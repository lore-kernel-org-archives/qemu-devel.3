Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2920C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 16:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2v7z-0002VB-1B; Thu, 10 Apr 2025 12:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2v7h-0002UD-Oc
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 12:51:33 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2v7f-00019d-JW
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 12:51:29 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so876476f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744303886; x=1744908686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qr5VYT3PQaUCfNgsJVmgZxyK4sIwPyVBkGPvF5Dgc80=;
 b=WtDdSOwHM/gxH3btSFECric856+bAAuCQMEbMaWWAdXqpBHwsIP92/KoxkpBD4uynE
 qUGDbBtT0G67ZYhreFkIZ/96zdViJKQi7ncX5dJ2eFxvpjhd07VB/c3xwCW95MR1AmCg
 C0Np8KJ33panaUh5htkV52+6zvOf+eC2sZnoPXXFoYfpo+txX0IgLsE0RUYmikVTGuDv
 oCs59o0bAhx1hD/LMtB75xW4y7wTAgxKv4SguntyCrhNM6xCiZe0PJaYUWDnjSxGI1HH
 p6S+tY/jxhqfNveRJWrpFODh6pw4nQBuu8Q1gjwYvqoDNGbbkIkKlq6paFPJQjp79aPp
 neBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744303886; x=1744908686;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qr5VYT3PQaUCfNgsJVmgZxyK4sIwPyVBkGPvF5Dgc80=;
 b=adMhJ9DXJUn7EbWxea2Ab4f7Zrk/CuhvnKtuT7I+IngEhENR7FnT165RIVnqVkKEH5
 M+uNCgQzqHjeqqiSWVYtFh9N8xAb0lfKu8wMCpoI9lDudXBmg40Lrkz/6e+NiZQ2E5uY
 iAqL2S1NQJiNy+OTHSLXt2C3FdFKbjQknnaVkOzbu/+9LKkUgn+T3IFNDWh6clSvxVYB
 5kCaR1rD6sHlt4M3jHHRTFLsNnxqm2QueD1Mm3Chs94es3eNZY1g96odxuY8TzIPwt3v
 yIgWHDJcwHuFcSZ/TngI0FwXXjXx8yXe5GFYm0+TQ+tO/y4xehnz+/yqMvihODu/wq6I
 cdEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZom0elzgLUOJXeW7XDZhiML+1WPWsB03MMVYYlaR4G3xURJdQvMCz4PbnE7jCcHNvz4BTDtohssY1@nongnu.org
X-Gm-Message-State: AOJu0Yz4Rwr1+33NlDXVMa7fn5J1KJuRQKAIQVKiIPyRWgXUPOYcy5p5
 Xnx1lIqgDlBTjEdeM5SK67U0VO0OkDdOnlwKBIaxJa+eF1cyPbB+ki8LfLcmdeSl4es80asmmWx
 S5a8=
X-Gm-Gg: ASbGncs2vLM3SxW1SamocipZTOdHERodwt4syop8r4rZWZ/uFr2Kc2cgfQPj/0LMvg5
 T6xkieinWvz4I6IALXbZ2UBA1Uy1MN83TFIHj8zlrgWLSrWTXtrnRzludhMxSUAZ5i8T0owhvT0
 oVanr/stWCr+HLkvcKrmAQ6gNUba9uTR4FdMlqb3Ak0hPDTCBNZoUs8Jh5DsbZ/cUic+xQkQhig
 5VCYKG7AxjVmwEBv8mPN8qDhPqYCJ2nFLCp+Es15cinsAkfRTxl7RZ7mbdGgmRHMOO9iuFER1u8
 Rsc/O65BvLMyojWlG0lUhPbuItiL6LVNxrLwgpugRwLW0xIeslecVs0U/c7EIsjAW7NulKsM+BX
 /w2Gj4lghubJSiQ==
X-Google-Smtp-Source: AGHT+IEL9tMym0XXj8FVQP5p4Qr6JhVmPoL6dFtJl71OwYlcy0b03QyiwYqsWlH+m2nwKiks79UGuQ==
X-Received: by 2002:a5d:64cc:0:b0:39c:16a0:feef with SMTP id
 ffacd0b85a97d-39d8f4d37dfmr2976100f8f.38.1744303885902; 
 Thu, 10 Apr 2025 09:51:25 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d8938a83esm5242222f8f.47.2025.04.10.09.51.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 09:51:25 -0700 (PDT)
Message-ID: <019026a5-5b48-43ec-9e48-5d49995c199e@linaro.org>
Date: Thu, 10 Apr 2025 18:51:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [for-10.1] qtest: introduce qtest_init_ext
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, lvivier@redhat.com, farosas@suse.de
References: <20250410162250.329941-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250410162250.329941-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 10/4/25 18:22, Vladimir Sementsov-Ogievskiy wrote:
> Merge qtest_init_with_env_and_capabilities() and qtest_init_with_env()
> into one qtest_init_ext().
> 
> Reasons:
> 
> 1. qtest_init_with_env() is just wrong: it gets do_connect parameter
>     but always pass true to qtest_init_with_env_and_capabilities().
>     Happily, all qtest_init_with_env() callers pass true as well.
> 
> 2. qtest_init_with_env() is not used outside of libqtest.c, so no
>     reason to keep it as public function
> 
> 3. and in libqtest.c it's used not often, so no problem to use
>     more generic function instead.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   tests/qtest/libqtest.c            | 18 +++++-------------
>   tests/qtest/libqtest.h            | 30 +++++++-----------------------
>   tests/qtest/migration/framework.c |  7 +++----
>   3 files changed, 15 insertions(+), 40 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


