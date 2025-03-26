Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161BDC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 12:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txQ3U-0004NG-KW; Wed, 26 Mar 2025 08:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1txQ3B-0004ED-JV; Wed, 26 Mar 2025 08:40:06 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1txQ35-0000BA-SI; Wed, 26 Mar 2025 08:40:02 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7F3584E6019;
 Wed, 26 Mar 2025 13:39:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id d8QRc5ugYFNh; Wed, 26 Mar 2025 13:39:49 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 67CFF4E6005; Wed, 26 Mar 2025 13:39:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6596674577C;
 Wed, 26 Mar 2025 13:39:49 +0100 (CET)
Date: Wed, 26 Mar 2025 13:39:49 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Samuel Tardieu <sam@rfc1149.net>, 
 qemu-block@nongnu.org, Patrick Leis <venture@google.com>, 
 David Hildenbrand <david@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>, 
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>, 
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org
Subject: Re: [PATCH-for-10.0 01/12] hw/audio/wm8750: Categorize and add
 description
In-Reply-To: <befafa24-f2a5-4c7c-963d-4ea89e44fb69@redhat.com>
Message-ID: <205e31d4-9dc5-dfec-f012-94b3ee9dfa2a@eik.bme.hu>
References: <20250325224310.8785-1-philmd@linaro.org>
 <20250325224310.8785-2-philmd@linaro.org>
 <892797b6-8d2f-4234-840f-e36ef94b0701@redhat.com>
 <befafa24-f2a5-4c7c-963d-4ea89e44fb69@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1374366407-1742992789=:46948"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1374366407-1742992789=:46948
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 26 Mar 2025, Thomas Huth wrote:
> On 26/03/2025 07.47, Thomas Huth wrote:
>> On 25/03/2025 23.42, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/audio/wm8750.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>> 
>>> diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
>>> index 8d381dbc658..6c1bb20fb75 100644
>>> --- a/hw/audio/wm8750.c
>>> +++ b/hw/audio/wm8750.c
>>> @@ -721,6 +721,8 @@ static void wm8750_class_init(ObjectClass *klass, void 
>>> *data)
>>>       sc->send = wm8750_tx;
>>>       dc->vmsd = &vmstate_wm8750;
>>>       device_class_set_props(dc, wm8750_properties);
>>> +    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
>>> +    dc->desc = "WM8750 Stereo CODEC";
>>>   }
>>>   static const TypeInfo wm8750_info = {
>> 
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> Looking at this twice, I think the patch is not OK in its current shape: The 
> wm8750 device now shows up twice in the output of "-device help", once in the 
> "Sound" category and once in the "Misc" category (inherited from I2C device). 
> That's somewhat ugly. I guess you'd need to remove the MISC bit here to clean 
> that up?

Maybe we could add an i2c category for those devices? But in this case it 
fits in multiple categories.

Regards,
BALATON Zoltan
--3866299591-1374366407-1742992789=:46948--

