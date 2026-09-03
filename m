Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88BFC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2GSb-0006VS-8N; Thu, 03 Sep 2026 19:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2GSZ-0006Uc-0u
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 19:03:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2GSX-00035q-9r
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 19:03:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683Jgtce1692613
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 23:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3MPFKXf4YignzYvD3Y/Ro//GDCgsEdMkXUvpHh7r+ps=; b=ezVJB0Hyd/ilybaI
 g7ewAKAganOK6ZH8ub5KCS9mNdolQwEIAPM85Z48MM2XSrp0Oh5Fl1XbJjzHJE0v
 MBUszwZPJVGYdM9AwOVlwTYDWjyrjCo3N1BJpPaV0KtoSlPIODkLWpReL+Gbr299
 JjZvgeDgOs6zITtyvpwagv6Tm9SmnZJ5nbg7BIJi+zUE9LGygi+XBpPaVqGv5FcS
 NUFENTYOfb47QeErcX14QLNIS+ejihdm3+yjA0yRfnJ74nKXQ5wbG1Oo5/pHS54f
 ZgdwMZ+Hla2Vudc2AcKQTPsF60B2ZMVdaAOK8IuEN2RR3RpLWMwCNLfRV5WZ5M+6
 sqsi0w==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6p73ckf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 23:03:04 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-78350646d7eso1257017137.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 16:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788476583; x=1789081383; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3MPFKXf4YignzYvD3Y/Ro//GDCgsEdMkXUvpHh7r+ps=;
 b=b824s9PfyHNRP2y1tF188l/IdWr0XMmUapuUusXYrvwVkGmezSxwlzr2w1PImu3wnn
 PTTjet+/kBzk+NAtaOt1r/Px3+VnV0Ye0KBI/jmYuIneneR684p3CmVZkiBFaRYYhThb
 8gUXdMNxeHELgiqufo2qK05JSlyV0CU7PcCCIDfAxWDP+DsaCG/wWtRR5rQGNOb9yesC
 hg0K9pPZdyVLTm9sVkODHKxgdOLvPAxtCZORmdgE0srUp1p7qTcSumFUFfpRVnx1/TSr
 hYsfom3zEJY2246lqgyQw+MrvYXFZ3UinQRB1M0pzOrhETAfFj7QarplK/JkBZQGcV9R
 T8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788476583; x=1789081383;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3MPFKXf4YignzYvD3Y/Ro//GDCgsEdMkXUvpHh7r+ps=;
 b=clK7yg5udtBQoWNjEZeb3ZSxk8AQEyNC2BfjcBBVTA0xJG8GenSgwhVTN4UHGr2gu7
 fAkVj4nBzit0ImbGPl6eEOVZdHU+UyxwTG1gAxgO2ue0MffhtU58qwpg3BlGF75JQxnH
 ClJQr3DWxCzSbOVsOPeQ0sR8oKJeooZRfXWtTkCiBGe11/0FaY+fggEstlO/zzJp4MY3
 mm5zEU2ehhp6F759ri+CW/I1h3hK2lIqcPKteEptLgv158WbgXqmryqyz3zzYKOhLVqZ
 ydMPIKEvsLnVFh/5cPYPNy3/gddHHqbjO2bur1c08EfwqJKzAqYnehFmkm7QZwk6zqIf
 t/ZA==
X-Gm-Message-State: AFuF++nNJeyWiB9QzugwTf+aU9lkP/pXVBua13QBCVLXfFav5RIjPMWs
 IxHFVIvxF8cxS6Stb3giqicmivEVJc8PQedrUypXvo+TkzzSUidO+FKrdDtosL0MSPriDeqEbMe
 tFsImSpuWs40vsFtEVVTh9mlmR4OhZ8bGSW4hgRguO81snoapbbZslHLS2EfW13BhgQ==
