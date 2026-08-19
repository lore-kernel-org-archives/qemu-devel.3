Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE8DC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhj0-0007lM-3g; Wed, 19 Aug 2026 10:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhit-0007kx-Es
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:56:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhiq-0000R9-CC
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:56:59 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEbo6e3550158
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=MFcF18kZWGFZ4Gh4f7tZci
 XELusorMLKm6REJdfk7GQ=; b=BX96w9mfkUpLpHQhKPAac5gM0AbMmsHAYbIDy5
 8GfBAnk3sNxENCuqjGtMkxld5dxbFbNJjkb2iEKDQZ2mGXejEGfrccjA9XBJmus2
 VMtHnnx0P5nts3ZXlxdcva32A/0H4rukNw3Lj+Cizh9CMD0F675vk8cVf2vSQVaB
 jcaGxYI+RrS1JfFk6M2EjDWlAzfVbEa2+Cfzvv8n2xHn9jN9LW866UuA0cVMKdeD
 LTYqK+6TSRIIvMaakA981d8TXgOKsIDJuntn7SmRigCRgMjXKdsO9ovER5OhW+R7
 fMumrQoBRQ28dh8SY4Ait9Z3w/FYamFXb5W0gTrqYobHZUVw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfkbvpb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:56:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so153274785a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787151412; x=1787756212; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MFcF18kZWGFZ4Gh4f7tZciXELusorMLKm6REJdfk7GQ=;
 b=Kge7g/CBemx8A+gU5C3tH3uUNKb7U1F9ORS0+2TUcIGicUkanfP0od0svLBYIqFQ9U
 NoVhdk54QUS3AzezOfq4MAV7FsOs/O8Q7Y81VlRSBkIjyM9GkZtmVcs//77UVd/+nDYJ
 YbXiRosxl8eebOaKACsnqx3ue51P2J2RmBpSErgNB6l5qigSdTnAGYtd9rDV+wopHOQb
 7z61O0srBES6TX4DRxAoraO6OiVJNNU5GZMtX3/d8R9B+edkMg6jAKfCUPNGi2fxWTsa
 cVeuZt497A1HwZEwjRk/RtSCoZxsD7bekr3CjVs+alY9ohhuZu61Xt19/9kz2l70CXht
 cOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151412; x=1787756212;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MFcF18kZWGFZ4Gh4f7tZciXELusorMLKm6REJdfk7GQ=;
 b=MqSeFKL3MXW3jMoOrkItU8umAjwl2tHXrpRKaaPWA7g44DCg9niF5/Brj3K/LXlT+f
 shNrCNB8NJzDMfxkpBsweJ6ZErk1paVEZc7UCw/AtZcjf4IeSIxQZf51kBe7gHyPOfXB
 YUqDMf8S20/cYoXXDT76fxXxQglvekSVuFZqSHsKiO7x0w01HgOya2QNzkcTmQkKr3aj
 XC9FePz/TbkVr8FdUwYmXO3OFXAOGlDbd17QEKZqag1tGvyCurQApUxxIIX65ZjXlGyo
 s2B3y5MyaT/LDSXuM9aqOpDJikLBENFjzsyHGgjpBsPiYckQ31HNMVhd0ovzh61wWfkI
 H47w==
X-Gm-Message-State: AOJu0YxsaZWqBdlPfOYZer4Jl+x9QrxmRerqbjaWSkljDK0k8o5IwPgG
 LcPg1/HF9NYJG/4uiNJDUnKFnRF4yRnBHhNfheYpKXxdPlMa93mr2/KDkFBPYbpHElsqKOa62i4
 DKXIzJtexDzW2ts7QLIpSqirXscHhCedYzGUFBSfDhR8pzCY4gtQ3hXq3j/8J6QA8JGMO
X-Gm-Gg: AR+sD105rLV+GpFHiD0agwINwpQ8atHuvqn1PJDxNQUCxbEAoDuFKDJ08VgjteQTFvo
 odruLcel30cM7N/UMz1d/rZZ912CkRx0GpGbNGfJO8NuTAzsfKSWnbYCBjVqq5oNumonjlVZuhw
 S/8hJ25y87RheRtCsjrCZIWu/7Gis4vwbcl68lR/6MDoMgPfwo16cOmQoURtjyiUxFJpBaTMiBS
 KhLM41Z2Z+dRIJY/1bQJrJF+1NmkfOR81UzCDqMPMH8B7f7QftLyS39VmurT1K7XHAn16cVYMRq
 xZf9fk5rNkijkPD+Rp6H5S4ObCbgGe/Rvp4Ya6prqBxlgxrkkaaaxogj/tTm0AGxr3qaqvKC4u9
 u3aVJ/IzeM/2PZRWU+tEdpYruQ2jJ87ldMTtcaEaY4Q==
X-Received: by 2002:a05:620a:2b86:b0:92e:e695:d622 with SMTP id
 af79cd13be357-9371e6aca28mr537065685a.28.1787151412439; 
 Wed, 19 Aug 2026 07:56:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2b86:b0:92e:e695:d622 with SMTP id
 af79cd13be357-9371e6aca28mr537058685a.28.1787151411837; 
 Wed, 19 Aug 2026 07:56:51 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e0b351sm30945515e9.3.2026.08.19.07.56.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Aug 2026 07:56:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 00/11] accel/tcg: Make halt-to-exec transition explicit and
 remove cpu_exec_halt
