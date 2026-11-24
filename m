Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB220606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sa5ML54g;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kp0SImR4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzxN-0004HX-Ss; Tue, 24 Nov 2026 18:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwy-0003zU-AE
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:29:25 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzww-00084X-IC
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:29:23 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMaerJ3520116
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q/r4AwdbfkN7HW14k94mwfZ7+ibhnteT/J9qc9kufWQ=; b=Sa5ML54gzpI9xvD+
 sjM9XSSi5aRRGatBhKvc63yVR0R+K35AkB5CAo0QqDJbcrMnqxPMfX9VUtAeEcNe
 oGBKrziolsKTuwq/CerL2aWFSaqySXFknRyU3kMXKZhegzK8lYKgCasza6D45dlH
 CMJjc9vy0MoOaYRcqKRw0Nc1zWAYKspZx7Tu+Yz4H49REcHDyVq8sd9T0QMMZwoW
 XvYm/q11SebKslRCc45b35gIgaSMXMLX+xZM32DnO6WV9EMRwaVYxX51YTA19Vbw
 WRbQpASqZA5NoCVy4e/DoTlxyRt3e6mhO+24tgiDFyzoDQ1TBuSK1eaV2F6jfFLg
 3H49vg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5f00h9h6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:29:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f33438950so893699685a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562960; x=1796167760; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q/r4AwdbfkN7HW14k94mwfZ7+ibhnteT/J9qc9kufWQ=;
 b=Kp0SImR4wKuxHTqmRNQ27GoBHaTkOAWGeYrLmPT28ah2BNOfUeunos7wNtK/nIBUHG
 aedRIzywMvqx4v0oNa46dHJ+QS9vxARcaSZv/dRN+H289Td0Xv2PqVOJcYPH6YK+LTxX
 hYoW2taFDMVhnEfUMjH0pjvsTV+4YkLTAblI+mfzVsqiv4LMqW4UG1ujlpBlpe4J2bkx
 mwAjMkcmAEaqDSt62yd16Dqlt2w8hc2CXQMFHiBJJ6Bvy3kQJcxJnGSlr5K54LJV0PA2
 QkoFtaXz0UKK+TjuoN5FsMSLVxb1u4zhndGdoDxD1ymx/pd29J4nw4aUwIycCvFJCvnq
 +Esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562960; x=1796167760;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q/r4AwdbfkN7HW14k94mwfZ7+ibhnteT/J9qc9kufWQ=;
 b=nBpDt+eCmmlo+oELfujb/FBUjTQpqIfDhESTVXqzz56wnnk6XVHU1MUPAW67eGjnpV
 C5PdMAaaL/xmO4LDx7P0a7uboSh3tqZb82xu0mupu/NVDZujKSJ6evmDHg93milZ1UTt
 ABVnBrJgq1BQsWMVwRDZGIqgvjS51LNnTlpFwTFEntXGxrnCkQUAvIOE4AnZ2BjhqirU
 6HCRDoxZE2JXvBMmfhJ+yLehzdcE9aGKzi5QTCYPJVIEMHmB3Ke86tKXAZeVzmVq67jj
 xXY+cLy+Pupfyb6e62bRVOH4M7CJNGAUqka+BqBeelbYIM39NQGzM4Ncd61L4rEgMR1E
 0zwQ==
X-Gm-Message-State: APuU4Z92lKhWvH7ljkbnXC+OFKzB7ZcLC3f6tA1qJNpiv0K6jz8WrY3N
 U3mBHueLrCUpCaS6vM515pVjlc6fBasD8UfRUx0/taPKw2Uo2xLo8OXi5OxCW3N5zcotGkSRHhT
 dqPYZ14gbMpp7thzxsw2AQst3vCRJkufvDRBVk5HUMHUVlxfFGLbt4nYJreldfnDvYBmH
X-Gm-Gg: AZFdTZck5XCKOw+ECGZiUTK7Q6pxVLcT8glhpju2aB4fWPrPwYrBplv76q8x+WoYNui
 0rqC4nnt0kfrgvtLhwOwBiyQy8pSYEeWDPucDlsSNRqMt1El4w4PUuPPdH7RVc0SSeqqANPw10c
 7bbqgCqop9uptip+k4ax+2QV8xrfjkjd4/HyAQfv0XOAwHZseLCZH0g8I7pwWwpsByLneNam8Hz
 zs9NOYz4o+6QF/wBTC2Lp5QmFbHOWV2GJVwKZ0+ILGR24hsd0U5SR+6lW0ZuWOfexL0txjZpdAL
 2eFRy+XBzYKnr0ZSpsH0NDogaWN567/uR7BrCb3rn7Kd56sORL0SmGK0+0hcTfqnrG3XKwl9h3B
 nmdvwuf9Ml5mtcYdYY1xp8EhSnvroU2dExnAIjPXBjNey3QYuLLK73xexg9VoN7ni1Y5YBLq/Ty
 T0xyATxl8MD669OA==
