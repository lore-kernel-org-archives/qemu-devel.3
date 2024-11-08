Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3DED5C0F0
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9R8V-0002JW-LP; Fri, 08 Nov 2024 10:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9R8U-0002JM-VO
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:42:58 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9R8S-0005I7-45
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:42:58 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-720c2db824eso2447710b3a.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731080574; x=1731685374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SceYCbCcY2IaNyvN5s9PaHH9tnhvxAvk7SxOm3Prwj0=;
 b=UakeVkK7djN7xOgtEJ65PCZ7XoL7OkgTR7g31qNDjMjb5UiiQytTkFlj0AhkRGvww0
 K5Mqh624tS40UwRA+/q5ocaPF46BYeQTHG/hGk12n2/Lt7Z29EqVpU7QTu53+uuCawFd
 UBhiYiMz2wDKESY+r0nggj0hlCfg4+mmTDpFSw9aUf/vF59/Ky9lUDITcn6xjlqOMMJl
 XAhgJy1OcRP8cPYQod4CgAB0urH0SbUmUfEjy9tAXHe5SE4NlrFA75vp3VQcr7McHYZS
 2m/yU3v5koHVIt4CpUMYf+bi1QuUnoOP3lAeXII2eAcB1zH92W3LJx5wAGj/LYtDt21x
 zyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080574; x=1731685374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SceYCbCcY2IaNyvN5s9PaHH9tnhvxAvk7SxOm3Prwj0=;
 b=JsjXVPD0FevTU29o1f6ovCUqQKDwmkKcRWcdZVqJTkB4233Uv6ONxtYSN00T6URVS7
 HRYU+v0bgvDIMutEgA6r3tBbLbMUVsykjy5rLzQvIcN7tjuLa1P8LAPob12Yd48TIUq7
 yGbD4XlbE6hk4OZmcxX7eA/TgRwjxoC+49tx5W1+4NambXYezEAkYeJ79i3tALr/Ould
 t679VBMU1l/qWLcKSEuCtELgwIXrNP4m3iTa0ZmTXXPsY0DfQ0i/U8Itj7k1P/9gFJLW
 Yf08Wo76ys3RT+ifr218ZOrjb7YzPiIMgRF5Y5KsXzcHUYjU6hbP+yMVjf/o4Mq3Sq1a
 IkPQ==
X-Gm-Message-State: AOJu0Yw2v12b3CpNZmvlh0FVVTw5sjDur2uheWVU23E2RjWHjUuPskHW
 +L9tQBmHJS7/akNqLFYul3nGFfIKOPQaf/qGSpmz+RunSLpGomNoADhFRw==
X-Google-Smtp-Source: AGHT+IE+j/xh9XiiMFOjlZOfYaGAfK+yx4v5IGKimnDwPCC900vVgGnhRGyzUuq6Tsu++1TkLBkTbA==
X-Received: by 2002:a05:6a00:198a:b0:71e:692e:7afb with SMTP id
 d2e1a72fcca58-7241325f64amr4126535b3a.5.1731080574044; 
 Fri, 08 Nov 2024 07:42:54 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f48d32bsm3110444a12.17.2024.11.08.07.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:42:53 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH 4/5] qtest/xhci: Add controller and device setup and ring
 tests
Date: Sat,  9 Nov 2024 01:42:27 +1000
Message-ID: <20241108154229.263097-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154229.263097-1-npiggin@gmail.com>
References: <20241108154229.263097-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

Add tests which init the host controller registers to the point
where command and event rings, irqs are operational. Enumerate
ports and set up an attached device context that enables device
transfer ring to be set up and tested.

This test does a bunch of things at once and is yet well
librified, but it allows testing basic mechanisms and gives a
starting point for further work.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/usb-hcd-xhci-test.h | 232 +++++++++++++++
 tests/qtest/usb-hcd-xhci-test.c | 506 +++++++++++++++++++++++++++++++-
 2 files changed, 732 insertions(+), 6 deletions(-)
 create mode 100644 tests/qtest/usb-hcd-xhci-test.h

