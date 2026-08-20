Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F42C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3kJ-0002mk-1o; Thu, 20 Aug 2026 10:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wx3k6-0002Ub-L2
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:27:44 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wx3k1-000296-61
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=O3ZYip28Dq4t3UPO3m3REwut7M1szCPoI8C3wpDIdPM=; b=nyWHc7fFqEDJOzjw
 tSlRPZswUhAMffDljJHcc31FM649bqxT8ru+1aJrvDI5rE7xfeZRpcqoTam2Am6I6igdK+39x7jIG
 d+DF7N0711/2r+A4GSnm07NKRL1rFDVrgpDEqom4Y1Q4w9DRWiK3clvnGCRW73fntrdVQckY7j3RH
 5HIlizHd1CPXqHsqsZCUJtIaC6V1feYL+N/QkpS167jea7DLnZqfNPaU13OQSY5+OiHFfulmLm2KQ
 lFP8q9lnw8amSPf+Juhuefv852nnxBRx4Kk9M00rVre5o6Yxvn88KZpSGSTePK3KlqWINrVK8KV2b
 ZWF21hM3sADiLxw6ig==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wx3jw-00000003Pmf-1V7m;
 Thu, 20 Aug 2026 14:27:32 +0000
Date: Thu, 20 Aug 2026 14:27:32 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 48/49] monitor: move HMP-specific to
 monitor-hmp-internal.h
Message-ID: <aocO1HDcO7hSGyLD@gallifrey>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-48-e53fc35bc550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816-qemu-no-hmp-v3-48-e53fc35bc550@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.101+deb13-amd64 (x86_64)
X-Uptime: 14:27:08 up 13 days, 18:04,  2 users,  load average: 0.00, 0.00, 0.00
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

* Marc-André Lureau (marcandre.lureau@redhat.com) wrote:
> Move HMP-specific declarations to its own CONFIG_HMP guarded header.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

