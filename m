Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA1D606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HgmJx3yO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=klvqLVWM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzwf-0002gM-0M; Tue, 24 Nov 2026 18:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwd-0002Zm-AX
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:29:03 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwb-00082X-Mz
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:29:03 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMaieB2656149
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tD7gkW9eSakaoDI5uvUOI7aHtOPrX4zWECKqiV613Dw=; b=HgmJx3yOslX58g7U
 DWsJSIS5uRSXS9aPUW8xktYL/q7r39lCnnjdVcCV9gHFWsEOgX1HA/Y9YW6XJeOG
 bzTTU6wcl7hFE30UYTngaUhncOnmpRBkW4XTWN4e9tfKb6uslrD0eM/qi7ollQrw
 zS2o+qzQiwCROqp/LsWZ5lfi0u4d3RImJk/YKQQBaJzS8C19/qzemJGD6bzMPj2K
 C48FbrrM5UvJGgzfEXQ2imw056Te/Xo8vDU790H6ILzFuvWmth5jshO9v2KBKXxM
 4cfumluNSfH9te4oQbDefiu4Vl2NqJ5526n5A4hu/I3wizCFiPuBG7Y31fPJ09VU
 2pnQIQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5b802jx5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:29:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f5844e383so804726285a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562940; x=1796167740; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tD7gkW9eSakaoDI5uvUOI7aHtOPrX4zWECKqiV613Dw=;
 b=klvqLVWMQyWn7jTi440sAAUUA2s+kLP/PciE7K2Ptuwh/MvY5jJknuJF3ql/xPB+Ht
 m1RaqP/oy4W8uGMExkU7HlsCXsr/UcitFj1Q8o4JgPjQO6/J2iWrJaSzBkCoLyOOcjHF
 GlTCelvNXobX4vR6ZjMtkKMAJn7NvbqA2JfaYTxykmKKYL5lAaru0S649SSIKX2RcYuw
 lKyvdz+pHLS35FRJ1j819LtaEUrWOO6FgBkpj6mWYytXnoMQBEepTYDzQTTvNkS3HdXZ
 1W1OZmRes7HpoBUQiUtPc6aai5rGLYiwN65iWk6hW79YZgnJ9I/CE+r4shTMh0ShERiu
 9eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562940; x=1796167740;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tD7gkW9eSakaoDI5uvUOI7aHtOPrX4zWECKqiV613Dw=;
 b=ACPnx/TqsdbTo+xj/X2PTpg3KWBgb9tIajRXp8dcslngQyDH3P+3d69ydbTooAxzZu
 cN8RO7idZsv+npVMn5nR8CC7Snuy7KCUf0AqHLZDBN+cDcupAdU7f7jEbxgn/EwziBeI
 UV87QlhQ5wQaQtZ+ItCUh3bU5UzQEIZQLq5ckDa5LZOz3AouoAtBALYR8Dw8N1L7rZ1A
 GKILChUKd/F9GajTbCQyuE/CqUc5b+GSchzJq+RF6tlxg8DdYjnbLpBReUI9Xv424TDS
 7cVAWUI1yg7elV1Vqv+qCWRUG9C6lgZrYafcQIDbW56CJ8JFgpItNo2RHe1EtCpEyH74
 982g==
X-Gm-Message-State: APuU4Z+jAwL3JxrbK8t5sBQNcLFTy0WRkp8Xrsts1hiWnaKlj4T/K1+G
 Zw4KbQbjZkqe/KB5KgmxbvsTN8Mt0UFiv4ABVk9lg8Vg2IieZI6eqoTmrxt7EM3+LFHP3DTeoWC
 s55B2Q1d+7lnAkoJJixx8+OPqNMnfbMP8OqA91JfeqVlCTKu2MkINXhCGIHXNygBSjIRQ
X-Gm-Gg: AZFdTZfhZEy11fl2f4qRxV0M//0vAXqVQVUXpa5dRlKQ6C/tq3owo18J250iz3W/kB5
 kg7bT89CQ546PipLFAdv9iKET7/liIHJP8dzdKm7wWpX8fejjO2dV8ef00WGhKw2F6BkmTHukOk
 NlWjN0XGdpJl0qY/99L/RglTq86/iroYAk1h0LpqeU6p7+14hTLfq8B9AK18kD2JFYo51+6De19
 KllRVol196tVP87SvO7Ow4T4z1rqEGCMx2pSNKS0/u1VCDl8/j0SYzE4pm7/HcknIvPZHermY0K
 z/Kf3kt2ZwJQAsihNROez5g2pRdyDhmtoxXeVxDfR1T/iG98Ng+C6LIM6QvDsDyeb6dFtJwQ3E5
 YsWZAQK1lz5wsFo7b+YpxP0XvGnubRetVKCpI1arXMANWu/YdnpZCsNTT5/4ml77vQmkd1bZjZ8
 Abtyz+COotsdaEhw==
