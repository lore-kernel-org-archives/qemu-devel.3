Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5AFC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 18:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x00rx-0001Nt-SL; Fri, 28 Aug 2026 14:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x00rx-0001N6-12
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 14:00:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x00rv-0002JW-6A
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 14:00:00 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SGJxq03568386
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 17:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X8MXQDnqmV1vBHQApI8YWzRQuc5yoA1QAecRSeMI4es=; b=OJRH/ZjkzW0Qy6J9
 Feq0MtGbf5Gv+d3D+Jq9qNmN1Hxk2lmYNMTrOXXLbhGRy+gpiEQmEx9WLhByI8uw
 fbP9ISWJ1iI1dKUZThYRgqZK6CkuHsZoLkhXi60XkLd23jKVobOSFu8pR+q0auZ9
 VvNy4T0kwWc7n361/YiDb1enzmteLqxbiU4xdJJNyB3uwBDqrXABuvAFQ96ge1A8
 5AWYbdhblrl83Y63wK703zZhWE3bteUEcxAYX+fZzQgvsmHHffURGHiHRGJDMoyk
 VtDKehsA9mq7Wblt4+pRf6DMpzBNMFEu40z4TmBQ0ci2Izea4HqouXoGCq9704IR
 vJ/KpQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mxu0n3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 17:59:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso17543025ad.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787939995; x=1788544795; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X8MXQDnqmV1vBHQApI8YWzRQuc5yoA1QAecRSeMI4es=;
 b=VLwl9MWf8aFtSPzRT27MvhdWmaVEZDzzUqYOxI7tX75vg9OetF2IVMG2kaDuUnZ/u3
 qCAyOz8tFDEcI/MM/imCpleqp1rfABsJvHupoHGqJ7NctQwlBovNI01/c5KXAzJpQDM2
 EASKj7KJj2xyC/he7a24JL5Qbs3Wkm53583fZGlocFZoFzQEmPXF5qzchPkrbQjaQx7m
 5GNcZlqLQvz3EAQO+PTLsYXnmsLwpjC9cWTZ8G1noi3R8Sb2VnPhemGcNsZcgBV5yO6E
 h37rP/ws+nThdTrYYWqekiZKlxj0LLCMycwAk8kZ/LklA38M9MJObKk6DkvA0RE+8UNw
 TVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787939995; x=1788544795;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X8MXQDnqmV1vBHQApI8YWzRQuc5yoA1QAecRSeMI4es=;
 b=PHKKpmJTbfC5Iy/K5hGiw3mLUo0HT0zrbNnQgua6JWHZ/CdVjIquUtGEQ4MflNr4s+
 HYV6kKgTZibYgtjNLAxa1G/NSlN9danmKjyaMJqMtMYKaetW+OM6mD7ZIveKPRKZRrir
 06Xk9QCyG5DwPZg3odNgMlyI0KsL+/dtXwQK7FkPRPPtUusfbZOmGzoMKzlvsj+eKr10
 lr14XxmU86qkHgYBvvqvCtYOe2zcR/pGe8QVpEneInuhzzVCLvnF02U0Nkh/9hzyqwKD
 w7uk2KvB5C+8yv7ugX4OjJTlfem++72mVEZYcxs/rnI5KOcd5exwj97aTYklpywNWwYf
 hCgw==
X-Gm-Message-State: AFuF++kPKVgvHRMcH8raG5IU9wR6VktRe0fcSPhSR96GksHM027VQEwX
 J4iMxAFOboMB0JNO6C3I3o+pTdSEQQVwKsYltqeEyGWY7hQ8FVmiaD87eLpF1yKr0d4x1YfWRGW
 IL8eFv/lUTGbPEnYkPyS47gY29lYQU0fusRR+2xpnNvpT2SOSd78XTNMEgA==
X-Gm-Gg: AYBFou3LBnZ6BRRvXnsDivWvDvdjECdgiBH0m2Qcfhb7QwT7HXTuHo0dzNotAh3IEnf
 wWyCLedGuKYmKLt63qCI8ZcxGShnaRfre998A4Y4fSJKNiehN3ZBIhzYof0EkSg2d/hms1kbpAT
 MZ2LQY8NBvYt+3vPwtg0APBquldNRuViY1SHQPg01N9BvtPWL98fj6NKd0AWvEVHiiSJYy4yoel
 A1y6+DD8mbp9fz0/ZxBTqEATSw46xg/ylLd/d7Xgf16SOc8D15JB5PngORuWlCmiHozObhi1axR
 4SsU4wn22HZVP+bhvArQNrXoDadrUWFNc5NDr9ENPc0LGbH6x1nfuWgFcmqrpchbZ9dOeU3A5ev
 J59hC9EGMG00CwE6AdP3VmTM467/2SyRu3dksAF+VyZ/2pAoiupu/x1ahLJpSsf7lgC4v