(I think that supported types table moves every time I try and remember one
of the more obscure characters)

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  include/monitor/hmp.h          |   8 +++-
>  migration/migration-hmp-cmds.c |   1 +
>  monitor/hmp-cmds.c             |   1 +
>  monitor/hmp.c                  |   1 +
>  monitor/monitor-hmp-internal.h | 106 +++++++++++++++++++++++++++++++++++++++++
>  monitor/monitor-internal.h     |  99 --------------------------------------
>  monitor/monitor.c              |   1 +
>  monitor/qmp-cmds.c             |   1 +
>  stubs/monitor-core.c           |   2 +
>  stubs/monitor-internal.c       |   2 +
>  tests/unit/test-util-sockets.c |   2 -
>  tools/qemu-vnc/stubs.c         |   6 ---
>  12 files changed, 121 insertions(+), 109 deletions(-)
> 
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index f10bf83df86d..ef53e87f7608 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -21,6 +21,10 @@
>  #define TYPE_MONITOR_HMP "monitor-hmp"
>  OBJECT_DECLARE_TYPE(MonitorHMP, MonitorHMPClass, MONITOR_HMP);
>  
> +MonitorHMP *monitor_cur_hmp(void);
> +
> +#ifdef CONFIG_HMP
> +
>  #define HMP_STUB(cmd) \
>      void hmp_##cmd(MonitorHMP *hmp, const QDict *qdict) \
>      { \
> @@ -36,8 +40,6 @@ struct MonitorDef {
>  void monitor_new_hmp(const char *id, const char *chardev_id,
>                       bool use_readline, Error **errp);
>  
> -MonitorHMP *monitor_cur_hmp(void);
> -
>  int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
>      G_GNUC_PRINTF(2, 0);
>  int monitor_hmp_printf(MonitorHMP *mon, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
> @@ -218,4 +220,6 @@ void hmp_info_skeys(MonitorHMP *hmp, const QDict *qdict);
>  void hmp_info_cmma(MonitorHMP *hmp, const QDict *qdict);
>  void hmp_migrationmode(MonitorHMP *hmp, const QDict *qdict);
>  
> +#endif /* CONFIG_HMP */
> +
>  #endif
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 6fe189471899..27b38d0e5f85 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -21,6 +21,7 @@
>  #include "monitor/hmp-completion.h"
>  #include "monitor/monitor.h"
>  #include "monitor/monitor-internal.h"
> +#include "monitor/monitor-hmp-internal.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/qapi-visit-migration.h"
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 3ac70c3f1123..91701ddf331b 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -25,6 +25,7 @@
>  #include "monitor/hmp.h"
>  #include "monitor/hmp-completion.h"
>  #include "monitor/monitor-internal.h"
> +#include "monitor/monitor-hmp-internal.h"
>  #include "monitor/qdev.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-control.h"
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index e3fc05f521a8..488ec23937df 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -27,6 +27,7 @@
>  #include "hw/core/qdev.h"
>  #include "hw/core/sysemu-cpu-ops.h"
>  #include "monitor-internal.h"
> +#include "monitor-hmp-internal.h"
>  #include "monitor/hmp.h"
>  #include "qobject/qdict.h"
>  #include "qobject/qnum.h"
> diff --git a/monitor/monitor-hmp-internal.h b/monitor/monitor-hmp-internal.h
> new file mode 100644
> index 000000000000..4e2430551abf
> --- /dev/null
> +++ b/monitor/monitor-hmp-internal.h
> @@ -0,0 +1,106 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef MONITOR_HMP_INTERNAL_H
> +#define MONITOR_HMP_INTERNAL_H
> +
> +#ifdef CONFIG_HMP
> +#include "monitor/hmp.h"
> +/*
> + * Supported types:
> + *
> + * 'F'          filename
> + * 'B'          block device name
> + * 's'          string (accept optional quote)
> + * 'S'          it just appends the rest of the string (accept optional quote)
> + * 'O'          option string of the form NAME=VALUE,...
> + *              parsed according to QemuOptsList given by its name
> + *              Example: 'device:O' uses qemu_device_opts.
> + *              Restriction: only lists with empty desc are supported
> + *              TODO lift the restriction
> + * 'i'          32 bit integer
> + * 'l'          target long (32 or 64 bit)
> + * 'M'          Non-negative target long (32 or 64 bit), in user mode the
> + *              value is multiplied by 2^20 (think Mebibyte)
> + * 'o'          octets (aka bytes)
> + *              user mode accepts an optional E, e, P, p, T, t, G, g, M, m,
> + *              K, k suffix, which multiplies the value by 2^60 for suffixes E
> + *              and e, 2^50 for suffixes P and p, 2^40 for suffixes T and t,
> + *              2^30 for suffixes G and g, 2^20 for M and m, 2^10 for K and k
> + * 'T'          double
> + *              user mode accepts an optional ms, us, ns suffix,
> + *              which divides the value by 1e3, 1e6, 1e9, respectively
> + * '/'          optional gdb-like print format (like "/10x")
> + *
> + * '?'          optional type (for all types, except '/')
> + * '.'          other form of optional type (for 'i' and 'l')
> + * 'b'          boolean
> + *              user mode accepts "on" or "off"
> + * '-'          optional parameter (eg. '-f'); if followed by a 's', it
> + *              specifies an optional string param (e.g. '-fs' allows '-f foo')
> + *
> + */
> +
> +typedef struct HMPCommand {
> +    const char *name;
> +    const char *args_type;
> +    const char *params;
> +    const char *help;
> +    const char *flags; /* p=preconfig */
> +    void (*cmd)(MonitorHMP *hmp, const QDict *qdict);
> +    /*
> +     * If implementing a command that takes no arguments and simply
> +     * prints formatted data, then leave @cmd NULL, and then set
> +     * @cmd_info_hrt to the corresponding QMP handler that returns
> +     * the formatted text.
> +     */
> +    HumanReadableText *(*cmd_info_hrt)(Error **errp);
> +    /*
> +     * @sub_table is a list of 2nd level of commands. If it does not exist,
> +     * cmd should be used. If it exists, sub_table[?].cmd should be
> +     * used, and cmd of 1st level plays the role of help function.
> +     */
> +    struct HMPCommand *sub_table;
> +    void (*command_completion)(ReadLineState *rs, int nb_args, const char *str);
> +
> +    /* Keep non-pointer data at the end to minimize holes. */
> +
> +    /**
> +     * @arch_bitmask: bitmask of QEMU_ARCH_* constants
> +     *     Allow to restrict the command for a particular set of
> +     *     target architectures.
> +     */
> +    uint32_t arch_bitmask;
> +    bool coroutine;
> +} HMPCommand;
> +
> +struct MonitorHMPClass {
> +    MonitorClass parent_class;
> +};
> +
> +struct MonitorHMP {
> +    Monitor parent_obj;
> +    bool use_readline;
> +    /*
> +     * State used only in the thread "owning" the monitor.
> +     * This is currently always the main thread, since
> +     * HMP does not allow use of the I/O thread at this time.
> +     * These members can be safely accessed without locks.
> +     */
> +    ReadLineState *rs;
> +    char *mon_cpu_path;
> +    int reset_seen;
> +};
> +
> +int monitor_hmp_set_cpu(MonitorHMP *hmp, int cpu_index);
> +void handle_hmp_command(MonitorHMP *hmp, const char *cmdline);
> +int hmp_compare_cmd(const char *name, const char *list);
> +
> +/*
> + * hmp_cmds_for_target: Return array of HMPCommand entries
> + *
> + * If @info_command is true, return the particular 'info foo' commands array.
> + */
> +HMPCommand *hmp_cmds_for_target(bool info_command);
> +
> +#endif /* CONFIG_HMP */
> +#endif
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index c198c12eaa00..822a66d06d00 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -27,7 +27,6 @@
>  
>  #include "chardev/char-fe.h"
>  #include "monitor/monitor.h"
> -#include "monitor/hmp.h"
>  #include "qapi/qapi-emit-events.h"
>  #include "qapi/qapi-types-control.h"
>  #include "qapi/qapi-types-qom.h"
> @@ -36,75 +35,6 @@
>  #include "qemu/readline.h"
>  #include "system/iothread.h"
>  
> -/*
> - * Supported types:
> - *
> - * 'F'          filename
> - * 'B'          block device name
> - * 's'          string (accept optional quote)
> - * 'S'          it just appends the rest of the string (accept optional quote)
> - * 'O'          option string of the form NAME=VALUE,...
> - *              parsed according to QemuOptsList given by its name
> - *              Example: 'device:O' uses qemu_device_opts.
> - *              Restriction: only lists with empty desc are supported
> - *              TODO lift the restriction
> - * 'i'          32 bit integer
> - * 'l'          target long (32 or 64 bit)
> - * 'M'          Non-negative target long (32 or 64 bit), in user mode the
> - *              value is multiplied by 2^20 (think Mebibyte)
> - * 'o'          octets (aka bytes)
> - *              user mode accepts an optional E, e, P, p, T, t, G, g, M, m,
> - *              K, k suffix, which multiplies the value by 2^60 for suffixes E
> - *              and e, 2^50 for suffixes P and p, 2^40 for suffixes T and t,
> - *              2^30 for suffixes G and g, 2^20 for M and m, 2^10 for K and k
> - * 'T'          double
> - *              user mode accepts an optional ms, us, ns suffix,
> - *              which divides the value by 1e3, 1e6, 1e9, respectively
> - * '/'          optional gdb-like print format (like "/10x")
> - *
> - * '?'          optional type (for all types, except '/')
> - * '.'          other form of optional type (for 'i' and 'l')
> - * 'b'          boolean
> - *              user mode accepts "on" or "off"
> - * '-'          optional parameter (eg. '-f'); if followed by a 's', it
> - *              specifies an optional string param (e.g. '-fs' allows '-f foo')
> - *
> - */
> -
> -typedef struct HMPCommand {
> -    const char *name;
> -    const char *args_type;
> -    const char *params;
> -    const char *help;
> -    const char *flags; /* p=preconfig */
> -    void (*cmd)(MonitorHMP *mon, const QDict *qdict);
> -    /*
> -     * If implementing a command that takes no arguments and simply
> -     * prints formatted data, then leave @cmd NULL, and then set
> -     * @cmd_info_hrt to the corresponding QMP handler that returns
> -     * the formatted text.
> -     */
> -    HumanReadableText *(*cmd_info_hrt)(Error **errp);
> -    /*
> -     * @sub_table is a list of 2nd level of commands. If it does not exist,
> -     * cmd should be used. If it exists, sub_table[?].cmd should be
> -     * used, and cmd of 1st level plays the role of help function.
> -     */
> -    struct HMPCommand *sub_table;
> -    void (*command_completion)(ReadLineState *rs, int nb_args, const char *str);
> -
> -    /* Keep non-pointer data at the end to minimize holes. */
> -
> -    /**
> -     * @arch_bitmask: bitmask of QEMU_ARCH_* constants
> -     *     Allow to restrict the command for a particular set of
> -     *     target architectures.
> -     */
> -    uint32_t arch_bitmask;
> -    bool coroutine;
> -} HMPCommand;
> -
> -
>  struct MonitorClass {
>      ObjectClass parent_class;
>  
> @@ -149,24 +79,6 @@ struct Monitor {
>      int mux_out;
>  };
>  
> -struct MonitorHMPClass {
> -    MonitorClass parent_class;
> -};
> -
> -struct MonitorHMP {
> -    Monitor parent_obj;
> -    bool use_readline;
> -    /*
> -     * State used only in the thread "owning" the monitor.
> -     * This is currently always the main thread, since
> -     * HMP does not allow use of the I/O thread at this time.
> -     * These members can be safely accessed without locks.
> -     */
> -    ReadLineState *rs;
> -    char *mon_cpu_path;
> -    int reset_seen;
> -};
> -
>  struct MonitorQMPClass {
>      MonitorClass parent_class;
>  };
> @@ -209,21 +121,10 @@ int monitor_can_read(void *opaque);
>  void monitor_cancel_out_watch(Monitor *mon);
>  void monitor_list_append(Monitor *mon);
>  void monitor_fdsets_cleanup(void);
> -int monitor_hmp_set_cpu(MonitorHMP *mon, int cpu_index);
>  
>  void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
>  void monitor_data_destroy_qmp(MonitorQMP *mon);
>  void coroutine_fn monitor_qmp_dispatcher_co(void *data);
>  void qmp_dispatcher_co_wake(void);
>  
> -void handle_hmp_command(MonitorHMP *hmp, const char *cmdline);
> -int hmp_compare_cmd(const char *name, const char *list);
> -
> -/*
> - * hmp_cmds_for_target: Return array of HMPCommand entries
> - *
> - * If @info_command is true, return the particular 'info foo' commands array.
> - */
> -HMPCommand *hmp_cmds_for_target(bool info_command);
> -
>  #endif
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 7979cd1cbcfd..6ba06280e023 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -24,6 +24,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "monitor-internal.h"
> +#include "monitor-hmp-internal.h"
>  #include "qapi/error.h"
>  #include "qapi/opts-visitor.h"
>  #include "qapi/qapi-emit-events.h"
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index c9f24febdc96..7525a88e0494 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -16,6 +16,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/sockets.h"
>  #include "monitor-internal.h"
> +#include "monitor-hmp-internal.h"
>  #include "monitor/qdev.h"
>  #include "monitor/qmp-helpers.h"
>  #include "system/system.h"
> diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> index 0e74d78d52e4..8dfd46d2a8a3 100644
> --- a/stubs/monitor-core.c
> +++ b/stubs/monitor-core.c
> @@ -1,6 +1,7 @@
>  #include "qemu/osdep.h"
>  #include "monitor/hmp.h"
>  
> +#ifdef CONFIG_HMP
>  int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
>  {
>      /*
> @@ -17,3 +18,4 @@ int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
>      }
>      return -1;
>  }
> +#endif
> diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
> index 6f69f1f14ae4..4483ca25557f 100644
> --- a/stubs/monitor-internal.c
> +++ b/stubs/monitor-internal.c
> @@ -8,8 +8,10 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
>      return -1;
>  }
>  
> +#ifdef CONFIG_HMP
>  void monitor_new_hmp(const char *id, const char *chardev_id,
>                       bool use_readline, Error **errp)
>  {
>      g_assert_not_reached();
>  }
> +#endif
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
> index 530a3fee3c13..006f5e579c6b 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -24,7 +24,6 @@
>  #include "qapi/error.h"
>  #include "socket-helpers.h"
>  #include "monitor/monitor.h"
> -#include "monitor/hmp.h"
>  
>  static void test_fd_is_socket_bad(void)
>  {
> @@ -75,7 +74,6 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>   */
>  Monitor *monitor_cur(void) { return cur_mon; }
>  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
> -int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap) { abort(); }
>  
>  #ifndef _WIN32
>  static void test_socket_fd_pass_name_good(void)
> diff --git a/tools/qemu-vnc/stubs.c b/tools/qemu-vnc/stubs.c
> index 0aa50a901d37..1e4c14913b56 100644
> --- a/tools/qemu-vnc/stubs.c
> +++ b/tools/qemu-vnc/stubs.c
> @@ -9,7 +9,6 @@
>  #include "system/runstate.h"
>  #include "hw/core/qdev.h"
>  #include "monitor/monitor.h"
> -#include "monitor/hmp.h"
>  #include "migration/vmstate.h"
>  
>  bool runstate_is_running(void)
> @@ -42,11 +41,6 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
>      return NULL;
>  }
>  
> -int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
> -{
> -    return -1;
> -}
> -
>  /*
>   * Link-time stubs for VMState symbols referenced by VNC code.
>   * The standalone binary never performs migration, so these are
> 
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

