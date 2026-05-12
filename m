Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DEBCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMooR-0005gF-JE; Tue, 12 May 2026 11:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wMooO-0005fj-Qp
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wMooN-0006xU-1h
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778598857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4ipTl8SxHF2BtSH0nCWnuSQlDSFAuLUpgjGujTX8sr4=;
 b=Pxn6ClV4Z/RfE8qCcQ2Ce2m3LMErQLo7YaE9Q/hnNPYVEjeWgxluYrymvb1JgnSKOksZpb
 /bZ63LpQHJKavMUPj/+oweafBGGC/Dx8WazBy8CDJckxofz3Ee87ttzEHKWL3aG8+sh7Ww
 +YoE2Zj0jqy1azunszc+ln48N0q4VKs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-IqKO9NxRMFCpe1Ye5SDrhA-1; Tue, 12 May 2026 11:14:16 -0400
X-MC-Unique: IqKO9NxRMFCpe1Ye5SDrhA-1
X-Mimecast-MFC-AGG-ID: IqKO9NxRMFCpe1Ye5SDrhA_1778598855
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48d0677b5f7so31983895e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778598855; x=1779203655; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4ipTl8SxHF2BtSH0nCWnuSQlDSFAuLUpgjGujTX8sr4=;
 b=ktdAiNGPWa1jiRr/HheEeB/6fztKl0olKuvzmENWt+uHEZ3wEPO3GLV2+1+uGZvT9x
 dXagsg7rwzUj4p/ODm1S8SVGD/ni3tlpCUWfFZyDaDt0Ctp0dPtflgXWCG1w3ONaO8HA
 l2TdeTdWinsSUo09sZ/A6kj0qSkH3wCGaufNUwb02bxS6LwRQQeJ+Ddnvv1PryGmu9f7
 nhztaegpCDxbYbtIvCuaksbs4bhOjcIbp0YZCWo6iaZos49pAD6bPM628sMK1BQxPJ1t
 R6IEM6dVjbtdosWGr9UN5d6ZgqBkwaZLEAHAGsbFlCU/UIWcsfcmaWWYe4W1WWBLr+33
 GJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778598855; x=1779203655;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ipTl8SxHF2BtSH0nCWnuSQlDSFAuLUpgjGujTX8sr4=;
 b=HFikL0I59pGRY5Mfr3xIIONW6DedIp/S66lzrfFWz4K9anKmaVaqHjPhbj05tID/3+
 xNDLaY3XXaWQ/xqTVgUlvSq2M5JHzXmnO8x9cR+3J0t5zQ1bo2szoksImXiQbIH+YS4X
 nAXgZvGaM3BKqSdVQOgj1E4BLeYjhBohgJjSic01/5DEekRjkhY/aeN7UgfyrWZgl6Jq
 aM16zac4/qIydRXwFdGf8YablFs+D6zVk8tk+/vlrVjzd/XEMtlAvQRXP6N/7z83nPzd
 BxxjQXHxg4AC2B8hBN2c8areUtsrvrQ3GCuKknvzFboUYfZZ+NOQ67qvGHBUoy8gJ03M
 f0Wg==
X-Gm-Message-State: AOJu0Yy/QKXvK0IgB7tbiXL6NMwm1HRPRBaDXDEc/7TFeuXhXMDZ8/U5
 PIXJnxVVxk5pcPAqMFbEbVsPKuvOoL4iTUPogeAp014IyUZBM6WLI+LyB5bNCayWH4Ay/247unb
 1daLUaE4nJVWmFz00MuQUh74JLE7JdSf3aKoxW+ImXItZXhwp4Y6K2Nh3
