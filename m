Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C46C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 17:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxxe-0006fo-0l; Tue, 27 May 2025 13:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxxb-0006dy-OA
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxxZ-0000RO-Rf
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748366368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8XjI8PUrGTVgjcxSY+wJwP09QeVT6XEtNZ5AwPPMdSM=;
 b=LWrlTr4ne9hEUUZXpbs5WbY5XQeEzLK4U8NT2226S0RLO9PYsbS3ml1S1L6s6EAhA+6mjv
 fpCu7keqPeqrIlBfDBokvPdJ5IRZ5UnUZ2Fwapm4CuzIoAlRpsFRvZUmxjcucV9emfKX1K
 /djST8eLdNeJdPgPKIT3YdY/al5s2No=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-HEDEf2G8MGGjiB8SUOfuxA-1; Tue, 27 May 2025 13:19:26 -0400
X-MC-Unique: HEDEf2G8MGGjiB8SUOfuxA-1
X-Mimecast-MFC-AGG-ID: HEDEf2G8MGGjiB8SUOfuxA_1748366363
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac6ce5fe9bfso338327866b.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 10:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748366363; x=1748971163;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8XjI8PUrGTVgjcxSY+wJwP09QeVT6XEtNZ5AwPPMdSM=;
 b=WGPfnF7Gm/3bTjuQUwY7uUh/0lC38Og6ThYr8IQAwf1i+MzyAmMiEaAknAKB+XlT1u
 TCHpagneR0sRjc2VyC0SscJUMD6Gc8C9N92Bkt48fUI1aYVlaCp3iZJfUrZ1UsmuUUkg
 i2ilsWceEsbQ5sHqc4J1keAakQonG22tv0fBjAW6NktMKGQgAG6PC6DDHTmlcs/lplqH
 SKKvyyWQdyEbz89neTwf0BgsFjkiv37MhHJo9SNsK3RgGTbLZNH/t1qtH8zUGzB4Okrx
 JuWsb4IEYUPXf6uSgPcAEWSCSDKvkX5zndIuvmz6KV36YiiY9+fS6RsbGkiqcSzaOJ9Q
 xovg==
X-Gm-Message-State: AOJu0Ywo+YcewpPp02Mc1LG4C+dhkxJtSfK/mSJI6lae3NSJJKcmcR8t
 CzwT5IkXngIPdAaGVccgzSUp5Ztd2G/NJCGSis/YUycY5LCTqNTPW0Oe7zM+hZKA0VoegWPamoh
 nwp5vqPlFSTpN+tDE6n0vaKp/TM08pZzJNTAl2JFil4ZxHNfvZzRmcQTi
X-Gm-Gg: ASbGncvSz34gZX2UEYLUntRnRstiF6DsI4c2u076/8xbeWhKs1l4xToIpvIYv/yLoDY
 gcYn7TjfdQUIEdVM3276wjHZWFORDKzaXWNQMCcZWY8AOE8mabUaQx5stcWNK+Ai+GtVU880Zxp
 uRx1F3qTfJqdIEOAWgPkEPFGHJNe7fM/eTKPFL/3c/Vyfv6EZ+7QXXcwSpzK3KyEJvUB8FaYWQL
 dPrJKhFN9pFX2SXVg+8lbayvG93VCCXK/WVY48rK0NYlP6JSEIgOq00P+jAd1n1vDwoLOdDlxdd
 +t4CYtB4JKIc9A==
X-Received: by 2002:a17:907:9723:b0:ad5:57e0:c3b1 with SMTP id
 a640c23a62f3a-ad85b0e0ef2mr1248934366b.23.1748366362803; 
 Tue, 27 May 2025 10:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENBN7WKZFiYKIyGkEoGHvbwDew0nHHtIY3nvAcYNtWzFq4E12q7cyh9gFC2bFJqAHHv5MwOA==
X-Received: by 2002:a17:907:9723:b0:ad5:57e0:c3b1 with SMTP id
 a640c23a62f3a-ad85b0e0ef2mr1248932066b.23.1748366362421; 
 Tue, 27 May 2025 10:19:22 -0700 (PDT)
Received: from [192.168.10.27] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ad5572f6402sm1642359066b.178.2025.05.27.10.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 10:19:21 -0700 (PDT)
Message-ID: <c7218963-6e04-41ff-85b5-dfa1e106eb56@redhat.com>
Date: Tue, 27 May 2025 19:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/boards: Remove MachineState::usb_disabled field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Alexander Graf <agraf@csgraf.de>,
 Markus Armbruster <armbru@redhat.com>
References: <20250526130006.49817-1-philmd@linaro.org>
 <1c9f8e9d-1ee6-b2d9-98d6-5640f59f0e4a@eik.bme.hu>
 <649e4c91-fb4c-4cb2-9810-b1ee885ffea3@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <649e4c91-fb4c-4cb2-9810-b1ee885ffea3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/26/25 16:20, Philippe Mathieu-Daudé wrote:
> On 26/5/25 15:18, BALATON Zoltan wrote:
>> On Mon, 26 May 2025, Philippe Mathieu-Daudé wrote:
>>> Only add default devices checking defaults_enabled().
>>> Remove the unused usb_disabled field in MachineState.
>>
>> At least for Mac machines this may be more complex. I think there is a 
>> - usb switch to enable/disable USB independently of defaults and due 
>> to some bugs some MacOS versions may need this to boot so maybe it's 
>> used.
> 
> If the user asks -usb off, we shouldn't re-enable it in the shadow.

And if the user asks -usb on, you shouldn't disable it.  My
understanding is that adding

-        if (!has_adb || machine_arch == ARCH_MAC99_U3) {
+        if ((!has_adb || machine_arch == ARCH_MAC99_U3) && defaults_enabled()) {

disables USB completely when -nodefaults.

If you want to remove usb_disabled, change machine->usb to ON_OFF_AUTO
and query

static inline bool machine_usb_enabled(MachineState *ms)
{
         return (defaults_enabled()
                 ? machine->usb != ON_OFF_AUTO_OFF
                 : machine->usb == ON_OFF_AUTO_ON);
}

instead of machine->usb (even better, change the name of the field so that
it causes a compilation error).

Paolo


