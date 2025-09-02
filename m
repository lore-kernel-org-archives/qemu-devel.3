Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A96CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI05-0006t0-CN; Mon, 01 Sep 2025 23:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzq-0006q2-Gi
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzl-0004Tc-Ty
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S7T6030605
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qJYNeIiIz58odRTKcDvwHX0O6OfH1ljJw4sFlCOXBzA=; b=Ocfd2/jOoMBQJm2L
 Gqj4iV640XRn1/LsP4KXLrCp8+QAuzheyqQ4jwP7iSG8U/Q0aoOUXYExojGuE3Hc
 KTDgXYyEtqUoqJgSeKnoBohUj0r8Nx+EhXU0cDopIoJxx+HjYhxtRnkNUVdzehLB
 Kvev6fewnRh5LHnC3mpFFd9imxSs4m4LoD1BDXSLBhJiF/V5UijUfe4k7TbxiXnf
 GZAngORqxBApIMDSEDo/6mIDjG0HGMkXunXEfW7gUX9sUWPZF4qC8m9TcmYo29BA
 Sc/T1zD56OkEEFdsMB3NvLSgfkVG7y/DzPUy2sbOwYZ7Yd6aRF2T2TbGSXcIMo7t
 r+giKQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8pbxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-329d4a14286so476660a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784863; x=1757389663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJYNeIiIz58odRTKcDvwHX0O6OfH1ljJw4sFlCOXBzA=;
 b=UZCSXOIqp0caLaDiR2nH6BAPDKJ7Y/V89N+ddW/42EWZjXW6HerPGBvVuimRJ6LI8G
 89tOgHTW7dI6tQ7vsl5abEyo/2HgzK/rDsDCuo8SYh36qD6ph+ys7qF8QP7nNYIRDyk7
 tc7HTgBuy3rfDYJcrAYeg76yFphNRTFMT2dwx3IzP1RxOrBpROD+V+MoEmCe7gL9N9FI
 x/jS7t3YiYe2sWcllkYlItfoOfB9LiTdWjQbeXAOiONdKyg28zxXDx9JgQW7R5xFls6r
 gTtbfGpe1bz8zmXAg9pO1tOF1z+fyAWiP0k7UUPfh7seYwHRRzyin/so6UKm3KY6w+Lm
 RKMg==
X-Gm-Message-State: AOJu0YzqnpYWokPt1sGOW8eeLYq1R1xhqUhe1lPmXgqe2b1vjGMkpMMb
 NFGKtln7wJVxJGs9rhVKiDwdzHN9xk0oUnoGj1zIM7ugHz6B3OAEPwX0PnTAUy01ipIvz8UK3r9
 5S5UOoqmsfNTQ25mxynXWcJGY3tK/sEEfpYL6Qux90rWHX79VbZ7+bCiRH8XEqIq6yB9y
X-Gm-Gg: ASbGncsGyPzjsbrGjSAxHBsMTAze00aA3MY5665brQt/9l1gEh8xnIihZuk016JTHVI
 WY2ii5dQw1QPzLv7Avg3jsOR3ftzLYcIFSHzD6iwUWLR1FNeUA/sbzr5t0F60xG56yG+P5ZJNmH
 rNvCPO/HLUw1XKMH7+n7YSazVrvuPIa9ujZJMsIflmW8Php69Vekm9F7MAkNSxq45D7feSRKXUM
 SHkZEFRanGhah9XYj2sqX8xWSc+I4JFDd0fTRwhO/GC10RFSd11u23ZbaBcH2iH2McOMsMl8oFH
 w/MYvihyVAIZ5twzai1RwtB0BosI0Bm9Kzm/3JNeuxh4/3wgDoplvEhfKarTCFw2kiWY5joZca+
 t122nUPlu/EBU
X-Received: by 2002:a17:90b:5284:b0:323:28cb:264a with SMTP id
 98e67ed59e1d1-328154513c7mr12998410a91.13.1756784862387; 
 Mon, 01 Sep 2025 20:47:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeFeaenexv8N0JG1mnpv/T7mhpAzQ2blqwtnwnzOE+IVolLNNthtSPh5okEd9uOpNUJxaDEw==
X-Received: by 2002:a17:90b:5284:b0:323:28cb:264a with SMTP id
 98e67ed59e1d1-328154513c7mr12998364a91.13.1756784861407; 
 Mon, 01 Sep 2025 20:47:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 16/40] target/hexagon: Add imported macro,
 attr defs for sysemu
Date: Mon,  1 Sep 2025 20:46:51 -0700
Message-Id: <20250902034715.1947718-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AMLyu3vuXJ07lMO6Y0h5b8ScGhqesEgv
X-Proofpoint-GUID: AMLyu3vuXJ07lMO6Y0h5b8ScGhqesEgv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX286N+BO4XS2z
 aV1PVtmHiinUrRMc9SKJVZYBkry86NP1GOo7cTPr3hNk4MN0XLBmsj4w5YgerLtenQJc+fBVOdr
 ZHVbbP4/9YZVqa5LrDOAqQKNKU6KQCuev7KqZUHfWtAtbfVjKauX9L3hePcWXTH/+WojtoQDghu
 Ar6z8xfE5DS5yiKZAdkpS5p2g39rxpM7863Rf++NbshaOPfZO4qasTxSHPuIF4V5l3hYH91OCTg
 mUy2R/NjJjM3qmPnSEWmtbp/eRLmONjk8R/gpkWXkUNqsw0ACi5MOWu5a/S9OY1x02zKq9lTcaP
 P+SzXEj3LMeT6OJfFfnjQV7mCJTzeN0//Cj4rqlGTaZkEcoyy37tpzZTHOnlhgVrDy9vcN8YFWC
 Eqizv42P
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b668e1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=FEAouyqSGNlIFG8ZZtgA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/attribs_def.h.inc   | 413 +++++++++++++++++++--
 target/hexagon/imported/macros.def | 558 +++++++++++++++++++++++++++++
 2 files changed, 941 insertions(+), 30 deletions(-)
 mode change 100755 => 100644 target/hexagon/imported/macros.def

diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.h.inc
index 9e3a05f882..e86284732a 100644
--- a/target/hexagon/attribs_def.h.inc
+++ b/target/hexagon/attribs_def.h.inc
@@ -19,20 +19,41 @@
 DEF_ATTRIB(AA_DUMMY, "Dummy Zeroth Attribute", "", "")
 
 /* Misc */
+DEF_ATTRIB(FAKEINSN, "Not a real instruction", "", "")
+DEF_ATTRIB(MAPPING, "Not real -- asm mapped", "", "")
+DEF_ATTRIB(CONDMAPPING, "Not real -- mapped based on values", "", "")
 DEF_ATTRIB(EXTENSION, "Extension instruction", "", "")
+DEF_ATTRIB(SHARED_EXTENSION, "Shared extension instruction", "", "")
+DEF_ATTRIB(CABAC,
+           "Cabac Instruction. Used in conjuction with QDSP6_CABAC_PRESENT", "",
+           "")
+DEF_ATTRIB(EXPERIMENTAL, "This may not work correctly not supported by RTL.",
+           "", "")
 
 DEF_ATTRIB(PRIV, "Not available in user or guest mode", "", "")
 DEF_ATTRIB(GUEST, "Not available in user mode", "", "")
 
 DEF_ATTRIB(FPOP, "Floating Point Operation", "", "")
+DEF_ATTRIB(FPDOUBLE, "Double-precision Floating Point Operation", "", "")
+DEF_ATTRIB(FPSINGLE, "Single-precision Floating Point Operation", "", "")
+DEF_ATTRIB(SFMAKE, "Single Float Make", "", "")
+DEF_ATTRIB(DFMAKE, "Single Float Make", "", "")
+
+DEF_ATTRIB(NO_TIMING_LOG, "Does not get logged to the timing model", "", "")
 
 DEF_ATTRIB(EXTENDABLE, "Immediate may be extended", "", "")
+DEF_ATTRIB(EXT_UPPER_IMMED, "Extend upper case immediate", "", "")
+DEF_ATTRIB(EXT_LOWER_IMMED, "Extend lower case immediate", "", "")
+DEF_ATTRIB(MUST_EXTEND, "Immediate must be extended", "", "")
+DEF_ATTRIB(NA_NT, "Non-Allocating Non-Temporal instruction", "", "")
+DEF_ATTRIB(INVPRED, "The predicate is inverted for true/false sense", "", "")
 
 DEF_ATTRIB(ARCHV2, "V2 architecture", "", "")
 DEF_ATTRIB(ARCHV3, "V3 architecture", "", "")
 DEF_ATTRIB(ARCHV4, "V4 architecture", "", "")
 DEF_ATTRIB(ARCHV5, "V5 architecture", "", "")
 
+DEF_ATTRIB(PACKED, "Packable instruction", "", "")
 DEF_ATTRIB(SUBINSN, "sub-instruction", "", "")
 
 /* Load and Store attributes */
@@ -46,21 +67,47 @@ DEF_ATTRIB(MEMSIZE_4B, "Memory width is 4 bytes", "", "")
 DEF_ATTRIB(MEMSIZE_8B, "Memory width is 8 bytes", "", "")
 DEF_ATTRIB(SCALAR_LOAD, "Load is scalar", "", "")
 DEF_ATTRIB(SCALAR_STORE, "Store is scalar", "", "")
