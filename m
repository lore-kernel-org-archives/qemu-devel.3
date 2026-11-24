Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E40606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kPsf3aTo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XuMtvnRO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVt95-0008Ag-GM; Tue, 24 Nov 2026 11:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVt90-00089J-9Q
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 11:13:23 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVt8x-0001DQ-Ku
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 11:13:22 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFL8UY1696920
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 16:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /AYPQQmmExJ/bArdg/hnXvAX3qAATfSXQTZhVZHAXjs=; b=kPsf3aTofUD6BKtw
 EZpdW+e+Z4i6MaPptgHQ22KbFxWAvc10+H1XE26T0G19n560ZG5LdLQ9FS/OkU0B
 A1roecn8Z7BgvWZ1Kz8DJJUwc2hSI+rweL30T1qDtFvyNxSWWxTIfcwCfF4TiY4F
 1LhpmSYsdKlvodjX3zkvVLU5HbZumZfaXZ/B8i6p4xL08k2GQ4bZ8zAjzuqMAm1p
 yATWKv8dy1Hmi3DHi+VVFAR/y3U9msYnBN539WKg5NioX3qzSCgB6BqeSwnQbWca
 u7m9Qv0DYxV218//UBmQytTHXT8vaoB2NMhh7L1i1dZvr6VU9N+Ojf6AA+ooXnZw
 Xw3fAQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5b800v7g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 16:13:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-92126ecb4b8so82802596d6.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 08:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795536796; x=1796141596; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/AYPQQmmExJ/bArdg/hnXvAX3qAATfSXQTZhVZHAXjs=;
 b=XuMtvnROwfjf6JnSb7rQJ73HHwkByzAXM4xFxIvxzEfkhqMf3lWuIsyE+6jhdpieIg
 cBAoNe9c7R5p7lA17dGvWTTN9rhP7qGqTTb0RzCXL7U8bwJO0B498ekl4zRKCw/hqTkB
 gVX/GN+AKhi19RwArnTmig/skDn2spnzOMiydrsCmPeG+GbQBQ7Tvde+BmLWeADbiBaU
 MXxv/n3EKUbBNkH3aiuvF6jIxX4X4SKrLOMCRL0lIOj8nlzUTdkJ3NMbbq3RIjLhT5OS
 qR08wre0oIMuyXMu2zpa29LlV+aIJZ4n7VU4GtPlQZYyp56ViQjnsF0q65ftpoedv/Tm
 lBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795536796; x=1796141596;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/AYPQQmmExJ/bArdg/hnXvAX3qAATfSXQTZhVZHAXjs=;
 b=qdjU5LqALZt05RSrKwq5a2lhdp1OWi/6N/DCz5YPdVbwxkfyX4nakWw3mvjGxYO5ZO
 Gnnibr1ojSZQJAPfRQIa6apV58tiEzI5paAnkrOQ5F9zBSzRDTB3Esu2cXw+TiWoounU
 QakmDrPHk5KhYiV/Vc1K/ohawKbIvwVDpz38m234ADJhvytZ57v0kOYfEBCaKFSMAcNz
 dbj7S0/gCKoTvpU8GQnXzVIjgkbO57J/6VAx1wzaKGL5JkWyoYWLMVXuM09BXRoD2DOZ
 Nyt9I+KO75pcAGbQjZTswAtF4+zz4aopbKsCJBchJtixEEBK/bOyWnVgHcJjCVyBTxSk
 sgyQ==
X-Gm-Message-State: APuU4Z8x19imuIhbWJCdGLXAv73YaB3IxjmipCrIbsL6Lc8/QkCMyyke
 +waiGRHNAs9U4lcwoe4+LyPsx86zYb9M7meqBezWHnkhFbTPBZuLGMxWSQNlOUuJK5i8MhfhqTv
 sje5Lho7+19S0EPR0+Ygm6w3n57MO4cnEXIPEBeSkYenQd+t1QnwiFtLQdg==
