Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1CEC2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZH-0006Cn-2i; Mon, 17 Jun 2024 14:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZC-0005NI-0i
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:58 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZ9-00051n-Vm
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:57 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70436048c25so3565429b3a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650734; x=1719255534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAGICjPOsf8qlBYaZrf0UehAmpN+2Vvp/a0MWtmp8us=;
 b=i/FIa7h0VQbLu4R/wKa17W54LUmV19KACOECYtzP1tGtNJjSgl3K1ht37jnc91HJxD
 iyV9Ld5Bk4hR4io5kE72H3Cr9nm0YrNnL/xBKeQeanPOzJHqUv+Dmp4fTAttoJl8eE0O
 KwRnhYLOI8VdTNMl18v6SbWRUsDwv2TrvbtzUxKbA8YAdBfwt7uNNoR4yBs8vNJG7dl1
 HJ46VH51vCVSiyVD7/JkBBlh3RDkYeoxBF7vsKZYKcranw7Ld4EcnYRJ+9LQe96x6wSc
 ik3zBwONTocUl8p4zSuMAvCMKuuKSG5/2Z2d3zKLhFIHi1O+tBgdA6Eysi/2IzBTDMQv
 2kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650734; x=1719255534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAGICjPOsf8qlBYaZrf0UehAmpN+2Vvp/a0MWtmp8us=;
 b=GOpY0FzzOHyxB6D3AAQKdvFUyOkuME6yTp2MYcMck4VUR/SgfDQ8JIzsSkuIW+3+c+
 ZC5P+tZvbF++ZFX/kV+Z9txLqpWX8P94dbWO8WnkA6hzqx2J843FVG7md3szx19UtdyG
 ZWr6rd3XIH5Ebg2fhUa8glkIuNAeseAvxoLw4ZCHuvVZDyPZ1LiGHZwaXzoVdhSkRDeM
 0SzF21ESz+laWzWlQuZ3eqGRL6oSV6PndI24jHXAhZLraCUzSMieeKybEJb7QJW/U7ui
 Ai1+oiYa2Ror2dKbSlNGh9oOV9q3E+vA6rUotzyF0oxD6MgcJ7CtTpGjAPFDT9TooLv5
 UFwA==
X-Gm-Message-State: AOJu0YySz+PFkmtwGXX6HzV3idO/X24Y4vSsOkclPvfmZFaNljK4wOpt
 qhQdVQ/cHMY1f4bnkFyLJ2UpYDvrXZPKagfg4oPAoLdiIkfsKZtfO/cgsENf8C8=
X-Google-Smtp-Source: AGHT+IFY9pAHmOb3hrJQx+wHnCY8wSifWr+1gCkV7w5tgE1Ur0akp+t027UL68BxPhvAnPWuGoP4Gw==
X-Received: by 2002:a05:6a21:9988:b0:1b6:da8b:9c with SMTP id
 adf61e73a8af0-1bae7f142demr10584627637.28.1718650734208; 
 Mon, 17 Jun 2024 11:58:54 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:54 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 16/23] Add function to retrieve additional ARM AArch64 hwcap
Date: Tue, 18 Jun 2024 00:27:57 +0530
Message-Id: <20240617185804.25075-17-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Warner Losh <imp@bsdimp.com>

Function to retrieve the extended hardware capability flags

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/aarch64/target_arch_elf.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
index ed2419408e..7202cd8334 100644
--- a/bsd-user/aarch64/target_arch_elf.h
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -133,4 +133,33 @@ static uint32_t get_elf_hwcap(void)
     return hwcaps;
 }
 
+static uint32_t get_elf_hwcap2(void)
+{
+    ARMCPU *cpu = ARM_CPU(thread_cpu);
+    uint32_t hwcaps = 0;
+
+    GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
+    GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
+    GET_FEATURE_ID(aa64_sve2_aes, ARM_HWCAP2_A64_SVEAES);
+    GET_FEATURE_ID(aa64_sve2_pmull128, ARM_HWCAP2_A64_SVEPMULL);
+    GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
+    GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
+    GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
+    GET_FEATURE_ID(aa64_condm_5, ARM_HWCAP2_A64_FLAGM2);
+    GET_FEATURE_ID(aa64_frint, ARM_HWCAP2_A64_FRINT);
+    GET_FEATURE_ID(aa64_sve_i8mm, ARM_HWCAP2_A64_SVEI8MM);
+    GET_FEATURE_ID(aa64_sve_f32mm, ARM_HWCAP2_A64_SVEF32MM);
+    GET_FEATURE_ID(aa64_sve_f64mm, ARM_HWCAP2_A64_SVEF64MM);
+    GET_FEATURE_ID(aa64_sve_bf16, ARM_HWCAP2_A64_SVEBF16);
+    GET_FEATURE_ID(aa64_i8mm, ARM_HWCAP2_A64_I8MM);
+    GET_FEATURE_ID(aa64_bf16, ARM_HWCAP2_A64_BF16);
+    GET_FEATURE_ID(aa64_rndr, ARM_HWCAP2_A64_RNG);
+    GET_FEATURE_ID(aa64_bti, ARM_HWCAP2_A64_BTI);
+    GET_FEATURE_ID(aa64_mte, ARM_HWCAP2_A64_MTE);
+
+    return hwcaps;
+}
+
+#undef GET_FEATURE_ID
+
 #endif /* TARGET_ARCH_ELF_H */
-- 
2.34.1


