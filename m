Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7A1C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHoHK-0004ca-8Y; Thu, 13 Jun 2024 13:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sHoHI-0004c2-Nt
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:30:24 -0400
Received: from fhigh7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sHoHG-0007Fj-EV
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:30:24 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 59AC91140157;
 Thu, 13 Jun 2024 13:30:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Thu, 13 Jun 2024 13:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718299821;
 x=1718386221; bh=+JwncMEIhPA0LQany3Z1qAPP2WyhtQ9mhBkYNm40cuk=; b=
 DG7YKO83HuJfSC/XMdNeLBnjn5SfH4CRhuOf3nyuFMy1hdSiivuzTO9pHirqakVy
 Zb3FFZosZB0YNgd99ggnGA9DfUeSdt9od+tJwv9mFGt/MQikGPiHmEO7/kXV6kGm
 2Fojh+DlCslxOYrMh9smowoZlnAHF2xLaNfAiQuU8uH0Qh9vSMZErKC1lmbju0XD
 h6XfUawAYCmdlgfKnDoUUQgqIt/QSuKi+9V/ZObvrF7f9lI+sp1oqH13QZ1/Dzad
 PpoH+XPyxV54tfjIBUdckHIQoI89hHAOunrHNQG7fxvgXAuTpwl4Dt2il9nZLJvh
 epRq2m6iBp/VC5zBFd8+OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718299821; x=
 1718386221; bh=+JwncMEIhPA0LQany3Z1qAPP2WyhtQ9mhBkYNm40cuk=; b=E
 QLoqaHA2TMNJeCXaPtg1EF9U1CenD4GlgGAhqfammyjZSF8Gt2UBfT/x09OkG6ge
 Q7sUVvyG6WyvyF2lWyq+5NnHci8N8xmHxPQD6tg0PfMEQDkei7d9ip2Pyay3Y0G0
 +vDlSYYUupKM+R9CA4klwaJyMt21LHwjHZ+CXo4EhDCgoisrKM7ti5TvYvWD+kTl
 XnlZhDy8xVJW6VZVO7UmjbtU2BQDNbYj8cjU0jHRVP3xYKC364n4/x7fGb3ofQ7o
 1ttdf5kacGRqtAvFu5N/6qKF28FJ3VxgFQv4zjwUhJgO3u3EXQ1LQvSXbY2YJd/f
 c21Zc7s+g8Ye2KS+qIyPQ==
X-ME-Sender: <xms:rSxrZpKPF46JrT8KwUA44D5CrzT6MifjdVujVwS8xTn40_uJtUVRZw>
 <xme:rSxrZlJpk-kw8-BKA6NcpgeD-mlyMMmMQqbGCPpVQg-t4HD8L-XvhbhRyTkUeNbU_
 BGNdhsisNBvjnmTe6o>
X-ME-Received: <xmr:rSxrZhvcWw8Hz8RGuF1RTmvylTKbzLv6P-mKfX3NQUY6Qkm1YYBsLeE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgudduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:rSxrZqZlpKkt2XuYm-tlhgD_m-ztbyuJo5kfv5W5TUqArLE58B2mVA>
 <xmx:rSxrZgYwntM0l1QqnsCOO7ll4hchqchnmE___fcMHq9tsFlrcaoBGg>
 <xmx:rSxrZuBy7jP_dSEMAeYNGkmoEX_S-TgJNnGxuKhWYuW0YiNUaOeXIQ>
 <xmx:rSxrZua62fCwEytIPBhbbWBm--RUIYpB-27ALhsy5yYVj--L8ZJRWg>
 <xmx:rSxrZqD9hliXH0rwk_JXRPf8y_bU69Vl2H79wD7XbC-R2ThBYK1-vBjq>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 13:30:19 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 13 Jun 2024 18:30:15 +0100
Subject: [PATCH 1/3] acpi/ged: Implement S3 and S4 sleep
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-loongarch64-sleep-v1-1-d2ef0aaa543a@flygoat.com>
References: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
In-Reply-To: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
To: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Sergio Lopez <slp@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6486;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=f76BG7HPJrfWMHtI/gS8gAZiuID/iiQb3Z0RGRIo27o=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRsnVXZTq1S+k73T2itXJglb1rw0Gq70cXsmAD2j9a36
 5eyMfl3lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwE2ezMhwa3IPA5/qjacb+56b
 d7HcXPxo16uNOaUM7pL//qzzW/ZdjZFhoc9aoUfrZjJe3Lt1ehbLNiv1sC5X5kRHHaEX87T0ihb
 xAAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.158;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Implement S3 and S4 sleep with ACPI_GED_REG_SLEEP_CTL.SLP_TYP
writes.

Implement wakeup callback and WAK_STS register to inform guest
about current states.

All new functions are gated by "slp-typs" property, it is defaulted
to S5 only and machines can opt-in for S3 and S4.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/acpi/generic_event_device.c         | 70 ++++++++++++++++++++++++++++++----
 include/hw/acpi/generic_event_device.h | 12 +++++-
 2 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 2d6e91b124e5..f1fc99c04011 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-run-state.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/irq.h"
