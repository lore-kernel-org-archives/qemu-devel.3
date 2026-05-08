Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13FECD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIhu-0008WF-Rz; Fri, 08 May 2026 06:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLIht-0008W7-Ib
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLIhr-0003pB-8b
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778237117;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5MGPAA6KJlDktIYvwYp+Ngfg9in6sfdJFPqGm8qzxZQ=;
 b=aovZA8SJ/hMZja5ixUIKRrTlK60FA2J7Up4tvb8vRnf+fHK3EFwz0d01UnXZVWP5MoT9no
 KHKQahlcIhCIJCxKcVlpIr+8RRquKX+8Pzx7EATUvkpfE/eyQXibxdbn0LuBXLON5lgR/t
 3BsZTfv264QjdY3LIopZM1/BDJBDbqg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-QdD1MDp2Nkipin2IL6Pb4w-1; Fri,
 08 May 2026 06:45:16 -0400
X-MC-Unique: QdD1MDp2Nkipin2IL6Pb4w-1
X-Mimecast-MFC-AGG-ID: QdD1MDp2Nkipin2IL6Pb4w_1778237115
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48D5519560B7
 for <qemu-devel@nongnu.org>; Fri,  8 May 2026 10:45:15 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.204])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E06A019560A2; Fri,  8 May 2026 10:45:13 +0000 (UTC)
Date: Fri, 8 May 2026 11:45:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 26/26] tools/qemu-vnc: add standalone VNC server over
 D-Bus
Message-ID: <af2-tr2Hn1859JaO@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
 <20260430-qemu-vnc-v3-26-be96757428d0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430-qemu-vnc-v3-26-be96757428d0@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Thu, Apr 30, 2026 at 01:02:59AM +0400, Marc-André Lureau wrote:
> Add a standalone VNC server binary that connects to a running QEMU
> instance via the D-Bus display interface (org.qemu.Display1, via the bus
> or directly p2p). This allows serving a VNC display without compiling
> VNC support directly into the QEMU system emulator, and enables running
> the VNC server as a separate process with independent lifecycle and
> privilege domain.
> 
> Built only when both VNC and D-Bus display support are enabled.
> If we wanted to have qemu -vnc disabled, and qemu-vnc built, we would
> need to split CONFIG_VNC. This is left as a future exercise.
> 
> Current omissions include some QEMU VNC runtime features (better handled via
> restart), legacy options, and Windows support.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS                   |    5 +
>  docs/conf.py                  |    3 +
>  docs/interop/dbus-display.rst |    2 +
>  docs/interop/dbus-vnc.rst     |   26 +
>  docs/interop/index.rst        |    1 +
>  docs/meson.build              |    1 +
>  docs/tools/index.rst          |    1 +
>  docs/tools/qemu-vnc.rst       |  226 +++++++
>  meson.build                   |   17 +
>  tools/qemu-vnc/qemu-vnc.h     |   49 ++
>  tools/qemu-vnc/trace.h        |    4 +
>  tests/qtest/dbus-vnc-test.c   | 1346 +++++++++++++++++++++++++++++++++++++++++
>  tools/qemu-vnc/audio.c        |  308 ++++++++++
>  tools/qemu-vnc/chardev.c      |  148 +++++
>  tools/qemu-vnc/clipboard.c    |  378 ++++++++++++
>  tools/qemu-vnc/console.c      |  170 ++++++
>  tools/qemu-vnc/dbus.c         |  474 +++++++++++++++
>  tools/qemu-vnc/display.c      |  456 ++++++++++++++
>  tools/qemu-vnc/input.c        |  239 ++++++++
>  tools/qemu-vnc/qemu-vnc.c     |  581 ++++++++++++++++++
>  tools/qemu-vnc/stubs.c        |   62 ++
>  tools/qemu-vnc/utils.c        |   59 ++
>  meson_options.txt             |    2 +
>  scripts/meson-buildoptions.sh |    3 +
>  tests/dbus-daemon.sh          |   14 +-
>  tests/qtest/meson.build       |   13 +
>  tools/qemu-vnc/meson.build    |   26 +
>  tools/qemu-vnc/qemu-vnc1.xml  |  201 ++++++
>  tools/qemu-vnc/trace-events   |   21 +
>  29 files changed, 4833 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>





With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


