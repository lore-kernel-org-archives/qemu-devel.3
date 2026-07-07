Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B33EC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh2sX-00089o-Iw; Tue, 07 Jul 2026 06:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wh2sW-000896-6I
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:18:12 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wh2sU-0003sK-AE
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1783419464; x=1784024264; i=lukasstraub2@web.de;
 bh=gyAljP7FTH3HJpqi7pAllGM6rQeuORO3DhqwVXV86nM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=EPDn/j+lonNfJYjn9g9yIBgvnUViUXvL52vmVM5XPALqHW0hoSLVe4xfC+5RCa4Q
 CAMatdT051KjV0oUqjOiZ4tx+q9ioA08uOiWXMGmQWf6MrCixWoq6hieq1SxOdyva
 M7Yjvha+M6JuLSvpRZvX0RGRtz6+G+OIuNB2Hn8yVkZf1LpkZ9CNaJr3kv4I3gW+c
 EODAg23Z73A2LEsqzWppV10jZkkKhcAmzQmOqwV1DFD9xLjr88Mpdxmb5NkNLexsi
 xZCfvE24xOZ39FV265ieSEs3cSEHml8bDyIhsuSHPenmlOp1ycSRLlGQ2dHnZ6UoJ
 AXndIDuG6yhW6vUgMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqIFD-1xU9991Ixf-00fQWo; Tue, 07
 Jul 2026 12:17:44 +0200
Date: Tue, 7 Jul 2026 12:17:41 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Avihai Horon <avihaih@nvidia.com>
Cc: <qemu-devel@nongnu.org>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@mailo.com>, Zhao Liu <zhao1.liu@intel.com>, Halil
 Pasic <pasic@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Richard
 Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, "Cornelia
 Huck" <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>, "Vladimir
 Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Maor Gottlieb
 <maorg@nvidia.com>
Subject: Re: [PATCH v5 08/16] migration: Fail migration if switchover-ack is
 requested after switchover decision
Message-ID: <20260707121741.473c2175@penguin>
In-Reply-To: <20260706085211.13905-9-avihaih@nvidia.com>
References: <20260706085211.13905-1-avihaih@nvidia.com>
 <20260706085211.13905-9-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z=yXqxjNRFc06Jmw//9VQI3";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:GOrTu1ka1OecnhTeoU36R7BX54g7KLUQpEQD5KPl0t1CaWJbiyp
 5ajS9yfXq/qRxipzrgSGR2wWAhYp5MoU6W5r2HTMhqN5i4kBNwHtIHlCDjAYQjZpppKkJrO
 J65CW4JSwAKI5xhio78uHcfTWT0lM7ib9MouJpO1Lfm3WG/ArobH3gDwIGQZXJ5VJRdyJ8N
 1Boega2ywucVUW/uTyvVA==
UI-OutboundReport: notjunk:1;M01:P0:jzxVooYHuu4=;vnpvxYLyoMzWKLE7w4arVqXej4K
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--Sig_/Z=yXqxjNRFc06Jmw//9VQI3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Jul 2026 11:52:03 +0300
Avihai Horon <avihaih@nvidia.com> wrote:

> Switchover ACK is checked only during precopy while the guest is still
> running. The last migration_can_switchover() decision and guest stop are
> not atomic, so a device may want to request another switchover ACK in
> the gap after switchover decision has been made but before the guest is
> stopped. Migration would then miss that request, which can increase
> downtime.
>=20
> Cover this case by failing the migration if a switchover-ack was
> requested during that time.
>=20
> Ideally, precopy iterations should be resumed in this case, however,
> VFIO doesn't support going back to precopy after being stopped, so
> implementing such logic would require non-trivial changes to the guest
> start/stop flow. Given the above and that this case should be rare,
> failing the migration seems reasonable.
>=20
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

