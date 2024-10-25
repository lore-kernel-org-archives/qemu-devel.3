Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FB7D11704
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 06:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4EEP-0002Ya-7a; Fri, 25 Oct 2024 02:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hdtb=RV=kaod.org=clg@ozlabs.org>)
 id 1t4EEM-0002Xu-Be; Fri, 25 Oct 2024 02:55:30 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hdtb=RV=kaod.org=clg@ozlabs.org>)
 id 1t4EEK-0001QP-5c; Fri, 25 Oct 2024 02:55:30 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XZYSg2TBqz4w2K;
 Fri, 25 Oct 2024 17:55:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XZYSb5cSCz4wyk;
 Fri, 25 Oct 2024 17:55:11 +1100 (AEDT)
Message-ID: <07664ec3-6b46-4b27-9d8c-9e2ff34c9dbe@kaod.org>
Date: Fri, 25 Oct 2024 08:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: Add collie and sx functional tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, Jan Luebbe <jlu@pengutronix.de>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <dcf06645-dac0-4099-8946-38ca9deaeccf@redhat.com>
 <ec2cb5e8-77be-435e-8aa7-4314cf412c4d@redhat.com>
 <CAFEAcA8MY8DWABNuYuzH57k-nv3J4s0eMR=FuRt1TVd8P2GU2g@mail.gmail.com>
 <a65a224e-4f54-436d-b555-734a8926d941@roeck-us.net>
 <aa7755a2-e6fa-4d23-bcac-a630e6da98db@linaro.org>
 <d9f18091-aee1-4b32-ba72-e1028fe433c9@roeck-us.net>
 <5262a33d-d0c5-452b-9869-f8f482b1c857@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <5262a33d-d0c5-452b-9869-f8f482b1c857@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=hdtb=RV=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/24/24 19:59, Philippe Mathieu-Daudé wrote:
> Cc'ing Jan.
> 
> On 22/10/24 12:04, Guenter Roeck wrote:
>> On 10/21/24 21:09, Philippe Mathieu-Daudé wrote:
>>> Hi Guenter,
>>>
>>> On 21/10/24 11:02, Guenter Roeck wrote:
>>>
>>>> Unrelated to this, but I found that the sd emulation in 9.1 is also broken
>>>> for loongarch and sifive_u, and partially for ast2600-evb (it has two
>>>> controllers, with one of them no longer working). That is too much for me
>>>> to track down quickly, so this is just a heads-up.

It would greatly help if we could merge some of your testsuite under QEMU.


>>> Please Cc me with reproducer or assign Gitlab issues to me,
>>> I'll have a look.
>>>
>>
>> If it wasn't funny, it would be sad.
>>
>> hw/sd/sd.c:sd_reset() calls sd_bootpart_offset() t determine the boot partition
>> offset. That function needs to have sd->ext_csd[EXT_CSD_PART_CONFIG] configured.
>> However, the value is only set later in sd_reset() with the call to sc->set_csd().
>> One of the parameters of that function is the previously calculated size.
>>
>> So in other words there is a circular dependency. The call to sd_bootpart_offset()
>> returns 0 because sd->ext_csd[EXT_CSD_PART_CONFIG] isn't set, then
>> the call to sc->set_csd() sets it ... too late. Subsequent calls to
>> sd_bootpart_offset() will then return the expected offset.

oh. I didn't realize that :/ I guess we only tested our own scenario when
we were working on the ast2600 bringup.

I think the change in the reset handler should be :

-    size -= sd_bootpart_offset(sd);
+    if (sd_is_emmc(sd)) {
+        size -= sd->boot_part_size * 2;
+    }


Thanks,

C.



>> I have no idea how this is supposed to work, and I don't think it works
>> as implemented. I'll revert commit e32ac563b83 in my local copy of qemu.
> > Jan, can you have a look at this bug report please? Otherwise I'll
> have a look during soft freeze.
> 
> Regards,
> 
> Phil.
> 


