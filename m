Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF0CF417EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv1-0001Ke-Ni; Mon, 09 Mar 2026 10:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbud-0000s3-89
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuZ-0005GI-Sw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629DqgRL2137771
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1fV3rBwQoe8iGzmQY/2nS9021QVzehxmk5ZY/0UTJes=; b=et0yXiBNjoZWfoxE
 XSczwUS0bAq8DYwf/cGAXughomC3d/w6JDV5hcVLqniPiVzveomfOrga0YRxcEpL
 2yFgYDDUTFHswsld1Vqu0O4K1YHYpeCMV82kSLZnn2oxrXTnezxszRZcG+39K6J/
 vnyHvlQWxoJm2iT9/lUK3WwK15NaNJrXv8UHP730e8WGDHCpKDb2fhNtDSjLL44j
 qq4vL/V10KU04rXZzrXa2j9jYG5l0/9jSQ4TonKFgypsErATBq8kCOKClkQwaGlo
 xwjrhgU41mbESXgC6t3+/7qKKw7r1wGQQvN7l8qmpJSdRDxib8oTfVWwRQNgrmmh
 A8rMKQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyft05up-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2be191ce356so8524631eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067725; x=1773672525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fV3rBwQoe8iGzmQY/2nS9021QVzehxmk5ZY/0UTJes=;
 b=kxA6h34XZagELaNH3llo4tWlplPR/CcLljZZ0BbbdmfwR/eT7HMMzMeJYjRlg+cASl
 odL648hLAr3wooaE7g5ylUjp6nFDJsWUWcPX3nhAjj1rIppxqes4QjjaKHX7VmXsr19M
 zkPu+vypr6brvVkQ3dGAQcCMKDY78V546louV1qyN4uNPDMjNaiPoUmLtgP6Md42YkNw
 EooddhDzflaKNmzthA9AASQ8rK6stRzxZZJYo+U+/AQXqwTSXiaEU0BGIGU+CR+46Dfn
 D+fUumnZZvky7q46yy055FmzfjhFLH2TIQ3Xif+kGNXDMjHDAltWX5ywnseDtvT1v1KY
 A6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067725; x=1773672525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1fV3rBwQoe8iGzmQY/2nS9021QVzehxmk5ZY/0UTJes=;
 b=LDCqc0u5AKy9ZkoH5NnGxzvN3ZcB0qRfuGzps9tFA6sZoVjvXks2IVYuWflUdGWBFr
 CkbW9JxIr6OT/4N66QaQkjLun4GwCjoUE+zEwSt4wgSsDetsLiDqlcoByJolGjJAUhQn
 MAa7h+FwxtD9NlmD2cvV0r/xNu7VnhGGhSheGgEIGlvtqvCnL2B0sgz7WDHpfEKUPmuw
 NrdXX8ksLgQ+xYCQZ+t5iWti2DTIzRKWK1Z02/nssD92CKQ6PBp507rYjxadbnRRy2VL
 m0BuIHDAPSqeG4PIq52Z5OP2+f8pN9k73MxeUZ1RS0xx7+EdoztfphkINf0ApCdgjgr0
 e75w==
X-Gm-Message-State: AOJu0Yxh8Te58TiqBgQqRR84BGQRRmwYlEY+NnuDV9pEW/dFVj00r1mN
 QffyD4TODsKBL2ql0FF+r7rwk87RgrnkNrM1QOm/Cn1emeuzq4ANviy6Tbjm2MoebC5JyjWdzJa
 vV4ynbUlp6s6y78FJAsw2naUc0ufPgPIAanuACp1bEVKX/lVGGqwMJMK7XyU7aq3CuQ==
X-Gm-Gg: ATEYQzw5At45BnaIqBeVjyHLCdW+qDqIcPU4AnbNeVZs+nv4JvzAgFYKP8KGhJVA5fm
 uhLs77D0kKZjy0nsZy/Rn8PWOWzwCaPcnG9husCJMwtrk8N1al7h0lTKxXyT0hi2yHd3wH/gVMG
 zQ2cc7eWCI1P9/SSbZcs6F6COopHSpARzYov9zM4An7GRsIVhXCAHLfKrwYV1KVl3COX+o2IqMH
 kXg8WGfRzxDjuQPLNSrBkjZlJuKle4GLY3YcNY8fHGz9vv4Dml/Y6w/D0wR8lXuWx7Hq7kS9SsX
 Dvzq0KhQWXlc/Knn8VVNB8knOdOJNeOqZB32/nXjDcOHhKvuRUtjniEMVR13SgCCJoPtTlXA88D
 pFu9r+xTll8oxshSQBy6MEZP2GHN9Yi581z5bYaTQKBg/qfI9gyKQ2BXbZ1PUiTwFx3SHBw==
