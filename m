Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5944AC44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLK1-0002nW-N4; Thu, 16 Jul 2026 08:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLK0-0002nD-8q
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJy-00077M-Hn
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:12 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBiSeo2754573
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ABclx9VxU6T
 JYU/oQ5YMaR1V0j1Xrqljshb3DW4UPkg=; b=RFztDQGDQX3epZZvl81Ys3hhclq
 lc5ANnVzd+rfsLcVPoxlR6ePCeLziUnsv1k+YIEqSanYjPKJLKtkGHW2FHq+nW/i
 Zc4lt/hwIYGkIqw5H/dYYBwr/UtVrXiANNGoqRpraZywh6WMKN2wAc2keBKjfBN3
 44UJsuUb4fFF9R/CwASzLooOnbSx4UDonhaA+OH2eSLIY2gQitIMKcyR4+v0ZPO4
 AEGCrO6b5eH6Jz79sILQUnFn4C3Pfis0yE6HeQNPP2w2/vZMQMevYoSoWIBAqqBe
 yZpLxr4I2GELVojagC3hbfOWQNT9lerrNznel+HGzK4ZKEstSdt0+8mrkdA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu10977c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:09 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8e9b9f30d65so90104356d6.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205369; x=1784810169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ABclx9VxU6TJYU/oQ5YMaR1V0j1Xrqljshb3DW4UPkg=;
 b=MthyCd07Zsq7/+HoWP2GHmJmDcWdu6rFtS9DJwunOnguIQx7/2fg/FmCGtYKgG96nu
 hIIdcJ1Bbpq1mPXGSscDzdEeSAlm5dlYKUIAk/H1pOuQFwjRtOJ2l/OG0eraSezh8Sq+
 JxUHv4/cWgNSuj/ctb/t/njr5peBgdCsX/9cQLSNxHJ3Hfa5wttFSg7CN05x7Nh49IrO
 YVs7ydB+nngUXOV0RCB+GgRkjKWsx/3IpzqLLKZd7Bndjs7XrHZQ6tRdx4K8TFOztEH4
 ryf2QBTzQzWHJz/sp/+oMt6Li6xe5xj471wfnNky4ggdgUY3q95krrwMh8ugoBoeYwrI
 1n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205369; x=1784810169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ABclx9VxU6TJYU/oQ5YMaR1V0j1Xrqljshb3DW4UPkg=;
 b=kvdmWIBSRS9kapBOCEfj1ZjvKjRckINWn9dQmBIbcAHWImhH8CThMsXont0A/JRYvq
 7gOyRsHk3WMVabbWLVWqBgFCEcgT3KMZkXdpXXxFzmaDgkmSfiQJNjLyzEL/I6Yt7dYD
 qv0prcvU8N5HheJ6Rg/B32/DL8wBDYvmSdnncDCJNt8Iu1qx0q5++DwZN1FnFyvDCbPG
 PSQQ7QLPnX+IBb3bLnrl6elsSpVLC3zHNU+YT/HgTP15lUR3MraBdFgyEg5eZCQkboEK
 Tb49oP2mrW2WoZmzc9zopqSvNwfHd/K5mUcAkY68tvMKNZuStdKPck7+ibpwbqmmCPsK
 FBPA==
X-Gm-Message-State: AOJu0YyCh0f0dhUNIUbCBDz7+XoTe7zNalNoqBjlY3thC4U+K0lmFZtB
 hPyaeB399jU8ACyDQe6NBLM3GyHvF0lCIelBWPA6dUx2PtfCEpvN3yuopEm1EI6p9EE3cf70Es5
 paIU1HvvIglu5FxMHSYQlu/DNrad7OK7cmSL/ljN/GH+DOPovHnXUmTrtspyL2Y54Rw==
X-Gm-Gg: AfdE7ckKzgRdEbEOVbhLe9ozj3+/L5RzSn9+lGhHQZ388STZ8Zob0Eyp7cZV6LxFOPO
 wd/qQnCJ4IFsvnpTZcKG+JVQglGauLRl208OpYhDUfFSR/STMBkxvjeyXFYOsmWVZz0xHYjQJzq
 xjVl5B5S1eovLu/6uG4WcZTz9JP1WNGv7XRoQfaMfTjsUA1FX3Bpyv3TtPixE0OWB5XaUL8Jy3+
 uiO0cOnvPYJwufgin/jt4abvbIVp2Lg8v96Tm+67P5BzPd6U7XGY/Wo00Lh2TagrG2FcPXYpsiz
 vFfOQeT1lPouA252CfoOhsKX5JVVW+s+5ujPNyIYyx0wRd7lAgKisK1hKzYB1W0OJd1sgnNqM/1
 ZPAT/bN0o7nDRpoe8+mQzrsek2KJ0q+3nbDs=
X-Received: by 2002:a05:6214:5785:b0:8ef:a9ed:5e9b with SMTP id
 6a1803df08f44-9074c8928f3mr116274036d6.55.1784205368893; 
 Thu, 16 Jul 2026 05:36:08 -0700 (PDT)
