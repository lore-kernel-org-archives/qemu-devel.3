Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED618C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzS8-0002ZA-9w; Wed, 16 Jul 2025 06:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ubzNr-0007ng-6e; Wed, 16 Jul 2025 06:29:12 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ubzNh-0005Pv-G0; Wed, 16 Jul 2025 06:29:05 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:29a1:0:640:5fbc:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 35FECC015F;
 Wed, 16 Jul 2025 13:28:50 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:748::1:e] (unknown [2a02:6bf:8080:748::1:e])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id mSJaXP0Gr8c0-O6p8sEwK; Wed, 16 Jul 2025 13:28:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1752661729;
 bh=VheFPJEX7HSPNGn/4KfSQr2XMtVdDiYl84SAO2wCj0g=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=X6xucEJG1my9XbLMhueLk2K+qxe/LmVZqC5pW6HSEH7SY1v+JYKfs+gOwBCRyJ2v4
 yfRxBiStujGRsUT33GH6VYRxmYGgFWTWFuTD/M+oP/QhXgIGF/Yx1iFK0V/zb71K7o
 51pJBsMcXlrWqWvctQrNvDcVkTlR4GnVON5reZXI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9d839afc-f34f-401a-8716-e0ed098de272@yandex-team.ru>
Date: Wed, 16 Jul 2025 13:28:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] vhost: drop backend_features
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 pbonzini@redhat.com, jasowang@redhat.com, hreitz@redhat.com,
 kwolf@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net
References: <20250703124713.2530079-1-vsementsov@yandex-team.ru>
 <20250714062807-mutt-send-email-mst@kernel.org>
 <d428a737-6733-457b-a973-28a70610c46d@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <d428a737-6733-457b-a973-28a70610c46d@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 14.07.25 22:23, Vladimir Sementsov-Ogievskiy wrote:
> On 14.07.25 13:41, Michael S. Tsirkin wrote:
>> On Thu, Jul 03, 2025 at 03:47:08PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> This field is mostly unused and sometimes confusing (we even have
>>> a TODO-like comment to drop it). Let's finally do.
>>
>> Breaks make check with UBSAN enabled:
>> 32/109 /arm/virt/virtio-mmio/virtio-bus/virtio-net-device/virtio-net/virtio-net-tests/vhost-user/flags-mismatch - ERROR:../tests/qtest/qos-test.c:189:subprocess_run_one_test: child process (/arm/virt/virtio-mmio/virtio-bus/virtio-net-device/virtio-net/virtio-net-tests/vhost-user/flags-mismatch/subprocess [9701]) failed unexpectedly FAIL
>>
>>
>>
>> https://gitlab.com/mstredhat/qemu/-/jobs/10668177755
>>
>>
>> To trigger, configure with:
>>
>> ./configure '--cc=clang' '--cxx=clang++' '--enable-ubsan' '--extra-cflags=-fno-sanitize-recover=undefined -fno-sanitize=pointer-overflow' '--target-list=arm-softmmu'
>>
>> make
>> make check
> 
> 
> Thanks for reproducer, it works for me.
> 
> 
> Hm. Seems, that because I miss that I've changed the behavior for vhost_net_ack_features():
> with may patches it doesn't include VHOST_USER_F_PROTOCOL_FEATURES (taken from backend_features) into acked_features..
> 
> And with such change:
> 
>   void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
>   {
> -    net->dev.acked_features = qemu_has_vnet_hdr(net->nc)
> -        ? 0 : (1ULL << VHOST_NET_F_VIRTIO_NET_HDR);
> +    net->dev.acked_features =
> +        (qemu_has_vnet_hdr(net->nc) ? 0 :
> +                                      (1ULL << VHOST_NET_F_VIRTIO_NET_HDR)) |
> +        (net->dev.features & (1ULL << VHOST_USER_F_PROTOCOL_FEATURES));
>       vhost_ack_features(&net->dev, vhost_net_get_feature_bits(net), features);
>   }
> 
> 
> test starts to work again.
> 
> But I can't understand, what is the relation with VHOST_USER_F_PROTOCOL_FEATURES and acked_features.
> I though, VHOST_USER_F_PROTOCOL_FEATURES make sense only for vhost <-> QEMU communication, and should
> not present in guest-negotiated acked_features..
> 
> 

UPD: undestand.

the test wants to check features mismatch, and on this code in vhost_net_init():

#ifdef CONFIG_VHOST_NET_USER
     if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
         features = vhost_user_get_acked_features(net->nc);
         if (~net->dev.features & features) {
             fprintf(stderr, "vhost lacks feature mask 0x%" PRIx64
                     " for backend\n",
                     (uint64_t)(~net->dev.features & features));
             goto fail;
         }
     }
#endif

still the only mismatching feature is VHOST_USER_F_PROTOCOL_FEATURES, which vhost_net code (before my changes) passes to acked features.

Instead of exploiting acked_features this way, we may improve this check to also check VHOST_USER_F_PROTOCOL_FEATURES, which is vhost-user-only.

I'll resend

>>
>>
>>> Vladimir Sementsov-Ogievskiy (4):
>>>    vhost: introduce vhost_ops->vhost_set_vring_enable_supported method
>>>    vhost-user: stop use backend_features
>>>    vhost_net: stop use backend_features
>>>    hw/vhost: finally drop vhost_dev.backend_features field
>>>
>>>   hw/block/vhost-user-blk.c         |  1 -
>>>   hw/net/vhost_net.c                | 14 ++++++--------
>>>   hw/scsi/vhost-scsi.c              |  1 -
>>>   hw/scsi/vhost-user-scsi.c         |  1 -
>>>   hw/virtio/vdpa-dev.c              |  1 -
>>>   hw/virtio/vhost-user.c            | 25 ++++++++++++++++---------
>>>   hw/virtio/vhost.c                 | 15 ++++++---------
>>>   hw/virtio/virtio-qmp.c            |  2 --
>>>   include/hw/virtio/vhost-backend.h |  2 ++
>>>   include/hw/virtio/vhost.h         |  7 -------
>>>   10 files changed, 30 insertions(+), 39 deletions(-)
>>>
>>> -- 
>>> 2.48.1
>>
> 

-- 
Best regards,
Vladimir


