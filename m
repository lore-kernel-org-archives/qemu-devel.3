Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B01C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 19:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYVC0-0008Qy-KG; Thu, 16 Jan 2025 14:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYVBx-0008L3-Up
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 14:06:10 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYVBv-0007Pz-RA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 14:06:09 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 141F521185;
 Thu, 16 Jan 2025 19:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737054365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NOEpuLrSHnem/Zahj7yv0JRwxm3Wf/w9ZGIKhFwcCGw=;
 b=rG7C6SNmbt15Bow2B+9gavIZFIarbN8dSoL9wgpdHhmxmihAu4YvxnEFTf7ejvAwtGCkh9
 36BA4FOyGpCI1YV7MucG/CPedBQOzk+PXYHJJAWITk0dHup8yQZxUFuZ8eAHkOnQIuW1+3
 Ia9UoOloHLPXo5AG0vYEcpVSHACGoJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737054365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NOEpuLrSHnem/Zahj7yv0JRwxm3Wf/w9ZGIKhFwcCGw=;
 b=80YmK47JhB/cnbFLJ517Ed7KCW5k5iHjZ6jygJ0gFNmBmkXdZhCuz0D1NqG3HZCdFCIBZB
 /v0ppReGuYJi5YAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rG7C6SNm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=80YmK47J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737054365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NOEpuLrSHnem/Zahj7yv0JRwxm3Wf/w9ZGIKhFwcCGw=;
 b=rG7C6SNmbt15Bow2B+9gavIZFIarbN8dSoL9wgpdHhmxmihAu4YvxnEFTf7ejvAwtGCkh9
 36BA4FOyGpCI1YV7MucG/CPedBQOzk+PXYHJJAWITk0dHup8yQZxUFuZ8eAHkOnQIuW1+3
 Ia9UoOloHLPXo5AG0vYEcpVSHACGoJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737054365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NOEpuLrSHnem/Zahj7yv0JRwxm3Wf/w9ZGIKhFwcCGw=;
 b=80YmK47JhB/cnbFLJ517Ed7KCW5k5iHjZ6jygJ0gFNmBmkXdZhCuz0D1NqG3HZCdFCIBZB
 /v0ppReGuYJi5YAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8007D13A57;
 Thu, 16 Jan 2025 19:06:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tdhCD5xYiWceUwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 16 Jan 2025 19:06:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V7 23/24] migration-test: cpr-transfer
In-Reply-To: <1736967650-129648-24-git-send-email-steven.sistare@oracle.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
 <1736967650-129648-24-git-send-email-steven.sistare@oracle.com>
