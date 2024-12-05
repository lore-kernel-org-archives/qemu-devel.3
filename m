Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04A1E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 19:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJHou-0007Xj-MW; Thu, 05 Dec 2024 14:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1tJHor-0007XA-Kr
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 14:47:26 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1tJHoq-0003X1-91
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 14:47:25 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso751546a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 11:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733428043; x=1734032843; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BciRCKo9dpXZef1l36yLtDmRjnwQE75qWNru87l1uBg=;
 b=MBEVVGoeiVut/2Z/GDnvcMCIjSldJPevooCE8o9BqJfkU49Z9hDlyQpL9FmwM06l86
 5UTXE01QLpeFmhiwAPKO5iV8tihv0ZW/RZNlZs6vrMBtuC6ty6NJ8pZKm5GnJbXDJubZ
 +yvAxaUzhIhtu8E//UNNDUso4FWGMAtbUFdeddqjHQlecxtdiuH/X1HRtEej7R6RC4M8
 87lRobXtzQMKcG0v8hc44x3Ljv04VVu2FmJ4urZSmGYo98x2SBtmvcRLnNUbEZpkIRd2
 Cuzk7rR8DeORJPymapddo2y3mmEwqOMGyRuleSTbF5k9NK2a/FETBlwEQXqQZEmxQKy1
 FSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428043; x=1734032843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BciRCKo9dpXZef1l36yLtDmRjnwQE75qWNru87l1uBg=;
 b=jMRhvOF4ejSF6BJPRKENcNUpg9JkjTjaUwdJ571LVYdZOP6OvrsNpcs5AMiGjs7/BY
 a8NkpPgHbn86jj0tJXYqd5ZmNhTcYLAdQ771YgZk90HohaEqI9Tcah7HNfCl58/8D8uX
 04NY7grH2XakjEzJGd+YRCBnApx+6gw0QPwHrX00JxfU0QJEDuIezE2IYoCG+Geuh9AZ
 WQZQWIRVbqDU8e42hLP5jW+3CNY9v+2AO+BHP4m3qQXSf6DRM1xdDzoTo52ruflal0PH
 FG+oUV8FO5+suGXMehJux8UuKdjdbZAijWI19upWzopQFkr4k4AwCeaFZx0jO404z+kb
 oILg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUNjuodhMw0vXRd619fK4xS+DMVJN/67rM0V6u6i9eJYT0325XFUKRKZ2VX6g+7pPw+uTcaVQCNN+r@nongnu.org
X-Gm-Message-State: AOJu0Yy1X87Cewm32DwU4ayLd0GDnimWbzK2LfKpmAmE4nwFMbmLxNNj
 ZFR6hSZurWYLsX8zswA+6PQ6zNfwLcuS3HFQEH5M9ZjMeQC2CDM/ZzoVDRugi3hL5ZbmHXGx+5j
 boBLw5ruY2acjawiVnSkvjXZgj+ytOA==
X-Gm-Gg: ASbGncudwmxjW9Mi1+xBstcdTinVlD0Q0t1E8odhxFCbLpQyyH8cKvDMQt1/YOhklEV
 IwXvhi7l7YKZQe2QekFXW/VItScV6ubA=
X-Google-Smtp-Source: AGHT+IHIQ/rE6IcD8HANmNY7vY2+0RVYp3RxBt9N16Dz/XNGJmcbgBdpOk8a6ZS2kGR6W22fTXM3LkcTTGP3QbLYsoQ=
X-Received: by 2002:a17:90b:3807:b0:2ee:74a1:fb92 with SMTP id
 98e67ed59e1d1-2ef6955f870mr598627a91.6.1733428042879; Thu, 05 Dec 2024
 11:47:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <624309a8e37f7779336bd5c0573d24f155b2ed41.1731773021.git.maciej.szmigiero@oracle.com>
 <Z1DJroYiKUwK-kMY@x1n>
In-Reply-To: <Z1DJroYiKUwK-kMY@x1n>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 6 Dec 2024 03:46:46 +0800
Message-ID: <CAK3tnvLsfe2FJ-zVkJRCk1xKDJ0ULP8DFaDMOFgDFCF4d+0j2g@mail.gmail.com>
Subject: Re: [PATCH v3 05/24] migration: Add MIG_CMD_SWITCHOVER_START and its
 load handler
To: Peter Xu <peterx@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabiano Rosas <farosas@suse.de>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 5, 2024 at 5:30=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Sun, Nov 17, 2024 at 08:20:00PM +0100, Maciej S. Szmigiero wrote:
> > diff --git a/migration/colo.c b/migration/colo.c
> > index 9590f281d0f1..a75c2c41b464 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -452,6 +452,9 @@ static int colo_do_checkpoint_transaction(Migration=
State *s,
> >          bql_unlock();
> >          goto out;
> >      }
> > +
> > +    qemu_savevm_maybe_send_switchover_start(s->to_dst_file);
> > +
> >      /* Note: device state is saved into buffer */
> >      ret =3D qemu_save_device_state(fb);
>
> Looks all good, except I'm not sure whether we should touch colo.  IIUC i=
t
> should be safer to remove it.
>

Agree with Peter's comments.
If I understand correctly, the current COLO doesn't support multifd migrati=
on.

Thanks
Chen




> --
> Peter Xu
>
>