X-Received: by 2002:a05:7300:fd0e:b0:2ba:7783:d1c0 with SMTP id
 5a478bee46e88-2be4dead952mr4291112eec.9.1773067724201; 
 Mon, 09 Mar 2026 07:48:44 -0700 (PDT)
X-Received: by 2002:a05:7300:fd0e:b0:2ba:7783:d1c0 with SMTP id
 5a478bee46e88-2be4dead952mr4291081eec.9.1773067723532; 
 Mon, 09 Mar 2026 07:48:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 15/35] target/hexagon: Add imported macro,
 attr defs for sysemu
Date: Mon,  9 Mar 2026 07:48:02 -0700
Message-Id: <20260309144822.877695-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Zt875oRIx8g_VE0ryTAvBtMeBvsm0Ra4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX2LTWajLf/Iqr
 BKIOE/ADpu+lY215xeYZeyNPuiTfqKxMVMu4qJ8ZC9YYfjf7rJUdYJkWj/yx4yBwFdvYsF0r243
 Btx8awWs4N2kEGgqJgXLWK9bka+DWP6ojPB9CzuOoBDfW6qScq/t2cfeiODFt/tZwL1UrTMbPH1
 Tch7HtfOS3Ywd5kwgIu319CtwXhETHWvw3Gig6U6FX87ajCUqSnhNSDuVg+6/T33/J5rVzZSFnd
 2BJVhEKA8NVqp61rlzvpeniXgdshSsEHZuL2maMwhoh0WjQmE0wNS5Zv7CodZrM85cpeVKrRYOF
 43BH9SAh+OSczaDwllkqRTUf1ZwvDpUCDJr5P4ibvfs70cnyOxSRh8/DGg4tjSbKJVFWSr00e7H
 6TIBAEq36U1uN3mvtGsckUbT6BJOsJtjX8JTNsu05+q4/X5JqiuH21NRTzgPmW+E5JLJTBz6tZU
 FGbNh0emrQHGqpUfZig==
X-Proofpoint-GUID: Zt875oRIx8g_VE0ryTAvBtMeBvsm0Ra4
X-Authority-Analysis: v=2.4 cv=F8dat6hN c=1 sm=1 tr=0 ts=69aeddce cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=i3OrD5w6cDdmGd68u_gA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/attribs_def.h.inc   |  49 ++-
 target/hexagon/imported/macros.def | 482 ++++++++++++++++++++++++++++-
 2 files changed, 518 insertions(+), 13 deletions(-)
 mode change 100755 => 100644 target/hexagon/imported/macros.def

diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.h.inc
index 9e3a05f8828..06ab826b49f 100644
--- a/target/hexagon/attribs_def.h.inc
+++ b/target/hexagon/attribs_def.h.inc
@@ -52,6 +52,9 @@ DEF_ATTRIB(REGWRSIZE_4B, "Memory width is 4 bytes", "", "")
 DEF_ATTRIB(REGWRSIZE_8B, "Memory width is 8 bytes", "", "")
 DEF_ATTRIB(MEMLIKE, "Memory-like instruction", "", "")
 DEF_ATTRIB(MEMLIKE_PACKET_RULES, "follows Memory-like packet rules", "", "")
+DEF_ATTRIB(CACHEOP, "Cache operation", "", "")
+DEF_ATTRIB(COPBYADDRESS, "Cache operation by address", "", "")
+DEF_ATTRIB(COPBYIDX, "Cache operation by index", "", "")
 DEF_ATTRIB(RELEASE, "Releases a lock", "", "")
 DEF_ATTRIB(ACQUIRE, "Acquires a lock", "", "")
 
@@ -101,23 +104,44 @@ DEF_ATTRIB(ROPS_3, "Compound instruction worth 3 RISC-ops", "", "")
 
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
 DEF_ATTRIB(IMPLICIT_WRITES_USR, "May write USR", "", "")
-DEF_ATTRIB(IMPLICIT_READS_SP, "Reads the SP register", "", "")
+DEF_ATTRIB(IMPLICIT_WRITES_CCR, "Writes CCR register", "", "UREG.CCR")
+DEF_ATTRIB(IMPLICIT_WRITES_GOSP, "Writes GOSP register", "", "UREG.GOSP")
+DEF_ATTRIB(IMPLICIT_WRITES_SSR, "Writes SSR register", "", "UREG.SSR")
+DEF_ATTRIB(IMPLICIT_WRITES_SGP0, "Writes SGP0 register", "", "UREG.SGP0")
+DEF_ATTRIB(IMPLICIT_WRITES_SGP1, "Writes SGP1 register", "", "UREG.SGP1")
+DEF_ATTRIB(IMPLICIT_WRITES_IMASK_ANYTHREAD,
+    "Writes IMASK for any thread", "", "")
+DEF_ATTRIB(IMPLICIT_WRITES_STID_PRIO_ANYTHREAD,
+    "Writes STID priority for any thread", "", "")
 DEF_ATTRIB(COMMUTES, "The operation is communitive", "", "")
 DEF_ATTRIB(DEALLOCRET, "dealloc_return", "", "")
 DEF_ATTRIB(DEALLOCFRAME, "deallocframe", "", "")
