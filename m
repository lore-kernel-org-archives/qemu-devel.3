Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B01C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 18:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riehc-00076D-5O; Fri, 08 Mar 2024 13:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rieha-000761-Ak
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riehX-0005nF-W4
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709921530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btK1kyt8BalfNBwPiYgdVCxNdJNeq5gpu69gZVwdFqg=;
 b=Z66/M7+GQ3GLFNCSbABWQrpkk9wwe1q/iRtAk7dUv/8f2YAGfXjXpmn88rH+6bIl9lhBFO
 ZFFDypESEFPIp+Th7VOwM2juOW+BkYsihfPgirH5XgSYVcgHOFRXIn9nt4HLhNadKNHdVw
 cBzy2koQZB1jSY/OjGiVYKff3OsLtC8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-nJKrFPj4MYiAttHll2N0VA-1; Fri, 08 Mar 2024 13:12:09 -0500
X-MC-Unique: nJKrFPj4MYiAttHll2N0VA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5135cb04b9fso2888426e87.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 10:12:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709921526; x=1710526326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=btK1kyt8BalfNBwPiYgdVCxNdJNeq5gpu69gZVwdFqg=;
 b=Dz4lvuo0hBK9oVqCi7MCLYHl+SzlYlwKmooleYUKNHV2ZaYBxodeejSW5jUc43hFgy
 aSv1qS8wNiqRVM79P1pYtCNOTxWFbPqYw1hpkGh3qZjK4U0CYUCoM8SKNAaCFqtFjHY4
 OsYgbl7blhZiIZACGeZ++MZ2FjGfMKbo4EKuQvrqHNGf+f9UTSHSzB0bPhcCGyQ1UAZc
 TuZCifOSL11mxKK4PoYPSSBv5OJg7+nCGd0oMFMwv65oVhdBDrEmjCcCKHVfFHPcfnot
 z6zCuDj8dtXVYVMmCr6mncNJ8XFGLkANLSrWcZlLmsJQmvOnQMWH0m3P2tdJ81CQmnFo
 CKkQ==
X-Gm-Message-State: AOJu0YwcFvY6B/IcPfNGigyo6EieLSIEk71R6Gd7HDZmwsWSrxvolcrY
 X756Zvhd9AwSwCJTloFnFqPr341W1YjhU1kr0x7xe9AUJWpPC0m/hQoN26uEfW17btf6xJRRzXg
 DqwUNDV1TI921zOebIXUOFKzT3ON2zlP5Z8xuKbpRG+OQbDSjZrQvyv8+elJ6qXn9Wic+ObUP20
 coDzBxE2szveX2itt8fGqx8fxqk3FDnQ+XOjaG
X-Received: by 2002:a19:915b:0:b0:513:84dc:9568 with SMTP id
 y27-20020a19915b000000b0051384dc9568mr2961416lfj.32.1709921526588; 
 Fri, 08 Mar 2024 10:12:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgKHQHGOpZVdJDnx5t2dOt7tjRkpvxhagcF1AMNOTIthYnwCIH7DQ7C/Gd2bSNkdwtwxg2XQ==
X-Received: by 2002:a19:915b:0:b0:513:84dc:9568 with SMTP id
 y27-20020a19915b000000b0051384dc9568mr2961388lfj.32.1709921526064; 
 Fri, 08 Mar 2024 10:12:06 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170906688f00b00a449cb924dbsm35484ejr.124.2024.03.08.10.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 10:12:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/9] hw/scsi/lsi53c895a: add timer to scripts processing
Date: Fri,  8 Mar 2024 19:11:53 +0100
Message-ID: <20240308181202.617329-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308181202.617329-1-pbonzini@redhat.com>
References: <20240308181202.617329-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Sven Schnelle <svens@stackframe.org>

HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
under certain circumstances. As the SCSI controller and CPU are not
running at the same time this loop will never finish. After some
time, the check loop interrupts with a unexpected device disconnect.
This works, but is slow because the kernel resets the scsi controller.
Instead of signaling UDC, start a timer and exit the loop. Until the
timer fires, the CPU can process instructions which might changes the
memory location.

