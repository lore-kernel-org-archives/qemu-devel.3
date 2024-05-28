Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EDFC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByoi-0004M2-Cx; Tue, 28 May 2024 11:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sByog-0004LP-7o
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sByoe-0003WT-1r
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716910361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQYzV8+rnwRE6otz4sKcjy11R0UGgMrdrlJKihkLPh4=;
 b=bGfH6Vyi5LNdk3PMuVrv6qPwcclIuS6DTi+pdQ+KS+aPYtslRmyGupbtOcL4wMKYTI8Rvv
 A0GNketxnbfFt5gTa8mQaMoBv0pD+FTPxmdm3R1kmMIPCOx4Sx5UULh015M49aC8GKKyZV
 YX/PdPWpnEQ7rALpWxeBsJVAXOrqBqE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-QWChCJ0RPvu75AJ5QhZJWw-1; Tue, 28 May 2024 11:32:40 -0400
X-MC-Unique: QWChCJ0RPvu75AJ5QhZJWw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-354ddb92ad8so577107f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716910351; x=1717515151;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQYzV8+rnwRE6otz4sKcjy11R0UGgMrdrlJKihkLPh4=;
 b=FhHXv224pY8isMORuALvp+WQOInJHLIq+bYF8Uqp+zd0QcttwneoZ7G0UoBmyZj1b2
 cGkZ/jvS0PCA0QMQ+T/RNpYxCj6OBnesHxHEkyGmq5Z7hUeo/hw68qY83Ma81YquQgBt
 1cyWZcqc8U6PvhBMybtykbTDkWaIV32JX8qXZopgUWWp7gaEaAZoN4oAB46QNup025ha
 asmwWsXaXA3mBCAlCvbkEdIuhe8l0zvE/APSEWbPFvtqM0JPVKMflw7+M9f1zyWAtCt4
 OCJCm+eO/QEKUyaFc3sg7LdYXOw3VS2ZzoC6Mgqf6MjiBOEZmJMTM5whu6ESlQe/Z8UQ
 MqyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWorp9ZrJ7IYXv9b8oU3IYlxNCmLiDzHsmdvx9LwuVDzFjZWiEI/87j76kRzJ60aJksc0rv58OehDMmjfcUkdJ3r/xj4Pk=
X-Gm-Message-State: AOJu0Yyo3SjLuhUW3EnoZwSSI4IiU7d94T/btFWX44uAL6LKbewFv/1g
 KJ3y5IGaxvX6VQ3nVcnUPUfLIJ95QBvbv4VUn0EwcHfvGvU/PzyK7p+GFZImrWoGGFXIfQX5tV7
 En1eBqKy0V3yDlThqH9ScNYEJf+XUxvrPgZvzTxuRtVKvcEkhdI9s
X-Received: by 2002:adf:ce91:0:b0:351:dab1:1c72 with SMTP id
 ffacd0b85a97d-3552fe19370mr7599684f8f.47.1716910350880; 
 Tue, 28 May 2024 08:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+EjJbYml9ZPC1EA4nrJl4u7loDzN/rMkcvHeIKA6mRGkBXRNj6/MHL15gIjJC+iJKkn6TJg==
X-Received: by 2002:adf:ce91:0:b0:351:dab1:1c72 with SMTP id
 ffacd0b85a97d-3552fe19370mr7599660f8f.47.1716910350510; 
 Tue, 28 May 2024 08:32:30 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7db23sm12333075f8f.23.2024.05.28.08.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 08:32:30 -0700 (PDT)
Date: Tue, 28 May 2024 17:32:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Marc Hartmayer <mhartmay@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>
Subject: Re: [PATCH 1/1] vhost-vsock: add VIRTIO_F_RING_PACKED to feaure_bits
Message-ID: <glq3neyd4vyzu4wgdrlq2a2ws7h4tn35dg2xaw4klc73zfj25k@pwotfsysvgqr>
References: <20240429113334.2454197-1-pasic@linux.ibm.com>
 <ps5dukcjk6yh3an3hlkynr227r7kcln7b5dxgwope62avz5ceo@decy6vkuu56j>
 <20240527132710.4a7c372f.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240527132710.4a7c372f.pasic@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 27, 2024 at 01:27:10PM GMT, Halil Pasic wrote:
