Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B29F01836
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUh1-00077U-Re; Fri, 06 Mar 2026 07:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vyUgy-000774-58
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:54:08 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vyUgv-0005hF-6l
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772801627; x=1773406427; i=lukasstraub2@web.de;
 bh=S3eng7J+PzLnLJOOOFOp8Grwm68YrA8vJF0cjUtCZjw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YYs9TTFgwsdABA8T01A3Pu+DFA6tGBz+L9kmCYUfFXQw9nDwzy5h2L3XxPdSZT12
 LZoH6WFfY69in/89a0KtqzwSz+UhoJxTGZ7B4qPxlnh2HG2toeDElhiFLx7DRSZ25
 2WQ/OEX+nsqP/PHjQnkC+rilPKl/vZiwmJ7qTxEkwPd5amNnec07QPWGSo7t8IBNP
 fGt3fXKoTG4+AEo07omaUCAd2qdq1/jOXk6co1S6QtSN+aw7enkGdeuh1VdE7TPKT
 IFvOJyi9cq7UulxgYEM8Rr/KzbgD+WR6u3oGLgEDcy50QpgtRjRXhIT/EBlXNw2Yr
 zjOJNn7wlLsb6c9SfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVrbl-1w8d9q0T81-00HbNr; Fri, 06
 Mar 2026 13:53:47 +0100
Date: Fri, 6 Mar 2026 13:53:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Zhang
 Chen <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH v11 00/21] migration: Add COLO multifd support and COLO
 migration unit test
Message-ID: <20260306135335.5413bef0@penguin>
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5q1OEtiKS9UtVLVX7WYeyrG";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:ljqjtmM78wtOag0fT+AlTKBhBhF+puZpZjLkUJFduk+sx47ktHY
 yDT0rOf2vcIxW3c00jDekPFDVC0RI7YxuYAd0JE9lvXwtll40uV5Mkj3ZPgcnINeEEfV61a
 MyyrGFml3MRuoBLG02AyZFx7/h+rCIsuj+BtlWEsN39H0ETR7JLFe4UJ6fAPQA+dTdK8jRD
 cdCRUXMzIHVv/ssW8UI5g==
UI-OutboundReport: notjunk:1;M01:P0:SZUPCCrWl6s=;wUY7MFwa1FLRut3Nsa4GOMe2OtL
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--Sig_/5q1OEtiKS9UtVLVX7WYeyrG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon,  2 Mar 2026 12:43:30 +0100
Lukas Straub <lukasstraub2@web.de> wrote:

>=20
> Hello everyone,
> This has some cleanups for and adds multifd support and migration unit te=
sts
> for COLO migration.
>=20
> Regards,
> Lukas

Hello Peter, Hello Fabiano,
Will you apply this?

Best regards,
Lukas Straub

>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
> Changes in v11:
> - Use colo with return-path capability
> - Link to v10: https://lore.kernel.org/qemu-devel/20260220-colo_unit_test=
_multifd-v10-0-bfe67d422ef1@web.de
>=20
> Changes in v10:
> - multifd: always kick the main thread
> - always open the return path socket on source
> - Link to v9: https://lore.kernel.org/qemu-devel/20260218-colo_unit_test_=
multifd-v9-0-d8dbdb0ca6f6@web.de
>=20
> Changes in v9:
> - Rebase onto master
> - Fix two rare bugs discovered during sresstesting the colo unit test
> - Link to v8: https://lore.kernel.org/qemu-devel/20260210-colo_unit_test_=
multifd-v8-0-7f9e5f7d082b@web.de
>=20
> Changes in v8:
> - Fix peter's review comments
> - Link to v7: https://lore.kernel.org/qemu-devel/20260210-colo_unit_test_=
multifd-v7-0-23bd32f36828@web.de
>=20
> Changes in v7:
> - Fix peter's review comments
> - Link to v6: https://lore.kernel.org/qemu-devel/20260206-colo_unit_test_=
multifd-v6-0-27779dda139d@web.de
>=20
> Changes in v6:
> - Fix the crash when running COLO with TCG accel.
> - Link to v5: https://lore.kernel.org/qemu-devel/20260203-colo_unit_test_=
multifd-v5-0-57508b7389f6@web.de
>=20
> Changes in v5:
> - Remove unused inmports from multifd-colo.c
> - Mention the checkpoint overhead of reset to the Q35 fix
> - Link to v4: https://lore.kernel.org/qemu-devel/20260130-colo_unit_test_=
multifd-v4-0-7115ab6f0e77@web.de
>=20
> Changes in v4:
> - Add cleanup patches to remove migration_incoming_colo_enabled() and MIG=
_CMD_ENABLE_COLO
> - Add more comments to the colo unit test
> - Call colo_release_ram_cache() after multifd threads terminate
> - Link to v3: https://lore.kernel.org/qemu-devel/20260125-colo_unit_test_=
multifd-v3-0-ae926ccd8eae@web.de
>=20
> Changes in v3:
> - Fix peter's review comments.
> - Fix COLO with Q35 machine
> - Link to v2: https://lore.kernel.org/qemu-devel/20260117-colo_unit_test_=
multifd-v2-0-ab521777fa51@web.de
>=20
> Changes in v2:
> - Fix review comments
> - Hide stderr in colo migration test since the logged errors are expected
> - Add benchmarking data for multifd
> - Add myself as maintainer for COLO migration framework
> - Link to v1: https://lore.kernel.org/qemu-devel/20251230-colo_unit_test_=
multifd-v1-0-f9734bc74c71@web.de
>=20
> ---
> Lukas Straub (21):
>       MAINTAINERS: Add myself as maintainer for COLO migration framework
>       MAINTAINERS: Remove Hailiang Zhang from COLO migration framework
>       colo: Setup ram cache in normal migration path
>       colo: Replace migration_incoming_colo_enabled() with migrate_colo()
>       colo: Remove ENABLE_COLO savevm command and mark it as deprecated
>       ram: Remove colo special-casing
>       multifd: Move ram state receive into multifd_ram_state_recv()
>       multifd: Add COLO support
>       Call colo_release_ram_cache() after multifd threads terminate
>       colo: Fix crash during device vmstate load
>       colo: Hold the BQL while sending ram state
>       colo: Do not hold the BQL while receiving ram state.
>       migration-test: Add COLO migration unit test
>       Convert colo main documentation to restructuredText
>       qemu-colo.rst: Miscellaneous changes
>       qemu-colo.rst: Add my copyright
>       qemu-colo.rst: Simplify the block replication setup
>       multifd: Fix hang if send thread errors during sync
>       colo: Use file lock in primary_vm_do_failover()
>       migration: Keep s->rp_state.from_dst_file open until migration ends
>       colo: Reuse the return path from migration on primary and secondary=
 side
