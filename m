Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220BBD5B172
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 14:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV9wF-00032M-EK; Mon, 15 Dec 2025 09:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vV9wD-00031M-Kq
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:52:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vV9wB-0008QR-Oz
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765810353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eq4KgYOtqRBiLie2Uc3Bar12Vtlzt4cWCeb+rglMjPw=;
 b=D29lb6g5PdxRsBpP6RQwIfQt3I5zbQLoZtmQQzBIP7LZFygsKBfp+sfzs1/wD+fUIOI4WO
 APDzAacuFrAjkrxIy8dlyHEQb70g3HBynsHy4Se3QX2RDdqTFnbHoXPO3QMuiFlGhA+rS2
 uBuRxP+6wuAKVOuvvZxyYkiI9cwnuzc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-yVRg4r-wNGmhcaQuwHVjQw-1; Mon,
 15 Dec 2025 09:52:29 -0500
X-MC-Unique: yVRg4r-wNGmhcaQuwHVjQw-1
X-Mimecast-MFC-AGG-ID: yVRg4r-wNGmhcaQuwHVjQw_1765810348
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2034A19560A5; Mon, 15 Dec 2025 14:52:28 +0000 (UTC)
Received: from localhost (unknown [10.2.16.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72D3C1800576; Mon, 15 Dec 2025 14:52:26 +0000 (UTC)
Date: Mon, 15 Dec 2025 09:52:25 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v2 for-10.2] Revert "nvme: Fix coroutine waking"
Message-ID: <20251215145225.GA23007@fedora>
References: <20251215141540.88915-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7FEhguUDuXU15/xb"
Content-Disposition: inline
In-Reply-To: <20251215141540.88915-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--7FEhguUDuXU15/xb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 03:15:40PM +0100, Hanna Czenczek wrote:
> This reverts commit 0f142cbd919fcb6cea7aa176f7e4939925806dd9.
>=20
> Said commit changed the replay_bh_schedule_oneshot_event() in
> nvme_rw_cb() to aio_co_wake(), allowing the request coroutine to be
> entered directly (instead of only being scheduled for later execution).
> This can cause the device to become stalled like so:
>=20
> It is possible that after completion the request coroutine goes on to
> submit another request without yielding, e.g. a flush after a write to
> emulate FUA.  This will likely cause a nested nvme_process_completion()
> call because nvme_rw_cb() itself is called from there.
>=20
> (After submitting a request, we invoke nvme_process_completion() through
> defer_call(); but the fact that nvme_process_completion() ran in the
> first place indicates that we are not in a call-deferring section, so
> defer_call() will call nvme_process_completion() immediately.)
>=20
> If this inner nvme_process_completion() loop then processes any
> completions, it will write the final completion queue (CQ) head index to
> the CQ head doorbell, and subsequently execution will return to the
> outer nvme_process_completion() loop.  Even if this loop now finds no
> further completions, it still processed at least one completion before,
> or it would not have called the nvme_rw_cb() which led to nesting.
> Therefore, it will now write the exact same CQ head index value to the
> doorbell, which effectively is an unrecoverable error[1].
>=20
> Therefore, nesting of nvme_process_completion() does not work at this
> point.  Reverting said commit removes the nesting (by scheduling the
> request coroutine instead of entering it immediately), and so fixes the
> stall.
>=20
> On the downside, reverting said commit breaks multiqueue for nvme, but
> better to have single-queue working than neither.  For 11.0, we will
> have a solution that makes both work.
>=20
> A side note: There is a comment in nvme_process_completion() above
> qemu_bh_schedule() that claims nesting works, as long as it is done
> through the completion_bh.  I am quite sure that is not true, for two
> reasons:
> - The problem described above, which is even worse when going through
>   nvme_process_completion_bh() because that function unconditionally
>   writes to the CQ head doorbell,
> - nvme_process_completion_bh() never takes q->lock, so
>   nvme_process_completion() unlocking it will likely abort.
>=20
> Given the lack of reports of such aborts, I believe that completion_bh
> simply is unused in practice.
>=20
> [1] See the NVMe Base Specification revision 2.3, page 180, figure 152:
>     =E2=80=9CInvalid Doorbell Write Value: A host attempted to write an i=
nvalid
>     doorbell value. Some possible causes of this error are: [...] the
>     value written is the same as the previously written doorbell value.=
=E2=80=9D
>=20
>     To even be notified of this error, we would need to send an
>     Asynchronous Event Request to the admin queue (p. 178ff), which we
>     don=E2=80=99t do, and then to handle it, we would need to delete and
>     recreate the queue (p. 88, section 3.3.1.2 Queue Usage).
>=20
> Cc: qemu-stable@nongnu.org
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Tested-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/nvme.c | 56 +++++++++++++++++++++++++---------------------------
>  1 file changed, 27 insertions(+), 29 deletions(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--7FEhguUDuXU15/xb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmlAIKkACgkQnKSrs4Gr
c8haKAf+MWZOwR4kCCwOI2zuZWy+lNjVKmzyvB4w4mGEM1OcGX8ejAjS8quC4OEe
xAFmEdNMGeJJVqXnP2YF9maQaM6Gw61cUDc9i/lc101958PRsySDr99qLTtZvuCs
1kJBhZhInIlgg1onOAaYhDPwfBGCeT9WIUzieQcSjj5TlOtFQaHxWgEaCa6D4RiK
YVE5UqNQ9j+jG5VicrVuDKRl5QTPM3uZLrqHE58OQrpaNwAXh0IwxvKiS4ZHe59s
p28dSTpWQyVDbZkkVDW7Lz8V6bYVbEQlNWH47/dvbUKePbSIdQplunBQhUnNNFa0
KXFsMV7jndpe4HIBDgZlAck5jkymyg==
=dPoa
-----END PGP SIGNATURE-----

--7FEhguUDuXU15/xb--