>On Thu, 16 May 2024 10:39:42 +0200
>Stefano Garzarella <sgarzare@redhat.com> wrote:
>
>[..]
>> >---
>> >
>> >This is a minimal fix, that follows the current patterns in the
>> >codebase, and not necessarily the best one.
>>
>> Yeah, I did something similar with commit 562a7d23bf ("vhost: mask
>> VIRTIO_F_RING_RESET for vhost and vhost-user devices") so I think for
>> now is the right approach.
>>
>> I suggest to check also other devices like we did in that commit (e.g.
>> hw/scsi/vhost-scsi.c, hw/scsi/vhost-user-scsi.c, etc. )
>
>Hi Stefano!
>
>Thank you for chiming in, and sorry for the late response. I was hoping
>that Michael is going to chime in and that I can base my reply on his
>take. Anyway here I  go.
>
>A very valid observation! I do agree that we need this for
>basically every vhost device, and since:
>* net/vhost-vdpa.c
>* hw/net/vhost_net.c
>* hw/virtio/vhost-user-fs.c
>already have it, that translates to shotgun it to the rest. Which
>isn't nice in my opinion, which is why I am hoping for a discussion
>on this topic, and a better solution (even if it turns out to be
>something like a common macro).

Yeah, I see your point and I agree on a better solution.

>[..]
>> >
>> >The documentation however does kind of state, that feature_bits is
>> >supposed to contain the supported features. And under the assumption
>> >that feature bit not in feature_bits implies that the corresponding bit
>> >must not be set in the 3rd argument (features), then even with the
>> >current implementation we do end up with the intersection of the three
>> >as stated. And then vsock would be at fault for violating that
>> >assumption, and my fix would be the best thing to do -- I guess.
>> >
>> >Is the implementation the way it is for a good reason, I can't judge
>> >that with certainty for myself.
>>
>> Yes, I think we should fix the documentation, and after a few years of
>> not looking at it I'm confused again about what it does.
>>
>
>I would prefer to fix the algorithm and make whole thing less fragile.
>
>> But re-reading my commit for VIRTIO_F_RING_RESET, it seems that I had
>> interpreted `feature_bits` (2nd argument) as a list of features that
>> QEMU doesn't know how to emulate and therefore are required by the
>> backend (vhost/vhost-user/vdpa). Because the problem is that `features`
>> (3rd argument) is a set of features required by the driver that can be
>> provided by both QEMU and the backend.
>
>Hm. I would say, this does sound like the sanest explanation, that might
>justify the current code, but I will argue that for me, it isn't sane
>enough.
>
>Here comes my argument.
>
>1) The uses is explicitly asking for a vhost device and giving the user
>a non vhost device is not an option.

I didn't get this point :-( can you elaborate?

>
>2) The whole purpose of vhost is that at least the data plane is
>implemented outside of QEMU (I am maybe a little sloppy here with
>dataplane). That means a rather substantial portion of the device
>implementation is not in QEMU, while QEMU remains in charge of the
>setup.

Yep

>
>3) Thus I would argue, that all the "transport feature bits" from 24 to
>40 should have a corresponding vhost feature because the vhost part needs
>some sort of a support.
>
>What do we have there in bits from 24 to 40 according to the spec?
>* VIRTIO_F_INDIRECT_DESC
>* VIRTIO_F_EVENT_IDX
>* VIRTIO_F_VERSION_1
>* VIRTIO_F_ACCESS_PLATFORM
>* VIRTIO_F_RING_PACKED
>* VIRTIO_F_IN_ORDER
>* VIRTIO_F_ORDER_PLATFORM
>* VIRTIO_F_SR_IOV
>* VIRTIO_F_NOTIFICATION_DATA
>* VIRTIO_F_NOTIF_CONFIG_DATA
>* VIRTIO_F_RING_RESET
>and for transitional:
>* VIRTIO_F_NOTIFY_ON_EMPTY
>* VIRTIO_F_ANY_LAYOUT
>* UNUSED
>
>I would say, form these only VIRTIO_F_SR_IOV and
>VIRTIO_F_NOTIF_CONFIG_DATA look iffy in a sense things may work out
>for vhost devices without the vhost part doing something for it. And
>even there, I don't think it would hurt to make vhost part of the
>negotiation (I don't think those are supported by QEMU at this point).
>
>I would very much prefer having a consolidated and safe handling for
>these.

I completely agree on this!

>
>4) I would also argue that a bunch of the device specific feature bits
>should have vhost feature bits as well for the same reason:
>features are also such that for a vhost device, the vhost part needs
>some sort of a support.
>
>Looking through all of these would require a lot of time, so instead
>of that, let me use SCSI as an example. The features are:
>* VIRTIO_SCSI_F_INOUT
>* VIRTIO_SCSI_F_HOTPLUG
>* VIRTIO_SCSI_F_CHANGE
>* VIRTIO_SCSI_F_T10_PI
>
>The in the Linux kernel we have
>        VHOST_SCSI_FEATURES = VHOST_FEATURES | (1ULL << VIRTIO_SCSI_F_HOTPLUG) |
>                                               (1ULL << VIRTIO_SCSI_F_T10_PI)
>but in QEMU kernel_feature_bits does not have
>VIRTIO_SCSI_F_T10_PI which together does not make much sense to me. And I would
>also expect VIRTIO_SCSI_F_INOUT to be a part of the negotiation, because
>to me that the side that is processing the queue is the one that should
>care about it, but I don't think it is supported by QEMU at all, and
>then not negotiating it is fine. VIRTIO_SCSI_F_HOTPLUG is in QEMU's
>kernel_feature_bits and thus negotiated. in  So the only one that can be
>done purely in QEMU seems to be VIRTIO_SCSI_F_CHANGE.
>
>And for vsock we have
>VIRTIO_VSOCK_F_SEQPACKET and VIRTIO_VSOCK_F_STREAM, with VIRTIO_VSOCK_F_STREAM
>being strange in a sense that the spec says "If no feature bit is set,
>only stream socket type is supported. If VIRTIO_VSOCK_F_SEQPACKET has
>been negotiated, the device MAY act as if VIRTIO_VSOCK_F_STREAM has also
>been negotiated."

