Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237B4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh7i-0004Bh-3S; Thu, 01 May 2025 23:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7a-0004AE-Nc
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:32 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7V-0001G7-Vg
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:30 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7403f3ece96so2262977b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156684; x=1746761484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NM7HJOh9v000gUzrupe4wLfC+e8cJXJMVS97llbap5s=;
 b=NK2WYSPpt/wHo19iD2SoehlQG4i1bbmKw6QHoaWj/xEk6rYEuaYTWm5/AE74eZQiHM
 ujJgbvczuaQGxGR3NP7vRzsR2aZsDx+rwS+WomSZVXaiBJj9b5DD43Pk+Xuj9agECqGv
 5WKSZwD6ZP1NLBRk/k2O1SIKC31nrAKT0RdWS4aVTZcMYeSPMFvklrOlzQKfMdRkFNcu
 THzePEvTX4TP6iyE+LI+tIZgX8vJdwT+EsMQ4OAld29K2hulGE/SuwlgxWfptDATCr44
 VQAYyIDSME+EbQlt61ofQmuYWgizNlkYazKb/w0+BkhHtz2lGdRqhVZCNX0L44cfbVSU
 7Oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156684; x=1746761484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NM7HJOh9v000gUzrupe4wLfC+e8cJXJMVS97llbap5s=;
 b=YI0y1N+0RNnYPSKEgW0yl+lxNfmj8vG/EPaeAZKdJpu04c1iBpjjuQmZ9O7K1V5ToM
 C8a8kl1KVoqAP3oANrVcBmmDjewwHCaUQzeKD9MwDdFUOeT3EzP4Cxs4FbgxzC4zXMSN
 hu0OZAE1qF1SfxOD8+LN9Tnxv/DnMFdyrG+XqK9lPujDdbD6ulJFmU+aC7RAI9PLFKkN
 BC7okD0M7KfzEAMuEa664Ni2//3i4mTdaRzKL3xomtJGoAeOJDYt3ruNJRZjOvrSyCr1
 6ux1cJ8iz9jzVwuvNKkqAx65a8yWEiHWjwnbkDS3aYIxo5BV6744rxLf9I0hjRSkifFj
 oPhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL8Q1WSdqRhBIsdNgb1lKUj3F4dKHMIj7ABcJF5O8G0fbdN+KYZpNzHk4t71c1nLN6gU62+N/V+Rkt@nongnu.org
X-Gm-Message-State: AOJu0YyH7lFqKlT+TYn797MKtn2QsEApifovLKKh5veliH2OyePHAWBn
 IQhQCL8jIfixM7Z1HPIXeqzKmQp4tj49TgqCJY3V3Ue5CuOXeqCI
X-Gm-Gg: ASbGncs2XaGgKM1xM3lxyrlUcQ5LNjB/myTMC2zHPgFNIE1TNqoHEV8UrJmJ7DmGPVq
 mZPuVY9liGCWMABpGyD4D9Ze/18Ro3AUCn1WLON1COUDjAL4qfXHvN8xTpwr2LX2ZnELwA4xLpZ
 JOd/8RUP86c4TloV0U17HKEKiWKhejgifjSz8PFzWERXjddfYv9+8lP+15Ga8LMr3uX2Gvd4Tb6
 8Q36JlFEXl3zoEu8rsBg89DWPTsqM90ZNwvsiV4WE1aYe9QManGDtrczES3FWmfLMCOrtbtv+7x
 paTrf6cX2qHznWP6o2OEb7YqGFXsByNqpVxJYxPAFEVM
X-Google-Smtp-Source: AGHT+IH5xq74SLhEQQVKGQoN0+XaUZSN4rk7bMP+GXNdeqGdrawl3inEGgXXs8hNrPfSvdc0eFn4bQ==
X-Received: by 2002:a05:6a00:8d8d:b0:736:31cf:2590 with SMTP id
 d2e1a72fcca58-74058aea47emr1781034b3a.16.1746156684536; 
 Thu, 01 May 2025 20:31:24 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:31:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 05/22] tests/qtest/xhci: Add basic USB Mass Storage tests
