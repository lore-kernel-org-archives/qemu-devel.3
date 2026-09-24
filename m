Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDC8C98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lLW-0004kL-P3; Thu, 24 Sep 2026 11:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lLO-0004EZ-Lz
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:26:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lLM-0000Yy-OO
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:26:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC51OR2595126
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1Yi2Xq8xePL9IFa/hO0y+R8c/Rr6KsL/bzE+yLfsjuk=; b=Suy9Xux7YnEjBxZu
 AK7AUnzfQm3vUMu6BEyKb/eoC6ZgGzHc05Esjh+IXg/BDULep1VUrC/8KTKpaM8J
 1kW59Y9kiNlsJMNVTAKEUPGeOo5WJQMLKmSIFTwAZHSAW2udW5hZB4Fp+zg+LGqA
 kydKJYFw0EwjBg85kP5ijxdY9KCU6+tlBiVGBJjCx86ys8K0SOqKUM8ef+jaHax1
 Fsk09uEtjw3IrDkPq5puVlPvMr5UQDBC6yv6hmcvS50t13T/W7o5xUpK9lFm1BO+
 YcVHGgg1r1tjK2/z7z01KVuSLpc4gCfjWm9/rZHwy5IOwswUgiuAF4iyo+DMf30x
 VirDEQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjh915-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:26:39 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7a532e31dadso2114197137.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263599; x=1790868399; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Yi2Xq8xePL9IFa/hO0y+R8c/Rr6KsL/bzE+yLfsjuk=;
 b=e7kwi148pTqs5FSRQa3iCxRfoCxT5gn5SA387hbGi0xBstcizHL5Onyw7cziyd+Viy
 HJ+Xjh3T955erzp7kQSBuydTStzjB2NJJvxHvcp3D6R/d6o4lO7uOihFTkTOP3V5u04X
 wLgzizwJvABFwxhaN93hrXZMDcg/Jzz8d9gJcjHwZX5u7x+ScTeetwer0D6y1o15JtB4
 NJJKsF/fyylQ+lqq3Z8wCduu5sfih4TnjYICm33nUcVCIxC4Rh85q4mGgnspRbIBUmRE
 vwJzXn5JdMbD5hYYUi7wSuRiAsTInT7CWH/xI66VzDPLC5iklgBDqDMpe/XLIFmTwDyl
 nCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263599; x=1790868399;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Yi2Xq8xePL9IFa/hO0y+R8c/Rr6KsL/bzE+yLfsjuk=;
 b=NilKIyFDWM464ppYVGIHLoH2jSs818DhANhTcCIY2+JcqFKr0WeNanDvmW7bAy3nkR
 Bj3CLOty8inhkHGSR8J8oNp9Vf68AL3I5sJ4mleVGm7Eq2MIpEbvbS9RWJFZjOt/L2vJ
 6lwsscV6DST9MmPkONaXtFJqCvpqZubFh+jF6doWe6hqmPokKTEh4rRz0487JVHRbvac
 s7Rc1M9se/g+UElVRb/HEv8APHPFrl2hJ1Deg8OBomJWF7VXbC2oR5A6cIDLEFFBkLlQ
 ofdFBwq1A9p1/mngAo5hPleMZYWUATaKsxPIzBoFpXMz62wWhK6TJvcM2FnuVlQXZ9jT
 NJRg==
X-Gm-Message-State: AFuF++lD6Fk5KXnO8w6B9xbBJdtxNyCs7zLeiGRfMHVtxGrhs/pDKCD6
 j17ymvS1GWYJfo819qUPknvp2J008rNBLKuKjRc/1mk7qumRyWoNid/soUXOwP9KvMUojp0V1XF
 XD/u6Tc2bFghYiFfJmn0cXzFCT+9+aKhcux/0ZG33zMeita842xMqYFhENQehsY1jmg==
X-Gm-Gg: AYBFou0K+95aIyBhQPGIp+3zg65By7oeneaALGvRUs5C3hXass1dZfUq/WYezA5JR9D
 wxoWTa5ZOhzV87+ka01tp+vW75EjeK1ATqVAtM754KjiGP5ytmQlSGLC+ADh10Tqr0G1MQUTzqG
 oveJOs/8eRVmgbUEbA2mNTRTrNutYUmadUOLZd4IrZsWTE474VM0dkUuobva9M3mrVqdaxDCl+l
 5aV4l8D38Jp4LIpWPyWB4nB6ymv8IfUcjWqblaucn/fULeZWbHNUv1+GyJkSBi1Cbx7FXOLEpEy
 bRiWt0WTBAbr3/HCDZarXwnWjVjAaiaMWOZzbjtFAf8Xqah4h101Pnp21UdUIiCGCYscE7B7Fjz
 ZZOx70ugwWGDAtC7uuKQQFq5gxTdbvlQeLWypUQBb
X-Received: by 2002:a05:6102:3e84:b0:7a7:79c5:d3a7 with SMTP id
 ada2fe7eead31-7af1ce99adcmr1679679137.12.1790263598764; 
 Thu, 24 Sep 2026 08:26:38 -0700 (PDT)
X-Received: by 2002:a05:6102:3e84:b0:7a7:79c5:d3a7 with SMTP id
 ada2fe7eead31-7af1ce99adcmr1679656137.12.1790263598069; 
 Thu, 24 Sep 2026 08:26:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c3731fsm141492695e9.2.2026.09.24.08.26.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:26:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/18] target/ppc: Stop vCPU thread before calling
 parent_unrealize
