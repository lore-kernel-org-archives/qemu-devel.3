Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01222C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 09:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKlL-0005xB-9c; Wed, 13 Mar 2024 05:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkKlJ-0005wz-G6
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 05:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkKlH-0006Sc-Di
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 05:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710321538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y1Ev2M4ZB4+71/hATyitMQrZqZ0O5l0fd+gyAp1YBvk=;
 b=eNChAsSbyCxnyyjCPbjJP4MO+1EOdMR+vyyQH6oHB9Hnbu/IYITtPO0fdALQieKixMjBCy
 kpS9cmzc/nfXAGMIXgv5dtRJrcBCQE7VAxQ1g4mF0GXwfqp2QIA4sotBRl25R3RCfMq/QH
 6aqD+fNsvB/2tKwtwEji9MvIKH6zYmY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-izhpBo65MK-KZpsKSGYReA-1; Wed, 13 Mar 2024 05:18:57 -0400
X-MC-Unique: izhpBo65MK-KZpsKSGYReA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e435a606aso37865325e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 02:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710321536; x=1710926336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1Ev2M4ZB4+71/hATyitMQrZqZ0O5l0fd+gyAp1YBvk=;
 b=KGQ2f2ogGqrR5sw1ors3XZG47x/KZJwWKrHOohIqXj9xgRUpWjAoYC8mWaAGWbWZ7I
 cvs+RnJhRM5ApxV4x7YLujwRQ3lLZCpr5/QVdvAWMAMTIU0gdOjqwksFQ0B0PIQtCW40
 MjeZ57O97metF5LT6M3K7Y7XYaj3dg0ROyiVVyYB7tHHW3UfL5+8xsLwqOzmrcx90oAt
 pgP5TMIXxT+38AaCWtlsAWTcs6U4OaP6bOLZS6U4iTjyawvWWWKLE+gPLQFoz8IF6b04
 OG7yycpj22BXuuSA1PX0CnnCuAliTJENWsSqw7WuOLm4H9LEXS3IQzOrR5LlQYmASUWM
 K4Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVquWW4IClSrx226HyGiBKZStGiGMRLlJpqJmKIz9Sw0AIdzJSiuSpN0t1xG7VE5kWZivYkUbp+qel/jGzLLcqeBWSEwe0=
X-Gm-Message-State: AOJu0Yw/kF3eE6HJXV2yxs1vfipr6YYitSGt4LJ4cyvnUKvgLvHmmWcP
 9eZCVBQboIMO1i3G26IzYZ/qpUcFSFDR63e9M0Fmd1GB1Et92uUe7w8Wk3evShCeohR0kaUXKcW
 FLXoyRH3xA15nCmtaqSjlMn/NeV50cIGdg+fsAeBHl2CWtS/IPGrg
X-Received: by 2002:a05:600c:46d0:b0:413:1f5c:baa6 with SMTP id
 q16-20020a05600c46d000b004131f5cbaa6mr3560992wmo.30.1710321535972; 
 Wed, 13 Mar 2024 02:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETww/iGfw7FfaU8TnCQbprZR6ouEXY4Jm+rmDex7opcsupdXtEDYPNUNBWqbciwV41HCWBmQ==
X-Received: by 2002:a05:600c:46d0:b0:413:1f5c:baa6 with SMTP id
 q16-20020a05600c46d000b004131f5cbaa6mr3560973wmo.30.1710321535407; 
 Wed, 13 Mar 2024 02:18:55 -0700 (PDT)
Received: from redhat.com ([85.190.233.128]) by smtp.gmail.com with ESMTPSA id
 j30-20020a05600c1c1e00b004133825e6cfsm1686035wms.24.2024.03.13.02.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 02:18:54 -0700 (PDT)
Date: Wed, 13 Mar 2024 05:18:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 0/3] Adjust the output of x-query-virtio-status
Message-ID: <20240313051034-mutt-send-email-mst@kernel.org>
References: <cover.1708525606.git.yong.huang@smartx.com>
 <20240312121944-mutt-send-email-mst@kernel.org>
 <87h6hah7bb.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6hah7bb.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

On Wed, Mar 13, 2024 at 09:20:08AM +0100, Markus Armbruster wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Wed, Feb 21, 2024 at 10:28:50PM +0800, Hyman Huang wrote:
> >> v4:
> >> - Rebase on master
> >> - Fix the syntax mistake within the commit message of [PATCH v3 1/3]
> >> - Adjust the linking file in hw/virtio/meson.build suggested by Markus
> >> 
> >> Please review,
> >> Yong
> >
> > I'm still not excited about this.
> > For one this will not scale when we add more than 64 feature bits.
> 
> x-query-virtio-status is meant to be a low effort, low level debugging
> aid.  Its feature set members correspond 1:1 to uint64_t members of the
> C struct, which I figure correspond 1:1 to 64-bit words in the binary
> virtio interface.
> If we run out of bits in the binary virtio interface, I guess we'd add
> another 64-bit word.  The C struct acquires another uint64_t member, and
> so does x-query-virtio-status.
> 
> What's wrong with that?

Nope, that last part about virtio binary interface is wrong. virtio does
not have a 64-bit word in it's ABI, it has an array of bits represented,
depending on a transport, as a dynamically sized array of 32-bit words
(PCI, MMIO) or a dynamically sized array of bytes (CCW).

We are beginning to get closer to filling up 64 bits for some devices
so I'm already looking at not baking 64 bit in new code.

> 
> > As long as we are changing this let's address this please.
> > I would also suggest just keeping the name in there, so
> > a decoded feature will be
> > [0, NAME]
> > and a non-decoded will be just
> > [23]
> >
> > will make for a smaller change.
> 
> I'm not sure I understand your suggestion.
> 
> [...]

For example, for the balloon device:

instead of e.g. 0x201 as this patch would do,
I propose [ [{0, "VIRTIO_BALLOON_F_MUST_TELL_HOST" }, {9, ""}] ].

-- 
MST