@@ -137,9 +161,15 @@ DEF_ATTRIB(RESTRICT_SLOT3ONLY, "Must execute on slot3", "", "")
 DEF_ATTRIB(RESTRICT_NOSLOT1, "No slot 1 instruction in parallel", "", "")
 DEF_ATTRIB(RESTRICT_PREFERSLOT0, "Try to encode into slot 0", "", "")
 DEF_ATTRIB(RESTRICT_PACKET_AXOK, "May exist with A-type or X-type", "", "")
+DEF_ATTRIB(RESTRICT_SINGLE_MEM_FIRST, "Single memory op must be first", "", "")
+DEF_ATTRIB(RESTRICT_SLOT1_AOK, "Slot 1 is allowed", "", "")
 
 DEF_ATTRIB(ICOP, "Instruction cache op", "", "")
 
+DEF_ATTRIB(EXCEPTION_SWI, "Software interrupt exception", "", "")
+DEF_ATTRIB(DMA, "DMA instruction", "", "")
+DEF_ATTRIB(NO_TIMING_LOG, "Does not get logged to the timing model", "", "")
+
 DEF_ATTRIB(HWLOOP0_END, "Ends HW loop0", "", "")
 DEF_ATTRIB(HWLOOP1_END, "Ends HW loop1", "", "")
 DEF_ATTRIB(RET_TYPE, "return type", "", "")
@@ -151,6 +181,10 @@ DEF_ATTRIB(DCFETCH, "dcfetch type", "", "")
 
 DEF_ATTRIB(L2FETCH, "Instruction is l2fetch type", "", "")
 
+DEF_ATTRIB(DCTAGOP, "Data cache tag operation", "", "")
+DEF_ATTRIB(ICTAGOP, "Instruction cache tag operation", "", "")
+DEF_ATTRIB(L2TAGOP, "L2 cache tag operation", "", "")
+
 DEF_ATTRIB(ICINVA, "icinva", "", "")
 DEF_ATTRIB(DCCLEANINVA, "dccleaninva", "", "")
 
@@ -166,6 +200,9 @@ DEF_ATTRIB(NOTE_LATEPRED, "The predicate can not be used as a .new", "", "")
 DEF_ATTRIB(NOTE_NVSLOT0, "Can execute only in slot 0 (ST)", "", "")
 DEF_ATTRIB(NOTE_NOVP, "Cannot be paired with a HVX permute instruction", "", "")
 DEF_ATTRIB(NOTE_VA_UNARY, "Combined with HVX ALU op (must be unary)", "", "")
+DEF_ATTRIB(NOTE_SLOT1_AOK, "Slot 1 is allowed", "", "")
+DEF_ATTRIB(NOTE_GUEST, "Guest mode instruction", "", "")
+DEF_ATTRIB(NOTE_BADTAG_UNDEF, "Bad tag results in undefined behavior", "", "")
 
 /* V6 MMVector Notes for Documentation */
 DEF_ATTRIB(NOTE_SHIFT_RESOURCE, "Uses the HVX shift resource.", "", "")
