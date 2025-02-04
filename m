Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90D8C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfFhi-00014a-3E; Tue, 04 Feb 2025 04:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tfFhg-00014C-L1; Tue, 04 Feb 2025 04:58:48 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tfFhe-0007iS-LI; Tue, 04 Feb 2025 04:58:48 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D33B44E601A;
 Tue, 04 Feb 2025 10:58:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id fUcay_nW9171; Tue,  4 Feb 2025 10:58:39 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EB5774E6013; Tue, 04 Feb 2025 10:58:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E905674577C;
 Tue, 04 Feb 2025 10:58:39 +0100 (CET)
Date: Tue, 4 Feb 2025 10:58:39 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, 
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>, 
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 11/12] hw/arm/raspi: Deprecate old raspiX machine names
In-Reply-To: <e32a54f2-ef46-4964-89d4-a8969b6d1b05@linaro.org>
Message-ID: <1ec3cd49-7fe8-9c80-212d-68939580b8ce@eik.bme.hu>
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-12-philmd@linaro.org>
 <CAFEAcA-3JJ1tZAXsik5hAonuSO9sCqDF1xqPQVhAeN-XwAAhDw@mail.gmail.com>
 <e32a54f2-ef46-4964-89d4-a8969b6d1b05@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1784103270-1738663119=:54447"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1784103270-1738663119=:54447
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 4 Feb 2025, Philippe Mathieu-Daudé wrote:
> On 4/2/25 10:22, Peter Maydell wrote:
>> On Tue, 4 Feb 2025 at 00:23, Philippe Mathieu-Daudé <philmd@linaro.org> 
>> wrote:
>>> 
>>> All previous raspi machines can be created using the
>>> generic machine. Deprecate the old names to maintain
>>> a single one. Update the tests.
>>> 
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> 
>>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>>> index 4a3c302962a..c9a11a52f78 100644
>>> --- a/docs/about/deprecated.rst
>>> +++ b/docs/about/deprecated.rst
>>> @@ -257,6 +257,19 @@ Big-Endian variants of MicroBlaze ``petalogix-ml605`` 
>>> and ``xlnx-zynqmp-pmu`` ma
>>>   Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for little 
>>> endian
>>>   CPUs. Big endian support is not tested.
>>> 
>>> +ARM ``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b`` and 
>>> ``raspi4b`` machines (since 10.0)
>>> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>>> +
>>> +The Raspberry Pi machines have been unified under the generic ``raspi`` 
>>> machine,
>>> +which takes the model as argument.
>>> +
>>> +    - `raspi0`` is now an alias for ``raspi,model=Zero``
>>> +    - `raspi1ap`` is now an alias for ``raspi,model=1A+``
>>> +    - `raspi2b`` is now an alias for ``raspi,model=2B``
>>> +    - `raspi3ap`` is now an alias for ``raspi,model=3A+``
>>> +    - `raspi3b`` is now an alias for ``raspi,model=3B``
>>> +    - `raspi4b`` is now an alias for ``raspi,model=4B``
>> 
>> This is not how we typically handle "we have a bunch
>> of different devboards in one family". What's wrong with the
>> existing set of machine names?
>
> Zoltan and you don't want to add more machine names, then you
> don't want a generic machine. This is very confusing.

I said either rastpi4b,revision=1.4 or -machine raspi4b -memory 4g would 
be better IMHO. Peter perefers -memory which is also fine with me. I just 
don't think adding more machine names where only RAM size is different 
would be better than using -memory for that as usual.

Regards,
BALATON Zoltan

> See previous patch:
>
>  $ qemu-system-aarch64 -M raspi,model=help
>  Available models (processor):
>  - A          (BCM2835)
>  - B          (BCM2835)
>  - A+         (BCM2835)
>  - B+         (BCM2835)
>  - CM1        (BCM2835)
>  - Zero       (BCM2835)
>  - ZeroW      (BCM2835)
>  - 2B         (BCM2836)
>  - 3B         (BCM2837)
>  - CM3        (BCM2837)
>  - 3B+        (BCM2837)
>  - 3A+        (BCM2837)
>  - CM3+       (BCM2837)
>  - 4B         (BCM2838)
>
> Can we or not add the other raspi models?
>
>> Can we implement "support more than just the fixed amount
>> of RAM" by making '-m 2G' work, without changing the
>> machine names at all, please?
>
> We surely can if we find developers motivated to do the work.
>
> Regards,
>
> Phil.
>
>
--3866299591-1784103270-1738663119=:54447--

