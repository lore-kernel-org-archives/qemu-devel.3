Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1461606A334
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ltatd94i;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d+5XOuwk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7xK-0006Oz-Ss; Wed, 28 Oct 2026 14:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM7xI-0006OJ-Qj
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:00:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM7xH-0000a5-0v
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:00:56 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SHQBSR2869212
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZJDSzr+T8kkQOuIuaPEa2o+zrT7CPEnTWccX+wTblwM=; b=Ltatd94iiCaO39x9
 OQtSXqKFfl6/ILZVAC3L45qWKnVmQ/c7Kc1iEN6Y+hiUtdZRXDayblhHY1Wa6ovf
 vW55XihL11tvUPKj4w3Fryb+6tE0fPDYd5UnkHczomSFV/zruvuS7SecpMdXJrnH
 wGn91XuCibFeeiOZavOcAzO45ncNYu1O/X+HuOK8TTzKeXExnfkh6aN/2N1l98sq
 n1sKkVJCZDpc+TcgurUAYFyzTGWyfHCgnyRMNjGYwdkBTRwpya1BLu99ti/hWKI3
 LMNh+Or7S8B6nArNzMN9z0W+QoLXF2azYNW+pu9Lz0myoA1PfgKoV2LiK7ZZqJ6u
 Qn72sw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkneur4kb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:00:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f559420f3so110543985a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793210452; x=1793815252; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZJDSzr+T8kkQOuIuaPEa2o+zrT7CPEnTWccX+wTblwM=;
 b=d+5XOuwk3iEzR3iyYD6UlI6jz8oDxW8Lc9QM6e2tgQ5LNyFFCSlnU6NfObq5Uqs2ef
 kKHEFydXPvRgHMD5XdQfCl9Ko931akRSXYW1DVAZZxXdY9evCW2EYvrxuz6RuuwKvKhz
 htuaDttn6MG+dSDqjA6gIMU4wYvj8or1d6I6eLVP8Ph4ti/04JEddEyFfv7kKodeAGB7
 F8oCIAibduaVKUAQomeqPKdpaAubvSsxQ/I9s9dk3YJWyPuT5KnW1Vn6eWEUSeYN0/wy
 prpqHE03jYknz5n+BWDsbdyW7Gyy1+e3XiCHQcRcHzbNRDgwvQaEw8jlpHbZYlkoYn+6
 zQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793210452; x=1793815252;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZJDSzr+T8kkQOuIuaPEa2o+zrT7CPEnTWccX+wTblwM=;
 b=1cpIjSqdgjEco7ZdcvD4W4QdLGvQdgACSjfUeMSHM9I5Ek6zRTDBZBlgXHlyqjYHWn
 tev2Dig220WKq4kciVvlwrCxTSfUmL5qv72sRLnnESWO0i16M2pWfM7ikEX2FimamA8m
 TZt4Ih0x60v6XLha7/20uRGubn9YCqTnU39lDWBi0j8obAGi/grnrA+b9fubAaIXJlaE
 zEOtiaV5mZOjPR6m43CBRW1ZGz3g09oMBZzA6iN5RvCIxgwkzjh7JJhrYLW5c/TnKnMI
 HPJ2kIhFL/oSHX9rK4pOMQJpyG9bkOvRuGnHfn0WCXLqCGaatHzdq1t0AKkR11T1CuNT
 7Eag==
X-Gm-Message-State: AFq9FYJ6MDxiYk954JDNqXkeOiVUQEYXGDGmht3nkw4QfHFIZW+Lu1WH
 ej5rfbsNn3Dciy6Z063Q/PYCv+QACd6ScGS+ERyH74bc5X1d33PDjMqk+DNpE1RogWNslcMZR2R
 Jtq4HH6m9UybSQtnREqHzMxZVDCEYGCjfoe1OK7MO5pREQ2/Yq2IG0in6p9c9vNjSYwln
X-Gm-Gg: AYBFou0FkEP3X5pEnmRQrwkO7wqVGTlLPI7XAtPEb/iKIkTXq7jMIHyq7MMFVTUlBMG
 KBLXDCwfB9W6HeMBrKYAjxfshlqGVObpKr7LTMMVq4GnsKHh5Fpns+Vo2oeSxYVDHeF4/qBYgu8
 F2Mb54GzemChK1c6b/P+PBjCl+3SA8tBOleOW7zUvSwmLYZQ3CFPZmts/Ek8hb624koWIWRk7UT
 i5pocpGVdJkLlU3+s4M6OKSo9DC0E0ZsdEnsWOvxxGC9VqsncKKj3Q31zHTq30v0qOVUoJw5Fh5
 aY1sXve/J8/PaaOAqLy5OOV1eEWJFFcXZpEA01AE2QMxNiPcBJJoYhAaeIgokradcp9QXLP4lHy
 epLzjP1uGKBbejux2R5NnVwbckenO+KsA0S9/Iq1W0WnXLn1EbADGx1c1RcWTMuJWkgyUxPUIZa
 viQWOMl7PU4ZGNw8l/AYSRsQTdJRkS1A==
