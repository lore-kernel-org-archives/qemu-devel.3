Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6988AC5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 06:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwCsR-0001Fv-Ui; Tue, 18 Aug 2026 02:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwCsO-0001FK-Ob
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 02:00:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwCsM-000726-Vu
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 02:00:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I3iR2j1171927
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lKmx/oXJnXx308KWcQ9z722ZJ2Fse/sOjJrigePd4nA=; b=oeopAWX9jofD73GM
 Ylnap39zZm4bgZS41LlGQbcnYI/qjUoxR1ZB31UEnIM7Kvz2+KOHItYDCxlU3fxN
 U+/jjBt0rWQWQTV9P3MZpXMBsfS2mSsZ7cu203XNQSHcTKx6TGDgimygEve1aKQQ
 oOr7boAKk44mfC2cfc8MAJHKHttNMfD+GnnWpYrZKefqfHzUr5WpBtJde5RhHdEt
 Xv/9d8MrQQ8eHCOiDLCPx0dVxh/lakcfhtHarK/MQIxNTKQ2r52IOafijRFduy2l
 IMtclLtHp8sADsBahy+I69K4lL8JpP/njYEZ1KHyVEd5a7x4aefUR8lmOIbEF+R/
 57nR0A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4frmrhx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:00:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930b6bdcb4fso611764385a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 23:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787032839; x=1787637639; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lKmx/oXJnXx308KWcQ9z722ZJ2Fse/sOjJrigePd4nA=;
 b=ePNGYujMggoYLDyl2DQ3EISVBIFUt94itZXgzduGZ4uuYu04wyULsiWvCfxrrYxogf
 y1byMSZGbOYyhHhZLHAy2z4RmijyxIX4mIKkygrCL8eBqrSI+LKi1SFXFmGB2VknE4xT
 7HRwIhQLpFkKqdguCpCv6Uv1Ue/fZ68cHJoDXw052yvBXDXfl5iUKN0J7Ef+uqVYrTtJ
 ok4JGPXL4zTVHNCK8ZOPg3AMiRN7xNQsITaWSFRVnEHZlznMKQIWdeiDqZupWpKTaT3a
 mFm6ikydYupx0JEoAPHut6FML+EBlB5RtpDiOgMu50qgLxit84D6alUbxN9hx6gJ1LGU
 hTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787032839; x=1787637639;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lKmx/oXJnXx308KWcQ9z722ZJ2Fse/sOjJrigePd4nA=;
 b=f5xsqJnz+7HWli+Sk6bvaS42AD2I1iLu/7h3JwAeAfrlRwq4bce5RDbSN9x0jt8/X0
 EfRmzh/CczQU8WdC10sOQmvF//9bOhSKHnQEK75Qpcd9bNzAtSVGr/YSs3hjjFDsMBBz
 /d3guQ1FPSkfRuJu8zvh6OPbOPMFxb3EGztmAWnbi4eUq62dtLI1qCgX0R5DL1VdF3Vb
 me1vU63Snq8QD3U/C1/2reguusUxaVthuMfzr0Y2lGJKy/d2YOKf4DJqK7ytfUBYFUC4
 VkkDS55AcmyTGxKHkK1hyNyXSWJCiwlnp6ShFD23rB+Z95SXt65ljGRsSToPAnT86/Ob
 GumQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpE8S7lQfmF1ML83pU7gA8VXmyNq2deoq0qjggHuOua2cKgMtImtTJlvxu+ftglg07Wrj+RCWXGYpgH@nongnu.org
X-Gm-Message-State: AOJu0YzdHhn34j731TTEUEGsEeUd658roP/+X8dncfoZW7kl1eg1CH5Y
 ATWVt4O+mrha4b6Or1/bJW3Ycd/sD68Vm4HkhoHfn5rdLsMU5o0yoM0ztrCdvc1AGM866kGNfya
 LHDAS3hVvxIlaTsQq9Zko7X4z0me/8IGHgCSleBPTCWCo7aJGdHhaXnA+iQ==
X-Gm-Gg: AR+sD129AnFl16Y9pqBm77zmySq2bO6ZtosFKzkaqQeWoHDqJZnhLoav5zSm3LHRaL+
 UTnUDJtKzn+oXk1X20WQ7nD3yn+0XpDfAbBRBMUEOFqFJ06TALxSMYZtUkIfjz8s85ImfaRnYvI
 UnPYK/iH/cUpzezFfdE97XS8HDzsWEZn0fWx+Ch6FsYpG0YwZ4hwkt49/EEcw/uUNz/NOMr6bcw
 LcOES68Ly3jjfmzLYmDvAF2mP87BQUGvpXp8WH5nojEvkIul8+ePPd0OcjJMopgE8VWmQ2MmXTH
 vKpJngd2Dak1ALnksc/GKg8BjIIjz+id73mHMjGet6z5WnyuInU8Kr4rflFpyNCasXg9xFex+h/
 rZ2pW3YATETsSlWv9k69XK6Nox02wj/Apd+8=
X-Received: by 2002:a05:620a:a191:10b0:92e:51ee:7944 with SMTP id
 af79cd13be357-936d22f8f26mr2497187285a.34.1787032838676; 
 Mon, 17 Aug 2026 23:00:38 -0700 (PDT)
X-Received: by 2002:a05:620a:a191:10b0:92e:51ee:7944 with SMTP id
 af79cd13be357-936d22f8f26mr2497176385a.34.1787032837828; 
 Mon, 17 Aug 2026 23:00:37 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a31572sm9451552f8f.5.2026.08.17.23.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 23:00:37 -0700 (PDT)
