Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94827606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ev/RZ3H2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kVtiW0SR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj1S-0004Pj-D8; Thu, 26 Nov 2026 18:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj1O-0004M3-1W
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:36:58 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj1M-0004eU-E9
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:36:57 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJvupm060708
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aKXQ2PUage8tK9Q/lYV3x/9ZrCYklyEq2vLrHsxomHw=; b=ev/RZ3H22mdjFZXF
 i/vUf3YAA60wWIXV8+OLcScme/VXHK8oklyXcTcNG9Yb1ggwIesfJGljsRSAYW2y
 eC4ZSPanhueNKG5naeQwHWuVUyO21v9aUTnmEkjEhWwA6UiZH547BJ1UwGvDKbB3
 h0iPzUpQP4IzGLg0dZRNxKzCKjRi/B2O+YZzl3ZxSBP1bZcuNRYLauMYXznoibwf
 p1F19oOWbmrA1TSsS+X5OXTRiJQeZVoExMU3d68+ERVPHucSUfFKlUivRofeitO/
 jd88hecct8EarVKhO7feG9g5fZDKB58o8/d4ypUOLKIj3qKNhy5SAyjHsgDzDUdW
 7Fc9hw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4hrg0a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:36:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so1411677085a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736204; x=1796341004; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aKXQ2PUage8tK9Q/lYV3x/9ZrCYklyEq2vLrHsxomHw=;
 b=kVtiW0SRyVa06U3PuYPSgDih92AYqtLxF5yZ0eFTLLenhtII3ue8rV8K0BBtUJkvyY
 CHO9kDX5pZ4+ihbc6QS2WbJnR0YfyseKDWlNBF3sUH2PFTKrVwkWdXs/gtQiHIPdIVzc
 LCr4JH7ZGXLyxySjlxaujARUPbXuodkACH87W79QKi25tie1fufCj9MLhl/5gyZKtEVK
 G1c09uauyhM5DiRESsTMpU4N2kmrbLPPa98Fse++SHS+sa1sKiNL+8gZsxplrUd/3P2e
 uDIhMyRkqie3POp8q9Oe1tO++ee0qKlXGqqSaSiTDUl6n2g48MzIyr/qLdrN+QsiIZjx
 uYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736204; x=1796341004;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aKXQ2PUage8tK9Q/lYV3x/9ZrCYklyEq2vLrHsxomHw=;
 b=fQED3xIs0+AUzjTyd+KUqB5kv8SIF92RwzQy22qZNmac2Ns9NwxayWavwZE78uYfDX
 DCao2cCT/79b9vpbaF1ISiybGSjWFesYzFtGZAW5LGc6rcbu71ynolaE+nCwjiHzwxCy
 QZPcCn8SJ15+3GwbuYhLZb/Lewn4Uk0kGnbh91RcHQ8i2W3t2eWGsl9Fx1c6oDIXsaMb
 P141KUOerPalh0fBlJTLghSgiN2LSPwEk5dicEVM7qSP7DAqg+DOnc1/5LiMBwg7zPzh
 sQw1aHfO1RwrjmQ8Do9hPVKQmh3S9yyapCnB8Tv+2/fEqkCtOHT5WqxekwO/mku1gLQk
 bYqQ==
X-Gm-Message-State: APuU4Z9MEYRvtj22/7UrZBKd5m4+bQunPBWengGXciT4UFLW1WaYcVnp
 bjKl4xkLqZwPiAGXrvqTlRrWFu4biZhJPj5JK3TEe9jlGJ6Q3bjZpBq1RPynQ/Npi+KpAdHi1Za
 MbcqrJCRwcd8/H073xjkqHCr78xJOLJ/3i+pvsq0Axymun+GDCYBZJ8QX1VkVoCRP8g==
