Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC94C79FBA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcqHs-0007yb-GR; Mon, 05 Jan 2026 14:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcqHk-0007xm-My
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:30:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcqHe-0001af-Lj
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767641426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xpwQgFcTsaNt3GIKI6kW6JxIz8iyCxHpiNWSYr9PruU=;
 b=IehdnJ3Hg7yqWMldHBcjllv0GsaUZ2Vxq4+w9tw8Pgdnch4VFO1YeeCnmZpmqML6bHHcIu
 VldDIw6rVsoblHMweM8CeUtW7+oJ5Y+JhaUzJ2u4Csg8VyCE1N/2zaqi2ZOjcHbZ1l5K9h
 KqEpwh/eV91+IDCAEOQYq43MmKTSlSs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-dj6H7dYsN_qYJ1DApIcJRg-1; Mon, 05 Jan 2026 14:30:22 -0500
X-MC-Unique: dj6H7dYsN_qYJ1DApIcJRg-1
X-Mimecast-MFC-AGG-ID: dj6H7dYsN_qYJ1DApIcJRg_1767641421
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b9b9e8b0812so315937a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 11:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767641421; x=1768246221; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xpwQgFcTsaNt3GIKI6kW6JxIz8iyCxHpiNWSYr9PruU=;
 b=om2tU+WIH9XFSaEqdu62aN/CCM6t20aai8MXrM//Ablii6UQgzyFKcL9QMM6k2IwKb
 mSSJrBceBjbYk8U1xC1W8h/fMvDDlimRhnfoXQ/Xo+P0Bs3BwIHvjMlUjlO5bvCT7y3j
 r0WyyfdCrzUemb9YxLyVXMQXd2SyqzHGTWkqV1XF+v4SEirb/b91b9UiRntw/3f3UhK1
 tpwbbvllUxIcPdn59NmM/3tw7jAxSmtk+YgC23eWV2npU23tOKJBFPovk1Nv4iuK+/ZH
 16RF63Ex/FFvw9KkDFPwe8H5VO7l0M9PrmTGhqbAJ18PpKjQ6iwZA0Uo3AtIgigA9ilY
 C/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767641421; x=1768246221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xpwQgFcTsaNt3GIKI6kW6JxIz8iyCxHpiNWSYr9PruU=;
 b=O3eBePHBlnSVnlHdPlhZYpikw6yh5B3G1GY6lo9pdJpb+0o5sMrUi4SnJma5CtlcfN
 SW4jcJ/rnVOFF0anGPnEffJKnfEH3iS0rDOcc06t3kfw/rHd+cHO6jG8TvPrIXcSfKLn
 2uNpGZ4SpgNNYlbR/mJBSWmo+DGi+ELjXFpYmZpIc+UDcrFkvyB/87VLuGlECiz3AALi
 RS3ER4mgLP4hJZYdptCf7nLKWV8IZ4PiqPuFmv5tnMCoP3GSCQN4WC7TKTjLF1DSSGM+
 czxYvb8hziWcU/o+uTIvJFpnxQpSSLJ8qhKObETobpADfzNLuPJ7be/cmUNM/Ss33wxZ
 QzVg==
X-Gm-Message-State: AOJu0Yyt2w7yIOJ0F9cAxVLdjQCdpDC2XC/AIuhcIvTnpZg1otgz2HlN
 1wgqVqWoha7dhptV4+BfuczGuS8xYx0kzx9aQOhk2QO111t7mo1MeKkonqAcRNvdMjEKASiWz2z
 xrbhLDpVyXt0VPGP2domawvn36tqE9Yqv78BanZ6un1O5SJ4ANn2H7z3u
X-Gm-Gg: AY/fxX7MxjnGOmEoSYtQS6Q6SADVdLCilhmoFTduBkEr9Qaunl6HItMl2QsXo/s5K2v
 Lpot/Mv6kqq3JQQKsbYyy642MLdVoa5n8eoQqlUxPupzALL6cOa+szWDu1TKrsPMsB4Qo+x7+Ex
 yYFx/kzD2zYMCFb3IG6jbod5dbJ2Zp/65G8cfYSD1GaXMJcTMhJqbWv9GtcRS+B6oUTAGzleeia
 CqWNixV5K336GEXzUR8DnGZPSgvwxnDerJQz0nXCinNpivk9ONBrHBoxqhxoJnhCly6mZ35Ujiw
 3Wpa85F3uQ/Es1GE3rlxnG8hFbWw/8yJY4FxvtuqkXmAnDekWjN3M4z6VEEwPy/ygERoT+7Nfiv
 7XXk=
