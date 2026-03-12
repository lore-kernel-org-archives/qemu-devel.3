Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3146106703C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 15:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0i3X-0003lN-IE; Thu, 12 Mar 2026 11:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0i3V-0003kx-3B
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0i3R-0006aY-Av
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773329667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YOl7Eqg/lJOo6LFwTaL6IFOQIb4lrXJmEBDlVjNLxQo=;
 b=KS3x3DhKnZPdvdk0VASrqCg1rSpFqp80o9yYdUxxRiZcT/p+yp7nvrUospQxAOswtd8u8r
 yr6MNd+0Q43NvnUeSvsg+YGcuC8lLdE6ZLbri31q6vnNcPWl7qW1CQ4M14jYWQ01SXgjeS
 eKgjSHGz+uov7UOsp/4ew42bulDAr50=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-ljYzVJ1KOa6wtk8EVvg1eA-1; Thu, 12 Mar 2026 11:34:26 -0400
X-MC-Unique: ljYzVJ1KOa6wtk8EVvg1eA-1
X-Mimecast-MFC-AGG-ID: ljYzVJ1KOa6wtk8EVvg1eA_1773329665
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd7f6ac239so731172485a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773329665; x=1773934465; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YOl7Eqg/lJOo6LFwTaL6IFOQIb4lrXJmEBDlVjNLxQo=;
 b=T6SfJzZIU5KoD2B9zXzHD1Irwuhci+drKOKfDJaf1kIiSzw/dAiPaXWA9hqaHd3KjR
 FVuCSL3DMdgvvJPa3+EfXRX0+8jPKfwRH+kAKhhvDF6mzbkCorpsPsNg23mLHROrcb1b
 u27/B7WBLx1nFEPTZxQPy8ZMOdrKeAvWkN29SpbxVDkmSP9tZep71i+kBX//27vsbbS4
 BrAKEEWgxXGp2xCJtcZ/kF17wBjtidq7ywVVho2JniOwQJMgNTEkINh/MXgm2k9+4NB8
 C42NQY83MJCikcLv6UG0B2yczrMv3++iALd01GCrB5se0PCftA3mM3oNmZtoijOMxgx+
 lO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773329665; x=1773934465;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YOl7Eqg/lJOo6LFwTaL6IFOQIb4lrXJmEBDlVjNLxQo=;
 b=ovNYorNfDTwniTkyREnd5D7gTLmURg3/Ageb/IPb72YW6hmoipcIrhWE+txP58rDyV
 zrMal1zw0go1450V1fjRWbKHq6vn3NwYIkm2tOkOgcp6IsZRN9dTDZbktziF9bK+ACvT
 Iqg9Qv9tEpR7WLAtah8UrrwC+o+PAOaCn6IkbVd0ByjLUwFHFSwz4Pbe5KNLm+q+FNuZ
 edyGkJK7KTKlgOVuVgwvAarfnRfoV+g/5z8zmr/UOrCe6TdzYMQdZHTYWNme0jh+exg2
 eScMSNZgrM4RY8MRTlfGJ1QtCFHHbcZyqRdNiuS5zpCkvbmHiCyGM18I3w7r0+vWeUHj
 7GHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdO56vphfdM6fR63D0abBw/DsUyVnu1LhdPnN1+i40uiYpNtnOBddow4LBvlcarnsC1/DCtzD14uBx@nongnu.org
X-Gm-Message-State: AOJu0Yy2wo7wr+7B9QUa6VlH2Hui1CDLcqyMQhcTU2mT43gXxKiiwh3c
 mFMXxg8RAEOgkqkPO1HqwJpGokpjmTURovKT/MN0udQhEbt0vvEZajyuovu9eZnMBVHlnfKhwmI
 qDqLUZyAXdyBQ+YwKKtuKe/NFDUykYVx+kmegBNUHlBCby1NiBPpTm1Rl
