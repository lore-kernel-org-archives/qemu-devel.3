Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1037CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI2i-0007Vr-60; Mon, 01 Sep 2025 23:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2K-0006Tp-FX
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2F-0004vV-LO
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:22 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Sutq011396
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YdvU/mxz3xVNNr/3bVkbSg1EtfkUXL/XkaPTNSCNu7I=; b=azer051lKuUyYF/y
 goaASAirCppoL/ru+Fu8cBa/UUa4TAIRqwYOF4ChaZnto0xtkt8RlSU8bulwj1uH
 Mb6BdW89aUtPvx2gLUvkQLNbBNX/39Ce4paT0TabliOXfytQ8l3eZXlxKifIO8yz
 3582ECIHPs4c2OnAZhgasrSpwoUr/rJJpQ8N3jCayXGFm4TKkAxEGt/2svbK1YEB
 GsnpBWwEjjrfgUNHQW/nu/XXLLV0M/4T+tRpXYuKlI2bSKc8iWeQhDrECzFAyVMP
 z68gWMtgApaEZ5HHa1JAhHTKt4fDALNnrSX52j9gUbqXqXB6asU8EyTHobOjPEAJ
 fn0Yvg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjedct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:50:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-329e1e3b25bso318868a91.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785007; x=1757389807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YdvU/mxz3xVNNr/3bVkbSg1EtfkUXL/XkaPTNSCNu7I=;
 b=p9SWvAbFDCcouQTJz+ZsfNTA8i/hSaF8UivORXVDnk5dgnY1JEvZS97ItBwBXVcdrm
 UoYzRjywLjdKon6OJOqrq+CkBaO032pYOYYOhQ4XOwO1H/YOjxkU7hABjwelDVJYyhZ1
 9GYW1WKt1TRR+1ZEwwjn70LQDAlc0uOSOv2MnydJovuUN4O+5ZhVk4QmKjKx/Vyef10v
 dT7pPhMQBIBPRhnI7Njkh4+NMY27PoYHwFDGz93y847K9yK3CGpUPLr3ZmiIFKe/zIGn
 LDAEvboMABHHOEjR0lX2SwVAU1afu9kO2SDGECIPeji4aw9SUYTlnyQ3mUvQKSxKCilz
 1bZg==
X-Gm-Message-State: AOJu0YysiBxhp3xPJSXb2DEaWUweYR+H028VGS2ZOO6FBGDvHJwMVvvP
 S9b64el7TB1gloRAr16op2J66Iz4RRKS+vT4UbFuHEzNxSEU1hMh6ODk1GXn5ee58KsQ790y+QZ
 5G25C2FXL+DhSssxdaIo3Zdr2b1JV/xKyVP0eIAtVmuZHz57jX/0hIzXojdHSHdYJBB0X
X-Gm-Gg: ASbGncs/FQVB5g/36X3QJJ9qwcMaz890fhjQKrc1nprjFoiinfRafhyu+xB84taHi1c
 qBs/yuakIswbMed2CyyLHPyV7reUOwFKLrfHZrh8KqkdfvXztZNNxrluav0nGi5F1vKwbwDWqX2
 Pu1e+/PHHKjv/YuWYL4xnj2V/Q8wXbftqszjGN96I4WNRc8Mvn8VBKUtOSNQYBA3+Zx23Y9ybR9
 S1uZDtFUZMIMG8fC7O3qmdBCdtelBL8Fd4dMuGw9YgqOqwsitq0pqYxf1lmfLhfXcbOshPMP3nF
 FOaZOI/GPtmiPeOKr1Niigj+pMJvgFMee+HmXdyA2O2IzCpo4GIegQcuumYk+SrJOFVCSGV8ykH
 mq4u0kytM70ZB
X-Received: by 2002:a17:90b:5810:b0:329:e407:b53c with SMTP id
 98e67ed59e1d1-329e407b781mr742903a91.5.1756785006967; 
 Mon, 01 Sep 2025 20:50:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdhZKEDYYS9AsjBnbzh20PX06x4xaIyzQp32JwvEuk0ly5CrSYgVW9e0FiXEveYxwUIFGsEA==
