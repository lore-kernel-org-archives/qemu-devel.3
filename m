Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ED6C5AD4E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtMOE-0005fn-VL; Mon, 10 Aug 2026 05:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtMOE-0005fY-06
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 05:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtMOC-0005XW-7o
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 05:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786354426;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Z7VMx061mhUsryagvO51V9xRWQ6gHlRUDYLfqo0yWyc=;
 b=NmvynfVWo4pNu45Iijy+YdqYbj+HoQL3BMjlyTwgTXjoR4zTPtIExCNa5SrdrkEKznJHWW
 PBFXZ50CCKvuVipPU1tIu2ydqZ4DZFD6p6kbsN7uNEqqYYXsp+TSh9/RqEEFwrYSXwns7O
 jmXqy4HCQ/cf1wgMrS0en6fSceyoFY0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-Omxq9pLcM9ShqYqs1pd7uw-1; Mon,
 10 Aug 2026 05:33:43 -0400
X-MC-Unique: Omxq9pLcM9ShqYqs1pd7uw-1
X-Mimecast-MFC-AGG-ID: Omxq9pLcM9ShqYqs1pd7uw_1786354422
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAF19195608B; Mon, 10 Aug 2026 09:33:41 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8825B1800346; Mon, 10 Aug 2026 09:33:40 +0000 (UTC)
Date: Mon, 10 Aug 2026 10:33:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Dreibholz <dreibh@simula.no>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH] Fix for
 https://gitlab.com/qemu-project/qemu/-/work_items/4141:
Message-ID: <anma8SUZlGZinwtB@redhat.com>
References: <20260808-solaris-qga-fix-b4-v1-1-80eafc48246c@simula.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260808-solaris-qga-fix-b4-v1-1-80eafc48246c@simula.no>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.827,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Please use a $SUBJECT that describes what you're fixing

  "Fix shutdown command path not found on Solaris"

On Sat, Aug 08, 2026 at 12:34:06PM +0200, Thomas Dreibholz wrote:
> Using the correct paths for "shutdown", "reboot", etc. under Solaris.
> 
> Signed-off-by: Thomas Dreibholz <dreibh@simula.no>
> ---
> This patch fixes the issue of the not-working shutdown command
> in the QEMU Guest Agent under Solaris
> (https://gitlab.com/qemu-project/qemu/-/work_items/4141) by
> fixing the command paths from /sbin/ to /usr/sbin/ in the
> Solaris build.
> ---
>  qga/commands-posix.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 837be51c40..e24248a0f3 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -216,9 +216,17 @@ out:
>      return retcode;
>  }
>  
> +#ifdef CONFIG_SOLARIS
> +#define POWEROFF_CMD_PATH "/usr/sbin/poweroff"
> +#define SHUTDOWN_CMD_PATH "/usr/sbin/shutdown"
> +#define HALT_CMD_PATH     "/usr/sbin/halt"
> +#define REBOOT_CMD_PATH   "/usr/sbin/reboot"
> +#else
>  #define POWEROFF_CMD_PATH "/sbin/poweroff"
> -#define HALT_CMD_PATH "/sbin/halt"
> -#define REBOOT_CMD_PATH "/sbin/reboot"
> +#define SHUTDOWN_CMD_PATH "/sbin/shutdown"
> +#define HALT_CMD_PATH     "/sbin/halt"
> +#define REBOOT_CMD_PATH   "/sbin/reboot"
> +#endif

I wonder why we need to use a qualified path at all. We're passing these
to ga_run_command and that uses execvp, which searches $PATH.

qga runs as root and can be expected to have these in $PATH.

>  
>  void qmp_guest_shutdown(const char *mode, Error **errp)
>  {
> @@ -262,7 +270,7 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
>          return;
>      }
>  
> -    const char *argv[] = {"/sbin/shutdown",
> +    const char *argv[] = {SHUTDOWN_CMD_PATH,
>  #ifdef CONFIG_SOLARIS
>                            shutdown_flag, "-g0", "-y",
>  #elif defined(CONFIG_BSD)
> @@ -274,7 +282,7 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
>  
>      /*
>       * If the specific command exists (poweroff, halt or reboot), use it instead
> -     * of /sbin/shutdown.
> +     * of SHUTDOWN_CMD_PATH.
>       */
>      if (shutdown_cmd != NULL) {
>          argv[0] = shutdown_cmd;

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