Date: Wed, 19 Aug 2026 16:56:38 +0200
Message-ID: <20260819145649.23439-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PoGjqQM3 c=1 sm=1 tr=0 ts=6a85c435 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VBVPcwuWFa0cdlCml2cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfXxtoRqyN7/rlQ
 E7fY+HLZudC0nQ5FbS2jRMIZ6O40k2PPtkpJWOTmUumhgTULhYQ5+lzQZkP/Ya2tMplJ60Im2mx
 9/JXUGPiot2v7/I0Ac60pcfox/7N39VlAGn7YFHZAnbwlNYXXX20ZXtUSlGwBxec5kmFkN0Yqfc
 Jlg4+Q/N2YH57/wyZ3Nqmz7lTQlC7cd1DX5KC0Kn62FJsRHd5N/6uGJtuT2Pf/sMoo3BNDanNmb
 IMLvJI+nbmxp2Dp2L38DIGykD8o3CSDd21ZczUfiPLUayBrIgFkXbO8eN6jQ5Zuv8QNft6K8Kd8
 K/oAN9PrOx09T1E3lTeLzSV7HePWxeWD70Gz2HqMNur5EGMEGBwEnJh3UyLZs9eUlLTRReyW7Ok
 HiSiGitg3TLf39mnF9Fis+a/UfPejmuKS4R65AfKi9cgbAwljwnZOP1B6k1xtf99C6I19gqmTQt
 DHGBeLErwNKcgcKRFyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX4ypvBA9DNJyj
 OWoEh4uxGEo5akLD/++8UXpRpe3fLmAPbuopNNO278c7szmEgoe/vyembdD7TUG8j3+qeY14LVp
 ru51RPu91xJNclPOARcUaxm3J+XMF0g=
X-Proofpoint-GUID: CkR_klt7G0MbeCxAv3WxSGWjHunFT-W1
X-Proofpoint-ORIG-GUID: CkR_klt7G0MbeCxAv3WxSGWjHunFT-W1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
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

This series was inspired by a previous thread on the list [*].

Refactor the CPU halt-to-execution transition logic in TCG as
something more explicit and composable.

Core problem: TCGCPUOps::cpu_exec_halt callback mixed concerns,
it checked for work, processed async events, and handled state
transitions all in one place.

Solution: introduces two dedicated callbacks:

  * process_async_events(): Process target-specific async events
    before checking for work. Called early in cpu_exec().

  * transition_halt_to_exec(): Perform target-specific state updates
    when transitioning from halt to execution.

This separation allows the generic cpu_exec() code to orchestrate
the flow cleanly (process events, check for work, transition state).

Only 2 targets need to be migrated (x86 and ARM) then we can remove
the redundant cpu_exec_halt() hook.

The changes are expected to be purely refactoring with no functional
impact.

Series structure:

  Patches 1-2: Preparatory refactoring and guard additions
  Patch 3: Introduce the new hooks and orchestration logic
  Patch 4: Refactor cpu_exec() flow to use new infrastructure
  Patches 5-7: x86 extraction and conversion
  Patches 8-9: ARM extraction and conversion
  Patch 10: Remove the now-redundant cpu_exec_halt hook

Testing: CI test suite

[*] https://lore.kernel.org/qemu-devel/CABgObfaDAhrpnVqQaKgG6uxPQe1YDu77YOsUEx9nqrN=3M2cGw@mail.gmail.com/

Philippe Mathieu-Daudé (11):
  accel/tcg: Rename for exception codes named @ret as @excp
  accel/tcg: Restrict EXCP_HALTED handling to system emulation
  accel/tcg: Check %halted field in cpu_handle_halt() caller
  accel/tcg: Refactor halt-to-execution flow in cpu_exec()
  accel/tcg: Introduce .process_async_events and
    .transition_halt_to_exec
  target/arm: Extract halt-to-exec transition out of arm_cpu_exec_halt()
  target/arm: Convert cpu_exec_halt() to transition_halt_to_exec()
  target/i386: Extract async event processing out of x86_cpu_exec_halt()
  target/i386: Extract halt-to-exec transition out of
    x86_cpu_exec_halt()
  target/i386: Convert cpu_exec_halt() to transition_halt_to_exec()
  accel/tcg: Remove the now redundant cpu_exec_halt() hook

 include/accel/tcg/cpu-ops.h         | 30 +++++++-------
 target/arm/internals.h              |  3 --
 target/i386/tcg/helper-tcg.h        |  3 +-
 accel/tcg/cpu-exec.c                | 63 ++++++++++++++++-------------
 accel/tcg/tcg-accel-ops-mttcg.c     |  7 ++--
 accel/tcg/tcg-accel-ops-rr.c        |  8 ++--
 accel/tcg/tcg-accel-ops.c           |  7 ++--
 target/alpha/cpu.c                  |  1 -
 target/arm/cpu.c                    | 22 +++++-----
 target/arm/tcg/cpu-v7m.c            |  1 -
 target/avr/cpu.c                    |  1 -
 target/hexagon/cpu.c                |  1 -
 target/hppa/cpu.c                   |  1 -
 target/i386/tcg/system/seg_helper.c | 14 ++++---
 target/i386/tcg/tcg-cpu.c           |  3 +-
 target/loongarch/tcg/tcg_cpu.c      |  1 -
 target/m68k/cpu.c                   |  1 -
 target/microblaze/cpu.c             |  1 -
 target/mips/cpu.c                   |  1 -
 target/or1k/cpu.c                   |  1 -
 target/ppc/cpu_init.c               |  1 -
 target/riscv/tcg/tcg-cpu.c          |  1 -
 target/rx/cpu.c                     |  1 -
 target/s390x/cpu.c                  |  1 -
 target/sh4/cpu.c                    |  1 -
 target/sparc/cpu.c                  |  1 -
 target/tricore/cpu.c                |  1 -
 target/xtensa/cpu.c                 |  1 -
 28 files changed, 84 insertions(+), 94 deletions(-)

-- 
2.53.0


