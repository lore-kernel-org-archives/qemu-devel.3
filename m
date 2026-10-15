Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD2FCCA462
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT5F-0005To-FF; Thu, 15 Oct 2026 17:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4D-0005AJ-MC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:32:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4C-0002QB-0A
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:32:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3gLL3902249
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Y/M54RMUqx5
 hotV0Hrq8hFEE7C6FuL7WLhOrk37Ftw4=; b=OLmUZr166OgNj7w8qetIu1jYxzV
 RxsiqxBPJsX3oyn11Im0WSVcfUeDcYpgyZmv60X+6/gh4f73ii5wh2FR+nqKKxMM
 NjhrCj8Iv6WONHkXWGbeQmbpMPcCPv+nWohrWbisZ7W56PhBZG4twYKIyvQZUszB
 Ed5uUS/513ulXysKfsSjqdQRoGBf933pUdpGi/zYLb1Ta/8FaEQ43+wQB2xlYuF+
 741CdAsOT6RHeKMBe76rLFoNIIbX2NuBQ7x5v8G7nq/Z//2NeJET6Cl2G0AQEDPH
 9A/mVaLoXP0AcipceUWrr8B38ioCCuFAeYQsYLQNReuSm9UVK2AJWb5JLZg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3serq1t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3aaee1fc104so8197268a91.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099966; x=1792704766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y/M54RMUqx5hotV0Hrq8hFEE7C6FuL7WLhOrk37Ftw4=;
 b=iN7irs3Kjkm2Nu0+fvwwU5t6NO8GVxoY5CYNhUJwM4y5hon85hAeoIxlQY0MeNE44/
 xO56syd4GapVJFf7kaz1S5cGaj6Xbu36tR90wuXgebmw8+CHtBIFuADszY1kpo19dyGG
 6fSVS4Y2hj3pMnhDer4MF9rxt9ATfFrUESLTtNzYYfuXHCMZsUaFyWFDhIVwMWwmZTaI
 JMxu++zRL7P5TJbudGkNf+gsWXCP8ikwwOO376cjaRdG+sqoMvlijblw/nsrpHMD7ape
 QVWvOGU/Y2481mXtuFmayNa1gXRT7x2lN3ewx46A726LtSQ//CKUCW6UidiUrf4D42ED
 jk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099966; x=1792704766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y/M54RMUqx5hotV0Hrq8hFEE7C6FuL7WLhOrk37Ftw4=;
 b=Y4J8i8sVPEOXips9b8uxyOLapY5J5f8MyJk2c1NvQAlQCz+rPGnIjYc72JKzRucnWD
 fi1LGa4Bpf1wo1Hr4Vx0QB2KIM+Z6x8tN5NOz6ql84I/kvWeN9beaq44KOIGE+UQ5glp
 ny+QaQ7kbkcHcnQe9vp6o5M7VQUJ0WOo8fiBCwO7lK0jCFnnlj7D1me9cHRjBY6Q6YCn
 Fdf5gVsfFMcoxFcyi0Fn0PXzXPxaK8flA3i7KcskXbwdVGAg0JMM7ld/JVftp5bbbb6N
 i7ImEp5Agoohg86JyvyEWNb/qsdqE3wKBM2Ck+reOGew/IGcEY/0U5auBx80/cfio2/l
 HG4A==
X-Gm-Message-State: AFq9FYLlvc/uLH9zK+bNOHPZ+GceQgAsH1VXwUl+JsIFOZ3v3JMAUPyr
 6c4VqAct8GiAC50T0aM2oO4o0FjOJLLsjGyGryPUHBi13x08+KqaG1H6YuAEFLZHlSRq7nm3X2v
 VTrDLig+R7eLDexcAqbX+RMwb6c0WdBcCmMcoZCQn0awO8mmvev8HFwDin2YKrqOfiA==