diff --git a/target/hexagon/imported/macros.def b/target/hexagon/imported/macros.def
old mode 100755
new mode 100644
index 4bbcfdd5e19..13eb13c71f7
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
@@ -1532,18 +1568,137 @@ DEF_MACRO(fECHO,
 /* OS interface and stop/wait               */
 /********************************************/
 
+DEF_MACRO(RUNNABLE_THREADS_MAX,
+    /* */,
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
+    /* */,
+    ()
+)
+DEF_MACRO(WRITE_IMASK,
+    /* */,
+    (A_IMPLICIT_WRITES_IMASK_ANYTHREAD)
+)
+
+
+DEF_MACRO(WRITE_PRIO,
+    /* */,
+    (A_IMPLICIT_WRITES_STID_PRIO_ANYTHREAD)
+)
+
+
+DEF_MACRO(DO_IASSIGNW,
+    /* */,
+    (A_IMPLICIT_WRITES_IMASK_ANYTHREAD)
+)
+
+
+
+
+DEF_MACRO(fDO_NMI,
+    /* */,
+)
+
+DEF_MACRO(fDO_TRACE,
+    /* */,
+)
+
+DEF_MACRO(DO_IASSIGNR,
+    /* */,
+    ()
+)
+
+DEF_MACRO(DO_SWI,
+        /* */,
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
+    /* */,
+    ()
+)
+
 DEF_MACRO(fPAUSE,
     {sys_pause(thread, insn->slot, IMM);},
     ()
 )
 
+
 DEF_MACRO(fTRAP,
-    warn("Trap NPC=%x ",fREAD_NPC());
-    warn("Trap exception, PCYCLE=%lld TYPE=%d NPC=%x IMM=0x%x",thread->processor_ptr->pstats[pcycles],TRAPTYPE,fREAD_NPC(),IMM);
-    register_trap_exception(thread,fREAD_NPC(),TRAPTYPE,IMM);,
+    /* */,
+    (A_EXCEPTION_SWI)
+)
+
+DEF_MACRO(fCLEAR_RTE_EX,
+      /* */,
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
+      /* */,
+      ()
+)
+
+DEF_MACRO(fCLEAR_TLB_LOCK,
+      /* */,
+      ()
+)
+
+DEF_MACRO(fCLEAR_K0_LOCK,
+      /* */,
+      ()
+)
+
 DEF_MACRO(fALIGN_REG_FIELD_VALUE,
     ((VAL)<<reg_field_info[FIELD].offset),
     /* */
@@ -1554,6 +1709,24 @@ DEF_MACRO(fGET_REG_FIELD_MASK,
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
+    /* */,
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
@@ -1561,6 +1734,11 @@ DEF_MACRO(fREAD_REG_FIELD,
     /* ATTRIBS */
 )
 
+DEF_MACRO(fREAD_GLOBAL_REG_FIELD,
+    /* */,
+    /* ATTRIBS */
+)
+
 DEF_MACRO(fGET_FIELD,
     fEXTRACTU_BITS(VAL,
         reg_field_info[FIELD].width,
@@ -1576,6 +1754,174 @@ DEF_MACRO(fSET_FIELD,
     /* ATTRIBS */
 )
 
+DEF_MACRO(fSET_RUN_MODE_NOW,
+        /* */,
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
+    /* */,
+    /* NOTHING */
+)
+
+DEF_MACRO(fGET_RUN_MODE,
+        /* */,
+)
+
+DEF_MACRO(fSET_WAIT_MODE,
+    {fLOG_GLOBAL_REG_FIELD(MODECTL,MODECTL_W,
+    fREAD_GLOBAL_REG_FIELD(MODECTL,MODECTL_W) | 1<<(TNUM))},
+    /* NOTHING */
+)
+
+DEF_MACRO(fCLEAR_WAIT_MODE,
+        /* */,
+)
+
+DEF_MACRO(fGET_WAIT_MODE,
+        /* */,
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
+    /* */,
+    ()
+)
+
+DEF_MACRO(fTLB_NONPOW2WRAP,
+    /* */,
+    /* ATTRIBS */
+)
+
+DEF_MACRO(fTLBW,
+    /* */,
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
+    /* */,
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
@@ -1602,19 +1948,49 @@ DEF_MACRO(fISYNC,
 )
 
 
+DEF_MACRO(fICFETCH,
+    ,
+    ()
+)
+
 DEF_MACRO(fDCFETCH,
     sys_dcfetch(thread, (REG), insn->slot),
     (A_MEMLIKE)
 )
 
 DEF_MACRO(fICINVA,
-    {
-        arch_internal_flush(thread->processor_ptr, 0, 0xffffffff);
-        sys_icinva(thread, (REG),insn->slot);
-    },
+    /* */,
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
@@ -1635,6 +2011,12 @@ DEF_MACRO(fDCZEROA,
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
@@ -1645,6 +2027,16 @@ DEF_MACRO(fCHECKFORGUEST,
     ()
 )
 
+DEF_MACRO(fTAKEN_INTERRUPT_EDGECLEAR,
+        { proc->global_regs[REG_IPEND] &= ~(INT_NUMTOMASK(intnum) & proc->global_regs[REG_IEL]); },
+        ()
+)
+
+DEF_MACRO(fSET_IAD,
+    /* */,
+    ()
+)
+
 DEF_MACRO(fBRANCH_SPECULATE_STALL,
     {
         sys_speculate_branch_stall(thread, insn->slot, JUMP_COND(JUMP_PRED_SET),
@@ -1664,3 +2056,79 @@ DEF_MACRO(IV1DEAD,
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


