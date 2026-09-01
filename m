Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1CDC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1V6n-0000Ri-I5; Tue, 01 Sep 2026 16:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1V6l-0000QJ-EA
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:29:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1V6j-00057M-D0
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:29:27 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTFgd2468830
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gxbf0LEMUm9FuacbIX2IIiTGQs5x0SdQJ5/psKIbaT8=; b=Wa2p8uEt20EaogN0
 dO3URAYv3wBObwrGYqjxSGBy9E1wVcg4pZIt3KtSrjsSLjr0Fe35P9AWixOGYghL
 qkrqdMesNecjuTAAHvUAlEUT0igg/E152LuQBw6jZbo3ePZSjtSTia7ch2izYagK
 4cbBCXsp8qZ+tw6Hh7np7Qa4HD6M1HcF3FYCJ11H4Y0YjR9daBLXszaVx0++EDZQ
 M1PukHSMYUOgnMaBvwC5aSm8cnhh0om1wo+Jgihz5Z9pJfC6ySQSusMHDdX/3M/N
 H0/DTlLoqb0x7mZ3Ai7H4+/DOCtG1nH4C8ZlxbVvk/Vgy1a3ibsqH2CnRwB+3miq
 GMoIsw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge39cgq0w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:29:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930edb4362dso62927785a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294562; x=1788899362; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gxbf0LEMUm9FuacbIX2IIiTGQs5x0SdQJ5/psKIbaT8=;
 b=Lw8uXf8Wi6In3kzQ3om16IgtAPr07oSYUr3GShkmGzx1X3RngUYsEWsuAc85I08fdZ
 m2V6fd20iAj6Me+5ShE07IVf4g6LiWZm0RUclcqRheVX2yJkKEJXnVT00ouCgu/xDBZj
 w671/V8nKEVVTqdvYg3I8K35Cu5C1IEHoQr6B1C51ENwaozO+PMNFDAWsyT/Rorca4zH
 /XQxJ/8xrKStvmUAbRzeVeY3gRd6ZGMaAFYzxoM1nXmMg05pL11hAqFcv7uIC+6DX8f5
 5FX/OyzFOV5IvSonS3KUna6JIwYZqpLL/Tid+hBri/6NQrXt/nEZSg5tdaSdBroqfz0+
 dPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294562; x=1788899362;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gxbf0LEMUm9FuacbIX2IIiTGQs5x0SdQJ5/psKIbaT8=;
 b=TTN4ag8fBMjcRQuM3nc/1AKCKT4gHKw+xMcfIEk/aKj0PsBbKpfLXDKNlgt1JhtRX4
 1vHumZgyNL0JVqHxk8MiwRpJP4qBhG3PAcm+U8M+ePzMybUSNM9hrQHU6nndKXcJ8dqb
 HVybvrvzcXYo+GgktaovqnvaehAPBA7YR+ow/vPxds/TJ0f6fv90BfpufOFWfWc5IKDO
 lTboPFeEy2NehMkZH9sCHBJwbxwhU6qxi0aRYJw2whhq/z7lRA7gCY8jyQf13zm2f/Pt
 Yh9FplvFAqBKxQg00h1moZOjYOkONrvJ/hGJqgm/uikOH5Cb+UPSDM8NhQbyHOHTejYd
 L3cQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYCAyhb8s5DxHXSfWgGJRHQChzFLJVuJ4EEBkhtTKkpB6OT1t0x8RaqlI7llu2BXORrdaI0Wg3vQBU@nongnu.org
X-Gm-Message-State: AFuF++m5uXZVn1Qx0QyEYU8PyT7CVqcoJcdPGVFoKI6yD/b34A6QsPDc
 ttSoEiCRHPRqo96iReyhJNwpgEZUT/04v6/CLiCcVweHqOCbxmNzo6gA1hiyPeUoFwJmO8GNozF
 GHUTXPnm0pN9clE22iE6f2gIJqoIFFm1fniirfmgh4+uGz0iTtzNKChehiw==
