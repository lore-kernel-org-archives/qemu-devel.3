Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ABEC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 01:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjRf0-0000T8-Su; Mon, 13 Jul 2026 21:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjRew-0000OP-By
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 21:10:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjReu-0003jP-4J
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 21:10:05 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DNn7w12872638
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u1L0qjbhwqOPub1Kv1dmD59cH8Hdo74k8BXP/IihYMs=; b=eeYh+bzjkjPkGgZJ
 PdpgScVdK+wLvlK8uKNBIEV47Bw7fn0fmdQLVr6txkWCBY0mKNxV3wi8bsPwp7x1
 V63B+CHQkMaN9oRdNzjyY2J4ZS7XVZSTfq9aBEm/WX4qIkAhQ4shLmIw4e0Co+Wn
 yj2IDmvchsejsBs3mw1BlbfE1cxKg9eP0Dx+XamB46BkO9tlspadIFDcBFLhkGrB
 at47ykqSH+x9R0JsB9S0kOgMb7dWvTVOX2Soj88k5/tANQ8v0N/ik6gIX7XVOuNN
 Gne5+RU4Pa6cOY8E6aRWkp16OGHcqBg3w0DiGcSHV9NZDi43qR+GMeV++c39ldgg
 /NUuQQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44p1bma-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:10:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-848d21bbb55so4677601b3a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783991401; x=1784596201; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u1L0qjbhwqOPub1Kv1dmD59cH8Hdo74k8BXP/IihYMs=;
 b=Ihi7vkwu+WEmYaf7xvsoca/SC/0RryQzzt7KYtAR8yjrQJrbcOMN6VB0T1/flCTXJc
 bXucarwxBRJMGknt3yUxTCt6re04DyYVanQirHdaALhM5SKVcOf3UXK2dL2E3X0+1jFM
 7lTb8hYmA6u2wHB0FRH5mTVVDPdhQoMiKy0ixFw74LDET96xuvUWe63BPsuE+DMMeCDC
 kyHwblbaIpdWHCCwFImmWBcZr+RILjv0Qpm6D2yg0sCLH2uQ+BuKAz+COtnQ47tnetbI
 q97Bxk4M5pYWXrZGBSnWi+NH1gPXDMAu7Lhj/6iPnTcHrCIRPEBhOyiTjJK5G0qzaFkc
 NP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783991401; x=1784596201;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u1L0qjbhwqOPub1Kv1dmD59cH8Hdo74k8BXP/IihYMs=;
 b=JKHVLJ6NQSuRnR/4Xyr69aQt4BECIgmGpZ4iPLioWxj6T5NICa/elUII2LMup5l9ZR
 W7z3rR+9nNQC64/XeD7881bbDg77N7H8vVycvJc8GA4NKOXnZbX1cYIJm65zrg3BvFoR
 pKqNz/ZrYs7um3L4UxWu2W+LpqTkAu/hM/g0xOqlWqGszukZ2dcaeItowapqaSPRvhZa
 ++WWCzHUKPR7KIwr0aJAgrxKRQyG4846SnS7Nrfu6/Nn6Mhc4TH906rkbe04Vwhl1JOS
 X9Q+v65oLKfHr1KTwr9TX/57NTTCK14uLRUhzIHvkr4xP1QZahFP+78qPcdVi+ZKRMh+
 A8yQ==
X-Gm-Message-State: AOJu0Yxyv/R1bSi1TFKhLQPN8nHENeamtELPIJCCXyBHESaYj8uhZjBT
 DI/P4/9UW6m1KhdrTJZ7eP0/AMCUnc2wHPqTuJHHTuLmdYDXJxWwLL7OfbnrcjjCNvi2bnSXDP8
 n6ssnqgxGgdcSl9PMtF8TWekTnfTFxhr5v2MJoL5kiymmpT3D/qTIjCkx5ndGicldUQ==
