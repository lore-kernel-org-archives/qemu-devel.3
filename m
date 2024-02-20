Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0D1C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 20:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcWUM-0000P0-HH; Tue, 20 Feb 2024 15:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWUK-0000Op-SS
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:13:12 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWUJ-0006Xt-AI
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:13:12 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-290d59df3f0so5121731a91.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 12:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708459989; x=1709064789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HQoDLWE+tHXmr61iG9SGA2MUAvCUj1IQ1kM2npPoaGQ=;
 b=etd6SNpi9dgdD2dv/By3Cxc4vbVKMT+CURtgl8Nh2Ei/sLSxgsEL9jB9glsVJdOhCD
 3XwVkN5SbhmPAKNkYJIX1O7QMnytsLmsofO48bd7I31TDJl/lWs8GFwiQ6KQjB1HV1no
 2wYm78Oo7yNSkVQTUBXcVXFZ/WOEeXjQVWQ1cgVGsnHwV3b5l0qyB6gvuWSoQrHeSX13
 wAGE8hAYn7wFhKGAyl604vlA/kL316T4uDMuDtcETwU6kIhiIWKbiteK4iDa5eKuJfhX
 HkmSpBuuTWJkkN9uBx76r9CeqYzlA4KIkSjrcKcyU/I6cJpyb70ftkNRl51WxqHoSBHk
 BubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708459989; x=1709064789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HQoDLWE+tHXmr61iG9SGA2MUAvCUj1IQ1kM2npPoaGQ=;
 b=jbwYVBQCrqKenGyNTropIqBM5QnMEfjCqM9RBhSXLY5oc8wVRRUvXLmwQzMhys7lz3
 CdPz37l6O28ovSO2qWtrc6a2QnjVoyjJsyNZvP0mmoYJ1f1XkLtwtxxfJM3pU0mrqc8V
 4+bNVBpkrpLG0FbwXaYnxaRrrRqIM3oxWtUO56DeTO2VJVW8L9oPmNuArherYkr+BQeQ
 jrQNjBiKKNUpp2tRkiO3aa24svWLTEIAYIr2qhk98PsZRT9a5b5VTJXXkySRZDd7Gfnx
 XoptozoDBvqAFSb5kKymQjXlOr/G/1C8JOwfOVjFkI3XK4B8ZaURnV9ZAOQqd68ehtSm
 Lk5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6HydRQsbZ1eutoQ/H41g7eSJaHlfiHA84i9IHqKXo00H240KE9gZBTM9Atp2A0TQIJO09VrQjG/cbIZngcehc400A1MA=
X-Gm-Message-State: AOJu0YzJWMqL0kVL/28GuAAssjFLUHQ6ZO4QacyCAm7vH/3LuY1kItlr
 HkyZp/J+eGCIdaohsw2hcuNtgt2XaP5uVWkV8WDpxurXq4UawemFqTHF5XMsbmM=
X-Google-Smtp-Source: AGHT+IGBLAyitnP7Osc8SmMB1jVmvWEbeqtDcLMLITcK4l3e+cbSkT+o2SMjqkVQiov4zlAyE9dMVg==
X-Received: by 2002:a17:90a:77c3:b0:298:c118:c3d1 with SMTP id
 e3-20020a17090a77c300b00298c118c3d1mr14683314pjs.22.1708459989140; 
 Tue, 20 Feb 2024 12:13:09 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 sv6-20020a17090b538600b00299d4856e6asm50079pjb.1.2024.02.20.12.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 12:13:08 -0800 (PST)
Message-ID: <e2fa1121-eb3f-46ec-9e46-f3da42ef56a8@linaro.org>
Date: Tue, 20 Feb 2024 10:13:05 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] docs/devel/reset: Update to discuss system reset
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
 <20240220160622.114437-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220160622.114437-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
> Now that system reset uses a three-phase-reset, update the reset
> documentation to include a section describing how this works.
> Include documentation of the current major beartrap in reset, which
> is that only devices on the qbus tree will get automatically reset.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> This merely documents the current situation, and says nothing
> about what we might like to do with it in future...
> ---
>   docs/devel/reset.rst | 44 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 42 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

