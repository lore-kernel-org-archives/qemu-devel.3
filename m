Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233BAC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XoP-0002rG-S4; Mon, 07 Sep 2026 07:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Xo7-0002iJ-F7
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:46:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Xo5-0003Fn-LX
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:46:39 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AvLN8496177
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 11:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mSiaHjamEiK
 gBhiTky4VCSqYrt7tGD65LQ7WnvRfMqE=; b=H0759PQ/+6SzNWysfqndYu/QZnI
 pVW0wiSo3mkzj9MOaR0ZBxEkfF0LiE2pvHY2mIIHlVmz+oDKouDzlUL5iowO0BHW
 QArn6Ib0pyjF5JEA6toIsHms1AfMBR50d/N8rHYfouLXkixISdLX1MTtrZTSqZa0
 fOolJ6WSPzEKrTNzTcLxPqqYqP5f1yYdc9yzxPVoWuV0TpMcae8YKzIiqhL1DuyS
 p2ExxXnyucyhBCm9q3GmFRyNFUX3Tjm/6bFdN0CvylTzMSKUjh9LrrGrReeKIKcv
 VQg1aacZ8PAUwpTiA4h/WwYFsSAsWBYatB4Nd1Ci4nhNu5Hph9ZloqXTIZg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghuyk8534-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 11:46:36 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90cc0ed09b5so34574556d6.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788781595; x=1789386395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mSiaHjamEiKgBhiTky4VCSqYrt7tGD65LQ7WnvRfMqE=;
 b=aStNbGx2ZaIxmBGVNFSbY8U7qflVHLOZtPo36bGy6yEjQwIcsnLKYJhhTGzCXHPbkq
 eUFmMzAUF+YxRrb0AQTK29mIu+K9ZpL0Cd5Ery22jb3X3p239Se7MCFd+3THHvYpZ/Me
 Rw4lNSScJojIKWZMUWc1KwHHtXYaCzJIWftyUP/2G5RGMmjO4YvtHY1e3xI8D5cb/37d
 FoTLCHqiwRwwcKYWiI4c59tgfN8EeuJXq9aQw/bWfoSqyFmMN02H9a60IklUlc2kgz07
 FnwpzxbxYzMovoYhDqN4XeOZyDdyjEWOzdF32RrIXF/bYit/5qL842dMoYLZmxrFzjNl
 KUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781595; x=1789386395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mSiaHjamEiKgBhiTky4VCSqYrt7tGD65LQ7WnvRfMqE=;
 b=Ts3X9Fac0iSPOkCJvnXy11st0oGEaaCocaBzCcouWUrBPQiUr9en9iXUWr62wur+5M
 9ymWdxXaHIcjVd9BjBnIi8+PPXAecJMnLllPoIqDtdFpg0PVAAvRJ93RYlRG3pgNGQeu
 qxfkc6qV7Cn3p6jynJyy+o08aaOTLvURvsHnAadQkCKXZj4HKPt+zWma5CLoF3OsX1+E
 zpqdH2xP5+r3vjK3wDA2INsX2UnU8W04FzgaFRXKm/VC1hH9qwQlj5L2M5tmOtgoD1fh
 z03X3EpkKdZElWdpK2fZ1MqI3jfiPc4RxOEHD7xSxxlbljVrc8loGbjp5U23nsX4twJf
 X5gg==
X-Gm-Message-State: AFuF++lYElKP8t0yewVOSQe6B5eRm0B1T0psRmqUW3z7/3WeU7KHFTiD
 S36TUX0xpyHLHPZfH1Jv3GPuiiRZVIIfDIGP2VRSjOkfnLnF9GEKqt1RWO2H2ycEmedi3kV8HQv
 OEtZTDp+piFmOPV7GVIkNDBDOojPOMMI/8C355q50GbqxxJaP3lWWWFW0sxuyVkD7Wg==
X-Gm-Gg: AYBFou2dQabz3Crwsk87hSUORu50dJNgOgjr8AiTmmM3wzyT72d9nd5aKtJZVqy+EG2
 rqD+v8gO9bH/IgFDvxfA9rwVZhJInBuOTnf3iEdUS9jYhVhNyT97Xw/NmJhmbglXkWSPBqThaZx
 q0f3dsq9E8AHUxRcGwvbKHJSGSXnj91J7xfvOzQ6Tkd0CyeYMLOoj/EeJ/IpzB2dMauo8OZJmui
 nIxiO7WqfIcyuGuutLUFATboAnpGQEt89QJqP/eihulEoxfsIPpmjm+u/T4kZutao5t+aRgvWrH
 7uo+Rts5sXmnBewELj1pH7PmCyrMqzI13u9HPtZ1srt8lZP/3lJi/edNdS9EWPZSeeg60jLINfB
 7ypu+5MKOWlvhIKuMYgRSzLUjSHLM8kGLdJ+4
X-Received: by 2002:a05:620a:4802:b0:939:1498:cd55 with SMTP id
 af79cd13be357-9398044b5c7mr2377690585a.36.1788781595268; 
 Mon, 07 Sep 2026 04:46:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4802:b0:939:1498:cd55 with SMTP id
 af79cd13be357-9398044b5c7mr2377684085a.36.1788781594758; 
 Mon, 07 Sep 2026 04:46:34 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040679e13sm89834876d6.26.2026.09.07.04.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:46:34 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v8 4/7] target/riscv: add sdext enter Debug Mode on ebreak
