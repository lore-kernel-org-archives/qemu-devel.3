Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5472C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd7YS-000523-Hy; Fri, 26 Jun 2026 10:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wd7YQ-00051f-Ga
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:29:14 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wd7YO-0005b7-P2
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:29:14 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-39ad188f6d8so10974801fa.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 07:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782484150; cv=none;
 d=google.com; s=arc-20260327;
 b=E2vuXtnsM6iG9NlIANI5qUBbHHjXQ3KI1SOQIcXWsZehc2+H+ZXK1qPm3rsgWxQ+VJ
 DSdzKFIcQFpAIUxsi4wNmuLCsh/2NgdjunX/1S1d8w3mFSbmXABxcftQfZTHS4Be4/eY
 /sIwhOuxGJNhU8CY99dgjAh6ZEe/WyK5mQukj18xdNXejjBPXE/QuXlm5Xq0tl7rtPks
 zhaVGml0PdUvrWZ7b1kvw6Rni4ZodrjLBJS6tKJCq/t47yT0HGmX/OXEYYfVHNRZKA15
 sVK1+jPsMtgvM55g1QW6IpSFg27WvuuVVT/HHQOFyaylgn0/pJEMtTZgMmPAzSH5U22k
 syLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fTcRzdBHr9iCYU03/M7eGozHOShewHXCaAybGINyLc0=;
 fh=M53F9OyMyXaprNYz5ycy0QOslAkZgr8cpZk3PVQ0YK0=;
 b=U1rj4+ErMNoUGXJfytqcMioDya9O1Re5xKfvMBSqdoozpqX2SNL0NERbtat3XU8NKD
 tH/gvEWbHtdslL2C+XzU6kuYVNfIDz64kNQ1tfcsPiy/q7xnXMKTcNjS637VBUwA7xVy
 XyMGbzomOos8h0S0nLbDieMrrzo7qv4GFB2LfJIDnqJiT/yG+jM6WkD4awZdBEdbki0h
 AMmEiMOvOqMTxC6LJwBusnt9dU9fNbT/K7J/dCicDAXXR2/as1QmwUX1LptFNoqD689b
 GYBglnb4AjOShIFZAomEpu4DxzOz8QqSZcTFQlIs1BEPJfzlU1WcSl66d7T4gxIgNnBq
 EOdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782484150; x=1783088950; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTcRzdBHr9iCYU03/M7eGozHOShewHXCaAybGINyLc0=;
 b=LmP1cPpHDzfsrnC8TSrZCg180aLXSFv3I9dj6yLgzCEKVVSfFN424qlaKKr9YJlEd+
 htFeAqxJHeL+lJ4EQfCRUSFjeycfDHLiX+ZFzY2NsfB6rr1oKIF0xlnZg9e29EGs+45H
 M9My9z75ooKe8TsOjcBoN81az7785Gqcr9UJcoGgyqZFPu3Jy4ElBlCoK4yIhk9PlhMp
 I/K8dabi1bCKkSM0hvnbc1jUvDyuR8Z5cf5TF1g43mpgY+VNwT1TY7Mb9hDenhIVivIO
 wFTTBdvN0M6dgMER30Nb/Zu4MquC1CV2boJGjUdFN3D3C+uaAqPH01WNmuOixjQqjmb6
 3YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782484150; x=1783088950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fTcRzdBHr9iCYU03/M7eGozHOShewHXCaAybGINyLc0=;
 b=aDNn6V28IKW/yk/km2OvNVLLDDqK/oFBD9szBi9bSVIzmekXuVgxsfAD3BLlvDzl/f
 njickyirlnUBh3nwB2wTPrHHpaGRPXlJCaiAqoYFlF5YbaHQbthWcLiPRZY1vUH5/gVV
 ds/WbKPlomSy743f9K1e+uxgDNs4K5Sgzc8raJuV5hhcXuga+KVnhhgk/pH/Zso8ETDp
 yCatTMIR4iWBdvWelO/oq6q1nPrrrMnGxeW0Jiat+F6HLEWDpMNQOpCraHpmWbRUfpMf
 Mi5tvHs+J0j9Gt/MWCvGCkW6VUCPMdjCBEd13tshNdkq86p2uz1ifcDvjM5uvotkcCOj
 XJnw==
X-Gm-Message-State: AOJu0YzoGz5ocoKj5zwuGdHQdB8ftlCyp2W/lb7XgLZDHxB/XFxmft28
 xXSi64J5fWHmrlwysvpc3rvv7euaVYMxIhrVdYqmnujj9OIk6WbanDbEjbflOh1Inacs7UQ1B0s
 1jHLx5o7XLzytb/MMn/XXARUDYOcrtSU=
