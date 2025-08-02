Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43277C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLPE-0005wj-DC; Sat, 02 Aug 2025 19:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLP4-00059i-K3
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:38 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLP2-0001uc-Vc
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:38 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-433f1f97199so593173b6e.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176356; x=1754781156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QP61lQW9RuzWvrPNmZmEKa6PBqjBLfDxLSYJ7A/0qbE=;
 b=K7wRL8VJpvnDm3W7LxVeVZXHfBVMS3nAnZM8RDq8KaN19fOYsj1nNBG+LoF+WKt3cH
 5YBu84NGg5vas3scHZruttba8mOdsusGrCnqJxb83RyYeRve0KEjrEtiCedtxtO/jUuY
 mGAMZoM3f4Fy63rSbGm5OefwgzWzLJIpa77moLE1tffWh8LY26XfTmYnDyci9sRUiqv3
 B6aVZVhIVc+wc0My5A2cAYDTj3YyslUu3lf1MZFgzibABeaf67saANMM/cn4O0Rnwk9y
 CEJLPkVfVfO35UA5kX93EvOAJAVird2QOqamDdFErAeC2vT63zSKhsWzEnICC0i9Rxci
 anxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176356; x=1754781156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QP61lQW9RuzWvrPNmZmEKa6PBqjBLfDxLSYJ7A/0qbE=;
 b=lRp5ZxF/fVMt2bfP9Buflk+HadAaC4ZunhrAwKln+3QQi4VwtbtgAmYv5YLL9CAuvZ
 cr+oQQp7Le8IsXroWi5ejUttofugbdFOs7wu5ORwX5Jl2WARjzQPzfLTrMiP7FQYicqB
 MWI0LxTBCq0RN/lPbcTJiqveu5nSoG0mexIuVopJTckRbSNaAEAD80psPSTBjQeiirxq
 AMlrBBf7ohMXCpzfKK2kdcgsYBbXpID6lRftvwaqE7sfdMNNGcVPGJoSxgsp06haQ0Ks
 70Ul0hLfUrrMfihl8cfexKCbdJ9KEI/JbXZofqOtLpMyvxQ7BB+MGeDfp0W5mFQq9wQd
 fL+Q==
X-Gm-Message-State: AOJu0YwZVY1U9kd4LhT1rp4IQZ0JlJaAn86uOGqmdRxIPistJCRb3C4p
 BkQeBg6Z5bmOU+xMNjSz+tBdCmG8tsEFumKo5bpJA0iEQa5h5xdQjgCiMkZqAU5BXRli3OrWCV/
 Hze3+cWM=
X-Gm-Gg: ASbGncuRwZYnuNIJySOvC8CzhHZxysKx7yIN7cyeP5826nJq6Mwc2ITOBXfjaHkhMmQ
 5akDhelvdpZwmsn2F5LBWwA4Dd4OndBiUWLkBU3H3UDCT13h+thH5JNINZaOyqZ859VE6/Jr6eX
 dM5GwTAQTfpkHbzqwgxrLTtkDUHNPNDaHx3fJ6g4FoSvCHaOCg9czpNH5jBESksp3z7PNqsfY89
 HGECXAdb1dsJqBkdd1hIHnsPigEJu98dhRIHX0PgPYemr3Fa9t09MFeireD9PD2KanewG8oIhRL
 Yt3mREEDmzdJXFVnuHrx6fw2NivolTbhZK4m6oZBZIt8T1Koi9Rt++J77Te6+JqJs6vMVkDlS7b
 R5ptLPA1yJj+qEQrBHGq37G7MDJPo6qzVQNUc9Ie/8huLG5nxO/AA
X-Google-Smtp-Source: AGHT+IFpFymIFV5w67zLoYYOGw+GKjECn0rEbtW5dR1HN7on0vhIX3Wb+0CKGBl1pUD+QDRG/FinAQ==
X-Received: by 2002:a05:6808:199b:b0:434:487:320e with SMTP id
 5614622812f47-43404873ad1mr26721b6e.29.1754176355728; 
 Sat, 02 Aug 2025 16:12:35 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 75/95] linux-user: Move elf parameters to
 microblaze/target_elf.h
Date: Sun,  3 Aug 2025 09:04:39 +1000
Message-ID: <20250802230459.412251-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/microblaze/target_elf.h | 5 +++++
 linux-user/elfload.c               | 9 ---------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/linux-user/microblaze/target_elf.h b/linux-user/microblaze/target_elf.h
index 2d83fdaf6d..7ce4c10d00 100644
--- a/linux-user/microblaze/target_elf.h
+++ b/linux-user/microblaze/target_elf.h
@@ -8,6 +8,11 @@
 #ifndef MICROBLAZE_TARGET_ELF_H
 #define MICROBLAZE_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_MICROBLAZE
+
 #define ELF_NREG                38
 
+#define elf_check_arch(x)   ((x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4173a8d619..34a2639d85 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,15 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_MICROBLAZE
-
-#define elf_check_arch(x) ( (x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
-
-#define ELF_CLASS   ELFCLASS32
-#define ELF_ARCH    EM_MICROBLAZE
-
-#endif /* TARGET_MICROBLAZE */
-
 #ifdef TARGET_OPENRISC
 
 #define ELF_ARCH EM_OPENRISC
-- 
2.43.0


