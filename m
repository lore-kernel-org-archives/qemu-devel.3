Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC6F606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J+fZ9Ctj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YmydDSD3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKehT-0003gH-0K; Sat, 24 Oct 2026 12:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKehR-0003YT-7B
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:34:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKehO-0002TA-Hp
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:34:28 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF02fX839103
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y/CUFPofGs+0NAYVy0fNcO2jY9OoJpCTTU1ELPVSbN0=; b=J+fZ9CtjJ6gveSba
 CCZZagN+CIitiZzoh3GMRgGipv9yR7s0tOmdYBjloJTemT0nLCiLuXYaS9PutiwT
 8CBKfG9Uh9hhCClLiov9rl2DoqFAJA5y+euAtHvxb+5XaUfF+qCSCE/f4kzEJgRf
 zUU+QL4AfMtL1bAusq7Ce1g80EA/86iO7HHmRzQpcQ6DGIpo4NmeDCoKPYdRa6Mk
 CT27W3hXsCEBcFfubqtZfOeHZtPp8dSiCuNgGIUnNQFNY9xERQYdtJWAfSdqnvys
 +awhit1WjNPmsrsq6FlK2gIKlEzIvtZeqlstClk3RZtPUD+d9MesScSLm2MxH0M1
 jK3+Gg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27samg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:34:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad436a9d00so1591493a91.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792859664; x=1793464464; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=y/CUFPofGs+0NAYVy0fNcO2jY9OoJpCTTU1ELPVSbN0=;
 b=YmydDSD36I84iWRh3T8llJhhg22dBL+FiwKl/pmJ8givFGs/2v14sQwQRlrHzb8wWs
 qGOgqj4P2eB7bU8FzLWsjq45KNq8oE22dSmTbAASXypmXTlTpEh83ivp/EKsUpU0DbjZ
 SaOhCeyTZI5Q069Q6Fb+yOgnxcT3dqgPBv4azScf/i7215M/VfN9y9PawSyI4WZH3Y/A
 1DmoDArUkoIdEB1POy7RkujQEzVTnpOm5MwboePSor2ElmRYT5OAHeviO5uUhH0wq5df
 fKKzUE/lLv4XERWxKzeMoZcU8rZpn8B7ZjmM0wU8VwffUO7NlOArxBfpx8HJWFB53vfx
 9eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859664; x=1793464464;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y/CUFPofGs+0NAYVy0fNcO2jY9OoJpCTTU1ELPVSbN0=;
 b=r3ifYbG3uwFjhVYtlJSdngrPrRuSB3/MU+Kkd31o4WMteEEggJfTFJv34yv+drJ8jF
 EEZBH5DxMPE2dXV35XJ/7vlqfdWDEn4+O8Fb3C/1PU1V2axsu4k3WtW9cZWTzQjWmXDr
 pbyZdRxlDKfytnS3mo7C2XVgZGoYcpCzluZAljozcdSBjn/95wAF6DwlCdW4WD2OEbpF
 z4URMwSMpDSL0mZktjo9CFVkamFLJiioBIkQ6rr+Vm2xC3ifCe9VUqFR5pIuDVkN237q
 TNNnw+zZEHUIIyURb3ubvlBJQuTCCqivqZPDuJN6YAKkYCMp9uHzKgMgtFv5EK0b7r3R
 fGhA==
X-Gm-Message-State: AFq9FYJNrJObALksUsqo6OE4LD1GnNFXY7UCavVNDVLbWYQzxfXnccSW
 BIy7sJkX++d+VekbKyZdqeD/X3mfDfIlKpOZHOXVYjeZeuJ6M0lNKo2cefIx1IdTi5weBFIveXi
 Cjufo+SMSbaBPBgHrbCKkj8oUua4pb5273N1lTpyeoGJmZUypx7u/NemfFW6ey9yF8g==
