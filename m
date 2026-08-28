Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16D6C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 17:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x006M-0001O9-Ie; Fri, 28 Aug 2026 13:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x006H-0001NS-SK
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 13:10:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x006F-0004hb-UO
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 13:10:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SGJubA4132420
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 17:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6HFwXtphroyYmtI7DV97c0JvF7nJ88pn7s/U+7RgISI=; b=pFEdy16S/PtKT89A
 K7IzwzqMBP3vjrmthHiP9JexRGjGgdBpxkD6ggw6csxm/3lh8S7/W6YZIDEzB91E
 eV+HehFoz/b0/3iS20K9YleJr9XBzfyFw1UmD5TLlcQseLLUYEIpRowks9aWcF2z
 wN6fcmzVO1tPGg22kLXczczxxrtkXtzKv//FZQ/O25lYNjUvg2phQmSoJvuD1qJk
 06fufV/gpymE+gEvKD3WU7JILhs+K6e7VEoqREqoA6KTMHCgfZ605+W8E9SG8dFg
 lT28Msr6WFeubp8a7aBixhoA8QzzdOomRxbXKA+RpNx9+1NGhh8G2AwWfhybPI1v
 ppHzLA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42pam87-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 17:10:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38f57e31b6eso1282537a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787937041; x=1788541841; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6HFwXtphroyYmtI7DV97c0JvF7nJ88pn7s/U+7RgISI=;
 b=P7rdWPK507pEM+G9lri0+zBKyqPRlJK1SZQ/YwgHqMmApeCCUwkfIFbsc69EEWEVgQ
 bUE9ZuOvVEti9gFx0oSGchxgB2XsjNDoT6DGFStg+wQpQtQhBTUcweFvmAaWsUyHSr0h
 MxldhEHzZj5k4b3MVPsXBJT6yTcv1CThZLDSLheZpFatqNehPNjINDWhmGHX1Zi5OvjA
 qbvoF75XdfAp4f9xbrrKF8MAqNbuMuUrK4SH860ONvpkDsGjDU2jq3MdG2bnlDljqrZq
 iV6SLUgqLGCpWcsmJHylkRrLU9H+6juASvsyOPX8+z1thDuxhTPpRqhQ+0GQ41q6+vrJ
 3VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787937041; x=1788541841;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6HFwXtphroyYmtI7DV97c0JvF7nJ88pn7s/U+7RgISI=;
 b=pwIdB7tMgKEFZpDvoIjVHJtXFNSI+ZbMjcdOr4jUCWs0JT/ocQKGF2FNhiog8X2+Qj
 cnRsel6cwz59OjNhcfck6HNjwXZpB3xUEfKJc+XpUv1+DjldZ6KEEWg+p/n0gn8FOd+v
 umjwahs7w4zxgKLDdnNo9TgG46mCt762vBcg3seDxhFI3REqH6CcNdpsqh5c/Nx2tVbD
 1p7LBv9/cIBdQrFQSYdxCf/6/B8ZRthEp2oFf7SJsiY1dX3RJZLpUNqUxfOyW11pQVvM
 Asy1t47aFizXYMMuEL0Jv0jxyPGV8coBWexO+FrRh6jIH2jmUzDmdu6NtizVubmQHPOG
 IVjw==
X-Gm-Message-State: AFuF++neIYwZmF8uN8YX2k2AqJ49xrriFZnjUvswynAn+HLC+gWQOdb3
 pY/pkayObgcjL151vGvcMDz01NZMVu1ey0wkBtwg2TbLlz1znvxPzevBwt3OETSAv8yIuuajGIO
 U0M2TaakqPrZkWG/GGrKCcwGmEYQ8MM42APFVP/mAMVEBjgfMCDfaPLRo6Q==
