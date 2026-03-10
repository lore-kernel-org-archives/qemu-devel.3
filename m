Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61938EB1073
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzKL-0000hC-A5; Tue, 10 Mar 2026 11:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vzzKJ-0000h0-FE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:48:55 -0400
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vzzKF-0002jB-Ns
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1773157719; x=1773762519; i=lukasstraub2@web.de;
 bh=VwvK1Ofy8thztDKJd9JnOSsvC1OYY9OmxbMIFTb731s=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=t60Raa0ScSZxOhfc7xYG5//zeMsHSYTD142Eh5kJnmdhti+C6vXm0wDUO7GeUeWE
 Zb0VelhcQsa9T27bJCaq/ya1AaPKqEdcfL2vHCEZG37T161AzlmsZgQVfQr96na8+
 QbHhXbeMumpaD1wr1F67y4UMhqoL5syRA6qR1BZ4UaM+Vuy0rbfON2MIMYTau6LRn
 JASs12Ypddb74Qife9V4IYyQm12bpqxKaTiJhRudkpd0KAQrt13M18rs+s04RdX2u
 UPzpbV+UseP5Hh+3uYg0Lwbmsk6W4r6OVQ+BoyD1b4D9ZviSAZ74KJiRKthGmODKi
 byfpTVvOVJ8dQBxG4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9ISh-1vxUbw10sB-009vyR; Tue, 10
 Mar 2026 16:48:39 +0100
Date: Tue, 10 Mar 2026 16:48:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter
 Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>, Ben Chaney
 <bchaney@akamai.com>
Subject: Re: [PATCH 3/8] tests/qtest/migration: Fix misuse of listen_uri
Message-ID: <20260310164834.1b36fc41@penguin>
In-Reply-To: <20260310135540.8679-3-farosas@suse.de>
References: <20260310135540.8679-1-farosas@suse.de>
 <20260310135540.8679-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9B1YDu2PIjQU6C/erLvzrJ1";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:s+Dnmm5LbtZHBgDFrV5QRyVpz9piG+YfhQv+ZEEFq2pPgzCblNB
 4K65jkFFi7TaLEPlTmcIxHg4ggjwgHWFo3HF0i5h/6afxQuIsI4BNK5XOMr6rGVsUW7tkNY
 UsQCid/7qL+TgbnUXRxllhQuQ4cylUSBxZ3jFFwzyy/1pd57jIrFYtfDyG/Bln3pjJyVy1Q
 B8oSLTx4J4aXpHiYQr3DQ==
UI-OutboundReport: notjunk:1;M01:P0:dG0BO5FVkMo=;yZVIoOHsNBOMR2EJpfvGM2nN23c
 +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
 0jepauFnERP9dBqep+Wo3kGNjurJc0H3A==
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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

--Sig_/9B1YDu2PIjQU6C/erLvzrJ1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Mar 2026 10:55:35 -0300
Fabiano Rosas <farosas@suse.de> wrote:

