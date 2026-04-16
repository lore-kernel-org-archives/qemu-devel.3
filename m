Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42029F8A160
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDKr6-0002f2-Vx; Thu, 16 Apr 2026 07:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDKr4-0002et-Nt
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:25:54 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDKr2-0000WN-VO
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:25:54 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488c2690057so79608615e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776338751; x=1776943551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v4ydU8RqlM2saQrWN6PseVqMlzx4G6VqDed8mujhY8M=;
 b=b7NsiNZzsMIVFbkHABpZkBXn4Tk672G105pk8l8itBHyF44yYztRRUv+j+iCrEd0+c
 i/e1NOPkfgNLIqgw5/3DrptGcKh7KofFpJELJ2wAUuaYYCSxNKJ53UrR+oHnXRtl9A4s
 aOhqe1upZZ24fKiwLbZW2pAH1QQgXqQz0gxOxv8CdffVwcIdEGI9G+VvmMSjAQR97S+g
 l0j36tC3mIhD4UmGxwmYMtx4nMmq5zWLbwERxo5I/pHmdE/MkWhqs8m/l2PuicBVWn5/
 Lj4V6UgbuGrjiHp0Gh1Fc9lpILe0zHmdGOTBUd1gPINOmmnk6Hetxw2QDFBlDLnlv5kL
 qO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776338751; x=1776943551;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v4ydU8RqlM2saQrWN6PseVqMlzx4G6VqDed8mujhY8M=;
 b=dx6AHmz1M5TOPFn3SNvfpz0GgFLuVH9UFkxaeQ1e5LEByHvFWL181k/EEm4nJIrdGt
 USvEOjo8X0koO5TK2a3cDULYP/iFyDwcJSKXkpjx0F7tbgHVFYyzjmo42UXYQa00UJI7
 R5MUdBAPqYgicU7JoXh/czTH7YzH1A4hXJPMhynHuik95tg6QvZeft9PpJPgekgJDJEn
 p8s6dsSVrOQSMmbcqFu/4JjC0t5P+QP1Jq0aETXasVqIacrx08OmDdr5XtJzrGrF8QfT
 R8idytyIbGK6rJ5pjDLWhoufnQUW4DbBckQoOZZkJ2p+R1SeqnzKg7z7ZWCM9r/x8g5S
 my/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XKZUlMMDpjbaN2oEVVjXqqC1IR5w6IVx9cyvtyJC6b3T+8QsbcS2MsUqbPTNGX6xYrV3c8msEVX3O@nongnu.org
X-Gm-Message-State: AOJu0YyRfASnni0vqb/9taPtosjAnYxSDqkMzdxM2w0d6E3rigU6DyN8
 ozVN+RlVMzEKrFUzagtbi2YWoyiOCosmup45QXpa7nRFDCaf06IT8xqTBrR0Bet0OAw=
X-Gm-Gg: AeBDietyyk3xqN4jsiNSXUFhQ2hyHo/F5rNJMs7lXDc8+09qcGmawVUE9n9gTqU0ToD
 IcHMos/OryaiTphnt57Wqj8DDAj3BA7O0d0TTZfUTa78wjNxod9uE6ugXi42Kqs9N42bPQt9plJ
 wBN7pp5WAUvW1J4efeVWdMSK8zcYMqEaB8ojo6XIGIQYf1T36Cxl4lSoSoTnzqslnbbl0i99Tm5
 gpsND8fTQlykExPxJhlTbnem9oTR8E8psN5ecdd8O92NwMoL3QAo1vZw8FEmoNOWvImpXpceN+J
 O2RYBXmXr1y2cbaE2RkA+3BVoWWjkE2x3Kd4iKR/1uemhPBRQJdeK8oMLiU1FcLbUzdOo68eFLt
 30BB0spfGvKZgJ/8+hKnUgXooWQBRxBHIec3kJfmmlP59KjzGGJoZ0QU/lUxZxWdCgr7752eC/P
 ELoncCRaive03oMHwpNlnZbpB5p+nTjyHacgvG4C4T0issH0q6RedmJG6UC0xsGwjxdA==
X-Received: by 2002:a05:600c:64c4:b0:486:fbd1:9dc0 with SMTP id
 5b1f17b1804b1-488d68c2c56mr314664145e9.22.1776338750878; 
 Thu, 16 Apr 2026 04:25:50 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f582048bsm45917485e9.7.2026.04.16.04.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 04:25:50 -0700 (PDT)
Message-ID: <e41baa82-d096-41e3-bd27-5a4be359f842@linaro.org>
Date: Thu, 16 Apr 2026 13:25:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/28] MAINTAINERS: Remove WANG Xuerui
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu@xen0n.name, Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20260416091654.316158-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 16/4/26 11:16, Peter Maydell wrote:
> WANG Xuerui has not posted to qemu-devel in some years and did not
> respond to a query about whether they still wished to be listed in
> our MAINTAINERS file.  Remove them, on the assumption that they are
> no longer active in QEMU.
> 
> This makes "LoongArch64 TCG target" orphan.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7fb4e4770..0b2adbc247 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4115,8 +4115,7 @@ S: Maintained
>   F: tcg/x86_64/
>   
>   LoongArch64 TCG target
> -M: WANG Xuerui <git@xen0n.name>
> -S: Maintained
> +S: Orphan
>   F: tcg/loongarch64/

FWIW Xuěruì posted a patch 4 months ago that we ignored:
https://patchwork.kernel.org/project/qemu-devel/patch/20251207055626.3685415-1-i.qemu@xen0n.name/

(Cc'ed the qemu@xen0n.name email hoping it triggers something)

