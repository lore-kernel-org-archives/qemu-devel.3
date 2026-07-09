Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E835BC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 23:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whyGU-0004t8-Ha; Thu, 09 Jul 2026 19:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whyGT-0004sV-GV
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:34:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1whyGR-0007RW-PP
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:34:45 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXdMP2517732
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 23:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IjpFrVnMAdtocIh96Yg8jeTIQ2y8dxQd28EukOf/Rwk=; b=mTNZaBFvrPStb/4w
 pkzt43aUEk1fcuym1HRYGMPER/XLenbggu4ythMS5hwGh6AjIldg4Q5LQrpPP8fZ
 3H171dnMVgLVGPMJ6+AFj/u9dThCF8OwzlFN6jOTYleUSvlXDGGhKUhXdbcLDoxh
 9I9isRnZGZZ+pvsumshcPxmz04SuXWNJhRfuCLAN0eGWI5XfgM1CudPpbpB5+Iej
 Ux+BA5FsT6C1HHhen0CH/NBtO13Pit4mRj/qtKeFhDowRYv/I1G/04+y1R09u25u
 91+54miGdns7FjjbdcT6+G8DTQfJH3y1QxsTSPoQjTe8v/T+0gUdOQTZaEtabAOb
 iBcknw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeessu5w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:34:42 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8478ff5d801so356357b3a.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783640081; x=1784244881; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IjpFrVnMAdtocIh96Yg8jeTIQ2y8dxQd28EukOf/Rwk=;
 b=DKMS2VMv8jJCGqnqun2CW8vbWl4jjd5G6vpNOc6wlSRsBg7ji93Gd1JcG5ONu9woJE
 dhPbZSOohAGnAfFNi5gBByWunrv0OvvfUPx3AMb7kv07v4Eenv3i4lJSrBoKy/VCruXC
 mqmgBg63w0KTDxPskzkdlHd+vNh8WITzi4OpguI7pF3hcf8eyE5luhOrDAbSxYhQqU7m
 8rgHKG6sFjQ6ej+NQQqjqXwsNzFCLU0Pt8RSch42mL15t6S/bR58VZgjuBu1pcRitytB
 QRdJ2KXqjclQAsAglMh9NX1ExmqWHaRqoUditCQ0rsohNc/LIK40foORo9HU+Ac1g0Hb
 EUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783640081; x=1784244881;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IjpFrVnMAdtocIh96Yg8jeTIQ2y8dxQd28EukOf/Rwk=;
 b=ioAEa6jE0iqt9/Xjd+h/udOjmsN/p0fYIi0KxG2fxW3jUM69W7ZclRTKSxm2yyyTYi
 fQithqv8MHdAiRJsNb5jpOykObShB0qkQoip2gS75DHEAan9xGbCqazYeUegKRrSPzKw
 nB2wcbJFjH3SVIigoPg1K1pbUYvRm/hpLaj/XwfhWzf7JU2aoW1it7YWJrRLgwT8wAV2
 s5T0dtciMqRE0ssJONxEt8S20lBUfYkUELz+Lte0RZ8sQCefVuotBFvWmurs3/peb4VJ
 9LvTAGosPu/BAGfHAPUozknBozbIbKlW/DfTFE9cdwYMbIFrQK2D3K0w07bgNZSNL52U
 DPiQ==
X-Gm-Message-State: AOJu0YzBLEti0F33bUSage6G4iGpIMfn04kJq3k++V6zTtAUwrUVaMAb
 l4laXzDIHBRZ1HLpyjWtGxehKvgXmpy+gIa7AsV6SBvp0iBSREYaf8TNbOmrJUYq6UhTC7VHHwe
 hYifPE73Y2xTNQqrfAT+UFzv7SwOaBWMT6Y2wfMCNBWQ1p92vYh/CCI09+ouC2TzMnw==
X-Gm-Gg: AfdE7cmXCu5AHLq9IU5QyToQ7DYyLGS2TKQHAtyItfnN04W4D0nf8TD+1ziK8emN6wZ
 +5VEjle25opSjT5jpOV1aDpVysPPOETQ+gbNlsii0t9ktY4Kx1kvtJRG8fF36HrlNKB0EKge3z/
 OfrTDhgS4ErWG9uFbtgNVpowksZuftm4PfTcZ+QFn4yZL30Nj6JPNqeOpqm2dwu51IUyVOKxYrT
 zQY9seV9I7t6Wjc7d56d2AjnUlb6juS9tNDjlG9+n+lzMW1e5GvFLbWfU6bj1y644qaOIN1aIzE
 FnEtlbuEnO/IslVkMPklRGz6YSukrEqMRO/D757yveYSsGaW1EbpclvteOKiylPQ1pzqvMLpHJ8
 afQ5Kp+iHJe4VndwVYB035tbGayQNILGhNSMvq3Ujip6hKLodO0DQUYPk1eY=
X-Received: by 2002:a05:6a21:1493:b0:3c0:9c1a:893d with SMTP id
 adf61e73a8af0-3c0bccfcf5cmr11148654637.69.1783640081324; 
 Thu, 09 Jul 2026 16:34:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:1493:b0:3c0:9c1a:893d with SMTP id
 adf61e73a8af0-3c0bccfcf5cmr11148636637.69.1783640080908; 
 Thu, 09 Jul 2026 16:34:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm25447189eec.20.2026.07.09.16.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 16:34:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, matheus.bernardino@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>
Subject: [PATCH 2/4] target/hexagon: raise SIGBUS on unaligned scalar stores
Date: Thu,  9 Jul 2026 16:34:34 -0700
Message-Id: <20260709233436.3075100-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
References: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -xerhMpNU6lkTyjQ_mDAlnhJMtarNF8V
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a503012 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=MHlpfT5McVMPhJjrq0IA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIzNSBTYWx0ZWRfX102be1mAK4eD
 ZNo6pvchK/hPMyvF93/T3Ly3Smqi4CGmul0XDalG8bnwpaXoBOvYMiL+kfZfvgoCsKOb/bo6qos
 DdBMrSuWqQlvjp3MFb773wFtPflqP1I=