X-Received: by 2002:a17:90b:2701:b0:398:9be6:f992 with SMTP id
 98e67ed59e1d1-3989be6fac8mr2212667a91.17.1787939995445; 
 Fri, 28 Aug 2026 10:59:55 -0700 (PDT)
X-Received: by 2002:a17:90b:2701:b0:398:9be6:f992 with SMTP id
 98e67ed59e1d1-3989be6fac8mr2212619a91.17.1787939994975; 
 Fri, 28 Aug 2026 10:59:54 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0d3fdf6sm8756803c88.6.2026.08.28.10.59.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 10:59:54 -0700 (PDT)
Message-ID: <7510d409-812c-46fc-859f-c554990210e9@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 10:59:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] single-binary: implement dynamic filtering for
 machine types
To: luoyonggang@gmail.com
Cc: qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE8g0nAJPoJvjZGR_KpEAo+C+S7+QTdZGhagBQE_diDXcw@mail.gmail.com>
 <a38bf9f3-cbdb-43bd-9753-924b30c02db4@oss.qualcomm.com>
 <CAE2XoE-we=__uHK3QfYeTRBbePmRFOXSFY_E0ZFZwc-rvODDcw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-we=__uHK3QfYeTRBbePmRFOXSFY_E0ZFZwc-rvODDcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE1NiBTYWx0ZWRfX9CaLyh0pjVFv
 46nM9ZaM1MniiR3DeWYMfMi8w4q29rweylUXg/kLC+Y92Cj02k1eBhofcbytIdPt6BAGdmI8kDj
 iqOGPsliB06VNUCYhG8q1yMogGR/ZkN86jvMAjJo11GS+3lqSwG1o3MT2u+5iB7dXDsM+7Ak8QF
 YNNzOBagc2F68hKyH5CC5439E9W/712sdK3NSk2r4ns1qHyYkGerhOgFee767195Idbc8m6Yi+F
 vOh7cPunaoz5uMuybkJPz7HdqpNws6DtV2ER5Gd23uNgmXjsmx632NSpnaiBy5m2AXH51PRdjBs
 bA9NDyjUr0GCdNxFaINbRFlEqUvnrZ8C2aQjQ3k9AnX9ynIloVSZBt0uaz4ntOP9tvvJTiZWP4d
 570WNLSgUShIKDVjUtSQMYNFRm23MJcNf4GnfiPK9KzT7JYZ5R6nrJZo0u62afmDaXUxj6GYfXd
 YevSVm28mCvNhZ6SovA==
X-Authority-Analysis: v=2.4 cv=MONQXsZl c=1 sm=1 tr=0 ts=6a91cc9c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=EB4W5_DgHDwtR-QVpj0A:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE1NiBTYWx0ZWRfX+ACQ+W5IiCtH
 Oa+0zwIu4/zhQGpRV16f0yjR29tI9gEnt1ehehYxi8i0wURk6AVZ+MgMEZlVP2mhXy2HhWx4D3Z
 J3ga+OASxWf/ctQS79a8r7kOaKECLXE=
X-Proofpoint-ORIG-GUID: gB3FcZrjIvB5LbKmt-6pjOD-5DDz7QMg
X-Proofpoint-GUID: gB3FcZrjIvB5LbKmt-6pjOD-5DDz7QMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280156
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

On 8/28/2026 10:54 AM, Yonggang Luo wrote:
> can we use both？ first is the enum，  then the is_available handler.
>

I don't think it would be good, as we would duplicate information.
I'll send a v3 of current series to implement an alternative (see v2
latest message from Richard).

