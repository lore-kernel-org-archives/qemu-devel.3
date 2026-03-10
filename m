Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9601AEB1074
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzJd-00008W-BJ; Tue, 10 Mar 2026 11:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vzzJa-0008Qy-O5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:48:10 -0400
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vzzJV-0002Tm-Ie
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1773157683; x=1773762483; i=lukasstraub2@web.de;
 bh=j+0dkPE0MDX8XWlRSdXdWXN3Gvth5r11F6yn01jL1XU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=t3O95oEZi67hRsQWFRXijYd+I3BLL37ia0kEZbjhtGOI5SfeDw306OHJgzvu8sLU
 uuHnz11U9k12FkixbFTluEO8oG4kX3MNVrw+ppk0mGi+QRx964QBsBkGde+so78i1
 anYst5R8SDy40EZjtXuvlbVg6Zs+4jPZk7GNsg7WUO8OdDweEpKzSy8g69Oi1+aZL
 mDp1lHSc+t9f6tGiS/YvEZ7WgRIHZuFQJNTBTc7tt8jUyMbq2mt/gM+Vr8F4VhRG2
 mIXE/21025YPTyJlMia/Hn1dUL+esQR1jmzceOuxpN56sLKubIhAG3Bx3eM0ENoxi
 AQGgf+GHRzlXtcPiRw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDvDU-1vsFXT24TU-000LVX; Tue, 10
 Mar 2026 16:48:03 +0100
Date: Tue, 10 Mar 2026 16:47:53 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter
 Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH 4/8] tests/qtest/migration: Stop invoking
 migrate_incoming from hooks
Message-ID: <20260310164753.1f71bebd@penguin>
In-Reply-To: <20260310135540.8679-4-farosas@suse.de>
References: <20260310135540.8679-1-farosas@suse.de>
 <20260310135540.8679-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tKKUpfAvRxJ32u+NgrVbFnQ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:jBiKEP7Wf5bcmN7rodgi+omuvwVdnjNVmJTLR5mQRZjOhM9htOb
 utG7nUt1r0SbEte9P1q0CgA2dkc6AbSvuOqmdm/UtZLZK4bW8IDvbDMp99FDMENmpr3Vgti
 3IXwSaIDovk93umDkeSma4JDYH/sNELIxLGx1/OKCy/dmdXvVbda4mRQW15wf/2p2jEb7p8
 +nHBZEoDDqoRNhil7OVhQ==
UI-OutboundReport: notjunk:1;M01:P0:ejigmUFVHMc=;6Df5eEroPOhvCJFpVnCbiMBauCo
 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
 wj1RJyQfurbXauCq9u/3a6kA==
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

--Sig_/tKKUpfAvRxJ32u+NgrVbFnQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Mar 2026 10:55:36 -0300
Fabiano Rosas <farosas@suse.de> wrote:

