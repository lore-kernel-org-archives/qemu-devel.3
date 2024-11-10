Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D2CD5E39B
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 03:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9yoJ-0007gk-Tv; Sat, 09 Nov 2024 22:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9yoD-0007fU-J4
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 22:40:18 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9yoA-0000QN-Qs
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 22:40:17 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e4244fdc6so2959460b3a.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 19:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731210013; x=1731814813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4v7dNh0tFihXRU3YW4bfnWuiADJBD6mg/js2X/rZcE=;
 b=XR5H6L3NngbayT9lniqF+iR0vR6eW42tw4i/5YyoZ+ZiwSA3knXBiH/VQCRkOQRXYK
 wzvJvvvG+sT6+G7Neky70TRTX4o8ObwBO9wvN6+BahWDxF0ZYTo0jWXnE6tO/cJkmBW8
 W83g45t5wk1zhmbOQ/CNmJaBOdASacqJ3H+uxu0nz9aHkY5XkpGEhlnGyW/esF1Jam0Z
 /CauRx58LrHG1sBOyuZNDEwoE7NCEdnOjVAEqdelJV6izIglpyShgVdy2qckMwwzjHqG
 +MS++QB6RJtsw+B5oxy3XrQwMVo55KjR59mDhwCvq02UHVTR5OFjCMMdCRYpw4u42d0c
 YG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731210013; x=1731814813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o4v7dNh0tFihXRU3YW4bfnWuiADJBD6mg/js2X/rZcE=;
 b=jVgnhbVHlbiTmiwmjYQoMmcic2iRDdxnZWjSzVXpkRl0DAMlknVX8KEKvXU4X2aAKU
 yyAAEub7cX00+JW2emSc8jJviqO0sOmq7n7Ga/AAFW1u8arzvQqKWfxySk+fAhOW2mAA
 T+1h3Oyih/6h0PXaN6HE9KrWk3SUAP/dx9xMcuf0XIxTSlUDj07AqE7ieTH4h2M51n15
 mG+SQfwjuYcqBTMmKniyrA2ufyav4O/yPQ570c/G5ZAbNr7ywdJf/VtE4FKdSMvFoRLI
 /BIssSzdvl5xW2sVpxY++Rb9dYZgFm4lnFb97DFBTV+QIjo9iE07d8UldysSe+S1Tlv6
 uOAg==
X-Gm-Message-State: AOJu0YzOyylzkeg7EBjzoV2L62WNleS9KMHfovsqg7JRNxg3lhZJNTXk
 Kw90GTJ1yHjBR+HEDVnDI50tTds/z3kvg5bIlw2+qEousOUcgy7qAwFmxg==
X-Google-Smtp-Source: AGHT+IEg4mtlOs/CoX2ME4AjdWJD2+onbfwjashpKfPxCCmNmTwNu94PG7YVN4B5iMfbVnpy2r5dlQ==
X-Received: by 2002:a05:6a00:c89:b0:71e:6eb:786e with SMTP id
 d2e1a72fcca58-724132cd14amr10871276b3a.13.1731210012714; 
 Sat, 09 Nov 2024 19:40:12 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7240799bb78sm6345273b3a.95.2024.11.09.19.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 19:40:12 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH 2/2] usb/msd: Permit relaxed ordering of IN packets
Date: Sun, 10 Nov 2024 13:40:00 +1000
Message-ID: <20241110034000.379463-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110034000.379463-1-npiggin@gmail.com>
References: <20241110034000.379463-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The USB MSD protocol has 3 packets that make up a command, and only one
command may be active at any time.

- CBW to start a command (that contains a SCSI request).
- DATA (IN or OUT) to send request data between host and SCSI layer.
- CSW to return status and complete the command.

DATA is optional if the request has no data.

The QEMU MSD model requires these packets to arrive in this order, CBW,
DATA(*), CSW. This is the way the state machine is described in the
MSD spec, and this must be how most USB stacks operate. Except AIX.

Universal Serial Bus Mass Storage Class Bulk-Only Transport 1.0 contains:

  3.3 Host/Device Packet Transfer Order
  The host shall send the CBW before the associated Data-Out, and the
  device shall send Data-In after the associated CBW and before the
  associated CSW. The host may request Data-In or CSW before sending the
  associated CBW.