Date: Thu, 24 Sep 2026 17:23:53 +0200
Message-ID: <20260924152353.36209-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b8rbUwkSFI5LXnBZ-r4kLC-D1bW80-bL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX0MVQrVFI1Aqv
 LCg4hWe5LvT9ZsPIiZ4l0noTWrZStXUvJUlpxyoFKQ8TF13dmBpNL1NjNrewc9vnTC12oLnPE6b
 TtCgfGPenOxTn2Qz7AATRxHfadeAu27Z22/zkZk/XLpCcw8UmRaDxAVxiE0OQP9+CR48HbfcpDa
 JJbY7N9o3jz3lBLF6GIB7DrCO8tocu49/I5xEfb1EKD3G0yUGKiO7r/KnixYKuW8uVrNSi8G3tg
 Q4ozShyiHhjCaZPrXfi2QKhVn4Hj7lDkKmFdo4qopQEKKcUknfEd0IwmtjO0Sos6VI9l0dDIJL4
 SIVQ7NX68jOjmqYYmJ+2wmOQ4OnezuGH0uBtisf2o0cmyNsr+iuW1kGAqWB5mC84s2hvUJ+AYxd
 mHcYjo/Pihs8HfTinZH65h/Ido2qTA03sa+yzg6tT5awmU0hA5fUJciiGPH1zx+NqGT5t85WevA
 4Mg8sctUykvkcvnmNNg==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab5412f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=Mypnz8zva-T9gF3EKnkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: b8rbUwkSFI5LXnBZ-r4kLC-D1bW80-bL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX++4/LNwKcesL
 QYBFNETQ7b0lcaHJmgg7x77FMYnO6HU9I3a//aifexdis41JG1ofbNxzTtmcqoeqB3etqI1k5sv
 MBJPjBfvoXP5mZoXGPZ8NP36FoRHvsk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240063
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

During CPU hot-unplug (e.g. via dynamic reconfiguration unplug),
ppc_cpu_unrealize() invoked pcc->parent_unrealize(dev) before calling
cpu_remove_sync(CPU(cpu)).

pcc->parent_unrealize() calls cpu_common_unrealize(), which triggers
accel_cpu_common_unrealize() -> tcg_exec_unrealizefn() -> tlb_destroy().
This immediately frees the CPU's TLB tables and structures. Because the
vCPU thread had not yet been stopped and joined via cpu_remove_sync(),
the vCPU thread was still actively running its event loop and processing
queued CPU work (such as tcg_commit_cpu / tlb_flush).

This resulted in a race where the running vCPU thread accessed and freed
already-destroyed TLB tables concurrently with tlb_destroy(), leading to
Segfault (due to heap corruption).

AddressSanitizer build reported a double-free:

=================================================================
==121930==ERROR: AddressSanitizer: attempting double-free on 0x7ef8f3438800 in thread T14:
    #0 0x7fe8f74e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
    #1 0x7fe8f6cb8f84 in g_free (/lib64/libglib-2.0.so.0+0x41f84)
    #2 0x558bf6a391b1 in tlb_mmu_resize_locked accel/tcg/cputlb.c:249
    #3 0x558bf6a396b5 in tlb_flush_one_mmuidx_locked accel/tcg/cputlb.c:296
    #4 0x558bf6a39f91 in tlb_flush_by_mmuidx_async_work accel/tcg/cputlb.c:390
    #5 0x558bf6a3a200 in tlb_flush_by_mmuidx accel/tcg/cputlb.c:417
    #6 0x558bf6a3a22a in tlb_flush accel/tcg/cputlb.c:422
    #7 0x558bf73f31ac in tcg_commit_cpu system/physmem.c:3068
    #8 0x558bf6987c55 in process_queued_cpu_work cpu-common.c:378
    #9 0x558bf73a9913 in qemu_process_cpu_events_common system/cpus.c:402
    #10 0x558bf73a9a46 in qemu_process_cpu_events system/cpus.c:421
    #11 0x558bf6a65974 in mttcg_cpu_thread_fn accel/tcg/tcg-accel-ops-mttcg.c:90

0x7ef8f3438800 is located 0 bytes inside of 65536-byte region [0x7ef8f3438800,0x7ef8f3448800)
freed by thread T9 here:
    #0 0x7fe8f74e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
    #1 0x7fe8f6cb8f84 in g_free (/lib64/libglib-2.0.so.0+0x41f84)
    #2 0x558bf6a39a91 in tlb_destroy accel/tcg/cputlb.c:345
    #3 0x558bf6a16354 in tcg_exec_unrealizefn accel/tcg/cpu-exec.c:1094
    #4 0x558bf693d073 in accel_cpu_common_unrealize accel/accel-common.c:117
    #5 0x558bf6980e37 in cpu_common_unrealize hw/core/cpu-common.c:279
    #6 0x558bf6980dfa in cpu_common_unrealizefn hw/core/cpu-common.c:267
    #7 0x558bf763ef65 in ppc_cpu_unrealize target/ppc/cpu_init.c:6965
    #8 0x558bf7872199 in device_set_realized hw/core/qdev.c:618
    #14 0x558bf756068f in spapr_unrealize_vcpu hw/ppc/spapr_cpu_core.c:209

Fix this by moving cpu_remove_sync() before pcc->parent_unrealize(dev)
in ppc_cpu_unrealize(), ensuring the vCPU thread is stopped, has
finished processing its events, and is joined before CPU resources
and accelerator state are destroyed.

Cc: qemu-stable@nongnu.org
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Message-ID: <20260923121444.154175-1-shivangu@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 6c626843c93..b711f9c0a85 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6962,10 +6962,10 @@ static void ppc_cpu_unrealize(DeviceState *dev)
     PowerPCCPU *cpu = POWERPC_CPU(dev);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
-    pcc->parent_unrealize(dev);
-
     cpu_remove_sync(CPU(cpu));
 
+    pcc->parent_unrealize(dev);
+
     destroy_ppc_opcodes(cpu);
 }
 
-- 
2.53.0


