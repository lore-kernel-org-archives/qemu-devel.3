Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D970606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yp7EmgCA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIspY-0005cF-Uj; Mon, 19 Oct 2026 15:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xIspW-0005bv-FM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:15:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xIspT-00027Y-U5
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:15:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJ7Gnb3645533
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 19:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Xz9txx6tsq3fI8PYkS2/1jxQMDh6iJp4Cqm
 3NYUQxBk=; b=Yp7EmgCAYg1sGbl+u4Jrv+Jflg38Prx07gaRUkQf+XWD1WFEsNp
 uUbIa3/soW+M6JqhjE5YNlPK0rm7gCTkxIbTLu59dMXlrh/pzyoUDpbnWDM66oHV
 ry7jr8g6X5IiqvANuR/ZoeHR0buhFJyMO9kSTZCfM2pHfxUs0rYc3pKBdMmmRlMj
 tI//yZGHUuBENiv2/kcsoeOTnD98QItYp21cTnCihO2aY+VjfZcJZ7qAKPJ85E4L
 +nkftvu7IzsmdWGmH6O/2pZb5cvCe/j+UNNjWP5G5BX0qEUMmDmitm6bYo5z/0SK
 iAAJ+k5b0hwIFL77mA//wtr9yK/+7uyOFnQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3xawet-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 19:15:23 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJFNRB1865641; Mon, 19 Oct 2026 19:15:23 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69JJFM881865632
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 19:15:23 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id E4487252A5; Mon, 19 Oct 2026 12:15:22 -0700 (PDT)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH] hw/hexagon: add V73NC_1 machine
Date: Mon, 19 Oct 2026 12:14:59 -0700
Message-ID: <20261019191459.300112-1-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: SfvMhppfxS5HkTARuNbSb6Vf0ptZ50sC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NiBTYWx0ZWRfXxzhf2FMVaemH
 B0cfemrAfhSQGn1Z7+UFJ+0CKc+bdZL+WiOHSWojHxGv6TaJX9Gq9bdH2zfZpwpqQyvuhytScMA
 CLOwoRKoJco2daeNEffo9HRcCXpMLdU=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad66c4b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=ZpTreCGDb18jbhSl3SMA:9
X-Proofpoint-GUID: SfvMhppfxS5HkTARuNbSb6Vf0ptZ50sC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NiBTYWx0ZWRfX+gTFsf6nWeNa
 gxVcpqT+ED3f7adFabWdxsJ3NcrPsO8v75uAYVJzzW6bW4PVvmoaQH2x9DlcJ/Ts1XLhS+4bdzV
 Ybfvq1SgztNCBTsbH14wHv0DkGh4V4jCrQ4FYhOwdK2H/4C/UEXqAOncDlNe/NFE0FLqkxky+Y4
 21/WEgJcL54o/5qpqOKN7GmYKRj2inzzOdLjJdNT1nunAvf0LtJL2bRn9Hg61x7SUMMuNSwEZHq
 N1fbOZGfEf/6Xg66CHOb3cGDDKuDq2gv65W4P5auvse8qDm1Il/TAqDERAde0f57/QNCo9v5OkS
 TkrJma+3APKmqHwuPqludQ09eeoPIO0LVTeAnVIiH616EdAXUwZ09DGU3Hg1Iy+tqno014Atcna
 YUXCt14lEt9qX/E7c4vp2EMngZHa4mMZDulfxsG62xBbbRH9MdhR2xwbuUTVJpjPBKKqoK5WWq2
 GNrTjamO16oyROwS1Uw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 hw/hexagon/hexagon_dsp.c             | 22 +++++++++
 hw/hexagon/machine_cfg_v73nc_1.h.inc | 73 ++++++++++++++++++++++++++++
 include/hw/hexagon/hexagon.h         |  1 +
 3 files changed, 96 insertions(+)
 create mode 100644 hw/hexagon/machine_cfg_v73nc_1.h.inc

diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
index 8824fe10a5..d904d5afa1 100644
--- a/hw/hexagon/hexagon_dsp.c
+++ b/hw/hexagon/hexagon_dsp.c
@@ -30,6 +30,7 @@
 
 #include "machine_cfg_v66g_1024.h.inc"
 #include "machine_cfg_v68n_1024.h.inc"
+#include "machine_cfg_v73nc_1.h.inc"
 #include "machine_cfg_v81dgb_1.h.inc"
 #include "machine_cfg_v81qa_1.h.inc"
 
@@ -200,6 +201,22 @@ static void v68n_1024_init(ObjectClass *oc, const void *data)
     mc->default_cpus = 6;
 }
 
