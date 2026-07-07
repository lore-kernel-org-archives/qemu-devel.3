Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078AFC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eT-0004Jv-NZ; Tue, 07 Jul 2026 09:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dc-00038Y-27
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5dW-0000bJ-9V
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:14:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C93uR3590163
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MQ8cwo67B8kScl6kCnX4SGCllu3hPViC4NEXHKyhSy8=; b=XQy8beQsugV9pTMu
 zHs9gMw+DQ50ez9+VTu5/0KidEV26rFy3p3IYhghdTWGRVddT6S/1yJm3LNLc3Ag
 uYZ7BfrHjHSzI3SqG4zekVcQrH6hrmgkWB8Yogh/KuYV2gy8S9N4HLF8OakJmhZB
 rXKfg1zwyJ4bLvoLL27PODd6/jr/y1Q+OYp/NA0pjJrUwJhVRH05GsOT9WhoVHPW
 jY5asIXYWisuxrN6AqFUtezT2ab5p1j5g76T251eBLcrkzl9dnQ6HCY3MmIQ77O0
 6glhghMHWdIssB5TgTWsM7MGnrjTRxz34qKjQkyBx+fs5Hlz4tTEJFdp7IlehAFa
 ZJwyag==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2u9bp6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:14:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso72772091cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430090; x=1784034890; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MQ8cwo67B8kScl6kCnX4SGCllu3hPViC4NEXHKyhSy8=;
 b=EUZI1KC+j56mzzQBZs7mdZq48uULEo11j2rNAt/aNpaFoUX7uNNBYEbBHsxyXiD65J
 YwDokPtTBnx1JX1oLmtrTe9ElZ1BAt28WPn+1+xuaPoIEs+9Qm8XkkkC5+YoFHvKPjbn
 J7Li6T8mqpBN5dF0/tk9wxUfgoxtKO46ZqbRWOEd+TsdUp6PMPNLqj0IO1rI1/O2mg7r
 bS7F/mn7u8ADaPaxr5GexnFR6O7JhKkzr7NeI0hd1fNmLP0qkHbaH+qUWcgBlHyB14tJ
 JbHmgVVJIAmkiyZekE1YjdE5e+PjxOwFshU1keLLvXZI3N8A5AbdScijACREEy3lIeVI
 kx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430090; x=1784034890;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MQ8cwo67B8kScl6kCnX4SGCllu3hPViC4NEXHKyhSy8=;
 b=P2dlUiXRB8RdyN+s9ogk/q/qpibCe2bcvfgZzcq6rEeT0sjKIXPc/uvyO82UAjxfzZ
 +jubhiCLRv6AA0hDceZJZBlPXi3fTUcSZQkLnrZ9o2uxZggXb6HTUsz4aIhmzMBBVZls
 M6Bzb09tCAl5cCY+/iD7SRfNyV/YAK7payM8IBETdliGschRftgvpWBdSbArNGm61fL5
 7a2HvCUcJkUkUrj1wMnV8zYkW4qWfSOHF5CAM/Db/AGdcoSD2RzsiZjhNCU63ZTohXSz
 TXaDcPCJFkLFJUy2EUcd/6C83rR/yLYZI3zSr5JvpvEb+A77nmwdWn1ZP2VdIOh5E2O7
 tFrQ==
X-Gm-Message-State: AOJu0YxjfTCfCzexHDogVAJU5ughFoOgaU0S0GY+cbvu8wMXp7McGsfi
 0iTXAnE5tn91h4gO3sd9ANUx1mzeecshjnLX381ANQNBAvNabgML4pPh03ySd0MA/IQ6S+RFr8D
 2fU6+ILoqNdJvHsRcGwi7/u5Mp0ARbYyBt/k73/8CMup22aLX5fv6rz2ONLkzNjAElQ==
X-Gm-Gg: AfdE7clZvzIjjSTD3eJLGbpGwr9s7rNqzE1ApliDhQX6GcwF8M5ocbV/hUStM/+xW+r
 Hr9XR1FMdOlXt8EORqpJcQYayB9KHF56WC3Snz2dh09FhmAruRhJJTAWaZlVNSxV/O1EJ9RZtli
 09Fk7IYJidZYDRbbpwnplYSIM5aQ8udrVyvLYu9gcap6dnJ+HEuKV+0xWVLnVUL7j/yY4lFvI1e
 Ko3V/ZwNCKAmJyHdO5D9YW3DE+/PPYJlRxxD4uZLC+ptS7TcFBdeeGoBkzTb2h+zo56POWMPjRB
 3uyyN00zUR1jQoDqSGiXebosIlaENqiY1qkF+VfbRGjBJNs7Al63Nq1WEGU54tF5H+kpj0V4viT
 kMmxfvO3AkezLrQrs1zXoZeC0CNtv2idA01TkK/lBzgO8eUaDK/o1ki8Vw1SuJQudaMkR
X-Received: by 2002:ac8:5e4a:0:b0:51c:2685:2964 with SMTP id
 d75a77b69052e-51c7487fd08mr50987411cf.43.1783430089407; 
 Tue, 07 Jul 2026 06:14:49 -0700 (PDT)