Date: Thu, 16 Jan 2025 16:06:01 -0300
Message-ID: <8734hifujq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 141F521185
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org,oracle.com];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_SEVEN(0.00)[11];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Add a migration test for cpr-transfer mode.  Defer the connection to the
> target monitor, else the test hangs because in cpr-transfer mode QEMU does
> not listen for monitor connections until we send the migrate command to
> source QEMU.
>
> To test -incoming defer, send a migrate incoming command to the target,
> after sending the migrate command to the source, as required by
> cpr-transfer mode.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration/cpr-tests.c | 62 +++++++++++++++++++++++++++++++++++++++
>  tests/qtest/migration/framework.c | 19 ++++++++++++
>  tests/qtest/migration/framework.h |  3 ++
>  3 files changed, 84 insertions(+)
>
> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> index 44ce89a..215b0df 100644
> --- a/tests/qtest/migration/cpr-tests.c
> +++ b/tests/qtest/migration/cpr-tests.c
> @@ -44,6 +44,62 @@ static void test_mode_reboot(void)
>      test_file_common(&args, true);
>  }
>  
> +static void *test_mode_transfer_start(QTestState *from, QTestState *to)
> +{
> +    migrate_set_parameter_str(from, "mode", "cpr-transfer");
> +    return NULL;
> +}
> +
> +/*
> + * cpr-transfer mode cannot use the target monitor prior to starting the
> + * migration, and cannot connect synchronously to the monitor, so defer
> + * the target connection.
> + */
> +static void test_mode_transfer_common(bool incoming_defer)
> +{
> +    g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
> +    g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
> +    g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
> +
> +    const char *opts = "-machine aux-ram-share=on -nodefaults";
> +    g_autofree const char *cpr_channel = g_strdup_printf(
> +        "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
> +        cpr_path);
> +    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
> +                                                   cpr_channel, opts);
> +
> +    g_autofree char *connect_channels = g_strdup_printf(
> +        "[ { 'channel-type': 'main',"
> +        "    'addr': { 'transport': 'socket',"
> +        "              'type': 'unix',"
> +        "              'path': '%s' } } ]",
> +        mig_path);
> +
> +    MigrateCommon args = {
> +        .start.opts_source = opts,
> +        .start.opts_target = opts_target,
> +        .start.defer_target_connect = true,
> +        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
> +                                " -machine memory-backend=pc.ram",
> +        .listen_uri = incoming_defer ? "defer" : uri,
> +        .connect_channels = connect_channels,
> +        .cpr_channel = cpr_channel,
> +        .start_hook = test_mode_transfer_start,
> +    };
> +
> +    test_precopy_common(&args);
> +}
> +
> +static void test_mode_transfer(void)
> +{
> +    test_mode_transfer_common(NULL);
> +}
> +
> +static void test_mode_transfer_defer(void)
> +{
> +    test_mode_transfer_common(true);
> +}
> +
>  void migration_test_add_cpr(MigrationTestEnv *env)
>  {
>      tmpfs = env->tmpfs;
> @@ -55,4 +111,10 @@ void migration_test_add_cpr(MigrationTestEnv *env)
>      if (getenv("QEMU_TEST_FLAKY_TESTS")) {
>          migration_test_add("/migration/mode/reboot", test_mode_reboot);
>      }
> +
> +    if (env->has_kvm) {
> +        migration_test_add("/migration/mode/transfer", test_mode_transfer);
> +        migration_test_add("/migration/mode/transfer/defer",
> +                           test_mode_transfer_defer);
> +    }
>  }
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 8d34cb2..699beda 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -407,6 +407,7 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest)
>      qtest_quit(to);
>  
>      cleanup("migsocket");
> +    cleanup("cpr.sock");
>      cleanup("src_serial");
>      cleanup("dest_serial");
>      cleanup(FILE_TEST_FILENAME);
> @@ -688,8 +689,11 @@ void test_precopy_common(MigrateCommon *args)
>  {
>      QTestState *from, *to;
>      void *data_hook = NULL;
> +    QObject *in_channels = NULL;
>      QObject *out_channels = NULL;
>  
> +    g_assert(!args->cpr_channel || args->connect_channels);
> +
>      if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
>          return;
>      }
> @@ -721,8 +725,20 @@ void test_precopy_common(MigrateCommon *args)
>          }
>      }
>  
> +    /*
> +     * The cpr channel must be included in outgoing channels, but not in
> +     * migrate-incoming channels.
> +     */
>      if (args->connect_channels) {
> +        in_channels = qobject_from_json(args->connect_channels, &error_abort);
>          out_channels = qobject_from_json(args->connect_channels, &error_abort);
> +
> +        if (args->cpr_channel) {
> +            QList *channels_list = qobject_to(QList, out_channels);
> +            QObject *obj = migrate_str_to_channel(args->cpr_channel);
> +
> +            qlist_append(channels_list, obj);
> +        }
>      }
>  
>      if (args->result == MIG_TEST_QMP_ERROR) {
> @@ -735,6 +751,9 @@ void test_precopy_common(MigrateCommon *args)
>      if (args->start.defer_target_connect) {
>          qtest_connect(to);
>          qtest_qmp_handshake(to);
> +        if (!strcmp(args->listen_uri, "defer")) {
> +            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
> +        }

Paths that don't call migrate_incoming_qmp() never free
in_channels. We'll need something like this, let me know if I can squash
it in or you want to do it differently:

-- >8 --
From 62d60c39b3e5d38cac20241e63b9d023bd296d2f Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Thu, 16 Jan 2025 15:40:22 -0300
Subject: [PATCH] fixup! migration-test: cpr-transfer

---
 tests/qtest/migration/framework.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 699bedae69..1d5918d922 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -753,9 +753,14 @@ void test_precopy_common(MigrateCommon *args)
         qtest_qmp_handshake(to);
         if (!strcmp(args->listen_uri, "defer")) {
             migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
+            in_channels = NULL;
         }
     }
 
+    if (in_channels) {
+        qobject_unref(in_channels);
+    }
+
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
         wait_for_migration_fail(from, allow_active);
-- 
2.35.3