X-Gm-Gg: AfdE7ckZL0RKW2TdcmmuFgnLnIf5iKPx3yJCxjOGf0hTvFKOP7PFDEjbOmU3Hxt1pWo
 qa9600wQZaCyD/cHzBNwUPzVtuUQeIdLpY3SBjGFY0fCJfa6xj3rf1YrW8m3VUJJh9VGKiqz+7S
 NNoyw1EIzw3M1UgS/uziHeSmINLE/GZJLm7aDnLKBmBHKTIppXLCVEiJ1j48xsPLAROsYKIyYZY
 3uoncCZmP22g7qB/R4oJCGE05tmKMgbn9IWuhBPReKeHQAuhsaaaegjtj6o9PHDXwydIuOUgX9J
 fSH8VL239HcgdLKEMaqKDlAudaALXEbFNBWbIClAkkH4xYw2R9peCDpDb7MioKUlmbMCC4JTnoH
 T81TId3FuXHEOE/oRtqGIj6KQrhiHZDokCOqMvrrEaQKcl9hj27O7rUi/DXM=
X-Received: by 2002:a05:6a21:394a:b0:3a2:ccb5:abc7 with SMTP id
 adf61e73a8af0-3c357314351mr82816637.13.1783991401420; 
 Mon, 13 Jul 2026 18:10:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:394a:b0:3a2:ccb5:abc7 with SMTP id
 adf61e73a8af0-3c357314351mr82779637.13.1783991400962; 
 Mon, 13 Jul 2026 18:10:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174accb0esm76826246eec.30.2026.07.13.18.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 18:10:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, Alessandro Di Federico <ale@rev.ng>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>, philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 3/5] target/hexagon: raise SIGBUS on unaligned scalar stores
Date: Mon, 13 Jul 2026 18:09:53 -0700
Message-Id: <20260714010955.2226493-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714010955.2226493-1-brian.cain@oss.qualcomm.com>
References: <20260714010955.2226493-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwOSBTYWx0ZWRfX5a7B1D3ZEt+t
 8/WAY+akAHuT5A52EUGvaqYDPbRuVMPs95UjtzHQQvOnu478vApap0/W3wypm7LSTfy1fyc2PJu
 +0vVwY8gDHOcJuaOWrAMBdKJpzlZnnM=
X-Proofpoint-GUID: oro6g7hNevZvjEqwWsaKYnQkG3HME9uM
X-Proofpoint-ORIG-GUID: oro6g7hNevZvjEqwWsaKYnQkG3HME9uM
X-Authority-Analysis: v=2.4 cv=BZroFLt2 c=1 sm=1 tr=0 ts=6a558c6a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=MHlpfT5McVMPhJjrq0IA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwOSBTYWx0ZWRfX553bzIRrvzhz
 cVR4QLNPc8d0Ugr1kvQ0qSSIkWhp9CSWL3XJc97UdYYU3PFu/i94wO42PMTYESjPa75cPfg+58V
 5o0nC8ouNoAuZPG2Fq+wDsUNKLyMeNUfkLJE/ZrxNlg48+D9Blp+HpN6kjBEx0K9l9S7BKpXw0v
 1BppsI+CVZRKkQ+2Nxm+mCw3YszIS0++gVhG9kRL0Ah19dPY7GM0vNQ8wM6sZjq+riB/My2JDtr
 pPjQ1Z57M83FSABvyK6csM+JjgM/mUoWnkad2zi1rv2Q3Gh2ik6NH0n2vG++BwuzCEd6OcvGAPR
 KNe8210CtPxXaWxp+VQRLxAtrzgju/Od7IZhNH0o7LldNKyWs6ZFVrXfM5BvWDko/1TxT7h77LL
 FUyqRBRMBf3KVxYTEwfNR4fj5XPVZGxcUYZ3NIuAoCD12YOIrIIyZ7j34+GkZRNy/SJ25le/AKz
 mp9MRyY1hYJRk2SokCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140009
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
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


