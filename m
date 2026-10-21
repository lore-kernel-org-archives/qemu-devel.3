Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ABB606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QwwP4GbU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jZayX2oJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJNEm-0000dD-P0; Tue, 20 Oct 2026 23:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJNEk-0000cy-0r
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:43:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJNEi-00064B-28
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:43:33 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F3e9336836
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BO3CP/U8Kmy2CaQ84m7VfYif+eqxaV8Jyv2SbIg03F8=; b=QwwP4GbU+nAkPndG
 DFWRngkJpnwrc+LfGrFLjdHdLWch2ElVZ67aEMc05dDrRouWBQMncdpVXnzKfz4o
 gwSj7gnycdR+RXeTG+pjrusW3kbKE9uGeNgrsv8rUUS/83Gkxg1y0L7ZBFzEQCQB
 j1ky1XlonmkIp6DrKkoHahQ0pkqHGQsL48hp/XX6+7o01SwbjCKfK0+pkkFVq6Po
 sCg1wuyhL6eWeDvqd5MUIhOd1j0Cq6FMcyVKBWpswuuVYYd0CCAuDzNz9bqXNUgH
 X2mwA5TTqMKFR/RAuGmMVYlPhSP/QBvjRNkXH2dRa3YDDJyLQRJ2ZK/dOVGHqQtq
 fquLlw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabhudf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:43:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f2373e9b4so35670285a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792554208; x=1793159008; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BO3CP/U8Kmy2CaQ84m7VfYif+eqxaV8Jyv2SbIg03F8=;
 b=jZayX2oJ7V4XeZQf003djVkV0ZMU8nddNljubkg2scfq8Mvx6ZY6b9b6Med1sNws56
 TED1yaiEMGTJhVhOD8B9GJOAVkXOoQEpxFQvSNtSOzW0U7Zto849siEcX1ZT8D5OIXz+
 qtILgEhhXxjKi28ZZs4GH6Cjqacnm+gQfZou7NGnRvYOU0Yt2detj7H8wGmEFuT65GRF
 PBhS4pw2oKgCUalLX8nbTmcCPFriMvfOQ4VGX8rDu59BOAgn08aurJHD30QBmdtK831Q
 pJtASk5gRdAaI6RRCF8r0er9fpOJNZZI0oBiaPGzrh9axBJAlw63/FSzj5c1lBOCvBLv
 iTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792554208; x=1793159008;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BO3CP/U8Kmy2CaQ84m7VfYif+eqxaV8Jyv2SbIg03F8=;
 b=cYWTgimGXxvalgGf9rnc4OhnC8C+vHUsr5CY8yAUnnfpqs/ex2cgRqC1g0hmUnfn4+
 ilK0eECuqJNQsvsDc7Zk5TJPH8KJQUWmFioRKowoOYTMefDCGatZPSZ02V+pMNiG7QVW
 Z8JoGIJCGqNGNeyPGUqCpVXnu93lnKG5kWRZB/u80RXgoiw8e9e/KAgYZkeerp969Rgj
 9LqpoL/WgpBcQcRdjom9+opn1Cg+HnVO4+Tyq1beEEHQYTHFUpn9ulhEfvFmwny2w4x0
 3urJpPmIouhlstlc5hJhYCzXl15pv8J8zrf5zKOtNIPz9yYpCy78u56h1LpOSukNn9Ns
 YZGA==
X-Forwarded-Encrypted: i=1;
 AKwUvByqKzdEum9fq/T5mrWD5jN15E7icUOBzmQv4fWj3bt6NzStlftUbFdzboi9EZtN0HlKHFQ7q43+8zlw@nongnu.org
X-Gm-Message-State: AFq9FYIV652JAT51vxrDdM3VPg+fNjD5jtPmLyQkvYlQSm49AQO8PHIc
 GWLaKjMzS5LZJdyZx55Ps1TWZDwEcfv+AJlGEywdFEd1iUr18Zvn6E/rdJhTW8RJwKsPcpjQKhb
 WJtCGoLpXjOwL6hNms1bCfStEx6kz4t3xlGmuFrtkj4Wrotrigq397586Qw==