Complicating matters, DATA-IN and CSW are both input packets that arrive
in the same manner, so before a CBW it is impossible to determine if an
IN packet is for data or CSW.

This reworks the msd state machine to cope with out of order packets by
tracking them as an "unknown_in" packet until the CBW arrives, when they
are categorized into data or CSW.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/usb/msd.h |  20 +-
 hw/usb/dev-storage.c | 505 ++++++++++++++++++++++++++++---------------
 2 files changed, 349 insertions(+), 176 deletions(-)

diff --git a/include/hw/usb/msd.h b/include/hw/usb/msd.h
index f9fd862b52..847a708890 100644
--- a/include/hw/usb/msd.h
+++ b/include/hw/usb/msd.h
@@ -10,11 +10,11 @@
 #include "hw/usb.h"
 #include "hw/scsi/scsi.h"
 
-enum USBMSDMode {
-    USB_MSDM_CBW, /* Command Block.  */
-    USB_MSDM_DATAOUT, /* Transfer data to device.  */
-    USB_MSDM_DATAIN, /* Transfer data from device.  */
-    USB_MSDM_CSW /* Command Status.  */
+enum USBMSDCBWType {
+    USB_MSD_CBW_NONE       = 0,
+    USB_MSD_CBW_ZERO,           /* zero-length */
+    USB_MSD_CBW_DATAIN,         /* data-in command */
+    USB_MSD_CBW_DATAOUT,        /* data-out command */
 };
 
 struct QEMU_PACKED usb_msd_csw {
@@ -26,15 +26,21 @@ struct QEMU_PACKED usb_msd_csw {
 
 struct MSDState {
     USBDevice dev;
-    enum USBMSDMode mode;
+    bool ready;
+    bool cmd_done;
+    enum USBMSDCBWType cbw_type;
     uint32_t scsi_off;
     uint32_t scsi_len;
     uint32_t data_len;
     struct usb_msd_csw csw;
     SCSIRequest *req;
     SCSIBus bus;
+
     /* For async completion.  */
-    USBPacket *packet;
+    USBPacket *data_packet;
+    USBPacket *csw_in_packet;
+    USBPacket *unknown_in_packet;
+
     /* usb-storage only */
     BlockConf conf;
     bool removable;
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 4f1e8b7f6c..e64fcd5c6a 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -35,7 +35,7 @@ struct usb_msd_cbw {
     uint8_t lun;
     uint8_t cmd_len;
     uint8_t cmd[16];
-};
+} __attribute__((packed));
 
 enum {
     STR_MANUFACTURER = 1,
@@ -177,18 +177,33 @@ static const USBDesc desc = {
     .str   = desc_strings,
 };
 
-static void usb_msd_packet_complete(MSDState *s, int status)
+static void usb_msd_data_packet_complete(MSDState *s, int status)
+{
+    USBPacket *p = s->data_packet;
+
+    /*
+     * Set s->data_packet to NULL before calling usb_packet_complete
+     * because another request may be issued before usb_packet_complete
+     * returns.
+     */
+    trace_usb_msd_packet_complete();
+    s->data_packet = NULL;
+    p->status = status;
+    usb_packet_complete(&s->dev, p);
+}
+
+static void usb_msd_csw_packet_complete(MSDState *s, int status)
 {
-    USBPacket *p = s->packet;
+    USBPacket *p = s->csw_in_packet;
 
     /*
-     * Set s->packet to NULL before calling usb_packet_complete
-     * because another request may be issued before
-     * usb_packet_complete returns.
+     * Set s->csw_in_packet to NULL before calling usb_packet_complete
+     * because another request may be issued before usb_packet_complete
+     * returns.
      */
     trace_usb_msd_packet_complete();
+    s->csw_in_packet = NULL;
     p->status = status;
-    s->packet = NULL;
     usb_packet_complete(&s->dev, p);
 }
 
@@ -196,8 +211,12 @@ static void usb_msd_fatal_error(MSDState *s)
 {
     trace_usb_msd_fatal_error();
 
-    if (s->packet) {
-        usb_msd_packet_complete(s, USB_RET_STALL);
+    if (s->data_packet) {
+        usb_msd_data_packet_complete(s, USB_RET_STALL);
+    }
+
+    if (s->csw_in_packet) {
+        usb_msd_csw_packet_complete(s, USB_RET_STALL);
     }
 
     /*
@@ -242,21 +261,32 @@ static void usb_msd_send_status(MSDState *s, USBPacket *p)
 void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
 {
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
-    USBPacket *p = s->packet;
+    USBPacket *p = s->data_packet;
 
-    if ((s->mode == USB_MSDM_DATAOUT) != (req->cmd.mode == SCSI_XFER_TO_DEV)) {
-        usb_msd_fatal_error(s);
-        return;
+    if (s->cbw_type == USB_MSD_CBW_DATAIN) {
+        if (req->cmd.mode == SCSI_XFER_TO_DEV) {
+            usb_msd_fatal_error(s);
+            return;
+        }
+    } else if (s->cbw_type == USB_MSD_CBW_DATAOUT) {
+        if (req->cmd.mode != SCSI_XFER_TO_DEV) {
+            usb_msd_fatal_error(s);
+            return;
+        }
+    } else {
+        g_assert_not_reached();
     }
 
+    assert(s->scsi_len == 0);
     s->scsi_len = len;
     s->scsi_off = 0;
+
     if (p) {
         usb_msd_copy_data(s, p);
-        p = s->packet;
+        p = s->data_packet;
         if (p && p->actual_length == p->iov.size) {
             /* USB_RET_SUCCESS status clears previous ASYNC status */
-            usb_msd_packet_complete(s, USB_RET_SUCCESS);
+            usb_msd_data_packet_complete(s, USB_RET_SUCCESS);
         }
     }
 }
@@ -264,44 +294,51 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
 void usb_msd_command_complete(SCSIRequest *req, size_t resid)
 {
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
-    USBPacket *p = s->packet;
+    USBPacket *p = s->data_packet;
 
     trace_usb_msd_cmd_complete(req->status, req->tag);
 
+    g_assert(s->req);
+    /* The CBW is what starts the SCSI request */
+    g_assert(s->cbw_type != 0);
+    g_assert(!s->cmd_done);
+
+    if (s->cbw_type == USB_MSD_CBW_ZERO) {
+        g_assert(!p);
+    }
+
     s->csw.sig = cpu_to_le32(0x53425355);
     s->csw.tag = cpu_to_le32(req->tag);
     s->csw.residue = cpu_to_le32(s->data_len);
     s->csw.status = req->status != 0;
 
-    if (s->packet) {
-        if (s->data_len == 0 && s->mode == USB_MSDM_DATAOUT) {
-            /* A deferred packet with no write data remaining must be
-               the status read packet.  */
-            usb_msd_send_status(s, p);
-            s->mode = USB_MSDM_CBW;
-        } else if (s->mode == USB_MSDM_CSW) {
-            usb_msd_send_status(s, p);
-            s->mode = USB_MSDM_CBW;
-        } else {
-            if (s->data_len) {
-                int len = (p->iov.size - p->actual_length);
-                usb_packet_skip(p, len);
-                if (len > s->data_len) {
-                    len = s->data_len;
-                }
-                s->data_len -= len;
-            }
-            if (s->data_len == 0) {
-                s->mode = USB_MSDM_CSW;
+    /* Set cmd_done req to NULL before completing packet because another
+     * packet may come in after that */
+    s->cmd_done = true;
+    scsi_req_unref(req);
+    s->req = NULL;
+
+    if (p) {
+        if (s->data_len) {
+            int len = (p->iov.size - p->actual_length);
+            usb_packet_skip(p, len);
+            if (len > s->data_len) {
+                len = s->data_len;
             }
+            s->data_len -= len;
         }
         /* USB_RET_SUCCESS status clears previous ASYNC status */
-        usb_msd_packet_complete(s, USB_RET_SUCCESS);
-    } else if (s->data_len == 0) {
-        s->mode = USB_MSDM_CSW;
+        usb_msd_data_packet_complete(s, USB_RET_SUCCESS);
+    }
+
+    if (s->csw_in_packet) {
+        g_assert(s->csw_in_packet);
+        usb_msd_send_status(s, s->csw_in_packet);
+        usb_msd_csw_packet_complete(s, USB_RET_SUCCESS);
+        s->cbw_type = USB_MSD_CBW_NONE;
+        s->cmd_done = false;
+        s->ready = true;
     }
-    scsi_req_unref(req);
-    s->req = NULL;
 }
 
 void usb_msd_request_cancelled(SCSIRequest *req)
@@ -315,9 +352,10 @@ void usb_msd_request_cancelled(SCSIRequest *req)
         s->csw.tag = cpu_to_le32(req->tag);
         s->csw.status = 1; /* error */
 
+        s->scsi_len = 0;
+        s->cmd_done = true;
         scsi_req_unref(s->req);
         s->req = NULL;
-        s->scsi_len = 0;
     }
 }
 
@@ -331,12 +369,19 @@ void usb_msd_handle_reset(USBDevice *dev)
     }
     assert(s->req == NULL);
 
-    if (s->packet) {
-        usb_msd_packet_complete(s, USB_RET_STALL);
+    if (s->data_packet) {
+        usb_msd_data_packet_complete(s, USB_RET_STALL);
     }
 
+    if (s->csw_in_packet) {
+        usb_msd_csw_packet_complete(s, USB_RET_STALL);
+    }
+
+    s->unknown_in_packet = NULL;
     memset(&s->csw, 0, sizeof(s->csw));
-    s->mode = USB_MSDM_CBW;
+    s->cbw_type = USB_MSD_CBW_NONE;
+    s->cmd_done = false;
+    s->ready = true;
 
     s->needs_reset = false;
 }
@@ -355,11 +400,12 @@ static void usb_msd_handle_control(USBDevice *dev, USBPacket *p,
 
     switch (request) {
     case EndpointOutRequest | USB_REQ_CLEAR_FEATURE:
+        /* XXX clear halt not implemented */
         break;
         /* Class specific requests.  */
     case ClassInterfaceOutRequest | MassStorageReset:
         /* Reset state ready for the next CBW.  */
-        s->mode = USB_MSDM_CBW;
+        usb_msd_handle_reset(dev);
         break;
     case ClassInterfaceRequest | GetMaxLun:
         maxlun = 0;
@@ -387,166 +433,284 @@ static void usb_msd_cancel_io(USBDevice *dev, USBPacket *p)
 {
     MSDState *s = USB_STORAGE_DEV(dev);
 
-    assert(s->packet == p);
-    s->packet = NULL;
-
-    if (s->req) {
-        scsi_req_cancel(s->req);
+    if (p == s->data_packet) {
+        s->data_packet = NULL;
+        if (s->req) {
+            scsi_req_cancel(s->req);
+        }
+    } else if (p == s->csw_in_packet) {
+        s->csw_in_packet = NULL;
+    } else if (p == s->unknown_in_packet) {
+        s->unknown_in_packet = NULL;
+    } else {
+        g_assert_not_reached();
     }
 }
 
-static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
+static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
 {
     MSDState *s = (MSDState *)dev;
-    uint32_t tag;
-    struct usb_msd_cbw cbw;
-    uint8_t devep = p->ep->nr;
-    SCSIDevice *scsi_dev;
-    int len;
 
-    if (s->needs_reset) {
-        p->status = USB_RET_STALL;
-        return;
-    }
+    if (!s->cbw_type) {
+        uint32_t tag;
+        struct usb_msd_cbw cbw;
+        SCSIDevice *scsi_dev;
+        int len;
 
-    switch (p->pid) {
-    case USB_TOKEN_OUT:
-        if (devep != 2)
+        if (p->iov.size != 31) {
+            error_report("usb-msd: Bad CBW size %ld", p->iov.size);
+            goto fail;
+        }
+        usb_packet_copy(p, &cbw, 31);
+        if (le32_to_cpu(cbw.sig) != 0x43425355) {
+            error_report("usb-msd: Bad signature %08x",
+                         le32_to_cpu(cbw.sig));
+            goto fail;
+        }
+        scsi_dev = scsi_device_find(&s->bus, 0, 0, cbw.lun);
+        if (scsi_dev == NULL) {
+            error_report("usb-msd: Bad LUN %d", cbw.lun);
             goto fail;
+        }
 
-        switch (s->mode) {
-        case USB_MSDM_CBW:
-            if (p->iov.size != 31) {
-                error_report("usb-msd: Bad CBW size");
-                goto fail;
-            }
-            usb_packet_copy(p, &cbw, 31);
-            if (le32_to_cpu(cbw.sig) != 0x43425355) {
-                error_report("usb-msd: Bad signature %08x",
-                             le32_to_cpu(cbw.sig));
-                goto fail;
-            }
-            scsi_dev = scsi_device_find(&s->bus, 0, 0, cbw.lun);
-            if (scsi_dev == NULL) {
-                error_report("usb-msd: Bad LUN %d", cbw.lun);
-                goto fail;
+        tag = le32_to_cpu(cbw.tag);
+        s->data_len = le32_to_cpu(cbw.data_len);
+
+        s->ready = false;
+        if ((cbw.flags & 0x80) && s->data_len > 0) {
+            s->cbw_type = USB_MSD_CBW_DATAIN;
+            if (s->unknown_in_packet) {
+                /* In packet must be be DATAIN */
+                g_assert(!s->data_packet);
+                s->data_packet = s->unknown_in_packet;
+                s->unknown_in_packet = NULL;
             }
-            tag = le32_to_cpu(cbw.tag);
-            s->data_len = le32_to_cpu(cbw.data_len);
+
+        } else {
             if (s->data_len == 0) {
-                s->mode = USB_MSDM_CSW;
-            } else if (cbw.flags & 0x80) {
-                s->mode = USB_MSDM_DATAIN;
+                s->cbw_type = USB_MSD_CBW_ZERO;
             } else {
-                s->mode = USB_MSDM_DATAOUT;
-            }
-            trace_usb_msd_cmd_submit(cbw.lun, tag, cbw.flags,
-                                     cbw.cmd_len, s->data_len);
-            assert(le32_to_cpu(s->csw.residue) == 0);
-            s->scsi_len = 0;
-            s->req = scsi_req_new(scsi_dev, tag, cbw.lun, cbw.cmd, cbw.cmd_len, NULL);
-            if (s->commandlog) {
-                scsi_req_print(s->req);
+                s->cbw_type = USB_MSD_CBW_DATAOUT;
             }
-            len = scsi_req_enqueue(s->req);
-            if (len) {
-                scsi_req_continue(s->req);
-            }
-            break;
+            if (s->unknown_in_packet) {
+                /* In packet must be the CSW */
+                if (s->unknown_in_packet->iov.size != 13) {
+                    /*
+                     * Not strictly within spec to reject size > 13? But
+                     * could catch some guest errors.
+                     */
+                    error_report("usb-msd: CSW size %zd != 13\n",
+                                 s->unknown_in_packet->iov.size);
+                    goto fail;
+                }
 
-        case USB_MSDM_DATAOUT:
-            trace_usb_msd_data_out(p->iov.size, s->data_len);
-            if (p->iov.size > s->data_len) {
-                goto fail;
+                /* In packet must be be CSW */
+                s->csw_in_packet = s->unknown_in_packet;
+                s->unknown_in_packet = NULL;
             }
+        }
+        trace_usb_msd_cmd_submit(cbw.lun, tag, cbw.flags,
+                                 cbw.cmd_len, s->data_len);
+        assert(le32_to_cpu(s->csw.residue) == 0);
+        assert(s->scsi_len == 0);
+        s->req = scsi_req_new(scsi_dev, tag, cbw.lun, cbw.cmd,
+                              cbw.cmd_len, NULL);
+        if (s->commandlog) {
+            scsi_req_print(s->req);
+        }
+        len = scsi_req_enqueue(s->req);
+        if (len) {
+            scsi_req_continue(s->req);
+        }
 
-            if (s->scsi_len) {
-                usb_msd_copy_data(s, p);
-            }
-            if (le32_to_cpu(s->csw.residue)) {
-                len = p->iov.size - p->actual_length;
-                if (len) {
-                    usb_packet_skip(p, len);
-                    if (len > s->data_len) {
-                        len = s->data_len;
-                    }
-                    s->data_len -= len;
-                    if (s->data_len == 0) {
-                        s->mode = USB_MSDM_CSW;
-                    }
+    } else if (s->cbw_type == USB_MSD_CBW_DATAOUT) {
+        trace_usb_msd_data_out(p->iov.size, s->data_len);
+        if (s->data_packet) {
+            error_report("usb-msd: dataout packet while dataout in progress");
+            goto fail;
+        }
+        if (s->unknown_in_packet) {
+            error_report("usb-msd: dataout packet with unknown in packet");
+            goto fail;
+        }
+        if (p->iov.size > s->data_len) {
+            error_report("usb-msd: dataout packet too large for CBW");
+            goto fail;
+        }
+
+        if (s->scsi_len) {
+            usb_msd_copy_data(s, p);
+        }
+
+        if (s->cmd_done) {
+            int len;
+
+            g_assert(!s->req);
+            len = p->iov.size - p->actual_length;
+            if (len) {
+                usb_packet_skip(p, len);
+                if (len > s->data_len) {
+                    len = s->data_len;
                 }
+                s->data_len -= len;
+            }
+            if (s->csw_in_packet) {
+                usb_msd_send_status(s, s->csw_in_packet);
+                usb_msd_csw_packet_complete(s, USB_RET_SUCCESS);
+                s->cbw_type = USB_MSD_CBW_NONE;
+                s->cmd_done = false;
+                s->ready = true;
             }
+        } else {
             if (p->actual_length < p->iov.size) {
                 trace_usb_msd_packet_async();
-                s->packet = p;
+                assert(!s->csw_in_packet);
+                s->data_packet = p;
                 p->status = USB_RET_ASYNC;
             }
-            break;
-
-        default:
-            goto fail;
         }
-        break;
+    } else { /* USB_MSD_CBW_ZERO or USB_MSD_CBW_DATAIN */
+        error_report("usb-msd: unexpected out packet in state %x",
+                     s->cbw_type);
+fail:
+        p->status = USB_RET_STALL;
+    }
+}
 
-    case USB_TOKEN_IN:
-        if (devep != 1)
-            goto fail;
+static void usb_msd_handle_data_in(USBDevice *dev, USBPacket *p)
+{
+    MSDState *s = (MSDState *)dev;
 
-        switch (s->mode) {
-        case USB_MSDM_DATAOUT:
-            if (s->data_len != 0 || p->iov.size < 13) {
-                goto fail;
+    if (!s->cbw_type) {
+        s->ready = false;
+        if (s->unknown_in_packet) {
+            /*
+             * It's unclear from the USB MSD spec if this is permitted, but
+             * for now we don't try to handle it.
+             */
+            error_report("usb-msd: 2nd datain packet before CBW");
+            goto fail;
+        }
+        g_assert(!s->req);
+        g_assert(!s->data_packet);
+        g_assert(!s->csw_in_packet);
+        s->unknown_in_packet = p;
+        trace_usb_msd_packet_async();
+        p->status = USB_RET_ASYNC;
+
+    } else if (s->cmd_done) {
+        g_assert(!s->req);
+        if (s->data_len) {
+            int len = (p->iov.size - p->actual_length);
+            usb_packet_skip(p, len);
+            if (len > s->data_len) {
+                len = s->data_len;
             }
-            /* Waiting for SCSI write to complete.  */
-            trace_usb_msd_packet_async();
-            s->packet = p;
-            p->status = USB_RET_ASYNC;
-            break;
-
-        case USB_MSDM_CSW:
-            if (p->iov.size < 13) {
+            s->data_len -= len;
+        } else {
+            if (p->iov.size != 13) {
+                qemu_log("usb-msd: CSD size is %ld (expecting 13)\n", p->iov.size);
                 goto fail;
             }
 
-            if (s->req) {
-                /* still in flight */
-                trace_usb_msd_packet_async();
-                s->packet = p;
-                p->status = USB_RET_ASYNC;
-            } else {
-                usb_msd_send_status(s, p);
-                s->mode = USB_MSDM_CBW;
-            }
-            break;
+            usb_msd_send_status(s, p);
+            s->cbw_type = USB_MSD_CBW_NONE;
+            s->cmd_done = false;
+            s->ready = true;
+        }
 
-        case USB_MSDM_DATAIN:
-            trace_usb_msd_data_in(p->iov.size, s->data_len, s->scsi_len);
-            if (s->scsi_len) {
-                usb_msd_copy_data(s, p);
-            }
-            if (le32_to_cpu(s->csw.residue)) {
-                len = p->iov.size - p->actual_length;
-                if (len) {
-                    usb_packet_skip(p, len);
-                    if (len > s->data_len) {
-                        len = s->data_len;
-                    }
-                    s->data_len -= len;
-                    if (s->data_len == 0) {
-                        s->mode = USB_MSDM_CSW;
-                    }
+    } else if (s->cbw_type == USB_MSD_CBW_DATAIN) {
+        trace_usb_msd_data_in(p->iov.size, s->data_len, s->scsi_len);
+        if (s->data_packet) {
+            error_report("usb-msd: data packet while datain in progress");
+            goto fail;
+        }
+        g_assert(!s->data_packet);
+        g_assert(!s->unknown_in_packet);
+        g_assert(!s->csw_in_packet);
+
+        if (s->scsi_len) {
+            usb_msd_copy_data(s, p);
+        }
+
+        if (s->cmd_done) {
+            int len;
+
+            g_assert(!s->req);
+            len = p->iov.size - p->actual_length;
+            if (len) {
+                usb_packet_skip(p, len);
+                if (len > s->data_len) {
+                    len = s->data_len;
                 }
+                s->data_len -= len;
+                g_assert(s->data_len == 0);
             }
-            if (p->actual_length < p->iov.size && s->mode == USB_MSDM_DATAIN) {
+            if (p->status == USB_RET_ASYNC) {
+                usb_msd_data_packet_complete(s, USB_RET_SUCCESS);
+            }
+        } else {
+            if (p->actual_length < p->iov.size) {
                 trace_usb_msd_packet_async();
-                s->packet = p;
+                s->data_packet = p;
                 p->status = USB_RET_ASYNC;
             }
-            break;
+        }
+    } else { /* USB_MSD_CBW_ZERO or USB_MSD_CBW_DATAOUT */
+        if (s->csw_in_packet) {
+            /*
+             * It's unclear from the USB MSD spec if this is permitted, but
+             * for now we don't try to handle it.
+             */
+            error_report("usb-msd: 2nd CSW packet");
+            goto fail;
+        }
+        g_assert(!s->unknown_in_packet);
+        if (s->cbw_type == USB_MSD_CBW_ZERO) {
+            g_assert(s->data_len == 0);
+            g_assert(!s->data_packet);
+        }
+        g_assert(s->req);
+        g_assert(!s->unknown_in_packet);
 
-        default:
+        if (p->iov.size != 13) {
+            qemu_log("usb-msd: CSD size is %ld (expecting 13)\n", p->iov.size);
             goto fail;
         }
+
+        /* Waiting for SCSI zero/write to complete.  */
+        trace_usb_msd_packet_async();
+        s->csw_in_packet = p;
+        p->status = USB_RET_ASYNC;
+    }
+    return;
+fail:
+    p->status = USB_RET_STALL;
+}
+
+static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
+{
+    MSDState *s = (MSDState *)dev;
+    uint8_t devep = p->ep->nr;
+
+    if (s->needs_reset) {
+        p->status = USB_RET_STALL;
+        return;
+    }
+
+    switch (p->pid) {
+    case USB_TOKEN_OUT:
+        if (devep != 2) {
+            goto fail;
+        }
+        usb_msd_handle_data_out(dev, p);
+        break;
+
+    case USB_TOKEN_IN:
+        if (devep != 1) {
+            goto fail;
+        }
+        usb_msd_handle_data_in(dev, p);
         break;
 
     default:
@@ -573,7 +737,7 @@ static const VMStateDescription vmstate_usb_msd = {
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, MSDState),
-        VMSTATE_UINT32(mode, MSDState),
+//        VMSTATE_UINT32(state, MSDState),
         VMSTATE_UINT32(scsi_len, MSDState),
         VMSTATE_UINT32(scsi_off, MSDState),
         VMSTATE_UINT32(data_len, MSDState),
@@ -612,6 +776,9 @@ static const TypeInfo usb_storage_dev_type_info = {
 
 static void usb_msd_register_types(void)
 {
+    qemu_build_assert(sizeof(struct usb_msd_cbw) == 31);
+    qemu_build_assert(sizeof(struct usb_msd_csw) == 13);
+
     type_register_static(&usb_storage_dev_type_info);
 }
 
-- 
2.45.2


