Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CE8C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJzt-0007qV-ND; Tue, 18 Aug 2026 09:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwJzW-0007ZF-4H
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:36:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwJzT-0000jY-0t
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:36:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IDQXi61425677
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cLgP7i8hsY4GFGQMWjWoUDJIEBNQJmTIbmIra47C5qU=; b=akbm/3vS57SzQ2Tr
 5sSan99wQuqWhULmriqrFhQzKUpjGTXpQkEq5w5+eoRMwoteuUL52HP+O5bPGHyP
 dJIq0EVNsqNcJaabaShpBP1N8r1/ITfcl6D8U3pvxS2c+de0lxG1IXa+qBuXC6tX
 eVeiJDb4FnwiniRCp3/yMM9oE2T7dBBbwBzXuM0bWb+fVY/osqwjtZQtVZYs+JBJ
 y7GomI6nnK1BzLjQ5MUZxzHMXxLDwLE2ZqBxYYYctPRq3IEfXRTwnofA0H9l1BEO
 jv5pK/qOh2jwbqAB5i6kUE1dFTVz3k1HcacFnf4Z+rKft9a6q/V+0qXXqPeIoIhT
 +EWOUw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4prn0dkc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:36:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e63df032bso111436585a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787060188; x=1787664988; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cLgP7i8hsY4GFGQMWjWoUDJIEBNQJmTIbmIra47C5qU=;
 b=NlhWlpx99eoZYNp09mkzk9WdIXnUsdqS/vR8pEAmcWSVdLBTh6nDynPo7KGHOhCwtJ
 A8qmOKiGXJSiYCrypX/DCYpwJQo8RVbbBRssnFlij/ZYfFY6i7HLhnvrFpqhT4zCNln5
 v46prtQssfIm/WodhXmxPsRXm6lMhMxFzky4xKWxJOi+QapcurZbes9rdt8B7rlDOGLl
 j4gpMmGqrNLWB+SypAma4UicGzIQjkwfJCgrz7Rl6qcr6V0kNBEwV91xJy+5SJrjXMW2
 bczcvnewB9bdtn4IwDFMmarccrQUTA/0wFj2lsfunqJxB6tK6alCaqyM226lW8hClJVu
 JW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787060188; x=1787664988;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cLgP7i8hsY4GFGQMWjWoUDJIEBNQJmTIbmIra47C5qU=;
 b=GjbxenKcg7Sh+Ouc3JnFYBZD9/j1Nke+nKMMZG7JJ7yEWQGKF9eA29fk1UpMkbmTmy
 08mMDm3/pbLZKQ58XOS5IB+ZubrszWw0vkJPxEN3DDg3ZvAOkKUcWqIuN/gYgxwKQpuH
 Qw+JAt2uTd2Q5y6CciKUR9kuLtiNFMjrRHy+n8Ki95wVOfQyY/SWJrD27fRK6tZzZ4+G
 E594i6a4VMV4qsG7D+4VFHxHFvlrzA6HQhCyvTiwVxC23P+V/TmdGDNlgsrdzr/Ch2Fu
 nBKVWlrOOQAfL5t1e/Sj9rx3dimNln1q+a39vpvprvKnQ6A9U4VkYxWll7Yr3jG5RWyu
 TrkA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwtkD0fwRGwEXgj7rG1SJduWIJrY7Q+sDq0o+E4KyWHgKZErP5TqWOg5IgEa+GxgtxCm9kainuwcYt@nongnu.org
X-Gm-Message-State: AOJu0Yy3HxBeDVUuajaCzM2HOQFZGy1XYal23x4rvyUf0v6srmGeq/b/
 bZfgtVGI2QD6HY/ox6Kl85kOxG/fAgIawtKA0RjG68z1eb8i+mnd7AXDgU3daxDn+E8CnyknLpB
 RdOAUP4nwu4gihlXUmpCfofGafNvc/1TjaO8G7dT6rJbJnXRfa3JKPOgd+g==