X-Received: by 2002:a05:6214:5785:b0:8ef:a9ed:5e9b with SMTP id
 6a1803df08f44-9074c8928f3mr116273566d6.55.1784205368409; 
 Thu, 16 Jul 2026 05:36:08 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:36:07 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 10/17] target/riscv/debug: Fix breakpoint matching
 action
Date: Thu, 16 Jul 2026 09:35:27 -0300
Message-ID: <20260716123535.3709148-11-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jRg_fyVQugx6usbKNyYrZgVpTZEtWY0_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX3vnOW3p9lftd
 yS490SGqJvStVvUrnjd4dnwV7czxMakV8vdtaBUprluK+X3p6uoSorf1O817PZJFNyoqbEewUZZ
 Jc57mTJFgJ4T/reDRSWG2nmqpyfpB5pkfiVcFw5kCU7es95c4Ce8xM1LXkcqBtUrXfib0uTwE8I
 /za/O/S60iluTIN79MXoIgQGabdPCLIVWVcjwZW9eMWFi+PKPPTOE9uLn+SC3aCQUSfiEZc/v0o
 oYSofSsuFFoClI1/t/070B0Yt1mNdv7TX+ilttHlMGAUKpZZGqAWrMHQzxSbJ6VHHf5+bTUfYKk
 33/OtR6K6RaLNzCDVMN5TypTjdtxMui0NZFj7x68P6NRLkvfWpk3zp2WxO5daLB4BRto9OsEZxN
 HUYVDqOCvvAjK6cA6+zDVVymuXi2bVCGeVbnbPzM3DgJisWOczLevmos11kkrE/eJJeUZMy7lOC
 jp6PvVn+UxzLH36xmLA==
X-Proofpoint-GUID: jRg_fyVQugx6usbKNyYrZgVpTZEtWY0_
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a58d039 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=yV3_rp2NExHQcldBhgkA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfXzghpwBReKErr
 v55pr7gzz5fkXXsoMtHqtXTICfSra/unDhCemUopVCQkLhSewJOPUb3PBR9+LopoCK6d+eu6Y9v
 s5hSELUZPm1WM1UOKzJ/3GHMeg0LYhc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Nicholas Piggin <npiggin@gmail.com>

The debug exception callback is too late to find the action for the
trigger(s) which caused it, and it is actually passing the wrong thing
to do_trigger_action(), which expects a trigger index but is given
DBG_ACTION_BP (which will be interpreted as trigger 0 and use the
action set for that trigger).

It could be possible to derive the trigger index from the bp/wp address,
but that is clunky and it is really the action that determines whether
an exception should be raised, also multiple triggers may perform their
actions in the same cycle, so it is more consistent to check action
during the breakpoint matching phase. If a breakpoint exception is to be
taken then that is signaled at that time.

Fixes: d1c111411e ("target/riscv: debug: Create common trigger actions function")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index d98e737763..f671ae67f8 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -282,7 +282,8 @@ static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
     return textra;
 }
 
-static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
+/* Return true if an exception should be raised */
+static bool do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
 {
     trigger_action_t action = get_trigger_action(env, trigger_index);
 
@@ -290,8 +291,7 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
     case DBG_ACTION_NONE:
         break;
     case DBG_ACTION_BP:
-        riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
-        break;
+        return true;
     case DBG_ACTION_DBG_MODE:
     case DBG_ACTION_TRACE0:
     case DBG_ACTION_TRACE1:
@@ -304,6 +304,7 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
     default:
         g_assert_not_reached();
     }
+    return false;
 }
 
 /*
@@ -720,7 +721,9 @@ void helper_itrigger_match(CPURISCVState *env)
         }
         itrigger_set_count(env, i, count--);
         if (!count) {
-            do_trigger_action(env, i);
+            if (do_trigger_action(env, i)) {
+                riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
+            }
         } else {
             enabled = true;
         }
@@ -967,11 +970,11 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
 
     if (cs->watchpoint_hit) {
         if (cs->watchpoint_hit->flags & BP_CPU) {
-            do_trigger_action(env, DBG_ACTION_BP);
+            riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
         }
     } else {
         if (cpu_breakpoint_test(cs, env->pc, BP_CPU)) {
-            do_trigger_action(env, DBG_ACTION_BP);
+            riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
         }
     }
 }
@@ -1008,8 +1011,10 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                 pc = env->tdata2[i];
 
                 if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
-                    env->badaddr = pc;
-                    return true;
+                    if (do_trigger_action(env, i)) {
+                        env->badaddr = pc;
+                        return true;
+                    }
                 }
                 break;
             case TRIGGER_TYPE_AD_MATCH6:
@@ -1017,8 +1022,10 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                 pc = env->tdata2[i];
 
                 if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
-                    env->badaddr = pc;
-                    return true;
+                    if (do_trigger_action(env, i)) {
+                        env->badaddr = pc;
+                        return true;
+                    }
                 }
                 break;
             default:
@@ -1069,7 +1076,9 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
             }
 
             if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                return true;
+                if (do_trigger_action(env, i)) {
+                    return true;
+                }
             }
             break;
         case TRIGGER_TYPE_AD_MATCH6:
@@ -1085,7 +1094,9 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
             }
 
             if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                return true;
+                if (do_trigger_action(env, i)) {
+                    return true;
+                }
             }
             break;
         default:
-- 
2.43.0


