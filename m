Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5398AC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 10:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uciKF-000304-Pi; Fri, 18 Jul 2025 06:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uciKC-0002wY-9X
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 06:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uciKA-00068D-Hw
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 06:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752834496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KCUWHZvWUFTEiuVCSKBZ7fDqaqvHkAkknvw7+1o0IdM=;
 b=Xx5RsmQCYjFlOhgGNtwAzLLTLmqWyTWWzA+nkHutX0s1hjiz/4FMAElm39IA2FwJMe5W8i
 rh+gHepWjAZaNOMb1UpiHfe9Q34DhTtno3wocmy8jAJj+3dw7O32B7JhfKhnDZBbRBh8je
 kvtXWgkAI1g2oZ9QKhbKVazu9Pf1mlY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-i3T6BTBaMe6-9s-a_wWhIQ-1; Fri, 18 Jul 2025 06:28:15 -0400
X-MC-Unique: i3T6BTBaMe6-9s-a_wWhIQ-1
X-Mimecast-MFC-AGG-ID: i3T6BTBaMe6-9s-a_wWhIQ_1752834495
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fb01bb5d9aso26785466d6.3
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 03:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752834495; x=1753439295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KCUWHZvWUFTEiuVCSKBZ7fDqaqvHkAkknvw7+1o0IdM=;
 b=i6pPyzZ8rnUBJmSnzyBFkELhpBsuByvapr0d0QJCXsoyDhELHB/2R/gzvqXLtR9yea
 4Vbv/8+8o7AdVV0WA9UB4OW2hYiZdK68eY0X4SsSZBjOyftZY2E0ePxOm3/5rBmkhjVW
 O40to4XyG4V7U4heYUZZU2Ym9DZcaXwlkyCy15hiTJ1uKwVkDEHpIzWS3SWAHmKP1+hC
 j3OP2AY0hBoSs/dflXTjoI+Bp9djJHX+txJ0vbVrAyK1g6f3RE5R8h5Z+Kz74bjYbr0Y
 6vsGgke+eclcYE3byCMY/gng5vrYz32aL0nLT+GvJj2rOe2YNMnMr7UBqL8c+qGGnj3B
 6BNw==
X-Gm-Message-State: AOJu0YwPiGtEMS7UIp6qc1ExGKmU0Ry4OFf6sfZrYxBNSaYaPRsOQiSJ
 ce8gUcPgqWbjvMBpLUfkVL4c4+uuIjSsOyiXCXX9C5qVyKOG9htoj0K7ktsqCVIcQWqWeV3pz/O
 MCbdLntiByYX4d7st0IJ+TvFGuxSbQkPZrd2gAmAYhlk0xl3Bz9JxeCq5
X-Gm-Gg: ASbGncuU3/KHPq1PZmqHg9DV0tCzTFZ/ipK/0WHbAHnXLeZGOxdHOJBQsikHS2Ixj5F
 Or/c6Y22HXylFCMnMXI+eo9c3sCgtzfsPmSaarfalzx7ZmphK68gmhRlJbtM6xSiZB+tTCFvkTv
 UqusGHCgpeV1PgcbDJh1P+P+vuWkB9MECkaYgxVB/0TNajGlCG40ErsWNCPJ++GT3LgbtprqlkV
 vK6n0xhU1nvHBJiaJLLwkD5baprMrmmiN+HfwYbWvUddYMteucL3+nmgOjrMuwQp/jqqetiSNSX
 clHyWaRJQKYxDGicZTPCFjZvAxLCjsbcSkryd3rh1CIGP38cZGi48fpd9sjbHyaxRfCpiqxzb1a
 L2eVRVozVHe2YB4I=
X-Received: by 2002:a05:6214:4283:b0:704:7df7:c1a0 with SMTP id
 6a1803df08f44-704f47fa4bemr180802756d6.7.1752834494695; 
 Fri, 18 Jul 2025 03:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNEqh+cBaafO4OlGYjldZIYmK3zY47yOzBlzxa4/z3Q6+yaqezpXSk9TFcdLP7APQ0Aq4bFA==
X-Received: by 2002:a05:6214:4283:b0:704:7df7:c1a0 with SMTP id
 6a1803df08f44-704f47fa4bemr180802276d6.7.1752834494138; 
 Fri, 18 Jul 2025 03:28:14 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051ba6b728sm5800316d6.69.2025.07.18.03.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 03:28:13 -0700 (PDT)
Date: Fri, 18 Jul 2025 12:28:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH RFC v3 08/13] qmp: update virtio features map to support
 extended features
Message-ID: <747yl6magfb5cvwdk72mwukafp6xdzhyc3ovmsmixxcewos6xx@hb45y3knbg7i>
References: <cover.1752828082.git.pabeni@redhat.com>
 <8a42515171c651101aa487519fbbc53dbe4c4c29.1752828082.git.pabeni@redhat.com>
 <5vwmpqfuwdo66kydy7k45fmps2jtgawwsan6bd2ipzs6v5j3lo@cuoibjphppck>
 <8842b61b-eb9b-4484-ab5d-0dda9642cb02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8842b61b-eb9b-4484-ab5d-0dda9642cb02@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Jul 18, 2025 at 12:23:21PM +0200, Paolo Abeni wrote:
>On 7/18/25 12:18 PM, Stefano Garzarella wrote:
>> On Fri, Jul 18, 2025 at 10:52:34AM +0200, Paolo Abeni wrote:
>>> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
>>> index 3b6377cf0d..03c6163cf4 100644
>>> --- a/hw/virtio/virtio-qmp.c
>>> +++ b/hw/virtio/virtio-qmp.c
>>> @@ -325,6 +325,20 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
>>>     FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
>>>             "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
>>>             "negotiation supported"),
>>> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, \
>>> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
>>> +            "UDP tunnel packets"),
>>> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, \
>>> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
>>> +            "UDP tunnel packets requiring checksum offload for the outer "
>>> +            "header"),
>>> +    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, \
>>> +            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
>>> +            "UDP tunnel packets"),
>>> +    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, \
>>> +            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
>>> +            "UDP tunnel packets requiring checksum offload for the outer "
>>> +            "header"),
>>
>> Is this chunk supposed to be here in this patch or better in the last
>> patches where you add UPD tunnel features support?
>
>Note that this point was discussed in the previous iteration:
>
>https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg04418.html

Ops, sorry, I skiped that version and came directly here.
I'll check the v3.

>
>I think it could be both way: it could be useful for QMP to be able to
>dump the (kernel/backend) features in human readable format even if qemu
>does not support them.

I see.

>
>No big objection to move the above chunk in patch 13/13, if there is
>agreement :)

Not a strong opinion here.

Thanks,
Stefano


