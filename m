Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2829FCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIGZ-0006iA-DJ; Fri, 08 May 2026 06:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLIGY-0006ho-AO
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLIGW-0006PL-Lm
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778235423;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYbOBlLXPbvsdD0Tf2vCyrqF6oVa3+1BjoWSMFKkBjg=;
 b=Enu4FLJGSh8YxLmASSlJIxWFr2zR4GxAiNialT8fZSJjr0d/fJc/Ch4XJ5bHrEPq0W8AsD
 BwCWVIUhHC5x10x7P68R6SGRZuLcOXMAAzkxo2R7jHnCkmqxIPcZRNeqgf7qPGKoqD/yqz
 xKSWE8C3N5Qh2xpFCLPZVkC5NCEmsJE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-FYRIZpHSOWS8AHxbjrzkKA-1; Fri,
 08 May 2026 06:17:00 -0400
X-MC-Unique: FYRIZpHSOWS8AHxbjrzkKA-1
X-Mimecast-MFC-AGG-ID: FYRIZpHSOWS8AHxbjrzkKA_1778235419
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B80019560BB
 for <qemu-devel@nongnu.org>; Fri,  8 May 2026 10:16:59 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.204])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFCCB300019F; Fri,  8 May 2026 10:16:57 +0000 (UTC)
Date: Fri, 8 May 2026 11:16:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 04/26] ui/console: default vc encoding to cp437 for
 machine < 11.1
Message-ID: <af24FUi3zy69LUno@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
 <20260430-qemu-vnc-v3-4-be96757428d0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430-qemu-vnc-v3-4-be96757428d0@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 30, 2026 at 01:02:37AM +0400, Marc-André Lureau wrote:
> Add a QOM "encoding" enum property to some chardev-vc backends
> (console-vc & dbus - gtk and spice don't make use of it) so that the
> machine compat mechanism can override the default. For machine versions
> prior to 11.1, the charset defaults to cp437 (raw 8-bit VGA) instead of
> utf8, preserving the historical behaviour.
> 
> The following commits are going to wire this to VT100 emulation code and
> an extra exported D-Bus property.
> 
> Note that GTK libvte uses utf8 unconditionally, and Spice doesn't have a
> way to set the encoding, and typically just use libvte in client too.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/chardev/char.h | 19 +++++++++++++++++++
>  hw/core/machine.c      |  4 +++-
>  ui/console-vc.c        | 18 ++++++++++++++++++
>  ui/dbus.c              | 40 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 80 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


