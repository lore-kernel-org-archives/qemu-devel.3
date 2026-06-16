Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1723CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 20:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZa8y-0004nm-9W; Tue, 16 Jun 2026 16:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZa8v-0004nS-M1
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 16:12:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZa8t-0004B8-GM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 16:12:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOWXB382243
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 20:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qx9YiqQHXH4hCVfkGEEARK6i4A5nlJRppFTXe3Pfw3U=; b=BLTaYyfvo1BwWSQt
 5wDpF2JPAeJakSiVeerp1aumLy0ZvaODLoM8bHU6DrZvJHB0RJmJdgtjKmDxiFgF
 HCzsE+thQBUNLagK6UZ+WZvu42wfHj0AjM6ZefuxR3jcieyZ+WOK3nhq0EgdUJm8
 7D8KGliYG8R/fsqF+fVFfrIG1s/i3qkkV/BMBib8jGFHIA9fmRl7iHuJRulVOoyU
 CFB2mCVouNRARDY3TRHe8/DINiKjVx/iqUGZkxnCVdvyciJnccfvaMM0a+Rdc4TK
 l0fMQrz0h9kC8RTeojeFVLr4/akRLIN6h50Lf0e8vJ8lEsheiQuOEV2tE0p0FWfk
 IfGUrQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu4dkjx8t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 20:12:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-517878a92c5so87022381cf.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781640732; x=1782245532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qx9YiqQHXH4hCVfkGEEARK6i4A5nlJRppFTXe3Pfw3U=;
 b=LhVfwq3KTV9Zi13Sv0UuS9b1NPyf5Og4PKisor4FdVK3dvFi1NhcCT9B5VlSgfcn2e
 K4IEz7ovfCuBqmpSHqZmalqea/bfvgKZTg3Zy/8e/DlCa5K4C4iFeK/izALZ5rm5PZnx
 LeV9hW9nA6Z6tzBF/ylw0jHtHwTYuDl/3ySblx5UJ/hJ/0pLIcFUDdOJjPV8OjwPBnzz
 woJ/RTa9vnzqtHB8FD9ZUr/OtkszZwKi8ypo6y7GY1ZiKrG9k5UqCPXJuipBXfP8zYK5
 ske7L8/shQHFH03GwsgevKVhcCdVMzROcE20N1bnepvoDhBcuItl1Ut2B7l2pj3uVm5U
 yCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781640732; x=1782245532;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qx9YiqQHXH4hCVfkGEEARK6i4A5nlJRppFTXe3Pfw3U=;
 b=cSvuriNlEOwKfu2P+YN85TxhMmufzN24X+46UlqPIgwTX5UO73LH+Cbr9JbrUIyG+F
 qkP0rexkZ/3Wf6FhLR+ekor1M9HxulQVT/SZD0L82pXGA2EN/FeSS63eS54spcpo2qwy
 eOkE2hB/rls/TnjFzRdYqHltxp+sEuIEl+9e9waVOI6UE6z7JwBu0Hz+sXKyZP9/aYUZ
 dq+aZtwo3XPIpz6ah//yqHt3IOYlrueeKg2M7CyCqZi0a/2sYv9LxcLeZpTXlkImWr+o
 xUoV/cyJFuCOYRJtwtcE51LvvzF7lqt+p1+W8s8TGnBzFR7nnSnPSEkjGDrTOWd9ZgnR
 UaXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/84l2gbOzhEPzs5obj6SZRZCyh+HtLrj3Qgyhq5PzpEkioMxE0mrzyPJE1pidCkqd/r0csihAhqEaX@nongnu.org
X-Gm-Message-State: AOJu0YxIYWFiUhv8Rk2xKZ3XTh9ixrj67vQv+jwfbLxKZbyuK3xoKqPm
 9j5sNd96JlmHjAGJ1Lo2p3xipg9jAwyXpJ6lXEqugZ03dBtsJdwHzzAWLIbXxW8YUKtGKzkL2r/
 xwdgJfZuVXEknU9VUkY1fuAYx0FAPWtei1Yj81zGgA7H22igUSwheDoNvXw==
