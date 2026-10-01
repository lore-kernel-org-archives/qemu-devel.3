Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69557CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGst-0001BM-Sr; Thu, 01 Oct 2026 09:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGse-0000Ft-SD
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGsc-0006S6-Kp
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y/oPf45UcMrdKaDQ6+RGXf9f/PrLAkuUHjEXeWLkNjs=;
 b=Ohot6sV2RQI0FqkX/1wAMDaOxt6D1rOpbEvSZVfvaf1Jq/P+lKss18I9fzk29u2pTUst1c
 11xXRUml5IcAcraasJrSjxQgH79QXMg96J8Pr+S8twcf94QcIynJLAby9uXPMlDacrotz6
 cTAtzfZjE6T5BF2a8pnI+vI4vxvUJJY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-amKVIMC9N26wxdM_Ln-WOA-1; Thu,
 01 Oct 2026 09:31:17 -0400
X-MC-Unique: amKVIMC9N26wxdM_Ln-WOA-1
X-Mimecast-MFC-AGG-ID: amKVIMC9N26wxdM_Ln-WOA_1790861473
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1F311828A86; Thu,  1 Oct 2026 13:31:12 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 238141956086; Thu,  1 Oct 2026 13:31:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:30:04 +0400
Subject: [GIT PULL 25/27] hw/usb/dev-smartcard-reader: advertise T=1
 protocol support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-25-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3701;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uX9Ip/8PgNR6QRXszgmYx0rl0AfR271pYolhO3lO9y0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBI3eiiogU4Xgdnpzsc4x9kjTGqcMi5b7Tgy
 A/rYrM3/xOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gSAAKCRDa6OEJdZac
 5eegD/9udg4HpD4CuXYUNKDAB+WLTaBEkU+QrKHhHfT2uykoWaohlvaVqdbwEKJGpEQ9zDeLE0c
 8Ndwjw+yT9Q1X1XG6GmKbo9t9v2rj5xlhZ2KuYgIilY3+k6W2NdMQm3uphzbhXrtFBAZytBF2eg
 /fZ1YIct8fNgjMdCS7wKKo/trEzycBp465tjXBOowjwxQqLNZWMejw/JOS5D+7Mu3Nk73ZNuCd/
 SGjjnLCwmBAjRBCwqolNHAiuFZx8EdJBJWHsvT8KOhtZVNTbvIeoDizEA5f3CjvMTz43EoEUwEU
 cFDEJ9bjYWijA6GEv2kmhXHEGdjWGnF3xDoET5vdILQ3ATxBaDeOoIMK6qg37+IRqjLJIB/HAD5
 OjH4FvflkBMGbEk0wcvvYCZoGkalDuaua0ZPdv/3xDUDsckd323rvbeLEdc9YKgphXf2hgVZBAM
 ngIuMQEtOdIGXse8aMz1lnPOJJXxUf0edwEzdGrHbAt8GiwVYroOvWm1NJHoRSgKuKn5pqSbPh8
 KEwzNxMK03cLXejZUhdH3GQmdCMG1tEC0to1qPaTC0IQBt7qcCzZ4GK03UpUHENrKQKRUCeGFNd
 RovBptE/kJaKmwPCnlg/1rcsaprbhlg27xyEuKf9pQpSvQ7KeQbFZGyzdrW005M0o/c7/M6Ju1+
 vfqxugMOKmU1bnw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The CCID descriptor only advertised T=0, but it actually handles t=1
since it shuttles framed blocks to the backend. libcacard advertized T=0
in the ATR, so it works fine. This allows passthrough cards to work
at t=1 if they need to.

Add a configurable property to also advertise T=1 in the dwProtocols
field, enabled by default.

Use the correct error code (7, ICC protocol not supported) instead
of CMD_NOT_SUPPORTED when SetParameters receives an invalid protocol.

Note: I only tested with libcacard emulation.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/machine.c             |  1 +
 hw/usb/dev-smartcard-reader.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index a5a168d72521..d9ac4b419a36 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -59,6 +59,7 @@ GlobalProperty hw_compat_11_0[] = {
     { "migration", "switchover-ack-legacy", "on" },
     { "usb-ccid", "x-accurate-message-length", "off" },
     { "usb-ccid", "x-pin-support", "on" },
+    { "usb-ccid", "x-t1-support", "off" },
     { "usb-ccid", "x-migrate-pending-answers", "off" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 8520a2dab216..99086befe0b8 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -169,6 +169,7 @@ enum {
     ERROR_CMD_SLOT_BUSY     = -32,
     ERROR_BAD_DWLENGTH      = 1,
     ERROR_SLOT_NOT_EXIST    = 5,
+    ERROR_PROTOCOL_INVALID  = 7,
 };
 
 /* 6.2.6 RDR_to_PC_SlotStatus definitions */
@@ -330,6 +331,7 @@ struct USBCCIDState {
     bool migrate_pending_answers;
     bool pending_answers_loaded;
     bool pin_support;
+    bool t1_support;
 };
 
 static uint32_t ccid_bulk_in_pending_num(USBCCIDState *s)
@@ -368,6 +370,7 @@ static uint8_t qemu_ccid_descriptor[] = {
                      */
         0x07,       /* u8  bVoltageSupport; 01h - 5.0v, 02h - 3.0, 03 - 1.8 */
 
+#define CCID_DESC_OFFSET_DW_PROTOCOLS 0x06
         0x01, 0x00, /* u32 dwProtocols; RRRR PPPP. RRRR = 0000h.*/
         0x00, 0x00, /* PPPP: 0001h = Protocol T=0, 0002h = Protocol T=1 */
                     /* u32 dwDefaultClock; in kHZ (0x0fa0 is 4 MHz) */
@@ -968,7 +971,7 @@ static void ccid_set_parameters(USBCCIDState *s, CCID_Header *recv)
     uint32_t protocol_num = ph->bProtocolNum & 3;
 
     if (protocol_num != 0 && protocol_num != 1) {
-        ccid_report_error_failed(s, ERROR_CMD_NOT_SUPPORTED);
+        ccid_report_error_failed(s, ERROR_PROTOCOL_INVALID);
         return;
     }
     s->bProtocolNum = protocol_num;
@@ -1546,6 +1549,9 @@ static void ccid_realize(USBDevice *dev, Error **errp)
     if (!s->pin_support) {
         qemu_ccid_descriptor[CCID_DESC_OFFSET_B_PIN_SUPPORT] = 0;
     }
+    if (s->t1_support) {
+        qemu_ccid_descriptor[CCID_DESC_OFFSET_DW_PROTOCOLS] |= 0x2;
+    }
     usb_desc_create_serial(dev);
     usb_desc_init(dev);
     qbus_init(&s->bus, sizeof(s->bus), TYPE_CCID_BUS, DEVICE(dev), NULL);
@@ -1742,6 +1748,8 @@ static const Property ccid_properties[] = {
                      accurate_message_length, true),
     DEFINE_PROP_BOOL("x-pin-support", USBCCIDState,
                      pin_support, false),
+    DEFINE_PROP_BOOL("x-t1-support", USBCCIDState,
+                     t1_support, true),
     DEFINE_PROP_BOOL("x-migrate-pending-answers", USBCCIDState,
                      migrate_pending_answers, true),
 };

-- 
2.56.0.rc0.29.g47ce80527c56


