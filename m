Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE78DF8E4A9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 04:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDbC1-0001ku-62; Fri, 17 Apr 2026 00:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDbBy-0001kF-JT
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:52:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDbBw-0004bW-IK
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:52:33 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so126871f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776401549; x=1777006349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GZqUvniB/hbtoN3vsAlK9Y8uDhOLEKm5n62oz/zRGmQ=;
 b=q9jqyjIzxLV5Ka0uTzYckAxgtVrs3IUE3uI3/eMX1sXMLdIwnIUOA1Izf23FEEfXyi
 jtl8WUCoeS02Vu7TGbIGvy/S+ajt6YR+Lz0UcUnx/BaOF/erV9l6Rz1Gds90Vhtvh9YM
 9zYtZ3xGsy5paY5JHilbHvdVa/ZoUKJMFk2WYENXVN5fGyUS6tl6wZ6gldh0jsGaT7fV
 a7MDRBZTNtRsStqaVhlZWdjyO2zs0eaekHI76mL9wcmtJOr2EQOueac+MRngzuCyDsqz
 j08BizNVyf+o+29NcoE7mOGd/fkZIjJrYMn6fLqW47ou9cqbN0ykhWVwhkbjX51YagWC
 0Imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776401549; x=1777006349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GZqUvniB/hbtoN3vsAlK9Y8uDhOLEKm5n62oz/zRGmQ=;
 b=R8ynfpOV3/yRJJDlqGxaYVrq4xfiQUl8utZURVL8UmVElBMVGS4qc/Suf0uxMFfQnK
 c281YnZhrGo6C57wuVre6mTT34Mz7LPbII1OjQpC56TfjGD39ODqBd/r6hfWFEaAfvAX
 MV4OKpdLFChuepQdXX1lOwb4oIO5lxIlmtzIsg8+zHCRWBU7xMuNX+VaW8clSL4bVEZj
 4/YZXN7Lf76N8fYNuFPoHqR/5baeilcR/GHVnjVdxLlj0/wtgKywqxuw/gsjQuRhZHzb
 cQHWfETAgGohQsFFwN3gSQgHEX5waue49GFOfGLBqc8OC/7c2XUQgEs7rN2CefuO38um
 zmiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Chbq+mGsP+ZmXLbsmcdG/nGRpLEfgUXMUr87cNM/D9KZghdEt/EWm9NmMA2/v7nfRXF8dsk7sQZCk@nongnu.org
X-Gm-Message-State: AOJu0YxtLsfK0Luh0lyIg7Rb5MXInvan2iAroaptq3icFspP9foU4f+K
 1Fdhh9VsRuT4/Df6SUB6DjxYdZp4B00MluauVntDk8m758/kJzxnKu0Vu7x3vMuiID4=
X-Gm-Gg: AeBDiesvpaOg1E5GgJkZkhDhDwDM3vWp0mrfgj/IRwTFXfkbwS7C8oom5P+O7gNIypS
 uSaCGYIwigtKzAqow6/VA2qFpnMXqHOU8i6DmO2W/Ux9ZnrhcVE/0d5KDkNr6S7/sSp6445sak6
 GDDEGZ244UbzRpBy7EQy/8U+lp2Afg7jqVtCSlpWO4sCOJSpNFzUc8CI35Vt+j6QJmQpnt3bCF7
 EWqhp/mxWteQl626D6mzy1wzYzoXXeZlEzRQjrbyJTo5Ld2fGQVjguVoRjzoKN3DNuHSmK8SG7R
 N8l5XZ2kd3+e0ZtX7Njt7Tn8Kus4qNn6LyiksMe9tiwD70IH7vzIotftYxi8lxZuf7zFXqJtW2w
 Lt3w/aOJ9FxgJNQyrPMFUVlV26Y5HYZxSuK/wm8Y9Lsr3HxY8dp3ImpHStJrgm0jIZfQHrEohxD
 Cnnd8QyiOwnzLl9xVXk6xNqQxEDiLKb4noX6jwSOFeuXUaODTzrgm1c9pQ9VggjFLCxx0NoM1yi
 OlRxQE0MKKxCyg=
