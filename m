Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E14F41994
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCyrf-0004RS-Dl; Wed, 15 Apr 2026 07:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCyrd-0004R1-Mw
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 07:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCyrb-0002Uv-0l
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 07:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776254217;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JSEEUePxTpXt8dpbZuxo+PHlTjz/mAzHJmKpbtcII+4=;
 b=dO2sjY27yT5HIx4/nX7Tbpe+PbiZICP87jirb56rup04Zbl4zy77613J9ZII5YYrHazI0W
 yCMtNCiMQaHmFwslbVasGenuedoaRdhUGgOkGzynLntXsU53WYq7sig1RC0km5uzvUFwdt
 SVFDMqWvDkF6Rnt21Fkt9AiWyysSRys=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-0N1K_oZZPEWxvW_VHImX9w-1; Wed,
 15 Apr 2026 07:56:53 -0400
X-MC-Unique: 0N1K_oZZPEWxvW_VHImX9w-1
X-Mimecast-MFC-AGG-ID: 0N1K_oZZPEWxvW_VHImX9w_1776254212
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3081C1802649
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 11:56:52 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4988A3000232; Wed, 15 Apr 2026 11:56:50 +0000 (UTC)
Date: Wed, 15 Apr 2026 12:56:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 49/67] ui/vnc: add vnc_cleanup()
Message-ID: <ad98_6fvkOYJwcLM@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-49-231416f76dc3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410-qemu-vnc-v2-49-231416f76dc3@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Apr 10, 2026 at 11:19:11PM +0400, Marc-André Lureau wrote:
> Add a function to tear down VNC displays, call it when leaving QEMU.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/ui/console.h |  1 +
>  system/runstate.c    |  5 +++++
>  ui/vnc.c             | 24 ++++++++++++++++++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 1794f1a2cf0..b3aaf3ff12b 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -455,6 +455,7 @@ void vnc_parse(const char *str);
>  int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp);
>  bool vnc_display_reload_certs(const char *id,  Error **errp);
>  bool vnc_display_update(DisplayUpdateOptionsVNC *arg, Error **errp);
> +void vnc_cleanup(void);
>  
>  /* input.c */
>  int index_from_key(const char *key, size_t key_length);
> diff --git a/system/runstate.c b/system/runstate.c
> index 770253b467b..0e1cb3b4e67 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -61,6 +61,8 @@
>  #include "system/confidential-guest-support.h"
>  #include "system/system.h"
>  #include "system/tpm.h"
> +#include "ui/console.h"
> +
>  #include "trace.h"
>  
>  static NotifierList exit_notifiers =
> @@ -1044,5 +1046,8 @@ void qemu_cleanup(int status)
>      monitor_cleanup();
>      qemu_chr_cleanup();
>      user_creatable_cleanup();
> +#ifdef CONFIG_VNC
> +    vnc_cleanup();
> +#endif
>      /* TODO: unref root container, check all devices are ok */
>  }
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 4d5b36a6fa8..c26b581f3ef 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -4354,6 +4354,30 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
>      return vnc_display_new(id, errp) != NULL ? 0 : -1;
>  }
>  
> +void vnc_cleanup(void)
> +{
> +    VncDisplay *vd, *vd_next;
> +    VncState *vs;
> +
> +    QTAILQ_FOREACH(vd, &vnc_displays, next) {
> +        if (vd->listener) {
> +            qio_net_listener_disconnect(vd->listener);
> +        }
> +        if (vd->wslistener) {
> +            qio_net_listener_disconnect(vd->wslistener);
> +        }
> +        QTAILQ_FOREACH(vs, &vd->clients, next) {
> +            vnc_disconnect_start(vs);
> +        }
> +    }

Upto this point, I feel like there is conceptual overlap with
what I'd expect vnc_display_close to be doing, except that its
current impl does not kill off the clients - it doesn't need
to as it is currently only called in a startup path where 
(IIUC) we can assume no clients are present.

IOW, could we have this look more like

  QTAILQ_FOREACH(vd, &vnc_displays, next) {
    vnc_display_close(vd);
  }

pushing the vnc_disconnect_start into vnc_display_close.

> +    QTAILQ_FOREACH_SAFE(vd, &vnc_displays, next, vd_next) {
> +        while (!QTAILQ_EMPTY(&vd->clients)) {
> +            main_loop_wait(false);
> +        }

Could we push this loop into  vnc_display_free, on the assumption
that a call to vnc_display_close be made a documented pre-condition ?

> +        vnc_display_free(vd);
> +    }
> +}
> +
>  static void vnc_register_config(void)
>  {
>      qemu_add_opts(&qemu_vnc_opts);
> 
> -- 
> 2.53.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


