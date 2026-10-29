Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62595606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=lDPg0+Cn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMLdV-0004qe-8b; Thu, 29 Oct 2026 04:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xMLdT-0004qF-NL
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:37:23 -0400
Received: from smtpout2.mo537.mail-out.ovh.net ([51.210.91.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xMLdR-00017Q-3z
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:37:23 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4jFczd1Kq7z3x2R;
 Thu, 29 Oct 2026 08:37:16 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 29 Oct 2026 08:37:16 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.231.92])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jFczc3PLSz46Xc; Thu, 29 Oct 2026 08:37:16 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 4DD17203621; 
 Thu, 29 Oct 2026 08:37:15 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R00644afe926-e354-4dba-8d83-d731e951cea0,
 5A664F180DA3A669278262F6C36EE325C28E6E12) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <45822012-fd39-4263-a8de-d66a440d1061@kaod.org>
Date: Thu, 29 Oct 2026 09:37:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/i2c: add dummy device
To: Timur Maksimov <gessingate@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v2-1-07deed1dff60@gmail.com>
 <2629ee8a-e817-4764-a1e3-72e0ccbb978b@kaod.org> <874ie6ku2u.fsf@pond.sub.org>
 <5d219f231fb1f97c6d90cbef4068e82dff803a18.camel@gmail.com>
 <87pkwtezsz.fsf@pond.sub.org>
 <c850cbe681b0328cf3c3f93140132f8363e253e2.camel@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <c850cbe681b0328cf3c3f93140132f8363e253e2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 413205266012220461
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG1CBEXcx89SLTHhTWkWv+wkDSK4OAsKXqQg5rgLwzaOUGcIm39uJ2GgS/bvVr27G5D8qlKrlniD86EzCie34siCE5TIyl8zsWebR19gMufaieW8hy7BbORR28Y+VQ6EiEhCS2863wL8JR6Tl4B5QWrgBUehSRnEBEdBUzSfliDj8nJSWWvISGylRSdKmciB+xFCO9YCZ88Yy07Gqy+RoblTL0GFJSM0f6GZjkiIaWz8bJi3LNDgoiDcqIlaV1FCUq28DDzY/29GPH4l4Z9xkr9VNj26eaNwrzNCLyjKYbA8b9NuMy3bqdOJMPrLfMJa7QK/nD3IS+Z/cTlwBK9a+DzgaI9w2bNAxy1S+cb600ot6bxX5seIXL4NRc9o8ktbwxbfQeVDAeezhAV9sACxFOmHJAqUSTcQfNtMazixtjpngcltGy3TSv8vPYFyqoJaAAvFIF2mcNX3H76RvPeB/OAVCwGTKSDCcvXk6Fc7M1dsL6Ea4AG0hTwG8SwOV+7TYswAvoWvpZPfY0iuMn2kvwDgRKmOai+ms0a2Zvskz6SUTAJ6QR2Bq0I+1lG3v0eaCOi8VGbY4wJFeSxVdpOUVc+RXE9qOCrkce73TqsbF34wxT2NXWond73EaY3X/oAIOMyleN77GCgH99Fc/awrxqkjUDgGnOQag4VFkNsZr15Rw
DKIM-Signature: a=rsa-sha256; bh=ZrNCYqlRtyzvk4GAg5G0D4sC29ADbsM6e9/uELH6kaY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1793263038; v=1;
 b=lDPg0+Cn6vwPbOfPFvE/zhKBon9X3c1ls2RTCv8XmJIczQFrThDB14l+WO+uPR7C1LEubfyz
 Z9D1YvcdS71mUei+yJ8Vyhm1YdCvBm+OwNZRO+L+FsbW5bVMDTViQpCHy+VwNiB0zeZCp1EdbfA
 hMzlu/v4I5nCLUsfQhOibRvW5iuGQROJZcfVLPhBxTuE3Sb0lMWE6ef/UXVa75q5eXrxu4H9UsN
 YHliwJc1yW+eEcHr2FgsB89hjJMQe545CXf40zJMOw/LS/6CcOZkItAPLLeIhCbdSJqxRyi/b3L
 zF2vbUcMVp6pID1B88JrA8cijT63ovF97F03Vmo1pdKnw==
Received-SPF: pass client-ip=51.210.91.21; envelope-from=clg@kaod.org;
 helo=smtpout2.mo537.mail-out.ovh.net
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 09:20, Timur Maksimov wrote:
> Hi, Markus
> 
> On Thu, 2026-10-29 at 08:22 +0100, Markus Armbruster wrote:
>> Timur Maksimov <gessingate@gmail.com> writes:
>>
>>> Hi, thanks for the review.
>>>
>>> It was my decision to use such API, I thought it would be okay for
>>> a
>>> test device. I don't think there is a way to expose integer array
>>> as a
>>> single QOM property.
>>
>> There are ways, but I need to know what you're trying to accomplish
>> to
>> be able to provide guidance.
> 
> We need to access the transfer buffer array with QOM. Actually, I have
> a few ideas on how to do this without cluttering the QOM with
> properties, such as using a FIFO interface.
>>
>>> Actually, we can go without this model. I suppose I will rewrite
>>> tests
>>> so they don't use it.
>>
>> You haven't answered my question on code-provenance.rst.
>>
>>> On Wed, 2026-10-28 at 11:17 +0100, Markus Armbruster wrote:
>>>> Cédric Le Goater <clg@kaod.org> writes:
>>>>
>>>>> + Corey for I2C feed back.
>>>>>
>>>>> + Markus for QOM
>>>>>
>>>>> The brute-force solution to expose the contents of the device
>>>>> array
>>>>> with 128 properties has a slight AI smell. I find it ugly but I
>>>>> am
>>>>> human :)
>>>>
>>>> Timur, have you read docs/devel/code-provenance.rst section "Use
>>>> of
>>>> AI-generated content"?
>>>>
>>>>>           That said I don't know if there are better
>>>>> alternatives.
>>
>> [...]
> 
> Sorry. Yes, I have read it. This is solely my work, no AI was used to
> write it.
> 
> I also have a question about MAINTAINERS file. If we keep this device,
> where should I put this file?

You can put it under Aspeed for now, since it will be only used by
Aspeed machines for tests. If it grows, I guess we should move it
under "I2C and SMBus" if Corey agrees.

Thanks,

C.

