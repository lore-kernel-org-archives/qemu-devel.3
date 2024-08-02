Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85E4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 20:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZzKY-0004Fx-MN; Fri, 02 Aug 2024 16:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sZzKX-0004FP-2B
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 16:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sZzKV-0004UV-46
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 16:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722632209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+TLZk2Vovox8HVQlrGrYGcTcUWFulAH4t5AnY5jWeo=;
 b=jSbbrby8LavsJgzetVQRLpcBhu3cEEYbi1Fn9Dc6bkcp7hvKP/0SlkNX29M5dhnXE+Fap+
 E9nzm9kZIESns6xJcLSNhFbV+TErRRYhoUcV7eHy6hcEl8xoxhiy4Q7E1gbIChwWkXmoHd
 ocsor1vVW7OXMNP7pQaBFJYLB/OlFKg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-HqMTBm-NPQWHbsjiAGtJVg-1; Fri, 02 Aug 2024 16:56:47 -0400
X-MC-Unique: HqMTBm-NPQWHbsjiAGtJVg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b7b1d79bacso17127166d6.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 13:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722632207; x=1723237007;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+TLZk2Vovox8HVQlrGrYGcTcUWFulAH4t5AnY5jWeo=;
 b=WfhbpTNHklNeJoHAARW5uBKsqMxwnXn9mh8JhC8bLN2VC7x0Nv9/HgyNAkRldhvJeM
 WcvvPuJ4i4qHJvsVUm8ORK3zM7J3OM6tlmrCuv7Jyusk05rIKxMpabY7ABmuBBS9f/4o
 88wwtH5fmz7RK6DKEhVQ9g/A1ihbTXH4PXzNnUaVEDkHnxswjueiyGFqsZzsMsFGA2Bo
 /unmarGUitXqbCx+ztoMLP9nooEyaDh5/e6VOiVL+oKc+eM2M7DdOLoPmNSvYl96IdBM
 8Da/iAPDreZLSWC337CABO3mN1+3duD5X5pfKt5T6+VycrZz7BXl8caAjKiTcVOrjOVe
 lcxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOUNPDJ0qzsR/1D19NXX6DrdLuHleAokv90C/vU/i9dExvAMc4oxoUYWzRNM/ZwoIad4cB2uIS4mTEOm7nE8xs1UnjKVM=
X-Gm-Message-State: AOJu0YwY75v5451DvDO2F/S9MVbn3Enda2QDdYBO/uONdoCJR4XqIl9S
 2qIT1U31hEk9d3en1YES5TZEYYx2xqsRUmoSoiUOUd8BVw5zFc7GzWjI/t7SBzMICpTajfEgIgJ
 DzF5b6+4YsgxzZkW2RCSdrsgGKu2JySu8OTk+ROpK47iJUkoWBQwr
X-Received: by 2002:a05:620a:4709:b0:7a1:5683:b04b with SMTP id
 af79cd13be357-7a34efdaec2mr309420585a.9.1722632207230; 
 Fri, 02 Aug 2024 13:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl81zRfS+tosAYtmx1lUwqIysMCRB/afh3QA8+L1gZYgSLBX4LvDZAzFMmJbuJRq0+cIubtA==
X-Received: by 2002:a05:620a:4709:b0:7a1:5683:b04b with SMTP id
 af79cd13be357-7a34efdaec2mr309418885a.9.1722632206870; 
 Fri, 02 Aug 2024 13:56:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a34f6ffb39sm118679085a.62.2024.08.02.13.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 13:56:46 -0700 (PDT)
Date: Fri, 2 Aug 2024 16:56:43 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <Zq1IC1LAnBl653ZQ@x1n>
References: <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com>
 <Zqk6x2nd3Twz--75@x1n>
 <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com>
 <ZqumIZcs1tCNTpRE@x1n>
 <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com>
 <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com>
 <Zq0IrhV-DgStpJtk@x1n>
 <20240802123127-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240802123127-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Aug 02, 2024 at 12:40:33PM -0400, Michael S. Tsirkin wrote:
> On Fri, Aug 02, 2024 at 12:26:22PM -0400, Peter Xu wrote:
> > And that's why I was thinking (where I totally agree with you on this) that
> > whether we should settle a short term plan first to be on the safe side
> > that we start with migration always being compatible, then we figure the
> > other approach.
> 
> We have two big issues around migration compatibility we never solved:
> 
> - some guest visible behaviour depends on a package outside of qemu:
>   as that package can change, so can qemu behaviour

Any example, or bug link for this one?

> 
> - sometimes we change guest visible behaviour and only
>   discover this after the release: fixing that breaks
>   migration to one version, not fixing breaks migration to another

In this case it is a bug, IMHO, and not always fixable.  It's like QEMU can
crash and coredump, not fixable unless the user upgrades.

Here "upgrades" for migration purpose means, the user should avoid
migration with a broken QEMU version, and one needs to cold reboot into a
new fixed binary rather than a live migration.

The good thing is as long as the user doesn't trigger migration logically
the bug can be avoided.

The bad thing is since it's a migration bug it cannot be fixed by live
migrating to a new QEMU..

AFAICT we did that before, for downstream we fix X.Y.0 with X.Y.1, then
declare X.Y.0 broken, something like that.  It's the same for downstream
where we put into similar documentations.

> 
> 
> These, to me, look similar enough that I feel we should look
> at them together from QAPI POV.

Or maybe I misunderstood here, in that case some elaboration of the QAPI
that mentioned here could help on clarifying things.

So far I don't see any QAPI command can fix a migration bug, for example,
which falls into category 2 above.

> 
> Both issues sometimes can have work-arounds, enabling these
> would be nice.
> Also, both issues have a clean solution, which can come in
> two flavors:
> 1. basic: detecting incompatibility
> and not starting qemu on destination (or failing migration,
> possibly early, which I consider a less clean solution).
> 2. advanced: ability to go from a set of configurations to
> a flag making them compatible.
> 
> 
> -- 
> MST
> 

Thanks,

-- 
Peter Xu


