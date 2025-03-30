Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC92C28B20
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 08:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tynxq-0002DL-LR; Sun, 30 Mar 2025 04:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tynxm-0002Ce-Cr
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 04:24:16 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tynxk-0003tI-AF
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 04:24:13 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso3148625f8f.2
 for <qemu-devel@nongnu.org>; Sun, 30 Mar 2025 01:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743323048; x=1743927848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=divQ2CncxackwiMkwlRFw619BjrM69wJW1gT81QYt6A=;
 b=ngxRjIPCkTy7Om+ewKr0GA6rMNHTKq2Wt6/2vKV0pRbxObn/f6Jwz9nR9GYsLgoyJh
 CKpIkJpLLm4FJwozc3PuTggR4d5awc9AAZV4lt3bb5SrIwXxiCU7eKbd5+rBbekgtzkc
 XvGtcSyGtF36GXc94qTHzvifetqH2UhVzkV3U6HRnYZzvUKXZwCCoRcFS/cLrTaiCZbI
 W83l96zxa3w1TAUVC4wy3omV6SipgCgj9LJMpGR1ZQDiuxFNDZ8o+XFAYuySZY5Cp+3R
 wW+oT91P5T+bJp2cxcBlqHHHe6yCwUgOao6gXsvI8SsDXajSUoyvADXdhfqbgtJAzqHC
 ZSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743323048; x=1743927848;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=divQ2CncxackwiMkwlRFw619BjrM69wJW1gT81QYt6A=;
 b=D6pNc7P5y7oa/R2Qdojc3ClF1v96abhPPzAFHZB+LWLiUJP6wFR24b12PVWcSwRFoN
 BUxdvP6L4071k88qGkkXVmJBHeOfrtB2n4ylXk4vMni0U8tiPIvl/MJmzxI/aZFvtYJs
 1uo6+J6pLqsch+6mdj/YLBocuzu1HQepiBAPGBJLKL0xFIckDzVjRWSYHuqNiGq4Aqht
 M69bmi8VApZ2Vf5s5dNFARX5m4xl5dAdaQSog7rESVy3L3L8H3BuROfE96XGkYzt4zv5
 SnJvlk2Sn1gXNDgQRjWPA13w9iuwBNinnlWgAhMyFSfdyKzOkebTw8O3NXVDwc/7cqJi
 GXTA==
X-Gm-Message-State: AOJu0Yw3GNdp67zpgpFHxRUKditDnAsy8QjF26GlH7eO+z0DYlHy9JnE
 /cTk990j9mpDOh6fV1xtkhglZwPEEvUjDztSnOtX+7wM0b2BUDIBxuqNVuFYlJ4=
X-Gm-Gg: ASbGncswNDJbNTBp5nDJsDL9rRDKLUckORT7axXgeL4qGkWanQkJRnbzyVlgWrFqvjs
 rIu4/N2Mojpc0W0dyo8OXvbHbOFmEiazQ7ek+pq+aWiJhglzu29aAD4qiRcU9B95IDupsUiwQ/d
 oce5WHkIyBzLlszNLYdVOxeKCKOit+d1U5XfY2pc3T1Ctc2zxgu342lreXZUtLlBcslBrzj5rok
 8R2s/o/ozRorQ99U4TCijiTre4pkLDVYo7QurtbH9lnUrc76kmUCvfK5uXcDmb2qCZ8qLW19jpr
 1oMBWp2poKOPvcdFjXzAyjp1Wuchx2nNPfRTB77w3UzQPWLQTq0ljDLgST+O0FJ6n27bXeXqaVa
 rG28=
X-Google-Smtp-Source: AGHT+IGyLe+XkTueodN4TYZF6f7n2geQOPznw8o1bs6U35L9naeyw2s0T6bIZqpuu6krKEbZ0LsXKA==
X-Received: by 2002:a5d:47a7:0:b0:391:487f:280b with SMTP id
 ffacd0b85a97d-39c120cb53amr3977561f8f.10.1743323048199; 
 Sun, 30 Mar 2025 01:24:08 -0700 (PDT)
Received: from [10.155.70.213] (63.170.88.92.rev.sfr.net. [92.88.170.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658c87sm8043513f8f.9.2025.03.30.01.24.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 01:24:06 -0700 (PDT)
Message-ID: <b306727d-48d4-4e0e-8d62-569b89d7fcea@linaro.org>
Date: Sun, 30 Mar 2025 10:24:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/ppc: Deprecate Power8E and Power8NVL
To: Aditya Gupta <adityag@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250329180427.2566964-1-adityag@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250329180427.2566964-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 29/3/25 19:04, Aditya Gupta wrote:
> Power8E and Power8NVL variants are not of much use in QEMU now, and not
> being maintained either.
> 
> Newer skiboot might not be able to boot Power8NVL since skiboot v7.0
> 
> Deprecate the 8E and 8NVL variants.
> 
> After deprecation, QEMU will print a warning like below when the
> CPU/Chips are used:
> 
>      $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8nvl -nographic
>      qemu-system-ppc64: warning: CPU model power8nvl_v1.0-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...
>      $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8e -nographic
>      qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...
>      $ ./build/qemu-system-ppc64 -M pseries --cpu power8e -nographic
>      qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...
> 
> Also, print '(deprecated)' for deprecated CPUs in 'qemu-system-ppc64
> --cpu ?':
> 
>      $ ./build/qemu-system-ppc64 --cpu help
>        ...
>        power8e_v2.1     PVR 004b0201 (deprecated)
>        power8e          (alias for power8e_v2.1)
>        power8nvl_v1.0   PVR 004c0100 (deprecated)
>        power8nvl        (alias for power8nvl_v1.0)
>        power8_v2.0      PVR 004d0200
>        power8           (alias for power8_v2.0)
>        power9_v2.0      PVR 004e1200
>        power9_v2.2      PVR 004e1202
>        ...
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> 


> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index ece348178188..0a2227802c06 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -32,17 +32,22 @@
>   /* PowerPC CPU definitions                                                 */
>   #define POWERPC_DEF_PREFIX(pvr, svr, type)                                  \
>       glue(glue(glue(glue(pvr, _), svr), _), type)
> -#define POWERPC_DEF_SVR(_name, _desc, _pvr, _svr, _type)                    \
> +#define POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, _svr, _type, _deprecation_note) \
>       static void                                                             \
>       glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_class_init)            \
>       (ObjectClass *oc, void *data)                                           \
>       {                                                                       \
>           DeviceClass *dc = DEVICE_CLASS(oc);                                 \
> +        CPUClass *cc    = CPU_CLASS(oc);                                    \
>           PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);                       \
>                                                                               \
>           pcc->pvr          = _pvr;                                           \
>           pcc->svr          = _svr;                                           \
>           dc->desc          = _desc;                                          \
> +                                                                            \
> +        if (_deprecation_note) {                                            \
> +            cc->deprecation_note = _deprecation_note;                       \

As mentioned in v2, we can just assign, no need to check.
Otherwise LGTM, thanks!

> +        }                                                                   \
>       }                                                                       \

