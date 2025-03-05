Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8DCC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiPF-0007mI-Lh; Wed, 05 Mar 2025 01:39:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpiPB-0007lx-Iy
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:38:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpiP9-0000xi-2k
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741156730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JYYUs2fBDZGyQRkxAl6EA2s4BhdIPh9cwsN5arzJRQg=;
 b=UEh5qAwzmGckUd96HdNqYOWTDoCU7d9ntHuvpCdbaPNaSILdyA7gT0DYukTsdnV84lvk5W
 7zfRpw/poTLqwlnseM9gedVKaqx7sIxvjPdk/8wtmw9IiqFjp1mlcBe5iYzAS+P8toy07+
 xWmvUNEn3NMchDAlP4q0oPrHRxFhcBw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524--arPV_qBPfyaYuHZJQA10g-1; Wed, 05 Mar 2025 01:38:48 -0500
X-MC-Unique: -arPV_qBPfyaYuHZJQA10g-1
X-Mimecast-MFC-AGG-ID: -arPV_qBPfyaYuHZJQA10g_1741156727
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43bd0586b86so6040865e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 22:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741156727; x=1741761527;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JYYUs2fBDZGyQRkxAl6EA2s4BhdIPh9cwsN5arzJRQg=;
 b=SNR6/dFxb9/SvNOLyjsA6DZR/BJ6+RpqG8x9GrAtpZWSOVj1MC3Bctm0Zw/jsfxgqj
 dtNErHSO7AZ8I+jaME8xPvXxQXw1V321Ydxiu0p+h+hb1gZkRDrDPbkaamp6nt+OGltE
 XF5ndNI1svMI1YKTwhW1eyHPXSnfxhvJkDc7+Wa6yVwTHYb/PGgXtHmghHwQNEwSXtAA
 gBY/l2XJYuV8hbh/ShM5FwTK3oxKmsMN3PE+Rd9o49ubh9HnZ6JC5So1nSMKxo7LsvtW
 ihEBZcl4cW6blzrIIDdU0RJnPPjo/V6/KWzK2IFBkEHyH6d4011Oy69pSmiA4A1QoXqQ
 yyHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0xS8q+fqMBSxcT0FRg6D13u9S4XE8o8Tx+N10UueUAzEBZqUpvcVZT/rzTm79YHy6qGg6VqEGcGdR@nongnu.org
X-Gm-Message-State: AOJu0YyRMXDpYJmqCVk9sKd/HY/dl/RSpkcU5psFFUE+MykgQxH50tTz
 DuEQ4UfHdoK72wb0ak9kI6DKI2bjciIqHqJibMLh6y9s8thvHwVGd0xv+OGmPgLGhNYNcdNC3me
 K+DGVpmpwAt2+ZlZVatP7kRk27+Qk/yEq9GwBqJsSFE57O3Qq/yh2
X-Gm-Gg: ASbGnctUJSMOvoE6GMKx/G9ttk/GG8yDV1IfWhFBqc11xr0H69AS7aeqr8/0RVneh7j
 d07uybWKE2kFVDPfXW+Wd4a97DwqNW69HPKQ1A8t0nEOkr6N7s/zYlz2eN6OLoHo3NUDksCDoEi
 JwTxfPBuwxtNvgLTWem2qYPxqXOsd2yUvm5/vvLjjpZh0Z3lYY5jSLgFmp7CrpuyH1bVmc+5AyW
 e1MJc4bddDV523BHTYBBgw+y0fpDPD9XjI8NrIAT5I4NKgR4IgLHE/n7F5vSY50QCyXRiSiGS6d
 CKH3N87d7NCEebjzpHO6rM+qPkMxd0H3s3V55X6KIn6oIPw=
X-Received: by 2002:a05:600c:458a:b0:439:5da7:8e0 with SMTP id
 5b1f17b1804b1-43bd2992d20mr13444575e9.16.1741156727129; 
 Tue, 04 Mar 2025 22:38:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFgFDO9pjgjRN7EVdQM+28tR8gOu+IwlE9xKq/ZVnbl87C8RKnhAPHPzvnCBTwJy2UpqXndg==
X-Received: by 2002:a05:600c:458a:b0:439:5da7:8e0 with SMTP id
 5b1f17b1804b1-43bd2992d20mr13444375e9.16.1741156726746; 
 Tue, 04 Mar 2025 22:38:46 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4310779sm7604665e9.37.2025.03.04.22.38.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 22:38:45 -0800 (PST)
Message-ID: <c37bff90-72f2-4f82-94b0-e2ea63684b35@redhat.com>
Date: Wed, 5 Mar 2025 07:38:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
 <aa01f3dd-e3ac-4ee5-87b4-8133103bd000@linaro.org>
 <270cc189-e3b2-4bf4-b32b-8655be51bcb4@redhat.com>
 <b2075e91-79ca-4d5f-b13b-151f2a59181d@redhat.com>
 <8e3a5810-accf-1f77-8692-4e077c3ce327@eik.bme.hu>
 <b0b56480-0b5a-4f32-af27-13394795b58e@redhat.com>
 <CAFEAcA8FRyuuPxZQhLM8Jq4iD6TEMqN+E=iTNfNOeafTzTBeNg@mail.gmail.com>
 <2ccd4a87-68f3-4eb1-bc2a-dbc424bc8d34@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2ccd4a87-68f3-4eb1-bc2a-dbc424bc8d34@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 03/03/2025 18.32, Philippe Mathieu-Daudé wrote:
> On 3/3/25 17:57, Peter Maydell wrote:
>> On Mon, 3 Mar 2025 at 15:49, Cédric Le Goater <clg@redhat.com> wrote:
>>> Why are we keeping qemu-system-ppc and qemu-system-i386, and arm,
>>> since qemu-system-ppc64 and qemu-system-x86_64 should be able to
>>> run the same machines ?
>>
>> They're not identical -- for example "-cpu max" on
>> qemu-system-arm is a 32-bit CPU but on qemu-system-aarch64
>> it is a 64-bit CPU.
>>
>> There's definitely a lot of overlap but we can't just drop
>> the -arm executable until/unless we figure out what to do
>> about the corner cases where they are different. Plus there's
>> a lot of users out there with existing command lines and
>> configs that assume the existence of a qemu-system-arm
>> executable.
> 
> Thomas and myself have been trying to sort that out. Now with the
> single-binary effort, it gained new interest. This hasn't be a trivial
> task so far, due to as you mentioned the legacy CLI uses and migration.

FWIW, here's my former attempt to see whether we could move into that direction:

  https://lore.kernel.org/qemu-devel/20230425133851.489283-1-thuth@redhat.com/

In the end, it was too frustrating to struggle with the 
backwards-compatibility questions (do we really need to keep 
qemu-system-i386 around forever?), so I pretty much gave up on that patch 
series.

  Thomas