For the COLO parts:
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/savevm.h    |  4 ++--
>  migration/colo.c      |  6 +++++-
>  migration/migration.c |  4 +++-
>  migration/savevm.c    | 19 ++++++++++++++++++-
>  4 files changed, 28 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/savevm.h b/migration/savevm.h
> index fb92d3bc85..415198423f 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -47,8 +47,8 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>  int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
>  void qemu_savevm_query_pending_iter(MigrationState *s, MigPendingData *p=
ending,
>                                      bool exact);
> -void qemu_savevm_query_pending_final(MigrationState *s,
> -                                     MigPendingData *pending);
> +bool qemu_savevm_query_pending_final(MigrationState *s,
> +                                     MigPendingData *pending, Error **er=
rp);
>  int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_pos=
tcopy);
>  bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
>  void qemu_savevm_state_end(QEMUFile *f);
> diff --git a/migration/colo.c b/migration/colo.c
> index 0cef0f6b0e..0f30a5926f 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -473,7 +473,11 @@ static int colo_do_checkpoint_transaction(MigrationS=
tate *s,
>       * state is saved. Unlike a regular switchover, COLO reaches complet=
ion
>       * repeatedly for every checkpoint, so this must be done on each one.
>       */
> -    qemu_savevm_query_pending_final(s, &pending);
> +    if (!qemu_savevm_query_pending_final(s, &pending, &local_err)) {
> +        ret =3D -1;
> +        bql_unlock();
> +        goto out;
> +    }
> =20
>      /*
>       * Only save VM's live state, which not including device state.
> diff --git a/migration/migration.c b/migration/migration.c
> index 2b625da114..98603ee19c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2833,7 +2833,9 @@ static bool migration_switchover_start(MigrationSta=
te *s, Error **errp)
>       * properly update all the dirty bitmaps to finally generate the
>       * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
>       */
> -    qemu_savevm_query_pending_final(s, &pending);
> +    if (!qemu_savevm_query_pending_final(s, &pending, errp)) {
> +        return false;
> +    }
> =20
>      /* Inactivate disks except in COLO */
>      if (!migrate_colo()) {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 1f6e696c50..f654a1c563 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1852,11 +1852,28 @@ void qemu_savevm_query_pending_iter(MigrationStat=
e *s, MigPendingData *pending,
>      qemu_savevm_query_pending(s, pending, exact, false);
>  }
> =20
> -void qemu_savevm_query_pending_final(MigrationState *s, MigPendingData *=
pending)
> +bool qemu_savevm_query_pending_final(MigrationState *s, MigPendingData *=
pending,
> +                                     Error **errp)
>  {
>      g_assert(bql_locked());
> =20
>      qemu_savevm_query_pending(s, pending, true, true);
> +
> +    /*
> +     * Switchover-ack requests done after switchover decision are not al=
lowed.
> +     * Fail the migration in this case since we currently don't support =
going
> +     * back to precopy.
> +     */
> +    if (migrate_switchover_ack() && !migrate_switchover_ack_legacy() &&
> +        pending->switchover_ack_pending > 0) {
> +        error_setg(errp,
> +                   "Switchover ACK was requested by %" PRIu32
> +                   " devices during switchover",
> +                   pending->switchover_ack_pending);
> +        return false;
> +    }
> +
> +    return true;
>  }
> =20
>  void qemu_savevm_state_cleanup(void)


--Sig_/Z=yXqxjNRFc06Jmw//9VQI3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmpM0kUACgkQNasLKJxd
slhJqw/+PtN+BP0OvZWQK61MmCBLW25VtP0FcZ1DsoCHVfyWgFobbKy6z/qKf7jv
dTCWd9UPIBm8ktzWlXAjhp8h2bQy+vroG/JSVHeLCWMRVzMCl6zR0MHQe0+t/lsf
4/F/GVa412VkxNn2ciTv4yFKRJ7C0pXDnRAFHdni13UdvxzdRFzjFTN+DZl/PYlX
GwPWZiYvaDD8Zps7H1lmjEUcOwmccxoQLyyR9dx5UOUoSQV1xiUDH1SuLDCBnRRW
NZSVrVxD64Mf/Xj9F1xcnVLkkni54X7yhb/z4fABNlVsENPYr4wNZnCxAXKxHkIF
BvHdMjRmxYZcdlgysNsHQQ5UsCaFjsyAU1+3MwSUHOW+lnBkYJZfzlKN0Rgp+QQg
S0q0i68aMSm+Wp1JcHrDsQw9BTM/3bD/M/fLR1LyfLpZrPoUvl/oqj5PCdpghyN5
hsXiaGPd/xQvQWTiCtaf9YZ0SUhAINxyRB5Ucm+RO0polcnzYfbT+HpfksQ6mj69
dkHgn3IS5C8WN3bDWaITj+FxOEA2IZNnMOstWfMn2o3uWl/h8MGCliQTnpU3YXhD
1Wk2RnuvVgMGqs4xm6TR48qloTgXPqx+mF2DOKsNcXXRIxTgujfCtmT3tdFtWjVm
EvZmHAGDHCfWpFyC2cHF08zwpHirEVr0mAQ9rA7HVYr6NyUALHU=
=WPZO
-----END PGP SIGNATURE-----

--Sig_/Z=yXqxjNRFc06Jmw//9VQI3--

