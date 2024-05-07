Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0BEC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4KJm-00064H-1G; Tue, 07 May 2024 08:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4KJJ-0005dH-4p
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:52:45 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4KJG-0002I8-Uo
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:52:44 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51f4d2676d1so3444088e87.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715086361; x=1715691161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yKM634OjyYIi8yArIR9t/13TNpeWE1UO4NyOtqU9kcw=;
 b=EToy1UD6YH1xyse7V3R6YWsLEGhAy2DokRAtJ+ikLbaChhHrtpXbUltKPWabeV5s+T
 2DIaootgAToQgTk6lCLwSHqowysEPc0JF54emCqtKDUGUg8o0DjKelwSUsTdMrCi77pp
 +DXXH1f7bLMlcnyNPv93LBm9/CDSbdJ3naTRWzmnLf0QveHo3LAy3yX9cphNe3GT9DVJ
 xO1quGY2m8FCAPppjC3QcyUTKKs6tcZecLt9Qsm+Sb+H92OX6noS7e48O8XWYcONa24n
 nhFjSJfI9up0wU7+7X+JPsuWN6C9anOIVW9T0rqyfsuxtHkkJr4aiWP+aR1UX51xeCiW
 CGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715086361; x=1715691161;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yKM634OjyYIi8yArIR9t/13TNpeWE1UO4NyOtqU9kcw=;
 b=bqoIGgSvtMvvlO1LpCvJXLoEJ58MNTRsnAgVvtiQAat1Ci8+U6CG5ztZQe9/OW4or+
 Ys8pg+TPYNymzaLbFtnVmKjWprQ9iVsWi5fpBsmS7Az3xNcHUi9l97gznbDOOTej04RN
 PyS7HzHte8phORXKXBYSr1Xh0fK5azEdXvINfqLTM/gN3RGLQ8dVEojs8jJ8IBjuU7V6
 K7/t291vpz9D//QmKvnq2H30j6c21Zyssvm5JGfpZB4NPwMpp3LmbliWFort/G84kBG1
 Kr0Kr5Y9ukOCkRoE+0DxfNSrWzjUcoaZBFreUgWMqFbIikwxHMJAmK74COCBWyqLHeKq
 DBlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfkIuyVI+M6ixrf8aWVYRFTk99A6qnY/FzMGqG+uDYHBCB+6eqOmaf25uqqCcgc61uYkMIldXILbVkf+nx3AmxLGPp0uE=
X-Gm-Message-State: AOJu0YyciU3XWzhpJM4O291WrPPzdqVbfC2ocx1HkuhI9rhpq8srerML
 brSk6fuwzvQDe/RQY3t/4zbXuV4VhPzBPkBpePEG8c17uVpmNChLectUeBBebLM=
X-Google-Smtp-Source: AGHT+IEuDAAilDr/mHbQLshrXntLj9Wo4A8uHNySu0I5zYnfHq5bgfOLHQ6KyAhMnUQmhHcBrogvVg==
X-Received: by 2002:a05:6512:2090:b0:51f:d72:cd2d with SMTP id
 t16-20020a056512209000b0051f0d72cd2dmr7617330lfr.22.1715086360879; 
 Tue, 07 May 2024 05:52:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 m37-20020a05600c3b2500b0041816c3049csm19555853wms.11.2024.05.07.05.52.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 05:52:40 -0700 (PDT)
Message-ID: <cf640e4c-610e-4357-a9bb-57d2d4ab1254@linaro.org>
Date: Tue, 7 May 2024 14:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] Support message-based DMA in vfio-user server
To: Mattias Nissler <mnissler@rivosinc.com>, Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>,
 QEMU Developers <qemu-devel@nongnu.org>, john.levon@nutanix.com,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20240304100554.1143763-1-mnissler@rivosinc.com>
 <ZeWho6ZW41tg0rob@x1n>
 <CAGNS4TYd7qVjLb6VCUSQa9DrYivwJV5UDhdSnSde0t2UCMpXrg@mail.gmail.com>
 <ZjjsyF_ZMIPGqcci@x1n>
 <CAGNS4TaSxprHvoVCMRLw2YCGA2FXirO=Wp-TgzzxquwaL6y51Q@mail.gmail.com>
 <CAGNS4TYUPwQFWZ5Pc3eqTkLX2u0_mP5EFMJgGLUva3CGL=ZxLg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAGNS4TYUPwQFWZ5Pc3eqTkLX2u0_mP5EFMJgGLUva3CGL=ZxLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

On 7/5/24 11:43, Mattias Nissler wrote:
> 
> 
> On Mon, May 6, 2024 at 11:07 PM Mattias Nissler <mnissler@rivosinc.com 
> <mailto:mnissler@rivosinc.com>> wrote:
> 
> 
> 
>     On Mon, May 6, 2024 at 4:44 PM Peter Xu <peterx@redhat.com
>     <mailto:peterx@redhat.com>> wrote:
> 
>         On Thu, Mar 28, 2024 at 08:53:36AM +0100, Mattias Nissler wrote:
>          > Stefan, to the best of my knowledge this is fully reviewed
>         and ready
>          > to go in - can you kindly pick it up or advise in case there's
>          > something I missed? Thanks!
> 
>         Fails cross-compile on mipsel:
> 
>         https://gitlab.com/peterx/qemu/-/jobs/6787790601
>         <https://gitlab.com/peterx/qemu/-/jobs/6787790601>
> 
> 
>     Ah, bummer, thanks for reporting. 4GB of bounce buffer should be
>     plenty, so switching to 32 bit atomics seems a good idea at first
>     glance. I'll take a closer look tomorrow and send a respin with a fix.
> 
> 
> To close the loop on this: I have posted v9 with patch #2 adjusted to 
> use uint32_t for size accounting to fix this.

"size accounting" calls for portable size_t type. But if uint32_t
satisfies our needs, OK.

