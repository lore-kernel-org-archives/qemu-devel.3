Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE5CC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUqb-00046A-Vi; Wed, 22 Jan 2025 02:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taUqU-00042f-8h
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:08:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taUqS-0008CW-Iq
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737529690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+Zmshx/iq2URjE7xdp3QBu8evcKClfweGR4BGQPyaIc=;
 b=XQItJx/ZwLMGbwD6gKM4f2m9QWN/Kd6Kw580jot1HTCfEfntbzrCsDQwA+mtviTk9zpO/K
 3TX9WFBXsKXcFEn2JVaB7Xfzqc9IIYh94woE5gpconKjjpactETaVhMvvoljAom8dyt5Cp
 pjCKV3ZbquPwe+e7sYNvtIM8lzG7oTw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-WhSGnXGXO82Cy8OS__1UQw-1; Wed, 22 Jan 2025 02:08:07 -0500
X-MC-Unique: WhSGnXGXO82Cy8OS__1UQw-1
X-Mimecast-MFC-AGG-ID: WhSGnXGXO82Cy8OS__1UQw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385dcae001fso2893808f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 23:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737529686; x=1738134486;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Zmshx/iq2URjE7xdp3QBu8evcKClfweGR4BGQPyaIc=;
 b=KZ2Od4PBjWIdLGjd2wu8j0+BQjXu/FAljTHuiTYacqbkJGpQOBgrHtPn7oPOFdZ5KU
 N8smo6JGOe1AHgBanHHx6A2pAwJ0wDZTgHjR2LhsrXYPxGjt1732QdmVnYI7m6GPKO1g
 KwUwsREKYHton7vycYztuEkiWc2k4zWEdLQOQcHBbsM9KnHinzQz5tEk1ybeKExxCyJy
 VaakKju5O0Zvwwg2Y6zR/slfafJSX5ThQTKB63AHPFZP8CAfUBM6lWu76nu9yQu6jDl+
 4vUge4MHQ1CDBvkfTYKwWWYUbgj8kJqP4ztLLEGlKnInMqOeRQs8bUtQxMwnKh0XP9ko
 V0Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQuH7Fsc0i5P824r0D+XBzJQ2jFxACBmQkpnJ42NLxKV+rs4lrWokEiZqteikuIFJpWph1WORILWJF@nongnu.org
X-Gm-Message-State: AOJu0YzV6B5TumVjwcDJ/WPyHSUAKtsne73GskZRPFaFI2Sr7GD2DArD
 z8UDrFK24A2d4PJS4AGTA2ZxPVLQ5fE05qRu8ozS3zPDEppyyWDgENcfSiQJUArctzXhLYuwS+w
 fITR/Mq0Lof8U9/wQnITLegm7p8X2BFVhxR+z5sG56R3hPsn18UMBkKu/hG0l
X-Gm-Gg: ASbGnctVcp0zSq1FRWDHDmt6EWjkbt+1PpDdImAsjwV/fLU/5VlOh7FQE9bzt9FbFqC
 4tBxqdM6gsAPU6nJYkLCPyav/zgUCvr1DV8o3A2EjuBtiTe627h20VKBlD1D+J85UmGKu3tqImY
 ygufsc5Vt7GkZZxhcc+3jmLLhEJ/8/vGnElqwgnDfOPbLlfhJmpSo4TR0Z8UsfiwQY3Qpi6Ul6N
 UHoL4EFKvY8T8AmPH17D/iS1gK17V1fKOt+mccl57FqoWYP4JHnF8j3jrK1z6suTuLrK+2mWiv5
 1gLeOU7iQ3sNFXCV5nzfuHOHDdAOUhVG
X-Received: by 2002:a5d:6b8b:0:b0:38a:8b2c:53ac with SMTP id
 ffacd0b85a97d-38bf57b3fe9mr12892497f8f.42.1737529686116; 
 Tue, 21 Jan 2025 23:08:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9rTcT36TbtQyczHoSQNvpmqhl57wT7Yfnxo5/zN9sXoEvGEIz2WETdsJal9b5w5htgzTC+Q==
