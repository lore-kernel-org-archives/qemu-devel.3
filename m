Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946DCF417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbup-0000yA-Uh; Mon, 09 Mar 2026 10:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbul-0000v2-Hj
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuk-0005Hj-10
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:59 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629AUwrw1587278
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KWwmlEVndruWtF10NfXjVHSIEZCP+AYqKotN4ROqTh0=; b=VNOCgggJK3/pKxAO
 le1YgX+ErRcTwIIOuJ4QxmSDs5Woo2czqiqfes5pk8DrugaTi6UBFrhx29dxY3d3
 kpqY1iqqoiGaoLAX6vOLbf0L7mzHFJ7Tg29XvjVqAczMPclXJl3WVrUt0rcUnbQo
 BXaZ+XJZdEOAGdBY3f7r5wpB/gT2hKiVMmjIrJSdjXGnNbLwB/fVGslLIOcRSybE
 oxY4464nqTX1SVZjkS5eMxRCYpxqKRethk+R1T/K7gRwJYdDiabYBVUsE9d6wqAi
 Kk0TbTnW1kEiJOwkRXSXbCOsAhjXOYxWcrtTSkyCmg2ibORbaIjc9pEuFYg2z2yZ
 1TbEPA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csqcy9y45-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2be191ce356so8524798eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067735; x=1773672535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWwmlEVndruWtF10NfXjVHSIEZCP+AYqKotN4ROqTh0=;
 b=AoxxtkmBy6V3HmWFtgcpwI1GklEPPf0Ia1vKyEbQRvrq6O1DdcbwbTNOOezpTOjvB0
 LJGubd1dobUlfjjCtop8YSWCZUXEy3cU95p0OL2esFb9ACn8Ex4VBgYYH/gSyylZ94jY
 cxtwPybhX6/MEymwTF6+mWGU+l1mSbldwTVPvZm0QXcHV4fMG7oSNsRgkkHp+Zxzh7N6
 FZ8uL35ZN/Bwpg//siYF6/hk00d2wrUlAtxhtwdCJN0/IemYMOae/HRHbmZVrWqFkbgs
 Vzcji1gDrOVqs+z4N2qTr6NoOmvgQAkGkfrqMsGTfgp/7otTrzNNOzE3O69/8F1XIMyd
 N1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067735; x=1773672535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KWwmlEVndruWtF10NfXjVHSIEZCP+AYqKotN4ROqTh0=;
 b=P6A9ltKbHfZhNaHWoIaLN5QEs+MYWFkS56er9B+MQOHlNJPYvBLG2EFfV59fsbwpE4
 g/rzxLbi+NAXYxCEnwwieEd1ldvDp6q7HGUclWIYBYSRhc9rVJeNd0/R6OnUuAbJCTF5
 5JJ0EGMpzsleJVySQzOFF1yIjpQUP7ddpyteWf2bvnyNHlV1qtiBs8vsE3Oph2n82Ipn
 0SVwUzdTFAke+MkOVFbq2PsF61FnVJlR6plAdstIpcKleA+J7EWL2nTwp/e4u5TqSaPV
 XHMfFEiqB+UHjVBlxUCewBBZDqwfi0K+sFro2fkq+hhB7PF3ifZ7tkpEb8scOU2sE3qX
 3xLQ==
X-Gm-Message-State: AOJu0YxQzsK9PChJ/zd4yVQeO90OQomfPTFtsvqAm1PKeXfe2AJcc8Lx
 yxH3AHvV6LXrW6R4hdNV9uaMlPz1xmzI+UVO5sP7wecFZ7cE3RmtCBUjYgxaiM06EHCHsXcqPGA
 rmKEKUeeg79j6wal639CGNATkEC5Ew51l+XftNAGk9Z96u8GCcIf6FKi7clsNSsg+EQ==
