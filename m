Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E832606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kgmphGB7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jjb9o4SW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHyD-0004y5-33; Fri, 23 Oct 2026 12:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHxw-0004fo-2S
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHxt-0002Z2-JP
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG6CVm2215817
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7UyMttxFzDTGznMWXPCKERdc7dDyFIV3k/y2lVFHpS0=; b=kgmphGB7u7Ths5yV
 zXYInjUMwHcgpQNLFNOOU8872JdFRiZ7kCoHtN4+0sDurW+WvRchctBI7bqP0Ejr
 Y6o+QNUAKvpfX5j5pP7kUSLdZeWKxPn2UJd3d4j/0tnRFCETtweH7y48xTZvq2H9
 8Nt8TlcU5qBVrixZFLPgFH2z/0qLL8QDsKmYR97iNEgc+5WiB/SxISsqS3CHxTBz
 xxZ1bQcSUnlSD/t8cIRrm7I4aQfDKoRBIg8tto+XOsZfOHH14LS0PDCCJNMA2GJE
 RWH+R+1rVYj4KoolakUFEF2WpHQj/S9YszixHAUg2Sj0KA9mZpcJiGPF78s2/Vj4
 Pouuaw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc81fg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ecdc701a2so142969685a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772276; x=1793377076; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7UyMttxFzDTGznMWXPCKERdc7dDyFIV3k/y2lVFHpS0=;
 b=jjb9o4SWXPfqQbpV4Rl+UaxhSFmOs4pldWIjxTefCEzHnH/dFjVQcQJ8JBWxt4pNOo
 b/Hhn7wZw7q+W/9yqa4JPTtQ4DikNXehFoMRsJeUNEc/VsQoOG4mODqJ+ywvX517wJrw
 MC+yTEpOM5y6DVaYkmBxTQzmcuCVzTSw5cXWgL5Uf6xoseNpV3zAU9UlcWeRrVu9AFNA
 +NfDigkU8GyE2kYRbvY7snkKw4kmiO2+rIHDElj71Ap9SpEgIAx/iJ5vwha/nUylvONS
 MQblj9ma2yiMFodGDYof75lCbBKTk4upXOdiAW5X7hnoTChwgSzTnLEB+PTGHWHxu2Cf
 /TbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772276; x=1793377076;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7UyMttxFzDTGznMWXPCKERdc7dDyFIV3k/y2lVFHpS0=;
 b=Lt4FHV75VEkgkQgHGPQNNKrfBta1MCwVVmyiRWsWzYUevPD/HR0pAiGDC4B9HnOg6G
 OrYzhz9S+F8A/gVP8T/DWc2hnQBTCKNEofE/S/XKInqw5hGanaDZvxsmkt4DTS3IbAWw
 cCb4Lim9i7mN8jwCSN8FQSpMno6dvR69mURtOiwFmihXuQMT9Rt8/4HQfu7X5q8f9kNI
 eVmmwPtcAZVw1Q2G71QY0F7ITREQnE4RUSu5NdlG8YfBNLZ2aykgC4MrWPs5IE8Dau2D
 sj1j2TAelSf5IH4Kk3lAXMXGvtKlQnjNQy5FcTX7cnQ+OMgFXsLewFRXtp1/gVoUB67t
 5d8w==
X-Gm-Message-State: AFq9FYJlzkSeJ5LpOZ+bEdwQBAtLwx+2nCHRef82TvmXA2vV02yiL71U
 hn2h9EQAWwSgKyo0xJi77z1Ifo+wjhQpV4J6DEWrsiLtFYk18DfzHLUQgCwPSZXgDmz3c/k5gmJ
 5x4hqzUpZEO69nalGXhxzQNdBy3wlKAbo1Y30Qy0vPQXBquNfwJCiJaIino27dssQDlO8
X-Gm-Gg: AYBFou0r6jr1NGxZH3x6ovUC228LAnSgPdNPf/i4+FNbqKqDu4mYt9oNkzdBXoFG7Kq
 cR8PiDDysvBCNSEFqZF5KRvLM0YdFfl8bxIiMH1fqjAlQv1axNeif43sCDOuFc6+pL7ft9E+c+o
 3JGIYFknJlsHd4MyPjQKW5DoZM/cPY/VJCgntF0fJltTsY/+3u9Df0VTf1MZoSAfoHwzOwJ5DiD
 nXbA9dJO5L/JbhW8laNtV0f0HmAa+C1pKlzoZjPnH6oglYSGvbL4H8dfQwS04/ev/xBfhBJ9s5e
 U//jvyjcn1iiFXo4hf8Q8upRpnGY+jv0SUHrf9ItIKIB1hZw+SiOCgpLb5ywew74GszHYBamAJo
 1D4EZTKywyIZWDVSyei4Td+8COXksr0Nd/JpHbGoB
