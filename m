Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B0BCA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBySd-0002mk-8M; Wed, 30 Sep 2026 13:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBySB-00023k-LN
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:50:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByS8-0001Yy-TT
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:50:51 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHfF6V4014411
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 umBn4N/wtIjXHvktox4c/lOAr71sWERl+bXZVsuFbkA=; b=F4ifl9ntNHIfGk3k
 j783wYRyy8QisC9Xj4swXkQHjZgpwko1b7UIfTt2uHfx/LU3zjdtqrlnkVL89nzq
 LDYrolkX8yk8JkrMZ2U4mtRzhn3COsWk3m+nFH83e1IGD4tCcN+lisdero612KRO
 YDFAxk6Ie4je6TyQ7LEaDhev8dJoG8IG5qid+xYklG1gEAR4tYy1WOllxEDTIDC/
 tW218HZp1+TwkIU8yWPiewTPmGxlnBmXXApEramder+tAISaWpgtfElfah7gbUXu
 P8Cd91RwIpK56p0Y/xo7zG8j7sdN7kHkTxYOtFsSGKNqTRMpwRK8Hci3Y2Dvd1aK
 ezXkQQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x27jtbs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:50:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5336778acfeso18334161cf.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790647; x=1791395447; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=umBn4N/wtIjXHvktox4c/lOAr71sWERl+bXZVsuFbkA=;
 b=X0bzxXY/yDmSAPuR8uP35UjddStQozyHxOWieUoHxfGvjEAbtyMtPRkcDeN5vlreSz
 TjIt0EjFHznCKxnwvGOv7ugZEbt/oI/QhEK+9y9by4nSFNBtUgEVTzTTk4iEntGBKlzY
 gcncQULvr3gszI3zgL+Oey8gqHRdLz+ttbIVbwGNunpXx7powaAToBkMyMngmf97dPly
 eM0hbPEKXjWj9A4qbTS9dpwxLrMROyaBA94bMrbbeIksylBZbty/pSBWK4ZRNFRkGd29
 QvDlH2B5EC2Rd8LnKer5covEXvS9X4++NUhgychYZlNjNX5h5EFySMX7IXOapKAN7VLd
 A4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790647; x=1791395447;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=umBn4N/wtIjXHvktox4c/lOAr71sWERl+bXZVsuFbkA=;
 b=Kx1iKke/kHPecRTHLW36i7oEI0HqSuix3G3NyZyH2DNNUNaKqAXpXWzT4s1clxbvIm
 eiQFhduLKhEyZwsVBbwTxmewD5fahHjUTi8bMxKD+eGM4Dq75gQ4Y8rTgjxORWEjDv4/
 X+ekXSJ63R9qByYjTXSsEhojpwVn0B4i6jY2B9WKwFGfejxR7NTAv9kqL55aTzghGnAq
 QiHEM3V+GJLBjYECsRpjj9lp8uytTkJCTNfd235mhLkjgHaJn0NOw7bGkSIxwUH0rINS
 NaGuZpu4AcqGuYcW/38J9IoF0cErDhW2B9/h82sC1Ols7Ng66qEcWYasR1uGBoNt9llJ
 i5Ag==
X-Gm-Message-State: AFuF++kbRSbMk28zJBfF/vcIX/QR5oPnv8YDJfU1CKUB5FjW9E04xSIu
 nBDPg7dVzDZG8YKI63uHfZmcTLiSOM5T+zLH4uwWFNUYhouQlTejs4oqbp7qfTS2egWS+Ukhl57
 E/0eHV6XSPyVPitcu16Sw2Oj+l+vMFb/MWGuofwrmBUgvG8pa9aJXJegJvpARMxAgZQ==
