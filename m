Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A7FC5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wua13-0003nj-4q; Thu, 13 Aug 2026 14:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wua0s-00035A-Fo
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:18:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wua0f-0002Ft-G3
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:18:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DGUt9G2076781
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V1XUkcAOBdCmt+f6LujKVgOfRbrqLf8eqAKYfrk8/gI=; b=K4ShfWpvQbhhvufj
 8t/5NMf0CpYEEoRHoYloXGQt3OB4BRFdi1CWOEZseiPgULp6nL/HLmP1VgNLeNDA
 3Q8Qw3T3K3Ov+oBU+2GmNRI+pYcU+KxxWrV83QEPtw/vxP3dEN44ZsGozWGNeh9u
 0G6aG4sOZzqgyAAnzZb2DHLlZk4Twl2kQVJ8QJ3mD+/43iNcXSaEHtfbkPqQp4eN
 6kMmMxF6zu3JZUPSt6nTbP2F61n4dTRUFccn4E9RVjqnx1vo4Yomm/cNcp8q1RMy
 pGud0v+8ArXD5IHSq1LRVwTDa+QrKPg8uOid70ZnUuP9+Gu+bZcs3BUVLdufiNQq
 7DnBNw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1hgy0fff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:18:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso850881cf.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 11:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786645100; x=1787249900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V1XUkcAOBdCmt+f6LujKVgOfRbrqLf8eqAKYfrk8/gI=;
 b=R5UH/uIoCI1VCGsT3VieFJswwnUqZahjK19zZN1yVOX7LMKnZF2P0A1zeL8hXc8MAb
 znwlm8xJ6u1E7DNTd2K+Nn8rkGpuAwA5XqbQ/I4chywU5jOdyFtkE4FWiNiLeM6/JsnQ
 /KevBvfd+BK4nnIeGorGrP9Xg3Ax5T1X02kEAaBgfKTl1b1aTfCa3kZwV+C9cIKl8AT7
 Ep1qilrSzmWl4Tywu+kxa6mupbmJ6GY0NW4Dim8sRPBpiUuCvc0uzjsIaixImqN5bT87
 8rywqSx8PkO5U7Og8BHJ4Ho6cGc/cGoitm+jYumSjV+wwTU6t9d9XCCh1nDAOxIcCA/X
 g0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645100; x=1787249900;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V1XUkcAOBdCmt+f6LujKVgOfRbrqLf8eqAKYfrk8/gI=;
 b=sqsbKjj91tcmZdJ8jKj53PFFdTq0cGXYgrvCNtcMiswMnEnHAVpjouI/c3+q2AjCba
 QDBBcJ17ZNQ0edifE0WjoR894VL7GZqliMZBA/nz5gWMDxBpeRVlJ2HeURoPWsRB/B2b
 9VPjPUlz8wXcm1t2LFzPGj0VOYnEezbG5mtLeG2xZGa34dKF3gbItktNeDJdQy+z88xw
 jQNQc6G4De+WaMU3SoIYysr5Oc2v3wV+5bu69D2eM48EhF+GIQH7livl1L4OWEmTfk9G
 xizOdM8Rg+V/rW7D5MbqI5Wa+HMOWYDL3NxLxEMUha4bDXYs53JBEx40HPEF+Z9GYjYt
 5kNQ==
X-Gm-Message-State: AOJu0YwUIHO0U5rybjIWDiHFE/20zjCLjKSyctr8MGpgkMRORfMzs3ZS
 iz4EnAvrq+q59wDlaXSIyLum/sLtSrSxNNqo6XQn2m+TfavV44NithTrvccfQx4rUTwkvhJhkC1
 b3yEjMBzkgN05VIyHs5In4RdN6IrsCskLBtyC2o265UXbynOcAcFccjie6sQNmRQSDA==
X-Gm-Gg: AR+sD13qQj3tfIOaZbCVCuxIhRueORti8u55e2miyhjrUF3/0FBIlyagKxMHzqDwg7Z
 tucbN5OjyyJs7rBica/nrUVScJQ0sBv4WtAGcEGhoPvnb/y6qjGcZnNgUVlCyf+ouEaZnUHyZkC
 aEN+9FK+tRFG2DWVNU0AvtTK11dPZW8UjkiNdJ+SvJIox1rijr9cxGjLqNQpRE14mMgWKjpNWSG
 RdtWvrVE4mKY5Ndnu3VPi4yqqg0kjdBzhE3rkQ7+7BsSnu7LDf2AD6HvhZDhD9TCxyh0ZjfnLQK
 0ocPaazN3bbNEs/A1ASpSttZCtUcZ4tHWV1HitVM15V+UhJECNjMNlccPoMg67hzosC8NlaGCTC
 7QKkmD3oZnvYQTUeylHk5wPAJIs+xr/4XBptK58+kNQ==