-DEF_ATTRIB(REGWRSIZE_1B, "Memory width is 1 byte", "", "")
-DEF_ATTRIB(REGWRSIZE_2B, "Memory width is 2 bytes", "", "")
-DEF_ATTRIB(REGWRSIZE_4B, "Memory width is 4 bytes", "", "")
-DEF_ATTRIB(REGWRSIZE_8B, "Memory width is 8 bytes", "", "")
+DEF_ATTRIB(REGWRSIZE_1B, "ETM Memory width is 1 byte", "", "")
+DEF_ATTRIB(REGWRSIZE_2B, "ETM Memory width is 2 bytes", "", "")
+DEF_ATTRIB(REGWRSIZE_4B, "ETM Memory width is 4 bytes", "", "")
+DEF_ATTRIB(REGWRSIZE_8B, "ETM Memory width is 8 bytes", "", "")
 DEF_ATTRIB(MEMLIKE, "Memory-like instruction", "", "")
 DEF_ATTRIB(MEMLIKE_PACKET_RULES, "follows Memory-like packet rules", "", "")
+DEF_ATTRIB(CACHEOP, "Cache operation", "", "")
+DEF_ATTRIB(COPBYADDRESS, "Cache operation by address", "", "")
+DEF_ATTRIB(COPBYIDX, "Cache operation by index", "", "")
 DEF_ATTRIB(RELEASE, "Releases a lock", "", "")
 DEF_ATTRIB(ACQUIRE, "Acquires a lock", "", "")
 
 DEF_ATTRIB(RLS_INNER, "Store release inner visibility", "", "")
+DEF_ATTRIB(RLS_OUTER, "Store release outer visibility", "", "")
 DEF_ATTRIB(RLS_ALL_THREAD, "Store release among all threads", "", "")
 DEF_ATTRIB(RLS_SAME_THREAD, "Store release with the same thread", "", "")
 
+/* Load and Store Addressing Mode Attributes */
+DEF_ATTRIB(EA_REG_ONLY, "EA = input register only", "", "")
+DEF_ATTRIB(EA_IMM_ONLY, "EA = immediate only", "", "")
+DEF_ATTRIB(EA_REG_PLUS_IMM, "EA = register plus immediate", "", "")
+DEF_ATTRIB(EA_REG_PLUS_REGSCALED, "EA = register plus scaled register", "", "")
+DEF_ATTRIB(EA_IMM_PLUS_REGSCALED, "EA = immediate plus scaled register", "", "")
+DEF_ATTRIB(EA_BREV_REG, "EA = bit-reversed input register", "", "")
+DEF_ATTRIB(EA_GP_IMM, "EA = GP plus immediate (unless extended)", "", "")
+DEF_ATTRIB(EA_PAGECROSS, "EA calculation can have a Page Cross Stall", "", "")
+
+DEF_ATTRIB(PM_ANY, "Post Modify", "", "")
+DEF_ATTRIB(PM_I, "Post Modify by Immediate", "", "")
+DEF_ATTRIB(PM_M, "Post Modify by M register", "", "")
+DEF_ATTRIB(PM_CIRI, "Post Modify with Circular Addressing by immediate", "", "")
+DEF_ATTRIB(PM_CIRR, "Post Modify with Circular Addressing by I field", "", "")
+
+DEF_ATTRIB(VMEM, "VMEM-type", "", "")
+DEF_ATTRIB(VBUF, "Touches the VBUF", "", "")
+DEF_ATTRIB(VDBG, "Vector debugging instruction", "", "")
+
 /* V6 Vector attributes */
 DEF_ATTRIB(CVI, "Executes on the HVX extension", "", "")
+DEF_ATTRIB(NT_VMEM, "Non-temporal memory access", "", "")
+DEF_ATTRIB(VMEMU, "Unaligned memory access", "", "")
 
 DEF_ATTRIB(CVI_NEW, "New value memory instruction executes on HVX", "", "")
 DEF_ATTRIB(CVI_VM, "Memory instruction executes on HVX", "", "")
@@ -69,109 +116,415 @@ DEF_ATTRIB(CVI_VP_VS, "Double vector permute/shft insn executes on HVX", "", "")
 DEF_ATTRIB(CVI_VX, "Multiply instruction executes on HVX", "", "")
 DEF_ATTRIB(CVI_VX_DV, "Double vector multiply insn executes on HVX", "", "")
 DEF_ATTRIB(CVI_VS, "Shift instruction executes on HVX", "", "")
-DEF_ATTRIB(CVI_VS_3SRC, "This shift needs to borrow a source register", "", "")
+DEF_ATTRIB(
+    CVI_VS_3SRC,
+    "This shift instruction needs to borrow a source register from the VP slot",
+    "", "")
 DEF_ATTRIB(CVI_VS_VX, "Permute/shift and multiply insn executes on HVX", "", "")
 DEF_ATTRIB(CVI_VA, "ALU instruction executes on HVX", "", "")
+DEF_ATTRIB(CVI_VA_2SRC,
+           "This alu instruction executes on multimedia vector engine and "
+           "requires two vectro sources",
+           "", "")
 DEF_ATTRIB(CVI_VA_DV, "Double vector alu instruction executes on HVX", "", "")
 DEF_ATTRIB(CVI_4SLOT, "Consumes all the vector execution resources", "", "")
 DEF_ATTRIB(CVI_TMP, "Transient Memory Load not written to register", "", "")
 DEF_ATTRIB(CVI_REMAP, "Register Renaming not written to register file", "", "")
+DEF_ATTRIB(CVI_TMP_SRC, "Transient reassign", "", "")
+DEF_ATTRIB(CVI_EXTRACT, "HVX Extract Instruction that goes through L2", "", "")
+DEF_ATTRIB(CVI_EARLY, "HVX instructions that require early sources", "", "")
+DEF_ATTRIB(CVI_LATE, "HVX insn that always require late sources", "", "")
+DEF_ATTRIB(CVI_VV_LATE, "HVX insn that always require late Vv source", "", "")
+DEF_ATTRIB(CVI_REQUIRES_TMPLOAD, ".tmp load must be included in packet", "", "")
+DEF_ATTRIB(CVI_PUMP_2X, "Goes through the pipeline twice", "", "")
+DEF_ATTRIB(CVI_PUMP_4X, "Goes through the pipeline four times", "", "")
 DEF_ATTRIB(CVI_GATHER, "CVI Gather operation", "", "")
 DEF_ATTRIB(CVI_SCATTER, "CVI Scatter operation", "", "")
 DEF_ATTRIB(CVI_SCATTER_RELEASE, "CVI Store Release for scatter", "", "")
+DEF_ATTRIB(CVI_GATHER_RELEASE, "CVI Store Release for gather", "", "")
 DEF_ATTRIB(CVI_TMP_DST, "CVI instruction that doesn't write a register", "", "")
+DEF_ATTRIB(CVI_SCATTER_WORD_ACC, "CVI Scatter Word Accum (second pass)", "", "")
+DEF_ATTRIB(CVI_SCATTER_ACC, "CVI Scatter Accumulate", "", "")
+DEF_ATTRIB(CVI_VX_VSRC0_IS_DST,
+           "For the assembler to handle the special case of non-linear "
+           "instructions with Vxx specified both as src and dst in syntax ",
+           "", "")
+
+DEF_ATTRIB(CVI_VX_ACC_FWD, "VX Accumulator Forwarding", "", "")
+
+DEF_ATTRIB(CVI_VX_NO_TMP_LD,
+           "VX Accumulator renaming not allowed from tmp load instruction", "",
+           "")
+
+DEF_ATTRIB(RESTRICT_CVI_NOVP,
+           "Instructions with this attribute are assigned to the original "
+           "shift unit and can not be assigned to the shift/permute unit",
+           "", "")
+
+DEF_ATTRIB(CVI_GATHER_ADDR_2B, "CVI Scatter/Gather address is halfword", "", "")
+DEF_ATTRIB(CVI_GATHER_ADDR_4B, "CVI Scatter/Gather address is word", "", "")
+
+DEF_ATTRIB(VFETCH, "memory fetch op to L2 for a single vector", "", "")
+
 DEF_ATTRIB(CVI_SLOT23, "Can execute in slot 2 or slot 3 (HVX)", "", "")
 
-DEF_ATTRIB(VTCM_ALLBANK_ACCESS, "Allocates in all VTCM schedulers.", "", "")
+DEF_ATTRIB(HVX_FLT, "This a floating point HVX instruction.", "", "")
+
+DEF_ATTRIB(
+    VTCM_ALLBANK_ACCESS,
+    "This instruction allocates in all VTCM schedulers due to a region access.",
+    "", "")
+DEF_ATTRIB(XUMINOR, "XU minor SMTable instruction", "", "")
+
+DEF_ATTRIB(SYNC_MARKER, "This instruction needs a sync marker.", "", "")
+
 
 /* Change-of-flow attributes */
 DEF_ATTRIB(JUMP, "Jump-type instruction", "", "")
+DEF_ATTRIB(DIRECT, "Uses an PC-relative immediate field", "", "")
 DEF_ATTRIB(INDIRECT, "Absolute register jump", "", "")
+DEF_ATTRIB(CJUMP, "Conditional jump", "", "")
 DEF_ATTRIB(CALL, "Function call instruction", "", "")
+DEF_ATTRIB(RET, "Function return instruction", "", "")
+DEF_ATTRIB(PERM, "Permute instruction", "", "")
 DEF_ATTRIB(COF, "Change-of-flow instruction", "", "")
 DEF_ATTRIB(HINTED_COF, "This instruction is a hinted change-of-flow", "", "")
 DEF_ATTRIB(CONDEXEC, "May be cancelled by a predicate", "", "")