X-Gm-Gg: AZFdTZcomUKEySo0oyCN5tXp5hhQ7hEAoaR29Pli3u5vE05du6T7VfqjV81Dp0rXbH3
 p4H7wzyEeHR6CgmkuJ4LT7fZi63tgNPHc/h/R6MdJsQXztJ6BVlPJ/B5FQkcfigyjSivZ3C2tG4
 bElAHwdrqIyzS1UGKe1uqft70vS5CwP7VlM/jJprHdz4oi+wlYTtgfZnu4a3FI9ihMi2vw5yCcw
 IjEnLuGriqjEewc+P1WipDgtNGJk5G9GGKzrF0pvQI8kW8++JRV2vSgguqVSjyuyEN6xPcRu0HQ
 5SDSQ+ce5WxJjhupnPY4SDatmpgtVo+AvNvDn+P0ByAl7CXRY8H1FNqwbkh1Dh25nUoLzcWW9mW
 Xkv8JxkFzSBuL91O617Bo+yJNseHoVlXy6vUHeFqVKvocEWerNr1O1v2/Rv5kxHdUWX6k7IOl7w
 6Sx/BKGzhi
X-Received: by 2002:ac8:5d09:0:b0:535:a20:8277 with SMTP id
 d75a77b69052e-55d769940e9mr281913721cf.10.1795536795160; 
 Tue, 24 Nov 2026 08:13:15 -0800 (PST)
X-Received: by 2002:ac8:5d09:0:b0:535:a20:8277 with SMTP id
 d75a77b69052e-55d769940e9mr281912841cf.10.1795536794488; 
 Tue, 24 Nov 2026 08:13:14 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d78811fd5sm132540511cf.8.2026.11.24.08.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 08:13:13 -0800 (PST)
Message-ID: <67da6667-477e-4c94-a678-7c5345c8600b@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 13:13:09 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: make Zicfiss CBO checks independent of TLB
 state
To: Abhigyan Kumar <314abh@gmail.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20261114215908.260568-1-314abh@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261114215908.260568-1-314abh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2MyBTYWx0ZWRfX1G4Xkz2L7A27
 /iTqp9+Uk1RGf8H6CcAXOLp7nAr6L9SKCgBSWm+6N1waygtnHNprNbjR8K+VpJciwPj1ozaAh4W
 aL1Svn5kOC/p+z2+zcqmjOpYj2rJnLZ4grCd5jlnYhnP9ZsD4mgfaU6t1bFj2yzh6Dk4N9LOGf0
 Ae88jdrTK/k7QIwxkWkDLCCTG/AiHjzXyuNvQapzNy/LYudNhvVa8fSAKLZm/VyOcNIUWGP7ZXq
 oNIxAtwNS9VcdVMxoMCnGe7dVFnzdQ/h+dd2CkdnHC11LsSp1hK9Rmo697e+exqWqqlflUv/nzt
 y/AqLbbBvpwgKUbMK98zRBsKQsJjHYwj6v8ZPQjCsIFpANXAZSRa8r3GHrJ2h1Lnt2zMX3GIFdt
 0jFIlG3+7M6KdIKmPgwKFsJq678gjG4WM/bNBJIC8oPMtlpd0JvHOCRh/LFJTkSc43ClPk+Qyd5
 EZm45aTe2O2R1C7PuVw==
X-Authority-Analysis: v=2.4 cv=K5W3jCWI c=1 sm=1 tr=0 ts=6b05b79c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=Dezw0IVeCP2Y-Kh92igA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: tlQmHjOx4K-OF7NfM4DL6kTTEl074AJj
X-Proofpoint-GUID: tlQmHjOx4K-OF7NfM4DL6kTTEl074AJj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2MyBTYWx0ZWRfX6ZOZfyJf2mcg
 8gT6fm2j2ng1PsRo5Z6GWERl6xwMTmGzPtmRdpKWiaPYJaIQmsBCI9QiKuC5WVVkEzIUhu7bub9
 l8qwh7JOgurbXAnsJlRP3j1jtzKfRSI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240063
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,


