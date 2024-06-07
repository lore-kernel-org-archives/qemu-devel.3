Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DB0C27C55
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 22:07:44 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFcOw-0005bd-OR; Fri, 07 Jun 2024 12:25:14 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1sFcOu-0005bC-Px
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 12:25:12 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1sFcOr-0005v3-RU
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 12:25:12 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a68c5524086so273569166b.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1717777504; x=1718382304; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INlsx8np7RYxS+x/PsMXwLcYpgw9uIOEVBONEyYuKkQ=;
 b=NXll9MbhBeiRMSk1VEPnZppSTrDiC7Com7zKQyCo93sH19BbWP/r35shanSLbWhMEy
 lYs0rU2U6KIjms9xjtZNriRbmwxYgxhnhfPdUx9ErfwzBaPzx/Mgqnw7cZx9Y8I2mqK8
 aKKeuJ8LiwzhrF1zmY+t8sit13Z4GZ7JwO/VuJHSQNWfKjgHTHnqNWdEZQZ4Fsn7lkxm
 RXrx2q8mgMgcKcyUtRBxISXLJMcu9Re/sglS/N4ZGJ19mabQS1d3EKfikcB7KwSRP3Kf
 v3PbaOkLjp+eAZixoiJyrTJKa9HDCTFl33ihHCu7+kSCg9RJt5gj9ByX9OI4LE+JtVc8
 EgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717777504; x=1718382304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INlsx8np7RYxS+x/PsMXwLcYpgw9uIOEVBONEyYuKkQ=;
 b=d5bnidRO2/ALgBFIUarqY0uit/4nWQ/PMwa1NPRbPLr45twVpi/P5Lee7p2qYJKiWZ
 +BNa23utnHFgGJ+z58yHWcxwnOcEPfZGadVITdVzoLylHUz4Z1wdpwRh+8WGIA6Sjr5K
 EuQ1QBcNCoy9wAWkuzvDaWJqJF0tBCV5zBflX+Z+y8ADKPdsEz+Mseg0gf3WgEpT0Mav
 ZjAUDasUPJ+0v6y5xf1lYMT1r+HzbzZvgXDTlKaHyeSPScjnMQ/hWJRprrvSTxr3CA23
 f5zcSMRNmEX3g6lScE8CVHPb8+CnInwT4rLliD9brEzmub0TPu9dgoS2Kz2WGHg9DUH+
 pIGQ==
X-Gm-Message-State: AOJu0YwFxwAbtG6VfOjmfRUvZnzNFSWe1A3moWofAtPTJVN19WtIMwZP
 ufOFtp39vJA9wOG6jKVNbR4wkcJogKwuuZPvl/jplSs+xsaTViSAXMDX14G3mH9HkBJbxn5Tpet
 P3RpCq6w7JX2zkCMITMp1G6OCkJKJQbGZoKWqCg==
X-Google-Smtp-Source: AGHT+IE/Ku73Ss6uPK9q17BoWHv/wkU+34sP4blf4t8hH4ZwaxZkxEp51MEqwvs2EEl3EW/1Xv9mPNzsyaQX+R5+l4w=
X-Received: by 2002:a17:906:a5a:b0:a62:b679:3e7b with SMTP id
 a640c23a62f3a-a6cdb2f94c8mr200111966b.61.1717777504087; Fri, 07 Jun 2024
 09:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <20240605035622-mutt-send-email-mst@kernel.org>
 <e39d065823da4ef9beb5b37c17c9a990@huawei.com>
In-Reply-To: <e39d065823da4ef9beb5b37c17c9a990@huawei.com>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Fri, 7 Jun 2024 18:24:52 +0200
Message-ID: <CAHEcVy5psqfipiRFkvTyfONfX1b90SJ1iwZK7Tw+XnQvNDKUDQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Peter Xu <peterx@redhat.com>, 
 Michael Galaxy <mgalaxy@akamai.com>, Jinpu Wang <jinpu.wang@ionos.com>, 
 Elmar Gerdes <elmar.gerdes@ionos.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 zhengchuan <zhengchuan@huawei.com>, 
 "berrange@redhat.com" <berrange@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, 
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, Xiexiangyou <xiexiangyou@huawei.com>, 
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lixiao (H)" <lixiao91@huawei.com>, 
 Wangjialin <wangjialin23@huawei.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::633;
 envelope-from=yu.zhang@ionos.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Hello Gonglei,

Jinpu and I have tested your patchset by using our migration test
cases on the physical RDMA cards. The result is: among 59 migration
test cases, 10 failed. They are successful when using the original
RDMA migration coed, but always fail when using the patchset. The
syslog on the source server shows an error below:

Jun  6 13:35:20 ps402a-43 WARN: Migration failed
uuid=3D"44449999-3333-48dc-9082-1b6950e74ee1"
target=3D2a02:247f:401:2:2:0:a:2c error=3DFailed(Unable to write to
rsocket: Connection reset by peer)

