Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0942ECD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 09:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruqr0-00032Y-5s; Thu, 11 Apr 2024 05:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruqqy-00031R-Q8
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:36:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruqqw-0001SX-9i
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 05:36:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-417d092f39aso3393435e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 02:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712828176; x=1713432976; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UE6t2jCVit83Kyhn5LvJR7ZKVRuHMJ6vHRvosUhAV+A=;
 b=rc44rY/nygEJH94IAw6L+LeJsxenss7LasN4PSWYSrEh8+s1jxAknWXg6BIEWzerL0
 F2PWoKsEzQIgqJv41Im+Ud0Amk+oBUsGaOpxBPKoaMb+AqkkQuCfE7YzKw354yp7fM0c
 TkmGln6ZfqgLDosguCASu/Vlu7vVYMZH0hPpMGZ8Qgao3ul44ITH231x11ItAuXsyEWg
 oeasRASjcPhhZHPOKctrvLYkKeYtWEo0JVZkVt13Lwkxv54kcUm6V7ax9M2hHr3Ngnvc
 rcBIsVEMpZshqXPY1udhpihj4G4ad6lwk4Ai+syiyEhi0yRCIqoOSMT2wfnRaE6nRQwd
 BhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712828176; x=1713432976;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UE6t2jCVit83Kyhn5LvJR7ZKVRuHMJ6vHRvosUhAV+A=;
 b=DoImLHEui7lPOfLkGmtJm2TQKFFz/ESmvUTgOLLToyaRiNS2rOUYhTnThwV2JZvyT9
 7NmDSnuU7S2GKXxFXOb/hAUewKK282oAVw3Iisn8dmHDlwfrsCA8lwVw1IyYWzQEgAFb
 d3jezKvLYLRAC0Hly9h9olnac7hDVj9Xign8UVD7BSzEiO0os8YQ7qCDxfSQ0Cka70B4
 ddOVCCqHbWGJdMKZ+OanfqdFybXEMsHzz+SOxJD1p9LIwdPjbgOrlc2WXR/b46Ua+yso
 hlxKETyyyVum0ug4svcTxG7UcoTrSe1F3cx9K8Wx2nNO6S1/u3L0qEbzD319FVLye8Z0
 Wzkw==
X-Gm-Message-State: AOJu0YwkMPd+B/tw469C4lG6sE8v6B6VDSiW/whrwCMbl60SN6e9eb/a
 pSJ1lfwM8Yq6KXZhMqIWJHyPR/SZ/EnjK/VQ6PjKn2hN4Pls5ckxP2njMyc6KQU=
X-Google-Smtp-Source: AGHT+IFL8LBcYu5fKeXxrsC7NMDsKoJ2s5smujMsz/JAezVwztpKS9ivijH2ngLfr543QdamSOFrEw==
X-Received: by 2002:a05:600c:4f93:b0:416:389d:a4b6 with SMTP id
 n19-20020a05600c4f9300b00416389da4b6mr2107258wmq.12.1712828176496; 
 Thu, 11 Apr 2024 02:36:16 -0700 (PDT)
Received: from [192.168.202.175] (137.red-88-29-174.dynamicip.rima-tde.net.
 [88.29.174.137]) by smtp.gmail.com with ESMTPSA id
 u14-20020a05600c19ce00b0041772ec5d18sm4237322wmq.0.2024.04.11.02.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 02:36:16 -0700 (PDT)
Message-ID: <4c683f51-fe0f-4ef9-b424-aee8a859df0e@linaro.org>
Date: Thu, 11 Apr 2024 11:36:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] ui/console-vc: Replace sprintf() by
 g_strdup_printf()
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20240410160614.90627-1-philmd@linaro.org>
 <20240410160614.90627-2-philmd@linaro.org>
 <dx3zdfuwz7gam7brijaqfd4kg4uttybr2s2pjonhl4twyivhf3@afcjz4iulzcn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <dx3zdfuwz7gam7brijaqfd4kg4uttybr2s2pjonhl4twyivhf3@afcjz4iulzcn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/4/24 09:47, Gerd Hoffmann wrote:
>    Hi,
> 
>>      Due to security concerns inherent in the design of sprintf(3),
>>      it is highly recommended that you use snprintf(3) instead.
> 
>> -    char response[40];
>> +    g_autofree char *response = NULL;
> 
>> -                    sprintf(response, "\033[%d;%dR",
>> +                    response = g_strdup_printf("\033[%d;%dR",
> 
> Any specific reason why you don't go with the recommendation above?
> 
> While using g_strdup_printf() isn't wrong it allocates memory which
> is not needed here because you can continue to use the stack buffer
> this way:
> 
> 	snprintf(response, sizeof(response), ...);

I thought GLib/GString was recommended for formatting, so choose
this thinking mostly about style. Indeed in this case snprintf()
is sufficient. I'll respin, thanks.

> 
> take care,
>    Gerd
> 