X-Received: by 2002:a5d:6b8b:0:b0:38a:8b2c:53ac with SMTP id
 ffacd0b85a97d-38bf57b3fe9mr12892477f8f.42.1737529685772; 
 Tue, 21 Jan 2025 23:08:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322a859sm15156547f8f.43.2025.01.21.23.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 23:08:04 -0800 (PST)
Message-ID: <3bf8a71a-f2a8-41a8-bddc-45d220a953eb@redhat.com>
Date: Wed, 22 Jan 2025 08:08:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] aspeed: pre-PR for QEMU 10.0
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Steven Lee <steven_lee@aspeedtech.com>
References: <20250120095820.516511-1-clg@redhat.com>
 <SI2PR06MB5041DEDC7F75EA997D4ECCFDFCE12@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SI2PR06MB5041DEDC7F75EA997D4ECCFDFCE12@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/22/25 04:35, Jamin Lin wrote:
> Hi Cedric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Monday, January 20, 2025 5:58 PM
>> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: Joel Stanley <joel@jms.id.au>; Andrew Jeffery
>> <andrew@codeconstruct.com.au>; Troy Lee <troy_lee@aspeedtech.com>;
>> Jamin Lin <jamin_lin@aspeedtech.com>; Steven Lee
>> <steven_lee@aspeedtech.com>; Cédric Le Goater <clg@redhat.com>
>> Subject: [PATCH 0/9] aspeed: pre-PR for QEMU 10.0
>>
> Sorry, I do not see this patch series in the following links.
I guess the mailing list had issues when I sent it. Will resend.


Thanks,

C.




> Do I lost anything?
> https://patchwork.kernel.org/project/qemu-devel/list/
> https://patchew.org/QEMU/
> https://www.mail-archive.com/qemu-devel@nongnu.org/mail5.html
> Thanks-Jamin
> 
>> Hello,
>>
>> Here are the changes I plan to send as a PR for QEMU 10.0, this week or the
>> next. The last 3 patches still need a review. An Ack would be appreciated.
>>
>> Thanks,
>>
>> C.
>>
>> Cédric Le Goater (3):
>>    test/functional: Update the Aspeed aarch64 test
>>    test/functional: Update buildroot images to 2024.11
>>    aspeed: Create sd devices only when defaults are enabled
>>
>> Jamin Lin (5):
>>    hw/sd/sdhci: Introduce a new Write Protected pin inverted property
>>    hw/arm/aspeed: Invert sdhci write protected pin for AST2600 EVB
>>    hw/timer/aspeed: Refactor Timer Callbacks for SoC-Specific
>>      Implementations
>>    hw/timer/aspeed: Add AST2700 Support
>>    aspeed/soc: Support Timer for AST2700
>>
>> Kenneth Jia (1):
>>    hw/arm/aspeed: fix connect_serial_hds_to_uarts
>>
>>   include/hw/arm/aspeed.h                     |   1 +
>>   include/hw/sd/sdhci.h                       |   5 +
>>   include/hw/timer/aspeed_timer.h             |   1 +
>>   hw/arm/aspeed.c                             |  15 +-
>>   hw/arm/aspeed_ast27x0.c                     |  17 ++
>>   hw/sd/sdhci.c                               |   6 +
>>   hw/timer/aspeed_timer.c                     | 263
>> ++++++++++++++++++--
>>   hw/timer/trace-events                       |   2 +-
>>   tests/functional/aspeed.py                  |   2 +-
>>   tests/functional/test_aarch64_aspeed.py     |   8 +-
>>   tests/functional/test_arm_aspeed_ast2500.py |   8 +-
>>   tests/functional/test_arm_aspeed_ast2600.py |   8 +-
>>   12 files changed, 303 insertions(+), 33 deletions(-)
>>
>> --
>> 2.48.1
> 


