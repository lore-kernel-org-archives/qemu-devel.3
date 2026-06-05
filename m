Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3203BCD6E7E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 23:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVdjt-0002Bf-HV; Fri, 05 Jun 2026 19:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tahsinahmed217@gmail.com>)
 id 1wVcsb-0007Km-Fy
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:19:07 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tahsinahmed217@gmail.com>)
 id 1wVcsZ-0006bc-CO
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:19:05 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-91563abd6a9so118937785a.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 15:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780697941; x=1781302741; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kWCvCbMuLrvzjTXWLz/A01J/l3SSgSOcIvIPUKXPcKk=;
 b=qquYsJ9s9koDTeBPgWMJ+MuzsgVf10esqh0tRILfwm55uoThcKfIvYMNo6Ev62TXcI
 LftOkTANamjm7yHhjlg/VU7rQYpjs75+GVMYjqykLPorIr7ajhWtSmmf1yoKAeLkLaPJ
 pbeIFr/TnprEBLPVu9KXPYDR+/SlWkslSyTTz7ImBDlLx77pvpBKKcCpqYJh4CktdKGB
 yOr7UU5M8mzb/oYM6V4LjBdaK3rMkuoamwd7RTlEFd4l+Uox5dDeOmVuIryA+n457gxw
 zsLfqX4/BFbb4ERRHvw3hJVXvWzlIQN5jA8a41Kd4pfITy31BGjukKwB6SBJSsT4Xt0U
 e+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780697941; x=1781302741;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWCvCbMuLrvzjTXWLz/A01J/l3SSgSOcIvIPUKXPcKk=;
 b=A1J7hFljc/pjsOpopRxFUyjKpyXXQPBj95N2Swyud/3ae1HPBmBrTx+CqlGnveSOcv
 ObXA2A4Tp9aaBEEch5kYwz1H0vxjVsHQMPCEtCcU86BxsqfLhzSL07GYbBaNKLXtynd/
 n43fisKXCi3p+wfODFivoiyPQcKci5EeJAZZnuwUF+dQa/DGqfwpJyr+xIQKwRxpVTF0
 8xh9gG9uRWQ/varV562eMxGS+KSVdhtF1JI2aSTuGqLnBemMVZrhzSCAYzcpePylYhQi
 Rwj1hCmDQ3Xdps/NXllx98df6yofkCi8hOLrRI6rqwt6fbol4kRiQNdncx7OxX3QlrXb
 4swA==
X-Gm-Message-State: AOJu0YzZHXUzLHudmaVNogTUOBK7V26hI8ROaN0/tdl8b0Q9j+8Je125
 gNzhD9m3AMTInjU4oaDEH1x2LWEgSrjhAayxnjWzJo90Dv1kqBHNYDL7
X-Gm-Gg: Acq92OF2qzc+cKVKebA6xcIjuWEHL4P0TdOmTKIDQJRSsdfboJTlYvQIHWuQQFAxOnp
 mR40VMLFprOYAMv1sOkieC2sjp7+SGHOLhsGyNLuuB5gtckVun/zIRxZXlPxh5/OhfHMAEhsx6q
 o0sgXBXyFt+g4Z1Hmxh3+aeTNg2shD8sB09zAHclG3QEpN6vi1K2rhnyx2w77GHmdVzaLBonrhW
 hbnMYG9zvs4ngqe9CdQO5jg6kUjSG4fkn7MDprkVnDRcpXTgI1KxuEf8gY9gGhi3fJfrZC3pen/
 fPqpB4S0e2K1rpVOfUCvmtpve1SMTMTdSFzgSTjZzdCogxjzJHaDIX/a74BS0rn9yNopka2dQE8
 R4xVI4n6p0JSDzcWCkxh8xZrcEoH/T2dbCBSFhhq0NxAbWhMW3iyyOS3Rh8DuP4wlUwkj9ID1y4
 05QIRXR/AJC/lVKOY4axWg8//BOkG8fFeVyThEYe1gX6KNx7dlw2Q=
X-Received: by 2002:a05:620a:8396:b0:915:9015:3413 with SMTP id
 af79cd13be357-915a9de9ff4mr1055379485a.57.1780697941473; 
 Fri, 05 Jun 2026 15:19:01 -0700 (PDT)
Received: from cosmos.localdomain ([47.230.224.41])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a238f8esm1020621285a.15.2026.06.05.15.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 15:19:01 -0700 (PDT)
From: Tahsin Ahmed <tahsinahmed217@gmail.com>
Date: Fri, 05 Jun 2026 18:18:49 -0400
Subject: [PATCH] hw/scsi/scsi-bus.c: Change DO_UPCAST(SCSIBus, qbus, dev)
 -> scsi_bus_from_device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-scsi_bus_from_device-v1-1-eac51c49ac43@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMWwqDMBBG4a3IPBtIUiq1WxEJufy2I1Qlo1IQ9
 960ffwezjlIkBlC9+qgjJ2F56nA1BXFp58eUJyKyWrb6EZflURhFzZxQ55fLpUkQt2AS+uN9cE
 kKumSMfD7t+36v2ULI+L6fdF5fgAEPpkzeAAAAA==
