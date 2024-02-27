Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB53FC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf1zX-0000VO-V7; Tue, 27 Feb 2024 13:15:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rf1zC-0000P2-JU
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:15:39 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rf1z6-0003g7-RI
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:15:26 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412ae087378so6814125e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709057717; x=1709662517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zLZrhJhE63vlPUo7z57RU3MPKrdHlrl35iPxJrFSFQ0=;
 b=lxRzF3p3W5ufq1GCkSP5z0ZASBe3Wzajxi8SAr7iywcN1Tw2j79NHSbHVVn7lr6U3L
 KnnoWZZO79C5xi0A84v+a5n0+PfjsBSlz6FIEstlXgQPsDCykFlYSorA28jTRtRc7ruE
 e4ohrqfynqpAIPG1cytdvf+qIoaAnGGADKV1yP1JloC1dU/EJ4mPB2i2KbmJtIPNTLlw
 J+bwv5WPecRLRri7lkgVOvRhMw/6GSzF59Ity9JF8vsFvn0odXQECbZH+gvzDbSM8aXK
 UBDu/LWJJLIswHVre6d+r8fB4sSrurr3rYnaxUd70QGVwLjMEs0eBMSDZ2ahqVBXIouA
 7qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709057717; x=1709662517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zLZrhJhE63vlPUo7z57RU3MPKrdHlrl35iPxJrFSFQ0=;
 b=UkDbeoz3O6YuGh8sIdXvof2qOAA8attxc4nijfYzW4JkHEaK7TRxmTJ5M88peo+Mwb
 ckq7mLwQUOhH35eqlzch6EzT3ik8JlLmZiT6Re1WSeKBGQ/clicDfTQe0YuJQqSgSnxK
 MxxOSoqtTJVm5wzdFMrRLEhBw6Txm7zSSstAjh5uT8cplc0Ggka2z8x6zsoC9UBgo2QG
 Gzj4k5XfRtInwSAVOvK9kmgsoN21pQJQeRAFL+HeBYaQHbwPNVSNGBg3uRxINj0kz33b
 DO0+xmVhch2XFT+Iqamu+b+AqP6J2O0qFWhT3xzOSmbpNnNOE9+pWkzft09PpGJcxxC7
 Le2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx7UTylm6e5S3WSf0qu6qqAMR5e5q7TSqKqKekkC9mf6GEox2GyqoSfMKXJp9oR+z3gT1g8sU2UbIo67qmBaajjOzw1ng=
X-Gm-Message-State: AOJu0Yzec/W4hKzIQdjy9BlV5BpvpgrzpKChpwMgrki0+oHpuwf7G2BJ
 H4ECXaYbJf26uzdI9ioWQ+1Yz9gA539Guvg+kJUKXNDKA32W994CNWqkjFttDf0=
X-Google-Smtp-Source: AGHT+IHfBPjFEXxsJ4aZsnKHdvPJ6oZZB0uBI7+eEAFwpqzkoE81P6RtjAKu7tAWwv5SeeC3lXWibw==
X-Received: by 2002:a05:6000:1e8b:b0:33d:dffb:7144 with SMTP id
 dd11-20020a0560001e8b00b0033ddffb7144mr3585586wrb.60.1709057717379; 
 Tue, 27 Feb 2024 10:15:17 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.23])
 by smtp.gmail.com with ESMTPSA id
 r2-20020adff702000000b0033b60bad2fcsm11880927wrp.113.2024.02.27.10.15.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 10:15:16 -0800 (PST)
Message-ID: <48e5e0b8-9b0a-4c9f-9f3e-c30e2fddc502@linaro.org>
Date: Tue, 27 Feb 2024 19:15:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TCG change broke MorphOS boot on sam460ex
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <fe59ceb1-e8cd-f488-d6f0-6372923a8a33@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fe59ceb1-e8cd-f488-d6f0-6372923a8a33@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Zoltan,

On 27/2/24 17:47, BALATON Zoltan wrote:
> Hello,
> 
> Commit 18a536f1f8 (accel/tcg: Always require can_do_io) broke booting 
> MorphOS on sam460ex (this was before 8.2.0 and I thought I've verified 
> it before that release but apparently missed it back then). It can be 
> reproduced with https://www.morphos-team.net/morphos-3.18.iso and 
> following command:
> 
> qemu-system-ppc -M sam460ex -serial stdio -d unimp,guest_errors \
>    -drive if=none,id=cd,format=raw,file=morphos-3.18.iso \
>    -device ide-cd,drive=cd,bus=ide.1
> 
> before:
> Invalid read at addr 0xC08001216, size 1, region '(null)', reason: rejected
> Invalid read at addr 0x216, size 1, region '(null)', reason: rejected
> Invalid read at addr 0x4FDF6BFB0, size 4, region '(null)', reason: rejected
> Invalid write at addr 0xE10000014, size 4, region '(null)', reason: 
> rejected
> Invalid write at addr 0xE10000214, size 4, region '(null)', reason: 
> rejected
> Invalid write at addr 0xE30000014, size 4, region '(null)', reason: 
> rejected
> Invalid write at addr 0xE30000214, size 4, region '(null)', reason: 
> rejected
> 8.440| sam460_i2c_write: Error while writing, sts 34
> 8.463|
> 8.463|
> 8.463| ABox 1.30 (2.7.2018)...
> 
> after:
> Invalid read at addr 0xC08001216, size 1, region '(null)', reason: rejected
> Invalid read at addr 0x216, size 1, region '(null)', reason: rejected
> Invalid read at addr 0x4F0C01374, size 4, region '(null)', reason: rejected
> invalid/unsupported opcode: 00 - 00 - 00 - 00 (00000000) 00c01374
> Invalid read at addr 0x4F0000700, size 4, region '(null)', reason: rejected
> invalid/unsupported opcode: 00 - 00 - 00 - 00 (00000000) 00000700
> 
> Not sure what it's trying to do here, maybe decompressing some code and 
> then trying to execute it? Any idea what could be the problem or what to 
> check further?

Are you testing with commit cf9b5790db ("accel/tcg: Remove CF_LAST_IO")
included?

