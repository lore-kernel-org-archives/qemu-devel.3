Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71476F45A12
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 22:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBKna-000643-ET; Fri, 10 Apr 2026 18:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wBKnZ-00063j-CC; Fri, 10 Apr 2026 18:58:01 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wBKnX-0001CR-74; Fri, 10 Apr 2026 18:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=THuLOX2PCskfL3cYNUmso7wv62RwWCISNYR590+ueIY=; b=OM9Nu7QES5lWU4kR
 5pCRBcNmRgRuG/snYQZDONr8zhLHni+GqmYsHtjHL/KDUKpSAmB6EAw15hny5DQWGgj2yxjzqgnr0
 qBL3OIVU1CqAVB2uDeGtKNRmvl4l5HKkxoYt9ouu0n5XswUKCn58kJQR5r53kFpQRU17DkOFLs981
 dIBIM7ht9/4bCzPSRgQJNlZv3t6I9+RPrLMoE3UxmpyuhUpExday6rA982kdYOu1HGbQUgA2pHdto
 SomJYaqc8JvkNLCehUnKMihVyzp0igehiNyTJ+LUAQK4ogKnZpWqpO57tzXVe7RmZ3YQWeRkRnymg
 QdWTEKHdQqUuTSSHkg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wBKnS-00000007ZYZ-1nhP;
 Fri, 10 Apr 2026 22:57:54 +0000
Date: Fri, 10 Apr 2026 22:57:54 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 03/17] monitor: rename monitor_init* to monitor_new*
Message-ID: <admAcuqIMrtQ80l4@gallifrey>
References: <20260410160458.3778874-1-berrange@redhat.com>
 <20260410160458.3778874-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410160458.3778874-4-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 22:57:47 up 29 days, 11 min,  2 users,  load average: 0.04, 0.02,
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> The current "monitor_init" functions will clash with the methods of the
> same name that are required by QOM. To ease the transition to QOM,
> rename them out of the way.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  chardev/char.c                       |  2 +-
>  gdbstub/system.c                     |  2 +-
>  include/monitor/monitor.h            |  8 ++++----
>  monitor/hmp.c                        |  2 +-
>  monitor/monitor.c                    | 10 +++++-----
>  monitor/qmp.c                        |  2 +-
>  storage-daemon/qemu-storage-daemon.c |  2 +-
>  stubs/monitor-internal.c             |  2 +-
>  system/vl.c                          |  2 +-
>  9 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/chardev/char.c b/chardev/char.c
> index 48b326d57b..b59972f325 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -786,7 +786,7 @@ static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
>  
>      if (qemu_opt_get_bool(opts, "mux", 0)) {
>          assert(permit_mux_mon);
> -        monitor_init_hmp(chr, true, &err);
> +        monitor_new_hmp(chr, true, &err);
>          if (err) {
>              error_report_err(err);
>              object_unparent(OBJECT(chr));
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index e86c5870ab..20dcf7878d 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -388,7 +388,7 @@ bool gdbserver_start(const char *device, Error **errp)
>          /* Initialize a monitor terminal for gdb */
>          mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
>                                     NULL, NULL, &error_abort);
> -        monitor_init_hmp(mon_chr, false, &error_abort);
> +        monitor_new_hmp(mon_chr, false, &error_abort);
>      } else {
>          qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
>          mon_chr = gdbserver_system_state.mon_chr;
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 296690e1f1..bfbb440550 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -19,10 +19,10 @@ bool monitor_cur_is_qmp(void);
>  
>  void monitor_init_globals(void);
>  void monitor_init_globals_core(void);
> -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
> -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
> -int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
> -int monitor_init_opts(QemuOpts *opts, Error **errp);
> +void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp);
> +void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp);
> +int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp);
> +int monitor_new_opts(QemuOpts *opts, Error **errp);
>  void monitor_cleanup(void);
>  
>  int monitor_suspend(Monitor *mon);
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index af346d190b..6dfeca84b5 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1516,7 +1516,7 @@ static void monitor_readline_flush(void *opaque)
>      monitor_flush(&mon->parent);
>  }
>  
> -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
> +void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
>  {
>      MonitorHMP *mon = g_new0(MonitorHMP, 1);
>  
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 6b183edcf5..393fb7795e 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -715,7 +715,7 @@ void monitor_init_globals(void)
>      aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
>  }
>  
> -int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
> +int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
>  {
>      ERRP_GUARD();
>      Chardev *chr;
> @@ -732,7 +732,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
>  
>      switch (opts->mode) {
>      case MONITOR_MODE_CONTROL:
> -        monitor_init_qmp(chr, opts->pretty, errp);
> +        monitor_new_qmp(chr, opts->pretty, errp);
>          break;
>      case MONITOR_MODE_READLINE:
>          if (!allow_hmp) {
> @@ -743,7 +743,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
>              error_setg(errp, "'pretty' is not compatible with HMP monitors");
>              return -1;
>          }
> -        monitor_init_hmp(chr, true, errp);
> +        monitor_new_hmp(chr, true, errp);
>          break;
>      default:
>          g_assert_not_reached();
> @@ -752,7 +752,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
>      return *errp ? -1 : 0;
>  }
>  
> -int monitor_init_opts(QemuOpts *opts, Error **errp)
> +int monitor_new_opts(QemuOpts *opts, Error **errp)
>  {
>      Visitor *v;
>      MonitorOptions *options;
> @@ -765,7 +765,7 @@ int monitor_init_opts(QemuOpts *opts, Error **errp)
>          return -1;
>      }
>  
> -    ret = monitor_init(options, true, errp);
> +    ret = monitor_new(options, true, errp);
>      qapi_free_MonitorOptions(options);
>      return ret;
>  }
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 69d9e40e32..9caee70624 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -513,7 +513,7 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
>      monitor_list_append(&mon->parent);
>  }
>  
> -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
> +void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
>  {
>      MonitorQMP *mon = g_new0(MonitorQMP, 1);
>  
> diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
> index eb72561358..50dbfbd97a 100644
> --- a/storage-daemon/qemu-storage-daemon.c
> +++ b/storage-daemon/qemu-storage-daemon.c
> @@ -330,7 +330,7 @@ static void process_options(int argc, char *argv[], bool pre_init_pass)
>                  visit_free(v);
>  
>                  /* TODO Catch duplicate monitor IDs */
> -                monitor_init(monitor, false, &error_fatal);
> +                monitor_new(monitor, false, &error_fatal);
>                  qapi_free_MonitorOptions(monitor);
>                  break;
>              }
> diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
> index 4fece49d53..23d58da184 100644
> --- a/stubs/monitor-internal.c
> +++ b/stubs/monitor-internal.c
> @@ -8,6 +8,6 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
>      return -1;
>  }
>  
> -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
> +void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
>  {
>  }
> diff --git a/system/vl.c b/system/vl.c
> index 246623b319..2391811a46 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1244,7 +1244,7 @@ static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
>  
>  static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
>  {
> -    return monitor_init_opts(opts, errp);
> +    return monitor_new_opts(opts, errp);
>  }
>  
>  static void monitor_parse(const char *str, const char *mode, bool pretty)
> -- 
> 2.53.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