X-Gm-Gg: Acq92OHkMT4Dws381W42s7wh93ARJTljHnogLa62JNdPp7lU8w8cF1qG0A4DdZpFz1w
 psQGjDHGFJSxPN9trUjFn67nQuV3AA5ZTTLHIaG9B401woV2SxJL6YKXsWPGq7HUgjfZ7sNohCh
 AyecQU4r51ZsekoGhFPvNVO4EdhFo0dWCFDMZbRqqpr58Y3X/ZzWNOg4pfT2ANI3FS9f2B6et5H
 EghasTomxARtnSuyyL1jOaNOnzSkfrWosA7BcgKeo8/ctTcwpVdvgePOFYGsloyr6zdlnhfZ7j6
 FVJcI5DBcBP1NUCPPaQbKTCWVXLX8VaT/W/bdJvOhVYHMpyyK28Tm0yWUByEVs5BI9EAN13B6Me
 C8qCdfpaEE9hbc7UKvnARfImKmziQXkFhlEK5MWTUZlKPfK4RRHRG4TSkQRI5o0HSAZgD9yA2KF
 A9HtlTWggcGKpUyDdE
X-Received: by 2002:a05:600c:c166:b0:48a:93f8:dd02 with SMTP id
 5b1f17b1804b1-48e8fe7227cmr54459615e9.14.1778598854800; 
 Tue, 12 May 2026 08:14:14 -0700 (PDT)
X-Received: by 2002:a05:600c:c166:b0:48a:93f8:dd02 with SMTP id
 5b1f17b1804b1-48e8fe7227cmr54459065e9.14.1778598854441; 
 Tue, 12 May 2026 08:14:14 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f410558sm39968055e9.5.2026.05.12.08.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 08:14:13 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 12 May 2026 17:14:12 +0200
Subject: [PATCH] hw/i386/microvm: Add IGVM support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-microvm_igvm-v1-1-8b1fd8861235@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBOcASO6SkSIjTULMxQkkO6et
 HyL/xsUzsIFZtUgc5Ui6erAQYE/3XWwlr0byNBoLJKO4nOqcZOjRu0o2GlE9B4N9OTOHOT5d8v
 6vh9X2UWRXgAAAA==
X-Change-ID: 20260512-microvm_igvm-a2f58611cc10
To: qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The IGVM infrastructure operates on X86MachineState and is already
machine-type-agnostic, but the "igvm-cfg" QOM property is only
registered on the PC machine type. Register it on microvm as well.

When an IGVM file is configured, the firmware image is provided as
a payload of the IGVM file so skip loading the default BIOS.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 hw/i386/microvm.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 5a7889f21b..779741ec76 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -159,7 +159,6 @@ static int microvm_ioapics(MicrovmMachineState *mms)
 
 static void microvm_devices_init(MicrovmMachineState *mms)
 {
-    const char *default_firmware;
     X86MachineState *x86ms = X86_MACHINE(mms);
     ISABus *isa_bus;
     GSIState *gsi_state;
@@ -276,10 +275,12 @@ static void microvm_devices_init(MicrovmMachineState *mms)
         serial_hds_isa_init(isa_bus, 0, 1);
     }
 
-    default_firmware = x86_machine_is_acpi_enabled(x86ms)
-            ? MICROVM_BIOS_FILENAME
-            : MICROVM_QBOOT_FILENAME;
-    x86_bios_rom_init(x86ms, default_firmware, get_system_memory(), true);
+    if (!x86ms->igvm) {
+        const char *default_firmware = x86_machine_is_acpi_enabled(x86ms)
+                ? MICROVM_BIOS_FILENAME
+                : MICROVM_QBOOT_FILENAME;
+        x86_bios_rom_init(x86ms, default_firmware, get_system_memory(), true);
+    }
 }
 
 static void microvm_memory_init(MicrovmMachineState *mms)
@@ -717,6 +718,16 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
 
     compat_props_add(mc->compat_props, microvm_properties,
                      G_N_ELEMENTS(microvm_properties));
+
+#if defined(CONFIG_IGVM)
+    object_class_property_add_link(oc, "igvm-cfg",
+                                   TYPE_IGVM_CFG,
+                                   offsetof(X86MachineState, igvm),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_set_description(oc, "igvm-cfg",
+                                          "Set IGVM configuration");
+#endif
 }
 
 static const TypeInfo microvm_machine_info = {

---
base-commit: 5e61afe211e82a9af15a8794a0bd29bb574e953b
change-id: 20260512-microvm_igvm-a2f58611cc10

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


