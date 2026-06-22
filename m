Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477BBCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wblpD-0007ol-Lg; Mon, 22 Jun 2026 17:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wblpB-0007lm-Ct
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:04:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wblp8-0001jw-Tb
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:04:57 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZj4B3222608
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uv/+mo6kWGoBuNYiMOYjT4/Rxzddblx8K8XEyqHNduc=; b=BBEWexW7jv2DfJa4
 GAcHr2vEweO0DmcL+LGdVMas41viClPVzh6qruhTLd9ZzghTM7S7OlvqS4ceZ0u1
 cXGbQq0Y7FaTJ/H3NP1rvM6OFjzkjI2845NpJ4U1jFoL8DNXQ+I/Qri7uk/JHfp9
 I6h6JjaAYCCtXXnFkdKiXJnX8XkEGJMEdgYtPwq3jcUhQMA3wQGipVTFq6+VELUT
 nIr4GbhbrgQP0whFAIMp6WHUKGOMy1A3X/d8Xxikegl9yRTklRjI9ovp534elj3Z
 Iv80cv8te++3bRYY21HhVUOdxeZGgeN7600dwmPgf6O3jChij6TFzeFe6NPh+/4O
 buKJOg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5sn1pjs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:04:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-517c65c019bso123508581cf.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782162292; x=1782767092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uv/+mo6kWGoBuNYiMOYjT4/Rxzddblx8K8XEyqHNduc=;
 b=DsbQzGIyxr5iF2ijzx4bEUvrQTni/Si31LIrLh03VeAB6tM2S6vd83VF7pBvC2eq6/
 SYdBZ5NNitKxfiweebNsbKGIGrP3PRMDGic+f1xTrgpi4JlzU0XxC2j0sfqTWWcGKHK+
 1uQG5Hk6J9/WNLvDhlrN2zLgMwl9EUUq+8qiS8NxvfOvcd3hhP/xzxmZlzAdCBW2hyHg
 SSutBMgS3QmyPDQMzn2AUnx13KjDDmBzVloJUIzaK4O11xTxfdCany+Gv0PJwNHLSFRk
 M9hLbh/ywx7dYHcUFElzUjeNKCHmtLG4JzhiXFByBvGprvTxWhKaKKT6dFuM5y25twIS
 vYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782162292; x=1782767092;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uv/+mo6kWGoBuNYiMOYjT4/Rxzddblx8K8XEyqHNduc=;
 b=dHMKrp1+Rr+tRNnhXalpvL9E5LYvTaYhMQesh/UqTk2y4cJLSIVVEUwgBOk38h9HZ2
 m/Uc6hGcyoYkdGleSGdbR8l2bryy2QScFt/OiKbQueaWlrVlGTO5HAfjhFaOagRZuB2r
 iXOeUC+xRG1aTvaOjkyLjIiL37NdhIxW2rPQfWW47hoHy4tOUGl08ntZxfmtts2amf5K
 Gk5o8WG2vqL9aUUP7dIawLk567M0pAvmz58qo4dRpDt3seAD0W0Dd2hs8ULtbGy39XxO
 MVn2p1Lm/8jaEtsSb9nuHTU0IU32ZDUbOqHtv+gGT2TTgX4TpTgaffR0Px+XIBE79l9F
 wNRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SBzqLhXiOzwuCvVCTei6gDcUaOjFV+1DS5gYj/2m5v6vDmh18YgL33XGbBHvbqOljiiEEGq+RZTD2@nongnu.org
X-Gm-Message-State: AOJu0Yy55kWSBk/d/OZhbs9+hpSJdwEV+ijSa74d5YMNAIGFyaNSB9vC
 OxZHtijPBhEnJzcVPpUBoNIQ3hs6AJYJcAaIdf9sFWdvwSuoSMfZdC6jDc5Fmyeuu8/KKFTWXbF
 xb0iV5IH/d0xB7I2frueFAkl+4UHG9+fMd44PPVwj2Uq/4GOHyM0GeC/4Dw==
