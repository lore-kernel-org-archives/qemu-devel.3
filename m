Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1F1CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rti3j-000228-Jx; Mon, 08 Apr 2024 02:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rti3R-0001sv-Tb
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:00:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rti3N-0004Q0-3R
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:00:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4165caf9b2dso7790265e9.1
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712556023; x=1713160823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l1LQJEiM3XFlw0rkdhi7ov39VLj61Y5z0yOEt2UGEyY=;
 b=qIytL9FImgsCxcFc8Yi+hOFH8I2NjiKNvjWZcbOYWYVmaTVTQDS4CAOb49Nk+/qfeD
 ywgamWp9PVITLQAzFfhyE/K6v9pzUj9MVv0rZ2tlkh/mwGty+Gi5gxWjiwTpAO9PIk5i
 8Ug+SbVBIP9shXYTYVEFL7L8sKXUG2yKBKIuhMijLRLReNWUiDInzVbbTHDqpGijzSdL
 he6gFIIXOXNlEWKBtUU2fsKWaybEcrvLpx2vG69CRBv3uHKLqN6lUjPznM+jJVxATx83
 gKClf2rYFYC5JjpR7Veejnbqt7PVe/GltfXBbAECi9znXAbXo0fXtABq8uYXTIWQUWNz
 76PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712556023; x=1713160823;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l1LQJEiM3XFlw0rkdhi7ov39VLj61Y5z0yOEt2UGEyY=;
 b=Rj7YLrI/UYfMN/M0QYN94OUMhT8oRWEWzoGCNrpyJRK2/uF5uzh+eV1Jm0K4fbehlx
 574BenJ2A4CWeLazm4ocwCEEu01vYK/XNhR+L1xLkz+OYL2fKTAXdGXXsnbb25WJFLo1
 vZ0RIAwoKa/vaaHUYLDyumHrG5FGACetKlNWfsNHm0BDTP6aPn5DxOnGt2z2ioxKNKxY
 wiYQbzx173rG8kLrxbLduts6tTZXKRqSn5J0nAYC9d1qZX6WICxYcNMEJXNpKjQU8Hp5
 idZLW7SbxsSXfcm/kDlEiryyxtiOUiq+heKxEEEdJb+Y5iFr842QPs0FTkdajj7RlUzL
 rtYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuOOBOjSXgSX/dh/vF8doPiEPB9D1tnj1iYDKQMr+VhuVyrfe8dy5JT+LsiOYrXHZ+VrgwGmhXVAY/Ybr6zJOvHiMCnDk=
X-Gm-Message-State: AOJu0Ywf12JmRAyJJ0f7woqVElDEl8LVuEBuGwG99YkPPFTXfjCXjqG8
 KVQqn5fEPeIaOwodViMrbnPsvMS94j5Jx+EHHJYHHaZm3m6Aw/Zw9SMw6P1IyeiCOJN6E/CKhix
 L
X-Google-Smtp-Source: AGHT+IHjQwUrLbVry/n0t7ITqXoJHP9QCKAXoYAHSUdgInX0dLFwDQX42CPXmtNczkD0/rD/iSfVbQ==
X-Received: by 2002:adf:fc8a:0:b0:343:ba58:97c2 with SMTP id
 g10-20020adffc8a000000b00343ba5897c2mr6129078wrr.2.1712556022829; 
 Sun, 07 Apr 2024 23:00:22 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 r27-20020a170906365b00b00a47152e6d10sm3983618ejb.134.2024.04.07.23.00.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 23:00:22 -0700 (PDT)
Message-ID: <7dc08fb0-9013-46b6-ba16-01cbdb0733c3@linaro.org>
Date: Mon, 8 Apr 2024 08:00:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 6/7] hw/core: Move reset.c to hwcore_ss[] source
 set
To: Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20240404194757.9343-1-philmd@linaro.org>
 <20240404194757.9343-7-philmd@linaro.org>
 <f96cb1da-09ea-4708-9616-bc2560d63d5f@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f96cb1da-09ea-4708-9616-bc2560d63d5f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 6/4/24 00:44, Richard Henderson wrote:
> On 4/4/24 09:47, Philippe Mathieu-Daudé wrote:
>> reset.c contains core code used by any CPU, required
>> by user emulation. Move it to hwcore_ss[] where it
>> belongs.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/core/meson.build | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/core/meson.build b/hw/core/meson.build
>> index e26f2e088c..1389f1b339 100644
>> --- a/hw/core/meson.build
>> +++ b/hw/core/meson.build
>> @@ -3,7 +3,6 @@ hwcore_ss.add(files(
>>     'bus.c',
>>     'qdev-properties.c',
>>     'qdev.c',
>> -  'reset.c',
>>     'resetcontainer.c',
>>     'resettable.c',
>>     'vmstate-if.c',
>> @@ -16,6 +15,7 @@ if have_system
>>     hwcore_ss.add(files(
>>       'hotplug.c',
>>       'qdev-hotplug.c',
>> +    'reset.c',
> 
> This patch would seem to obviate the previous?

No, hwcore_ss[] is used for both system/user.

As its name suggests, "sysemu/reset.h" is system specific.
We don't want to compile its definitions and link them to
a user-only build.

I can squash both if it makes it more obvious.

Regards,

Phil.