Date: Fri,  2 May 2025 13:30:29 +1000
Message-ID: <20250502033047.102465-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

Add a usb-storage device to xhci tests, enable USB Mass Storage Bulk
endpoints, and run some MSD commands through it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/usb-hcd-xhci-test.c | 359 +++++++++++++++++++++++++++++++-
 1 file changed, 351 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 291d1dfc36e..39c5c36e940 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -373,6 +373,20 @@ static uint64_t submit_cr_trb(XHCIQState *s, const XHCITRB *trb)
     return ret;
 }
 
+static uint64_t submit_tr_trb(XHCIQState *s, int slot, int ep,
+                              const XHCITRB *trb)
+{
+    XHCIQSlotState *sl = &s->slots[slot];
+    XHCIQTRState *tr = &sl->transfer_ring[ep];
+    uint64_t ret;
+
+    ret = queue_trb(s, tr, trb);
+
+    xhci_db_writel(s, slot, 1 + ep); /* doorbell slot, EP<ep> target */
+
+    return ret;
+}
+
 static void xhci_enable_device(XHCIQState *s)
 {
     XHCIQTRState *tr;
@@ -451,14 +465,165 @@ static void xhci_enable_device(XHCIQState *s)
     for (i = 0; i < s->maxports; i++) {
         value = xhci_port_readl(s, i, 0); /* PORTSC */
 
-        /* All ports should be disabled */
-        g_assert(!(value & XHCI_PORTSC_CCS));
-        g_assert(!(value & XHCI_PORTSC_PED));
-        g_assert(((value >> XHCI_PORTSC_PLS_SHIFT) &
-                  XHCI_PORTSC_PLS_MASK) == 5);
+        /* First port should be attached and enabled if we have usb-storage */
+        if (qtest_has_device("usb-storage") && i == 0) {
+            g_assert(value & XHCI_PORTSC_CCS);
+            g_assert(value & XHCI_PORTSC_PED);
+            /* Port Speed must be identified (non-zero) */
+            g_assert(((value >> XHCI_PORTSC_SPEED_SHIFT) &
+                      XHCI_PORTSC_SPEED_MASK) != 0);
+        } else {
+            g_assert(!(value & XHCI_PORTSC_CCS));
+            g_assert(!(value & XHCI_PORTSC_PED));
+            g_assert(((value >> XHCI_PORTSC_PLS_SHIFT) &
+                      XHCI_PORTSC_PLS_MASK) == 5);
+        }
     }
 }
 
