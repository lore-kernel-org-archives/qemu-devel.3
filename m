Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E637C5DF7A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzoX-0002CF-KV; Mon, 17 Aug 2026 12:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1wvzoO-0001vV-Bi
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:03:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1wvzoK-0006xB-No
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:03:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HFYwOZ1530602
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 16:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IN5d9diPA+5
 gtrEwQvCPi+67EjQ5+TqAioWBC9q16SA=; b=dWudoXbeTu15o58jemUaNumu6lj
 R0F5zWc5BD8RHQFCRi4n93hlf2hVhyC7ztk+ZwUGAU58I3G0NzErF0FP0cwKZI2b
 zlLfSfU8WEARh02yzHi5aeE6otqMDcAow0iAXjKzPRUMqGkQQrckrJabIicQg2AA
 t4dDmV7xyH2HRwO3aGLRNrVuJUMInucvn17Z6aeyemMIIAA1I1Yxx9XBuLmkKgM5
 2/tvxaBcvIaPmG1EzcgTwtW70rXG37fNg4x8DmzPABa3aD1Wq3TIJUIXf/jwj9cu
 AdHfEaE6I2QWTwOUeNaV9d3b16ft96AYgRbr9i6q67w0dXD7xkDwJBvYoeQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wke258m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 16:03:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84e048a801dso4794105b3a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786982619; x=1787587419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IN5d9diPA+5gtrEwQvCPi+67EjQ5+TqAioWBC9q16SA=;
 b=ihGU1k+icd6mwYq5KgXV4Eae65MaQyKIzUhZGyrUlKTydphWQPf3J8uQ5iXpLwbpPC
 u4Hrucw5smVcBXC3EUQDmIN0d957oEhXrd0CQUuSXZAsWKGNEMxSF1isBNprFTR/xmKC
 g/GcE0fhdn+jcs+S7JPNxQZeyU51SaAOV1Mlf6jAtCTThxJeiACsMuIpfUU3BzCUQyq2
 G0HnL4AdYrry17oaRnbbbhlphXz3Q4iV3nl8SRutuLiLT3OVVFjxPgQMlHhliVFYymUg
 +YPfgRgpPr2ogE+Es2WaDyxjB3izYNgS0U1NlZpaoN7KXHoxNMrr2X+VCib2EssKE+wW
 l01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786982619; x=1787587419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IN5d9diPA+5gtrEwQvCPi+67EjQ5+TqAioWBC9q16SA=;
 b=oZjIDr+gPyj8MoJTE8BSua7d+Hir16cm5PV6JvfBR5AcZywbKpryhyo4OO57DC7chr
 KdrNb636p10WF8Os4O2R3+w/naKbVT1giv2P4dd+CcsrIxMwunf79LMLC/xcGz1rQjFD
 EgHOcS6Jn1cXQvkaPMZLUb5IxdXxcYRN23lYkN4H/8ooL27jdPkzXt31l8JC/jwQU0Jd
 6/5yFZj2L+Zes/6/DS4h4Q4doV30rbGqV6NxC3xcUVoJyh27dqFDY6RRdO0xOHkM3mXS
 4zsbhQBateiABGa/3oI2KhLUtc+1yVqoKmrDgajXUC+1keTZPMcoA7a0z5tgQeDrZS67
 fQVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RphWLouX8FjUlgMVqaVUAnniiEZCiWVmVpFkHMEHOhm4aPfVSKID1y/43fXLUbBUimi+NU9wMA0ZCqH@nongnu.org
X-Gm-Message-State: AOJu0Yz4GsZeNR9RLCIO2oxAokmiRx5gY2JvrYbeLGT4Xst3KacxteSP
 qHptDxlgq2vL6K9PiME7l0B+xzkvfuz08YQtH0wTLSoT7YiDM8IXmSBOJNPTEId4imU6eHw8+/h
 4OsSuekiIHHKy4CweC4JEDwGQC68V2HyKVGZ/RX310JOpPgTaTIOd7rtvkoM0XioNLw==
