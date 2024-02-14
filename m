Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0707C4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 07:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra9OE-0003Wp-Cs; Wed, 14 Feb 2024 02:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=AQUf=JX=kaod.org=clg@ozlabs.org>)
 id 1ra9OC-0003Wb-I0; Wed, 14 Feb 2024 02:09:04 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=AQUf=JX=kaod.org=clg@ozlabs.org>)
 id 1ra9OA-000876-42; Wed, 14 Feb 2024 02:09:04 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TZTnd6jvSz4wcl;
 Wed, 14 Feb 2024 18:08:53 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TZTnb16NMz4wcF;
 Wed, 14 Feb 2024 18:08:50 +1100 (AEDT)
Message-ID: <cd75772d-e892-4315-b97a-579b593a2cd0@kaod.org>
Date: Wed, 14 Feb 2024 08:08:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/arm/stellaris: Add missing QOM 'SoC' parent
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
References: <20240130190317.25692-1-philmd@linaro.org>
 <20240130190317.25692-5-philmd@linaro.org>
 <CAFEAcA9V7wQr=LEvv2DYT5SabPe2H3+V2RMQPHRVZ8avrse9ww@mail.gmail.com>
 <7e7646e7-85d1-40a4-8e5e-bca2fcaa6ba5@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <7e7646e7-85d1-40a4-8e5e-bca2fcaa6ba5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=AQUf=JX=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/13/24 16:36, Philippe Mathieu-Daudé wrote:
> On 1/2/24 17:46, Peter Maydell wrote:
>> On Tue, 30 Jan 2024 at 19:03, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>
>>> QDev objects created with qdev_new() need to manually add
>>> their parent relationship with object_property_add_child().
>>>
>>> Since we don't model the SoC, just use a QOM container.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>
>> Ah, this is where the other qdev_new() calls are sorted.
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> I wonder if we should add a variant on qdev_new() that
>> you can pass in the parent object to?
> 
> Yes, this is what we discussed with Markus. In order to
> stop using the "/unattached" container from pre-QOM,
> qdev_new() must take a QOM parent. I tried to do it but hit
> some problem with some odd use in PPC or S390 (discussed
> with Cédric so likely PPC, I need to go back to it).

Can you remind what this was about ?


Thanks,

C.



