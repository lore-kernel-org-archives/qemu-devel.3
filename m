Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5675C87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 08:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlmM-0005s9-B9; Mon, 21 Jul 2025 04:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udlm7-0005jL-7t
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1udlm4-0008NE-Ql
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753086087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhvX+7GEV0aLcmy889k9UsLnGpiciUmDAc8uXlZ+HUc=;
 b=IJ0XDJy85r1sDL/sQQhOzT4PohIsc5XXRUhOJsNSnChITSR3LQKQMNv5kpReUof4sde4qB
 jHXLh/yUiR2EQFcOytz2oWLzeAds5BqYqJV3UI5y52M4CrnT1ZABv+fVn3vc7oEOrlidkN
 eqChipff8B77ozTQ1tE2mrwlSZWuxJ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-EzKVA3dOMN27sjZW7VALpg-1; Mon, 21 Jul 2025 04:21:25 -0400
X-MC-Unique: EzKVA3dOMN27sjZW7VALpg-1
X-Mimecast-MFC-AGG-ID: EzKVA3dOMN27sjZW7VALpg_1753086084
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d30992bcso30907415e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 01:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753086084; x=1753690884;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bhvX+7GEV0aLcmy889k9UsLnGpiciUmDAc8uXlZ+HUc=;
 b=NpLv4T3N+rAdSr/TAgvSzbXIAU4AFEHooRm/RXsBtNy/BkhsZydgxJl9zSp4kJL9rq
 dtbQcErsDXGfl1uO0ikjmtilGopKrfHBm1YMy2O9OYc2n+Xau7N6XnCU0tvnlcI9WIOx
 QwAFBIYpu9PFNL8nC2nshtAvAdiKGWaZcu+QFIsxxA255bJOAmaRPPnrsfjR1jPqor5F
 zXgwrzOhpG034BsyRCUWtu4zdOpGYKwFKCBNyTwVovDSiiLtsQFuvD5OSnLA24OdldnR
 P5UNmM8v7lrqFw97nG50lIxjhwDqfun9Qz27qexRbclzsXIzDYk307MMRPSOriX+43W5
 KQ6w==
X-Gm-Message-State: AOJu0YyPr96z00N0xJPKSz8aWVRjbUhUr+NxPp7Fqds9xzWXXl6/dnOe
 ySaQ37oWdGakLwXSkncasFPoarftrnix2uEyHFF0pvYlsauzu3m/M9KJohd5z2hl6SlZS4xbEoX
 m7/sChsJye9y1dMHqaLqm82UAAcyRPzxhMYiVjgSishjturehlMO2LTHG
X-Gm-Gg: ASbGncs9N0Y13Wow4S5Mi1gml+7TQyqNzlcMTSpwTEv/fZVtd0qd8PY65DhL4ae2U+K
 a0ko59xT8+A3fqjYkoXdQndHAmDvmnpeP7RW/0oGP1IT85VPEnM4ZMU6ybi6X0PqvNvtGqvXyqA
 SVwoKJrN1CTjDp3IeETIT3Eys2HKreWLSJQwWQzeETKbM7W0D1accAZ2L0figXHldCYWrjnbBuJ
 oUHrgejn/Joeh3W1LLttVjbm301xDZwdCKQHJesWYNfCqMrf+Ub1dGZXHkHbODegl1uJSqAaTTr
 iP4zWW83RTSnSZ66Nqb+YrWUG0zMzDvPqiRIifpCYGuROk89iJ96qN8e+aBL9N1yO9hai9WBJh5
 V6OMSYIb2k9g=
X-Received: by 2002:a05:600c:8505:b0:450:cf42:7565 with SMTP id
 5b1f17b1804b1-4562ee44601mr146472425e9.23.1753086083996; 
 Mon, 21 Jul 2025 01:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLZ9XKPGWcaWIWX7kAZN/NfwrfWpjHWOmqaVniOeP9RzsI2QdODfz/40SMqoRY36pXUL/gNQ==
X-Received: by 2002:a05:600c:8505:b0:450:cf42:7565 with SMTP id
 5b1f17b1804b1-4562ee44601mr146471995e9.23.1753086083417; 
 Mon, 21 Jul 2025 01:21:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45635fe6a92sm84926175e9.2.2025.07.21.01.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 01:21:22 -0700 (PDT)