X-Received: by 2002:a05:620a:2913:b0:93e:5fff:db07 with SMTP id
 af79cd13be357-949ba9a9ae3mr2957709885a.40.1795562960177; 
 Tue, 24 Nov 2026 15:29:20 -0800 (PST)
X-Received: by 2002:a05:620a:2913:b0:93e:5fff:db07 with SMTP id
 af79cd13be357-949ba9a9ae3mr2957706485a.40.1795562959707; 
 Tue, 24 Nov 2026 15:29:19 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8533579csm413696615e9.2.2026.11.24.15.29.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:29:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/18] target/mips: Pass the nanoMIPS BREAK code to
 generate_exception_break()
Date: Wed, 25 Nov 2026 00:27:20 +0100
Message-ID: <20261124232722.90234-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bMsd0MzQoMLp8InN48lPsM0Ehtqtmgn2
X-Proofpoint-GUID: bMsd0MzQoMLp8InN48lPsM0Ehtqtmgn2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfXx7MPFPwZzaZm
 EK/CmP4DjD6I4I9dwq48nqdoy7sLMArqigloZ74b9dJBe1NX95VVTnxX+U0SzsiDIKYWNZXp1sH
 7k1/jR6lscwmbRBraH/nyr7PvewcGAg=
X-Authority-Analysis: v=2.4 cv=JqtkP84C c=1 sm=1 tr=0 ts=6b061dd1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=8IlIMGR4T542jAIm1n4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX3761dntF9nPI
 0ttyjp+2UvAT6iDR0XhugWD2SS70FusiY8fBgVjkkN0QlX0wxC4+/qXgkY3iskdIiGllGhhs7SO
 tEambJB9oaIz9tGzVs18QXkQ9VHhEgvsN6wIEj5ELNPmlO4C39PttyGvo4iCt4zz5TabBVPiS6H
 iELxr/xz9wL2GrKzC7rYI1oqtLcFAP9kWVdDj3t/QyWfXgBF7Ubblpc+cXrw/j/LnltVninJJLU
 Az8pircAuKakNTK3OGpO40xEfwYLyW1loH3bcWTFVjN8l+yY77b82zE4Mehwd9SnXb8L/HTrGF+
 FVni3S51LKIEqtitQQfeFW58nWDIrzc0LKEkGarL4uY+rxHigJQ4LG3ag75pjTnzU5F26Dciizv
 2GonPoTTGkCVJG3NE0xkOPCvc8xLC+vU36S3etLaeCotthjYQ75P9pgOre5QTMy7eO7RuxB/TcK
 D//s55Z4+Bawmp/VODQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

The nanoMIPS BREAK[32] and BREAK[16] decoders call
generate_exception_end() and drop the break code, leaving a
stale env->error_code for linux-user. Pass the encoded 'code'
19 bits for BREAK[32], 3 bits for BREAK[16] (MD01247 rev 01.01,
p.59).

Complete 6f3533dd1b6a ("target/mips: Extract break code into
env->error_code").

Fixes: c02809830346 ("target/mips: Add emulation of some nanoMIPS 32-bit")
Fixes: 8869ad02bfd9 ("target/mips: Add emulation of nanoMIPS 16-bit misc")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261113161158.25811-16-philmd@oss.qualcomm.com>
---
 target/mips/tcg/nanomips_translate.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index dcee8df333f4..19cca9463de4 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -3573,7 +3573,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 }
                 break;
             case NM_BREAK:
-                generate_exception_end(ctx, EXCP_BREAK);
+                generate_exception_break(ctx, extract32(ctx->opcode, 0, 19));
                 break;
             case NM_SDBBP:
                 if (is_uhi(ctx, extract32(ctx->opcode, 0, 19))) {
@@ -4508,7 +4508,7 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
                 }
                 break;
             case NM_BREAK16:
-                generate_exception_end(ctx, EXCP_BREAK);
+                generate_exception_break(ctx, extract32(ctx->opcode, 0, 3));
                 break;
             case NM_SDBBP16:
                 if (is_uhi(ctx, extract32(ctx->opcode, 0, 3))) {
-- 
2.55.0