X-Gm-Gg: AR+sD115/EyWqXPaml61q5UFN18qNdeV3Ufw9N5PSiS6xCdr7jdPeB3Z605Wwqdo7EE
 4fPyaE/loZDztuqTiYvlyob81gx7e1UDCk7FRRQT3wNBjuZZ8dL5TT4JUO76AacoyL/SLLt3TYx
 4orCRYT452GrwYt/PWoduAIpKEi6qBurS1tP04Zr4z9FMhsq8CN+j0saR6hVF1xwP126WVniFSe
 yHR0naEOitMPEMKTbPFJoDTJHIHu8S4y4PWmGF4V4fMHHSPoG0ZOJWDr198yH3MIEzG5Jaui223
 bffzZ/wUY9H1oOr2vesM2d/1TNQpiIRQUVT+Cv5Yp8UhfwGGuziImBIHeE0HhonmPm2XodIIMI1
 P1lkG6QVwxhXXsLhpe4WKYsyKuZVpeyPuK3c=
X-Received: by 2002:a05:620a:6789:b0:932:db03:4da3 with SMTP id
 af79cd13be357-93706683ed7mr500744985a.19.1787060187403; 
 Tue, 18 Aug 2026 06:36:27 -0700 (PDT)
X-Received: by 2002:a05:620a:6789:b0:932:db03:4da3 with SMTP id
 af79cd13be357-93706683ed7mr500734985a.19.1787060186730; 
 Tue, 18 Aug 2026 06:36:26 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d061637sm122582905e9.1.2026.08.18.06.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 06:36:25 -0700 (PDT)
Message-ID: <a6331cdb-bd05-4648-8651-0fa00db51323@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 15:36:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] monitor: Refine 'info tlb' command
Content-Language: en-US
To: AlanoSong@163.com, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: dave@treblig.org, laurent@vivier.eu, zhao1.liu@intel.com,
 atar4qemu@gmail.com
References: <20260818132519.186010-1-AlanoSong@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260818132519.186010-1-AlanoSong@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwMCBTYWx0ZWRfX72GGXgvwp7lK
 QGe9CzkeMNg3YUJnGmrKQthT25N4MTaM9XeOPGYwbeaa0FWAxxTJzk6OeGW6t/eD3u07GpbxZme
 cfz2R7GYMz9qreOdcGqoF2zpSmzgDfA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwMCBTYWx0ZWRfXyVsMTaJaHESN
 4LpjOz+ciBKamZoYkQnBzo5t2qB67WGa3nXJe8gziXvODg4I8JsdWvOLOLzUOyoBdfYo+DBNOiO
 CfxhW7W97nya/CCPFRIrzdI9PLNrRhj2sLZYvTrmbpPSPWwKPGTdPnz9yy1ipURrO3GXVOGCgDi
 MOLEv5DMwSZY/tZygc06ZlwpPaFQhFXtfGsTLCWLIe3nhzbb9VXj1bDp1aKJsKJmclKuPgeHjpi
 3d6rUXv1O0gbPLNANi0E8YcRj85wXDxFO69SOEKh8nIynGnU6lddcUmCFPYFzQ6a9GDvIKG5MnO
 HIUHQEG2NfsJB0OJJ3ekLnHddYE1gXpdDDw8j+aVhfHrYz8DeuM87kDJG8xB5vT3Y/AmSSl3tTc
 v+LpqCU5vW6QsDX3r+k5j9HnKLKvLx6ZbOMPRIPMJm6TSXlKIbNuqwEVu89WVl5hsI5pbpzlpX/
 dNPayETr8muhNJuhZ0Q==
X-Proofpoint-ORIG-GUID: HOUeaJvE0sKfKRqYfYeS9kJkeSHWkZ_z
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=6a845fdc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Byx-y9mGAAAA:8 a=IL8dtaOw2ToWy3Usil8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: HOUeaJvE0sKfKRqYfYeS9kJkeSHWkZ_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180100
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Cc'ing Marc-André