+static void v73nc_1_config_init(MachineState *machine)
+{
+    hexagon_common_init(machine, v73nc_1_rev, &v73nc_1);
+}
+
+static void v73nc_1_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Hexagon V73NC_1";
+    mc->init = v73nc_1_config_init;
+    init_mc(mc);
+    mc->default_cpu_type = TYPE_HEXAGON_CPU_V73;
+    mc->default_cpus = 6;
+}
+
 static void v81dgb_1_config_init(MachineState *machine)
 {
     hexagon_common_init(machine, v81dgb_1_rev, &v81dgb_1);
@@ -258,6 +275,11 @@ static const TypeInfo hexagon_machine_types[] = {
         .parent = TYPE_HEXAGON_DSP_MACHINE,
         .class_init = v68n_1024_init,
     },
+    {
+        .name = MACHINE_TYPE_NAME("V73NC_1"),
+        .parent = TYPE_HEXAGON_DSP_MACHINE,
+        .class_init = v73nc_1_init,
+    },
     {
         .name = MACHINE_TYPE_NAME("V81DGB_1"),
         .parent = TYPE_HEXAGON_DSP_MACHINE,
diff --git a/hw/hexagon/machine_cfg_v73nc_1.h.inc b/hw/hexagon/machine_cfg_v73nc_1.h.inc
new file mode 100644
index 0000000000..729e48975c
--- /dev/null
+++ b/hw/hexagon/machine_cfg_v73nc_1.h.inc
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+static const struct hexagon_machine_config v73nc_1 = {
+    .cfgbase =             0xd8180000,
+    .l2tcm_size =          0x00000000,
+    .l2vic_base =          0xfc910000,
+    .l2vic_size =          0x00001000,
+    .csr_base =            0xfc900000,
+    .qtmr_region =         0xfc921000,
+    .cfgtable = {
+        .l2tcm_base = 0x0000d800,
+        .reserved0 = 0x00000000,
+        .subsystem_base = 0x00002000,
+        .etm_base = 0x0000d819,
+        .l2cfg_base = 0x0000d81a,
+        .reserved1 = 0x00000000,
+        .l1s0_base = 0x0000d900,
+        .axi2_lowaddr = 0x00003000,
+        .streamer_base = 0x00000000,
+        .reserved2 = 0x00000000,
+        .fastl2vic_base = 0x0000d81e,
+        .jtlb_size_entries = 0x00000080,
+        .coproc_present = 0x00000001,
+        .ext_contexts = 0x00000002,
+        .vtcm_base = 0x0000d900,
+        .vtcm_size_kb = 0x00000800,
+        .l2tag_size = 0x00000400,
+        .l2ecomem_size = 0x00000400,
+        .thread_enable_mask = 0x0000003f,
+        .eccreg_base = 0x00000000,
+        .l2line_size = 0x00000080,
+        .tiny_core = 0x00000000,
+        .l2itcm_size = 0x00000000,
+        .l2itcm_base = 0x0000d800,
+        .reserved3 = 0x00000000,
+        .dtm_present = 0x00000000,
+        .dma_version = 0x00000002,
+        .hvx_vec_log_length = 0x00000007,
+        .core_id = 0x00000000,
+        .core_count = 0x00000000,
+        .coproc2_reg0 = 0x00000040,
+        .coproc2_reg1 = 0x00000020,
+        .v2x_mode = 0x00000001,
+        .coproc2_reg2 = 0x00000001,
+        .coproc2_reg3 = 0x00000000,
+        .coproc2_reg4 = 0x00000000,
+        .coproc2_reg5 = 0x00000000,
+        .coproc2_reg6 = 0x00000000,
+        .coproc2_reg7 = 0x00000000,
+        .acd_preset = 0x00000000,
+        .mnd_preset = 0x00000000,
+        .l1d_size_kb = 0x00000010,
+        .l1i_size_kb = 0x00000020,
+        .l1d_write_policy = 0x00000002,
+        .vtcm_bank_width = 0x00000080,
+        .reserved4 = 0x00000001,
+        .reserved5 = 0x00000000,
+        .reserved6 = 0x00000000,
+        .coproc2_cvt_mpy_size = 0x0000000a,
+        .consistency_domain = 0x000000e0,
+        .capacity_domain = 0x00000080,
+        .axi3_lowaddr = 0x00004000,
+        .coproc2_int8_subcolumns = 0x00000002,
+        .corecfg_present = 0x00000001,
+        .coproc2_fp16_acc_exp = 0x00000000,
+        .AXIM2_secondary_base = 0x00004000,
+        .AXIM_data_width = 0x00000000,
+        .l1d_ways = 0x00000000,
+        .l1i_ways = 0x00000000,
+        .l2way_num = 0x00000000,
+        .dma_jtlb_entries = 0x00000000,
+    },
+};
diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
index 9b5d33ffc3..a01cf5cb3b 100644
--- a/include/hw/hexagon/hexagon.h
+++ b/include/hw/hexagon/hexagon.h
@@ -27,6 +27,7 @@ typedef enum {
     v71_rev = 0x8c71,
     v73_rev = 0x8c73,
     v73m_rev = 0xcc73,
+    v73nc_1_rev = 0x8b73,
     v81_rev = 0x8781,
     v81dgb_1_rev = 0xcc81,
 } Rev_t;
-- 
2.43.0