+/* XXX: what should these values be? */
+#define TRB_MAX_PACKET_SIZE 0x200
+#define TRB_AVERAGE_LENGTH  0x200
+
+static void xhci_enable_slot(XHCIQState *s)
+{
+    XHCIQTRState *tr;
+    uint64_t input_context;
+    XHCITRB trb;
+    uint64_t tag;
+    g_autofree void *mem = g_malloc0(0x1000); /* buffer for writing to guest */
+    uint32_t *dc; /* device context */
+
+    /* Issue a command ring enable slot */
+    memset(&trb, 0, TRB_SIZE);
+    trb.control |= CR_ENABLE_SLOT << TRB_TYPE_SHIFT;
+    trb.control |= TRB_TR_IOC;
+    tag = submit_cr_trb(s, &trb);
+    wait_event_trb(s, &trb);
+    g_assert_cmphex(trb.parameter , ==, tag);
+    g_assert_cmpint(TRB_TYPE(trb), ==, ER_COMMAND_COMPLETE);
+    s->slotid = (trb.control >> TRB_CR_SLOTID_SHIFT) & 0xff;
+
+    /* 32-byte input context size, should check HCCPARAMS1 for 64-byte size */
+    input_context = xhci_guest_zalloc(s, 0x420);
+
+    /* Set input control context */
+    memset(mem, 0, 0x420);
+    ((uint32_t *)mem)[1] = cpu_to_le32(0x3); /* Add device contexts 0 and 1 */
+
+    /* Slot context */
+    dc = mem + 1 * 0x20;
+    dc[0] = cpu_to_le32(1 << 27); /* 1 context entry */
+    dc[1] = cpu_to_le32(1 << 16); /* 1 port number */
+
+    /* Endpoint 0 context */
+    tr = &s->slots[s->slotid].transfer_ring[0];
+    tr->addr = xhci_guest_zalloc(s, 0x1000);
+    tr->trb_entries = 0x10;
+    tr->trb_c = 1;
+
+    dc = mem + 2 * 0x20;
+    dc[0] = 0;
+    dc[1] = cpu_to_le32((ET_CONTROL << EP_TYPE_SHIFT) |
+                        (TRB_MAX_PACKET_SIZE << 16));
+    dc[2] = cpu_to_le32((tr->addr & 0xffffffff) | 1); /* DCS=1 */
+    dc[3] = cpu_to_le32(tr->addr >> 32);
+    dc[4] = cpu_to_le32(TRB_AVERAGE_LENGTH);
+    qtest_memwrite(s->parent->qts, input_context, mem, 0x420);
+
+    s->slots[s->slotid].device_context = xhci_guest_zalloc(s, 0x400);
+
+    ((uint64_t *)mem)[0] = cpu_to_le64(s->slots[s->slotid].device_context);
+    qtest_memwrite(s->parent->qts, s->dc_base_array + 8 * s->slotid, mem, 8);
+
+    /* Issue a command ring address device */
+    memset(&trb, 0, TRB_SIZE);
+    trb.parameter = input_context;
+    trb.control |= CR_ADDRESS_DEVICE << TRB_TYPE_SHIFT;
+    trb.control |= s->slotid << TRB_CR_SLOTID_SHIFT;
+    tag = submit_cr_trb(s, &trb);
+    wait_event_trb(s, &trb);
+    g_assert_cmphex(trb.parameter , ==, tag);
+    g_assert_cmpint(TRB_TYPE(trb), ==, ER_COMMAND_COMPLETE);
+
+    guest_free(&s->parent->alloc, input_context);
+
+    /* Check EP0 is running */
+    qtest_memread(s->parent->qts, s->slots[s->slotid].device_context, mem, 0x400);
+    g_assert((((uint32_t *)mem)[8] & 0x3) == EP_RUNNING);
+}
+
+static void xhci_enable_msd_bulk_endpoints(XHCIQState *s)
+{
+    XHCIQTRState *tr;
+    uint64_t input_context;
+    XHCITRB trb;
+    uint64_t tag;
+    g_autofree void *mem = g_malloc0(0x1000); /* buffer for writing to guest */
+    uint32_t *dc; /* device context */
+
+    /* Configure 2 more endpoints */
+
+    /* 32-byte input context size, should check HCCPARAMS1 for 64-byte size */
+    input_context = xhci_guest_zalloc(s, 0x420);
+
+    /* Set input control context */
+    memset(mem, 0, 0x420);
+    ((uint32_t *)mem)[1] = cpu_to_le32(0x19); /* Add device contexts 0, 3, 4 */
+
+    /* Slot context */
+    dc = mem + 1 * 0x20;
+    dc[0] = cpu_to_le32(1 << 27); /* 1 context entry */
+    dc[1] = cpu_to_le32(1 << 16); /* 1 port number */
+
+    /* Endpoint 1 (IN) context */
+    tr = &s->slots[s->slotid].transfer_ring[2];
+    tr->addr = xhci_guest_zalloc(s, 0x1000);
+    tr->trb_entries = 0x10;
+    tr->trb_c = 1;
+
+    dc = mem + 4 * 0x20;
+    dc[0] = 0;
+    dc[1] = cpu_to_le32((ET_BULK_IN << EP_TYPE_SHIFT) |
+                        (TRB_MAX_PACKET_SIZE << 16));
+    dc[2] = cpu_to_le32((tr->addr & 0xffffffff) | 1); /* DCS=1 */
+    dc[3] = cpu_to_le32(tr->addr >> 32);
+    dc[4] = cpu_to_le32(TRB_AVERAGE_LENGTH);
+
+    /* Endpoint 2 (OUT) context */
+    tr = &s->slots[s->slotid].transfer_ring[3];
+    tr->addr = xhci_guest_zalloc(s, 0x1000);
+    tr->trb_entries = 0x10;
+    tr->trb_c = 1;
+
+    dc = mem + 5 * 0x20;
+    dc[0] = 0;
+    dc[1] = cpu_to_le32((ET_BULK_OUT << EP_TYPE_SHIFT) |
+                        (TRB_MAX_PACKET_SIZE << 16));
+    dc[2] = cpu_to_le32((tr->addr & 0xffffffff) | 1); /* DCS=1 */
+    dc[3] = cpu_to_le32(tr->addr >> 32);
+    dc[4] = cpu_to_le32(TRB_AVERAGE_LENGTH);
+    qtest_memwrite(s->parent->qts, input_context, mem, 0x420);
+
+    /* Issue a command ring configure endpoint */
+    memset(&trb, 0, TRB_SIZE);
+    trb.parameter = input_context;
+    trb.control |= CR_CONFIGURE_ENDPOINT << TRB_TYPE_SHIFT;
+    trb.control |= s->slotid << TRB_CR_SLOTID_SHIFT;
+    tag = submit_cr_trb(s, &trb);
+    wait_event_trb(s, &trb);
+    g_assert_cmphex(trb.parameter , ==, tag);
+    g_assert_cmpint(TRB_TYPE(trb), ==, ER_COMMAND_COMPLETE);
+
+    guest_free(&s->parent->alloc, input_context);
+
+    /* Check EPs are running */
+    qtest_memread(s->parent->qts, s->slots[s->slotid].device_context, mem, 0x400);
+    g_assert((((uint32_t *)mem)[1*8] & 0x3) == EP_RUNNING);
+    g_assert((((uint32_t *)mem)[3*8] & 0x3) == EP_RUNNING);
+    g_assert((((uint32_t *)mem)[4*8] & 0x3) == EP_RUNNING);
+}
+
 static void xhci_disable_device(XHCIQState *s)
 {
     int i;
@@ -477,6 +642,144 @@ static void xhci_disable_device(XHCIQState *s)
     guest_free(&s->parent->alloc, s->dc_base_array);
 }
 