X-Gm-Gg: AR+sD10PppsPzzj0MzWswjJ9lDfOSnxVE03emngjCIVqB76+6H2zkLulf9b7+5H6JQw
 Vx5FRa1gI4SbZJ62vj7SnpcrxxOrksCd0nTmQFmBsYDGbZZInZD5+Rc9++FkJ73C1JY47LQzCEe
 y4bv4RnXd0c3+EHARaQdnz3nDzCOJattWQEnAL88ht1KBNWCJ+Fnfmanijdk0a5T2wfnlcfrukB
 FI9fM+fBkHhtw7NwzTfA+OrAv2mdBRrh/lBr3XoiHQAamnvNe8wRDqchXbMqQTSRllAMW3YUwI6
 HivQ53gWUPRoIi2FxnGcKp1ZdPzreLXFOi6ABcDhiRl0Avs5Bxiwcw6Hi0DCFJlUN+CzV0lGtX4
 S7vg8AiGfB7Ei1FKdS9+jrhzT7AURSJN3ENEX
X-Received: by 2002:a05:620a:a913:b0:92e:6a33:7118 with SMTP id
 af79cd13be357-9395ebe1358mr153767485a.30.1788294561766; 
 Tue, 01 Sep 2026 13:29:21 -0700 (PDT)
X-Received: by 2002:a05:620a:a913:b0:92e:6a33:7118 with SMTP id
 af79cd13be357-9395ebe1358mr153760585a.30.1788294561257; 
 Tue, 01 Sep 2026 13:29:21 -0700 (PDT)
Received: from [192.168.68.101] ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9395f1ae7f8sm28055785a.18.2026.09.01.13.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 13:29:20 -0700 (PDT)
Message-ID: <bb9345ba-1125-408a-8770-d340a734ddd3@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 17:29:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] hw/riscv, target/riscv: initial n-trace support
To: Konstantin Semichastnov <antikostya2@gmail.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexei Filippov <halip0503@gmail.com>
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=T968ifKQ c=1 sm=1 tr=0 ts=6a9735a2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=bDdBU3oEAAAA:8 a=HwFc7jivAAAA:8 a=pGLkceISAAAA:8
 a=OLIL841TmuMiggfAf5YA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=DN7SgORnOiO7RqxRx1GC:22 a=kr7TZk85JJIQSqC0cl8G:22
X-Proofpoint-ORIG-GUID: QA-bQl-arMlukxB97aIguUNSE04yie-u
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OSBTYWx0ZWRfX4Wj33zN43C6a
 pFlI36/wcpCaSZUU+t0Yh4R6F7fU7VjPS43yH8cqWXt81nVlgeCmcZ63jptDsl3u5/W/d1LR/PD
 3NJaHvfB0XcRJutxrflfDOpe2PknOzA=
X-Proofpoint-GUID: QA-bQl-arMlukxB97aIguUNSE04yie-u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OSBTYWx0ZWRfX5svR84beqQOq
 iziVVF7NT54o3suBpKSe1HiV8wrakkldryHEXM6DH1GGQgR4nGkUCPcg8jXBVZBfRP8TB3JoXBP
 fTqVbkMEDEVLERPQttJ2giqie+b5Nb9h1D+jjlkhuxYFm5tXItu0xW17lW66kvzEXjyuFixRAMN
 AO1NY3WJxswFa8xZv2J8T4F4jUP7743wK7jdTKESuLieLEv1JepFZnEpVfuZYiJNhu/36Fv4M8d
 R1o/dmgK1twOEpCjoVrV7Sq+/r5JuOBRJAA8onKHOA2KZL1BNhGRAunQr7EyaNJ+FAX9oqObEGK
 WzN9CN4I3OrQsMS3dvfyJAVv9s2EanntvXKNScT9pRXa1E86rJMthWlQuNUpT/VcW55GVkF6phZ
 CFUtIn/1IzXUcI/vqFr9cAYPyur3PiS3hFeR7aVO4APXYc72oBa2hgaxD1TK5HvolRt+3tC640K
 +fisuC6+K2kzxJ3h0rQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010179
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi Konstantin,