>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo
> 
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>> 于 2026年8月29日周六 01:10写道：
> 
>     On 8/28/2026 2:51 AM, Yonggang Luo wrote:
>     >
>     >
>     > On Fri, Jul 24, 2026 at 8:11 AM Pierrick Bouvier
>     > <pierrick.bouvier@oss.qualcomm.com
>     <mailto:pierrick.bouvier@oss.qualcomm.com>
>     > <mailto:pierrick.bouvier@oss.qualcomm.com
>     <mailto:pierrick.bouvier@oss.qualcomm.com>>> wrote:
>     >>
>     >> Now that we can link a single-binary with at least two targets (arm,
>     > aarch64),
>     >> we want to make sure that we expose the same set of machines (later
>     > devices and
>     >> cpus) than target binaries. For that, we implemented a static
>     > filtering based on
>     >> target interfaces that each machine will implement to declare which
>     > targets have
>     >> this machine.
>     >>
>     >> However, we discovered that this static filtering is not enough.
>     > Indeed, some
>     >> machines and devices do not depend only on target, and their presence
>     > can depend
>     >> on Kconfig or host/target combination. Thus, our static approach
>     can't
>     > work, and
>     >> we need something more flexible.
>     >>
>     >> This series adds a new TYPE_TARGET_SPECIFIC, that declare a single
>     > function
>     >> bool is_available(void). From there, any machine type (and later
>     > devices and
>     >> cpus) can implement it to override their presence for each target.
>     >> We first replace the existing static mechanism with this, and once
>     > done, we
>     >> cleanup all the old interface. One nice benefit is that we can
>     get rid of
>     >> config/targets/*.c files, which saves duplication.
>     >
>     >
>     >   About target-filtering, we already have 
>     >
>     > enum {
>     >     QEMU_ARCH_ALPHA =       (1UL << SYS_EMU_TARGET_ALPHA),
>     >     QEMU_ARCH_ARM =         (1UL << SYS_EMU_TARGET_ARM) |
>     >                             (1UL << SYS_EMU_TARGET_AARCH64),
>     >     QEMU_ARCH_I386 =        (1UL << SYS_EMU_TARGET_I386) |
>     >                             (1UL << SYS_EMU_TARGET_X86_64),
>     >     QEMU_ARCH_M68K =        (1UL << SYS_EMU_TARGET_M68K),
>     >     QEMU_ARCH_MICROBLAZE =  (1UL << SYS_EMU_TARGET_MICROBLAZE),
>     >     QEMU_ARCH_MIPS =        (1UL << SYS_EMU_TARGET_MIPS) |
>     >                             (1UL << SYS_EMU_TARGET_MIPSEL) |
>     >                             (1UL << SYS_EMU_TARGET_MIPS64) |
>     >                             (1UL << SYS_EMU_TARGET_MIPS64EL),
>     >     QEMU_ARCH_PPC =         (1UL << SYS_EMU_TARGET_PPC) |
>     >                             (1UL << SYS_EMU_TARGET_PPC64),
>     >     QEMU_ARCH_S390X =       (1UL << SYS_EMU_TARGET_S390X),
>     >     QEMU_ARCH_SH4 =         (1UL << SYS_EMU_TARGET_SH4) |
>     >                             (1UL << SYS_EMU_TARGET_SH4EB),
>     >     QEMU_ARCH_SPARC =       (1UL << SYS_EMU_TARGET_SPARC) |
>     >                             (1UL << SYS_EMU_TARGET_SPARC64),
>     >     QEMU_ARCH_XTENSA =      (1UL << SYS_EMU_TARGET_XTENSA) |
>     >                             (1UL << SYS_EMU_TARGET_XTENSAEB),
>     >     QEMU_ARCH_OR1K =        (1UL << SYS_EMU_TARGET_OR1K),
>     >     QEMU_ARCH_TRICORE =     (1UL << SYS_EMU_TARGET_TRICORE),
>     >     QEMU_ARCH_HPPA =        (1UL << SYS_EMU_TARGET_HPPA),
>     >     QEMU_ARCH_RISCV =       (1UL << SYS_EMU_TARGET_RISCV32) |
>     >                             (1UL << SYS_EMU_TARGET_RISCV64),
>     >     QEMU_ARCH_RX =          (1UL << SYS_EMU_TARGET_RX),
>     >     QEMU_ARCH_AVR =         (1UL << SYS_EMU_TARGET_AVR),
>     >     QEMU_ARCH_HEXAGON =     (1UL << SYS_EMU_TARGET_HEXAGON),
>     >     QEMU_ARCH_LOONGARCH =   (1UL << SYS_EMU_TARGET_LOONGARCH64),
>     >     QEMU_ARCH_ALL =         UINT32_MAX,
>     > };
>     >
>     > Can we use this to do target filtering instead? And we can extend this
>     > to maximal uint128_t to support maximal 128 targets in future, so it's
>     > not a burden to use it as a enum
>     >
>     > and for arm or mips we can use QEMU_ARCH_ARM QEMU_ARCH_MIPS  to
>     support
>     > multiple targets in a single integer.
>     >
> 
>     It's not enough, as some types depend on target config, and not only on
>     target itself. That's why this series exist, because I wrongly assumed
>     target would be enough when designing the original filtering, and it
>     proved to be insufficient.
> 
>     Concrete examples here are x-remote and nitro machines.
> 
>     >
>     >
>     > --
>     >          此致
>     > 礼
>     > 罗勇刚
>     > Yours
>     >     sincerely,
>     > Yonggang Luo
> 


