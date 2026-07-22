Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F96C4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmZVt-0002hO-0b; Wed, 22 Jul 2026 12:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZVr-0002gQ-4t
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:09:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmZVp-0001v3-LS
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:09:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MFYBS51260632
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Cfw08zrS/HQBV5FgdUQoKFEqIatiAJuiZqcnB2We1EM=; b=YKnoZehN3QcxntIp
 npaRkFJo+pCIdP7PsSf6aiU608y8m57DQAHzAeEDeXH2TNcdi1MkmYUHyNdiptWl
 c2rjEICo0B3nIa/yUqq7yrXH2JJ4uI0jZjVmvaSL+0iY7vsLnQkGlSYyl6oIsyWc
 Cm8D1GN10DsFEjTLHZ0Tm177Onhq2ILU0P0IYY4hMsBBu2GUasLKH+ek3xsfi6mN
 ZzRbhMqg5016ynytOnN3BlYetZ2Yvx1qh0u7i6WaR4WQ1Q3MNP5Ql4bjAJ9zwrqr
 Aprsn2U3TlyMa3qwVkTcCfHnfJmWysDPQpfNLWr3E+MX5K+hWggEUNNnyaS1aM1R
 M4QdBw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjuu79fgr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:09:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a23afcbso117412841cf.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784736536; x=1785341336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cfw08zrS/HQBV5FgdUQoKFEqIatiAJuiZqcnB2We1EM=;
 b=aYDqAyuGqKMhxams7UD6WuAbDHhwV0ndGFFafXE61GRX7pia/SyOm/wFIT0aFJECjS
 +nVXWNI17a/x2rJ9HY6DAJcp/rHYvgEL/MegpenDlwljEUmIy5pWlW0Px41ei6/EWq1T
 cGKxz4V89Aif99uLHsWDFUMjz8VC7bQm3h1JK5iLqe/NanktMmXGxx1uJotMyVkQn6x1
 z3NpmV2U0cscvOF50p6zcjX1WmHy66QQaIQb4ou/e59trfkpxCV8lHekzS7WOt67FYUo
 Mv0Py8osK7yxxkNg1Ll9ognR3/+YmA8AxIg5ECaVyu8XDxR9v1Cy3+zEmr89xlz5LdFA
 dR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784736536; x=1785341336;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cfw08zrS/HQBV5FgdUQoKFEqIatiAJuiZqcnB2We1EM=;
 b=ZwC71ZqbkQ/pqtTmGNkZXGqMUs4a0u3T2Bcp0oh31zunVDix07Fugf8Ksh82HMdPLQ
 ZWhV0nficwdSEFBhvk2hXupv97am3XsAKCJBdlO+g1dRLMRmRaKp84eZkKM8m5OTG4oy
 cv/whe+ezYAxRNMIet89RRaHmHyVkrIo3L4gyPQNAni3gX1EcxpqtzhKZ7Yy1ATEsr8F
 pxR3/nM1r39vhetQBm5u0P6nF4XaU1P0Fy/k/tXxQivFU/HF9FCSnllMBoGHDoBXxEgz
 1foFW6Zlyh8uwUaH1MXYyoxmK1+aOJYwMNcNcqo9MO7CgHJkhLL5+t87LVMLyKPEdGLF
 qdHQ==
X-Gm-Message-State: AOJu0YzxGauo9gu2bbfXr0K7kef1yqkRg6hqHnyZoplgDdV3MBZSWMVD
 H7N+viWpmWDUU4/hKNPqOk69GB1riMWzrn9pihLuQgR2VwM1BLOx4u+NS/Yp63NBalhnDYr6RH0
 SvcXxEeesf5SwW0E+1W8FjhTO5svoO3xDkNfUftax70rdT9HpvBw9ibsB4BKx4qT4MQ==
X-Gm-Gg: AR+sD12w1N/RYiG3k6J2dkONjvnLcf4wr+uvvoLXiX7fcx2uidfB1aD+Cxaf+u7zSNo
 roHy26FE5/VZ6kv0XPFfgl05cl62vCPsah8i6uahN5ryaNyazKpd3yp/d0Pa4uxI+X8N4E9cpI2
 8Q4S2hIIr+uBKtFr/MqQcLRXXDgmuxW1ISMYN26dDU3SGguPC4oNFd3B5OhFARNVfWWgX/NCoev
 Avn+ELCPWMTfs/AkOvbWXA5R21DMUvXNbPo7i2SYkl3QHp6kmsugELg8eC7ToMFjPeHWHDrHgTD
 JeRO2/KmGFjOIclfWU98CDuUxNiVcWKJQzc/QImX10vmgICLEgQhryLvBJlKEumRtbE8iAARLo6
 nnjCw+0LnY2pQwi8QfJKpt1wFxeDqER9E6ZGgiY7uEEvVTxdELJHRdAw=
