Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC283104891E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6Bw-0006ND-Hy; Fri, 27 Feb 2026 17:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6Bt-0006KC-DW
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:20:09 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6Br-000810-4O
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:20:08 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-480706554beso29806105e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772230805; x=1772835605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v7ZHQMFWjWl4mZlb+CYA8GnDjnrZ4AUcKOA5fzMdZ3Y=;
 b=cV7dib6CrY/vB38lYK+olJYgluo2BVfqYhbBzzL8KhMtTvDkGnBsXp69Lmf5vHIxf9
 PmhkSXgryU8Bw/pQF+DdfbMp5RvvLh+Ik7X3fwMzTL4r22Gv6quwEKQz/BRYBwQvy1y3
 Xg7GzYgUMME7tyExdzzZaTPqqjl3J9IjkDRpxJK86hVZOVXDjAEh0oaN/JQveJO2XNXo
 E8CCpg3yxb5M/awY6hozyYyZcI56JkwZ/flUFxMlsVzu68Q+uPhXbsoEgMmeda+fZZxT
 CkMdSiXIuZp/Mw7A3ZVI4Uwa0YjAbn/bSQ6SD6O0eTKRezyfdo6hKCwOL9VyBOkAxFr7
 DCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772230805; x=1772835605;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v7ZHQMFWjWl4mZlb+CYA8GnDjnrZ4AUcKOA5fzMdZ3Y=;
 b=LOaJLA68+dSWfifvP/pLKFHVZbwpmivmB3r71yJAI/YUJwW4AfkYaMv7P92EpXvH5C
 5FJDrYPU1kzyZjlddmFzoqdhttUZ1nLTeutfCozUbaQpVr1oi2gZ5NCEKL9LpbcJbpAL
 NCRVg5UYdIU8R0HLYzbPIQjxhq/nDu+qENyJtoYY9mIHuyUldld2BA8SdVC1+ij91YNQ
 RDrUbAhnUeiJJqrO5d+8wHS37kKfgOTLjvTA/Sk2VumgsBTFmA957oJiJAsOpVwj+wSt
 D3I25S71BOjr3Y3LKPnAUiPK+x2jkfxe5AOSFVe0yPoXBE4xWEO/rlHR7fRruuByriZz
 sxqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT5ifPuboMmxS9vNqfsXJQo6qQEU2jNPqdsAL41xLxOfkfriJizxwJiS9Wf6iCHlqHi3rEos37t3Vv@nongnu.org
X-Gm-Message-State: AOJu0YzxhkxF2S9aXectULLwm9hEX9ks6skB+eZaP5/UU0eQA8YwwQPl
 gnASf3t5GoK6agOCt0PCHGboWp9feUKEgHjezCMeh5lb6CvVOGJmafvcoSgbIPd1A+c=
X-Gm-Gg: ATEYQzxG0xCJWIStQHBe6DIfKLgy1G7+pLyFOWY4IjEAN+J140QwchKOVRwuJX25nvX
 lWF/8AVcfAsouayXd7cMHPYBMigWMQ3Cv9lpBt0O/WrzOm7gIMxk3Rc9mZ6KIkAWdP1pQ+XrYo9
 JNa/9Q85vjv6ak70cgwO0Z+1y39ZbbWq+xgJQBFaoDvcVa7mXpIDhDlPFFhBH0sq2amjnGA8MPc
 kfnUZ1eQiJ8LS3u+zbrEqExO3Rv2wyW0maW/xDVv1Z+Ju6iK8zWDISIwdwoKfBUaPky68ICGPiZ
 sGEYoILbwHaPJVIbrJQO1+ntqkV5nXDz6ofXGikSKM2WFBsOl4nlh3hrL6JxWonmokoT4XNhd5d
 Kn5Q+yxdCCDoooyI5x+wpdezL82Iw1ODSPJjuvzJSlZ4rZsl1EB+ZaKDk3Kc/girxiVwgxDJhL8
 bbLrAAAyX07d+TJCHOh/hxAv/i5qKkK2A95fvwj1oiLgYYEKnBrILJAN7NhBN1ZGv1jFUJcL1ma
 x+9
X-Received: by 2002:a05:600c:8b01:b0:483:be73:9b1 with SMTP id
 5b1f17b1804b1-483c9bdb186mr77889075e9.31.1772230804647; 
 Fri, 27 Feb 2026 14:20:04 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd75dfaasm217043645e9.12.2026.02.27.14.20.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:20:03 -0800 (PST)
Message-ID: <35984e30-23be-4796-bf06-7fae66a08652@linaro.org>
Date: Fri, 27 Feb 2026 23:20:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 37/37] target/hexagon: Add hex_interrupts support
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>, Sid Manning <sidneym@quicinc.com>,
 Michael Lambert <mlambert@quicinc.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-38-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260227203627.932864-38-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 27/2/26 21:36, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Co-authored-by: Michael Lambert <mlambert@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h            |   1 +
>   target/hexagon/hex_interrupts.h |  15 ++
>   target/hexagon/cpu.c            |   2 +
>   target/hexagon/hex_interrupts.c | 332 ++++++++++++++++++++++++++++++++
>   4 files changed, 350 insertions(+)
>   create mode 100644 target/hexagon/hex_interrupts.h
>   create mode 100644 target/hexagon/hex_interrupts.c
> 
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 3f4f8516f2f..99150aae753 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -190,6 +190,7 @@ struct ArchCPU {
>       bool short_circuit;
>   #ifndef CONFIG_USER_ONLY
>       struct HexagonTLBState *tlb;
> +    uint32_t l2vic_base_addr;

This field is never used (nor in
https://github.com/quic/qemu/tree/bcain/sysemu_review).

>       uint32_t htid;
>   #endif
>   };


> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 69b5c56b55f..a1ca4075472 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -61,6 +61,8 @@ static const Property hexagon_cpu_properties[] = {
>   #if !defined(CONFIG_USER_ONLY)
>       DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
>                        HexagonTLBState *),
> +    DEFINE_PROP_UINT32("l2vic-base-addr", HexagonCPU, l2vic_base_addr,
> +        0xffffffff),
>       DEFINE_PROP_UINT32("htid", HexagonCPU, htid, 0),
>   #endif
>       DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),


