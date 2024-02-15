Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3816C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 07:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raVqi-0004BL-Jr; Thu, 15 Feb 2024 02:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raVqf-0004An-Ff
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 02:07:57 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raVqd-0003GE-HO
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 02:07:57 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a3d82926ed2so49162866b.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 23:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707980874; x=1708585674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1OiazDcobrZAPUvx4xaHM8BE3kYsl2JiBCl7BidHEOs=;
 b=hHfIHXau41f341W5ixJDg3p3pM2xolorscBhzoJt+bkCqCgVFZqwf0tBP+ZIZJzr9h
 SbWJR0oTh/Lh5dMrxifNjhVVFHMFmxoH4G82qA0Cm6VtFiT9SFLlkwj1nhfOuwiuXC+v
 Q8YW0ManL+74gIMzbZlHFg17kPcTlYWa3qL0EaHfFeaGpXVYke3Do7Ue0PdnKb0nz90Q
 YHv91jv4OZM9+8vIBsRuqqdU4s/EOzASmVtmzaXPp0TSZwwxXA3U49lazMdCKdbUFCK2
 68OAkP5BTTMrn6/qxUv/uGdvWlkn076j/nN/ZVcSO63zTZuHh9Loop+AMHCXHlxwEe5B
 oo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707980874; x=1708585674;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1OiazDcobrZAPUvx4xaHM8BE3kYsl2JiBCl7BidHEOs=;
 b=QazfYSeXr+/YRgeCjsQS5IuruzK704+dQhECV5aL/uqsBmM+VwRCwP3O6wR2SoM8KV
 NK6xmRH/12yBMMLCf/Obf+g1HHyGsWF803kWteBx/JIDVx+SyYqsMva+0YkZ1GVHBxLf
 IQuRWTugw17Yy240xvjdkoz7wk4bUoBnfpSd/Da3hvr+S8WwQ4wFeKGkj46JP70XFMGM
 iarMj1UlzP3EXsg80cw1Jhjl4nH9koSeuPlJke0bJ9xWfFwDQT7aax2BCmu3JIVH0dSb
 ZnPiNDCPva3r1TfOS+EClBfwBIIt1D4OSm2XE9Cwijohe5AmxKUNR5OTvkG5aCqCxrJE
 O6Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzlp1jrBDHCQJzQoknLQB9sliuzHwN/GJwLLdJuudhnq8OqvcMUXb967OoKGYJ7RO/A7HE3oA2Dqx8c1FZcaEDQ150TtA=
X-Gm-Message-State: AOJu0YxmfI5WyUT/41km+L1lC0RrVsW4glP1i2ddShkqA1v3V/zhfRSH
 rQ8nIEQqEFiE8P/U781gRhCruA1EVrMvjTCIdrEl7GRBC2Pip6Tj8cpVCIArpaA=
X-Google-Smtp-Source: AGHT+IG2Yv3UH9GcxJqGfArioE3zOtwrGoW7zvcQf0F4+cvcq7UnGibjSztE+AlvqOoU4kxJTyG+eA==
X-Received: by 2002:a17:906:ad91:b0:a3d:7072:d2eb with SMTP id
 la17-20020a170906ad9100b00a3d7072d2ebmr566238ejb.67.1707980873752; 
 Wed, 14 Feb 2024 23:07:53 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 sn24-20020a170906629800b00a3d296f46besm248102ejc.120.2024.02.14.23.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 23:07:53 -0800 (PST)
Message-ID: <2854a908-bc6f-4c18-bcf7-632efdd070eb@linaro.org>
Date: Thu, 15 Feb 2024 08:07:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 36/36] linux-user: Remove pgb_dynamic alignment
 assertion
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240215062018.795056-1-richard.henderson@linaro.org>
 <20240215062018.795056-37-richard.henderson@linaro.org>
Cc: Alexey Sheplyakov <asheplyakov@yandex.ru>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215062018.795056-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 15/2/24 07:20, Richard Henderson wrote:
> The assertion was never correct, because the alignment is a composite
> of the image alignment and SHMLBA.  Even if the alignment didn't match
> the image an assertion would not be correct -- more appropriate would
> be an error message about an ill formed image.  But the image cannot
> be held to SHMLBA under any circumstances.
> 
> Fixes: ee94743034b ("linux-user: completely re-write init_guest_space")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2157
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index f3f1ab4f69..d92d66ca1e 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3022,8 +3022,6 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
>       uintptr_t brk, ret;
>       PGBAddrs ga;
>   
> -    assert(QEMU_IS_ALIGNED(guest_loaddr, align));
> -
>       /* Try the identity map first. */
>       if (pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
>           brk = (uintptr_t)sbrk(0);

I suppose this isn't part of this series since posted as
https://lore.kernel.org/qemu-devel/20240214045413.541677-1-richard.henderson@linaro.org/

Still:
Reported-by: Alexey Sheplyakov <asheplyakov@yandex.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