X-Received: by 2002:a17:90b:5810:b0:329:e407:b53c with SMTP id
 98e67ed59e1d1-329e407b781mr742879a91.5.1756785006458; 
 Mon, 01 Sep 2025 20:50:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327c5fc5055sm14117932a91.14.2025.09.01.20.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:50:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 04/11] hw/hexagon: Add v68, sa8775-cdsp0 defs
Date: Mon,  1 Sep 2025 20:49:44 -0700
Message-Id: <20250902034951.1948194-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
References: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b66970 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=Y0VZbjsYLljPqHOwCnMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ChLDKCXFpukq_W791OeKlhB1YtvIX3x_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX7LRr42FZkeG0
 kbQ5tg4IIzG/nvVjij+atyQexMNzEL7tafqaIcGcaa8FtRlHwxOb0GTuFcQWjeB/xmBX4g9nq5t
 mwZyEL5KW/yoAWFvhmAadKbfYZDPULZfhcnakwnfnTRBNNqEqtNm8/tgdYZn+dzIhTDziFhlQ3I
 nqUCxi1IueJkJyQnp0kUS3L6yegeu60pKvby6CE4bEVf/D4zKM/vyJemRXe4OSCVc2Qd8dRKBA2
 TqRgMq7GgXoUgocr0sCKqxKxV10ViSctKEq8QQpt3Y+gDMhAKAK56hylZ7x9i36f8sOGja0CqM7
 DKWsga6W9FTQ1Dg1aPFvIRK6WBJFOt4ebk0UlohKORpChfKu44O9WHeQF6VpHGwQhVw0f394YeU
 TZm+Oogl
X-Proofpoint-ORIG-GUID: ChLDKCXFpukq_W791OeKlhB1YtvIX3x_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Acked-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc | 63 ++++++++++++++++++++++
 hw/hexagon/machine_cfg_v68n_1024.h.inc    | 64 +++++++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
 create mode 100644 hw/hexagon/machine_cfg_v68n_1024.h.inc