X-Gm-Gg: ATEYQzzrX/l2w1j3bXyJcEWSSh0CqWJgkc2F+57KUwrzVqlkX+sS3Ytzzl+wjzLvlmC
 uFckF01rpxpzYEFQ/K0Uc8BjTKgMUfy04iv4qtNPxg5pDtKBH+teYg5HZMgUdL8/emRbTvcyGjQ
 e6WE6LKTkbNmACAVLTf8IesS5AKyLP9ZtVKI7d59tRfcQ8Z9y1rVJtxFMqhqXsclt3AgGDlHZNB
 K4tt1bA0zTym4MNc3ycfdo0pxKE2Nh4AzRAGLE6970OmgWhUkpcdyANpqWDq5q05+RUQqNRFScJ
 aFrjwdJ/50nHTuHdY0hi2TJcekj9TXADVXs2AI2DhPc28G+NRNGYUi4PS+pUhmCxJaXpb364WQg
 wUkbFE8MR+iHwiU3WRQ4+4DGAnysU2com93GsqD54xYDAmdPiY5H/XF+1Dpb43nKf3rYu0Q==
X-Received: by 2002:a05:7301:4094:b0:2be:e4b:60bd with SMTP id
 5a478bee46e88-2be4de932fdmr4245028eec.6.1773067735213; 
 Mon, 09 Mar 2026 07:48:55 -0700 (PDT)
X-Received: by 2002:a05:7301:4094:b0:2be:e4b:60bd with SMTP id
 5a478bee46e88-2be4de932fdmr4245012eec.6.1773067734702; 
 Mon, 09 Mar 2026 07:48:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 25/35] target/hexagon: Add implicit attributes to sysemu
 macros
Date: Mon,  9 Mar 2026 07:48:12 -0700
Message-Id: <20260309144822.877695-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX8M7hN4nemcvr
 sJbEen8bayBC3SLMA6ZaJldwpKhDLVa1XIAxSVT84206lonHby1bla5s29vl84/ror03Dakpjrp
 wjZDKoZyEyoM0sx4fLnAPwlqnv9wv51eVK8WiiqvC2dYd4G/JNtKBZMtOUQQMKrIfcLVYoZyyyo
 FO712z6ZZ9j1eZzS4Lhw2zjwD4uNl20Qxgd02OSsv88HSrIkF0Met4hDdsYMyQzz3vUaI8Dgxmr
 n4uoAfkVbccPMiz8xbnC8zzAtYEvHOpVD/D0GQWzoysYZboSphjuX/+FrDK2rNQRPtMFGRArfTx
 fNjGjdPHZsMhIFUcKWj4wYKvrltiLqrHAZruCR60iz1D3rVmSS1dVM3YJ/Z30trWjXDr2/kNtVe
 o+a06TRMpMuutwaq/4TnfP6Q0Hi+e7gqi31ij8ssDvv43ImWaGMa7pJgVJXQ28DgOg0OIgYncWy
 wodG1C51+ofWhV6OjYA==
X-Authority-Analysis: v=2.4 cv=QJtlhwLL c=1 sm=1 tr=0 ts=69aeddd8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=CUHppggc_AvCVqMSdgsA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: QBkLDWCC4zkXmBVkbBzh8btqn6yMTVAM
X-Proofpoint-GUID: QBkLDWCC4zkXmBVkbBzh8btqn6yMTVAM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/hex_common.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index d7496bf6b2e..207eb44f3ae 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -128,8 +128,11 @@ def calculate_attribs():
     add_qemu_macro_attrib("fTRAP", "A_IMPLICIT_READS_PC")
     add_qemu_macro_attrib("fSET_OVERFLOW", "A_IMPLICIT_WRITES_USR")
     add_qemu_macro_attrib("fSET_LPCFG", "A_IMPLICIT_WRITES_USR")
+    add_qemu_macro_attrib("fCLEAR_RTE_EX", "A_IMPLICIT_WRITES_SSR")
     add_qemu_macro_attrib("fLOAD", "A_SCALAR_LOAD")
     add_qemu_macro_attrib("fSTORE", "A_SCALAR_STORE")
+    add_qemu_macro_attrib("fSET_K0_LOCK", "A_IMPLICIT_READS_PC")
+    add_qemu_macro_attrib("fSET_TLB_LOCK", "A_IMPLICIT_READS_PC")
     add_qemu_macro_attrib('fLSBNEW0', 'A_IMPLICIT_READS_P0')
     add_qemu_macro_attrib('fLSBNEW0NOT', 'A_IMPLICIT_READS_P0')
     add_qemu_macro_attrib('fREAD_P0', 'A_IMPLICIT_READS_P0')
-- 
2.34.1