X-Gm-Gg: AZFdTZeELm59RRVl26tbhm3KtTQflG8wijrdeFwQazYi7ch5f7NjGhXtcsZE6CmZsi0
 3aMgIsYmoU+0A+YqDx07AvaXd4cqvkfrwzaReXaOcGiXz8/TDeet1l4hqHFQGLSdR/Mr0n5TR3g
 QcV6ZaT/W68b+v16JaeQ58im1+7lhGbgX3k3pQomOMadFR7m0Ag95XuttArEi0V9YAlt+X8TzBk
 0QL9c5ct2uMIswa9MkFyqdseowi3xAKZ+fx3IeY4vtCvJcKxsTC4QU/FoU8+ThTvVjFDKKQkSAm
 iAUCoDUD73BNd8eSosgE/NBRrXtsytJhKZNfIDfBVswXHHpmNgIhvPNkUDXu9pSVkz+N2N6npdD
 zbTOojlgBrjJI+YhVa5EFnp2S/oP3EuOEWWMyj88sEGyyNLks+rAWR7ZrF3i8op9M84sSP4vGeo
 v46ET26awt7whP1w==
X-Received: by 2002:a05:620a:4111:b0:939:5cd5:e243 with SMTP id
 af79cd13be357-949ba80f8acmr4042820285a.6.1795736203794; 
 Thu, 26 Nov 2026 15:36:43 -0800 (PST)
X-Received: by 2002:a05:620a:4111:b0:939:5cd5:e243 with SMTP id
 af79cd13be357-949ba80f8acmr4042817185a.6.1795736203361; 
 Thu, 26 Nov 2026 15:36:43 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b216esm699305865e9.12.2026.11.26.15.36.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:36:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 05/24] target/alpha: Use 64-bit TB flags
Date: Fri, 27 Nov 2026 00:35:43 +0100
Message-ID: <20261126233604.67722-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX8z7RcVyuwz9V
 BT7FYo3BuiNyanovQ288TC0km58thoQ8oSb/BRxoTmQO7eubffaF9cBJxOhqueY8zBKCf6RzTPi
 k6lqIUueoLGD+PItAUmH0c03vASIQjM=
X-Proofpoint-GUID: wMHbsurzRvkaeDdlBigYEqu6FIk2ZApE
X-Proofpoint-ORIG-GUID: wMHbsurzRvkaeDdlBigYEqu6FIk2ZApE
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b08c28c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=60FdqjWU91-NsAbpyuYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX71Eoor72CeW8
 Yrx4PkwqGvSRZ8oThMN9hYq/rMXgwV4vUieLR/t/J7DPWMkExF96rfU/4ViTj7+M3tc9EFe2CQb
 yXrIvFGwgMG6Nqs8ryOFlQuMQw0o6qBu5wzB7ytjT3rwf5VASJwDxmBR9rA5XUyXYDwbRE0LzAW
 eCm7+9E4j5u/VB8bPQJxuqY9Bk4GypzLxzx7gtcJ9cR8XFyIuyqvNL1wTdBF9ga1BBSJXk1RWPn
 ZobnKJeh2RJGTzN7c+3FjIuuCnAXVsxYaSHh8rytw0TXM+pnDptGBr+XGrgmpGffutmyq4HkP9r
 lreUdscCG/p+WGsLbg7CojVbKGPk+oIE46+NgGFExxChXbsL1vRemds85w3p5DRQyQvtrLhkdPJ
 06Kqw4lRL4tNA2WLxjo4IZlgTdBx5vVWyS04iEC8+hDOoQJTWEfxJ3J2Xo9Fv78kaVodOcOn6wT
 h7y+MSfiIrq11FPtx/A==
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TranslationBlock::flags and TCGTBCPUState::flags are now
64-bit, use matching types for the values derived from them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/alpha/cpu.c       | 2 +-
 target/alpha/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index fd099c8e70f9..de452c881172 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -44,7 +44,7 @@ static vaddr alpha_cpu_get_pc(CPUState *cs)
 static TCGTBCPUState alpha_get_tb_cpu_state(CPUState *cs)
 {
     CPUAlphaState *env = cpu_env(cs);
-    uint32_t flags = env->flags & ENV_FLAG_TB_MASK;
+    uint64_t flags = env->flags & ENV_FLAG_TB_MASK;
 
 #ifdef CONFIG_USER_ONLY
     flags |= TB_FLAG_UNALIGN * !cs->prctl_unalign_sigbus;
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 6f18b8d1af62..2063abf3ce5a 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -48,7 +48,7 @@ struct DisasContext {
 #ifdef CONFIG_USER_ONLY
     MemOp unalign;
 #endif
-    uint32_t tbflags;
+    uint64_t tbflags;
     int mem_idx;
 
     /* True if generating pc-relative code.  */
-- 
2.55.0