This patch fails to build, at least in my env, when applied on top of
alistair/riscv-to-apply.next (https://github.com/alistair23/qemu):

[1889/2854] Compiling C object libqemu-riscv64-softmmu.a.p/target_riscv_tcg_op_helper.c.o
FAILED: libqemu-riscv64-softmmu.a.p/target_riscv_tcg_op_helper.c.o
cc -Ilibqemu-riscv64-softmmu.a.p -I. -I.. -Itarget/riscv -I../target/riscv -Isubprojects/libvduse -I../subprojects/libvduse -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/pixman-1 -I/usr/include/glib-2.0 -I/usr/lib/aarch64-linux-gnu/glib-2.0/include -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/gio-unix-2.0 -I/usr/include/slirp -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O2 -g -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing 
-fno-common -fwrapv -ftrivial-auto-var-init=zero -fzero-call-used-regs=used-gpr -fstack-protector-strong -Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-overflow=2 -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wredundant-decls -Wshadow=local -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs 
-Wno-psabi -Wno-shift-negative-value -isystem /home/dbarboza/work/qemu/linux-headers -isystem linux-headers -iquote . -iquote /home/dbarboza/work/qemu -iquote /home/dbarboza/work/qemu/include -iquote /home/dbarboza/work/qemu/host/include/aarch64 -iquote /home/dbarboza/work/qemu/host/include/generic -iquote /home/dbarboza/work/qemu/tcg/aarch64 -fPIE -pthread -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=600 -DNCURSES_WIDECHAR=1 -isystem../linux-headers -isystemlinux-headers -DCOMPILING_PER_TARGET 
'-DCONFIG_TARGET="riscv64-softmmu-config-target.h"' -DTARGET_ARCH_PREFIX=target_riscv '-DCONFIG_DEVICES="riscv64-softmmu-config-devices.h"' -MD -MQ libqemu-riscv64-softmmu.a.p/target_riscv_tcg_op_helper.c.o -MF libqemu-riscv64-softmmu.a.p/target_riscv_tcg_op_helper.c.o.d -o libqemu-riscv64-softmmu.a.p/target_riscv_tcg_op_helper.c.o -c ../target/riscv/tcg/op_helper.c
../target/riscv/tcg/op_helper.c: In function ‘check_zicbom_access’:
../target/riscv/tcg/op_helper.c:237:14: error: unused variable ‘fault_addr’ [-Werror=unused-variable]
   237 |     uint64_t fault_addr = address;
       |              ^~~~~~~~~~
cc1: all warnings being treated as errors


This happens because 'fault_addr' is being used only inside the #ifdef:


#ifdef CONFIG_USER_ONLY
     ret = probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
                              mmu_idx, true, &phost, ra);
     if (ret & TLB_MMIO) {
         env->badaddr = fault_addr;
         riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ACCESS_FAULT, ra);
     } else if (ret != TLB_INVALID_MASK) {
         /* Success: readable */
         return;
     }
#else
(...)
#endif


And, for riscv64-softmmu builds, the variable will be left unused and gcc will nag about it.


Can you please rebase the patch on top of alistair/riscv-to-apply.next branch
and re-send?  Thanks,

Daniel


