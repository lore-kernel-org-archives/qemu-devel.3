Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F29C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 17:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHnWj-0002Hy-HP; Wed, 21 May 2025 13:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uHnWh-0002H4-Sz
 for qemu-devel@nongnu.org; Wed, 21 May 2025 13:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uHnWc-00072o-9f
 for qemu-devel@nongnu.org; Wed, 21 May 2025 13:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747849599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIVjUZ0G+0XzGnuQsGafc/1sAITX5npAyoV0HZIImwM=;
 b=ArHwVKpg2VwCvV5oiKye0sshN4gn6K7YWFDetmIQ7G4OIbsqwDyEIXM1lB4L/FZPYtKkUn
 7vjfXekg6unXYdUCuj1efe+IyBzocGr20EGehfMv2Ap7rkTUxho3FDyrXOyt5p5gaDGtuW
 uQWXfL90Q2tpoZEVLzK5urXXbMam2Ds=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-KFs8XNSZPkeQno7XB0K9Vw-1; Wed,
 21 May 2025 13:46:37 -0400
X-MC-Unique: KFs8XNSZPkeQno7XB0K9Vw-1
X-Mimecast-MFC-AGG-ID: KFs8XNSZPkeQno7XB0K9Vw_1747849596
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14A03180045B; Wed, 21 May 2025 17:46:36 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B39D019560B7; Wed, 21 May 2025 17:46:33 +0000 (UTC)
Date: Wed, 21 May 2025 19:46:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 bmarzins@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] file-posix: Probe paths and retry SG_IO on potential
 path errors
Message-ID: <aC4Rdt5HWgh7LGjG@redhat.com>
References: <20250513113730.37404-1-kwolf@redhat.com>
 <20250513135148.GB227327@fedora> <aCWiuYUWiwKJz4_j@redhat.com>
 <20250515140142.GA333399@fedora> <aCYCFrh_As6XuPQj@redhat.com>
 <20250520140339.GC82528@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1qwCXJTHJl0cxuYR"
Content-Disposition: inline
In-Reply-To: <20250520140339.GC82528@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--1qwCXJTHJl0cxuYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.05.2025 um 16:03 hat Stefan Hajnoczi geschrieben:
> On Thu, May 15, 2025 at 05:02:46PM +0200, Kevin Wolf wrote:
> > Am 15.05.2025 um 16:01 hat Stefan Hajnoczi geschrieben:
> > > On Thu, May 15, 2025 at 10:15:53AM +0200, Kevin Wolf wrote:
> > > > Am 13.05.2025 um 15:51 hat Stefan Hajnoczi geschrieben:
> > > > > On Tue, May 13, 2025 at 01:37:30PM +0200, Kevin Wolf wrote:
> > > > > > When scsi-block is used on a host multipath device, it runs int=
o the
> > > > > > problem that the kernel dm-mpath doesn't know anything about SC=
SI or
> > > > > > SG_IO and therefore can't decide if a SG_IO request returned an=
 error
> > > > > > and needs to be retried on a different path. Instead of getting=
 working
> > > > > > failover, an error is returned to scsi-block and handled accord=
ing to
> > > > > > the configured error policy. Obviously, this is not what users =
want,
> > > > > > they want working failover.
> > > > > >=20
> > > > > > QEMU can parse the SG_IO result and determine whether this coul=
d have
> > > > > > been a path error, but just retrying the same request could jus=
t send it
> > > > > > to the same failing path again and result in the same error.
> > > > > >=20
> > > > > > With a kernel that supports the DM_MPATH_PROBE_PATHS ioctl on d=
m-mpath
> > > > > > block devices (queued in the device mapper tree for Linux 6.16)=
, we can
> > > > > > tell the kernel to probe all paths and tell us if any usable pa=
ths
> > > > > > remained. If so, we can now retry the SG_IO ioctl and expect it=
 to be
> > > > > > sent to a working path.
> > > > > >=20
> > > > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > > > > ---
> > > > > >  block/file-posix.c | 82 ++++++++++++++++++++++++++++++++++++++=
+++++++-
> > > > > >  1 file changed, 81 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > Maybe the probability of retry success would be higher with a del=
ay so
> > > > > that intermittent issues have time to resolve themselves. Either =
way,
> > > > > the patch looks good.
> > > >=20
> > > > I don't think adding a delay here would be helpful. The point of
> > > > multipath isn't that you wait until a bad path comes back, but that=
 you
> > > > just switch to a different path until it is restored.
> > >=20
> > > That's not what this loop does. DM_MPATH_PROBE_PATHS probes all paths
> > > and fails when no paths are available. The delay would only apply in =
the
> > > case when there are no paths available.
> > >=20
> > > If the point is not to wait until some path comes back, then why loop=
 at
> > > all?
> >=20
> > DM_MPATH_PROBE_PATHS can only send I/O to paths in the active path
> > group, so it doesn't fail over to different path groups. If there are no
> > usable paths left in the current path group, but there are some in
> > another one, then the ioctl returns 0 and the next SG_IO would switch to
> > a different path group, which may or may not succeed. If it fails, we
> > have to probe the paths in that group, too.
>=20
> This wasn't obvious to me, can that be emphasized in the code via naming
> or comments? About retrying up to 5 times: is the assumption that there
> will be 5 or fewer path groups?

Originally, the thought behind the 5 was more about the case where
DM_MPATH_PROBE_PATHS offlines bad paths, but then another one goes down
before we retry SG_IO, so that it fails again.

But you're right that it would now apply to retrying in a different path
group. The assumption we make would then be that there will be 5 or
fewer path groups with no working path in them (rather than just 5 of
them existing). That doesn't seem like a completely unreasonable
assumption, but maybe we should increase the number now just to be on
the safe side?

Ben, do you have an opinion on this?

Kevin

--1qwCXJTHJl0cxuYR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmguEXYACgkQfwmycsiP
L9YFZBAArnCOrIPO4mlo5HJSLpn2vmKieiqPyrS1dRjmUO4ZQ9Sn615cvfpe6IuS
dK++qZBAsgbwOd4tP4EYSbvuAd8BmLvEHGJliI1bk8x+7PqUo1XT2Xwj4YUxvFum
YSIB+WcWMEmSZur+PvkGQrAZOz70s1zE3X/Mq7eCd4xcEjXiAKh2LMLujyBHomtp
Ac090V7gy6atTMXw3v8+k4T2bGwrED4GBiI6hX9I8h9sFwrjtlMuTf7UmRn59bjp
Knz84z3piMyXReCxi2aSUgjK4gnhNdj8qL17LgcuV9MJe8DEhWeyYBSONGDQNjDt
IuzvG+7RuDAkjdMlkdkdHhdqHcIqj+hQJlj/Gf8RRS4e7GEim1DxK3OI427op9F2
CLp5z67wVyVKNPrBcH4zkPVe3pB95wAhRxc2jHmYbdPHIGEQlGLUdUk6hBiswziI
sup6pa8hQCDRiabmA6ayxALH2J739v/c3+7hkF2FA5kEMSNf9wFcWYfuEH2Grsua
HRXBcOUfFgHGmwJcnilwxcXzKoY24NkoB4Tlt/zQPA14hZcf43lhIgzSCHiOy4GT
88araqmSvVvXOsUCaSZuduQsnx7uxKI/mtZDdSEmz1LMDL2Tkvs9EWpcxhBB3c3b
s2qQd3xcGBSdtEgjY/9t9UGhHraoMsw0BTHkCEE23mZ7RI16Jn4=
=lHQ9
-----END PGP SIGNATURE-----

--1qwCXJTHJl0cxuYR--


