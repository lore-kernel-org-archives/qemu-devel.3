Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46ADDC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhkW-0000ZU-71; Wed, 19 Aug 2026 10:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhjc-000851-R1
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhjb-0000ZU-6f
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:44 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEbv2Q483823
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FXITH5suvTv+icy2CdUplpix+DUoujxMoLKvSwrcVV8=; b=TnMrSRAMLuojg1de
 Bki7yiZ2LnzkzWhXdvkQO7jglt9e3ibaWWybNsfliuNu1l5FeAHN+T4dB0gmmEO9
 yJ+MP4QxF8V0GmeoggWLQz86gKheaRRzXnGF2q20ecl/h9UfqSQ0EY3i/2fQ8iZc
 Uon/PfHXOxxh53TJPYQwKw+KVcdKuM78QLv3CD7PWl3730wKUpWV1Nnj3z0Wwyub
 TMN2WuULYQMKuiYZjeNEkSsqiJfCbuYEUJpYoSw17QFenrgi7KRrjkBDFV0Z+r+y
 7IJ5OPCgZnY865yrDBM0oCaE8+NNRvBmBPechI9WYPWIZAfTDDQ5tzlQFyrklCgS
 92sZcQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfnbstk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936d067836eso142189885a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787151462; x=1787756262; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FXITH5suvTv+icy2CdUplpix+DUoujxMoLKvSwrcVV8=;
 b=TXW1d2Mlh6O1rFCa5ZxvZ849UTRt4Kh2zGGVUQEvqt0u+UH4SARKY0oUvXC47KU7Xg
 siZ7ztlL0svg6AuyTJGNqbpA3nJ9z10G5YeChMorxLFeW4eMqqgJrgPTL3MWBDdswceu
 yV4SyASEufGC6edDUUSprbX0e+nx1noZjQkgOl61SI0yqT6KUni/0KKDiCcOWB1OEQ0L
 v5AoedugCDzTrRAxTNf07tyPNLAqsmnXzblqMwBqSK2z4Sp2AZTnk2GWs/yhmUIUUJ5v
 AJlhg79B1JFcCcweIDA8udzPacQYU3q/Kh2cro5lclB/gXBPypOrec7p0iqilwhXWtxE
 ADbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151462; x=1787756262;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FXITH5suvTv+icy2CdUplpix+DUoujxMoLKvSwrcVV8=;
 b=CNp4DsV0uZlUarViGSAA4xD56BHGgYdrd7Qf5pJMkrZs0PE/CNGTNG8G9HTQkr0MAI
 39eaDHd75hu3eQHTL2DdEOzJmAdueZr6Sa36XkPI/KOG0MANc5VlNPAE9Wq5gK3M5JKQ
 NQQdxFoIwW2SFDCUS0xDGj60jaSPi+nLSm7FTbF2B77e961J0BLNt2/8WJBF4IzooYhi
 lL5ZHDe/CmdHnpSLZSRHf1iQInZzk/9HdyWJ6r7MkDYGdW/o5kJSwdEMLXYWc4lwzP44
 QK+uOGH8jshIR22fygaejhi7atZfEIqm45n+HnVUqZB5bM5r/YvYeWxZJL1D9WLvJaKe
 96fQ==
X-Gm-Message-State: AOJu0Yw2U4SSTx+izkCnvY8LPmSesXTj3b7ec7I8GknC3cGp/gLd15rn
 1wRGLpIubHFnh6KxDUH2oFXNggfohSwn25CEP3LEydLoT47DqDkOxdjORo38aHgsPRsgOCRfx9O
 uMBiJ36yKgZfxe9ObHwvtcknO6eQM5cJTO7UKvAbFBz1YcVNQzIxldH3or+/x+bOaMBEb
X-Gm-Gg: AR+sD13cV5F3qmxVzHAaQ9r8Cep0ViL+ec6STxDaIBjefKsODdUpvCZhvaHSF7xXw2r
 Fl+ZFHNTbsDWhZ8shDix7H81gXPr36opftWyrX+nQRM0i/vlHtdh7XBwpaljf/oG7Xr+x/J05UF
 nZBW6kJdB2O0zZx38oqRLS1dm+xNFFEhyGeYRnVtJA581h5IuuIw0b0paO2Drlz5gmjGELkqrEc
 RS35DRdtDkTskeALNoWl6vSvmd9xNcXMyKxJGhScoMyJDqEYw2sJn1xe9tD1r8QGuyuJcXBbo1Y
 ZYx8DTnfNs7+18aqD1LmoyB9abSeqvMBh5Lx6Hf2CGjXRPpE6tM7wTTjSKX1V7lO7id4IWsX7iM
 V5WmRjkOxixaqRv9N6Vc0gh8EkG6hfmmiiQCw4ckZ8A==
