Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD9FCDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 20:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbldW-0003hS-JL; Mon, 22 Jun 2026 16:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wbldV-0003hA-G7
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:52:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wbldS-0007L7-So
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:52:53 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJdmwn1940410
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 20:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0FCsHaU9AMRwGFyu9Qz3hjiOwIHA1sRP23xsw1KczsQ=; b=ObZEAuksVTf6Fhm2
 2VOxCAY9jcNyaatj6FtR9SpeLNDxZ1qxvAlNbWQXIeMkhg7scvSN49KtQUQEkU9F
 ktmcJMKhviYrNaRcWKu+Df0fjIyXPRsniDAJ5j+aQqIRvsgeumGbZ0QXeGYwH/F6
 Q0dP46GOLjmte5Es1QEWxilEBlcYcceq8hoQDsj/El+J6hf2bqIcoIfNwRVRJT9w
 j0H6+O5/4WgdH476HwIMg5qhB2aMIzed1io4aD9CPbkLckJB3pXhmc9KA2+6HVjG
 wMdzrq89/2SYPc4yEkqw0/UepKm+rA/DW6CP6m8OLWf/i+3AQPrqmfm57zxOoH8Y
 anZGCg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5ye9mjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 20:52:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so11480847eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 13:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782161569; x=1782766369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0FCsHaU9AMRwGFyu9Qz3hjiOwIHA1sRP23xsw1KczsQ=;
 b=d1Wnoo3/Dk+5jg8dfriQUCqxgqoUwSPUiHe7LN0npVZtBYSlWuqCzhc4acQ3qPoMEZ
 kSezJ5qPHYXLsAVzSu3h2LiBp0i01e6HIx09XIi9xltdxIlsHMTCQ6ZTeYQH3UE4ZKLL
 P3mjyCKYdX2twTSHcuFlw2F4Jvg5b32NjgKU1Po9l3A6u1mkdMOtJs11bEzKO74SxsLF
 19oeCM/QDa1q4mjvYou2ygUfuH7f7jWEmN53tgYo0QBtB8LVZCRDlhfr+w2DUI7Y0dDt
 Be6SoTTY2RZXn7W7A7RExkYEMvO9rCCnB1XmNe7z2IYJb2jVPTEqvKMklsMlZKyFyyi1
 u3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782161569; x=1782766369;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0FCsHaU9AMRwGFyu9Qz3hjiOwIHA1sRP23xsw1KczsQ=;
 b=cLg4aK1VERp8BALQl7iBcGAZbDW7T1zuk+grHTskftYVZ5X3cQg/jO4+IsqexAUWJq
 u9zw4wr5eaUjAkk86SmpW58Q/t5oT3PBIP9FmEjPz4rudUvWi5+uBQosdCd/PwJGpWjH
 +L1EEjFhH01WGKISV5A+9ClEEYLl8iyLTz5C8CF2k5D6kjN/HW4cAZnpuweyxRbB4MBk
 7wpA+Gx55apjDEKns0TfQGOz+SKWU5tnneyGbO9tVUR9HAjrS8OuDrRMjnX+4GxLUMsK
 O7hq9TG8Twm7MP9UKnlphyLTnzONtgwMclnIpTSR9HjBVfhe1nh2JsTDTWPxMLzBJQQp
 MzHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBn9kpYbnCUuLWn0twBRemPeLJi4QSaQoqR1zc/2D88Jvnjkta4FNSlzkiMr0QUs2FkwQ2XsJl4u5w@nongnu.org
X-Gm-Message-State: AOJu0Yx0VzQxfxi5wRgHXhIvJfpP06CvoDxrRSq2YblubMnfy4xRGVlu
 n1n5i1ZaXTm4RwQLhAUW/UimSjlKG2rCSi27sPqdzumVHUXSrniJ72RHCqpw6bhgDYAAUYsMAQi
 YCtKZn83Io5pS2zF8wvYCsSyNgvfMz0uEh58v4aLcra6Neq7suMfFToPeng==
