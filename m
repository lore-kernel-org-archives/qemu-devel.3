Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E66C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 13:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5PjB-0006Gu-I5; Thu, 17 Apr 2025 09:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Pix-00068R-QS
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:56:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Piu-0006DC-L6
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:56:15 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so481573f8f.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744898170; x=1745502970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SQxKsIVpAWzrbFCxo1OnimVyigMC/NcQCKrmW9IV/SA=;
 b=xXmwo1qjNz+Bw2foRp9VI4TeT3XACTrCiBBAFXzRmG6eKI4GhoRopdrmBfREJCl1GN
 aakg5BUE9fdvFfNF2n53vTggLkL2D5YrV3JfBirnb9k8XKnnDDNK/XdRM10uG8nnY5KE
 6C8Y6qFtBg4VcKp9Sxynz0mThzc/lMigcnFDfBilj/MqjFNuBMLNcDyil+1sOiU8UWkG
 yVxhvTBtYWhkBb4IduBMHIzTnYUprP8ljNbTk68NnUmVF4oYL3dbDxPoGP7J0lOoFzBi
 lirSwE/frMyA2AgGNzE+4RLtAGO1PfnwR3M0QDJHHEDAN5DWGGcfnIUn41MGAgaENF+E
 aSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744898170; x=1745502970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQxKsIVpAWzrbFCxo1OnimVyigMC/NcQCKrmW9IV/SA=;
 b=bNxKZdzJosbePi7RuvByKkeN6B694T/tCpZhvdUWsoWMcf1t1qQcZuay5Was7YaidO
 v05DXiWcX03GdHAszu0Ry98M4EzBXikW1LRlPkFdegIrHMbe1FXz7fWKpMy5m0bORyoC
 Qndg1SdpUVmbiP4FqYIRF4fW6Tp1cRLssAzKTAFQOmlDWW8HyyySk8+loNOrzwFRsGxB
 ElYjFarmebvGhbR0alOt4FSJMSuTZ7FpiYIHEwq018ybs+n8kHgs85lZaniU5ZmnBUZn
 S8M8n547RRNCludZ7cirMjglWSkubxJFelUCu9H3ZS28KqNA5Zj2JPRN8J62XabZXLZA
 VHaw==
X-Gm-Message-State: AOJu0Ywg4LuaH14PFmXWxDqeW8HPpYYFAMgSD/2qEt0apHyfIjw2g45v
 ZiM88H+73wQeQbN6L3E7UN7Q8+lN4L9FCKi1y1oD0A7BBerQQkYZVWd9FjsZsy8=
X-Gm-Gg: ASbGncv6cLd7X44H85Wu3F6Jid74YpkT9mCBfbA4Zt5kaT/ZDmJu8W4C6MdzjYEkk/y
 lT60BstCvM8ST/6gNm0WOD+zDXCQxLVa3Vh1irqBELg3c6xiNN9vHOTlnk2jZqtt6D2xQGdOgdp
 FHWhtM4XKjodxFHAk1MaZkgMI4FrnI8bp6gEu27wjrd0SEI/coDMbGw917j6dzU1uFNFKjmQlBb
 uonXUEpQN4sSTxb3BnX1LSG1c8H9rRPgZT66a/TcIPPX9ALMKB1HimraiM1EklQkBG+a/nI3GDI
 7HeN8oRvyaF6pgbw7jztYt46ing+PAYtFX/QXcyAbHMg9a8+IA9DkbTQcjeqLiAS+jbYQ7wR17E
 Bh7YxLEnaCOHRUgnbzC8=
X-Google-Smtp-Source: AGHT+IHAl+1gpmURUVh/ZfDWBkoUBisQQzQNhkKHwhDyHhH3EtbRMzxHIoNYpl3OkovJZ0fTYrBrZw==
X-Received: by 2002:a05:6000:178d:b0:39a:d336:16 with SMTP id
 ffacd0b85a97d-39ee5b35e55mr4622081f8f.34.1744898170028; 
 Thu, 17 Apr 2025 06:56:10 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445713sm19982721f8f.85.2025.04.17.06.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 06:56:09 -0700 (PDT)
Message-ID: <c9f6cb76-67ce-4631-a8e8-13c7625a1138@linaro.org>
Date: Thu, 17 Apr 2025 15:56:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/8] smbios: Fix buffer overrun when using path= option
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Valentin David <valentin.david@canonical.com>,
 qemu-stable@nongnu.org
References: <20250408185538.85538-1-philmd@linaro.org>
 <20250408185538.85538-2-philmd@linaro.org>
 <CAO8sHcnLO8L_iYhzaQ3UBvpm_NTPpKe-AyNijJkdf-X9zRo6GA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAO8sHcnLO8L_iYhzaQ3UBvpm_NTPpKe-AyNijJkdf-X9zRo6GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Hi Daan,

On 17/4/25 12:11, Daan De Meyer wrote:
> CC-ing qemu-stable again to hopefully get this backported to the
> stable branches.
> 
> Cheers,
> 
> Daan
> 
> On Tue, 8 Apr 2025 at 20:55, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> From: Daan De Meyer <daan.j.demeyer@gmail.com>
>>
>> We have to make sure the array of bytes read from the path= file
>> is null-terminated, otherwise we run into a buffer overrun later on.
>>
>> Fixes: bb99f4772f54017490e3356ecbb3df25c5d4537f ("hw/smbios: support loading OEM strings values from a file")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2879
>>

If you want to be sure a commit is noticed for backport, you
should add

    Cc: qemu-stable@nongnu.org

in your commit description.

Regards,

Phil.

>> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Tested-by: Valentin David <valentin.david@canonical.com>
>> Message-ID: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/smbios/smbios.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
>> index 02a09eb9cd0..ad4cd6721e6 100644
>> --- a/hw/smbios/smbios.c
>> +++ b/hw/smbios/smbios.c
>> @@ -1285,6 +1285,9 @@ static int save_opt_one(void *opaque,
>>               g_byte_array_append(data, (guint8 *)buf, ret);
>>           }
>>
>> +        buf[0] = '\0';
>> +        g_byte_array_append(data, (guint8 *)buf, 1);
>> +
>>           qemu_close(fd);
>>
>>           *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
>> --
>> 2.47.1
>>


