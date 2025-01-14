Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503B4C02184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 13:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXhEF-00023o-6E; Tue, 14 Jan 2025 08:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tXhEA-000215-Du
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:45:06 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tXhE8-00009x-BH
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:45:06 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d9837f201aso9533407a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 05:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736862302; x=1737467102; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SsyJGjDRQt3+2lMlMWYz0qdY3EFmcfqri/t8MxP8X+Q=;
 b=B8y1Cc1mKdmEQMk0rrdcfM44GmFLySKdAqhqJ2M+JrOK63VlEqaeHX3SxKq3ej5CDL
 BOaM/FvH4guTfu5Z58SS+M2IUxIL86osCNeMOrcjGw9Hj6rnz/MHxitDOpRZ/q9GApHR
 499k8z8rg11xyFx4gEy0/cPdNwgNMGICszO2fPBOV10ItQ0ttx2XIMu7EJdSfLrYq9TD
 mUjl9FteDBeA5+9fflb/O8wWt6d4HcVyBjbWIsJLJl98/34ysi4w2QAYK4yypJ+LPh7z
 45fyPuZlJ02ksJ4ZEV01nsNzcZw+h4UfS7n+xeY+LpXMi7DtXjH29jZFm4djTNTnnZUx
 4rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736862302; x=1737467102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SsyJGjDRQt3+2lMlMWYz0qdY3EFmcfqri/t8MxP8X+Q=;
 b=sUG69C697czqsuVp5KJWNI9EfzKPQqDCdYBunHCxsuoroXgdin3I+nAroCHAUrpIvt
 LwnmUej/M5AckkF4W7T6QmghTgR9EavM/EAZ281eWoubg3P2/GhicHuiJODChI9N1e6r
 +Uud0ddlNB2wS/8xNx7a99ZMGexgNjbArGVsPgf6PJq+HE7SvUmeewmaqgWXkIdlDNdj
 04w1fBjaPsjXNTkpouxLIAldJ+PAf86CekF/CpZy1SJQ9iKp+pF3eqK04HpA151dX8PT
 ztvYeJirfSiCF+Y+npGVrpZ+PaiGibLLBlWljRss49Gx1oP1GfmJhU1mugHTZl6nTErt
 2Ugw==
X-Gm-Message-State: AOJu0YxdrOvI6tyWcSEOmdllNAZGWIuElhfYMTE5NXpVej65lnWFActp
 0Ixtp128uhl+GX+ASkXvSbV5IRvmSC9cZGv2dFy7CgfZR1je54O6wjnQ8njl94S8gwKCRYEfcRv
 gYEroArkVReMFL0oZc2rxbWrvsBc=
X-Gm-Gg: ASbGncu98+4JcVclZ6Mq3YWlRcqaQbmaPipy8SGgHKv1ekMI0VMsp0LuOJ6GEELj4N5
 8ZacwRxYzQnuBamVlnVwQcvOo3FSzX8iDvbNl
X-Google-Smtp-Source: AGHT+IHzrGWUYjZf9qx3lCumX0hFdSw8Z1NUczQs/P5JWUMVtE6dDzn01guyHCQq0noSj0SefSJj9xPtFT0XtSpcBpg=
X-Received: by 2002:a05:6402:4408:b0:5d3:eb50:4e33 with SMTP id
 4fb4d7f45d1cf-5d9861d1511mr18408281a12.5.1736862301427; Tue, 14 Jan 2025
 05:45:01 -0800 (PST)
MIME-Version: 1.0
References: <20250113210833.1712-1-farosas@suse.de>
In-Reply-To: <20250113210833.1712-1-farosas@suse.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 14 Jan 2025 08:44:49 -0500
X-Gm-Features: AbW1kvavNETjIdjij3_8959NkR7kgi1srURu2dFl72-DNiOwc3N0ga7qkHgsVXQ
Message-ID: <CAJSP0QWe+0_rjchH0hCszU-4r_PF+ZgZgWb+cgg6UZzZiYeTQA@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/qtest/migration: Add cpu hotplug test
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
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

On Mon, 13 Jan 2025 at 16:09, Fabiano Rosas <farosas@suse.de> wrote:
>
> Bug #2594 is about a failure during migration after a cpu hotplug. Add
> a test that covers that scenario. Start the source with -smp 2 and
> destination with -smp 3, plug one extra cpu to match and migrate.
>
> The issue seems to be a mismatch in the number of virtqueues between
> the source and destination due to the hotplug not changing the
> num_queues:
>
>   get_pci_config_device: Bad config data: i=0x9a read: 4 device: 5
>   cmask: ff wmask: 0 w1cmask:0
>
> Usage:
> $ QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_BINARY=./qemu-system-x86_64 \
>   ./tests/qtest/migration-test -p /x86_64/migration/hotplug/cpu
>
> References: https://gitlab.com/qemu-project/qemu/-/issues/2594
> References: https://issues.redhat.com/browse/RHEL-68302
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> As you can see there's no fix attached to this. I haven't reached that
> part yet, suggestions welcome =). Posting the test case if anyone
> wants to play with this.
>
> (if someone at RH is already working on this, that's fine. I'm just
> trying to get some upstream bugs to move)

