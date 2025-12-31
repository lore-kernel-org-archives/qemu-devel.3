Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D92EE57D5
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaqir-0007cp-SX; Wed, 31 Dec 2025 02:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqiq-0007Zr-CQ
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:20 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqio-0001BZ-Mi
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:20 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso17030864b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 23:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767166457; x=1767771257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evdd5T/Fi2dYyHzRsiaIO9JAH5fYrMEkDtHE8uL2Oz4=;
 b=ws1zR1a3oYtnkn2lgq7pE/mp7z/pWyVSba3h0KMRGK/+GGjdri4uz3Y9nDFt+FVX86
 0JaV7o1ojfgLorHXPD83ipvUuSrxoBE/3/kJILDifJHaruw3G7dwTm8JQEspif/Ckjef
 +c5oIZdPsho7Wyn3eTrNFZyfunSucQin5FvVodqwMqiS6LclX7TV4JdMS3+AdOXo8vXZ
 1KA4S2oIlieNeUkKEDyz1Gl8DibtoJN8HFimem36aLcW+MoOZ7c0kSz4gg+vehsBqf7j
 PcNXgs5dwduzWmFVJ4zAACe7JR779NssVYlUx0FvP/IMQhOE8Z+KmYKqSAsJFpRkNJWd
 287A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767166457; x=1767771257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=evdd5T/Fi2dYyHzRsiaIO9JAH5fYrMEkDtHE8uL2Oz4=;
 b=W4H7OMgotWLPlehjkk5zoL906JKVzXOAU0tC5MUUfUEAqN6b9C2vf1IBURM1Mth2Uy
 6WYGEi8vVklmc8nzuDWVxU3VO5c2+RjpGMlhHsCYAw2WWVgjCXvi7ydkaFAdJYAYhFN6
 ZPGxabAmUSWAmQ2jD+q2GjMb5ygQj7EcPqQrB5t/0EkZtpHRjB+N+YD2llz2tOaznZ1M
 kBjLOIV7vh+N+vzShWfi9tJffyZBmK3yHOXLt80J/Xo/YhLXK6JpW/oyodH6PkmkdK9b
 x7C4B1NhuAj8UcS75O7/8uMYqcEVer75lWr5uCSFfGmQGeSgOnlNMRCAEgPY9QAlvpG1
 UR6A==
X-Gm-Message-State: AOJu0YyK4+YDZhPovavUkMmamyVElE/E1b+4HJlFCjqLUTrZZSc9HhoQ
 fttQ+IyEE50OKRKyQXQ8zRyaz4aMrHI3bVH3VbIkr85lQmVLflZ7SDJZz6eeyx65r3FDImQOTr+
 Su21e
X-Gm-Gg: AY/fxX49zDCdDr4iWVLsBmJsyeBK4qqCP4FYKok2MvKCWnkiDBsWPTWMvE901c1VZxx
 prIW7YfLYHwwWuA12cVLR2tlZwexhsUvzot+4X6ouuymIMF3yk9IzpJw5Ax7LzewErIwe6YdYh3
 rfay7oxkdTNIcw6mGK7Yu9piBxh1ipaDP7BSINZDpLtr+wt8JMf2iQiEDfJUEq3gQOfnjEpm/WV
 Ika5lab/52JhL4Dc7mKUS2ydVlHglNbSlC87fckUaoeB8RaecyN7ikX7kqKdDbOTVi88zvXtaWr
 8Gya9i6GY5OGlvu7RcfsEXdtzTUpo7e9vdka38bc+R9uAwOD+wVjlOJ87wEmXwT4rN/x8FiBg4R
 gUasF/QLVnPSEj3kU7Kv+drcmzJ2uGL+CTjbB4+n4is6SAavehE5TzzXSY7gpoBV8Fpy5cf6DpS
 /vAOqNw1xvvVKkp/+YTw3h+nocTmtOYE06tVkRT7PPHYD6eqX5RB/N4mduLnlrX99u
X-Google-Smtp-Source: AGHT+IFhgxIvjfmVqnKGy44nbXLWF9bkygTYFJe0DKwj/i2/3UY7LAzVxm8YInrwAC1ihJK7sAA39A==
X-Received: by 2002:a05:6a00:302a:b0:7b7:79ca:9a73 with SMTP id
 d2e1a72fcca58-7ff646f9664mr34651092b3a.10.1767166457155; 
 Tue, 30 Dec 2025 23:34:17 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f3d7sm34597984b3a.51.2025.12.30.23.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 23:34:16 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 08/11] meson: enable cpp (optionally) for plugins
Date: Tue, 30 Dec 2025 23:33:58 -0800
Message-ID: <20251231073401.2097765-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index c7042413f20..ecfacaf2ac1 100644
--- a/meson.build
+++ b/meson.build
@@ -77,7 +77,8 @@ python = import('python').find_installation()
 
 cc = meson.get_compiler('c')
 all_languages = ['c']
-if host_os == 'windows' and add_languages('cpp', required: false, native: false)
+enable_cpp = host_os == 'windows' or get_option('plugins')
+if enable_cpp and add_languages('cpp', required: false, native: false)
   all_languages += ['cpp']
   cxx = meson.get_compiler('cpp')
 endif
-- 
2.47.3


