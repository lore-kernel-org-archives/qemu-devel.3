Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738F2C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYs4-0005Pk-U2; Mon, 26 Feb 2024 06:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYs1-0005On-Nj
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:10:06 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYry-0007ah-Tc
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:10:05 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412a4094197so6665485e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708945798; x=1709550598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qTgeTVZVubBa3N2eaijKi1ll7rNPEQ4SIU28dGs6epI=;
 b=BNjEEDgTR0g0XLG0rhQ3XxO4x+T0cZrsvo2YKuh4AFyikIyub5lg8On494rsRGy7x2
 9MP5qrUuLclJadM+XhcRxEnKyRpPF6wyycLDHrZZXaeTd2Zpn4GdHPvGDJ94Pmv0fT2t
 CYpXdRO87WkDy/1+ZIoOIGHD/fRmCN4yoZEAzdSchyBH6stU0+UK5xnP3ADYBTZl5rje
 9WHnhvixDCz4UE8EfAdpfQ7JV+E2naxiQi8MxiWx0VlezvBVP6XBVtU1+IjlolZ3JVPb
 AVGMKgiN0jHEWRCRsaF8iVcQd6i5ItyEMkOENq1hzfxEA3fuIYCmWRZa91Bfkpoz55w9
 2l4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708945798; x=1709550598;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qTgeTVZVubBa3N2eaijKi1ll7rNPEQ4SIU28dGs6epI=;
 b=Hi4m6Rtw78d/EMaDTKtj+ytxsPfBCVhqVIddmQAdUl9NRBogYHb5PDqxQ/QDYmsawo
 kYqJb+a22YCYV00td214G0JTbqiLUpxEIbFfF9izn+u+EzHbiIZ66sseKEY97yFMcy/M
 7iSPRHl/r8c6hDyd9VB3MWwOnRDCAkhgicKKTEJcPzyv/xZX6V8bp1DavrbLdZ/NVskI
 6sQPly3i//M7VQmdWUWhIxJW+P/Nsdl6hjkNrZETUS7/+loSlcNXlvzqua1aqfe77Yw5
 lSXyiTVQVVcWnt1AQPWc5dqXRUEmLARbocZHzizcZvC7eIZ/fJNTDaCRNc3BYo7FcZ8o
 hs4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXytR+KDHzIMVwzmVxjWyrkijka2/kbNM0sKvhYs+W+oxvf+mTDSi939voeD1iTgbwS4b6Kuh3BgFaIDRelXv8PFbMRiPo=
X-Gm-Message-State: AOJu0YxtjE0WxNsek0o35PQyTB/mJ086dUdILMrIYbOGg7ItZMYNFTHj
 afMlluHiMME2+s2J4TUmybXZ8/026sOaPPzxX4qkqQ9zipeStqblyodiRVzTGb8=
X-Google-Smtp-Source: AGHT+IHnY5JJsbVFQHMuIet5Bc35SX82PqBIscKUyFWoNhbrBGshgTDU8qp3tCMiQOEJHKF+aWS5yw==
X-Received: by 2002:adf:f80d:0:b0:33d:71c:273b with SMTP id
 s13-20020adff80d000000b0033d071c273bmr1937036wrp.36.1708945798481; 
 Mon, 26 Feb 2024 03:09:58 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 m1-20020adfa3c1000000b0033d67791dc0sm7958845wrb.43.2024.02.26.03.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 03:09:57 -0800 (PST)
Message-ID: <4f8f7404-977d-4ff2-8987-a704bb260244@linaro.org>
Date: Mon, 26 Feb 2024 12:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Emulating multi core processor (ARM cortex M7) on QEMU
Content-Language: en-US
To: ankita suman <ankita.suman7@gmail.com>, qemu-discuss@nongnu.org
References: <CAJSdhPiUcGuHmtZbgaN3Op5qqyDGacN1s9DeGJkmQrx6HL19VQ@mail.gmail.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJSdhPiUcGuHmtZbgaN3Op5qqyDGacN1s9DeGJkmQrx6HL19VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hello,

On 26/2/24 11:58, ankita suman wrote:
> Hello,
> 
> I am trying to emulate multi core processor (dual core for now) on QEMU. 
> The processor I am targeting is cortex m7. I tried by running multiple 
> instances of QEMU to emulate multi cores, and use shared memory for 
> communication, but since I am working on a bare metal environment, I 
> don't have the options of libraries for synchronization.

Have a look at the 'fby35' machine in hw/arm/fby35.c, it uses
a pair of Aspeed ast1030 and ast2600 ARM cores.

> Another approach I tried was using inter VM shared memory(ivshmem). But 
> I am facing the same problem. I am able to write and read from the 
> ivshmem device from two different QEMU instances, but it is not working 
> for ARM.

Cc'ing Gustavo who worked on something similar and posted ivshmem
patches:
https://lore.kernel.org/qemu-devel/20240222222218.2261956-1-gustavo.romero@linaro.org/

> can someone please guide me on how to proceed and what is the best 
> approach? If there are library support in QEMU for multi core emulation, 
> kindly let me know, that would be helpful as well.

Regards,

Phil.