+DEF_ATTRIB(DOTOLD, "Uses a predicate generated in a previous packet", "", "")
+DEF_ATTRIB(DOTNEW, "Uses a predicate generated in the same packet", "", "")
 DEF_ATTRIB(DOTNEWVALUE, "Uses a register value generated in this pkt", "", "")
 DEF_ATTRIB(NEWCMPJUMP, "Compound compare and jump", "", "")
 DEF_ATTRIB(NVSTORE, "New-value store", "", "")
 DEF_ATTRIB(MEMOP, "memop", "", "")
 
-DEF_ATTRIB(ROPS_2, "Compound instruction worth 2 RISC-ops", "", "")
-DEF_ATTRIB(ROPS_3, "Compound instruction worth 3 RISC-ops", "", "")
+DEF_ATTRIB(ROPS_2, "Compound instruction worth 2 wimpy RISC-ops", "", "")
+DEF_ATTRIB(ROPS_3, "Compound instruction worth 3 wimpy RISC-ops", "", "")
 
 /* access to implicit registers */
 DEF_ATTRIB(IMPLICIT_WRITES_LR, "Writes the link register", "", "UREG.LR")
+DEF_ATTRIB(IMPLICIT_READS_LR, "Reads the link register", "UREG.LR", "")
+DEF_ATTRIB(IMPLICIT_READS_LC0, "Reads loop count for loop 0", "UREG.LC0", "")
+DEF_ATTRIB(IMPLICIT_READS_LC1, "Reads loop count for loop 1", "UREG.LC1", "")
+DEF_ATTRIB(IMPLICIT_READS_SA0, "Reads start address for loop 0", "UREG.SA0", "")
+DEF_ATTRIB(IMPLICIT_READS_SA1, "Reads start address for loop 1", "UREG.SA1", "")
+DEF_ATTRIB(IMPLICIT_WRITES_PC, "Writes the program counter", "", "UREG.PC")
+DEF_ATTRIB(IMPLICIT_READS_PC, "Reads the program counter", "UREG.PC", "")
 DEF_ATTRIB(IMPLICIT_WRITES_SP, "Writes the stack pointer", "", "UREG.SP")
+DEF_ATTRIB(IMPLICIT_READS_SP, "Reads the stack pointer", "UREG.SP", "")
 DEF_ATTRIB(IMPLICIT_WRITES_FP, "Writes the frame pointer", "", "UREG.FP")
+DEF_ATTRIB(IMPLICIT_READS_FP, "Reads the frame pointer", "UREG.FP", "")
+DEF_ATTRIB(IMPLICIT_WRITES_GP, "Writes the GP register", "", "UREG.GP")
+DEF_ATTRIB(IMPLICIT_READS_GP, "Reads the GP register", "UREG.GP", "")
 DEF_ATTRIB(IMPLICIT_WRITES_LC0, "Writes loop count for loop 0", "", "UREG.LC0")
 DEF_ATTRIB(IMPLICIT_WRITES_LC1, "Writes loop count for loop 1", "", "UREG.LC1")
 DEF_ATTRIB(IMPLICIT_WRITES_SA0, "Writes start addr for loop 0", "", "UREG.SA0")
 DEF_ATTRIB(IMPLICIT_WRITES_SA1, "Writes start addr for loop 1", "", "UREG.SA1")
+DEF_ATTRIB(IMPLICIT_WRITES_R00, "Writes Register 0", "", "UREG.R00")
 DEF_ATTRIB(IMPLICIT_WRITES_P0, "Writes Predicate 0", "", "UREG.P0")
 DEF_ATTRIB(IMPLICIT_WRITES_P1, "Writes Predicate 1", "", "UREG.P1")
 DEF_ATTRIB(IMPLICIT_WRITES_P2, "Writes Predicate 1", "", "UREG.P2")
 DEF_ATTRIB(IMPLICIT_WRITES_P3, "May write Predicate 3", "", "UREG.P3")
-DEF_ATTRIB(IMPLICIT_READS_PC, "Reads the PC register", "", "")
-DEF_ATTRIB(IMPLICIT_READS_P0, "Reads the P0 register", "", "")
-DEF_ATTRIB(IMPLICIT_READS_P1, "Reads the P1 register", "", "")
-DEF_ATTRIB(IMPLICIT_READS_P2, "Reads the P2 register", "", "")
-DEF_ATTRIB(IMPLICIT_READS_P3, "Reads the P3 register", "", "")
+DEF_ATTRIB(IMPLICIT_READS_R00, "Reads Register 0", "UREG.R00", "")
+DEF_ATTRIB(IMPLICIT_READS_P0, "Reads Predicate 0", "UREG.P0", "")
+DEF_ATTRIB(IMPLICIT_READS_P1, "Reads Predicate 1", "UREG.P1", "")
+DEF_ATTRIB(IMPLICIT_READS_P3, "Reads Predicate 3", "UREG.P3", "")
+DEF_ATTRIB(IMPLICIT_READS_Q3, "Reads Vector Predicate 3", "UREG.Q3", "")
+DEF_ATTRIB(IMPLICIT_READS_CS, "Reads the CS/M register", "UREG.CS", "")
+DEF_ATTRIB(IMPLICIT_READS_FRAMEKEY, "Reads FRAMEKEY", "UREG.FRAMEKEY", "")
+DEF_ATTRIB(IMPLICIT_READS_FRAMELIMIT, "Reads FRAMELIMIT", "UREG.FRAMELIMIT", "")
+DEF_ATTRIB(IMPLICIT_READS_ELR, "Reads the ELR register", "MREG.ELR", "")
+DEF_ATTRIB(IMPLICIT_READS_SGP0, "Reads the SGP0 register", "MREG.SGP0", "")
+DEF_ATTRIB(IMPLICIT_READS_SGP1, "Reads the SGP1 register", "MREG.SGP1", "")
+DEF_ATTRIB(IMPLICIT_WRITES_SGP0, "Reads the SGP0 register", "", "MREG.SGP0")
+DEF_ATTRIB(IMPLICIT_WRITES_SGP1, "Reads the SGP1 register", "", "MREG.SGP1")
+DEF_ATTRIB(IMPLICIT_WRITES_STID_PRIO_ANYTHREAD, "Reads", "", "MREG.STID.PRIO")
+DEF_ATTRIB(IMPLICIT_WRITES_SRBIT, "Writes the OVF bit", "", "UREG.SR.OVF")
+DEF_ATTRIB(IMPLICIT_WRITES_FPFLAGS, "May write FP flags", "", "UREG.SR.FPFLAGS")
+DEF_ATTRIB(IMPLICIT_WRITES_LPCFG, "Writes the loop config", "", "UREG.SR.LPCFG")
+DEF_ATTRIB(IMPLICIT_WRITES_CVBITS, "Writes the CV flags", "", "UREG.SR.CV")
+DEF_ATTRIB(IMPLICIT_READS_FPRND, "May read FP rnd mode", "UREG.SR.FPRND", "")
+DEF_ATTRIB(IMPLICIT_READS_SSR, "May read SSR values", "MREG.SSR", "")
+DEF_ATTRIB(IMPLICIT_READS_CCR, "May read CCR values", "MREG.CCR", "")
+DEF_ATTRIB(IMPLICIT_WRITES_CCR, "May write CCR values", "", "MREG.CCR")
+DEF_ATTRIB(IMPLICIT_WRITES_SSR, "May write SSR values", "", "MREG.SSR")
+DEF_ATTRIB(IMPLICIT_READS_GELR, "May read GELR values", "GREG.GELR", "")
+DEF_ATTRIB(IMPLICIT_READS_GEVB, "May read GEVB values", "MREG.GEVB", "")
+DEF_ATTRIB(IMPLICIT_READS_GSR, "May read GSR values", "GREG.GSR", "")
+DEF_ATTRIB(IMPLICIT_READS_GOSP, "May read GOSP values", "GREG.GOSP", "")
+DEF_ATTRIB(IMPLICIT_WRITES_GELR, "May write GELR values", "", "GREG.GELR")
+DEF_ATTRIB(IMPLICIT_WRITES_GSR, "May write GSR values", "", "GREG.GSR")
+DEF_ATTRIB(IMPLICIT_WRITES_GOSP, "May write GOSP values", "", "GREG.GOSP")
+DEF_ATTRIB(IMPLICIT_READS_IPENDAD_IPEND, "May read", "MREG.IPENDAD.IPEND", "")
+DEF_ATTRIB(IMPLICIT_WRITES_IPENDAD_IPEND, "May write", "", "MREG.IPENDAD.IPEND")
+DEF_ATTRIB(IMPLICIT_READS_IPENDAD_IAD, "May read", "MREG.IPENDAD.IAD", "")
+DEF_ATTRIB(IMPLICIT_WRITES_IPENDAD_IAD, "May write", "", "MREG.IPENDAD.IAD")
+DEF_ATTRIB(IMPLICIT_WRITES_IMASK_ANYTHREAD, "May write", "", "MREG.IMASK")
+DEF_ATTRIB(IMPLICIT_READS_IMASK_ANYTHREAD, "May read", "MREG.IMASK", "")
+DEF_ATTRIB(IMPLICIT_READS_SYSCFG_K0LOCK, "May read", "MREG.SYSCFG.K0LOCK", "")
+DEF_ATTRIB(IMPLICIT_WRITES_SYSCFG_K0LOCK, "May write", "", "MREG.SYSCFG.K0LOCK")
+DEF_ATTRIB(IMPLICIT_READS_SYSCFG_TLBLOCK, "May read", "MREG.SYSCFG.TLBLOCK", "")
+DEF_ATTRIB(IMPLICIT_WRITES_SYSCFG_TLBLOCK, "May wr", "", "MREG.SYSCFG.TLBLOCK")
+DEF_ATTRIB(IMPLICIT_WRITES_SYSCFG_GCA, "May write", "", "MREG.SYSCFG.GCA")
+DEF_ATTRIB(IMPLICIT_READS_SYSCFG_GCA, "May read", "MREG.SYSCFG.GCA", "")
 DEF_ATTRIB(IMPLICIT_WRITES_USR, "May write USR", "", "")
