Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F100C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhkD-0000PD-Ox; Wed, 19 Aug 2026 10:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhjx-00007e-TV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:58:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhjw-0000dH-Ax
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:58:05 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEboTx588430
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lf1AKkFbDPN5LN9GZ52Xje1+fKB6ZDsodR2xkXPemRU=; b=gtlJp19n4nhEtAM9
 NW2FT0WyluDxvAR957N51DI+svnfrEE3tdv3rpk0FZ5RdZFMzYI26X4JFj+wxBWs
 PlWj6kTOAaMA7xPdtUSdggnlK1+USlUPJdBCo7sXrYrMFDKi0Sgm/mnTyx6976tM
 Ggg4UbBjPR9CUeLn4g189jVpj4Umj/B5IEuwcAjAEVS7kUIU++T7MRYr93dec/ie
 TeQXpc6hBHTmIUnhO+7EWxzR0bSIh7lfSP0apXk9sUd922Zj8j7Gq6mok5Zgv7GU
 ErFV5vy10dXPG3x//Rd15F5DdJZ12LfOx859BaY/+b0EEb0zYG1LiJswvSeqB2iC
 JhwCpA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfkbutj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:58:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e4f946461so124363185a.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787151483; x=1787756283; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lf1AKkFbDPN5LN9GZ52Xje1+fKB6ZDsodR2xkXPemRU=;
 b=TyYKPdVJ2STLZRrnNkSX+yGpD610Iue6Gm3Wvarr+roZBS7vob32iFidm35hAP0RYe
 U99I5sCnWu9nSj2yCER9/5nY8qwjscspvriVy20E80CoqjDyZn81pxuDtDycvIx1KAP0
 YQs5O7ckIy1bErR6hwsknY7cu+j9eIKaCaE3wHOxUr/rttrQXQejoVJg381VPKZEFwSV
 y77CQQ1QCwWYPugQYdzZ/QbQTwBQmO1TJkgWmEDKxxO+i4oQKAEzsKXaHwsyVJuvTiZ7
 UJzX35Wqq9cKpQvEmUbaa0YAhp+b6umqFyc5oB2O/RZGrPrwylwvala0h0n4UmYSXwhs
 b+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151483; x=1787756283;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lf1AKkFbDPN5LN9GZ52Xje1+fKB6ZDsodR2xkXPemRU=;
 b=r6+ofbsga+8S7d5THeEIvVHaryq5chhUNv6XJX/kQ7G32ovwUQvM+bYcIpQfgPIWiI
 mY1jvBl2FfbAK3GDW9R3vpehDdw8o133LI/PmR0/mrTFQG/Mq7Ya5/aMaKoX4WaKYO5t
 limgxG6TxLYALhFVDMzJDSANk8EgCWcpFvgaUkY3rnWSIR9Ii+BW4B95l0gFMXY4t2hR
 Mpt2mCt1KeEX/C/SEhy5T3IM9uZl+4VWejs3zEdqRKxGrWkzfRoDJv0vEytee//rzoo8
 1qwkxv/fSVQnD3PI1PYbSvUQsg3XG/GOm56idqlU385b0lAtIgMIgQSPsBZFg1n+dF+s
 C5IA==
X-Gm-Message-State: AOJu0YzLzKvho5n3oqqQRV0NHT8uf3ideJC6nB6aDfT4tVpWXoRixw6w
 rDNN3Yjah3pdusah7tBiEm2CxIOhuJG3yWZPllpav+Aqu/0oXDuTAnD3YmpWEnHgN7M4lq6REIR
 phydnTHikVJDOfgvJqLI52HpBODgNLr4vHQIILkgTCXNu7dk7chB3NV0vxHECtyAG0LrL
X-Gm-Gg: AR+sD11OhuNImEfeq1rWg1RB64X55IUjj5ZSISKcfSQF1Ve5vQAJtPMIJ0kwNyyUDVG
 gMZ8pkFb4JECoA1YsDXPWXFFoCn9JKsfHt+Q4sIp87Zn/7UJBdAejUebbRqqNe93SGniqiGyzLw
 vcfuMaTO08H+9tfwD2SJkkRue9fCNbLXxfTTbyj+bs7hM+LTRE5kOvrOMST7YygoyWSbKJMwWgq
 lpurzQU+sWBXDROVvEVMzxcKgDkAgh5+p+eSTy3Ku4zaQhQaz0gtu/NnJx20kKhswmS1JFU0G17
 c/4PK04RPnn9ScZExniruaor6BpJxRaYnUHRgsjQT2DH3QmElR5Ou6QbJgbZiqoP2lJp544ieb4
 qEBlMWVwfqg8wfGguylvx7qjZnsLjxIQOJ+2YKpUddg==
