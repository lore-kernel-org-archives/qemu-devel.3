Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B19CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 09:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utN1a-0005vt-AB; Tue, 02 Sep 2025 05:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utN1K-0005ug-3J
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:09:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utN1I-0004Mb-29
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756804177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icQZRWICF94Ux0M33w/MDbGWZQnsPJrqSbUtj7kJb8Q=;
 b=Rb847IQvrOXxw0MqKW4xIANW5tagM01uJ+Z9LqsgNYLEOUM/OL45q5DK5iwNRD0sfIrt7E
 MhGHJJTrdxea9gRrc2fFihgK9R78I9OHge9fjNBkiT2n6wN1X7f87vNAIe48PI8Z7xUulu
 IKejyYKIHq8sqW9uVGmiHsU42/G/4m0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-Hmy2NzBSNtmQ65_Tc7J0hw-1; Tue, 02 Sep 2025 05:09:35 -0400
X-MC-Unique: Hmy2NzBSNtmQ65_Tc7J0hw-1
X-Mimecast-MFC-AGG-ID: Hmy2NzBSNtmQ65_Tc7J0hw_1756804175
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-248abeb9242so46259925ad.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 02:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756804174; x=1757408974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=icQZRWICF94Ux0M33w/MDbGWZQnsPJrqSbUtj7kJb8Q=;
 b=NsUWNcC34Kv3xM3fRkFzfFEmvI1bcKeIEoiVvVtXLnq9ETG64PVyOeetjTYpbSZ9Z3
 IXcAbaKUCcJFV8d07WypndP9KpeR3gVwpVJPTEF/m/YTt3hzgG8P0kpjvy3IwxmWba2E
 vGuAkzE3Zn7EppjEULeBQNvAk5jdVUyBzkj/hrLAvVCcb2k2QtSUFMLEXPPCJsfRXn4U
 7tGnLgmAfAjDTmVivsHi1G2Q9E1sjrOl8DCOSK8jAztFWsH5D+7cs9hp+2LWTwUHvjDP
 gokfIvxoyUNxblyFk/I/h35wN++iNxsU+aynxshnjAZf7LZeAUcDjdNfa4uWF1mcDkZE
 1ciQ==
X-Gm-Message-State: AOJu0YwOCGMoMwKqYqOvyBCQ1dSSnIKRJIvQFsVmGEkfjfSTvuZvJZ8K
 L7sbKty7YX33NvWo7ry86CFAc+5fFMTSwJ12SIU62ofN6J3TwCsfFpkUp3h+2GTM6r/9BpHI43E
 ndfYvy4mvIqDO1HvqyTD/MplDw7BiShmaXwuyqiNur2aENsc9JtYaKTOxJvvFbFwNXAliQENY/w
 jbEwmDjAndl0B+jxc1ciUE/oqD3c4leJQ3gcoQ8ki1Rw==
X-Gm-Gg: ASbGncszQfEMDaKOhfdAJiwsVLdT+I1zBul9EFWPPoX5uehPzovrloYZMB5EN5Es61v
 1YphDEOill2kLFC0xASw56Ldc5Qwm63iEwzNBrziKJYpOEKF5Vzn5sYcGrv8ra8Q+bxHDP6vkHZ
 riMvkZ+pDiO9D3N2vMog0xKA==
X-Received: by 2002:a17:902:e84a:b0:24b:270e:56c0 with SMTP id
 d9443c01a7336-24b270e59d9mr6232945ad.36.1756804174282; 
 Tue, 02 Sep 2025 02:09:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFRwlwrI7ITsuC7hxVZE8H9unE8J+uw3idlvtHho4NpC6Az63pOeyyUH9/SnJuJcYFcX5WzCfy4X+IU+QDK+w=
X-Received: by 2002:a17:902:e84a:b0:24b:270e:56c0 with SMTP id
 d9443c01a7336-24b270e59d9mr6232695ad.36.1756804173832; Tue, 02 Sep 2025
 02:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
 <05aed3c3-f953-4287-b317-e7ef89c4c717@yandex-team.ru>
In-Reply-To: <05aed3c3-f953-4287-b317-e7ef89c4c717@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 2 Sep 2025 17:09:22 +0800
X-Gm-Features: Ac12FXw9bT5TGugS2h9GWCT2diF4IWY5-ydeB9TifhgMTgcv0UbzuXUJNsjof88
Message-ID: <CACGkMEsxBytJHwrhBCtcSqia4=1hK=AN42avaL2UcArQD=_3Jw@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] TAP initialization refactoring
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 1, 2025 at 10:28=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Ping!)
>
> Understand, that it's quite big. I can split into 2-3 series, if this hel=
ps.

I will have a look this week. The size should be fine so no need to split.

Thanks