On 8/25/2026 11:22 AM, Konstantin Semichastnov wrote:
> Hi,
> 
> This series continues to implement RISC-V tracing subsystem.
> This work implements RISC-V N-Trace (Nexus-based Trace) [1].
> 
> N-Trace is a different format for tracing (compared to E-Trace [2]),
> and it is based on same underlying interface: RISC-V Trace Control
> Interface Specification [3].
> 
> This is the first patchset of several upcoming patchset series,
> that will ultimately provide full support for N-Trace HTM tracing.
> 
> A design decision was chosen to make the most of the existing
> infrastructure of the trace subsystem.
> 
> Linux kernel driver support is available here:
> 
> https://lore.kernel.org/linux-riscv/20251002060732.100213-1-apatel@ventanamicro.com/
> 
> Patches based on Daniel's Efficient Trace patchset [4],
> which provides support for Trace Control Interface and E-Trace messages
> implementation.


I *really* need to re-send that series.  I'll do that as soon as I clear up pending
work to avoid holding this series back when it's time to merge it.

Since you're using that series as a base I'll keep you in the loop if I make some
drastic changes in it.  I don't think I will - what comes to mind is some TCG side
changes to take advantage of the extra tb_flags we have now.

I remember from those reviews that we were doing changes in that e-trace message code.
I'll keep that code intact, and in case you decide we need changes we can do it as
a follow-up when stuff is already accepted.

Also, please update my email in the CC in the next versions of this work.  That email
is still around but not sure for how long ...


Thanks,
Daniel




> 
> [1] https://docs.riscv.org/reference/nexus-trace/_attachments/RISC-V-N-Trace.pdf
> [2] https://docs.riscv.org/reference/e-trace/_attachments/riscv-trace-spec.pdf
> [3] https://docs.riscv.org/reference/trace-control-interface/_attachments/RISC-V-Trace-Control-Interface.pdf
> [4] https://lore.kernel.org/qemu-riscv/20251111114656.2285048-1-dbarboza@ventanamicro.com
> 
> Based-on: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
> 
> Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
> ---
> Konstantin Semichastnov (13):
>        hw/riscv/trace-encoder: add ntrace enable flag
>        hw/riscv/trace-encoder.c: add trace ntrace/etrace selection logic
>        hw/riscv: add n-trace encoder with ProgTraceSync message
>        hw/riscv/trace-encoder.c: align ntrace messages with ones
>        hw/riscv/trace_encoder, target/riscv: add trace pc history logic
>        hw/riscv: add n-trace IndirectBranchHist rv-trace-message
>        hw/riscv/trace-encoder: add interrupt support to N-Trace encoder
>        hw/riscv: add n-trace ResourceFull rv-trace-message
>        hw/riscv: add n-trace ProgTraceCorrelation rv-trace-message
>        test/qtest/riscv-trace-test: add test-ntrace-simple qtest
>        hw/riscv/trace-encoder.c: add remaining fields to trace-encoder
>        hw/riscv/trace-encoder.c: remaining fields to ram-sink as RO values
>        hw/riscv/trace-encoder: refactor register accesses
> 
>   disas/riscv.c                                  |   2 +-
>   disas/riscv.h                                  |   2 +
>   hw/riscv/rv-trace-messages.c                   | 265 ++++++++++++++++++++
>   hw/riscv/rv-trace-messages.h                   |  10 +
>   hw/riscv/trace-encoder.c                       | 332 +++++++++++++++++++++----
>   hw/riscv/trace-encoder.h                       |  49 +++-
>   hw/riscv/trace-ram-sink.c                      |  22 +-
>   hw/riscv/trace-ram-sink.h                      |   1 +
>   target/riscv/cpu_helper.c                      |  21 +-
>   target/riscv/helper.h                          |   4 +-
>   target/riscv/insn_trans/trans_privileged.c.inc |  10 +-
>   target/riscv/insn_trans/trans_rvi.c.inc        |  15 +-
>   target/riscv/trace_helper.c                    |  23 +-
>   target/riscv/translate.c                       |  19 +-
>   tests/qtest/riscv-trace-test.c                 |  59 ++++-
>   15 files changed, 734 insertions(+), 100 deletions(-)
> ---
> base-commit: 6cedd046f606f155e054375c369bd606313e5f6c
> change-id: 20260825-upstream-ntrace_core-49bff943062d
> 
> Best regards,
> --
> Konstantin Semichastnov <antikostya2@gmail.com>
> 
> 