X-Gm-Gg: AfdE7cnUpHaY48YUXuQLvRh7CPbMGj1GJmyKPJV1d47L5u4JYmtA2nP6/2hItkM4lKz
 qlnpUOcua+TpM8j7npvxn1Te7bxFACBn/YgaHAf8MPhv29TK8muhWlx4rAsCkxo4UWLpT7eO2gE
 qrAHiQXfnM2ZERVH9gCz22FNFKdEG+P7HA+OH3JG+T4gqu8ORMRwsjAFd4jb2CocaA+scNjZHnl
 Q1OMEu+mx3/1iypfWMCWDAna13u0f1bc94nimF+eQ6hfPcnIblgzI9lSGZRAXEh3zcf0YtWdvia
 eK5OpwFpLuWvogD6LPs4uEUDvJ2eDc1RGBwcl+9vAZoHwZFns7vaMYurzRcxyeQRojYJavtMfPx
 5zaxS0dLWfTYrzkK/hc12OK33T9y7sNL3vYG8KwpTC6fXuNNLsID98hFXkyqaA+fzcPx4PV/KNw
 hZhvI=
X-Received: by 2002:a05:7300:50f:b0:30c:554f:cc2 with SMTP id
 5a478bee46e88-30c554f1148mr1083981eec.12.1782161568612; 
 Mon, 22 Jun 2026 13:52:48 -0700 (PDT)
X-Received: by 2002:a05:7300:50f:b0:30c:554f:cc2 with SMTP id
 5a478bee46e88-30c554f1148mr1083938eec.12.1782161567870; 
 Mon, 22 Jun 2026 13:52:47 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba1f137sm10914133eec.1.2026.06.22.13.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 13:52:47 -0700 (PDT)
Message-ID: <52c3605c-345f-43d2-8cc6-794980c805fa@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 13:52:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: R2mHz513N-Lzy7_0pNa0zUCnfHUY1_du
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwMSBTYWx0ZWRfX9po5muF5yqz4
 4fGAy/BWrokRZPVHpinnw0TsYmbsMO5hdQJAqGcE0n5A6NH0M/7VJzTjKUI3+p1cr3DEgZvO7S3
 CBod/TIBPZ958YpON/2an7MgjYAz3rU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwMSBTYWx0ZWRfX+RCaCBGmWDit
 KGvH4UbTvkwfv3Tg3h8osVXbgtjDWgQLtXnuLR2V3CpDDAZwMF5lC3m7nOlUWrs7yV2MPwGOhUk
 xO4CwTCRts8AzfN3XyYRERrJUWFnpZF19o++92bmRSoCKlq33/ufhPs5AfWRbnQ1WjrBlAMDWr2
 3ffnQmp7Ipv48DelIluyff3fjeD4/Cm/pmXsARojYd+O8wvjFkPPGRjrC8iJHPwOh84ZNqcjfJS
 uCak3kDX+I9OngnPt2eXKzU3zQr2l+9HoOnyzPXOXoFhYfrj63y7yoa/pCl+3HclQPbHdy88nxJ
 CCxepT8tzezHcbfrf9S1z/6Lsh5MY6P//32NgLyD7ynT2/YG8EeO1VZB1XC7t+P6Pj7aOIf+1Nq
 U/jy25a9A5XdT9jvFWxbzwYLDKU8qCOVk1RXf9VWyWCpPHJF3IiHNdvHsGFkqpg+Lhc1ZKCD7y1
 0DGO1qYs6InckYGbFXQ==
