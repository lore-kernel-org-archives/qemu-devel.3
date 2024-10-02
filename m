Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36919CF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHE-0006Ht-ID; Wed, 02 Oct 2024 01:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsH9-0005xW-JN
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:51 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsH7-0004tp-UI
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:51 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-718da0821cbso5003084b3a.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848308; x=1728453108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tgn22ymHGut59Ykc0D6Hbb4Bov2uF0nu+uBfgEW9Duc=;
 b=gIOgLL0jo2D2nt4mGo08j3IhIJ4mhMNeSZy0Q35SP9tXlYizZLjabSLkg7LBqSgOdy
 uW0YwWsWbfts+dK2X1sPbgJywv1xy10plLsF2FMD7QyYhSbPGpz/Hvi//xR0V1SKKd1D
 +w480dvAWOKviO2MbQsm8wHojtAwTe0k3MMs2Iaa09DAKUO5qWpXf2TuYMq5fpj8Y7yO
 ixMgo/g2sHst5svVAzjn2OrjNZrekLsAxLznJasVzplknr6gO7m9N5crbqQOKfkCx8bD
 JqBK91ANhDon+Xsyh2pTcG4ZnQdNViDCZuYw6aqlCbg654MdP6S8YLqTjGprQmfIU4gO
 GZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848308; x=1728453108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tgn22ymHGut59Ykc0D6Hbb4Bov2uF0nu+uBfgEW9Duc=;
 b=EXpC1D4WU2D4ZL9Uiu5tPMFFFc7uyNjbfIHx4u3I/Eb/cP2iEkZyWLe5jQBx7gnf1R
 ys9978ro+uz2PEP3LvvATePfQowzYGgBCEKKKLV4Np8CODGbRjv+ArHPgKwsPAPpn76C
 HUPYYlwGgL09dbYOtuYptlEGBP31okQpzp4AJWac5aF1Wd6oOmu3fR+apr2ggEIS3EvZ
 G0+EMXBfoVsOf7QQUBbF0P85njcU3g9O0OmCrsw0xeoJmKl4ltDkKpcy/aK9T+SLT3Vc
 AgcR2FBSMxbZyZmrG96rfjelEKtjldzyMupQk5Vp4G3mLWLxecSqRa/B8PoIv1CthI1T
 hCXA==
X-Gm-Message-State: AOJu0YzZC6PjSHyKcNT8baZl/XFaeNQuzGcwM0iM67yDxakex5CpHYkI
 bWpeNU0+aO8ZOIM6flq1dXdqIJPBFaG3LnzizTCMSNJQikW0xIR1I7YEIDDy
X-Google-Smtp-Source: AGHT+IGDNVYxeMNlv3G/HcsPip03xMu29/gK+rfFQUMut8bN9vtU+LO1L6vsaXFI9b6u0dmkegkq5Q==
X-Received: by 2002:a05:6a20:6f8a:b0:1d2:eadb:bb2a with SMTP id
 adf61e73a8af0-1d5db1b751cmr2985802637.30.1727848308229; 
 Tue, 01 Oct 2024 22:51:48 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:47 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 17/35] target/riscv/cpu_helper: Fix linking problem with
 semihosting disabled
Date: Wed,  2 Oct 2024 15:50:30 +1000
Message-ID: <20241002055048.556083-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Thomas Huth <thuth@redhat.com>

If QEMU has been configured with "--without-default-devices", the build
is currently failing with:

 /usr/bin/ld: libqemu-riscv32-softmmu.a.p/target_riscv_cpu_helper.c.o:
  in function `riscv_cpu_do_interrupt':
 .../qemu/target/riscv/cpu_helper.c:1678:(.text+0x2214): undefined
  reference to `do_common_semihosting'

We always want semihosting to be enabled if TCG is available, so change
the "imply" statements in the Kconfig file to "select", and make sure to
avoid calling into do_common_semihosting() if TCG is not available.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240906094858.718105-1-thuth@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 2 ++
 target/riscv/Kconfig      | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 4b2c72780c..a935377b4a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1674,10 +1674,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     if (!async) {
         /* set tval to badaddr for traps with address information */
         switch (cause) {
+#ifdef CONFIG_TCG
         case RISCV_EXCP_SEMIHOST:
             do_common_semihosting(cs);
             env->pc += 4;
             return;
+#endif
         case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
         case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
         case RISCV_EXCP_LOAD_ADDR_MIS:
diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
index c332616d36..11bc09b414 100644
--- a/target/riscv/Kconfig
+++ b/target/riscv/Kconfig
@@ -1,9 +1,9 @@
 config RISCV32
     bool
-    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
+    select ARM_COMPATIBLE_SEMIHOSTING if TCG
     select DEVICE_TREE # needed by boot.c
 
 config RISCV64
     bool
-    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
+    select ARM_COMPATIBLE_SEMIHOSTING if TCG
     select DEVICE_TREE # needed by boot.c
-- 
2.46.2


