Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD3BCEB2CB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 23:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svQ3Z-0005UX-5E; Mon, 30 Sep 2024 19:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1svQ3X-0005Tr-L0
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 19:43:55 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1svQ3V-0004GR-Pv
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 19:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=jWo/dR7adezQ/5IXl4pivfZLyHDhSU527PnDHNzkopA=; b=jySSk/BgEM1yC981
 OqM3gWPqMnCNXU0NEYtV1G/AcMJ+ZHPn/OLxGJYo9a71oYUjOer26wyaPTyiTFoHlzBpkLfEk3P28
 4oimd/qYSgWKfoFHEeTTaZda00rA1cmEiXBWp9RaSnDI+dEY5XwGjxgUugkMF/DZuzF3vGcKlctuW
 RH5Jth1yhymPRtZdHZGgOF/4ASMRIt+KPx83KpFGdPuFWINmV0f2zExDF6LyLuxejEPK/5et1eLnR
 hmBxrE9yGYzcZoN51lDS8G55k1devejzpqrE65cPvwyPSStZ06IRrYsg2qkhmkT7HavXM3/GsGPw1
 ohZ0ewHuZyUi4eoz8Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1svQ3R-0086V1-30;
 Mon, 30 Sep 2024 23:43:49 +0000
Date: Mon, 30 Sep 2024 23:43:49 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 7/7] hmp: Add "info migrationthreads"
Message-ID: <Zvs3tb80cXdlSmZW@gallifrey>
References: <20240930195837.825728-1-peterx@redhat.com>
 <20240930195837.825728-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240930195837.825728-8-peterx@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 23:39:00 up 145 days, 10:53,  1 user,  load average: 0.08, 0.03, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Peter Xu (peterx@redhat.com) wrote:
> The QMP command was added in 671326201d ("migration: Introduce interface
> query-migrationthreads", v8.0).  Add the HMP version of it.
> 
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/monitor/hmp.h          |  1 +
>  migration/migration-hmp-cmds.c | 25 +++++++++++++++++++++++++
>  hmp-commands-info.hx           | 13 +++++++++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index ae116d9804..e44a399e4a 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -31,6 +31,7 @@ void hmp_info_mice(Monitor *mon, const QDict *qdict);
>  void hmp_info_migrate(Monitor *mon, const QDict *qdict);
>  void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict);
>  void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict);
> +void hmp_info_migrationthreads(Monitor *mon, const QDict *qdict);
>  void hmp_info_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vnc(Monitor *mon, const QDict *qdict);
>  void hmp_info_spice(Monitor *mon, const QDict *qdict);
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 20d1a6e219..63a6ea61f2 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -814,3 +814,28 @@ void loadvm_completion(ReadLineState *rs, int nb_args, const char *str)
>          vm_completion(rs, str);
>      }
>  }
> +
> +void hmp_info_migrationthreads(Monitor *mon, const QDict *qdict)
> +{
> +    MigrationThreadInfoList *list;
> +    MigrationThreadInfo *entry;
> +    Error *err = NULL;
> +
> +    list = qmp_query_migrationthreads(&err);
> +

I think you need to do the hmp_handle_error here rather than at
the end, and return if there was one.

Other than that it looks OK.

Dave

> +    if (!list) {
> +        monitor_printf(mon, "No migration threads found\n");
> +        return;
> +    }
> +
> +    monitor_printf(mon, "%-16s%s\n", "TID", "Thread Name");
> +    while (list) {
> +        entry = list->value;
> +        monitor_printf(mon, "%-16" PRId64 "%s\n",
> +                       entry->thread_id, entry->name);
> +        list = list->next;
> +    }
> +
> +    qapi_free_MigrationThreadInfoList(list);
> +    hmp_handle_error(mon, err);
> +}
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index c59cd6637b..a8dc55dbd2 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -512,6 +512,19 @@ SRST
>      Show current migration parameters.
>  ERST
>  
> +    {
> +        .name       = "migrationthreads",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show migration threads information",
> +        .cmd        = hmp_info_migrationthreads,
> +    },
> +
> +SRST
> +  ``info migrationthreads``
> +    Show migration threads information.
> +ERST
> +
>      {
>          .name       = "balloon",
>          .args_type  = "",
> -- 
> 2.45.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