X-Received: by 2002:a05:693c:2c07:b0:2ab:9b40:fc78 with SMTP id
 5a478bee46e88-2b16f9205bcmr450066eec.20.1767641420702; 
 Mon, 05 Jan 2026 11:30:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsF2mBzN5y4VOUXduDoVwCYz35Yq2K9/JNe69hzZpLhOSukHpuK8BawJRDIDZFaG0bZVlblQ==
X-Received: by 2002:a05:693c:2c07:b0:2ab:9b40:fc78 with SMTP id
 5a478bee46e88-2b16f9205bcmr450031eec.20.1767641420086; 
 Mon, 05 Jan 2026 11:30:20 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b1706a53fbsm34786eec.12.2026.01.05.11.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 11:30:19 -0800 (PST)
Date: Mon, 5 Jan 2026 14:30:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH v2 13/25] migration: Move setting of QEMUFile into
 migration_outgoing|incoming_setup
Message-ID: <aVwRR4-q0hpZKu8K@x1.local>
References: <20260105190644.14072-1-farosas@suse.de>
 <20260105190644.14072-14-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105190644.14072-14-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jan 05, 2026 at 04:06:30PM -0300, Fabiano Rosas wrote:
> Centralize, on both sides of migration, the setting of the to_src_file
> and from_dst_file QEMUFiles. This will clean up the interface with
> channel.c and rdma.c, allowing those files to stop dealing with
> QEMUFile themselves.
> 
> (multifd_recv_new_channel was changed to return bool+errp for
> convenience)
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

Some nitpicks inline.

> ---
>  migration/channel.c   |  9 +----
>  migration/migration.c | 82 ++++++++++++++++++++++++++-----------------
>  migration/migration.h |  2 ++
>  migration/multifd.c   |  8 +++--
>  migration/multifd.h   |  2 +-
>  5 files changed, 58 insertions(+), 45 deletions(-)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index 26cb7bf059..6acce7b2a2 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -14,7 +14,6 @@
>  #include "channel.h"
>  #include "tls.h"
>  #include "migration.h"
> -#include "qemu-file.h"
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "io/channel-tls.h"
> @@ -80,14 +79,8 @@ void migration_channel_connect(MigrationState *s, QIOChannel *ioc)
>          return;
>      }
>  
> -    QEMUFile *f = qemu_file_new_output(ioc);
> -
>      migration_ioc_register_yank(ioc);
> -
> -    qemu_mutex_lock(&s->qemu_file_lock);
> -    s->to_dst_file = f;
> -    qemu_mutex_unlock(&s->qemu_file_lock);
> -
> +    migration_outgoing_setup(ioc);
>      migration_connect(s);
>  }
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 1ea6125454..dc8fe80cf8 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -930,17 +930,52 @@ out:
>      migrate_incoming_unref_outgoing_state();
>  }
>  
> -/**
> - * migration_incoming_setup: Setup incoming migration
> - * @f: file for main migration channel
> - */
> -static void migration_incoming_setup(QEMUFile *f)
> +static bool migration_has_main_and_multifd_channels(void);
> +
> +bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp)

Considering how widely used is "bool+errp" pattern across QEMU (but with
different semantics), maybe we should add a comment to the retval here
saying the bool is not reflecting "whether errp will be set", but "whether
we should proceed with processing the incoming migration".