X-Received: by 2002:ac8:5e4a:0:b0:51c:2685:2964 with SMTP id
 d75a77b69052e-51c7487fd08mr50986261cf.43.1783430088026; 
 Tue, 07 Jul 2026 06:14:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad9be41esm137511466b.39.2026.07.07.06.14.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:14:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/32] hw/arm/imx8mp-evk: Introduce FslImx8mpEvkState
Date: Tue,  7 Jul 2026 15:12:10 +0200
Message-ID: <20260707131223.51505-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX+Ldxdigasy7w
 +iM0iYrdj5dCdxkghc+t7T2je7Zcsaic4J1BS+kN+VuKVPPBbu7EtTqUjCil/DsUSoFqLSXxB06
 llYEYYzFMJHr0DrYA9VkZe31bIBgloI=
X-Proofpoint-GUID: EU2WoTvIEHtkajqX4dzosktQ8CuOmgg-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX/gu5FXyi8fId
 dm2R+QPLrqcUMkCNw1uJMj+nMfmFBaWFRa4VUMiYmhTI5HMCKAyzcPbvmilhku5evgOustp/Z5t
 X9Ec9TXpfptVMEku5ZCgXMboY74Xx31eiHmvoS0DEh+7DceHE2ftV2sPhR9hqSu0fTDFfBU1zPA
 1gI4LyGSEEf9nZGjcwYwbmxbClYMKtoXUhG5jtlDVSVwNwBeJ6KXTM5kdMKqa9QYJUZ+dD5bn4l
 dLFagWhnQmQRkufgsuLDLP2ZByxg4GvlrrtZWvgYswF3spxv8AtTjiewEGZw8IMcJE5qZ5mlR9+
 quxAWEkYbnPzZh1uTc34p1PYYtEqEf7mK4XJQL7e1xdt8j3q0HkLLXGag3r4MW0Tcv8+wArdiF5
 +ewXuDqfurzn16AfF+2ryBfNTUdJZGLy71+2DW2v5/ezGAmF7kLG2Pt6RzSdVhPzG/tHKaXTfBR
 BVI6HsLVpVw/GBEUieQ==
X-Proofpoint-ORIG-GUID: EU2WoTvIEHtkajqX4dzosktQ8CuOmgg-
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4cfbca cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=v0UstXECslOuxGkfbp0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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

From: Bernhard Beschow <shentey@gmail.com>

Introduce class FslImx8mpEvkState which will be needed for holding
CanBusState attributes and associated properties.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Message-ID: <20260702184038.178196-5-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/imx8mp-evk.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 4a0c9df76b7..ca0ee2d3f2e 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -19,6 +19,17 @@
 #include "qapi/error.h"
 #include <libfdt.h>
 
+#define TYPE_IMX8MPEVK_MACHINE MACHINE_TYPE_NAME("imx8mp-evk")
+OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpEvkState, IMX8MPEVK_MACHINE)
+
+struct FslImx8mpEvkState {
+    MachineState parent_obj;
+
+    FslImx8mpState soc;
+
+    struct arm_boot_info boot_info;
+};
+
 static void imx8mp_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
 {
     int i, offset;
@@ -57,8 +68,7 @@ static void imx8mp_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
 static void imx8mp_evk_init(MachineState *machine)
 {
-    static struct arm_boot_info boot_info;
-    FslImx8mpState *s;
+    FslImx8mpEvkState *s = IMX8MPEVK_MACHINE(machine);
 
     if (machine->ram_size > FSL_IMX8MP_RAM_SIZE_MAX) {
         error_report("RAM size " RAM_ADDR_FMT " above max supported (%08" PRIx64 ")",
@@ -66,7 +76,7 @@ static void imx8mp_evk_init(MachineState *machine)
         exit(1);
     }
 
-    boot_info = (struct arm_boot_info) {
+    s->boot_info = (struct arm_boot_info) {
         .loader_start = FSL_IMX8MP_RAM_START,
         .board_id = -1,
         .ram_size = machine->ram_size,
@@ -74,10 +84,9 @@ static void imx8mp_evk_init(MachineState *machine)
         .modify_dtb = imx8mp_evk_modify_dtb,
     };
 
-    s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
-    object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX8MP);
+    object_property_set_uint(OBJECT(&s->soc), "fec1-phy-num", 1, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
                                 machine->ram);
@@ -93,14 +102,14 @@ static void imx8mp_evk_init(MachineState *machine)
         }
 
         blk = blk_by_legacy_dinfo(di);
-        bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
+        bus = qdev_get_child_bus(DEVICE(&s->soc.usdhc[i]), "sd-bus");
         carddev = qdev_new(TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->cpu[0], machine, &boot_info);
+        arm_load_kernel(&s->soc.cpu[0], machine, &s->boot_info);
     }
 }
 
@@ -128,9 +137,10 @@ static void imx8mp_evk_machine_class_init(ObjectClass *oc, const void *data)
 
 static const TypeInfo imx8mp_evk_machine_types[] = {
     {
-        .name = MACHINE_TYPE_NAME("imx8mp-evk"),
+        .name = TYPE_IMX8MPEVK_MACHINE,
         .parent = TYPE_MACHINE,
         .class_init = imx8mp_evk_machine_class_init,
+        .instance_size = sizeof(FslImx8mpEvkState),
         .interfaces = aarch64_machine_interfaces,
     },
 };
-- 
2.53.0


