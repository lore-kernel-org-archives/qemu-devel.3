Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D95606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KQ1xJn0O;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FGUSegQd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI26-00048j-28; Fri, 23 Oct 2026 12:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI1o-0003oP-OV
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI1l-00034R-V1
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:21:59 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6qu33001100
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2FL0W+f79pWQwOpI6aYfBDDNVTS9hr4EUrQnY0Ni014=; b=KQ1xJn0OpdBBlJ5z
 FdX5X3Wz4bz0Y4d8d/4FXfhrz49rw9Z86g1FkqmhG9mEfNFCorJTXmVTLtsMPv0b
 wOeLLaWnWqzRGCL7pMowMll8BS6BngahtD4xAfKE6rGovxsxcsYK8J1RhCz437t5
 RCvDf7xRPvFxezILuYBjnZFlS9EV19NxP5TeeWr2O6c18jdWjgSJiWRAGC7wS+mn
 ZAaYdk/zf9vhkZ5lKG5dRj5NhvVMyi3SiCp7G9Y+bBVsJjxOE4msIB6qH3ncePrJ
 DfkW7I0ARQ64gvSraIXOx5rMRaUd/7k4TKTviOcLW4B5/xjXzvWR/oLN7snLAXwY
 /c5EZA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn0wf7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:21:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ca9b53afaso321127485a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772515; x=1793377315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2FL0W+f79pWQwOpI6aYfBDDNVTS9hr4EUrQnY0Ni014=;
 b=FGUSegQdF6vqE0qHJVvYcu3dnKvGS+7llEtormq6W0NGmjO9c6WeH5JeanRLofXi+v
 9tmbAhsritpfSBYOL6s5fdZt/tRFJt5zVKOdRLc9y8RfgRCSHy8l23IDhLD0en9PL0TZ
 E+PEb2blqg95NeT8Cd5eT5UidPdTNFQRDvegSOA+cD4aTocDO+EQNCXT4KXNIAr7rC0J
 4Jeusj12I2ELW0ZxTJlU2wdDwryIfAqGAT88hNc7eFesLXWpfpIL9ibqUnrcZqBBTkPD
 vod7d8+XNpicJ7k9B13nVPiQqlKXrJzSK5JBrIqVAAtycrHg0ReK1myky5oHbUCFclDQ
 5n2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772515; x=1793377315;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2FL0W+f79pWQwOpI6aYfBDDNVTS9hr4EUrQnY0Ni014=;
 b=TgsA1El4w+fkQdfVcRniu5FbkpoS3UpAM8JGYL/ZZPctZ+EwVImtyCIHW/AbehzvNm
 dzluhHzO9wT4d9awMjuZAGfeYyrYA+hyFbFpstIqqhePoYBj9MfItwiDYRlFyYGNNw2l
 m/ImU+r+XppmRLvL0TWzInAHKfDm0vw6NfRjOErWFdsb357Lxx9THZrBlByam+Wha9YL
 FyqRWMLrO4IH8MDnGQ2vfofYhYe0Hv4KrZb8/GVsRJuyu0qij2nXh3o2C0Lw3fJttZKL
 8K8s6th/3V8PBvfdKo0LZx0tXEOn1gRZOyThGuOblr7x1wk5NWzM4jUhVIC4XKhfZ/Se
 6TNA==
X-Gm-Message-State: AFq9FYK9VuI7MMmSqWqnpgYaroZ3WoHtqYp5x1qdRU3AqLH7Q6svF7mw
 vce1x63s0uTtZ0Ll2zipTQ1J8o/Esrgvot0xE9SLXl5lGbDe7L3K4eg79zCtdEMeqhFIEClWT1/
 u/fifF7Cj3foXmoeXrEsfx5gWUBGKYckYCOxU8G4J/HC2KqkIaYsesZ47S2eEeYnrQZNa
X-Gm-Gg: AYBFou3RWuHdSdEhPRN+GpRwDB+eypD3u5Y7s9ZfhezEylEabbNpQp4weiyalkAht8f
 cnw0TtX1FTcajpVgCR06IX11EiJqlGagknqMuW/GwnIGVKo2rMGWztHSe3Ko+fRmq74XBgkaYrX
 4DvmBFLjDPcev1OO8ao37Rc/OVG/+fAVzJFRFL8Qp0xWXE3kB04jDDMXRVx3hQtjtZkvH4sP0p4
 /DxQYfT98i/pZg3p5PLA71xzYD4L6Z53a0wdmYj7LNPWQ+5B7KgWaGvnZbuttoNo48QWVCvgOTR
 vbH0JY48poAAbCfsiCuWJQSjSuNcBFq3HYizoIZYLBEgyULmGJskB5C1Rcfly/Vy0ruXdhh2sag
 +wlOMDvold6FI5Xg0JjrlSETL3JzUHDfIvdlmH0Nx
X-Received: by 2002:a05:620a:4515:b0:93f:26d6:d70b with SMTP id
 af79cd13be357-93f6f787243mr517704185a.29.1792772515033; 
 Fri, 23 Oct 2026 09:21:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4515:b0:93f:26d6:d70b with SMTP id
 af79cd13be357-93f6f787243mr517696585a.29.1792772514193; 
 Fri, 23 Oct 2026 09:21:54 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2a92a4444sm16540645e9.5.2026.10.23.09.21.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:21:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 69/83] target/or1k: define and call helpers using HELPER macro
