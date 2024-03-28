Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54711CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpspN-0008P5-6k; Thu, 28 Mar 2024 12:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rpspL-0008Oa-MQ
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 12:42:07 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rpspJ-0003rU-WE
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 12:42:07 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5684db9147dso1384240a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711644124; x=1712248924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fpd9QS0uZHxja51WY1hodu7BzxiGsU4OgNS0Zs2Y5HU=;
 b=CSsVe5SYmICIyPA1nHB5dDLtcXzdIBoUhP7qXFg8yAHDt509jLkd1/mGbLR1s/525J
 iMY6U8bAKA9lW8lpFL8Ppzezr19K4vuvto7Cie1aPCjINSFqBqamyVr0qPE9JXsvCf7W
 f0EcPldaOKDEG4dXsnrJjEbyF0Mn3XO//VhaH/cFHK7E3zpTh1oKI1GQj9CvCjtc++Ic
 6XXHLyo1p5NwRkzPhKELZe1vEoohm4xrCvyqKpEcGJ7P57ymAsD0NSvym1eEJFFQqr1F
 Nr0C0+pkn0O7XwSYr2a7rGCNsx8hHALnYlFSBFaGxyhAoir0jpO9NnpB1eaVQSU0FHpK
 TSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711644124; x=1712248924;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fpd9QS0uZHxja51WY1hodu7BzxiGsU4OgNS0Zs2Y5HU=;
 b=opdKpEQh4wPmmW5sKAdqM3N5i65si/PDuDQr7pcStRfPuomO1mj5hadVdiHbO1m8au
 9Kt7fOTqSHXaWrryGIVnREJ8omt1AQXoTwV95ZdXekJ+4+Tc+z9d8pXUyym33cB5oqB4
 QkxWn0m/gL9AB5go1nUhdKdfdBjMc1Du4+96cmnmH6oOce6agnrACQWJOxXEln1Fw1Rq
 hWjpMuFsTnJGoRxBoe32cCYYt85DkHHAwzFkutdQRAkLmCeNEo71sCXKAtibT/lqYH52
 N3EXIErIJI9gONnkEpZzAIwpRT2SvEN668q0Qk3hryfuPcBWvF2TeG6x8TsiUby1LPlC
 GYdg==
X-Gm-Message-State: AOJu0YyQA/UrQF+tIW+Xp/c+H1yuuPIUvLBza4GCghdlTeyhQvNkE+G5
 6M8w+XBTJvIkLePeAJAnfJHQkR+7fdMuzHWx5eDTn4TtLChZWiOdUNCKm3aCvgZ68Izav+S+k2B
 CT4oHDg==
X-Google-Smtp-Source: AGHT+IHsM52kCxqgEq5Yb+faPfJC9hnMDzVGRWbXBXYYYmRYg5ihQ4QUNP1L+F5uqNEh2/GeGSCfmw==
X-Received: by 2002:a50:ab5b:0:b0:56c:be3:7cef with SMTP id
 t27-20020a50ab5b000000b0056c0be37cefmr2534050edc.11.1711644124291; 
 Thu, 28 Mar 2024 09:42:04 -0700 (PDT)
Received: from [192.168.200.106] (83.11.22.169.ipv4.supernova.orange.pl.
 [83.11.22.169]) by smtp.gmail.com with ESMTPSA id
 q4-20020aa7d444000000b00568d6a20717sm1033490edr.52.2024.03.28.09.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 09:42:03 -0700 (PDT)
Message-ID: <19444e7a-f234-4f35-9a76-525430c7b9b1@linaro.org>
Date: Thu, 28 Mar 2024 17:42:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] docs: sbsa: update specs, add dt note
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20240326095819.1268062-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA_Hf_Ehk8Cc8kZGCO3niW_x18vwg4=JSFmYoFZOOTPzGg@mail.gmail.com>
Content-Language: pl-PL, en-GB, en-HK
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CAFEAcA_Hf_Ehk8Cc8kZGCO3niW_x18vwg4=JSFmYoFZOOTPzGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x52b.google.com
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

W dniu 28.03.2024 o 16:43, Peter Maydell pisze:
> On Tue, 26 Mar 2024 at 09:58, Marcin Juszkiewicz
> <marcin.juszkiewicz@linaro.org> wrote:
>>
>> Hardware of sbsa-ref board is nowadays defined by both BSA and SBSA
>> specifications. Then BBR defines firmware interface.
>>
>> Added note about DeviceTree data passed from QEMU to firmware. It is
>> very minimal and provides only data we use in firmware.
>>
>> Added NUMA information to list of things reported by DeviceTree.
>>
>> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>> ---
>>   docs/system/arm/sbsa.rst | 37 ++++++++++++++++++++++++++++---------
>>   1 file changed, 28 insertions(+), 9 deletions(-)
>>
>> diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
>> index bca61608ff..d4d1f2efe3 100644
>> --- a/docs/system/arm/sbsa.rst
>> +++ b/docs/system/arm/sbsa.rst

>> +Note
>> +''''
>> +
>> +QEMU provides us with minimal information about hardware platform using
> 
> s/us/the guest EL3 firmware/  (or whatever other term you want to
> use to describe the guest software that reads the dt).

Thanks, fixed.

>> +minimalistic devicetree. This is not a Linux devicetree. It is not even a
>> +firmware devicetree.
>> +
>> +It is information passed from QEMU to describe the information a hardware
>> +platform would have other mechanisms to discover at runtime, that are affected
>> +by the QEMU command line.
> 
> 
> Might want to say also
>   Guest EL3 firmware does not pass this devicetree on to later
>   components of the software stack.
> ?

This is a matter of what firmware stack QEMU user will run. TF-A (our 
current "guest EL3 firmware") passed devicetree to later components of 
the software stack. We just stopped using it in EDK2. But if someone 
would like to run U-Boot or other firmware then both SMC and DT will 
wait for them.

>> +
>> +Ultimately this devicetree will be replaced by IPC calls to an emulated SCP.
>> +And when we do that, we won't then have to rewrite Normal world firmware to
>> +cope.
> 
> I would drop the last sentence here, and use "may" instead of "will".

Done.

>> +
>>   DeviceTree information
>>   ''''''''''''''''''''''
>>
>> -The devicetree provided by the board model to the firmware is not intended
>> -to be a complete compliant DT. It currently reports:
>> +The devicetree reports:
>>
>>      - CPUs
>>      - memory
>>      - platform version
>>      - GIC addresses
>> +   - NUMA node id for CPUs and memory
> 
> Otherwise looks good to me, and the updates to the spec URLs
> are particularly helpful. As a docs change I'd be happy
> to take it into 9.0 (at least before rc2) if some other
> sbsa-ref-knowledgeable person wants to either review or ack it.
> (But it's also OK if it misses 9.0 and goes into 9.1.)

OK.


