Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C89606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J5VIM+mm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ms4gBlUd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj27-0005f7-Hi; Thu, 26 Nov 2026 18:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj1w-0005Pa-6z
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:37:34 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj1u-0006wj-3G
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:37:31 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwlvt1012155
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K+1rYPMLMIU1uLFcv/qtFlOmnLx9HwEmB05o3PG19RM=; b=J5VIM+mmkANxLXhN
 fI5+3lgWROGG6/JjeP17XbvAA0TpEawXnsZvIEeppfg/ucA182LQlOb7F7RT0f9x
 N7KsiFTiCBsgkY0ld+Co2AZGWZKrrnZjyqaw2eC0BsE7OHhrJssvwT+v/jNKL2Dh
 219fYNU4QywwpGsaV2oXPC5Pz83qIR4zZixGy103ZYfYRU2vMyb5Uh6ULnzi/rxK
 Phs+Ds+Yp4oVdaQ5KZDU1Sc49O61gN3SZv+7yYaFSuNFN1q3GEP2ZrevouJMxx9N
 8YEv9Z+B/54EwY5IyZ08tyc3Klu73yREvi9qZk5yFZ414cQAZyuUt4rPGtUV+elb
 1B62Ew==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf9109p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:37:18 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9210357af78so118819046d6.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736238; x=1796341038; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K+1rYPMLMIU1uLFcv/qtFlOmnLx9HwEmB05o3PG19RM=;
 b=Ms4gBlUd32JDiCqx/xJcpG1gNWs7n+tnWSHWhtGjmtDs6K6SRylEa7d79Edisgt+ph
 zE7wIQzgfBZfyDxGvQ6YPJcABocoi5Kpux4FVUNxWNMfUsK0b++/1gH0h1tROCiu45L6
 0DUseZnjvAq/0KN2747w5sxEO+vr+OdXnrM9p0LvUVSn+NpIUPqhSuus3s7jFNZt3Riv
 OlFSNxCzD+z/r+ugyXOUgdTaGfKvwIRXNieJTD49VMs0u8aBMpycn6OCxR+cWLi0TNfz
 +DmpMJ7Ek7Pw71xxePPCZWe+ur8PZz4xU58SYJy8YOPmeM3CDRx34l/8WEwZ97r3Km4R
 7hsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736238; x=1796341038;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K+1rYPMLMIU1uLFcv/qtFlOmnLx9HwEmB05o3PG19RM=;
 b=cF2tJF2K7kNlHlXJk6K2aE69ImlmhjqQE8R6oNlfq6xGdzvRWGHsyS6/BZUU+4HNKD
 SeuNyfqfdr6L8mRiBX9Dpmr1/2Aay2EF5suoVZ3P3dhLwITl5yIqKkAp3CADRO/kECYz
 5Y2CEYbUA6TUD0eZu+CXFitsjm+EoPJSnWdtDJSeKs4wDVO5YfZ41Rh2BekxET9csBar
 1ODwfhuCS4zLqXyQkng7Jyt5o8SA47gAGoCx+gziSowKpy71Bcoi833RIrWGReY6XF7n
 /UdCWTmaVRjP7nYHrEr+5lRo0gN1W9vBujN6khiT/kwJOGRsS4ondsFVtFaM+PrsFq/X
 CCYQ==
X-Gm-Message-State: APuU4Z8oRyJa7Ln7sAhoaYfb/jKWsKiSIXNKRfUanqwWTblviQyFgCRG
 MJIlF9+MbXS3HTqTm4NHgjX5ESatCpFa/xmWdlQvadQC4OzzyuixlB4msN6hcG5Fq/oYEqlws8N
 CPbzhM+JYPUjW6G7lIpMphrwzncUo2GUGSHg23YuZ6V9CignapYoAURCh9qCI7lnIGA==
X-Gm-Gg: AZFdTZdGw0jKJr1vcQsjFxqtzE0x/fnZttwOyk4ytET9hE0vN/jjgvbNi+Ej+bR/qoL
 D/bhOgSUXbvcgRqJ4dTgsa7VvRyJ/X7fr1wHI0HgN8lRYckLTTtykQtP+DVnD1h8nF2Kk478syW
 cQl+iXvTuQG40HmVPXwDaRe0xca9LF/th8a/ID9jXR3v7PoOUXZ+2oNGLaxzcKGVevN5F1dygm+
 uuiVv3vSZJ69118Mieyo+VhJ9hztqafvtJhY8iwV+wIm6SVZ2nsl4VCT4LpOWzHa7oVm58JWTcy
 6azIKV7lqjwOkaoY14P0lpQ225SRqsiOkJrvqsd9kVqmajXmUBFTtg2Y+HyVsFvVnXxjHGsmzdE
 vZDHTp5+ijjyerV1QTb1DI7gLWKxCk3T9dQxhMyuK5WsHNJcwymYT8Id7buy3SFpwrY/qJgwblY
 EFZdj0M2nqYgmKsA==
