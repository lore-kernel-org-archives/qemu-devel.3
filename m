Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36236E77184
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu1d-0006Nh-BD; Sun, 15 Dec 2024 14:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu07-00041G-JX
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:59 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu04-0001Y0-Nb
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:59 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5f2d5b3c094so725906eaf.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289795; x=1734894595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uAf44RLFv6Gad90RDm0aq5Bw6DLI2y44Nb6zhHpVoxY=;
 b=iDx/jKMwED8Mu9JdEDUs7Fqp81U09//S4NoK4zr6Vu+7EBDW+XfMu3NKwqddrrhdCS
 k4REbAXKTONRQaKr//a6hF51z0m5ESLuDwMb4DmsNX9u4qTd7FQ33Bl7KkKPtR6/BXXI
 gH1SJhkCnYkHo08p3zXP0hMxaZwH1KNNPnMw5/SbQiFxa37VTXoXpRDJeXq1Ul5Oas8J
 yGIXo5ZW216MdbSR8vaS0LZJWzbDRB/pUvlSicw8W+S3rHEMzwJqwiIdzH3cSK9o0+MT
 r1XrdoH6f4o+vyehb1XfGOVzJ4cqTxI/FN8JqSSGbYV1lnxORAt9UYE+qNuorv9xMg5N
 dPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289795; x=1734894595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uAf44RLFv6Gad90RDm0aq5Bw6DLI2y44Nb6zhHpVoxY=;
 b=mkbBk79dOvwYsMalOQQoxJ8bvga1uncEupSWOaS8lkJbxe/EviwjjPb5NN6kt508ky
 bo/85hmwq21qVBy4n0fYASu7LsO+XY3qos+7GFYWQyEM5DzCMfQI8xVWZz1gWJtgO55q
 ZEHmAPEkRmNVJgqTD8Qax+DSQtjtJXZ8aKn5NwJbi/0o6Gm4logvxPieStkBjRMIurmI
 5td3z+XyVbf8dHyLtu7wswPe2UF/qQkkp3RFyCmAioHm0K1FidnVli+LC0FkUF06Eq6O
 M7gLyATE/Kq7QLsqikxn/Q/io3XpEHXRYkZ05kfRIIHmtB1qAIYjZb4pQy7W4gmZCDee
 SQeg==
X-Gm-Message-State: AOJu0Yyz8weY80rxDm6FLaJE4CAwAKAEB1LAeZk9esU/PxLNGS5rzf0r
 h8mdEsWkB6Bwx2V+R00l2IWae2hiA3fPgwLlEEYWx0YCGrq1kmic5BhZ0gAVhnYPz2ls5E4iTww
 U+maWcTgs
X-Gm-Gg: ASbGnctjvZwb7bVbTnddZihEDSZi19iR7GMI16QKECW+uMJy4mrX+OG6e+x+DA3pNYp
 l4rxJMmZrpegVD0NGtcC89rkJG4Aj7PmUip/1dkH6o8SoYlAc01x+PpWKC0LGU1YJec9LYZA53G
 Yf6O+eci1l88xBO60PboTGD8z0vjxdTLx9KPw58fBh4skIGzIMBZGuDK2ZDX/j+C4SUEnyip2e/
 N00qSNdbN5RwdJWRxauDCR4xlMVr7+UvaHY/tsZjZYtsbEO1sdnKL8sr5wUs3410vrLHLMVEwdK
 Qt2bX7XvJ/dD7bVb2TNJDMqp9Z1YjKPpUqc4xxvJIYY=
X-Google-Smtp-Source: AGHT+IHW0dptm8aXWEuBzxHB4qr8bCofngBl8a3DwLi7ahEbw2d52BK3J/vAe0sEOcrscnMyqABuxw==
X-Received: by 2002:a05:6870:2c90:b0:29f:d0bb:618e with SMTP id
 586e51a60fabf-2a3ac6dcd39mr5793001fac.25.1734289795506; 
 Sun, 15 Dec 2024 11:09:55 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 61/67] hw/usb: Constify all Property