-DEF_ATTRIB(IMPLICIT_READS_SP, "Reads the SP register", "", "")
+
+/* Other things the instruction does */
+DEF_ATTRIB(ACC, "Has a multiply", "", "")
+DEF_ATTRIB(MPY, "Has a multiply", "", "")
+DEF_ATTRIB(SATURATE, "Does signed saturation", "", "")
+DEF_ATTRIB(USATURATE, "Does unsigned saturation", "", "")
+DEF_ATTRIB(CIRCADDR, "Uses circular addressing mode", "", "")
+DEF_ATTRIB(BREVADDR, "Uses bit reverse addressing mode", "", "")
+DEF_ATTRIB(BIDIRSHIFTL, "Uses a bidirectional shift left", "", "")
+DEF_ATTRIB(BIDIRSHIFTR, "Uses a bidirectional shift right", "", "")
+DEF_ATTRIB(BRANCHADDER, "Contains a PC-plus-immediate operation.", "", "")
+DEF_ATTRIB(CRSLOT23, "Can execute in slot 2 or slot 3 (CR)", "", "")
 DEF_ATTRIB(COMMUTES, "The operation is communitive", "", "")
 DEF_ATTRIB(DEALLOCRET, "dealloc_return", "", "")
 DEF_ATTRIB(DEALLOCFRAME, "deallocframe", "", "")
 
-DEF_ATTRIB(CRSLOT23, "Can execute in slot 2 or slot 3 (CR)", "", "")
+/* Instruction Types */
+
+DEF_ATTRIB(IT_ALU, "ALU type", "", "")
+DEF_ATTRIB(IT_ALU_ADDSUB, "ALU add or subtract type", "", "")
+DEF_ATTRIB(IT_ALU_MINMAX, "ALU MIN or MAX type", "", "")
+DEF_ATTRIB(IT_ALU_MOVE, "ALU data movement type", "", "")
+DEF_ATTRIB(IT_ALU_LOGICAL, "ALU logical operation type", "", "")
+DEF_ATTRIB(IT_ALU_SHIFT, "ALU shift operation type", "", "")
+DEF_ATTRIB(IT_ALU_SHIFT_AND_OP, "ALU shift and additional op type", "", "")
+DEF_ATTRIB(IT_ALU_CMP, "ALU compare operation type", "", "")
+
+DEF_ATTRIB(IT_LOAD, "Loads from memory", "", "")
+DEF_ATTRIB(IT_STORE, "Stores to memory", "", "")
+
+DEF_ATTRIB(IT_MPY, "Multiply type", "", "")
+DEF_ATTRIB(IT_MPY_32, "32-bit Multiply type", "", "")
+
+DEF_ATTRIB(IT_COF, "Change-of-flow type", "", "")
+DEF_ATTRIB(IT_HWLOOP, "Sets up hardware loop registers", "", "")
+
+DEF_ATTRIB(IT_MISC, "misc instruction type", "", "")
+
 DEF_ATTRIB(IT_NOP, "nop instruction", "", "")
 DEF_ATTRIB(IT_EXTENDER, "constant extender instruction", "", "")
 
 
+/* Exceptions the instruction can generate */
+
+DEF_ATTRIB(EXCEPTION_TLB, "Can generate a TLB Miss Exception", "", "")
+DEF_ATTRIB(EXCEPTION_ACCESS, "Can generate Access Violation Exception", "", "")
+DEF_ATTRIB(EXCEPTION_SWI, "Software Interrupt (trap) exception", "", "")
+
+
+/* Documentation Notes */
+DEF_ATTRIB(NOTE_ARCHV2, "Only available in the V2 architecture", "", "")
+
+DEF_ATTRIB(NOTE_PACKET_PC, "The PC is the addr of the start of the pkt", "", "")
+
+DEF_ATTRIB(NOTE_PACKET_NPC, "Next PC is the address following pkt", "", "")
+
+DEF_ATTRIB(NOTE_CONDITIONAL, "can be conditionally executed", "", "")
+
+DEF_ATTRIB(NOTE_NEWVAL_SLOT0, "New-value oprnd must execute on slot 0", "", "")
+
+DEF_ATTRIB(NOTE_RELATIVE_ADDRESS, "A PC-relative address is formed", "", "")
+
+DEF_ATTRIB(NOTE_LA_RESTRICT, "Cannot be in the last pkt of a HW loop", "", "")
+
+DEF_ATTRIB(NOTE_OOBVSHIFT, "Possible shift overflow", "", "")
+DEF_ATTRIB(NOTE_BIDIRSHIFT, "Bidirectional shift", "", "")
+
+DEF_ATTRIB(NOTE_CVFLAGS, "Sets the Carry and Overflow flags in USR.", "", "")
+DEF_ATTRIB(NOTE_SR_OVF_WHEN_SATURATING, "Might set OVF bit", "", "")
+DEF_ATTRIB(NOTE_STNT,
+           "Non Temporal Data. The :nt appendix is a hint to the "
+           "microarchitecture indicating that the life of the cache line is "
+           "short. This information is used throughout the cache hierarchy to "
+           "make replacement and allocation decisions.",
+           "", "")
+DEF_ATTRIB(NOTE_PRIV, "Monitor-level feature", "", "")
+DEF_ATTRIB(NOTE_GUEST, "Guest-level feature", "", "")
+DEF_ATTRIB(NOTE_NOPACKET, "solo instruction", "", "")
+DEF_ATTRIB(NOTE_AXOK, "May only be grouped with ALU32 or non-FP XTYPE.", "", "")
+DEF_ATTRIB(NOTE_NOSLOT1, "Packet with this insn must have slot 1 empty", "", "")
+DEF_ATTRIB(NOTE_SLOT1_AOK, "Packet must have slot 1 empty or ALU32", "", "")
+DEF_ATTRIB(NOTE_NOSLOT01, "Packet must have both slot 1 and 2 empty", "", "")
+DEF_ATTRIB(NOTE_NEEDS_MEMLD, "Must be grouped with a memory load", "", "")
+DEF_ATTRIB(NOTE_LATEPRED, "The predicate can not be used as a .new", "", "")
+DEF_ATTRIB(NOTE_COMPAT_ACCURACY, "In the future accuracy may increase", "", "")
+DEF_ATTRIB(NOTE_NVSLOT0, "Can execute only in slot 0 (ST)", "", "")
+DEF_ATTRIB(NOTE_DEPRECATED, "Will be deprecated in a future version.", "", "")
+DEF_ATTRIB(NOTE_NONAPALIV1, "may not work correctly in Napali V1.", "", "")
+DEF_ATTRIB(NOTE_NOLAHAINAV1, "This may not work correctly in Lahaina V1.", "",
+           "")
+DEF_ATTRIB(NOTE_BADTAG_UNDEF, "Undefined if a tag is non-present", "", "")
+DEF_ATTRIB(NOTE_NOSLOT2_MPY, "Packet cannot have a slot 2 multiply", "", "")
+DEF_ATTRIB(NOTE_HVX_ONLY, "Only available on a core with HVX.", "", "")
+
+DEF_ATTRIB(NOTE_NOCOF_RESTRICT, "Cannot be grouped with any COF", "", "")
+DEF_ATTRIB(NOTE_BRANCHADDER_MAX1, "One PC-plus-offset calculation", "", "")
+
+DEF_ATTRIB(NOTE_CRSLOT23, "Execute on either slot2 or slot3 (CR)", "", "")
+DEF_ATTRIB(NOTE_EXTENSION_AUDIO, "Hexagon audio extensions", "", "")
+DEF_ATTRIB(NOTE_FETCHNT,
+           "Non Temporal Data Cache Prefetch. The :nt appendix is a hint to "
+           "the microarchitecture indicating that the life of the cache line "
+           "fetched is short. This information is used throughout the cache "
+           "hierarchy to make replacement and allocation decisions.",
+           "", "")
+DEF_ATTRIB(NOTE_VECX_V67, "This instruction is only available on V67", "", "")
+
+DEF_ATTRIB(NOTE_NOVP,
+           "This instruction cannot be paired with a HVX permute instruction",
+           "", "")
+DEF_ATTRIB(NOTE_VA_UNARY,
+           "If a packet contains this instruction and a HVX ALU op then the "
+           "ALU OP must be unary.",
+           "", "")
+
+
+/* V6 MMVector Notes for Documentation */
+DEF_ATTRIB(NOTE_ANY_RESOURCE, "Can use any HVX resource.", "", "")
+DEF_ATTRIB(NOTE_ANY2_RESOURCE, "Uses any pair of the HVX resources", "", "")
+DEF_ATTRIB(NOTE_PERMUTE_RESOURCE, "Uses the HVX permute resource.", "", "")
+DEF_ATTRIB(NOTE_SHIFT_RESOURCE, "Uses the HVX shift resource.", "", "")
+DEF_ATTRIB(NOTE_MPY_RESOURCE, "Uses a HVX multiply resource.", "", "")
+DEF_ATTRIB(NOTE_MPYDV_RESOURCE, "Uses both HVX multiply resources.", "", "")
+DEF_ATTRIB(NOTE_NT_VMEM, "Non-temporal hint to the micro-architecture", "", "")
+DEF_ATTRIB(NOTE_ALL_RESOURCE, "Uses all HVX resources.", "", "")
+DEF_ATTRIB(NOTE_VMEM, "Immediates are in multiples of vector length.", "", "")
+DEF_ATTRIB(NOTE_ANY_VS_VX_RESOURCE, "Consumes two resources", "", "")
+
+DEF_ATTRIB(NOTE_RT8, "Input scalar register Rt is limited to R0-R7", "", "")
+
+DEF_ATTRIB(NOTE_MX, "This is in-memory matrix multiply instruction.", "", "")
+DEF_ATTRIB(NOTE_VX_ACC_FWD,
+           "The accumulator (Vxx) source of this instruction must be generate "
+           "in the previous packet to avoid a stall. The accumulator cannot "
+           "come from a .tmp operation.",
+           "", "")
+DEF_ATTRIB(NOTE_TMP_NO_VX,
+           "The tmp load instruction destination register cannot be an "
+           "accumulator register.",
+           "", "")
+
+DEF_ATTRIB(
+    NOTE_NO_ECC,
+    "ECC is not supported for scatter and gather instructions. Enabling ECC "
+    "with unprotected access instructions result in undetermined behavior.",
+    "", "")
+
+/* FP8 instructions */
+DEF_ATTRIB(HVX_FP8, "HVX FP8 extension instruction", "", "")
+DEF_ATTRIB(HVX_IEEE_FP_OUT_8, "HVX IEEE FP extension instruction: 8-bit output",
+           "", "")
+
 /* Restrictions to make note of */