X-Received: by 2002:a05:622a:11c2:b0:528:3a24:f396 with SMTP id
 d75a77b69052e-5283a24f6c0mr5320371cf.73.1784736536235; 
 Wed, 22 Jul 2026 09:08:56 -0700 (PDT)
X-Received: by 2002:a05:622a:11c2:b0:528:3a24:f396 with SMTP id
 d75a77b69052e-5283a24f6c0mr5319321cf.73.1784736535198; 
 Wed, 22 Jul 2026 09:08:55 -0700 (PDT)
Received: from localhost.localdomain (92.171.88.92.rev.sfr.net. [92.88.171.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b030a64sm57062335e9.3.2026.07.22.09.08.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jul 2026 09:08:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 4/7] target/microblaze: Set MO_ENDIAN in do_load/do_store
 callers
Date: Wed, 22 Jul 2026 18:08:04 +0200
Message-ID: <20260722160807.24031-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722160807.24031-1-philmd@oss.qualcomm.com>
References: <20260722160807.24031-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eUoJUA1tUXNJ3cno-ZEHVwziSVTYTGJV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfXz5gN83OBZXaV
 bu1qOCZARJPpBwsA2pbxd95WINzvgJ8x12DKlw2nHy19hURlnF3EnQ4q3VvscTvKNx6pNpojCFo
 v37u4jEZj0YUKn6dyhtnKlII9mpJw2I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1OSBTYWx0ZWRfX7BTQXFxteDAk
 tdAzPMe+jfu6B0FXwnuF06F9HEcSsKxpLLb+Q2HgYyLtjsWYP0/HK1868ebhoZyZ7JpR2WLaY/M
 OSDA0JPXepuT90ZdOPsbG8fbVxElxKhNF965FhuA3+8M+9WajPstf/+/fzkuZEla0aATvETHoUM
 A69QONf1s7MoTVgaa0gx4pAnTwxi+T1OCa2ekWI3BSGN7GyhQH8U6yl4n/Ifo6E5OrgbnoYQOh+
 8yKj/YwG+UJ16sKVLkpywXo8mtyTIQ88myxcZGi8hyCctskQPAoEXfxqyY0jQRw++FNl9YAeFfe
 pQ+Fq1g/+uzor3GrcffYWrxRxhJoKZYyM+BA18hYpdpjrpuGX6xJhPkY575R0fvmakGwekzIFYf
 O0YlNqCYxha78S8R3b/kXplw/IBt3aCTN4OyosyJetFiK57ktoXsuWsdVeaKZcTPea7C7Kl5EKS
 eY23qluhTi0snTVmieg==
X-Proofpoint-GUID: eUoJUA1tUXNJ3cno-ZEHVwziSVTYTGJV
X-Authority-Analysis: v=2.4 cv=JuTBas4C c=1 sm=1 tr=0 ts=6a60eb3f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=8SOIyxyylBkeE3ShledptA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=lN58bEdq_bzK_G3D1aMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220159
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

Again set the MO_ENDIAN bit in the caller rather than the
callee, allowing to further simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/microblaze/translate.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 3f2de375d97..d4826981913 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -716,8 +716,6 @@ static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
 {
     MemOp size = mop & MO_SIZE;
 
-    mop |= mo_endian(dc);
-
     /*
      * When doing reverse accesses we need to byteswap the data
      * lanes on the way back into the CPU core.
@@ -749,13 +747,13 @@ static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
 static bool trans_ld_typea(DisasContext *dc, arg_typea *arg, const MemOp mop)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_load(dc, arg->rd, addr, mop, dc->mem_index);
+    return do_load(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
 }
 
 static bool trans_ld_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
 {
     TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_load(dc, arg->rd, addr, mop, dc->mem_index);
+    return do_load(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
 }
 
 TRANS(lbu,  trans_ld_typea, MO_UB)
@@ -839,8 +837,6 @@ static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
 {
     MemOp size = mop & MO_SIZE;
 
-    mop |= mo_endian(dc);
-
     /*
      * When doing reverse accesses we need to byteswap the data
      * lanes on the way back into the CPU core.
@@ -872,13 +868,13 @@ static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
 static bool trans_st_typea(DisasContext *dc, arg_typea *arg, const MemOp mop)
 {
     TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
-    return do_store(dc, arg->rd, addr, mop, dc->mem_index);
+    return do_store(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
 }
 
 static bool trans_st_typeb(DisasContext *dc, arg_typeb *arg, const MemOp mop)
 {
     TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
-    return do_store(dc, arg->rd, addr, mop, dc->mem_index);
+    return do_store(dc, arg->rd, addr, mop | mo_endian(dc), dc->mem_index);
 }
 
 TRANS(sb,   trans_st_typea, MO_UB)
-- 
2.53.0


