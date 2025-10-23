Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C80CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 17:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBzKq-0003Tj-Ct; Thu, 23 Oct 2025 13:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vBzKi-0003Rt-2M
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:42:40 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vBzKd-0002FJ-GV
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 13:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=oC8hkvYyImfq4Eft018IVOQxvhaHKHtRVdycPWI4NoY=; b=EqR9eUhOOQKvtPz6
 T8KkID1MT0F/sDqLJNerfLV516695tjLrn+5oKg0QVpk0RklulEbr0TgJhqxAm0CjK+XMYzOQqicr
 17NX+7teq+pbs+uhkD5Clk4WFe4q/+G0sIafc/ss1i4JqP8AAdfSyKGFQ1fBb4y2VKMxi90SK82ve
 CrS8GcJ7NI2udS6+CeXSkk+FN0UWIPYGUZYfFI0Ug6sFNXV7rRo9V3HgOMcMLwEXetzyOcdUzOZ3x
 OajzqwKroONMU1j2kErmvabkbdDjKYoU27cMsyD9OkPXbdf+Zhfm31OI+S69scY1A5ONoocVPKRuy
 NbQZNqo0KJyP7dKaHg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1vBzKV-000mYF-2c;
 Thu, 23 Oct 2025 17:42:27 +0000
Date: Thu, 23 Oct 2025 17:42:27 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration/cpr: Document obscure usage of g_autofree when
 parse str
Message-ID: <aPppA7F1WamLCFdP@gallifrey>
References: <20251023161657.2821652-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20251023161657.2821652-1-peterx@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 17:36:45 up 179 days,  1:50,  2 users,  load average: 0.03, 0.01,
 0.00
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
> HMP parsing of cpr_exec_command contains an obscure usage of g_autofree.
> Provide a document for it to be clear that it's intentional, rather than
> memory leaked.
> 
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration-hmp-cmds.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 847d18faaa..79426bf5d7 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -734,6 +734,12 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          visit_type_bool(v, param, &p->direct_io, &err);
>          break;
>      case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
> +        /*
> +         * NOTE: g_autofree will only auto g_free() the strv array when
> +         * needed, it will not free the strings within the array. It's
> +         * intentional: when strv is set, the ownership of the strings will
> +         * always be passed to p->cpr_exec_command via QAPI_LIST_APPEND().
> +         */

Eww that's a bit weird isn't it.
It's not clear to me if g_shell_parse_argv() might return an error part
way through its parsing, and if it does whether there may be valid entries in
strv which really do need freeing.

https://docs.gtk.org/glib/func.shell_parse_argv.html doesn't seem to say.

Dave

>          g_autofree char **strv = NULL;
>          g_autoptr(GError) gerr = NULL;
>          strList **tail = &p->cpr_exec_command;
> -- 
> 2.50.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