>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> +    QEMUFile *f;
>  
> -    assert(!mis->from_src_file);
> -    mis->from_src_file = f;
> -    qemu_file_set_blocking(f, false, &error_abort);
> +    if (multifd_recv_setup(errp) != 0) {
> +        return false;
> +    }
> +
> +    switch (channel) {
> +    case CH_MAIN:
> +        f = qemu_file_new_input(ioc);
> +        assert(!mis->from_src_file);
> +        mis->from_src_file = f;
> +        qemu_file_set_blocking(f, false, &error_abort);
> +        break;
> +
> +    case CH_MULTIFD:
> +        if (!multifd_recv_new_channel(ioc, errp)) {
> +            return false;
> +        }
> +        break;
> +
> +    case CH_POSTCOPY:
> +        assert(!mis->postcopy_qemufile_dst);
> +        f = qemu_file_new_input(ioc);
> +        postcopy_preempt_new_channel(mis, f);
> +        return false;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return migration_has_main_and_multifd_channels();
> +}
> +
> +void migration_outgoing_setup(QIOChannel *ioc)
> +{
> +    MigrationState *s = migrate_get_current();
> +    QEMUFile *f = qemu_file_new_output(ioc);
> +
> +    qemu_mutex_lock(&s->qemu_file_lock);
> +    s->to_dst_file = f;
> +    qemu_mutex_unlock(&s->qemu_file_lock);
>  }
>  
>  /* Returns true if recovered from a paused migration, otherwise false */
> @@ -988,7 +1023,11 @@ void migration_incoming_process(void)
>  
>  void migration_fd_process_incoming(QEMUFile *f)
>  {
> -    migration_incoming_setup(f);
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +
> +    assert(!mis->from_src_file);
> +    mis->from_src_file = f;
> +    qemu_file_set_blocking(f, false, &error_abort);

These are only a few lines of straightforward code, I think it's fine to
open code them here.

Said that, IMHO it's always one step back if your new patch will open-code
some function more than once, when we used to have a helper for that.

IMHO we can rename the old migration_incoming_setup() to
migration_incoming_setup_main(), and use it in both places.

>      migration_incoming_process();
>  }
>  
> @@ -1011,8 +1050,6 @@ static bool migration_has_main_and_multifd_channels(void)
>  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> -    Error *local_err = NULL;
> -    QEMUFile *f;
>      uint8_t channel;
>      uint32_t channel_magic = 0;
>      int ret = 0;
> @@ -1066,28 +1103,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>          channel = CH_POSTCOPY;
>      }
>  
> -    if (multifd_recv_setup(errp) != 0) {
> -        return;
> -    }
> -
> -    if (channel == CH_MAIN) {
> -        f = qemu_file_new_input(ioc);
> -        migration_incoming_setup(f);
> -    } else if (channel == CH_MULTIFD) {
> -        /* Multiple connections */
> -        multifd_recv_new_channel(ioc, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -    } else if (channel == CH_POSTCOPY) {
> -        assert(!mis->postcopy_qemufile_dst);
> -        f = qemu_file_new_input(ioc);
> -        postcopy_preempt_new_channel(mis, f);
> -        return;
> -    }
> -
> -    if (migration_has_main_and_multifd_channels()) {
> +    if (migration_incoming_setup(ioc, channel, errp)) {
>          migration_incoming_process();
>      }
>  }
> diff --git a/migration/migration.h b/migration/migration.h
> index d134881eaf..4dcf299719 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -530,6 +530,8 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>  void migration_fd_process_incoming(QEMUFile *f);
>  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>  void migration_incoming_process(void);
> +bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
> +void migration_outgoing_setup(QIOChannel *ioc);
>  
>  bool  migration_has_all_channels(void);
>  
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 3fb1a07ba9..4980ed4f04 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1521,7 +1521,7 @@ bool multifd_recv_all_channels_created(void)
>   * Try to receive all multifd channels to get ready for the migration.
>   * Sets @errp when failing to receive the current channel.
>   */
> -void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>  {
>      MultiFDRecvParams *p;
>      Error *local_err = NULL;
> @@ -1536,7 +1536,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>                                      "failed to receive packet"
>                                      " via multifd channel %d: ",
>                                      qatomic_read(&multifd_recv_state->count));
> -            return;
> +            return false;
>          }
>          trace_multifd_recv_new_channel(id);
>      } else {
> @@ -1549,7 +1549,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>                     id);
>          multifd_recv_terminate_threads(error_copy(local_err));
>          error_propagate(errp, local_err);
> -        return;
> +        return false;
>      }
>      p->c = ioc;
>      object_ref(OBJECT(ioc));
> @@ -1558,4 +1558,6 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>      qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
>                         QEMU_THREAD_JOINABLE);
>      qatomic_inc(&multifd_recv_state->count);
> +
> +    return true;
>  }
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 9b6d81e7ed..89a395aef2 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -42,7 +42,7 @@ int multifd_recv_setup(Error **errp);
>  void multifd_recv_cleanup(void);
>  void multifd_recv_shutdown(void);
>  bool multifd_recv_all_channels_created(void);
> -void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>  void multifd_recv_sync_main(void);
>  int multifd_send_sync_main(MultiFDSyncReq req);
>  bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
> -- 
> 2.51.0
> 

-- 
Peter Xu


