Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0FCC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 08:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqpm2-0000u2-0H; Sat, 08 Mar 2025 03:43:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tqpm0-0000qg-Km
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:43:08 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tqply-0007Mh-H6
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:43:08 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5dce099f4so3068306a12.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 00:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741423384; x=1742028184; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxo8CzNaGgCZtLobjaeT2NxKeeswU1v2DOLQ/iOoskA=;
 b=X/ZuEFJzusBseSQAPj099SBwLkYdfaEZB1Ronu5qdT92iZFrmw2TzaGQ1bZEoM+tQ+
 BtG7vaRCrw3Sya0sLpDAhgYWxXpvVH/iYMLIbRX8otlhBKsB+3e0iMSMwW3Z9W+DUPDX
 7mr6enn/h1B3YO5ThMysCObMF+ChJkJT4z4hyFbn6EyP2PCnMJIgAoHusdj6x8DPO3Ce
 Ke9Rz/UgzanuFGXCM7rBXG7PZeJq8sBdR2v66Xzl3MkGUv2dWX7ehFdpMmG/B7HFCTAA
 BqNTZHJ/lEa0PFV4BIFcbO1E5GFOfRK37uFW7QVAZws/iAvpjYbYSmhHvECiY4apefJW
 C+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741423384; x=1742028184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxo8CzNaGgCZtLobjaeT2NxKeeswU1v2DOLQ/iOoskA=;
 b=xNvlhlxV83ylK/2FcBNGyPjy5vCYsn+6cufAmUdPWYRzUz+YvHyKq/PBl6qn5+1PVD
 qwUUC5KNovbzSgC4FfDEhKuX2UrqYJIEngPDdCgk14XxQkeNl/afAhzEMdKzD2WjcHqT
 sDtiVgGRDCq6K9pXu9EKQUQKK6qGHRLr3rOeB2BIoYZOycWyeTP9cgxVSeom6ReJR9vu
 Cd7XO8kbBdi/6PfG87VPgLQUXSnHKkxRyCnf5Lg+tBisxhWkax2ydaJ5bKZ4vAMZz+41
 L/+28Stxo3L4dAnd/FeMTMz2ZZEBRauvF82xLcFIbEebhLQ3N+TDJp3F5BAHDnn7dGkr
 4JBA==
X-Gm-Message-State: AOJu0YyVDKh6uClIVpeac6kMAs8GW6ZvdYYXPHzfA+/AOihbCfXev9h2
 iEzR//Fwod2KTT2uUmDtlJ1CBGyIXllIF8wlyFtd0LtC9lSUCl4bA7vtW/hVicydgUeDrBSbSfT
 QWshOy4dHQekeUFFaiCnMj5THd1I=
X-Gm-Gg: ASbGncskEOaBfRR+4wnfw1YvxrQCTOoMHNZLFVSSi7MSpWJhResgCSClWVSHju3A15C
 xseb8StwaELNhzUCl5rOrRacAh479LKEp+jqFWL8yclxFcKuIqreNThSdz1PTzNSs0eSdQ9+/gY
 u9Tm9mcUP1+7l5njsEerqLUGiMkQ==
X-Google-Smtp-Source: AGHT+IGPSHInVkhj0eak+ZcybW586+ISOJ+xbYD/zQ9nJVSXdhDQ582+EeqPiu6hgS47Rm/aDLmTLOacVBCj4kjp7YU=
X-Received: by 2002:a05:6402:1ed0:b0:5e4:cbee:234c with SMTP id
 4fb4d7f45d1cf-5e5e22da6cdmr6301810a12.10.1741423383618; Sat, 08 Mar 2025
 00:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20250307181551.19887-1-farosas@suse.de>
 <20250307181551.19887-9-farosas@suse.de>
 <4ce8e8e0-3aee-41dd-b1fb-ac9398b0c1d6@linaro.org>
In-Reply-To: <4ce8e8e0-3aee-41dd-b1fb-ac9398b0c1d6@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 8 Mar 2025 16:42:51 +0800
X-Gm-Features: AQ5f1Jr7XqbW4wBZ1fl2nr_Qwxk1akdNv99vL3qwpICuEd5Gj8h6-vyNsBBq5cA
Message-ID: <CAJSP0QVYqkPhWPYRQUbD0VbiKYsV_AGJnYU+3yaD-4AhKT5p_A@mail.gmail.com>
Subject: Re: [PULL 8/8] migration: Add qtest for migration over RDMA
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Li Zhijian <lizhijian@fujitsu.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52d.google.com
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