Date: Mon,  7 Sep 2026 08:46:11 -0300
Message-ID: <20260907114615.1609913-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907114615.1609913-1-daniel.barboza@oss.qualcomm.com>
References: <20260907114615.1609913-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEyOSBTYWx0ZWRfXyOWQN5olkc+2
 B/9Jv+qJWOiEGH4AKr+R/zr/d/9f6AaI99gbzKOOD8meXMWalOB9NC/bnBGiM+GtJ5/ZRhTumXo
 Um4HP65QFDF92+WBjX+r5fCXU/pNl2g=
X-Proofpoint-GUID: y9yTHxP22YmANvKyemBEtirjnl1gtq6m
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=6a9ea41c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=xvfqbYfxAAAA:20
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=ITXOtABjXhpKHoTPUzwA:9
 a=OIgjcC2v60KrkQgK7BGD:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: y9yTHxP22YmANvKyemBEtirjnl1gtq6m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEyOSBTYWx0ZWRfXwsNyG0nxPryZ
 7AdqtH1p+PTqoJ/nlKlWnKwXW+Tt8z3Zd7c6Ti55+n+NOkh9g9sKPiPqXbMqdRoLGflsp18tTg3
 uyjCWe7ssZRojIASQNCOUHrOT7iQoAfZ1WHHYXaJtI6OvdyiQ10g4jGRT7MRyVNKMoYJpad4zk9
 vWyV6kcetJnHYgh1qXhMFYJVKtsQkUYosJdfvTpoCg7Y85GzGER62zPCTnM0INRQXY/c8EYW+A/
 rB/TgzLKMjpIlEIDc+Ha2N6G1L0W5IML8DFZ5fB8bjCGn/AWmNEUp0Jsl9VdVotuLn0IifIAHs4
 lDKywWA7xfBhB9JTFOBW3QweliJBPDiGCmzmbzUYjgC6mvCguLF+F/x+lTt6htU2+k3ynOCtrgF
 yTyMPV4owPoxBerM0WCHHnug3CbPxJBOnwHV6h6yfuDjYSbgm1O1Va2PSbEAfS9VkXJuX/tGUJQ
 fXhJAUsiBm0yxo5KoLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Chao Liu <chao.liu.zevorn@gmail.com>

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Route EBREAK via helper_sdext_ebreak. If Sdext is enabled and the
matching dcsr.ebreak* bit is set, enter Debug Mode with cause=ebreak
and stop with EXCP_DEBUG. Otherwise keep the normal breakpoint trap.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/helper.h                         |  1 +
 .../tcg/insn_trans/trans_privileged.c.inc     |  6 ++++
 target/riscv/tcg/op_helper.c                  | 34 +++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b4c47d0738..0d9ae15e3e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -142,6 +142,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
 DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
 DEF_HELPER_1(itrigger_match, void, env)
+DEF_HELPER_2(sdext_ebreak, void, env, tl)
 #endif
 
 /* Hypervisor functions */
diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index 4e57901880..42bf2ffb53 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
@@ -68,9 +68,15 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
         generate_exception(ctx, RISCV_EXCP_SEMIHOST);
     } else {
+#ifndef CONFIG_USER_ONLY
+        gen_update_pc(ctx, 0);
+        gen_helper_sdext_ebreak(tcg_env, tcg_constant_tl(ebreak_addr));
+        ctx->base.is_jmp = DISAS_NORETURN;
+#else
         tcg_gen_st_i64(tcg_constant_i64(ebreak_addr), tcg_env,
                       offsetof(CPURISCVState, badaddr));
         generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
+#endif
     }
     return true;
 }
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 54269efee1..5db4f6aacd 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -489,6 +489,40 @@ target_ulong helper_dret(CPURISCVState *env)
 #endif
 }
 
+void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
+{
+    CPUState *cs = env_cpu(env);
+    bool enter_debug = false;
+
+    if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode) {
+        if (env->virt_enabled) {
+            if (env->priv == PRV_S) {
+                enter_debug = env->dcsr & DCSR_EBREAKVS;
+            } else if (env->priv == PRV_U) {
+                enter_debug = env->dcsr & DCSR_EBREAKVU;
+            }
+        } else {
+            if (env->priv == PRV_M) {
+                enter_debug = env->dcsr & DCSR_EBREAKM;
+            } else if (env->priv == PRV_S) {
+                enter_debug = env->dcsr & DCSR_EBREAKS;
+            } else if (env->priv == PRV_U) {
+                enter_debug = env->dcsr & DCSR_EBREAKU;
+            }
+        }
+    }
+
+    env->badaddr = pc;
+
+    if (enter_debug) {
+        riscv_cpu_enter_debug_mode(env, pc, DCSR_CAUSE_EBREAK);
+        cs->exception_index = EXCP_DEBUG;
+        cpu_loop_exit_restore(cs, GETPC());
+    }
+
+    riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, GETPC());
+}
+
 target_ulong helper_mnret(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
-- 
2.43.0