X-Received: by 2002:a05:620a:1b8c:b0:949:7920:9d09 with SMTP id
 af79cd13be357-949ba99fdd3mr2852738385a.35.1795562940180; 
 Tue, 24 Nov 2026 15:29:00 -0800 (PST)
X-Received: by 2002:a05:620a:1b8c:b0:949:7920:9d09 with SMTP id
 af79cd13be357-949ba99fdd3mr2852735585a.35.1795562939750; 
 Tue, 24 Nov 2026 15:28:59 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906640a2sm247965305e9.0.2026.11.24.15.28.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:28:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/18] target/mips: Fix nanoMIPS BPOSGE32C branch offset sign
 extension
Date: Wed, 25 Nov 2026 00:27:17 +0100
Message-ID: <20261124232722.90234-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfXzYe6xdPPp+vr
 AGz6KKMWER/a7iLZJzzOrjE6V+wBzcFXNU3V/+x9KWecIoadmvWQwNNDYewPDG/qxNP1YnUwynO
 5TVXa9f4dxdfwMcqHlVfzc5MWVQ+AEka/7f7qPFw/pasTxONeVJutGuakfnZNKawRTr74Dyge0R
 Zy5zPYI36gg5IgGfgbKkYWfycuzRRrPG/7MTCI27EwMa2y4ut+a6X8AeX3aIh7rfRxBuOcFjPTf
 PlUvmtikFVXFLvKnblliyiFXWAgv+9A9FM3xvYUWq71S8C145ndaavK6YqO33yAFWNVxYgzgEO+
 DA+m2wrILOCxXKO9Z7B4dQSmoRRquItzHqcXVwQgzQP/0ga8iXekFX6PBMuxMRdnQIjB8NRMH26
 KSXMVAGHTuK4W6JPSv/LW1SnEyRiWDwXNKg8LRd6m5J43X9ZjZ7vRGNt9UDo0+3gaT6jFVJ8eef
 UKbexREQIydi6XvGigQ==
X-Authority-Analysis: v=2.4 cv=K5W3jCWI c=1 sm=1 tr=0 ts=6b061dbc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: idp4CWBqXfnP13Fxdl3gaLdPjwKLfMY2
X-Proofpoint-GUID: idp4CWBqXfnP13Fxdl3gaLdPjwKLfMY2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX7gAtLbqyBt80
 sFc0HYKsTPmGxPDjQ2E4crexVnh0c7r5t+L8RTZE9JP8PRWEoheTpaqll089Kc/UP+QgWgQX4sK
 MvUNYBfbp1/a+KAIYDDd3p4NtdLZZo0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240092
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The BPOSGE32C offset is a signed value s[14:1], with s[14] stored in
instruction bit 0 (MD01249 rev 0.04, "BPOSGE32C", printed page 88).
The decoder zero-extended it, so backward branches went to the wrong
target.

Reuse the sign-extended offset already computed by the P.BR3A pool.

Fixes: 6d033ca7513d ("target/mips: Add emulation of DSP ASE for nanoMIPS")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261113161158.25811-11-philmd@oss.qualcomm.com>
---
 target/mips/tcg/nanomips_translate.c.inc | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index c883b5514f1c..f1462c971a93 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4364,13 +4364,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                     break;
                 case NM_BPOSGE32C:
                     check_dsp_r3(ctx);
-                    {
-                        imm = extract32(ctx->opcode, 1, 13)
-                            | extract32(ctx->opcode, 0, 1) << 13;
-
-                        gen_compute_branch_nm(ctx, OPC_BPOSGE32, 4, -1, -2,
-                                              imm << 1);
-                    }
+                    gen_compute_branch_nm(ctx, OPC_BPOSGE32, 4, -1, -2, s);
                     break;
                 default:
                     gen_reserved_instruction(ctx);
-- 
2.55.0