X-Received: by 2002:a05:620a:1729:b0:93e:4f4c:b380 with SMTP id
 af79cd13be357-944089388e2mr455387285a.10.1793210452155; 
 Wed, 28 Oct 2026 11:00:52 -0700 (PDT)
X-Received: by 2002:a05:620a:1729:b0:93e:4f4c:b380 with SMTP id
 af79cd13be357-944089388e2mr455381985a.10.1793210451643; 
 Wed, 28 Oct 2026 11:00:51 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb851sm25745888f8f.26.2026.10.28.11.00.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 11:00:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 1/5] target/mips: Constify CPUMIPSTLBContext::map_address()
 handlers
Date: Wed, 28 Oct 2026 19:00:35 +0100
Message-ID: <20261028180040.22848-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028180040.22848-1-philmd@oss.qualcomm.com>
References: <20261028180040.22848-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfXw363Npnf4d9S
 um+CXv5u9Z1fsmETGOTo1XRPhJvN9StUTwKXSDuFjzkgUWtV7JA3piT6ouge1UlXFQuORiTRFPx
 pB4tExdK5JeK45XGfb4i8r5aSDXKigWgYGFO14DOckKuibWHyXEw20LmeajRhRanR5R1tTwQzYI
 E0IXWfAxPnxNLfqJf7IjhV5jTmX3CRCvb+S8qxU3m5f6En7hWS9AUQK5J+/S0PmQCKQ0ernXqCF
 oGzYsPmnfNVQWDDvY6rAzUqGp/n8r7r+VE0KWlumjx8hpZFoymBE8abQtrrjv2BzcxUG1eWkzom
 V18sujzKze+oFkt0dZJ0aRsc+uSozfkcqvIl/5BSCKeePSgfDfBy6ZbBpqk932yr+RhxoMGXHu1
 DBENQ+3wtp2+2Um+YIPDXlXA4J+IcCrDta5miHEPBoNAJbxkkMS51oacaZbGYovcYOec3q3Bjzq
 MmdUBYxWUQ/HvecpxQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfXwYUQBGCGGyB0
 1zueQyxH/Zs7D1ycqgglZrl3q7JzcrwIPl/OXMadGIqD+h9+V6nXa0/fc0EmSBa+gdvckA+od+a
 coPktwezNRGkBRTKGGmhX2IC7S5DAKk=
X-Authority-Analysis: v=2.4 cv=LoAHWXdc c=1 sm=1 tr=0 ts=6ae23855 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=mGHmK0apHAD9Fp09lz8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: YE01H1tzhUDrOQQLzLjC6LNWDoiLMx4M
X-Proofpoint-ORIG-GUID: YE01H1tzhUDrOQQLzLjC6LNWDoiLMx4M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

The map_address() handlers only read the CPU state, make
their CPUMIPSState argument const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/internal.h              | 2 +-
 target/mips/tcg/system/tlb_helper.c | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index a302fc0c20bb..177fe5cadaef 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -145,7 +145,7 @@ struct r4k_tlb_t {
 struct CPUMIPSTLBContext {
     uint32_t nb_tlb;
     uint32_t tlb_in_use;
-    int (*map_address)(CPUMIPSState *env, hwaddr *physical, int *prot,
+    int (*map_address)(const CPUMIPSState *env, hwaddr *physical, int *prot,
                        target_ulong address, MMUAccessType access_type);
     void (*helper_tlbwi)(CPUMIPSState *env);
     void (*helper_tlbwr)(CPUMIPSState *env);
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 0ff0c9c87175..976226a548db 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -360,8 +360,9 @@ void HELPER(ginvt)(CPUMIPSState *env, target_ulong arg, uint32_t type)
 }
 
 /* no MMU emulation */
-static int no_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
-                              target_ulong address, MMUAccessType access_type)
+static int no_mmu_map_address(const CPUMIPSState *env, hwaddr *physical,
+                              int *prot, target_ulong address,
+                              MMUAccessType access_type)
 {
     *physical = address;
     *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
@@ -369,7 +370,7 @@ static int no_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
 }
 
 /* fixed mapping MMU emulation */
-static int fixed_mmu_map_address(CPUMIPSState *env, hwaddr *physical,
+static int fixed_mmu_map_address(const CPUMIPSState *env, hwaddr *physical,
                                  int *prot, target_ulong address,
                                  MMUAccessType access_type)
 {
@@ -390,7 +391,7 @@ static int fixed_mmu_map_address(CPUMIPSState *env, hwaddr *physical,
 }
 
 /* MIPS32/MIPS64 R4000-style MMU emulation */
-static int r4k_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
+static int r4k_map_address(const CPUMIPSState *env, hwaddr *physical, int *prot,
                            target_ulong address, MMUAccessType access_type)
 {
     uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
-- 
2.55.0


