Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5502DC5DF69
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wua1H-0004Fu-Mg; Thu, 13 Aug 2026 14:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wua0d-000309-Iy
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:18:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wua0X-0002FE-FS
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:18:28 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFU1PA2374722
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JzbDkxS3itZNpjD41FPb0w8HQM5ewTacpZ4P5EQ4taQ=; b=oUWs89iLelCmwkJ/
 Mvy/9ND+MihY70Nc6KbUpVGUUH9SZanld6qEdOQpJfUiGQtpvgJXsY97kAahP9U7
 T3WWqw1+UizKvIh2yYs2Iws+/BuiD9XBdPi+afda9TrNUZB4e+YkX0oNIgwHNW77
 mS7javzGCJevOC5tK8v9B5UrBBHwlYwcWC91pEqAhoxGROveyGYnuXZWuajxpKVv
 +2HCK70OJSYgWWC/3W9/XpardUkR7hPmgN51vo+Ve24lW2eWHPFSpGdX7x9zHy9W
 RGQq8tm2/ultltdt5+qNZghqsn4uQq5TjqTqjHaYGC2iE6+yHoavzZYsM7B5p+ME
 T2CBkw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g14sykxpf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:18:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d8243f1bcso3727731cf.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786645091; x=1787249891; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JzbDkxS3itZNpjD41FPb0w8HQM5ewTacpZ4P5EQ4taQ=;
 b=IEpJMRpGWWYeBP4ghDUJKSEJXU57gilw4/EvNhNPeK0+UyXNV1+BrglSTImAIhX26r
 Is3mguNAyQy7XrsfU62UqQvDMCDYB0ALL4fj54ISFrWdtUHPAapDKMHcPxspoWB9kUhS
 HkybrQZlEYs874soDUGCZ1pdOz5gJS60HJCtBzkNDIyB7rOcg27eVRZiydjH0NLxRD2G
 BTjy0o26+FNVdGei+nUZb2YssXu8gqEYh0wbOCa0aY7miSxQ13WoD3fmonfxf26kagLN
 nil2FfKVqkQ6v+TFsW9krBFpVUPCee9l1MzQF8jOg9WSnuQmmEHR05Aw9Atf1cxzBLFV
 yFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645091; x=1787249891;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JzbDkxS3itZNpjD41FPb0w8HQM5ewTacpZ4P5EQ4taQ=;
 b=O5f+eAVqUVxf2l+Kprx4zLf8klOEWBKDFWqI8cfkBhc36mhTlI5pAkwEJzMv5FxZYr
 6Li68mvoHULyM2ZA6vpM2IlyBgPrJLAFUd2lkbwQ5iOTgzoUmHd0SlVVSvgJv2o8Eg28
 eYXjF2BVEAWpx6ncA0Ni1IdfFTMRkQ0M8r1xbfrOvndR4icqnB49VEmNWI+7dHasso1e
 b1SbVTpFrXlAG+cxiwBjd9BfhGbcHQSZWFp/iXW3vkBlkVuBv9508TTIijoAB/G7gTpS
 VZwMT2C3Wb/qAFV5/FO3M/LJTILEfVHEGxS7i+qb/O8Ptu+TXDL+aOniaAWFC0PhqR0A
 ycdg==
X-Gm-Message-State: AOJu0YzN8dSfJk6yAsd1O0UpbWz5c1RYAcUQLf9od7olPUEsdOZafGGH
 uFEkjPoCJmQI6I6sOBXpFiGas+gpWc/euyezxl/3boJZEKtXjVooaujiZI8Rm/HXps1y3EcQGrE
 yEbKav3XmhaO7eTvnA7s50Vn0YL1i7InrP0gbU36Apiajyp/Oe6OMrN9tA1DD9OgKwA==
X-Gm-Gg: AR+sD10cF9e32DJ3IAd/tofYJr4ieBxn6mPzxv0JmBvaeTIJtusQtN/ItMk0dlwV9b+
 /ZN/LlCBGgCplYaYb8+P9g4/AXqN4rei6SsGGzOVnq4ezt3RWjSlwr/R6CuwCewjvLlHtcBzntX
 qTaZRadA6qYGIV6h36zey1E9kzDQysxPC+PGfeVuCjsO78Sv2Zyd6WFC+Ia6VKLbq0f2vixG2vb
 01TM2LK8hmk61t0VRz9ivMoSmqwZ/qj8IUyetsaCR1gPJ6Hdz0nsWIeV0q2lCzn6Iw1/SeqHegZ
 ulgtaw9XUTzY98boEyfqT2hbgT9FSm+n+vwBfLdk9WzaPmv97HFzLvs2dEv+9X3JjTk6yiZrmYI
 XAm/j9ngpN41WSui/DeCkTw2OS4Tj/LVTQe86Zy5LIA==
