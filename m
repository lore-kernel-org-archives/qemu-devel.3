Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4C0CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDsh-00022w-F6; Tue, 24 Sep 2024 18:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDse-0001op-8I
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:36 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsc-0001jI-IB
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:35 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7e6ba3f93fdso669643a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216370; x=1727821170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvmXuolKEh5VCCBso7oxro8MJDKi12QvfETwv+HVfmM=;
 b=WjP0LMfuI8PkU6waAmlOyPfmAs878pLrbj0eQ7WJ+YCeKMg7bd7Wv0b2GOY0WxtwzW
 MiIB5aeqmT9rIDz1eTUhDAlE5LiVZUMUIDLgwCqDVfnwBGcYgx7DF5bV0FTJSgNjhaOG
 cZWdp30GbT6rVLdvRoqtrV3Ps+3hc44fMC7doBkOT4zaZTm86z6SEIZnvoScIIYceq7q
 mGLZp7QEm3UHjPBQBwkRdHV+jZpvOw4JwE3cvt7BQuKj4EbKdxsWeiUUbW4k+ZIgIqH1
 B8d4dXny4y/dP4BjQLOSS1wlyw8UYxjrnE8IepAfzM+Ryfr1J61C2E3CqoExfs8O44r7
 fOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216370; x=1727821170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XvmXuolKEh5VCCBso7oxro8MJDKi12QvfETwv+HVfmM=;
 b=oyzK5G6OZo3gVBwJgU7JAhsxUTfgexgQ3OMJQeYUJn3XFsYSEMPmpcsPUp2CktOpLr
 vvv74uxfc/ez0aMeLGAva1r+xJglk7CAiN999dUU10bovEps0TLjD2NAzEA92ecIz+UC
 wM4nIzX/P4gcypZrXU5kCxwWCRcODQVebmii3XWqT1OD3vr5XtXXWQE6ZMyRNPY/yT/U
 /TQqs45aYJzANUMnEp8luCaYg9RKdmOCCg2uQyq0GlSeIDSRp8X7tYo+BBQUWhsX432J
 uW5ObCkxWGnYGzTxHPs0UWA35bWe8HI2GvVzW5fAUP8hdIS7fP+QYr6KXDdkYNdgGpXV
 ETYQ==
X-Gm-Message-State: AOJu0YzGGJcD9Fpz7AlfzwaL0y/T5GHHeKfgwuFwA409o/P+Xzozt8Lf
 swdHS+V5UBfYyLF5tdhIWcWSvW8ZTj+WbwacFkNN3/vmkQ2Aa3nijoP+HA==
X-Google-Smtp-Source: AGHT+IGCtAOy4Qi6A6Ow+1XFxf4aAablk8XXuapW0b+ikJpAzIywINpybzLXKG9/rkZVKJbhDW7ySw==
X-Received: by 2002:a05:6a21:3a85:b0:1d0:3a28:d2a7 with SMTP id
 adf61e73a8af0-1d4e0bff489mr662923637.41.1727216370100; 
 Tue, 24 Sep 2024 15:19:30 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:19:29 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 29/47] target/riscv/cpu_helper: Fix linking problem with
 semihosting disabled
Date: Wed, 25 Sep 2024 08:17:30 +1000
Message-ID: <20240924221751.2688389-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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
2.46.1