Date: Sun, 15 Dec 2024 13:05:27 -0600
Message-ID: <20241215190533.3222854-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/usb/bus.c                  | 2 +-
 hw/usb/canokey.c              | 2 +-
 hw/usb/ccid-card-emulated.c   | 2 +-
 hw/usb/ccid-card-passthru.c   | 2 +-
 hw/usb/dev-audio.c            | 2 +-
 hw/usb/dev-hid.c              | 6 +++---
 hw/usb/dev-hub.c              | 2 +-
 hw/usb/dev-mtp.c              | 2 +-
 hw/usb/dev-network.c          | 2 +-
 hw/usb/dev-serial.c           | 4 ++--
 hw/usb/dev-smartcard-reader.c | 4 ++--
 hw/usb/dev-storage-classic.c  | 2 +-
 hw/usb/dev-uas.c              | 2 +-
 hw/usb/hcd-dwc2.c             | 2 +-
 hw/usb/hcd-dwc3.c             | 2 +-
 hw/usb/hcd-ehci-pci.c         | 2 +-
 hw/usb/hcd-ehci-sysbus.c      | 2 +-
 hw/usb/hcd-ohci-pci.c         | 2 +-
 hw/usb/hcd-ohci-sysbus.c      | 2 +-
 hw/usb/hcd-uhci.c             | 4 ++--
 hw/usb/hcd-xhci-nec.c         | 2 +-
 hw/usb/hcd-xhci-sysbus.c      | 2 +-
 hw/usb/hcd-xhci.c             | 2 +-
 hw/usb/host-libusb.c          | 2 +-
 hw/usb/redirect.c             | 2 +-
 hw/usb/u2f-emulated.c         | 2 +-
 hw/usb/u2f-passthru.c         | 2 +-
 27 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index bfab2807d7..80e6a92820 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -18,7 +18,7 @@ static char *usb_get_dev_path(DeviceState *dev);
 static char *usb_get_fw_dev_path(DeviceState *qdev);
 static void usb_qdev_unrealize(DeviceState *qdev);
 
