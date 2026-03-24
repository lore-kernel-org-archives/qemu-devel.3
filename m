Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5016F54AC4
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52mZ-0006Lf-J8; Tue, 24 Mar 2026 10:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w52mU-0006L5-Ar
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w52mR-0006Hv-Q2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774362650;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0XMizQcld3bQsM7ikdm6cGn+EVenhMuALX95gVm/azs=;
 b=Qc/2cfYbe7NceKUATbkyUv7B2QwTQKrd4kNyhXUcRgSydmszXONcoENzf56GI8AujUgCfE
 7sl0dLBc0bzS8evybpMjq/fwtCtwN9+BccrRCTdF/3TY3Zb6wZvKM131N3HxB/e6XVTPAJ
 temh+H/JEiK/a+H7FLPeA4UT8CsUV3o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-lSuNvVAsPeCKd5nuX_7SeA-1; Tue,
 24 Mar 2026 10:30:49 -0400
X-MC-Unique: lSuNvVAsPeCKd5nuX_7SeA-1
X-Mimecast-MFC-AGG-ID: lSuNvVAsPeCKd5nuX_7SeA_1774362648
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 790951944F11
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 14:30:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B5F41955D71; Tue, 24 Mar 2026 14:30:47 +0000 (UTC)
Date: Tue, 24 Mar 2026 14:30:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 40/60] ui: minor code simplification
Message-ID: <acKgEm0F_Ghh4fRB@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-40-48eb1dcf7b76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317-qemu-vnc-v1-40-48eb1dcf7b76@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Mar 17, 2026 at 12:50:54PM +0400, Marc-André Lureau wrote:
> Remove the extra "info" variable and its initialization.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/sdl2.c | 10 +++++-----
>  ui/vnc.c  |  7 ++-----
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index aaaede56e0e..3ffb8acaff8 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -600,11 +600,11 @@ static void handle_windowevent(SDL_Event *ev)
>      switch (ev->window.event) {
>      case SDL_WINDOWEVENT_RESIZED:
>          {
> -            QemuUIInfo info;
> -            memset(&info, 0, sizeof(info));
> -            info.width = ev->window.data1;
> -            info.height = ev->window.data2;
> -            dpy_set_ui_info(scon->dcl.con, &info, true);
> +            dpy_set_ui_info(scon->dcl.con,
> +                &(QemuUIInfo) {
> +                    .width = ev->window.data1,
> +                    .height = ev->window.data2,
> +                }, true);

I find this new code less readable than the original. The compiler
optimizer can remove uneccessary variables in this way.

I would, however, suggest removing the memset and doing

             QemuUIInfo info = { .width = ev->window.data1,
                                 .height = ev->window.data2 };
             dpy_set_ui_info(scon->dcl.con, &info, true);

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