>
> On 23.08.25 19:03, Vladimir Sementsov-Ogievskiy wrote:
> > Hi all!
> >
> > Here is a refactoring of initialization code, to improve its
> > readability and get rid of duplication.
> >
> > v2:
> > 01,03: improve commit msg
> > 14: fix return value for new net_tap_init_one()
> > 15: add return statements to other cases, to not break them
> > 20: new
> >
> > Below are the initialization flow diagrams showing the changes.
> >
> > BEFORE REFACTORING:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > ```
> > net_init_tap()
> >      |
> >      +-- if (tap->fd)
> >      |   +-- duplicated logic*
> >      |   +-- net_init_tap_one()
> >      |
> >      +-- else if (tap->fds)
> >      |   +-- for each fd:
> >      |       +-- duplicated logic*
> >      |       +-- net_init_tap_one()
> >      |
> >      +-- else if (tap->helper)
> >      |   +-- duplicated logic*
> >      |   +-- net_init_bridge()
> >      |
> >      +-- else (normal case)
> >          +-- for each queue:
> >              +-- net_tap_init()
> >              +-- net_init_tap_one()
> >
> > net_init_bridge()
> >      |
> >      +-- duplicated logic*
> >      +-- net_tap_fd_init()
> >
> > net_init_tap_one()
> >      |
> >      +-- net_tap_fd_init()
> >
> > net_tap_init()
> >      |
> >      +-- tap_open()
> >
> > net_tap_fd_init()
> >      |
> >      +-- qemu_new_net_client()
> >      +-- Initialize TAPState
> >
> > * duplicated logic: set fd nonblocking + probe vnet_hdr
> > ```
> >
> > AFTER REFACTORING:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > ```
> > net_init_tap()
> >      |
> >      +-- if (tap->fd)
> >      |   +-- net_tap_from_monitor_fd()
> >      |
> >      +-- else if (tap->fds)
> >      |   +-- for each fd:
> >      |       +-- net_tap_from_monitor_fd()
> >      |
> >      +-- else if (tap->helper)
> >      |   +-- net_init_bridge()
> >      |
> >      +-- else (normal case)
> >          +-- net_tap_open()
> >
> > net_tap_open()
> >      |
> >      +-- for each queue:
> >          +-- net_tap_open_one()
> >
> > net_tap_open_one()
> >      |
> >      +-- tap_open()
> >      +-- net_tap_fd_init_common()
> >
> > net_tap_from_monitor_fd()
> >      |
> >      +-- net_tap_fd_init_external()
> >
> > net_tap_fd_init_external()
> >      |
> >      +-- net_tap_fd_init_common()
> >
> > net_init_bridge()
> >      |
> >      +-- net_tap_fd_init_external()
> >
> > net_tap_fd_init_common()
> >      |
> >      +-- qemu_new_net_client()
> >      +-- Initialize TAPState
> > ```
> >
> > Solved problems:
> >
> > - duplicated logic to handle external
> >    file descriptors (set nonblocking, probe vnet_hdr)
> >
> > - duplication between tap/helper case in
> >    net_init_tap() and net_init_bridge()
> >
> > - confusing naming and functionality spread between functions (we had
> >    net_init_tap(), together with net_tap_init(); also main central
> >    function was net_init_tap_one(), and part of its logic (not clear
> >    why) moved to separate net_tap_fd_init()),
> >
> > - net_init_tap() was just too big
> >
> > Vladimir Sementsov-Ogievskiy (20):
> >    net/tap: net_init_tap_one(): add return value
> >    net/tap: add set_fd_nonblocking() helper
> >    net/tap: tap_set_sndbuf(): add return value
> >    net/tap: net_init_tap_one(): drop extra error propagation
> >    net/tap: net_init_tap_one(): move parameter checking earlier
> >    net/tap: net_init_tap(): refactor parameter checking
> >    net/tap: net_init_tap(): drop extra variable vhostfdname
> >    net/tap: move local variables related to the latter case to else
> >      branch
> >    net/tap: use glib strings vector and g_strsplit for fds case
> >    net/tap: drop extra tap_fd_get_ifname() call
> >    net/tap: net_init_tap_one(): refactor to use netdev as first arg
> >    net/tap: net_init_tap_one(): support bridge
> >    net/tap: net_init_bridge(): support tap
> >    net/tap: refactor net_tap_init() into net_tap_open_one()
> >    net/tap: introduce net_tap_open()
> >    net/tap: introduce net_tap_fd_init_external()
> >    net/tap: introduce net_tap_from_monitor_fd() helper
> >    net/tap: split net_tap_setup_vhost() separate function
> >    net/tap: drop net_tap_fd_init()
> >    net/tap: introduce net_init_tap_fds()
> >
> >   net/tap-linux.c |   5 +-
> >   net/tap.c       | 578 +++++++++++++++++++++++------------------------=
-
> >   net/tap_int.h   |   2 +-
> >   3 files changed, 277 insertions(+), 308 deletions(-)
> >
>
>
> --
> Best regards,
> Vladimir
>


