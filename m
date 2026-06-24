Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE49CD4F26
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9x-00086R-0Q; Tue, 23 Jun 2026 20:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9d-0007gJ-Ur
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9c-0003LS-4p
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:45 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NJweHR2295601
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UJ/VuRTDDvOZzIN9WXSG0TT4FVv4DNHGoPKG+8PDOo4=; b=H8YAMXPWQ+JUwj+u
 x01PWQZ+b21hQXdPKvX8bH7Yaw3M6u4ahIFJEHUHM8bVcjtLPtm7FsN92AmfSM0l
 PDaUOLlVJajlETveEVETVe6SNh4+Uk4GFx+KvnaH+yWtARUOuZpmBGRbYBtc6DhN
 +kmduaRhJ9NnMCw9G+8yimWp4k/iE0vebTbOr13ky0gMlPm4EogEDCmMDpwrrLSC
 A9rHB/JlWkQaDv0Ge54WdN16+Tt9Xpn9IqIpg3PdiRWwexrjt40345YXQT9yqNOi
 KxfOCRo1mJ2A6LQYzPOTMpzVNpnwjAFV3GKWdrpaZWtOO4NgdaNE7V357ipV70gj
 J+1U0w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr28u4ku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-519ed1acb05so4281571cf.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259661; x=1782864461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJ/VuRTDDvOZzIN9WXSG0TT4FVv4DNHGoPKG+8PDOo4=;
 b=PklL7oGyPpFnB2b0xFs/LcBIlntTXQXT/4FhUm7Q7HP1ysoxl+uQR/bsI1D3n1+sKf
 IYK4Tzkekvmce+Zhq3EbHOHGjquH3nkNA73I1n+vI6OZ38YEFOsqZOlpVaJdUmA/DgUt
 Tj1TVPWOt+tzjGmlrw+PQMJPA9PqSOLUwfeWQ/mCGi1drq4NPITNWHf0uDOGyc0sCuWG
 xZ2aw2ER+/6xm4kNg3tvkMhJbyoObxLnWn0hLSnkLp62jRpqbjabUU7Zp7mHWrfg+9Eu
 0/5JWheBsmzkwfqO+sqSPPrJEZpWhIWQ5RDMwA0VGDLljyG7GumrMx40x67JrtLaUPlX
 42Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259661; x=1782864461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UJ/VuRTDDvOZzIN9WXSG0TT4FVv4DNHGoPKG+8PDOo4=;
 b=ozQorvXFiRcap+EGs606Pw2p4bQXW4rRUIBqGs6AYyj0619tO/BYg9rYm4jfasqnKv
 V3Pj6Ck77532PBfcB4y6Tqx350anxIeWpBgbm47sHCUFXEso00sR5olSF8CNa3c/23wu
 c32ZKXyAfpPuisVmi0EumW4oEGq9/E3R4Ed0mAkxDxQceWeFVEi2ekvZ2KKzveiizXjF
 +cnb1wVl7enCWtEGE/tcJeP5hVBLM0644J6DyQ8OsZinyj1GgBBRq2qU0It4qZixvneZ
 qsM6vg9kRJb/KgwY+PV+0oaqFtNt7BCUOs3OCVBO8QaLBFJ0dTKc1Tyg1ZmBDBND7eUG
 w59Q==
X-Gm-Message-State: AOJu0YwjETP5Ea9bJclNBWCRvk/Jnsnx8BWc959KHXvwcc3SKxjS++TV
 id/1eIPrTLEuNQDU9JzgHdvmpYSGJPsHPnpnjegq4tIMixwbu4lXRbn6wi44blZeJa//HXCKUbD
 h5kTaqK1wTG+rxDCNBUq9DFauRqHng8V/6KDEOpRhDLCYYIpOgxap/zK10lzAZIWOuA==
X-Gm-Gg: AfdE7clb4sWrs++AiuulYCJkBF5ofJQBinXAAyxhvzIy+g+0YSIUCemlDYdDqO7e0FJ
 MXQgbe8CK2k10hGlH0h3DksEl1b/Ul+I85kvS8heOnKs1szhHkaJte+JhBqIorE82F+w2wAQ/88
 rh4TbnZuSAAAE+XFwZp1QMfFUg1woNS8JmmRdABW9YRd7iyExmyz+7UGXJso8SyGM5IhOc7QaeC
 Y7L4kU1t5MhI/WllmtMl6Hx34qKfjS6Vwb9eel4/XRBcerYITAs+EvylegszoxmQm/BKc9xdIw4
 oQW7BvO/9KuWS3TueDicx9lGDrlUA1bJRpHexqL8tyU+UIjk4gY3PTbQY/aYdZhSjweCtJjwSq6
 fjV3x2VAsxxTXlVcpLFP27VmD60srKicdlV+2YOH+Tz8yvw==