X-Gm-Gg: AR+sD11hNa+2k27O2vfqqKub6okM+5AkkUh6aQbNHUGfQxFiwduRl4lqhvAJw8C1g7u
 znp4U2jfzMkblH7ADNccSCQw7w63U08QlEjBCaRFQ0gPuCZdUIt/z4Rz6SFUq1k4+8U5hnrBEMT
 YD9wRmEQ5etYMaxYG6ezPEDhr+pFq/I8JlkjfYZ14VJ1xPZtl7FfviyNO9547BI46xTKTiLhLOS
 5tKpgkExSRLONmcSzbiOJ4LWCo8BE+7hGEnRPuUAJq9OKCUoBn1baInIsHAXOHLMC6hp4HSATNA
 TVqnigOctHMbKrREPmHWOq6+sCXNyuuUkuMfziDlv5GbREpWOnpCTxiIgHvfEopbbbdal1zs2Uv
 ocvYEHrPJIGq1LmgvWMEDgb9CLPOb8hc+L3yPrKahNWo1vwQGYQsv1YQ0K4OhH3MZ2xLPOPK99a
 Z+Au15X+Rzb5MzFjOO1I9yI+Mlmw==
X-Received: by 2002:a05:6a00:10cd:b0:847:982e:cca0 with SMTP id
 d2e1a72fcca58-84fde1fd916mr24445359b3a.19.1786982618329; 
 Mon, 17 Aug 2026 09:03:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:10cd:b0:847:982e:cca0 with SMTP id
 d2e1a72fcca58-84fde1fd916mr24445287b3a.19.1786982617735; 
 Mon, 17 Aug 2026 09:03:37 -0700 (PDT)
Received: from hu-mchitale-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-851b6f8c0f6sm545923b3a.39.2026.08.17.09.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:03:37 -0700 (PDT)
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Cc: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [RFC PATCH 2/2] target/riscv: Capture Sspesa sample PC and counter ID
 on overflow
Date: Mon, 17 Aug 2026 21:33:17 +0530
Message-ID: <20260817160321.3313698-3-mayuresh.chitale@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817160321.3313698-1-mayuresh.chitale@oss.qualcomm.com>
References: <20260817160321.3313698-1-mayuresh.chitale@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEyMyBTYWx0ZWRfX7d2Nwr1OjW37
 TDc5wAiF+NDkHRbFpSzjTAxIu8QpJ/5tD/4PHCj3yenKeKbNf72qMwhHrpVQ7GKZ7cOiseEo0ry
 6wT93gP9j57OUrUjR6+U8UEt7i7EVBD5tMxrDj9TFiJQ1MVWJeOWZ2jA52CirL+czKiTnZYSfQd
 XG1z75dbXQnxhvhp90idr75juYcbU8cRhgp2cyj0Rt6MR5Tv3orISxDuTEy9L6B7ykc8H06h46l
 2i548BxrwiG9PvvNGZDMnsoBV4WnAT4nKYqXbRHELv535hwvKOdkbME5YGV/kRmuyFYwtYHLyMo
 pj/OblY7q1v0VhA8qkuBZFlkCrj2w6R8TOBDYLRJWr6p9tbnkiGDUGMYv4PqMyG24cxhEE6l72o
 KCVng9+Yx/3Xsk29W4NiuaHjjdXFHXwRq230WAAwHiy1WiTR7V4qOoO1elbYFw1vVkom8O0FUYl
 lhaGtY58dHaflBR5KWw==
