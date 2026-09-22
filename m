Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B86BC98307
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93m5-0001UC-Qu; Tue, 22 Sep 2026 12:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93ij-00053g-EN
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:51:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93if-0002ef-R0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:51:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjVf51058317
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VscxCLnI2dGnGBzBwxcHvgdrFWZJrGl9KKZv7JgH7Xc=; b=ChKu6M/nilbqAG88
 +QkAVSbvSgdk2eZaMlAxiP6wj7pmcnXt0SxBm9CJoplqN4uckdAOHlm4kIJinIrB
 5dl5hSICeQzRObkUaMSFvVNEfK5AtoGGMNkgnsZSnFTMn44nn+g+uyfyMuqVnH3h
 DavUOlvggdcNMtfPuZJT5yvFC19bED6WlhFARUDkqzPJe3dKqRTOXy2fpvpUmfo6
 /um6z+QpIlyL3o9zcqiGODYP5dUuFETbyYWs2OvbhTraTORm8cXIWGK7q3t1TRMI
 UwVf0H9Rd50kt1NXT902uqDAqhHyaChx4jwQYz+yLrl2r/rLMDlZUVyeh6GoI1T8
 uWOm8A==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guha5uh15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:51:38 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c9a93f5f3aso57002e0c.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790095898; x=1790700698; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VscxCLnI2dGnGBzBwxcHvgdrFWZJrGl9KKZv7JgH7Xc=;
 b=F0qIQWHwDDwZe3tEssYYcEuZ7apShkN5Wp36yzICzyEPNqLivE82ixPIzLY6JpsXR8
 zjaV7cFMP3brrkx8rzgeta/xtiQzvYeLAmyE35XdijNeHeDu9XL1EBrAgBtEdFh6IPc6
 UfdMrqZ93iQdBLeJCtnb12WgX/djrPg9Y4s6OOtxRrkvAcxOm7oiQfmajzcrI6cbunnd
 WBfBZjxcAbfLyihLKyf3rPStwWYt+XQOJcYBcLxqRAvty6YPrzKVWFZMpT1s4erd61No
 phMZFellbcHT4/AJ9zXJmSFKdBa3lD3KnJFg3BHeVaRVMGxLeWLeXFMFTgrYO+3tQz3z
 FlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095898; x=1790700698;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VscxCLnI2dGnGBzBwxcHvgdrFWZJrGl9KKZv7JgH7Xc=;
 b=lgJSuWSmHDsDYsc2oMtdgnRvEXbY1UrEZxmY6O/70EZzM/3VPsXak7e8E0PUI1Xzsa
 qHp95n+tbAU4pzc/BAqBgjFXvHZjEScm2NzVxM4OsoXDoAA0wS8cLxM5AmE3gxFTUAX7
 U71kXJBJE875XQ9v70LJlqUDjZXRLPlHHcpD/Z0h27vUPkV9xvkVkHMgAIEp9Eg69BVp
 oi6Nz3lOCSRPxxzBypZUkzWsqvEX5bc5SVJkWRMYyToR7ZVD2CyHLRtXinhJJ2nhIl8a
 rKZudRcCLSh1axH55nH6EMf2/KvDy5T09BGxXURDmezDcZCe1SQnOAEPlDC3xIBljKnq
 D//w==
X-Gm-Message-State: AFuF++mbf68ztGpQVBwukquHJIBtx4wN87sheS8BBtSRtxAQuqOrRRsG
 4kdr+hqkej488HfNY2sr4zZj5mBOJ5fV/7bfzrcjJeGp2zir3+ZSw/E6jmPo7r0wWt6FAux7UPQ
 UF+VC/yLJBVLE5/VS9VyhgNxFU1hMUSif10iqqkNHU5r+suWrVz8/d9H+CaLmS/FUzA==
X-Gm-Gg: AYBFou2JAZK6SUOMe7PXFZzWWIom+AwyfSmYiQshYxmoreMdfkO4uidGCmkvQ9nVKAM
 /wdL43+yIEv1xZkvk+ljWajF/U+y78Qqm/INdkkP9+kJuKgQU6ONsM9A+SO0KuONwxjKZaNCYNF
 ata/cSsKvy2oWDydsXyAAI56W9ZCuAUIBGTOFIs8WBFuM6AzZIB6WfJXYACpRKjTrRm5GtVvwly
 4EtkP6fs5HSMHLXgiZD5mM0ndPS3jWpbuQC4GcnSkambzgvS5jOiVpig4itvfU7xhrIXtw7KICb
 Tzr6hiORGE1WXKrAikl4M888kysS3In+rw/Ne0NldlR0KeG2JaP//UosHFjgnaqHpqwYm5ROuhh
 m7T3VtNmfWU+xhi12+TJVCgB2I1RTd2iQWrOnovWG
