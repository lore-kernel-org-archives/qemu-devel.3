Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5810ACDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc5Nr-0006zA-9M; Tue, 23 Jun 2026 13:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wc5No-0006yd-QE
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:58:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wc5Nm-0003JZ-8k
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:58:00 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NHqWhO3744694
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9v0l8bng4JLcgkLRzYPWjMte29iNB5qq9i5l0mWMQG4=; b=IBdoe158U0styUAv
 7m4oltHiCtU8yDRYNWc5Ng3RoVRADEgtL05nT+TCQ2EucTX8w8SgQxLw/xr/nkA5
 /ePKGOEX8mUMFKDteJagvW8OfFiWmX4Vo7H5xoLA0Vwa1AwK1sNUs5O10HacPHvw
 goyqGymd5wv9SSoRFReZyjk9ZqalGDBJSgIigdtkWoFhMfNBWVEHmGg2HQtU4W1B
 BfgP54GFem30bhXV1XMKX/7WtI61zcxPmR/VDA0fGvd6kzM1usYU7KkI4H1oTB2r
 mmibpVJCHrNN+WYIYNi8LThTeTbuXRnZFnEwkXbyPNVDvjupN/zaYiasBr//uJ6r
 cX6RRw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eypx3aew2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:57:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9157de5360fso252532885a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782237474; x=1782842274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9v0l8bng4JLcgkLRzYPWjMte29iNB5qq9i5l0mWMQG4=;
 b=EbnYcFq8EqqakqXRdj3hM8jN4qyUCxaxqt07o9+j85TAO5LN9QnDWXUQbHy/tg+B03
 Z+UBQmHi/nqb8TaWZU3y5LDnmilFqBVVoGBIoz8NuoerjxEuIby0AiDQgUwzI1/owGn7
 M0gqyCVAN3ApqkES8bx/sA+L42bC+T+Y4FdjGODM0oeIu9HZzRBOH/N7Qvo6qZl6/jiJ
 SOllPZ5SJzFWS8L5LMjzaV/V7+jIDOSviLdmq4louP7TJEt2ZKdeircUy7+7wxl+NV3j
 dwGxWDkKWUf0tp8skUBfG1Y9qQV3fyFJjabqTfcOoEnErmea+iVHvoBF5ljrU/zfMs8Q
 ep/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782237474; x=1782842274;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9v0l8bng4JLcgkLRzYPWjMte29iNB5qq9i5l0mWMQG4=;
 b=CC4zlItKgPTjqTS1QLjt0UmTQEyfNjKrYMMPsebBeSmcPgPTPG6o6/uHi7yUsrCie8
 ZNN0tgqTS1/0t3KIdRn7ZNqqQlpL+s7shcWAPaWtrlEWwMi1c1hecJ6i2SBOqwOPNVR0
 1pCOBvKKlCx8wozgFCnY5o3Uc/cSD9tqEP/XdilJpIBkRkD1XXofINn5ewD2UhyH8Ctt
 Lmxke88tcjLWX3p0PJYXc0YggST+MWhqvVBeapDva34zmuKYWYo0JzEz0a78LAb+vtEz
 OiMMFUCuXhi34vw3m4SP91CaO4Q4oMRZhtJKX8LM4MM6PAFFaGk4lFncdMOJeZ7+BbGR
 vpyg==
X-Gm-Message-State: AOJu0Yy3Y/h3WZ63upaFQkxxAkrGKQ88VqwYQkTyQ4kkdTVmAjv0z8Bj
 Ub6IIPp2JYd6FfFtwshlfj24+0dTnweJg4MzOCtlRk6/taX3G2VpPnbHW3I1bMvEpUStP4k0FXc
 iRgMlXwLVNqoKepCp3FYepTxlWMuio/5OfyDmOQDsXD6rfaD0tdOAcLROiq1FCpzD4A==
X-Gm-Gg: AfdE7cmGI69pqAXTG4NeISEpZGsOz6/6y40ae68cdSLH9G7nG9K9KcGZ/IyKna0Ha9h
 EbspZaYZc2g69vivXCu2Atodm7SbSXLxvcsuF0xte+6Fcd/DgVtP5XDfQDHOwrrn7vnzdO/NkPw
 FlF1FxwF+uQ3jtdn8MyktAHYM56FdWFuVTAC9u031V+vAsQ74qPdHlWK65McfN0QfUEYDklRgqR
 njmwSLI2whVGt4rkEe05LK2BqMDZU/HjvbL8cm+/uT4TBM7PEn9uJKGB+GeH5z1Hhz3laxkAl9q
 pZpewXub7ndwwpmcucVAxfeqhfjE3WetvrkmC3htmBitgpbYdzdJMP5jpTNMFw4+vd2aajzHlKy
 TGiLDPAJUKrxN4PnxgGCIwGc6/PWY14DJJTHdrIGJ5lohgKxLbzhkEI+M+tb2E58K