X-Received: by 2002:a05:620a:6011:b0:93e:d5c1:da58 with SMTP id
 af79cd13be357-93f6fa1057dmr459699885a.79.1792772275927; 
 Fri, 23 Oct 2026 09:17:55 -0700 (PDT)
X-Received: by 2002:a05:620a:6011:b0:93e:d5c1:da58 with SMTP id
 af79cd13be357-93f6fa1057dmr459695985a.79.1792772275434; 
 Fri, 23 Oct 2026 09:17:55 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cdbd2f2sm15270545e9.11.2026.10.23.09.17.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:17:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/83] target/mips: Remove EXCP_LAST, use ARRAY_SIZE(excp_names)
Date: Fri, 23 Oct 2026 18:12:44 +0200
Message-ID: <20261023161332.60153-37-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX7uNBrL7kTU4I
 6iIul+3Zao0Nv9nyYIm1UW+8Zs4odF0R4i+OvaS69p8MK1CUyasqaSvz7NTtA2l5QS9eLfP4ens
 5YRGWnzlWZwjrvw6u7RNYoGD+Fp3UudgDQ8ww0j4zVoF0lu1emksF4JuTm8injM0pJQl3NbBqHB
 9g+Ktcc6qn2SnVyj2fEfdN+hFz6slGxpdXX44lmZGKdR/wjtE/dhq7/v1ATETNF7xP1v8z44aHC
 8LDK+crsMtmIyXcMwaI/lWncgA57koeZNxHXFxi5OaYKmeMQ0Dk0y7wDguIOqoCt2WQerMr10aW
 gUX0+R7DQzPoi+86cYGuXhbY23I/EmZNIuFwBnFp36O53m6TSpdIDTqTLevmxaB/kdWNyYebyHl
 TYb8JQgl52jteAs0J61zSJe0AmU1CSvCG2r9yrjYdbDkA7FzVM6Sd+LRhi5kqQnfQm3sTrBqwv0
 8GoPboumAD9+vAABkEA==
X-Proofpoint-GUID: 1Gof7zYJwWfpdWVhJl_Xm8PHQImowORO
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adb88b4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=p6m5v2aWr9E3IcuUVYgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 1Gof7zYJwWfpdWVhJl_Xm8PHQImowORO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX749cDt9Rg1P7
 HYB+33p0TxbnBwfVaY6gz2eRfFAGuLyyXHxCE1k4KY+vJYWkQEH/4w9aO57YCM3mjYsjtcs3nsc
 9aeTy0QcmB32Aj6kGPh88IlIDAXWWEI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
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

EXCP_LAST was only used to size excp_names[] and to bound-check
mips_exception_name(). Let the table size itself from its
initializers and check the index with ARRAY_SIZE(), so adding an
exception no longer requires updating EXCP_LAST.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-18-philmd@oss.qualcomm.com>
---
 target/mips/cpu.h           | 2 --
 target/mips/tcg/exception.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 32549791a18..5d8b78a70b8 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1347,8 +1347,6 @@ enum {
     EXCP_TLBXI,
     EXCP_TLBRI,
     EXCP_SEMIHOST,
-
-    EXCP_LAST = EXCP_SEMIHOST,
 };
 
 /*
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 630b8b809fa..2f02f9be877 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -88,7 +88,7 @@ void mips_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb)
     env->hflags |= tb->flags & MIPS_HFLAG_BMASK;
 }
 
-static const char * const excp_names[EXCP_LAST + 1] = {
+static const char * const excp_names[] = {
     [EXCP_RESET] = "reset",
     [EXCP_SRESET] = "soft reset",
     [EXCP_DSS] = "debug single step",
@@ -131,7 +131,7 @@ static const char * const excp_names[EXCP_LAST + 1] = {
 
 const char *mips_exception_name(int32_t exception)
 {
-    if (exception < 0 || exception > EXCP_LAST) {
+    if (exception < 0 || exception >= ARRAY_SIZE(excp_names)) {
         return "unknown";
     }
     return excp_names[exception];
-- 
2.55.0


