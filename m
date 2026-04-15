Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C561DF4199C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 12:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCzDw-0000I0-60; Wed, 15 Apr 2026 08:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCzDu-0000Hm-RJ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 08:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCzDs-0005L7-Fe
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 08:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776255598;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QudhsiLe50wvkVB9hkJZqM5WawFPOajirPx7umPKc3g=;
 b=OjjwIGa25BIJfVpThzGmM1tNsy4RFYamLOFt9U+5v/nFTfKrZtyWJ3Qj5O6ZEakjrhK8D0
 8wSUcDmg9+6F+nnHGG4Vx6K8wZU4cZHNdoqDm44SdKknaXKDHpQoC69mjGCXeX0vW+nKVC
 kWXeDQbl2uk1zfqeom0AD+X5HbFyFsE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-w6nknh3uNrGobQuNIxObRg-1; Wed,
 15 Apr 2026 08:19:56 -0400
X-MC-Unique: w6nknh3uNrGobQuNIxObRg-1
X-Mimecast-MFC-AGG-ID: w6nknh3uNrGobQuNIxObRg_1776255595
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A144C18003F6
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 12:19:55 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2FBB180047F; Wed, 15 Apr 2026 12:19:54 +0000 (UTC)
Date: Wed, 15 Apr 2026 13:19:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 52/67] ui/vnc: expose vnc_disconnect_start()
Message-ID: <ad-CZ-P0JpTeUPjL@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-52-231416f76dc3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410-qemu-vnc-v2-52-231416f76dc3@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Apr 10, 2026 at 11:19:14PM +0400, Marc-André Lureau wrote:
> This allows VncDisplay users to tear down all clients before freeing the
> VncDisplay for example.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/vnc.h | 1 +
>  ui/vnc.c | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ui/vnc.h b/ui/vnc.h
> index de41517be48..794341265b3 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -560,6 +560,7 @@ void vnc_display_free(VncDisplay *vd);
>   *****************************************************************************/
>  
>  /* Event loop functions */
> +void vnc_disconnect_start(VncState *vs);

AFAICT, nothing later in this series calls this, so this patch
looks redundant

>  gboolean vnc_client_io(QIOChannel *ioc,
>                         GIOCondition condition,
>                         void *opaque);
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 747b1c44e36..6fef80e98c4 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -617,7 +617,6 @@ bool vnc_display_reload_certs(const char *id, Error **errp)
>  */
>  
>  static int vnc_update_client(VncState *vs, int has_dirty);
> -static void vnc_disconnect_start(VncState *vs);
>  
>  static void vnc_colordepth(VncState *vs);
>  static void framebuffer_update_request(VncState *vs, int incremental,
> @@ -1296,7 +1295,7 @@ static void audio_del(VncState *vs)
>      }
>  }
>  
> -static void vnc_disconnect_start(VncState *vs)
> +void vnc_disconnect_start(VncState *vs)
>  {
>      if (vs->disconnecting) {
>          return;
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


