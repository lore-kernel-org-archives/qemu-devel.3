Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8718C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 08:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdmxe-0005gb-39; Tue, 13 Aug 2024 04:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdmxc-0005b7-Lx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:32:56 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdmxa-0006Ll-Sd
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:32:56 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7a83a968ddso505321966b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 01:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723537973; x=1724142773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K39hCVxZDiwh10XPpZXeqLUXFggILY6z0KTzVQEe+E4=;
 b=HFfhxJI3OURRRJUIibjkh6yGZOe8xU6vfNsB3nKqzWzu8yO7rMwVtT3wS9OucXHWEc
 gxs6XjKrbPjvOQNif4w8XsGwdtTZMiZvmbtLTuNDxfAyelDywCH1wC+Ko01CiYLGMrhM
 F4nMm/uC8gyjRVkXLW17WR8UdampjV0PUKANBws8EzgJpnOnMh+V9KdpHL65Ut+uHzpJ
 DQM8k5omtCnFDxadCUJpJMm4SCUZw3te0+1A6ujLCGdpDPXGMWKDLuIqqFYls/7aPxqK
 E8OyhVsmVSH3MZj3mWYUCYaeVPrJLNJCcoYlj0oqi+Oqu3tKFvHGds0/gX2HqmxHiT5L
 oJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723537973; x=1724142773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K39hCVxZDiwh10XPpZXeqLUXFggILY6z0KTzVQEe+E4=;
 b=gWxbagPf2/Ft7YoHfyKeJ41Ig8HKy/OwGA79PXwFjgzCwmfsrPpzJuQqhSE0U+h+Qu
 LheqxqWJMoqKiC+Y0cfA+9JUYzKkgFhIKVXC2/F0xEBdYmWMC776h/o2SBBHQyE8jgBL
 RKr7iKKM4Kvx09OV+LBF+nqgsd5M/oxk9awb/dAzF/kJisxujOuVjhxccZJKu5ffcu0L
 E2f7nWfVdQHAzlssW5CenSKxl9l57cjfLw3cbQU7nMGDE/YYFFMTDl8yVDM44Bybbrh6
 3AgQgmXox4aqgxCRG0hTE0Fymd8SDxZBtZtE1Htw1muPMC2ZPUigxtCAqo9ZUNHUCQ/c
 SdTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzqtK7qyhwV/sZJWPj+1MAoLr7WHVZ15hLm1h3l2FGQTXqem3Xq54/gUX6Urfm2bAyozhk0YxZGQ6kKlKDzxDz1mo7UUA=
X-Gm-Message-State: AOJu0YxnTMQgV8f+ZUPbklDUoFYpuq5lsRGQ/6gy2bwOjINzreg6LnN3
 q9c7RkjBnNIrWw7IMY+tiyk/AITmo005GTOFc0YwWVO2Duz1KEQUYs0CRZIi8Yc=
X-Google-Smtp-Source: AGHT+IFdofLhOfFifpA+P7ZaxNI4/pULSNg6TgI01r5b24JFRuedSJkXPHAnHJVSh0WZqCxdNAEkdg==
X-Received: by 2002:a17:907:d861:b0:a77:c95e:9b1c with SMTP id
 a640c23a62f3a-a80ed1c14f1mr213588866b.27.1723537973011; 
 Tue, 13 Aug 2024 01:32:53 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3fafb6csm49649766b.75.2024.08.13.01.32.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 01:32:52 -0700 (PDT)
Message-ID: <e9ea37c6-a9b4-4708-bfce-0869d1bd9cbb@linaro.org>
Date: Tue, 13 Aug 2024 10:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/23] scripts: add script to generate C header files
 from SVD XML files
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Octavian Purdila <tavip@google.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com,
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org,
 marcandre.lureau@redhat.com, alistair@alistair23.me, crosa@redhat.com,
 bleal@redhat.com
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-4-tavip@google.com>
 <CAFn=p-abeXP+dUtp_gwH3dcD5DT-sTAFg=udVugrzcU1r8fXpA@mail.gmail.com>
 <CAGWr4cQL_LMWmEUdoPprRSp2k=CkQ0UJp5Q45qbAtUvvE6fDHg@mail.gmail.com>
 <9080f7e5-a40d-4cbd-a734-74578dd27894@linaro.org>
 <CABgObfY1hGKhBjwjDeKSSd5uxbe8Lc5=hVL6psB0NLbnX1bJ0g@mail.gmail.com>
 <ZrXokj7du0YgRHpz@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZrXokj7du0YgRHpz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 9/8/24 11:59, Daniel P. Berrangé wrote:
> On Fri, Aug 09, 2024 at 11:42:38AM +0200, Paolo Bonzini wrote:
>> On Fri, Aug 9, 2024 at 11:30 AM Philippe Mathieu-Daudé
>> <philmd@linaro.org> wrote:
>>>
>>> On 9/8/24 00:30, Octavian Purdila wrote:
>>>> On Thu, Aug 8, 2024 at 2:56 PM John Snow <jsnow@redhat.com> wrote:
>>>
>>>
>>>>>> diff --git a/configure b/configure
>>>>>> index 5ad1674ca5..811bfa5d54 100755
>>>>>> --- a/configure
>>>>>> +++ b/configure
>>>>>> @@ -956,7 +956,7 @@ mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
>>>>>>    # Finish preparing the virtual environment using vendored .whl files
>>>>>>
>>>>>>    $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
>>>>>> -     ${source_path}/pythondeps.toml meson || exit 1
>>>>>> +     ${source_path}/pythondeps.toml meson svd-gen-header || exit 1
>>>>>
>>>>
>>>> Hi John,
>>>>
>>>> Thanks for reviewing!
>>>>
>>>>>
>>>>> I haven't read the rest of this series; I'm chiming in solely from the build/python maintainer angle. Do we *always* need pysvd, no matter how QEMU was configured? Adding it to the meson line here is a very big hammer.
>>>>>
>>>>
>>>> I think the minimum we can do is to install it only if CONFIG_ARM is
>>>> enabled. That might change in the future if the models we create with
>>>> pysvd are enabled for other architectures.
>>>
>>> Similarly on how we manage libfdt, you can have meson defines
>>> SVDGEN as:
>>>
>>>     config_host_data.set('CONFIG_SVDGEN', svd_gen_header.found())
>>>
>>> Then declare SVDGEN in Kconfig.host, and finally use in the Kconfigs:
>>
>> That would force people to install pysvd on the host, which is a pity
>> for such a small and little-known library.  We have used submodules
>> in the past for much larger and common dependencies, for example
>> capstone.
> 
> As mentioned elsewhere in thsi threads, IMHO we shoud not be running
> this generator during the build at all. It should be run once to
> create the headers needed for a particular device & the output committed
> to QEMU. There after any changes to the header (if any) need reviewing
> to ensure they don't imply an impact on guest ABI. This avoids having
> the 8.6 MB XML file in QEMU git too, as well as the pysvd dep on the
> host. Only the very rare times when we create a new device would need
> to have the pysvd code & XML.

OK, fine by me, as long as we don't end in a similar use of dtc where
we use distrib dtc to rebuild outdated dts and emit a bunch of pointless
warnings cluttering the build output and that nobody agrees how to fix.