diff --git a/tests/qtest/usb-hcd-xhci-test.h b/tests/qtest/usb-hcd-xhci-test.h
new file mode 100644
index 0000000000..88d65b4f7e
--- /dev/null
+++ b/tests/qtest/usb-hcd-xhci-test.h
@@ -0,0 +1,232 @@
+#ifndef TESTS_USB_HCD_XHCI_H
+#define TESTS_USB_HCD_XHCI_H
+
+typedef enum TRBType {
+    TRB_RESERVED = 0,
+    TR_NORMAL,
+    TR_SETUP,
+    TR_DATA,
+    TR_STATUS,
+    TR_ISOCH,
+    TR_LINK,
+    TR_EVDATA,
+    TR_NOOP,
+    CR_ENABLE_SLOT,
+    CR_DISABLE_SLOT,
+    CR_ADDRESS_DEVICE,
+    CR_CONFIGURE_ENDPOINT,
+    CR_EVALUATE_CONTEXT,
+    CR_RESET_ENDPOINT,
+    CR_STOP_ENDPOINT,
+    CR_SET_TR_DEQUEUE,
+    CR_RESET_DEVICE,
+    CR_FORCE_EVENT,
+    CR_NEGOTIATE_BW,
+    CR_SET_LATENCY_TOLERANCE,
+    CR_GET_PORT_BANDWIDTH,
+    CR_FORCE_HEADER,
+    CR_NOOP,
+    ER_TRANSFER = 32,
+    ER_COMMAND_COMPLETE,
+    ER_PORT_STATUS_CHANGE,
+    ER_BANDWIDTH_REQUEST,
+    ER_DOORBELL,
+    ER_HOST_CONTROLLER,
+    ER_DEVICE_NOTIFICATION,
+    ER_MFINDEX_WRAP,
+    /* vendor specific bits */
+    CR_VENDOR_NEC_FIRMWARE_REVISION  = 49,
+    CR_VENDOR_NEC_CHALLENGE_RESPONSE = 50,
+} TRBType;
+
+typedef enum TRBCCode {
+    CC_INVALID = 0,
+    CC_SUCCESS,
+    CC_DATA_BUFFER_ERROR,
+    CC_BABBLE_DETECTED,
+    CC_USB_TRANSACTION_ERROR,
+    CC_TRB_ERROR,
+    CC_STALL_ERROR,
+    CC_RESOURCE_ERROR,
+    CC_BANDWIDTH_ERROR,
+    CC_NO_SLOTS_ERROR,
+    CC_INVALID_STREAM_TYPE_ERROR,
+    CC_SLOT_NOT_ENABLED_ERROR,
+    CC_EP_NOT_ENABLED_ERROR,
+    CC_SHORT_PACKET,
+    CC_RING_UNDERRUN,
+    CC_RING_OVERRUN,
+    CC_VF_ER_FULL,
+    CC_PARAMETER_ERROR,
+    CC_BANDWIDTH_OVERRUN,
+    CC_CONTEXT_STATE_ERROR,
+    CC_NO_PING_RESPONSE_ERROR,
+    CC_EVENT_RING_FULL_ERROR,
+    CC_INCOMPATIBLE_DEVICE_ERROR,
+    CC_MISSED_SERVICE_ERROR,
+    CC_COMMAND_RING_STOPPED,
+    CC_COMMAND_ABORTED,
+    CC_STOPPED,
+    CC_STOPPED_LENGTH_INVALID,
+    CC_MAX_EXIT_LATENCY_TOO_LARGE_ERROR = 29,
+    CC_ISOCH_BUFFER_OVERRUN = 31,
+    CC_EVENT_LOST_ERROR,
+    CC_UNDEFINED_ERROR,
+    CC_INVALID_STREAM_ID_ERROR,
+    CC_SECONDARY_BANDWIDTH_ERROR,
+    CC_SPLIT_TRANSACTION_ERROR
+} TRBCCode;
+
+/* bit definitions */
+#define USBCMD_RS       (1<<0)
+#define USBCMD_HCRST    (1<<1)
+#define USBCMD_INTE     (1<<2)
+#define USBCMD_HSEE     (1<<3)
+#define USBCMD_LHCRST   (1<<7)
+#define USBCMD_CSS      (1<<8)
+#define USBCMD_CRS      (1<<9)
+#define USBCMD_EWE      (1<<10)
+#define USBCMD_EU3S     (1<<11)
+
+#define USBSTS_HCH      (1<<0)
+#define USBSTS_HSE      (1<<2)
+#define USBSTS_EINT     (1<<3)
+#define USBSTS_PCD      (1<<4)
+#define USBSTS_SSS      (1<<8)
+#define USBSTS_RSS      (1<<9)
+#define USBSTS_SRE      (1<<10)
+#define USBSTS_CNR      (1<<11)
+#define USBSTS_HCE      (1<<12)
+
+
+#define PORTSC_CCS          (1<<0)
+#define PORTSC_PED          (1<<1)
+#define PORTSC_OCA          (1<<3)
+#define PORTSC_PR           (1<<4)
+#define PORTSC_PLS_SHIFT        5
+#define PORTSC_PLS_MASK     0xf
+#define PORTSC_PP           (1<<9)
+#define PORTSC_SPEED_SHIFT      10
+#define PORTSC_SPEED_MASK   0xf
+#define PORTSC_SPEED_FULL   (1<<10)
+#define PORTSC_SPEED_LOW    (2<<10)
+#define PORTSC_SPEED_HIGH   (3<<10)
+#define PORTSC_SPEED_SUPER  (4<<10)
+#define PORTSC_PIC_SHIFT        14
+#define PORTSC_PIC_MASK     0x3
+#define PORTSC_LWS          (1<<16)
+#define PORTSC_CSC          (1<<17)
+#define PORTSC_PEC          (1<<18)
+#define PORTSC_WRC          (1<<19)
+#define PORTSC_OCC          (1<<20)
+#define PORTSC_PRC          (1<<21)
+#define PORTSC_PLC          (1<<22)
+#define PORTSC_CEC          (1<<23)
+#define PORTSC_CAS          (1<<24)
+#define PORTSC_WCE          (1<<25)
+#define PORTSC_WDE          (1<<26)
+#define PORTSC_WOE          (1<<27)
+#define PORTSC_DR           (1<<30)
+#define PORTSC_WPR          (1<<31)
+
+#define CRCR_RCS        (1<<0)
+#define CRCR_CS         (1<<1)
+#define CRCR_CA         (1<<2)
+#define CRCR_CRR        (1<<3)
+
+#define IMAN_IP         (1<<0)
+#define IMAN_IE         (1<<1)
+
+#define ERDP_EHB        (1<<3)
+
+#define TRB_SIZE 16
+
+enum {
+    PLS_U0              =  0,
+    PLS_U1              =  1,
+    PLS_U2              =  2,
+    PLS_U3              =  3,
+    PLS_DISABLED        =  4,
+    PLS_RX_DETECT       =  5,
+    PLS_INACTIVE        =  6,
+    PLS_POLLING         =  7,
+    PLS_RECOVERY        =  8,
+    PLS_HOT_RESET       =  9,
+    PLS_COMPILANCE_MODE = 10,
+    PLS_TEST_MODE       = 11,
+    PLS_RESUME          = 15,
+};
+
+#define CR_LINK TR_LINK
+
+#define TRB_C               (1<<0)
+#define TRB_TYPE_SHIFT          10
+#define TRB_TYPE_MASK       0x3f
+#define TRB_TYPE(t)         (((t).control >> TRB_TYPE_SHIFT) & TRB_TYPE_MASK)
+
+#define TRB_EV_ED           (1<<2)
+
+#define TRB_TR_ENT          (1<<1)
+#define TRB_TR_ISP          (1<<2)
+#define TRB_TR_NS           (1<<3)
+#define TRB_TR_CH           (1<<4)
+#define TRB_TR_IOC          (1<<5)
+#define TRB_TR_IDT          (1<<6)
+#define TRB_TR_TBC_SHIFT        7
+#define TRB_TR_TBC_MASK     0x3
+#define TRB_TR_BEI          (1<<9)
+#define TRB_TR_TLBPC_SHIFT      16
+#define TRB_TR_TLBPC_MASK   0xf
+#define TRB_TR_FRAMEID_SHIFT    20
+#define TRB_TR_FRAMEID_MASK 0x7ff
+#define TRB_TR_SIA          (1<<31)
+
+#define TRB_TR_DIR          (1<<16)
+
+#define TRB_CR_SLOTID_SHIFT     24
+#define TRB_CR_SLOTID_MASK  0xff
+#define TRB_CR_EPID_SHIFT       16
+#define TRB_CR_EPID_MASK    0x1f
+
+#define TRB_CR_BSR          (1<<9)
+#define TRB_CR_DC           (1<<9)
+
+#define TRB_LK_TC           (1<<1)
+
+#define TRB_INTR_SHIFT          22
+#define TRB_INTR_MASK       0x3ff
+#define TRB_INTR(t)         (((t).status >> TRB_INTR_SHIFT) & TRB_INTR_MASK)
+
+#define EP_TYPE_MASK        0x7
+#define EP_TYPE_SHIFT           3
+
+#define EP_STATE_MASK       0x7
+#define EP_DISABLED         (0<<0)
+#define EP_RUNNING          (1<<0)
+#define EP_HALTED           (2<<0)
+#define EP_STOPPED          (3<<0)
+#define EP_ERROR            (4<<0)
+
+#define SLOT_STATE_MASK     0x1f
+#define SLOT_STATE_SHIFT        27
+#define SLOT_STATE(s)       (((s)>>SLOT_STATE_SHIFT)&SLOT_STATE_MASK)
+#define SLOT_ENABLED        0
+#define SLOT_DEFAULT        1
+#define SLOT_ADDRESSED      2
+#define SLOT_CONFIGURED     3
+
+#define SLOT_CONTEXT_ENTRIES_MASK 0x1f
+#define SLOT_CONTEXT_ENTRIES_SHIFT 27
+
+typedef enum EPType {
+    ET_INVALID = 0,
+    ET_ISO_OUT,
+    ET_BULK_OUT,
+    ET_INTR_OUT,
+    ET_CONTROL,
+    ET_ISO_IN,
+    ET_BULK_IN,
+    ET_INTR_IN,
+} EPType;
+
+#endif /* TESTS_USB_HCD_XHCI_H */
diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 0cccfd85a6..d66e76f070 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -8,17 +8,188 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "libqtest.h"
+#include "libqos/libqos-pc.h"
 #include "libqtest-single.h"
 #include "libqos/usb.h"