diff --git a/hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc b/hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
new file mode 100644
index 0000000000..70b1eabfe9
--- /dev/null
+++ b/hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
@@ -0,0 +1,63 @@
+
+static hexagon_machine_config SA8775P_cdsp0 = {
+    .cfgbase =         0x24000000 + 0x180000,
+    .l2tcm_size =      0x00000000,
+    .l2vic_base =      0x26300000 + 0x90000,
+    .l2vic_size =      0x00001000,
+    .csr_base =        0x26300000,
+    .qtmr_region =     0x26300000 + 0xA1000,
+    .cfgtable = {
+        .l2tcm_base = 0x00002400,
+        .reserved0 = 0x00000000,
+        .subsystem_base = 0x00002638,
+        .etm_base = 0x00002419,
+        .l2cfg_base = 0x0000241a,
+        .reserved1 = 0x0000241b,
+        .l1s0_base = 0x00002500,
+        .axi2_lowaddr = 0x00000000,
+        .streamer_base = 0x00000000,
+        .reserved2 = 0x00000000,
+        .fastl2vic_base = 0x0000241e,
+        .jtlb_size_entries = 0x00000080,
+        .coproc_present = 0x00000001,
+        .ext_contexts = 0x00000004,
+        .vtcm_base = 0x00002500,
+        .vtcm_size_kb = 0x00002000,
+        .l2tag_size = 0x00000400,
+        .l2ecomem_size = 0x00000000,
+        .thread_enable_mask = 0x0000003f,
+        .eccreg_base = 0x0000241f,
+        .l2line_size = 0x00000080,
+        .tiny_core = 0x00000000,
+        .l2itcm_size = 0x00000000,
+        .l2itcm_base = 0x00002400,
+        .reserved3 = 0x00000000,
+        .dtm_present = 0x00000000,
+        .dma_version = 0x00000003,
+        .hvx_vec_log_length = 0x00000007,
+        .core_id = 0x00000000,
+        .core_count = 0x00000000,
+        .coproc2_reg0 = 0x00000040,
+        .coproc2_reg1 = 0x00000020,
+        .v2x_mode = 0x00000001,
+        .coproc2_reg2 = 0x00000008,
+        .coproc2_reg3 = 0x00000020,
+        .coproc2_reg4 = 0x00000000,
+        .coproc2_reg5 = 0x00000002,
+        .coproc2_reg6 = 0x00000016,
+        .coproc2_reg7 = 0x00000006,
+        .acd_preset = 0x00000001,
+        .mnd_preset = 0x00000000,
+        .l1d_size_kb = 0x00000010,
+        .l1i_size_kb = 0x00000020,
+        .l1d_write_policy = 0x00000002,
+        .vtcm_bank_width = 0x00000080,
+        .reserved3 = 0x00000001,
+        .reserved4 = 0x00000000,
+        .reserved5 = 0x00000003,
+        .coproc2_cvt_mpy_size = 0x0000000a,
+        .consistency_domain = 0x000000e0,
+        .capacity_domain = 0x00000080,
+        .axi3_lowaddr = 0x00000000,
+    },
+};
diff --git a/hw/hexagon/machine_cfg_v68n_1024.h.inc b/hw/hexagon/machine_cfg_v68n_1024.h.inc
new file mode 100644
index 0000000000..257c133df8
--- /dev/null
+++ b/hw/hexagon/machine_cfg_v68n_1024.h.inc
@@ -0,0 +1,64 @@
+
+static hexagon_machine_config v68n_1024 = {
+    .cfgbase =           0xde000000,
+    .l2tcm_size =        0x00000000,
+    .l2vic_base =        0xfc910000,
+    .l2vic_size =        0x00001000,
+    .csr_base =          0xfc900000,
+    .qtmr_region =       0xfc921000,
+    .cfgtable = {
+        .l2tcm_base = 0x0000d800,
+        .reserved0 = 0x00000000,
+        .subsystem_base = 0x0000fc90,
+        .etm_base = 0x0000d819,
+        .l2cfg_base = 0x0000d81a,
+        .reserved1 = 0x00000000,
+        .l1s0_base = 0x0000d840,
+        .axi2_lowaddr = 0x00003000,
+        .streamer_base = 0x0000d81c,
+        .reserved2 = 0x0000d81d,
+        .fastl2vic_base = 0x0000d81e,
+        .jtlb_size_entries = 0x00000080,
+        .coproc_present = 0x00000001,
+        .ext_contexts = 0x00000004,
+        .vtcm_base = 0x0000d840,
+        .vtcm_size_kb = 0x00001000,
+        .l2tag_size = 0x00000400,
+        .l2ecomem_size = 0x00000400,
+        .thread_enable_mask = 0x0000003f,
+        .eccreg_base = 0x0000d81f,
+        .l2line_size = 0x00000080,
+        .tiny_core = 0x00000000,
+        .l2itcm_size = 0x00000000,
+        .l2itcm_base = 0x0000d820,
+        .reserved3 = 0x00000000,
+        .dtm_present = 0x00000000,
+        .dma_version = 0x00000001,
+        .hvx_vec_log_length = 0x00000007,
+        .core_id = 0x00000000,
+        .core_count = 0x00000000,
+        .coproc2_reg0 = 0x00000040,
+        .coproc2_reg1 = 0x00000020,
+        .v2x_mode = 0x1f1f1f1f,
+        .coproc2_reg2 = 0x1f1f1f1f,
+        .coproc2_reg3 = 0x1f1f1f1f,
+        .coproc2_reg4 = 0x1f1f1f1f,
+        .coproc2_reg5 = 0x1f1f1f1f,
+        .coproc2_reg6 = 0x1f1f1f1f,
+        .coproc2_reg7 = 0x1f1f1f1f,
+        .acd_preset = 0x1f1f1f1f,
+        .mnd_preset = 0x1f1f1f1f,
+        .l1d_size_kb = 0x1f1f1f1f,
+        .l1i_size_kb = 0x1f1f1f1f,
+        .l1d_write_policy = 0x1f1f1f1f,
+        .vtcm_bank_width = 0x1f1f1f1f,
+        .reserved3 = 0x1f1f1f1f,
+        .reserved4 = 0x1f1f1f1f,
+        .reserved5 = 0x1f1f1f1f,
+        .coproc2_cvt_mpy_size = 0x1f1f1f1f,
+        .consistency_domain = 0x1f1f1f1f,
+        .capacity_domain = 0x1f1f1f1f,
+        .axi3_lowaddr = 0x1f1f1f1f,
+    },
+};
+
-- 
2.34.1