Date: Fri, 23 Oct 2026 18:13:17 +0200
Message-ID: <20261023161332.60153-70-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX9WWGe79ANP9F
 IpbBWHP2AoA1fyh4UqAd4TS/ngyHu8LrDkhf/HyFskHB8t9bdpK7qAYx6tHx9cZ5oBRloDDx/kf
 ZI8xkldP9yki03G2LWu0CwSrJpy+hTFpwHH+OWhkgKhn7pihp433yOof0XGj8ONZU483JUg9/8H
 wuXEonuT/ZblUWwNu83QRdHmEk04PN7Km+M+XnjEiE1JGP8CoFiUsuwrk8JEXFfXkRhOuKQqC3I
 OWWeDjbwSSfnq5vycoMQ1pHSurZeOP4dRElRo4GT7gdIH67LkdZ1keznw+/M2zrn2C3KuuPn1DH
 Y1pnCAxswPfWcgMD58rvtfHlBB+KnoIeY/d+M334QUprkDsEvjK7m3WeC9aDIh7K/UTgCshWfpo
 QH9SlkRWAU5eqjc/SIAXz1AFw9AGD/lJ5qS97nqlu9CWSbmtSiW8SARx1vOKUlWr38x1+6w3b2a
 RWApHp8R/nkwz2yzB9Q==
X-Proofpoint-GUID: 2aXw59U5-xyx60CC7ew5httZ30Z2jEvb
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb89a3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=UVNzukUmG7bquJPxmdsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 2aXw59U5-xyx60CC7ew5httZ30Z2jEvb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX9H2y/BEdeLSE
 cJGlsETyTgQZ+I2EXwpgHUJk6BibCFOu2x9Gk8Hgdr9VMD9kJIKXsVuIbv9kmCPw10U0ENiU+4j
 UliCXyrc50rd86BJYJxQL3Yo+CsDTvA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230064
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20261019212046.149572-11-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/or1k/fpu_helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/or1k/fpu_helper.c b/target/or1k/fpu_helper.c
index e680606d4da..3c2aff64e9a 100644
--- a/target/or1k/fpu_helper.c
+++ b/target/or1k/fpu_helper.c
@@ -114,10 +114,10 @@ uint32_t HELPER(dtos)(CPUOpenRISCState *env, uint64_t val)
 }
 
 #define FLOAT_CALC(name)                                                  \
-uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
+uint64_t HELPER(float_ ## name ## _d)(CPUOpenRISCState *env,              \
                                      uint64_t fdt0, uint64_t fdt1)        \
 { return float64_ ## name(fdt0, fdt1, &env->fp_status); }                 \
-uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
+uint32_t HELPER(float_ ## name ## _s)(CPUOpenRISCState *env,              \
                                      uint32_t fdt0, uint32_t fdt1)        \
 { return float32_ ## name(fdt0, fdt1, &env->fp_status); }
 
@@ -129,7 +129,7 @@ FLOAT_CALC(rem)
 #undef FLOAT_CALC
 
 
-uint64_t helper_float_madd_d(CPUOpenRISCState *env, uint64_t a,
+uint64_t HELPER(float_madd_d)(CPUOpenRISCState *env, uint64_t a,
                              uint64_t b, uint64_t c)
 {
     /* Note that or1ksim doesn't use fused operation.  */
@@ -137,7 +137,7 @@ uint64_t helper_float_madd_d(CPUOpenRISCState *env, uint64_t a,
     return float64_add(a, b, &env->fp_status);
 }
 
-uint32_t helper_float_madd_s(CPUOpenRISCState *env, uint32_t a,
+uint32_t HELPER(float_madd_s)(CPUOpenRISCState *env, uint32_t a,
                              uint32_t b, uint32_t c)
 {
     /* Note that or1ksim doesn't use fused operation.  */
@@ -147,10 +147,10 @@ uint32_t helper_float_madd_s(CPUOpenRISCState *env, uint32_t a,
 
 
 #define FLOAT_CMP(name, impl)                                             \
-uint32_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
+uint32_t HELPER(float_ ## name ## _d)(CPUOpenRISCState *env,              \
                                          uint64_t fdt0, uint64_t fdt1)    \
 { return float64_ ## impl(fdt0, fdt1, &env->fp_status); }                 \
-uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
+uint32_t HELPER(float_ ## name ## _s)(CPUOpenRISCState *env,              \
                                          uint32_t fdt0, uint32_t fdt1)    \
 { return float32_ ## impl(fdt0, fdt1, &env->fp_status); }
 
@@ -161,13 +161,13 @@ FLOAT_CMP(un, unordered_quiet)
 #undef FLOAT_CMP
 
 #define FLOAT_UCMP(name, expr) \
-uint32_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
+uint32_t HELPER(float_ ## name ## _d)(CPUOpenRISCState *env,              \
                                          uint64_t fdt0, uint64_t fdt1)    \
 {                                                                         \
     FloatRelation r = float64_compare_quiet(fdt0, fdt1, &env->fp_status); \
     return expr;                                                          \
 }                                                                         \
-uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
+uint32_t HELPER(float_ ## name ## _s)(CPUOpenRISCState *env,              \
                                          uint32_t fdt0, uint32_t fdt1)    \
 {                                                                         \
     FloatRelation r = float32_compare_quiet(fdt0, fdt1, &env->fp_status); \
-- 
2.55.0