Message-ID: <92b5edaf-19d5-4691-860b-c184b440524d@redhat.com>
Date: Mon, 21 Jul 2025 10:21:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 07/13] vhost: add support for negotiating extended
 features
To: Lei Yang <leiyang@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <d3d36eaf7a68813d5f1208ffe6f85b86b654cc24.1752828082.git.pabeni@redhat.com>
 <3cm3qlpzmsnddedajhdnzgwl5govuott3mnzkeroyaglvfbbn4@devu25bxprfs>
 <CAPpAL=yQwxOKYCsFSK1p_3R7arT0oDpZmfKsD_bKf0R7tXhCNQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAPpAL=yQwxOKYCsFSK1p_3R7arT0oDpZmfKsD_bKf0R7tXhCNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/21/25 4:53 AM, Lei Yang wrote:
> On Fri, Jul 18, 2025 at 10:37 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> On Fri, Jul 18, 2025 at 10:52:33AM +0200, Paolo Abeni wrote:
>>> Similar to virtio infra, vhost core maintains the features status
>>> in the full extended format and allows the devices to implement
>>> extended version of the getter/setter.
>>>
>>> Note that 'protocol_features' are not extended: they are only
>>> used by vhost-user, and the latter device is not going to implement
>>> extended features soon.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> v2 -> v3:
>>>  - fix compile warning
>>>  - _array -> _ex
>>>
>>> v1 -> v2:
>>>  - uint128_t -> uint64_t[]
>>>  - add _ex() variant of features manipulation helpers
>>> ---
>>> hw/virtio/vhost.c                 | 73 +++++++++++++++++++++++++++----
>>> include/hw/virtio/vhost-backend.h |  6 +++
>>> include/hw/virtio/vhost.h         | 33 ++++++++++++--
>>> 3 files changed, 100 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>> index c30ea1156e..85ae1e4d4c 100644
>>> --- a/hw/virtio/vhost.c
>>> +++ b/hw/virtio/vhost.c
>>> @@ -972,20 +972,34 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
>>> static int vhost_dev_set_features(struct vhost_dev *dev,
>>>                                   bool enable_log)
>>> {
>>> -    uint64_t features = dev->acked_features;
>>> +    uint64_t features[VIRTIO_FEATURES_DWORDS];
>>>     int r;
>>> +
>>> +    virtio_features_copy(features, dev->acked_features_ex);
>>>     if (enable_log) {
>>> -        features |= 0x1ULL << VHOST_F_LOG_ALL;
>>> +        virtio_add_feature_ex(features, VHOST_F_LOG_ALL);
>>>     }
>>>     if (!vhost_dev_has_iommu(dev)) {
>>> -        features &= ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
>>> +        virtio_clear_feature_ex(features, VIRTIO_F_IOMMU_PLATFORM);
>>>     }
>>>     if (dev->vhost_ops->vhost_force_iommu) {
>>>         if (dev->vhost_ops->vhost_force_iommu(dev) == true) {
>>> -            features |= 0x1ULL << VIRTIO_F_IOMMU_PLATFORM;
>>> +            virtio_add_feature_ex(features, VIRTIO_F_IOMMU_PLATFORM);
>>>        }
>>>     }
>>> -    r = dev->vhost_ops->vhost_set_features(dev, features);
>>> +
> 
> Hi Paolo
> 
>>> +    if (virtio_features_use_extended(features) &&
>>> +        !dev->vhost_ops->vhost_set_features_ex) {
>>> +        VHOST_OPS_DEBUG(r, "extended features without device support");
>>> +        r = -EINVAL;
>>> +        goto out;
>>> +    }
> 
> As we discussed in version 2, this code should be changed to: [1],
> otherwise the problem mentioned last time will occur when compiling.
> 
> [1] if (virtio_features_use_extended(features) &&
>          !dev->vhost_ops->vhost_set_features_ex) {
> -        VHOST_OPS_DEBUG(r, "extended features without device support");
>          r = -EINVAL;
> +        VHOST_OPS_DEBUG(r, "extended features without device support");
>          goto out;
>      }

Yes, I'm sorry, something went wrong here. Likely ENOCOFFEE or similar.
Will hopefully address for good in the next revision.

Thanks,

Paolo


