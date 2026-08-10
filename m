Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B96C5B567
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtUqr-0004pg-La; Mon, 10 Aug 2026 14:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtUqq-0004p1-HD
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtUqo-0006vz-Qf
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786386954;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uU8sgKMWnp5/IqFKepqK9nPFjZblsbOXrL29Hy8Q/8=;
 b=Aw/9ZQ5SVbjeCI5vWlnXtyhRCwEj5ZEFBxqegaY67It73MUEmKttxwYaokhdZ/sk9F5BtW
 zjGEiJyKe1lusAmlvuePCgL264zwneXBrCm+9u0WjFote9p+KKq0sj9/SQE3WYd9q5lhjL
 S0i5hK2NQ+uhgz0C8lHmYCR+RlqNS0A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-ybszHSZ5NnGCr6n69oP4Mg-1; Mon,
 10 Aug 2026 14:35:41 -0400
X-MC-Unique: ybszHSZ5NnGCr6n69oP4Mg-1
X-Mimecast-MFC-AGG-ID: ybszHSZ5NnGCr6n69oP4Mg_1786386940
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04B3C18002F8; Mon, 10 Aug 2026 18:35:40 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98AB8195DF91; Mon, 10 Aug 2026 18:35:38 +0000 (UTC)
Date: Mon, 10 Aug 2026 19:35:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 32/39] qapi: make HMP-specific schema entries
 conditional on CONFIG_HMP
Message-ID: <anoZ9pFUeBjnrSvG@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-32-8af31bc54c61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626-qemu-no-hmp-v2-32-8af31bc54c61@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 26, 2026 at 01:19:33AM +0400, Marc-André Lureau wrote:
> Make the 'readline' value of MonitorMode and the
> 'human-monitor-command' command conditional on CONFIG_HMP, so
> they are only available when HMP support is compiled in.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/control.json  | 4 +++-
>  qapi/misc.json     | 3 ++-
>  monitor/monitor.c  | 8 +++++++-
>  monitor/qmp-cmds.c | 2 ++
>  4 files changed, 14 insertions(+), 3 deletions(-)

this will need a bunch of conflict resolution with the QOM
work I'm afraid.

> 
> diff --git a/qapi/control.json b/qapi/control.json
> index 9a5302193d6..9898552814b 100644
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
> index 22b7afed9f6..a21ba61b96e 100644
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
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index f443f406b4c..50f1fe77c33 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -733,13 +733,18 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
>      }
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
>          monitor_init_qmp(chr, opts->pretty, errp);
>          break;
> +#ifdef CONFIG_HMP
>      case MONITOR_MODE_READLINE:
>          if (!allow_hmp) {
>              error_setg(errp, "Only QMP is supported");
> @@ -751,6 +756,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
>          }
>          monitor_init_hmp(chr, true, errp);
>          break;
> +#endif /* CONFIG_HMP */
>      default:
>          g_assert_not_reached();
>      }
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index 0c409c27dc3..5e642a2b14d 100644
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
> @@ -189,6 +190,7 @@ out:
>      monitor_data_destroy(&hmp.common);
>      return output;
>  }
> +#endif /* CONFIG_HMP */
>  
>  static void __attribute__((__constructor__)) monitor_init_qmp_commands(void)
>  {
> 
> -- 
> 2.54.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


