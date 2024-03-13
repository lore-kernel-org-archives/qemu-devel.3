Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6AAC54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMTG-0002Fj-CI; Wed, 13 Mar 2024 07:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkMTC-0002Cz-K9
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkMT7-0001pY-Lh
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710328100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iit3uGAM56/6VD8D+WjoFPjOKygwso4aO+HOFKdrWbE=;
 b=ZwzTsK2IekuFQtAlSVjHdU2Rrg1k+YTPqU0GfuycrMwbSKl1okZaVu6iY1Miz1X6cUgpau
 oiFoYeWZiEBcQsHs3BJDReb1vBGIiJUa95Sqq7NisPr3w0ci03iQagyf3Qd8T4Tgq+h75w
 czIimUXVW0eHXcnBrBP/JpddfO8Tjag=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-D1HXOM38O3emInXDRnnG3A-1; Wed, 13 Mar 2024 07:08:19 -0400
X-MC-Unique: D1HXOM38O3emInXDRnnG3A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-412e355e2abso4150985e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 04:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710328098; x=1710932898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iit3uGAM56/6VD8D+WjoFPjOKygwso4aO+HOFKdrWbE=;
 b=IIKqkJmGa3RqNkR98X6uiiMY/TlwaA8OmdA8P8sNB3pySZQSaR6HwGrY/uWYkhYvpZ
 6JP7lkA/DUhZTrNw42fGBj/Tjelc86ZUU6Syk7vpnORRoE6cr6z8v8+GH1bDABa4Izpt
 yHdJjrFjX/sGDQiKpOm1gt5b/YxF9W4J+5OmFgV93ZdH9c76x5nol5IUkmeTtwPIZwTt
 1XdGtTdIIBfib3mUqTNdMTOFaRD9OHz23D73hVNdbDS9jy26ObdIG5ZoXFty8jFte2y1
 TZwJpzE88klt7RFVx3foaLg1IaqI517W63hlPj1ddH4XA063YEwrkim6381wyTnGBfVw
 A4ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPKTqcxBgF0AxX5Kc0PIHhRTTqc2KoV6atjcMX8G0JktvSijxxYMF+w/Kbzls9nPBueKI7UFR5YV4kVG0Vkz9ppJkD43w=
X-Gm-Message-State: AOJu0Yy8KE4AkfN42z+iyeWieevEy7KS00aWNMQT/5yRWCyczXycf1cl
 oXpeWJT72AVk9H2LmQgQD0v3fyZXXWBaVxH638+xvfzhXN3wBr0ee+Yo3s31aI6YViHmxRueHEZ
 5hjT0eoORs1ulHHZtlxt3cjpPvWi/k6hpV1Fu98I8qulaAHH3szn0
X-Received: by 2002:a05:600c:4fce:b0:413:3890:25f4 with SMTP id
 o14-20020a05600c4fce00b00413389025f4mr2122331wmq.36.1710328098174; 
 Wed, 13 Mar 2024 04:08:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQdh2ar+cKxOX7BmmBVQKQjvYgmEz7nZ5c7TTguKeLYHhA1kmCqIcD80qI4pMZwavAXvtqBw==
X-Received: by 2002:a05:600c:4fce:b0:413:3890:25f4 with SMTP id
 o14-20020a05600c4fce00b00413389025f4mr2122308wmq.36.1710328097629; 
 Wed, 13 Mar 2024 04:08:17 -0700 (PDT)
Received: from redhat.com ([85.190.233.128]) by smtp.gmail.com with ESMTPSA id
 u13-20020a05600c19cd00b0041316e91c99sm2001086wmq.1.2024.03.13.04.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 04:08:17 -0700 (PDT)
Date: Wed, 13 Mar 2024 07:08:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 0/3] Adjust the output of x-query-virtio-status
Message-ID: <20240313070613-mutt-send-email-mst@kernel.org>
References: <cover.1708525606.git.yong.huang@smartx.com>
 <20240312121944-mutt-send-email-mst@kernel.org>
 <87h6hah7bb.fsf@pond.sub.org>
 <20240313051034-mutt-send-email-mst@kernel.org>
 <87msr2fp16.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msr2fp16.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 13, 2024 at 10:40:21AM +0100, Markus Armbruster wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Wed, Mar 13, 2024 at 09:20:08AM +0100, Markus Armbruster wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> 
