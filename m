Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74E8C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 06:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdOE4-00017I-HG; Thu, 30 Jan 2025 01:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdODy-00016I-Bn
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 01:40:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdODv-0006DD-PV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 01:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738219220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HQKJjO18p/Ip3LdvMZeIgzo9C5VIOgiMZRgRDeBhUic=;
 b=ccNYbQMpPI5c/OU0OZF7DU0INk8zc/pAWZmBw6V/XW2SP/9XWpoERCG6NwbvRrJdHOroeM
 lodvbWh66pUyqcovQNSKyq5SE+sA6T7FUy26Vc396/QL8XpKxKey7MYS4Of1ixQLanFDT5
 TMIlz0+llygqf9GQ6cGKzten06HjTCE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-gJRhf4ouN-eASQs-HiD_Nw-1; Thu, 30 Jan 2025 01:40:19 -0500
X-MC-Unique: gJRhf4ouN-eASQs-HiD_Nw-1
X-Mimecast-MFC-AGG-ID: gJRhf4ouN-eASQs-HiD_Nw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4362552ce62so1621155e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 22:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738219218; x=1738824018;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HQKJjO18p/Ip3LdvMZeIgzo9C5VIOgiMZRgRDeBhUic=;
 b=W8zHtgAuYSxu8S5viYQr4OQpgYqOmeX1UB15G3LzN46OlEeOljg+wJBX+99U/AFwvk
 5/4oPAJJYzQCxM1VoYBVdfsDTUS1ahQliqyKn9RXYx7gcOp7/wzahIuY0wVr6yc9D7ia
 GNY8Z+0c8DV8DofrvhYE2JD+cEgekMchbGpNgDusfdDndHiuIo6phTmAHefYqPuIeVzA
 zKZTJnfD4nLg1FFwjzlssb2L0+QLKsy9uAy4wOEg5CGhNXlSQu7GO0Tht2+cpcG3WozI
 edfUU70gZN+nOgoMwNj0cY056a3Za+gPyPRMfkCUIOIxLjTaORIdH8ochRJZDNyJL7qn
 W15Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/zd4GI+8//5AQm/XoVty5XXEGat1FwnqqFHjDLvL5jPt8/kgHw+OcVogW3YDjaahO1XwnI1j9jJC9@nongnu.org
X-Gm-Message-State: AOJu0YwLSJt8AbYmCRyPbTXPR9j2fr2mUacvg6i9rsR6QTQuJtj+RVHf
 PPsUhE9mNQGLY6mUu6ShcXa7d/wYbIr6Gf28qJKV67M9qDiKQya2m+vu4OpbnBSWu2m79NGhnTT
 F+3qahvlgFviddPYeCaUtW6owP0RhEJi+ZVnSVmuw+fBRXJ1RNIwy
X-Gm-Gg: ASbGncvaX8awAJqvAuu81IkCpHLyFP1qbbtUlAWOYC8Yk9O0+Q8tVvxQxeEOsGgU+Nb
 kthK3DcQOl2jfALjhGtXm3fIbfiq+hKQjs2b5wbaxOrwhYHstOrzg+/op+78aI2ReM/6pMKTktF
 3FDBvpwlaRA49RqZksXfk58E3CMk+d9GSBmiy/SXLv866Qp84yfm/5P5JLYs+ciiGdqx9EudWII
 fyDq+r+zjGUAvoxyk/5vGpABXgk1GfRaCBnq5IFgqhULSfAi6Fu+ObB8NVP/3k2h9f+/hCh/bHz
 IRqExUCEKo9UnGGKtZCWzUoMN3MoSMujWuiZ
X-Received: by 2002:a05:600c:1e0e:b0:434:9934:575 with SMTP id
 5b1f17b1804b1-438dc3caa59mr56255555e9.16.1738219217803; 
 Wed, 29 Jan 2025 22:40:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD+cPyy6MyWANE73ks2nw/RDOsS0SjO6MKrbgpKUJWk9/QDU+MvJPwrSVJUGroOdp8lGE7Jw==
X-Received: by 2002:a05:600c:1e0e:b0:434:9934:575 with SMTP id
 5b1f17b1804b1-438dc3caa59mr56255415e9.16.1738219217457; 
 Wed, 29 Jan 2025 22:40:17 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d444bsm11892935e9.8.2025.01.29.22.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 22:40:16 -0800 (PST)
Message-ID: <3fe2d7fa-0e2b-48ff-b69c-2c6d805fee12@redhat.com>
Date: Thu, 30 Jan 2025 07:40:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] tests/functional: Introduce a new test routine for
 OpenBMC images
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>
References: <20250129071820.1258133-1-clg@redhat.com>
 <20250129071820.1258133-2-clg@redhat.com>
 <98b2cdec-dcd2-44bf-a81e-91521e2bd446@redhat.com>
 <815ec281-f4b0-43e4-ba56-1400d16dfe21@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <815ec281-f4b0-43e4-ba56-1400d16dfe21@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 29/01/2025 17.28, Cédric Le Goater wrote:
> On 1/29/25 08:58, Thomas Huth wrote:
>> On 29/01/2025 08.18, Cédric Le Goater wrote:
>>> The OpenBMC images currently used by QEMU to test the Aspeed machines
>>> are rather old. To prepare an update to the latest builds, we need to
>>> adjust the console patterns. Introduce a new routine to preserve the
>>> current tests.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   tests/functional/aspeed.py | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
>>> index b52358bb8c61..51c821944842 100644
>>> --- a/tests/functional/aspeed.py
>>> +++ b/tests/functional/aspeed.py
>>> @@ -23,6 +23,24 @@ def do_test_arm_aspeed(self, machine, image):
>>>           self.wait_for_console_pattern("ftgmac100 1e660000.ethernet 
>>> eth0: irq ")
>>>           self.wait_for_console_pattern("systemd[1]: Set hostname to")
>>> +    def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
>>> +                                   cpu_id='0x0', soc='AST2500 rev A1'):
>>> +        hostname = machine.removesuffix('-bmc')
>>> +
>>> +        self.set_machine(machine)
>>> +        self.vm.set_console()
>>> +        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
>>> +                         '-net', 'nic', '-snapshot')
>>
>> "-net nic" is the default anyway, so unless you also use "-nodefaults", I 
>> think you can simply drop that?
> 
> OK. Will do.
> 
> Do you want a resend for that ? Unless you prefer this series
> to go through you tree, I will amend before sending PR.

No, no need for a v2 just because of this. And yes, please take it through 
the aspeed tree!

  Thanks,
   Thomas


