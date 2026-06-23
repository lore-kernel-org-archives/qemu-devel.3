Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABC7CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0C6-0005kg-Q3; Tue, 23 Jun 2026 08:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wc0Bz-0005iC-MJ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:25:28 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wc0Bt-00015i-Cm
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=1zJ9bzEMFScGDnCFr8lmkLgTxe5AyGDFqPeHrpNFntw=; b=CDiv0zJp2GJCVEnB
 Uo7wdYeHoHDbjcYjzl+570blg4wQXKWsI2W+JjQNNBNlXtMfgW+acafW+pIAwWUXrFYVnZGniSHwQ
 nXPaCqeyedDfbXCi3YkTUomC3RWygh5e1H1cn4KVlWXur28Ly1gOE3rvhfbWn+g5rHRlboMB47QFE
 BjLXPQ0ogbPh0uoyxIgW0bKdeKxd6Je30gJHAQjkCE+2r+g9/ddMNqE99pigYJ0BjERP3enR8RK1s
 wBKgL/3p1mtIpV38uWFj+lYxeWcfeScSk4XCNrlUTn9LoYydSTg1a0La81coDnAGEBi4wiYlK/eB/
 mxdvYDRUt37AF4GiFQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wc0BV-00000009SDW-0UKM;
 Tue, 23 Jun 2026 12:24:57 +0000
Date: Tue, 23 Jun 2026 12:24:57 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com
Subject: Re: [PATCH 1/1] migration/cpr: Add HMP support for cpr-transfer
Message-ID: <ajp7GduDZGjei3Gz@gallifrey>
References: <20260621072646.517545-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260621072646.517545-1-dongli.zhang@oracle.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.88+deb13-amd64 (x86_64)
X-Uptime: 12:20:56 up 38 days, 15:33,  2 users,  load average: 0.01, 0.02, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
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

* Dongli Zhang (dongli.zhang@oracle.com) wrote:
> Currently the cpr-transfer source QEMU instance cannot be driven entirely
> via HMP.  The source must use QMP in order to specify both the
> main migration channel and the CPR channel.
> 
> Extend the HMP migrate command with an optional CPR channel URI. When the
> migration mode is cpr-transfer, HMP uses this URI to build a
> CPR MigrationChannel in addition to the main migration channel. The new
> argument is rejected unless the migration mode is cpr-transfer, so existing
> HMP migrate usage is unchanged.
> 
> For example, source QEMU HMP commands can be something like below. The
> "unix:/tmp/cpr.sock" is for CPR URI.
> 
> (qemu) migrate_set_parameter mode cpr-transfer
> (qemu) migrate tcp:0:50002 unix:/tmp/cpr.sock
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Yeh this looks OK to me; I don't see a check for if you do:
(qemu) migrate_set_parameter mode cpr-transfer
(qemu) migrate tcp:0:50002

Does that get caught by the qmp_migrate or should you add a check here?

I do have a slight preference for using flag optional parameters rather 
than positional, e.g.

   migrate -c unix:/tmp/cpr.sock tcp:0:50002

but I wouldn't insist on it.

Dave


> ---
>  hmp-commands.hx                | 11 +++++++----
>  migration/migration-hmp-cmds.c | 18 ++++++++++++++++++
>  2 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 7ae2468a3d..021e51b142 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -928,16 +928,17 @@ ERST
>  
>      {
>          .name       = "migrate",
> -        .args_type  = "detach:-d,resume:-r,uri:s",
> -        .params     = "[-d] [-r] uri",
> +        .args_type  = "detach:-d,resume:-r,uri:s,uri-cpr:s?",
> +        .params     = "[-d] [-r] uri [uri-cpr]",
>          .help       = "migrate to URI (using -d to not wait for completion)"
> -		      "\n\t\t\t -r to resume a paused postcopy migration",
> +		      "\n\t\t\t -r to resume a paused postcopy migration"
> +		      "\n\t\t\t uri-cpr specifies CPR URI for cpr-transfer mode",
>          .cmd        = hmp_migrate,
>      },
>  
>  
>  SRST
> -``migrate [-d] [-r]`` *uri*
> +``migrate [-d] [-r]`` *uri* [*uri-cpr*]
>    Migrate the VM to *uri*.
>  
>    ``-d``
> @@ -945,6 +946,8 @@ SRST
>      query an ongoing migration process, use "info migrate".
>    ``-r``
>      Resume a paused postcopy migration.
> +  ``uri-cpr``
> +    Specify CPR URI for cpr-transfer mode. It must be a UNIX domain socket.
>  ERST
>  
>      {
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 8b385f560e..42ca652bb3 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -836,9 +836,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      bool detach = qdict_get_try_bool(qdict, "detach", false);
>      bool resume = qdict_get_try_bool(qdict, "resume", false);
>      const char *uri = qdict_get_str(qdict, "uri");
> +    const char *uri_cpr = qdict_get_try_str(qdict, "uri-cpr");
>      Error *err = NULL;
>      g_autoptr(MigrationChannelList) caps = NULL;
>      g_autoptr(MigrationChannel) channel = NULL;
> +    g_autoptr(MigrationChannel) channel_cpr = NULL;
>  
>      if (!migrate_uri_parse(uri, &channel, &err)) {
>          hmp_handle_error(mon, err);
> @@ -846,6 +848,22 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      }
>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>  
> +    if (uri_cpr) {
> +        if (migrate_mode() != MIG_MODE_CPR_TRANSFER) {
> +            error_setg(&err, "uri-cpr requires cpr-transfer mode");
> +            hmp_handle_error(mon, err);
> +            return;
> +        }
> +
> +        if (!migrate_uri_parse(uri_cpr, &channel_cpr, &err)) {
> +            hmp_handle_error(mon, err);
> +            return;
> +        }
> +
> +        channel_cpr->channel_type = MIGRATION_CHANNEL_TYPE_CPR;
> +        QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel_cpr));
> +    }
> +
>      qmp_migrate(NULL, true, caps, true, resume, &err);
>      if (hmp_handle_error(mon, err)) {
>          return;
> -- 
> 2.43.7
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

