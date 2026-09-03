Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C842C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24t4-0000Op-19; Thu, 03 Sep 2026 06:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24t2-00008M-2h
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sz-0006ke-Rk
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:39 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH3ZB3720177
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kEBWd/ayFsof74WCIOTxV6+HUGj/T0gNOXc2AnKzipc=; b=LQXDQSmmCQijiMoC
 Hdx1SHi0zPIuR+CGERoeXii0J1tO97dbhscCndt99xokogUKVY18+gWwuF+Iq6Fp
 zqBpqcgYETD5l3BdeP6+pUaKxE0/I/Lrv3idTjA0c+YVCNvWU98wtyPCqSDO036d
 4WDYXaRQf/4JqXcgsr0uzuJffyfsyGv2zPr9FvrQAYyfzKP6oWaeIzmFZEKPF3ab
 w3+fZoMVx4tN41U9lhU8cPva/RQYjdy8B2Wj+v1W44CXj3av9b7K2TteU+W72gmC
 WI/pcXe960jg7vwFRArK49PoPhB7Ntx5qGjbsG9MMMyMo6KSqh7QdJTgNB9UbZ8q
 h3VD9A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf0gjsqdc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:41:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9396e0515dcso58713885a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432095; x=1789036895; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kEBWd/ayFsof74WCIOTxV6+HUGj/T0gNOXc2AnKzipc=;
 b=aJvbsz/jmrN2VTXgcUtZkEd+lcvjdh4b8UTJVpnsi6sp3ZmdgAA0kLGs3Ij6bwRwQJ
 1gbBaccboBNfg3Sz/ioTOCvVGVS6H/0zKH4JU1qurHGuTrjErbw9PnMBEJxiJDSRacYH
 cmcb9uWTPC/FVIAI4SRpbMgKgxxvC9NEQZolhOA1fMnhRhAAyO+qW93rUiEDvoVZoZZ9
 Ps7f7Mv7zqxNYAmZ6zqR8JrsW0skBbHAoasxqBtBRgUJw/Rx1opQ+4Cokw/1YveLMfdq
 zmYF8CXQuMswjuXX1VLieXqjqlH6uSgKYYHVwmn1+o7zuOfEhxFx33l8VXi7Nb/OEmIU
 TSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432095; x=1789036895;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kEBWd/ayFsof74WCIOTxV6+HUGj/T0gNOXc2AnKzipc=;
 b=Ev7JtQ9XcAP7Qd4nXcblez8nARBxQYlw8xZxXqRghCWkXEYhZMEcTVhasINkovx7AX
 vOdQUGJUZ2GfYDvnViF6SSUQXVTi1VaPvscqCDUiki+fhJjKSaI1+NDFOPMw4fjWgrEu
 i+/wPBMTv5JCdxx5214wcQy+Tpt5pQIEr+3pOV6Q9CzPWDHArFF116joSlKDxhMcRaca
 z5/H+BE9+28MkragyJ4b3HuUK2z6t2y9OIze34h9QGkdQ0Mi2xbbp+z4slwDxBr4cyJs
 C8T3kLhLqdpM/Ck15Zd3/6rGSuZQHBqkGrXqI1v2R8g2sGmGYrDMcIq0R8+YwB0WN7xQ
 rWdw==
X-Gm-Message-State: AFuF++mTbFkOi45MD8bcHxX+Fw3YQeLXLOu0zB4A0A+GD+o5MdHD0GvV
 tV7i5AJYJfKj3l7X/boHS6dtjb7RJQm19uOn2coMAJPnBiyy1Jm4uMdjFkbJB/Zuwfz5bpWRtt3
 474V3wwU5kTajAc3QMpHNIhxYp+Zj3sSSj/79+cdoHjHi5pACL7Stm/eTFrQuyY+OFA==
X-Gm-Gg: AYBFou2Bt85QjdwTITqpwIElXa+N6Aej8CE6vXilfTxrCd5Hi+VlUxuxWxw806cSMwa
 dV9bZ5bMqUrxZt2sjlN0utb9aAgLwi02qdu8uOio/2qXvBqDB0RtAHrGcA0LLHEltJp/miXRHV8
 gfYQUTjaRD8CsA3n98+zEQdww6F/owcNaLdz/C0G1k0CZ+94pHWRv5GmLgWzdPlJSFGBXFSXOgE
 7GBhggBTfOfxz4m05GHuFtXMigEuLvyOEJIHrNqGhLxVWSnlxrCH3qAesziA+xNG0vyuNFmY2Q3
 nOL7dxjM4Oadm+bvMynakYwXGuBVXRy/crH1g2dFrRtRkEjsS4/MAENgS83cTOlOaAHE2k5YsBj
 9jNtCwqKwY7GvsVgCKc9KPviKJWnfO4KRLRrX+12o
X-Received: by 2002:a05:620a:7112:b0:939:4890:98f6 with SMTP id
 af79cd13be357-93960f18106mr1328575985a.22.1788432095334; 
 Thu, 03 Sep 2026 03:41:35 -0700 (PDT)
X-Received: by 2002:a05:620a:7112:b0:939:4890:98f6 with SMTP id
 af79cd13be357-93960f18106mr1328571885a.22.1788432094802; 
 Thu, 03 Sep 2026 03:41:34 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4761dd1sm83639875e9.0.2026.09.03.03.41.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:41:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/51] hw/block/pflash_cfi02: Add migration support