+#include "hw/pci/pci_ids.h"
+#include "hw/pci/pci_regs.h"
+#include "usb-hcd-xhci-test.h"
+
+/*** Test Setup & Teardown ***/
+typedef struct XHCIEvRingSeg {
+    uint32_t addr_low;
+    uint32_t addr_high;
+    uint32_t size;
+    uint32_t rsvd;
+} XHCIEvRingSeg;
+
+typedef struct XHCITRB {
+    uint64_t parameter;
+    uint32_t status;
+    uint32_t control;
+} XHCITRB;
+
+typedef struct XHCIQSlotState {
+    /* In-memory arrays */
+    uint64_t device_context;
+    uint64_t transfer_ring;
+
+    uint32_t tr_trb_entries;
+    uint32_t tr_trb_idx;
+    uint32_t tr_trb_c;
+} XHCIQSlotState;
+
+typedef struct XHCIQState {
+    /* QEMU PCI variables */
+    QOSState *parent;
+    QPCIDevice *dev;
+    QPCIBar bar;
+    uint64_t barsize;
+    uint32_t fingerprint;
+
+    /* In-memory arrays */
+    uint64_t dc_base_array;
+    uint64_t command_ring;
+    uint64_t event_ring_seg;
+    uint64_t event_ring;
+
+    uint32_t cr_trb_entries;
+    uint32_t cr_trb_idx;
+    uint32_t cr_trb_c;
+    uint32_t er_trb_entries;
+    uint32_t er_trb_idx;
+    uint32_t er_trb_c;
+
+    /* Host controller properties */
+    uint32_t rtoff, dboff;
+    uint32_t maxports, maxslots, maxintrs;
+
+    XHCIQSlotState slots[32];
+} XHCIQState;
+
+#define XHCI_NEC_ID (PCI_DEVICE_ID_NEC_UPD720200 << 16 | \
+                     PCI_VENDOR_ID_NEC)
+
+/**
+ * Locate, verify, and return a handle to the XHCI device.
+ */
+static QPCIDevice *get_xhci_device(QTestState *qts, uint32_t *fingerprint)
+{
+    QPCIDevice *xhci;
+    uint32_t xhci_fingerprint;
+    QPCIBus *pcibus;
+
+    pcibus = qpci_new_pc(qts, NULL);
+
+    /* Find the XHCI PCI device and verify it's the right one. */
+    xhci = qpci_device_find(pcibus, QPCI_DEVFN(0x1D, 0x0));
+    g_assert(xhci != NULL);
+
+    xhci_fingerprint = qpci_config_readl(xhci, PCI_VENDOR_ID);
+    switch (xhci_fingerprint) {
+    case XHCI_NEC_ID:
+        break;
+    default:
+        /* Unknown device. */
+        g_assert_not_reached();
+    }
+
+    if (fingerprint) {
+        *fingerprint = xhci_fingerprint;
+    }
+    return xhci;
+}
+
+static void free_xhci_device(QPCIDevice *dev)
+{
+    QPCIBus *pcibus = dev ? dev->bus : NULL;
+
+    /* libqos doesn't have a function for this, so free it manually */
+    g_free(dev);
+    qpci_free_pc(pcibus);
+}
+
+/**
+ * Start a Q35 machine and bookmark a handle to the XHCI device.
+ */
+G_GNUC_PRINTF(1, 0)
+static XHCIQState *xhci_vboot(const char *cli, va_list ap)
+{
+    XHCIQState *s;
+
+    s = g_new0(XHCIQState, 1);
+    s->parent = qtest_pc_vboot(cli, ap);
+    alloc_set_flags(&s->parent->alloc, ALLOC_LEAK_ASSERT);
+
+    /* Verify that we have an XHCI device present. */
+    s->dev = get_xhci_device(s->parent->qts, &s->fingerprint);
+    s->bar = qpci_iomap(s->dev, 0, &s->barsize);
+    /* turns on pci.cmd.iose, pci.cmd.mse and pci.cmd.bme */
+    qpci_device_enable(s->dev);
+
+    return s;
+}
+
+/**
+ * Start a Q35 machine and bookmark a handle to the XHCI device.
+ */
+G_GNUC_PRINTF(1, 2)
+static XHCIQState *xhci_boot(const char *cli, ...)
+{
+    XHCIQState *s;
+    va_list ap;
+
+    if (cli) {
+        va_start(ap, cli);
+        s = xhci_vboot(cli, ap);
+        va_end(ap);
+    } else {
+        s = xhci_boot("-M q35 "
+                      "-device nec-usb-xhci,id=xhci,bus=pcie.0,addr=1d.0 "
+                      "-drive id=drive0,if=none,file=null-co://,"
+                          "file.read-zeroes=on,format=raw");
+    }
+
+    return s;
+}
+
+/**
+ * Clean up the PCI device, then terminate the QEMU instance.
+ */
+static void xhci_shutdown(XHCIQState *xhci)
+{
+    QOSState *qs = xhci->parent;
+
+//    xhci_clean_mem(xhci);
+    free_xhci_device(xhci->dev);
+    g_free(xhci);
+    qtest_shutdown(qs);
+}
+
+/*** tests ***/
 
 static void test_xhci_hotplug(void)
 {
-    usb_test_hotplug(global_qtest, "xhci", "1", NULL);
+    XHCIQState *s;
+    QTestState *qts;
+
+    s = xhci_boot(NULL);
+    qts = s->parent->qts;
+
+    usb_test_hotplug(qts, "xhci", "1", NULL);
+
+    xhci_shutdown(s);
 }
 
 static void test_usb_uas_hotplug(void)
 {
-    QTestState *qts = global_qtest;
+    XHCIQState *s;
+    QTestState *qts;
+
+    s = xhci_boot(NULL);
+    qts = s->parent->qts;
 
     qtest_qmp_device_add(qts, "usb-uas", "uas", "{}");
     qtest_qmp_device_add(qts, "scsi-hd", "scsihd", "{'drive': 'drive0'}");
@@ -30,25 +201,347 @@ static void test_usb_uas_hotplug(void)
 
     qtest_qmp_device_del(qts, "scsihd");
     qtest_qmp_device_del(qts, "uas");
+
+    xhci_shutdown(s);
 }
 
 static void test_usb_ccid_hotplug(void)
 {
-    QTestState *qts = global_qtest;
+    XHCIQState *s;
+    QTestState *qts;
+
+    s = xhci_boot(NULL);
+    qts = s->parent->qts;
 
     qtest_qmp_device_add(qts, "usb-ccid", "ccid", "{}");
     qtest_qmp_device_del(qts, "ccid");
     /* check the device can be added again */
     qtest_qmp_device_add(qts, "usb-ccid", "ccid", "{}");
     qtest_qmp_device_del(qts, "ccid");
+
+    xhci_shutdown(s);
+}
+
+static uint64_t xhci_guest_zalloc(XHCIQState *s, uint64_t size)
+{
+    char mem[0x1000];
+    uint64_t ret;
+
+    g_assert(size <= 0x1000);
+
+    memset(mem, 0, size);
+
+    ret = guest_alloc(&s->parent->alloc, size);
+    qtest_memwrite(s->parent->qts, ret, mem, size);
+
+    return ret;
+}
+
+static uint32_t xhci_cap_readl(XHCIQState *s, uint64_t addr)
+{
+    return qpci_io_readl(s->dev, s->bar, addr);
+}
+
+static uint32_t xhci_op_readl(XHCIQState *s, uint64_t addr)
+{
+    return qpci_io_readl(s->dev, s->bar, 0x40 + addr);
+}
+
+static void xhci_op_writel(XHCIQState *s, uint64_t addr, uint32_t value)
+{
+    qpci_io_writel(s->dev, s->bar, 0x40 + addr, value);
+}
+
+static uint32_t xhci_port_readl(XHCIQState *s, uint32_t port, uint64_t addr)
+{
+    return xhci_op_readl(s, 0x400 + port * 0x10 + addr);
+}
+
+static uint32_t xhci_rt_readl(XHCIQState *s, uint64_t addr)
+{
+    return qpci_io_readl(s->dev, s->bar, s->rtoff + addr);
+}
+
+static void xhci_rt_writel(XHCIQState *s, uint64_t addr, uint32_t value)
+{
+    qpci_io_writel(s->dev, s->bar, s->rtoff + addr, value);
+}
+
+static void xhci_db_writel(XHCIQState *s, uint32_t db, uint32_t value)
+{
+    qpci_io_writel(s->dev, s->bar, s->dboff + db * 4, value);
+}
+
+static void wait_event_trb(XHCIQState *s, XHCITRB *trb)
+{
+    XHCITRB t;
+    uint64_t er_addr = s->event_ring + s->er_trb_idx * sizeof(*trb);
+    uint32_t value;
+    guint64 end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+
+    /* Wait for event interrupt  */
+
+    do {
+        if (g_get_monotonic_time() >= end_time) {
+            g_error("Timeout expired");
+        }
+        qtest_clock_step(s->parent->qts, 10000);
+
+        value = xhci_op_readl(s, 0x4); /* USBSTS */
+    } while (!(value & USBSTS_EINT));
+
+    value = xhci_rt_readl(s, 0x20 + 0x0); /* IMAN */
+
+    /* With MSI-X enabled, IMAN IP is cleared after raising the interrupt */
+    g_assert(!(value & IMAN_IP));
+
+    /* Ensure MSI-X interrupt is pending */
+    assert(qpci_msix_test_clear_pending(s->dev, 0));
+    /* Then cleared */
+    assert(!qpci_msix_pending(s->dev, 0));
+
+    xhci_op_writel(s, 0x4, USBSTS_EINT); /* USBSTS clear EINT */
+
+    qtest_memread(s->parent->qts, er_addr, &t, sizeof(t));
+
+    trb->parameter = le64_to_cpu(t.parameter);
+    trb->status = le32_to_cpu(t.status);
+    trb->control = le32_to_cpu(t.control);
+
+    g_assert((trb->status >> 24) == CC_SUCCESS);
+    g_assert((trb->control & TRB_C) == s->er_trb_c); /* C bit has been set */
+
+    s->er_trb_idx++;
+    if (s->er_trb_idx == s->er_trb_entries) {
+        s->er_trb_idx = 0;
+        s->er_trb_c ^= 1;
+    }
+    /* Update ERDP to processed TRB addr and EHB bit, which clears EHB */
+    er_addr = s->event_ring + s->er_trb_idx * sizeof(*trb);
+    xhci_rt_writel(s, 0x38, (er_addr & 0xffffffff) | ERDP_EHB);
+}
+
+static void set_link_trb(XHCIQState *s, uint64_t ring, uint32_t c, uint32_t entries)
+{
+    XHCITRB trb;
+
+    g_assert(entries > 1);
+
+    memset(&trb, 0, sizeof(trb));
+    trb.parameter = cpu_to_le64(ring);
+    trb.control = cpu_to_le32(c | /* C */
+                              (TR_LINK << TRB_TYPE_SHIFT) |
+                              TRB_LK_TC);
+    qtest_memwrite(s->parent->qts, ring + sizeof(trb) * (entries - 1), &trb, sizeof(trb));
 }
 
