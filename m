Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C35DC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLl-0005gP-6M; Thu, 01 May 2025 02:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLI-0005F4-UC
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:22 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLD-0007NH-UB
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:17 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so1726452b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080653; x=1746685453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbIHH1S4kZio87pXSHaHXNfuYgqfHo9zKgyYkp9Oz1s=;
 b=oQzINCbw3TOLMS9/zqyWod3SowKnQZX5DwlDS18L8qYW4pYjni0QTrEHx2krASgZyQ
 isH9s/CC7OncJJ0T9+J72P1PXODJq5uyxo0WuKqIYe5R/UfgrWtrRaDJXDH+kNiVAbUo
 J8Rx1tgIDLklkgtGDnnpCJMDPuBox7pf+8gvCoGLwmgcRGajey7aBMdSmyg462Le5/Kf
 v/yKDUxOwXDg8zyfsD/UF5BMgkPxSLsIsfmZ3n1WEEGs0rtQ47JETNHIVhl9jyE+GovB
 o8EImzvbeuxocowm2zav0Z23KTO5YAjlSmAq8YhcqRiikC+BLKN2oEHZpcux5XFnDqJv
 JPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080653; x=1746685453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AbIHH1S4kZio87pXSHaHXNfuYgqfHo9zKgyYkp9Oz1s=;
 b=B0KYFHl8bgskga3KHvAQgiycFc9oeeMWXS9/03P3CaxH1qiOcq0Frf6fS4cqEV4EzE
 kokSd5wAEUCeiZmuTHyy3YquhDbol87GMx9NMhgWztZSK3wzx4NhsNoB7yNqJQSsqBS4
 Xu389mE5eRo5z4yIVjSNO0C4BxILdkqdXlqLL85Q2B8f+Q6PKRmnnfVa3Fz9QuXG8WlR
 n1CsNC7mcLCwk7//FCb1YjQ+tea+Erw3L21JSSQnZEMXvLF3yJKoQGdu0SHwPpgqQ5hf
 /VVIZ5uxt6scH2kIAv9bY/4tVXrcQC1RLV8cB4ADO/lP0iwcTedA9QE1zZAbCHkA2QpH
 JsgQ==
X-Gm-Message-State: AOJu0Yxz2b+R4pDhh7v7n51uY/am+ZLjBDSuvOkpytX9qiNQknw8vMqa
 VI9dg1KixpC65I5LfAZ756vI1zZh2YByx/pb5dckO1xHFZvttasu37y/ddtiBUxGHJUJwDG7uG8
 4
X-Gm-Gg: ASbGncv+4JH2tm35c+3h5DYulgWcsQvoBAyoSZDJGDUeaaFJUbVFeNFtJH8+r4YIp/l
 G222wgJ3OtvccnCT/sQVe3I56HEEElenv6XiUPX5d1OnrSplJtT/ypV5gKDtQMNmKsIYrh99rZi
 g7f1ESpsPr9Ur1PWEb5m7ykuMEJ4RGu3p+GF++EZHx3Uw6vXR7ExUO+AQk1VZnorziNGyfyxln4
 15lAkjkRkKw6ttNh2JASml3IvlSWTq/YuGWNjf+V9Lsnk5yB2PiGtEg+PngpHR6RPgEYyj1ikAQ
 viRW5oF0a5ocmko7UCfSew+lXNeFQLEJNKusF8HQwR07vzZUnBE=
X-Google-Smtp-Source: AGHT+IE+M2Qhe1mZXdpj+BeqZNGIoeFOrdKYtLvcOBl4KLwgVIF+m/BYToT/VO8K7wQPtU8U+I0ngw==
X-Received: by 2002:a05:6a20:3953:b0:1f3:237b:5997 with SMTP id
 adf61e73a8af0-20bdcca171emr1844660637.14.1746080653018; 
 Wed, 30 Apr 2025 23:24:13 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 24/33] target/arm/vfp_fpscr: compile file twice (user,
 system)
Date: Wed, 30 Apr 2025 23:23:35 -0700
Message-ID: <20250501062344.2526061-25-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index c8c80c3f969..06d479570e2 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -2,7 +2,6 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
   'gdbstub.c',
-  'vfp_fpscr.c',
 ))
 arm_ss.add(zlib)
 
@@ -32,6 +31,7 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_user_ss.add(files(
   'debug_helper.c',
   'helper.c',
+  'vfp_fpscr.c',
 ))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
@@ -40,6 +40,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_common_system_ss.add(files(
   'debug_helper.c',
   'helper.c',
+  'vfp_fpscr.c',
 ))
 
 subdir('hvf')
-- 
2.47.2