> Now that the listen_uri is being properly used, tests can stop calling
> migrate_incoming from their hooks. The _common functions and
> migrate_start should take care of that.
>=20
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> Link: https://lore.kernel.org/qemu-devel/20251215220041.12657-29-farosas@=
suse.de
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/colo-tests.c        |  4 ++++
>  tests/qtest/migration/compression-tests.c |  6 ++++++
>  tests/qtest/migration/framework.c         | 14 +++++++++++---
>  tests/qtest/migration/precopy-tests.c     |  7 ++++---
>  tests/qtest/migration/tls-tests.c         |  8 ++++++++
>  5 files changed, 33 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/c=
olo-tests.c
> index 7c438c196b..0d800429c5 100644
> --- a/tests/qtest/migration/colo-tests.c
> +++ b/tests/qtest/migration/colo-tests.c
> @@ -55,6 +55,10 @@ static int test_colo_common(MigrateCommon *args,
>          data_hook =3D args->start_hook(from, to);
>      }
> =20
> +    if (args->start.incoming_defer) {
> +        migrate_incoming_qmp(to, args->listen_uri, NULL, "{}");
> +    }
> +
>      migrate_ensure_converge(from);
>      wait_for_serial("src_serial");
> =20
> diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migr=
ation/compression-tests.c
> index eb0b7d6b4b..bed39dece0 100644
> --- a/tests/qtest/migration/compression-tests.c
> +++ b/tests/qtest/migration/compression-tests.c
> @@ -33,6 +33,7 @@ migrate_hook_start_precopy_tcp_multifd_zstd(QTestState =
*from,
> =20
>  static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
>  {
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd_zstd;
> =20
>      args->start.incoming_defer =3D true;
> @@ -43,6 +44,7 @@ static void test_multifd_tcp_zstd(char *name, MigrateCo=
mmon *args)
> =20
>  static void test_multifd_postcopy_tcp_zstd(char *name, MigrateCommon *ar=
gs)
>  {
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd_zstd,
> =20
>      args->start.incoming_defer =3D true;
> @@ -66,6 +68,7 @@ migrate_hook_start_precopy_tcp_multifd_qatzip(QTestStat=
e *from,
> =20
>  static void test_multifd_tcp_qatzip(char *name, MigrateCommon *args)
>  {
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd_qatzip;
> =20
>      args->start.incoming_defer =3D true;
> @@ -85,6 +88,7 @@ migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *=
from,
> =20
>  static void test_multifd_tcp_qpl(char *name, MigrateCommon *args)
>  {
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd_qpl;
> =20
>      args->start.incoming_defer =3D true;
> @@ -104,6 +108,7 @@ migrate_hook_start_precopy_tcp_multifd_uadk(QTestStat=
e *from,
> =20
>  static void test_multifd_tcp_uadk(char *name, MigrateCommon *args)
>  {
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd_uadk;
> =20
>      args->start.incoming_defer =3D true;
> @@ -156,6 +161,7 @@ migrate_hook_start_precopy_tcp_multifd_zlib(QTestStat=
e *from,
> =20
>  static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
>  {
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd_zlib;
> =20
>      args->start.incoming_defer =3D true;
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/fr=
amework.c
> index 75605d1791..4cc63bba7b 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -837,6 +837,9 @@ int test_precopy_common(MigrateCommon *args)
>      QObject *out_channels =3D NULL;
> =20
>      g_assert(!args->cpr_channel || args->connect_channels);
> +    if (args->start.incoming_defer) {
> +        g_assert(args->listen_uri || args->connect_channels);
> +    }
> =20
>      if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
>          return -1;
> @@ -846,6 +849,14 @@ int test_precopy_common(MigrateCommon *args)
>          data_hook =3D args->start_hook(from, to);
>      }
> =20
> +    if (args->start.incoming_defer && !args->start.defer_target_connect)=
 {
> +        if (args->connect_channels) {
> +            in_channels =3D qobject_from_json(args->connect_channels,
> +                                            &error_abort);
> +        }
> +        migrate_incoming_qmp(to, args->listen_uri, in_channels, "{}");
> +    }
> +
>      /* Wait for the first serial output from the source */
>      if (args->result =3D=3D MIG_TEST_SUCCEED) {
>          wait_for_serial("src_serial");
> @@ -1077,9 +1088,6 @@ void *migrate_hook_start_precopy_tcp_multifd_common=
(QTestState *from,
>      migrate_set_parameter_str(from, "multifd-compression", method);
>      migrate_set_parameter_str(to, "multifd-compression", method);
> =20
> -    /* Start incoming migration from the 1st socket */
> -    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
> -
>      return NULL;
>  }
> =20
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migratio=
n/precopy-tests.c
> index 31fd4af1ad..d2302ed692 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -239,9 +239,6 @@ static void *migrate_hook_start_fd(QTestState *from,
>                                   "  'arguments': { 'fdname': 'fd-mig' }}=
");
>      close(pair[0]);
> =20
> -    /* Start incoming migration from the 1st socket */
> -    migrate_incoming_qmp(to, "fd:fd-mig", NULL, "{}");
> -
>      /* Send the 2nd socket to the target */
>      qtest_qmp_fds_assert_success(from, &pair[1], 1,
>                                   "{ 'execute': 'getfd',"
> @@ -283,6 +280,7 @@ static void migrate_hook_end_fd(QTestState *from,
>  static void test_precopy_fd_socket(char *name, MigrateCommon *args)
>  {
>      args->connect_uri =3D "fd:fd-mig";
> +    args->listen_uri =3D "fd:fd-mig";
>      args->start_hook =3D migrate_hook_start_fd;
>      args->end_hook =3D migrate_hook_end_fd;
> =20
> @@ -443,6 +441,7 @@ static void test_multifd_tcp_uri_none(char *name, Mig=
rateCommon *args)
>       * everything will work alright even if guest page is changing.
>       */
>      args->live =3D true;
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
> =20
>      args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> @@ -459,6 +458,7 @@ static void test_multifd_tcp_zero_page_legacy(char *n=
ame, MigrateCommon *args)
>       * everything will work alright even if guest page is changing.
>       */
>      args->live =3D true;
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
> =20
>      args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> @@ -475,6 +475,7 @@ static void test_multifd_tcp_no_zero_page(char *name,=
 MigrateCommon *args)
>       * everything will work alright even if guest page is changing.
>       */
>      args->live =3D true;
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
> =20
>      args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tl=
s-tests.c
> index 40a78bd2d2..f636802642 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c
> @@ -675,6 +675,7 @@ static void test_multifd_tcp_tls_psk_match(char *name=
, MigrateCommon *args)
>  {
>      args->start_hook =3D migrate_hook_start_multifd_tcp_tls_psk_match;
>      args->end_hook =3D migrate_hook_end_tls_psk;
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
> =20
>      args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> @@ -687,6 +688,7 @@ static void test_multifd_tcp_tls_psk_mismatch(char *n=
ame, MigrateCommon *args)
>      args->start_hook =3D migrate_hook_start_multifd_tcp_tls_psk_mismatch;
>      args->end_hook =3D migrate_hook_end_tls_psk;
>      args->result =3D MIG_TEST_FAIL;
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
> =20
>      args->start.hide_stderr =3D true;
>      args->start.incoming_defer =3D true;
> @@ -700,6 +702,7 @@ static void test_multifd_postcopy_tcp_tls_psk_match(c=
har *name,
>  {
>      args->start_hook =3D migrate_hook_start_multifd_tcp_tls_psk_match;
>      args->end_hook =3D migrate_hook_end_tls_psk;
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
> =20
>      args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> @@ -714,6 +717,7 @@ static void test_multifd_tcp_tls_x509_default_host(ch=
ar *name,
>  {
>      args->start_hook =3D migrate_hook_start_multifd_tls_x509_default_hos=
t;
>      args->end_hook =3D migrate_hook_end_tls_x509;
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
> =20
>      args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> @@ -726,6 +730,7 @@ static void test_multifd_tcp_tls_x509_override_host(c=
har *name,
>  {
>      args->start_hook =3D migrate_hook_start_multifd_tls_x509_override_ho=
st;
>      args->end_hook =3D migrate_hook_end_tls_x509;
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
> =20
>      args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> @@ -752,6 +757,7 @@ static void test_multifd_tcp_tls_x509_mismatch_host(c=
har *name,
>      args->start_hook =3D migrate_hook_start_multifd_tls_x509_mismatch_ho=
st;
>      args->end_hook =3D migrate_hook_end_tls_x509;
>      args->result =3D MIG_TEST_FAIL;
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
> =20
>      args->start.incoming_defer =3D true;
>      args->start.hide_stderr =3D true;
> @@ -765,6 +771,7 @@ static void test_multifd_tcp_tls_x509_allow_anon_clie=
nt(char *name,
>  {
>      args->start_hook =3D migrate_hook_start_multifd_tls_x509_allow_anon_=
client;
>      args->end_hook =3D migrate_hook_end_tls_x509;
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
> =20
>      args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> @@ -778,6 +785,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_cli=
ent(char *name,
>      args->start_hook =3D migrate_hook_start_multifd_tls_x509_reject_anon=
_client;
>      args->end_hook =3D migrate_hook_end_tls_x509;
>      args->result =3D MIG_TEST_FAIL;
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
> =20
>      args->start.incoming_defer =3D true;
>      args->start.hide_stderr =3D true;


--Sig_/tKKUpfAvRxJ32u+NgrVbFnQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmwPSkACgkQNasLKJxd
slgfug//Tq4Htv+43fC3Y+1S7yVo/3SRrLq8E54rnX54F8DSKLYcr/rqUOGqoF4g
8YYcIHg+l7oPjli4ikSPZUlWZAVPt1vghKAXPv192CwRmRuAGB4iQYim6Z7PG1+h
yo+RVGnkIN1v7BJEN+J4Fy/Sy0mtsY57akgc+hGe+JpyaLuSeTMWAyNls0F1mgFo
iyHLxo7tqa/mAa43mqj6Ei0g/2aqkXkueP8ep5oER4+UPh6vuB0cXd3xLscOkgEw
mm5HaWiXxtkY3skti3BqWlK0DfiNGUQndX055mhaAXOKm0YO9BvolFgJGptD42nK
LPB27W10KvsTNzB9i0TsL+fU5fr3T6xOckL8EpFlOyJeDRnfPSSjt8eH14EIS/bl
1Q8pww6vcKkPaO6GHqGhE+JmL/QDF+lwk46JiASNC3V7UCDI9UDEbLUI+PpTVXPS
eA40T6BczxJTWDjsE4u6Av04zNNXBGO7JAAxd8kB/p6BLGjknQTKz8gWoU/vHhqt
6VT192sodcOcUihaRGdGda1B3/fgolkQCMqPRDUPxvqSDazKObJ0EGvGYcgaiiC4
JTSm42fsaAgNQ4VkMlVawsydcRq8ODOfc0hxkEmqO11OKPHgjOoaC4UF6w4aHHp/
uXuQ4nKNL+Am11srSCYM0kZlLf5Y3/K0rAe3wKJ6uOiBOc8NyNA=
=UpyH
-----END PGP SIGNATURE-----

--Sig_/tKKUpfAvRxJ32u+NgrVbFnQ--