> The listen_uri parameter is supposed to be used for the incoming
> migration while connect_uri for the outgoing migration. This is well
> documented in the header file.
>=20
> However, due to -incoming "defer", some tests set listen-uri =3D
> "defer", which is fine. But then, being without another parameter to
> define the uri to be use in migrate_incoming, some tests have been
> misusing connect_uri.
>=20
> Add a separate flag to denote "defer" and spare the tests from passing
> the string. Change the usage of listen_uri to it's original purpose.
>=20
> Link: https://lore.kernel.org/qemu-devel/20251215220041.12657-28-farosas@=
suse.de
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  tests/qtest/migration/colo-tests.c        |  4 ++-
>  tests/qtest/migration/compression-tests.c | 12 +++----
>  tests/qtest/migration/cpr-tests.c         | 20 +++++++----
>  tests/qtest/migration/file-tests.c        | 41 ++++++++++++++++-------
>  tests/qtest/migration/framework.c         | 12 +++----
>  tests/qtest/migration/framework.h         |  7 ++++
>  tests/qtest/migration/misc-tests.c        |  4 +--
>  tests/qtest/migration/precopy-tests.c     | 14 +++++---
>  tests/qtest/migration/tls-tests.c         | 16 ++++-----
>  9 files changed, 83 insertions(+), 47 deletions(-)
>=20
> diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/c=
olo-tests.c
> index ef880f5114..7c438c196b 100644
> --- a/tests/qtest/migration/colo-tests.c
> +++ b/tests/qtest/migration/colo-tests.c
> @@ -116,9 +116,11 @@ static void test_colo_multifd_common(MigrateCommon *=
args,
>                                       bool failover_during_checkpoint,
>                                       bool primary_failover)
>  {
> -    args->listen_uri =3D "defer";
> +    args->listen_uri =3D "tcp:127.0.0.1:0";
>      args->start_hook =3D hook_start_multifd;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> +    args->start.incoming_defer =3D true;
> +
>      test_colo_common(args, failover_during_checkpoint, primary_failover);
>  }
> =20
> diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migr=
ation/compression-tests.c
> index 845e622cd5..eb0b7d6b4b 100644
> --- a/tests/qtest/migration/compression-tests.c
> +++ b/tests/qtest/migration/compression-tests.c
> @@ -33,9 +33,9 @@ migrate_hook_start_precopy_tcp_multifd_zstd(QTestState =
*from,
> =20
>  static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd_zstd;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
>      test_precopy_common(args);
> @@ -43,9 +43,9 @@ static void test_multifd_tcp_zstd(char *name, MigrateCo=
mmon *args)
> =20
>  static void test_multifd_postcopy_tcp_zstd(char *name, MigrateCommon *ar=
gs)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd_zstd,
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] =3D true;
> =20
> @@ -66,9 +66,9 @@ migrate_hook_start_precopy_tcp_multifd_qatzip(QTestStat=
e *from,
> =20
>  static void test_multifd_tcp_qatzip(char *name, MigrateCommon *args)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd_qatzip;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
>      test_precopy_common(args);
> @@ -85,9 +85,9 @@ migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *=
from,
> =20
>  static void test_multifd_tcp_qpl(char *name, MigrateCommon *args)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd_qpl;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
>      test_precopy_common(args);
> @@ -104,9 +104,9 @@ migrate_hook_start_precopy_tcp_multifd_uadk(QTestStat=
e *from,
> =20
>  static void test_multifd_tcp_uadk(char *name, MigrateCommon *args)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd_uadk;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
>      test_precopy_common(args);
> @@ -156,9 +156,9 @@ migrate_hook_start_precopy_tcp_multifd_zlib(QTestStat=
e *from,
> =20
>  static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd_zlib;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
>      test_precopy_common(args);
> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cp=
r-tests.c
> index 0d97b5b89f..1b3d42e51c 100644
> --- a/tests/qtest/migration/cpr-tests.c
> +++ b/tests/qtest/migration/cpr-tests.c
> @@ -32,10 +32,11 @@ static void test_mode_reboot(char *name, MigrateCommo=
n *args)
>      g_autofree char *uri =3D g_strdup_printf("file:%s/%s", tmpfs,
>                                             FILE_TEST_FILENAME);
> =20
> +    args->listen_uri =3D uri;
>      args->connect_uri =3D uri;
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_mode_reboot;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.mem_type =3D MEM_TYPE_SHMEM;
>      args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] =3D true;
> =20
> @@ -53,7 +54,7 @@ static void *test_mode_transfer_start(QTestState *from,=
 QTestState *to)
>   * migration, and cannot connect synchronously to the monitor, so defer
>   * the target connection.
>   */
> -static void test_mode_transfer_common(MigrateCommon *args, bool incoming=
_defer)
> +static void test_mode_transfer_common(MigrateCommon *args)
>  {
>      g_autofree char *cpr_path =3D g_strdup_printf("%s/cpr.sock", tmpfs);
>      g_autofree char *mig_path =3D g_strdup_printf("%s/migsocket", tmpfs);
> @@ -84,7 +85,11 @@ static void test_mode_transfer_common(MigrateCommon *a=
rgs, bool incoming_defer)
>                                    "addr.type=3Dfd,addr.str=3D%d %s",
>                                    cpr_sockfd, opts);
> =20
> -    args->listen_uri =3D incoming_defer ? "defer" : uri;
> +    /*
> +     * The URI is used only for the deferred target connection when
> +     * !incoming_defer.
> +     */
> +    args->listen_uri =3D uri;
>      args->connect_channels =3D connect_channels;
>      args->cpr_channel =3D cpr_channel;
>      args->start_hook =3D test_mode_transfer_start;
> @@ -102,12 +107,14 @@ static void test_mode_transfer_common(MigrateCommon=
 *args, bool incoming_defer)
> =20
>  static void test_mode_transfer(char *name, MigrateCommon *args)
>  {
> -    test_mode_transfer_common(args, false);
> +    args->start.incoming_defer =3D false;
> +    test_mode_transfer_common(args);
>  }
> =20
>  static void test_mode_transfer_defer(char *name, MigrateCommon *args)
>  {
> -    test_mode_transfer_common(args, true);
> +    args->start.incoming_defer =3D true;
> +    test_mode_transfer_common(args);
>  }
> =20
>  static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
> @@ -227,11 +234,10 @@ static void test_mode_exec(char *name, MigrateCommo=
n *args)
>  {
>      g_autofree char *uri =3D g_strdup_printf("file:%s/%s", tmpfs,
>                                             FILE_TEST_FILENAME);
> -    g_autofree char *listen_uri =3D g_strdup_printf("defer");
> =20
>      args->connect_uri =3D uri;
> -    args->listen_uri =3D listen_uri;
>      args->start_hook =3D test_mode_exec_start;
> +    args->start.incoming_defer =3D true;
> =20
>      args->start.only_source =3D true;
>      args->start.opts_source =3D "-machine aux-ram-share=3Don -nodefaults=
";
> diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/f=
ile-tests.c
> index 5d1b861cf6..7597ff7552 100644
> --- a/tests/qtest/migration/file-tests.c
> +++ b/tests/qtest/migration/file-tests.c
> @@ -25,7 +25,9 @@ static void test_precopy_file(char *name, MigrateCommon=
 *args)
>      g_autofree char *uri =3D g_strdup_printf("file:%s/%s", tmpfs,
>                                             FILE_TEST_FILENAME);
>      args->connect_uri =3D uri;
> -    args->listen_uri =3D "defer";
> +    args->listen_uri =3D uri;
> +
> +    args->start.incoming_defer =3D true;
> =20
>      test_file_common(args, true);
>  }
> @@ -69,9 +71,11 @@ static void test_precopy_file_offset_fdset(char *name,=
 MigrateCommon *args)
>      g_autofree char *uri =3D g_strdup_printf("file:/dev/fdset/1,offset=
=3D%d",
>                                             FILE_TEST_OFFSET);
>      args->connect_uri =3D uri;
> -    args->listen_uri =3D "defer";
> +    args->listen_uri =3D uri;
>      args->start_hook =3D migrate_hook_start_file_offset_fdset;
> =20
> +    args->start.incoming_defer =3D true;
> +
>      test_file_common(args, false);
>  }
>  #endif
> @@ -83,7 +87,9 @@ static void test_precopy_file_offset(char *name, Migrat=
eCommon *args)
>                                             FILE_TEST_OFFSET);
> =20
>      args->connect_uri =3D uri;
> -    args->listen_uri =3D "defer";
> +    args->listen_uri =3D uri;
> +
> +    args->start.incoming_defer =3D true;
> =20
>      test_file_common(args, false);
>  }
> @@ -95,9 +101,11 @@ static void test_precopy_file_offset_bad(char *name, =
MigrateCommon *args)
>                                             tmpfs, FILE_TEST_FILENAME);
> =20
>      args->connect_uri =3D uri;
> -    args->listen_uri =3D "defer";
> +    args->listen_uri =3D uri;
>      args->result =3D MIG_TEST_QMP_ERROR;
> =20
> +    args->start.incoming_defer =3D true;
> +
>      test_file_common(args, false);
>  }
> =20
> @@ -107,8 +115,9 @@ static void test_precopy_file_mapped_ram_live(char *n=
ame, MigrateCommon *args)
>                                             FILE_TEST_FILENAME);
> =20
>      args->connect_uri =3D uri;
> -    args->listen_uri =3D "defer";
> +    args->listen_uri =3D uri;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] =3D true;
> =20
>      test_file_common(args, false);
> @@ -120,8 +129,9 @@ static void test_precopy_file_mapped_ram(char *name, =
MigrateCommon *args)
>                                             FILE_TEST_FILENAME);
> =20
>      args->connect_uri =3D uri;
> -    args->listen_uri =3D "defer";
> +    args->listen_uri =3D uri;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] =3D true;
> =20
>      test_file_common(args, true);
> @@ -132,8 +142,9 @@ static void test_multifd_file_mapped_ram_live(char *n=
ame, MigrateCommon *args)
>      g_autofree char *uri =3D g_strdup_printf("file:%s/%s", tmpfs,
>                                             FILE_TEST_FILENAME);
>      args->connect_uri =3D uri;
> -    args->listen_uri =3D "defer";
> +    args->listen_uri =3D uri;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] =3D true;
> =20
> @@ -146,8 +157,9 @@ static void test_multifd_file_mapped_ram(char *name, =
MigrateCommon *args)
>                                             FILE_TEST_FILENAME);
> =20
>      args->connect_uri =3D uri;
> -    args->listen_uri =3D "defer";
> +    args->listen_uri =3D uri;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] =3D true;
> =20
> @@ -168,9 +180,10 @@ static void test_multifd_file_mapped_ram_dio(char *n=
ame, MigrateCommon *args)
>      g_autofree char *uri =3D g_strdup_printf("file:%s/%s", tmpfs,
>                                             FILE_TEST_FILENAME);
>      args->connect_uri =3D uri;
> -    args->listen_uri =3D "defer";
> +    args->listen_uri =3D uri;
>      args->start_hook =3D migrate_hook_start_multifd_mapped_ram_dio;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
> @@ -240,10 +253,11 @@ static void test_multifd_file_mapped_ram_fdset(char=
 *name, MigrateCommon *args)