X-Gm-Gg: AfdE7ckGFua1YXLu/my8ELcS8nklscJWP915pP4F16omxM5Hyz9xsJCY4JDFiZOLmJ5
 Z+bo7RO8Q+K5oVfah4VXBLdoXL9bvy35FEkpxdDW702irOleOMSy3/QwPzVpEGL5dkMiLikBzcz
 oztY8LHP4BcCCQSkVf3EvF7X9HY79uuNiv4kmPhmqIPBLp5ezvUSS3ojcXNGc7ut9AglDOCtKew
 SYflcOpTyoAQLwJtvV/95ZzU0zE0cgj7BYGWFU0tEmhFDYCPD+SFTqajv1FWGEYsXmncXdH1a85
 2+ttJc+JVAfT/DPSBdulWnrwvhFtn6tyy2diWZ+9oXDF8+ktjuv9n5PPlX1+Qxb9BPbJtMViFr1
 iZoDywbkTxT01G3Pki8DOxMGWN0VIlATN+5XuJipNXolw
X-Received: by 2002:ac8:5e0c:0:b0:517:5bc1:e1f0 with SMTP id
 d75a77b69052e-519e46cab16mr243714251cf.0.1782162292083; 
 Mon, 22 Jun 2026 14:04:52 -0700 (PDT)
X-Received: by 2002:ac8:5e0c:0:b0:517:5bc1:e1f0 with SMTP id
 d75a77b69052e-519e46cab16mr243713701cf.0.1782162291447; 
 Mon, 22 Jun 2026 14:04:51 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92600d78c84sm77304185a.47.2026.06.22.14.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 14:04:50 -0700 (PDT)
Message-ID: <fb95ef34-dcdd-4e05-b929-2853247479c4@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 18:04:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <52c3605c-345f-43d2-8cc6-794980c805fa@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <52c3605c-345f-43d2-8cc6-794980c805fa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: G31LGgWqykBSaU-hJDutdtCrNh3I1BDg
X-Proofpoint-ORIG-GUID: G31LGgWqykBSaU-hJDutdtCrNh3I1BDg
X-Authority-Analysis: v=2.4 cv=PuKjqQM3 c=1 sm=1 tr=0 ts=6a39a375 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=NEAV23lmAAAA:8
 a=m-4l0abKu59XhOTcK5AA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwNCBTYWx0ZWRfX3TbbjZqBO0rL
 lbzF1buknSWr+pEPafJcsvYGvSU/4LK75yUZl2lGMoDCh6MmrjNv8ulpxoiRFZBre+h8bJu6xKC
 zhpI4gZFEDPMq1vo5AU5tVzxhubNETw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwNCBTYWx0ZWRfX9bUZAn92+IUI
 QOwcylh6CvvrUNNvxyf/6ZlcpYdhaIpewHu+rzwUoKCOdCF1N6GpBE7e2IqC8qiXriqcvAq81Fl
 Y7ZO9sAuF+quchBpDAXqmr86vwil3JOoI4jCQd/wXq5BA47GinzPteUDSB7ayR4NGrwmcvjswQw
 kToNKekWNEQxR0xrpxcNJ4PtJpOHEYNcdXR8MdH6TVwAHG5UOJAWI5u9MlNHfJCsbET4evADza2
 ewGQ/lL/aEBPmyZT5yEXUIjX4F0Mv7YwpMnPfrcNdJsrJLadCXOGfNLnN13EJJH1w/3h3M1UPWR
 oIOTZnjlvB8ZUcqPwjIpjOv08dkMvf5M/3FndiI/hboIoNEh9nuFAhzTfwwgDYmii5eaB0N+CbL
 QT0Ytvtkf+S/ZEZG6dxLSAWIp2gdgB1hiHUK/htthVN01LPbCjifejfxOq7M9ZevCtFglSLPN2h
 SJHbOHExlSHTEfPM5vA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220204
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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