Date: Thu,  3 Sep 2026 12:39:00 +0200
Message-ID: <20260903103936.62355-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXwHFk1w+A/k1s
 rIobJ1Ju23lJPdCQt2Z7VeIJf3/FxhRBnSPbDqSUasKg0snkPSJcGIgNT7elGpfVF3nAAeEAJN4
 8BCEodK0IcsHD8annKzlUL8Qvk7SnFEdVIeD77yTfvP5Dedh0ies57XSiLCn/ZAI5f7Vjv8m4F7
 YEgcYBDRMdTSkj45KKptgUD5++/T8aEOzDEDnApAoQICVnxBkLE3wxl82v+zI+Yv2uSaeRjM8Q3
 RkKmUW3WkRfmbtLK66iNDIYZHDnNNV0ziCfPb8FCqe6hEGiQrv8fLiygXWqHkkjUhJwwezPu96F
 zAiZLtqaFC3QtDXct3fAc/PNa5EAM7LvepdLQeNAD66jgNQnyW7poFL0VlUgjQA1wjZBISM+qgL
 cGr4q64jk482nL32GJqcrccONHEPWA74QwtqIWXpHps1aOsV/xoqOvWidEseAME7QM2ZYLwpnR8
 0fGe1k8LlIggK6kb8ZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX4pRrwO8vz0/f
 COgY1Y3I+hAgeYFBWt1lC3L+gQdyCKO1LN/Exy8qDXD2Ekijw8FNXfZO4RApYWgftIGM7pfHZKO
 5RJ5srEsW40kJHnGLiBa5nPyTAZMHfQ=
X-Proofpoint-GUID: BbxemrYbooOHry_RNLG6jpf41CPQtNq_
X-Proofpoint-ORIG-GUID: BbxemrYbooOHry_RNLG6jpf41CPQtNq_
X-Authority-Analysis: v=2.4 cv=LZ4MLDfi c=1 sm=1 tr=0 ts=6a994ee0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=S0GvZrwMS1Fw2x4e3gIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

From: Om Barkare <ombarkare123@gmail.com>

Device did not have migration support, which would result in its
internal state being lost during migration or saves.

Add VMStateDescription to serialize state and set memory regions
romd_mode to rom_mode field in post load hook

total_sectors was changed from uint32_t to int32_t to satisfy the
VMSTATE_BITMAP macro's _field_size argument, but that is OK because
it's a value is calculated using the size of the flash and it will
never be large enough to overflow int32_t

The only boards using pflash_cfi02 are the sh4 r2d and
the arm canon-a1100, musicpal and xilinx-zynq-a9

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4157

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Om Barkare <ombarkare123@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260827193942.69406-1-ombarkare123@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/block/pflash_cfi02.c | 52 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 6f952fe7de0..4f72c438c0c 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -46,6 +46,7 @@
 #include "qemu/module.h"
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
+#include "system/runstate.h"
 #include "trace.h"
 
 #define PFLASH_LAZY_ROMD_THRESHOLD 42
@@ -71,7 +72,7 @@ struct PFlashCFI02 {
     BlockBackend *blk;
     uint32_t uniform_nb_blocs;
     uint32_t uniform_sector_len;
-    uint32_t total_sectors;
+    int32_t total_sectors;
     uint32_t nb_blocs[PFLASH_MAX_ERASE_REGIONS];
     uint32_t sector_len[PFLASH_MAX_ERASE_REGIONS];
     uint32_t chip_len;
@@ -107,6 +108,29 @@ struct PFlashCFI02 {
     unsigned long *sector_erase_map;
     char *name;
     void *storage;
+    VMChangeStateEntry *vmstate;
+};
+
+static int pflash_post_load(void *opaque, int version_id);
+
+static const VMStateDescription vmstate_pflash = {
+    .name = "pflash_cfi02",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = pflash_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(wcycle, PFlashCFI02),
+        VMSTATE_INT32(bypass, PFlashCFI02),
+        VMSTATE_UINT8(cmd, PFlashCFI02),
+        VMSTATE_UINT8(status, PFlashCFI02),
+        VMSTATE_TIMER(timer, PFlashCFI02),
+        VMSTATE_BOOL(rom_mode, PFlashCFI02),
+        VMSTATE_INT32(read_counter, PFlashCFI02),
+        VMSTATE_INT32(sectors_to_erase, PFlashCFI02),
+        VMSTATE_UINT64(erase_time_remaining, PFlashCFI02),
+        VMSTATE_BITMAP(sector_erase_map, PFlashCFI02, 1, total_sectors),
+        VMSTATE_END_OF_LIST()
+    }
 };
 
 /*
@@ -976,6 +1000,7 @@ static void pflash_cfi02_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, pflash_cfi02_reset);
     dc->unrealize = pflash_cfi02_unrealize;
     device_class_set_props(dc, pflash_cfi02_properties);
+    dc->vmsd = &vmstate_pflash;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
@@ -1028,3 +1053,28 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     return PFLASH_CFI02(dev);
 }
+
+static void postload_update_cb(void *opaque, bool running, RunState state)
+{
+    PFlashCFI02 *pfl = opaque;
+
+    /* This is called after bdrv_activate_all.  */
+    qemu_del_vm_change_state_handler(pfl->vmstate);
+    pfl->vmstate = NULL;
+
+    trace_pflash_postload_cb(pfl->name);
+    pflash_update(pfl, 0, pfl->chip_len);
+}
+
+static int pflash_post_load(void *opaque, int version_id)
+{
+    PFlashCFI02 *pfl = opaque;
+
+    if (!pfl->ro) {
+        pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb, pfl);
+    }
+
+    memory_region_rom_device_set_romd(&pfl->orig_mem, pfl->rom_mode);
+
+    return 0;
+}
-- 
2.53.0


