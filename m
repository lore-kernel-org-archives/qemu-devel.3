Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183B8C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 15:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxTYo-0003HQ-M2; Thu, 18 Apr 2024 11:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxTYk-0003Fq-UO
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:20:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxTYg-0004WG-79
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:20:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-418c0d83d18so7472605e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713453607; x=1714058407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n5QqC5TWO216H4QGIIquQv5JWDc3hZs2/K7GnFUQidw=;
 b=tJbHDLDzekKvLlrsVrfslFFmTYSs9///PV69aSjxXU93sJcqKOF0p7NU+UMydnMJgN
 NpoCbUDIDKhee9eJ/8LX7Ym4hZ5JjhvfZOLb7a/k+jfLZZTbQdKRHZMTht7amcbsgyzJ
 IHmYeZ6FeUajjWKZBZAmu3uc9xpoa48SP/a3CLo56z0OEAXsYQfX+TQJvFJkM8gHVVTt
 JoIGNs6bWagbCROrPg4j0TKTGfJ2agIAsMLfnMC/2q6Kb4I4/t0UspfLxOBbjCCeaguQ
 swOEUT+xq+tvaaEd+rMhKeRM+r6c8g3ewqYqlpgC6obaDUBWpWRObsdPVbqO6KGoUHRr
 oRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713453607; x=1714058407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n5QqC5TWO216H4QGIIquQv5JWDc3hZs2/K7GnFUQidw=;
 b=JIAzEIJck9f9s+9+QmfY98tL3eKofFzyvmqesVx0DeQKf/os4c7QqZmrZg0mZ4Ip+Y
 iALrQrSPSiBObJnNacoOvTKrNHWzpN+MjrlpjpLl7EfukbuGeUPXSaLNi6vguy8Lv/5i
 m9sb87Af18mwXvE9IK7EIbulgRbyUXWGdkjWHzjKElyscbJsAM58Hvs7B0vrxEPs2hWv
 i2ghi67xaW9xO4eEV3KdKoNl+YYlbiRVk84ph8M5MTWu+LCYWHnisgUiHOMFW7SQA5jO
 OWQ0ZmI8JrAQu08H7aAhYQsVk70IIExXE433/O1FDCViHPQmoeFitVTQp671EF7yImYR
 VT3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt+j/PrneFPhdtRcBHv+g0WV9GnXqkGg1jyk7FmjIvipR6JNZF2besd4wll2ziGdiSAFVTvlxvUQQuKk+fiaS+rHwmF9M=
X-Gm-Message-State: AOJu0Yw/9Uj8Xsyj1rCK2QZObgv7LVh7GviMldAOxOM1x4MgiUGdn2SX
 N1XplCcqXi1RJ0XxP4pKXQR/w+wjXBZKboks7JpEUosRtHdelawRI1tKL4Y2U58=
X-Google-Smtp-Source: AGHT+IEDROZUAGmShVkZCaBFSsISwM9W9sBuxceKy19jYlzzkFdUH3s3UYck/BjGc14nPjWcsjbZKQ==
X-Received: by 2002:a05:600c:1906:b0:417:c5cc:77a7 with SMTP id
 j6-20020a05600c190600b00417c5cc77a7mr2216901wmq.13.1713453607195; 
 Thu, 18 Apr 2024 08:20:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a05600c475100b004162d06768bsm6886839wmo.21.2024.04.18.08.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 08:20:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/5] target/arm: Enable FEAT_ETS2 for -cpu max
Date: Thu, 18 Apr 2024 16:20:02 +0100
Message-Id: <20240418152004.2106516-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418152004.2106516-1-peter.maydell@linaro.org>
References: <20240418152004.2106516-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

FEAT_ETS2 is a tighter set of guarantees about memory ordering
involving translation table walks than the old FEAT_ETS; FEAT_ETS has
been retired from the Arm ARM and the old ID_AA64MMFR1.ETS == 1
now gives no greater guarantees than ETS == 0.

FEAT_ETS2 requires:
 * the virtual address of a load or store that appears in program
   order after a DSB cannot be translated until after the DSB
   completes (section B2.10.9)
 * TLB maintenance operations that only affect translations without
   execute permission are guaranteed complete after a DSB
   (R_BLDZX)
 * if a memory access RW2 is ordered-before memory access RW2,
   then RW1 is also ordered-before any translation table walk
   generated by RW2 that generates a Translation, Address size
   or Access flag fault (R_NNFPF, I_CLGHP)

As with FEAT_ETS, QEMU is already compliant, because we do not
reorder translation table walk memory accesses relative to other
memory accesses, and we always guarantee to have finished TLB
maintenance as soon as the TLB op is done.

Update the documentation to list FEAT_ETS2 instead of the
no-longer-existent FEAT_ETS, and update the 'max' CPU ID registers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 2 +-
 target/arm/tcg/cpu32.c        | 2 +-
 target/arm/tcg/cpu64.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 958c69f3799..de39110692b 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -49,7 +49,7 @@ the following architecture extensions:
 - FEAT_EL2 (Support for execution at EL2)
 - FEAT_EL3 (Support for execution at EL3)
 - FEAT_EPAC (Enhanced pointer authentication)
-- FEAT_ETS (Enhanced Translation Synchronization)
+- FEAT_ETS2 (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index de8f2be9416..b5a60682fa6 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -67,7 +67,7 @@ void aa32_max_features(ARMCPU *cpu)
     cpu->isar.id_mmfr4 = t;
 
     t = cpu->isar.id_mmfr5;
-    t = FIELD_DP32(t, ID_MMFR5, ETS, 1);          /* FEAT_ETS */
+    t = FIELD_DP32(t, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
     cpu->isar.id_mmfr5 = t;
 
     t = cpu->isar.id_pfr0;
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 4445c5a212b..da15182595b 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1195,7 +1195,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);       /* FEAT_LOR */
     t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 3);      /* FEAT_PAN3 */
     t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1);      /* FEAT_XNX */
-    t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 1);      /* FEAT_ETS */
+    t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* FEAT_ETS2 */
     t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
     t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
     cpu->isar.id_aa64mmfr1 = t;
-- 
2.34.1