On 18/8/26 15:25, AlanoSong@163.com wrote:
> When booting an i386 target, the 'info tlb' command
> may walk the entire page table hierarchy and emit
> an enormous amount of output. It will take dozens of
> minutes to print all the info, and
> The same situation also occurred on sparc32 and
> m68k targets.
> 
> So this change do the following:
> 1) Add a address range argument to help user control
>     the number of output items.
> 2) Add warning note in help message that such address
>     range argument only supported on target i386,
>     sparc32 and m68k.
> 3) Print ignore warning when user add such address
>     range argument on other targets (sh4, sparc64,
>     ppc and xtensa). Those targets only print limited
>     tlb info.
> 
> Signed-off-by: Alano Song <AlanoSong@163.com>
> ---
>   hmp-commands-info.hx      | 17 ++++++--
>   target/i386/monitor.c     | 92 ++++++++++++++++++++++++++++-----------
>   target/m68k/cpu.h         |  2 +-
>   target/m68k/helper.c      | 55 +++++++++++++++--------
>   target/m68k/monitor.c     | 15 ++++++-
>   target/ppc/monitor.c      |  6 +++
>   target/sh4/monitor.c      |  5 +++
>   target/sparc/cpu.h        |  3 ++
>   target/sparc/mmu_helper.c | 40 +++++++++++++----
>   target/sparc/monitor.c    | 23 ++++++++++
>   target/xtensa/monitor.c   |  6 +++
>   11 files changed, 206 insertions(+), 58 deletions(-)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 82134eb6c2..f907edf273 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -188,17 +188,26 @@ ERST
>   
>       {
>           .name       = "tlb",
> -        .args_type  = "",
> -        .params     = "",
> -        .help       = "show virtual to physical memory mappings",
> +        .args_type  = "start:l?,end:l?",
> +        .params     = "[start [end]]",
> +        .help       = "show virtual to physical memory mappings. "
> +                      "output can be extremely large for i386, sparc32 "
> +                      "and m68k targets. use 'info tlb [start [end]]' "
> +                      "to show a range of entries. Note that the range "
> +                      "argument is only supported on i386, sparc32 and "
> +                      "m68k targets.",
>           .cmd        = hmp_info_tlb,
>           .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPARC \
>                           | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M68K,
>       },
>   
>   SRST
> -  ``info tlb``
> +  ``info tlb`` [*start* [*end*]]
>       Show virtual to physical memory mappings.
> +    The output can be extremely large for i386, sparc32 and m68k targets.
> +    Use *start* and *end* to print entries located in virtual address
> +    range [start, end] (end is optional). Note that the range argument is
> +    only supported on i386, sparc32 and m68k targets.
>   ERST
>   
>       {
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index a536712c75..8db9ab0576 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -48,11 +48,9 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
>       return addr;
>   }
>   
> -static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
> -                      hwaddr pte, hwaddr mask)
> +static void do_print_pte(Monitor *mon, hwaddr addr,
> +                         hwaddr pte, hwaddr mask)
>   {
> -    addr = addr_canonical(env, addr);
> -
>       monitor_printf(mon, HWADDR_FMT_plx ": " HWADDR_FMT_plx
>                      " %c%c%c%c%c%c%c%c%c\n",
>                      addr,
> @@ -68,7 +66,25 @@ static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
>                      pte & PG_RW_MASK ? 'W' : '-');
>   }
>   
> -static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
> +static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
> +                      hwaddr pte, hwaddr mask, hwaddr size,
> +                      hwaddr start, hwaddr end)
> +{
> +    hwaddr addr_start = addr_canonical(env, addr);
> +    hwaddr addr_end = addr_canonical(env, addr + size - 1);
> +    /*
> +     * Print current page [addr_start, addr_end] only if it overlaps the
> +     * requested virtual address range [start, end].
> +     */
> +    if (addr_start > end || addr_end < start) {
> +        return;
> +    }
> +
> +    do_print_pte(mon, addr_start, pte, mask);
> +}
> +
> +static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as,
> +                        hwaddr start, hwaddr end)
>   {
>       const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>       unsigned int l1, l2;
> @@ -80,15 +96,16 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>           if (pde & PG_PRESENT_MASK) {
>               if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
>                   /* 4M pages */
> -                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
> +                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1),
> +                          0x400000, start, end);
>               } else {
>                   for(l2 = 0; l2 < 1024; l2++) {
>                       pte = address_space_ldl_le(as, (pde & ~0xfff) + l2 * 4,
>                                                  attrs, NULL);
>                       if (pte & PG_PRESENT_MASK) {
>                           print_pte(mon, env, (l1 << 22) + (l2 << 12),
> -                                  pte & ~PG_PSE_MASK,
> -                                  ~0xfff);
> +                                  pte & ~PG_PSE_MASK, ~0xfff, 0x1000,
> +                                  start, end);
>                       }
>                   }
>               }
> @@ -96,7 +113,8 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>       }
>   }
>   
> -static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
> +static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as,
> +                           hwaddr start, hwaddr end)
>   {
>       const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>       unsigned int l1, l2, l3;
> @@ -114,17 +132,19 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                       if (pde & PG_PSE_MASK) {
>                           /* 2M pages with PAE, CR4.PSE is ignored */
>                           print_pte(mon, env, (l1 << 30) + (l2 << 21), pde,
> -                                  ~((hwaddr)(1 << 20) - 1));
> +                                  ~((hwaddr)(1 << 20) - 1), 0x200000,
> +                                  start, end);
>                       } else {
>                           pt_addr = pde & 0x3fffffffff000ULL;
>                           for (l3 = 0; l3 < 512; l3++) {
>                               pte = address_space_ldq_le(as, pt_addr + l3 * 8,
>                                                          attrs, NULL);
>                               if (pte & PG_PRESENT_MASK) {
> -                                print_pte(mon, env, (l1 << 30) + (l2 << 21)
> -                                          + (l3 << 12),
> +                                print_pte(mon, env,
> +                                          (l1 << 30) + (l2 << 21) + (l3 << 12),
>                                             pte & ~PG_PSE_MASK,
> -                                          ~(hwaddr)0xfff);
> +                                          ~(hwaddr)0xfff, 0x1000,
> +                                          start, end);
>                               }
>                           }
>                       }
> @@ -136,7 +156,8 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>   
>   #ifdef TARGET_X86_64
>   static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
> -        uint64_t l0, uint64_t pml4_addr)
> +                          uint64_t l0, uint64_t pml4_addr, hwaddr start,
> +                          hwaddr end)
>   {
>       const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>       uint64_t l1, l2, l3, l4;
> @@ -159,7 +180,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
>               if (pdpe & PG_PSE_MASK) {
>                   /* 1G pages, CR4.PSE is ignored */
>                   print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30),
> -                        pdpe, 0x3ffffc0000000ULL);
> +                          pdpe, 0x3ffffc0000000ULL, 0x40000000, start, end);
>                   continue;
>               }
>   
> @@ -172,8 +193,9 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
>   
>                   if (pde & PG_PSE_MASK) {
>                       /* 2M pages, CR4.PSE is ignored */
> -                    print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30) +
> -                            (l3 << 21), pde, 0x3ffffffe00000ULL);
> +                    print_pte(mon, env,
> +                              (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 << 21),
> +                              pde, 0x3ffffffe00000ULL, 0x200000, start, end);
>                       continue;
>                   }
>   
> @@ -182,9 +204,11 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
>                       pte = address_space_ldq_le(as, pt_addr + l4 * 8,
>                                                  attrs, NULL);
>                       if (pte & PG_PRESENT_MASK) {
> -                        print_pte(mon, env, (l0 << 48) + (l1 << 39) +
> -                                (l2 << 30) + (l3 << 21) + (l4 << 12),
> -                                pte & ~PG_PSE_MASK, 0x3fffffffff000ULL);
> +                        print_pte(mon, env,
> +                                  (l0 << 48) + (l1 << 39) + (l2 << 30) +
> +                                  (l3 << 21) + (l4 << 12),
> +                                  pte & ~PG_PSE_MASK,
> +                                  0x3fffffffff000ULL, 0x1000, start, end);
>                       }
>                   }
>               }
> @@ -192,7 +216,8 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
>       }
>   }
>   
> -static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
> +static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as,
> +                          hwaddr start, hwaddr end)
>   {
>       const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>       uint64_t l0;
> @@ -203,7 +228,8 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
>       for (l0 = 0; l0 < 512; l0++) {
>           pml5e = address_space_ldq_le(as, pml5_addr + l0 * 8, attrs, NULL);
>           if (pml5e & PG_PRESENT_MASK) {
> -            tlb_info_la48(mon, env, as, l0, pml5e & 0x3fffffffff000ULL);
> +            tlb_info_la48(mon, env, as, l0, pml5e & 0x3fffffffff000ULL,
> +                          start, end);
>           }
>       }
>   }
> @@ -213,6 +239,18 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>   {
>       CPUArchState *env;
>       AddressSpace *as;
> +    hwaddr start = 0, end = HWADDR_MAX;
> +
> +    if (qdict_haskey(qdict, "start")) {
> +        start = (hwaddr)qdict_get_int(qdict, "start");
> +    }
> +    if (qdict_haskey(qdict, "end")) {
> +        end = (hwaddr)qdict_get_int(qdict, "end");
> +    }
> +    if (start > end) {
> +        monitor_printf(mon, "Invalid address range: start > end.\n");
> +        return;
> +    }
>   
>       env = mon_get_cpu_env(mon);
>       if (!env) {
> @@ -229,17 +267,19 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>   #ifdef TARGET_X86_64
>           if (env->hflags & HF_LMA_MASK) {
>               if (env->cr[4] & CR4_LA57_MASK) {
> -                tlb_info_la57(mon, env, as);
> +                tlb_info_la57(mon, env, as, start, end);
>               } else {
> -                tlb_info_la48(mon, env, as, 0, env->cr[3] & 0x3fffffffff000ULL);
> +                tlb_info_la48(mon, env, as, 0,
> +                              env->cr[3] & 0x3fffffffff000ULL,
> +                              start, end);
>               }
>           } else
>   #endif
>           {
> -            tlb_info_pae32(mon, env, as);
> +            tlb_info_pae32(mon, env, as, start, end);
>           }
>       } else {
> -        tlb_info_32(mon, env, as);
> +        tlb_info_32(mon, env, as, start, end);
>       }
>   }
>   
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 7cf3791108..b129cb150f 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -606,6 +606,6 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
>   #define TB_FLAGS_TRACE          16
>   #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
>   
> -void dump_mmu(CPUM68KState *env);
> +void dump_mmu(CPUM68KState *env, hwaddr start, hwaddr end);
>   
>   #endif
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 5f91d206f5..1b854c912b 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -461,27 +461,46 @@ void m68k_switch_sp(CPUM68KState *env)
>   /* MMU: 68040 only */
>   
>   static void print_address_zone(uint32_t logical, uint32_t physical,
> -                               uint32_t size, int attr)
> +                               uint32_t size, int attr,
> +                               hwaddr start, hwaddr end)
>   {
> +    uint64_t zone_start = logical;
> +    uint64_t zone_end = zone_start + size - 1;
> +    uint64_t zone_len;
> +
> +    /*
> +     * Print current zone [zone_start, zone_end] only if it overlaps the
> +     * requested virtual address range [start, end].
> +     */
> +    if (zone_end < start || zone_start > end) {
> +        return;
> +    }
> +
> +    physical += (uint32_t)(start > zone_start ? start - zone_start : 0);
> +    zone_start = zone_start > start ? zone_start : start;
> +    zone_end = zone_end < end ? zone_end : end;
> +    zone_len = zone_end - zone_start + 1;
> +
>       qemu_printf("%08x - %08x -> %08x - %08x %c ",
> -                logical, logical + size - 1,
> -                physical, physical + size - 1,
> +                (uint32_t)zone_start, (uint32_t)zone_end,
> +                physical, physical + (uint32_t)(zone_len - 1),
>                   attr & 4 ? 'W' : '-');
> -    size >>= 10;
> -    if (size < 1024) {
> -        qemu_printf("(%d KiB)\n", size);
> +    zone_len >>= 10;
> +    if (zone_len < 1024) {
> +        qemu_printf("(%d KiB)\n", (int)zone_len);
>       } else {
> -        size >>= 10;
> -        if (size < 1024) {
> -            qemu_printf("(%d MiB)\n", size);
> +        zone_len >>= 10;
> +        if (zone_len < 1024) {
> +            qemu_printf("(%d MiB)\n", (int)zone_len);
>           } else {
> -            size >>= 10;
> -            qemu_printf("(%d GiB)\n", size);
> +            zone_len >>= 10;
> +            qemu_printf("(%d GiB)\n", (int)zone_len);
>           }
>       }
>   }
>   
> -static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
> +static void dump_address_map(CPUM68KState *env, uint32_t root_pointer,
> +                             hwaddr start, hwaddr end)
>   {
>       int tic_size, tic_shift;
>       uint32_t tib_mask;
> @@ -550,7 +569,8 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
>                           size = last_logical + (1 << tic_shift) -
>                                  first_logical;
>                           print_address_zone(first_logical,
> -                                           first_physical, size, last_attr);
> +                                           first_physical, size, last_attr,
> +                                           start, end);
>                       }
>                       first_logical = logical;
>                       first_physical = physical;
> @@ -560,7 +580,8 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
>       }
>       if (first_logical != logical || (attr & 4) != (last_attr & 4)) {
>           size = logical + (1 << tic_shift) - first_logical;
> -        print_address_zone(first_logical, first_physical, size, last_attr);
> +        print_address_zone(first_logical, first_physical, size, last_attr,
> +                           start, end);
>       }
>   }
>   
> @@ -610,7 +631,7 @@ static void dump_ttr(uint32_t ttr)
>                                  M68K_DESC_USERATTR_SHIFT);
>   }
>   
> -void dump_mmu(CPUM68KState *env)
> +void dump_mmu(CPUM68KState *env, hwaddr start, hwaddr end)
>   {
>       if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
>           qemu_printf("Translation disabled\n");
> @@ -675,10 +696,10 @@ void dump_mmu(CPUM68KState *env)
>       dump_ttr(env->mmu.ttr[M68K_DTTR1]);
>   
>       qemu_printf("SRP: 0x%08x\n", env->mmu.srp);
> -    dump_address_map(env, env->mmu.srp);
> +    dump_address_map(env, env->mmu.srp, start, end);
>   
>       qemu_printf("URP: 0x%08x\n", env->mmu.urp);
> -    dump_address_map(env, env->mmu.urp);
> +    dump_address_map(env, env->mmu.urp, start, end);
>   }
>   
>   static int check_TTR(uint32_t ttr, int *prot, target_ulong addr,
> diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
> index 3e0df40a6b..bcb528d8e3 100644
> --- a/target/m68k/monitor.c
> +++ b/target/m68k/monitor.c
> @@ -9,15 +9,28 @@
>   #include "cpu.h"
>   #include "monitor/hmp.h"
>   #include "monitor/monitor.h"
> +#include "qobject/qdict.h"
>   
>   void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>   {
>       CPUArchState *env1 = mon_get_cpu_env(mon);
> +    hwaddr start = 0, end = HWADDR_MAX;
>   
>       if (!env1) {
>           monitor_printf(mon, "No CPU available\n");
>           return;
>       }
>   
> -    dump_mmu(env1);
> +    if (qdict_haskey(qdict, "start")) {
> +        start = (hwaddr)qdict_get_int(qdict, "start");
> +    }
> +    if (qdict_haskey(qdict, "end")) {
> +        end = (hwaddr)qdict_get_int(qdict, "end");
> +    }
> +    if (start > end) {
> +        monitor_printf(mon, "Invalid address range: start > end.\n");
> +        return;
> +    }
> +
> +    dump_mmu(env1, start, end);
>   }
> diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
> index 7c88e0e2bd..753ed6b93d 100644
> --- a/target/ppc/monitor.c
> +++ b/target/ppc/monitor.c
> @@ -10,6 +10,7 @@
>   #include "monitor/monitor.h"
>   #include "monitor/hmp.h"
>   #include "cpu.h"
> +#include "qobject/qdict.h"
>   
>   void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>   {
> @@ -19,5 +20,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>           monitor_printf(mon, "No CPU available\n");
>           return;
>       }
> +
> +    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
> +        monitor_printf(mon, "The range arguments will be ignored.\n");
> +    }
> +
>       dump_mmu(env1);
>   }
> diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
> index 50324d3600..c804824bab 100644
> --- a/target/sh4/monitor.c
> +++ b/target/sh4/monitor.c
> @@ -25,6 +25,7 @@
>   #include "cpu.h"
>   #include "monitor/monitor.h"
>   #include "monitor/hmp.h"
> +#include "qobject/qdict.h"
>   
>   static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
>   {
> @@ -48,6 +49,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>           return;
>       }
>   
> +    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
> +        monitor_printf(mon, "The range arguments will be ignored.\n");
> +    }
> +
>       monitor_printf (mon, "ITLB:\n");
>       for (i = 0 ; i < ITLB_SIZE ; i++)
>           print_tlb (mon, i, &env->itlb[i]);
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 5f583ed9de..11f94b6bd8 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -601,6 +601,9 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                           bool probe, uintptr_t retaddr);
>   target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev);
>   void dump_mmu(CPUSPARCState *env);
> +#ifndef TARGET_SPARC64
> +void dump_mmu_range(CPUSPARCState *env, hwaddr start, hwaddr end);
> +#endif
>   
>   #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
>   int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 07ba25dfce..65a30b438b 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -354,7 +354,32 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
>       return 0;
>   }
>   
> +static void print_tlb_entry(target_ulong va, hwaddr pa, uint32_t pde,
> +                            const char *indent, const char *kind,
> +                            hwaddr size, hwaddr start, hwaddr end)
> +{
> +    hwaddr va_hw_start = (hwaddr)va;
> +    hwaddr va_hw_end = (hwaddr)(va + size - 1);
> +
> +    /*
> +     * Print current region [va_hw_start, va_hw_end] only if it overlaps the
> +     * requested virtual address range [start, end].
> +     */
> +    if (va_hw_start > end || va_hw_end < start) {
> +        return;
> +    }
> +
> +    qemu_printf("%sVA: " TARGET_FMT_lx ", PA: " HWADDR_FMT_plx
> +                " %s: " TARGET_FMT_lx "\n",
> +                indent, va, pa, kind, pde);
> +}
> +
>   void dump_mmu(CPUSPARCState *env)
> +{
> +    dump_mmu_range(env, 0, HWADDR_MAX);
> +}
> +
> +void dump_mmu_range(CPUSPARCState *env, hwaddr start, hwaddr end)
>   {
>       CPUState *cs = env_cpu(env);
>       target_ulong va, va1, va2;
> @@ -373,8 +398,8 @@ void dump_mmu(CPUSPARCState *env)
>               } else {
>                   pa = tres.physaddr;
>               }
> -            qemu_printf("VA: " TARGET_FMT_lx ", PA: " HWADDR_FMT_plx
> -                        " PDE: " TARGET_FMT_lx "\n", va, pa, pde);
> +            print_tlb_entry(va, pa, pde, "", "PDE", 16 * 1024 * 1024,
> +                            start, end);
>               for (m = 0, va1 = va; m < 64; m++, va1 += 256 * 1024) {
>                   pde = mmu_probe(env, va1, 1);
>                   if (pde) {
> @@ -383,9 +408,8 @@ void dump_mmu(CPUSPARCState *env)
>                       } else {
>                           pa = tres.physaddr;
>                       }
> -                    qemu_printf(" VA: " TARGET_FMT_lx ", PA: "
> -                                HWADDR_FMT_plx " PDE: " TARGET_FMT_lx "\n",
> -                                va1, pa, pde);
> +                    print_tlb_entry(va1, pa, pde, " ", "PDE", 256 * 1024,
> +                                    start, end);
>                       for (o = 0, va2 = va1; o < 64; o++, va2 += 4 * 1024) {
>                           pde = mmu_probe(env, va2, 0);
>                           if (pde) {
> @@ -394,10 +418,8 @@ void dump_mmu(CPUSPARCState *env)
>                               } else {
>                                   pa = tres.physaddr;
>                               }
> -                            qemu_printf("  VA: " TARGET_FMT_lx ", PA: "
> -                                        HWADDR_FMT_plx " PTE: "
> -                                        TARGET_FMT_lx "\n",
> -                                        va2, pa, pde);
> +                            print_tlb_entry(va2, pa, pde, "  ", "PTE",
> +                                            4 * 1024, start, end);
>                           }
>                       }
>                   }
> diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
> index 36f3d8d58e..993e411a37 100644
> --- a/target/sparc/monitor.c
> +++ b/target/sparc/monitor.c
> @@ -25,6 +25,7 @@
>   #include "cpu.h"
>   #include "monitor/monitor.h"
>   #include "monitor/hmp.h"
> +#include "qobject/qdict.h"
>   
>   
>   void hmp_info_tlb(Monitor *mon, const QDict *qdict)
> @@ -35,5 +36,27 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>           monitor_printf(mon, "No CPU available\n");
>           return;
>       }
> +
> +#ifdef TARGET_SPARC64
> +    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
> +        monitor_printf(mon, "The range arguments will be ignored.\n");
> +    }
> +
>       dump_mmu(env1);
> +#else
> +    hwaddr start = 0, end = HWADDR_MAX;
> +
> +    if (qdict_haskey(qdict, "start")) {
> +        start = (hwaddr)qdict_get_int(qdict, "start");
> +    }
> +    if (qdict_haskey(qdict, "end")) {
> +        end = (hwaddr)qdict_get_int(qdict, "end");
> +    }
> +    if (start > end) {
> +        monitor_printf(mon, "Invalid address range: start > end.\n");
> +        return;
> +    }
> +
> +    dump_mmu_range(env1, start, end);
> +#endif
>   }
> diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
> index 2af84934f8..df572cba42 100644
> --- a/target/xtensa/monitor.c
> +++ b/target/xtensa/monitor.c
> @@ -25,6 +25,7 @@
>   #include "cpu.h"
>   #include "monitor/monitor.h"
>   #include "monitor/hmp.h"
> +#include "qobject/qdict.h"
>   
>   void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>   {
> @@ -34,5 +35,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>           monitor_printf(mon, "No CPU available\n");
>           return;
>       }
> +
> +    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
> +        monitor_printf(mon, "The range arguments will be ignored.\n");
> +    }
> +
>       dump_mmu(env1);
>   }