Yes, this was a problem we introduced with F_SEQPACKET. Unfortunately, 
when we added that feature, we didn't define F_STREAM well because the 
devices always supported it. So we had to resort to this workaround.

>
>VIRTIO_VSOCK_F_SEQPACKET is negotiated with vhost.
>
>It seems for whatever reason we just assume that the vhost device
>supports VIRTIO_VSOCK_F_STREAM and that is why we don't negotiate it. I
>would assume based on what I see that the feature VIRTIO_VSOCK_F_STREAM
>was retrofitted, and that is what we ended up with. Thus I guess now
>we have an implicit rule that any QEMU compatible vhost-vsock
>implementation would have to support that. But in practice we care only
>about Linux, and thus it does not matter.

Yep, is this, but I have in my todo to fix this somehow.

>
>5) Based on the following, I would very much prefer a per device list of
>features with the semantic "hey QEMU can do that feature without any
>specialized vhost-device support (e.g. like VIRTIO_SCSI_F_CHANGE)" over
>the current list with the semantics "these are the features that
>need vhost backend support, and anything else will just work out". That
>way if an omission is made, we would end up with the usually safer
>under-indication  instead of the current over-indication.

Makes sense to me!

>
>
>@Michael, Jason: Could you guys chime in?
>
>>
>> >
>> >But I'm pretty convinced that the current approach is fragile,
>> >especially for the feature bits form the range 24 to 40, as those are
>> >not specific to a device.
>> >
>> >BTW vsock also lacks VIRTIO_F_ACCESS_PLATFORM, and VIRTIO_F_RING_RESET
>> >as well while vhost-net has both.
>>
>> VIRTIO_F_RING_RESET is just above the line added by this patch.
>>
>
>My bad! :)
>> >
>
>> >If our design is indeed to make the individual devices responsible for
>> >having a complete list of possible features in feature_bits, then at
>> >least having a common macro for the non-device specific features would
>> >make sense to me.
>>
>> Yeah, I agree on this!
>
>I guess, "possible features" shifted towards "possible features that QEMU
>can not provide without the vhost backend".
>
>But some sort of a common list does seem viable. I would however prefer
>a can do without list, or maybe even two ("can do without because I do it
>myself and alone" and "can do without, because although I must rely on a
>vhost capability to provide that feature, the presence of that capability
>is not indicated via the feature bits and based on knowing how things are
>I'm assuming the capability is there although not specifically
>indicated".
>
>>
>> >
>> >On the other hand, I'm also very happy to send a patch which changes the
>> >behavior of vhost_get_features(), should the community decide that the
>> >current behavior does not make all that much sense -- I lean towards:
>> >probably it does not make much sense, but things like
>> >VIRTIO_F_ACCESS_PLATFORM, which are mandatory feature bits, need careful
>> >consideration, because there vhost can't do so we just won't offer it
>> >and proceed on our merry way is not the right behavior.
>> >
>> >Please comment!
>>
>> Maybe we should discuss it in another thread, but I agree that we should
>> fix it in someway. Thank you for raising this discussion!
>>
>
>Hm, I ended up replying in this thread because we still don't have
>closure on this patch. But if you think it makes, feel free to start a
>different thread, and please do include me.

I see, this thread is fine!

>
>
>> >
>> >Regards,
>> >Halil
>> >---
>> > hw/virtio/vhost-vsock-common.c | 1 +
>> > 1 file changed, 1 insertion(+)
>>
>> This patch LGTM, but as I mention we should fix other devices as well,
>> but maybe we can do with the common macro you suggested in another
>> patch.
>
>I agree, this should be definitely another patch or even series
>depending on how the discussion pans out.

Ack!

Thanks,
Stefano