X-Received: by 2002:a05:620a:1a29:b0:91c:dc11:8e35 with SMTP id
 af79cd13be357-925ffecfe0fmr708667885a.1.1782237474014; 
 Tue, 23 Jun 2026 10:57:54 -0700 (PDT)
X-Received: by 2002:a05:620a:1a29:b0:91c:dc11:8e35 with SMTP id
 af79cd13be357-925ffecfe0fmr708664085a.1.1782237473247; 
 Tue, 23 Jun 2026 10:57:53 -0700 (PDT)
Received: from [10.71.189.79] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92600b82638sm318583385a.41.2026.06.23.10.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 10:57:52 -0700 (PDT)
Message-ID: <841ee482-4d6b-4f07-bcf3-011478c13fb7@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 12:57:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/75] hex queue
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
 <CAJSP0QVk6wsOnPAspC4YfXRp90saKibQfD4Mk-44-RQo0k=z3w@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJSP0QVk6wsOnPAspC4YfXRp90saKibQfD4Mk-44-RQo0k=z3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EsfiaycA c=1 sm=1 tr=0 ts=6a3ac923 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=IetE_rvxKELtVZpgSlEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: IFv4Un5S2sxqf5U_z8sg-ADwrq9ovfFo
X-Proofpoint-GUID: IFv4Un5S2sxqf5U_z8sg-ADwrq9ovfFo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE0NyBTYWx0ZWRfX3hn64MVsn8wM
 5aIpADf2UFEWRDa1lcyUm/DRa3S1H7nxy6MKkE+013jiTDYBV5NeCh7Bb48U7Hcfvt0ZpSsWxC7
 0XEfwDBHvHBRUXIIZOpk/nKdNs9OILk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE0NyBTYWx0ZWRfX1HloV+YAMUT+
 /dPikEB87Q2NjSvb+YAm+jRf6OY+e6ycfqht3CXEMUToTN8E9L2nUQd3eIJaa15CFyTAxas5nRh
 /IIO19L5As++qMpi7HBYb798tBq838+I/9XpLrxGa97kgo9SKH3AsR2dCTqhSM7UvG1dg/3YRw/
 nseXFrMi+SRnY8AM2fqNF/mP3n/cmAA3euSr3PFPGcAN2dsKPVnruUe19+y4Z97OL7gEm+VJOmK
 rI79qoTAdbTTxOstT8ALDkXM46XTO29kveyhbR0sKO0DhqMHkvnEx+sUJcDfAH6Xk/vVElSEg0C
 vKpYkZtd23gNcsYDdrwzApCqfnoQXdQhyX3ugpmE5699GsVt8qGFigFVVeTIurWCpty1o+60S6L
 dIUVHR//Gw3ZxQlJOSxiJ4zeRVpYBlfe/LfREW2B8TaXL7fM1/qoEx+Y1umc36P6JylFwOKNciZ
 UgCKYE5rbeg7Jx4DAdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230147
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


On 6/23/2026 12:22 PM, Stefan Hajnoczi wrote:
> On Mon, Jun 22, 2026 at 6:33 PM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> The following changes since commit b83371668192a705b878e909c5ae9c1233cbd5fb:
>>
>>    Merge tag 'pbouvier/pr/plugins-20260618' of https://gitlab.com/p-b-o/qemu into staging (2026-06-19 15:00:01 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/qualcomm/qemu tags/pull-hex-20260622
>>
>> for you to fetch changes up to 4f876e63daaa40bea293c2eeced2ac6418b3d13a:
>>
>>    target/hexagon/idef-parser: open input file in binary mode (2026-06-22 14:30:23 -0700)
>>
>> ----------------------------------------------------------------
>> hex queue - sysemu
>>
>> v2 PR: Fix for wasm build error in `target/hexagon/meson.build`:
>>
>>      ../target/hexagon/meson.build:285:47: ERROR: Program 'emscripten' not
>>      found or not executable
> Hi Brian,
> There is a wasm build failure:
>
> Run-time dependency libffi found: YES 3.5.2
> Program scripts/decodetree.py found: YES
> (/builds/qemu-project/qemu/build/pyvenv/bin/python3
> /builds/qemu-project/qemu/scripts/decodetree.py)
> Program ../scripts/feature_to_c.py found: YES
> (/builds/qemu-project/qemu/build/pyvenv/bin/python3
> /builds/qemu-project/qemu/gdbstub/../scripts/feature_to_c.py)
> Program flex found: NO
> ../target/hexagon/meson.build:294:8: ERROR: Program 'flex' not found
> or not executable