X-Received: by 2002:a05:620a:6cca:b0:930:b068:8c03 with SMTP id
 af79cd13be357-9371e4421cfmr484568985a.34.1787151482588; 
 Wed, 19 Aug 2026 07:58:02 -0700 (PDT)
X-Received: by 2002:a05:620a:6cca:b0:930:b068:8c03 with SMTP id
 af79cd13be357-9371e4421cfmr484562085a.34.1787151482064; 
 Wed, 19 Aug 2026 07:58:02 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b145153fsm6322181f8f.12.2026.08.19.07.58.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Aug 2026 07:58:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 10/11] target/i386: Convert cpu_exec_halt() to
 transition_halt_to_exec()
Date: Wed, 19 Aug 2026 16:56:48 +0200
Message-ID: <20260819145649.23439-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145649.23439-1-philmd@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gRIj9VLj9KQfDzSoXD-H57VAVXcTvECk
X-Proofpoint-ORIG-GUID: gRIj9VLj9KQfDzSoXD-H57VAVXcTvECk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX6I3MAc4GK9xC
 cEgbRGlSTvyv+tWbSRiH7vS+Ln++VRbFwDW1fmfqm21m+K7esXLZgv9wqEH2/8ImmM+NU3zDTrE
 APAFw4Mvx18Ky5t5hr5b2LvVS7HVTI8N7SliuIjehyVBZFtzj/XzWWbtDDiCZusl4CDWhVihXuK
 W6wfnxBoLkIsfR7MRs5G/IL7t6pd9oxxf9yjRn0Lx+pCV9ffvom7zRJL/wUWAg7oe4LTpXjxlDc
 qifj7r4rqOVuv9+fY9KAz52CKIsIQI4CPA1pkCotGz1MTspb/qx9B10dxDU7TR/vwl+h+GpTrXf
 UDGS/+XPqFqk7RCYd8qeWnRBejgZjyAVx/60xdq24E2UgbG2TnfR9DpTcjrn0IU+RxvkrYQTo09
 VPY9QJfI6rTrjQqlx4jGxSenI/v1kw+ZIDpInBcWUPcSLoE9MGo0LdV4YlqNqSrOC6dzON0uUKA
 IbajTgYoeBoHyI86slQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX9fkjaazVtAp6
 jMHMOZxXAvQNPPymFl12w2NEHnbos5R3LzEfkTVHbdUIg4WhqDyyV9ZXSC1tMdeKC8489sjbIa+
 317KdEbJxacnbbQqbg2kKqfRnyZCGf0=
X-Authority-Analysis: v=2.4 cv=fvfsol4f c=1 sm=1 tr=0 ts=6a85c47b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=5HqjihXlECL5oxfrbloA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190116
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

x86_cpu_exec_halt() now merely checks cpu_has_work() and
conditionally call x86_cpu_transition_halt_to_exec(), which is now
the generic flow in cpu_has_work_after_processing_async_events().

Register both process_async_events and transition_halt_to_exec
handlers to use the generic target-agnostic flow, and remove the
x86_cpu_exec_halt() wrapper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/i386/tcg/helper-tcg.h        |  1 -
 target/i386/tcg/system/seg_helper.c | 11 -----------
 target/i386/tcg/tcg-cpu.c           |  3 ++-
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 65819670493..d224cb3c1c7 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -38,7 +38,6 @@
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
 void x86_cpu_process_async_events(CPUState *cpu);
-bool x86_cpu_exec_halt(CPUState *cpu);
 void x86_cpu_transition_halt_to_exec(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 9b2adcca76c..7a3f14a255e 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -154,17 +154,6 @@ void x86_cpu_transition_halt_to_exec(CPUState *cpu)
     }
 }
 
-bool x86_cpu_exec_halt(CPUState *cpu)
-{
-    if (!cpu_has_work(cpu)) {
-        return false;
-    }
-
-    x86_cpu_transition_halt_to_exec(cpu);
-
-    return true;
-}
-
 bool x86_need_replay_interrupt(int interrupt_request)
 {
     /*
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6f5dc06b3b9..e4fc212aca5 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -180,7 +180,8 @@ const TCGCPUOps x86_tcg_ops = {
     .tlb_fill = x86_cpu_tlb_fill,
     .pointer_wrap = x86_pointer_wrap,
     .do_interrupt = x86_cpu_do_interrupt,
-    .cpu_exec_halt = x86_cpu_exec_halt,
+    .process_async_events = x86_cpu_process_async_events,
+    .transition_halt_to_exec = x86_cpu_transition_halt_to_exec,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
     .cpu_exec_reset = x86_cpu_exec_reset,
     .do_unaligned_access = x86_cpu_do_unaligned_access,
-- 
2.53.0


