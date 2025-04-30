Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5339C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAClE-0003Sh-1d; Wed, 30 Apr 2025 15:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAClD-0003QW-0w
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 15:06:23 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAClB-0002Jd-8q
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 15:06:22 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b0da25f5216so151239a12.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746039979; x=1746644779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OlVE7gl+CUw4uBk5E7cv6Cwlsk+3Ly8aETY/UIpTw9M=;
 b=hXH0daD7sF0jdKbLe+19IYJ2L5+wjKc7yKpw/uM8FoorTbgAsamqCinG481pyMVzMo
 EQMMQYi3ozl+lkSxY3lqvq4Rsshl85XB8I+04navWRlAqE8bi/TelCpIKBZNTjEXOez/
 CgHe8+GvOtGB0ccHxmSRK/W2AjGKpiZvoVXeQk6Su+LAn9a/nEtQa9bH9I8RyWk1yrq5
 3+5qrIY3xqFtwsrUXnsbiRP9DGjHWTbltBPyzNihFcV2Rm+sZW/mYCD78qvUfCFrz1RL
 Z85bjexYscaNmK2+FVZ26VG5Pwdb3lbWT7ltK3btOo0sq4JSWNuEzokzlAm3C0PJ/IHW
 dKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746039979; x=1746644779;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OlVE7gl+CUw4uBk5E7cv6Cwlsk+3Ly8aETY/UIpTw9M=;
 b=R/21jQChksJSh9+44ChV5gmU48qdJ1kNnXC8eMd8gOnhYYvdGY+POnLifFXOh0dhmn
 pmQihbL0BDHxIIgR0UyS1dTvup/3pyJdAs7vUr+cS/qSPmRawzRAQV+maGA27z+XER+G
 uEZfSx+Tjmqz5GcIv2yiYea/SsfJUGifFISvUr3VS69jkz++WTEVd4ENcS2FT3t34Hjg
 13nsfu5bP5+vKMTEFgAcWAnXhCo3mXKPIsoIzmxfXu8CdCE8CXqESxTmtb/Cq3nY1eXW
 nPP6GQ2+KeVWLtB/BFwxCl1io0iC9z8BQUUBPYhWLRDJ0is0VbDNRg/FwDtBluZFVNPt
 yfig==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1YbQboBHH35eFOqfBDi3tHXOFwGxiaV/TZ9p/CXi5JVV43IDjTU/KEak3EjHI87H/0yvizW1oi8Op@nongnu.org
X-Gm-Message-State: AOJu0Yw+jFK3BQrIBQ8oa/hzST2Ij/bW3v0fRe+R/lPRckWSQv9H60Bt
 kKUhH+c++eBEXJjwBC4BHS4MYahwhQyjYl4TA2H/HIlY0Oh3S61hgKBBUmDXXVY=
X-Gm-Gg: ASbGncsNWfjTZAaXYaIbb4/io2HyKFuSXESsrxWM2AaXKDVGVsM82GFgMXoDVT/6dzB
 UYDo4GKVHvPDcbU0xtn1uQa/aLmsw1btU4s//H8wiOJQk06O/LHfXYIkFm2gaUcHRVoOWxL2Hlk
 UvUPMAXpaaSwQr16VxCvncHqg9LgqqrE77NbE+lvUAwyPHYXUpyDH/3vqoBeo4oMPlcgca2DkwC
 vQH852roT67n5uqCwLbpEvqWW2Lxwfsyppp4wmU2weK8dfAwctgOu9kEsDPsazN6JEyLSrb1Y4K
 AFcucJ0Io1EpWjn90eAnN3LJUB1BAZUxoXyIR4i3WuBvyNfxCKJ6eA==
X-Google-Smtp-Source: AGHT+IGj5B6+DB2NaW+I5mAxRhlLboxIrcBkEvFW6E9iaGZb6qpzUxdVqI+SAgAnfIBrFAywlTIIXQ==
X-Received: by 2002:a05:6a21:1511:b0:203:becd:f9ce with SMTP id
 adf61e73a8af0-20ba8e4bbe9mr461533637.39.1746039979042; 
 Wed, 30 Apr 2025 12:06:19 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f7ec3116sm11157941a12.31.2025.04.30.12.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 12:06:18 -0700 (PDT)
Message-ID: <23d84ae9-5409-4022-a65b-0b0ffa5ff51a@linaro.org>
Date: Wed, 30 Apr 2025 12:06:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] target/arm/cpu: compile file twice (user,
 system) only
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, anjo@rev.ng
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
 <20250430145838.1790471-12-pierrick.bouvier@linaro.org>
 <e77b5c7d-5f6b-46e8-ad68-207ae87a07dc@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <e77b5c7d-5f6b-46e8-ad68-207ae87a07dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

On 4/30/25 11:50 AM, Richard Henderson wrote:
> On 4/30/25 07:58, Pierrick Bouvier wrote:
>> +arm_common_system_ss.add(files('cpu.c'), capstone)
> 
> I wonder if we should inherit these dependencies from common_ss or system_ss?
>

I ran into the same issue when working on hw/arm [1], and didn't really 
look for a way to do this from main meson.build.
I thought that it's a good thing to document those kind of dependencies 
next to the sources who depend on them, so I didn't dig too much.
That said, I'm not opposed to it if you feel your approach is better.

[1] hw/arm/meson.build
-arm_ss.add(files('boot.c'))
+arm_common_ss.add(fdt, files('boot.c'))
-arm_ss.add(when: 'CONFIG_MUSICPAL', if_true: files('musicpal.c'))
+arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [pixman, 
files('musicpal.c')])

> 
> r~