On 11/14/2026 6:59 PM, Abhigyan Kumar wrote:
> The Zicfiss extension requires CBO.CLEAN/FLUSH/INVAL on a shadow stack
> page to raise a store/AMO access fault. Citing section 15.1.2.3 ("Shadow
> Stack Memory Protection") of the RISC-V spec:
> 
>      "Memory mapped as an SS page cannot be written to by instructions
>      other than SSAMOSWAP.W/D, SSPUSH, and C.SSPUSH. Attempts will raise
>      a store/AMO access-fault exception. Access to a SS page using
>      cache-block operation (CBO.*) instructions is not permitted. Such
>      accesses will raise a store/AMO access-fault exception. Implicit
>      accesses, including instruction fetches to an SS page, are not
>      permitted. Such accesses will raise an access-fault exception
>      appropriate to the access type. However, the shadow stack is
>      readable by all instructions that only load from memory."
> 
> Currently, CBO.* instructions quietly return when operated on a shadow
> stack page. check_zicomb_access probes pages for read with non-fault
> set. Then, get_physical_address reports a shadow stack page as
> unreadable when called from a probing tlb_fill. But it only works when
> probe reaches tlb_fill. After a usual load, probe hits TLB and reports
> the page as readable. Hence, causing CBOs to quietly return.
> 
> This commit introduces CPUTLBEntryFull.extra.riscv.sstack as
> a marker for shadow stack pages inside TLB entries. When riscv.sstack is
> set, check_zicbom_access falls through it to probe_write.
> 
> With this commit, the now-redundant special case in get_physical_address
> for probe is removed. is_probe in a call to get_physical_address is
> replaced with is_sstack_page. As a side effect non-fault probes of
> shadow stack pages no longer see them as unreadable, matching what a
> usual load does.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4789
> Fixes: 669b4867495c ("target/riscv: mmu changes for zicfiss shadow stack protection")
> Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
> ---
>   include/hw/core/cpu.h         |  5 ++++
>   target/riscv/tcg/cpu_helper.c | 49 +++++++++++++++++++++++++----------
>   target/riscv/tcg/op_helper.c  | 16 ++++++++++++
>   3 files changed, 57 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 5b7c330047..71666a5497 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -277,6 +277,11 @@ struct CPUTLBEntryFull {
>               uint8_t shareability;
>               bool guarded;
>           } arm;
> +
> +        struct {
> +            /* Zicfiss shadow stack page. */
> +            bool sstack;
> +        } riscv;
>       } extra;
>   };
>   
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> index 58e98e975c..d1b902fea2 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -1096,7 +1096,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>                                   hwaddr *fault_pte_addr,
>                                   int access_type, int mmu_idx,
>                                   bool first_stage, bool two_stage,
> -                                bool is_debug, bool is_probe)
> +                                bool is_debug, bool *is_sstack_page)
>   {
>       /*
>        * NOTE: the env->pc value visible here will not be
> @@ -1254,7 +1254,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>               int vbase_ret = get_physical_address(env, &vbase, &vbase_prot,
>                                                    base, NULL, MMU_DATA_LOAD,
>                                                    MMUIdx_U, false, true,
> -                                                 is_debug, false);
> +                                                 is_debug, NULL);
>   
>               if (vbase_ret != TRANSLATE_SUCCESS) {
>                   if (fault_pte_addr) {
> @@ -1411,6 +1411,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>           return TRANSLATE_FAIL;
>       }
>   
> +    /* If gets stale after a goto restart. */
> +    sstack_page = false;
> +
>       target_ulong rwx = pte & (PTE_R | PTE_W | PTE_X);
>       /* Check for reserved combinations of RWX flags. */
>       switch (rwx) {
> @@ -1421,10 +1424,10 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>           if (cpu_get_bcfien(env) && first_stage) {
>               sstack_page = true;
>               /*
> -             * if ss index, read and write allowed. else if not a probe
> -             * then only read allowed
> +             * If ss index, read and write allowed, else allow only reads.
> +             * Page flagged in TLB for CBOs to be able to tell them apart.
>                */
> -            rwx = is_sstack_idx ? (PTE_R | PTE_W) : (is_probe ? 0 :  PTE_R);
> +            rwx = is_sstack_idx ? (PTE_R | PTE_W) : PTE_R;
>               break;
>           }
>           return TRANSLATE_FAIL;
> @@ -1539,7 +1542,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>               int gpa_ret = get_physical_address(env, &gpa_paddr, &gpa_prot,
>                                                  pte_gpa, NULL, MMU_DATA_STORE,
>                                                  MMUIdx_U, false, true,
> -                                               is_debug, false);
> +                                               is_debug, NULL);
>               if (gpa_ret != TRANSLATE_SUCCESS) {
>                   if (fault_pte_addr) {
>                       *fault_pte_addr = pte_gpa >> 2;
> @@ -1612,6 +1615,10 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>       }
>       *ret_prot = prot;
>   
> +    if (is_sstack_page) {
> +        *is_sstack_page = sstack_page;
> +    }
> +
>       return TRANSLATE_SUCCESS;
>   }
>   
> @@ -1669,13 +1676,13 @@ bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
>       int mmu_idx = riscv_env_mmu_index(&cpu->env, false);
>   
>       if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_idx,
> -                             true, env->virt_enabled, true, false)) {
> +                             true, env->virt_enabled, true, NULL)) {
>           return false;
>       }
>   
>       if (env->virt_enabled) {
>           if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL,
> -                                 0, MMUIdx_U, false, true, true, false)) {
> +                                 0, MMUIdx_U, false, true, true, NULL)) {
>               return false;
>           }
>       }
> @@ -1779,6 +1786,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       bool first_stage_error = true;
>       bool two_stage_lookup = mmuidx_2stage(mmu_idx);
>       bool two_stage_indirect_error = false;
> +    bool sstack_page = false;
>       int ret = TRANSLATE_FAIL;
>       privilege_mode_t mode = mmuidx_priv(mmu_idx);
>       /* default TLB page size */
> @@ -1794,7 +1802,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>           /* Two stage lookup */
>           ret = get_physical_address(env, &pa, &prot, address,
>                                      &env->guest_phys_fault_addr, access_type,
> -                                   mmu_idx, true, true, false, probe);
> +                                   mmu_idx, true, true, false, &sstack_page);
>           /*
>            * A G-stage exception may be triggered during two state lookup.
>            * And the env->guest_phys_fault_addr has already been set in
> @@ -1816,7 +1824,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>   
>               ret = get_physical_address(env, &pa, &prot2, im_address, NULL,
>                                          access_type, MMUIdx_U, false, true,
> -                                       false, probe);
> +                                       false, NULL);
>   
>               qemu_log_mask(CPU_LOG_MMU,
>                             "%s 2nd-stage address=%" VADDR_PRIx
> @@ -1854,7 +1862,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>           /* Single stage lookup */
>           ret = get_physical_address(env, &pa, &prot, address, NULL,
>                                      access_type, mmu_idx, true, false, false,
> -                                   probe);
> +                                   &sstack_page);
>   
>           qemu_log_mask(CPU_LOG_MMU,
>                         "%s address=%" VADDR_PRIx " ret %d physical "
> @@ -1880,8 +1888,23 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       }
>   
>       if (ret == TRANSLATE_SUCCESS) {
> -        tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
> -                     prot, mmu_idx, tlb_size);
> +        /*
> +         * tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
> +         *           prot, mmu_idx, tlb_size);
> +         */
> +        CPUTLBEntryFull full = {
> +            .phys_addr = pa & ~(tlb_size - 1),
> +            .attrs = MEMTXATTRS_UNSPECIFIED,
> +            .prot = prot,
> +            .lg_page_size = ctz64(tlb_size),
> +            /*
> +             * Allows CBO.* to differentiate between a shadow-ss from a usual,
> +             * readable one.
> +             */
> +            .extra.riscv.sstack = sstack_page,
> +        };
> +
> +        tlb_set_page_full(cs, mmu_idx, address & ~(tlb_size - 1), &full);
>           return true;
>       } else if (probe) {
>           return false;
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index f9c79fe6b9..a289cb1a84 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -224,6 +224,9 @@ void HELPER(cbo_zero)(CPURISCVState *env, target_ulong address)
>    * section 2.5.2 of the CMO specification) for Zicbom, raising
>    * either store page-fault (non-virtualized) or store guest-page
>    * fault (virtualized).
> + *
> + * Zicfiss: CBOs on a shadow stack page always raise a store/AMO access fault
> + * even though loads are allowed.
>    */
>   static void check_zicbom_access(CPURISCVState *env,
>                                   target_ulong address,
> @@ -233,6 +236,9 @@ static void check_zicbom_access(CPURISCVState *env,
>       int mmu_idx = riscv_env_mmu_index(env, false);
>       uint16_t cbomlen = cpu->cfg.cbom_blocksize;
>       void *phost;
> +#ifndef CONFIG_USER_ONLY
> +    CPUTLBEntryFull *full;
> +#endif
>       int ret;
>   
>       /* Mask off low-bits to align-down to the cache-block. */
> @@ -250,12 +256,22 @@ static void check_zicbom_access(CPURISCVState *env,
>        * addresses, whether a cache-block management instruction is
>        * permitted to access the cache block is UNSPECIFIED."
>        */
> +#ifdef CONFIG_USER_ONLY
>       ret = probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
>                                mmu_idx, true, &phost, ra);
>       if (ret != TLB_INVALID_MASK) {
>           /* Success: readable */
>           return;
>       }
> +#else
> +    ret = probe_access_full(env, address, cbomlen, MMU_DATA_LOAD,
> +            mmu_idx, true, &phost, &full, ra);
> +    /* A shadow stack page is readable but faults after fall through. */
> +    if (ret != TLB_INVALID_MASK && !full->extra.riscv.sstack) {
> +        /* Success: readable */
> +        return;
> +    }
> +#endif
>   
>       /*
>        * Since not readable, must be writable. On failure, store


