Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9511EC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfZE-0002d9-7G; Fri, 22 Mar 2024 10:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rnfZB-0002cN-MF
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:08:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rnfZA-00031c-33
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711116494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jb+RFwUxZLS6XlMgPlZdWSuIHefjsKppq7uBkfuYlFQ=;
 b=WVqpEUwJ2IiohFFv0TKqWKIuGuigDLT2pJvGstKw9kZ+dBas67ifPWfffj4GOzi69rbYQB
 GCFvbQr7IkhADvpxeFKfKKe/heEraqHnLDqJ9xSsyN/MD/CShwTSx6zlY/PuKQddAB16Cg
 4SJlHSK1vLmqe07CdrH6SKUWdZ0cdBo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-tTXb0x7IMYuv-wN21DU4Tg-1; Fri, 22 Mar 2024 10:08:12 -0400
X-MC-Unique: tTXb0x7IMYuv-wN21DU4Tg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-513eee2dd2fso2100649e87.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 07:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711116491; x=1711721291;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jb+RFwUxZLS6XlMgPlZdWSuIHefjsKppq7uBkfuYlFQ=;
 b=t3b4Aq9Hq/dKyEa1vsEmM3gIExUZeT4szRTBv6pP+32GggtwNK9jfM6BMVM5IR83ZZ
 jdP0juh7PFV61Pji2OAzQIf9TfXKZlO5lO3O+BkqT+f3tDfm2zEul28gXDr2fsxmhwyj
 lH5D4n3HSRbVyF16UbngAlJB3OzzffdDj48QUPPfVA5pc6IsOGhDfSxSUmEnU9i5VzwU
 pyA06jSOePcN6KKHCVB0qepU9riNOP9MnFboCbS1L7vqt5VgI2IVYZaHSfjSmobleCWK
 T0nHCMWobFANh10m76Vn13HRH3Sp7/Hz+aU/Y6IvDUOugDaQoIezH9MmlMiOx35GpsM2
 PmcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmLKWhrm8oyqvcoTgPQagPdU0xdwLwxwaD07vwLE47nrFtCiYIymBFekfRIbGgMVZm1362OBXu4O5ubcdzHegV1Ohh4V0=
X-Gm-Message-State: AOJu0Yzp4XPso/B0Jr4+d3DPoewdRqaQuw4dQaHi9Alq/iwaY20tsI6T
 YpXM+HKI29pEDzBNH713Ce/xxz1AEFjziHHAVZg4VQbtfYvCQ9usnMLLVt5p31vYh1pdqhcc1Hl
 4pqMqRIhzBbyedfY7ZB+ZrAjxh3QbTTJPgTyGl6NFs8NkjQdDnKmw
X-Received: by 2002:a19:e05d:0:b0:513:c6ec:fa6c with SMTP id
 g29-20020a19e05d000000b00513c6ecfa6cmr1724290lfj.48.1711116491418; 
 Fri, 22 Mar 2024 07:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHcfthXuy2N5hKCsZ42T5Q83dfNwqXK3Du4VtPbyMsngZqrCKM0JE7SY5SK9Zn13EPpRLThw==
X-Received: by 2002:a19:e05d:0:b0:513:c6ec:fa6c with SMTP id
 g29-20020a19e05d000000b00513c6ecfa6cmr1724272lfj.48.1711116491075; 
 Fri, 22 Mar 2024 07:08:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 m15-20020adffe4f000000b0033e5c54d0d9sm2153343wrs.38.2024.03.22.07.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 07:08:10 -0700 (PDT)
Message-ID: <6dfb82c0-d2c0-4618-94b0-2e2561534d96@redhat.com>
Date: Fri, 22 Mar 2024 15:08:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
Subject: Re: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
To: Peter Maydell <peter.maydell@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20240220150833.13674-1-philmd@linaro.org>
 <f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com>
 <cc132404-dcd5-4aed-a481-b46d6e3115b0@linaro.org>
 <CAFEAcA_0qUFW0MewHC+v+pSOisE-kQDt9Wv4F3RafEkyQ0DGJA@mail.gmail.com>
 <59C20F1A-FCFE-4E26-B511-A6C0E1EF6F61@qti.qualcomm.com>
 <CAFEAcA8MVbKqv-TgaO7Vv95f0p164Gao+LT-CM5+92cXjkpmTw@mail.gmail.com>
 <23BCD870-16A1-4AF9-9308-2788178F511B@qti.qualcomm.com>
 <CAFEAcA8=H=xD75T-e6JFnz9RtT2kG2nM5HbqE0AsTiWFe+0a-w@mail.gmail.com>
Content-Language: en-US, fr
In-Reply-To: <CAFEAcA8=H=xD75T-e6JFnz9RtT2kG2nM5HbqE0AsTiWFe+0a-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/20/24 16:00, Peter Maydell wrote:
> On Wed, 20 Mar 2024 at 14:10, Mark Burton <mburton@qti.qualcomm.com> wrote:
>> I’d broaden this to all ’signals’ (IRQ, Reset etc) - and I guess
>> similar statements apply, with the “bridge” between the function
>> and the GPIO mechanism moved closer or further from the originator(s)
>> of the activity.
>>
>> The issue isn’t my “machine” model, rather the compose-ability of
>> (any) such machine.  A-priori, a model writer doesn’t know if they
>> should respond directly to an NMI or not - Hence they dont know if
>> they should implement the TYPE_NMI or not. That’s a decision only
>> the machine composer knows.
>> My suggestion would be to use a GPIO interface to models, which can
>> then be appropriately wired. (And, hence, to have a single place
>> that implements the TYPE_NMI interface and provides the GPIO wire
>> ready for wiring to appropriate devices).
> 
> I feel like that's a long way in the future, but my back-of-the-envelope
> design sketch of that is that the TYPE_MACHINE class that's implementing
> the "I am just a container for all the devices that the user has
> specified and wired together" machine would itself implement TYPE_NMI and
> when an NMI came in it would assert a GPIO line that the user could
> wire up, or not wire up, as they chose.
> 
> Right now we can't do that though, because, among other reasons,
> TYPE_MACHINE isn't a TYPE_DEVICE. (I do want to fix that, though:
> I'm hoping it won't be too difficult.)

Oh that's interesting. Will that introduce an extra level of container
with multiple machines below ?

/qemu
   /machine[0]
     ...
     /peripheral (container)
     /peripheral-anon (container)
   /machine[1]
     ...
     /peripheral (container)
     /peripheral-anon (container)
   /unattached (container)
     ...
     /sysbus (System)
     /system[0] (memory-region)

Thanks,

C.


