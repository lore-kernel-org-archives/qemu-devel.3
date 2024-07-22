Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCA7C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 05:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVlUk-0004b0-51; Mon, 22 Jul 2024 01:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sVlUi-0004ZM-PS
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 01:21:56 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sVlUg-0005hb-EA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 01:21:56 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70d2b921cd1so347231b3a.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 22:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721625711; x=1722230511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tZnSY7mkBUXb0/F/YQCmgBzJ7YOFbEEDAM0HuwTaadY=;
 b=c1gC93f4jw6j8Zc3EMciYMmhptODNTxluRwr9MXTBZJuh/YVAujg+2RzmJTRB0nKwz
 IAdozJvcneC0GsLOqvP2ea+zNeGbKP1NtBskJ2WUI36G5LQ2gxlhfAblXfpcKrkfxWls
 WxJrTPVWK7Dp9c1hKiDJC6r1vVB0vI8zdwnJQP5me4AgMzDSwaLildVje3sV+ROYDK5q
 IWvdB8M7lPU4v51TbmbkuLBYwKABgrvhjD027J1zI0Hz1Gx2u/fcdFusauAK/5xTsqZf
 T+6iylT21VZcstXov8GiCQi7m5g9C+t9Umhr6QfsTT3t2epwwJ9JIki3FZFLYMc8z2x/
 iZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721625711; x=1722230511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tZnSY7mkBUXb0/F/YQCmgBzJ7YOFbEEDAM0HuwTaadY=;
 b=Q+Dw4rxIrqEXAWamRv7q9uY2PcwuFCwyZRHR9gu0X+JATdT1RLjAQo9msms0NI9D44
 lCBYLebOQ/HJNsalBx9fuZxnbc6Rrb37YSBd8hndWd278yWEC8t+EVtIqbV9ExxD9rTa
 rnsUvVbhOnoUSOPVYFHv0er1B2yz40XblHlZTpN/TjgmlcHeI1SfRTsQqSE6MX9i9ZFK
 Toz4f9J9S7TvVgUQzZqTotRF7amqV+ppTjxBtcjwm/Xs3fyMpW4HQTSWXcuKRWwmT0UX
 Q6zjteKltHCE5X2PqTHX2mFvcZAKqkf3/m5KX1+AkTYgPTxEi2L72UeI2ZuCt2YK8Yu/
 PSdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1eNCz9yx9Fuwmf4QzfarI/w6R1PgzOuEoQwBHJpyuhkqE2os2H/BDb+vVJZGYH8ousRkJ0ipk5j6YECn377fyoS8p+ho=
X-Gm-Message-State: AOJu0YxWFEhtw7vzAvRpg8Xy1G7BSd+VopIrpUcWq5uNt1Th2oB04Yhl
 p3HUEU9PpQwXGl2J3Tmdw3Hgkzz4ETy2LyGTM4xz1VqcJIEVicamag5QsxWyfkc=
X-Google-Smtp-Source: AGHT+IEUDTqE9nq4vp7XCW/XGlhK/BfX59fbb2cDTQjAP6aQIDWfEOLDAFS0jIivQYkIWQ8yLxldMw==
X-Received: by 2002:a05:6a20:72aa:b0:1be:d1bf:a371 with SMTP id
 adf61e73a8af0-1c42295f2cdmr9990685637.33.1721625711461; 
 Sun, 21 Jul 2024 22:21:51 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f44d179sm45481055ad.212.2024.07.21.22.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jul 2024 22:21:51 -0700 (PDT)
Message-ID: <22995a46-9288-43d3-aafc-c56705c662ed@linaro.org>
Date: Mon, 22 Jul 2024 15:21:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240721081401.425588-1-clg@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240721081401.425588-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 7/21/24 18:13, Cédric Le Goater wrote:
> The following changes since commit a87a7c449e532130d4fa8faa391ff7e1f04ed660:
> 
>    Merge tag 'pull-loongarch-20240719' ofhttps://gitlab.com/gaosong/qemu into staging (2024-07-19 16:28:28 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-aspeed-20240721
> 
> for you to fetch changes up to 4db1c16441923fc152142ae4bcc1cba23064cb8b:
> 
>    aspeed: fix coding style (2024-07-21 07:46:38 +0200)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * SMC model fix (Coverity)
> * AST2600 boot for eMMC support and test
> * AST2700 ADC model
> * I2C model changes preparing AST2700 I2C support

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

