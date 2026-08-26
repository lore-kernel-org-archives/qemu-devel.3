Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5975FC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz9XJ-0004Il-0D; Wed, 26 Aug 2026 05:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wz9XH-0004IQ-Hb
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 05:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wz9XF-0003Yl-BL
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 05:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787734984;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xb2XQadLBDPYajmv6CCZMG8uCPgKq5ev0fghG5tNFQ4=;
 b=eLI9q9wOkUpsHflbvx/YNmLldG/1YvFmI1bMrtHIVmFfgpTaTLR1NWlN+gct4MpGcQaREd
 GIiY6T1tzsOXO33GCRc9CO3X+NL2dgQK0uHyjhphXn1PzI0kCA1Sk3zLJ+VxfhtMyQ+rK3
 lOjJJ+2rRxAPT2srlzdK6+r7KB66lN0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-2t80OlqCMsWbDKhAxePXgg-1; Wed,
 26 Aug 2026 05:02:59 -0400
X-MC-Unique: 2t80OlqCMsWbDKhAxePXgg-1
X-Mimecast-MFC-AGG-ID: 2t80OlqCMsWbDKhAxePXgg_1787734978
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 375DB19373DE; Wed, 26 Aug 2026 09:02:58 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 347B418005BC; Wed, 26 Aug 2026 09:02:55 +0000 (UTC)
Date: Wed, 26 Aug 2026 10:02:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 39/49] qapi: make HMP-specific schema entries
 conditional on CONFIG_HMP
Message-ID: <ao6rvUMqwEGdW_v3@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-39-af60857c2fbe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260825-qemu-no-hmp-v4-39-af60857c2fbe@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Aug 25, 2026 at 11:09:46PM +0400, Marc-André Lureau wrote:
> Make the 'readline' value of MonitorMode and the
> 'human-monitor-command' command conditional on CONFIG_HMP, so
> they are only available when HMP support is compiled in.
> 
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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

This introduces a public facing semantic change.

Currently

  qemu-system-x86_64 -chardev stdio,id=foo  -mon chardev=foo

will always result in an HMP monitor.

With the new code, this may result in either an HMP or a QMP
monitor, depending on whether QEMU was built with CONFIG_HMP
set or not. This is bad semantics as HMP/QMP are completely
different things to talk to and not transparently replaceable
with each other.

IMHO  it needs to be:

   if (!opts->has_mode) {
#ifdef CONFIG_HMP
     if (allow_hmp) {
        error_setg(errp, "HMP support is not built in this QEMU");
	return -1;
     }
     opts->mode = MONITOR_MODE_CONTROL;
#else
     opts->mode = allow_hmp ? MONITOR_MODE_READLINE : MONITOR_MODE_CONTROL;
#endif
  }


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

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