We also tried to compare the migration speed between w/o the patchset.
Without the patchset, a big VM (with 16 cores, 64 GB memory) stressed
with heavy memory workload can be migrated successfully. With the
patchset, only a small idle VM (1-2 cores, 2-4 GB memory) can be
migrated successfully. In each failed migration, the above error is
issued on the source server.

Therefore, I assume that this version is not yet quite capable of
handling heavy load yet. I'm also looking in the code to see if
anything can be improved. We really appreciate your excellent work!

Best regards,
Yu Zhang @ IONOS cloud

On Wed, Jun 5, 2024 at 12:00=E2=80=AFPM Gonglei (Arei) <arei.gonglei@huawei=
.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Wednesday, June 5, 2024 3:57 PM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: qemu-devel@nongnu.org; peterx@redhat.com; yu.zhang@ionos.com;
> > mgalaxy@akamai.com; elmar.gerdes@ionos.com; zhengchuan
> > <zhengchuan@huawei.com>; berrange@redhat.com; armbru@redhat.com;
> > lizhijian@fujitsu.com; pbonzini@redhat.com; Xiexiangyou
> > <xiexiangyou@huawei.com>; linux-rdma@vger.kernel.org; lixiao (H)
> > <lixiao91@huawei.com>; jinpu.wang@ionos.com; Wangjialin
> > <wangjialin23@huawei.com>
> > Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket =
API
> >
> > On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
> > > From: Jialin Wang <wangjialin23@huawei.com>
> > >
> > > Hi,
> > >
> > > This patch series attempts to refactor RDMA live migration by
> > > introducing a new QIOChannelRDMA class based on the rsocket API.
> > >
> > > The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> > > that is a 1-1 match of the normal kernel 'sockets' API, which hides
> > > the detail of rdma protocol into rsocket and allows us to add support
> > > for some modern features like multifd more easily.
> > >
> > > Here is the previous discussion on refactoring RDMA live migration
> > > using the rsocket API:
> > >
> > > https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@lina=
r
> > > o.org/
> > >
> > > We have encountered some bugs when using rsocket and plan to submit
> > > them to the rdma-core community.
> > >
> > > In addition, the use of rsocket makes our programming more convenient=
,
> > > but it must be noted that this method introduces multiple memory
> > > copies, which can be imagined that there will be a certain performanc=
e
> > > degradation, hoping that friends with RDMA network cards can help ver=
ify,
> > thank you!
> >
> > So you didn't test it with an RDMA card?
>
> Yep, we tested it by Soft-ROCE.
>
> > You really should test with an RDMA card though, for correctness as muc=
h as
> > performance.
> >
> We will, we just don't have RDMA cards environment on hand at the moment.
>
> Regards,
> -Gonglei
>
> >
> > > Jialin Wang (6):
> > >   migration: remove RDMA live migration temporarily
> > >   io: add QIOChannelRDMA class
> > >   io/channel-rdma: support working in coroutine
> > >   tests/unit: add test-io-channel-rdma.c
> > >   migration: introduce new RDMA live migration
> > >   migration/rdma: support multifd for RDMA migration
> > >
> > >  docs/rdma.txt                     |  420 ---
> > >  include/io/channel-rdma.h         |  165 ++
> > >  io/channel-rdma.c                 |  798 ++++++
> > >  io/meson.build                    |    1 +
> > >  io/trace-events                   |   14 +
> > >  meson.build                       |    6 -
> > >  migration/meson.build             |    3 +-
> > >  migration/migration-stats.c       |    5 +-
> > >  migration/migration-stats.h       |    4 -
> > >  migration/migration.c             |   13 +-
> > >  migration/migration.h             |    9 -
> > >  migration/multifd.c               |   10 +
> > >  migration/options.c               |   16 -
> > >  migration/options.h               |    2 -
> > >  migration/qemu-file.c             |    1 -
> > >  migration/ram.c                   |   90 +-
> > >  migration/rdma.c                  | 4205 +--------------------------=
--
> > >  migration/rdma.h                  |   67 +-
> > >  migration/savevm.c                |    2 +-
> > >  migration/trace-events            |   68 +-
> > >  qapi/migration.json               |   13 +-
> > >  scripts/analyze-migration.py      |    3 -
> > >  tests/unit/meson.build            |    1 +
> > >  tests/unit/test-io-channel-rdma.c |  276 ++
> > >  24 files changed, 1360 insertions(+), 4832 deletions(-)  delete mode
> > > 100644 docs/rdma.txt  create mode 100644 include/io/channel-rdma.h
> > > create mode 100644 io/channel-rdma.c  create mode 100644
> > > tests/unit/test-io-channel-rdma.c
> > >
> > > --
> > > 2.43.0
>

