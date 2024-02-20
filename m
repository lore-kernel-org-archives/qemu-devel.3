Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F14C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 20:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcWRE-0007hj-LR; Tue, 20 Feb 2024 15:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWRD-0007hN-3K
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:09:59 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWRB-0005w4-Im
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:09:58 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-599f5e71d85so3765458eaf.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 12:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708459796; x=1709064596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IAuxyBrCJ/lUuzB5sld+Gg4n/afAKejGR+X7bc5rpXc=;
 b=bshYhVSvlGvtxsWFn/QHdPyqWqNVntdCIYvD5DXEvN8jhn31sLBu+00wLzfp4s+KGr
 k+iXOREgwMYlj3zmb+OSgm/fU752dadlSfB1IUSOdANi30mZTzSvs8u4+yXAaM1kSUWr
 WPDg1SfaCMCG79++Y1j2BRGNjGRzJXY0ZC+cpnbhGBzAZnx5B9KWCNNWpslTGGyzZF79
 /1xQT0NqsvouXyaI0b+gDc1Xxr/1TPCChOVjAMyyxCG5v/n2rq8SdkZ2B1ErmQSWFXYR
 c+xoQ0LV20ASJvk13Vfy2OSaZIm3O0CLgWcyF1NbIs/c01JSu85z7OEWcGuik066Z/NO
 EAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708459796; x=1709064596;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IAuxyBrCJ/lUuzB5sld+Gg4n/afAKejGR+X7bc5rpXc=;
 b=SlZP3e00SeTBh0mhkn9deCxZpMxZ057m1s/ud46M10cFsVFfemlbIkqz61f5mZY8jO
 M9pJvw0C1Hs+jQ/VIiPNtXexqA/4YYV2qFkO3GhlXx6OD2UEMF+TMcejjVwv2ebOP1qF
 0k0ulqd79seH71XvMZwJvyDqq3xmxm2hOFjjMofdLeVe1YpFsakRKJn8MDA/6yHgdcti
 y6b22IGM9jy/A9/Ery+fN6aIvelKQsPSPRCwT1DXVndT+rdiDH11Qx6CZBuh6Y4ZVXpQ
 eQQOgjVtDhB2f+lvJ+uMCkRDlcJCJ4Q7k/5psD5nN5wPTjr/FnrA1v4S+qhPSD/vZI71
 wDiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjkFkq9pLmb6yQ99PzNDTvk0hMgX5JVGuj3SI5creyIu3lyPdzTe07PEKcTzzh30fGWAvb29ySwnp9Rc/DcnRQgZYsCfM=
X-Gm-Message-State: AOJu0YwAjpvLlNYs9BUFwC/xKZ15oswUl/q4660d8yfAA7GwhFsPusiE
 ek/L2Ig/7xGBd87Mt7MMkNpPFd4Lvg/ya9fZdzM+lKghGBkKPWyL0cIX8UDLHuc=
X-Google-Smtp-Source: AGHT+IEqjNpTUTCfpTnXKlLzZeEr0DzM1XbhVax1+7El1fnFnsMtlSkORKjrXmNPV8+RJMI+sWiGnw==
X-Received: by 2002:a05:6358:6a46:b0:17b:2d12:74d9 with SMTP id
 c6-20020a0563586a4600b0017b2d1274d9mr12553492rwh.27.1708459796276; 
 Tue, 20 Feb 2024 12:09:56 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 m25-20020a638c19000000b005ca0ae17983sm7151639pgd.8.2024.02.20.12.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 12:09:55 -0800 (PST)
Message-ID: <b2186b56-50f9-4e0e-a8cb-dfc764f4d221@linaro.org>
Date: Tue, 20 Feb 2024 10:09:51 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] hw/core/machine: Use qemu_register_resettable for
 sysbus reset
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220160622.114437-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

On 2/20/24 06:06, Peter Maydell wrote:
> Move the reset of the sysbus (and thus all devices and buses anywhere
> on the qbus tree) from qemu_register_reset() to qemu_register_resettable().
> 
> This is a behaviour change: because qemu_register_resettable() is
> aware of three-phase reset, this now means that:
>   * 'enter' phase reset methods of devices and buses are called
>     before any legacy reset callbacks registered with qemu_register_reset()
>   * 'exit' phase reset methods of devices and buses are called
>     after any legacy qemu_register_reset() callbacks
> 
> Put another way, a qemu_register_reset() callback is now correctly
> ordered in the 'hold' phase along with any other 'hold' phase methods.
> 
> The motivation for doing this is that we will now be able to resolve
> some reset-ordering issues using the three-phase mechanism, because
> the 'exit' phase is always after the 'hold' phase, even when the
> 'hold' phase function was registered with qemu_register_reset().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> I believe that given we don't make much use of enter/exit phases
> currently that this is unlikely to cause unexpected regressions due
> to an accidental reset-order dependency that is no longer satisfied,
> but it's always possible...
> ---
>   hw/core/machine.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

