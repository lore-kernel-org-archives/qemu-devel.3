Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE232C282D2
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 14:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpTUr-0000wm-Ky; Tue, 04 Mar 2025 09:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tpTU4-0000sw-T3
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:43:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tpTU2-00038z-B0
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741099376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R8iZpaCwxXotYP8YTMoUA9S/jCSwJk1WCcYVP6YSSVE=;
 b=AEvCJ29fPoRfBRTstu5+Sx3jEFoTybOULHFPtGpRW6EEo2Hnei5c+FrKpwqGXjVkxjeRU/
 Aqypi7+Q/oXoeBx5LV/qx3RiquzGfzoZ/12zn55JSH6qpoAgESnrhJbh7QSpnMj7S75vxV
 eYzNB4AhyOKNuuMJoFYnm/QdkWYNxtw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-tETKAEi0Ne-4DNG-RNXMBA-1; Tue, 04 Mar 2025 09:42:45 -0500
X-MC-Unique: tETKAEi0Ne-4DNG-RNXMBA-1
X-Mimecast-MFC-AGG-ID: tETKAEi0Ne-4DNG-RNXMBA_1741099365
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6fd4cfafeb0so36483287b3.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 06:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741099365; x=1741704165;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8iZpaCwxXotYP8YTMoUA9S/jCSwJk1WCcYVP6YSSVE=;
 b=qq+4GdNyJvGi7RhQMgvSfpesjcJtttfybsP6EoLMQM556N0JhwWOHcH3RQCCCJVkYV
 3kut9Z0FmiazbOmbW5gNwk46dM7laPo+uu/hLjH6Hgb1SlQJzYWlDTIZVMJsiuBi3Vqw
 3dB/jF6VJTg7LIF9Yjn6CRBfSoJJ+DPOFVEI4RxeiS8Us0jeOXfQVRM+C41i+GikW9OH
 YeO2wspsEwHxcgmRiu2c45IJf2cQiJ++OFRfgzCUFMDI646x4KKL9QObvLaplxBpVRTT
 GT4qHSQfZ5gj/tgFaBC3hpd4GOzYaI+Dg6KfOGZhoIrgKFB7tg0ylqVD12aWZJggzA7T
 bw/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqXc/Qiv4uWzHQIhg9UZP1dMIghhLx0KnBpK75s7YMAPlFeL4Gk3JWTYzxaTslbmcjAOpXlHhHsT/L@nongnu.org
X-Gm-Message-State: AOJu0Yzai7sMskPcuRNEbxsqV/BHHp0QYBY5un4IGpGcDhv5cyJ3kC2C
 b9vLZHzFfYL219yWj+zmKAWYb6fMei/7LaKUM5hUHXLi/u3bHyIbp5MA7xe289x/qszVpLe25Vs
 DrEOQZGwGCO5Vo7AHCdjwMA5Ea3MgjZe+aH+gfCvSE8Xvwn7yl0Mg
X-Gm-Gg: ASbGnct3SKunvdoJnsjJBywqeowX4whFowG5x0U3hpg4fbFxlKsw8ginchKOjAUEXaq
 XU7YGl/U4fjPIbsxEr6ate84ArxQphFril+1glIwsYcFfFqZKQleNXzwhFxammcpCeApbx1iH9i
 MnlnxAovX0F4JWttUAOd8fBpBCgo4nO42f8FnnnLfqJy3LoBNuCR/LW06KvOy5GYWvbwzz9h6ko
 WC3hp2t2sEkbu6GHvLkNYx9yrCIz0lOGb6odEJR1pR1Qv/zNHhapxSZ6f7BYYj0DfzyEQ3yk5IN
 EeryrGs=
X-Received: by 2002:a05:690c:7482:b0:6f9:3e3d:3f2e with SMTP id
 00721157ae682-6fd4a1003famr231597257b3.33.1741099364898; 
 Tue, 04 Mar 2025 06:42:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7Gp6KcHG5Wgse8Nmb0I+jo9stwoZRM8m+4upXgsDjQEUd6q4d5OCk/GG72HbtpZb/oROSZA==
X-Received: by 2002:a05:690c:7482:b0:6f9:3e3d:3f2e with SMTP id
 00721157ae682-6fd4a1003famr231596987b3.33.1741099364583; 
 Tue, 04 Mar 2025 06:42:44 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd5f0be55dsm16897607b3.114.2025.03.04.06.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 06:42:43 -0800 (PST)
Date: Tue, 4 Mar 2025 09:42:40 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 0/5] Allow to enable multifd and postcopy migration
 together
