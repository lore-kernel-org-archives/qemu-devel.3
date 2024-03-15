Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BEEC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 05:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl0WK-0006Nc-Od; Fri, 15 Mar 2024 01:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl0WI-0006MG-He
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 01:54:18 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl0WH-0005KC-0O
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 01:54:18 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a44e3176120so216022866b.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 22:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710482055; x=1711086855; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DZY6N/K0uFgJFFKnJh5Tmfk8JtnWgEPToC+Fk1CW4m8=;
 b=B8Vo2gmOTDyUfKf64Lqs8yhi9J75djG2xqIPW5kWI9rSw1vXybeu2DqRytmqK7XZhX
 BbtIu2p6MKLrg2u/4297V57pXapjpEtXnQylRvvTjN4z0f0A55bxULU4I7O5LD7LPK4y
 QipkZ8uprHBYNtR5CgYE8LXFdFeaDb7YMgxuBobwKHeOBpWcsqa9mrJsX6DUiwJ0G3/a
 KdMMtn9tvhWXC2a5VbLa4g6064IE3xu13cZBZJ+kIJ2i7l6Ss6tf/Pen8HOsOxcg/xVY
 5/cqBV90+mttbMeehVIcTsrB+IC5Z2LLdW1JTeCBda88ySHelfXMmlIEPlzyZ9O5U+gq
 hRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710482055; x=1711086855;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DZY6N/K0uFgJFFKnJh5Tmfk8JtnWgEPToC+Fk1CW4m8=;
 b=aLsHS2t+IOJqCdcAoqScysQap07HbO9BR4XfZYnVemUAWwpOsKaP2weSXBE05HdRnp
 YORFB6acGDy8pEOIUV963/izqf9SdK2vonqTFCmmdzrZDEgyzUIQq7Hj5aabaNI4CtMu
 bFlBZ0XKxa3wUNw+Adv88pJmt1XP/i3A1FnM6fMZXWtDhVU72F1+sjeKSJMqN6Ilb781
 e0WSCkXfYO5ntR9YYtG4oXz+7KIiE/jzSDYlOHW0DX/DtffgtJ8znEIaGEIv97GQpCvN
 WPSeVFJx9LCiDP5bNjz7nLH6ftRo3Igti+VbXNyzDEs29PwUoM7gWOVbCLGRKbZhCTM5
 8HiQ==
X-Gm-Message-State: AOJu0Yxbn2UmXGqV4h+243ma34MwGfwlYXeLZy/UAC2R99O5kj6+9eEm
 tZyNy4LLTNEXIWrD9L/oD9ZNs+EyY23JNgWGJ6T7JSB7WP1jEjvZX6qbBZlXaUs=
X-Google-Smtp-Source: AGHT+IEMwfh4SDrE6Rr6Sukr+LEZVlUwSpUHEMuc/5tx0wgI+vUj9tw3VbMJ0h+q37HBqqjYHRNtbQ==
X-Received: by 2002:a17:906:1319:b0:a45:a450:ae4 with SMTP id
 w25-20020a170906131900b00a45a4500ae4mr1011056ejb.13.1710482055227; 
 Thu, 14 Mar 2024 22:54:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.77])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a170906454b00b00a44f07e55d2sm1357554ejq.41.2024.03.14.22.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 22:54:14 -0700 (PDT)
Message-ID: <8a160678-4178-44df-a53d-837e7203df3f@linaro.org>
Date: Fri, 15 Mar 2024 06:54:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/s390: clarify even more that cpu-topology is KVM-only
Content-Language: en-US
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240314172218.16478-1-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240314172218.16478-1-cfontana@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 14/3/24 18:22, Claudio Fontana wrote:
> At least for now cpu-topology is implemented only for KVM.
> 
> We already say this, but this tries to be more explicit,
> and also show it in the examples.
> 
> This adds a new reference in the introduction that we can point to,
> whenever we need to reference accelerators and how to select them.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>   docs/system/introduction.rst       |  2 ++
>   docs/system/s390x/cpu-topology.rst | 14 ++++++++------
>   2 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


