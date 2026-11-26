Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ADB606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YoA4ihgq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Osjc9Sdq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj4N-00042h-DC; Thu, 26 Nov 2026 18:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj3V-00035D-Ri
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:39:12 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj3T-0001Gn-E1
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:39:09 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwj6E1712623
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UgHeI5HKxGDMHp/30iu+FcDW1BImaAv//42V+y+PM9o=; b=YoA4ihgqXNoq5Upd
 xhFY7zH8mlpd37OX4/NZtP0LCa+mgB9ynf5XsUg8p6KDkqnnF/0dxHy0aoLAiVR1
 buOEWUUYCxEyNf9sTxCifOUmuoXpN/iid+fpW4Kv1AJflSmknNrkDoUmR76Y++/t
 DtFEFCPyPOTmfImhSc7WgNTaqEoYX9sZJVnAZC0EjbV/fkCQQsX/3tC+F9FvEkE0
 5W7+IYXdi5V944P8P244IzSbeJOOl7AILW5rBfOhPZSBIDXhvRQtdOUlDQpk649x
 c4lTKDx2DlU3ZjaYULUkGEiVXMzj1qTTW4fFpUaIpjtaKYUVAqOwjZHrb0TtfojV
 7pY0Yg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne2u9t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:38:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-949b0d322fcso1242940985a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736336; x=1796341136; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UgHeI5HKxGDMHp/30iu+FcDW1BImaAv//42V+y+PM9o=;
 b=Osjc9SdqCwjpdlx4yyVger9RZtkfiF1h74TxNikpMZtWp9Fd27YeFu6woDkiO8WRvC
 rh+LhfhLkRW4YWEcp+NZYZ5d143VEMynWGJK3YIFKygsG3k9SSOGig9qOhgLWC5fmYUj
 ON5eJ7Kuk2Rff1v66CU9k1yNoFmSkKJ0qjxnRC0RrZzzD1Te9Bz+SgDY0WH8RBLweM0A
 Ait00jC6dkHD+9qa54BMSyWP5TPC+kdG1K7YuhFhX0HfcK/ST17PTyEBGIQyQUKlR2wQ
 jf1iyEXbadwmMWeTLglPVAiAh2ZxHGAztt8WnCL5f4zaPMTXY94OIHhNVppXMOaUzDeJ
 XQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736336; x=1796341136;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UgHeI5HKxGDMHp/30iu+FcDW1BImaAv//42V+y+PM9o=;
 b=hx385UGHCEjMVLS4qrkh+04acNE25KBe5D0m5J8SGvg2tl4jGYAg2RhqsxiP512EMz
 AagEhZvO7dGvY1OlB85Cl+kKPFGq6/dxXXj6JHxMfniqG7hyTwoRfguBtBqGZEkqg1nW
 6d+X2J8SrNxUjDNS2dTCD5ySIsxRdK7moe9+VaQDRp9sZBUV2bLUzaXMc6DJMKL21zmt
 9n780NVLb4La2Pft1lvjPQw7u28fHlgZE3mXQwkgrCLHSqDNxmwUk/QAZx5sxsAaDqQx
 qdn3xusR6HetKc4it7GeWFo69wH6Y4yG3+5rXXN6lqiirxyQ+MFJlDct7Ye2ydQyMnQB
 WBgQ==
X-Gm-Message-State: APuU4Z+36zy6tXusJ/eKUbMTKCXSjIXrIw42h1WkdCHCHFpqFSRvt539
 hXHxNdJiMrUKM3XbzmMEiidJul0uQp6z2Y+IiYvYC3hffLInIUaz8eRNeoVas/R0jiKSSByl2ha
 w30+rPiJbJ5+wewdegXrlaIiM+skI6xCF+cjti+L3IzszolbskOZ/+3yjczFitXBtEQ==
X-Gm-Gg: AZFdTZf6J7FS75sVjRXGLYT+fBdE0w318+AtUXIMebNuGMLjRngqP3/I05V+NX3umZ2
 SbIMjETckVr/OL3HyVwO5V+PK/cqjlPXerXzvTOMyB96d4IikIAgh9h7k6RPZWJRFUX2jxW5ORH
 3iFy2Y1gXZCCz+Z/v1P9AbKO3Qa5RLqN+4FAt8LozLHSkWrM79Uk0EWBEy7/UAbKwAxUAY5KBGe
 7TQNihcmfj5nvGr7BgboHLzTe9KJDjfU0KCcl3yLJH/qVAscKrrnLrQahC3iq34mkGqbcOfdaH3
 bcN2LW2n8/2GM8Uk3C5e6UJaix9H8nINphQttHmJy1/IBBu8ZkY3/8as02ZgyC2lNuuZGEzL2ir
 92wTM1zYotvZ7J9imPS1Es5ROtLHXB12eW2ECplqGOyxW4WHW4IIa4su5Fk4H0XR0WYQ6nyBQPr
 YOeMurbyI9khcMnw==