X-Gm-Gg: AYBFou3UCSlH4krkDx1XuIY8ezloC3cqnJpl3ftsMUUaodQcgOKdQ/1XyaGNYXvfwUl
 gYwYBmSi7777WPzPDOuUKPLNNeh+/8GXjvzC2I6Nk3PpAA1Zyj6l83qP+tj4n18OercWybkCc59
 eJBAGD2uylO1wWGXG8JoEYaMmU1wzh9CKBCVdnftFwznm3mzXpzCUn/Vb7GdvgY6CFB1CERhjf7
 6ssOn6GKUzWyA2onS32e1Gmx6EKsMHeRC0AQvIYzuWnDnPCukg1us3IY7ZToMFc6gZt0sV0gP7E
 2kcBAYVl5Yc/H5mSCz/Rk0S6sxFK1bzHNObUq2Hlyrd3O9ZwB1+LHktmE7rAnEn+x507GM7ZRZj
 c2nrjlEYK/d7c/Nhd31GdohHv3rA6sQdAk5lIeIq8
X-Received: by 2002:a05:620a:410f:b0:93a:48a:167 with SMTP id
 af79cd13be357-93ca973260fmr402117185a.39.1790790646769; 
 Wed, 30 Sep 2026 10:50:46 -0700 (PDT)
X-Received: by 2002:a05:620a:410f:b0:93a:48a:167 with SMTP id
 af79cd13be357-93ca973260fmr402111785a.39.1790790646099; 
 Wed, 30 Sep 2026 10:50:46 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068ff6f9sm701644f8f.7.2026.09.30.10.50.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:50:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v4 8/9] accel/tcg: Remove the redundant cpu_exec_halt() hook
Date: Wed, 30 Sep 2026 19:49:44 +0200
Message-ID: <20260930174946.82195-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930174946.82195-1-philmd@oss.qualcomm.com>
References: <20260930174946.82195-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfXxf/oAVU9Apk2
 NAqCsiuy9VucyIgp5ZPXRNcrAkzfWKwdeuDPTievEFlGXQtCUX9S/R0dSNpunV8aw1m/MXY1rS5
 FgeVwjPVGLwVCVDPvV7JFvqfFgmXVvU=
X-Proofpoint-GUID: rhYkOFMInrVMt3b6_FFu5RpablqmMpuY
X-Authority-Analysis: v=2.4 cv=W9GtxhWk c=1 sm=1 tr=0 ts=6abd4bf7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Fma_We6Em7EAR7gKL-MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfXyhS4qgzCUH97
 nWmcETRt2Qo5CT3zjbWJJajX74KHhbDPdHLGM6g1bI6Seh7EWJM6K3jMkdEOuzt0POBuHP9MDhA
 UEYxR7+Xc11/4l9BsH3/By+tYPqIMPIx8GbI+rgVAvBdLVNx+TV34VU2hL4Y3Sn89RUcLxZNSzl
 Yl4cq2R4xS+8NJPtU6cwTEEDI6MfcGLomI+qQPKsYk3dRx3/s6/ttsKl0JpEMuKazte4zneI+Pg
 0raG5Wv4wCOEJivXJY5tSszTEP/kS+44YXF1MKplFrTXM1xJhV9XyLLOugZIeH0+/Yr1XYz5o+v
 5rwa4zx5/cm8rztZUz52pjvjJMqA3YF87DmgEx9BBtu6UH8a6FJXbHqSHMFfmL34MXGnE/55XcZ
 qBj9nXSDOh1qBdCsH8z6TF71vbGJcVLCRK8ijaPrZV8ebWLuIe/s0oMBfXjscTJVypXGodA4lFn
 LWAYz1saNpqdlermwEg==
X-Proofpoint-ORIG-GUID: rhYkOFMInrVMt3b6_FFu5RpablqmMpuY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300071
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

All remaining users of cpu_exec_halt simply alias cpu_has_work().
Call cpu_has_work() directly from the generic halt flow and remove
the redundant hook registrations and interface definition.