X-Gm-Gg: AYBFou2gkKLYX/ajNF3R+/obt9qgmJ0k5SUET0DJCPVIwURs4t55COcqFhuf+0O2hCk
 oD9aqFLqbZpdbC5swmtdUyMqbtW+W4fVa+dNoWbQ08IDR56NL5KJ89cUE0+HDPIj7+XypYO5Fvs
 K83SRlHRegqy4p70lzFAIcUc101tH9/b9u6jUdGFnJ6pwe/lQKayk0pxI1iKTJGU5x7y3L802IY
 xWF0Crw+BlQ5XpA9UL0WwYkuWuvaPuC6VN8tf5yWcXzRA894fOM4mnIdoYrQk15PkBFMCcyhgcE
 7FUJrdGXAj2D9d7rWzJsEQksjqQ5U13R/jDXF5VQ+B5PHnrrDaBu+LOGb4AIu08w4hsVwUedvEq
 95ZThhp99IJ19REYAxBezZpUAx1z/A8ISnQ==
X-Received: by 2002:a05:620a:1a16:b0:93f:2ed6:1f3a with SMTP id
 af79cd13be357-93f57f91f83mr232853785a.49.1792554207997; 
 Tue, 20 Oct 2026 20:43:27 -0700 (PDT)
X-Received: by 2002:a05:620a:1a16:b0:93f:2ed6:1f3a with SMTP id
 af79cd13be357-93f57f91f83mr232852185a.49.1792554207475; 
 Tue, 20 Oct 2026 20:43:27 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25841fe4sm2666473f8f.53.2026.10.20.20.43.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 20:43:25 -0700 (PDT)
Message-ID: <7de740ef-f912-451c-858a-8b4c87d697ea@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 05:43:23 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/or1k: Convert to translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
 <20261020122752.3651914-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261020122752.3651914-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMyBTYWx0ZWRfX4HPbdK8YBilx
 ao2d9gflIEL005vy+hmQgageqMJOap+BS8FoXuM947yGWzeT8dkOFDkTSbcqSnUbPEvYqJ/j3F8
 nZFYNdbddx6qHJOjCXmzNcSZ2ME2fnM=