X-Gm-Gg: AR+sD122TJRn9kG5kDmhIJOziED+j5+ZXGelmHLQREmdU7xWc+dGPr9YJgGPb7aWaSo
 hH5vz2nGOnWUI01vIRDhLq+7K36el274IQBDyt2i9WYI/+ACK2JwSzCcqoxpJkjImhC0mtSONBv
 QdsYoTHUWBSMuqUGLiRwnNXD0vPs6IMEvFrfvuCfYwNHeqakRH1cXSV7YOGupWSZyjlabj0k9ny
 faD4Xu3WIGK46BbkoSZY1meURLuKUUSAvolESXzRGzbeVQZqVxsYZ94Doz3ShBxw+JFsvAEQndw
 HedWQ7EMUY6BVNueN53DPNgXrle0xCMxbH2aPdok7MzGvVSBQTntw0AIdDL3bfmYa07RGFmXpoG
 q8qzl0+wbqyZuBc4/Q+4sDe1GrAyZjK3TR2hnYUKTVSnskj34G71hCEnuND5SzTRLpLYY
X-Received: by 2002:a17:90b:2ec4:b0:38e:75f3:ad4d with SMTP id
 98e67ed59e1d1-396d0edf5d6mr19092452a91.7.1787937040797; 
 Fri, 28 Aug 2026 10:10:40 -0700 (PDT)
X-Received: by 2002:a17:90b:2ec4:b0:38e:75f3:ad4d with SMTP id
 98e67ed59e1d1-396d0edf5d6mr19092388a91.7.1787937040294; 
 Fri, 28 Aug 2026 10:10:40 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f9ecaa9sm7253152eec.26.2026.08.28.10.10.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 10:10:39 -0700 (PDT)