>                                             FILE_TEST_OFFSET);
> =20
>      args->connect_uri =3D uri;
> -    args->listen_uri =3D "defer";
> +    args->listen_uri =3D uri;
>      args->start_hook =3D migrate_hook_start_multifd_mapped_ram_fdset;
>      args->end_hook =3D migrate_hook_end_multifd_mapped_ram_fdset;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
> @@ -255,11 +269,13 @@ static void test_multifd_file_mapped_ram_fdset_dio(=
char *name,
>  {
>      g_autofree char *uri =3D g_strdup_printf("file:/dev/fdset/1,offset=
=3D%d",
>                                             FILE_TEST_OFFSET);
> +
>      args->connect_uri =3D uri;
> -    args->listen_uri =3D "defer";
> +    args->listen_uri =3D uri;
>      args->start_hook =3D migrate_hook_start_multifd_mapped_ram_fdset_dio;
>      args->end_hook =3D migrate_hook_end_multifd_mapped_ram_fdset;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
> @@ -286,8 +302,9 @@ test_precopy_file_mapped_ram_ignore_shared(char *name=
, MigrateCommon *args)
>  {
>      g_autofree char *uri =3D g_strdup_printf("file:%s/%s", tmpfs,
>                                             FILE_TEST_FILENAME);
> +    args->listen_uri =3D uri;
>      args->connect_uri =3D uri;
> -    args->listen_uri =3D "defer";
> +    args->start.incoming_defer =3D true;
> =20
>      args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] =3D true;
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/fr=
amework.c
> index b9371372de..75605d1791 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -428,7 +428,8 @@ int migrate_args(char **from, char **to, const char *=
uri, MigrateStart *args)
>                                   "%s %s %s %s",
>                                   kvm_opts ? kvm_opts : "",
>                                   machine, machine_opts,
> -                                 memory_backend, tmpfs, uri,
> +                                 memory_backend, tmpfs,
> +                                 args->incoming_defer ? "defer" : uri,
>                                   events,
>                                   arch_opts ? arch_opts : "",
>                                   args->opts_target ? args->opts_target :=
 "",
> @@ -873,8 +874,7 @@ int test_precopy_common(MigrateCommon *args)
>       * migrate-incoming channels.
>       */
>      if (args->connect_channels) {
> -        if (args->start.defer_target_connect &&
> -            !strcmp(args->listen_uri, "defer")) {
> +        if (args->start.defer_target_connect && args->start.incoming_def=
er) {
>              in_channels =3D qobject_from_json(args->connect_channels,
>                                              &error_abort);
>          }
> @@ -898,8 +898,8 @@ int test_precopy_common(MigrateCommon *args)
>      if (args->start.defer_target_connect) {
>          qtest_connect(to);
>          qtest_qmp_handshake(to, NULL);
> -        if (!strcmp(args->listen_uri, "defer")) {
> -            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}=
");
> +        if (args->start.incoming_defer) {
> +            migrate_incoming_qmp(to, NULL, in_channels, "{}");
>          }
>      }
> =20
> @@ -1048,7 +1048,7 @@ void test_file_common(MigrateCommon *args, bool sto=
p_src)
>       * We need to wait for the source to finish before starting the
>       * destination.
>       */
> -    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
> +    migrate_incoming_qmp(to, args->listen_uri, NULL, "{}");
>      wait_for_migration_complete(to);
> =20
>      if (stop_src) {
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/fr=
amework.h
> index 80eef75893..f920735d05 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -145,6 +145,13 @@ typedef struct {
>       * migration_set_capabilities().
>       */
>      bool caps[MIGRATION_CAPABILITY__MAX];
> +
> +    /*
> +     * Whether to use "defer" as the uri for the -incoming command
> +     * line option. If set to true, MigrateCommon.listen_uri will be
> +     * used for the deferred migrate_incoming call.
> +     */
> +    bool incoming_defer;
>  } MigrateStart;
> =20
>  typedef enum PostcopyRecoveryFailStage {
> diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/m=
isc-tests.c
> index 06da2657d5..a1704755d9 100644
> --- a/tests/qtest/migration/misc-tests.c
> +++ b/tests/qtest/migration/misc-tests.c
> @@ -217,7 +217,6 @@ static void do_test_validate_uri_channel(MigrateCommo=
n *args)
> =20
>  static void test_validate_uri_channels_both_set(char *name, MigrateCommo=
n *args)
>  {
> -    args->listen_uri =3D "defer",
>      args->connect_uri =3D "tcp:127.0.0.1:0",
>      args->connect_channels =3D ("[ { ""'channel-type': 'main',"
>                                "    'addr': { 'transport': 'socket',"
> @@ -225,6 +224,7 @@ static void test_validate_uri_channels_both_set(char =
*name, MigrateCommon *args)
>                                "              'host': '127.0.0.1',"
>                                "              'port': '0' } } ]"),
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.hide_stderr =3D true;
> =20
>      do_test_validate_uri_channel(args);
> @@ -232,8 +232,8 @@ static void test_validate_uri_channels_both_set(char =
*name, MigrateCommon *args)
> =20
>  static void test_validate_uri_channels_none_set(char *name, MigrateCommo=
n *args)
>  {
> -    args->listen_uri =3D "defer";
>      args->start.hide_stderr =3D true;
> +    args->start.incoming_defer =3D true;
> =20
>      do_test_validate_uri_channel(args);
>  }
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migratio=
n/precopy-tests.c
> index f17dc5176d..31fd4af1ad 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -282,11 +282,12 @@ static void migrate_hook_end_fd(QTestState *from,
> =20
>  static void test_precopy_fd_socket(char *name, MigrateCommon *args)
>  {
> -    args->listen_uri =3D "defer";
>      args->connect_uri =3D "fd:fd-mig";
>      args->start_hook =3D migrate_hook_start_fd;
>      args->end_hook =3D migrate_hook_end_fd;
> =20
> +    args->start.incoming_defer =3D true;
> +
>      test_precopy_common(args);
>  }
>  #endif /* _WIN32 */
> @@ -435,7 +436,6 @@ migrate_hook_start_precopy_tcp_multifd_no_zero_page(Q=
TestState *from,
> =20
>  static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd;
>      /*
>       * Multifd is more complicated than most of the features, it
> @@ -444,6 +444,7 @@ static void test_multifd_tcp_uri_none(char *name, Mig=
rateCommon *args)
>       */
>      args->live =3D true;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
>      test_precopy_common(args);
> @@ -451,7 +452,6 @@ static void test_multifd_tcp_uri_none(char *name, Mig=
rateCommon *args)
> =20
>  static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon =
*args)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd_zero_pag=
e_legacy;
>      /*
>       * Multifd is more complicated than most of the features, it
> @@ -460,6 +460,7 @@ static void test_multifd_tcp_zero_page_legacy(char *n=
ame, MigrateCommon *args)
>       */
>      args->live =3D true;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
>      test_precopy_common(args);
> @@ -467,7 +468,6 @@ static void test_multifd_tcp_zero_page_legacy(char *n=
ame, MigrateCommon *args)
> =20
>  static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *arg=
s)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd_no_zero_=
page;
>      /*
>       * Multifd is more complicated than most of the features, it
> @@ -476,6 +476,7 @@ static void test_multifd_tcp_no_zero_page(char *name,=
 MigrateCommon *args)
>       */
>      args->live =3D true;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
>      test_precopy_common(args);
> @@ -483,7 +484,6 @@ static void test_multifd_tcp_no_zero_page(char *name,=
 MigrateCommon *args)
> =20
>  static void test_multifd_tcp_channels_none(char *name, MigrateCommon *ar=
gs)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_precopy_tcp_multifd;
>      args->live =3D true;
>      args->connect_channels =3D ("[ { 'channel-type': 'main',"
> @@ -492,6 +492,7 @@ static void test_multifd_tcp_channels_none(char *name=
, MigrateCommon *args)
>                               "              'host': '127.0.0.1',"
>                                "              'port': '0' } } ]");
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
>      test_precopy_common(args);
> @@ -513,6 +514,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *ar=
gs, bool postcopy_ram)
>      QTestState *from, *to, *to2;
> =20
>      args->start.hide_stderr =3D true;
> +    args->start.incoming_defer =3D true;
> =20
>      if (migrate_start(&from, &to, "defer", &args->start)) {
>          return;
> @@ -560,6 +562,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *ar=
gs, bool postcopy_ram)
>      wait_for_migration_status(from, "cancelled", NULL);
> =20
>      args->start.only_target =3D true;
> +    args->start.incoming_defer =3D true;
> =20
>      if (migrate_start(&from, &to2, "defer", &args->start)) {
>          return;
> @@ -734,6 +737,7 @@ static void test_cancel_src_after_status(char *test_p=
ath, MigrateCommon *args)
>      QTestState *from, *to;
> =20
>      args->start.hide_stderr =3D true;
> +    args->start.incoming_defer =3D true;
> =20
>      if (migrate_start(&from, &to, "defer", &args->start)) {
>          return;
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tl=
s-tests.c
> index 4ce7f6c676..40a78bd2d2 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c
> @@ -673,10 +673,10 @@ migrate_hook_start_multifd_tls_x509_reject_anon_cli=
ent(QTestState *from,
> =20
>  static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *ar=
gs)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_multifd_tcp_tls_psk_match;
>      args->end_hook =3D migrate_hook_end_tls_psk;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
>      test_precopy_common(args);
> @@ -684,12 +684,12 @@ static void test_multifd_tcp_tls_psk_match(char *na=
me, MigrateCommon *args)
> =20
>  static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon =
*args)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_multifd_tcp_tls_psk_mismatch;
>      args->end_hook =3D migrate_hook_end_tls_psk;
>      args->result =3D MIG_TEST_FAIL;
> =20
>      args->start.hide_stderr =3D true;
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
>      test_precopy_common(args);
> @@ -698,10 +698,10 @@ static void test_multifd_tcp_tls_psk_mismatch(char =
*name, MigrateCommon *args)
>  static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
>                                                      MigrateCommon *args)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_multifd_tcp_tls_psk_match;
>      args->end_hook =3D migrate_hook_end_tls_psk;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] =3D true;
> =20
> @@ -712,10 +712,10 @@ static void test_multifd_postcopy_tcp_tls_psk_match=
(char *name,
>  static void test_multifd_tcp_tls_x509_default_host(char *name,
>                                                     MigrateCommon *args)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_multifd_tls_x509_default_hos=
t;
>      args->end_hook =3D migrate_hook_end_tls_x509;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
>      test_precopy_common(args);
> @@ -724,10 +724,10 @@ static void test_multifd_tcp_tls_x509_default_host(=
char *name,
>  static void test_multifd_tcp_tls_x509_override_host(char *name,
>                                                      MigrateCommon *args)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_multifd_tls_x509_override_ho=
st;
>      args->end_hook =3D migrate_hook_end_tls_x509;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
>      test_precopy_common(args);
> @@ -749,11 +749,11 @@ static void test_multifd_tcp_tls_x509_mismatch_host=
(char *name,
>       * to load migration state, and thus just aborts the migration
>       * without exiting.
>       */
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_multifd_tls_x509_mismatch_ho=
st;
>      args->end_hook =3D migrate_hook_end_tls_x509;
>      args->result =3D MIG_TEST_FAIL;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.hide_stderr =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
> @@ -763,10 +763,10 @@ static void test_multifd_tcp_tls_x509_mismatch_host=
(char *name,
>  static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
>                                                          MigrateCommon *a=
rgs)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_multifd_tls_x509_allow_anon_=
client;
>      args->end_hook =3D migrate_hook_end_tls_x509;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20
>      test_precopy_common(args);
> @@ -775,11 +775,11 @@ static void test_multifd_tcp_tls_x509_allow_anon_cl=
ient(char *name,
>  static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
>                                                           MigrateCommon *=
args)
>  {
> -    args->listen_uri =3D "defer";
>      args->start_hook =3D migrate_hook_start_multifd_tls_x509_reject_anon=
_client;
>      args->end_hook =3D migrate_hook_end_tls_x509;
>      args->result =3D MIG_TEST_FAIL;
> =20
> +    args->start.incoming_defer =3D true;
>      args->start.hide_stderr =3D true;
>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] =3D true;
> =20


--Sig_/9B1YDu2PIjQU6C/erLvzrJ1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmwPVIACgkQNasLKJxd
slhgjQ/8DSex+93itqWUgcdnopMx+7tobSYcUOhc9fmGS3FG7Mr2AuExWMOTrcWo
ui/4oACG95YXVjjXpqIGz5bWkFZP2YdaApBSG3i8/y+wsSVznTWNLZ5bXoJL0UNZ
/DzexRY6ZOW28oCeWgVdiOICOKrKCoj5wJLpYQB907c7FdyCmaBEPySswVlDG7et
3qyfsoi1VI7A+5TaA80FIIEBJmH8NBAsUWWSRmA1+yUCWyO30NB/hSQQWtAp3na8
hgaFMH2JaaGuwzvwHaAAIH4/tsD7XskaUa3/ptt6tNz9KR+bKzJp92Sgxk+HVb8W
VokmVlXX/x8B+Ohur3HoqEL+YdzDqwTe6d2Uy5a7ZCaVKHdHTkoOvu91JpQyAK1e
+TPamSantRtW1XeRplm6Lay96dIshXl9VzqLm96TUzqja/bBtDSdVeSKxkFbL+97
9xl1qWSu0r/ZnwuftI1IxpLJ8qpel2/by/UrcN/Lc5q2s9LdUlsk3p/Ox7ErH/yt
n45ouGsMFT/K3JKYyT5ab0AlSFcfclIi9I4uk2sHbeRp41ccp51wrFUxZLpz5kY1
V6rf5Rm0aPMt/y2w5IUicB1YNVTwmXn+f/caNCU/Tr85Mojs86dQBXiwhDjQibGR
kybP6mrO+IKEGj+E/vI5r6pj+NzRGFj2aOCTW+O5j2uhNzvtKO0=
=aT6E
-----END PGP SIGNATURE-----

--Sig_/9B1YDu2PIjQU6C/erLvzrJ1--