X-Received: by 2002:a05:622a:5812:b0:527:7756:3ee9 with SMTP id
 d75a77b69052e-52d748bf7c0mr76996051cf.0.1786645091516; 
 Thu, 13 Aug 2026 11:18:11 -0700 (PDT)
X-Received: by 2002:a05:622a:5812:b0:527:7756:3ee9 with SMTP id
 d75a77b69052e-52d748bf7c0mr76995381cf.0.1786645091089; 
 Thu, 13 Aug 2026 11:18:11 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f1fff25sm1953402f8f.3.2026.08.13.11.18.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Aug 2026 11:18:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 12/16] target/arm/hvf: Move flush_cpu_state() into the inner
 vCPU loop
Date: Thu, 13 Aug 2026 20:16:35 +0200
Message-ID: <20260813181640.6537-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813181640.6537-1-philmd@oss.qualcomm.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZcQt8MVA c=1 sm=1 tr=0 ts=6a7e0a64 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=xMUYw9VpK-qeDZ3ugSsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX6XaO4ltwPoUe
 tEMHEoH3y6j4zlQFjsaN4eZw83ZIJ/H2cjQD7C9x4oSSJebjc4FklFsw3RD9XJJnp6VxumnAJk9
 cD5JYSt3kmX+2MRWzwjJOOclk8qzolvonY2Zu0X6bBJ75KgW68xO+zh2hEu/h/rT1h5ddkEh9kD
 1MwTMLkiVJYLSQQctNVm/LUcBK6cgPmPd7LS1xIwMKDX1wu1QKZiKxuBKiPIWKVCkzYq8oA80d+
 J99L08HnyIX9rnetDvmV+PM9Bs9iagkXudrGI8v5huBzwLrbQpPRFsBNq9W9s6K934RHRrTwaHN
 Lnn8zGS0odBHJIWhcRU27SSvuLczA2oKOczv3MUL5yuER4BEIU3qiuyqDOb21/K4LxjCnheJ+2P
 ovX2UxYoJaTBaK/TIAlZKR5EHTk+bEObzlEe0RmifNfE4c/9fCUEtrxQLcmGc7aMHkZ1N99YzKl
 NE8ifxPQnw/RKFGnbsQ==
X-Proofpoint-ORIG-GUID: RzyV72WYLeX93ocULCcwcK3LQgx1nDEY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX9o6fJHzR8ryb
 IdZMvU3pdYjec9fdn3segKItkiaUnDeBfAeeo43f41EgI9joHuTDv5qk3UWEvwHdgfaWQmLGAfn
 0ZD5+eDA0GzVGBmrm5PQb3YOruw4++0=
X-Proofpoint-GUID: RzyV72WYLeX93ocULCcwcK3LQgx1nDEY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

To ensure the vCPU state is flushed on each inner loop iteration,
move the flush_cpu_state() inside it, right after the interrupt
injection check (catching any interrupt changes from previous loop).

Since flush_cpu_state() uses CPUState::vcpu_dirty field as a lazy
synchronization mechanism, there is no performance penalty if the
cache is clean.

This got missed while refactoring the inner loop in commit 93ac76507.

Fixes: 93ac765076a ("target/arm/hvf: Keep calling hv_vcpu_run() in loop")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 3eeb9f70de4..c14ea54a67f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2598,8 +2598,6 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         }
     }
 
-    flush_cpu_state(cpu);
-
     /* Inner vCPU loop */
     do {
         if (!(cpu->singlestep_flags & SSTEP_NOIRQ) &&
@@ -2607,6 +2605,8 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
             return EXCP_INTERRUPT;
         }
 
+        flush_cpu_state(cpu);
+
         bql_unlock();
         cpu_exec_start(cpu);
         r = hv_vcpu_run(cpu->accel->fd);
-- 
2.53.0


