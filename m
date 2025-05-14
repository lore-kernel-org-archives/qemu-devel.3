Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FBCC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFC6r-00052G-38; Wed, 14 May 2025 09:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uFC6h-0004s4-DC
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:25:16 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uFC6e-0005Zo-1D
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=BRr8R1+RZBSSWOY8fB0CcmwDTVNO/WKd20ALx8dqPWQ=; b=Wq6cY1fXwn2B8yo4
 z+SE5wpKi6JNkb3bwdKDCIfjoa+3al5lokg4JO+Xz0P/Ek8yLHoLIDFhhww8yJ3BZO+VNvGtvKkEo
 GlcR+1GMla3tKyENSiIInIs/rIR3Dsooq7Ou+ZD+3bRMRwLdSADbQ7fuAU/ngZUgsC1RFK4LrsUGZ
 ahvycRTPzHncdWA64ZtTMrMYnQ9JSaj4zuRbsROnqH8aIDt3ZDa4VCMPz5I/WjA390QWQAIOzHcwr
 GYdPEWvgTA0qU8mf4Yv0R7o56UVLa0GdcskzZ+j+rFkNqhBPpT4BSYNGCd9V8ZixT7qdOemPY+bjz
 Xt+JWhE/e0cJ47pEVA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uFC6b-003WGn-21;
 Wed, 14 May 2025 13:25:05 +0000
Date: Wed, 14 May 2025 13:25:05 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 2/3] migration/hmp: Dump global in "info
 migrate_parameters" instead
Message-ID: <aCSZsXvHy0u_5LaP@gallifrey>
References: <20250513220923.518025-1-peterx@redhat.com>
 <20250513220923.518025-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250513220923.518025-3-peterx@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 13:18:34 up 16 days, 21:32, 1 user, load average: 0.00, 0.00, 0.00
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
> "info migrate" is the command people would frequently use to query
> migration status.  We may not want it to dump global configurations because
> dumping the same things over and over won't help.
> 
> The globals are just more suitable for a parameter dump instead.  Hence
> move it over.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

I think this is a *little* odd, since 'info migrate_parameters'
is a list of the things you can set with 'migrate_set_parameters'
Perhaps it would be better to add it under the 'info migrate -a' option
you add in the next patch?

However, one other thing, the globals stuff prints a
'globals:'  at the start,  but doesn't print anything at the end,
so if you make this change, you end up with out being able to tell
where the globals end and the parameters start, so maybe a
'parameters:' after it?

Dave

> ---
>  migration/migration-hmp-cmds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 49c26daed3..0034dbe47f 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -58,8 +58,6 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>  
>      info = qmp_query_migrate(NULL);
>  
> -    migration_global_dump(mon);
> -
>      if (info->blocked_reasons) {
>          strList *reasons = info->blocked_reasons;
>          monitor_printf(mon, "Outgoing migration blocked:\n");
> @@ -235,6 +233,8 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>  {
>      MigrationParameters *params;
>  
> +    migration_global_dump(mon);
> +
>      params = qmp_query_migrate_parameters(NULL);
>  
>      if (params) {
> -- 
> 2.49.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

