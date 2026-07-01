Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86092C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2z-0004jf-6H; Wed, 01 Jul 2026 06:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2x-0004iZ-C7
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:59 -0400
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2v-00051R-RE
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:59 -0400
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-139f3eaaa49so489238c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901196; x=1783505996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gw4l4Gi5whz+2vBwByejJ5LTilUWHMGfCkjX1QzScfU=;
 b=dkSUMjsvdz6tNNtmhOgmp972pvHskmqHU5eibOIYyX2JaNQIzb0ZnPUJGNWd+XsDpp
 U9oS3yA8M2NQmiR//N7v81JizfJFQONg/XOWDVHX47uK6Zial60vQajthXQjbqgXTyY1
 DsI1+pghgsZgWVb4J2WScgIWFHCPzcFwVDufbzCMIpVmRFKg76QdqHJXatMYEUvMhyzS
 8lhPVTcQ2Hd8u5WEVdP8FA8nJzI/6qzVnneHvdw7UaXcVQtgVtHmuvJFfdNhJPPA3Cua
 dkKc1vmDLtXUu3zDyH3fsr2KHQaTNi/3gjZHKFQ+1mWYPvAzzV4RECoBKNNizgleIV9+
 gs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901196; x=1783505996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gw4l4Gi5whz+2vBwByejJ5LTilUWHMGfCkjX1QzScfU=;
 b=eSxRpjGMi6aFsR6OufaIbKxgTM2fwSZb1CsGRKILZRCzA0gd5P3iT6IgALkLPYziy5
 p4LXt5HtVr9UlLmw5EHdQ1npzFCJhGZXVpLXITQwuXjvB8FcHe8l1fqQvRS58GknDQoQ
 5kIjPatLYKzZfweoE109k7VPO6e5ypnhmIbvAslGnAWr3O0zHpZWFhUo6tlhvjqFhpI6
 i0irqoBRGGQjAsNHgSAQHCU64Qc1DvjDsRUC+8Qu3dPXmbNxBlWvJGfDs0/qzcTBN7Zx
 bUZNPxSAWGKrN1pHmzmSI3rBcxrgsS36C9pGaejU9jGzq+QQ2LyTvhl1Y62sLOlA4hw0
 q0vg==
X-Gm-Message-State: AOJu0YzW1kaS19odTaKKAsCEvaryOqH6rjdU/HL7pnE3i41MvC6y8msT
 C2+hFvmfos0nlNvjcDPKRzwQzv485BXhJgXie3D7lYSSt2ML8fWw+tX2pI/t8g==
X-Gm-Gg: AfdE7cmSc/cHMIoZKsFSfYE180B5UA36v3uc8Xij+tVOqJ6mNjKcYcK/GSBNNiJUOJN
 8jdKVANSy95FUz6l/5RE1jrY7EUmOJqbrNudFDjmWgetgG73eyy6nxadJZ8NUikwv4vrg98Q4Th
 7ULEJyauGHtB7gPlJModFC2i8u1t79fpgp5pAl6X+iCJN75JidmDUdNZcD4NA7JXez2W8LTl7Be
 L4VD4a+N7B3H75+Xbwq9OTsSnURj6VVdn9bdOr3PSpfRAyBxSixsvO3b9yN8abLuz6IIS7vTQGt
 7OMEyRixIhoiVbORj3s167nttowwIPANP9Cd92d28bPSP3OugG0DOxLzgappPZXy+6F7R0lEqAL
 jhLTkUwFJfbVN0YwHbY5z0UITS5qqkPWpKihO6JzWLAKs6tutIUXJN1rP5SqAB0o541Pfwkp0B9
 /bN/RFjdiucTSo4gm4m63xEpjBLzHFELk=
X-Received: by 2002:a05:7022:45a3:b0:137:1ae1:bc0e with SMTP id
 a92af1059eb24-13b36d7fbf1mr960008c88.13.1782901196219; 
 Wed, 01 Jul 2026 03:19:56 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:55 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Joel Stanley <joel@jms.id.au>
Subject: [PULL 34/39] hw/riscv/atlantis: Ensure OpenSBI has a non-zero
 next_addr
Date: Wed,  1 Jul 2026 20:17:47 +1000
Message-ID: <20260701101752.2522962-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1230;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1230.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

When using OpenSBI fw_dynamic on the Atlantis board OpenSBI fails
to print any output, as it hits an error early on
in the boot process and gets stuck in `sbi_hart_hang()`.

The error occurs in the `sanitize_domain()` function inside OpenSBI.
`sanitize_domain()` is called after a M-Mode OpenSBI Firmware and a generic
coverall S-Mode RWX memory region are created. `sanitize_domain()` is
checking that the next address is executable.

If no next address is provided (which occurs on QEMU with an empty payload),
then `dom->next_addr` will be 0. On most RISC-V boards address 0 will fall
inside the coverall S-Mode RWX memory region and pass this check. On
Atlantis the OpenSBI firmware is running at address 0, so this address
falls inside the M-Mode only OpenSBI firmware region and fails the check.

Once the check has failed OpenSBI aborts and the user doesn't see any
messages. This can be fixed by either supplying a payload, or just
manually forcing a non-zero address (actually just any address that
isn't the OpenSBI firmware) for next_addr.

This patch ensures that if no kernel is loaded we still specify a
default kernel_entry so that OpenSBI happily boots and jumps to
the first address in memory.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260630024952.1520546-9-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/tt_atlantis.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 1f0cd08ac9..d4fa9c251d 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -377,8 +377,16 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
     if (machine->kernel_filename) {
         riscv_load_kernel(machine, &boot_info, kernel_start_addr,
                           true, NULL);
+        kernel_entry = boot_info.image_low_addr;
+    } else {
+        /* If we aren't loading a payload, OpenSBI thinks we are trying to boot
+         * address 0, which fails `sbi_domain_check_addr()` as that is where
+         * OpenSBI is running. Instead point OpenSBI to the end of the region
+         * where it was loaded, which avoids the early hang, allowing the
+         * system to proceed with the OpenSBI boot output.
+         */
+        kernel_entry = kernel_start_addr;
     }
-    kernel_entry = boot_info.image_low_addr;
 
     fdt_load_addr = riscv_compute_fdt_addr(s->memmap[TT_ATL_DDR_LO].base,
                                            s->memmap[TT_ATL_DDR_LO].size,
-- 
2.54.0