-static Property usb_props[] = {
+static const Property usb_props[] = {
     DEFINE_PROP_STRING("port", USBDevice, port_path),
     DEFINE_PROP_STRING("serial", USBDevice, serial),
     DEFINE_PROP_BIT("msos-desc", USBDevice, flags,
diff --git a/hw/usb/canokey.c b/hw/usb/canokey.c
index b306eeb20e..7cb600e3c8 100644
--- a/hw/usb/canokey.c
+++ b/hw/usb/canokey.c
@@ -296,7 +296,7 @@ static void canokey_unrealize(USBDevice *base)
     trace_canokey_unrealize();
 }
 
-static Property canokey_properties[] = {
+static const Property canokey_properties[] = {
     DEFINE_PROP_STRING("file", CanoKeyState, file),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 3ee9c73b87..dd58333943 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -582,7 +582,7 @@ static void emulated_unrealize(CCIDCardState *base)
     qemu_mutex_destroy(&card->event_list_mutex);
 }
 
-static Property emulated_card_properties[] = {
+static const Property emulated_card_properties[] = {
     DEFINE_PROP_STRING("backend", EmulatedState, backend_str),
     DEFINE_PROP_STRING("cert1", EmulatedState, cert1),
     DEFINE_PROP_STRING("cert2", EmulatedState, cert2),
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index a515703904..f97dcf767f 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -388,7 +388,7 @@ static const VMStateDescription passthru_vmstate = {
     }
 };
 
-static Property passthru_card_properties[] = {
+static const Property passthru_card_properties[] = {
     DEFINE_PROP_CHR("chardev", PassthruState, cs),
     DEFINE_PROP_UINT8("debug", PassthruState, debug, 0),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 1897fff9e6..6007f16d30 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -990,7 +990,7 @@ static const VMStateDescription vmstate_usb_audio = {
     .unmigratable = 1,
 };
 
-static Property usb_audio_properties[] = {
+static const Property usb_audio_properties[] = {
     DEFINE_AUDIO_PROPERTIES(USBAudioState, card),
     DEFINE_PROP_UINT32("debug", USBAudioState, debug, 0),
     DEFINE_PROP_UINT32("buffer", USBAudioState, buffer_user, 0),
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 9e358c934e..d83f67b984 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -793,7 +793,7 @@ static const TypeInfo usb_hid_type_info = {
     .class_init = usb_hid_class_initfn,
 };
 
-static Property usb_tablet_properties[] = {
+static const Property usb_tablet_properties[] = {
         DEFINE_PROP_UINT32("usb_version", USBHIDState, usb_version, 2),
         DEFINE_PROP_STRING("display", USBHIDState, display),
         DEFINE_PROP_UINT32("head", USBHIDState, head, 0),
@@ -818,7 +818,7 @@ static const TypeInfo usb_tablet_info = {
     .class_init    = usb_tablet_class_initfn,
 };
 
-static Property usb_mouse_properties[] = {
+static const Property usb_mouse_properties[] = {
         DEFINE_PROP_UINT32("usb_version", USBHIDState, usb_version, 2),
         DEFINE_PROP_END_OF_LIST(),
 };
@@ -841,7 +841,7 @@ static const TypeInfo usb_mouse_info = {
     .class_init    = usb_mouse_class_initfn,
 };
 
-static Property usb_keyboard_properties[] = {
+static const Property usb_keyboard_properties[] = {
         DEFINE_PROP_UINT32("usb_version", USBHIDState, usb_version, 2),
         DEFINE_PROP_STRING("display", USBHIDState, display),
         DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 2c3640c705..317ca0b081 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -665,7 +665,7 @@ static const VMStateDescription vmstate_usb_hub = {
     }
 };
 
-static Property usb_hub_properties[] = {
+static const Property usb_hub_properties[] = {
     DEFINE_PROP_UINT32("ports", USBHubState, num_ports, 8),
     DEFINE_PROP_BOOL("port-power", USBHubState, port_power, false),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 554b397e88..7994727e5e 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -2078,7 +2078,7 @@ static const VMStateDescription vmstate_usb_mtp = {
     }
 };
 
-static Property mtp_properties[] = {
+static const Property mtp_properties[] = {
     DEFINE_PROP_STRING("rootdir", MTPState, root),
     DEFINE_PROP_STRING("desc", MTPState, desc),
     DEFINE_PROP_BOOL("readonly", MTPState, readonly, true),
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index d00d68b21d..6c4f5776d4 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1407,7 +1407,7 @@ static const VMStateDescription vmstate_usb_net = {
     .unmigratable = 1,
 };
 
-static Property net_properties[] = {
+static const Property net_properties[] = {
     DEFINE_NIC_PROPERTIES(USBNetState, conf),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 63047d79cf..0c3e9160ec 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -634,7 +634,7 @@ static const VMStateDescription vmstate_usb_serial = {
     .unmigratable = 1,
 };
 
-static Property serial_properties[] = {
+static const Property serial_properties[] = {
     DEFINE_PROP_CHR("chardev", USBSerialState, cs),
     DEFINE_PROP_BOOL("always-plugged", USBSerialState, always_plugged, false),
     DEFINE_PROP_END_OF_LIST(),
@@ -677,7 +677,7 @@ static const TypeInfo serial_info = {
     .class_init    = usb_serial_class_initfn,
 };
 
-static Property braille_properties[] = {
+static const Property braille_properties[] = {
     DEFINE_PROP_CHR("chardev", USBSerialState, cs),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index c0d63e0425..c3c02f0aad 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1171,7 +1171,7 @@ static Answer *ccid_peek_next_answer(USBCCIDState *s)
         : &s->pending_answers[s->pending_answers_start % PENDING_ANSWERS_NUM];
 }
 
-static Property ccid_props[] = {
+static const Property ccid_props[] = {
     DEFINE_PROP_UINT32("slot", struct CCIDCardState, slot, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -1431,7 +1431,7 @@ static const VMStateDescription ccid_vmstate = {
     }
 };
 
-static Property ccid_properties[] = {
+static const Property ccid_properties[] = {
     DEFINE_PROP_UINT8("debug", USBCCIDState, debug, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index 6147387dc6..ca037ba96f 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -67,7 +67,7 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
     s->scsi_dev = scsi_dev;
 }
 
-static Property msd_properties[] = {
+static const Property msd_properties[] = {
     DEFINE_BLOCK_PROPERTIES(MSDState, conf),
     DEFINE_BLOCK_ERROR_PROPERTIES(MSDState, conf),
     DEFINE_PROP_BOOL("removable", MSDState, removable, false),
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 1804cb6799..57e8d20051 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -953,7 +953,7 @@ static const VMStateDescription vmstate_usb_uas = {
     }
 };
 
-static Property uas_properties[] = {
+static const Property uas_properties[] = {
     DEFINE_PROP_UINT32("log-scsi-req", UASDevice, requestlog, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index b4f0652c7d..6a10f3e9cd 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -1448,7 +1448,7 @@ const VMStateDescription vmstate_dwc2_state = {
     }
 };
 
-static Property dwc2_usb_properties[] = {
+static const Property dwc2_usb_properties[] = {
     DEFINE_PROP_UINT32("usb_version", DWC2State, usb_version, 2),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/usb/hcd-dwc3.c b/hw/usb/hcd-dwc3.c
index e7d8c7924b..ff970bd989 100644
--- a/hw/usb/hcd-dwc3.c
+++ b/hw/usb/hcd-dwc3.c
@@ -656,7 +656,7 @@ static const VMStateDescription vmstate_usb_dwc3 = {
     }
 };
 
-static Property usb_dwc3_properties[] = {
+static const Property usb_dwc3_properties[] = {
     DEFINE_PROP_UINT32("DWC_USB3_USERID", USBDWC3, cfg.dwc_usb3_user,
                        0x12345678),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index dd06451e23..374f25c5ed 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -135,7 +135,7 @@ static void usb_ehci_pci_write_config(PCIDevice *dev, uint32_t addr,
     i->ehci.as = busmaster ? pci_get_address_space(dev) : &address_space_memory;
 }
 
-static Property ehci_pci_properties[] = {
+static const Property ehci_pci_properties[] = {
     DEFINE_PROP_UINT32("maxframes", EHCIPCIState, ehci.maxframes, 128),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index eb7df93ac2..f4e08aab89 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -30,7 +30,7 @@ static const VMStateDescription vmstate_ehci_sysbus = {
     }
 };
 
-static Property ehci_sysbus_properties[] = {
+static const Property ehci_sysbus_properties[] = {
     DEFINE_PROP_UINT32("maxframes", EHCISysBusState, ehci.maxframes, 128),
     DEFINE_PROP_BOOL("companion-enable", EHCISysBusState, ehci.companion_enable,
                      false),
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 47fb659806..459644cc1b 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -109,7 +109,7 @@ static void usb_ohci_reset_pci(DeviceState *d)
     ohci_hard_reset(s);
 }
 
-static Property ohci_pci_properties[] = {
+static const Property ohci_pci_properties[] = {
     DEFINE_PROP_STRING("masterbus", OHCIPCIState, masterbus),
     DEFINE_PROP_UINT32("num-ports", OHCIPCIState, num_ports, 3),
     DEFINE_PROP_UINT32("firstport", OHCIPCIState, firstport, 0),
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
index 313e1e71bb..81cf2e558d 100644
--- a/hw/usb/hcd-ohci-sysbus.c
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -57,7 +57,7 @@ static void ohci_sysbus_reset(DeviceState *dev)
     ohci_hard_reset(ohci);
 }
 
-static Property ohci_sysbus_properties[] = {
+static const Property ohci_sysbus_properties[] = {
     DEFINE_PROP_STRING("masterbus", OHCISysBusState, masterbus),
     DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),
     DEFINE_PROP_UINT32("firstport", OHCISysBusState, firstport, 0),
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 65c1f93cc9..245352c231 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1227,14 +1227,14 @@ static void usb_uhci_exit(PCIDevice *dev)
     }
 }
 
-static Property uhci_properties_companion[] = {
+static const Property uhci_properties_companion[] = {
     DEFINE_PROP_STRING("masterbus", UHCIState, masterbus),
     DEFINE_PROP_UINT32("firstport", UHCIState, firstport, 0),
     DEFINE_PROP_UINT32("bandwidth", UHCIState, frame_bandwidth, 1280),
     DEFINE_PROP_UINT32("maxframes", UHCIState, maxframes, 128),
     DEFINE_PROP_END_OF_LIST(),
 };
-static Property uhci_properties_standalone[] = {
+static const Property uhci_properties_standalone[] = {
     DEFINE_PROP_UINT32("bandwidth", UHCIState, frame_bandwidth, 1280),
     DEFINE_PROP_UINT32("maxframes", UHCIState, maxframes, 128),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 1a191fc737..f06e7403e2 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -36,7 +36,7 @@ struct XHCINecState {
     uint32_t slots;
 };
 
-static Property nec_xhci_properties[] = {
+static const Property nec_xhci_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_UINT32("intrs", XHCINecState, intrs, XHCI_MAXINTRS),
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index 59cf7fd4ab..f4dbad7cc6 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -82,7 +82,7 @@ void xhci_sysbus_build_aml(Aml *scope, uint32_t mmio, unsigned int irq)
     aml_append(scope, dev);
 }
 
-static Property xhci_sysbus_props[] = {
+static const Property xhci_sysbus_props[] = {
     DEFINE_PROP_UINT32("intrs", XHCISysbusState, xhci.numintrs, XHCI_MAXINTRS),
     DEFINE_PROP_UINT32("slots", XHCISysbusState, xhci.numslots, XHCI_MAXSLOTS),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d85adaca0d..3c5006f425 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3605,7 +3605,7 @@ const VMStateDescription vmstate_xhci = {
     }
 };
 
-static Property xhci_properties[] = {
+static const Property xhci_properties[] = {
     DEFINE_PROP_BIT("streams", XHCIState, flags,
                     XHCI_FLAG_ENABLE_STREAMS, true),
     DEFINE_PROP_UINT32("p2",    XHCIState, numports_2, 4),
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 691bc881fb..85d33b51ba 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1758,7 +1758,7 @@ static const VMStateDescription vmstate_usb_host = {
     }
 };
 
-static Property usb_host_dev_properties[] = {
+static const Property usb_host_dev_properties[] = {
     DEFINE_PROP_UINT32("hostbus",  USBHostDevice, match.bus_num,    0),
     DEFINE_PROP_UINT32("hostaddr", USBHostDevice, match.addr,       0),
     DEFINE_PROP_STRING("hostport", USBHostDevice, match.port),
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 0f2dd2e504..f72a612d5a 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2573,7 +2573,7 @@ static const VMStateDescription usbredir_vmstate = {
     }
 };
 
-static Property usbredir_properties[] = {
+static const Property usbredir_properties[] = {
     DEFINE_PROP_CHR("chardev", USBRedirDevice, cs),
     DEFINE_PROP_UINT8("debug", USBRedirDevice, debug, usbredirparser_warning),
     DEFINE_PROP_STRING("filter", USBRedirDevice, filter_str),
diff --git a/hw/usb/u2f-emulated.c b/hw/usb/u2f-emulated.c
index 63cceaa5fc..df86ce97fc 100644
--- a/hw/usb/u2f-emulated.c
+++ b/hw/usb/u2f-emulated.c
@@ -369,7 +369,7 @@ static void u2f_emulated_unrealize(U2FKeyState *base)
     }
 }
 
-static Property u2f_emulated_properties[] = {
+static const Property u2f_emulated_properties[] = {
     DEFINE_PROP_STRING("dir", U2FEmulatedState, dir),
     DEFINE_PROP_STRING("cert", U2FEmulatedState, cert),
     DEFINE_PROP_STRING("privkey", U2FEmulatedState, privkey),
diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index c4a783d128..ec4f6165d8 100644
--- a/hw/usb/u2f-passthru.c
+++ b/hw/usb/u2f-passthru.c
@@ -516,7 +516,7 @@ static const VMStateDescription u2f_passthru_vmstate = {
     }
 };
 
-static Property u2f_passthru_properties[] = {
+static const Property u2f_passthru_properties[] = {
     DEFINE_PROP_STRING("hidraw", U2FPassthruState, hidraw),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