On Sat, Mar 8, 2025 at 2:01=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Hi,
>
> On 7/3/25 19:15, Fabiano Rosas wrote:
> > From: Li Zhijian <lizhijian@fujitsu.com>
> >
> > This qtest requires there is a RDMA(RoCE) link in the host.
> > In order to make the test work smoothly, introduce a
> > scripts/rdma-migration-helper.sh to
> > - setup a new Soft-RoCE(aka RXE) if it's root
> > - detect existing RoCE link
> >
> > Test will be skipped if there is no available RoCE link.
>
> Is it? Runing as user I'm getting:
>
>    RDMA ERROR: RDMA host is not set!

The CI is failing too:
https://gitlab.com/qemu-project/qemu/-/jobs/9350004599#L5590

I have dropped this pull request for now. Please send a new revision
once the issue has been resolved.

Stefan

>
> Apparently called via:
>
> qemu_start_incoming_migration()
>    -> rdma_start_incoming_migration()
>       -> qemu_rdma_dest_init()
>
> >   # Start of rdma tests
> >   # Running /x86_64/migration/precopy/rdma/plain
> >   Command 'rdma' is not available, please install it first.
> >   # To enable the test:
> >   # (1) Run 'scripts/rdma-migration-helper.sh setup' with root and reru=
n the test
> >   # or
> >   # (2) Run the test with root privilege
>
> Could this might be the issue, should we skip if not root, as calling
> the script in "detect" mode makes the new_rdma_link() method to succeed.
>
> >   #
> >   ok 1 /x86_64/migration/precopy/rdma/plain # SKIP No rdma link availab=
le
> >   # End of rdma tests
> >
> > Note: Remove the newly added RXE link by executing 'modprobe -r rdma_rx=
e'
> > or by specifying 'clean' within this script.
>
> qtest_add() provides both setup() / teardown() methods.
>
> Test leaving system in different state seems bogus to me.
> More even if the information is buried in a commit description...
>
> We shouldn't merge this patch as is IMHO.
>
> Regards,
>
> Phil.
>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > Message-ID: <20250305062825.772629-7-lizhijian@fujitsu.com>
> > [reformated the message to be under 90 characters]
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >   MAINTAINERS                           |  1 +
> >   scripts/rdma-migration-helper.sh      | 48 +++++++++++++++++++
> >   tests/qtest/migration/precopy-tests.c | 69 ++++++++++++++++++++++++++=
+
> >   3 files changed, 118 insertions(+)
> >   create mode 100755 scripts/rdma-migration-helper.sh
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5df6020ed5..56e85adcfb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3517,6 +3517,7 @@ R: Li Zhijian <lizhijian@fujitsu.com>
> >   R: Peter Xu <peterx@redhat.com>
> >   S: Odd Fixes
> >   F: migration/rdma*
> > +F: scripts/rdma-migration-helper.sh
> >
> >   Migration dirty limit and dirty page rate
> >   M: Hyman Huang <yong.huang@smartx.com>
> > diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-=
helper.sh
> > new file mode 100755
> > index 0000000000..08e29a52eb
> > --- /dev/null
> > +++ b/scripts/rdma-migration-helper.sh
> > @@ -0,0 +1,48 @@
> > +#!/bin/bash
> > +
> > +# Copied from blktests
> > +get_ipv4_addr()
> > +{
> > +    ip -4 -o addr show dev "$1" |
> > +        sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1=
/p' |
> > +        tr -d '\n'
> > +}
> > +
> > +has_soft_rdma()
> > +{
> > +    rdma link | grep -q " netdev $1[[:blank:]]*\$"
> > +}
> > +
> > +rdma_rxe_setup_detect()
> > +{
> > +    (
> > +        cd /sys/class/net &&
> > +            for i in *; do
> > +                [ -e "$i" ] || continue
> > +                [ "$i" =3D "lo" ] && continue
> > +                [ "$(<"$i/addr_len")" =3D 6 ] || continue
> > +                [ "$(<"$i/carrier")" =3D 1 ] || continue
> > +
> > +                has_soft_rdma "$i" && break
> > +                [ "$operation" =3D "setup" ] &&
> > +                    rdma link add "${i}_rxe" type rxe netdev "$i" && b=
reak
> > +            done
> > +        has_soft_rdma "$i" || return
> > +        get_ipv4_addr "$i"
> > +    )
> > +}
> > +
> > +operation=3D${1:-setup}
> > +
> > +command -v rdma >/dev/null || {
> > +    echo "Command 'rdma' is not available, please install it first." >=
&2
> > +    exit 1
> > +}
> > +
> > +if [ "$operation" =3D=3D "setup" ] || [ "$operation" =3D=3D "detect" ]=
; then
> > +    rdma_rxe_setup_detect
> > +elif [ "$operation" =3D=3D "clean" ]; then
> > +    modprobe -r rdma_rxe
> > +else
> > +    echo "Usage: $0 [setup | detect | clean]"
> > +fi
> > diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migrat=
ion/precopy-tests.c
> > index ba273d10b9..f1fe34020d 100644
> > --- a/tests/qtest/migration/precopy-tests.c
> > +++ b/tests/qtest/migration/precopy-tests.c
> > @@ -99,6 +99,71 @@ static void test_precopy_unix_dirty_ring(void)
> >       test_precopy_common(&args);
> >   }
> >
> > +#ifdef CONFIG_RDMA
> > +
> > +#define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
> > +static int new_rdma_link(char *buffer, bool verbose)
> > +{
> > +    const char *argument =3D (geteuid() =3D=3D 0) ? "setup" : "detect"=
;
> > +    char cmd[1024];
> > +
> > +    snprintf(cmd, sizeof(cmd), "%s %s %s", RDMA_MIGRATION_HELPER, argu=
ment,
> > +             verbose ? "" : "2>/dev/null");
> > +
> > +    FILE *pipe =3D popen(cmd, "r");
> > +    if (pipe =3D=3D NULL) {
> > +        perror("Failed to run script");
> > +        return -1;
> > +    }
> > +
> > +    int idx =3D 0;
> > +    while (fgets(buffer + idx, 128 - idx, pipe) !=3D NULL) {
> > +        idx +=3D strlen(buffer);
> > +    }
> > +
> > +    int status =3D pclose(pipe);
> > +    if (status =3D=3D -1) {
> > +        perror("Error reported by pclose()");
> > +        return -1;
> > +    } else if (WIFEXITED(status)) {
> > +        return WEXITSTATUS(status);
> > +    }
> > +
> > +    return -1;
> > +}
> > +
> > +static void test_precopy_rdma_plain(void)
> > +{
> > +    char buffer[128] =3D {};
> > +    bool verbose =3D g_getenv("QTEST_LOG");
> > +
> > +    if (new_rdma_link(buffer, verbose)) {
> > +        g_test_skip("No rdma link available");
> > +        if (verbose) {
> > +            g_test_message(
> > +                "To enable the test:\n"
> > +                "(1) Run \'" RDMA_MIGRATION_HELPER
> > +                " setup\' with root and rerun the test\n"
> > +                "or\n(2) Run the test with root privilege");
> > +        }
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * TODO: query a free port instead of hard code.
> > +     * 29200=3D('R'+'D'+'M'+'A')*100
> > +     **/
> > +    g_autofree char *uri =3D g_strdup_printf("rdma:%s:29200", buffer);
> > +
> > +    MigrateCommon args =3D {
> > +        .listen_uri =3D uri,
> > +        .connect_uri =3D uri,
> > +    };
> > +
> > +    test_precopy_common(&args);
> > +}
> > +#endif
> > +
> >   static void test_precopy_tcp_plain(void)
> >   {
> >       MigrateCommon args =3D {
> > @@ -1124,6 +1189,10 @@ static void migration_test_add_precopy_smoke(Mig=
rationTestEnv *env)
> >                          test_multifd_tcp_uri_none);
> >       migration_test_add("/migration/multifd/tcp/plain/cancel",
> >                          test_multifd_tcp_cancel);
> > +#ifdef CONFIG_RDMA
> > +    migration_test_add("/migration/precopy/rdma/plain",
> > +                       test_precopy_rdma_plain);
> > +#endif
> >   }
> >
> >   void migration_test_add_precopy(MigrationTestEnv *env)
>
>

