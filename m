Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEBDE6BF30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 18:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlt8P-0002bt-Bx; Fri, 30 Jan 2026 13:22:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlt8K-0002YQ-F8
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 13:22:17 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlt8I-0001qD-H2
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 13:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769797333; x=1770402133; i=lukasstraub2@web.de;
 bh=jIUwso/I1EzYXp+eAA3Wtfq5TAcpkGVCcg+s+PJauSA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GNyzD1ftkVXocQqsG9khqB6NywSaPe7D1oohiLVQrPDl4L/3eHAqJx8ce8kKkT2D
 MIKgsdAl9c+cwF/Ll/SriUR9Zfr5m7cR7XEFZJyY57Z5xKxqmD4zyhR2i8vIo8G72
 X6RW2utIWRg4Zw1dDxLvKO3dM6fQ3go6qIT7lHfhUPMFhhuQm4nqd7ZJQ+IytK72u
 gxo7udEQX6vyN1EDqBBiNiwVzf0JovxJRY2noD0MvBjDSqoUCJd5LcbV0Vdep2W95
 LA/yneksBQVTDSneCshJ18tq6bM/0Sd6k7lDh6/fCT2S/8xtZBJdXm3JoKTxhcjNJ
 2bIgO0sypqFHordsFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.97.172]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPdr-1vQ4zF3EDB-00Uy0a; Fri, 30
 Jan 2026 19:22:12 +0100
Date: Fri, 30 Jan 2026 19:22:02 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 00/24] migration: small cleanup series
Message-ID: <20260130192202.520d7a6e@penguin>
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l./2EMSQAfm7blPMs83w1Th";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:X9xCWiWuxGsnvbSHoDBx/g+d86IcFNui0xW8RPIvUn3hMiyZIky
 Sx24pM2bnGaMYpNal0HqiMrD6rabWQ4WLyexYIzE98HQdXCygtZAe9zTZWTWFUbKSlqt+gJ
 hBjOuQSjR6a3aiNqevg7ZG3RNsijRXaJiU7drzTgRcK/2/KqZ6jbc/mZQGQPHS4XnZbLhhv
 Nls2/yolTqr2hrEeDBRmw==
UI-OutboundReport: notjunk:1;M01:P0:x8aOEbJCmbs=;Y6cQMgKP8/AH7DvNxvHTqXcLRlS
 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
 Hzo1b+bsragj18iS8O8q
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/l./2EMSQAfm7blPMs83w1Th
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Jan 2026 13:52:30 -0500
Peter Xu <peterx@redhat.com> wrote:

> CI: https://gitlab.com/peterx/qemu/-/pipelines/2289719627
>=20
> v1: https://lore.kernel.org/r/20260121223336.3381912-1-peterx@redhat.com
>=20
> This is the v2 of the small cleanup series.  It used to be only for COLO,
> but now for some other things too around dumping vmstates.
>=20
> The small series growed a little bit, because I wanted to try Fabiano's
> request to deduplicate qemu_save_device_state() and precopy's similar
> version to dump non-iterable devices.
>=20
> Changelog skipped, as too many things added.  Old patches should almost t=
he
> same with R-bs collected, though.  I still touched up some small things,
> though (where I dropped the R-bs).
>=20
> This should pass the new COLO unit test too, I hope I didn't overlook
> something once more. Please anyone let me know if it fails.
>=20
> Comments welcomed, thanks.

This now works well in my testing:

Tested-by: Lukas Straub <lukasstraub2@web.de>

>=20
> Peter Xu (24):
>   migration: Introduce qemu_savevm_send_* helpers
>   migration: Use qemu_savevm_send_header() in qemu_save_device_state()
>   migration: Remove one migration_in_colo_state() occurance
>   migration/savevm: Remove SaveStateEntry.is_ram
>   migration/colo: Unwrap qemu_savevm_live_state()
>   migration: Remove call to send switchover start event in colo/savevm
>   colo: Forbid VM resume during checkpointing
>   migration/colo: Use the RAM iterable helper directly
>   migration/colo: Document qemu_fflush(fb)
>   migration: Drop iterable_only in qemu_savevm_state_complete_precopy
>   migration: Drop qemu_file_set_error() when save non-iterable fails
>   migration/colo: Send device states without copying buffer
>   migration/postcopy: Send device states without copying buffer
>   migration: Introduce qemu_savevm_state_end()
>   migration: Provide helper for save vm description
>   migration: Split qemu_savevm_state_complete_precopy_non_iterable()
>   migration: qemu_savevm_state_complete_precopy() take MigrationState*
>   migration: Cleanup error propagates in qemu_savevm_state_setup()
>   migration: Refactor qemu_savevm_state_setup()
>   migration: Introduce qemu_savevm_state_active()
>   migration/bg-snapshot: Cleanup error paths
>   migration: Make qemu_savevm_state_non_iterable() take errp
>   migration: Simplify qemu_save_device_state()
>   migration/colo/xen: Use generic helpers in qemu_save_device_state()
>=20
>  migration/savevm.h    |  18 +--
>  migration/colo.c      |  16 ++-
>  migration/migration.c |  48 +++----
>  migration/savevm.c    | 312 ++++++++++++++++++++++--------------------
>  monitor/qmp-cmds.c    |   3 +
>  5 files changed, 213 insertions(+), 184 deletions(-)
>=20


--Sig_/l./2EMSQAfm7blPMs83w1Th
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAml89soACgkQNasLKJxd
slgOShAAvI5H73vj12MssoHDwP3ierB5JBJPtujfFsOUzNz55Qg54EJVn1YacICZ
Ax7vzRBGtlskVnT4/5r2DvtfWgIKu05pan16UxADT9NbOuJh0F0+/xJaVZP+PhJj
b/Fw9XjRLFJbf+6+mEM2smePxEMqgb0BkyYqELLczOpSZYwpUI6QsNVw9P7ZazQo
y63OsRkQGKqaUN1yBhVzyZd/XvLEeVE8mSVkKCzHV5KZy0lDNRYIY7deOY+oPxKN
OUctBTjLaE/YPheZeqlbT9O+p6AzHu1C8tXFh0q89nOqRYqB7Uu+wqzNyqKwFjii
Li3j/D5pV2k7Gpg3qDrX2yiKd96BznkL4PD4Zs9F7tta9s1YSJsCZtJAN5xf8ZPr
ufqWGUB+QQ5Ir0LjYI+3D+GecWNlxPan6o0aUgpHZvhAo6W9z22yuh985rWBh0P4
XsM8813P0CE2E8UXJn/MDA8B0X3pqz4CtDFtfnkpluna0FbcUweNHpVHO4NBeH7/
84CyzQyo6FL0znX1eqJW056CYn+c7ToRvS5yRi2IYBRSAnYqlTR8AA5quzJ8Hjn6
ol7SpD964sD2Twho7dkjuUNtTAa4UMdTiNjggKbFD2T/vdyIllk32BqiEaldC9Ku
kseUspDpKBNY8rVvlQlP0c7g3JxtulQ6QerVDzrFeZ6JPXUIw3M=
=iVIJ
-----END PGP SIGNATURE-----

--Sig_/l./2EMSQAfm7blPMs83w1Th--

