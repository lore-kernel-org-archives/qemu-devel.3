Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69959C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiBP-0005M4-C2; Mon, 08 Apr 2024 02:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiBN-0005Lv-Ne
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:08:41 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiBM-0005z3-1x
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:08:41 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a51a7dc45easo312075766b.2
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712556518; x=1713161318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W4KSWG+OYZJc9cZudDYgiBUYvMbvtXIMkcIDx02xl20=;
 b=TLUS/R8wYft/kGdgSpXYx138dnpikFxzmolRPAL9apeXGsrxcBiahalODWlXVfEjyq
 1BFgG//J4+nrWmNEmiYSJKO7z+EE7FwMDPSRqdCpAiSgWiiTfzVmNePxq0GBrtwIVsXK
 KnsSfjK32n55puo3ytvubQEln9UHHwqz2QFNpN6dEtCgoyyuAvKbJSvRJuosbT7Oz5/D
 NIqkMhS+M3oGpKZOP0kYabMDbG4oGRnVeSHxxqhFSK91ZbJfHRszdFj2Z0ac/aiu+vRR
 9Oa/SlxXCPvePSZzHA65/jJgasI18VOXdC4wLfsV6Xki6x7Gu2dBTbPkMvf7Qqx6sPV8
 oIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712556518; x=1713161318;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W4KSWG+OYZJc9cZudDYgiBUYvMbvtXIMkcIDx02xl20=;
 b=XFX6c1agA6Hwzz9WvSK+JqXXNc1Vn5GRn+45i2SVbGpGsFNWDOHZ0an4geW8n+FybK
 mYlh8ZVQesBdRlx4SMmzh+deCfIJjngOcY+FKeZG8NvYRgVB5ovnf0dxW22ZcYspgOyP
 P/C+9EYG4WvyIMKNUGoa+lTYB6esGwJpyc6XaXdnrAjSWbz5vAj/MRy2X0IWPgZkim9r
 oumSgaUWW3kt12NIi3Eq6tqbJZIXdkpeohkXv01S0IshfIgC2xT+NV8rpikXedNNgKae
 FC45xiMrKjj2WngA1ZdNssgJsF6VAWFX3VTo30vZem7WguJvZ+jrwA6TMaZ6d+We4bKe
 AKHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURl1UurPa2f0i2W7m5H8laeuIDbw/AmNUBHGpU3EV8XxjAehSEFBp5JyXzkQaIxAEM7jK1CPUCHSKCwDw7PAkXPRN79Lk=
X-Gm-Message-State: AOJu0YxHsyeJ+EO03AERdLY+h6xvIqdSoNApA/Kq4Ybzp3UCkUp1ZC80
 BotDp7WvMQWq8MJjufO1V0kNo53dVdu+GIcnHSPnO+dh7KWnUPVoBtiNCqMgFDQ=
X-Google-Smtp-Source: AGHT+IEznJUSPiP9D3d2s/+D0Ne/MVDB8lXnOaszk/I8tskSWesMggwZHMEhMKbvJSa//NJQUMbcLw==
X-Received: by 2002:a17:906:c55:b0:a46:92a1:6459 with SMTP id
 t21-20020a1709060c5500b00a4692a16459mr4936547ejf.17.1712556518396; 
 Sun, 07 Apr 2024 23:08:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 jg18-20020a170907971200b00a51a60bf400sm3847864ejc.76.2024.04.07.23.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 23:08:38 -0700 (PDT)
Message-ID: <6e5d5d31-24ab-4284-b26f-66e429f8fc54@linaro.org>
Date: Mon, 8 Apr 2024 08:08:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] target/sh4: Fix mac.w with saturation enabled
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: zack@buhman.org, peter.maydell@linaro.org, ysato@users.sourceforge.jp
References: <20240406053732.191398-1-richard.henderson@linaro.org>
 <20240406053732.191398-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406053732.191398-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 6/4/24 07:37, Richard Henderson wrote:
> From: Zack Buhman <zack@buhman.org>
> 
> The saturation arithmetic logic in helper_macw is not correct.
> I tested and verified this behavior on a SH7091.
> 
> Signed-off-by: Zack Buhman <zack@buhman.org>
> Message-Id: <20240405233802.29128-3-zack@buhman.org>
> [rth: Reformat helper_macw, add a test case.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sh4/helper.h           |  2 +-
>   target/sh4/op_helper.c        | 28 +++++++++-------
>   tests/tcg/sh4/test-macw.c     | 61 +++++++++++++++++++++++++++++++++++
>   tests/tcg/sh4/Makefile.target |  3 ++
>   4 files changed, 82 insertions(+), 12 deletions(-)
>   create mode 100644 tests/tcg/sh4/test-macw.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


