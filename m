Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C39C624DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2GSl-0006WR-AJ; Thu, 03 Sep 2026 19:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2GSh-0006W1-Bz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 19:03:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2GSf-00036O-Gu
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 19:03:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683JgAK61451454
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 23:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LVlONWyZmSBVJCAo0Rf30qLhQUlyuXkPBBqtG7R9M3I=; b=MvDDfSBSM5L7YYSJ
 6TguggQKBddZxgTH5zPezFGf45uCABls5TL16BXQThW58a/uMVvYQaONYpcL2mF7
 yZF5kVdl2dd+WgB+ZCBCcktbAtuGsQ5kjz/6SyXlXuB25Ouj9B2/2uBP/4rM2S2v
 dgk41lrv0/pMyQcsdoGfOF12dG99/GrzFr6z5JMvXBtgJnbII5aRIzzrzeEZvgbP
 iYB74yEtodBN4QSkJfcZRjpNIBU/pE2DsKv0VtXrOWIIFWzlt4XXVh0gFG2D+ytJ
 RQUkAcTq8bas0nu16ZWN960kzZ1hlw41ASlN2upX/9Sug1+WYmX6+qOxisHs71zA
 FLRQMA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyxh49n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 23:03:12 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c7a3b3c06bso109793e0c.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 16:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788476591; x=1789081391; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LVlONWyZmSBVJCAo0Rf30qLhQUlyuXkPBBqtG7R9M3I=;
 b=DpOCn70Qe6kqYuef7sqYqzWbNX8Mgms8pUAt9+P5UkhaexmKdfZGFmWzWXoFTVwq0q
 Sb2vTGTAtWSbdULKQ+2pY+Q/X0wE1RY6e/Zv6uVOMzGLR3RHBjjjzIq/PX+In8lu4W9n
 hNlWIODgZ60WSZ5ieE6Yg0s1er+0Dtb72OqDpV53WKK/Uoj7j6S1qg8bYo+/xuuuVmKR
 Ygry1KOlEITLHdyhrARKnB8zqA47R3UDamesP8Xj2l1Ns7JYbEJQVHlEz1B5p8cQFzVa
 kCNEzJpD3Y0lipAOxEOHBSTBq8/qqlVO544FiD7nBU1Wwgx21RhqT+J6wfTJjWRcxdEJ
 k3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788476591; x=1789081391;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LVlONWyZmSBVJCAo0Rf30qLhQUlyuXkPBBqtG7R9M3I=;
 b=jUMq5RDCTmXYN09olLjjr0tahiDy7n1bTzg8mrp7FQT/LWDcJpsq6d0BD+498Sxxkv
 D3AllAYEbjOXkGfCquPVQAmSbffvgsJS9zk2T+cOPaEAI9VBISEMFS4kF0viEpE/Yl3q
 xYGrJU3YuwcyHBCYoVjfkv6mgZ03/iuPBibkd0ea6W9hW6I8bnOTOW877hXtMWOk8/F2
 kvrCHJE/p22fbtI9lUsEkAQ6EXzIGDoJR05wvLJnAEIdO275nCd5KFRq3JRGFp2ebDpz
 PPqPQinFUbC7GM2CuM1DqvG47EDMoq0rMWrS4CPYvYydTgYtxsMhNnohIjToPOsT7fvx
 cnJA==
X-Gm-Message-State: AFuF++kkkiMLKxJTxgq/wfWSNsSh4Jx4Mhl+gi/EQQrxk4LVjw3HQPsI
 FSj9vwPEZfJX3sXdicP3IkboGB6LzmveDe1R6jjSdTj5xzP7hZzwhkem0Er2tugfm3VIBukacyJ
 CjB1gTMobRcONn0PRGGsgQtk5a+WMbruzuWVc4Dxv7+DR4fvgwkz84rxygXqKqdPQ9g==
X-Gm-Gg: AYBFou30uVZx9mo7CqNEt/FZvDsUmEAZzo3S1/M+wb8f0iHzLz8XCo5nIY+GqHb7O5c
 ZiVYdMQSiqhV00EzoI6FrrGzoiW0P1jjZtFc/QiXVlfR4U0p2YD3BsYrDElymUTxrxhcF30rjTF
 X2bLOi9aMDwjHlb12YHQqDESwQW33R9aDdgNpP3wbBbB4VtJStJOJquOAULk1VualW7aotOfSsY
 94+cMHxk+74ZchogLVcJaftWUmwv79LVpkVDcASlBuLO8i7KDH6/CxSm0i/8cPnJCYbNfElRUZz
 wyHh9j9YSABiu2SRJVi4OMIwo3LOorxSnMLsgiEhI/a2xT0cU6PbWPtJ1KOfM10yWlV+IWKUKsE
 XcSu9Q2Kbz0CHQ2tFWQVzHFnvPyDrfPd4r3PvxYXi
X-Received: by 2002:a05:6122:29cd:b0:5c5:ac11:9731 with SMTP id
 71dfb90a1353d-5c7ed41c72bmr888144e0c.8.1788476591224; 
 Thu, 03 Sep 2026 16:03:11 -0700 (PDT)
