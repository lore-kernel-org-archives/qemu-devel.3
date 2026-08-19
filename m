Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566BDC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwh3b-00058F-2q; Wed, 19 Aug 2026 10:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wwh3Y-00057i-VW
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:14:16 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wwh3W-0007Gb-Tq
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=7a1zJ/gViV7O/RbG9B/Zb76FCoEremqcfOYuhPqslCg=; b=bMJY4qoaxna07EDN
 JJZFDzQU64SvpJrXIPFCbix78VQgwXBekocyLE9XjHOX6dUNz2gJHjSpR9GzxfjohKc7zH1PwXFP7
 NnFIRXGqyMwqAkCnpOPuMNEPgiUninaLFmHE/SFHASvcvSVGvCxfJ/V7K7IsTwlA2WQIFSQBPBcU+
 AiK+mVS8bWvpzDkJ+7vk3yDVlwB9ZT82K3njnqE+TRWznwdgkAADkKVNHIg1XBo1S3Ya6o+kt528O
 yq55LTEyyAZtBbXY2hZ+0Hc3y39N847N4z+IwIrApKXyoH+EZO2d9RXl94boXFZpMSUCad+rmdMUP
 5foC0qw4NLhs6oKEGw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wwh3S-000000039vj-09Pt;
 Wed, 19 Aug 2026 14:14:10 +0000
Date: Wed, 19 Aug 2026 14:14:09 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 40/49] qapi: make HMP-specific schema entries
 conditional on CONFIG_HMP
Message-ID: <aoW6Mc6j8XaOoF8p@gallifrey>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-40-e53fc35bc550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816-qemu-no-hmp-v3-40-e53fc35bc550@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.101+deb13-amd64 (x86_64)
X-Uptime: 14:14:06 up 12 days, 17:51,  3 users,  load average: 0.06, 0.03, 0.00
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
> Make the 'readline' value of MonitorMode and the
> 'human-monitor-command' command conditional on CONFIG_HMP, so
> they are only available when HMP support is compiled in.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  monitor/monitor.c  | 8 +++++++-
>  monitor/qmp-cmds.c | 2 ++
>  qapi/control.json  | 4 +++-
>  qapi/misc.json     | 3 ++-
>  4 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index da76e6e4ac19..da0c8eda86b0 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -740,13 +740,18 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
>      ERRP_GUARD();
>  
>      if (!opts->has_mode) {
> -        opts->mode = allow_hmp ? MONITOR_MODE_READLINE : MONITOR_MODE_CONTROL;
> +        opts->mode =
> +#ifdef CONFIG_HMP
> +            allow_hmp ? MONITOR_MODE_READLINE :
> +#endif
> +            MONITOR_MODE_CONTROL;
>      }
>  
>      switch (opts->mode) {
>      case MONITOR_MODE_CONTROL:
>          monitor_new_qmp(opts->id, opts->chardev, opts->pretty, errp);
>          break;
> +#ifdef CONFIG_HMP
>      case MONITOR_MODE_READLINE:
>          if (!allow_hmp) {
>              error_setg(errp, "Only QMP is supported");
> @@ -758,6 +763,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
>          }
>          monitor_new_hmp(opts->id, opts->chardev, true, errp);
>          break;
> +#endif /* CONFIG_HMP */
>      default:
>          g_assert_not_reached();
>      }
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index b16119f4858c..c9f24febdc96 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -162,6 +162,7 @@ void qmp_add_client(const char *protocol, const char *fdname,
>      }
>  }
>  
> +#ifdef CONFIG_HMP
>  char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>                                  int64_t cpu_index, Error **errp)
>  {
> @@ -187,6 +188,7 @@ out:
>      object_unref(hmp);
>      return output;
>  }
> +#endif /* CONFIG_HMP */
>  
>  static void __attribute__((__constructor__)) monitor_init_qmp_commands(void)
>  {
> diff --git a/qapi/control.json b/qapi/control.json
> index 9a5302193d67..9898552814b1 100644
> --- a/qapi/control.json
> +++ b/qapi/control.json
> @@ -186,7 +186,9 @@
>  #
>  # Since: 5.0
>  ##
> -{ 'enum': 'MonitorMode', 'data': [ 'readline', 'control' ] }
> +{ 'enum': 'MonitorMode', 'data': [
> +    { 'name': 'readline', 'if': 'CONFIG_HMP' },
> +    'control' ] }
>  
>  ##
>  # @MonitorOptions:
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 22b7afed9f65..a21ba61b96e0 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -247,7 +247,8 @@
>  { 'command': 'human-monitor-command',
>    'data': {'command-line': 'str', '*cpu-index': 'int'},
>    'returns': 'str',
> -  'features': [ 'savevm-monitor-nodes' ] }
> +  'features': [ 'savevm-monitor-nodes' ],
> +  'if': 'CONFIG_HMP' }
>  
>  ##
>  # @getfd:
> 
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