+DEF_ATTRIB(RESTRICT_LOOP_LA, "Cannot be in the last packet of a loop", "", "")
+DEF_ATTRIB(RESTRICT_NEEDS_MEMLD, "Must be grouped with a load", "", "")
 DEF_ATTRIB(RESTRICT_COF_MAX1, "One change-of-flow per packet", "", "")
 DEF_ATTRIB(RESTRICT_NOPACKET, "Not allowed in a packet", "", "")
+DEF_ATTRIB(RESTRICT_NOSRMOVE, "Do not write SR in the same packet", "", "")
 DEF_ATTRIB(RESTRICT_SLOT0ONLY, "Must execute on slot0", "", "")
 DEF_ATTRIB(RESTRICT_SLOT1ONLY, "Must execute on slot1", "", "")
 DEF_ATTRIB(RESTRICT_SLOT2ONLY, "Must execute on slot2", "", "")
 DEF_ATTRIB(RESTRICT_SLOT3ONLY, "Must execute on slot3", "", "")
+DEF_ATTRIB(RESTRICT_NOSLOT2_MPY, "A packet cannot have a slot 2 mpy", "", "")
 DEF_ATTRIB(RESTRICT_NOSLOT1, "No slot 1 instruction in parallel", "", "")
+DEF_ATTRIB(RESTRICT_SLOT1_AOK, "Slot 1 insn must be empty or A-type", "", "")
+DEF_ATTRIB(RESTRICT_NOSLOT01, "No slot 0 or 1 instructions in parallel", "", "")
+DEF_ATTRIB(RESTRICT_NOSLOT1_STORE, "Packet must not have slot 1 store", "", "")
+DEF_ATTRIB(RESTRICT_NOSLOT0_LOAD, "Packet must not have a slot 1 load", "", "")
+DEF_ATTRIB(RESTRICT_NOCOF, "Cannot be grouped with any COF", "", "")
+DEF_ATTRIB(RESTRICT_BRANCHADDER_MAX1, "One PC-plus-offset calculation", "", "")
 DEF_ATTRIB(RESTRICT_PREFERSLOT0, "Try to encode into slot 0", "", "")
+DEF_ATTRIB(RESTRICT_SINGLE_MEM_FIRST, "Single memory op must be last", "", "")
 DEF_ATTRIB(RESTRICT_PACKET_AXOK, "May exist with A-type or X-type", "", "")
+DEF_ATTRIB(RESTRICT_PACKET_SOMEREGS_OK, "Relaxed grouping rules", "", "")
+DEF_ATTRIB(RESTRICT_LATEPRED, "Predicate can not be used as a .new.", "", "")
+
+DEF_ATTRIB(PAIR_1OF2, "For assembler", "", "")
+DEF_ATTRIB(PAIR_2OF2, "For assembler", "", "")
+DEF_ATTRIB(NOTE_MX_PAIR,
+           "Weights and Activations need to be paired in a packet.", "", "")
+DEF_ATTRIB(NOTE_RESTRICT_CVI_NOVP,
+           "This instruction cannot use the permute/shift resource", "", "")
+
+/* Performance based preferences */
+DEF_ATTRIB(PREFER_SLOT3, "Complex XU prefering slot3", "", "")
+
+DEF_ATTRIB(RELAX_COF_1ST, "COF can be fisrt in assembly order", "", "")
+DEF_ATTRIB(RELAX_COF_2ND, "COF can be second in assembly order", "", "")
 
 DEF_ATTRIB(ICOP, "Instruction cache op", "", "")
 
+DEF_ATTRIB(INTRINSIC_RETURNS_UNSIGNED, "Intrinsic returns an unsigned", "", "")
+
+DEF_ATTRIB(PRED_BIT_1, "The branch uses bit 1 as the prediction bit", "", "")
+DEF_ATTRIB(PRED_BIT_4, "The branch uses bit 4 as the prediction bit", "", "")
+DEF_ATTRIB(PRED_BIT_8, "The branch uses bit 8 as the prediction bit", "", "")
+DEF_ATTRIB(PRED_BIT_12, "The branch uses bit 12 as the prediction bit", "", "")
+DEF_ATTRIB(PRED_BIT_13, "The branch uses bit 13 as the prediction bit", "", "")
+DEF_ATTRIB(PRED_BIT_7, "The branch uses bit 7 as the prediction bit", "", "")
+DEF_ATTRIB(HWLOOP0_SETUP, "Sets up HW loop0", "", "")
+DEF_ATTRIB(HWLOOP1_SETUP, "Sets up HW loop1", "", "")
 DEF_ATTRIB(HWLOOP0_END, "Ends HW loop0", "", "")
 DEF_ATTRIB(HWLOOP1_END, "Ends HW loop1", "", "")
 DEF_ATTRIB(RET_TYPE, "return type", "", "")
+DEF_ATTRIB(HINTJR, "hintjr type", "", "")
 DEF_ATTRIB(DCZEROA, "dczeroa type", "", "")
+DEF_ATTRIB(ICTAGOP, "ictag op type", "", "")
 DEF_ATTRIB(ICFLUSHOP, "icflush op type", "", "")
 DEF_ATTRIB(DCFLUSHOP, "dcflush op type", "", "")
+DEF_ATTRIB(DCTAGOP, "dctag op type", "", "")
 DEF_ATTRIB(L2FLUSHOP, "l2flush op type", "", "")
+DEF_ATTRIB(L2TAGOP, "l2tag op type", "", "")
 DEF_ATTRIB(DCFETCH, "dcfetch type", "", "")
+DEF_ATTRIB(BIMODAL_BRANCH, "Updates the bimodal branch predictor", "", "")
 
+DEF_ATTRIB(VECINSN, "Long Vector Instruction", "", "")
+DEF_ATTRIB(MEMSIZE_32B, "Memory width is 32 bytes", "", "")
+DEF_ATTRIB(FOUR_PHASE, "Four Phase Instruction", "", "")
 DEF_ATTRIB(L2FETCH, "Instruction is l2fetch type", "", "")
 
+DEF_ATTRIB(PREDUSE_BSB, "Instructions need back-skip-back scheduling", "", "")
 DEF_ATTRIB(ICINVA, "icinva", "", "")
 DEF_ATTRIB(DCCLEANINVA, "dccleaninva", "", "")
 
+DEF_ATTRIB(EXTENSION_AUDIO, "audio extension", "", "")
+
+DEF_ATTRIB(MEMCPY, "memcpy or dma-type instruction", "", "")
 DEF_ATTRIB(NO_INTRINSIC, "Don't generate an intrisic", "", "")
 
-/* Documentation Notes */
-DEF_ATTRIB(NOTE_CONDITIONAL, "can be conditionally executed", "", "")
-DEF_ATTRIB(NOTE_NEWVAL_SLOT0, "New-value oprnd must execute on slot 0", "", "")
-DEF_ATTRIB(NOTE_PRIV, "Monitor-level feature", "", "")
-DEF_ATTRIB(NOTE_NOPACKET, "solo instruction", "", "")
-DEF_ATTRIB(NOTE_AXOK, "May only be grouped with ALU32 or non-FP XTYPE.", "", "")
-DEF_ATTRIB(NOTE_LATEPRED, "The predicate can not be used as a .new", "", "")
-DEF_ATTRIB(NOTE_NVSLOT0, "Can execute only in slot 0 (ST)", "", "")
-DEF_ATTRIB(NOTE_NOVP, "Cannot be paired with a HVX permute instruction", "", "")
-DEF_ATTRIB(NOTE_VA_UNARY, "Combined with HVX ALU op (must be unary)", "", "")
+DEF_ATTRIB(NO_XML, "Don't generate a XML docs for this instruction", "", "")
 
