Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124F6F417F1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbut-0000yt-Cy; Mon, 09 Mar 2026 10:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuS-0000q1-8T
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuQ-0005E0-4A
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:39 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629Du2MW412635
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6zPNYNW9GTOALG5AE5GzyagUhvHiqrWmCo87806ThO0=; b=YkGSF+8NL7lrg5yp
 pUMp8IQPERIlOPIpO3Aql6h6O+NCjmNFAx90QrbMhkT/1mV2HZdSVbNvM+l1umYw
 93DfckS/9IUON1aNfLVTTE2tfFw5JMwNkZtKD0Hn60Mcun4BXPPKUkJIX/DIUF8x
 Pe+a/0VEtCmEtd7MtlXkRd+51i8mnY1sru+FHqV9s+iCpAsKrLJRYnr68EQRWo24
 ytbzL2ZuEKsm2jbGnwegkl0wRdJIhRbHl8MwF4Z5Q4J/T2330fO/2a06ixjtDJ35
 2QEC8U4YU8BxVxOM1qhMNIgNctk0K40MDKYvgh7YTpJb5+S+r3vI2sl6GUgilE0c
 X6tPPA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyhbr5fs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2be07cafe1cso30719789eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067716; x=1773672516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6zPNYNW9GTOALG5AE5GzyagUhvHiqrWmCo87806ThO0=;
 b=SacfdhW70/xvGpvhofYv23FYzGaYSq9QDPxIEuz045kQxDZ6jf+ozW0VDvbO/P4x4L
 12JKeQMlNHVb/b53mqH1Foea/ULAKvWjwg+u6g55Yud2E+aXTy7DxYdESeTzwH0u9Oxu
 Vhcm75dS2fU9Tir69pwCl6UInuftJ9xDfR6ljk0ERWLkmLH3W00ha2thfOntNdNy3CB7
 d+CdjpQbi3PC46Ffl2XRIwigKZG8va71UYEGbELEm2GeOc1NfH0l/r6Z6Bnf0cE+izVC
 m4akbuBV8+705WFn0VtpBmmMUSJvsxgVkiX1y71VCqs0N7ORk1nf51JcPgC8KJLtHnzD
 JH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067716; x=1773672516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6zPNYNW9GTOALG5AE5GzyagUhvHiqrWmCo87806ThO0=;
 b=APqugsqGrD0q9iUq6Lu8rbHVefqQ5o28LVkTH51lnj8Movwy/XWsAsQtzyvZqLnVB3
 lxwrt7w8RWSucy0e3OkiNvljeygRViFovYaIUdRoa0RheIInlrJgDfOvCsdENlD1Mz85
 m95pMSfqHIgNI+EBGKzb/x7VeeUbVJpaLeX5ezZ6ysBNsQQFpVKixrig1iF3kLp1Ies2
 HWYkreVUHcyC+J2ag9+6EQWPx9lhFTzFDDIbOpyGaGdHw/7aHm0XDM2Btrcbf+yzmYcj
 T4ZYW9ugP495YMp/QfGe569k1bb/3tuhdT3AmDDZKbnpldD2V4bj80vi9ckYDAyDJEzo
 b7+g==
X-Gm-Message-State: AOJu0Yz6OY/5+Ss27VEzoCZwxp+DBDVUGYLX+4o2+dc3AnirXdd5PoqM
 TlTGSUbzg6WStt75nfy47MD9nuvfdL9Nq8dTJMEdfIRiNTvNV0+TOgCn6cOOLUPeI1qq6L0x644
 +lhIxDWoa6a39k+p5LSRLodXATqJd9BkA/8aLraqBRgEbxuKIKiDcLcb0iaREbrP3/g==