The management tool should set num_queues on the destination to ensure
migration compatibility.

Stefan

> ---
>  tests/qtest/migration/misc-tests.c | 76 ++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
> index 6173430748..bde567b124 100644
> --- a/tests/qtest/migration/misc-tests.c
> +++ b/tests/qtest/migration/misc-tests.c
> @@ -251,6 +251,79 @@ static void test_validate_uri_channels_none_set(void)
>      do_test_validate_uri_channel(&args);
>  }
>
> +static void test_cpu_hotplug_virtqueues(void)
> +{
> +    MigrateStart args = {
> +        .hide_stderr = false,
> +    };
> +    QTestState *from, *to;
> +    g_autofree char *device_virtio_scsi = NULL;
> +    g_autofree char *device_virtio_blk = NULL;
> +    g_autofree char *filename_scsi = g_strdup_printf("%s/qtest_disk0.qcow2", tmpfs);
> +    g_autofree char *filename_blk = g_strdup_printf("%s/qtest_disk1.qcow2", tmpfs);
> +
> +    /*
> +     * Matching the queues between src/dst allows the test to pass.
> +     * Defaults are:
> +     *   virtio-scsi-pci:   #vcpus + 2 queues that are always present.
> +     *   virtio-blk-pci:    same number of queues as vcpus.
> +     * See virtio_pci_optimal_num_queues() for the exact computation.
> +     */
> +    bool match_queues = false;
> +    const char *qs_scsi = "num_queues=5";
> +    const char *qs_blk = "num-queues=3"; /* _ vs. - is not a mistake */
> +
> +    g_assert(mkimg(filename_scsi, "qcow2", 1));
> +    g_assert(mkimg(filename_blk, "qcow2", 1));
> +
> +    device_virtio_scsi = g_strdup_printf(
> +        "-drive id=drive0,if=none,format=qcow2,file=%s "
> +        "-device virtio-scsi-pci,id=scsi0,%s "
> +        "-device scsi-hd,drive=drive0,bus=scsi0.0 ",
> +        filename_scsi, match_queues ? qs_scsi : "");
> +
> +    device_virtio_blk = g_strdup_printf(
> +        "-drive id=drive1,if=none,format=qcow2,file=%s "
> +        "-device virtio-blk-pci,drive=drive1,id=blk0,%s ",
> +        filename_blk, match_queues ? qs_blk : "");
> +
> +    /* The missing cpu will be hotplugged before migration */
> +    args.opts_source = g_strconcat("-smp 2,threads=1,sockets=1,maxcpus=4 ",
> +                                   device_virtio_scsi,
> +                                   device_virtio_blk, NULL);
> +
> +    args.opts_target = g_strconcat("-smp 3,threads=1,sockets=1,maxcpus=4 ",
> +                                   device_virtio_scsi,
> +                                   device_virtio_blk, NULL);
> +
> +    if (migrate_start(&from, &to, "defer", &args)) {
> +        return;
> +    }
> +
> +    g_free((char *)args.opts_source);
> +    g_free((char *)args.opts_target);
> +
> +
> +    migrate_ensure_converge(from);
> +    wait_for_serial("src_serial");
> +
> +    qtest_qmp_assert_success(from, "{ 'execute': 'device_add',"
> +                             "  'arguments': { "
> +                             "    'node-id': 0, 'socket-id': 0,"
> +                             "    'core-id': 2, 'thread-id': 0,"
> +                             "    'id': {},"
> +                             "    'driver': 'qemu64-x86_64-cpu' } }");
> +
> +    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
> +
> +    migrate_qmp(from, to, NULL, NULL, "{}");
> +    wait_for_migration_complete(from);
> +
> +    migrate_end(from, to, true);
> +    unlink(filename_scsi);
> +    unlink(filename_blk);
> +}
> +
>  void migration_test_add_misc(MigrationTestEnv *env)
>  {
>      tmpfs = env->tmpfs;
> @@ -279,4 +352,7 @@ void migration_test_add_misc(MigrationTestEnv *env)
>                         test_validate_uri_channels_both_set);
>      migration_test_add("/migration/validate_uri/channels/none_set",
>                         test_validate_uri_channels_none_set);
> +
> +    migration_test_add("/migration/hotplug/cpu/virtqueues",
> +                       test_cpu_hotplug_virtqueues);
>  }
> --
> 2.35.3
>
>

