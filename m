Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94370C5DF69
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wua11-0003cg-3R; Thu, 13 Aug 2026 14:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wua0F-0002ia-9Z
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:18:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wua0D-0002Dx-Rp
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:18:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DGDvpA2916956
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MsVnRq6tTlLn6rJyDkFaPR9BDkcmhfUBFcym5esfn2o=; b=c97tR2ddpDb5+1FW
 RxPrsNF3AsjCNIfxMfYWE2Pwq/0+hiX/05ArbaOF1Ahk8675cJspq3vwy04hO+Tp
 sHYj6jnHEzSGfZLJWwk52EImY6corNunFtH5s33gbvkXovncmGLdHbTzozMLWWKE
 EJAUGzWAEBOI158QPMv9xejpkJPxVWN8ny/4w5jm4FQ726rVkWwGV8p1A9NVmqi/
 Lo8RyntVD8836HcC0Sc7teFsit88wsju9TR+3Iz/sMfJgwBTsr7/7pi6+TydxoXk
 2GB5DXcRgVPXvzB7ch18uRhGcNn/0Qg/eVMCRHr0N/fRTQSVlwYiXIxL2U/kRky7
 QdN9gg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1h90rj9a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:18:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso848441cf.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786645084; x=1787249884; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MsVnRq6tTlLn6rJyDkFaPR9BDkcmhfUBFcym5esfn2o=;
 b=ehixXi0JUQtigCh8j8JdVEGRtlHbBCGAVKXYVDmgabL/hdtmpbtqjXqC9aTK4gN2IR
 sedJkLtrUXQ+yLMa08BTlp7I7eFRHwyFactDUHH5QSguF/YKV9NlSh6DaZj8jIvswM5q
 NwucXHjMg4xvDOfGVVDD0yPrKG51sfJLH9x5+c2p8Ub0aKyICAM/pORxnCYgGIMailoK
 Q1ImdSMBwDRXGelPwUfW54q+Oda+WMTRXz8YIthCaAeKmgR1TutgcACIUZbRAR8N33Lh
 ihRK3gkYPgdTKXqeZ9oZ6lFMje7NnIMExPOv09+BatvXW/I24PVHP7yp1omiEEOnNFtW
 i/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645084; x=1787249884;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MsVnRq6tTlLn6rJyDkFaPR9BDkcmhfUBFcym5esfn2o=;
 b=UK2v3RoXfZEZ9rj9PeHSw8BbUmZqGuCkP6G6I0dQTsWxszuijsF1Lutg0YXyTveWo1
 ZzM87szczcLGsf06WsoamjRbi37ve/g/4COk7yV8NWUQi+Bh8TZTjWUAD7/hizhgr1lK
 451oFv+IYnpcPyh1gjHL+6iAeJ05NtxHUAJGiGo2b2FU0dv3p41gT4BUNJW2DK2VdmFQ
 fLtX6vTzOa0yGcxqYnf2zc/uwyyefkky6SvLZmE/FyGelpTHP3a2+1mwrCqJduBHGny8
 c/tA4eWWYCc06kfb+I3Ap9MxAntgrF6Rnq8mUaRITP9zNcbHWCm5coqVY1Nn0g49sM1x
 r67A==
X-Gm-Message-State: AOJu0YxH7hE2q8gr3NaU6GTZfbthvaVqr3KZKXaIA+j/WjHdUKvYkz5x
 co3Hmrh6tL5Biq3cvz6c4YQLFftUNJWWLOyBkSK4RdTiNKy/wcF7QEABzeGuMSKCJdXruR25JDh
 cisvPXk0l5V8bKCEI8DC+TTZX45q1EAZmRfgh556+SHOE50VqDsZXU+WUAp0GvC66VQ==
X-Gm-Gg: AR+sD10HSdiVJeZbZEV01f0dKb/NCfS6iHptHMEuBgfCnxG6pl6aFzmrQQjJ9MAThR4
 U5PXj97BUlIDGYRevfdwAw64w2mF7M4Z5tlfObrJm3r69nR+1tdGJL5VLAp2RSWuzhiiV1qpLuo
 NfGRVobtALEAMTMm1Xzt9zzYi9TacBk5JkpxOkJzC+xXYPLviuuIYWA86ABJdJtpnJ6wsxCyXuW
 qes6tHnRfbzkLu+xVw+NCeZofU5VAFHkPn+CYQsofh7GD3gNU51yqOwpGQPXhbNZA0/QgdQQTHz
 hL4JmnTTfxvBNkYlLNvbRgu+Aa0XyaNFSySgxpaVqgs4h0xyT5cZRqibieYUQkj0C2bB/V2wpba
 Re8Y+bIXvQsmEqCmzHWvnalopHFrtA4+sGZfstIV6NA==