Message-ID: <a38bf9f3-cbdb-43bd-9753-924b30c02db4@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 10:10:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] single-binary: implement dynamic filtering for
 machine types
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE8g0nAJPoJvjZGR_KpEAo+C+S7+QTdZGhagBQE_diDXcw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE8g0nAJPoJvjZGR_KpEAo+C+S7+QTdZGhagBQE_diDXcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Dgf0xUYXE92m7Je3kDrljh_SnPKeZoE6
X-Authority-Analysis: v=2.4 cv=ToDWQjXh c=1 sm=1 tr=0 ts=6a91c111 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=JKIf-koSgo4kqYJha5sA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Dgf0xUYXE92m7Je3kDrljh_SnPKeZoE6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE0OSBTYWx0ZWRfX9CcVeq5NFFG/
 NP1ZkUs2GpjgN2QV7JrvHSmZKcz0NLl/zIztvtDOZtMj218y963jRBBlx7bannxUnAx4W2baPJ9
 D7kScNl7h+YMYlx3Zc/5sNWjmvUBn94=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE0OSBTYWx0ZWRfX1zx8v8xOb3lo
 vU2hGDO+rBgACvk0l6tV9jsvmCadKY5atsmwCORnWaNnfgFnuwGvBoikfQIy5mzXaLvb2CS6RPf
 E2xStLrYViecxcctqsNdR0p+syrA02EGLoTY2cqtk3m3+RvPz+pwyYnJphtzcgQhtCTkNvJhu1e
 Q8LuEAZtGsAOBdL/biVBj6rf02FalAL+gyTTkTMHn+0r0jCK19NB+VDZQ9cZPoGinmAO8VL9LA/
 LKdY8Xb0zfZ1DxUe3T3AcdZ3DPNw6RuSYipsBGwN4mZ54b6Og+qFTm09sUfbDxnlQwdYOrq5Gxp
 HubD+SiCCvJN4AL71Z8bYQ5csylJnyl7TJPbn6nOtC7bFvinFj8Ss3H4MOHg0Y2t1d8MYg6A+UL
 fPcI0AHcHVNmOl7SWDEfQ0cWfUkbuiDzuyMOFbQRgmiWFis5OkPFd4lyX7PjN5W2/qjQ5l9Hs34
 VFZgFPCccYffqweNQtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280149
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 8/28/2026 2:51 AM, Yonggang Luo wrote:
> 
> 
> On Fri, Jul 24, 2026 at 8:11 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>>
>> Now that we can link a single-binary with at least two targets (arm,
> aarch64),
>> we want to make sure that we expose the same set of machines (later
> devices and
>> cpus) than target binaries. For that, we implemented a static
> filtering based on
>> target interfaces that each machine will implement to declare which
> targets have
>> this machine.
>>
>> However, we discovered that this static filtering is not enough.
> Indeed, some
>> machines and devices do not depend only on target, and their presence
> can depend
>> on Kconfig or host/target combination. Thus, our static approach can't
> work, and
>> we need something more flexible.
>>
>> This series adds a new TYPE_TARGET_SPECIFIC, that declare a single
> function
>> bool is_available(void). From there, any machine type (and later
> devices and
>> cpus) can implement it to override their presence for each target.
>> We first replace the existing static mechanism with this, and once
> done, we
>> cleanup all the old interface. One nice benefit is that we can get rid of
>> config/targets/*.c files, which saves duplication.
> 
> 
>   About target-filtering, we already have 
> 
> enum {
>     QEMU_ARCH_ALPHA =       (1UL << SYS_EMU_TARGET_ALPHA),
>     QEMU_ARCH_ARM =         (1UL << SYS_EMU_TARGET_ARM) |
>                             (1UL << SYS_EMU_TARGET_AARCH64),
>     QEMU_ARCH_I386 =        (1UL << SYS_EMU_TARGET_I386) |
>                             (1UL << SYS_EMU_TARGET_X86_64),
>     QEMU_ARCH_M68K =        (1UL << SYS_EMU_TARGET_M68K),
>     QEMU_ARCH_MICROBLAZE =  (1UL << SYS_EMU_TARGET_MICROBLAZE),
>     QEMU_ARCH_MIPS =        (1UL << SYS_EMU_TARGET_MIPS) |
>                             (1UL << SYS_EMU_TARGET_MIPSEL) |
>                             (1UL << SYS_EMU_TARGET_MIPS64) |
>                             (1UL << SYS_EMU_TARGET_MIPS64EL),
>     QEMU_ARCH_PPC =         (1UL << SYS_EMU_TARGET_PPC) |
>                             (1UL << SYS_EMU_TARGET_PPC64),
>     QEMU_ARCH_S390X =       (1UL << SYS_EMU_TARGET_S390X),
>     QEMU_ARCH_SH4 =         (1UL << SYS_EMU_TARGET_SH4) |
>                             (1UL << SYS_EMU_TARGET_SH4EB),
>     QEMU_ARCH_SPARC =       (1UL << SYS_EMU_TARGET_SPARC) |
>                             (1UL << SYS_EMU_TARGET_SPARC64),
>     QEMU_ARCH_XTENSA =      (1UL << SYS_EMU_TARGET_XTENSA) |
>                             (1UL << SYS_EMU_TARGET_XTENSAEB),
>     QEMU_ARCH_OR1K =        (1UL << SYS_EMU_TARGET_OR1K),
>     QEMU_ARCH_TRICORE =     (1UL << SYS_EMU_TARGET_TRICORE),
>     QEMU_ARCH_HPPA =        (1UL << SYS_EMU_TARGET_HPPA),
>     QEMU_ARCH_RISCV =       (1UL << SYS_EMU_TARGET_RISCV32) |
>                             (1UL << SYS_EMU_TARGET_RISCV64),
>     QEMU_ARCH_RX =          (1UL << SYS_EMU_TARGET_RX),
>     QEMU_ARCH_AVR =         (1UL << SYS_EMU_TARGET_AVR),
>     QEMU_ARCH_HEXAGON =     (1UL << SYS_EMU_TARGET_HEXAGON),
>     QEMU_ARCH_LOONGARCH =   (1UL << SYS_EMU_TARGET_LOONGARCH64),
>     QEMU_ARCH_ALL =         UINT32_MAX,
> };
> 
> Can we use this to do target filtering instead? And we can extend this
> to maximal uint128_t to support maximal 128 targets in future, so it's
> not a burden to use it as a enum
> 
> and for arm or mips we can use QEMU_ARCH_ARM QEMU_ARCH_MIPS  to support
> multiple targets in a single integer.
>

It's not enough, as some types depend on target config, and not only on
target itself. That's why this series exist, because I wrongly assumed
target would be enough when designing the original filtering, and it
proved to be insufficient.

Concrete examples here are x-remote and nitro machines.

> 
> 
> --
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo


