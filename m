Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E955C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qaw-0002cm-5U; Wed, 23 Sep 2026 13:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QXl-0006g4-Ou
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:14:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QXi-0001OQ-Mo
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:14:05 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGU0rf2470628
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VscxCLnI2dGnGBzBwxcHvgdrFWZJrGl9KKZv7JgH7Xc=; b=X8CfVDa6uMDQ/2jq
 TFs5twY5EcHA+4Ngete2R3F+/zNXqH/rJ1r880J9xud5fc7AZbZBWEYfniZLatc2
 1QJak11Q6AmdbUe4kySQg76ygT4tPN0IM7RYGsZCTRQanpkNOSnBNIASyTX4i8JB
 qbH5wPZSbbx+UzDqtYrWevXlFBrZvm8JX8BHCzKHUZ6/RdGlpcObZkBk2GZz7NTV
 QuCJiahkD7irE5pJSLwAIbaHZ4fD5T1FzWAum/v799ZstZNXGBy3Iia6C8gF3ezm
 i/0JGfAkF+bSsxi9L5E37CwC9roAS/sShrS+KbdZv9ya8/7CeLrN/qXknnr38ZLc
 VW2SXQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv132n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:13:51 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-790e3ca4c85so373503137.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183630; x=1790788430; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VscxCLnI2dGnGBzBwxcHvgdrFWZJrGl9KKZv7JgH7Xc=;
 b=b5eCe3asfUCsbeQmQKlPCd7eVBSVvkI2I3uSIAfqAdCxDeYkVlLw8UfmQ/xLQe76o0
 omtcMHvEBEj4LH/UraPhNMIIiIE3t2Uk8DydR9XcbP9sfpquqJgCjjWI+7/jkZ4J8IFT
 +hAJKGVP+ajBxHIJx0YHDq3O/U1eupmZUAUj6aBKqH4LHLJjwn7vlxJCh41qmDKOpaI7
 k3Ze3UQ6JyozsgFS2aaxOy9gmFCV4pV5jX3e5l9fjza+XtbqEVL7Tpmz5uBvr3+pFuF/
 yjzfH6+SQHrXpdtQlKC2NbPMLmIOp2yshXtW6lXTdR876PHoRiVtrAtcgbyKmvph70Vn
 ePdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183630; x=1790788430;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VscxCLnI2dGnGBzBwxcHvgdrFWZJrGl9KKZv7JgH7Xc=;
 b=EN6Lr4rXE9HY2uoF6c+QjzWpK1B/tzDNl+kH/yeSrIvC13fEeyiqBYf7ufttupRRKy
 mUKmK+FvDVo4BEFvPsPwGuF+DwxGwNauNdZu4SJ2YPPLFGuMDyFvxcTgqkVI08/zf2Or
 GcjQd933TFn/g6l5hAGQpSGUFb213aq1kEHhIcFYH6flHQALIhmm7qDcmI2ocEVxDVKz
 uuNDiHOiIWHEvp8Z3BqX4EdXLL06ZEM7lXdGGbT4ZAwxWTFln5La5wdoj03mkrofzSyR
 a5mwanwHyhklLqpPfemG1TaziSLdZkXP123yv7TVMjKZJlT0mpMXdXBl7wipL7Y8FNbx
 CdWg==
X-Gm-Message-State: AFuF++n6ga0nAlMqZRmntEfLqmfzoqDZuwXA7fo/VRDGymLaliG8aa/J
 sdTW8eGuKzdhdwoJGZaXlXYRYnsSljj6sl2FUlTj7WlLIK+IdJTCV813n6N+5y0lopPWvkLHhcD
 6ui+mNumMhsoPxZOX0ZfM2rCVu+CeIoYchxmK3VoSQwzxoaWl4M5QOapARBinTmSVxR+S
X-Gm-Gg: AYBFou06WfEN4lDZ+Ubw7VWYcMT5oHngpOIP0wBmBqnzxhtjDfK6h5VzgS1GetjqHwj
 lPZhcXl/nrk4s5sVeYK2Ctj8m38zhCouRuqgNeMMou7ih3+Zi+kKXddcwEyF24nx9z5M+8MrfO6
 eP7YzpVWvqKfwzE9sHhU91D8Wd7UcvbBbnp3+hy/deEx9LDVqrnvcqyZXkrY1jcHyww7Ows8DsU
 aYVBleVcc2n9aDGuILWfi9EXSj/YYN2S9jV04WX4myFDlxxFH0zpnL9/r2+/7DY6nf2rIZdCw0N
 9HlkNFmZA0dl0WfV/Q/xZXg05nOEcnedu9gHIoVmAOM9IEcASs//vWHSajjV9UcpSa+U3mfhq38
 SiCweKtLQIPlzCLEaAqDIJI0tqEoFwNOI8fpBqFzY
X-Received: by 2002:a05:6102:f97:b0:7a1:f7d2:e832 with SMTP id
 ada2fe7eead31-7ac1d4ed253mr2983808137.18.1790183630247; 
 Wed, 23 Sep 2026 10:13:50 -0700 (PDT)
X-Received: by 2002:a05:6102:f97:b0:7a1:f7d2:e832 with SMTP id
 ada2fe7eead31-7ac1d4ed253mr2983785137.18.1790183629496; 
 Wed, 23 Sep 2026 10:13:49 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868886e45sm8590301f8f.31.2026.09.23.10.13.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:13:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 20/21] target/i386: Use generic halt transition handlers
Date: Wed, 23 Sep 2026 19:11:14 +0200
Message-ID: <20260923171116.31276-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923171116.31276-1-philmd@oss.qualcomm.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfXydltwkAOtaEA
 asYqFL36MpyAzllLpxB3yqQMZKWFaG/ENU+TEMHk+mUQlSW53fKIJ4AePWOjMfnnAdqirdIxg2J
 IHgtKUv0uuUDxel0EMy+ds76a7EVYzuowBAdjEBJnXv4C1+h7PFAvWFMS+CkAWCBQjPtB1Qmype
 xQW5s/oHO7NCl7fPm0beKNLg3O3IDeOU01Y0KNvye7sB2EPsc4rSfVaWrAoyGtgnMHKGJQ9Fksv
 yCe1kWRKg5RiQSUuNWfMgao8nUUCsj2SVxrOVmzuw0DIHN6lxL8SYpUEj+COp+WECLtLYsp5Jsp
 asXzYmY/QlpNLyjHE4NJrQI4WXdcg3XiDdhO9TKN6oCPfwM5gvnXXwaV5LLuSVRehEv74WuqZ2c
 FCZZ/167cT8OIA+zRJPATAPVa+UhfIoDLB/son/DHDmhuWAoP63G4/j0b2rgPT8nF2hhWlrYBto
 yJTYn6JqZuqt5gboTPg==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab408cf cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xWu8-Agft_6X_INOG6MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: i6vQaRJYfa18GzdqKs2gE4V_8s0f6sh_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX598xyo2FUNU2
 nJ1iRGQL+e9SwGy7jciivhodjllvMAQSIaaTLOBeXCIoRa+WLfRYeWe9KDuFvZcMtsL5czEtI9i
 6IFY+cDSIOo/jnDNoloUo8kFcEbjJJ4=
X-Proofpoint-ORIG-GUID: i6vQaRJYfa18GzdqKs2gE4V_8s0f6sh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230068
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


