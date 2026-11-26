Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F652606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gbM1Si2a;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kUhht51D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj1a-0004iR-B8; Thu, 26 Nov 2026 18:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj1X-0004aP-JK
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:37:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj1U-0005F0-KX
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:37:07 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJvo7c060406
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R9pD3qq6szDi5i0YRU5Dn0Z+n6ZG0Tdo6Myaj6NUP7I=; b=gbM1Si2a/NgDMFkQ
 l0UJ0Vxmmmzqc3eFjIKd0w0IpL6QWubsDe2sJvavnPAAv4Vkjc78SuccKHCs7F2z
 mrOQBe//WTeI8zcz4q+p9alMcZ/K5eY6kNlI0pDt7tAUvG/UTRmPOoYPXq+DBYDt
 6FTRjFLv2jDyaf5v3uj1xjIkUtNHUmt+zqAkUeTO3i/lSSOij50X9tknzvjg1x/D
 EJxYd7L/GPfy/JfEOiBOSpwgAuUaxw5uUAOcAcT57CYKNxJBKa4ebG35NmRubq50
 na1FuoJWZGnZGosXcFTv/qfKuBzcqBR+8hlp4ZT8/XUGscPjP4hqWE3ugqfA1RrO
 bZOKnA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4hrg0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:36:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9496ff065bcso1003994485a.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736212; x=1796341012; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R9pD3qq6szDi5i0YRU5Dn0Z+n6ZG0Tdo6Myaj6NUP7I=;
 b=kUhht51DKG9mgkEE+pupT14r47jh1p5JxtvkjxER0y1afdY5YoA6pt5a2+eaTAjgTm
 uWR1qnZ2uAzlWIzhZH/HqsQ+xtUQPoMmewroWsaMevQugNSpgeg7uHDnG8zsx9rFim1v
 oWyP7WJWWmTp2SPhe726kczK6sV/LvkOlTH1LH5YwsvuUYfvDf6w1KjR4j3K7RK4YH5N
 Y9Aqr8oi8aw/uiMp+nm1KKr+lftAcL3svrA3brJ0+Sk4cTKisFDtRCiklHXKsUp3jnMH
 vHheni5AurbCxnTOtS2U+9G5jcPDoZuHRMMLsVy9RHuNvWByI8wGYO3bRIDTFsU4rQDS
 E+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736212; x=1796341012;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R9pD3qq6szDi5i0YRU5Dn0Z+n6ZG0Tdo6Myaj6NUP7I=;
 b=OGUcOhkMHH1bD6Rw78jo3yBOEBAY+5bBcQdESdEUxmC0TTfGPRQC+AUNFYtgflsW9M
 pn2msCBBeEzDFFKoAIgpbM9j5cg9kQ/KFa3NZYFFm+P9S7jglM/tayArBofQe6BqbIvU
 fKa4xpcUszRmLiyfaDIBQV2KCbVT2L0mXWc6SUS5b9MKhUo9bc2iqI77SK9zLFSmOgeC
 /k55uc4ollbtceQDa7e9an4lq3F3zdN+XMG6CjlmmQ+xe520rOhGxreaJRGzPYjqhgTD
 OVKSDP/0+W+KMNOcGDXX1BG4feJf0xlMtbwn8UIzasoHc4tMbMbJtIJUSjm0OeU7g+qC
 lBRA==
X-Gm-Message-State: APuU4Z8xWyr/qEm77+M9J85Xm3YlepssdM4RyzbMzZeD3Schl0mjasS2
 KANvFQb5LxRngK198o3C4S+aWRlwuZY7zAADqpWUdRXp9dj8HqXEnFbH9Lrcpznctq6uEQqkRYG
 PzkrkSw1XZVgf7vSqxdF4G1voqtpF1259LSRJ9oRuk0UCOPDvVy6e0FPxqH5S0IFMKA==
