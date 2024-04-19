Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA62FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 05:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxgLj-0000rM-7Y; Fri, 19 Apr 2024 00:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxgLh-0000qt-DD
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxgLf-0007bp-Oq
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713502782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SNhjBb7iRbtRd2OnyQJzLHhVIWv6Lqm5Fc6lVzwJzKQ=;
 b=Ab/JZRBTbZ7RhtGgnjvAFlE5QhDsi/2QHq8CUJMasHY/R0kmN+C4ZQ9hPzo9O4+tyxEC2a
 iPWfSNNa7Q7E5ZVTXdM19CYixx1QkS/j2rWKCFra7RRyfg2shUzkHFVQ/RKSnMwnQDWRsY
 8r4bFcLE7n/ZMYN3x9D+QICpGW+H+8k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-kvgHSNbOPRqABa-0ggMstg-1; Fri, 19 Apr 2024 00:59:40 -0400
X-MC-Unique: kvgHSNbOPRqABa-0ggMstg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a4455ae71fcso78358566b.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 21:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713502779; x=1714107579;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNhjBb7iRbtRd2OnyQJzLHhVIWv6Lqm5Fc6lVzwJzKQ=;
 b=TtmLMfHfN+LssXfRgGTik7I9nkkCb6B9s1tBZ8Ax/VJDs4Sy5jR3hl5jG2We2VbJER
 UMZYoMS7kiIDe2Z7pJC9qV0PM7HhR32mSmhaYGPUSbywDDoCqik9U/ZNz+dsoxu0i6Ec
 y9sdQy+7LazVsNGIJ9zZ5lQhYt6GiG5JyNDdV7+UEFUnAyEj7AjhLt9G264NYMo5tcXI
 Xn5tlTYIC6nVTk4/rRtdOj82YJ7uh3cw8s9YzFpCW16LIhU2awJhtuMHGRgdzzxgMObl
 sFv3ttk/5QCWyCNHka9w5DyAi+527PWKa2K+fX2r4DCv4iVym59CvuDCGAFTUXsRERvh
 e+MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUigIEZoZO4CeyOsnIqw1YYmFzr7kkp/4/4gfLVxMXKrkPEO+pcSqQ2MJVdO6Q8SE8L7vB1eguotHpAt4rgkBf7ydzPr6E=
X-Gm-Message-State: AOJu0YxKI3olehLVFNM+Fxs+M6HSvH8kM6EdQRz91beWCSN/+Mxl8s9S
 WSB4M34FMM3WaHC9UdZ3PcEdb+wxxNSD/EOF1lhl8/ci5rQIHVNS9Bb5QF9U0+tRvasPvCiQOwm
 gwPGf2ymeodnidKINGyrQXIMJsvJNtp3J+Da81d6pjVweGDjD7w6j
X-Received: by 2002:a17:906:17cf:b0:a55:5ddd:ec0f with SMTP id
 u15-20020a17090617cf00b00a555dddec0fmr593124eje.12.1713502779338; 
 Thu, 18 Apr 2024 21:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVM84TnSlMyLjoRFETt9cEust51UKUBbyQEVXAiGiJiiJ14Hw/olY6y+/MwxE69/g27QKlRQ==
X-Received: by 2002:a17:906:17cf:b0:a55:5ddd:ec0f with SMTP id
 u15-20020a17090617cf00b00a555dddec0fmr593113eje.12.1713502778969; 
 Thu, 18 Apr 2024 21:59:38 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-117.web.vodafone.de.
 [109.43.177.117]) by smtp.gmail.com with ESMTPSA id
 e9-20020a17090681c900b00a4a33cfe593sm1685048ejx.39.2024.04.18.21.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 21:59:38 -0700 (PDT)
Message-ID: <ee98c81b-0b07-4469-9135-ac3be7dc7564@redhat.com>
Date: Fri, 19 Apr 2024 06:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] docs/system/target-sparc: Improve the Sparc
 documentation
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
 <20240307174334.130407-5-thuth@redhat.com>
 <529ece4e-1de6-4941-bb75-c10997aad13c@ilande.co.uk>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <529ece4e-1de6-4941-bb75-c10997aad13c@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/04/2024 22.27, Mark Cave-Ayland wrote:
> On 07/03/2024 17:43, Thomas Huth wrote:
> 
>> Add some words about how to enable or disable boolean features,
>> and remove the note about a Linux kernel being available on the
>> QEMU website (they have been removed long ago already).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   docs/system/target-sparc.rst | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
>> index 9ec8c90c14..9f418b9d3e 100644
>> --- a/docs/system/target-sparc.rst
>> +++ b/docs/system/target-sparc.rst
>> @@ -27,6 +27,11 @@ architecture machines:
>>   The emulation is somewhat complete. SMP up to 16 CPUs is supported, but
>>   Linux limits the number of usable CPUs to 4.
>> +The list of available CPUs can be viewed by starting QEMU with ``-cpu 
>> help``.
>> +Optional boolean features can be added with a "+" in front of the feature 
>> name,
>> +or disabled with a "-" in front of the name, for example
>> +``-cpu TI-SuperSparc-II,+float128``.
>> +
>>   QEMU emulates the following sun4m peripherals:
>>   -  IOMMU
>> @@ -55,8 +60,7 @@ OpenBIOS is a free (GPL v2) portable firmware 
>> implementation. The goal
>>   is to implement a 100% IEEE 1275-1994 (referred to as Open Firmware)
>>   compliant firmware.
>> -A sample Linux 2.6 series kernel and ram disk image are available on the
>> -QEMU web site. There are still issues with NetBSD and OpenBSD, but most
>> +There are still issues with NetBSD and OpenBSD, but most
>>   kernel versions work. Please note that currently older Solaris kernels
>>   don't work probably due to interface issues between OpenBIOS and
>>   Solaris.
> 
> Just curious as to what current issues exist with NetBSD and OpenBSD? At 
> least both my NetBSD and OpenBSD test images survive a casual boot test here 
> with latest git.

Maybe it's also about a long fixed bug ... shall I remove that sentence 
while I'm at it?

  Thomas