X-Gm-Gg: Acq92OH7K97O/rZyeS+CGAFZBAnnKczHg3dXop13SS1N4/6LTaPUcK05tAcqUdJmyB+
 fBNeiX0BYRX1X/QJGcJibzhS9WNKuZ4PY0OTinsPO6BmPodDRLbGCcygNyLWAByhXy68vk5Xtdc
 KbQIiDQv0cx6vwU5MON6/y92ZI4GVoCJQMngvGK1rGf6v3mjZn0e4A6Mi/y9z2OoQwphE5TBuPj
 RfN7Hp2I5diyjUjt91bkHoqYl9yPySiVV/Edy6eNqV+wF4Lne9jJjRs/qDS4ubHsaJpvGV5o6m3
 NBPuleyWx8hnwx2x8fSuSRQ8BgDvwGyGXk2ivF2t7pUvAAGLw799E+jkOadrIqsa40Bz9VNGA/S
 3W59ozh5gDI/rT6UIa1zmxLHN1NxTOB3xtkcKES8tusol3XkuXwXLXwh6Nw==
X-Received: by 2002:a05:622a:15:b0:50b:86f5:8fbc with SMTP id
 d75a77b69052e-519a900e14bmr14840051cf.51.1781640732377; 
 Tue, 16 Jun 2026 13:12:12 -0700 (PDT)
X-Received: by 2002:a05:622a:15:b0:50b:86f5:8fbc with SMTP id
 d75a77b69052e-519a900e14bmr14839421cf.51.1781640731840; 
 Tue, 16 Jun 2026 13:12:11 -0700 (PDT)
Received: from [192.168.68.103] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f14168f0sm48219766d6.6.2026.06.16.13.12.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 13:12:11 -0700 (PDT)
Message-ID: <b0a93da1-2a32-4d57-8958-04327b6742c1@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 17:12:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/83] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>, alistair23@gmail.com,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>, Anton Johansson <anjo@rev.ng>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
 <b72bbbc2-2195-44e5-a2b8-359aaba21091@tls.msk.ru>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b72bbbc2-2195-44e5-a2b8-359aaba21091@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0BtvMlS7RI7gFDHd1P5DXLU7ZHdYyS2Z
X-Proofpoint-ORIG-GUID: 0BtvMlS7RI7gFDHd1P5DXLU7ZHdYyS2Z
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a31ae1d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8
 a=gjiqKltb-epK48Dx2zYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDIwNCBTYWx0ZWRfX4AN9ohnUEEnF
 7ThHLz8mcY7L6DZrywNt97+5kqW2tEMJUXgnRpq35+6fd3lW5Ism0MgBxitBzWQEKVRZdXo8cUq
 04yM8rScs0/tCZOBGdXgfcZ9SXCRyTBaAxSsz4LSgztR9X40KeoZwl5A9R0j5TzK6Lr2o5eDIzb
 jEByQKbo8nUqR/WAq1SVpW7TAeJSZB3KFNfMJZbbKdIT8Y/FjJMgXE8i8SSFJEfy7+m5dwXBx3o
 B7P05iTHCAZYX16S8N5gqm6PK+F6809eafrIwqkUxSU1HbvQhPnnP2ADPDNwnIyTZXRsm23mSIJ
 X1N4cypKqACXDW+O0MLEqckERREoi5+hTZ71GEAwBHfGQ00iOjMlmcN2gyRdCuzYkwnj0joBZgE
 gG67P1BmqOVBTIoJMgQNVw9jfVNXwU9NQYWf7TuFqIsXPjEZNEQcfMfVkzG0LUCqsAvBiziKuBh
 hfWtDOWq9/Q2Gi9gQyA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDIwNCBTYWx0ZWRfX1x/LhA/X5oXC
 d+3048Qn90dN/OWJgPm+/3UwCRTpu3jFoO1ExUOD4AyzGv5XHekdawtgyD5+AxDjYSNYGDeH4iD
 XCEY5jgXxbViE+f37SUYs2mU/iH8hn8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160204
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Michael!