X-Authority-Analysis: v=2.4 cv=QetWeMbv c=1 sm=1 tr=0 ts=6a8330db cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=DHycWIkPxntEYEsfrQ0A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: vvqH8HDF1RGU3CwpQsq6HqmLZ5IiCs10
X-Proofpoint-GUID: vvqH8HDF1RGU3CwpQsq6HqmLZ5IiCs10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEyMyBTYWx0ZWRfXyTxmLSo/AZdV
 C37UxaIqN1ZhguOw9wkUkucEh4oks+f1sUQx8MFcG2o+Nr2dQc2ZRQU07+SlFoYjKhAPZ+9dBab
 Lsk1UxYUdaJNhrJ+dW28rbPJATR7qNQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170123
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mayuresh.chitale@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On a Zihpm counter overflow and with LCOFIP asserted, record the
overflowing counter ID in shpmsdata and arm a capture. When the LCOFI is
actually delivered, the shpmspc register is populated with the address of
the interrupted instruction.
Capturing shpmspc at LCOFI delivery (rather than at overflow time)
ensures the sample PC reflects the correct interrupted instruction.

Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
---
 target/riscv/cpu.h            |  2 ++
 target/riscv/tcg/cpu_helper.c |  6 ++++++
 target/riscv/tcg/csr.c        | 25 +++++++++++++++++++++++++
 target/riscv/tcg/pmu.c        | 27 +++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index fe56a6afd1..36425c3605 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -473,6 +473,8 @@ struct CPUArchState {
     /* Sspesa CSRs */
     target_ulong shpmspc;
     target_ulong shpmsdata;
+    /* Capture shpmspc/shpmsdata only on the first overflow */
+    bool sspesa_capture_pending;
 
     /* Sstc CSRs */
     uint64_t stimecmp;
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d9222652..15af3262ed 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -2255,6 +2255,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         sxlen = 16 << riscv_cpu_sxl(env);
         env->scause = cause | ((target_ulong)async << (sxlen - 1));
         env->sepc = env->pc;
+        /* On LCOFI delivery, latch the sample PC to the interrupted PC. */
+        if (riscv_cpu_cfg(env)->ext_sspesa && env->sspesa_capture_pending) {
+            if (async && cause == IRQ_PMU_OVF) {
+                env->shpmspc = env->pc;
+            }
+        }
         env->stval = tval;
         env->htval = htval;
         env->htinst = tinst;
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index ea49d28aae..e48c954359 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1228,6 +1228,15 @@ static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static bool sspesa_is_captured_ctr(CPURISCVState *env, uint32_t evt_index)
+{
+    if (!riscv_cpu_cfg(env)->ext_sspesa || !env->sspesa_capture_pending) {
+        return false;
+    }
+
+    return (env->shpmsdata & SHPMSDATA_CNTRID) == evt_index;
+}
+
 static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
@@ -1259,6 +1268,14 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
         mhpmevt_val = val & inh_avail_mask;
     }
 
+    /* Enable the sample capture when OF is cleared for the captured counter. */
+    if (sspesa_is_captured_ctr(env, evt_index)) {
+        if ((env->mhpmevent_val[evt_index] & MHPMEVENT_BIT_OF) &&
+            !(mhpmevt_val & MHPMEVENT_BIT_OF)) {
+            env->sspesa_capture_pending = false;
+        }
+    }
+
     env->mhpmevent_val[evt_index] = mhpmevt_val;
     riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
 
@@ -1289,6 +1306,14 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MHPMEVENTH_BIT_VSINH : 0;
 
+    /* Enable the sample capture when OF is cleared for the captured counter. */
+    if (sspesa_is_captured_ctr(env, evt_index)) {
+        if ((env->mhpmevent_val[evt_index] & MHPMEVENT_BIT_OF) &&
+            !((val & inh_avail_mask) & MHPMEVENTH_BIT_OF)) {
+            env->sspesa_capture_pending = false;
+        }
+    }
+
     env->mhpmevent_val[evt_index] = deposit64(env->mhpmevent_val[evt_index],
                                               32, 32, val & inh_avail_mask);
 
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 38ad2737e1..337e255da4 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -147,6 +147,31 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env,
     riscv_pmu_icount_update_priv(env, newpriv, new_virt);
 }
 
+static void riscv_pmu_sspesa_capture(CPURISCVState *env, uint32_t ctr_idx)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!cpu->cfg.ext_sspesa) {
+        return;
+    }
+
+    /*
+     * Only the first overflow updates the sample CSRs. While a capture is
+     * pending, keep the lowest counter ID as required by the spec.
+     */
+    if (env->sspesa_capture_pending) {
+        if ((ctr_idx & SHPMSDATA_CNTRID) <
+            (env->shpmsdata & SHPMSDATA_CNTRID)) {
+            env->shpmsdata = ctr_idx & SHPMSDATA_CNTRID;
+        }
+        return;
+    }
+
+    /* shpmspc is latched later, on LCOFI delivery. */
+    env->shpmsdata = ctr_idx & SHPMSDATA_CNTRID;
+    env->sspesa_capture_pending = true;
+}
+
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
 {
     uint32_t ctr_idx;
@@ -191,6 +216,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
         /* Generate interrupt only if OF bit is clear */
         if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
             env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
+            riscv_pmu_sspesa_capture(env, ctr_idx);
             riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
         }
     } else {
@@ -383,6 +409,7 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
 
     if (cpu->pmu_avail_ctrs & BIT(ctr_idx)) {
         if (pmu_hpmevent_set_of_if_clear(env, ctr_idx)) {
+            riscv_pmu_sspesa_capture(env, ctr_idx);
             riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
         }
     }
-- 
2.43.0