X-Proofpoint-ORIG-GUID: -xerhMpNU6lkTyjQ_mDAlnhJMtarNF8V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIzNSBTYWx0ZWRfX0Pw8Hp93UV10
 lIi7Cebrlqa84dSOq31PGmd3bKp9Ae+B/BH0sHZXoP1wKD9rQz2oPw1ShZqb6Q3aEL0PAAE4GVr
 Bxf4YcPb7h3TZzPmiNHktEW5hvqReEjxNs2VAeiB4HNWEaeUeA1eHKsU2aOhO8ErblSXnbLudoe
 qOt/22tkUKmyxj9y7hYVnF53HA9D64Rz6/4xlJfMa/3NnjMUjyS2T/8TiVRUGwViubCoTUzlUkA
 olXCebuInaGjm8ORHw6xNvjIFxiiJopO52BbDpYPujRpelRes5QbGl9xSluhJsXOtSuxprzs7Jh
 G1pwv/etKFYRgh6u/26U2wM/L5QyOaYoBXad3+nNiWdMzIWhpeAhkBebsS4GnB4nSI0FQhjuckJ
 XcM1FvxXS7ILVyUd6T7ShJeVF3XC3BvZEYb9bsozLvmSwHeLvrL71Yw3eEZN4tMRWaG3asRdwJc
 CBYwd9cKF6btFFISTQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090235
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

hexagon-linux-user had no enforcement of alignment for scalar store
exceptions, and unaligned stores silently succeeded instead of raising
SIGBUS.

Stores are logged rather than committed immediately, so both commit
paths need the fix.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/genptr.c    |  4 ++--
 target/hexagon/op_helper.c | 13 ++++++++++---
 target/hexagon/translate.c |  6 +++---
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 05c9aa04467..f48a27bc09b 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -495,7 +495,7 @@ static inline void gen_store_conditional4(DisasContext *ctx,
     zero = tcg_constant_tl(0);
     tmp = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(tmp, hex_llsc_addr, hex_llsc_val, src,
-                              ctx->mem_idx, MO_32);
+                              ctx->mem_idx, MO_32 | MO_ALIGN);
     tcg_gen_movcond_tl(TCG_COND_EQ, pred, tmp, hex_llsc_val,
                        one, zero);
     tcg_gen_br(done);
@@ -520,7 +520,7 @@ static inline void gen_store_conditional8(DisasContext *ctx,
     zero = tcg_constant_i64(0);
     tmp = tcg_temp_new_i64();
     tcg_gen_atomic_cmpxchg_i64(tmp, hex_llsc_addr, hex_llsc_val_i64, src,
-                               ctx->mem_idx, MO_64);
+                               ctx->mem_idx, MO_64 | MO_ALIGN);
     tcg_gen_movcond_i64(TCG_COND_EQ, tmp, tmp, hex_llsc_val_i64,
                         one, zero);
     tcg_gen_extrl_i64_i32(pred, tmp);
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 125952aee59..3ce223caba3 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -95,19 +95,26 @@ static void commit_store(CPUHexagonState *env, int slot_num, uintptr_t ra)
 {
     uint32_t width = env->mem_log_stores[slot_num].width;
     target_ulong va = env->mem_log_stores[slot_num].va;
+    MemOpIdx oi;
 
     switch (width) {
     case 1:
         cpu_stb_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
         break;
     case 2:
-        cpu_stw_le_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
+        oi = make_memop_idx(MO_LEUW | MO_ALIGN,
+                            cpu_mmu_index(env_cpu(env), false));
+        cpu_stw_mmu(env, va, env->mem_log_stores[slot_num].data32, oi, ra);
         break;
     case 4:
-        cpu_stl_le_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
+        oi = make_memop_idx(MO_LEUL | MO_ALIGN,
+                            cpu_mmu_index(env_cpu(env), false));
+        cpu_stl_mmu(env, va, env->mem_log_stores[slot_num].data32, oi, ra);
         break;
     case 8:
-        cpu_stq_le_data_ra(env, va, env->mem_log_stores[slot_num].data64, ra);
+        oi = make_memop_idx(MO_LEUQ | MO_ALIGN,
+                            cpu_mmu_index(env_cpu(env), false));
+        cpu_stq_mmu(env, va, env->mem_log_stores[slot_num].data64, oi, ra);
         break;
     default:
         g_assert_not_reached();
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 77235916f4b..5d54ce8caa4 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -896,17 +896,17 @@ void process_store(DisasContext *ctx, int slot_num)
         case 2:
             tcg_gen_qemu_st_tl(hex_store_val32[slot_num],
                                hex_store_addr[slot_num],
-                               ctx->mem_idx, MO_LE | MO_UW);
+                               ctx->mem_idx, MO_LE | MO_UW | MO_ALIGN);
             break;
         case 4:
             tcg_gen_qemu_st_tl(hex_store_val32[slot_num],
                                hex_store_addr[slot_num],
-                               ctx->mem_idx, MO_LE | MO_UL);
+                               ctx->mem_idx, MO_LE | MO_UL | MO_ALIGN);
             break;
         case 8:
             tcg_gen_qemu_st_i64(hex_store_val64[slot_num],
                                 hex_store_addr[slot_num],
-                                ctx->mem_idx, MO_LE | MO_UQ);
+                                ctx->mem_idx, MO_LE | MO_UQ | MO_ALIGN);
             break;
         default:
             {
-- 
2.34.1


