Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72883F417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv3-0001QL-2l; Mon, 09 Mar 2026 10:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuh-0000sL-TR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbug-0005HE-8B
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:55 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629ERLeS4164456
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5qaVcQk9nY/+Sck+k5N7Cra59kGFWFnLRS5Q2nhbM5k=; b=kIN3Xw7RDBokCfU+
 w48Kv07T28Q1rLEcgziuglmf9hnmAixwFby66dqcPZtqpi5Pe/0XHwh2eszur6cU
 7XY4+WsR3ayVFgA+vkCeVEviyy6r3ReEHW47Gsklcv18SWILckV42+pFMJQnjJQM
 2Nt++0joJ/sgYUuZJ2SPFjnp9qTsd83lBrNgB3mdptKyrIkyE08pRyrLubukK/ob
 Tz5hGUl03w5yxf94qgcSS2PQ0AIgCcP0a9+GoinQVBJIw2MAoznyhHePrtPD1UkN
 ft2lMvSC4R5CVDeVnwEpO8p8JihvQmJUygXvMt4YA8aqjwJDT7sCIeUVp0NBjKWn
 J8bYRg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crd6fdr72-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:52 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-128d0a51897so59679058c88.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067732; x=1773672532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qaVcQk9nY/+Sck+k5N7Cra59kGFWFnLRS5Q2nhbM5k=;
 b=ST4dApqfoowbJ7T6vHWBJEo2IRn7cyB/Ung8SdqCSYG0Nyj9VxpkhhPUG89JLQfWC4
 FAQOZ+Owr0zlDVuByoXXzfZGU8+vQwhWdo2AezpujSvOUyVcGSkKutkovK0w3ngQUz4G
 xKbNgUs31OKNs2sIBGpnQE/YEX5iLLjHg+OphJ+Y1Jqy7gBIgRSkRQQPgbZiTNp3PDSV
 e5DX+Mb5syODIkH9QKtYwpn31WvdOdbcmtxXft5/V2/DyBB+s57oWwrub5kIsaHMMnFG
 99QOaHI95ocTGnSA5KBfxbSvREaTkNVLVmziquv8q4o96WbMZbBawWRySFOmpXKvTLsI
 AxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067732; x=1773672532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5qaVcQk9nY/+Sck+k5N7Cra59kGFWFnLRS5Q2nhbM5k=;
 b=PhlMlsAh8kZ1+wdL/4IeAiNd01y1kDIQCwddqY619LkocwjzYHKbxFnmKw4z3/PqTu
 TDoJMvuvEBpJtv/wIyRbfprlGXL2X3QYT/xb4CzZ/GGGn5QvdHFSlA3AZBT/bf35nZCm
 +D6r++A5hWv0jPCnqASnIXginlil8AqriBz94zb8yaIMlFpudtZPsOE+eJQ5Ce/tnygo
 mznm6VxiFUMv/GlioQQZXIoLW13NhNl59SQgofvaH1/B3l543tTBWFrbR+ULHH2iivuD
 uGhOQedVPngsFDhLcAfWw8lEUNA5SeqqbWtkY+1PDeBkYYY+tzFQOCrW55Hj2YonVj5S
 b/jg==
X-Gm-Message-State: AOJu0Yzulep1DNlIvPQh/TyDh2GAyO0I5VRLbZ1PAyTsEtC2U3jiwJnX
 MQBg9fZ/6dA/gNssdUlY3LejLIaoJIxmvlfFsz4DfYYCEd3An7bQlJD7ktk9M+zZaJ9pq2qSTW+
 SUoEVkh01E74lSYIeaXluNph1Gd7yc/WAkZjV+ASO7eyNP4h+4hJz2+Of2h3xCPFNHQ==
X-Gm-Gg: ATEYQzxKip1FAyzbnLCMR62pd7uBeOFYPnWzFgJE0+ufZLtibc1c6U7LRMEgd+TL9of
 uyc1PIfUsGmT8bo1u6K9g1004Z4pdVB1vw9y3ajx3cMdV0EaTU1r2zBrqBL13zXrrSNk6JpV5zH
 ykQOJfGPaE6TR3pUz2ZrStq9jPxR7Ehtswzh0f8Vj84fe8fMrV6ao+sISKsjodWXWloYtrwqRkg
 WjultC4gldhtgXkAWo4FBu7jXtlE65OwtRgjLTweEi1Km+bMI6pVUem2CzWqt8I9Nt+zQ23Jmto
 A/TTWfKJtf6TTn9B0J74zuQPMdpUW5gtPcOxQuPQyedPVTvwLiyLewcX2k1B0RYJj8kjet98mEz
 VYlRwPufBvCUuqE64QpI64zhtpFc8p2NaCu9DoYJ/rcVvoM8zjtLlUHwtR0dVORvZa82zjA==