X-Received: by 2002:a05:622a:1aa2:b0:516:ea30:8756 with SMTP id
 d75a77b69052e-51a61bb526cmr21745171cf.36.1782259660598; 
 Tue, 23 Jun 2026 17:07:40 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa2:b0:516:ea30:8756 with SMTP id
 d75a77b69052e-51a61bb526cmr21744401cf.36.1782259659958; 
 Tue, 23 Jun 2026 17:07:39 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:39 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 20/24] target/riscv: move riscv_cpu_set_rdtime_fn to
 riscv_aclint
Date: Tue, 23 Jun 2026 21:06:27 -0300
Message-ID: <20260624000632.2149359-21-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXyE9QFmjhR//J
 /MKC9h02DhMYhpDWfo4s5FYRXyxkTyZQZ3jg6DslLZPkSY8Gh2YoHZmwQjbc/WkkBYv2L5sgFLf
 6S8ayn0Cznf3vq9ZSv2t+eajz+DR3as=
X-Authority-Analysis: v=2.4 cv=b4KCJNGx c=1 sm=1 tr=0 ts=6a3b1fcd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=u0cZ2EjT8PS4VQJ4ig0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: WTPbYQc-fa3HF3AkYN2CIp4xmhXoNdAr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXzgCGwcHd/Xvr
 gIZD4ZaGd+1TSHs0+J5jpig1ExBebgr3Z/rJZAJ9hiQ14mDoo6et+pHX+8SgSeat7h+/0Jvdr5F
 vo5djSMNqi5OBCxyY01ZGEBpAXobARKXZVp2xH4UsYLxJ37gC6rpcEEWr3obOrLStjknOtEYRvE
 K0JNgWJSSbkMEVV+4JD4xGGHwDd9wb2tBNb0aVOPTnoY7Bv4OwO0QOq5ant3g7t8+r+05S3/5QF
 mNnndYsFJVGS3h38zJPCNcTE4P4Xxcv3hQaColL/hpe0xbE6KnHNyxeXwU/xULI0KrHuzLq7ah8
 /dfLvOWqHFyP6cetV47fgfIIuv7vncX7f8CjIxkISrUHX/ZNUhsiXrKKXtkBJkKGA7STgLSJ7vi
 G+X7236vlSc/JbNEo1Wt20gY/jsaQQ==
X-Proofpoint-ORIG-GUID: WTPbYQc-fa3HF3AkYN2CIp4xmhXoNdAr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

There's no need for it to be in cpu_helper since riscv_aclint is the
only caller.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/intc/riscv_aclint.c        | 8 ++++++++
 target/riscv/cpu.h            | 2 --
 target/riscv/tcg/cpu_helper.c | 7 -------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index e27e5fb394..361a8d1bcb 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -40,6 +40,14 @@ typedef struct riscv_aclint_mtimer_callback {
     int num;
 } riscv_aclint_mtimer_callback;
 
+static void riscv_cpu_set_rdtime_fn(CPURISCVState *env,
+                                    uint64_t (*fn)(void *),
+                                    void *arg)
+{
+    env->rdtime_fn = fn;
+    env->rdtime_fn_arg = arg;
+}
+
 static uint64_t cpu_riscv_read_rtc_raw(uint32_t timebase_freq)
 {
     return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 396d9253e6..d6c5d6c1db 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -682,8 +682,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
 void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
-                             void *arg);
 void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
                                    aia_ireg_rmw_fn rmw_fn,
                                    void *rmw_fn_arg);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 9237d2129b..822c9fe483 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -612,13 +612,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
     return old;
 }
 
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
-                             void *arg)
-{
-    env->rdtime_fn = fn;
-    env->rdtime_fn_arg = arg;
-}
-
 void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
                                    aia_ireg_rmw_fn rmw_fn,
                                    void *rmw_fn_arg)
-- 
2.43.0


