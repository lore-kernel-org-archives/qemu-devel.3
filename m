Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8B8C83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQHH-0003wp-P7; Mon, 14 Jul 2025 16:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ubOll-0000X9-9t; Mon, 14 Jul 2025 15:23:30 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ubOlh-0008A5-Re; Mon, 14 Jul 2025 15:23:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 30A027E00D;
 Mon, 14 Jul 2025 22:23:08 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:741::1:36] (unknown
 [2a02:6bf:8080:741::1:36])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6NQlJB0GsKo0-oNvCNSb0; Mon, 14 Jul 2025 22:23:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1752520987;
 bh=WA9gbig5/lPzqCxaXN6XlYssxvrWUH6VeUlFI/gm4lA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Gq5dJGg/fLqQBjMXx+PDdo5JFkbjVuFVQu9KRhS59kbW09pentCc8jg+L82IrDecB
 Uw2Vh5SF3W2fgJmS7BWX6glbBopdgEvMLg5lQuQd5r4O091yeP/Ap5G3kIoR8CRVIc
 h+gHhzbAq39i+CPtHg4s1yMQRWbENMPgttqHpF74=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d428a737-6733-457b-a973-28a70610c46d@yandex-team.ru>
Date: Mon, 14 Jul 2025 22:23:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] vhost: drop backend_features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 pbonzini@redhat.com, jasowang@redhat.com, hreitz@redhat.com,
 kwolf@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net
References: <20250703124713.2530079-1-vsementsov@yandex-team.ru>
 <20250714062807-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250714062807-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 14.07.25 13:41, Michael S. Tsirkin wrote:
> On Thu, Jul 03, 2025 at 03:47:08PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> This field is mostly unused and sometimes confusing (we even have
>> a TODO-like comment to drop it). Let's finally do.
> 
> Breaks make check with UBSAN enabled:
> 32/109 /arm/virt/virtio-mmio/virtio-bus/virtio-net-device/virtio-net/virtio-net-tests/vhost-user/flags-mismatch - ERROR:../tests/qtest/qos-test.c:189:subprocess_run_one_test: child process (/arm/virt/virtio-mmio/virtio-bus/virtio-net-device/virtio-net/virtio-net-tests/vhost-user/flags-mismatch/subprocess [9701]) failed unexpectedly FAIL
> 
> 
> 
> https://gitlab.com/mstredhat/qemu/-/jobs/10668177755
> 
> 
> To trigger, configure with:
> 
> ./configure '--cc=clang' '--cxx=clang++' '--enable-ubsan' '--extra-cflags=-fno-sanitize-recover=undefined -fno-sanitize=pointer-overflow' '--target-list=arm-softmmu'
> 
> make
> make check


Thanks for reproducer, it works for me.


Hm. Seems, that because I miss that I've changed the behavior for vhost_net_ack_features():
with may patches it doesn't include VHOST_USER_F_PROTOCOL_FEATURES (taken from backend_features) into acked_features..

And with such change:

  void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
  {
-    net->dev.acked_features = qemu_has_vnet_hdr(net->nc)
-        ? 0 : (1ULL << VHOST_NET_F_VIRTIO_NET_HDR);
+    net->dev.acked_features =
+        (qemu_has_vnet_hdr(net->nc) ? 0 :
+                                      (1ULL << VHOST_NET_F_VIRTIO_NET_HDR)) |
+        (net->dev.features & (1ULL << VHOST_USER_F_PROTOCOL_FEATURES));
      vhost_ack_features(&net->dev, vhost_net_get_feature_bits(net), features);
  }


test starts to work again.

But I can't understand, what is the relation with VHOST_USER_F_PROTOCOL_FEATURES and acked_features.
I though, VHOST_USER_F_PROTOCOL_FEATURES make sense only for vhost <-> QEMU communication, and should
not present in guest-negotiated acked_features..


> 
> 
>> Vladimir Sementsov-Ogievskiy (4):
>>    vhost: introduce vhost_ops->vhost_set_vring_enable_supported method
>>    vhost-user: stop use backend_features
>>    vhost_net: stop use backend_features
>>    hw/vhost: finally drop vhost_dev.backend_features field
>>
>>   hw/block/vhost-user-blk.c         |  1 -
>>   hw/net/vhost_net.c                | 14 ++++++--------
>>   hw/scsi/vhost-scsi.c              |  1 -
>>   hw/scsi/vhost-user-scsi.c         |  1 -
>>   hw/virtio/vdpa-dev.c              |  1 -
>>   hw/virtio/vhost-user.c            | 25 ++++++++++++++++---------
>>   hw/virtio/vhost.c                 | 15 ++++++---------
>>   hw/virtio/virtio-qmp.c            |  2 --
>>   include/hw/virtio/vhost-backend.h |  2 ++
>>   include/hw/virtio/vhost.h         |  7 -------
>>   10 files changed, 30 insertions(+), 39 deletions(-)
>>
>> -- 
>> 2.48.1
> 

-- 
Best regards,
Vladimir