X-Received: by 2002:a05:7022:6182:b0:128:d51a:5161 with SMTP id
 a92af1059eb24-128d51a5664mr1907236c88.27.1773067731684; 
 Mon, 09 Mar 2026 07:48:51 -0700 (PDT)
X-Received: by 2002:a05:7022:6182:b0:128:d51a:5161 with SMTP id
 a92af1059eb24-128d51a5664mr1907189c88.27.1773067730777; 
 Mon, 09 Mar 2026 07:48:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 21/35] target/hexagon: Define register fields for system
 regs
Date: Mon,  9 Mar 2026 07:48:08 -0700
Message-Id: <20260309144822.877695-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3s6FE_jxyStpFoGieW9FEXNrMRa2nQ6i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX37yvb9NKMxrr
 a/IgUR8b864sTB//7mr5xPXmGbji1ZB2i22G/WKfqQqybtMNxrYXwALzguDTZnRen17vASNxHIu
 amUoYLpRg9fxfuHlL2a2pHsoAo+o293/rP9j5IiEHA19gmjgOegMze5pGVnwKQutTW96h4q7Ssg
 iOmjZ0/Q56z3J4VTqe3izDExSxjwwOZOU9Z/XMGoA2iX1OlPAzcA/TSbuc1haYQF2ZDKK5YhRbU
 C+q1CfKWoDnK5bInQKfzDPMfg90PYrSidBGzveidFm/+HgR9IMS7Ny4X7xi1dwSumdOTeZu/mTX
 xz9PYI9bDrg9eujwErIY2NSz9sp/79s4ViLdR1C+bWBq96CG6Arjr4v86n3NQKcpbjpQh1es2Az
 xvSCDZYDurE7avvAXjQ4MrtZVJENT+mgc8FK2QXl/oJrXoVv1FUP1kL/1CBIxX5ArIQ/O58I/VT
 x9Pa5jm0HB7DR7q6AfA==
X-Proofpoint-GUID: 3s6FE_jxyStpFoGieW9FEXNrMRa2nQ6i
X-Authority-Analysis: v=2.4 cv=RP++3oi+ c=1 sm=1 tr=0 ts=69aeddd4 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mmKuwxttERDeH49ycpoA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Define the register fields for ssr, schedcfg, stid, bestwait, ccr,
modectl, imask, ipendad.

Define the fields for TLB entries.


Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/reg_fields_def.h.inc | 96 +++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/target/hexagon/reg_fields_def.h.inc b/target/hexagon/reg_fields_def.h.inc
index f2a58d486c5..9b112ccec64 100644
--- a/target/hexagon/reg_fields_def.h.inc
+++ b/target/hexagon/reg_fields_def.h.inc
@@ -39,3 +39,99 @@ DEF_REG_FIELD(USR_FPDBZE,        26, 1)
 DEF_REG_FIELD(USR_FPOVFE,        27, 1)
 DEF_REG_FIELD(USR_FPUNFE,        28, 1)
 DEF_REG_FIELD(USR_FPINPE,        29, 1)