X-Gm-Gg: ATEYQzxzHXIM9Aw6fSWLySfTHnR3pxfky5T6xCCOWtWIkhK3Nkm3c25dHN/p0yY+i5P
 IqrSEfu5CMnWLJCh+nZGCAp6o+gj+V2StE8P5YhazSR4bTed8MdbPsYYDr9qzIBB9jFjM0yJqhj
 DaeiONqHfzJgaVYK4ug1MumBMPvABdnHmU/w2M/nBumjA5pGaa/8uI4GNOjPUytbSnKs7i9Su5T
 AfKj/Jcr0M0aFWDaMRvhG2dCwZ7zrCiUgRz/p/kUdvXoE7V/8b3Pbad6K5JtCRUUw5V4UDhUzOu
 q1CUEDkPqrC1dgBDWxprbC/NVC/lfXNtYK3FkPF3ybAD+yj9hsPgjthZ/FV3U0+1muBDWWlInpF
 24Z4l+QS8rZJ0CA==
X-Received: by 2002:a05:620a:471f:b0:8cd:8fb7:7b13 with SMTP id
 af79cd13be357-8cdb5a41872mr22021185a.10.1773329665247; 
 Thu, 12 Mar 2026 08:34:25 -0700 (PDT)
X-Received: by 2002:a05:620a:471f:b0:8cd:8fb7:7b13 with SMTP id
 af79cd13be357-8cdb5a41872mr22015285a.10.1773329664712; 
 Thu, 12 Mar 2026 08:34:24 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda211518esm374431285a.27.2026.03.12.08.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 08:34:24 -0700 (PDT)
Date: Thu, 12 Mar 2026 11:34:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2] vmstate: fix subsection load name check
Message-ID: <abLc_ppEEbKjNRUi@x1.local>
References: <20260302070626.613396-1-dtalexundeer@yandex-team.ru>
 <87y0k5136i.fsf@suse.de>
 <714e4329-6001-4c77-b004-ed7beb11c154@yandex-team.ru>
 <e81360d5-cab4-47a4-840b-7d948b51a5c0@yandex-team.ru>
 <CAFEAcA-m+CZPUchGsh6QU4gm1dO-FP0m1w5gu6sn56wUXBbRAQ@mail.gmail.com>
 <abBcN2B4QNBT_Oh9@x1.local>
 <f37dc7af-7ffd-4a7b-b4fa-552c2d2eb888@yandex-team.ru>
 <abGEwf-AG1rZ3kam@x1.local>
 <a6dafc1e-79d1-4380-a4da-7cbc4ff77ae4@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6dafc1e-79d1-4380-a4da-7cbc4ff77ae4@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 12, 2026 at 09:30:35AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> You say
> 
> > .. always pop the VMSD stack then the upper layer may read the SUBSECTION byte anywhere.
> 
> But it actually can be anything. Of course probability is small that some another state
> looks like QEMU_VM_SUBSECTION + <existing subsection name>, but we don't have actual
> guarantee for it in the protocol.
> 
> Probably, we may also add a protocol change (with some global state property,
> set to true in new MT) to add a number of subsections into section state, to be
> sure how many of them we have in the stream.

Yes, I believe it's always possible to change the streaming protocol to
make it even clearer.  Actually, that's what I was picturing before I read
your previous reply.

For doing that, I wonder if we should just fix "this specific problem" or
"the bigger problem".

The bigger problem here, at least to me, is migration streaming lacks level
information - virtio can wrongly treat that piece of info as its own
subsection only because the stream doesn't tell which level it's in..
It's a common issue for migration stream, so I wonder if we need to break
the streaming protocol then whether we should do even further than that.

That is the part where I think what you suggested in the previous email may
be the easy way to go (plus, removing the name check completely).

But let me double check with you on one thing: before any fix, this problem
will happen even during a migration between two latest QEMU that supports
that new subsection of virtio-blk, am I right?

I am curious why this problem is only reported until today, rather than
when the new subsection was developed.  I wonder if I still miss something
that I didn't notice..

-- 
Peter Xu


