Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E70E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 22:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsq2D-0008Bh-P4; Wed, 18 Feb 2026 17:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vsq2B-00089Y-UM; Wed, 18 Feb 2026 17:28:39 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vsq29-0000NZ-Sn; Wed, 18 Feb 2026 17:28:39 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D5F975969FC;
 Wed, 18 Feb 2026 23:28:32 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 93FBJzqbhzrs; Wed, 18 Feb 2026 23:28:30 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BEA845969F4; Wed, 18 Feb 2026 23:28:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B855A5969F0;
 Wed, 18 Feb 2026 23:28:30 +0100 (CET)
Date: Wed, 18 Feb 2026 23:28:30 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com, 
 richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] hw/virtio: add virtio_vdev_is_{modern, legacy}
In-Reply-To: <df5cca4c-4ea5-4284-8504-61854573435b@linaro.org>
Message-ID: <2fd7fa8d-ab3e-2051-7aae-ef676ff1eb35@eik.bme.hu>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
 <20260212234602.338131-2-pierrick.bouvier@linaro.org>
 <02b667c5-da6a-4829-87f1-4b9ebc53d5a4@linaro.org>
 <332a3290-9ebe-404f-8b49-d09a83bd47cb@linaro.org>
 <df5cca4c-4ea5-4284-8504-61854573435b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1648360936-1771453710=:88784"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-1648360936-1771453710=:88784
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 18 Feb 2026, Pierrick Bouvier wrote:
> On 2/18/26 2:17 PM, Pierrick Bouvier wrote:
>> On 2/18/26 1:00 PM, Philippe Mathieu-Daudé wrote:
>>> On 13/2/26 00:46, Pierrick Bouvier wrote:
>>>> This simplifies code compared to having
>>>> virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) or
>>>> !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1).
>>>> 
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>     include/hw/virtio/virtio-access.h |  3 +--
>>>>     include/hw/virtio/virtio.h        | 12 +++++++++++-
>>>>     hw/net/virtio-net.c               |  2 +-
>>>>     hw/virtio/vhost.c                 |  2 +-
>>>>     hw/virtio/virtio-pci.c            |  2 +-
>>>>     hw/virtio/virtio.c                | 16 ++++++++--------
>>>>     6 files changed, 23 insertions(+), 14 deletions(-)
>>> 
>>> 
>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>>> index 27cd98d2fe1..8f1e4323599 100644
>>>> --- a/include/hw/virtio/virtio.h
>>>> +++ b/include/hw/virtio/virtio.h
>>>> @@ -468,9 +468,19 @@ static inline bool 
>>>> virtio_host_has_feature(VirtIODevice *vdev,
>>>>         return virtio_has_feature(vdev->host_features, fbit);
>>>>     }
>>>>     +static inline bool virtio_vdev_is_modern(const VirtIODevice *vdev)
>>>> +{
>>>> +    return virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
>>>> +}
>>>> +
>>>> +static inline bool virtio_vdev_is_legacy(const VirtIODevice *vdev)
>>>> +{
>>>> +    return !virtio_vdev_is_modern(vdev);
>>>> +}
>>> 
>>> With retrospective, mentioning 'modern' was a mistake IMHO. But I
>>> understand it was simpler to add 'modern' code without updating the
>>> 'legacy' code base. Today I'd rather have 'legacy' explicit in function
>>> names, everything else being the normal / current / modern version,
>>> without having to clarify it.
>>> 
>> 
>> Agree.
>> 
>>> Thus back to this series I'd rather not introduce virtio_vdev_is_modern
>>> and use !virtio_vdev_is_legacy instead.
>> 
>> Sounds good. I feel it's still easier and clearer to read than
>> "!has_feature(1.0)". But as said in my previous answer to Zoltan, I
>> don't mind this patch too much, only 3rd one really matter.
>
> s/!has_feature(1.0)/has_feature(1.0), thus showing I've been confused once 
> more :).

The has_feature(1.0) is more specific though. What if 1.0 becomes legacy 
too? Then modern and legacy is more confusing than testing for a specific 
feature. I still think not touching this would be the easiest as the 
introduced legacy/modern does not seem to make it much clearer.

Regards,
BALATON Zoltan
--3866299591-1648360936-1771453710=:88784--

