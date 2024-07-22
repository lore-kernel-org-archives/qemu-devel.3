Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1D2C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 06:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVmcu-0008Oy-M9; Mon, 22 Jul 2024 02:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVmct-0008M7-3L
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:34:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVmcr-0001VE-F4
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:34:26 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so18684995e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721630063; x=1722234863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J33Dr11HEuWVlZHUckFxKb8okuFb4YfXuDE5ujFxuRA=;
 b=v+UkWEE9LlVAhtHSuX1ppfdF95ocnoYMKn4wRcW3/BCUugxVspHQOD/ERBnTHYJk3S
 WJh/B0nk4hTMwAUjGM3BU82P4TKp0+pEG2wty1NbSrEXoORqSzmWfkmqRBCz7NPiO7D7
 +PjEuTXFMmqus+e20nFmGamXamuqThw53/Z1QfIhjRrQhgviAJW/Pz1Qb6n4Yiv1VUdo
 f9KnE/OoX5HSfpgMCfXD0yqqqLDFcGziiym/aW2NGIkcp0oqh/SYUQRvjXdQ2llkBHEL
 io0ihVyxwRPpPVJncUNx6GRNe7Mqrt076ZQqAOs4DsMRAzJU0sbbPf9VmuLar39wOlkO
 M9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721630063; x=1722234863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J33Dr11HEuWVlZHUckFxKb8okuFb4YfXuDE5ujFxuRA=;
 b=VUZ1l+J1LGaUzUfqj3zq0TuDDLtaO5iWcLsYRMAgpNCQ2G/VtPntQx0lag2MwxqpjX
 L2sW5gPlTgfcRnHkmQify3jWsJwkhKFc9tq44JNUgfvyu6p3CAYYB1VJKD/gWqpdktaR
 aR8zch53ageuvcJLNiSCzSzPAEoc/5FLSIzB7HPXlHZAADHyZ4pU7n78ShQmJcau1raO
 xxApP8hC2m03CXIxte/NWrZHCrHvbPK62GXoKOJ+QC+K+HkWRPUzopapx/aiGDagLu+C
 6P5lxezuF0SjN/NAmTZutTyLjQtghvdv2YmV+21LTBWhg8smA18yVqGxmora2V4CaqgZ
 HS/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6eTo+2yKim1/L5MuqRuO57XVqRXsgF6TJ0TOBaCKp3HAlUZPQ0KICWPfCuz70C5ejmddM+tSS8rayxng1PSdkiODdDus=
X-Gm-Message-State: AOJu0YxiRFymq68n+vRhDI45Z0oZ37Q5RTqGvLkP9Bvd9c3Pfuw1M0Vw
 UurCdWeWxJC/lGnOypdke/1sKYCDuHnwbeBO2VRe7oM5kCn/ag9Dbsbw+k6W7m0=
X-Google-Smtp-Source: AGHT+IExO914yIlQvi3KM3Gig3D/VHifUGi2skd743ySZHV1NQhWglyz5mrxmgEMFbxpYNynKHZjjw==
X-Received: by 2002:a05:600c:3b0d:b0:426:618a:a092 with SMTP id
 5b1f17b1804b1-427d2ac024cmr73294345e9.13.1721630063551; 
 Sun, 21 Jul 2024 23:34:23 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6937e81sm113070505e9.47.2024.07.21.23.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jul 2024 23:34:23 -0700 (PDT)
Message-ID: <c968cb0d-9de2-4a87-a04a-159df7268364@linaro.org>
Date: Mon, 22 Jul 2024 08:34:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] aspeed queue
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240721081401.425588-1-clg@redhat.com>
 <22995a46-9288-43d3-aafc-c56705c662ed@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <22995a46-9288-43d3-aafc-c56705c662ed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 22/7/24 07:21, Richard Henderson wrote:
> On 7/21/24 18:13, Cédric Le Goater wrote:
>> The following changes since commit 
>> a87a7c449e532130d4fa8faa391ff7e1f04ed660:
>>
>>    Merge tag 'pull-loongarch-20240719' 
>> ofhttps://gitlab.com/gaosong/qemu into staging (2024-07-19 16:28:28 
>> +1000)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/legoater/qemu/ tags/pull-aspeed-20240721
>>
>> for you to fetch changes up to 4db1c16441923fc152142ae4bcc1cba23064cb8b:
>>
>>    aspeed: fix coding style (2024-07-21 07:46:38 +0200)
>>
>> ----------------------------------------------------------------
>> aspeed queue:
>>
>> * SMC model fix (Coverity)
>> * AST2600 boot for eMMC support and test

🥳 🥳

>> * AST2700 ADC model
>> * I2C model changes preparing AST2700 I2C support
> 
> Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as 
> appropriate.
> 
> r~
> 