X-Change-ID: 20260605-scsi_bus_from_device-8ee39a12ab1d
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 qemu-trivial@nongnu.org, Tahsin Ahmed <tahsinahmed217@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780697940; l=3478;
 i=tahsinahmed217@gmail.com; s=20260603; h=from:subject:message-id;
 bh=7BkQuGEaPY2xhgLih2Ec3juBuQcO/VoNqmU+gPdhET8=;
 b=N77xRvo8AeeKVNn9o2cJAHSy29llpvlD4mKJyaY1xpYusd5DIKKNRWh1SnwkDpko32AS1LhAO
 Q/tlXRZQ5OcCNcYAygVyrTlLQwrlIl2UnZpT36177DpE8bJDSGhl3e9
X-Developer-Key: i=tahsinahmed217@gmail.com; a=ed25519;
 pk=JfqIEYrQSsTnK0suzDJvT1w9PC0wESzl1NHgiFwAMQQ=
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=tahsinahmed217@gmail.com; helo=mail-qk1-x72a.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 05 Jun 2026 19:14:03 -0400
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

Signed-off-by: Tahsin Ahmed <tahsinahmed217@gmail.com>
---
 hw/scsi/scsi-bus.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index dccb2f25b2..ef2f5be0ab 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -233,7 +233,7 @@ static void scsi_device_unrealize(SCSIDevice *s)
 int scsi_bus_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                        size_t buf_len, void *hba_private)
 {
-    SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, dev->qdev.parent_bus);
+    SCSIBus *bus = scsi_bus_from_device(dev);
     int rc;
 
     assert(cmd->len == 0);
@@ -363,7 +363,7 @@ static bool scsi_bus_check_address(BusState *qbus, DeviceState *qdev, Error **er
 static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
 {
     SCSIDevice *dev = SCSI_DEVICE(qdev);
-    SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, dev->qdev.parent_bus);
+    SCSIBus *bus = scsi_bus_from_device(dev);
     bool is_free;
     Error *local_err = NULL;
 
@@ -848,7 +848,7 @@ SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
 SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t tag, uint32_t lun,
                           uint8_t *buf, size_t buf_len, void *hba_private)
 {
-    SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, d->qdev.parent_bus);
+    SCSIBus *bus = scsi_bus_from_device(d);
     const SCSIReqOps *ops;
     SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(d);
     SCSIRequest *req;
@@ -1481,7 +1481,7 @@ int scsi_req_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
 
 void scsi_device_report_change(SCSIDevice *dev, SCSISense sense)
 {
-    SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, dev->qdev.parent_bus);
+    SCSIBus *bus = scsi_bus_from_device(dev);
 
     scsi_device_set_ua(dev, sense);
     if (bus->info->change) {
@@ -1500,8 +1500,7 @@ void scsi_req_unref(SCSIRequest *req)
 {
     assert(qatomic_read(&req->refcount) > 0);
     if (qatomic_fetch_dec(&req->refcount) == 1) {
-        BusState *qbus = req->dev->qdev.parent_bus;
-        SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, qbus);
+        SCSIBus *bus = scsi_bus_from_device(req->dev);
 
         if (bus->info->free_request && req->hba_private) {
             bus->info->free_request(bus, req->hba_private);
@@ -1797,7 +1796,7 @@ void scsi_device_purge_requests(SCSIDevice *sdev, SCSISense sense)
 
 void scsi_device_drained_begin(SCSIDevice *sdev)
 {
-    SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, sdev->qdev.parent_bus);
+    SCSIBus *bus = scsi_bus_from_device(sdev);
     if (!bus) {
         return;
     }
@@ -1819,7 +1818,7 @@ void scsi_device_drained_begin(SCSIDevice *sdev)
 
 void scsi_device_drained_end(SCSIDevice *sdev)
 {
-    SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, sdev->qdev.parent_bus);
+    SCSIBus *bus = scsi_bus_from_device(sdev);
     if (!bus) {
         return;
     }
@@ -1895,7 +1894,7 @@ static int get_scsi_requests(QEMUFile *f, void *pv, size_t size,
                              const VMStateField *field)
 {
     SCSIDevice *s = pv;
-    SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, s->qdev.parent_bus);
+    SCSIBus *bus = scsi_bus_from_device(s);
     int8_t sbyte;
 
     while ((sbyte = qemu_get_sbyte(f)) > 0) {

---
base-commit: 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce0bdc
change-id: 20260605-scsi_bus_from_device-8ee39a12ab1d

Best regards,
--  
Tahsin Ahmed <tahsinahmed217@gmail.com>


