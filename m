Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BB2C25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 17:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s41yM-0007qI-M2; Mon, 06 May 2024 13:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s41yK-0007pv-RG
 for qemu-devel@nongnu.org; Mon, 06 May 2024 13:17:53 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s41yJ-0007SH-53
 for qemu-devel@nongnu.org; Mon, 06 May 2024 13:17:52 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso739113b3a.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715015869; x=1715620669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bwh1q8N4+KPwdYLPhya/voZpGkyEV3YYZg5i7YknAqw=;
 b=HY12rSDjihRrzOw6D4rBx0+FTgIiz6/C5A7YfNU4mJWF8302L0RqdjU6Y30PIzBLiF
 vOhIpg9Z11+neqtOcw5Yc8866h8x1cWNxm2iX0QXQ1VFfUP7A8WAVItyYlFN6L0N2+Q3
 +03ZhvYStCAfAry1SYXOWT+ocXSkGZkq9U9O7joMQDkJXK45KOT6LQXv6hxhnv14jnZl
 0RNfUaWuYcPPin1bphnDDVBim0FYrshXJjpvjIxvo262q/t+3labMXpMirzbFGybj31Z
 tAoGeq0pWiNZTElNLdWchuKt+eddkZbkIRv3HRuzHFJUukVS1tOHaHDH6uJyj4bdZDTv
 48GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715015869; x=1715620669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bwh1q8N4+KPwdYLPhya/voZpGkyEV3YYZg5i7YknAqw=;
 b=aaWgmVvkkS2+9ZhgUgmEPgzI6stjk31eaZTGGJRkz5OWghRwo1lTBxLuGhEQlS14jm
 SS4bWHRyiuVI9PDNW81X3Ismh4gwwSUmPrLUnlFOEi62itOwnqWh+T67yihQulL5j3A/
 IhpBz+L5i0+UXVDLu5tEQ/7P4V4fxmAb1tcxVTxQ2TOFTJ2KBiYhuXscvhEg8CJ0FcLZ
 OkO+DJWqmtzwymaMA7tztY5pJUjTNUP3A4oQbCjTFugippogur0wu97Z7JIe5JRfNpLl
 PxXEBwSCNHUlYluVGYjRNum/zodlhn2Ot0b3+RUqrpXTCCul+qCHnZh2j9uga5N2D0SU
 //Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqzGNEXVS6BW76priwKo32WAN3fQsJhUTw2rQpFXyrT5NUVf4j1f644LXtMDRNAP36tHXRgE++yTQhuCVjZZkwjEiTMpE=
X-Gm-Message-State: AOJu0Yyn/djOudocEXkOa+zmg8yXLAnyrwKzh4yiCiUdTadvWzgNWY9/
 zMvlKXcPoeimd09lgJt7nkIqwjPTQQAXgmJamp3Z3yy6xDGb+xqBkdfeiXa7kXA=
X-Google-Smtp-Source: AGHT+IGcdRh4PywV4oe1w8V0mYxPt/r/JegyzU2UovXTww42m+rwejG+lNR7UhUmUyFfICm/dANBGg==
X-Received: by 2002:a05:6a20:9193:b0:1a9:5e63:500e with SMTP id
 v19-20020a056a20919300b001a95e63500emr11868276pzd.27.1715015869456; 
 Mon, 06 May 2024 10:17:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006f442343c6esm7369133pfo.200.2024.05.06.10.17.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 10:17:48 -0700 (PDT)
Message-ID: <99984a8e-7607-4ee7-a6e4-9e9cada965c4@linaro.org>
Date: Mon, 6 May 2024 10:17:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] Hexagon: simplify gen for packets w/o
 read-after-write
To: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 quic_mathbern@quicinc.com, stefanha@redhat.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
References: <20240506024227.3345791-1-bcain@quicinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506024227.3345791-1-bcain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 5/5/24 19:42, Brian Cain wrote:
> The following changes since commit 248f6f62df073a3b4158fd0093863ab885feabb5:
> 
>    Merge tag 'pull-axp-20240504' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-05-04 08:39:46 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/quic/qemu  tags/pull-hex-20240505
> 
> for you to fetch changes up to a4696661491cac8c1c08e7d482d751f808ce3143:
> 
>    Hexagon (target/hexagon) Remove hex_common.read_attribs_file (2024-05-05 16:22:07 -0700)
> 
> ----------------------------------------------------------------
> Short-circuit for packets w/o read-after-write
> Cleanup unused code in gen_*.py scripts

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