X-Received: by 2002:a05:620a:19a5:b0:93c:8881:8df3 with SMTP id
 af79cd13be357-949ba9cbe9amr4077294185a.46.1795736335725; 
 Thu, 26 Nov 2026 15:38:55 -0800 (PST)
X-Received: by 2002:a05:620a:19a5:b0:93c:8881:8df3 with SMTP id
 af79cd13be357-949ba9cbe9amr4077290685a.46.1795736335267; 
 Thu, 26 Nov 2026 15:38:55 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf685asm43933900f8f.20.2026.11.26.15.38.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:38:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 21/24] target/sparc: Use 64-bit TB flags
Date: Fri, 27 Nov 2026 00:35:59 +0100
Message-ID: <20261126233604.67722-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b08c310 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Z3QnZVSG-XGvYK7FhJ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX7JiUur7oQ+D0
 8V5nQIG/Ch0/3otEB9R/6fowD5ieLaL7oFyYuXeROBwelJWs+NXCEmbo3ll8lFEzFhd118an7uU
 M2QTyj6CzLOcImzUDUAq13P428eYbHIpfGiJ89g8chUJBMqTsWKqfPzLCtRRrfolL0yx5j3qi04
 d3oB7iooC+/wKX4YnqA4zFIt7ZCEi6VmX2cbM1p2qz00gjvK8TQPM60nuZYGdq7+66OCvyHfxCu
 vL21Qh+g2a8Oef2j+Rro4JaHHsMEmUylh9lXTp/f7VA5dMZ2nyUVOlC7vd79FDAYsib2wMrpAsC
 UQuen2dW7TMwTmVZLc+2d1OUD225i0U0L/62bOI6m6XlLqBFnckigvXTRUaiSxYWl/1pMCQAxtb
 YWQLxXungNrkaT77QLNoT4QIujmqX//0bqMRv2Sttyp6NQ28vOhxqDaiisF+MHhlcX1aPJ/QawF
 xFqMaGNVSMLIZekxj7g==
X-Proofpoint-GUID: J2rO0nZSmNZCSX6URxXsTjJs7J0N7lFN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfXyBm24XNfjXOj
 KZnhQtFqvzwsNcxTxffDuGdCGVR3gmMbu5kVMtGeFWPR7X88Nh+ont7l2ma+eazzRbl/9pwa3YC
 iZ5R0C4tYLbLHU3Noide9/q/JM2a+gc=
X-Proofpoint-ORIG-GUID: J2rO0nZSmNZCSX6URxXsTjJs7J0N7lFN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260093
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TranslationBlock::flags and TCGTBCPUState::flags are now
64-bit, use matching types for the values derived from them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/sparc/cpu.h | 4 ++--
 target/sparc/cpu.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 3c1ba223eb25..4ac6e95307a4 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -742,7 +742,7 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
 #define TB_FLAG_FSR_QNE      (1 << 8)
 #define TB_FLAG_ASI_SHIFT    24
 
-static inline bool tb_fpu_enabled(int tb_flags)
+static inline bool tb_fpu_enabled(uint64_t tb_flags)
 {
 #if defined(CONFIG_USER_ONLY)
     return true;
@@ -751,7 +751,7 @@ static inline bool tb_fpu_enabled(int tb_flags)
 #endif
 }
 
-static inline bool tb_am_enabled(int tb_flags)
+static inline bool tb_am_enabled(uint64_t tb_flags)
 {
 #ifndef TARGET_SPARC64
     return false;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 77294136988b..436e1ada97eb 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -723,7 +723,7 @@ static void sparc_cpu_synchronize_from_tb(CPUState *cs,
 static TCGTBCPUState sparc_get_tb_cpu_state(CPUState *cs)
 {
     CPUSPARCState *env = cpu_env(cs);
-    uint32_t flags = cpu_mmu_index(cs, false);
+    uint64_t flags = cpu_mmu_index(cs, false);
 
 #ifndef CONFIG_USER_ONLY
     if (cpu_supervisor_mode(env)) {
@@ -742,7 +742,7 @@ static TCGTBCPUState sparc_get_tb_cpu_state(CPUState *cs)
     if ((env->pstate & PS_PEF) && (env->fprs & FPRS_FEF)) {
         flags |= TB_FLAG_FPU_ENABLED;
     }
-    flags |= env->asi << TB_FLAG_ASI_SHIFT;
+    flags |= (uint64_t)env->asi << TB_FLAG_ASI_SHIFT;
 #else
     if (env->psref) {
         flags |= TB_FLAG_FPU_ENABLED;
-- 
2.55.0


