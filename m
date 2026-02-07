Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203C3EE0ADC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 12:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vohHT-0004hj-9B; Sat, 07 Feb 2026 07:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vohHQ-0004hC-5x
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:19:16 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vohHM-0004Wz-OK
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:19:15 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1593:0:640:6beb:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A0C338083E;
 Sat, 07 Feb 2026 15:19:06 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:129::1:13] (unknown
 [2a02:6bf:8080:129::1:13])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5JOReL1AAW20-8W05PDOb; Sat, 07 Feb 2026 15:19:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770466745;
 bh=a8E+Z5PsPSnT8yuePLI8HO8JQpeHTApdYDNti2DjGKA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=xsiZWocDp1O6H7hlpKRRkzDKEYaAx5azhqOjfGflxw2An7vzYunf1fYrIEKsOuBC8
 ec2J1ZVGKo9b1DJqhxR/Vh4dfTvYj71H1UYkMLlvvp6+CmSxr2CmoYJnMWLBEZ9lb/
 9zj7wlEoHg91GORjN8YDZOCzqSRX3zBjx/77BAWo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e69d5e72-043b-4ae4-915a-4b638503fca5@yandex-team.ru>
Date: Sat, 7 Feb 2026 15:19:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user: pass GPA instead of UVA
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru
References: <20260204092339.211650-1-vsementsov@yandex-team.ru>
 <20260205031227-mutt-send-email-mst@kernel.org>
 <23c05b17-f993-48fd-bf41-06d358fd74d9@yandex-team.ru>
 <20260205033629-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260205033629-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 05.02.26 11:37, Michael S. Tsirkin wrote:
> On Thu, Feb 05, 2026 at 11:22:26AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 05.02.26 11:13, Michael S. Tsirkin wrote:
>>> On Wed, Feb 04, 2026 at 12:23:39PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> Unlike the kernel, vhost-user backend knows nothing about QEMUs
>>>> userspace addresses. We can pass GPA instead and nothing changes.
>>>>
>>>> The benefit: open the doors for further implementation of local
>>>> migration (live-update) with passing open vhost-releated FDs
>>>> through UNIX domain socket. This way the connection with backend
>>>> kept live and untouched.
>>>>
>>>> Without this change, we'll have to communicate with backend to
>>>> inform it about UVA addresses change, but better is simply use
>>>> more stable GPA numbers, like it's done for VDPA.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>    hw/virtio/vhost-user.c | 30 ++++++++++++++++++++++++++++++
>>>>    1 file changed, 30 insertions(+)
>>>>
>>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>>>> index 63fa9a1b4b..f379408c95 100644
>>>> --- a/hw/virtio/vhost-user.c
>>>> +++ b/hw/virtio/vhost-user.c
>>>> @@ -386,6 +386,24 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
>>>>        CharFrontend *chr = u->user->chr;
>>>>        int ret, size = VHOST_USER_HDR_SIZE + msg->hdr.size;
>>>> +    if (msg->hdr.request == VHOST_USER_REM_MEM_REG ||
>>>> +        msg->hdr.request == VHOST_USER_ADD_MEM_REG) {
>>>> +
>>>> +        /*
>>>> +         * In QEMU we pass guest physical addresses to vhost-user server
>>>> +         * instead of QEMUs virtual address. Server have no option to
>>>> +         * distinguesh,
>>>
>>> what does this mean? "Servers don't really care"?
>>
>> Yes. Still, we can't be sure, what servers care about. But I think, as
>> they don't have any access to QEMUs virtual address space, they can't
>> have any logic that breaks if we start to pass GPA instead of UVA
>> (imagine, that "accidentally" GPA and UVA are the same for the case).
> 
> right, just write something understandable pls.
> 
>>>
>>>> but we get a benefit: guest physical address is
>>>> +         * stable during migration, and we don't have to reset memory
>>>> +         * regions.
>>>
>>> curious if PA 0 is valid on some systems (as opposed to VA).
>>
>> Hmm, you are right, that's visible thing which differs for UVA and GPA.
>> Still, checking UVA to be non-zero on server side seems rather strange,
>> as the only use for these UVA addresses in the server is to calculate
>> offsets. The server is only interested in offsets inside given memory
>> region, not absolute UVA values.
>>
>> And we don't write in spec that UVA can't be zero, and we already use
>> GPA for VDPA.
> 
> poking at some servers to make sure can't hurt.


I can't believe it. I checked DPDK vhost-user implementation - it seems OK.

But our own vhost-user server in QEMU does this:

static bool
vu_is_vq_usable(VuDev *dev, VuVirtq *vq)
{
     if (unlikely(dev->broken)) {
         return false;
     }

     if (likely(vq->vring.avail)) {
         return true;
     }

     /*
      * In corner cases, we might temporarily remove a memory region that
      * mapped a ring. When removing a memory region we make sure to
      * unmap any rings that would be impacted. Let's try to remap if we
      * already succeeded mapping this ring once.
      */
     if (!vq->vra.desc_user_addr || !vq->vra.used_user_addr ||   <<<<<<<<<<<<<<<<<<<<
         !vq->vra.avail_user_addr) {
         return false;
     }
     if (map_ring(dev, vq)) {
         vu_panic(dev, "remapping queue on access");
         return false;
     }
     return true;
}


It really check whether the received "userspace" addresses are zero. Fantastic.

Hmm.. Seems that we need a feature flag to live without UVA addresses. In the long
run, it's better than hacking.


> 
>>>
>>>
>>>> +         *
>>>> +         * Look also at vhost_user_vq_get_addr(): like in VDPA, we pass
>>>> +         * physical addresses instead of user.
>>>> +         */
>>>> +
>>>> +        msg->payload.mem_reg.region.userspace_addr =
>>>> +            msg->payload.mem_reg.region.guest_phys_addr;
>>>> +    }
>>>> +
>>>>        /*
>>>>         * Some devices, like virtio-scsi, are implemented as a single vhost_dev,
>>>>         * while others, like virtio-net, contain multiple vhost_devs. For
>>>> @@ -3021,6 +3039,17 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
>>>>        return 0;
>>>>    }
>>>> +static int vhost_user_vq_get_addr(struct vhost_dev *dev,
>>>> +                                  struct vhost_vring_addr *addr,
>>>> +                                  struct vhost_virtqueue *vq)
>>>> +{
>>>> +    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
>>>> +    addr->desc_user_addr = (uint64_t)(unsigned long)vq->desc_phys;
>>>> +    addr->avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
>>>> +    addr->used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    const VhostOps user_ops = {
>>>>            .backend_type = VHOST_BACKEND_TYPE_USER,
>>>>            .vhost_backend_init = vhost_user_backend_init,
>>>> @@ -3059,4 +3088,5 @@ const VhostOps user_ops = {
>>>>            .vhost_supports_device_state = vhost_user_supports_device_state,
>>>>            .vhost_set_device_state_fd = vhost_user_set_device_state_fd,
>>>>            .vhost_check_device_state = vhost_user_check_device_state,
>>>> +        .vhost_vq_get_addr = vhost_user_vq_get_addr,
>>>>    };
>>>> -- 
>>>> 2.52.0
>>>
>>
>>
>> -- 
>> Best regards,
>> Vladimir
> 


-- 
Best regards,
Vladimir

