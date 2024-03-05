Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D69BC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQoY-0001Dt-Ir; Tue, 05 Mar 2024 04:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhQoI-0001D2-6e
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:10:07 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhQoD-0005GO-Dc
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:10:04 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412e96284b9so3466065e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 01:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709629798; x=1710234598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BB51VKcUiMsU7y3cpoie2sxDHVOI5ccUc9f+HgZn//0=;
 b=TfwV5QKnjqQ0Jwp4Jbyf6iO0PxTHoPh1xvlM0FgTTWGaeMYHXddfempLmRK0MTzQWg
 eweqHOGZpQU5LJUCy3K8mK/RUAFXYObBlAhVWyA5ktnmM12/ntdBIYH/kgrhhO01ZUXE
 UV1fF22aryF1xnMOw2Hc2rwY2P5KdMr07hSA3C9xBA4/h9ApjSGqGG0zwKcim2PtgF3i
 pGOTaMnoEdCCJtgO0eBRnS1bv35QUNRlbNC+Xf3IfdFv+C0yl2/qCVwUHrmuTF47j1nk
 NgEHupbi9BjUa7shPSuiA008DoylqXFxfQKkPrZYQT9bnNViasXbSj0Xtbaz6ftnKF0w
 4U+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709629798; x=1710234598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BB51VKcUiMsU7y3cpoie2sxDHVOI5ccUc9f+HgZn//0=;
 b=Crj00H1fcrfdyjUl4sfGQ7W0Kd8UbOkfARKKdPRqL4JnRF4swSizbtxsPq8F87svjT
 lQCfdL38FwWCCKincqa2BTiXzukxOO1mYVV2wJsJyYOGHkIlmP9gja/uW+rzPF6mTRsk
 MIs1okL3IDASWNBMF4fBZfKjlFbkievTroa51+mw62GxL+OUTtcAEdpy+2AAfD2Kh7dc
 0V48hBDXGH0HjRgNcu03C4ltO8929Tm1+tGNhgba4Z/Q9vyPRICpauxlgqT6MEkyXsT9
 cepaftgl2LeOyuNsehe0ycQnoMNly5Vq1i4JwdHiZ2Ai3rWIZ71aDNnmf9krUrCgY5XP
 0cDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtjqxMhKVcbp6hMvmRGavjSSh1RuHLnm6xO6nXDqi3YhvW5yxoDQGrm7fLZ5hHQBKwwi0toT7WyN/6vm0QiuAHPH7uMGc=
X-Gm-Message-State: AOJu0YznAL7+r6jTzvmFGTOMzPbSKIoEowzFZC3FI/gzq0CeIJeEM/R0
 8S2onLFVI8koTdCpV9ZeRsA/LVLyNlstoz+2C6WfAtAfsP44g2IuoWgrbgYURso=
X-Google-Smtp-Source: AGHT+IGBWHW1L/BzyCOmU0FPFgdoMAO3NlPkgucjpGAO1qm6FIArgYh/2Da0qDnXNVHIa2XAUPqToA==
X-Received: by 2002:a05:600c:4e11:b0:412:ee24:5711 with SMTP id
 b17-20020a05600c4e1100b00412ee245711mr513874wmq.16.1709629798316; 
 Tue, 05 Mar 2024 01:09:58 -0800 (PST)
Received: from [192.168.69.100] ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 bd9-20020a05600c1f0900b00412eeec84ffsm555411wmb.36.2024.03.05.01.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 01:09:57 -0800 (PST)
Message-ID: <1b553538-e7f9-4cf0-808d-94648b01b6c3@linaro.org>
Date: Tue, 5 Mar 2024 10:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/apic: fix memory leak
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: minhquangbui99@gmail.com
References: <20240304224133.267640-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240304224133.267640-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 4/3/24 23:41, Paolo Bonzini wrote:
> deliver_bitmask is allocated on the heap in apic_deliver(), but there
> are many paths in the function that return before the corresponding
> g_free() is reached.  Fix this by switching to g_autofree and, while at
> it, also switch to g_new.  Do the same in apic_deliver_irq() as well
> for consistency.
> 
> Fixes: b5ee0468e9d ("apic: add support for x2APIC mode", 2024-02-14)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/intc/apic.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