The limit of instructions is also reduced because scripts running on
the SCSI processor are usually very short. This keeps the time until
the loop is exit short.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-ID: <20240229204407.1699260-1-svens@stackframe.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 43 +++++++++++++++++++++++++++++++++----------
 hw/scsi/trace-events |  2 ++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d607a5f9fb1..4ff94703816 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -188,7 +188,7 @@ static const char *names[] = {
 #define LSI_TAG_VALID     (1 << 16)
 
 /* Maximum instructions to process. */
-#define LSI_MAX_INSN    10000
+#define LSI_MAX_INSN    100
 
 typedef struct lsi_request {
     SCSIRequest *req;
@@ -205,6 +205,7 @@ enum {
     LSI_WAIT_RESELECT, /* Wait Reselect instruction has been issued */
     LSI_DMA_SCRIPTS, /* processing DMA from lsi_execute_script */
     LSI_DMA_IN_PROGRESS, /* DMA operation is in progress */
+    LSI_WAIT_SCRIPTS, /* SCRIPTS stopped because of instruction count limit */
 };
 
 enum {
@@ -224,6 +225,7 @@ struct LSIState {
     MemoryRegion ram_io;
     MemoryRegion io_io;
     AddressSpace pci_io_as;
+    QEMUTimer *scripts_timer;
 
     int carry; /* ??? Should this be an a visible register somewhere?  */
     int status;
@@ -415,6 +417,7 @@ static void lsi_soft_reset(LSIState *s)
     s->sbr = 0;
     assert(QTAILQ_EMPTY(&s->queue));
     assert(!s->current);
+    timer_del(s->scripts_timer);
 }
 
 static int lsi_dma_40bit(LSIState *s)
@@ -1127,6 +1130,12 @@ static void lsi_wait_reselect(LSIState *s)
     }
 }
 
+static void lsi_scripts_timer_start(LSIState *s)
+{
+    trace_lsi_scripts_timer_start();
+    timer_mod(s->scripts_timer, qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + 500);
+}
+
 static void lsi_execute_script(LSIState *s)
 {
     PCIDevice *pci_dev = PCI_DEVICE(s);
@@ -1136,6 +1145,11 @@ static void lsi_execute_script(LSIState *s)
     int insn_processed = 0;
     static int reentrancy_level;
 
+    if (s->waiting == LSI_WAIT_SCRIPTS) {
+        timer_del(s->scripts_timer);
+        s->waiting = LSI_NOWAIT;
+    }
+
     reentrancy_level++;
 
     s->istat1 |= LSI_ISTAT1_SRUN;
@@ -1143,8 +1157,8 @@ again:
     /*
      * Some windows drivers make the device spin waiting for a memory location
      * to change. If we have executed more than LSI_MAX_INSN instructions then
-     * assume this is the case and force an unexpected device disconnect. This
-     * is apparently sufficient to beat the drivers into submission.
+     * assume this is the case and start a timer. Until the timer fires, the
+     * host CPU has a chance to run and change the memory location.
      *
      * Another issue (CVE-2023-0330) can occur if the script is programmed to
      * trigger itself again and again. Avoid this problem by stopping after
@@ -1152,13 +1166,8 @@ again:
      * which should be enough for all valid use cases).
      */
     if (++insn_processed > LSI_MAX_INSN || reentrancy_level > 8) {
-        if (!(s->sien0 & LSI_SIST0_UDC)) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "lsi_scsi: inf. loop with UDC masked");
-        }
-        lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
-        lsi_disconnect(s);
-        trace_lsi_execute_script_stop();
+        s->waiting = LSI_WAIT_SCRIPTS;
+        lsi_scripts_timer_start(s);
         reentrancy_level--;
         return;
     }
@@ -2197,6 +2206,9 @@ static int lsi_post_load(void *opaque, int version_id)
         return -EINVAL;
     }
 
+    if (s->waiting == LSI_WAIT_SCRIPTS) {
+        lsi_scripts_timer_start(s);
+    }
     return 0;
 }
 
@@ -2294,6 +2306,15 @@ static const struct SCSIBusInfo lsi_scsi_info = {
     .cancel = lsi_request_cancelled
 };
 
+static void scripts_timer_cb(void *opaque)
+{
+    LSIState *s = opaque;
+
+    trace_lsi_scripts_timer_triggered();
+    s->waiting = LSI_NOWAIT;
+    lsi_execute_script(s);
+}
+
 static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
 {
     LSIState *s = LSI53C895A(dev);
@@ -2313,6 +2334,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
                           "lsi-ram", 0x2000);
     memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
                           "lsi-io", 256);
+    s->scripts_timer = timer_new_us(QEMU_CLOCK_VIRTUAL, scripts_timer_cb, s);
 
     /*
      * Since we use the address-space API to interact with ram_io, disable the
@@ -2337,6 +2359,7 @@ static void lsi_scsi_exit(PCIDevice *dev)
     LSIState *s = LSI53C895A(dev);
 
     address_space_destroy(&s->pci_io_as);
+    timer_del(s->scripts_timer);
 }
 
 static void lsi_class_init(ObjectClass *klass, void *data)
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index d72f741ed85..f0f2a98c2ee 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -302,6 +302,8 @@ lsi_execute_script_stop(void) "SCRIPTS execution stopped"
 lsi_awoken(void) "Woken by SIGP"
 lsi_reg_read(const char *name, int offset, uint8_t ret) "Read reg %s 0x%x = 0x%02x"
 lsi_reg_write(const char *name, int offset, uint8_t val) "Write reg %s 0x%x = 0x%02x"
+lsi_scripts_timer_triggered(void) "SCRIPTS timer triggered"
+lsi_scripts_timer_start(void) "SCRIPTS timer started"
 
 # virtio-scsi.c
 virtio_scsi_cmd_req(int lun, uint32_t tag, uint8_t cmd) "virtio_scsi_cmd_req lun=%u tag=0x%x cmd=0x%x"
-- 
2.43.2