On 6/22/2026 5:52 PM, Pierrick Bouvier wrote:
> On 6/22/2026 12:31 PM, Daniel Henrique Barboza wrote:
>> Hello,
>>
>> This series looks scary but it's mostly trivial and mechanical work.
>>
>> It is yet another attempt at fixing --disable-tcg.  We have a recent
>> work sent to the ML [1] and we had Phil's attempt back in 2023 [2].
>> Phil's work didn't get merged and it's now too hard to rebase and
>> revive, the most recent attempt got misled into the 'what is common code
>> between TCG and KVM' dungeon.
>>
>> After reviewing [1] I went ahead and look what other targets were doing
>> w.r.t their directory structure and comparing to RISC-V.  In our case we
>> have a log going on in target/riscv:
>>
>> $ ls target/riscv
>> Kconfig                 cpu_cfg.h             fpu_helper.c   machine.c         sbi_ecall_interface.h  vector_internals.c
>> XVentanaCondOps.decode  cpu_cfg_fields.h.inc  gdbstub.c      meson.build       tcg                    vector_internals.h
>> arch_dump.c             cpu_helper.c          helper.h       mips_csr.c        th_csr.c               xlrbr.decode
>> bitmanip_helper.c       cpu_user.h            insn16.decode  monitor.c         time_helper.c          xmips.decode
>> common-semi-target.c    cpu_vendorid.h        insn32.decode  op_helper.c       time_helper.h          xthead.decode
>> cpu-param.h             crypto_helper.c       insn_trans     pmp.c             trace-events           zce_helper.c
>> cpu-qom.h               csr.c                 instmap.h      pmp.h             trace.h
>> cpu.c                   csr.h                 internals.h    pmu.c             translate.c
>> cpu.h                   debug.c               kvm            pmu.h             vcrypto_helper.c
>> cpu_bits.h              debug.h               m128_helper.c  riscv-qmp-cmds.c  vector_helper.c
>>
>>
>> It is non-trivial to realize that most of this stuff is TCG specific.
>> Meanwhile our 'tcg' subdir is mostly empty:
>>
>> $ ls target/riscv/tcg
>> meson.build  tcg-cpu.c  tcg-cpu.h
>>
>> If we compare it with other targets, let's say loongarch:
>>
>> $ ls target/loongarch/
>> Kconfig      cpu-csr.h    cpu-qom.h  cpu_helper.c  disas.c    insns.decode  loongarch-qmp-cmds.c  tcg           translate.h
>> README       cpu-mmu.h    cpu.c      csr.c         gdbstub.c  internals.h   machine.c             trace-events  vec.h
>> arch_dump.c  cpu-param.h  cpu.h      csr.h         helper.h   kvm           meson.build           trace.h
>> $
>> $ ls target/loongarch/tcg
>> constant_timer.c  fpu_helper.c  insn_trans      meson.build  tcg_cpu.c        tlb_helper.c  vec_helper.c
>> csr_helper.c      helper.h      iocsr_helper.c  op_helper.c  tcg_loongarch.h  translate.c
>>
>> It is straightforward to see which files are TCG exclusive and which
>> files are common to all accels.
>>
>> And this is what we did here.  The patches goes mostly as follows:
>>
>> - move stuff to 'tcg' subdir.  Most stuff is straighforward and is
>>    manageable with a single patch.  Other things required some logic to
>>    go to either cpu.c or tcg-cpu;
>> - move TCG stuff to tcg-cpu.c;
>> - move common accel stuff to cpu.c.  Usually from cpu_helper.c;
>> - filter TCG specific code in cpu.c and other files;
>> - trivial/assorted fixes in misc files that were needed to make
>>    --disable-tcg work.
>>
>> Patch 24 is taken from Zephyr Li to enable the CI for --disable-tcg.
>> Hopefully we won't break it anytime soon.
>>
>> After this series we have --disable-tcg working and the following dir
>> structure:
>>
>> $ ls target/riscv
>> Kconfig                 cpu.c                 cpu_vendorid.h  internals.h       sbi_ecall_interface.h  xlrbr.decode
>> XVentanaCondOps.decode  cpu.h                 gdbstub.c       kvm               tcg                    xmips.decode
>> arch_dump.c             cpu_bits.h            helper.h        machine.c         time_helper.c          xthead.decode
>> common-semi-target.c    cpu_cfg.h             insn16.decode   meson.build       time_helper.h
>> cpu-param.h             cpu_cfg_fields.h.inc  insn32.decode   monitor.c         trace-events
>> cpu-qom.h               cpu_user.h            instmap.h       riscv-qmp-cmds.c  trace.h
>> $
>> $ ls target/riscv/tcg
>> bitmanip_helper.c  csr.h         insn_trans     op_helper.c  pmu.h      translate.c         vector_internals.h
>> cpu_helper.c       debug.c       m128_helper.c  pmp.c        tcg-cpu.c  vcrypto_helper.c    zce_helper.c
>> crypto_helper.c    debug.h       meson.build    pmp.h        tcg-cpu.h  vector_helper.c
>> csr.c              fpu_helper.c  mips_csr.c     pmu.c        th_csr.c   vector_internals.c
>>
>>
>> [1] https://lore.kernel.org/qemu-devel/20260602091753.3209261-1-fritchleybohrer@gmail.com/
>> [2] https://lore.kernel.org/qemu-devel/20230711121453.59138-1-philmd@linaro.org/
>>
>>
>> Daniel Henrique Barboza (22):
>>    target/riscv: move TCG only files to tcg subdir
>>    target/riscv/machine.c: do not migrate pmp state with kvm
>>    target/riscv: move pmp files to tcg subdir
>>    target/riscv: make some riscv_sysemu_ops TCG only
>>    target/riscv: move pmu.h to tcg subdir
>>    target/riscv: move debug.h to tcg subdir
>>    target/riscv: remove csr.h from kvm-cpu.c
>>    target/riscv: move csr.h to tcg subdir
>>    target/riscv: move custom_csrs logic to tcg-cpu.c
>>    target/riscv: move riscv_cpu_set_nmi() to tcg-cpu.c
>>    target/riscv: move valid_vm_* satp arrays to cpu.c
>>    target/riscv: move some irq helpers to cpu.c
>>    target/riscv: move riscv_cpu_claim_interrupts to cpu.c
>>    target/riscv/cpu.c: handle TCG bits of riscv_cpu_dump_state
>>    target/riscv: gate riscv_cpu_update_mip with tcg_enabled()
>>    target/riscv/cpu.c: filter TCG only bits in riscv_cpu_reset_hold()
>>    hw/riscv/riscv_hart.c isolate tcg only bits
>>    target/riscv/gdbstub.c: isolate TCG only checks
>>    target/riscv: move riscv_cpu_set_rdtime_fn to riscv_aclint
>>    target/riscv/tcg: remove unused riscv_cpu_get_geilen()
>>    target/riscv: move riscv_cpu_set_geilen() to riscv-imsic
>>    target/riscv: move riscv_cpu_set_aia_ireg_rmw_cb() to riscv_imsic
>>
>> Zephyr Li (2):
>>    target/riscv: Remove unused tcg/tcg.h include
>>    gitlab-ci.d/crossbuilds: add riscv64 KVM-only build job
>>
>>   .gitlab-ci.d/crossbuilds.yml                  |   8 +
>>   hw/intc/riscv_aclint.c                        |   8 +
>>   hw/intc/riscv_imsic.c                         |  24 ++
>>   hw/riscv/fdt-common.c                         |  52 +++
>>   hw/riscv/riscv_hart.c                         |   4 +-
>>   hw/riscv/virt.c                               |   1 -
>>   include/hw/riscv/fdt-common.h                 |   1 +
>>   target/riscv/cpu.c                            | 316 +++++++++++++++---
>>   target/riscv/cpu.h                            |  19 +-
>>   target/riscv/gdbstub.c                        |  10 +-
>>   target/riscv/kvm/kvm-cpu.c                    |   1 -
>>   target/riscv/machine.c                        |  15 +-
>>   target/riscv/meson.build                      |  17 -
>>   target/riscv/monitor.c                        |   4 +-
>>   target/riscv/riscv-qmp-cmds.c                 |   2 +-
>>   target/riscv/{ => tcg}/bitmanip_helper.c      |   0
>>   target/riscv/{ => tcg}/cpu_helper.c           | 239 +------------
>>   target/riscv/{ => tcg}/crypto_helper.c        |   0
>>   target/riscv/{ => tcg}/csr.c                  |  45 +--
>>   target/riscv/{ => tcg}/csr.h                  |   6 +-
>>   target/riscv/{ => tcg}/debug.c                |   2 +-
>>   target/riscv/{ => tcg}/debug.h                |   0
>>   target/riscv/{ => tcg}/fpu_helper.c           |   0
>>   .../insn_trans/trans_privileged.c.inc         |   0
>>   .../{ => tcg}/insn_trans/trans_rva.c.inc      |   0
>>   .../{ => tcg}/insn_trans/trans_rvb.c.inc      |   0
>>   .../{ => tcg}/insn_trans/trans_rvbf16.c.inc   |   0
>>   .../{ => tcg}/insn_trans/trans_rvd.c.inc      |   0
>>   .../{ => tcg}/insn_trans/trans_rvf.c.inc      |   0
>>   .../{ => tcg}/insn_trans/trans_rvh.c.inc      |   0
>>   .../{ => tcg}/insn_trans/trans_rvi.c.inc      |   0
>>   .../{ => tcg}/insn_trans/trans_rvk.c.inc      |   0
>>   .../{ => tcg}/insn_trans/trans_rvm.c.inc      |   0
>>   .../{ => tcg}/insn_trans/trans_rvv.c.inc      |   0
>>   .../{ => tcg}/insn_trans/trans_rvvk.c.inc     |   0
>>   .../{ => tcg}/insn_trans/trans_rvzabha.c.inc  |   0
>>   .../{ => tcg}/insn_trans/trans_rvzacas.c.inc  |   0
>>   .../{ => tcg}/insn_trans/trans_rvzalasr.c.inc |   0
>>   .../{ => tcg}/insn_trans/trans_rvzawrs.c.inc  |   0
>>   .../{ => tcg}/insn_trans/trans_rvzce.c.inc    |   0
>>   .../{ => tcg}/insn_trans/trans_rvzcmop.c.inc  |   0
>>   .../{ => tcg}/insn_trans/trans_rvzfa.c.inc    |   0
>>   .../{ => tcg}/insn_trans/trans_rvzfh.c.inc    |   0
>>   .../{ => tcg}/insn_trans/trans_rvzicbo.c.inc  |   0
>>   .../insn_trans/trans_rvzicfiss.c.inc          |   0
>>   .../{ => tcg}/insn_trans/trans_rvzicond.c.inc |   0
>>   .../{ => tcg}/insn_trans/trans_rvzimop.c.inc  |   0
>>   .../{ => tcg}/insn_trans/trans_svinval.c.inc  |   0
>>   .../{ => tcg}/insn_trans/trans_xlrbr.c.inc    |   0
>>   .../{ => tcg}/insn_trans/trans_xmips.c.inc    |   0
>>   .../{ => tcg}/insn_trans/trans_xthead.c.inc   |   0
>>   .../insn_trans/trans_xventanacondops.c.inc    |   0
>>   .../{ => tcg}/insn_trans/trans_zilsd.c.inc    |   0
>>   target/riscv/{ => tcg}/m128_helper.c          |   0
>>   target/riscv/tcg/meson.build                  |  31 +-
>>   target/riscv/{ => tcg}/mips_csr.c             |   2 +-
>>   target/riscv/{ => tcg}/op_helper.c            |   2 +-
>>   target/riscv/{ => tcg}/pmp.c                  |   2 +-
>>   target/riscv/{ => tcg}/pmp.h                  |   0
>>   target/riscv/{ => tcg}/pmu.c                  |  52 ---
>>   target/riscv/{ => tcg}/pmu.h                  |   1 -
>>   target/riscv/tcg/tcg-cpu.c                    |  30 +-
>>   target/riscv/{ => tcg}/th_csr.c               |   2 +-
>>   target/riscv/{ => tcg}/translate.c            |   0
>>   target/riscv/{ => tcg}/vcrypto_helper.c       |   0
>>   target/riscv/{ => tcg}/vector_helper.c        |   0
>>   target/riscv/{ => tcg}/vector_internals.c     |   0
>>   target/riscv/{ => tcg}/vector_internals.h     |   0
>>   target/riscv/{ => tcg}/zce_helper.c           |   0
>>   target/riscv/time_helper.c                    |  33 +-
>>   70 files changed, 495 insertions(+), 434 deletions(-)
>>   rename target/riscv/{ => tcg}/bitmanip_helper.c (100%)
>>   rename target/riscv/{ => tcg}/cpu_helper.c (92%)
>>   rename target/riscv/{ => tcg}/crypto_helper.c (100%)
>>   rename target/riscv/{ => tcg}/csr.c (99%)
>>   rename target/riscv/{ => tcg}/csr.h (96%)
>>   rename target/riscv/{ => tcg}/debug.c (99%)
>>   rename target/riscv/{ => tcg}/debug.h (100%)
>>   rename target/riscv/{ => tcg}/fpu_helper.c (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_privileged.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rva.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvb.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvbf16.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvd.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvf.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvh.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvi.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvk.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvm.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvv.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvvk.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvzabha.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvzacas.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvzalasr.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvzawrs.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvzce.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvzcmop.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvzfa.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvzfh.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvzicbo.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvzicfiss.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvzicond.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_rvzimop.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_svinval.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_xlrbr.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_xmips.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_xthead.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_xventanacondops.c.inc (100%)
>>   rename target/riscv/{ => tcg}/insn_trans/trans_zilsd.c.inc (100%)
>>   rename target/riscv/{ => tcg}/m128_helper.c (100%)
>>   rename target/riscv/{ => tcg}/mips_csr.c (99%)
>>   rename target/riscv/{ => tcg}/op_helper.c (99%)
>>   rename target/riscv/{ => tcg}/pmp.c (99%)
>>   rename target/riscv/{ => tcg}/pmp.h (100%)
>>   rename target/riscv/{ => tcg}/pmu.c (86%)
>>   rename target/riscv/{ => tcg}/pmu.h (95%)
>>   rename target/riscv/{ => tcg}/th_csr.c (99%)
>>   rename target/riscv/{ => tcg}/translate.c (100%)
>>   rename target/riscv/{ => tcg}/vcrypto_helper.c (100%)
>>   rename target/riscv/{ => tcg}/vector_helper.c (100%)
>>   rename target/riscv/{ => tcg}/vector_internals.c (100%)
>>   rename target/riscv/{ => tcg}/vector_internals.h (100%)
>>   rename target/riscv/{ => tcg}/zce_helper.c (100%)
>>
> 
> It seems like series does not apply on top of master, would that be
> possible to rebase it?

Oh, sorry.  I forgot to mention that patches are based on alistair's
riscv-to-apply.next branch:

https://github.com/alistair23/qemu

Cheers,
Daniel

> 
> Regards,
> Pierrick