-/* V6 MMVector Notes for Documentation */
-DEF_ATTRIB(NOTE_SHIFT_RESOURCE, "Uses the HVX shift resource.", "", "")
-/* Restrictions to make note of */
-DEF_ATTRIB(RESTRICT_NOSLOT1_STORE, "Packet must not have slot 1 store", "", "")
-DEF_ATTRIB(RESTRICT_LATEPRED, "Predicate can not be used as a .new.", "", "")
+DEF_ATTRIB(DMA, "User-DMA instruction", "", "")
+DEF_ATTRIB(VERIF_DMASTEP,
+           "Hiphop needs to step dma prior to executing this packet", "", "")
+DEF_ATTRIB(VERIF_DMATICK,
+           "DMA gets a tick in verif mode for this instruction after a commit",
+           "", "")
+
+DEF_ATTRIB(HVX_IEEE_FP, "HVX IEEE FP extension instruction", "", "")
+DEF_ATTRIB(NOTE_HVX_IEEE_FP,
+           "Only supported on the HVX cores with the IEEE FP extension", "", "")
+
+DEF_ATTRIB(HVX_IEEE_FP_DV_ONE,
+           "HVX IEEE FP extension instruction - dual pipes: P2 and P3 - output "
+           "only on P2",
+           "", "")
+DEF_ATTRIB(HVX_IEEE_FP_ACC, "HVX IEEE FP accumulate instruction", "", "")
+DEF_ATTRIB(HVX_IEEE_BF,
+           "HVX IEEE BF extension instruction: 16-bit bfloat input", "", "")
+DEF_ATTRIB(HVX_IEEE_FP_OUT_BF,
+           "HVX IEEE FP extension instruction: 16-bit bfloat output", "", "")
+DEF_ATTRIB(HVX_IEEE_FP_OUT_16,
+           "HVX IEEE FP extension instruction: 16-bit output", "", "")
+DEF_ATTRIB(HVX_IEEE_FP_OUT_32,
+           "HVX IEEE FP extension instruction: 32-bit output", "", "")
+DEF_ATTRIB(HVX_IEEE_FP_BINARY_LATE,
+           "HVX IEEE FP extension instruction: Both inputs can arrive late", "",
+           "")
 
 /* Keep this as the last attribute: */
 DEF_ATTRIB(ZZ_LASTATTRIB, "Last attribute in the file", "", "")
diff --git a/target/hexagon/imported/macros.def b/target/hexagon/imported/macros.def
old mode 100755
new mode 100644
index 4bbcfdd5e1..f24f89f361
--- a/target/hexagon/imported/macros.def
+++ b/target/hexagon/imported/macros.def
@@ -353,6 +353,12 @@ DEF_MACRO(
     ()
 )
 