X-Received: by 2002:a05:620a:372b:b0:949:70c5:c0ce with SMTP id
 af79cd13be357-949b35ac8e0mr4173812285a.19.1795736237568; 
 Thu, 26 Nov 2026 15:37:17 -0800 (PST)
X-Received: by 2002:a05:620a:372b:b0:949:70c5:c0ce with SMTP id
 af79cd13be357-949b35ac8e0mr4173810485a.19.1795736237132; 
 Thu, 26 Nov 2026 15:37:17 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989b3sm43372266f8f.51.2026.11.26.15.37.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:37:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 09/24] target/i386: Use 64-bit TB flags
Date: Fri, 27 Nov 2026 00:35:47 +0100
Message-ID: <20261126233604.67722-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KeNSKHwYfzkbEdz21iNoWkdl8GoSenOH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX0nhcSDHqB0Mu
 UxlxBZRausk1n77HFJXRXgyIAKHGEcMB3nBWUJNQJWyGYok+IwLKtw7EXK37Ok8oW6lswcYVZRW
 bEkzorndNscLu1dBd6DEBWXwQZx+tYrFjOtSQjE8940XzZ7bYq4OMmWyR7zO9W4Fx6A40zH4Zug
 cgD8frMcgrxa2W8WkCvvTJ0qIjKG7xLbRVqfkYlm26TuoXmzD5TO9rvkBquN5G5vuoxakddpkwC
 RiDIW25cBzjf5NST/FeHVfAvIgNK50tDUThIwZGgzPW0lRn/3onLRi1pvaGhJz/4rMCwcb7CNqz
 8acAuSgp1Vl5RkGumQ4OEY+O2YolHtT1MWoaKtyNnox4hPx4xYr1wGbYMyRn90JbeTyOzSROg6b
 pcSYFaDwmc3dBIYmOk7McnMUp9vT2hp1+QB3dPWAarlqp99621SGq2J10yE/V+0IUzAXUZhEI3t
 LdQawinQVRbLnfkqraQ==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b08c2ae cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=7CWSldxV8w5ZVOrNXgYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX7BHWwLSw3XYx
 KNQrUHND3zfgZapPdh+GghPYOBKHjO6ih4zFTsxVb5tGfHmfBtk+/JxZuU/OocaLwdjLBWxasf/
 D0yr1ezgFnhBnkvc3pfBmHf9aUD4Ho4=
X-Proofpoint-GUID: KeNSKHwYfzkbEdz21iNoWkdl8GoSenOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
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
 target/i386/tcg/tcg-cpu.c   | 3 ++-
 target/i386/tcg/translate.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 167ff7695ae6..bdfd08107d6a 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -53,7 +53,8 @@ static void x86_cpu_exec_exit(CPUState *cs)
 static TCGTBCPUState x86_get_tb_cpu_state(CPUState *cs)
 {
     CPUX86State *env = cpu_env(cs);
-    uint32_t flags, cs_base;
+    uint64_t flags;
+    uint32_t cs_base;
     vaddr pc;
 
     flags = env->hflags |
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 719771032ff5..af98125cd718 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -122,7 +122,7 @@ typedef struct DisasContext {
 
     CCOp cc_op;  /* current CC operation */
     int mem_index; /* select memory access functions */
-    uint32_t flags; /* all execution flags */
+    uint64_t flags; /* all execution flags */
     int cpuid_features;
     int cpuid_ext_features;
     int cpuid_ext2_features;
@@ -3535,7 +3535,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     CPUX86State *env = cpu_env(cpu);
-    uint32_t flags = dc->base.tb->flags;
+    uint64_t flags = dc->base.tb->flags;
     uint32_t cflags = tb_cflags(dc->base.tb);
     int cpl = (flags >> HF_CPL_SHIFT) & 3;
     int iopl = (flags >> IOPL_SHIFT) & 3;
-- 
2.55.0


