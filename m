Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B06C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH27j-0006Dc-AW; Tue, 11 Jun 2024 10:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sH27g-00064I-85
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sH27e-0001hG-F8
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718114713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L4wPH+4tgj0Trt7UaPXNbwmTIK+vrVNtZc/zIVlAkvo=;
 b=JpB0u6pTAZBtJ4KRHklMkU2BqZUgrTXINjeYNGfkkPcdEPYf1zp2jz8ZHWWOtRQHj0LTsw
 58EUZ+iHZf5w71EE1bDAN8Xpy+FFMuv6dwyaIMMLzKEUe7ihlhJHLub3SmfGfEJ5tuHVJ1
 z03N3sZd2uogfbkqbTDhQFqHHGzuwhk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-09iZCzLwNIG93VKrkoHQXg-1; Tue,
 11 Jun 2024 10:05:07 -0400
X-MC-Unique: 09iZCzLwNIG93VKrkoHQXg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E2641954204; Tue, 11 Jun 2024 14:05:03 +0000 (UTC)
Received: from localhost (unknown [10.39.193.36])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E4534196B8C2; Tue, 11 Jun 2024 14:04:51 +0000 (UTC)
Date: Tue, 11 Jun 2024 10:04:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 pbonzini@redhat.com
Subject: Re: [RFC PATCH] migration/savevm: do not schedule
 snapshot_save_job_bh in qemu_aio_context
Message-ID: <20240611140449.GA366375@fedora.redhat.com>
References: <20240605120848.358654-1-f.ebner@proxmox.com>
 <20240606183638.GC198201@fedora.redhat.com>
 <6d64f07d-1638-44dc-848b-b307c0ebd0ad@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7QKAj/CNm8MP71bq"
Content-Disposition: inline
In-Reply-To: <6d64f07d-1638-44dc-848b-b307c0ebd0ad@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--7QKAj/CNm8MP71bq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 02:08:49PM +0200, Fiona Ebner wrote:
> Am 06.06.24 um 20:36 schrieb Stefan Hajnoczi:
> > On Wed, Jun 05, 2024 at 02:08:48PM +0200, Fiona Ebner wrote:
> >> The fact that the snapshot_save_job_bh() is scheduled in the main
> >> loop's qemu_aio_context AioContext means that it might get executed
> >> during a vCPU thread's aio_poll(). But saving of the VM state cannot
> >> happen while the guest or devices are active and can lead to assertion
> >> failures. See issue #2111 for two examples. Avoid the problem by
> >> scheduling the snapshot_save_job_bh() in the iohandler AioContext,
> >> which is not polled by vCPU threads.
> >>
> >> Solves Issue #2111.
> >>
> >> This change also solves the following issue:
> >>
> >> Since commit effd60c878 ("monitor: only run coroutine commands in
> >> qemu_aio_context"), the 'snapshot-save' QMP call would not respond
> >> right after starting the job anymore, but only after the job finished,
> >> which can take a long time. The reason is, because after commit
> >> effd60c878, do_qmp_dispatch_bh() runs in the iohandler AioContext.
> >> When do_qmp_dispatch_bh() wakes the qmp_dispatch() coroutine, the
> >> coroutine cannot be entered immediately anymore, but needs to be
> >> scheduled to the main loop's qemu_aio_context AioContext. But
> >> snapshot_save_job_bh() was scheduled first to the same AioContext and
> >> thus gets executed first.
> >>
> >> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/2111
> >> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> >> ---
> >>
> >> While initial smoke testing seems fine, I'm not familiar enough with
> >> this to rule out any pitfalls with the approach. Any reason why
> >> scheduling to the iohandler AioContext could be wrong here?
> >=20
> > If something waits for a BlockJob to finish using aio_poll() from
> > qemu_aio_context then a deadlock is possible since the iohandler_ctx
> > won't get a chance to execute. The only suspicious code path I found was
> > job_completed_txn_abort_locked() -> job_finish_sync_locked() but I'm not
> > sure whether it triggers this scenario. Please check that code path.
> >=20
>=20
> Sorry, I don't understand. Isn't executing the scheduled BH the only
> additional progress that the iohandler_ctx needs to make compared to
> before the patch? How exactly would that cause issues when waiting for a
> BlockJob?
>=20
> Or do you mean something waiting for the SnapshotJob from
> qemu_aio_context before snapshot_save_job_bh had the chance to run?

Yes, exactly. job_finish_sync_locked() will hang since iohandler_ctx has
no chance to execute. But I haven't audited the code to understand
whether this can happen.

Stefan

--7QKAj/CNm8MP71bq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZoWYEACgkQnKSrs4Gr
c8i4AwgAnAL1eJuFcov15YSTg5//ZuNkgdSB6MJDbK2RS+dm0woILRJTkEuQiBJw
GamN4FRQFXX48fFTk1Ww7ACRoiSQ9QIe9V3m5+ZeMneF6KMSqrvDV7qjrlduBT5a
MQLC7+2oWv8dg7j+hcbgTo6kzOnDwrX06R4qdyrCLAmK/oe70bR04CiRNPXKar/v
iHUr5H/N7gUwiSfs1JnrundGvlasu+xtVz7nJ+LLO1gRdLYfOb0UEk94Oe3r1A1I
at7y8kJG1BoVPeC1cWFuBpmYVlvu3ZAEYQTh621/vqn7BTRh8Gk3SILfrDKBy/4u
wU0n0QyRmZ2yV1gflu1x9F13WM5dIA==
=Ln32
-----END PGP SIGNATURE-----

--7QKAj/CNm8MP71bq--


