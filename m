Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8864D606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CYE+8vkX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fuWlBLTT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj36-0000gB-1B; Thu, 26 Nov 2026 18:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj2j-0006kT-UE
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:38:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj2h-00014a-Bs
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:38:21 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJw0oZ360823
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +vXqnVLR5M3m19J0+N9HVJT/VWQI5UpczuAZAijDotI=; b=CYE+8vkX2qGbBsfz
 He7Wnb81sO1Md2O0ADF5L7IwTlrNVLsmaJP2Unsd+L2poOLZGcXaDWx70zA2Sssx
 Tf0zonNVqJWyDPIxGICUtcZ/zOT3H7kiF6jCzKDIxkLx5mpxiIswQGT9tL/qPlX7
 aYPcF87sm65Dja5yXBuSOxli24ei803ZgVYgSDFNMhZHDnk4pkv/O8KHeXeE8wDe
 O+rmmeEoNRuC8edQl/12rtZZz3ATXT2U63amp3z1dF5EoE5wMMTyc8Tt+hPK/lIN
 SkFT0RBHkoS3OIqQo72l9eMrzP71WF85dx1/bc04+OkQQ95nOmDb09+D+cJN6MOK
 3U+Fdw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6f8rk6bh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:38:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9496ff065bcso1004077185a.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736287; x=1796341087; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+vXqnVLR5M3m19J0+N9HVJT/VWQI5UpczuAZAijDotI=;
 b=fuWlBLTTstAYnAjfXZpj3oBgpqSZ+PttxS/0Zzc05+8ju1TrS7cMEqjPtGvbJ5awoQ
 f8knpfCIIHWhg1zfPaf6MOsC95y2GhrCUqh/HsvCXfVKjoD9wRzjPOAy+4EyY0MzXX/9
 9PS47WMoyOelKKUu/5utaOcXwkFn7/g+uePrMigknzgFWkmQpiEvXibfHnWXKt1PHtSM
 Ee9Fk9ZPNIgT/G341QK5qUWnJLgGv8b5z2v50sqTJwbp0MaSYWTEUQHr1PX9b2Yoc/Im
 wz93MfPhj3O3eVTEi/GfR/ZRuYpq3XqDJemoDaAgtdbSxBdgryIIjJm1yB/ZCHKFKfIS
 guyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736287; x=1796341087;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+vXqnVLR5M3m19J0+N9HVJT/VWQI5UpczuAZAijDotI=;
 b=RWwXCY5sS5A/qwd7XF4VVVP/rov3IAO/RezSc4uT7Svve1QvFG7RS7ghQ20orUPwXl
 1/Xzh/GYQ6R0sPggvpSxlqK+OFVlDoP4mCvYT7lsJzFmFG74pdzUQj3czPzYeww3VuLp
 A2DlOE7CTL3FHRUvicqnryGPKRJA5uClL4aFx+Zs9zjUA2MY73zgInGWCfn2g5KkvjvZ
 ZS24hiWEsKyyLExGLRLh3iECyQ3h5ZqJ9dITfI+fRGvJNxldI32Y5taW4mgO9S2iON1b
 pGASWxT8BFV/Cv8seXjHn+BeWZ1PcVAb/PMP6c1tiwvuIinaAibdHWwTF4ONGbo/vKso
 tuCg==
X-Gm-Message-State: APuU4Z8SqSKyUzi/ZPI6qbssHg70fS30gLVMAeFJFc/t9aG7fez5RGOm
 dmwgJFUCoIqHMuQ8sPXX6C/qfnwbcaZYDFdA4nusnGfcLOGe82m0k5QK78FIRNyA9ee4za8xhI1
 xaK1OITD56YKq6VZuW7WS7iSciraWmDBSGCqpMlsudFu/sEsXWMTJyp3vEdiC/M62ww==
