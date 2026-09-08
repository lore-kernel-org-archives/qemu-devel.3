Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3331C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vx3-0001kL-O4; Tue, 08 Sep 2026 09:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1x3vx1-0001jx-Oq
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:33:28 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1x3vwz-0005ZI-QW
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:33:27 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so6897625a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 06:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788874404; x=1789479204; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qsXUN0ZSiymaLucTNiJbPFjd+9xaMr3N08xJF26N9dc=;
 b=JQWMmtfZaxCXHJNUqBnOVB910OWsVwByFCgFb1cDIXfG/TRGup+B1xTjBWQEO12VjG
 EVNwUdMsqAt6tFFke1sW/c0tboeiihHBVrrxemdQ/6vL7lFUf8Pg3yg4zB4YZafGWyYj
 PjoPLhEZLZDrLgv/ogX3uGalV0Ol3LzCeVHFi+TR5/8sV5Mc/MHRKQX2A+uTQh5EQdU7
 nDXebMJI+nMQTuqud/hjbFPEt8F/m3kr5NaY+d0PCJnZfUsk6IIX0ry1klxemEz8dqP7
 MgmfwmW0bTQjnAAjnLLL9UA4eKTVrMbC8J3Cbj7HKje9hG5DEX4rWKQc1wCzwADQJ3WS
 DU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788874404; x=1789479204;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qsXUN0ZSiymaLucTNiJbPFjd+9xaMr3N08xJF26N9dc=;
 b=srm20mfnqE5WPW3laVVrdG8jxtCs8JyeKy4SR/jvLV8MSr+gQOWJ0Q48ajK2rg24l+
 HTKYmmALbZGA9CsntCcn4naNhpU4bv+n1wT/gUygCSYvr1NEfvO7Eirn3IllxgIir+96
 eOKclnwjjr+vtwtYMsPPJeoeyNrdJh+LJrMBov2s9q1J07jeZpmxuLts7943MC9w48EL
 m0ZvXgDM3kUnBanNNZYmYusLvG2nefuit4usp/ArSPBNtShEnGmUmOUFPHn/CZnHu+aI
 Bde27Uwrt2T2c7GkHdaJCg2kDxpL6pW6UZzeVPmf91nceHfnugIDxd3mGAgLl/CLrlij
 4urA==
X-Gm-Message-State: AFuF++njZDEoTRHRvzFmP4akQ8Cf/3WTVqeYxLWhjA6cuUQCbbqsQ7S6
 Cga3BJDL53xnRC8+Ns3FeYaotFA7gzxrmPw/yhTAeUfRvKCK/SshVxbZ
X-Gm-Gg: AYBFou2Xu0eO1aZEqT9+DykztaaR3ciSJt/PxxIccPfozTJAlw1Uy1Kr6TXE9crvZCb
 etz5ksaAIM2dFkuWkqvLvJRhFU5RCoUQSqw0JduwxuB/gtJN97IgynAgxHYk2or+9dANXnn87Um
 7iPRfraRBFJ+t0d7Q5p1+6/kW85ujFe1jLOZ+GLjYNvOYlmcf3hRY6srnK0x/pHSZ8ELrdTyMt7
 iyLrglrNCvy95iQhfLPkHbetPd/2h4YAqUK5hqVGXsnN40yACCJIkvAixan7kI/JpwWoOZ2AD+/
 ib+nmoGrTzvSG0tv62v0gadVlODUmnjQLtvAPc3VcVLyRe2fq1H+CsKcK9DaXoRBM6bUWvZ8f0N
 YqahB+x6NOZN3PuhQBWs8mhrs1hP+DDvSVY//E0FnhDs/Z9xkP521aLgjplWe0kr/jZ9yxDdS9r
 ZzmcPAqrDRIcQ4a+4uLbGfITTioAOjUHLJs3FWbOugc2OvG25mlbOCiyF4wWBb1oG5IZFXwpAUq
 GtKmFLwHVmzC06GT7E7TnUKVbh6JAzMe5WADmHIEPrKMYS5orILWi/tlCx4p0PPWrwPs/RT
X-Received: by 2002:a05:6402:3706:b0:6a6:7818:b18 with SMTP id
 4fb4d7f45d1cf-6a7e90a9981mr10549839a12.22.1788874403281; 
 Tue, 08 Sep 2026 06:33:23 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-ee82-4536-a8f2-9e22.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:ee82:4536:a8f2:9e22])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9882a8510sm6147a12.21.2026.09.08.06.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 06:33:22 -0700 (PDT)
Date: Tue, 8 Sep 2026 15:32:24 +0200
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3] qga: implement 'guest-get-fsinfo' for FreeBSD
Message-ID: <aqAOaBGmp5oOAIIT@tulp>
References: <20260714165759.7521-1-bogorodskiy@gmail.com>
 <anxADf6QF3lqzLLw@tulp>
 <CAPMcbCr9=tX=PKCiqOK=kPa70ccw3_WUArYepLYdUxvx5q0gmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPMcbCr9=tX=PKCiqOK=kPa70ccw3_WUArYepLYdUxvx5q0gmg@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x52a.google.com
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

  Kostiantyn Kostiuk wrote:

> Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> 
> Will be merged after code freeze

Hi Kostiantyn,

Gentle ping on this one now that the code freeze should be over.

> On Wed, Aug 12, 2026 at 12:43 PM Roman Bogorodskiy <bogorodskiy@gmail.com>
> wrote:
> 
> >   Roman Bogorodskiy wrote:
> >
> > > Implement the qmp_guest_get_fsinfo() API for FreeBSD.
> > > To implement it, reuse build_fs_mount_list() which is already
> > > implemented for FreeBSD. Extend the FsMount type to include
> > > a string "fromname" attribute to store the disk the FS is mounted from.
> > >
> > > Disk mapping info is not covered by this implementation.
> > >
> > > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> > > ---
> > > Changes since v1:
> > >
> > >  - Replace g_malloc0() with g_new0(.., 1) for GuestFilesystemInfo
> > >
> > > Changes since v2:
> > >
> > >  - Drop the unused 'errp' argument to build_guest_fsinfo() and
> > >    clean up the related code.
> > >  - Fix leaking string through g_strdup() for a g_path_get_basename()
> > >    allocated string.
> > >
> > >  qga/commands-bsd.c    | 53 ++++++++++++++++++++++++++++++++++++++++++-
> > >  qga/commands-common.h |  1 +
> > >  qga/commands-posix.c  |  3 +++
> > >  qga/qapi-schema.json  | 12 +++++-----
> > >  4 files changed, 62 insertions(+), 7 deletions(-)
> >
> > ping
> >
> > https://patchew.org/QEMU/20260714165759.7521-1-bogorodskiy@gmail.com/
> >
> >