X-Received: by 2002:a05:6000:2f83:b0:439:c661:3245 with SMTP id
 ffacd0b85a97d-43fe3e1128dmr1674550f8f.34.1776401548995; 
 Thu, 16 Apr 2026 21:52:28 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4daf2sm1379919f8f.33.2026.04.16.21.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 21:52:28 -0700 (PDT)
Message-ID: <dcfd9953-487c-4c05-bc03-9f87b490f05b@linaro.org>
Date: Fri, 17 Apr 2026 06:52:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Add support for pre-setting the
 authentication key
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <cover.1776231967.git.jan.kiszka@siemens.com>
 <9fab19ee4c755f9cb2abf55494541fcadff46cbd.1776231967.git.jan.kiszka@siemens.com>
 <d68f975d-0450-4928-b758-bea1e657eae7@linaro.org>
 <60d47301-08f4-44e9-9cd6-2a12bb9e56de@siemens.com>
 <183ce56e-cbd9-41a5-8d68-9281aa6ddd54@linaro.org>
 <5add8989-b670-4350-a251-eab8503082a3@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5add8989-b670-4350-a251-eab8503082a3@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/4/26 17:31, Jan Kiszka wrote:
> On 16.04.26 10:29, Philippe Mathieu-Daudé wrote:
>> On 16/4/26 09:50, Jan Kiszka wrote:
>>> On 15.04.26 22:28, Philippe Mathieu-Daudé wrote:
>>>> Hi Jan,
>>>>
>>>> On 15/4/26 07:46, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> In contrast to real eMMCs, we are not (yet) persisting the full state
>>>>> of the device. This particularly includes the authentication key used
>>>>> for RPMB access, complicating testing of firmware images which do not
>>>>> support initial provisioning of the key.
>>>>>
>>>>> One way to address this would be, e.g., extending the eMMC disk image
>>>>> with a special sector to store further state. A simpler approach is
>>>>> used
>>>>> here: Add another device property that allows to specify the
>>>>> authentication key, bringing up the eMMC as if the key has already been
>>>>> provisioned before.
>>>>>
>>>>> This is how to tell qemu to use the OP-TEE test key:
>>>>>
>>>>> -device emmc,[...],auth-
>>>>> key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
>>>>>
>>>>> Or use this for machine-configured eMMCs:
>>>>>
>>>>> -global emmc.auth-
>>>>> key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>     hw/sd/sd.c | 23 +++++++++++++++++++++++
>>>>>     1 file changed, 23 insertions(+)
>>>>
>>>> Do you mind mentioning it in docs/system/devices/emmc.rst?
>>>
>>> Right, there was something... v2 our patch on top, what do you prefer?
>>
>> If there is no need for v2, my preference is an inlined diff that I
>> can apply directly saving both of us time :)
>>
> 
> Here we go:
> 
> diff --git a/docs/system/devices/emmc.rst b/docs/system/devices/emmc.rst
> index e62adfd68e..e7d67c809d 100644
> --- a/docs/system/devices/emmc.rst
> +++ b/docs/system/devices/emmc.rst
> @@ -53,3 +53,26 @@ SDHCI controllers while assuming that the firmware needs a boot partitions of
>       -drive file=emmc.img,if=none,format=raw,id=emmc-img
>       -device sdhci-pci
>       -device emmc,drive=emmc-img,boot-partition-size=1048576,rpmb-partition-size=2097152
> +
> +RPMB Authentication Key
> +=======================
> +
> +A private shared key is used for authenticating requests of the host to the
> +RPMB. A real eMMC stores this persistently and permits no reprogramming once it
> +is set. QEMU emulates key programming but does not persist the key state
> +across restarts. To emulate the state "key is set", the eMMC can be created
> +with a user-provided key via the ``auth-key`` property:
> +
> +.. code-block:: console
> +
> +    -device emmc,[...],auth-key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
> +
> +This sets the well-known test key of OP-TEE on emmc device creation. In case an
> +eMMC is instantiated by the machine model already:
> +
> +.. code-block:: console
> +
> +    -global emmc.auth-key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
> +
> +A key always consists of 32 bytes that have to be encoded as hex numbers,
> +left-padding with zeros as needed.

Thanks, series queued!