+static void submit_cr_trb(XHCIQState *s, XHCITRB *trb)
+{
+    XHCITRB t;
+    uint64_t cr_addr = s->command_ring + s->cr_trb_idx * sizeof(*trb);
+
+    trb->control |= s->cr_trb_c; /* C */
+
+    t.parameter = cpu_to_le64(trb->parameter);
+    t.status = cpu_to_le32(trb->status);
+    t.control = cpu_to_le32(trb->control);
+
+    qtest_memwrite(s->parent->qts, cr_addr, &t, sizeof(t));
+    s->cr_trb_idx++;
+    /* Last entry contains the link, so wrap back */
+    if (s->cr_trb_idx == s->cr_trb_entries - 1) {
+        set_link_trb(s, s->command_ring, s->cr_trb_c, s->cr_trb_entries);
+        s->cr_trb_idx = 0;
+        s->cr_trb_c ^= 1;
+    }
+    xhci_db_writel(s, 0, 0); /* doorbell 0 */
+}
+
+static void pci_xhci_stress_rings(void)
+{
+    XHCIQState *s;
+    uint32_t value;
+    uint64_t input_context;
+    XHCIEvRingSeg ev_seg;
+    XHCITRB trb;
+    uint32_t hcsparams1;
+    uint32_t slotid;
+    void *mem;
+    int i;
+
+    mem = g_malloc(0x1000);
+    memset(mem, 0, 0x1000);
+
+    s = xhci_boot("-M q35 "
+            "-device nec-usb-xhci,id=xhci,bus=pcie.0,addr=1d.0 "
+            "-device usb-storage,bus=xhci.0,drive=drive0 "
+            "-drive id=drive0,if=none,file=null-co://,"
+                "file.read-zeroes=on,format=raw "
+            );
+//            "-d trace:*xhci*,trace:*usb*,trace:*msi*");
+
+    hcsparams1 = xhci_cap_readl(s, 0x4); /* HCSPARAMS1 */
+    s->maxports = (hcsparams1 >> 24) & 0xff;
+    s->maxintrs = (hcsparams1 >> 8) & 0x3ff;
+    s->maxslots = hcsparams1 & 0xff;
+
+    s->dboff = xhci_cap_readl(s, 0x14); /* DBOFF */
+    s->rtoff = xhci_cap_readl(s, 0x18); /* RTOFF */
+
+    s->dc_base_array = xhci_guest_zalloc(s, 0x800);
+    s->command_ring = xhci_guest_zalloc(s, 0x1000);
+    s->event_ring = xhci_guest_zalloc(s, 0x1000);
+    s->event_ring_seg = xhci_guest_zalloc(s, 0x100);
+
+    /* Arbitrary small sizes so we can make them wrap */
+    s->cr_trb_entries = 0x20;
+    s->cr_trb_c = 1;
+    s->er_trb_entries = 0x10;
+    s->er_trb_c = 1;
+
+    ev_seg.addr_low = cpu_to_le32(s->event_ring & 0xffffffff);
+    ev_seg.addr_high = cpu_to_le32(s->event_ring >> 32);
+    ev_seg.size = cpu_to_le32(0x10);
+    ev_seg.rsvd = 0;
+    qtest_memwrite(s->parent->qts, s->event_ring_seg, &ev_seg, sizeof(ev_seg));
+
+    xhci_op_writel(s, 0x0, USBCMD_HCRST); /* USBCMD */
+    do {
+        value = xhci_op_readl(s, 0x4); /* USBSTS */
+    } while (value & (1 << 11)); /* CNR */
+
+    xhci_op_writel(s, 0x38, s->maxslots); /* CONFIG */
+
+    /* DCBAAP */
+    xhci_op_writel(s, 0x30, s->dc_base_array & 0xffffffff);
+    xhci_op_writel(s, 0x34, s->dc_base_array >> 32);
+
+    /* CRCR */
+    xhci_op_writel(s, 0x18, (s->command_ring & 0xffffffff) | s->cr_trb_c);
+    xhci_op_writel(s, 0x1c, s->command_ring >> 32);
+
+    xhci_rt_writel(s, 0x28, 1); /* ERSTSZ */
+
+    /* ERSTBA */
+    xhci_rt_writel(s, 0x30, s->event_ring_seg & 0xffffffff);
+    xhci_rt_writel(s, 0x34, s->event_ring_seg >> 32);
+
+    /* ERDP */
+    xhci_rt_writel(s, 0x38, s->event_ring & 0xffffffff);
+    xhci_rt_writel(s, 0x3c, s->event_ring >> 32);
+
+    qpci_msix_enable(s->dev);
+    xhci_op_writel(s, 0x0, USBCMD_RS | USBCMD_INTE); /* RUN + INTE */
+
+    /* Enable interrupts on ER IMAN */
+    xhci_rt_writel(s, 0x20, IMAN_IE);
+
+    assert(!qpci_msix_pending(s->dev, 0));
+
+    /* Wrap the command and event rings with no-ops a few times */
+    for (i = 0; i < 100; i++) {
+        /* Issue a command ring no-op */
+        memset(&trb, 0, sizeof(trb));
+        trb.control |= CR_NOOP << TRB_TYPE_SHIFT;
+        trb.control |= TRB_TR_IOC;
+        submit_cr_trb(s, &trb);
+        wait_event_trb(s, &trb);
+    }
+
+    /* Query ports */
+    for (i = 0; i < s->maxports; i++) {
+        value = xhci_port_readl(s, i, 0); /* PORTSC */
+
+        /* Only first port should be attached and enabled */
+        if (i == 0) {
+            g_assert(value & PORTSC_CCS);
+            g_assert(value & PORTSC_PED);
+	    /* Port Speed must be identified */
+	    g_assert(((value >> PORTSC_SPEED_SHIFT) & PORTSC_SPEED_MASK) != 0);
+        } else {
+            g_assert(!(value & PORTSC_CCS));
+            g_assert(!(value & PORTSC_PED));
+            g_assert(((value >> PORTSC_PLS_SHIFT) & PORTSC_PLS_MASK) == 5);
+        }
+    }
+
+    /* Issue a command ring enable slot */
+    memset(&trb, 0, sizeof(trb));
+    trb.control |= CR_ENABLE_SLOT << TRB_TYPE_SHIFT;
+    trb.control |= TRB_TR_IOC;
+    submit_cr_trb(s, &trb);
+    wait_event_trb(s, &trb);
+    slotid = (trb.control >> TRB_CR_SLOTID_SHIFT) & 0xff;
+
+    s->slots[slotid].transfer_ring = xhci_guest_zalloc(s, 0x1000);
+    s->slots[slotid].tr_trb_entries = 0x10;
+    s->slots[slotid].tr_trb_c = 1;
+
+    /* 32-byte input context size, should check HCCPARAMS1 for 64-byte size */
+    input_context = xhci_guest_zalloc(s, 0x420);
+
+    /* Set input control context */
+    ((uint32_t *)mem)[1] = cpu_to_le32(0x3); /* Add device contexts 0 and 1 */
+    ((uint32_t *)mem)[8] = cpu_to_le32(1 << 27); /* 1 context entry */
+    ((uint32_t *)mem)[9] = cpu_to_le32(1 << 16); /* 1 port number */
+
+    /* Set endpoint 0 context */
+    ((uint32_t *)mem)[16] = 0;
+    ((uint32_t *)mem)[17] = cpu_to_le32((ET_CONTROL << EP_TYPE_SHIFT) |
+                                        (0x200 << 16)); /* max packet sz XXX? */
+    ((uint32_t *)mem)[18] = cpu_to_le32((s->slots[slotid].transfer_ring & 0xffffffff) | 1); /* DCS=1 */
+    ((uint32_t *)mem)[19] = cpu_to_le32(s->slots[slotid].transfer_ring >> 32);
+    ((uint32_t *)mem)[20] = cpu_to_le32(0x200); /* Average TRB length */
+    qtest_memwrite(s->parent->qts, input_context, mem, 0x420);
+
+    s->slots[slotid].device_context = xhci_guest_zalloc(s, 0x400);
+
+    ((uint64_t *)mem)[0] = cpu_to_le64(s->slots[slotid].device_context);
+    qtest_memwrite(s->parent->qts, s->dc_base_array + 8*slotid, mem, 8);
+
+    /* Issue a command ring address device */
+    memset(&trb, 0, sizeof(trb));
+    trb.parameter = input_context;
+    trb.control |= CR_ADDRESS_DEVICE << TRB_TYPE_SHIFT;
+    trb.control |= slotid << TRB_CR_SLOTID_SHIFT;
+    submit_cr_trb(s, &trb);
+    wait_event_trb(s, &trb);
+
+    /* XXX: Check EP state is running? */
+
+    /* Shut it down */
+    qpci_msix_disable(s->dev);
+
+    guest_free(&s->parent->alloc, s->slots[slotid].device_context);
+    guest_free(&s->parent->alloc, s->slots[slotid].transfer_ring);
+    guest_free(&s->parent->alloc, input_context);
+    guest_free(&s->parent->alloc, s->event_ring);
+    guest_free(&s->parent->alloc, s->event_ring_seg);
+    guest_free(&s->parent->alloc, s->command_ring);
+    guest_free(&s->parent->alloc, s->dc_base_array);
+
+    xhci_shutdown(s);
+}
+
+/* tests */
 int main(int argc, char **argv)
 {
     int ret;
+    const char *arch;
 
     g_test_init(&argc, &argv, NULL);
 
+    /* Check architecture */
+    arch = qtest_get_arch();
+    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
+        g_test_message("Skipping test for non-x86");
+        return 0;
+    }
+
+    if (!qtest_has_device("nec-usb-xhci")) {
+        return 0;
+    }
+
     qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
     if (qtest_has_device("usb-uas")) {
         qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);
@@ -56,11 +549,12 @@ int main(int argc, char **argv)
     if (qtest_has_device("usb-ccid")) {
         qtest_add_func("/xhci/pci/hotplug/usb-ccid", test_usb_ccid_hotplug);
     }
+    if (qtest_has_device("usb-storage")) {
+        qtest_add_func("/xhci/pci/xhci-stress-rings", pci_xhci_stress_rings);
+    }
 
-    qtest_start("-device nec-usb-xhci,id=xhci"
-                " -drive id=drive0,if=none,file=null-co://,"
-                "file.read-zeroes=on,format=raw");
     ret = g_test_run();
+
     qtest_end();
 
     return ret;
-- 
2.45.2