+struct QEMU_PACKED usb_msd_cbw {
+    uint32_t sig;
+    uint32_t tag;
+    uint32_t data_len;
+    uint8_t flags;
+    uint8_t lun;
+    uint8_t cmd_len;
+    uint8_t cmd[16];
+};
+
+struct QEMU_PACKED usb_msd_csw {
+    uint32_t sig;
+    uint32_t tag;
+    uint32_t residue;
+    uint8_t status;
+};
+
+static ssize_t xhci_submit_scsi_cmd(XHCIQState *s,
+                                    const uint8_t *cmd, uint8_t cmd_len,
+                                    void *data, uint32_t data_len,
+                                    bool data_in)
+{
+    struct usb_msd_cbw cbw;
+    struct usb_msd_csw csw;
+    uint64_t trb_data;
+    XHCITRB trb;
+    uint64_t tag;
+
+    /* TRB data payload */
+    trb_data = xhci_guest_zalloc(s, data_len > sizeof(cbw) ? data_len : sizeof(cbw));
+
+    memset(&cbw, 0, sizeof(cbw));
+    cbw.sig = cpu_to_le32(0x43425355);
+    cbw.tag = cpu_to_le32(0);
+    cbw.data_len = cpu_to_le32(data_len);
+    cbw.flags = data_in ? 0x80 : 0x00;
+    cbw.lun = 0;
+    cbw.cmd_len = cmd_len; /* cmd len */
+    memcpy(cbw.cmd, cmd, cmd_len);
+    qtest_memwrite(s->parent->qts, trb_data, &cbw, sizeof(cbw));
+
+    /* Issue a transfer ring ep 3 data (out) */
+    memset(&trb, 0, TRB_SIZE);
+    trb.parameter = trb_data;
+    trb.status = sizeof(cbw);
+    trb.control |= TR_NORMAL << TRB_TYPE_SHIFT;
+    trb.control |= TRB_TR_IOC;
+    tag = submit_tr_trb(s, s->slotid, 3, &trb);
+    wait_event_trb(s, &trb);
+    g_assert_cmphex(trb.parameter, ==, tag);
+    g_assert_cmpint(TRB_TYPE(trb), ==, ER_TRANSFER);
+
+    if (data_in) {
+        g_assert(data_len);
+
+        /* Issue a transfer ring ep 2 data (in) */
+        memset(&trb, 0, TRB_SIZE);
+        trb.parameter = trb_data;
+        trb.status = data_len; /* data_len bytes, no more packets */
+        trb.control |= TR_NORMAL << TRB_TYPE_SHIFT;
+        trb.control |= TRB_TR_IOC;
+        tag = submit_tr_trb(s, s->slotid, 2, &trb);
+        wait_event_trb(s, &trb);
+        g_assert_cmphex(trb.parameter, ==, tag);
+        g_assert_cmpint(TRB_TYPE(trb), ==, ER_TRANSFER);
+
+        qtest_memread(s->parent->qts, trb_data, data, data_len);
+    } else if (data_len) {
+        qtest_memwrite(s->parent->qts, trb_data, data, data_len);
+
+        /* Issue a transfer ring ep 3 data (out) */
+        memset(&trb, 0, TRB_SIZE);
+        trb.parameter = trb_data;
+        trb.status = data_len; /* data_len bytes, no more packets */
+        trb.control |= TR_NORMAL << TRB_TYPE_SHIFT;
+        trb.control |= TRB_TR_IOC;
+        tag = submit_tr_trb(s, s->slotid, 3, &trb);
+        wait_event_trb(s, &trb);
+        g_assert_cmphex(trb.parameter, ==, tag);
+        g_assert_cmpint(TRB_TYPE(trb), ==, ER_TRANSFER);
+    } else {
+        /* No data */
+    }
+
+    /* Issue a transfer ring ep 2 data (in) */
+    memset(&trb, 0, TRB_SIZE);
+    trb.parameter = trb_data;
+    trb.status = sizeof(csw);
+    trb.control |= TR_NORMAL << TRB_TYPE_SHIFT;
+    trb.control |= TRB_TR_IOC;
+    tag = submit_tr_trb(s, s->slotid, 2, &trb);
+    wait_event_trb(s, &trb);
+    g_assert_cmphex(trb.parameter, ==, tag);
+    g_assert_cmpint(TRB_TYPE(trb), ==, ER_TRANSFER);
+
+    qtest_memread(s->parent->qts, trb_data, &csw, sizeof(csw));
+
+    guest_free(&s->parent->alloc, trb_data);
+
+    g_assert(csw.sig == cpu_to_le32(0x53425355));
+    g_assert(csw.tag == cpu_to_le32(0));
+    if (csw.status) {
+        return -1;
+    }
+    return data_len - le32_to_cpu(csw.residue); /* bytes copied */
+}
+
+#include "scsi/constants.h"
+
+static void xhci_test_msd(XHCIQState *s)
+{
+    uint8_t scsi_cmd[16];
+    g_autofree void *mem = g_malloc0(0x1000); /* buffer for writing to guest */
+
+    /* Clear SENSE data */
+    memset(scsi_cmd, 0, sizeof(scsi_cmd));
+    scsi_cmd[0] = INQUIRY;
+    if (xhci_submit_scsi_cmd(s, scsi_cmd, 6, mem, 0, false) < 0) {
+        g_assert_not_reached();
+    }
+
+    /* Report LUNs */
+    memset(scsi_cmd, 0, sizeof(scsi_cmd));
+    scsi_cmd[0] = REPORT_LUNS;
+    /* length in big-endian */
+    scsi_cmd[6] = 0x00;
+    scsi_cmd[7] = 0x00;
+    scsi_cmd[8] = 0x01;
+    scsi_cmd[9] = 0x00;
+
+    if (xhci_submit_scsi_cmd(s, scsi_cmd, 16, mem, 0x100, true) < 0) {
+        g_assert_not_reached();
+    }
+
+    /* Check REPORT_LUNS data found 1 LUN */
+    g_assert(((uint32_t *)mem)[0] == cpu_to_be32(8)); /* LUN List Length */
+}
+
 /*
  * This test brings up an endpoint and runs some noops through its command
  * ring and gets responses back on the event ring, then brings up a device
@@ -490,9 +793,18 @@ static void test_xhci_stress_rings(const void *arg)
     uint64_t tag;
     int i;
 
-    s = xhci_boot("-M q35 "
-                  "-device %s,id=xhci,bus=pcie.0,addr=1d.0 ",
-                  td->device);
+    if (qtest_has_device("usb-storage")) {
+        s = xhci_boot("-M q35 "
+                "-device %s,id=xhci,bus=pcie.0,addr=1d.0 "
+                "-device usb-storage,bus=xhci.0,drive=drive0 "
+                "-drive id=drive0,if=none,file=null-co://,"
+                    "file.read-zeroes=on,format=raw ",
+                td->device);
+    } else {
+        s = xhci_boot("-M q35 "
+                "-device %s,id=xhci,bus=pcie.0,addr=1d.0 ",
+                td->device);
+    }
     g_assert_cmphex(s->fingerprint, ==, td->fingerprint);
 
     xhci_enable_device(s);
@@ -513,6 +825,34 @@ static void test_xhci_stress_rings(const void *arg)
     xhci_shutdown(s);
 }
 
+/*
+ * This test brings up a USB MSD endpoint and runs MSD (SCSI) commands.
+ */
+static void test_usb_msd(const void *arg)
+{
+    const TestData *td = arg;
+    XHCIQState *s;
+
+    s = xhci_boot("-M q35 "
+            "-device %s,id=xhci,bus=pcie.0,addr=1d.0 "
+            "-device usb-storage,bus=xhci.0,drive=drive0 "
+            "-drive id=drive0,if=none,file=null-co://,"
+                "file.read-zeroes=on,format=raw ",
+            td->device);
+    g_assert_cmphex(s->fingerprint, ==, td->fingerprint);
+
+    xhci_enable_device(s);
+
+    xhci_enable_slot(s);
+
+    xhci_enable_msd_bulk_endpoints(s);
+
+    xhci_test_msd(s);
+
+    xhci_disable_device(s);
+    xhci_shutdown(s);
+}
+
 static void add_test(const char *name, TestData *td, void (*fn)(const void *))
 {
     g_autofree char *full_name = g_strdup_printf(
@@ -530,6 +870,9 @@ static void add_tests(TestData *td)
         add_test("usb-ccid", td, test_usb_ccid_hotplug);
     }
     add_test("xhci-stress-rings", td, test_xhci_stress_rings);
+    if (qtest_has_device("usb-storage")) {
+        add_test("usb-msd", td, test_usb_msd);
+    }
 }
 
 /* tests */
-- 
2.47.1