@@ -186,24 +187,53 @@ static const MemoryRegionOps ged_evt_ops = {
 
 static uint64_t ged_regs_read(void *opaque, hwaddr addr, unsigned size)
 {
+    GEDState *ged_st = opaque;
+
+    switch (addr) {
+    case ACPI_GED_REG_SLEEP_STS:
+        return ged_st->sleep_sts;
+    default:
+        break;
+    }
+
     return 0;
 }
 
 static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
                            unsigned int size)
 {
-    bool slp_en;
-    int slp_typ;
+    GEDState *ged_st = opaque;
+    AcpiGedState *s = container_of(ged_st, AcpiGedState, ged_state);
 
     switch (addr) {
     case ACPI_GED_REG_SLEEP_CTL:
-        slp_typ = (data >> 2) & 0x07;
-        slp_en  = (data >> 5) & 0x01;
-        if (slp_en && slp_typ == 5) {
-            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        if (data & ACPI_GED_SLP_EN) {
+            switch (extract8(data, 2, 3)) {
+            case ACPI_GED_SLP_TYP_S3:
+                if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S3)) {
+                    qemu_system_suspend_request();
+                }
+                break;
+            case ACPI_GED_SLP_TYP_S4:
+                if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S4)) {
+                    qapi_event_send_suspend_disk();
+                    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+                }
+                break;
+            case ACPI_GED_SLP_TYP_S5:
+                if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S5)) {
+                    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+                }
+                break;
+            default:
+                break;
+            }
         }
         return;
     case ACPI_GED_REG_SLEEP_STS:
+        if (data & ACPI_GED_WAK_STS) {
+            ged_st->sleep_sts &= ~ACPI_GED_WAK_STS;
+        }
         return;
     case ACPI_GED_REG_RESET:
         if (data == ACPI_GED_RESET_VALUE) {
@@ -223,6 +253,14 @@ static const MemoryRegionOps ged_regs_ops = {
     },
 };
 
+static void acpi_ged_notify_wakeup(Notifier *notifier, void *data)
+{
+    GEDState *ged_st = container_of(notifier, GEDState, wakeup);
+
+    ged_st->sleep_sts |= ACPI_GED_WAK_STS;
+}
+
+
 static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
                                     DeviceState *dev, Error **errp)
 {
@@ -305,6 +343,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
 
 static Property acpi_ged_properties[] = {
     DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
+    DEFINE_PROP_UINT32("slp-typs", AcpiGedState, slp_typs_bitmap,
+                        (1 << ACPI_GED_SLP_TYP_S5)),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -320,10 +360,11 @@ static const VMStateDescription vmstate_memhp_state = {
 
 static const VMStateDescription vmstate_ged_state = {
     .name = "acpi-ged-state",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(sel, GEDState),
+        VMSTATE_UINT8(sleep_sts, GEDState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -371,6 +412,18 @@ static const VMStateDescription vmstate_acpi_ged = {
     }
 };
 
+static void acpi_ged_realize(DeviceState *dev, Error **errp)
+{
+    AcpiGedState *s = ACPI_GED(dev);
+    GEDState *ged_st = &s->ged_state;
+
+    if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S3)) {
+        ged_st->wakeup.notify = acpi_ged_notify_wakeup;
+        qemu_register_wakeup_notifier(&ged_st->wakeup);
+        qemu_register_wakeup_support();
+    }
+}
+
 static void acpi_ged_initfn(Object *obj)
 {
     DeviceState *dev = DEVICE(obj);
@@ -409,6 +462,7 @@ static void acpi_ged_class_init(ObjectClass *class, void *data)
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
 
     dc->desc = "ACPI Generic Event Device";
+    dc->realize = acpi_ged_realize;
     device_class_set_props(dc, acpi_ged_properties);
     dc->vmsd = &vmstate_acpi_ged;
 
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index ba84ce021477..1ea3cb848679 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -80,9 +80,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 /* ACPI_GED_REG_RESET value for reset*/
 #define ACPI_GED_RESET_VALUE       0x42
 
-/* ACPI_GED_REG_SLEEP_CTL.SLP_TYP value for S5 (aka poweroff) */
+/* ACPI_GED_REG_SLEEP_CTL.SLP_EN bit */
+#define ACPI_GED_SLP_EN            (1 << 5)
+
+/* ACPI_GED_REG_SLEEP_CTL.SLP_TYP values */
+#define ACPI_GED_SLP_TYP_S3        0x03
+#define ACPI_GED_SLP_TYP_S4        0x04
 #define ACPI_GED_SLP_TYP_S5        0x05
 
+#define ACPI_GED_WAK_STS           (1 << 7)
+
 #define GED_DEVICE      "GED"
 #define AML_GED_EVT_REG "EREG"
 #define AML_GED_EVT_SEL "ESEL"
@@ -99,7 +106,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 typedef struct GEDState {
     MemoryRegion evt;
     MemoryRegion regs;
+    Notifier     wakeup;
     uint32_t     sel;
+    uint8_t      sleep_sts;
 } GEDState;
 
 struct AcpiGedState {
@@ -108,6 +117,7 @@ struct AcpiGedState {
     MemoryRegion container_memhp;
     GEDState ged_state;
     uint32_t ged_event_bitmap;
+    uint32_t slp_typs_bitmap;
     qemu_irq irq;
     AcpiGhesState ghes_state;
 };

-- 
2.43.0


