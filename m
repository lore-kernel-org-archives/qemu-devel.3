Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11174C79FBA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcqPB-0002xg-JN; Mon, 05 Jan 2026 14:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcqOu-0002x2-00
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:38:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcqOq-0002gW-B4
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767641874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MJPHFKoDR9tRYOU2QHaE7Hd/hBSyzoDUSq9VQxCG9CA=;
 b=diCoG/gsvoT8xLmk4u0mJopJ33YKHq3NbUlki3TuQQjPk80vXa1c2X4Rn3tLQuW4zSjMBB
 srCo4eOAmzII/ffNalGMoDshQUuuYGOkYOQDIDmhO9eF//7hO6QRFZqyE2RZY0CTGinaC5
 9aVp7RAVbqDMzbXApEvaddppPK7CTbM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-YKTqtRpnOBer6ZPl-kDPeA-1; Mon, 05 Jan 2026 14:37:53 -0500
X-MC-Unique: YKTqtRpnOBer6ZPl-kDPeA-1
X-Mimecast-MFC-AGG-ID: YKTqtRpnOBer6ZPl-kDPeA_1767641873
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b6097ca315bso283756a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 11:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767641872; x=1768246672; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MJPHFKoDR9tRYOU2QHaE7Hd/hBSyzoDUSq9VQxCG9CA=;
 b=JyJHvN/jcvLf69oB5R+A9HwCTXpGoGbjcchUTqJbAfoq7nXHI3aAcoERbdwqSnaOPS
 Me8OtSXEqRW1P5U8qtmR/DCs6F1C/1HNM8Wvj3PnSyxpljsk2Qok6+zhH+Ca1TZocy4P
 Q6GYUg5SV7gIDsm1S+l78mDLMW098kHxsh0p+IpdiPV/5sOUmCWqdBUIkH1M+1FJbkPY
 jZ9vWwXWDCk9sGHmNqp/7OuePWhMyOwnOPbFzPkCsCNvh1tPiY98pw2PDYyIbYMlqnI4
 xrOmoYcMUko88HPyMxRCQhGejYMPxss9dGIXobKNyZXEIjswug41AhRVUcTvfpjyCwXF
 umGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767641872; x=1768246672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJPHFKoDR9tRYOU2QHaE7Hd/hBSyzoDUSq9VQxCG9CA=;
 b=Y5frxXWoLAfbmWPMg1H9nzWOZ0srwNkb53D/ngRtKmbsBnBxySUKV33rJDtXPJhQ+q
 xdIZbIMKn+5QpkBlXP2s2CqMeJYnTJw9wMxjWPVZ9KM7NQlUt42s0dfJHBSueDnniHzY
 L9KVtMREMsJqyhjSaNCy1TIEbB3+PFeQSBqWac7zhQfzWrF+lUwDzGvZMW11ABTNe5jr
 VnRZSd+dkQUQphMco0lK/dzJp1rEd7yIHWgaYk3u0ZFQlp7wu2r1DDOKh9HaspekwDge
 aajzw+dQdfYWM303wjZljaz8i3q3u2fj7APcjiJMm+oHMP/QLQJsxV3u3q/owWi7veOP
 ZtaQ==
X-Gm-Message-State: AOJu0YzJzg38DQ1jFqWYPpn1pyFuwf6nuJDutPGMIOivt+y7XOYfdUTs
 us/FqXKuoCa2yrYngaT4vuYntDcnOIqaW3EkugKXK30WYSuUjvaPzV7sFaX+dvTuLROEhT5yWWI
 bw7rWDaVblFgELVUm2DitwJpTj/tL+gbLmnwzFhuWfg2bKPk6jhfyE8VdsSNsgsfZ
X-Gm-Gg: AY/fxX40hn4ljBWct8qhLmjLObW2doYzdCdWVKxM/tgl/hA1n3RrTEmoFuqdmL3vtF3
 HfR7NIRJAqhLVTg8NkJ8J0HESaTe5R9wC35v4rB9frL5zeg8RNJK2c8Zw+0ddIVasKNiMMKKSwK
 gaU57Yj6j1Ihw8G5AtkJ6rdGnZ7FmmEhe9GQFyPBig8KgYm5ZxdNdL9S11BoB8tpl2XXd9z2Fki
 wVK1IzrURtsRUrXJxcNUkjPCNu5HrzHhycrJQs94ikG/0ugYY2wG/8OR9Q2iHWn0/zEEMo/lggp
 ggTkuubCbTabYKJZEJZ5cRTamU3SfDn4J2mYQoP6qwuIMkIPGKR9jzfZYfwh9oHgojPvofBQxBv
 /qpg=
X-Received: by 2002:a05:7300:b0aa:b0:2a4:3594:72e3 with SMTP id
 5a478bee46e88-2b16f880b9amr228158eec.18.1767641872275; 
 Mon, 05 Jan 2026 11:37:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKKSwvsKbFR19EWFfGo+A80wuv2xImzqVHW7YnHzXQjWLyxatRrxCh9tKs4nnGZXbiwbzRoQ==
X-Received: by 2002:a05:7300:b0aa:b0:2a4:3594:72e3 with SMTP id
 5a478bee46e88-2b16f880b9amr228140eec.18.1767641871702; 
 Mon, 05 Jan 2026 11:37:51 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b17078dd8fsm34424eec.20.2026.01.05.11.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 11:37:51 -0800 (PST)
Date: Mon, 5 Jan 2026 14:37:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v2 14/25] migration/rdma: Use common connection paths
Message-ID: <aVwTCieTljUaG9el@x1.local>
References: <20260105190644.14072-1-farosas@suse.de>
 <20260105190644.14072-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105190644.14072-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Jan 05, 2026 at 04:06:31PM -0300, Fabiano Rosas wrote:
> Use the common connection paths for the incoming and outgoing sides of
> rdma migration. This removes one usage of QEMUFile from rdma.c. It
> also allows further unification of the connection code in next
> patches.
> 
> Move the channels enum to channel.h so rdma.c can access it. The RDMA
> channel is considered a CH_MAIN channel.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick inline.

> ---
>  migration/channel.h   |  7 +++++++
>  migration/migration.c | 13 -------------
>  migration/migration.h |  1 -
>  migration/rdma.c      | 23 +++++++++++------------
>  4 files changed, 18 insertions(+), 26 deletions(-)
> 
> diff --git a/migration/channel.h b/migration/channel.h
> index ccfeaaef18..93dedbf52b 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -18,6 +18,13 @@
>  
>  #include "io/channel.h"
>  
> +/* Migration channel types */
> +enum {
> +    CH_MAIN,
> +    CH_MULTIFD,
> +    CH_POSTCOPY
> +};
> +
>  void migration_channel_process_incoming(QIOChannel *ioc);
>  
>  void migration_channel_connect(MigrationState *s, QIOChannel *ioc);
> diff --git a/migration/migration.c b/migration/migration.c
> index dc8fe80cf8..906f0bdab3 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -91,9 +91,6 @@ enum mig_rp_message_type {
>      MIG_RP_MSG_MAX
>  };
>  
> -/* Migration channel types */
> -enum { CH_MAIN, CH_MULTIFD, CH_POSTCOPY };
> -
>  /* When we add fault tolerance, we could have several
>     migrations at once.  For now we don't need to add
>     dynamic creation of migration */
> @@ -1021,16 +1018,6 @@ void migration_incoming_process(void)
>      qemu_coroutine_enter(co);
>  }
>  
> -void migration_fd_process_incoming(QEMUFile *f)
> -{
> -    MigrationIncomingState *mis = migration_incoming_get_current();
> -
> -    assert(!mis->from_src_file);
> -    mis->from_src_file = f;
> -    qemu_file_set_blocking(f, false, &error_abort);
> -    migration_incoming_process();

This is removed very soon here..  That's OK.

> -}
> -
>  static bool migration_has_main_and_multifd_channels(void)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> diff --git a/migration/migration.h b/migration/migration.h
> index 4dcf299719..cd6cfd62ba 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -527,7 +527,6 @@ struct MigrationState {
>  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>                         MigrationStatus new_state);
>  
> -void migration_fd_process_incoming(QEMUFile *f);
>  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>  void migration_incoming_process(void);
>  bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 596a1aba0b..788ae183c1 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -15,6 +15,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "channel.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "exec/target_page.h"
> @@ -384,7 +385,6 @@ struct QIOChannelRDMA {
>      QIOChannel parent;
>      RDMAContext *rdmain;
>      RDMAContext *rdmaout;
> -    QEMUFile *file;
>      bool blocking; /* XXX we don't actually honour this yet */
>  };
>  
> @@ -3836,32 +3836,30 @@ static void qio_channel_rdma_register_types(void)
>  
>  type_init(qio_channel_rdma_register_types);
>  
> -static QEMUFile *rdma_new_input(RDMAContext *rdma)
> +static QIOChannel *rdma_new_input(RDMAContext *rdma)
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
>  
> -    rioc->file = qemu_file_new_input(QIO_CHANNEL(rioc));
>      rioc->rdmain = rdma;
>      rioc->rdmaout = rdma->return_path;
>  
> -    return rioc->file;
> +    return QIO_CHANNEL(rioc);
>  }
>  
> -static QEMUFile *rdma_new_output(RDMAContext *rdma)
> +static QIOChannel *rdma_new_output(RDMAContext *rdma)
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
>  
> -    rioc->file = qemu_file_new_output(QIO_CHANNEL(rioc));
>      rioc->rdmaout = rdma;
>      rioc->rdmain = rdma->return_path;
>  
> -    return rioc->file;
> +    return QIO_CHANNEL(rioc);
>  }
>  
>  static void rdma_accept_incoming_migration(void *opaque)
>  {
>      RDMAContext *rdma = opaque;
> -    QEMUFile *f;
> +    QIOChannel *ioc;
>  
>      trace_qemu_rdma_accept_incoming_migration();
>      if (qemu_rdma_accept(rdma) < 0) {
> @@ -3875,15 +3873,16 @@ static void rdma_accept_incoming_migration(void *opaque)
>          return;
>      }
>  
> -    f = rdma_new_input(rdma);
> -    if (f == NULL) {
> +    ioc = rdma_new_input(rdma);
> +    if (ioc == NULL) {
>          error_report("RDMA ERROR: could not open RDMA for input");
>          qemu_rdma_cleanup(rdma);
>          return;
>      }
>  
>      rdma->migration_started_on_destination = 1;
> -    migration_fd_process_incoming(f);
> +    migration_incoming_setup(ioc, CH_MAIN, NULL);

Maybe error_abort?

> +    migration_incoming_process();
>  }
>  
>  void rdma_start_incoming_migration(InetSocketAddress *host_port,
> @@ -3995,8 +3994,8 @@ void rdma_start_outgoing_migration(void *opaque,
>  
>      trace_rdma_start_outgoing_migration_after_rdma_connect();
>  
> -    s->to_dst_file = rdma_new_output(rdma);
>      s->rdma_migration = true;
> +    migration_outgoing_setup(rdma_new_output(rdma));
>      migration_connect(s);
>      return;
>  return_path_err:
> -- 
> 2.51.0
> 

-- 
Peter Xu