X-Gm-Gg: AYBFou0TnzIJ3QVZJKCxzKAGttiOXXVSSPueVaUi90Ut5quGHca+HMj0DQtQHwUGQ4F
 BaKgKC+29UB7kAlE0llcs8Vbboy8PIKuyd2oZPwt64wDAHf9KwKIM1dwZsS2d+pFaXQ9RHGygPr
 kcILhp2LEFkO4Rsf+AtZ2BgTpeCTrfuw6HIy0sVepxgWYvYkuMsOptn91H3KnlWsO6fAuWNT+48
 DYEpF0Z3ju5/gDyRfriK7zpPOH/hZq/Mumu+yr3w6a5Gn7i381MxK7OqxavXoxNIMF0Ry7+tiWg
 nwWdyh8+oXOBQtGjWhYYWlJFxA2K+XPSV/ZVAShCNAx9jbtzZs7qzDnsRl3C5aRBI8XSf9S6xqK
 rWaZdVHl1kIRNoULx2q8N+x8o4XX5vth3dXoHPCEw3vNwBWkmtF5YMXda
X-Received: by 2002:a17:90b:4d8c:b0:3ac:a521:95e with SMTP id
 98e67ed59e1d1-3adead4f7ebmr2395314a91.47.1792859664452; 
 Sat, 24 Oct 2026 09:34:24 -0700 (PDT)
X-Received: by 2002:a17:90b:4d8c:b0:3ac:a521:95e with SMTP id
 98e67ed59e1d1-3adead4f7ebmr2395296a91.47.1792859663951; 
 Sat, 24 Oct 2026 09:34:23 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebfa53c3sm3255022a91.13.2026.10.24.09.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 09:34:22 -0700 (PDT)
Message-ID: <e72bae56-54fe-40f1-94ec-2b30faa66d1c@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 09:34:22 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adcde11 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=l_izkvoGNv_PDKXs6_8A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: bvc88iCjUhns_KKYcrgGPb0L3xx5m8NV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfXzU83XN926AQf
 QmEbEraObOW291AuHH9ACWn6Dv+FTX1qmGUm9VZYkEcDYrtkHbujtbCk8E49y0bN5XUJKlhucp7
 yVGyO82Qq0w0DJdmtTLtptF93sDBiPM=