X-Received: by 2002:a05:620a:278c:b0:936:d2a2:5fe with SMTP id
 af79cd13be357-9371e2521a4mr501887485a.6.1787151461713; 
 Wed, 19 Aug 2026 07:57:41 -0700 (PDT)
X-Received: by 2002:a05:620a:278c:b0:936:d2a2:5fe with SMTP id
 af79cd13be357-9371e2521a4mr501881785a.6.1787151461262; 
 Wed, 19 Aug 2026 07:57:41 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9ded661sm51270135e9.2.2026.08.19.07.57.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Aug 2026 07:57:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 07/11] target/arm: Convert cpu_exec_halt() to
 transition_halt_to_exec()
Date: Wed, 19 Aug 2026 16:56:45 +0200
Message-ID: <20260819145649.23439-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145649.23439-1-philmd@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QedWeMbv c=1 sm=1 tr=0 ts=6a85c466 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=n7VCdh-ccns4_l-8tLkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 5_98nvQa_RCXKGFQ9qCNJZlTIFaBQwEu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfXwINCXVJRDCYp
 9CgyipRhCiyGUde0evO6n3Y2m4EzuPZVUtI6R8Owpqr+geH4kzVFN4oIlCxEZxBWhEc+5L52Cqw
 CYhXKOCM7F9ahalxt2HKHNml73/Wwys=
X-Proofpoint-GUID: 5_98nvQa_RCXKGFQ9qCNJZlTIFaBQwEu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX7AEcDANqR9k5
 8FFMNaJS0+GSUCBCLJsf48FlFoJeFqgEzJLtzHk2BE5urX6ZrGn4SwEIRqazE/8s3C9xkBcMA01
 uKxex0izhLT+noXYXWYhWCBU99mVv593L4IxB1EBOcOVR6DyhpqMkYThUOyktHUI050huKlh4sB
 fPjJaF+azLl41rZk8BHkheA2dO955pZ4dlN+Nak6DT/vCv2htJRGsUitdnXSqK2XHC4smIFWvOA
 bbtQzec1HWgz2UiLU9iuIPlhZrMuc0uvRQ+A+HKvOlU2ngiEqhbWDn4fuvrjP6SYyJWUO6i7R0a
 r3Cf2lNUhX0DZrjWHQaL3+1axJf3PoNmpUI6nZl0iqvmo4n61KeVNYGD81C3Vl8ZAcVoMhIDU2Z
 o3M8tGhVJLP1DL+LwjHjB/d1j6ebhbp5OpfV3mjoTMTC8IM75Jp9bshFcKpwIPeAxkepUFCtl2O
 ZJJIwpiEkqAe3UgehVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
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

arm_cpu_exec_halt() now merely checks cpu_has_work() and
conditionally call arm_cpu_transition_halt_to_exec(), which is now
the generic flow in cpu_has_work_after_processing_async_events().

Register the transition_halt_to_exec handler to use the generic
target-agnostic flow and remove the arm_cpu_exec_halt() wrapper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/internals.h   |  3 ---
 target/arm/cpu.c         | 12 +-----------
 target/arm/tcg/cpu-v7m.c |  1 -
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4026f67579e..8a9ee04e72e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -431,9 +431,6 @@ void arm_restore_state_to_opc(CPUState *cs,
 #ifdef CONFIG_TCG
 TCGTBCPUState arm_get_tb_cpu_state(CPUState *cs);
 void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
-
-/* Our implementation of TCGCPUOps::cpu_exec_halt */
-bool arm_cpu_exec_halt(CPUState *cs);
 int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8e9b584559d..22fae41125f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -883,16 +883,6 @@ static void arm_cpu_transition_halt_to_exec(CPUState *cs)
     /* clear the halt reason */
     cpu->env.halt_reason = NOT_HALTED;
 }
-
-bool arm_cpu_exec_halt(CPUState *cs)
-{
-    bool leave_halt = cpu_has_work(cs);
-
-    if (leave_halt) {
-        arm_cpu_transition_halt_to_exec(cs);
-    }
-    return leave_halt;
-}
 #endif
 
 /*
@@ -2612,7 +2602,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .tlb_fill_align = arm_cpu_tlb_fill_align,
     .pointer_wrap = aprofile_pointer_wrap,
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
-    .cpu_exec_halt = arm_cpu_exec_halt,
+    .transition_halt_to_exec = arm_cpu_transition_halt_to_exec,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = arm_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index dc249ce1f14..e30eb8cc52a 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -257,7 +257,6 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .tlb_fill_align = arm_cpu_tlb_fill_align,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
-    .cpu_exec_halt = arm_cpu_exec_halt,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = arm_v7m_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
-- 
2.53.0