X-Proofpoint-GUID: R2mHz513N-Lzy7_0pNa0zUCnfHUY1_du
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a39a0a1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=5S2GVuWWAkDWuBhmdzoA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220201
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/22/2026 12:31 PM, Daniel Henrique Barboza wrote:
> Hello,
> 
> This series looks scary but it's mostly trivial and mechanical work.
> 
> It is yet another attempt at fixing --disable-tcg.  We have a recent
> work sent to the ML [1] and we had Phil's attempt back in 2023 [2].
> Phil's work didn't get merged and it's now too hard to rebase and
> revive, the most recent attempt got misled into the 'what is common code
> between TCG and KVM' dungeon.
> 
> After reviewing [1] I went ahead and look what other targets were doing
> w.r.t their directory structure and comparing to RISC-V.  In our case we
> have a log going on in target/riscv:
> 
> $ ls target/riscv
> Kconfig                 cpu_cfg.h             fpu_helper.c   machine.c         sbi_ecall_interface.h  vector_internals.c
> XVentanaCondOps.decode  cpu_cfg_fields.h.inc  gdbstub.c      meson.build       tcg                    vector_internals.h
> arch_dump.c             cpu_helper.c          helper.h       mips_csr.c        th_csr.c               xlrbr.decode
> bitmanip_helper.c       cpu_user.h            insn16.decode  monitor.c         time_helper.c          xmips.decode
> common-semi-target.c    cpu_vendorid.h        insn32.decode  op_helper.c       time_helper.h          xthead.decode
> cpu-param.h             crypto_helper.c       insn_trans     pmp.c             trace-events           zce_helper.c
> cpu-qom.h               csr.c                 instmap.h      pmp.h             trace.h
> cpu.c                   csr.h                 internals.h    pmu.c             translate.c
> cpu.h                   debug.c               kvm            pmu.h             vcrypto_helper.c
> cpu_bits.h              debug.h               m128_helper.c  riscv-qmp-cmds.c  vector_helper.c
> 
> 
> It is non-trivial to realize that most of this stuff is TCG specific.
> Meanwhile our 'tcg' subdir is mostly empty:
> 
> $ ls target/riscv/tcg
> meson.build  tcg-cpu.c  tcg-cpu.h
> 
> If we compare it with other targets, let's say loongarch:
> 
> $ ls target/loongarch/
> Kconfig      cpu-csr.h    cpu-qom.h  cpu_helper.c  disas.c    insns.decode  loongarch-qmp-cmds.c  tcg           translate.h
> README       cpu-mmu.h    cpu.c      csr.c         gdbstub.c  internals.h   machine.c             trace-events  vec.h
> arch_dump.c  cpu-param.h  cpu.h      csr.h         helper.h   kvm           meson.build           trace.h
> $
> $ ls target/loongarch/tcg
> constant_timer.c  fpu_helper.c  insn_trans      meson.build  tcg_cpu.c        tlb_helper.c  vec_helper.c
> csr_helper.c      helper.h      iocsr_helper.c  op_helper.c  tcg_loongarch.h  translate.c
> 
> It is straightforward to see which files are TCG exclusive and which
> files are common to all accels.
> 
> And this is what we did here.  The patches goes mostly as follows:
> 
> - move stuff to 'tcg' subdir.  Most stuff is straighforward and is
>   manageable with a single patch.  Other things required some logic to
>   go to either cpu.c or tcg-cpu;
> - move TCG stuff to tcg-cpu.c;
> - move common accel stuff to cpu.c.  Usually from cpu_helper.c;
> - filter TCG specific code in cpu.c and other files;
> - trivial/assorted fixes in misc files that were needed to make
>   --disable-tcg work.
> 
> Patch 24 is taken from Zephyr Li to enable the CI for --disable-tcg.
> Hopefully we won't break it anytime soon.
> 
> After this series we have --disable-tcg working and the following dir
> structure:
> 
> $ ls target/riscv
> Kconfig                 cpu.c                 cpu_vendorid.h  internals.h       sbi_ecall_interface.h  xlrbr.decode
> XVentanaCondOps.decode  cpu.h                 gdbstub.c       kvm               tcg                    xmips.decode
> arch_dump.c             cpu_bits.h            helper.h        machine.c         time_helper.c          xthead.decode
> common-semi-target.c    cpu_cfg.h             insn16.decode   meson.build       time_helper.h
> cpu-param.h             cpu_cfg_fields.h.inc  insn32.decode   monitor.c         trace-events
> cpu-qom.h               cpu_user.h            instmap.h       riscv-qmp-cmds.c  trace.h
> $
> $ ls target/riscv/tcg
> bitmanip_helper.c  csr.h         insn_trans     op_helper.c  pmu.h      translate.c         vector_internals.h
> cpu_helper.c       debug.c       m128_helper.c  pmp.c        tcg-cpu.c  vcrypto_helper.c    zce_helper.c
> crypto_helper.c    debug.h       meson.build    pmp.h        tcg-cpu.h  vector_helper.c
> csr.c              fpu_helper.c  mips_csr.c     pmu.c        th_csr.c   vector_internals.c
> 
> 
> [1] https://lore.kernel.org/qemu-devel/20260602091753.3209261-1-fritchleybohrer@gmail.com/
> [2] https://lore.kernel.org/qemu-devel/20230711121453.59138-1-philmd@linaro.org/
> 
> 
> Daniel Henrique Barboza (22):
>   target/riscv: move TCG only files to tcg subdir
>   target/riscv/machine.c: do not migrate pmp state with kvm
>   target/riscv: move pmp files to tcg subdir
>   target/riscv: make some riscv_sysemu_ops TCG only
>   target/riscv: move pmu.h to tcg subdir
>   target/riscv: move debug.h to tcg subdir
>   target/riscv: remove csr.h from kvm-cpu.c
>   target/riscv: move csr.h to tcg subdir
>   target/riscv: move custom_csrs logic to tcg-cpu.c
>   target/riscv: move riscv_cpu_set_nmi() to tcg-cpu.c
>   target/riscv: move valid_vm_* satp arrays to cpu.c
>   target/riscv: move some irq helpers to cpu.c
>   target/riscv: move riscv_cpu_claim_interrupts to cpu.c
>   target/riscv/cpu.c: handle TCG bits of riscv_cpu_dump_state
>   target/riscv: gate riscv_cpu_update_mip with tcg_enabled()
>   target/riscv/cpu.c: filter TCG only bits in riscv_cpu_reset_hold()
>   hw/riscv/riscv_hart.c isolate tcg only bits
>   target/riscv/gdbstub.c: isolate TCG only checks
>   target/riscv: move riscv_cpu_set_rdtime_fn to riscv_aclint
>   target/riscv/tcg: remove unused riscv_cpu_get_geilen()
>   target/riscv: move riscv_cpu_set_geilen() to riscv-imsic
>   target/riscv: move riscv_cpu_set_aia_ireg_rmw_cb() to riscv_imsic
> 
> Zephyr Li (2):
>   target/riscv: Remove unused tcg/tcg.h include
>   gitlab-ci.d/crossbuilds: add riscv64 KVM-only build job
> 
>  .gitlab-ci.d/crossbuilds.yml                  |   8 +
>  hw/intc/riscv_aclint.c                        |   8 +
>  hw/intc/riscv_imsic.c                         |  24 ++
>  hw/riscv/fdt-common.c                         |  52 +++
>  hw/riscv/riscv_hart.c                         |   4 +-
>  hw/riscv/virt.c                               |   1 -
>  include/hw/riscv/fdt-common.h                 |   1 +
>  target/riscv/cpu.c                            | 316 +++++++++++++++---
>  target/riscv/cpu.h                            |  19 +-
>  target/riscv/gdbstub.c                        |  10 +-
>  target/riscv/kvm/kvm-cpu.c                    |   1 -
>  target/riscv/machine.c                        |  15 +-
>  target/riscv/meson.build                      |  17 -
>  target/riscv/monitor.c                        |   4 +-
>  target/riscv/riscv-qmp-cmds.c                 |   2 +-
>  target/riscv/{ => tcg}/bitmanip_helper.c      |   0
>  target/riscv/{ => tcg}/cpu_helper.c           | 239 +------------
>  target/riscv/{ => tcg}/crypto_helper.c        |   0
>  target/riscv/{ => tcg}/csr.c                  |  45 +--
>  target/riscv/{ => tcg}/csr.h                  |   6 +-
>  target/riscv/{ => tcg}/debug.c                |   2 +-
>  target/riscv/{ => tcg}/debug.h                |   0
>  target/riscv/{ => tcg}/fpu_helper.c           |   0
>  .../insn_trans/trans_privileged.c.inc         |   0
>  .../{ => tcg}/insn_trans/trans_rva.c.inc      |   0
>  .../{ => tcg}/insn_trans/trans_rvb.c.inc      |   0
>  .../{ => tcg}/insn_trans/trans_rvbf16.c.inc   |   0
>  .../{ => tcg}/insn_trans/trans_rvd.c.inc      |   0
>  .../{ => tcg}/insn_trans/trans_rvf.c.inc      |   0
>  .../{ => tcg}/insn_trans/trans_rvh.c.inc      |   0
>  .../{ => tcg}/insn_trans/trans_rvi.c.inc      |   0
>  .../{ => tcg}/insn_trans/trans_rvk.c.inc      |   0
>  .../{ => tcg}/insn_trans/trans_rvm.c.inc      |   0
>  .../{ => tcg}/insn_trans/trans_rvv.c.inc      |   0
>  .../{ => tcg}/insn_trans/trans_rvvk.c.inc     |   0
>  .../{ => tcg}/insn_trans/trans_rvzabha.c.inc  |   0
>  .../{ => tcg}/insn_trans/trans_rvzacas.c.inc  |   0
>  .../{ => tcg}/insn_trans/trans_rvzalasr.c.inc |   0
>  .../{ => tcg}/insn_trans/trans_rvzawrs.c.inc  |   0
>  .../{ => tcg}/insn_trans/trans_rvzce.c.inc    |   0
>  .../{ => tcg}/insn_trans/trans_rvzcmop.c.inc  |   0
>  .../{ => tcg}/insn_trans/trans_rvzfa.c.inc    |   0
>  .../{ => tcg}/insn_trans/trans_rvzfh.c.inc    |   0
>  .../{ => tcg}/insn_trans/trans_rvzicbo.c.inc  |   0
>  .../insn_trans/trans_rvzicfiss.c.inc          |   0
>  .../{ => tcg}/insn_trans/trans_rvzicond.c.inc |   0
>  .../{ => tcg}/insn_trans/trans_rvzimop.c.inc  |   0
>  .../{ => tcg}/insn_trans/trans_svinval.c.inc  |   0
>  .../{ => tcg}/insn_trans/trans_xlrbr.c.inc    |   0
>  .../{ => tcg}/insn_trans/trans_xmips.c.inc    |   0
>  .../{ => tcg}/insn_trans/trans_xthead.c.inc   |   0
>  .../insn_trans/trans_xventanacondops.c.inc    |   0
>  .../{ => tcg}/insn_trans/trans_zilsd.c.inc    |   0
>  target/riscv/{ => tcg}/m128_helper.c          |   0
>  target/riscv/tcg/meson.build                  |  31 +-
>  target/riscv/{ => tcg}/mips_csr.c             |   2 +-
>  target/riscv/{ => tcg}/op_helper.c            |   2 +-
>  target/riscv/{ => tcg}/pmp.c                  |   2 +-
>  target/riscv/{ => tcg}/pmp.h                  |   0
>  target/riscv/{ => tcg}/pmu.c                  |  52 ---
>  target/riscv/{ => tcg}/pmu.h                  |   1 -
>  target/riscv/tcg/tcg-cpu.c                    |  30 +-
>  target/riscv/{ => tcg}/th_csr.c               |   2 +-
>  target/riscv/{ => tcg}/translate.c            |   0
>  target/riscv/{ => tcg}/vcrypto_helper.c       |   0
>  target/riscv/{ => tcg}/vector_helper.c        |   0
>  target/riscv/{ => tcg}/vector_internals.c     |   0
>  target/riscv/{ => tcg}/vector_internals.h     |   0
>  target/riscv/{ => tcg}/zce_helper.c           |   0
>  target/riscv/time_helper.c                    |  33 +-
>  70 files changed, 495 insertions(+), 434 deletions(-)
>  rename target/riscv/{ => tcg}/bitmanip_helper.c (100%)
>  rename target/riscv/{ => tcg}/cpu_helper.c (92%)
>  rename target/riscv/{ => tcg}/crypto_helper.c (100%)
>  rename target/riscv/{ => tcg}/csr.c (99%)
>  rename target/riscv/{ => tcg}/csr.h (96%)
>  rename target/riscv/{ => tcg}/debug.c (99%)
>  rename target/riscv/{ => tcg}/debug.h (100%)
>  rename target/riscv/{ => tcg}/fpu_helper.c (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_privileged.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rva.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvb.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvbf16.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvd.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvf.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvh.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvi.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvk.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvm.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvv.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvvk.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzabha.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzacas.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzalasr.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzawrs.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzce.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzcmop.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzfa.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzfh.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzicbo.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzicfiss.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzicond.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_rvzimop.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_svinval.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_xlrbr.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_xmips.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_xthead.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_xventanacondops.c.inc (100%)
>  rename target/riscv/{ => tcg}/insn_trans/trans_zilsd.c.inc (100%)
>  rename target/riscv/{ => tcg}/m128_helper.c (100%)
>  rename target/riscv/{ => tcg}/mips_csr.c (99%)
>  rename target/riscv/{ => tcg}/op_helper.c (99%)
>  rename target/riscv/{ => tcg}/pmp.c (99%)
>  rename target/riscv/{ => tcg}/pmp.h (100%)
>  rename target/riscv/{ => tcg}/pmu.c (86%)
>  rename target/riscv/{ => tcg}/pmu.h (95%)
>  rename target/riscv/{ => tcg}/th_csr.c (99%)
>  rename target/riscv/{ => tcg}/translate.c (100%)
>  rename target/riscv/{ => tcg}/vcrypto_helper.c (100%)
>  rename target/riscv/{ => tcg}/vector_helper.c (100%)
>  rename target/riscv/{ => tcg}/vector_internals.c (100%)
>  rename target/riscv/{ => tcg}/vector_internals.h (100%)
>  rename target/riscv/{ => tcg}/zce_helper.c (100%)
> 

It seems like series does not apply on top of master, would that be
possible to rebase it?

Regards,
Pierrick

