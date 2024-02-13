Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9573BC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZtGd-000328-PX; Tue, 13 Feb 2024 08:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZtGc-00031t-M4
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:56:10 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZtGY-0008HC-G5
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:56:10 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6de3141f041so736212b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707832565; x=1708437365;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mKbbzcaeSgyj08ssfRFB7RfOAKBATPBt+2xzDKFGFV4=;
 b=lbJqzOErTFF+chh6Q+9Knh8Whv+nOCdiXHXbM5AuJXnsBM5OwyiKltUzzvsLrbYPFX
 TI3qd3YM/oV/XEuI1F3dMgbv6QdOI4WNDHSwB+tN0n++I3CYD2ZVn+AxW7j+E6GH3yVD
 yWIWOEqrQhOTxB+gAf/GDL7+rki/kOm/G5cF3SJxHgEGxADG+XWZb8TF+A9cqlDEVtb7
 AX3KmslwWdA4iAVrSAxOrlB43iT5pcxSJaSFCuw8MZa2a+FBgMrgYknqCvrOWvMs/zMa
 IgHqY9ExEx3TFaHAfcsOIYnjWojdCEQZNU85JhXMf3xsUCltHJHDAqA9aw5QMAMBSYWm
 Q6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707832565; x=1708437365;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mKbbzcaeSgyj08ssfRFB7RfOAKBATPBt+2xzDKFGFV4=;
 b=kiSWMp6HQ9dsbUM0Nnq6304lmiaqrmOQvjReE5ldyo9yIbA9/cMpfhFnY8IP6zd9Q+
 vL79MhnrLH+xHB0Naw0TFhUnl8MdwvF82BO5mPl4Hgvko8W5V0FVfzLLcVtlaeFm0C7Z
 yejFrMat4HGfpuGvLob8MNSGBGha9Z+ZVPj0qrMUrq7XNzXfmoWLl5ol6ao1rOIh5Mmw
 HNXYWG8kyaMX2UnXE33vmvNUMsE4jJU9WNwksfDlqpwgzQFOQmA/UjkIZFFWSzsK5Z4B
 igwp/aQB0WpIT/t8NFtRYZy6OyV2YGAlnzg/hmrwXkyqvLfCsXvypqvhPD/SdRBsgFY5
 ICOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw2jNeHKbRg3/qf2S8Fvq9ovMnuuuq/IEaUEoFF9NyV7U5VOH5nXQLrK0KFnpJOLYRnl6ITydyFTfhjYo++HPxHIADiuM=
X-Gm-Message-State: AOJu0YzYReVRsc4Dkqp1sMtyv6ww5rZ1QPlhXBVPGf1M533s8h4HEH1D
 /CcVWYus+ip6p96oEcojdNxTyYI5eg2ow+MZmo/HUt11d48l5hLTU8J5WhyYJuk=
X-Google-Smtp-Source: AGHT+IFNI1Sa6TRpyAsgLzFOLjIHj6GCWljJhZ1YFHaY+QvauiE8tDYjmHyrie7+gUGux6VER9DnWw==
X-Received: by 2002:a05:6a00:1825:b0:6e0:50c0:11e3 with SMTP id
 y37-20020a056a00182500b006e050c011e3mr11065702pfa.31.1707832564060; 
 Tue, 13 Feb 2024 05:56:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVLpXfS0P+gWJbkfFq+tA/gB8LeazUjU1tq+3ZzlyLP33WO7qmTzsQ3xqTGnVB5bYfxTw8eenDNeiXQ73AWWqmv/KYls80/K2mwCRtGUrCsghNdp1qHgfnGdoZ7Jew0DFASa99/HGshi+grhdu1SiOtK0jmcmpgHtixUkfpQ5MREXYHFxdf1aDklc4+0CPrh4t++vW8M46HwYPj5ydJFI8=
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a056a00139000b006e0404f419dsm7493924pfg.125.2024.02.13.05.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 05:56:03 -0800 (PST)
Message-ID: <473b44a0-8324-4ffa-ae4b-0de97c3c983c@daynix.com>
Date: Tue, 13 Feb 2024 22:56:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
Content-Language: en-US
To: Marek Glogowski <smarkusg@gmail.com>, Rene Engel <ReneEngel80@emailn.de>
Cc: peter.maydell@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20231217-cocoa-v7-1-6af21ef75680@daynix.com>
 <ad45a3b3201a6c9b24138abf2174946b@mail.emailn.de>
 <d73b8c8e-fde3-49e6-88b8-8f9bfa248509@daynix.com>
 <71895f08af8ba9f01dd78da158005229@mail.emailn.de>
 <2a775be4-363a-4e85-ae32-97ceb5927e11@daynix.com>
 <DB8CB49B-092F-4620-B8AE-67ED92059544@gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <DB8CB49B-092F-4620-B8AE-67ED92059544@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/20 5:06, Marek Glogowski wrote:
