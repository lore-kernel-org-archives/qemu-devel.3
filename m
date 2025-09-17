Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11D2CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 21:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyzNp-0006Ug-7K; Wed, 17 Sep 2025 17:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyzNn-0006U6-5A
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 17:08:07 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyzNi-0001Bj-Li
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 17:08:05 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D387420107;
 Wed, 17 Sep 2025 21:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758143280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRIsNYDyfKkNMcv6LXDBoCepCLZ5ndLbEa0qSAn36zE=;
 b=iT3c0uvgbELPOF60c4vEKCohgAXZAyV+5h856AJq3WTCHnF2B19hV3Zwo35qTAoT4WoXFQ
 740CMJtQXAWrNwvlKKHHDt1wAi3w9CvJxxyEiCNA0KohCUFce3LIL/Y5TG82J5N9GZR4mK
 xLLq/5TBFwqOPZFt33kvfIbja4RJDw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758143280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRIsNYDyfKkNMcv6LXDBoCepCLZ5ndLbEa0qSAn36zE=;
 b=8P/EaSS4LfMG/E0aDFK4xF1NL2qArUh0V30LO3k7iS15/HXu4+UHUCpsSioVhMXORtSqhb
 QiFl1cxYWS7NYqCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iT3c0uvg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="8P/EaSS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758143280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRIsNYDyfKkNMcv6LXDBoCepCLZ5ndLbEa0qSAn36zE=;
 b=iT3c0uvgbELPOF60c4vEKCohgAXZAyV+5h856AJq3WTCHnF2B19hV3Zwo35qTAoT4WoXFQ
 740CMJtQXAWrNwvlKKHHDt1wAi3w9CvJxxyEiCNA0KohCUFce3LIL/Y5TG82J5N9GZR4mK
 xLLq/5TBFwqOPZFt33kvfIbja4RJDw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758143280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRIsNYDyfKkNMcv6LXDBoCepCLZ5ndLbEa0qSAn36zE=;
 b=8P/EaSS4LfMG/E0aDFK4xF1NL2qArUh0V30LO3k7iS15/HXu4+UHUCpsSioVhMXORtSqhb
 QiFl1cxYWS7NYqCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FE951368D;
 Wed, 17 Sep 2025 21:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9g+tBDAjy2iQAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Sep 2025 21:08:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 3/3] migration/multifd: Use the new graceful termination
 helper
In-Reply-To: <20250910160144.1762894-4-peterx@redhat.com>
References: <20250910160144.1762894-1-peterx@redhat.com>
 <20250910160144.1762894-4-peterx@redhat.com>