+
+DEF_REG_FIELD(IPENDAD_IAD, 16, 16)
+DEF_REG_FIELD(IPENDAD_IPEND, 0, 16)
+
+DEF_REG_FIELD(SCHEDCFG_EN, 8, 1)
+DEF_REG_FIELD(SCHEDCFG_INTNO, 0, 4)
+DEF_REG_FIELD(BESTWAIT_PRIO, 0, 9)
+
+
+/* PTE (aka TLB entry) fields */
+DEF_REG_FIELD(PTE_PPD, 0, 24)
+DEF_REG_FIELD(PTE_C, 24, 4)
+DEF_REG_FIELD(PTE_U, 28, 1)
+DEF_REG_FIELD(PTE_R, 29, 1)
+DEF_REG_FIELD(PTE_W, 30, 1)
+DEF_REG_FIELD(PTE_X, 31, 1)
+DEF_REG_FIELD(PTE_VPN, 32, 20)
+DEF_REG_FIELD(PTE_ASID, 52, 7)
+DEF_REG_FIELD(PTE_ATR0, 59, 1)
+DEF_REG_FIELD(PTE_ATR1, 60, 1)
+DEF_REG_FIELD(PTE_PA35, 61, 1)
+DEF_REG_FIELD(PTE_G, 62, 1)
+DEF_REG_FIELD(PTE_V, 63, 1)
+
+/* SYSCFG fields */
+DEF_REG_FIELD(SYSCFG_MMUEN, 0, 1)
+DEF_REG_FIELD(SYSCFG_ICEN, 1, 1)
+DEF_REG_FIELD(SYSCFG_DCEN, 2, 1)
+DEF_REG_FIELD(SYSCFG_ISDBTRUSTED, 3, 1)
+DEF_REG_FIELD(SYSCFG_GIE, 4, 1)
+DEF_REG_FIELD(SYSCFG_ISDBREADY, 5, 1)
+DEF_REG_FIELD(SYSCFG_PCYCLEEN, 6, 1)
+DEF_REG_FIELD(SYSCFG_V2X, 7, 1)
+DEF_REG_FIELD(SYSCFG_IGNOREDABORT, 8, 1)
+DEF_REG_FIELD(SYSCFG_PM, 9, 1)
+DEF_REG_FIELD(SYSCFG_TLBLOCK, 11, 1)
+DEF_REG_FIELD(SYSCFG_K0LOCK, 12, 1)
+DEF_REG_FIELD(SYSCFG_BQ, 13, 1)
+DEF_REG_FIELD(SYSCFG_PRIO, 14, 1)
+DEF_REG_FIELD(SYSCFG_DMT, 15, 1)
+DEF_REG_FIELD(SYSCFG_L2CFG, 16, 3)
+DEF_REG_FIELD(SYSCFG_ITCM, 19, 1)
+DEF_REG_FIELD(SYSCFG_L2NWA, 21, 1)
+DEF_REG_FIELD(SYSCFG_L2NRA, 22, 1)
+DEF_REG_FIELD(SYSCFG_L2WB, 23, 1)
+DEF_REG_FIELD(SYSCFG_L2P, 24, 1)
+DEF_REG_FIELD(SYSCFG_SLVCTL0, 25, 2)
+DEF_REG_FIELD(SYSCFG_SLVCTL1, 27, 2)
+DEF_REG_FIELD(SYSCFG_L2PARTSIZE, 29, 2)
+DEF_REG_FIELD(SYSCFG_L2GCA, 31, 1)
+
+/* SSR fields */
+DEF_REG_FIELD(SSR_CAUSE, 0, 8)
+DEF_REG_FIELD(SSR_ASID, 8, 7)
+DEF_REG_FIELD(SSR_UM, 16, 1)
+DEF_REG_FIELD(SSR_EX, 17, 1)
+DEF_REG_FIELD(SSR_IE, 18, 1)
+DEF_REG_FIELD(SSR_GM, 19, 1)
+DEF_REG_FIELD(SSR_V0, 20, 1)
+DEF_REG_FIELD(SSR_V1, 21, 1)
+DEF_REG_FIELD(SSR_BVS, 22, 1)
+DEF_REG_FIELD(SSR_CE, 23, 1)
+DEF_REG_FIELD(SSR_PE, 24, 1)
+DEF_REG_FIELD(SSR_BP, 25, 1)
+DEF_REG_FIELD(SSR_XE2, 26, 1)
+DEF_REG_FIELD(SSR_XA, 27, 3)
+DEF_REG_FIELD(SSR_SS, 30, 1)
+DEF_REG_FIELD(SSR_XE, 31, 1)
+
+/* misc registers */
+DEF_REG_FIELD(IMASK_MASK, 0, 16)
+
+DEF_REG_FIELD(STID_PRIO, 16, 8)
+DEF_REG_FIELD(STID_STID, 0, 8)
+
+/* MODECTL fields */
+DEF_REG_FIELD(MODECTL_E, 0, 8)
+DEF_REG_FIELD(MODECTL_W, 16, 8)
+
+DEF_REG_FIELD(CCR_L1ICP, 0, 2)
+DEF_REG_FIELD(CCR_L1DCP, 3, 2)
+DEF_REG_FIELD(CCR_L2CP, 6, 2)
+
+DEF_REG_FIELD(CCR_HFI, 16, 1)
+DEF_REG_FIELD(CCR_HFD, 17, 1)
+DEF_REG_FIELD(CCR_HFIL2, 18, 1)
+DEF_REG_FIELD(CCR_HFDL2, 19, 1)
+DEF_REG_FIELD(CCR_SFD, 20, 1)
+
+DEF_REG_FIELD(CCR_GIE, 24, 1)
+DEF_REG_FIELD(CCR_GTE, 25, 1)
+DEF_REG_FIELD(CCR_GEE, 26, 1)
+DEF_REG_FIELD(CCR_GRE, 27, 1)
+DEF_REG_FIELD(CCR_VV1, 29, 1)
+DEF_REG_FIELD(CCR_VV2, 30, 1)
+DEF_REG_FIELD(CCR_VV3, 31, 1)
-- 
2.34.1