X-Received: by 2002:ac8:5f95:0:b0:52d:6f91:86e with SMTP id
 d75a77b69052e-52d74b6c8c2mr77157101cf.15.1786645098747; 
 Thu, 13 Aug 2026 11:18:18 -0700 (PDT)
X-Received: by 2002:ac8:5f95:0:b0:52d:6f91:86e with SMTP id
 d75a77b69052e-52d74b6c8c2mr77156511cf.15.1786645098222; 
 Thu, 13 Aug 2026 11:18:18 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2005bcsm1289151f8f.6.2026.08.13.11.18.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Aug 2026 11:18:17 -0700 (PDT)
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
Subject: [PATCH 13/16] target/arm/hvf: Lock BQL outside of the vCPU inner
 execution loop
Date: Thu, 13 Aug 2026 20:16:36 +0200
Message-ID: <20260813181640.6537-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813181640.6537-1-philmd@oss.qualcomm.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXxanI7MUHwlKi
 7s0t6KU10vEvnVpzisE41czh72rC76Lx73G5eeZFMya/4gwsimFsXhkaaTDF4hB7oX/kvzTn6dg
 ksCLd3GnM4yitLcRyEl5zj7ZxedVPcDyTlPH73wVODO+tQenTJMpSMlCxpT5ALWYjR3Wzfll79C
 UccpqrElHYTGvKdNaoqntykRjGN/SzMuL//N/ASvSVzWfdxiP0XczQeN5BVuqljlm31uuReS5eh
 Y4MJ6pI4SS8GAFsM69G+FSxq9skjEWMLhrEvV3fmabORGk8/brDvGE1JQK712NyZcTCtOU6xkos
 t360xKg7+z7EXsjILMSULEEuBfbwuE3D76jzkiJjnXuXsqzhrH6Bd1kxgbFP2c8YX6FkRnmMrVU
 /anpL1Rv55GVUKgSsWj6PAnKEp9nIsjC1IxR61DVoraepNxZnN5nYGl4zUmMe/bqemchDSRJxaY
 lfvzSuFW5gRFhR2Ov2A==
X-Authority-Analysis: v=2.4 cv=AaSB2XXG c=1 sm=1 tr=0 ts=6a7e0a6c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=WxR_XFPUuro4_54D_dQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 9ivjYMRW_tVOF5sbsi71ZQaTbxcWqquO
X-Proofpoint-GUID: 9ivjYMRW_tVOF5sbsi71ZQaTbxcWqquO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXzdZKSbmFR0Gx
 hvMUxYH2KNChuFKurPm3+Se6H1bmepWUTvIj+PqC+cmuSP/LkV72VvyaYl6dlL9Dcq/FNCfv9z+
 dP7NiPEBK6FWoIZPQb/Oh7cUCmZEluw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132
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

Reduce lock contention by acquiring / releasing the BQL
outside of the entire vCPU inner loop.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/hvf/hvf.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c14ea54a67f..9c6408d2e25 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2598,20 +2598,20 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         }
     }
 
+    bql_unlock();
+    cpu_exec_start(cpu);
+
     /* Inner vCPU loop */
     do {
         if (!(cpu->singlestep_flags & SSTEP_NOIRQ) &&
             hvf_inject_interrupts(cpu)) {
-            return EXCP_INTERRUPT;
+            ret = EXCP_INTERRUPT;
+            break;
         }
 
         flush_cpu_state(cpu);
 
-        bql_unlock();
-        cpu_exec_start(cpu);
         r = hv_vcpu_run(cpu->accel->fd);
-        cpu_exec_end(cpu);
-        bql_lock();
         switch (r) {
         case HV_SUCCESS:
             ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
@@ -2624,6 +2624,9 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         }
     } while (ret == 0);
 
+    cpu_exec_end(cpu);
+    bql_lock();
+
     return ret;
 }
 
-- 
2.53.0