Make affected cpu_has_work() helpers private where possible.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h    | 18 ------------------
 target/loongarch/internals.h   |  1 -
 target/riscv/internals.h       |  5 -----
 target/s390x/s390x-internal.h  |  1 -
 accel/tcg/cpu-exec.c           | 23 ++++++++---------------
 target/alpha/cpu.c             |  1 -
 target/avr/cpu.c               |  1 -
 target/hexagon/cpu.c           |  1 -
 target/hppa/cpu.c              |  1 -
 target/loongarch/cpu.c         |  2 +-
 target/loongarch/tcg/tcg_cpu.c |  1 -
 target/m68k/cpu.c              |  1 -
 target/microblaze/cpu.c        |  1 -
 target/mips/cpu.c              |  1 -
 target/or1k/cpu.c              |  1 -
 target/ppc/cpu_init.c          |  1 -
 target/riscv/cpu.c             |  2 +-
 target/riscv/tcg/tcg-cpu.c     |  1 -
 target/rx/cpu.c                |  1 -
 target/s390x/cpu-system.c      |  2 +-
 target/s390x/cpu.c             |  1 -
 target/sh4/cpu.c               |  1 -
 target/sparc/cpu.c             |  1 -
 target/tricore/cpu.c           |  1 -
 target/xtensa/cpu.c            |  1 -
 25 files changed, 11 insertions(+), 60 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 1ee5d3d8bdb..4195a29e1e4 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -187,7 +187,6 @@ struct TCGCPUOps {
      * resume execution from the halted state. This callback performs any
      * necessary target-specific state transitions or synchronization before
      * instruction execution resumes. The caller does not hold the BQL.
-     * Either this callback or @cpu_exec_halt must be provided (but not both).
      */
     void (*leaving_halt)(CPUState *cpu);
     /** @do_interrupt: Callback for interrupt handling.  */
@@ -196,23 +195,6 @@ struct TCGCPUOps {
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
     /** @cpu_exec_reset: Callback for reset in cpu_exec.  */
     void (*cpu_exec_reset)(CPUState *cpu);
-    /**
-     * @cpu_exec_halt: Callback for handling halt in cpu_exec.
-     *
-     * The target CPU should do any special processing here that it needs
-     * to do when the CPU is in the halted state.
-     *
-     * Return true to indicate that the CPU should now leave halt, false
-     * if it should remain in the halted state. (This should generally
-     * be the same value that cpu_has_work() would return.)
-     *
-     * Either @leaving_halt or this method must be provided, but not both.
-     * If the target does not need to
-     * do anything special for halt, the same function used for its
-     * SysemuCPUOps::has_work method can be used here, as they have the
-     * same function signature.
-     */
-    bool (*cpu_exec_halt)(CPUState *cpu);
     /**
      * @tlb_fill_align: Handle a softmmu tlb miss
      * @cpu: cpu context
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index f9a0680fe0f..2e31442453e 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -38,7 +38,6 @@ void cpu_loongarch_timer_cb(void *opaque);
 uint64_t cpu_loongarch_get_timer_counter(CPUTimerState *timer);
 uint64_t cpu_loongarch_get_timer_ticks(CPUTimerState *timer);
 void cpu_loongarch_set_timer_config(CPUTimerState *timer, uint64_t value);
-bool loongarch_cpu_has_work(CPUState *cs);
 bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 5d84e4de960..fb2d8b3e17a 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -201,11 +201,6 @@ static inline target_ulong get_xepc_mask(CPURISCVState *env)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
-/* Our implementation of SysemuCPUOps::has_work */
-bool riscv_cpu_has_work(CPUState *cs);
-#endif
-
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
                                             target_ulong addr,
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index da60b2b1fd4..df1297b5c67 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -248,7 +248,6 @@ bool s390_cpu_system_realize(DeviceState *dev, Error **errp);
 void s390_cpu_finalize(Object *obj);
 void s390_cpu_system_class_init(CPUClass *cc);
 void s390_cpu_machine_reset_cb(void *opaque);
-bool s390_cpu_has_work(CPUState *cs);
 #endif /* CONFIG_USER_ONLY */
 
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 122ad9e2e49..9ead35418d3 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -48,7 +48,6 @@
 #include "internal-common.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "accel/tcg/iommu.h"
-#include "hw/core/sysemu-cpu-ops.h"
 #endif
 
 /* -icount align implementation. */
@@ -661,21 +660,16 @@ static bool cpu_poll_while_halted(CPUState *cpu)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
+    if (tcg_ops->poll_during_halt) {
+        tcg_ops->poll_during_halt(cpu);
+    }
+
+    if (!cpu_has_work(cpu)) {
+        return false;
+    }
+
     if (tcg_ops->leaving_halt) {
-        assert(!tcg_ops->cpu_exec_halt);
-        if (tcg_ops->poll_during_halt) {
-            tcg_ops->poll_during_halt(cpu);
-        }
-        if (!cpu_has_work(cpu)) {
-            return false;
-        }
         tcg_ops->leaving_halt(cpu);
-    } else {
-        assert(!tcg_ops->poll_during_halt);
-        assert(cpu->cc->sysemu_ops->has_work == tcg_ops->cpu_exec_halt);
-        if (!tcg_ops->cpu_exec_halt(cpu)) {
-            return false;
-        }
     }
 
     cpu->halted = 0; /* allow execution */
@@ -1074,7 +1068,6 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         /* Check mandatory TCGCPUOps handlers */
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 #ifndef CONFIG_USER_ONLY
-        assert(tcg_ops->cpu_exec_halt || tcg_ops->leaving_halt);
         assert(tcg_ops->cpu_exec_interrupt);
         assert(tcg_ops->cpu_exec_reset);
         assert(tcg_ops->pointer_wrap);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 12e86021663..7d1d036e1d3 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -265,7 +265,6 @@ static const TCGCPUOps alpha_tcg_ops = {
     .tlb_fill = alpha_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_notreached,
     .cpu_exec_interrupt = alpha_cpu_exec_interrupt,
-    .cpu_exec_halt = alpha_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = alpha_cpu_do_interrupt,
     .do_transaction_failed = alpha_cpu_do_transaction_failed,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index f8409f32ab9..a01e6fa4751 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -246,7 +246,6 @@ static const TCGCPUOps avr_tcg_ops = {
     .restore_state_to_opc = avr_restore_state_to_opc,
     .mmu_index = avr_cpu_mmu_index,
     .cpu_exec_interrupt = avr_cpu_exec_interrupt,
-    .cpu_exec_halt = avr_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .tlb_fill = avr_cpu_tlb_fill,
     .do_interrupt = avr_cpu_do_interrupt,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 1f7d8a8df70..743c9260ef0 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -806,7 +806,6 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .cpu_exec_reset = cpu_reset,
     .tlb_fill = hexagon_tlb_fill,
     .do_unaligned_access = hexagon_cpu_do_unaligned_access,
-    .cpu_exec_halt = hexagon_cpu_has_work,
     .do_interrupt = hexagon_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 07b49e51326..7b1309a7c38 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -270,7 +270,6 @@ static const TCGCPUOps hppa_tcg_ops = {
     .tlb_fill_align = hppa_cpu_tlb_fill_align,
     .pointer_wrap = cpu_pointer_wrap_notreached,
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
-    .cpu_exec_halt = hppa_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = hppa_cpu_do_interrupt,
     .do_unaligned_access = hppa_cpu_do_unaligned_access,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f22f64efb80..6b765797393 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -123,7 +123,7 @@ bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 #endif
 
 #ifndef CONFIG_USER_ONLY
-bool loongarch_cpu_has_work(CPUState *cs)
+static bool loongarch_cpu_has_work(CPUState *cs)
 {
     bool has_work = false;
 
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 4b1d44a1644..7ea2a1eb933 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -327,7 +327,6 @@ const TCGCPUOps loongarch_tcg_ops = {
     .tlb_fill = loongarch_cpu_tlb_fill,
     .pointer_wrap = loongarch_pointer_wrap,
     .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
-    .cpu_exec_halt = loongarch_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = loongarch_cpu_do_interrupt,
     .do_transaction_failed = loongarch_cpu_do_transaction_failed,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9b52ad5fc23..c7771cbf643 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -710,7 +710,6 @@ static const TCGCPUOps m68k_tcg_ops = {
     .tlb_fill = m68k_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
-    .cpu_exec_halt = m68k_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = m68k_cpu_do_interrupt,
     .do_transaction_failed = m68k_cpu_transaction_failed,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 389a5124b12..6013a8def8e 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -448,7 +448,6 @@ static const TCGCPUOps mb_tcg_ops = {
     .tlb_fill = mb_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = mb_cpu_exec_interrupt,
-    .cpu_exec_halt = mb_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = mb_cpu_do_interrupt,
     .do_transaction_failed = mb_cpu_transaction_failed,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0fead20d651..c069aa1c0b7 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -716,7 +716,6 @@ static const TCGCPUOps mips_tcg_ops = {
     .tlb_fill = mips_cpu_tlb_fill,
     .pointer_wrap = mips_pointer_wrap,
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
-    .cpu_exec_halt = mips_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = mips_cpu_do_interrupt,
     .do_transaction_failed = mips_cpu_do_transaction_failed,
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index 66c00c0930c..42d9351b6d7 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -266,7 +266,6 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .tlb_fill = openrisc_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
-    .cpu_exec_halt = openrisc_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = openrisc_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b711f9c0a85..24748e50a20 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7496,7 +7496,6 @@ static const TCGCPUOps ppc_tcg_ops = {
   .tlb_fill = ppc_cpu_tlb_fill,
   .pointer_wrap = ppc_pointer_wrap,
   .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
-  .cpu_exec_halt = ppc_cpu_has_work,
   .cpu_exec_reset = cpu_reset,
   .do_interrupt = ppc_cpu_do_interrupt,
   .cpu_exec_enter = ppc_cpu_exec_enter,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 45e82fc30c5..5c6d638e3bd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -960,7 +960,7 @@ uint64_t riscv_cpu_get_mip(const CPURISCVState *env)
     return qatomic_read(&env->mip);
 }
 
-bool riscv_cpu_has_work(CPUState *cs)
+static bool riscv_cpu_has_work(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b68160af830..260ac6d89e7 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -286,7 +286,6 @@ const TCGCPUOps riscv_tcg_ops = {
     .tlb_fill = riscv_cpu_tlb_fill,
     .pointer_wrap = riscv_pointer_wrap,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
-    .cpu_exec_halt = riscv_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = riscv_cpu_do_interrupt,
     .do_transaction_failed = riscv_cpu_do_transaction_failed,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 9b8473d71cf..69946928995 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -227,7 +227,6 @@ static const TCGCPUOps rx_tcg_ops = {
     .pointer_wrap = cpu_pointer_wrap_uint32,
 
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
-    .cpu_exec_halt = rx_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = rx_cpu_do_interrupt,
 };
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index d963d9e940e..b2b4a7bc963 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -39,7 +39,7 @@
 #include "system/tcg.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
-bool s390_cpu_has_work(CPUState *cs)
+static bool s390_cpu_has_work(CPUState *cs)
 {
     S390CPU *cpu = S390_CPU(cs);
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 85afc5dec9a..e7f81fabff6 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -384,7 +384,6 @@ static const TCGCPUOps s390_tcg_ops = {
     .tlb_fill = s390_cpu_tlb_fill,
     .pointer_wrap = s390_pointer_wrap,
     .cpu_exec_interrupt = s390_cpu_exec_interrupt,
-    .cpu_exec_halt = s390_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = s390_cpu_do_interrupt,
     .debug_excp_handler = s390x_cpu_debug_excp_handler,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 3bbdee301d5..55c73a1da35 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -312,7 +312,6 @@ static const TCGCPUOps superh_tcg_ops = {
     .tlb_fill = superh_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_notreached,
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,
-    .cpu_exec_halt = superh_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = superh_cpu_do_interrupt,
     .do_unaligned_access = superh_cpu_do_unaligned_access,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ae9bdca9df8..1529f9570da 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1074,7 +1074,6 @@ static const TCGCPUOps sparc_tcg_ops = {
     .tlb_fill = sparc_cpu_tlb_fill,
     .pointer_wrap = sparc_pointer_wrap,
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
-    .cpu_exec_halt = sparc_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = sparc_cpu_do_interrupt,
     .do_transaction_failed = sparc_cpu_do_transaction_failed,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 84a05e3d363..82b56c3cd56 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -223,7 +223,6 @@ static const TCGCPUOps tricore_tcg_ops = {
     .tlb_fill = tricore_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
-    .cpu_exec_halt = tricore_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
 };
 
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 7c25b9ab707..99c8bd4b5fb 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -325,7 +325,6 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .tlb_fill = xtensa_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
-    .cpu_exec_halt = xtensa_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = xtensa_cpu_do_interrupt,
     .do_transaction_failed = xtensa_cpu_do_transaction_failed,
-- 
2.55.0


