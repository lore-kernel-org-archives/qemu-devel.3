Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35B0CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0S-0007Ib-Qa; Mon, 01 Sep 2025 23:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI04-0006tC-ED
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI02-0004Uy-Eh
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RkQU016270
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fokjFeEftBdKOeuh+z4Cq6nX4C/A86MjAL5I/qUJeRU=; b=QMMeahZmPOgQtmfQ
 jM2mGpJZ8dzJl42TLI4pKc9cFHejdqbDSsO8A3CZev3cT5HCSJPBcCzKR4z3La4u
 IY6ui8Z9zllJkLNMvaSW0o+pg8YxycTDmyUsec9feZNodmJq9qDYGROR5pNLRBcx
 8hCSL++7zVWfuCG6HHxidJnzekiFVVJUAaIuYWKMhA/uoFuq8UsU6i9dZEWO7ySs
 0X2jUzIL/nR+kkL5f2SG6DeSGsYIFoKZ3dXfqbtMj1kedIett52h8l4UIpxNLSHm
 Y9hbVhZnKTBjuEcru7ldRTX88Wsdg/OswZbxN8DM1YRcT6AlefIzD+797r1VtXbR
 Ghn25Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk8x86d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b4c724d27f8so2848909a12.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784870; x=1757389670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fokjFeEftBdKOeuh+z4Cq6nX4C/A86MjAL5I/qUJeRU=;
 b=bNIZmO4vsLl28O1rSZPdTceCmi5N0NOGQq/pwV7YfIqU3yZyXy/WPGnVQpsmsBlw6D
 ZiIVVs7neBcWcsAvijU/zxbIROGx4U61rjbsElA+XbqtReCb6F8j1Gh3dAEPqOcvLzh0
 SNrMXlyI83JXmBHAFF+6xpkN0igjzYn/zkWfjMmqgfAfXiUahBnlBPrb7sEsbaMIaX7A
 XTih++rmUcXjfL1UaQIm/bNcSXmyNbtDUhHLzS5zE+2k0HNwVXIvTCwTyzkwUrEyN0z/
 wjE/4DAhF5ZrHMv6QjRG2ScJI7L9rrtYrurOpaRsUolFeNf8K70O+MeRjZAw+BK5CgtF
 J0MA==
X-Gm-Message-State: AOJu0YyCzXIDgQ3auulBFX5j7LKe3O6/ahwRvuL6VLXmb5MqmyVaXQSs
 QD1buex7HP+IPPxLf5aAxkKTZQZymXEKTlYH5E3npAjSCaqw+iTqPoUJNWSvYSC/QK29LAqM72T
 6jO6xFfXlvbSwzDAzPmzJMcK8jLhbAnq5aDLIIK+LU+A15ijbbHw/z7fcYGqoma36wG+v
X-Gm-Gg: ASbGncvlavwzXIjuJwlzbcKfH8bpJEZyFPidzfE/ya/Mh5lpeXT+A74xOV14bo+Re0S
 eMwlGAPbyhSorBAmT2yYKhnfbBWuetdm4U4PSVFH+0XPaAvEwGfoNqNxNDyya1BkbYM3rk6QMEi
 QCsHsIIa27458itzsg4XPhevjSBGYjAZqp/FdUysohcaHuYI5nHC+54rS3XxA4/8uAee3ASNot0
 tHfKwS5rXCzcW5PQTA1oJmnq3HcFyezKSql2H2XtpLp9cF5YHL/rRmbRmYhxLHqE4V8mzUBcHDh
 6cb4K2pqzGTtzvL+xpRKwvY4CImVEm7DGolSTzrMsB7XIxGzHzakjuOeF9Zm+8EAnxspNtRFFyb
 FvlPr2hu7MECf
X-Received: by 2002:a05:6a21:99a1:b0:243:aa6f:ff2a with SMTP id
 adf61e73a8af0-243d6bc6e98mr12796099637.0.1756784869851; 
 Mon, 01 Sep 2025 20:47:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGParIAy88jmApJ3OgoJh9gi9FEqgnA51Fd7Z457w9b2qKLmGpQ+T5gQk9A9sH5rUp5O8osDg==
X-Received: by 2002:a05:6a21:99a1:b0:243:aa6f:ff2a with SMTP id
 adf61e73a8af0-243d6bc6e98mr12796067637.0.1756784869358; 
 Mon, 01 Sep 2025 20:47:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 23/40] target/hexagon: Define register fields for system
 regs
Date: Mon,  1 Sep 2025 20:46:58 -0700
Message-Id: <20250902034715.1947718-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 84B_QLRZJjq-gll_UupilWSTOmTv6apV
X-Proofpoint-ORIG-GUID: 84B_QLRZJjq-gll_UupilWSTOmTv6apV
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b668e6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=9dJjMySildbj4ad5Q0IA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfXxeEWn7P21AQD
 yJmo5WKkNOK1o+LFR8T/sDgVqeLLzqCCb4qkJ5FAbdzDxT1BAij1ufR/xHJxAM4lrfOOihihuUE
 AgBNrLxzzrOsJ/FBP2zaBci+t+xjM4K8SDOt6u16ziXEGBwNE1f86S4bOn2ZQisZqqReVnI+toM
 YkPI9tsjfWLDalx448qXYAJ8/lcpjgYuHjMlOFSE5NClJydTgZHKHf/LQNbZEiQeOTxjVU8a5Cl
 doaCZ2T92SJN+Ma8tYv7f3xJPJwirD9UsbQPb63Swm39kPa6fe8HEBrYc3IKMXf+NSvw/edXl1l
 0X5YC8KyldOT1cGcZPhPd53sDL/znu2XTBpeQwGru1F5pGtHN9qW4XVdBBNve7LdKF2a31OJ6xi
 Ag6DKG8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Define the register fields for ssr, schedcfg, stid, bestwait, ccr,
modectl, imask, ipendad.

Define the fields for TLB entries.


Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/reg_fields_def.h.inc | 96 +++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/target/hexagon/reg_fields_def.h.inc b/target/hexagon/reg_fields_def.h.inc
index f2a58d486c..9b112ccec6 100644
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


