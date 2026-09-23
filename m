Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329BFC9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qau-0002Ox-NE; Wed, 23 Sep 2026 13:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QXw-0006sr-B5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:14:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QXs-0001Qj-RQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:14:16 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTqwk4051893
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lW+1jiRUBpF2NHL9D17Hw5Js0SG7MzZxs3ZLjhXtYFI=; b=iPqV/t7AdrwnPZ+Q
 P4hJxuSTrEhHP5iNgbTlnDpY+1roRzT+n9Sn/IzewNZmXn/rN/tF5V4197F9Mk5c
 VIgqt/TxLfEb8UJyrPR7ldY1+kGKOcNPjxK4kuS1gz0FiUyjjFjY1cuQ9zcQSP0T
 Iy5QbmuzBOO9GYdhc9js1GoUIuVivyGtlhGBVEgxJK9EWuAL4r2AxNTSfx5y7fSa
 0qOfZNWS19H9X63Dwf/NL9d8qU+lL6GlVjY4PZYYJ7Vrm4wf3KF+xMqmVNeEeydC
 sl53VHgzLOPYWX+4bVLSWzdJ5AwCJ2sJlQQj6T32hF8GKvBg6SmHdHB1jV6r9vaE
 wKs6Nw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv78n36tr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:14:00 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-97cb2f3c6f7so283953241.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183640; x=1790788440; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lW+1jiRUBpF2NHL9D17Hw5Js0SG7MzZxs3ZLjhXtYFI=;
 b=SLpVPjjsYCDW0T0EbCzMMNcb0a7gPXzgExi5V6CjhsN2fjVmi8vu8V0iynKIwjMrGL
 EX+NMHjnyUxCcD5q2+i5bxyXsHRVXz1NqhfY1Xm6exB5zsLfbzOA1xgDjl+4k3WOPUoV
 uCE9Y2Fc4x8R8jY028LwqS38kygnr+0cIXWlb2j4WkubQYcdMam3zYSSttY4CEfwkGqU
 qC8KWMr4Zw9+r6JFKoQz1JdFS3bPy98NNBsSDwXF0L9N42YBDuyz8PLUfOT2JYTc36/M
 ATzj8SCnLMiGeOu1oFKWiChXp0+80HEmXAVLCZ9+h7H3VdOPs69HxAuZyub75tz0PXvS
 o8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183640; x=1790788440;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lW+1jiRUBpF2NHL9D17Hw5Js0SG7MzZxs3ZLjhXtYFI=;
 b=1EeVLmam0+J4i9lagqvrirT+gTx3FWGERDln+Sxbb+/4EfNSuufSWnwnwteYZST3uh
 piMOGe6QxF4pG3JX0iipSw31Paz2yId29tgoJjnttcOH+Fx+DWeCnC+Gma7qcaUNn9w5
 63bUQ6/XMjDHiHQY6S24xeH9aBX39bjMcefAhlZmTUfgxAOLPqKB92bJOnjsXS63z326
 EJBhNpgzkkCX8NHuoMILzeYxR1eFH4S75sd/ThcLv2t6Zd43aVJOauolmXXM/TZmTs3n
 OkzP938Tsmj04z61nGsdIAYjpMKpD4+OcTI7wbnoThlyt534oydx0bo+z6/mtlnmFkfs
 L0JQ==
X-Gm-Message-State: AFuF++nmVQdxGgBmB1x32idu06xqywadMeV8W9QgvGMuwpxx68+sUAz9
 Wnxm77oEEmR2Aj+fRom0uXbFzs0SgBXTyoYJaCM2+TbT3/4V1SE4A+swSGSSnSBlsQwUSCrOdHt
 nVCcbDmqY/YS1h9W1JNlaFQwgCicxvMVQbuFO1Kfe+xVtwquLEj4raH4Z5hKBhBARjeq0
