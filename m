Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824FAC282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 15:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp7P8-0000TI-QH; Mon, 03 Mar 2025 10:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tp7Od-0000N6-My
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 10:07:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tp7Ob-0000pt-Hu
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 10:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741014472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3PV1oX5l2ZaQyuOgBUA8R/Lr8u8tYnIiOCmQUyEb8DI=;
 b=CHUP3kqMPn/kowonbUW12T/b68mXKU1qt5k0fauS+ljhUG8f6Ufwa7O/truOb5WwAlFnxp
 IKBV2B/5tn9B6ZrKG2Bedx0zjCZuKHNCpekPuGsEOhrs3uqarFarhpjx6rnSmhmnkPTG0J
 iIoU3J8XbD3swCwJqFMJ9XH70CUdFe0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-WYaWpUj8PeKLdxBJ6oCaAg-1; Mon, 03 Mar 2025 10:07:41 -0500
X-MC-Unique: WYaWpUj8PeKLdxBJ6oCaAg-1
X-Mimecast-MFC-AGG-ID: WYaWpUj8PeKLdxBJ6oCaAg_1741014460
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-438e180821aso24399415e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 07:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741014460; x=1741619260;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PV1oX5l2ZaQyuOgBUA8R/Lr8u8tYnIiOCmQUyEb8DI=;
 b=mqOM4C008/1OBuMo0yg4iZsgCZHvTgHKmH4sOXO18kD5jIfHKN/hE+jd7yNUpfS9DN
 AWGlA0GZEA5GUtPKOe88os1fupUwV/SgTZOCK/AVqioHOoe9pC0Bj7gdvKOYbqWwQRBq
 4BbVST5DL8s4CfUJQfl7cr8mvZ4KJwznDD59BBqJlo0dmFoFWUyIydp1BFdUyvSI9hzA
 V9cf08/RjQ59OwTel1vRLXuPXmbyNhRiGzVZYSTLrPQKLA05nePaGeql/kXHhncgNidy
 d+gMF3pMHQKYKLjTjRL5KMoAdNEuniZ3QwfTTuYxj6HsuVN8iPxzTHSk47ioBbAev29o
 fVuA==
X-Gm-Message-State: AOJu0YzcczdJvH3t9ZX6oDA5CRPSl19Vs0YmI9XPg6GEDQKrkXxc+hog
 ADLaf3HHteu29MgqwSKXxNAYEy7H5xFxbP/o8Xl//gfNw/g4O5UhrtqNgMJMMIVHmvt/Jaz/uaL
 AO5slW0MBffgauRzIVDtHMOr+8GiMop1LOaFECLQUl6+LmrZqBFZ+
X-Gm-Gg: ASbGncv2UxrSaL88tB3BldjyNzK74LC+6Xt19nn8tmlNsKq7PZhI09SlKDiNHWj9fsb
 HnwPEd/JsnMEoNgv1p5tRR0Y1GYBu/JI0BhpvrDg2pmgJztYrxCp2u3sppjKaIphigNFMZ/+90e
 q/HVOmLCg/Qaq7BEO8YKncTY7VIucBHg0eJlIoDiSOclcjqrtHmY7H2aVXMxGUIOi0TyoeUAeMT
 loSdUW0r4WWv9tAyLvIwInbwQcJ+dmz5yNlwoqgGl0O8XszJ02ujymMnbkT5VOCh1PJILt/s9lJ
 TQJNLZaO++xmR7aXGYBbMa/V3nKrrZu8cmY9Z78+NVoYHJyiyiC/nA==
X-Received: by 2002:a5d:6dab:0:b0:390:fd84:9b with SMTP id
 ffacd0b85a97d-390fd84033emr7142932f8f.25.1741014460136; 
 Mon, 03 Mar 2025 07:07:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/dMoNoIVDjGnxagsdM6M4gSeSvNJw+SPglJ/NUQnGoUTDw9ZINud0fHyjVNmACyMMD7UNSg==
X-Received: by 2002:a5d:6dab:0:b0:390:fd84:9b with SMTP id
 ffacd0b85a97d-390fd84033emr7142881f8f.25.1741014459686; 
 Mon, 03 Mar 2025 07:07:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e479652dsm15023290f8f.16.2025.03.03.07.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 07:07:39 -0800 (PST)
Message-ID: <79685365-0ce5-435a-b6df-144916fed396@redhat.com>
Date: Mon, 3 Mar 2025 16:07:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
To: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <7982159d-710f-4948-830f-ab61b100a5d6@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <7982159d-710f-4948-830f-ab61b100a5d6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 3/3/25 15:43, Paolo Bonzini wrote:
> On 2/26/25 17:26, Cédric Le Goater wrote:
>> On 2/26/25 15:12, BALATON Zoltan wrote:
>>> On Wed, 26 Feb 2025, Cédric Le Goater wrote:
>>>> VFIO PCI never worked on PPC32 nor ARM, S390x is 64-bit, it might have
>>>> worked on i386 long ago but we have no plans to further support VFIO
>>>> on any 32-bit host platforms. Restrict to 64-bit host platforms.
>>>>
>>>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
>>>> Cc: Eric Farman <farman@linux.ibm.com>
>>>> Cc: Eric Auger <eric.auger@redhat.com>
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>> hw/vfio/Kconfig | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
>>>> index 7cdba0560aa821c88d3420b36f86020575834202..6ed825429a9151fcdff33e95d1a310210689b258 100644
>>>> --- a/hw/vfio/Kconfig
>>>> +++ b/hw/vfio/Kconfig
>>>> @@ -7,7 +7,7 @@ config VFIO_PCI
>>>>     default y
>>>>     select VFIO
>>>>     select EDID
>>>> -    depends on LINUX && PCI
>>>> +    depends on LINUX && PCI && (AARCH64 || PPC64 || X86_64 || S390X)
>>>
>>> Are these defined for the host or target? 
>>
>> host.
> 
> No, Zoltan is correct.  They are defined for the target, so if you build for 32-bit ARM you'd still get things with "depends on AARCH64" in qemu-system-aarch64.  You can check that you have

AFAICS, you can't build qemu-system-aarch64 on 32-bit ARM anymore. Can you ?

Thanks,

C.



> 
> config SBSA_REF
>      bool
>      default y
>      depends on TCG && AARCH64
> 
> but on x86-64:
> 
> $ qemu-system-aarch64 -M help|grep sbsa
> sbsa-ref             QEMU 'SBSA Reference' ARM Virtual Machine
> 
> 
>> As per commit 6d701c9bac1d3571e9ad511e01b27df7237f0b13 "meson: Deprecate
>> 32-bit host support", support will be fully removed in 2 releases and
>> it doesn't need to be addressed by VFIO.
> 
> Note that a deprecation *allows* full removal in 2 releases.  We have a lot of things that are deprecated but have not been removed.  For example
> 
>     Short-form boolean options (since 6.0)
>     ''''''''''''''''''''''''''''''''''''''
> 
>     Boolean options such as ``share=on``/``share=off`` could be written
>     in short form as ``share`` and ``noshare``.  This is now deprecated
>     and will cause a warning.
> 
> is deprecated to *allow* switching command-line options from the "qemu-options" parser to the "keyval" parser that doesn't support short-form boolean options, but it's unlikely that qemu-options will drop support for short-form boolean options.
> 
> Paolo
> 