> >> > On Wed, Feb 21, 2024 at 10:28:50PM +0800, Hyman Huang wrote:
> >> >> v4:
> >> >> - Rebase on master
> >> >> - Fix the syntax mistake within the commit message of [PATCH v3 1/3]
> >> >> - Adjust the linking file in hw/virtio/meson.build suggested by Markus
> >> >> 
> >> >> Please review,
> >> >> Yong
> >> >
> >> > I'm still not excited about this.
> >> > For one this will not scale when we add more than 64 feature bits.
> >> 
> >> x-query-virtio-status is meant to be a low effort, low level debugging
> >> aid.  Its feature set members correspond 1:1 to uint64_t members of the
> >> C struct, which I figure correspond 1:1 to 64-bit words in the binary
> >> virtio interface.
> >> If we run out of bits in the binary virtio interface, I guess we'd add
> >> another 64-bit word.  The C struct acquires another uint64_t member, and
> >> so does x-query-virtio-status.
> >> 
> >> What's wrong with that?
> >
> > Nope, that last part about virtio binary interface is wrong. virtio does
> > not have a 64-bit word in it's ABI, it has an array of bits represented,
> > depending on a transport, as a dynamically sized array of 32-bit words
> > (PCI, MMIO) or a dynamically sized array of bytes (CCW).
> 
> Then have x-query-virtio-status return a suitable array of unsigned
> numbers.  Look ma, no invention!

Then with bit 53 in spec user has to squint hard and do okay
53/32=1 so array entry 1 and 53%32=21 so bit 21 there.
And for ccw it's just completely weird they have a byte array.
No one wants these words everyone works with bit #s this
is what's in spec.

> > We are beginning to get closer to filling up 64 bits for some devices
> > so I'm already looking at not baking 64 bit in new code.
> >
> >> 
> >> > As long as we are changing this let's address this please.
> >> > I would also suggest just keeping the name in there, so
> >> > a decoded feature will be
> >> > [0, NAME]
> >> > and a non-decoded will be just
> >> > [23]
> >> >
> >> > will make for a smaller change.
> >> 
> >> I'm not sure I understand your suggestion.
> >> 
> >> [...]
> >
> > For example, for the balloon device:
> >
> > instead of e.g. 0x201 as this patch would do,
> > I propose [ [{0, "VIRTIO_BALLOON_F_MUST_TELL_HOST" }, {9, ""}] ].
> 
> Syntactially invalid.  I guess you mean something like
> 
>     [{"bit": 0, "name": "VIRTIO_BALLOON_F_MUST_TELL_HOST"},
>      {"bit": 9, "name": ""}]
> 
> or with optional @name
> 
>     [{"bit": 0, "name": "VIRTIO_BALLOON_F_MUST_TELL_HOST"},
>      {"bit": 9}]
> 
> This is an awfully verbose encoding of an n-bit number, even if we omit
> "VIRTIO_BALLOON_F_" as noise.
> 
> I could be awkward for the use case described in PATCH 1's commit
> message:
> 
>     However, we sometimes want to compare features and status bits without
>     caring for their exact meaning.  Say we want to verify the correctness
>     of the virtio negotiation between guest, QEMU, and OVS-DPDK.  We can use
>     QMP command x-query-virtio-status to retrieve vhost-user net device
>     features, and the "ovs-vsctl list interface" command to retrieve
>     interface features.  Without commit f3034ad71fc, we could then simply
>     compare the numbers.  With this commit, we first have to map from the
>     strings back to the numeric encoding.
> 
> It next describes the patch's solution:
> 
>     Revert the decoding for QMP, but keep it for HMP.
> 
>     This makes the QMP command easier to use for use cases where we
>     don't need to decode, like the comparison above.  For use cases
>     where we need to decode, we replace parsing undocumented strings by
>     decoding virtio's well-known binary encoding.
> 
> Since this is not a stable interface, instead of a perfect (and to my
> subjective self overengineered) solution at some future point, I'd
> prefer to get in a simple one *now*, even if we may have to evolve it
> later.


