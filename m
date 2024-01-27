Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14436C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaM8-0004re-F2; Fri, 26 Jan 2024 23:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaM7-0004rW-3n
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:31:47 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaM5-0006Ut-Hw
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:31:46 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bd7c5b2439so792026b6e.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706329904; x=1706934704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=URTUPDqaB1KrQpHhXBiULwCn+DbvnbaVle4GLPY5KVw=;
 b=Hig+ukVtN0HoMQ8QJTAYfn+32Cw4QQ9yjPgrO8wChWSqoAaKzzonRVJQqDAVN/rQO7
 c1eQIF7rLTdkDjAjxM7i1k5SJuc46h0UaoORY0uzeOuZ6zmUKkeixdpV/7l8erEbQYMd
 L6I5mGygCvqydExDgBeWvO66KmzJL8XVkPbPbsUOum64hzto89wBHZ4X9QaFlrGZe2XI
 dR3DUgP16tBCFQrFFQYbEnZ29JyL55DeoeXA93JzO0HAwVtwTlOCCPk30FPDkcKerJ7D
 QlDQNE9iuscemEMRvhpSGDHM5gLNI4G+ZstD/GQnxWKY0VPYZBBpbdAqdX7GiRGneA6d
 UU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706329904; x=1706934704;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=URTUPDqaB1KrQpHhXBiULwCn+DbvnbaVle4GLPY5KVw=;
 b=B2l5uBMPDLPEkP2rmvk6XJa52RQvSjZEbVq98dtAfqV0V0zpHs2aW3u3tAVRhLpxfm
 MDC6Le6d9kBLyXN/SDd7TU7PJAsBOHJr+gZPYx79eYsgEcbMvgjUZXHuRZpkm7H7Swta
 OZgs5k/plbfVq2tTZeRHzVtUVfv5Hc1Fa7N6pMaQ2KQ55LUGo8cyVfqWNA3h7LVoRnw+
 sDCndwdvZsaKBg+QUF72Vk0++k98XmL2+jd89QLcqvZPnRWFvqXqETFpWovlEZuna7X2
 XEb9m1VOxQLqEGv1J34hxLnFsDyx8vqgdgR/Mq8WPU4tSKHmgbJsRjtLumaBdsuxPCQy
 rf5Q==
X-Gm-Message-State: AOJu0YxF64rrdilcbAcPWJQr9p1USp6i6IUVJP+mQ8MVsJe4meBpzlZJ
 Sf1GgTzRIauYLqwB/rsjN4gWYJSwiMCoPl+mE7oz5wdb1l/AB0aguSRZJuWvFYI=
X-Google-Smtp-Source: AGHT+IELtzs34k7ZBD+c2VqqUVHaI8WwYQaKUPxgxFv9eEp3Hh4mj3660AEsQf1EV2PYtLasmdB5PA==
X-Received: by 2002:a05:6808:d4c:b0:3bd:ceef:804b with SMTP id
 w12-20020a0568080d4c00b003bdceef804bmr1269073oik.12.1706329904329; 
 Fri, 26 Jan 2024 20:31:44 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 s24-20020a056a00179800b006d9a6a9992dsm1864732pfg.123.2024.01.26.20.31.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:31:43 -0800 (PST)
Message-ID: <d041362d-ae22-40a7-868f-e91bc6ea7556@linaro.org>
Date: Sat, 27 Jan 2024 14:31:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/23] target/i386: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/hvf/vmx.h               | 13 +++-------
>   hw/i386/vmmouse.c                   |  6 ++---
>   hw/i386/xen/xen-hvm.c               |  3 +--
>   target/i386/arch_memory_mapping.c   |  3 +--
>   target/i386/cpu-dump.c              |  3 +--
>   target/i386/cpu.c                   | 37 +++++++++------------------
>   target/i386/helper.c                | 39 ++++++++---------------------
>   target/i386/hvf/hvf.c               |  8 ++----
>   target/i386/hvf/x86.c               |  4 +--
>   target/i386/hvf/x86_emu.c           |  6 ++---
>   target/i386/hvf/x86_task.c          | 10 +++-----
>   target/i386/hvf/x86hvf.c            |  6 ++---
>   target/i386/kvm/kvm.c               |  6 ++---
>   target/i386/kvm/xen-emu.c           | 32 ++++++++---------------
>   target/i386/tcg/sysemu/bpt_helper.c |  3 +--
>   target/i386/tcg/tcg-cpu.c           | 14 +++--------
>   target/i386/tcg/user/excp_helper.c  |  3 +--
>   target/i386/tcg/user/seg_helper.c   |  3 +--
>   18 files changed, 59 insertions(+), 140 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