Date: Wed, 17 Sep 2025 18:07:57 -0300
Message-ID: <87qzw4vlci.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D387420107
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> Multifd has a separate loop to do TLS terminations gracefully.  Meanwhile,
> it depends on two variables which records thread creations.
>
> It works perfectly before, however relying on "whether some threads are
> created" flag might be not as straightforward to decide a graceful
> shutdown.
>
> Since we'll need to dynamically identify TLS channels anyway with the new
> helper (which is needed for main and postcopy channels), use the same
> simple API for multifd channels too.  Also, we only need graceful shutdown
> on success of migrations.
>
> With that, we can remove the loop and drop migration_tls_channel_end().
>
> The comment there is still a good explanation, move it over to the new
> helper instead.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/tls.h     |  1 -
>  migration/channel.c |  7 +++++++
>  migration/multifd.c | 40 +++++++---------------------------------
>  migration/tls.c     |  5 -----
>  4 files changed, 14 insertions(+), 39 deletions(-)
>
> diff --git a/migration/tls.h b/migration/tls.h
> index 58b25e1228..75c918e156 100644
> --- a/migration/tls.h
> +++ b/migration/tls.h
> @@ -36,7 +36,6 @@ void migration_tls_channel_connect(MigrationState *s,
>                                     QIOChannel *ioc,
>                                     const char *hostname,
>                                     Error **errp);
> -void migration_tls_channel_end(QIOChannel *ioc, Error **errp);
>  /* Whether the QIO channel requires further TLS handshake? */
>  bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc);
>  
> diff --git a/migration/channel.c b/migration/channel.c
> index 1ae839e5fe..a481b45eae 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -153,6 +153,13 @@ int migration_channel_read_peek(QIOChannel *ioc,
>  bool migration_channel_shutdown_gracefully(QIOChannel *c, Error **errp)
>  {
>      if (object_dynamic_cast((Object *)c, TYPE_QIO_CHANNEL_TLS)) {
> +        /*
> +         * The destination expects the TLS session to always be properly
> +         * terminated. This helps to detect a premature termination in the
> +         * middle of the stream.  Note that older QEMUs always break the
> +         * connection on the source and the destination always sees
> +         * GNUTLS_E_PREMATURE_TERMINATION.
> +         */
>          qio_channel_tls_bye(QIO_CHANNEL_TLS(c), errp);
>      }
>  
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b255778855..cb0262076b 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -439,7 +439,7 @@ static void multifd_send_set_error(Error *err)
>      }
>  }
>  
> -static void multifd_send_terminate_threads(void)
> +static void multifd_send_terminate_threads(bool succeeded)
>  {
>      int i;
>  
> @@ -460,6 +460,9 @@ static void multifd_send_terminate_threads(void)
>  
>          qemu_sem_post(&p->sem);
>          if (p->c) {
> +            if (succeeded) {
> +                migration_channel_shutdown_gracefully(p->c, &error_warn);

Maybe keep the warning on failure to gracefully terminate?

> +            }
>              qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);

This triggers my multifd-code-smell detector. Reusing the loop. Could
the destination perhaps see this shutdown and start cleanup of it's
channels, causing the subsequent bye to fail?

>          }
>      }
> @@ -541,50 +544,21 @@ static void multifd_send_cleanup_state(void)
>  
>  void multifd_send_shutdown(void)
>  {
> +    MigrationState *s = migrate_get_current();
>      int i;
>  
>      if (!migrate_multifd()) {
>          return;
>      }
>  
> -    for (i = 0; i < migrate_multifd_channels(); i++) {
> -        MultiFDSendParams *p = &multifd_send_state->params[i];
> -
> -        /* thread_created implies the TLS handshake has succeeded */
> -        if (p->tls_thread_created && p->thread_created) {
> -            Error *local_err = NULL;
> -            /*
> -             * The destination expects the TLS session to always be
> -             * properly terminated. This helps to detect a premature
> -             * termination in the middle of the stream.  Note that
> -             * older QEMUs always break the connection on the source
> -             * and the destination always sees
> -             * GNUTLS_E_PREMATURE_TERMINATION.
> -             */
> -            migration_tls_channel_end(p->c, &local_err);
> -
> -            /*
> -             * The above can return an error in case the migration has
> -             * already failed. If the migration succeeded, errors are
> -             * not expected but there's no need to kill the source.
> -             */
> -            if (local_err && !migration_has_failed(migrate_get_current())) {
> -                warn_report(
> -                    "multifd_send_%d: Failed to terminate TLS connection: %s",
> -                    p->id, error_get_pretty(local_err));
> -                break;
> -            }
> -        }
> -    }
> -
> -    multifd_send_terminate_threads();
> +    multifd_send_terminate_threads(!migration_has_failed(s));

Looks awkward to pass this value in instead of caching inside the
function. But no big deal.

>  
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>          Error *local_err = NULL;
>  
>          if (!multifd_send_cleanup_channel(p, &local_err)) {
> -            migrate_set_error(migrate_get_current(), local_err);
> +            migrate_set_error(s, local_err);
>              error_free(local_err);
>          }
>      }
> diff --git a/migration/tls.c b/migration/tls.c
> index 284a6194b2..ca1595e05d 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -165,11 +165,6 @@ void migration_tls_channel_connect(MigrationState *s,
>                                NULL);
>  }
>  
> -void migration_tls_channel_end(QIOChannel *ioc, Error **errp)
> -{
> -    qio_channel_tls_bye(QIO_CHANNEL_TLS(ioc), errp);
> -}
> -
>  bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc)
>  {
>      if (!migrate_tls()) {