X-Gm-Gg: AYBFou3rPMlf/0E4W8mYvMFexuW8gYXSARzkUNMO0iIV1u89XMQGS4W84PEapiFKkSm
 8wlxwSKNXe3AIEk1u5j2s1/10vk0ZGXlKUB+ANGFSjJKwbNnlywqYSJ9ElFzObxfXp/iGrzI+vH
 VncUV/khbGz0/3wElFOY9Sw/5+ec9IIRkfN6tIIN0Ldl2fzvXrqtYmZQNrobDqDyGKDjtUFAnCj
 VN1IBrtFwt3/E/3kuAOJLpz9HbmxImnVI7BpvFi9KauKXP9wZhqzZo2wQvgARHSQTogJjRFUGMW
 3cm0y/ygBf+N4bezxQo8wqqNJRaUSbbjWQu7yJGYhkRrJTid9UzrFUN9uxLBEC37k48KvkY5rE+
 GRrt/Ro4Gv+/VGshOyNW8woFVviJT48U/ZwC5qg0P
X-Received: by 2002:a05:6102:8083:b0:79e:221f:708 with SMTP id
 ada2fe7eead31-7ac1aad3128mr2913360137.5.1790183639640; 
 Wed, 23 Sep 2026 10:13:59 -0700 (PDT)
X-Received: by 2002:a05:6102:8083:b0:79e:221f:708 with SMTP id
 ada2fe7eead31-7ac1aad3128mr2913334137.5.1790183638951; 
 Wed, 23 Sep 2026 10:13:58 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5ded2b7sm235525e9.10.2026.09.23.10.13.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:13:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
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
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 21/21] accel/tcg: Remove the redundant cpu_exec_halt() hook
Date: Wed, 23 Sep 2026 19:11:15 +0200
Message-ID: <20260923171116.31276-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923171116.31276-1-philmd@oss.qualcomm.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX1NbrNYZfFww0
 HTOfnPB9Hmo2F5bD89WHulYJmYy4TK3ttNvanJHHbvSTsSL1ec+NtVUg3Jv5N1yTQ9BVS9599mt
 NsmYSKM/5zJgow+VUprMKzjODSHpXd0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX3ThB/WYhBZW+
 2ZvWbDusRhuYwNhWYX2g6dOdhsTK7FPSKj1cRO4NfZ237ou1TGDJAlWO5XSpHlQrVUsOR+njRJL
 2vYr1IO07WNHVGH99rpXR5A0yqYRd4aMB/bakYwbewN49MO0RoSYqICDZiqFRvvPrNEQPav5em1
 zVFVmp8u2X+64Cj/ImhZhwl2GsBf2AL9BDNoi85Xz6ImPniNE2MDM/0dmem1WJoejjelKOPjiXh
 sBY6mG2fchh6Ecvwgl/FVDfcBAYIqPNjGh06L/ImpmeITiuta7ckaTiSieGtMY4320J8Km+TYkB
 ybccekZ9soy32TaZQP9Imxr5OQMT43+z6lA+57hY6Pw1EYLt5O2c5tfbk2HZ+FRSJtZ6vVriakA
 VQbvl/Z/NC3NAHHB4/kf8xSVWXQsYN+G1zDFCmISrds8BxQqkUSqIPLFBdiJ1aGBcL+Hgji8XQs
 5j7rzaP8LJhWncnKdOA==
X-Proofpoint-ORIG-GUID: NbvAgHd4vcTxI6GvutCRyAzXSq0dpsd4
X-Authority-Analysis: v=2.4 cv=aNFlOr9m c=1 sm=1 tr=0 ts=6ab408d8 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Fma_We6Em7EAR7gKL-MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NbvAgHd4vcTxI6GvutCRyAzXSq0dpsd4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
index edb719b0d10..30a9a8aed42 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -48,7 +48,6 @@
 #include "internal-common.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "accel/tcg/iommu.h"
-#include "hw/core/sysemu-cpu-ops.h"
 #endif
 
 /* -icount align implementation. */
@@ -659,21 +658,16 @@ static bool cpu_poll_while_halted(CPUState *cpu)
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
@@ -1072,7 +1066,6 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
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
index fad526ccfb5..e7defcca8a7 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -783,7 +783,6 @@ static const TCGCPUOps hexagon_tcg_ops = {
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
index 6c626843c93..ef59c56f416 100644
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
index 62ac4507ed5..c0ce7eceb2d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -954,7 +954,7 @@ int riscv_cpu_vsirq_pending(CPURISCVState *env)
                                     (irqs | irqs_f_vs), env->hviprio);
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
index d38de4fea2b..82c89080a17 100644
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
2.53.0


