Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA83CE835C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 15:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svIMw-0005VL-LB; Mon, 30 Sep 2024 11:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1svIMu-0005Ud-UP
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 11:31:25 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1svIMr-00075Z-Rt
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 11:31:24 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8d2b4a5bf1so622889266b.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1727710278; x=1728315078; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/BXX468qL0r2NQKwVpnTOoFA8mwwQGqQCuV9lJ2ZWO0=;
 b=OcgwZJ+IrCtCopXbE38iY24MrjbJrLjSed2ApRXEicG1Wgzd4R8o3J79JqTRoTaY7U
 8gcfcqGBIjn3kAOj7pV3iYj5O34MGKi/Wcuy0rjsFh1gfi2tPUlpkP7UVRIvrUscVL6D
 jhvs/4fBU4MAa0rVwUmOJv2GZMwpOKgfNrZGejQ96wVmwxEYyPhVk9xEdYjjQaiNvY3i
 PVwU2lGOzF1mlda5g2MTF3UbRZNGBSWeExvExGN/G7MwiKhNEnqG331pCU3XuQOU+EXe
 3aU12BAeQeQIOgRR/lfI7yfxJiGOOBocSqvGy+BpIGlhaWyNKvEpD2+CtiU6xlymgkS3
 bVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727710278; x=1728315078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/BXX468qL0r2NQKwVpnTOoFA8mwwQGqQCuV9lJ2ZWO0=;
 b=EnB/QtChSRxfb+LQpBdn6yrx/E/2gIa42d6uz8Xb6WakhIljH6iFPYUBUnC4Z4Amb5
 mv6IJXwrwML9StHDK1bwQ7MEmhlewjOTt//HwqYbkZfTt+Y+/5xn+9+B/sYWHHIh8YDY
 J0lkaLSwN+l069qDbs16SKPtrjIGM+k8/xpgFJxIzjgdwCwGv2fOCHPNzyWiRRKumUPU
 2D6rXpsEKU5uTsDOlRM8V+q1aMD9u6nrdJsDTuNyTOOiobllWPBiQvNPY4Y8bgomyseJ
 ESseWj/2tMph7bM6N7YCCvm8LCzQu2UilQswbyWbELXaxkr6JZSQxAaKYJ5MFEZ9CjrL
 2NyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3oKMa9FGkPaOwqvUEtaXicquXyFvp5s6FSlb9zaMzsEcWlfqx5JYYFJLhpfjKTtZ/KqNcYMBQiv6L@nongnu.org
X-Gm-Message-State: AOJu0Yw2N4UZvhSGZPsxkeWeipgnW6PlUGjd2pxej1WBM06bPlKOwT7A
 /iovAbCFbJvY7paY3h3jNWUos7SoXrnZ97hvNUPrXZUYEjxK2lH30bnKD1e1BTZY1xCHJ1bcqbJ
 VpgAFayX1Be1xmcBnnhNUGU6nsk1i+Rpz9A6AVQ==
X-Google-Smtp-Source: AGHT+IHluEb4B7Koo7MifzrpmBQfMoz7nnODdaANxlpzG/ANSBzF2DKPiSP0Dt8XFQq+rifbj4YkwrlR9chPCXX5rOU=
X-Received: by 2002:a17:907:6d1b:b0:a8d:64af:dc4c with SMTP id
 a640c23a62f3a-a93c4909952mr1461012166b.25.1727710278245; Mon, 30 Sep 2024
 08:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n> <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
 <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
 <20240929141323-mutt-send-email-mst@kernel.org>
 <46f8e54e-64a4-4d90-9b02-4fd699b54e41@akamai.com>
 <20240929182538-mutt-send-email-mst@kernel.org>
 <ce4dc43a-69d7-4623-abc4-b40b681595b2@akamai.com>
In-Reply-To: <ce4dc43a-69d7-4623-abc4-b40b681595b2@akamai.com>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Mon, 30 Sep 2024 17:31:07 +0200
Message-ID: <CAHEcVy4737zxRhOeXg=W-49e0ffhik6+gr1KxSLepWA_dVf4xw@mail.gmail.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: Michael Galaxy <mgalaxy@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sean Hefty <shefty@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>, 
 "berrange@redhat.com" <berrange@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, 
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 Xiexiangyou <xiexiangyou@huawei.com>, 
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lixiao (H)" <lixiao91@huawei.com>, 
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 Wangjialin <wangjialin23@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::633;
 envelope-from=yu.zhang@ionos.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hello Michael,

That's true. To my understanding, to ease the maintenance, Gonglei's
team has taken efforts to refactorize the RDMA migration code by using
rsocket. However, due to a certain limitation in rsocket, it turned
out that only small VM (in terms of core number and memory) can be
migrated successfully. As long as this limitation persists, no
progress can be achieved in this direction. One the other hand, a
proper test environment and integration / regression test cases are
expected to catch any possible regression due to new changes. It seems
that currently, we can go in this direction.

Best regards,
Yu Zhang @ IONOS cloud

On Mon, Sep 30, 2024 at 5:00=E2=80=AFPM Michael Galaxy <mgalaxy@akamai.com>=
 wrote:
>
>
> On 9/29/24 17:26, Michael S. Tsirkin wrote:
> > !-------------------------------------------------------------------|
> >    This Message Is From an External Sender
> >    This message came from outside your organization.
> > |-------------------------------------------------------------------!
> >
> > On Sun, Sep 29, 2024 at 03:26:58PM -0500, Michael Galaxy wrote:
> >> On 9/29/24 13:14, Michael S. Tsirkin wrote:
> >>> !-------------------------------------------------------------------|
> >>>     This Message Is From an External Sender
> >>>     This message came from outside your organization.
> >>> |-------------------------------------------------------------------!
> >>>
> >>> On Sat, Sep 28, 2024 at 12:52:08PM -0500, Michael Galaxy wrote:
> >>>> A bounce buffer defeats the entire purpose of using RDMA in these ca=
ses.
> >>>> When using RDMA for very large transfers like this, the goal here is=
 to map
> >>>> the entire memory region at once and avoid all CPU interactions (exc=
ept for
> >>>> message management within libibverbs) so that the NIC is doing all o=
f the
> >>>> work.
> >>>>
> >>>> I'm sure rsocket has its place with much smaller transfer sizes, but=
 this is
> >>>> very different.
> >>> To clarify, are you actively using rdma based migration in production=
? Stepping up
> >>> to help maintain it?
> >>>
> >> Yes, both Huawei and IONOS have both been contributing here in this em=
ail
> >> thread.
> >>
> >> They are both using it in production.
> >>
> >> - Michael
> > Well, any plans to work on it? for example, postcopy does not really
> > do zero copy last time I checked, there's also a long TODO list.
> >
> I apologize, I'm not following the question here. Isn't that what this
> thread is about?
>
> So, some background is missing here, perhaps: A few months ago, there
> was a proposal
> to remove native RDMA support from live migration due to concerns about
> lack of testability.
> Both IONOS and Huawei have stepped up that they are using it and are
> engaging with the
> community here. I also proposed transferring over maintainership to them
> as well.  (I  no longer
> have any of this hardware, so I cannot provide testing support anymore).
>
> During that time, rsocket was proposed as an alternative, but as I have
> laid out above, I believe
> it cannot work for technical reasons.
>
> I also asked earlier in the thread if we can cover the community's
> testing concerns using softroce,
> so that an integration test can be made to work (presumably through
> avocado or something similar).
>
> Does that history make sense?
>
> - Michael
>

