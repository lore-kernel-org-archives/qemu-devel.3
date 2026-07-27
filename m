Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD2EC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 00:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo9UQ-0002Uq-Vl; Sun, 26 Jul 2026 20:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wo9UO-0002UZ-MQ
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 20:46:40 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wo9UM-0000Xt-M3
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 20:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=iZFp50d39USgUw/vwUZnvD5cW6bvMbEMKwlxHh26fII=; b=nFNX+0eS5MIhbRaP
 HI45XSLr0e5aPbaOrJV8fyKiAgQA/s8raRpbyWCDz6D1B08JWandLURZxFwSvyzNQ0TfIp8MYcWq6
 bOW5wAz4SXLtKjMhgdjr9JHUxjPKbOoUrI4c+8koNvLTWY9LxjGZq0O76YxAt+Ga/PSmM9TIO77nR
 4GuaZ6dvTtwVWsfHOiyabuYmBhDyF+0Bt2+g7gdHAXwWpF32q4FS0TUNwKLOQpKMemZ6jBisTQO6D
 9T5vsi0Xdf2zSDckzGCHdeY5qy27786r92R1P94IBB7CKjmlq+oAWY0NDW+JpHHBKPSr3RAyfMrQf
 eRskG4npHkon4DFUhA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wo9UH-00000005dCu-0Umu;
 Mon, 27 Jul 2026 00:46:33 +0000
Date: Mon, 27 Jul 2026 00:46:33 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com
Subject: Re: [PATCH v2 1/1] migration/cpr: Add HMP support for cpr-transfer
Message-ID: <amaqaePN2wAWoUCN@gallifrey>
References: <20260724094119.90581-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260724094119.90581-1-dongli.zhang@oracle.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.95+deb13-amd64 (x86_64)
X-Uptime: 00:44:49 up 21 days, 26 min,  2 users,  load average: 0.00, 0.00,
 0.00
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
> option is rejected unless the migration mode is cpr-transfer, so existing
> HMP migrate usage is unchanged.
> 
> For example, source QEMU HMP commands can be something like below. The
> "-c unix:/tmp/cpr.sock" is for CPR URI.
> 
> (qemu) migrate_set_parameter mode cpr-transfer
> (qemu) migrate -c unix:/tmp/cpr.sock tcp:0:50002
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> v1->v2:
>   - Use the '-c' option in the HMP command reference.
>   - Use "a second uri can only be used in cpr-transfer mode" as error
>     message.

Thanks for making those changes; minor note below.

>  hmp-commands.hx                | 12 ++++++++----
>  migration/migration-hmp-cmds.c | 19 +++++++++++++++++++
>  2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 7ae2468a3d..7f43cf537f 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -928,16 +928,17 @@ ERST
>  
>      {
>          .name       = "migrate",
> -        .args_type  = "detach:-d,resume:-r,uri:s",
> -        .params     = "[-d] [-r] uri",
> +        .args_type  = "detach:-d,resume:-r,uri-cpr:-cs,uri:s",
> +        .params     = "[-d] [-r] [-c uri-cpr] uri",
>          .help       = "migrate to URI (using -d to not wait for completion)"
> -		      "\n\t\t\t -r to resume a paused postcopy migration",
> +		      "\n\t\t\t -r to resume a paused postcopy migration"
> +		      "\n\t\t\t -c to specify a CPR URI for cpr-transfer mode",
>          .cmd        = hmp_migrate,
>      },
>  
>  
>  SRST
> -``migrate [-d] [-r]`` *uri*
> +``migrate [-d] [-r] [-c uri-cpr]`` *uri*
>    Migrate the VM to *uri*.
>  
>    ``-d``
> @@ -945,6 +946,9 @@ SRST
>      query an ongoing migration process, use "info migrate".
>    ``-r``
>      Resume a paused postcopy migration.
> +  ``-c`` *uri-cpr*
> +    Specify the CPR URI for cpr-transfer mode. It must be a UNIX domain
> +    socket.
>  ERST
>  
>      {
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index b04fc4489f..4ca2c962c2 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -837,9 +837,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
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
> @@ -847,6 +849,23 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      }
>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>  
> +    if (uri_cpr) {
> +        if (migrate_mode() != MIG_MODE_CPR_TRANSFER) {
> +            error_setg(&err,
> +                       "a second uri can only be used in cpr-transfer mode");

That should probably be changed to something like
  "-c can only be used in cpr-transfer mode"

but other than that,

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
(Feel free to take it via cpr or migration).

Dave


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
> 2.43.5
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