>=20
>  MAINTAINERS                        |   6 +-
>  docs/COLO-FT.txt                   | 334 -------------------------------=
---
>  docs/system/index.rst              |   1 +
>  docs/system/qemu-colo.rst          | 362 +++++++++++++++++++++++++++++++=
++++++
>  include/migration/colo.h           |   3 -
>  migration/colo.c                   |  59 +++---
>  migration/meson.build              |   2 +-
>  migration/migration.c              |  80 ++++----
>  migration/multifd-colo.c           |  44 +++++
>  migration/multifd-colo.h           |  26 +++
>  migration/multifd-nocomp.c         |  10 +-
>  migration/multifd.c                |  26 ++-
>  migration/multifd.h                |   5 +-
>  migration/options.c                |  10 +-
>  migration/ram.c                    |  12 +-
>  migration/savevm.c                 |  37 +---
>  migration/savevm.h                 |   1 -
>  migration/trace-events             |   1 -
>  tests/qtest/meson.build            |   7 +-
>  tests/qtest/migration-test.c       |   1 +
>  tests/qtest/migration/colo-tests.c | 199 ++++++++++++++++++++
>  tests/qtest/migration/framework.c  |  13 ++
>  tests/qtest/migration/framework.h  |   5 +
>  23 files changed, 777 insertions(+), 467 deletions(-)
> ---
> base-commit: d8a9d97317d03190b34498741f98f22e2a9afe3e
> change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46
>=20
> Best regards,


--Sig_/5q1OEtiKS9UtVLVX7WYeyrG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmqzk8ACgkQNasLKJxd
sliCVw/7BWqprBr/xVSW06YB8PBlNkarUctd4Jnt09d4YOrnfm6OQzpHddbG+CnM
/vx/ubfPV9/HJIyXrntOzYKPinP7DBtoXysWgp48K5gXT2SsLkh8p/T5UPP5V/Nf
gFXHW1oeOOAPTyslrzxBDFuj6QLxdQOD94B6b6NCc8olyA42nuxLa38UWVqWD88b
DeYbkcOnBC3gkMXLUoIOXUkW4ji81RWvFjdYIDV92QqpAKYq9knYW5NevQnreUvk
Pc9T+L7/sQvT0ml45kn5JJKuiQZX6/q7JCxK2UJ/7TMIzQ+5cHIti4eqd9B+0HQi
asKJHmzlN6eiF+RsbTGAwFUU+n6UUEglSubt5OTiaRHuQQpEQaWctRf4GE28iPTY
d0HACucP6UkxBkQWHoekfe2AqfeHuvrKKn1pT6XB9CfMFxtLSZCVjtfJQfaUCYal
qHqI/U6EaKmAZvF2wkQuTOgomXAzT0rEiIyC8qGXkYAsY4nM6WxQHv0yctC5AXCI
uPDNdbCjwc9ORsiWNd+fjxxW7dBl/zgs4kOVI1dOXvuz+avVCfdpSOh5gKqEXBw7
xGOvU6OVjGocKqUxkvQnNgWMF0uzutPyd6DBjR7ZzweWGCTAPXB6t5ypCtL72hTq
DdyN7lVS7KQFh7fG6aOzHGqs+Qk9si153hEsBerYOEloWitGSsU=
=FMJx
-----END PGP SIGNATURE-----

--Sig_/5q1OEtiKS9UtVLVX7WYeyrG--

