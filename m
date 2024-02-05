Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B770AC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 13:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWzOz-00012g-Rx; Mon, 05 Feb 2024 08:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rWzOx-00012D-0O
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:52:47 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rWzOu-0007Oi-0H
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:52:46 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40ef64d8955so40585305e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 05:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707141162; x=1707745962; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HVbRqMnYEeQsQiEDTFTHE/RBaF3wOwp5DqDF4yy/N3Q=;
 b=H5U3XtqfSEp4C71bz9kF4b6zTHTGuaOboEIKZV2g/td6kuCZpEzt01M52Rdc5Q5ifw
 y1ApmhP82rHSrW6C3hiOzup+vxpnG8ZjjMB5G1d73CuPW4bhqEU4Tr/6Xei3pV83l3ld
 NUZraTj3GDYYx2by8d5YBfAj2OmEbVZ6qOvTp9W0YMRyy8PjUPzJ1G7BQNy0BwH5kbx0
 I8PU4Yl+ZLWHdSiKODvqdWNfrwqcIS8P023+DCK8O35dIm/ixYJnmOiunTc6HpqXBm8e
 vCpwi0Z5xcZkw1qdOGmM/e6VvohwuYBQKFAtwsvHd7R+gCiDyvGAcDxX1o0ohuQAcpwj
 hx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707141162; x=1707745962;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HVbRqMnYEeQsQiEDTFTHE/RBaF3wOwp5DqDF4yy/N3Q=;
 b=GR89WlmTwPPy0hpYidyh1ygyFqCXa5ulHKZqA68fKHqvRkbVvQZsWaIezfMI5rfYBD
 yHxcFEtdIsryZMY3h1cyXo4dUNLSX+PSmkP7jPbtCpn4+TYP4PiW1FFCi54sZQw93jgA
 gF1cQuvxLpJRDMUljFeediVP27oi98EAogvw6UvsUKQhDFgeTqGMyGGPxWdYTLYT4glr
 wf7f+H3R6hql/vc0DJbi3sSdOY3eoOm0FuiGrpq5stQxd0sNm9hFvs88I0gnRaz1EYQS
 RuEgQfRYD7VFxMQYqVaw7JWrkqsmbt6gkotGFb+EfzlGNwGUyvxF2hVVR3+rIDcF4ZJD
 7HHg==
X-Gm-Message-State: AOJu0YxpRaIsmo8jAWViLM8kbKN9EmWnmYuEwMH7FPuJdVg2YUFrrGgu
 S7BOQGs3kwVzq+GrA9RnKpPM2mwbnDHM56Rj8ZZnmnv0+8e0XNSyRLo66MSNuhg=
X-Google-Smtp-Source: AGHT+IFl2rZgGSawihFzZ4dXYXF8Vo++v9VfoKc2HPssa6nzgCTaTdGRInlozcmJByHj+Y/UTl+OCA==
X-Received: by 2002:a05:600c:4507:b0:40f:df31:6cac with SMTP id
 t7-20020a05600c450700b0040fdf316cacmr69897wmo.4.1707141162022; 
 Mon, 05 Feb 2024 05:52:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWpior6GQUz12W/5pOp0gKAtrNIgbZJlZ14UXG8yRyg8wZvOQS6SFLqaKOs7Gb1VmRaPe4lATM9Cab2uIavTAF4Ki3qsH3WH68WKA0dU8faR/Oyvyfz4wN3DvjX/0BkV0L3Oj8CT5PGfF1ZjGXq+N3OyC8+jBwO8IxMFlchEcbGpMAjQpZ2tvffyD559Fd+jXXVbc2hfkQ63sQgtzharAGoBZq0zFgMWLnc5QtdD3LweIwkVoz4AENjxghdoG8lP22W+rxHHsVaqQEF427TLJ3RI1SJV9GDGXI=
Received: from [192.168.197.175] ([92.88.170.125])
 by smtp.gmail.com with ESMTPSA id
 k26-20020a05600c1c9a00b0040fd3121c4asm6753455wms.46.2024.02.05.05.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 05:52:41 -0800 (PST)
Message-ID: <909745ef-b3dd-4af0-b4dc-e2be9e76cd83@linaro.org>
Date: Mon, 5 Feb 2024 14:52:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/qtest : Add testcase for DM163
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Samuel Tardieu <sam@rfc1149.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20240126193657.792005-1-ines.varhol@telecom-paris.fr>
 <20240126193657.792005-4-ines.varhol@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240126193657.792005-4-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Inès,

On 26/1/24 20:31, Inès Varhol wrote:
> `test_dm163_bank()`
> Checks that the pin "sout" of the DM163 led driver outputs the values
> received on pin "sin" with the expected latency (depending on the bank).
> 
> `test_dm163_gpio_connection()`
> Check that changes to relevant STM32L4x5 GPIO pins are prpagated to the
> DM163 device.
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   tests/qtest/dm163-test.c | 192 +++++++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build  |   1 +
>   2 files changed, 193 insertions(+)
>   create mode 100644 tests/qtest/dm163-test.c


> +static void test_dm163_gpio_connection(void)
> +{
> +    QTestState *qts = qtest_init("-M b-l475e-iot01a");

This machine is only available in ARM binaries, ...

> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_data_func("/dm163/bank0", (void *)0, test_dm163_bank);
> +    qtest_add_data_func("/dm163/bank1", (void *)1, test_dm163_bank);
> +    qtest_add_func("/dm163/gpio_connection", test_dm163_gpio_connection);
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 5692da4fc1..e9f6ac46ef 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -22,6 +22,7 @@ qtests_generic = [
>     'qos-test',
>     'readconfig-test',
>     'netdev-socket',
> +  'dm163-test',
... so I'd expect the test to be restricted to ARM & DM163
availability:

-- >8 --
@@ -206,2 +206,3 @@ qtests_stm32l4x5 = \
  qtests_arm = \
+  (config_all_devices.has_key('CONFIG_DM163') ? ['dm163-test'] : []) + \
    (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : 
[]) + \
---

BTW please consider enabling scripts/git.orderfile to ease reviewing
your series :)

Regards,

Phil.

