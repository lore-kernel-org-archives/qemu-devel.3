Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7C2C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPWI-0004YI-16; Thu, 16 Jul 2026 13:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wkPWG-0004SM-FE
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:05:08 -0400
Received: from smtpout1.mo540.mail-out.ovh.net ([51.210.91.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wkPWD-0006k8-QW
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:05:08 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4h1KCw6VMdz41sD;
 Thu, 16 Jul 2026 17:05:00 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Thu, 16 Jul 2026 17:05:00 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.137])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h1KCw4rrDz5vMM; Thu, 16 Jul 2026 17:05:00 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 468D620349F; 
 Thu, 16 Jul 2026 17:04:58 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S001c1b61445-ea3f-4dd5-bcb4-95ee901f6b87,
 816DE1EE18DD2826DFD8B9EE289546F56902E1FE) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <43f31b46-f240-41f5-8625-cf0a838bea29@kaod.org>
Date: Thu, 16 Jul 2026 19:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] hw/i2c: parent slaves created with
 i2c_slave_create_simple
To: emmanuel.blot@free.fr, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>,
 Emmanuel Blot <eblot@meta.com>, qemu-arm@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
References: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
 <20260701-i2c-adc128d818-anacapa-v5-6-fe8292d86b38@free.fr>
 <87pl0uyihl.fsf@pond.sub.org> <F7E73975-A2A2-4A5A-BBCA-40C2229FFF18@free.fr>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <F7E73975-A2A2-4A5A-BBCA-40C2229FFF18@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 1097752411443997741
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFUyQ8qo+X/8pcEUFXrZvbPK7XpWztIIWEG1pc/2q5TLnHcMcdcNCyzz5G8if0Fame94LWFzgXTLYqHMTEOTh4NNlPbPPw94pObZp9i753/NuuymM3PDGUYNYqxrlThr0imlUFcVmfIyDrhUOO0xCg1pZRXpouM/NsCopTK5d4pXw/2Iwv2+pMGcE90Bzv/j87WyIDKFe68xICEeHvJFIWVJ17R9DuX5ccPt3wYjw5RmM8LOg5d7p/NGfPJX4fwHLDyo54rrF26q6nQOZmUt0NDpzk7D+rQCmYJ0yHk5RjT/ksLxkcq/A2gJq5DER97WMfN+ZJhmFdNMmNtmU++YOgnGkk+p7Ja9crMYmIvB4ztHg+fM/P5Y2hgwP1sMn5Pz/5qeG4L3i+G+MpEJgIoNGNgdOyg3J4NTf1mf2i8jNHY0P/xPGhDed4VhigcCDimR9l1ahlVLUplgLnDzdrQa4gYU6BTltyRLC/YW6nSP7mWF8H9YgoL0CtBEawjf69MBi78HTmwxAsLNSFvo5ycHJdUxbLzWUXTOHPXG7xWkxOIaUVHkUsHvMNom3O/8vDg/G5N4Kzph2zdpltKQmynTjkz3NKDdW4kL/CX+YM8eslEC82+JIYREHkEZYl464ucCE0Tv8mBAS2T9GvgLUeJP6NztHUtvuoQgW6mpiurP1vcfQ
DKIM-Signature: a=rsa-sha256; bh=85hi8p4hjolP/Iv9Ji3QVi+aESiIuvCDqnfClFrYALs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784221502; v=1;
 b=PpaENgCDeCXE9zxyrQ1WV5Wc128x0Pwnj9m+cRUj0QOk2bwFKeHvMy0iIhbpaymfVKFi6Hiz
 ctYGm+YiIyyAzlt+8w3ZnYVNqutlyRQg1gtkOYFOfI6AvBFg+Gt6/8GOffsHfWLtW56tXPMFYUq
 BwevBxZ0y7IBgErh0w8kI816PAMvJEIVM6ISWzpPbNhUX1bsgsnuHyetofo38+JCxN8wdSpEFiw
 Z6UtpEhOnKZs+rXADMIcXAKQJha+PMO0pWEE6c4Fq0ruFPSWMFdI/jBsr2t5g20+rB/JPYzPt1r
 MGcHIVKbL9GPGvdjm5Cesf2m9p8MgCqVDLb/v30PXpD+g==
Received-SPF: pass client-ip=51.210.91.50; envelope-from=clg@kaod.org;
 helo=smtpout1.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/16/26 18:56, emmanuel.blot@free.fr wrote:
> 
> 
> On 10 Jul 2026, at 17:25, Markus Armbruster wrote:
> 
>> Emmanuel Blot <emmanuel.blot@free.fr> writes:
>>
>>> Slaves created with i2c_slave_create_simple() were left unparented and
>>> showed up under /machine/unattached with no stable QOM path. Add each
>>> slave as a QOM child of its bus, named after its I2C address, so it has
>>> a deterministic and addressable QOM path.
>>
>>> index 54f6bdca88..0bbce45d48 100644
>>> --- a/hw/i2c/core.c
>>> +++ b/hw/i2c/core.c
>>> @@ -382,6 +382,9 @@ I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr)
>>>   {
>>>       I2CSlave *dev = i2c_slave_new(name, addr);
>>>
>>> +    g_autofree char *childname = g_strdup_printf("0x%02x", addr);
>>
>> Is the hex address a satisfactory child name?
>>
> 
> Addresses are unique on a I2C bus. They are identified on the bus with their unique address, which is usually expressed as an hex integer in the datasheets. It makes the QOM path easy to interpret and use to access an I2C device, but I do not have a strong opinion on how to name them.

I tend to agree. Oarenting the device to the board seems to be
a preferred solution : 
See :

   Call to clean up QOM onboard devices lacking a parent
   https://lore.kernel.org/qemu-devel/87se5scipx.fsf@pond.sub.org/

and

   [RFC PATCH 000/134] qom: Make composition-tree parenting mandatory
   https://lore.kernel.org/qemu-devel/20260711223707.42139-1-graf@amazon.com/

Thanks,

C.