X-Gm-Gg: AZFdTZdwcpYfNPsDgLNfccK2IUHg8Hcj39HwJqgbmIRsHBd9URNT3fBgaKWYmVJ3PsY
 th/5mILi8HdjhLovNdDEfSILq6S8Vv7XpcdX/40Vltmzj/saWaHNSxeroljRYYOqz8UV2jhoMYf
 pRzEFdxQ7IaR3rcpHWKpVxET7ndsyWa2qC2+VFqNDb/JAwMQLiNTRL32GIbZMzb5CzsPSMLGsWN
 gMaygaKv4QgAsYS7VizOefRkaQDMOx7HUy6XzFneCpZZW8sWdPp2j+DwtpQJp6OzuxbwAxMK38c
 P308olpLUFjz/NjA3yBXBIeErK4i9K/B2KIDTw4grIXMw2346ZbaajKrkm8RfQY+Nw3+3Zg/THQ
 Wj0qSSJeosDKlpXRrTLWpCL7S7kBEzI5EJ4Afm4VgiGduJGhO08GbOIjJobCLrBNwZl2B8BwRXm
 QziFhsM+ST3nOx+Q==
X-Received: by 2002:a05:620a:4454:b0:93f:18ba:bf78 with SMTP id
 af79cd13be357-949bab1bf42mr4247004585a.69.1795736212287; 
 Thu, 26 Nov 2026 15:36:52 -0800 (PST)
X-Received: by 2002:a05:620a:4454:b0:93f:18ba:bf78 with SMTP id
 af79cd13be357-949bab1bf42mr4247000685a.69.1795736211769; 
 Thu, 26 Nov 2026 15:36:51 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c50sm42808995f8f.37.2026.11.26.15.36.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:36:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH 06/24] target/avr: Use 64-bit TB flags
Date: Fri, 27 Nov 2026 00:35:44 +0100
Message-ID: <20261126233604.67722-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX9nAeZQMGHiY1
 0DVI8c6g+kihTZduYlnofc8Nh7w8/nP1w2qaA3i18eekgBujq/FoPhfPYqraeyOKxdOdgoInIEG
 ivDYLQAD4DY40EQQAydN2e6RnXWP4co=
X-Proofpoint-GUID: zqU163I_I6FA15qViM16YcyyxE6WQIMy
X-Proofpoint-ORIG-GUID: zqU163I_I6FA15qViM16YcyyxE6WQIMy
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b08c295 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=SMSkvsHJu0LtLNEn4aUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfXxMrgiMrxtW4/
 aUaUjXMXDcyA7QOcKEwVnBUSbJnWNipmrVbd70ObKhPAPMzG8SXimOYREdpZw0w2FVVefUNjmAs
 9WK0SyHv4SMsYtUY78ltVPliqWd8YxLe1d0Brk6d1a4wro0t01e2dkN3eP/CZghnvfUm++nRwRY
 R7GqknGDUX8BrZUZCfyKIWWR/qpAlPCoEc87oK7ZsgFRkQW0UB2CjeV+JBTMPp1hvgPB7UfprGP
 ndKLLCdMutidm4kQOLipqhaivcFvjxs+FcnuW4DumRD35I7mnVczVRSAq4gGbYZKUpOHTvjQd+m
 gVP9RSapnBzov1WQ/KOMzjuP0j0ClfS8yphrk+WAAOlvhzPM5LcTSGRpQO8JWht5XkapQ191dcs
 vu9varC/wTbxol7QrEM6LRSDiY9XyGExdwjltlmfLV9vqLix/sWO4yaAeow0kHP9j8SThh61im4
 5wL3VzVc7wmqu6Qw++Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
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
 target/avr/cpu.c       | 2 +-
 target/avr/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 83710f565182..689d3f6ac5f5 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -58,7 +58,7 @@ static int avr_cpu_mmu_index(CPUState *cs, bool ifetch)
 static TCGTBCPUState avr_get_tb_cpu_state(CPUState *cs)
 {
     CPUAVRState *env = cpu_env(cs);
-    uint32_t flags = 0;
+    uint64_t flags = 0;
 
     if (env->fullacc) {
         flags |= TB_FLAGS_FULL_ACCESS;
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 3c5760609702..6a4e36f326af 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2660,7 +2660,7 @@ static bool canonicalize_skip(DisasContext *ctx)
 static void avr_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    uint32_t tb_flags = ctx->base.tb->flags;
+    uint64_t tb_flags = ctx->base.tb->flags;
 
     ctx->cs = cs;
     ctx->env = cpu_env(cs);
-- 
2.55.0


