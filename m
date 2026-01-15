Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF70D46606
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSFa-0007dq-QG; Thu, 15 Jan 2026 13:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vgSEX-0007Bn-5G
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:38:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vgSEV-0002AP-KH
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768502289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DFjaApEJr7UidLbl4TGgfaNez9rwAXU3BJHbq0JW8AY=;
 b=EVq40YYTp8QEZ2nmxnMEHF2UeZnMTXXuoMzP2+Rx5HCa9B30VyDwSg+M9adSdYV/TYbH76
 aYipz29fTl+HB+u6LMktvvphJm9Zmi4XDcR1JcLuL6XbKF5C3CxUODhRZovwWhrctuXCEv
 8NrVHLihe6W5QqKHtpv99pcDOIHFudQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-a8T2bkn7MtamOpgVF0MAiA-1; Thu,
 15 Jan 2026 13:38:03 -0500
X-MC-Unique: a8T2bkn7MtamOpgVF0MAiA-1
X-Mimecast-MFC-AGG-ID: a8T2bkn7MtamOpgVF0MAiA_1768502282
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86B36180060F; Thu, 15 Jan 2026 18:38:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.134])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21B6D1800665; Thu, 15 Jan 2026 18:37:59 +0000 (UTC)
Date: Thu, 15 Jan 2026 13:37:58 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pkrempa@redhat.com, Hannes Reinecke <hare@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alberto Faria <afaria@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-block@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 0/4] scsi: persistent reservation live migration
Message-ID: <20260115183758.GA665239@fedora>
References: <20260113215320.566595-1-stefanha@redhat.com>
 <c8436397-fe56-4281-b9a4-5ed6175be055@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UTKX3iOVnKmmhvW/"
Content-Disposition: inline
In-Reply-To: <c8436397-fe56-4281-b9a4-5ed6175be055@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--UTKX3iOVnKmmhvW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 06:11:37PM +0100, Paolo Bonzini wrote:
> On 1/13/26 22:53, Stefan Hajnoczi wrote:
> > Live migration does not work for SCSI Persistent Reservations acquired =
on
> > scsi-block devices. This patch series migrates the reservation key and
> > reservation type so that the destination QEMU can take over the persist=
ent
> > reservation with the PREEMPT service action upon live migration.
> >=20
> > The approach involves snooping PERSISTENT RESERVE OUT replies and track=
ing the
> > scsi-block device's current reservation key and reservation type. In mo=
st cases
> > this involves no additional SCSI commands. This approach isn't perfect:=
 if
> > another machine modifies the reservation on the physical LUN, then QEMU=
's state
> > becomes stale. Persistent reservations are inherently cooperative, so t=
his is
> > acceptable as long as real applications don't run into problems.
>=20
> One issue is that this would not transfer reservations done from a previo=
us
> invocation of the VM.  Are you assuming that the restarted VM won't assume
> to still have the reservation?  I think this is fine, but it has to be
> documented, or maybe QEMU could issue a PR IN command at startup?

Good point. The reason for this limitation is that I don't see a
reliable way to detect reservation keys and reservations that belong to
a guest. This is why the patch series uses the snooping approach.

The basic READ KEYS and READ RESERVATION service actions for PERSISTENT
RESERVATION IN only report the list of reservation keys that have been
registered and the key of the current reservation holder. There is no
way of tying that information back to the guest or even the host. It
would be necessary to know the guest's unique reservation key, but that
can be chosen by the guest at runtime. In addition, keys are not
guaranteed to be unique so there is no way to tell whether this host is
actually the reservation holder without potentially destructive probing
(e.g. attempting a command and seeing if it results in a RESERVATION
CONFLICT).

The optional READ FULL STATUS service action improves the situation by
identifying the initiator together with the reservation holder's key,
but it is not universally available. The hardware I'm testing on doesn't
implement this service action.

Therefore the assumption is that the guest configures persistent
reservations and if it is shut down, it reclaims the reservation while
starting up again. It also means that an administrator cannot configure
persistent reservations outside the guest and expect live migration to
move those persistent reservations with the guest.

The clean way to handle persistent reservation migration is using Fibre
Channel N_Port ID Virtualization (NPIV) so that each guest is a distinct
initiator that can migrate to another host without messing with the
persistent reservation state. NPIV requires the storage administrator to
set up the initiators and their zoning - something that few users go
through the trouble of doing.

Having said all this, if someone knows about a better way or I'm wrong
about how this works, please let me know!

Stefan

--UTKX3iOVnKmmhvW/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmlpNAYACgkQnKSrs4Gr
c8g4IAgAqmnDoepsTqyWtQNgO2ms4ShVyBcXqS9qHLk1SetTWvKY0EVKQEur1zx/
6UlySvkM8qBRw0/GmcqkO56+sTcY/WFy3DLjvSkHMUhszqRXwWsr8+HXvBr7NjSY
faSoRu9vGNbaE4E/U0P2nBrsG82FsPXjfThK8Utlcp+nbMPP9n1Kf8vOJcUoj3+X
/Zbw6BCr09vaNB/3ecZCkj/JuCvGmD/Dw0tsGId6UEobFDjw6zZasyG2XteyUQ3T
derv/6umvKDvrUAwqLnm2XRJjRhrChe1H+PTu+mqfjXkW19bcCRJVdc4w3rjN/Id
kIsWKcsfk24cfemYa7AyNyj+tTZLWA==
=zIk/
-----END PGP SIGNATURE-----

--UTKX3iOVnKmmhvW/--