X-Received: by 2002:a05:6122:29cd:b0:5c5:ac11:9731 with SMTP id
 71dfb90a1353d-5c7ed41c72bmr888099e0c.8.1788476590830; 
 Thu, 03 Sep 2026 16:03:10 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6023edsm104256555e9.7.2026.09.03.16.03.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 16:03:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 3/4] hw/hotplug: Reduce some HotplugHandler variables scope
Date: Fri,  4 Sep 2026 01:02:44 +0200
Message-ID: <20260903230245.65601-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903230245.65601-1-philmd@oss.qualcomm.com>
References: <20260903230245.65601-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kpVdJeNZIuuBt-gUygqxkxwbq-J_1th7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDIwMiBTYWx0ZWRfX9o2xyG6fJJjj
 LTYzf4dts9SUdAqgH1YHmV99oFGzqnE2na1yMkEIQ7TpbMMm6btm6Iooid3rFS1RmkZqbRY1FcP
 rDWXQIr+EAwN57BYDQ0USC6SUnTtU+w=
X-Proofpoint-GUID: kpVdJeNZIuuBt-gUygqxkxwbq-J_1th7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDIwMiBTYWx0ZWRfX2rAHb9F9Xm4z
 oSyUzuMntfilzjS+ypm22+qW6QZNtFJocKzazSG/XCPpDbir+c43u6RsVAsyqswGwIbllAxpuR/
 z7traOAs95qjnaklAMtPpCwgWpV1NFRCDFop+p8YYltIsuJKMe0kv1wQ2bYasN1OjeaWXdk9Uj+
 Hu8mBbh6Vx5deP6GuznCuDXpMIWSyPSqwDpp6QWxFMqThYx2/YKhKq6mUN9kB0Y+CdskP9LE1MN
 4BtPdUpwXHabkGC6s2wwK0IfpU0ECYwqEK3d3hC5cI2mdk0HbF6iGfs9Ph/w6deQ6KtyQKwYjTA
 2S0k2MYFRKcdu2id9SxsIgAyAmDVlRVUM6lEk9NeNNU5JX+RfI43jxKUs7mIxZR1DXlbDFD3Ty5
 iJfFH770lW/KJtIihCXDfQdKZfUXWmOVLCM1moj+J8ygIGrb1MmorTKOT2Es5A5CdWhpCkCMhtc
 35AxE+ViNPC4Tad61YA==
X-Authority-Analysis: v=2.4 cv=X9Zi7mTe c=1 sm=1 tr=0 ts=6a99fcb0 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=xzUfFDxNzoYzOMOmWCsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030202
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/acpi/memory_hotplug.c | 3 ++-
 hw/acpi/pcihp.c          | 3 ++-
 hw/pci/shpc.c            | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 1ddfdd17b75..f482c835a1c 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -119,7 +119,6 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
     MemStatus *mdev;
     ACPIOSTInfo *info;
     DeviceState *dev = NULL;
-    HotplugHandler *hotplug_ctrl = NULL;
     Error *local_err = NULL;
 
     if (!mem_st->dev_count) {
@@ -167,6 +166,8 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
             mdev->is_removing = false;
             trace_mhp_acpi_clear_remove_evt(mem_st->selector);
         } else if (data & 8) {
+            HotplugHandler *hotplug_ctrl;
+
             if (!mdev->is_enabled) {
                 trace_mhp_acpi_ejecting_invalid_slot(mem_st->selector);
                 break;
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index b26ddf0a263..336ebe1a13e 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -173,7 +173,6 @@ static bool acpi_pcihp_pc_no_hotplug(AcpiPciHpState *s, PCIDevice *dev)
 
 static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slots)
 {
-    HotplugHandler *hotplug_ctrl;
     BusChild *kid, *next;
     int slot = ctz32(slots);
     PCIBus *bus = acpi_pcihp_find_hotplug_bus(s, bsel);
@@ -210,6 +209,8 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slo
                      */
                     qdev->pending_deleted_event = false;
                 } else {
+                    HotplugHandler *hotplug_ctrl;
+
                     hotplug_ctrl = qdev_get_hotplug_handler(qdev);
                     hotplug_handler_unplug(hotplug_ctrl, qdev, &error_abort);
                     object_unparent(OBJECT(qdev));
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 938602866d7..1198e1ab8c0 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -271,7 +271,6 @@ static void shpc_invalid_command(SHPCDevice *shpc)
 
 static void shpc_free_devices_in_slot(SHPCDevice *shpc, int slot)
 {
-    HotplugHandler *hotplug_ctrl;
     int devfn;
     int pci_slot = SHPC_IDX_TO_PCI(slot);
     for (devfn = PCI_DEVFN(pci_slot, 0);
@@ -279,6 +278,8 @@ static void shpc_free_devices_in_slot(SHPCDevice *shpc, int slot)
          ++devfn) {
         PCIDevice *affected_dev = shpc->sec_bus->devices[devfn];
         if (affected_dev) {
+            HotplugHandler *hotplug_ctrl;
+
             hotplug_ctrl = qdev_get_hotplug_handler(DEVICE(affected_dev));
             hotplug_handler_unplug(hotplug_ctrl, DEVICE(affected_dev),
                                    &error_abort);
-- 
2.53.0


