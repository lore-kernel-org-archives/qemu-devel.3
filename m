Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1CFC54798
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 00:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgZIV-0000Cl-Ot; Sat, 02 Mar 2024 19:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgZIT-0000CK-Ls
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 19:01:41 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgZIR-0004sx-Ox
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 19:01:40 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso2959230a12.3
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 16:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709424098; x=1710028898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0wGiIwp7kOH4zJz+LAx1j5QiqEMpC2frev7DNuS9boo=;
 b=tTOtINeLhBF5j5Hri1YfCPzTWA3rg5OfKRSSJlMPF21o4y6YIpOmuKGZ/Hc+W/0zNG
 nUaGpDXni6qC6FGMZv/0jXZJDkRcexAjdSRtPi+4QCy2qGCSh+DODzBqQsiMdyh6ms9z
 TSibHLMb4d7REiog33Vw1fuAMT8glwjDczlnDmTB6NCbe+5kexJd+eEVWXSyNzLuYv7R
 cjWD02AiLpGnN4RVcRgJmMl0HqU4P9EeyFRkSIlbXOejlV6sD/FuFy2ikEqgaYqMyVE8
 qwvBuxJl41mi2KYdUWxVoLhhsYUAQktCazrhmRX4E7wXVL/jsDoi7SzaQP76DD7p7Qtv
 1XSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709424098; x=1710028898;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0wGiIwp7kOH4zJz+LAx1j5QiqEMpC2frev7DNuS9boo=;
 b=QONtin2ABwZWW34VzZKLaK8GXYitpgpLBaOIQsr+Qk30LJZHU9TY+rZSDZGq2D39pe
 mkgdP8ku7AVpJ7j1CUg9CUgAdPR/D9Q9EY3K6DeljUcpDPASyo1apZjGR3l1C71Z0/Kg
 ZWqANOdGwizYxPbQmlnE3Q06Xt+IixDu8wBoAo0xwgsgcHpdEGK+8ONQJk0otPCqzERQ
 RyEEMDHgmdCWozw8fmMN8fI8yiFvxkf5/Z9l0g76sNqVqyksxw+guWOd6jh7lwMhR7xW
 rKkWQoPtS8WHYI32Y8XxwicqIfF+CHdCuNCEwTaY/G6yT9vJh0N8aOXpMryRxySgDjj2
 bPlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9fjkrNxLP7lIikcYdaJtYJsL2iFx5hBGf+PPT8sIV6qPHisVJ/1AY2+JMBd0QUfSC8f2OJ1IhJhvo25lSknvskSkmKDw=
X-Gm-Message-State: AOJu0Yz2BVDzfY+Zg1pDZTToCGy6WqvPN8klYVvBm2A7Lvv4QAhW21G2
 /Yg1KHLLawV3RzTmyZz0RycCHmFyRHIYdhDwNB+brLHkh39PcmlYWfLZr5TN7nI=
X-Google-Smtp-Source: AGHT+IEoCu7Ed82IPureFdXn9C0Jf1RIIHjIMEdWZjjWf7OTzHaJnIheJ7ohCLc2BiDEgMOPFgmKmA==
X-Received: by 2002:a05:6a20:d908:b0:19e:bca3:213f with SMTP id
 jd8-20020a056a20d90800b0019ebca3213fmr6220798pzb.52.1709424097777; 
 Sat, 02 Mar 2024 16:01:37 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 132-20020a63008a000000b005dc9439c56bsm4831887pga.13.2024.03.02.16.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Mar 2024 16:01:37 -0800 (PST)
Message-ID: <3590961a-92f9-4a52-bdf4-ad0a7ce95c1f@linaro.org>
Date: Sat, 2 Mar 2024 14:01:32 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] hppa: assemble_16() in wide mode
To: Sven Schnelle <svens@stackframe.org>
Cc: deller@gmx.de, qemu-devel@nongnu.org
References: <20240302172727.2035011-1-svens@stackframe.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240302172727.2035011-1-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 3/2/24 07:21, Sven Schnelle wrote:
> Hi Richard,
> 
> while looking into a HPPA tcg issue i noticed that the current
> tcg code doesn't do the special wide mode handling described in the
> Parisc 2.0 specification, Chapter E -> assemble_16(). In wide mode,
> assemble_16() adds two more bits to the immediate value/displacement
> of certain instruction like ldo(ldi), st[bhwd] and ld[bhwd] and some
> others.
> 
> I wonder what the easiest way to implement this is - it has to be xor'd
> and is dependend on the W bit, so i don't think it will be possible to
> implement this with changing only insn.decode. I came up with the
> attached patch, do you think there's a better way?

Yes, it is possible to do this with decodetree.
I'll whip something up.


r~