X-Gm-Gg: ATEYQzyUT2EvF79oseeNGE94FPG3mR40JVPNBxGJHp0txCkqEX1nmjLmLcvMd5KFo/P
 7h3zeawoTFbqe38N0nE9SGLPbcOH7bCcO4Ws5Czc2clWZ/K9sRtEBy+s34D0C0guG1W4k/GD47I
 O0dJt1dd7vmPz/uVW7MT/7s56z7Oq5tnmP8eo3SBV+u+Etrux4ZkslMbW2Qb+FHka27apOF6R/o
 Xg5ZK/JQBVpOUJzX3hSS0nlUNoU66JqG8gukV7RIPuLTvsxGHv4XpkuEESXiT7iRe5eM26bp+0S
 bgEcAtThZHpRjwghoMGlPE1N/xKQwp+m8bCBmgI6e/1tbW+W+JvQSYt9gH574ly7RUeipKy0idb
 a1obalzUE3ScLP9zRke8h2cMFIUy7EqjXMnIe82gdjtEEVHSvtz4Kug1+Z5LeuH9H6aUeAw==
X-Received: by 2002:a05:7300:aca6:b0:2bd:d3f3:b0be with SMTP id
 5a478bee46e88-2be4e03ed55mr4691350eec.20.1773067715648; 
 Mon, 09 Mar 2026 07:48:35 -0700 (PDT)
X-Received: by 2002:a05:7300:aca6:b0:2bd:d3f3:b0be with SMTP id
 5a478bee46e88-2be4e03ed55mr4691333eec.20.1773067714962; 
 Mon, 09 Mar 2026 07:48:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 07/35] target/hexagon: Make gen_exception_end_tb non-static
Date: Mon,  9 Mar 2026 07:47:54 -0700
Message-Id: <20260309144822.877695-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Rcmdyltv c=1 sm=1 tr=0 ts=69aeddc5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t4cj51CzC67JwBy76UgA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX2cF94EGp5Prt
 BtoB37/fYoqSXRowCkLU/Pzdlj06VUBGxM7Eegw8xAjTIPc6jCwCen318KAPnkGxW3tXRewvbsl
 KVmvoP6wBXKjMd8U2O6Hz1uV39wJ9+jEE4HoicGoBMDwO50q/o/epSdw9FUGzZx7M8ZUunvn/L4
 typ9N91Oi+1BJhyjMHxNlpz0t8KpVaHp/Uf4hVsueHTKEGKSff3ynFLrXnoDpxYsHrNKnREeP0W
 UqbK750QKwZO2GxPjBnsQr3diuQwaRljsQV41Isi+vL8Z2+NCShAb2bJDVvzPdhE0trgmSzQyex
 wwoY0mdrgnbSZ//UJAFvK2w/R94NuY1Du3omdukRyC5LFZWYz+y79nCSH4EcPx2Xg7aRCrCny8M
 jY/uYgLAAEXiOLscO2i22ET/1THIAUw/fqIQE4CUh80X3mGAHVmsSpJm5Qyz0YyLDDhErhC2lFU
 FdMKfZ/MMuruzZCIESQ==
X-Proofpoint-GUID: wyrqzgbwZRGeA5hM5-MAyPmGD_oh_Wkw
X-Proofpoint-ORIG-GUID: wyrqzgbwZRGeA5hM5-MAyPmGD_oh_Wkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
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
 target/hexagon/translate.h | 2 ++
 target/hexagon/translate.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index b37cb492381..2804e08ce57 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -282,6 +282,8 @@ extern TCGv hex_vstore_addr[VSTORES_MAX];
 extern TCGv hex_vstore_size[VSTORES_MAX];
 extern TCGv hex_vstore_pending[VSTORES_MAX];
 
+void hex_gen_exception_end_tb(DisasContext *ctx, int excp);
+
 void process_store(DisasContext *ctx, int slot_num);
 
 FIELD(PROBE_PKT_SCALAR_STORE_S0, MMU_IDX,       0, 2)
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 8a223f6e13e..18b38c285ed 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -189,7 +189,7 @@ static void gen_end_tb(DisasContext *ctx)
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_exception_end_tb(DisasContext *ctx, int excp)
+void hex_gen_exception_end_tb(DisasContext *ctx, int excp)
 {
     gen_exec_counters(ctx);
     tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->next_PC);
@@ -590,7 +590,7 @@ static void gen_insn(DisasContext *ctx)
         ctx->insn->generate(ctx);
         mark_store_width(ctx);
     } else {
-        gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_OPCODE);
+        hex_gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_OPCODE);
     }
 }
 
-- 
2.34.1