X-Gm-Gg: AfdE7cnRYTYcfII6GR4OTwnQN0WsRgqVPnlrcujMNDNNDvEsAvAxpfYqDBuES4GNwRx
 MPulVhkq4NYEwMdOB+/nbOPYhruGSymwAv/1wcY4uklMtoGD8u02PEFQQeZ3tvH5FAKC/T4SOD1
 YxbmeEISigcXvx7qVSRRhPUyQkx5qZxD+lfjU7ge8zRgNR/6x3mbk5vlH9QrOnn9p6f/Xxus3Tq
 raye4R34ilYmxNq0JHGrOyVDBgtYnwcnHPO7+RLly5T41BWZ/wIubvoAg8WS5n0bnDUc5xFTewv
 1BAJ9PNwFSQ2P0UzDknAzzlJ+VzCd/IfQnb2CA==
X-Received: by 2002:a05:6512:3983:b0:5aa:6e86:55e5 with SMTP id
 2adb3069b0e04-5aea945b98emr199400e87.13.1782484149900; Fri, 26 Jun 2026
 07:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <878q84owlq.fsf@suse.de>
In-Reply-To: <878q84owlq.fsf@suse.de>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Fri, 26 Jun 2026 19:58:55 +0530
X-Gm-Features: AVVi8CekDCB1KIK9qL6z0wbhRzpVExKPpsPbEdURroNW444pdNn5Pba4plyY7gM
Message-ID: <CA++cPvLDjpsdmhfz4Z1FmgGZp48T99jrTD0d0b0ET5n_6SRvmA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] migration: fast snapshot load
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jun 24, 2026 at 7:43=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Aadeshveer Singh <aadeshveer07@gmail.com> writes:
>
> > This RFC implements a "fast snapshot load" mechanism to significantly
> > reduce the perceived resume time of a VM from a snapshot file.
> >
> > Currently, resuming a VM from a snapshot file requires loading all RAM
> > pages into the QEMU instance before execution begins. This extension
> > allows the user to run the VM nearly instantly by loading only the
> > required device states up front and loading RAM pages lazily, by
> > trapping access to pages that have not yet been loaded.
> >
> > Using the Linux userfaultfd syscall, a fault thread catches all page
> > faults caused by the guest and loads in the pages required to keep
> > the VM running. Concurrently, an eager background thread iteratively
> > loads all remaining pages into RAM so the guest does not have to
> > depend on the fault thread indefinitely.
> >
> > Much of code is reused from postcopy for fault handling and precopy
> > for reading mapped ram file. Implementation revolves around two
> > threads named the fault thread and eager load thread. Fault thread as
> > name suggests catches page faults by the guest and serves them using
> > userfaultfd. Postcopy fault thread is reused but instead of requesting
> > source for a page it loads the page directly by reading form file. In
> > order to remove the dependency of guest on fault thread indefinitely
> > the eager load thread loads in the entire RAM sequentially, and after
> > iterating through the entire RAM signals fault thread to exit and
> > calls cleanup.
> >
> > In order to prevent the case of a page being loaded twice(in the
> > case when eager load thread is loading it and fault thread also
> > tries to serve fault on same page) a bitmap called pending_bmap is
> > used to track pages which are pending and not being loaded by any
> > thread. Atomic operations on this bitmap allows coordination between
> > threads to prevent any unwanted behaviours
> >
>
> How does it work if a second savevm happens while the RAM has not been
> yet entirely loaded?

Hi Fabiano,
Thanks for the review across the series.

To answer this: If a second savevm is issued before the RAM is fully
loaded, it will be blocked. Because the migration state remains
MIGRATION_STATUS_POSTCOPY_ACTIVE until the eager thread finishes
reading the last page from disk, standard QEMU migration checks will
reject any new savevm or migration requests.

>
> > This patch was tested using a Debian 13 bare minimum system and Fedora
> > 44 KDE, snapshots for both are loaded successfully with no error.
> >
> > Next Steps:
> > - Add testing framework, in qtest and unit tests
> > - Add support for postcopy-blocktime
> > - Update documentation
> >
> > Future direction:
> > - Add support for hugepages
> > - Add support for multifd
> > - Add support for vhost-user
> >
> > Aadeshveer Singh (5):
> >   migration: add RAM Block fields and helpers for fast snapshot load
> >   migration: add support for fault thread to load pages from disk
> >   migration: add eager load thread for fast snapshot load
> >   migration: write up code to run fast snapshot load in
> >     qemu_loadvm_state
> >   migration/tests: remove capability conflict test
> >     postcopy-ram+mapped-ram
> >
> >  include/system/ramblock.h          |   8 ++
> >  migration/migration.c              |  10 +-
> >  migration/migration.h              |   5 +
> >  migration/options.c                |  11 +-
> >  migration/options.h                |   1 +
> >  migration/postcopy-ram.c           | 167 ++++++++++++++++++++++++++---
> >  migration/postcopy-ram.h           |   2 +
> >  migration/qemu-file.c              |  10 +-
> >  migration/ram.c                    |  61 +++++++++--
> >  migration/savevm.c                 |  52 ++++++++-
> >  migration/savevm.h                 |   2 +
> >  migration/trace-events             |   2 +
> >  tests/qtest/migration/misc-tests.c |  52 ---------
> >  13 files changed, 283 insertions(+), 100 deletions(-)