On 6/16/2026 4:49 PM, Michael Tokarev wrote:
> On 16.06.2026 13:04, alistair23@gmail.com wrote:
>> From: Alistair Francis <alistair.francis@wdc.com>
>>
>> The following changes since commit 2f28d34ea0aead9830478cd1d3d0dd9d9191d82e:
>>
>>    Merge tag 'pull-tcg-20260612' of https://gitlab.com/rth7680/qemu into staging (2026-06-13 14:02:34 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260616
>>
>> for you to fetch changes up to e968e487acf082279118667f495a3f4275a59d59:
>>
>>    hw/riscv: add create_fdt_socket_cpu_sifive() (2026-06-16 20:01:11 +1000)
>>
>> ----------------------------------------------------------------
>> RISC-V PR for 11.1
>>
>> * Disable svpbmt if satp_mode is less then sv39
>> * Fix PMP address alignment
>> * Mstatus write bug fixes
>> * Add 'cbo' insns to disassembler
>> * Do not hide Sstc CSRs from gdbstub
>> * Reject Svinval instructions in U-mode
>> * Save opcode before zicbo helpers
>> * Fault with reserved PTE.PBMT val
>> * Allow LOAD_ADDR_MIS promotion to AMO fault
>> * Make riscv cpu.h target independent
>> * Add PMA access fault
>> * Disable svnapot if satp_mode is less then sv39
>> * Fix disassembler inst_length calculation
>> * Add RISC-V big-endian target support
>> * Add the implied rules for G and B extensions
>> * Print privilege level and ELP in riscv_cpu_dump_state
>> * Improve alignment in riscv_cpu_dump_state
>> * Mask vxrm csrw write to the low 2 bits
>> * Reorder Smrnmi CPU fields above CPU reset line
>> * Supplement cpu topology arguments
>> * Don't insert DDT cache in Bare mode
>> * Fix 'iommu-map' FDT entry
>> * Fix mstatus.FS dirty tracking for FP exception-raising instructions
>> * Enable `mnret` disassembly
>> * Add support for K230 board
>> * FDT creation helpers
>>
>> ----------------------------------------------------------------
>> Abhigyan Kumar (1):
>>        target/riscv: mask vxrm csrw write to the low 2 bits
>>
>> Anton Blanchard (2):
>>        target/riscv: Print privilege level and ELP in riscv_cpu_dump_state
>>        target/riscv: Improve alignment in riscv_cpu_dump_state
>>
>> Anton Johansson (27):
>>        target/riscv: Fix size of gpr and gprh
>>        target/riscv: Fix size of vector CSRs
>>        target/riscv: Fix size of pc, load_[val|res]
>>        target/riscv: Fix size of frm and fflags
>>        target/riscv: Fix size of badaddr and bins
>>        target/riscv: Fix size of guest_phys_fault_addr
>>        target/riscv: Fix size of priv_ver and vext_ver
>>        target/riscv: Fix size of retxh
>>        target/riscv: Fix size of ssp
>>        target/riscv: Fix size of excp_uw2
>>        target/riscv: Fix size of sw_check_code
>>        target/riscv: Fix size of priv
>>        target/riscv: Fix size of gei fields
>>        target/riscv: Fix size of [m|s|vs]iselect fields
>>        target/riscv: Fix arguments to board IMSIC emulation callbacks
>>        target/riscv: Fix size of irq_overflow_left
>>        target/riscv: Indent PMUFixedCtrState correctly
>>        target/riscv: Replace target_ulong in riscv_cpu_get_trap_name()
>>        target/riscv: Replace target_ulong in riscv_ctr_add_entry()
>>        target/riscv: Fix size of trigger data
>>        target/riscv: Fix size of mseccfg
>>        target/riscv: Move debug.h include away from cpu.h
>>        target/riscv: Move CSR declarations to separate csr.h header
>>        target/riscv: Introduce externally facing CSR access functions
>>        target/riscv: Make pmp.h target_ulong agnostic
>>        target/riscv: Pass address as uint64_t in cpu_set_exception_base()
>>        target/riscv: Fix pmp.h/cpu.h circular inclusion
>>
>> Chao Liu (5):
>>        target/riscv: add thead-c908 cpu support
>>        hw/riscv: add k230 board initial support
>>        hw/watchdog: add k230 watchdog initial support
>>        tests/qtest: add test for K230 watchdog
>>        docs/system/riscv: add documentation for k230 machine
>>
>> Daniel Henrique Barboza (24):
>>        target/riscv/tcg: disable svpbmt if satp_mode < sv39
>>        target/riscv/csr.c: do not allow mstatus MPV/GVA writes
>>        target/riscv/csr.c: fix mstatus.UXL reserved value
>>        disas/riscv.c: add 'cbo' insns to disassembler
>>        target/riscv/insn_trans/trans_rvzicbo.c.inc: save opcode before helpers
>>        target/riscv/cpu_helper.c: fault with reserved PTE.PBMT val
>>        target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion to AMO fault
>>        target/riscv/cpu_helper.c: add PMA access fault
>>        target/riscv/tcg: disable svnapot if satp_mode < sv39
>>        disas/riscv.c: fix inst_length()
>>        hw/riscv/virt.c: fix 'iommu-map' FDT entry
>>        hw/riscv/sifive_u.c: add a FDT phandle to cpu-intc
>>        hw/riscv: add fdt-common helper
>>        hw/riscv/numa: make numa_enabled() public
>>        hw/riscv: add create_fdt_socket_memory() helper
>>        hw/riscv/sifive_u.c: add intc_phandles array
>>        hw/riscv/spike.c: add intc_phandles array
>>        hw/riscv: add create_fdt_clint() helper
>>        hw/riscv/sifive_u.c: add cpu-map, cluster and core DTs
>>        hw/riscv: add fdt_create_cpu_socket_subnode() helper
>>        hw/riscv: add create_fdt_socket_cpus()
>>        hw/riscv/spike.c: use create_fdt_socket_cpus()
>>        hw/riscv/fdt_common.c: create create_fdt_socket_cpu_internal()
>>        hw/riscv: add create_fdt_socket_cpu_sifive()
>>
>> Djordje Todorovic (6):
>>        target/riscv: Implement runtime data endianness via MSTATUS bits
>>        target/riscv: Fix page table walk endianness for big-endian harts
>>        target/riscv: Add big-endian CPU configuration field and reset logic
>>        hw/riscv/boot: Honour data endianness
>>        target/riscv: Expose and document the CPU 'big-endian' property
>>        tests/functional: Add RISC-V endianness test
>>
>> Frank Chang (2):
>>        target/riscv: Add standard B extension implied rule
>>        target/riscv: Reorder Smrnmi CPU fields above CPU reset line
>>
>> Jay Chang (4):
>>        target/riscv: Align pmp size to pmp-granularity
>>        target/riscv: Improve PMP address alignment readability
>>        hw/riscv: Don't insert DDT cache in Bare mode
>>        hw/riscv: Refactor riscv_iommu_ctx_put() for Bare mode handling
>>
>> Jim Shu (1):
>>        target/riscv: Add the implied rule for G extension
>>
>> Max Chou (2):
>>        target/riscv: Set mstatus.FS dirty when scalar FP raises exceptions
>>        target/riscv: rvv: Set mstatus.FS dirty when vector FP raises exceptions
>>
>> Philippe Mathieu-Daudé (5):
>>        target/riscv: Initialize DisasContext::mo_endian once
>>        target/riscv: De-indent some code in get_physical_address()
>>        target/riscv: Remove target_ulong use in get_physical_address()
>>        hw/riscv/boot: Rewrite setup_rom_reset_vec() using load/store API
>>        hw/riscv/boot: Replace cpu_to_le32() -> const_le32()
>>
>> Xuemei Liu (1):
>>        hw/riscv/numa.c: Supplement cpu topology arguments
>>
>> Zephyr Li (2):
>>        target/riscv: Do not hide Sstc CSRs from gdbstub
>>        target/riscv: Reject Svinval instructions in U-mode
>>
>> imaginos (1):
>>        disas/riscv: enable `mnret` disassembly
> 
> Hi!
> 
> Is there anything here worth picking up for the stable series?
> The "target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion to
> AMO fault" has Cc: stable, so I picked it up.


 From my patches I believe you can pick all the patches that have a "Resolves"
tag.  All of them are fixing stuff introduced several releases ago that people
on Gitlab found.  Should apply without too much hassle in stable 10.0.x and
above.


Thanks,
Daniel

> 
> Thanks,
> 
> /mjt