+DEF_MACRO(
+    fREAD_SSR, /* read SSR register */
+    (READ_RREG(REG_SSR)),          /* behavior */
+    ()
+)
+
 DEF_MACRO(
     fWRITE_LR, /* write lr */
     WRITE_RREG(REG_LR,A),          /* behavior */
@@ -371,12 +377,36 @@ DEF_MACRO(
     (A_IMPLICIT_WRITES_SP)
 )
 
+DEF_MACRO(
+    fWRITE_GOSP, /* write gosp */
+    WRITE_RREG(REG_GOSP,A),          /* behavior */
+    (A_IMPLICIT_WRITES_GOSP)
+)
+
 DEF_MACRO(
     fREAD_SP, /* read stack pointer */
     (READ_RREG(REG_SP)),          /* behavior */
     ()
 )
 
+DEF_MACRO(
+    fREAD_GOSP, /* read guest other stack pointer */
+    (READ_RREG(REG_GOSP)),          /* behavior */
+    ()
+)
+
+DEF_MACRO(
+    fREAD_GELR, /* read guest other stack pointer */
+    (READ_RREG(REG_GELR)),          /* behavior */
+    ()
+)
+
+DEF_MACRO(
+    fREAD_GEVB, /* read guest other stack pointer */
+    (READ_RREG(REG_GEVB)),          /* behavior */
+    ()
+)
+
 DEF_MACRO(
     fREAD_CSREG, /* read  CS register */
     (READ_RREG(REG_CSA+N)),          /* behavior */
@@ -570,6 +600,11 @@ DEF_MACRO(
     WRITE_PREG(3,VAL),     /* behavior */
     (A_IMPLICIT_WRITES_P3)
 )
+DEF_MACRO(
+	fWRITE_P3_LATE, /* write Predicate 0 */
+	{WRITE_PREG(3,VAL); fHIDE(MARK_LATE_PRED_WRITE(3))} ,          /* behavior */
+	(A_IMPLICIT_WRITES_P3,A_RESTRICT_LATEPRED)
+)
 
 DEF_MACRO(
     fPART1, /* write Predicate 0 */
@@ -660,6 +695,7 @@ DEF_MACRO(
     ((size8s_t)((size2s_t)(A))),
     /* optional attributes */
 )
+
 DEF_MACRO(
     fCAST2_8u, /* macro name */
     ((size8u_t)((size2u_t)(A))),
@@ -1532,18 +1568,209 @@ DEF_MACRO(fECHO,
 /* OS interface and stop/wait               */
 /********************************************/
 
+DEF_MACRO(RUNNABLE_THREADS_MAX,
+    (thread->processor_ptr->runnable_threads_max),
+    ()
+)
+
+DEF_MACRO(THREAD_IS_ON,
+    ((PROC->arch_proc_options->thread_enable_mask>>TNUM) & 0x1),
+    ()
+)
+
+DEF_MACRO(THREAD_EN_MASK,
+    ((PROC->arch_proc_options->thread_enable_mask)),
+    ()
+)
+
+
+
+DEF_MACRO(READ_IMASK,
+    (((TH) >= (thread->processor_ptr->runnable_threads_max)) ? 0 : (thread->processor_ptr->thread[TH]->Regs[REG_IMASK])),
+    ()
+)
+DEF_MACRO(WRITE_IMASK,
+    if ((TH) < (thread->processor_ptr->runnable_threads_max)) { thread->processor_ptr->thread[TH]->Regs[REG_IMASK]=(VAL & reg_mutability[REG_IMASK] ); },
+    (A_IMPLICIT_WRITES_IMASK_ANYTHREAD)
+)
+
+
+DEF_MACRO(WRITE_PRIO,
+    {
+        if ((TH) < (thread->processor_ptr->runnable_threads_max)) {
+            size4u_t tid_reg = thread->processor_ptr->thread[TH]->Regs[REG_TID];
+            fINSERT_BITS(tid_reg, reg_field_info[STID_PRIO].width, reg_field_info[STID_PRIO].offset, VAL);
+            LOG_OTHER_THREAD_REG_WRITE(thread,REG_TID,tid_reg,TH);
+        }
+    },
+    (A_IMPLICIT_WRITES_STID_PRIO_ANYTHREAD)
+)
+
+
+DEF_MACRO(DO_IASSIGNW,
+    {
+        int i;
+        int intbitpos = ((REG>>16)&0xF);
+        for (i=0;i<RUNNABLE_THREADS_MAX;i++) {
+            if(( (thread->processor_ptr->arch_proc_options->thread_enable_mask>>i) & 0x1)) {
+                fINSERT_BITS(thread->processor_ptr->thread[i]->Regs[REG_IMASK],1, intbitpos, (REG>>i) & 1);
+           }
+        }
+    },
+    (A_IMPLICIT_WRITES_IMASK_ANYTHREAD)
+)
+
+
+
+
+DEF_MACRO(fDO_NMI,
+    {
+        int i;
+        for (i=0;i<RUNNABLE_THREADS_MAX;i++) {
+            if( ( (thread->processor_ptr->arch_proc_options->thread_enable_mask>>i) & 0x1) ) {
+                if (SREG & (1<<i)) {
+                    register_nmi_interrupt(thread->processor_ptr->thread[i]);
+                }
+            }
+        }
+    },
+)
+
+DEF_MACRO(fDO_TRACE,
+    {
+        fHIDE(HEX_CALLBACK(thread->processor_ptr->options->trace_callback,
+            thread->system_ptr,thread->processor_ptr,
+            thread->threadId,SREG);)
+    },
+)
+
+DEF_MACRO(DO_IASSIGNR,
+    {
+        int i;
+        int result=0;
+        int intbitpos = ((SREG>>16)&0xF);
+        for (i=0;i<RUNNABLE_THREADS_MAX;i++) {
+            if(( (thread->processor_ptr->arch_proc_options->thread_enable_mask>>i) & 0x1)) {
+                result |= (((thread->processor_ptr->thread[i]->Regs[REG_IMASK]>>intbitpos)&1)<<i);
+            }
+        }
+        DREG=result;
+    },
+    ()
+)
+
+DEF_MACRO(DO_SWI,
+        {fHIDE(HEX_CALLBACK(thread->processor_ptr->options->swi_callback,
+         thread->system_ptr,thread->processor_ptr,
+         thread->threadId,REG));
+         LOG_GLOBAL_REG_WRITE(REG_IPEND,(GLOBAL_REG_READ(REG_IPEND) | (REG & GLOBAL_REG_READ(REG_IEL))));
+        },
+        (A_EXCEPTION_SWI)
+)
+
+DEF_MACRO(DO_CSWI,
+        LOG_GLOBAL_REG_WRITE(REG_IPEND,GLOBAL_REG_READ(REG_IPEND) & ~((REG) & GLOBAL_REG_READ(REG_IEL)));,
+        ()
+)
+
+DEF_MACRO(DO_CIAD,
+        sys_ciad(thread,VAL); LOG_GLOBAL_REG_WRITE(REG_IAD,GLOBAL_REG_READ(REG_IAD) & ~(VAL));,
+        (A_EXCEPTION_SWI)
+)
+
+DEF_MACRO(DO_SIAD,
+        sys_siad(thread,VAL); LOG_GLOBAL_REG_WRITE(REG_IAD,GLOBAL_REG_READ(REG_IAD) | (VAL));,
+        (A_EXCEPTION_SWI)
+)
+
+DEF_MACRO(fBREAK,
+    {isdb_brkpt_insn(thread->processor_ptr,thread->threadId);},
+    ()
+)
+
 DEF_MACRO(fPAUSE,
     {sys_pause(thread, insn->slot, IMM);},
     ()
 )
 
+
 DEF_MACRO(fTRAP,
     warn("Trap NPC=%x ",fREAD_NPC());
     warn("Trap exception, PCYCLE=%lld TYPE=%d NPC=%x IMM=0x%x",thread->processor_ptr->pstats[pcycles],TRAPTYPE,fREAD_NPC(),IMM);
     register_trap_exception(thread,fREAD_NPC(),TRAPTYPE,IMM);,
+    (A_EXCEPTION_SWI)
+)
+
+DEF_MACRO(fINTERNAL_CLEAR_SAMEPAGE,
+    /* force re-xlate at next fetch, refresh of in_user_mode, etc */
+    /* Permissions change too... */
+    sys_utlb_invalidate(thread->processor_ptr,thread),
+    /* NOTHING */
+)
+
+DEF_MACRO(fCLEAR_RTE_EX,
+      {
+        fLOG_REG_FIELD(SSR,SSR_EX,0);
+        fINTERNAL_CLEAR_SAMEPAGE();
+      },
+      ()
+)
+
+DEF_MACRO(fTLB_LOCK_AVAILABLE,
+    (fREAD_GLOBAL_REG_FIELD(SYSCONF,SYSCFG_TLBLOCK) == 0),
     ()
 )
 
+DEF_MACRO(fK0_LOCK_AVAILABLE,
+    (fREAD_GLOBAL_REG_FIELD(SYSCONF,SYSCFG_K0LOCK) == 0),
+    ()
+)
+
+DEF_MACRO(fSET_TLB_LOCK,
+      {
+      if (fTLB_LOCK_AVAILABLE()) {
+        fLOG_GLOBAL_REG_FIELD(SYSCONF,SYSCFG_TLBLOCK,1);
+      } else {
+        sys_waiting_for_tlb_lock(thread);
+      }
+      },
+      ()
+)
+
+DEF_MACRO(fSET_K0_LOCK,
+      {
+          if (fK0_LOCK_AVAILABLE() && sys_k0lock_queue_ready(thread)) {
+              warn("k0lock: T%d: PC=0x%x: PCycle=%lld",thread->threadId,thread->Regs[REG_PC],thread->processor_ptr->pstats[pcycles]);
+              fLOG_GLOBAL_REG_FIELD(SYSCONF,SYSCFG_K0LOCK,1);
+          } else {
+              warn("k0lock_waiting: T%d: PC=0x%x: PCycle=%lld",thread->threadId,thread->Regs[REG_PC],thread->processor_ptr->pstats[pcycles]);
+                sys_waiting_for_k0_lock(thread);
+          }
+      },
+      ()
+)
+
+DEF_MACRO(fCLEAR_TLB_LOCK,
+      {
+          int i;
+          fLOG_GLOBAL_REG_FIELD(SYSCONF,SYSCFG_TLBLOCK,0);
+          for (i = 0; i < RUNNABLE_THREADS_MAX; i++) {
+              if(( (thread->processor_ptr->arch_proc_options->thread_enable_mask>>i) & 0x1)) {
+                  thread->processor_ptr->thread[i]->cu_tlb_lock_waiting = 0;
+              }
+          }
+      },
+      ()
+)
+
+DEF_MACRO(fCLEAR_K0_LOCK,
+      do {
+      warn("k0unlock: T%d: PC=0x%x: Pcycle=%lld",thread->threadId,thread->Regs[REG_PC], thread->processor_ptr->pstats[pcycles]);
+      sys_initiate_clear_k0_lock(thread);
+      } while (0),
+      ()
+)
+
 DEF_MACRO(fALIGN_REG_FIELD_VALUE,
     ((VAL)<<reg_field_info[FIELD].offset),
     /* */
@@ -1554,6 +1781,26 @@ DEF_MACRO(fGET_REG_FIELD_MASK,
     /* */
 )
 
+DEF_MACRO(fLOG_REG_FIELD,
+    LOG_MASKED_REG_WRITE(thread,REG_##REG,
+    fALIGN_REG_FIELD_VALUE(FIELD,VAL),
+    fGET_REG_FIELD_MASK(FIELD)),
+    ()
+)
+
+DEF_MACRO(fWRITE_GLOBAL_REG_FIELD,
+    fINSERT_BITS(thread->processor_ptr->global_regs[REG_##REG],
+            reg_field_info[FIELD].width,
+            reg_field_info[FIELD].offset,VAL),
+)
+
+DEF_MACRO(fLOG_GLOBAL_REG_FIELD,
+    LOG_MASKED_GLOBAL_REG_WRITE(REG_##REG,
+        fALIGN_REG_FIELD_VALUE(FIELD,VAL),
+        fGET_REG_FIELD_MASK(FIELD)),
+    ()
+)
+
 DEF_MACRO(fREAD_REG_FIELD,
     fEXTRACTU_BITS(thread->Regs[REG_##REG],
         reg_field_info[FIELD].width,
@@ -1561,6 +1808,13 @@ DEF_MACRO(fREAD_REG_FIELD,
     /* ATTRIBS */
 )
 
+DEF_MACRO(fREAD_GLOBAL_REG_FIELD,
+    fEXTRACTU_BITS(thread->processor_ptr->global_regs[REG_##REG],
+        reg_field_info[FIELD].width,
+        reg_field_info[FIELD].offset),
+    /* ATTRIBS */
+)
+
 DEF_MACRO(fGET_FIELD,
     fEXTRACTU_BITS(VAL,
         reg_field_info[FIELD].width,
@@ -1576,6 +1830,185 @@ DEF_MACRO(fSET_FIELD,
     /* ATTRIBS */
 )
 
+DEF_MACRO(fSET_RUN_MODE_NOW,
+        {thread->processor_ptr->global_regs[REG_MODECTL] |= (1<<TNUM);
+         thread->last_commit_cycle = thread->processor_ptr->pcycle_counter;
+         sys_recalc_num_running_threads(thread->processor_ptr);},
+)
+
+DEF_MACRO(fIN_DEBUG_MODE,
+    (thread->debug_mode || (fREAD_GLOBAL_REG_FIELD(ISDBST,ISDBST_DEBUGMODE) & 1<<TNUM)),
+    ()
+)
+DEF_MACRO(fIN_DEBUG_MODE_NO_ISDB,
+    (thread->debug_mode),
+    ()
+)
+
+
+DEF_MACRO(fIN_DEBUG_MODE_WARN,
+    {
+        if (fREAD_GLOBAL_REG_FIELD(ISDBST,ISDBST_DEBUGMODE) & 1<<TNUM)
+            warn("In ISDB debug mode, but TB told me to step normally");
+    },
+    ()
+)
+
+DEF_MACRO(fCLEAR_RUN_MODE,
+    {fLOG_GLOBAL_REG_FIELD(MODECTL,MODECTL_E,
+     fREAD_GLOBAL_REG_FIELD(MODECTL,MODECTL_E) & ~(1<<(TNUM)))},
+    /* NOTHING */
+)
+
+DEF_MACRO(fCLEAR_RUN_MODE_NOW,
+    do {
+        fWRITE_GLOBAL_REG_FIELD(MODECTL,MODECTL_E,
+        fREAD_GLOBAL_REG_FIELD(MODECTL,MODECTL_E) & ~(1<<(TNUM)));
+        sys_recalc_num_running_threads(thread->processor_ptr);
+    } while (0),
+    /* NOTHING */
+)
+
+DEF_MACRO(fGET_RUN_MODE,
+        ((thread->processor_ptr->global_regs[REG_MODECTL]>>TNUM)&0x1),
+)
+
+DEF_MACRO(fSET_WAIT_MODE,
+    {fLOG_GLOBAL_REG_FIELD(MODECTL,MODECTL_W,
+    fREAD_GLOBAL_REG_FIELD(MODECTL,MODECTL_W) | 1<<(TNUM))},
+    /* NOTHING */
+)
+
+DEF_MACRO(fCLEAR_WAIT_MODE,
+        {thread->processor_ptr->global_regs[REG_MODECTL] &= ~(1<<(TNUM+16));
+         thread->last_commit_cycle = thread->processor_ptr->pcycle_counter;
+         sys_recalc_num_running_threads(thread->processor_ptr);},
+)
+
+DEF_MACRO(fGET_WAIT_MODE,
+        ((thread->processor_ptr->global_regs[REG_MODECTL]>>(TNUM+16))&0x1),
+)
+
+
+DEF_MACRO(fRESET_THREAD,
+        register_reset_interrupt(T,NUM),
+)
+
+DEF_MACRO(fREAD_CURRENT_EVB,
+    (GLOBAL_REG_READ(REG_EVB)),
+    /* nothing */
+)
+
+DEF_MACRO(fREAD_ELR,
+    READ_RREG(REG_ELR),
+    ()
+)
+
+DEF_MACRO(fPOW2_HELP_ROUNDUP,
+    ((VAL) | ((VAL) >> 1) | ((VAL) >> 2) | ((VAL) >> 4) | ((VAL) >> 8) | ((VAL) >> 16)),
+    ()
+)
+
+DEF_MACRO(fPOW2_ROUNDUP,
+    fPOW2_HELP_ROUNDUP((VAL)-1)+1,
+    ()
+)
+
+DEF_MACRO(fTLB_IDXMASK,
+    ((INDEX) & (fPOW2_ROUNDUP(fCAST4u(thread->processor_ptr->arch_proc_options->jtlb_size)) - 1)),
+    ()
+)
+
+DEF_MACRO(fTLB_NONPOW2WRAP,
+    (((INDEX) >= thread->processor_ptr->arch_proc_options->jtlb_size) ? ((INDEX) - thread->processor_ptr->arch_proc_options->jtlb_size) : (INDEX)),
+    /* ATTRIBS */
+)
+
+DEF_MACRO(fTLBW,
+    do {size4u_t __myidx = fTLB_NONPOW2WRAP(fTLB_IDXMASK(INDEX));
+        TLB_REG_WRITE(__myidx,VALUE);
+        fHIDE(HEX_CALLBACK(thread->processor_ptr->options->tlbw_callback,thread->system_ptr,thread->processor_ptr,thread->threadId,__myidx);)
+        fHIDE(sys_tlb_write(thread,__myidx,VALUE);)} while (0),
+    /* ATTRIBS */
+)
+
+DEF_MACRO(fTLB_ENTRY_OVERLAP,
+    fHIDE( (sys_check_overlap(thread,VALUE)!=-2) ),
+    /* ATTRIBS */
+)
+
+DEF_MACRO(fTLB_ENTRY_OVERLAP_IDX,
+    fHIDE(sys_check_overlap(thread,VALUE)),
+    /* ATTRIBS */
+)
+
+
+DEF_MACRO(fTLBR,
+    TLB_REG_READ(fTLB_NONPOW2WRAP(fTLB_IDXMASK(INDEX))),
+    /* ATTRIBS */
+)
+
+DEF_MACRO(fTLBP,
+    tlb_lookup(thread,((TLBHI)>>12),((TLBHI)<<12),1),
+    /* attribs */
+)
+
+
+
+DEF_MACRO(READ_SGP0,
+    READ_RREG(REG_SGP),
+    ()
+)
+
+DEF_MACRO(READ_SGP1,
+    READ_RREG(REG_SGP+1),
+    ()
+)
+
+DEF_MACRO(READ_SGP10,
+    READ_RREG_PAIR(REG_SGP),
+    ()
+)
+
+DEF_MACRO(READ_UGP,
+    READ_RREG(REG_UGP),
+)
+
+DEF_MACRO(WRITE_SGP0,
+    WRITE_RREG(REG_SGP,VAL),
+    (A_IMPLICIT_WRITES_SGP0)
+)
+
+DEF_MACRO(WRITE_SGP1,
+    WRITE_RREG(REG_SGP+1,VAL),
+    (A_IMPLICIT_WRITES_SGP1)
+)
+
+DEF_MACRO(WRITE_SGP10,
+    WRITE_RREG_PAIR(REG_SGP,VAL),
+    (A_IMPLICIT_WRITES_SGP0,A_IMPLICIT_WRITES_SGP1)
+)
+
+DEF_MACRO(WRITE_UGP,
+        WRITE_RREG(REG_UGP,VAL),
+)
+
+DEF_MACRO(fSTART,
+    fLOG_GLOBAL_REG_FIELD(MODECTL,MODECTL_E, fREAD_GLOBAL_REG_FIELD(MODECTL,MODECTL_E) | (((REG & ((1<<RUNNABLE_THREADS_MAX)-1))) & THREAD_EN_MASK(thread->processor_ptr))),
+    ()
+)
+
+DEF_MACRO(fRESUME,
+    fLOG_GLOBAL_REG_FIELD(MODECTL,MODECTL_W,
+    fREAD_GLOBAL_REG_FIELD(MODECTL,MODECTL_W) & (~(REG))),
+    ()
+)
+
+DEF_MACRO(fGET_TNUM,
+    thread->threadId,
+    ()
+)
+
 /********************************************/
 /* Cache Management                         */
 /********************************************/
@@ -1602,6 +2035,11 @@ DEF_MACRO(fISYNC,
 )
 
 
+DEF_MACRO(fICFETCH,
+    ,
+    ()
+)
+
 DEF_MACRO(fDCFETCH,
     sys_dcfetch(thread, (REG), insn->slot),
     (A_MEMLIKE)
@@ -1615,6 +2053,34 @@ DEF_MACRO(fICINVA,
     (A_ICINVA)
 )
 
+DEF_MACRO(fDCTAGR,
+    ({DST=sys_dctagr(thread, INDEX, insn->slot,DSTREGNO);})/* FIXME */,
+    ()
+)
+
+DEF_MACRO(fDCTAGW,
+    (sys_dctagw(thread, INDEX, PART2, insn->slot)),
+    ()
+)
+DEF_MACRO(fICTAGR,
+    ({DST=sys_ictagr(thread, INDEX, insn->slot,REGNO);}),
+    ()
+)
+
+DEF_MACRO(fICDATAR,
+    ({DST=sys_icdatar(thread, INDEX, insn->slot);}),
+    ()
+)
+
+DEF_MACRO(fICTAGW,
+    (sys_ictagw(thread, INDEX, PART2, insn->slot)),
+    ()
+)
+DEF_MACRO(fICDATAW,
+    ({ fHIDE(); }),
+    ()
+)
+
 DEF_MACRO(fL2FETCH,
     sys_l2fetch(thread, ADDR,HEIGHT,WIDTH,STRIDE,FLAGS, insn->slot),
     (A_MEMLIKE,A_L2FETCH)
@@ -1635,6 +2101,12 @@ DEF_MACRO(fDCZEROA,
     (A_MEMLIKE)
 )
 
+DEF_MACRO(fDCINVA,
+    sys_dcinva(thread, (REG)),
+    (A_MEMLIKE)
+)
+
+
 DEF_MACRO(fCHECKFORPRIV,
     {sys_check_privs(thread); if (EXCEPTION_DETECTED) return; },
     ()
@@ -1645,6 +2117,16 @@ DEF_MACRO(fCHECKFORGUEST,
     ()
 )
 
+DEF_MACRO(fTAKEN_INTERRUPT_EDGECLEAR,
+        { proc->global_regs[REG_IPEND] &= ~(INT_NUMTOMASK(intnum) & proc->global_regs[REG_IEL]); },
+        ()
+)
+
+DEF_MACRO(fSET_IAD,
+        { sys_siad(thread,INT_NUMTOMASK(intnum)); thread->processor_ptr->global_regs[REG_IAD] |= INT_NUMTOMASK(intnum); },
+        ()
+)
+
 DEF_MACRO(fBRANCH_SPECULATE_STALL,
     {
         sys_speculate_branch_stall(thread, insn->slot, JUMP_COND(JUMP_PRED_SET),
@@ -1664,3 +2146,79 @@ DEF_MACRO(IV1DEAD,
     ,
     ()
 )
+
+DEF_MACRO(fIN_MONITOR_MODE,
+    sys_in_monitor_mode(thread),
+    ()
+)
+
+DEF_MACRO(fIN_USER_MODE,
+    sys_in_user_mode(thread),
+    ()
+)
+
+DEF_MACRO(fIN_GUEST_MODE,
+    sys_in_guest_mode(thread),
+    ()
+)
+
+DEF_MACRO(fGRE_ENABLED,
+    fREAD_REG_FIELD(CCR,CCR_GRE),
+    ()
+)
+
+DEF_MACRO(fGTE_ENABLED,
+    fREAD_REG_FIELD(CCR,CCR_GRE),
+    ()
+)
+
+DEF_MACRO(fTRAP1_VIRTINSN,
+    ((fIN_GUEST_MODE())
+     && (fGRE_ENABLED())
+     && (   ((IMM) == 1)
+         || ((IMM) == 3)
+         || ((IMM) == 4)
+         || ((IMM) == 6))),
+    ()
+)
+
+DEF_MACRO(fVIRTINSN_RTE,
+    do {
+        thread->trap1_info = TRAP1_VIRTINSN_RTE;
+        fLOG_REG_FIELD(SSR,SSR_SS,fREAD_REG_FIELD(GSR,GSR_SS));
+        fLOG_REG_FIELD(CCR,CCR_GIE,fREAD_REG_FIELD(GSR,GSR_IE));
+        fLOG_REG_FIELD(SSR,SSR_GM,!fREAD_REG_FIELD(GSR,GSR_UM));
+        fBRANCH((fREAD_GELR() & -4),COF_TYPE_RTE);
+        fINTERNAL_CLEAR_SAMEPAGE();
+    } while (0),
+    (A_IMPLICIT_WRITES_CCR,A_IMPLICIT_WRITES_SSR)
+)
+
+DEF_MACRO(fVIRTINSN_SETIE,
+    do {
+        fLOG_REG_FIELD(CCR,CCR_GIE,(REG) & 1);
+        REG = fREAD_REG_FIELD(CCR,CCR_GIE);
+        thread->trap1_info = TRAP1_VIRTINSN_SETIE;
+    } while (0),
+    (A_IMPLICIT_WRITES_CCR)
+)
+
+DEF_MACRO(fVIRTINSN_GETIE,
+    {
+        thread->trap1_info = TRAP1_VIRTINSN_GETIE;
+        REG = fREAD_REG_FIELD(CCR,CCR_GIE);
+    },
+    ()
+)
+
+DEF_MACRO(fVIRTINSN_SPSWAP,
+    do {
+        if (fREAD_REG_FIELD(GSR,GSR_UM)) {
+            size4u_t TEMP = REG;
+            REG = fREAD_GOSP();
+            fWRITE_GOSP(TEMP);
+            thread->trap1_info = TRAP1_VIRTINSN_SPSWAP;
+        }
+    } while (0),
+    (A_IMPLICIT_WRITES_GOSP)
+)
-- 
2.34.1


