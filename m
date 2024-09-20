Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599FDCF58E7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 08:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srYlC-0007kC-MW; Fri, 20 Sep 2024 04:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1srYl8-0007aw-Qr
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 04:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1srYl5-0004tb-R0
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 04:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726819974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KOSjewOQYz/+C1kS7b8ZI9NOSzU3ogo6JqPSzz1tQ8c=;
 b=bXeeRP9FAv4yHXH6WveCmqB6tLjQWs6O9YfPZRhEIDTr//bxVm0u53vvKIQZ+ibbI66z22
 y0TaQjAtEsV1TtSib11XIuCpv5iLejDh6PenP4ZM0spd0BQMm6eeDzYIddHMvufhmBlepD
 lhvjaJkv9uAKCWdecoVl2g2Zjd8zBAQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-venpxLR8NhGsRZTycR09bA-1; Fri, 20 Sep 2024 04:12:52 -0400
X-MC-Unique: venpxLR8NhGsRZTycR09bA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a8d26b5857cso130501966b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 01:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819971; x=1727424771;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOSjewOQYz/+C1kS7b8ZI9NOSzU3ogo6JqPSzz1tQ8c=;
 b=ofckpbAgAspphJBVqEFIawTHNITFH9eCtdbgti/Ego2DVf/uyIE/ic6Mh/Q+53RzsD
 s1vYIxo7g1ASDzNSenIKwG4IcAOIbe0MQjuADp6WT8hqpZKLyIJIGfhW/VQpX3dHiKHP
 t3cPb6sbx73tSA2XRn8nakiTS7eVqoRkSPq5wrel+lltXcd06HjlGG078ZUeHoS66Om0
 HAkTiRQJ8Gb2U86MFJ0r2WI65v4xJJdE9YL1B2dqVB+c5o1jMv48G3SIGUdApaLQm8of
 nst0FDkj6qsG5szoEkzGBvm4GLyXvyt+0FJtGNLvz2pPtleNw4jsl3DgbQHUxFbvoEFE
 i4+Q==
X-Gm-Message-State: AOJu0Yzf66zmQ3lFF+2Vngo58tvElCXZ97NRXQK+9YrFVDpn3V/5snma
 9r3OSvwwrTO4l2m81afUVvcz4sY9X+OK2N1En4HlBwBElc2gHa7vNLHmetcnvBts7O2a7XQPgAv
 YmXvq+ggf1HBaDMhCS+vogtB1eQ9859HXUxwMKXHwzDRPKyCUymMU
X-Received: by 2002:a17:907:f79a:b0:a8a:78bb:1e2 with SMTP id
 a640c23a62f3a-a90d55e0b9bmr175816766b.6.1726819970879; 
 Fri, 20 Sep 2024 01:12:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgNNYs11NWJ/QD+BXOqk5v2itiJ7Q8aZpTum1i4VHzfGs3e3qYj4u/XGz/0ahiE/hZvqQU0g==
X-Received: by 2002:a17:907:f79a:b0:a8a:78bb:1e2 with SMTP id
 a640c23a62f3a-a90d55e0b9bmr175814166b.6.1726819970519; 
 Fri, 20 Sep 2024 01:12:50 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-42-49-166.web.vodafone.de.
 [109.42.49.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612e5675sm810113866b.169.2024.09.20.01.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2024 01:12:50 -0700 (PDT)
Message-ID: <872ca5a9-2359-4a83-9031-8c82fcdb7665@redhat.com>
Date: Fri, 20 Sep 2024 10:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qemu-iotests/testenv: Use the "r2d" machine for
 sh4/sh4eb
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Magnus Damm <magnus.damm@gmail.com>
References: <20240917194350.429971-1-thuth@redhat.com>
 <87bk0ikauh.wl-ysato@users.sourceforge.jp>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87bk0ikauh.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/09/2024 10.06, Yoshinori Sato wrote:
> On Wed, 18 Sep 2024 04:43:50 +0900,
> Thomas Huth wrote:
>>
>> Commit 0ea0538fae516f9b4 removed the default machine of the sh4
>> binaries, so a lot of iotests are failing now without such a default
>> machine. Teach the iotest harness to use the "r2d" machine instead
>> to fix this problem.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/qemu-iotests/testenv.py | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
>> index 0b32eec119..6326e46b7b 100644
>> --- a/tests/qemu-iotests/testenv.py
>> +++ b/tests/qemu-iotests/testenv.py
>> @@ -244,6 +244,8 @@ def __init__(self, source_dir: str, build_dir: str,
>>               ('riscv32', 'virt'),
>>               ('riscv64', 'virt'),
>>               ('rx', 'gdbsim-r5f562n8'),
>> +            ('sh4', 'r2d'),
>> +            ('sh4eb', 'r2d'),
>>               ('tricore', 'tricore_testboard')
>>           )
>>           for suffix, machine in machine_map:
>> -- 
>> 2.46.0
>>
> 
> r2d is works only sh4 little endian mode.

Oh, that's interesting - since there is no other machine left for sh4/sh4eb.

> There was probably no other hardware that ran in big endian.

There used to be the "shix" machine, but it got removed, I assume that one 
worked in big endian mode, too?

Anyway, if the r2d machine only works in little endian mode, and there is 
apparently no other machine available anymore, I think we can disable the 
sh4eb target completely since it is of no use now? Or is there a reason to 
still keep it around?

  Thomas