X-Gm-Gg: AZFdTZdpnnNYBitjTlwScCh72DpFHp5TbjmLy0hlZg/owYUthQm+KpgX1YrIdPTH56p
 3EoeRpQt++ptYVlwmSiDaAchTqFAy5PVVFACBsnQ9PgvtRNHsbubtKjqM2W2xRAlt+s4fJwm2rO
 zxX4E+24mZWVPh0r85qReQCgjN7/CbdQChG3EjWBBpX0tkCoUrPOhaO4sFaX3rcT7uzGbAD+UVr
 Qr7iOtJpiqn1AFUNldNnOwiZcyDFu4Y5400ZQpuxu42s2KTkJ14Gu04u1zhSs0d6BHTy56TPYsJ
 0LGCK94urEU+9MtqMGv5hhc/i8681rPLu+GdtkTfvINOokIEGTzkB3Fd3XBV0b1M/+3I4pD5Ofk
 TOFPh63HDcZSez4iAFPCTR6/ZWGdPgtNiL1tNRToCFcRsENTsXSk5R67WtiHRC4F89gtu1g83DC
 WarEDDtddKHuOewA==
X-Received: by 2002:a05:620a:6f0a:b0:949:7710:37ef with SMTP id
 af79cd13be357-949baa0f7f0mr3633379085a.61.1795736287009; 
 Thu, 26 Nov 2026 15:38:07 -0800 (PST)
X-Received: by 2002:a05:620a:6f0a:b0:949:7710:37ef with SMTP id
 af79cd13be357-949baa0f7f0mr3633375685a.61.1795736286511; 
 Thu, 26 Nov 2026 15:38:06 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm665167945e9.3.2026.11.26.15.38.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:38:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 15/24] target/ppc: Use 64-bit TB flags
Date: Fri, 27 Nov 2026 00:35:53 +0100
Message-ID: <20261126233604.67722-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX7bT53rbOciEA
 paVBSoZQeXBVM6swKS4cW6SwQgKD75rr4dcruzskPqPM+nBPCcijRixtW8r64DB+JcAJP0MyxL7
 hy6K39VEcTXQlDuZ0BKLQufbM0nxxtG1nelRawrWYgU0sjII2KtTPm2ModrX/7SL5nSQ6Ea5g1J
 1Qr/TCT/4/duX6NflHlnCLn9thQMvIfBn/IDlAAcSmtYWolzBBa8JJ9RJV7qEjZhvFKzwFLYT1t
 zGh9+52nKymWuAg/qOTwwCdHO0ngLOY4twP3KcV8oKggPTYEJG/BRaQOIpzMEwdueAeggXvbW7D
 dR3v+u97umA3ekgJF3LA9GI/OY+V/GOYT+zKMeDBqUL7ftu6mXQ0x/DBxi0G5K+DabP552J90Ec
 CBnB6H3qdv+xYTIAni8Sw4y3EVyYNaHLRFDeHE0E6TxfJqyQfNeNMxe77ASq2IfXgUOvIqlO7v4
 M7wc7PXfTcqhn95qN4g==
X-Proofpoint-GUID: lEUY6XMUO16MM1MgcIM-rskXWFaGNgxj
X-Proofpoint-ORIG-GUID: lEUY6XMUO16MM1MgcIM-rskXWFaGNgxj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX9oWTuOgFQBky
 Q3Af0ZqO0ea+4CLLecYUCFCxBqgMwqhyNleMqYSdpvHZQPiOg96s4wB6skZQVmHbk/9oGjjW3j1
 udRIOnC4UHOXqZZrRQusi4AhcCBotK0=
X-Authority-Analysis: v=2.4 cv=FuOQbGrq c=1 sm=1 tr=0 ts=6b08c2e0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=3KaAF8_o41P3ivBUNq8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TranslationBlock::flags and TCGTBCPUState::flags are now
64-bit, use matching types for the values derived from them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/ppc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index dccae25bb4ec..e7bb0e4d4667 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4996,7 +4996,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUPPCState *env = cpu_env(cs);
-    uint32_t hflags = ctx->base.tb->flags;
+    uint64_t hflags = ctx->base.tb->flags;
 
     ctx->spr_cb = env->spr_cb;
     ctx->pr = (hflags >> HFLAGS_PR) & 1;
-- 
2.55.0


