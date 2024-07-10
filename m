Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA476C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 20:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRdfY-0006DL-6g; Wed, 10 Jul 2024 16:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRdfW-0006CL-PU
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 16:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRdfT-00012z-Vc
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 16:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720642319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sne4O/7Zu/ntHPFhCDNtjAjzsvQZBtwZ9haqmTrg9V8=;
 b=OxUCUdYia8qFtV9kOxSxaYatHY0q4kUHpyX6FgjQg4n0UPyHvNs7Lon++Sypg8bq4CJPBd
 um+bLc4eRYjmLNuGmdweJIet0eoFl6pl671QmOkiTfDt+hhuR6HT9G5FPs02G+pQyRNTKG
 NyUEpm2DJexwcVIkGIC3UinOBrDgfhw=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-EYUi-8dEOh2PSuiryxnh2g-1; Wed, 10 Jul 2024 16:11:57 -0400
X-MC-Unique: EYUi-8dEOh2PSuiryxnh2g-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-25e8c18a7c8so46981fac.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 13:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720642316; x=1721247116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sne4O/7Zu/ntHPFhCDNtjAjzsvQZBtwZ9haqmTrg9V8=;
 b=hk7WEvRxjc0OznlgX0lKpaWiFhg3EwWqZSxNfp/pNnLkM3XxsRh5pvtH3jpyfeuBDg
 9yYdXYr6bMfV7OoDcdvidobEt41LPtqjMINnAQWXGZkVQFOiizmIzh1F3BT6EKXq0XRd
 dX5jZtQP33+OzsTpwjAph0m9LAaKGZdaHPXScF0ydDcBM6a4WttcGDz/fL44ueUYj1Ko
 PE37h8BliYl3pIM+NJyVmjHRK0zUu9lxafrJ2Oi1L6kL9SdscFz6ggICPnA1+b7WE151
 jo/cCw0DzATzzFhPG4kHBGXifZcuchiLj0XURGPoKsg1KNzcj4TrctTKOSNZZn9vYKfl
 /ytQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhx6wrrhzML/19tW84fGXHKOG2uc1A6pRk3dBtWV6FtS5phPJ96w31mnhP91DHUncVFORcmD+jSHEo6naKqCoICuGT4P8=
X-Gm-Message-State: AOJu0YyuHjO+jDVEmGRvtRwjlIJPj0mHg/h+rP85zQGJmx5bLZDiD/8r
 kjVUjCFUoljXWLc2GdUVuYVUib25L5o978U/V1SZ/rirqMPBqzyDhzMCiBb+7i4QIkel1Lysz75
 yd039elvlJRxG6LwbMSXo/+6NpDvrfQPbMnLZyTOGg3lx88u6B3Iu
X-Received: by 2002:a05:6359:5f8f:b0:1aa:c73d:5a97 with SMTP id
 e5c5f4694b2df-1ac447ca679mr47857955d.1.1720642316691; 
 Wed, 10 Jul 2024 13:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUnKZChFKjZyh6ftGN9YJwS1oqiyRTCDF+NgxsdZUInNhqAKQPPIZXasWK/LgqphZBvIjcGw==
X-Received: by 2002:a05:6359:5f8f:b0:1aa:c73d:5a97 with SMTP id
 e5c5f4694b2df-1ac447ca679mr47855155d.1.1720642316321; 
 Wed, 10 Jul 2024 13:11:56 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f18ff67cdsm224705285a.18.2024.07.10.13.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 13:11:56 -0700 (PDT)
Date: Wed, 10 Jul 2024 16:11:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>, Bin Meng <bmeng.cn@gmail.com>,
 Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, devel@lists.libvirt.org,
 Luc Michel <luc.michel@amd.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 06/17] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
Message-ID: <Zo7rCXtap2lWd4IB@x1n>
References: <20240627162232.80428-1-philmd@linaro.org>
 <20240627162232.80428-7-philmd@linaro.org> <87cynmfggx.fsf@suse.de>
 <Zo2lLLAwcZ8bBvO2@x1n> <87a5ipfigb.fsf@suse.de>
 <Zo6iZjc8YpI1_9dW@x1n> <874j8xfc9s.fsf@suse.de>
 <Zo7dcF8OKfH92RlR@x1n> <871q41f2pk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871q41f2pk.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 10, 2024 at 04:48:23PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Jul 10, 2024 at 01:21:51PM -0300, Fabiano Rosas wrote:
> >> It's not about trust, we simply don't support migrations other than
> >> n->n+1 and (maybe) n->n-1. So QEMU from 2016 is certainly not included.
> >
> > Where does it come from?  I thought we suppport that..
> 
> I'm taking that from:
> 
> docs/devel/migration/main.rst:
>   "In general QEMU tries to maintain forward migration compatibility
>   (i.e. migrating from QEMU n->n+1) and there are users who benefit from
>   backward compatibility as well."
> 
> But of course it doesn't say whether that comes with a transitive rule
> allowing n->n+2 migrations.

I'd say that "i.e." implies n->n+1 is not the only forward migration we
would support.

I _think_ we should support all forward migration as long as the machine
type matches.

> 
> >
> > The same question would be: are we requesting an OpenStack cluster to
> > always upgrade QEMU with +1 versions, otherwise migration will fail?
> 
> Will an OpenStack cluster be using upstream QEMU? If not, then that's a

It's an example to show what I meant! :) Nothing else. Definitely not
saying that everyone should use an upstream released QEMU (but in reality,
it's not a problem, I think, and I do feel like people use them, perhaps
more with the stable releases).

> question for the distro. In a very practical sense, we're not requesting
> anything. We barely test n->n+1/n->n-1, even if we had a strong support
> statement I wouldn't be confident saying migration from QEMU 2.7 -> QEMU
> 9.1 should succeed.

No matter what we test in CI, I don't think we should break that for >1
versions..  I hope 2.7->9.1 keeps working, otherwise I think it's legal to
file a bug by anyone.

For example, I randomly fetched a bug report:

https://gitlab.com/qemu-project/qemu/-/issues/1937

QEMU version:                6.2 and 7.2.5

And I believe that's the common case even for upstream.  If we don't do
that right for upstream, it can be impossible tasks for downstream and for
all of us to maintain.

-- 
Peter Xu


