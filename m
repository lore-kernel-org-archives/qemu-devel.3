Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644E3C54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 22:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhHAB-0000LO-L7; Mon, 04 Mar 2024 17:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhHAA-0000LF-RM
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 17:52:02 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhHA8-0001xg-SU
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 17:52:02 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dca160163dso48885335ad.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 14:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709592719; x=1710197519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c37fbNcNwdR9mtT8FsddqKhSMxITPLNe3JTZM+Tjzv8=;
 b=yT/QXQYAYQhYInslP3zNBiXhRWFpeZ/g3LnRhN6M+h67XGMY8vNJE2bnCI3HIxyCsm
 +BEzgCUqXD4OdPw74zkEkLQ9jp5HJjKGF63tf5lhHBgC+o8q/YmwGdybVLtbWlPICiT3
 gDDXdulL8G8NfqnmgkCCnHBzcPltd3hNr5UTYgzNYnJgK6opdnpz58E/CVzsXFzh+yQD
 5TSwle2L7hHP7Vqfy/59UQtDtdjGi2LMP+NOi2LpX+b5ygRjOq3aIXO/M/RN2F6OlZKv
 lHe/4bEshT+ncT0kq+KPoZysxx0mujU1qW7dyCRhExVkjhkF/WCwsKPe3pwOrCVdZEZR
 FjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709592719; x=1710197519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c37fbNcNwdR9mtT8FsddqKhSMxITPLNe3JTZM+Tjzv8=;
 b=gMI5Ua/GgHU0vVGOMdpKlC3enN9YQsRBx0kAZFnYwD05MXwKG6tIybXPkSzLMG1gXS
 ETNbPAQRXmVpLfxv5A4hgcqyXLkpdhDOEIkw+5dWhwDe/oDPS+YLRyIfjDJBAOKI+uku
 QUfqDght+GT8aIJAlYxWGucsUFKQcrE4FoVrb14KolhDYa0yNQhR0s0og/odbWDHQME/
 c6gEHyZwtVBWR5f5DkQF18lQR3VuHShYHyxSwSIVS+uDglQQQ8oZ3UXn90U6dQ5SMRXW
 JqG4RlHATH+oxL88d6YeYT9kytqiwi0CBWcpcOyi3k+4VQBU68ZafdL4rDboJh1/CuQf
 STvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa9bXZfkcgmYqNx9opSXt9CwvihyObANIBEhZcHp0nZUng509YrxsFSDi0BsQqSTUOta58qWeVw5yUVDpgVhk7TgHoMBc=
X-Gm-Message-State: AOJu0YwCTL35WTvB4UqiT+79M5k/OvrZicQ/Er/ZqxddGcMesNzPfjDq
 Z+1b9CwHQtespPt6TxuVety+4ckUccmK25dMev3kFEHd+ciFKRxvjNBq9BC6c4U=
X-Google-Smtp-Source: AGHT+IFF39yIxZEuIF19P+/N2OqeyObWqwmRC3O70zyyRvx/YLI4jkfn2ZVJgBw58xrTWXkOEJK+wg==
X-Received: by 2002:a17:902:a9c1:b0:1db:be98:e9a with SMTP id
 b1-20020a170902a9c100b001dbbe980e9amr198921plr.26.1709592719008; 
 Mon, 04 Mar 2024 14:51:59 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 k15-20020a170902ba8f00b001dc91b4081dsm9033935pls.271.2024.03.04.14.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 14:51:58 -0800 (PST)
Message-ID: <cd6b5e0f-5a10-4acb-94d6-51073ceb5acf@linaro.org>
Date: Mon, 4 Mar 2024 12:51:55 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg: Add multiarch test for Xfer:siginfo:read
 stub
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240303192610.498490-1-gustavo.romero@linaro.org>
 <20240303192610.498490-2-gustavo.romero@linaro.org>
 <e33ab9ae-e2d4-41ba-b053-e7e918572808@linaro.org>
 <d98ef081-b25d-4dbf-7b67-fe27e09ff2f0@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d98ef081-b25d-4dbf-7b67-fe27e09ff2f0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/4/24 10:59, Gustavo Romero wrote:
>> Perhaps just abort for SIGABRT instead?
> 
> Although this can make a simpler test, the test can't control
> the si_addr value easily, which I think is interesting to be tested.
> 
> Why do you prefer SIGABRT?

I missed that you were testing si_addr -- in which case SIGSEGV is a good match.


>> A test using setitimer to raise SIGALRM would test the async path.
> 
> SIGLARM doesn't generate any interesting siginfo?

It should at minimum have si_sig = SIGALRM.

> 
> gromero@arm64:~$ gdb -q ./sigalrm
> Reading symbols from ./sigalrm...
> (gdb) run
> Starting program: /home/gromero/sigalrm
> 
> Program terminated with signal SIGALRM, Alarm clock.
> The program no longer exists.
> (gdb) p $_siginfo
> $1 = void

Well that's because the program died.
Do you need to have gdb handle the signal?


r~