Message-ID: <Z8cRYO1Kacl7vl-I@x1.local>
References: <20250228121749.553184-1-ppandit@redhat.com>
 <87frjy2k8z.fsf@suse.de>
 <CAE8KmOwVoGJ2frVCY76W7UxSr90wAL2EMj5Nmtcrdc+BE1e9=g@mail.gmail.com>
 <Z8W4xVOLLAD1wXjC@x1.local>
 <CAE8KmOzkVpG5iUqwShWWMF4+96-cbNm1AU8b=s3187EyWXXT4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzkVpG5iUqwShWWMF4+96-cbNm1AU8b=s3187EyWXXT4g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 04, 2025 at 03:17:14PM +0530, Prasad Pandit wrote:
> Hi,
> 
> On Mon, 3 Mar 2025 at 19:42, Peter Xu <peterx@redhat.com> wrote:
> > On Mon, Mar 03, 2025 at 04:17:53PM +0530, Prasad Pandit wrote:
> > > * I think we (you, me, Peter) are all looking at things differently.
> > >     - In my view Patch-2 is the minimal change _required_  to enable
> > > multifd & postcopy. In your view we are _revamping_ channel discovery
> > > parts while _sneaking_ in a feature of enabling multifd & postcopy
> > > together.
> > >     - In my view Patch-5 in this series is an isolated change because
> > > it adds a new migration command to allow multifd threads sync from
> > > source side. But Peter thinks without that 'flush and sync' Patch-2 is
> > > incomplete, so we should merge it back there.
> >
> > Just to mention, my suggestion does not conflict with splitting patch 2, as
> > long as you keep every patch complete on its own.
> >
> > Patch 5 needs to be squashed to either patch 2 or a split patch out of
> > patch 2, because current patch 2 (or any possible way to split it into
> > smaller ones, then one of them which enables the feature) is buggy.
> 
> * I'll try to segregate different parts, then we can discuss how to
> split them across patches:
> 
> Terminology:
>     _requires_  => is without which migration shall not work at all.
>     _essential_ => is without which there may be issues.
> 
> 1. Enable Multifd and Postcopy together
>     - It _requires_ removal of the Multifd capability check in
> migration/options.c
>     - It _requires_ identification of the CH_POSTCOPY connection when it arrives
>         - so enum { CH_MAIN, CH_MULTIFD, CH_POSTCOPY } is defined
>         - To identify channels, related changes are made to the
> channel discovery part (if .. else conditionals) in
> migration_ioc_process_incoming() function.
>         - These changes help to establish all channel connections.
> After that, the migration proceeds as usual until it's time to start
> the Postcopy phase.
>     - When time comes to start Postcopy phase, we shutdown multifd channels.
>         - it _requires_ calling multifd_send_shutdown()
>         - It _requires_ moving
> file_cleanup_outgoing/socket_cleanup_outgoing calls to
> migration_cleanup() function.
>     - When Postcopy phase starts, we don't want ram_save_target
> _page() function to call ram_save_multifd_page() function, because
> migrate_multifd() is still true.
>         - It _requires_ adding the !migration_in_postcopy() checks.

IIUC Fabiano is not asking you to drop them, but split them.  Split still
"requires" them to be present, as long as before the enablement patch.

For example, if you want you can put the channel changes into a separate
patch, but without enabling the feature.  That single patch (after applied)
should keep migration working as before.

> 
> * Above changes are minimal _required_ to enable multifd and postcopy
> together, while also ensuring that migration continues to work when
> those options are not enabled together. With these changes, guest
> migration across two machines works without any observed failures.
> 
> 2. The multifd_ram_flush_and_sync() call/command and the
> assert(!migration_in_postcopy()) call in multifd_recv_thread()
>     - These calls help to ensure that no multifd data is left behind
> when the Postcopy phase starts.
>     - And that multifd_recv threads shall not be active when the
> Postcopy is running.
>     - They protect the guests from potential state corruption.
> 
> * It is up to us to decide whether (2) is _required_ OR _essential_
> for the feature. Individual opinions can vary here.
> 
> 3. Revamp of the channel discovery parts by moving those bits to
> connection.c or other places.
>     - This entails moving the channel discovery parts from
> migration_ioc_process_incoming() function to somewhere else because it
> makes more sense to move it there and maybe it reduces complexity and
> makes the sources easier to understand.*
> 
> * It is up to us to decide whether (3) is _required_  OR  _essential_
> for the feature. Individual opinions can vary here.
> 
> * IMHO (1) is _required_,  (2) is _essential_,  and (3) is neither
> _required_ nor _essential_ for the - Enable multifd and postcopy
> together - feature. (3) is a completely unrelated change to this
> feature.
> 
> Since it is an individual opinion, we all can think differently here
> and that is perfectly fine. Once we have some consensus, we can decide
> how to split or merge patches and move forward.
> 
> Hope it helps. Thank you.
> ---
>   - Prasad
> 

-- 
Peter Xu