X-Gm-Gg: AYBFou0zNAlDGuAX9XmS2dJpSNVj0jHI9Fi3op4wrIyZo0Eiym/vyLMlUrNJxbVMe8l
 2rCDit7GeeHsr1McCFKrCsYQolHvdBjbX+GNRzSuFZunWa+XxBPB1k6csI1fpu9sVzY79YF497L
 tEh7pTls5tKEHgI7p4J6jQQaf2ACX1iu6+jJ1Pki83f63LGkyba+48sMw+KtEQOBiWcHXXs5ZKd
 kzjpNhodhwkdyAkvmQEpVtDuFbTbuFtOwemgJqK7lEzK/zLDGiVHmykU9E+OxFYKBN2yvYOYGog
 y8kMXQI2crJQkAbVqwrJvFJZfUn22YOeYd+JfDWliVSCDbgUUuYdmq4m+bHJ+kL4miyx1HZVgUe
 j6epY5iAPGdTH4oxKSu+eHlE86WUezu115RnAx3w0tOT5JM1zYy/lvmK8T1ri8u0=
X-Received: by 2002:a17:90b:1a87:b0:3ac:a6a5:5743 with SMTP id
 98e67ed59e1d1-3aca6a55a10mr2513438a91.32.1792099965525; 
 Thu, 15 Oct 2026 14:32:45 -0700 (PDT)
X-Received: by 2002:a17:90b:1a87:b0:3ac:a6a5:5743 with SMTP id
 98e67ed59e1d1-3aca6a55a10mr2513416a91.32.1792099965010; 
 Thu, 15 Oct 2026 14:32:45 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 01/19] hw/core/sysemu-cpu-ops: add get_dump_info
Date: Thu, 15 Oct 2026 21:32:18 +0000
Message-ID: <20261015213236.157767-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PLdh5dH6vNXgmcpv-LctIeUmxJ0HcKkO
X-Proofpoint-GUID: PLdh5dH6vNXgmcpv-LctIeUmxJ0HcKkO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXzCVcv6ZWmJj5
 SWSI1HmXQIH94WGSOjo1eK4byOorebQQEnlmJDME1UzK57/pGyKiHv2vZP6lLePQeaBIzioqynl
 D+m8UadMJBvA3D62u5uBLYV4LFiOsj4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX2M67rPGz9go9
 Qe8rLsYuEtrFDiCE8nraYjH2jYwwh6/7PuClbBNY0DRUX0TidgpGY1NI3362CVyzOuMMWUavZOt
 oCAJ3NRhe8kbfJFxndZ8LuUUbRLWCwkInIK2n7ck+avpuEuOw75cmQOi3uf2Wuc0Ky4Xt3VN4bQ
 74+ZQBjv+y1HfHEhYi+g24go0Tc/pc55mY02MYpSDUtRLr5TVHoCB8KvgZKV7AlurZzkMjuqm77
 1uKD/dczJh0Rmg22UJK5+jbsACZAAy1vnIv5uFz7xK2UVsGLDJrBsY2X2t81xaGfYoV/gpf52ZW
 zlniS5S7eG3WWUEMz5NefrLYFx5g+amDX7UTYv9FI7EBM4NYdMgtas+5ykZQ78sks2UrHbZR4xd
 S0m/UfipK3gPU2uy+i6RIrFH/YU0fY0oxJUTwQjln/UFIXrrqjwnEHkKFuFkvCyI5OZSZVkdV2F
 vdt8o+19esiiA0Ge4IA==
X-Authority-Analysis: v=2.4 cv=Se1i5fRu c=1 sm=1 tr=0 ts=6ad1467e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=s0xbLSvG6KTaNPbiVawA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150085
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This allows a specific cpu to declare its implementation of
get_dump_info, needed by dump.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/sysemu-cpu-ops.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index d125540262d..0b6bb42dc2c 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -11,6 +11,7 @@
 #define SYSTEM_CPU_OPS_H
 
 #include "hw/core/cpu.h"
+#include "system/dump-arch.h"
 
 /*
  * struct SysemuCPUOps: System operations specific to a CPU class
@@ -94,6 +95,12 @@ typedef struct SysemuCPUOps {
      */
     int (*write_elf64_qemunote)(WriteCoreDumpFunction f, CPUState *cpu,
                                 DumpState *s);
+    /**
+     * @get_dump_info: fills @info with the endianness, class and architecture.
+     * Returns 0 on success, or -1 if the guest memory can't be dumped.
+     */
+    int (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
+                         const struct GuestPhysBlockList *guest_phys_blocks);
     /**
      * @internal_is_big_endian: Callback to return %true if a CPU which supports
      * runtime configurable endianness is currently big-endian.
-- 
2.43.0