hmm - I think this should be coming from the host and not the target.

> https://gitlab.com/qemu-project/qemu/-/jobs/14996902150
>
> See `make docker-help` for how to run test-build locally in a
> emsdk-wasm64-cross container. The ./configure arguments are  "--static
> --cpu=wasm64 --wasm64-32bit-address-limit --disable-tools
> --enable-debug --enable-tcg-interpreter" (I got this from
> .gitlab-ci.d/buildtest.yml).

Sorry - will test it out comprehensively before v3.


> Thanks,
> Stefan
>
>> ----------------------------------------------------------------
>> Brian Cain (72):
>>        target/hexagon: use cmd_array() instead of get_id()
>>        docs: Add hexagon sysemu docs
>>        docs/system: Add hexagon CPU emulation
>>        target/hexagon: Fix badva reference, delete CAUSE
>>        target/hexagon: Add missing A_CALL attr, hintjumpr to multi_cof
>>        target/hexagon: Handle system/guest registers in gen_analyze_funcs.py and hex_common.py
>>        target/hexagon: Suppress unused-variable warnings for sysemu source regs
>>        target/hexagon: Switch to tag_ignore(), generate via get_{user,sys}_tags()
>>        target/hexagon: Add privilege check, use tag_ignore()
>>        target/hexagon: Add a placeholder fp exception
>>        target/hexagon: Add guest, system reg number defs
>>        target/hexagon: Add guest, system reg number state
>>        target/hexagon: Add TCG values for sreg, greg
>>        target/hexagon: Add guest/sys reg writes to DisasContext
>>        target/hexagon: Add imported macro, attr defs for sysemu
>>        target/hexagon: Add new macro definitions for sysemu
>>        target/hexagon: Add handlers for guest/sysreg r/w
>>        target/hexagon: Add placeholder greg/sreg r/w helpers
>>        target/hexagon: Add vmstate representation
>>        target/hexagon: Make A_PRIV, "J2_trap*" insts need_env()
>>        target/hexagon: Define register fields for system regs
>>        target/hexagon: Implement do_raise_exception()
>>        target/hexagon: Add system reg insns
>>        target/hexagon: Add sysemu TCG overrides
>>        target/hexagon: Add implicit attributes to sysemu macros
>>        target/hexagon: Add TCG overrides for int handler insts
>>        target/hexagon: Add TCG overrides for thread ctl
>>        target/hexagon: Add TCG overrides for rte, nmi
>>        target/hexagon: Add sreg_{read,write} helpers
>>        target/hexagon: Add representation to count cycles
>>        target/hexagon: Add implementation of cycle counters
>>        target/hexagon: Add pcycle setting functionality
>>        target/hexagon: Add cpu modes, mmu indices, next_PC to state
>>        hw/hexagon: Declare hexagon TLB device interface
>>        target/hexagon: Update TARGET_PAGE_BITS, stubs for modify_ssr/get_exe_mode
>>        target/hexagon: Define f{S,G}ET_FIELD macros
>>        target/hexagon: Add hex_interrupts support
>>        target/hexagon: Implement {c,}swi helpers
>>        target/hexagon: Implement iassign{r,w} helpers
>>        target/hexagon: Implement start/stop helpers, soft reset
>>        target/hexagon: Implement {g,s}etimask helpers
>>        target/hexagon: Implement wait helper
>>        target/hexagon: Implement get_exe_mode()
>>        target/hexagon: Implement hex_tlb_entry_get_perm()
>>        target/hexagon: Implement software interrupt
>>        target/hexagon: Implement stack overflow exception
>>        target/hexagon: Implement exec_interrupt, set_irq
>>        target/hexagon: Implement hexagon_tlb_fill()
>>        target/hexagon: Implement siad inst
>>        target/hexagon: Implement hexagon_resume_threads()
>>        target/hexagon: Implement setprio, resched
>>        target/hexagon: Add sysemu_ops, cpu_get_phys_page_debug()
>>        target/hexagon: extend hexagon_cpu_mmu_index() for sysemu
>>        target/hexagon: Decode trap1, rte as COF
>>        target/hexagon: Implement modify_ssr, resched, pending_interrupt
>>        target/hexagon: Add pkt_ends_tb to translation
>>        target/hexagon: Add next_PC, {s,g}reg writes
>>        target/hexagon: Add implicit sysreg writes
>>        target/hexagon: Define system, guest reg names
>>        target/hexagon: Add k0 {un,}lock
>>        target/hexagon: Add PC to raise_exception, use fTRAP() helper
>>        target/hexagon: Add TCG overrides for transfer insts
>>        target/hexagon: Add support for loadw_phys
>>        hw/hexagon: Add globalreg model
>>        hw/hexagon: Add global register tracing
>>        hw/hexagon: Add hexagon TLB device implementation
>>        hw/hexagon: Add machine configs for sysemu
>>        hw/hexagon: Add v68, sa8775-cdsp0 defs
>>        target/hexagon: add build config for softmmu
>>        hw/hexagon: Define hexagon "virt" machine
>>        tests/qtest: Add hexagon boot-serial-test
>>        target/hexagon/idef-parser: open input file in binary mode
>>
>> Matheus Tavares Bernardino (2):
>>        target/hexagon: add simple cpu_exec_reset and pointer_wrap
>>        target/hexagon: Add guest reg reading functionality
>>
>> Sid Manning (1):
>>        hw/hexagon: Add support for cfgbase
>>
>>   MAINTAINERS                                 |  16 +
>>   docs/devel/hexagon-sys.rst                  | 112 ++++++
>>   docs/devel/index-internals.rst              |   1 +
>>   docs/system/hexagon/cdsp.rst                |  12 +
>>   docs/system/hexagon/emulation.rst           |  15 +
>>   docs/system/target-hexagon.rst              | 103 +++++
>>   docs/system/targets.rst                     |   1 +
>>   configs/devices/hexagon-softmmu/default.mak |   7 +
>>   configs/targets/hexagon-softmmu.mak         |   8 +
>>   meson.build                                 |   1 +
>>   hw/hexagon/trace.h                          |   2 +
>>   include/hw/hexagon/hexagon.h                | 161 ++++++++
>>   include/hw/hexagon/hexagon_globalreg.h      |  55 +++
>>   include/hw/hexagon/hexagon_tlb.h            |  46 +++
>>   include/hw/hexagon/virt.h                   |  30 ++
>>   target/hexagon/cpu-param.h                  |   2 +-
>>   target/hexagon/cpu.h                        |  89 ++++-
>>   target/hexagon/cpu_bits.h                   |  75 +++-
>>   target/hexagon/cpu_helper.h                 |  26 ++
>>   target/hexagon/gen_tcg.h                    |  16 +-
>>   target/hexagon/gen_tcg_sys.h                | 139 +++++++
>>   target/hexagon/helper.h                     |  27 +-
>>   target/hexagon/hex_interrupts.h             |  15 +
>>   target/hexagon/hex_mmu.h                    |  26 ++
>>   target/hexagon/hex_regs.h                   | 117 ++++++
>>   target/hexagon/hexswi.h                     |  17 +
>>   target/hexagon/idef-parser/parser-helpers.h |   2 +
>>   target/hexagon/internal.h                   |  22 ++
>>   target/hexagon/macros.h                     |  38 +-
>>   target/hexagon/sys_macros.h                 | 252 ++++++++++++
>>   target/hexagon/translate.h                  |  47 +++
>>   hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc   |  64 ++++
>>   hw/hexagon/machine_cfg_v66g_1024.h.inc      |  64 ++++
>>   hw/hexagon/machine_cfg_v68n_1024.h.inc      |  65 ++++
>>   target/hexagon/attribs_def.h.inc            |  35 +-
>>   target/hexagon/reg_fields_def.h.inc         | 107 ++++++
>>   hw/hexagon/hexagon_dsp.c                    | 225 +++++++++++
>>   hw/hexagon/hexagon_globalreg.c              | 316 +++++++++++++++
>>   hw/hexagon/hexagon_tlb.c                    | 467 ++++++++++++++++++++++
>>   hw/hexagon/virt.c                           | 347 +++++++++++++++++
>>   linux-user/hexagon/cpu_loop.c               |  23 ++
>>   system/qdev-monitor.c                       |   2 +-
>>   target/hexagon/arch.c                       |   5 +
>>   target/hexagon/cpu.c                        | 422 +++++++++++++++++++-
>>   target/hexagon/cpu_helper.c                 | 399 +++++++++++++++++++
>>   target/hexagon/decode.c                     |  14 +
>>   target/hexagon/genptr.c                     | 173 ++++++++-
>>   target/hexagon/hex_interrupts.c             | 371 ++++++++++++++++++
>>   target/hexagon/hex_mmu.c                    | 270 +++++++++++++
>>   target/hexagon/hexswi.c                     | 271 +++++++++++++
>>   target/hexagon/idef-parser/parser-helpers.c |   9 +
>>   target/hexagon/machine.c                    |  32 ++
>>   target/hexagon/op_helper.c                  | 576 +++++++++++++++++++++++++++-
>>   target/hexagon/translate.c                  | 265 ++++++++++++-
>>   tests/qtest/boot-serial-test.c              |   8 +
>>   hw/Kconfig                                  |   1 +
>>   hw/hexagon/Kconfig                          |  14 +
>>   hw/hexagon/meson.build                      |   7 +
>>   hw/hexagon/trace-events                     |   3 +
>>   hw/meson.build                              |   1 +
>>   target/Kconfig                              |   1 +
>>   target/hexagon/Kconfig                      |   2 +
>>   target/hexagon/gen_analyze_funcs.py         |  14 +-
>>   target/hexagon/gen_helper_funcs.py          |  26 +-
>>   target/hexagon/gen_helper_protos.py         |  23 +-
>>   target/hexagon/gen_idef_parser_funcs.py     |   2 +
>>   target/hexagon/gen_op_attribs.py            |   2 +-
>>   target/hexagon/gen_opcodes_def.py           |   5 +-
>>   target/hexagon/gen_tcg_funcs.py             |  35 +-
>>   target/hexagon/hex_common.py                | 184 ++++++++-
>>   target/hexagon/idef-parser/idef-parser.y    |   5 +-
>>   target/hexagon/imported/encode_pp.def       | 129 ++++++-
>>   target/hexagon/imported/ldst.idef           |   3 +
>>   target/hexagon/imported/macros.def          | 482 ++++++++++++++++++++++-
>>   target/hexagon/imported/system.idef         | 244 +++++++++++-
>>   target/hexagon/meson.build                  |  30 +-
>>   tests/qemu-iotests/testenv.py               |   1 +
>>   tests/qtest/meson.build                     |   2 +
>>   78 files changed, 7076 insertions(+), 150 deletions(-)
>>   create mode 100644 docs/devel/hexagon-sys.rst
>>   create mode 100644 docs/system/hexagon/cdsp.rst
>>   create mode 100644 docs/system/hexagon/emulation.rst
>>   create mode 100644 docs/system/target-hexagon.rst
>>   create mode 100644 configs/devices/hexagon-softmmu/default.mak
>>   create mode 100644 configs/targets/hexagon-softmmu.mak
>>   create mode 100644 hw/hexagon/trace.h
>>   create mode 100644 include/hw/hexagon/hexagon.h
>>   create mode 100644 include/hw/hexagon/hexagon_globalreg.h
>>   create mode 100644 include/hw/hexagon/hexagon_tlb.h
>>   create mode 100644 include/hw/hexagon/virt.h
>>   create mode 100644 target/hexagon/cpu_helper.h
>>   create mode 100644 target/hexagon/gen_tcg_sys.h
>>   create mode 100644 target/hexagon/hex_interrupts.h
>>   create mode 100644 target/hexagon/hex_mmu.h
>>   create mode 100644 target/hexagon/hexswi.h
>>   create mode 100644 target/hexagon/sys_macros.h
>>   create mode 100644 hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
>>   create mode 100644 hw/hexagon/machine_cfg_v66g_1024.h.inc
>>   create mode 100644 hw/hexagon/machine_cfg_v68n_1024.h.inc
>>   create mode 100644 hw/hexagon/hexagon_dsp.c
>>   create mode 100644 hw/hexagon/hexagon_globalreg.c
>>   create mode 100644 hw/hexagon/hexagon_tlb.c
>>   create mode 100644 hw/hexagon/virt.c
>>   create mode 100644 target/hexagon/cpu_helper.c
>>   create mode 100644 target/hexagon/hex_interrupts.c
>>   create mode 100644 target/hexagon/hex_mmu.c
>>   create mode 100644 target/hexagon/hexswi.c
>>   create mode 100644 target/hexagon/machine.c
>>   create mode 100644 hw/hexagon/Kconfig
>>   create mode 100644 hw/hexagon/meson.build
>>   create mode 100644 hw/hexagon/trace-events
>>   create mode 100644 target/hexagon/Kconfig
>>   mode change 100755 => 100644 target/hexagon/imported/macros.def

