Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF495CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 20:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC1bG-0001RU-SE; Thu, 23 Oct 2025 16:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vC1bF-0001RC-Fu
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 16:07:53 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vC1bC-0004ah-Se
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 16:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=8S80enR75LdSBAbpK81XbzaOX3GzYoVznLBk+slIISI=; b=kD6TH1kodpYKX134
 AhmEiPrNdqhFhRcSsXpREdqOgZDoTASjiwCkY6S+7b6jnrkEsX1Uq6+EScYZoBmjsideeS5pO2W+S
 y4Yf/zLGIQZE6ASyZ0Ixq7ZnPZuzKh6cqV+C6AHBjOOWwVkJp5dmOL5Mjpuf6uSB1SLOVluEu9hJq
 sXt+YVpbcVAx4dh3oXJfPfNypZtJ/iPRc/nhJXt5phjH8UaI0cd4M/5bt68O+3Gcq3qfAZPfroP1M
 ExZxP5adWEA0yRY54xjVZCtqUzOfw3aBX2ppqj9MCdvIJBLdcWakyK3pZwe33ZvEGaE7066AgOCVK
 1fnfvgT+qhZtMHeEbQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1vC1bA-000oXG-0q;
 Thu, 23 Oct 2025 20:07:48 +0000
Date: Thu, 23 Oct 2025 20:07:48 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration/cpr: Document obscure usage of g_autofree when
 parse str
Message-ID: <aPqLFI2vXGY0mzDb@gallifrey>
References: <20251023161657.2821652-1-peterx@redhat.com>
 <aPppA7F1WamLCFdP@gallifrey> <aPp1IwqiGpBUToWg@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aPp1IwqiGpBUToWg@x1.local>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 20:06:51 up 179 days,  4:20,  2 users,  load average: 0.01, 0.03,
 0.01
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
> On Thu, Oct 23, 2025 at 05:42:27PM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > HMP parsing of cpr_exec_command contains an obscure usage of g_autofree.
> > > Provide a document for it to be clear that it's intentional, rather than
> > > memory leaked.
> > > 
> > > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  migration/migration-hmp-cmds.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> > > index 847d18faaa..79426bf5d7 100644
> > > --- a/migration/migration-hmp-cmds.c
> > > +++ b/migration/migration-hmp-cmds.c
> > > @@ -734,6 +734,12 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
> > >          visit_type_bool(v, param, &p->direct_io, &err);
> > >          break;
> > >      case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
> > > +        /*
> > > +         * NOTE: g_autofree will only auto g_free() the strv array when
> > > +         * needed, it will not free the strings within the array. It's
> > > +         * intentional: when strv is set, the ownership of the strings will
> > > +         * always be passed to p->cpr_exec_command via QAPI_LIST_APPEND().
> > > +         */
> > 
> > Eww that's a bit weird isn't it.
> > It's not clear to me if g_shell_parse_argv() might return an error part
> > way through its parsing, and if it does whether there may be valid entries in
> > strv which really do need freeing.
> > 
> > https://docs.gtk.org/glib/func.shell_parse_argv.html doesn't seem to say.
> 
> I checked glib code, it should be fine, the code looks like this since 2000:
> 
> gboolean
> g_shell_parse_argv (const gchar *command_line,
>                     gint        *argcp,
>                     gchar     ***argvp,
>                     GError     **error)
> {
>   ...
>  failed:
> 
>   g_assert (error == NULL || *error != NULL);
>   g_strfreev (argv);                            <-------------
>   g_slist_free_full (tokens, g_free);
>   
>   return FALSE;
> }

OK, thanks for checking.

> The hope is with the comment, the current way is still the most efficient,
> avoiding strdup()s.

Yeh, it's at least better with the comment!

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>


> Still, let me know if any of us still prefer changing the code instead of
> adding the comment..  The perf isn't a major issue, afaiu.  But it's still
> good to consider that always, I believe that was when Steve developed this.
> 
> Thanks!

Thanks for adding it.

Dave

> -- 
> Peter Xu
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