> Hi
> 
> For me, the problem does not occur if you use the maximum screen 
> resolution available.
> For me it is 1680x1050 - everything works fine.
> When I change the screen preference to a smaller screen resolution than 
> my maximum (1440x900,1024x768 ...) the mouse starts to malfunction. The 
> mouse pointer works strenuously and with a delay.
> 
> Checked on the current version with git qemu-system-ppc AOS4 with V8 and 
> V7 patch and the older version qemu-system-aarch64 Linux/Fedora

Hi,

I have just sent v9. Please see if it improves the situation.
https://patchew.org/QEMU/20240213-cocoa-v9-0-d5a5e1bf0490@daynix.com/

Regards,
Akihiko Odaki

> 
>> Wiadomość napisana przez Akihiko Odaki <akihiko.odaki@daynix.com 
>> <mailto:akihiko.odaki@daynix.com>> w dniu 19.12.2023, o godz. 13:12:
>>
>> On 2023/12/19 0:07, Rene Engel wrote:
>>> --- Ursprüngliche Nachricht ---
>>> Von: Akihiko Odaki <akihiko.odaki@daynix.com 
>>> <mailto:akihiko.odaki@daynix.com>>
>>> Datum: 18.12.2023 08:59:41
>>> An: Rene Engel <ReneEngel80@emailn.de <mailto:ReneEngel80@emailn.de>>
>>> Betreff: Re: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
>>>> On 2023/12/17 18:46, Rene Engel wrote:
>>>>>
>>>>> --- Ursprüngliche Nachricht ---
>>>>> Von: Akihiko Odaki <akihiko.odaki@daynix.com 
>>>>> <mailto:akihiko.odaki@daynix.com>>
>>>>> Datum: 17.12.2023 07:25:52
>>>>> An: Peter Maydell <peter.maydell@linaro.org 
>>>>> <mailto:peter.maydell@linaro.org>>,  Philippe Mathieu-Daudé
>>>> <philmd@linaro.org <mailto:philmd@linaro.org>>,  Gerd Hoffmann 
>>>> <kraxel@redhat.com <mailto:kraxel@redhat.com>>,  Marc-André
>>>> Lureau <marcandre.lureau@redhat.com 
>>>> <mailto:marcandre.lureau@redhat.com>>,  Marek Glogowski 
>>>> <smarkusg@gmail.com <mailto:smarkusg@gmail.com>>
>>>>
>>>>> Betreff: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
>>>>>
>>>>> Tested-by: Rene Engel <ReneEngel80@emailn.de 
>>>>> <mailto:ReneEngel80@emailn.de>>
>>>>>
>>>>> This patch now works with the "option zoom-to-fit=on/off"
>>>> thank you very much.
>>>>>
>>>>> But there is severe mouse lag within Cocoa output in full screen. You
>>>> can reproduce the problem by using the mouse very slowly inside the 
>>>> machine
>>>> where the mouse pointer no longer moves (guest). This issue only 
>>>> occurs with
>>>> Cocoa edition SDL/GTK works without mouse lag within the machine.
>>>>
>>>> I can't reproduce the issue. Is it a regression caused by this change or
>>>>
>>>> an existing bug?
>>>>
>>> I'm not sure how to reproduce it, but when I compile Qemu from master 
>>> source, zoom-to-fit for cocoa output is always active without using 
>>> your patch and cannot be enabled or disabled in full screen. Here the 
>>> mouse speed is about the same as under the MacOs host system.
>>> When using their latest patch series v8 for cocoa I can enable and 
>>> disable zoom-to-fit with "-display cocoa,zoom-to-fit=on/off 
>>> -full-screen" but the mouse speed then becomes slower. I'm not sure 
>>> what changes there were from Qemu Master where part of their patch 
>>> must be included, unless someone else has added something similar for 
>>> Qemu Master.
>>
>> Can you tell me your whole command line and guest operating system?
>>
>> Regards,
>> Akihiko Odaki
> 

