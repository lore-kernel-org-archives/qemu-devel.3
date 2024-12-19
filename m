Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94098E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFx-0001uE-PV; Thu, 19 Dec 2024 11:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIjD-0006A1-JN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:46:21 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIjA-0005jX-TG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:46:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361f796586so10318315e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734623173; x=1735227973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PFwqffTv02ZYUG0MVvVJxxrWJp2AA0cvxQbEUnc37oo=;
 b=v5JWlHAQEpGoI3nohzXfZzoRxO+m4FG5BMU3gMHkIGCnQCaO3ZS/sstm6j4FDegcRL
 ndEdavdrNKdtmj2GTuA9loGIImLCWnGpx8QU1B0KsxyoITBSOT4b/8oUNqqrQ4CoGo0e
 wYHqvsjsTpOz26NF7nNnMNikK2oPVRFyBqtwX6GZlxTFlxU/O1/Sah32D8PDwG2NWjbd
 Ry/ulnx1vbxBBh+uI+IpXT1Sw/pKtvLHX1pV4Fp0gyrvGQnh4VUIEAjImnRvnBB09t0n
 wsl046s31rCKI/tRUa6G0Yr8bOUpC6sosCVi/Tss03Xe9qkzOBdzaNc/7leqLW3dqB/n
 qmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734623173; x=1735227973;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PFwqffTv02ZYUG0MVvVJxxrWJp2AA0cvxQbEUnc37oo=;
 b=PJofdSxvb6hRMVT6emnJS5+uzmaUmTgMR5OjiQBBO8U7UrT/G0XhUTdgOvg40Ps6Sm
 brTag614CTvlCoPPqNQZ+H+ipxAbvAEkzpXlnqfce8URdNoLnP1Hwn0/4/7IA/4f/+zw
 or87jnzyAu1DvdKa3DkaMfRKTjjWs1DSrzRKDXHU+D7a5BhOUG6bj5wLZ66ESa0UIQWE
 0yi1wR0gwJmO5I61XqF1keAZNfSlcROIir1igHWz0DzXy3z+m+avdxkuDWjD6TVUfnML
 TsbDAvfBEScwwuEOMMYv91WpJkSdHd2brkiZ/wfd+m8oEP6IPfbPOA7wrzB/AunahzZy
 UYUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtwwEKx7Q1+bWgpbFBS1jDkqKuYHyFnzeMJ93rOlhrb1Kjj7un6fgdp6KoYlaau8Kxs/BJMhE+5wRO@nongnu.org
X-Gm-Message-State: AOJu0YzfwuCRf1CCv2dBMfs3y+EXs7Ja475d22O4esa16PYTvjbt67eu
 yclW7l9OkhZI3GSAyyrJJJVJAhaK8QGs2C1p+nux5c5O+LO1G/C4rbrxg+WYz52gDfeTPHhk4hD
 y
X-Gm-Gg: ASbGncu770sVHRefTsUKS/Nqt89Wok8EK3ncgV9RuS53xC9SHtDKWhKqDGFnjrndqm1
 vpMx5eBZZtBPCS35kQ65xDnvGV+OkI0W45+M69PYOB/kYvf/1wYrlV1Cfq45uyy4ivfUMkzAEW0
 +xv7h3cTfiYuNtu0PEIaXkAtNFPHlVVBJtX9NOxT7Z0pAkzXm5aAAvcdrYiVGj5UCFHubyGTeT/
 Yk3FvIfRYj8UDc1THIuqaPGyQgRC9IjbeLkUyN9Oyt1baE6tgUV1M+W0cWIs6m4yOQ7yVA=
X-Google-Smtp-Source: AGHT+IEntmYhCb3kfKaK+4ll/QAOcBgvnf4uUl98DAicai1tnL+Q5bddv0KHi6to9K4Ks4O2Qs4ofg==
X-Received: by 2002:a05:600c:2151:b0:434:ff45:cbbe with SMTP id
 5b1f17b1804b1-4365c793a5fmr38147495e9.18.1734623173420; 
 Thu, 19 Dec 2024 07:46:13 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661289995sm21046845e9.36.2024.12.19.07.46.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 07:46:12 -0800 (PST)
