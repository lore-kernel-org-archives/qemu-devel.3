Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B554EE644A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socRr-0003CV-OT; Thu, 12 Sep 2024 01:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socRT-0001Fw-PP
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:37 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socRR-0003CB-OC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:31 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7d4f8a1626cso483950a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119147; x=1726723947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6fZIAVQ4yCQPRQVlhgL3MODNobQ/HUxNCiJ7ns1wzI=;
 b=STWCefWSs9s+iNHK/hEqq5Xh1ino7ohRDYVdNYeADtcDeRX9nfrkwrWn+YKXfJAaPw
 VfqBzD+mUeLYeoRxujfZ55nahJ+pwoB+FdIYI33jm3loq2vKN4m/awCJuKgZ/J9Lwe8G
 f/R1URdLoT2ExvpRBqyP5IG4Xs+BA8N36MFGCFaFK5QdN3BrJiWdM08NYGjkFbJAWUz0
 D81nW1OSqs/x10uGuQ2ZDJG1yNVJCHFfCDgSRiuFfl0/zzZrcrsLsCVk8MRu4aDUHodZ
 eRWRU3Ijn8FrLgjmqTIQRITFniJt56kbRYCuxVgTBVf7I0K4Ui0/FxHz86PessJD9myG
 LJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119147; x=1726723947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6fZIAVQ4yCQPRQVlhgL3MODNobQ/HUxNCiJ7ns1wzI=;
 b=UmKuTU4pkHjJjulrw0P4vN/b78xK+obfPIFVG2h+T0Vcw3m4lX8wyivSjXowfYodm5
 pd7OpkhZ2A6U2UfJhXolYQmFN5s+Y3ppS/JZUT7mjQIb/pZX8W35bWj3u7F79oT1M/LM
 EZfVFf6fPlhy4+sWqzTerP1XD3aHkDaHupbNdTBO07j5JCjDyr0N2tuhNZACrsTnnS3o
 Y24WNpGdD20U5aiBjuJ5vrgnMspYFZ0rSkf9dmqHJmPZOaiEttbbIuR+/l2VhTAsnxFB
 OQOZaKaA89ifpCnrnyvGFhHeF4Lf1Apgg5OBXbbBp61eqVHCIPuK4s39Le242n94dChJ
 o/Ww==
X-Gm-Message-State: AOJu0Yw8opw648u+sIvTUGR0tvra+GHg+E9vvQjSqd+UeQxXHfs8quO1
 or16F9KXHZX51zfrozS+EfBJXBHBgN2z4I6YBVyqyjhtsZjNZflCjPH29Q==
X-Google-Smtp-Source: AGHT+IGIJ1Kg+/6j1jIBVeM0AEqz8SVFmJpZuqRXOpR9nP6/9QfF0IyJfwfrtW3sBrd8kS8AWSANAg==
X-Received: by 2002:a05:6a20:2d09:b0:1cf:2901:2506 with SMTP id
 adf61e73a8af0-1cf75ed390bmr2380511637.14.1726119146855; 
 Wed, 11 Sep 2024 22:32:26 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:32:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 46/47] target/riscv/cpu_helper: Fix linking problem with
 semihosting disabled
Date: Thu, 12 Sep 2024 15:29:51 +1000
Message-ID: <20240912052953.2552501-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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
2.46.0