X-Gm-Gg: AYBFou1BKzlL+noVcUXePSXHOXSs2Zyh2JLUDuqe/iL7srtytGtv/OvVxHLwWHjvbx6
 Kk+HhU/9RpwbJZDeV7Q5CsktmurZi82mEaE8nU1OPBE1RW5+2gl6khC3SXma1q/Mdj4vbXHUyoK
 7uilUX8Vov1v9cfJU3LIOwMOHydgrIYgnuG9Y2JrYuBmR16rMbp2cwIRyE7so3T8hhCLZekAmU4
 UTAlJZdyM+qTSx1JFV4dchc/38t4MktKChCA1IR/326Jmf8MgpLZCf0qQMeZ1GVV5M3K6UyIRbg
 WJcZSI8dfGDNeYUb9GDQM8aEJbhkuhIYARnNDKHdpP3mbPxh1QEyyUDclDHEDSda+A/lnvvNFNb
 8Or6LEtKqeeok2b/MPkq++p0t4j41O7hDaHuZ69vB
X-Received: by 2002:a05:6102:cb:b0:784:a925:3f0c with SMTP id
 ada2fe7eead31-78a2ea9acfcmr1818162137.0.1788476583374; 
 Thu, 03 Sep 2026 16:03:03 -0700 (PDT)
X-Received: by 2002:a05:6102:cb:b0:784:a925:3f0c with SMTP id
 ada2fe7eead31-78a2ea9acfcmr1818152137.0.1788476582948; 
 Thu, 03 Sep 2026 16:03:02 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60d9c6sm108296875e9.11.2026.09.03.16.03.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 16:03:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 2/4] hw/hotplug: Mark various HotplugHandlerClass variables as
 const
Date: Fri,  4 Sep 2026 01:02:43 +0200
Message-ID: <20260903230245.65601-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903230245.65601-1-philmd@oss.qualcomm.com>
References: <20260903230245.65601-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: B_nRzovh1C6buK16LeOyQtOBGeLU-oiU
X-Proofpoint-ORIG-GUID: B_nRzovh1C6buK16LeOyQtOBGeLU-oiU
X-Authority-Analysis: v=2.4 cv=OZyoyBTY c=1 sm=1 tr=0 ts=6a99fca8 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=kHeIkJ-FKRoZ7ECofzEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDIwMiBTYWx0ZWRfX2ph0yv7CKEG9
 RrXgmyY0jNklajGecTKlDp32GDmXtA4kYpmFMw+DJePTXG/U8xChwSDHTro9/CLE5IWdD/cCppD
 Pzj8iYN/Y5Z6rESIS6xs1wmDRZXAFok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDIwMiBTYWx0ZWRfXwAGhbKmhrlcq
 bteiPJriqX4gM+gt9+8423xzgSMlL8Z48IFvamaAJ05DYoEdSUdb5dnQerinI1saY18j/6Fx63w
 QbluQ5feyUmUzRO8/6Kicv5B/0WUoXyG13iaNeth2VYCrmmMivpl5VR4TC+BLX2Ty/jxPMFecu/
 LlYIYm7oGPIcgdNwRMEi3JXZvwdtqkCtEgDq6h8M6mwTooii6ZDO2+ESOcgYpnUeJ4x5fYAkI6U
 aKjnKOvn/lWvBvSt1fCwRizicpCgckiNS+PYR0t/UQlQYyIGMKgjRqwJ9aEGOP74owCopFeTChE
 ccYjaTe+QGJ4JnnxW9vUDG66TjukiJ7n4Cz/tc8uXtR1IL3aGrNO3LKgPuiqQtzSlptbOH3fwZ5
 qrZcxvu3+T/wLlflifisoY4JmFWJSdpPPUp97xjOvb6QUjnikxkeZUDHnPyoW/7XezH/Qlvd65V
 VkUu9jrNI+/9G4N7e1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030202
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