Message-ID: <3cdc20da-2b66-4488-a073-7225b6e5d83b@linaro.org>
Date: Thu, 19 Dec 2024 16:46:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <61096f4d-7b5f-48fd-9840-caf058db2201@linaro.org>
 <2933CCF9-F9D6-46D1-9658-07B85104011D@redhat.com>
 <6eed1b13-f41a-4590-8254-dbfb1f9c7a5b@linaro.org>
 <CAMxuvawa3G_G4DvSNdF_y2anTtte0ayVaANsvo9Gh_TKP3bEbA@mail.gmail.com>
 <CAK3XEhPu1mg3KWWDViw0bSQHq=+wxmB0ZDu=Yf7-Z2889sW=yg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAK3XEhPu1mg3KWWDViw0bSQHq=+wxmB0ZDu=Yf7-Z2889sW=yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 19/12/24 15:07, Ani Sinha wrote:
> On Thu, Dec 19, 2024 at 6:25 PM Marc-André Lureau
> <marcandre.lureau@redhat.com> wrote:
>>
>> Hi
>>
>> On Thu, Dec 19, 2024 at 2:03 PM Philippe Mathieu-Daudé
>> <philmd@linaro.org> wrote:
>>>>>> +static const TypeInfo vmfwupdate_device_info = {
>>>>>> +    .name          = TYPE_VMFWUPDATE,
>>>>>> +    .parent        = TYPE_DEVICE,
>>>>>
>>>>> What is the qdev API used here? Why not use a plain object?
>>>>
>>>> I wrote this taking vmcoreinfo device as starting point. I will leave this as is for now unless anyone has strong opinions.
>>>
>>> We shouldn't blindly copy/paste & spread possible design mistakes.
>>>
>>> Marc-André, any particular reason to implement vmcoreinfo using qdev
>>> and not plain object?
>>>
>>
>> I don't remember (damn 8y ago..). It seems the design changed over
>> time during review, qdev might have been necessary and stayed this
>> way.
> 
> I changed it to TYPE_OBJECT and we get a crash here:
> 
> #3  0x0000aaaaab207a48 [PAC] in object_class_dynamic_cast_assert
>      (class=0xaaaaac608880, typename=typename@entry=0xaaaaab4b9630
> "device", file=file@entry=0xaaaaab4300d0
> "/workspace/qemu-ani/include/hw/qdev-core.h", line=line@entry=77,
> func=func@entry=0xaaaaab595a90 <__func__.0> "DEVICE_CLASS") at
> ../qom/object.c:1021
> #4  0x0000aaaaaaec2d74 in DEVICE_CLASS (klass=<optimized out>) at
> /workspace/qemu-ani/include/hw/qdev-core.h:77
> #5  vmcoreinfo_device_class_init (klass=<optimized out>,
> data=<optimized out>) at ../hw/misc/vmcoreinfo.c:88

I believe you have enough knowledge to understand the concepts you
are mixing here. You can not change a type signature without
implementing its interface (which as you noticed, for QEMU is checked
at runtime).

> Basically doing this would be illegal for vmcoreinfo and we need to
> adjust the code :
> 
>     DeviceClass *dc = DEVICE_CLASS(klass);
> 
>      dc->vmsd = &vmstate_vmcoreinfo;
>      dc->realize = vmcoreinfo_realize;
>      dc->hotpluggable = false;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);

See the conversion:
https://lore.kernel.org/qemu-devel/20241219153857.57450-1-philmd@linaro.org/

> Anyway, for vmfwupdate, it is actually like a device with device properties:
> 
> +    device_class_set_props(dc, vmfwupdate_properties);
> 
> So I prefer to make it qdev type for now.

We have the opportunity to start with the correct model.
Consider simplifying our future (see what is required in
the suggested vmcoreinfo conversion). Except if you insist
and commit to do the vmfwupdate later.

