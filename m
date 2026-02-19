Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA446E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt4nd-0000fU-Es; Thu, 19 Feb 2026 09:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vt4nP-0000cY-VK; Thu, 19 Feb 2026 09:14:25 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vt4nC-0002dM-Ve; Thu, 19 Feb 2026 09:14:21 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 37E5D5969F0;
 Thu, 19 Feb 2026 15:14:00 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id q723v3alWxa0; Thu, 19 Feb 2026 15:13:57 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C832C597318; Thu, 19 Feb 2026 15:13:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C5CB6597312;
 Thu, 19 Feb 2026 15:13:57 +0100 (CET)
Date: Thu, 19 Feb 2026 15:13:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com, 
 richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] hw/virtio: add virtio_vdev_is_{modern, legacy}
In-Reply-To: <2969b605-0297-41fc-9be7-2cdbee80ccf3@linaro.org>
Message-ID: <dea7b54e-251c-6a7b-46c9-1c8b1b694338@eik.bme.hu>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
 <20260212234602.338131-2-pierrick.bouvier@linaro.org>
 <02b667c5-da6a-4829-87f1-4b9ebc53d5a4@linaro.org>
 <332a3290-9ebe-404f-8b49-d09a83bd47cb@linaro.org>
 <df5cca4c-4ea5-4284-8504-61854573435b@linaro.org>
 <2fd7fa8d-ab3e-2051-7aae-ef676ff1eb35@eik.bme.hu>
 <93c5afa3-baf8-4548-881d-d25a46e14daa@linaro.org>
 <77d787a5-75fa-5732-71bb-d120b7065013@eik.bme.hu>
 <2969b605-0297-41fc-9be7-2cdbee80ccf3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1575163501-1771510437=:78001"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1575163501-1771510437=:78001
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 18 Feb 2026, Pierrick Bouvier wrote:
> On 2/18/26 3:46 PM, BALATON Zoltan wrote:
>> On Wed, 18 Feb 2026, Pierrick Bouvier wrote:
>>> On 2/18/26 2:28 PM, BALATON Zoltan wrote:
>>>> On Wed, 18 Feb 2026, Pierrick Bouvier wrote:
>>>>> On 2/18/26 2:17 PM, Pierrick Bouvier wrote:
>>>>>> On 2/18/26 1:00 PM, Philippe Mathieu-Daudé wrote:
>>>>>>> On 13/2/26 00:46, Pierrick Bouvier wrote:
>>>>>>>> This simplifies code compared to having
>>>>>>>> virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) or
>>>>>>>> !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1).
>>>>>>>> 
>>>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>>>> ---
>>>>>>>>       include/hw/virtio/virtio-access.h |  3 +--
>>>>>>>>       include/hw/virtio/virtio.h        | 12 +++++++++++-
>>>>>>>>       hw/net/virtio-net.c               |  2 +-
>>>>>>>>       hw/virtio/vhost.c                 |  2 +-
>>>>>>>>       hw/virtio/virtio-pci.c            |  2 +-
>>>>>>>>       hw/virtio/virtio.c                | 16 ++++++++--------
>>>>>>>>       6 files changed, 23 insertions(+), 14 deletions(-)
>>>>>>> 
>>>>>>> 
>>>>>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>>>>>>> index 27cd98d2fe1..8f1e4323599 100644
>>>>>>>> --- a/include/hw/virtio/virtio.h
>>>>>>>> +++ b/include/hw/virtio/virtio.h
>>>>>>>> @@ -468,9 +468,19 @@ static inline bool
>>>>>>>> virtio_host_has_feature(VirtIODevice *vdev,
>>>>>>>>           return virtio_has_feature(vdev->host_features, fbit);
>>>>>>>>       }
>>>>>>>>       +static inline bool virtio_vdev_is_modern(const VirtIODevice
>>>>>>>> *vdev)
>>>>>>>> +{
>>>>>>>> +    return virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline bool virtio_vdev_is_legacy(const VirtIODevice *vdev)
>>>>>>>> +{
>>>>>>>> +    return !virtio_vdev_is_modern(vdev);
>>>>>>>> +}
>>>>>>> 
>>>>>>> With retrospective, mentioning 'modern' was a mistake IMHO. But I
>>>>>>> understand it was simpler to add 'modern' code without updating the
>>>>>>> 'legacy' code base. Today I'd rather have 'legacy' explicit in 
>>>>>>> function
>>>>>>> names, everything else being the normal / current / modern version,
>>>>>>> without having to clarify it.
>>>>>>> 
>>>>>> 
>>>>>> Agree.
>>>>>> 
>>>>>>> Thus back to this series I'd rather not introduce 
>>>>>>> virtio_vdev_is_modern
>>>>>>> and use !virtio_vdev_is_legacy instead.
>>>>>> 
>>>>>> Sounds good. I feel it's still easier and clearer to read than
>>>>>> "!has_feature(1.0)". But as said in my previous answer to Zoltan, I
>>>>>> don't mind this patch too much, only 3rd one really matter.
>>>>> 
>>>>> s/!has_feature(1.0)/has_feature(1.0), thus showing I've been confused 
>>>>> once
>>>>> more :).
>>>> 
>>>> The has_feature(1.0) is more specific though. What if 1.0 becomes legacy
>>>> too? Then modern and legacy is more confusing than testing for a specific
>>>> feature. I still think not touching this would be the easiest as the
>>>> introduced legacy/modern does not seem to make it much clearer.
>>>> 
>>> 
>>> As you can find in official Virtio spec, "legacy" is not a random name or
>>> something I personally chose, it's the official term for pre 1.0
>>> devices/interfaces.
>>> 
>>> https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-60001
>>> 
>>> ```
>>> 1.3.1 Legacy Interface: Terminology
>>> 
>>> Legacy Interface
>>> is an interface specified by an earlier draft of this specification 
>>> (before
>>> 1.0)
>>> 
>>> Legacy Device
>>> is a device implemented before this specification was released, and
>>> implementing a legacy interface on the host side
>>> ```
>>> 
>>> So even if VirtIO 2.0 comes out one day, they will have to define or 
>>> change
>>> term accordingly.
>> 
>> OK in that case it's better but modern would still be ambiguous. But as I
>> said I think current test for feature is OK in my opinion. That's all I
>> can add to this.
>> 
>>> Your comments are welcome also on patch 3 by the way.
>> 
>> Sorry I can't comment on that as I don't know this code. I also don't use
>> virtio with PPC machines but I know some people use it so they'll probably
>> complain if this broke something.
>> 
>
> I did my fair share of tests, including reproducing a ppc64el environment to 
> make sure migration was not broken. I hope someone comfortable with this can 
> give a reviewed-by and that Michael will happily pick the patch.
>
>> But maybe everybody uses current virtio now and the old one is only there
>> for compatibility. Is this maybe referenced from hw/core/machine.c in a
>> compatibility property that could be removed or is it user settable and
>> still supported? There was another thread on these compatibility
>> properties and adding a way to mark and deprecate compatibility properties
>> for easier removal but that did not end yet. You'd probably just want to
>> make this series do the least changes needed and then move on.
>> 
>
> Philippe went down this way, trying to remove legacy support completely, but 
> the community answered it had to stay and could not be deprecated/removed. 
> This position might change in the future, but we need to find a solution now 
> to remove target specifics, thus the current solution.

I don't know if that's related but in hw/core/machine.c:

GlobalProperty hw_compat_5_0[] = {
...
     { "virtio-device", "x-disable-legacy-check", "true" },
};

And the oldest visible machine is now 5.1 with everything older than 8.0 
deprecated due to auto deprecation. But we're behind with removing older 
code which is now at 2.8 so maybe we're deprecating things faster than we 
can remove and clean up old code so that may cause users problems before 
the code can benefit from it. Maybe we could slow down with auto 
deprecation until removal of old machine is catching up?

Regards,
BALATON Zoltan
--3866299591-1575163501-1771510437=:78001--