The HotplugHandlerClass pointers are only dereferenced, not updated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/qdev.h    | 2 +-
 hw/core/hotplug.c         | 8 ++++----
 hw/s390x/virtio-ccw-md.c  | 2 +-
 hw/virtio/virtio-md-pci.c | 2 +-
 system/qdev-monitor.c     | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index f054a214fc6..e4cb027ab3a 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -1069,7 +1069,7 @@ static inline bool qbus_is_hotpluggable(BusState *bus)
     bool ret = !!plug_handler;
 
     if (plug_handler) {
-        HotplugHandlerClass *hdc;
+        const HotplugHandlerClass *hdc;
 
         hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
         if (hdc->is_hotpluggable_bus) {
diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
index 68aabad8ae0..00e80a67c80 100644
--- a/hw/core/hotplug.c
+++ b/hw/core/hotplug.c
@@ -17,7 +17,7 @@ void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
                               DeviceState *plugged_dev,
                               Error **errp)
 {
-    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+    const HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
 
     if (hdc->pre_plug) {
         hdc->pre_plug(plug_handler, plugged_dev, errp);
@@ -28,7 +28,7 @@ void hotplug_handler_plug(HotplugHandler *plug_handler,
                           DeviceState *plugged_dev,
                           Error **errp)
 {
-    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+    const HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
 
     if (hdc->plug) {
         hdc->plug(plug_handler, plugged_dev, errp);
@@ -39,7 +39,7 @@ void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
                                     DeviceState *plugged_dev,
                                     Error **errp)
 {
-    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+    const HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
 
     if (hdc->unplug_request) {
         hdc->unplug_request(plug_handler, plugged_dev, errp);
@@ -50,7 +50,7 @@ void hotplug_handler_unplug(HotplugHandler *plug_handler,
                             DeviceState *plugged_dev,
                             Error **errp)
 {
-    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+    const HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
 
     if (hdc->unplug) {
         hdc->unplug(plug_handler, plugged_dev, errp);
diff --git a/hw/s390x/virtio-ccw-md.c b/hw/s390x/virtio-ccw-md.c
index 0370f584505..0b18b49bc48 100644
--- a/hw/s390x/virtio-ccw-md.c
+++ b/hw/s390x/virtio-ccw-md.c
@@ -73,7 +73,7 @@ void virtio_ccw_md_unplug_request(VirtIOMDCcw *vmd, MachineState *ms,
     VirtIOMDCcwClass *vmdc = VIRTIO_MD_CCW_GET_CLASS(vmd);
     DeviceState *dev = DEVICE(vmd);
     HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
-    HotplugHandlerClass *hdc;
+    const HotplugHandlerClass *hdc;
     Error *local_err = NULL;
 
     if (!vmdc->unplug_request_check) {
diff --git a/hw/virtio/virtio-md-pci.c b/hw/virtio/virtio-md-pci.c
index 9278b32cf84..aa5b11c0f60 100644
--- a/hw/virtio/virtio-md-pci.c
+++ b/hw/virtio/virtio-md-pci.c
@@ -72,7 +72,7 @@ void virtio_md_pci_unplug_request(VirtIOMDPCI *vmd, MachineState *ms,
     VirtIOMDPCIClass *vmdc = VIRTIO_MD_PCI_GET_CLASS(vmd);
     DeviceState *dev = DEVICE(vmd);
     HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
-    HotplugHandlerClass *hdc;
+    const HotplugHandlerClass *hdc;
     Error *local_err = NULL;
 
     if (!vmdc->unplug_request_check) {
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 5c87fda5093..0c5502d45b6 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -918,7 +918,7 @@ static DeviceState *find_device_state(const char *id, bool use_generic_error,
 void qdev_unplug(DeviceState *dev, Error **errp)
 {
     HotplugHandler *hotplug_ctrl;
-    HotplugHandlerClass *hdc;
+    const HotplugHandlerClass *hdc;
     Error *local_err = NULL;
 
     if (!qdev_hotunplug_allowed(dev, errp)) {
-- 
2.53.0