X-Proofpoint-GUID: bvc88iCjUhns_KKYcrgGPb0L3xx5m8NV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX5tqaQQO35hE0
 MDL6x5BbujpvjRzW+mvnhVIlz93ZLPF4ej4T/epqrK5hQB6M5pvigl8irC2ctyL+kyZAqH3JIud
 6ZrApVQVs4koGNJPYCYcAuJJJpNCko7QEBhWQcM9sXxUkxie4l9ixUMWCM1gHKVeJSeEchyOMlD
 +qPA3mdaJ2e8TbwFS93Z3ua7i1nvjKpnt+vCp3fSnPGKpoASwPlqxlVRjMyoPssG5Ewn+pCx3Mc
 KqLTNo/jgL/vQ5wTuUbkKSfiiHfMJ7FS8Pr+aCJJjaMMCHmlKuD1sC3FJLt/ZFdIfMtnBb5QzCF
 BVD936/PO31U8D1ge+GUWfVVesNn60YWTCuD5fxhfpC2SSuhclvyMQhBc8Ix12cp5RozTgr5Rnw
 yG4Dffr2o66GJ+/tIWDCXIW5OTubFDxK/uRQFyqYoRKJOlxMRwZ48njlXVEWw6lJo0U7PLSxe5r
 jp2w1INbyj+s04C7ZUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240065
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 2:20 PM, Pierrick Bouvier wrote:
> When linking multiple targets together, we usually have conflicts with helper
> names. So far, it was solved using ad-hoc renaming, but multiple people pointed it
> would be better to have a general mechanism for it, so here it is.
> 
> A previous series attempted that:
> https://lore.kernel.org/qemu-devel/20260930073935.712-1-luoyonggang@gmail.com/,
> but it was relying on (binary) symbol renaming, which is not a portable solution.
> Instead, this series approaches the problem from source code directly.
> It requires more change, but it's cleaner IMHO.
> 
> Series follows these steps:
> 
> First, we make sure all helpers and definition are using HELPER() macro. A lot
> of helpers were already defined this way, we just make sure it's exhaustive.
> After that we don't have any 'helper_' left on any target code. This is a big
> change touching the whole codebase, but it's a simple mechanical change. As long
> as it compiles and links, we know it's correct.
> 
> Then, we introduce the prefix for target helpers. For this , we add a new define
> (from meson) that applies to all target related code. It could later be used to
> prefix other symbols also, that's why it's not named "TCG".
> 
> Finally, we cleanup the previous manual helpers prefix that were added in
> codebase.
> 
> Pierrick Bouvier (26):
>    target/alpha: define and call helpers using HELPER macro
>    target/arm: define and call helpers using HELPER macro
>    target/avr: define and call helpers using HELPER macro
>    target/hppa: define and call helpers using HELPER macro
>    target/i386: define and call helpers using HELPER macro
>    target/loongarch: define and call helpers using HELPER macro
>    target/m68k: define and call helpers using HELPER macro
>    target/microblaze: define and call helpers using HELPER macro
>    target/mips: define and call helpers using HELPER macro
>    target/or1k: define and call helpers using HELPER macro
>    target/ppc: define and call helpers using HELPER macro
>    target/riscv: define and call helpers using HELPER macro
>    target/rx: define and call helpers using HELPER macro
>    target/s390x: define and call helpers using HELPER macro
>    target/sh4: define and call helpers using HELPER macro
>    target/sparc: define and call helpers using HELPER macro
>    target/tricore: define and call helpers using HELPER macro
>    tcg: introduce HELPER_INFO macro
>    tcg: prefix helpers with target base architecture
>    target/alpha: remove explicit target specific prefix
>    target/hexagon: remove explicit target specific prefix
>    target/hppa: remove explicit target specific prefix
>    target/microblaze: remove explicit target specific prefix
>    target/or1k: remove explicit target specific prefix
>    target/rx: remove explicit target specific prefix
>    target/tricore: remove explicit target specific prefix
> 
>   include/exec/helper-gen-common.h        |   7 +
>   include/exec/helper-gen.h.inc           |  48 +-
>   include/exec/helper-head.h.inc          |   8 +-
>   include/exec/helper-info.c.inc          |  16 +-
>   include/exec/helper-proto-common.h      |   7 +
>   meson.build                             |   2 +
>   target/alpha/clk_helper.c               |   2 +-
>   target/alpha/fpu_helper.c               |  60 +--
>   target/alpha/helper.c                   |   6 +-
>   target/alpha/helper.h                   |   2 +-
>   target/alpha/int_helper.c               |  38 +-
>   target/alpha/sys_helper.c               |  12 +-
>   target/alpha/translate.c                |   4 +-
>   target/alpha/vax_helper.c               |  42 +-
>   target/arm/tcg/helper-a64.c             |   6 +-
>   target/arm/tcg/mve_helper.c             |  28 +-
>   target/arm/tcg/psci.c                   |   2 +-
>   target/arm/tcg/sme_helper.c             |   4 +-
>   target/arm/tcg/sve_helper.c             | 141 ++---
>   target/arm/tcg/tlb_helper.c             |   2 +-
>   target/arm/tcg/vec_helper.c             |  72 +--
>   target/arm/tcg/vec_helper64.c           |  64 +--
>   target/arm/tcg/vec_internal.h           |   5 +-
>   target/avr/helper.c                     |  12 +-
>   target/hexagon/gen_tcg.h                |   2 +-
>   target/hexagon/gen_tcg_sys.h            |   2 +-
>   target/hexagon/helper.h                 |   4 +-
>   target/hexagon/op_helper.c              |   4 +-
>   target/hexagon/translate.c              |   4 +-
>   target/hppa/fpu_helper.c                |   2 +-
>   target/hppa/helper.h                    |   6 +-
>   target/hppa/op_helper.c                 |   4 +-
>   target/hppa/sys_helper.c                |  10 +-
>   target/hppa/translate.c                 |   6 +-
>   target/i386/ops_sse.h                   | 401 +++++++-------
>   target/i386/tcg/bpt_helper.c            |   6 +-
>   target/i386/tcg/cc_helper.c             |  14 +-
>   target/i386/tcg/excp_helper.c           |   8 +-
>   target/i386/tcg/fpu_helper.c            | 182 +++----
>   target/i386/tcg/int_helper.c            |  34 +-
>   target/i386/tcg/mem_helper.c            |   4 +-
>   target/i386/tcg/misc_helper.c           |  16 +-
>   target/i386/tcg/mpx_helper.c            |  12 +-
>   target/i386/tcg/seg_helper.c            |  32 +-
>   target/i386/tcg/system/bpt_helper.c     |   6 +-
>   target/i386/tcg/system/misc_helper.c    |  32 +-
>   target/i386/tcg/system/seg_helper.c     |   4 +-
>   target/i386/tcg/system/smm_helper.c     |  12 +-
>   target/i386/tcg/system/svm_helper.c     |  16 +-
>   target/i386/tcg/user/seg_helper.c       |   4 +-
>   target/loongarch/tcg/csr_helper.c       |  22 +-
>   target/loongarch/tcg/fpu_helper.c       | 126 ++---
>   target/loongarch/tcg/iocsr_helper.c     |  16 +-
>   target/loongarch/tcg/op_helper.c        |  18 +-
>   target/loongarch/tcg/tlb_helper.c       |  26 +-
>   target/loongarch/tcg/vec_helper.c       |   4 +-
>   target/m68k/op_helper.c                 |   2 +-
>   target/microblaze/helper.h              |  10 +-
>   target/microblaze/op_helper.c           |  46 +-
>   target/microblaze/translate.c           |  10 +-
>   target/mips/tcg/dsp_helper.c            | 187 +++----
>   target/mips/tcg/exception.c             |   8 +-
>   target/mips/tcg/fpu_helper.c            | 291 +++++-----
>   target/mips/tcg/ldst_helper.c           |  18 +-
>   target/mips/tcg/lmmi_helper.c           |  98 ++--
>   target/mips/tcg/msa_helper.c            | 690 ++++++++++++------------
>   target/mips/tcg/octeon_crypto.c         | 100 ++--
>   target/mips/tcg/op_helper.c             |  34 +-
>   target/mips/tcg/system/cp0_helper.c     | 276 +++++-----
>   target/mips/tcg/system/lcsr_helper.c    |   8 +-
>   target/mips/tcg/system/special_helper.c |  12 +-
>   target/mips/tcg/system/tlb_helper.c     |  14 +-
>   target/mips/tcg/vr54xx_helper.c         |  30 +-
>   target/or1k/fpu_helper.c                |  16 +-
>   target/or1k/helper.h                    |   2 +-
>   target/or1k/interrupt_helper.c          |   2 +-
>   target/or1k/translate.c                 |   2 +-
>   target/ppc/dfp_helper.c                 |  52 +-
>   target/ppc/fpu_helper.c                 | 396 +++++++-------
>   target/ppc/int_helper.c                 | 292 +++++-----
>   target/ppc/internal.h                   |   7 +-
>   target/ppc/mem_helper.c                 |  28 +-
>   target/ppc/misc_helper.c                |  56 +-
>   target/ppc/mmu-hash64.c                 |  18 +-
>   target/ppc/mmu_helper.c                 |  70 +--
>   target/ppc/power8-pmu.c                 |  14 +-
>   target/ppc/tcg-excp_helper.c            |  56 +-
>   target/ppc/timebase_helper.c            |  54 +-
>   target/ppc/translate/vsx-impl.c.inc     |   2 +-
>   target/riscv/tcg/debug.c                |   2 +-
>   target/riscv/tcg/fpu_helper.c           | 196 +++----
>   target/riscv/tcg/op_helper.c            |  74 +--
>   target/rx/helper.h                      |  12 +-
>   target/rx/op_helper.c                   |  62 +--
>   target/rx/translate.c                   |  14 +-
>   target/s390x/tcg/mem_helper.c           |   2 +-
>   target/sh4/op_helper.c                  |  76 +--
>   target/sparc/fop_helper.c               | 106 ++--
>   target/sparc/helper.c                   |  22 +-
>   target/sparc/int64_helper.c             |   6 +-
>   target/sparc/ldst_helper.c              |  14 +-
>   target/sparc/vis_helper.c               |  94 ++--
>   target/sparc/win_helper.c               |  38 +-
>   target/tricore/fpu_helper.c             |  32 +-
>   target/tricore/helper.h                 |  14 +-
>   target/tricore/op_helper.c              | 220 ++++----
>   target/tricore/translate.c              |  14 +-
>   107 files changed, 2789 insertions(+), 2739 deletions(-)
> 

Sent v2, after partial merge:
https://lore.kernel.org/qemu-devel/20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

