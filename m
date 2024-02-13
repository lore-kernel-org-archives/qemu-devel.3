Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A67C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZuqJ-0002v4-FV; Tue, 13 Feb 2024 10:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZuqC-0002tt-Ia
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:37:00 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZuq8-0002tS-MM
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:36:59 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a3d2587116aso27904666b.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707838614; x=1708443414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nUWmpwH/S6RGkePwrN5rWR3F0YowSCEcNgLh4WXbEww=;
 b=DVPwi21KvIqDQNCYlCc0TPAqYVn1AMr1yZmL9Q+/Dy+2nmzBzy7mjXA6ItvdwkkKk0
 BWaRBGSYgdOhhwG5jNrwQWOK+XPe6f4nsBdYJ3emqYw1E3pBeC1g5IvW/Cg/focqc0Gp
 xkFydlfnM6BHsL1iNJ1ya3QWuXu0VQH2yCc5a3AZUf2q1SzUE2ljosAk6zpgL3hX2c4q
 xcCXQgyaBKd4/Qnev5RKQitWIn5DyGpOo8OASQd2qo4FuKeF/IB5G/oF9kB39Qa70xLF
 77ji5PKEfAGWXZKg8CUzRAIo8Z27KdAIOPYN0XURS1I88MdEdsNaQAAgzSbX2cMJszD2
 FxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707838614; x=1708443414;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nUWmpwH/S6RGkePwrN5rWR3F0YowSCEcNgLh4WXbEww=;
 b=qvIfesOzFpJZwmxxzkLfCdwTVVT7pwgCkj4OwIiQiK/B4C4L7BPPE50z35Tb22kvmW
 MJnCzgQf0ufBNjiMjni/7d9EMwunuYLcUiS7ftYUy3YiZ8b8rksLaauJ6itp19IyBovV
 Ua5nnPTAiq4/vfCHhAuM376a0ePBD6x9pJLrHyzgnnxKRWt/28rg1O81v6iy3T/OLhm+
 sEpEq8cvPXR3t6B72qzxjqF3yr3Er3LprjSqCknWCwXZUVEEeTh/0AbqyMS5MG8OCA0P
 IukMxOrr1xEKqwbN8j+2nTD6rgUd/2u6Z/mbFvq8hkFrh4mvTxswJ1sV0j7x9y5WOiBg
 ph1A==
X-Gm-Message-State: AOJu0Yx1y2dA4wKlOgjWcqTvjEwTePgO0ewHFoWwGlGJ+5veDjrmMtUA
 +l3jWJSze4GNOimsoGMB5jwbuRYKgyJcXcLTZiCVq+gxS4ctr5dvsNNu0cGlXEs=
X-Google-Smtp-Source: AGHT+IFOyVhTmbljh/+aY/ndcr2glqGdQLMGDhspVbD8KEoUCyCmXYrwi2YNgb4Gl0HBXmZo5n/leQ==
X-Received: by 2002:a17:906:e093:b0:a3d:6f4:b5f7 with SMTP id
 gh19-20020a170906e09300b00a3d06f4b5f7mr1291214ejb.49.1707838613805; 
 Tue, 13 Feb 2024 07:36:53 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWquRUW6WuT4zpjpLyOmsoZ2VANDZqDgjEhkDl7fMH7XUGDYx7Au4jk0xEVEJreMBsspeaJ6CJhCw+lTEByjXfy3Nj9XOw0eo2kDgWBC9GlEdjeJ7VIHITD0iJdIrvv48Afg7S8E0SyD+9To8q1jeX1xnUX/Gx0bOlKegFeXD1C+TTwfhOKtw9rTUclChPdnT2ENkaPJ1IFVYO79ElgNXo=
Received: from [192.168.69.100] ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 un6-20020a170907cb8600b00a3cfb02c12bsm824995ejc.79.2024.02.13.07.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 07:36:53 -0800 (PST)
Message-ID: <7e7646e7-85d1-40a4-8e5e-bca2fcaa6ba5@linaro.org>
Date: Tue, 13 Feb 2024 16:36:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/arm/stellaris: Add missing QOM 'SoC' parent
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240130190317.25692-1-philmd@linaro.org>
 <20240130190317.25692-5-philmd@linaro.org>
 <CAFEAcA9V7wQr=LEvv2DYT5SabPe2H3+V2RMQPHRVZ8avrse9ww@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9V7wQr=LEvv2DYT5SabPe2H3+V2RMQPHRVZ8avrse9ww@mail.gmail.com>
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

On 1/2/24 17:46, Peter Maydell wrote:
> On Tue, 30 Jan 2024 at 19:03, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> QDev objects created with qdev_new() need to manually add
>> their parent relationship with object_property_add_child().
>>
>> Since we don't model the SoC, just use a QOM container.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
> 
> Ah, this is where the other qdev_new() calls are sorted.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> I wonder if we should add a variant on qdev_new() that
> you can pass in the parent object to?

Yes, this is what we discussed with Markus. In order to
stop using the "/unattached" container from pre-QOM,
qdev_new() must take a QOM parent. I tried to do it but hit
some problem with some odd use in PPC or S390 (discussed
with Cédric so likely PPC, I need to go back to it).