X-Proofpoint-ORIG-GUID: evCJGPr_bm0tJefIYQUQCjJEQ5qnMhNg
X-Proofpoint-GUID: evCJGPr_bm0tJefIYQUQCjJEQ5qnMhNg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMyBTYWx0ZWRfXyQJwHHpx07JP
 5kXJ8DanbwTg9qbZVjRVlYJpskyDH+5xiuMYxmQgXfMTP2LL8eoZsVVi8MKadFRp2bXRzmaWGFC
 mBJns3RDX6l6/bUiipVszH8JcRdV+wDpvVIjZ34Ec53ZAlyFzMWDr0WlDlDj2qQqt+8WSRvERSF
 9HSy6pcdSPJhU/5UWuESRZn8RfjScfSJgNJySynMGhXTmQDg3d326b2+ygfkewIsl0mtV47MqCx
 BMuaAYmLAXsKPaYDM4+OP8f9ZePcNwcJz70KPrPjghWlTztlQ4spUuF7UiCwJG51LU2kXmO8GNz
 r4EIxf2UxEpHAwc0WRKA1cAoKg3fcrZ/E/sy5CRGT2OYXQAyFY1B/325BeVBBDffXXMYfzQdIJ3
 L3hYffwEwrjfvudu+I1HwUHQcGoDF+NkQlO+xGUp0FlKCDm+1BJkV+KPvQjKL2CMuWm+cF4Z03f
 uWngwrHGn/Hmfnt6Z0Q==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad834e1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=FxyRol8rFYqdUe5CtOcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210013
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 20/10/26 14:27, Peter Maydell wrote:
> Convert or1k to providing the translate_for_debug method rather than
> the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/or1k/cpu.h |  3 ++-
>   target/or1k/cpu.c |  2 +-
>   target/or1k/mmu.c | 21 ++++++++++++++++-----
>   3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/target/or1k/cpu.h b/target/or1k/cpu.h
> index fc4387ce7ae..99b65ae4b97 100644
> --- a/target/or1k/cpu.h
> +++ b/target/or1k/cpu.h
> @@ -296,7 +296,8 @@ void openrisc_translate_code(CPUState *cs, TranslationBlock *tb,
>   int print_insn_or1k(bfd_vma addr, disassemble_info *info);
>   
>   #ifndef CONFIG_USER_ONLY
> -hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
> +bool openrisc_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
> +                                      TranslateForDebugResult *result);
>   
>   bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                              MMUAccessType access_type, int mmu_idx,
> diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
> index 66c00c0930c..d5415f0e567 100644
> --- a/target/or1k/cpu.c
> +++ b/target/or1k/cpu.c
> @@ -247,7 +247,7 @@ static void openrisc_any_initfn(Object *obj)
>   
>   static const struct SysemuCPUOps openrisc_sysemu_ops = {
>       .has_work = openrisc_cpu_has_work,
> -    .get_phys_addr_debug = openrisc_cpu_get_phys_addr_debug,
> +    .translate_for_debug = openrisc_cpu_translate_for_debug,
>   };
>   #endif
>   
> diff --git a/target/or1k/mmu.c b/target/or1k/mmu.c
> index 3fc56e1b771..a78e8c8ca2e 100644
> --- a/target/or1k/mmu.c
> +++ b/target/or1k/mmu.c
> @@ -139,7 +139,8 @@ bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
>       cpu_loop_exit_restore(cs, retaddr);
>   }
>   
> -hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
> +bool openrisc_cpu_translate_for_debug(CPUState *cs, vaddr addr,
> +                                      TranslateForDebugResult *result)
>   {
>       OpenRISCCPU *cpu = OPENRISC_CPU(cs);
>       int prot, excp, sr = cpu->env.sr;
> @@ -152,12 +153,15 @@ hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
>                               PAGE_READ,
>                               (sr & SR_SM) != 0);
>           if (!excp) {
> -            return phys_addr;
> +            break;
>           }

Faithful conversion, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Data lookup failed, we don't discriminate DTLB and directly check
ITLB. We can have:

   [EXCP_DPF]      = "DFP (data protection fault)",
   [EXCP_DTLBMISS] = "DTLBMISS (data tlb miss)",

EXCP_DPF could happen when accessing exec-only kernel .text;
shouldn't we return to gdb here for "valid DTLB but read denied",
and keep checking the ITLB for the EXCP_DTLBMISS case where no
data mapping? As:

             if (excp == EXCP_DPF) { break; }

>           excp = get_phys_mmu(cpu, &phys_addr, &prot, addr,
>                               PAGE_EXEC,
>                               (sr & SR_SM) != 0);
> -        return excp ? -1 : phys_addr;
> +        if (excp) {
> +            return false;
> +        }
> +        break;
>   
>       default:
>           /* The mmu is partially enabled, and we don't really have
> @@ -167,13 +171,20 @@ hwaddr openrisc_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
>                               PAGE_EXEC | PAGE_READ | PAGE_WRITE,
>                               (sr & SR_SM) != 0);
>           if (!excp) {
> -            return phys_addr;
> +            break;
>           }
>           /* fallthru */
>   
>       case 0:
>           /* The mmu is definitely disabled; lookups never fail.  */
>           get_phys_nommu(&phys_addr, &prot, addr);
> -        return phys_addr;
> +        break;
>       }
> +
> +    *result = (TranslateForDebugResult) {
> +        .physaddr = phys_addr,
> +        .lg_page_size = TARGET_PAGE_BITS,
> +        .attrs.debug = 1,
> +    };
> +    return true;
>   }


