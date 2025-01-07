Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5056E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCNh-0000Qg-FN; Tue, 07 Jan 2025 11:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVCNe-0000Ps-GF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:24:34 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVCNc-0002aQ-Sw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:24:34 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso164316695e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736267071; x=1736871871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5jERAaufHj4whkljT09G46/USkGPlSnCwTb3KtA7mFs=;
 b=UoX799nstMjOf46AgeqCdHdfOpm5bivYbleCdgOFFoUrk1irXEuJ7p0aUyG3FyhDr1
 MXWgY7R6ZVIGmVTBSs4shf/vs7u725MDTr2xmdaZFxRm1e5watI3IxxVESwn3LBlyvjI
 y/tMwz7pzNM6rnbK+76QY9iTK+I07D1ICFerrntq6d25S/jotxzVAVyr37m2AL6KCgi/
 BRxm7NnQ+hJFVBGc/vwZD/31lkzxU/P+9U5OKwOU4UexeivkfFScSbo+ofbtF7WikbAp
 p4YiOZDVkz1FoCymvkJijp1Jv9czO50b9wbeJ17QuDAPYrTIzG74k84zW5ulwDag2cuU
 8Xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736267071; x=1736871871;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5jERAaufHj4whkljT09G46/USkGPlSnCwTb3KtA7mFs=;
 b=MNdIupMzU1udSxnkCKPE43vg5CbQX/su+yt/xO7aQGHXwMHGMygd+L/x79uUqke3yM
 Xh8bgqALLdRaEHkYZe7pnYjeREFR1p8inhlXtGMbNkyYL4fwBJQyStVWf6kp8vubwMLD
 6CSOqcMI2fVtzWZ0aW61jFJ8o2KLO6IYxuG9po0Y4UoJ1ntSEMMyZ3sr7rT1R0Z+RauX
 nxthYFmtF0Lu/dJRpzMTuQODOsGpVdRtJe3UObgXPMt4q5wb011CBvtYLQa4PeRryhgD
 yn6TJva8jiW6fjlo574/2jN2mbjSQn/nKxoEzfJjFQQhr0d/g7Wpc5IgImc3cYx6o4CW
 JwwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrtDuRECTJeqW+pBjaZNlvYc6jODatMpDpEiMjvhWOOYvi+Skl4yNWnvPDen7ZfpK98tvpTljCpW7V@nongnu.org
X-Gm-Message-State: AOJu0YzWmPOTrNePhKHRjHB3jLSHFKGtzUz0WACX0w2/t9hXk8vT94Sd
 DFeHJsjrssgQt2alO9tUP79r3Anf37n6nnQWG3MivFikhVDQyxh78OXxQHrZYfM=
X-Gm-Gg: ASbGnctMfFomOcCsscw4a2v2rfchaq1YPt2mmuFqWNcM4V13/8KNFMKSeUZH3cJNIJL
 jK1ecKfM2S++mT9O3Bcc4TDKDLrKuZPyU2jF8vLg+aIl4BJ7J+WxkKerL2LFPJmOFxz6YbsI5Xv
 VQxvjXmzHSHw2l+bMf4p40aXjkUiNJNGAHRGdEw/S2V1kKtG5I7JPJ03EN6ykV2fu+YX0Jux3HO
 U8tchmJGEwmRZEDL4brpInRENhnujy2RE3F3fYwICJb2+meNxQLwb+YUM3tXPaWUR+YH/m3ribU
 zCt/8GTB47GknNwnqnxYEGSW
X-Google-Smtp-Source: AGHT+IHEqlWyKvzK44kwNGkqe6HiGn+vYEZ29/hCgmJoeH8pStBYqE+7RWWZAE/bCM7KQYPtbW1dQw==
X-Received: by 2002:a05:600c:1f8f:b0:436:30e4:459b with SMTP id
 5b1f17b1804b1-4368a8b6a2emr443640565e9.18.1736267071092; 
 Tue, 07 Jan 2025 08:24:31 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6cbbsm635514245e9.3.2025.01.07.08.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 08:24:30 -0800 (PST)
Message-ID: <7cc2a444-c699-4e56-80ff-8f9d6890b71a@linaro.org>
Date: Tue, 7 Jan 2025 17:24:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 25/41] rust: qom: put class_init together from multiple
 ClassInitImpl<>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
 <20241219083228.363430-26-pbonzini@redhat.com>
 <daea6757-a67b-45d5-bf2a-807fd9569a70@linaro.org>
 <CABgObfYMP5-9uN9cLofPT6DzBS_o1CVfbHbY8pwn9xjdOXOqgw@mail.gmail.com>
 <CAFEAcA-PE1paXOJNUo-cihu__htZQUYogZphVhRAjFNFzgi7JA@mail.gmail.com>
 <CABgObfZ7FFW5yhA2u6Rt5=MndrLsF=BnNhgE73LAyUWUGF=yXQ@mail.gmail.com>
 <Z31OiMcYT/66AGDt@intel.com>
 <CABgObfZETbD03-H6=qOt6V8GY4ex3WP82i5axzdf_U0GCwsMbw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfZETbD03-H6=qOt6V8GY4ex3WP82i5axzdf_U0GCwsMbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 7/1/25 17:03, Paolo Bonzini wrote:
> On Tue, Jan 7, 2025 at 4:37 PM Zhao Liu <zhao1.liu@intel.com> wrote:
>>> If anybody wants to do it as an exercise, I am happy to help, otherwise I
>>> can prepare a patch too.
>>
>> If possible and if no one else wants to practice, I would also like to
>> give it a try (I'll add it to my list).
> 
> Hmm, thinking more about it, it does require a bit that is slightly
> more complicated than I anticipated, which is a binding to
> object_class_dynamic_cast(). I placed something completely untested
> (except it compiles...) in rust-next. It uses a new trait
> InterfaceType that can be used as
> 
>      ResettableClass::interface_init::<T, DeviceState>(dc);
> 
> but I don't really like the two parameters and also I don't like that
> class_init is called differently for classes and interfaces. It's
> probably possible to design a better API, but I didn't spend too much
> time on it because it may require rethinking how classes are declared
> (not a huge deal, as we have only four of them).

Are you saying this is not a problem related to QDev Reset, but
a limitation with any QOM interface, and we can not instantiate
any type implementing TYPE_INTERFACE? As in:

   .interfaces = (InterfaceInfo[]) {
     ...
   },

> Feel free to give it a try, but it seems like a relatively low
> priority item compared to upstreaming timers (i.e. HPET) and
> MemoryRegionOps; or figuring out logging.
> 
> Paolo
> 


