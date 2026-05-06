Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DDFCD379F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcuI-000821-RA; Wed, 06 May 2026 10:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKctM-0005s7-B8
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:26 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKctK-0001mt-9V
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:23 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488d2079582so67352185e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076380; x=1778681180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g8o9bUnJ4HHQm9EVnHH7pclzgrawaWQlQJgn4JYf1qY=;
 b=amidFVevMYqUs7EllD5I9H9fnOe4UDXKz68KjZNmo734ZXJzV40uqMOCCLW1RN9R6a
 0XLBYbl9EDwY0+hc6LIexHWJkmFZ04iZIY6brbJBR2GuJF/YcxdBhm+iGag/56lfG/fa
 uh69JtQqZdDTqbCv0dUCIZKTCRmw4YKRKr3ra/8aYeC1lMpC072Kfg1TuBpOaWQ1xDPL
 j86BsIN3nDDAqfc1vyhBjDUtk9B61ZTZ1YAo3m0QxfwdX5e9XmNfcJfDwDgnhauC4tPW
 tz40HVQAXQxXVxIhtDE3tOpvineXGmrWorb9rJ7zr/u/nEbKz+Zp/UYyXuxPHKbo8EgX
 t2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076380; x=1778681180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g8o9bUnJ4HHQm9EVnHH7pclzgrawaWQlQJgn4JYf1qY=;
 b=ATGt0Tb2JK+FVgFzTma67xDMGbUPJiMIoFyJIDs0mw4matL6Tv6X5o9C6sEMDmbKIx
 YEcHvGHj3gc3qa0uUeDhS+QvvW+6jM0Bg+gCw/5FEiJM6SLQRS7Hzv9yVU5cTCN1u8Fc
 0b8eGHKxoyy9e91yHqhuIhCigCp7ODk+3RmmIDg3p1pqySjzSnugN1Bh8yQZyqTSosQK
 MptYQhWyjUl2lu6lhaxtfOlYDls5l96QrOHHSlJ87BZVAQxCxH/3TyjdhvknKnNPM70p
 8VAiDHLhywVTMERQqCjuV+1uqnMbSdH/tBE+j0FWYEyU0QJfzz0dERT2VZi5z35zVAde
 JjtA==
X-Gm-Message-State: AOJu0YxkyFDZj/HhKIFVXN/47DdSBmh0nxRWW84K2N2XZU1oeNZoyB+C
 kPSXCtcv7N/fRCoGPGY9otxstRM0jCeHMIbiStqCsHy8RM3pTYqvK2pqZmeqenYhxlHsD4RfE7g
 qk/VTiPQ=
X-Gm-Gg: AeBDieso+xAh9CZWwV81tZuztXrVpWX6QYEZg8rT5nHg7UIVHKloJhA0RJ6t8xQ/6OA
 /bMIkfSkYM5eso4gk51UITYUGBs7/bCLvXJFDDk7nK81JYqP7fJQvqq2NJ5qvEK3YdRCH4Nle0o
 V8B6leXHozB5pAi92F8YPuLrytOyeHItFGzztHRcGDqPe9qfr7h/KcTDDpk0t4CspWgAVWTALX+
 1ZQYThdrSbnGuPGu+m1Kw3LHw2bS84abThav3DNdBoi/b2o1D6I/VYNvlr4oAVy3mdAsGv2wGvL
 0ZQFYsXksTPZZWaQjmOuRhb1s7VnknGbS4NcccVPJ5QbWnq45Bkp3Q88HWRUJ3DlRG8u9YSyUyi
 r9SFkLTJvYMD2Fup0NsK8Jk3oP5a3zaNQD2SrTsDoYvDMBV2Y/WfMV6aWZRYgJqh4E2LyLDRPHQ
 2wXws7CBMWDO43gIxtSh27Exn8QyNBFQFMFo3K2nkHh78rpaW8Kyb+AIdFYvPTqEVuQok9QjzdS
 lhfPBfBvaM=
X-Received: by 2002:a05:600c:3b17:b0:489:e696:836f with SMTP id
 5b1f17b1804b1-48e51e15718mr58381085e9.10.1778076379704; 
 Wed, 06 May 2026 07:06:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312daf8sm18159875e9.20.2026.05.06.07.06.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:06:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 083/110] target/microblaze: Introduce common system/user meson
 source set
Date: Wed,  6 May 2026 15:54:55 +0200
Message-ID: <20260506135524.20617-84-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce a source set common to system / user.
No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260423100612.27278-5-philmd@linaro.org>
---
 target/microblaze/meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index b86b37d9238..7f7d27d4efa 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -1,5 +1,10 @@
 gen = decodetree.process('insns.decode')
 
+microblaze_common_ss = ss.source_set()
+microblaze_common_ss.add(files(
+  'gdbstub.c',
+))
+
 microblaze_ss = ss.source_set()
 microblaze_ss.add(gen)
 microblaze_ss.add(files(
@@ -10,10 +15,10 @@ microblaze_ss.add(files(
 ))
 
 microblaze_user_ss = ss.source_set()
-microblaze_user_ss.add(files('gdbstub.c'))
+microblaze_user_ss.add_all(microblaze_common_ss)
 
 microblaze_common_system_ss = ss.source_set()
-microblaze_common_system_ss.add(files('gdbstub.c'))
+microblaze_common_system_ss.add_all(microblaze_common_ss)
 
 microblaze_system_ss = ss.source_set()
 microblaze_system_ss.add(files(
-- 
2.53.0