X-Received: by 2002:ac8:594d:0:b0:51c:1f35:4638 with SMTP id
 d75a77b69052e-52d74ba523bmr65865181cf.21.1786645084340; 
 Thu, 13 Aug 2026 11:18:04 -0700 (PDT)
X-Received: by 2002:ac8:594d:0:b0:51c:1f35:4638 with SMTP id
 d75a77b69052e-52d74ba523bmr65864691cf.21.1786645083884; 
 Thu, 13 Aug 2026 11:18:03 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1d9bsm1099831f8f.24.2026.08.13.11.18.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Aug 2026 11:18:03 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH 11/16] accel/kvm: Consistently return CPU halt state from
 process_async_events
Date: Thu, 13 Aug 2026 20:16:34 +0200
Message-ID: <20260813181640.6537-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813181640.6537-1-philmd@oss.qualcomm.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ovh/DS/t c=1 sm=1 tr=0 ts=6a7e0a5c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=GGjvRDhnLmMstqdV9EAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXzOtSKSFRY7Pc
 3a7bni/jKYF6zSbgfJQ9Z6wwaoeCmsYlQoER3ABmXyTydoXpyXL/7GJxWE64GoQGBSQAm8YJrsI
 WtpyK/QBuRGttYPNEiFc+Cuug1ImYYc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX+9chTWW3HtaX
 uUCM0EINE1GvIELkUCxAosxYqL2+S5TbM2jnA8xCAh8bkQy6eEFg8OK1M1gsI/PSRza8WDRhzk3
 IYp9mWD3+gcyOYhPHM+Oskxb1kKWvdD1WLZP7M3wmqmAm560nmHVdSSYCBw7LJ906O2/AcWAeve
 V8BOYf4+I9hofPjyHE6tYQRHKFhV8IVlCyaYlZNJQmoYSO10A3AFhldMszywDQ4FwERn2nMQLmz
 YPqgSMg/h3obJB2J2msDQMi/9iT9w4YeKoVVDNkqD/LLSVhTq0nl5wQhrD0nkWJF0sltcAbL7rP
 HDKMzpQvjUntfMQ31Fzzl8mmoBV+T/NSzlz6foTkS5G0rbCe0y3aFJNp2HvgcyjZjT5vqDGVymM
 u4OKnht9/z7a9Nt0Nc1xtzuVHzkKbI8Gxh584uewzUp/++wctLao68AkBD47ZFSVh6qB3JI6ut5
 qHigLKAxc+Z0K+uUdWg==
X-Proofpoint-ORIG-GUID: 7ShquBfEeK0IH38WcHNrmrSPHy4J0f2P
X-Proofpoint-GUID: 7ShquBfEeK0IH38WcHNrmrSPHy4J0f2P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
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

When comparing the KVM implementations, RISCV and ARM differ
from S390x / PPC and LoongArch. The caller expects a non-zero
value to return pausing execution with the EXCP_HLT exception:

  3427 int kvm_cpu_exec(CPUState *cpu)
  3428 {
  ...
  3434     if (kvm_arch_process_async_events(cpu)) {
  3435         return EXCP_HLT;
  3436     }
  3437
  3438     bql_unlock();
  3439     cpu_exec_start(cpu);
  3440
  3441     /* Inner vCPU loop */
  3442     do {
  ...

Change ARM and RISC-V to return cs->halted for consistent behavior.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/kvm.c           | 2 +-
 target/riscv/kvm/kvm-cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d40a6a98591..5caabfab63f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1575,7 +1575,7 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
 
 int kvm_arch_process_async_events(CPUState *cs)
 {
-    return 0;
+    return cs->halted;
 }
 
 /**
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 97069bf597a..1a61cd5ef37 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1568,7 +1568,7 @@ int kvm_arch_irqchip_create(KVMState *s)
 
 int kvm_arch_process_async_events(CPUState *cs)
 {
-    return 0;
+    return cs->halted;
 }
 
 void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
-- 
2.53.0


