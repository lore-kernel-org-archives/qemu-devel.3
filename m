Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEB9C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 18:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj1Ry-0007f3-Q2; Sat, 09 Mar 2024 13:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj1Rw-0007eJ-KN
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 13:29:36 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj1Ru-0002D9-N0
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 13:29:36 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5131c48055cso3476435e87.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 10:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710008972; x=1710613772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MQLfKzox0LylrQcC/ff7e41doMo+4bqjXiBE4hhr1pU=;
 b=WOK+nSkOR1ZASFPWTuBLcn4uS2BZEI+DsPL7rx7LLak/99Q3Gq7uQ0OfdoZUhTHVTa
 XThty1BeoxvVLdtE90uf06BhJl8TWeCqyuswAkP18polsg88fLWa0S/VREpedHps6OQ+
 SDKUCHoOLJKF4+N65fD3Bqr1ILL5W8mfne5KgO2Jxj+EhA7GW91/Nd4doS6fjP5h6/kW
 b+koAu4mYnuu7lU/bfxPDcUklRxksZHlwSg0fnt8wmczUoplJgby5xu/8IE3aVIIA6nI
 ujmI/jx0oBhw0DmR4BYBZDk0NNzaPXDI4uwHSM/Mb4E/iTWwZrbtaElpCzIy0mqvc9Lj
 0Zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710008972; x=1710613772;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MQLfKzox0LylrQcC/ff7e41doMo+4bqjXiBE4hhr1pU=;
 b=HnYbvRhbkw2lOshWRUumQhPUZV2EX7/+gSuRafJz3+YzCtobxSC52spGlVlviRrokr
 ONlbkhULgmlRMb/hhJ/CL8KD9rD5Ek1RiXesu4u0snjU887VbrxgQ5gV9r5ap3vSW0mw
 PJxiqmSaFc+X4Gu8caJkbfPOHtqOgSdhxSEoYikNScUcW4p1dvemWZRMfEVZvBkjcFsA
 3T3CgAAe9bW7pOrttV2yOZRMV0aI2XM3D6UhqcW0KogRHiKCSx3hE2O18WwF7s8U1PoB
 +Tb8w2y+8sVG3I5YD3eVd0HUVi7nj5vdKOY3ivTWCZY1g5F53w2ygOhxBtgLtVxJACbc
 tacA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWggv1R65jRZ1l0KUed7qt8rirXz60VH/nNVxaB9F+K6v1xhq/kuPJomZrh3kR2QyrCRroDcbAa4K9KOue8H53YbUCEJoY=
X-Gm-Message-State: AOJu0YzYYN11nBmBK49Bfh42nW5EEo3vfGtZkrauEmaZnfe/xo2UkdAE
 mQWorVtzYYp2BL/1wnhjmrcd3psu/0UurQh3mDdVNXuuPDJ00tUkZEOHxj4fxFc=
X-Google-Smtp-Source: AGHT+IHdo3kLqgzSDF8SfsCyouROPfHHgXPea6zfqA1b/ABxrv1hg5ylnZWvu+LMIbxZQOzd4wllDA==
X-Received: by 2002:ac2:5f8b:0:b0:513:2004:43e4 with SMTP id
 r11-20020ac25f8b000000b00513200443e4mr1516769lfe.36.1710008972025; 
 Sat, 09 Mar 2024 10:29:32 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 cf12-20020a0564020b8c00b005664afd1185sm1102837edb.17.2024.03.09.10.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 10:29:31 -0800 (PST)
Message-ID: <f31b2eaf-aa04-46ed-995d-67c785be167f@linaro.org>
Date: Sat, 9 Mar 2024 19:29:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/conf.py: Remove usage of distutils
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20240304130403.129543-1-thuth@redhat.com>
 <CAFEAcA8rac2nEzrVWUWfRHAWYLmC6dSDMK=j6msD_SdPpn6ZtA@mail.gmail.com>
 <3262c873-b845-4286-a71f-a53b96bbc8a9@redhat.com>
 <ZeYNQdqW2bBA4gNL@redhat.com>
 <86d80d62-8c82-4ec5-ab67-50c83041f979@redhat.com>
 <CAFEAcA8X6hR+GfnREQkWNqiOBk40r4o_dWPOiyfVT3n7YJqRVA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8X6hR+GfnREQkWNqiOBk40r4o_dWPOiyfVT3n7YJqRVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

On 9/3/24 18:27, Peter Maydell wrote:
> On Tue, 5 Mar 2024 at 10:39, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 04/03/2024 19.04, Daniel P. Berrangé wrote:
>>> On Mon, Mar 04, 2024 at 06:11:58PM +0100, Thomas Huth wrote:
>>>> On 04/03/2024 17.56, Peter Maydell wrote:
>>>>> On Mon, 4 Mar 2024 at 13:04, Thomas Huth <thuth@redhat.com> wrote:
>>>>>>
>>>>>> The macOS jobs in our CI recently started failing, complaining that
>>>>>> the distutils module is not available anymore. And indeed, according to
>>>>>> https://peps.python.org/pep-0632/ it's been deprecated since a while
>>>>>> and now likely got removed in recent Python versions.
>>>>>
>>>>> This doesn't seem to be sufficient to fix the macos CI:
>>>>> something in glib seems to still be using it.
>>>>>
>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/6313212803
>>>>>
>>>>> [281/6553] Generating ui/dbus-display gdbus-codegen with a custom command
>>>>> FAILED: ui/dbus-display1.h ui/dbus-display1.c
>>>>> /opt/homebrew/Cellar/glib/2.78.4/bin/gdbus-codegen
>>>>> ui/dbus-display1.xml --glib-min-required 2.64 --output-directory
>>>>> /private/var/folders/xc/tpssff9959345bnqq4c6tlww0000gn/T/cirrus-ci-build/build/ui
>>>>> --interface-prefix org.qemu. --c-namespace QemuDBus --generate-c-code
>>>>> dbus-display1
>>>> ...
>>>>> ModuleNotFoundError: No module named 'distutils'
>>>>
>>>> Looking at the glib sources, I think this has been fixed here:
>>>>
>>>>    https://gitlab.gnome.org/GNOME/glib/-/commit/6ef967a0f930ce37a8c9b5aff96969
>>>>
>>>> The fix will be in glib 2.79, unfortunately homebrew still seems to use glib
>>>> 2.78 ...
>>>>
>>>> We could maybe temporarily work-around the problem by disabling the dbus
>>>> code in the CI job? Or just wait for homebrew to update the package?
>>>
>>> File a bug against homebrew. IME they are very quick (1-3 days) at
>>> putting out fixes for things like this, especially if you point them
>>> to the upstream solution.
>>
>> Ok, while I was writing my mail, I was looking at https://brew.sh/ and
>> didn't see a link to a bug tracker there ... but now I realized that they
>> are simply using the github tracker, so I went ahead and filed a bug there:
>>
>>    https://github.com/Homebrew/brew/issues/16823
>>
>> Let's see how it goes...
> 
> Seems to be going slowly. I notice that there's a comment in there
> saying that "brew install python-setuptools" is a workaround to
> get glib 2.78 working -- that seems like it would be good to get
> our CI back to green. Is there a way to test changes to the cirrus
> config short of committing it and seeing if it helps? I don't see
> the jobs available on a pipeline in my personal gitlab repo...

Yes, but you need to grant cirrus-ci some permissions you weren't
ready to give last time.

I just tested it and it is still failing for me:
https://gitlab.com/philmd/qemu/-/jobs/6357526794