X-Received: by 2002:a05:6102:8007:b0:7a1:f7d2:e817 with SMTP id
 ada2fe7eead31-7a55ba4d3eemr10035510137.16.1790095898334; 
 Tue, 22 Sep 2026 09:51:38 -0700 (PDT)
X-Received: by 2002:a05:6102:8007:b0:7a1:f7d2:e817 with SMTP id
 ada2fe7eead31-7a55ba4d3eemr10035444137.16.1790095897665; 
 Tue, 22 Sep 2026 09:51:37 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdab0c240sm44540925e9.4.2026.09.22.09.51.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 09:51:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 16/17] target/i386: Use generic halt transition handlers
Date: Tue, 22 Sep 2026 18:49:34 +0200
Message-ID: <20260922164936.15189-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164936.15189-1-philmd@oss.qualcomm.com>
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: otHy111Hko3tjK0Tziu3oRKXcZDIXU79
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX02m3YDW/mvwt
 tovuUUPu/W0WQVR5lJZihI+UodGcNy4tP1xCQygvO50Bc8z08oVQE/ba4Z0UE3RAniIMb82RW2Y
 CoSTTmd7DAu6BXFDf+gcPBgOmRUEUQA=
X-Authority-Analysis: v=2.4 cv=U+4Hnuru c=1 sm=1 tr=0 ts=6ab2b21a cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xWu8-Agft_6X_INOG6MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: otHy111Hko3tjK0Tziu3oRKXcZDIXU79
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfXwTCp3TyoXONs
 z/vdYwJv9iRZDIQqum6lse0wcW8L9YhStl3EwQ4PLEVVLsWYCOP0280hscdNLxmNTDWCjCsHpXY
 /f54OQhkn00LGAIzbqGMB8qBvO308TbsdT029j7ASOrAXXSrqYwA1pKOyXJ/cvmH5xRxjp1htO0
 d+9Xppflv+DO61x7BoSTh0lGyuBDNeWeCiWp/hz+c7ChLNPFT9WAig21uDrpyhzz1YyyHWETyK8
 PnEdlL+POLL5A4n6ezo26VjHZAX2ihV/vqw2fAsoBJPB5xt4a+0+DiMbAWb4PXRA+3sTu8hGiad
 BB9ioz0DL8FWZTkHxRnHUfzBbGFOxW/WUROSvZEGuGmDRJn82YxMd4utAIV43A+uyyUwbip7LFG
 XfK2Ol2+KKzEWqXGfaYwRwPMdpLJO2z7DXDC6pQ4olupcwXzV7UruscETKHkq7Hxts/4xurO40P
 Uovj3wf3mnQc7koRIaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220246
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

Register x86_cpu_poll_during_halt() and x86_cpu_leaving_halt()
with the generic TCG halt flow. Remove the target-specific
x86_cpu_exec_halt() wrapper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/helper-tcg.h        |  1 -
 target/i386/tcg/system/seg_helper.c | 11 -----------
 target/i386/tcg/tcg-cpu.c           |  3 ++-
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 96accb30a80..4d543556a9f 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -38,7 +38,6 @@
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
 void x86_cpu_poll_during_halt(CPUState *cpu);
-bool x86_cpu_exec_halt(CPUState *cpu);
 void x86_cpu_leaving_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 566b3d4d80c..e24d01000ad 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -157,17 +157,6 @@ void x86_cpu_leaving_halt(CPUState *cpu)
     }
 }
 
-bool x86_cpu_exec_halt(CPUState *cpu)
-{
-    if (!cpu_has_work(cpu)) {
-        return false;
-    }
-
-    x86_cpu_leaving_halt(cpu);
-
-    return true;
-}
-
 bool x86_need_replay_interrupt(int interrupt_request)
 {
     /*
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6f5dc06b3b9..2fde412394f 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -180,7 +180,8 @@ const TCGCPUOps x86_tcg_ops = {
     .tlb_fill = x86_cpu_tlb_fill,
     .pointer_wrap = x86_pointer_wrap,
     .do_interrupt = x86_cpu_do_interrupt,
-    .cpu_exec_halt = x86_cpu_exec_halt,
+    .poll_during_halt = x86_cpu_poll_during_halt,
+    .leaving_halt = x86_cpu_leaving_halt,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
     .cpu_exec_reset = x86_cpu_exec_reset,
     .do_unaligned_access = x86_cpu_do_unaligned_access,
-- 
2.53.0