Message-ID: <760d9989-96b9-478d-9e71-dc47f47aeab9@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 08:00:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/8] accel/tcg: skip the can_do_io stores in user-only
 builds
Content-Language: en-US
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com
References: <20260817190038.580257-1-mattst88@gmail.com>
 <20260817190038.580257-4-mattst88@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260817190038.580257-4-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0MyBTYWx0ZWRfX74cI7c8rfoBm
 ejdyuZgOzOQa8W5ynYAkOweHx+kNvoS0yNpM7sfRDptAW3QOFj0ho58xL2Y+R9Mbd0dNQ66L2u+
 LAgDbwwH+Y088bOQwPTmueasPwy6nRqUppg4lM6p6dSd6sObfTtKzyhzBMJ1FTqsFC7/ihrgcbr
 fq7Jc8FyM3AxcUmxcLuYjlghFqigsHZUTmJCGghGaW0Pk85RD69xGkKJsSBj8qzFFZfgkvyNIt3
 gpTWqvLQVHWAA71J5nnrqwB8YZLgbfdXpWfgOhFtgE+Jquym0QTfhPxQJyRiAg417uUso8Fy16t
 4Wxr7hK3Ca2DGdSwBcVBBJsQYqpkSDQG+g/LEbCawWHKgakC+iQPvwafzY4to0MX/9fV1Bm0jtE
 d+NbjU0l1fM0cT4TrQKNYKpyVGhtBQ6BeRV292IkWgBKI2WFwFXeixUA1EF1r8Xdwvc60dMSV5k
 IlO3hyUGRTYX47pwu2w==
X-Proofpoint-GUID: jdQl-rA_U6eQBm786P_G2AYOffCRQWYH
X-Proofpoint-ORIG-GUID: jdQl-rA_U6eQBm786P_G2AYOffCRQWYH
X-Authority-Analysis: v=2.4 cv=GtlyPE1C c=1 sm=1 tr=0 ts=6a83f507 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=Lp6gHy6cP4WB_V5DFnUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0MyBTYWx0ZWRfX1yRibVmQiJtG
 M4u+UsURLuhJYhD0gx3AbrieOX7d7xHH8VzVseHJ5zrY2R3nKFkWCiv1BBe5wYtuBHujZXcO3CV
 VSYmt9jV0TlOMOvm4roOJGeFV9n4x7c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180043
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

On 17/8/26 21:00, Matt Turner wrote:
> Every translation block stores to cpu->neg.can_do_io twice: false before
> the first instruction, true before the last one. Nothing reads it in a
> user-only build. There is no memory-mapped I/O in linux-user, and every
> reader is in system_ss: cputlb.c, watchpoint.c, icount-common.c and
> tcg-accel-ops-icount.c.
> 
> Two stores per TB is not much on its own, but TBs are short. An emulated
> alpha gcc 16.2.0 compiling the SQLite 3.45.1 amalgamation (255k lines,
> -O2) executes 34.2 billion TBs at 6.04 guest instructions each, so this is
> 68 billion stores for nothing.
> 
> Measured on an x86-64 host, LTO build, on top of the preceding two
> patches:
> 
>      before: 1,469,729,281,442 instructions
>      after:  1,402,816,253,499 instructions   -4.55%
> 
>      before: 120.97s wall clock
>      after:  115.75s wall clock              -4.32%

Nice.

> The emulated compiler produces byte-identical output.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   accel/tcg/translator.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git ./accel/tcg/translator.c ./accel/tcg/translator.c
> index cd7d079fe0..29e609b2ec 100644
> --- ./accel/tcg/translator.c
> +++ ./accel/tcg/translator.c
> @@ -21,12 +21,14 @@
>   #include "disas/disas.h"
>   #include "tb-internal.h"
>   
> +#ifndef CONFIG_USER_ONLY
>   static void set_can_do_io(DisasContextBase *db, bool val)
>   {
>       QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
>       tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
>                       offsetof(CPUState, neg.can_do_io) - sizeof(CPUState));
>   }
> +#endif

I'm a bit reluctant to clutter translator.c with #ifdef'ry (in
particular when we are not protecting system-specific API, so
this can be evaluated at runtime).
We could have a tcg_user_emulation() or user_mode_emulation()
helper hidding the #ifdef; or could move set_can_do_io() to
accel/tcg/translate-all.c, or maybe others have better idea.
The overall change LGTM otherwise.

>   
>   bool translator_io_start(DisasContextBase *db)
>   {
> @@ -210,17 +212,25 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>       /*
>        * Manage can_do_io for the translation block: set to false before
>        * the first insn and set to true before the last insn.
> +     *
> +     * Nothing reads can_do_io in user-only builds.  There is no MMIO
> +     * there, and every reader (cputlb.c, watchpoint.c, icount) is in
> +     * system_ss, so skip the two stores per TB entirely.
>        */
>       if (db->num_insns == 1) {
>           tcg_debug_assert(first_insn_start == db->insn_start);
>       } else {
>           tcg_debug_assert(first_insn_start != db->insn_start);
> +#ifndef CONFIG_USER_ONLY
>           tcg_ctx->emit_before_op = first_insn_start;
>           set_can_do_io(db, false);
> +#endif
>       }
> +#ifndef CONFIG_USER_ONLY
>       tcg_ctx->emit_before_op = db->insn_start;
>       set_can_do_io(db, true);
>       tcg_ctx->emit_before_op = NULL;
> +#endif
>   
>       /* May be used by disas_log or plugin callbacks. */
>       tb->size = db->pc_next - db->pc_first;


