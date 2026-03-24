Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBC0F54ACF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53cN-0004lO-Hk; Tue, 24 Mar 2026 11:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w53cK-0004l0-Pt
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w53cI-0007zQ-IG
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774365864;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AkVoHPH7T4OajBCFu6VGPuH9NQqkI/JxsybDrknVjHY=;
 b=PUGkKSCiQo+XoAUDCnABsDD2caAgE12/ZS1fmHmIA9jOMGsc4x01j3QG1n1g9aMIewQyFe
 Ra0dXJl2JH3YMVUj1VRmNxJEHu9mdFLZmImZ1ywVlf+BLsIV1uz6SOVfZ4QqkngaAUsIBn
 LB3xKkxLdZ1zo/J5T9X/s0MYlQ2SJ+0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-64E3n_qUPmCVvr9TAxhaIw-1; Tue,
 24 Mar 2026 11:24:22 -0400
X-MC-Unique: 64E3n_qUPmCVvr9TAxhaIw-1
X-Mimecast-MFC-AGG-ID: 64E3n_qUPmCVvr9TAxhaIw_1774365862
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEB761800245
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 15:24:21 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C38A01955D71; Tue, 24 Mar 2026 15:24:20 +0000 (UTC)
Date: Tue, 24 Mar 2026 15:24:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 60/60] contrib/qemu-vnc: add standalone VNC server over
 D-Bus
Message-ID: <acKsobCZ2G8TE2XI@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-60-48eb1dcf7b76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317-qemu-vnc-v1-60-48eb1dcf7b76@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 17, 2026 at 12:51:14PM +0400, Marc-André Lureau wrote:
> Add a standalone VNC server binary that connects to a running QEMU
> instance via the D-Bus display interface (org.qemu.Display1, via the bus
> or directly p2p). This allows serving a VNC display without compiling
> VNC support directly into the QEMU system emulator, and enables running
> the VNC server as a separate process with independent lifecycle and
> privilege domain.

IIUC, this new binary is linking to all the existnig ui/vnc.c
code, so there's no actual new impl of the RFB protocol, just
a new glue layer for launching the existing impl with comms
over DBus instead of from direct callback functions ?

> Built only when both VNC and D-Bus display support are enabled.
> If we wanted to have qemu -vnc disabled, and qemu-vnc built, we would
> need to split CONFIG_VNC. This is left as a future exercise.
> 
> I left out for now:
>  - sasl & tls authz

IMHO these are must have features, as the default VNC protocol
security is a very bad joke.

>  - some runtime functionalities (better done by restarting)
>  - a few legacy options
>  - Windows support
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS                    |   5 +
>  docs/conf.py                   |   3 +
>  docs/interop/dbus-display.rst  |   2 +
>  docs/interop/dbus-vnc.rst      |  26 ++
>  docs/interop/index.rst         |   1 +
>  docs/meson.build               |   1 +
>  docs/tools/index.rst           |   1 +
>  docs/tools/qemu-vnc.rst        | 199 +++++++++++
>  meson.build                    |  17 +
>  contrib/qemu-vnc/qemu-vnc.h    |  46 +++
>  contrib/qemu-vnc/trace.h       |   4 +
>  contrib/qemu-vnc/audio.c       | 307 +++++++++++++++++
>  contrib/qemu-vnc/chardev.c     | 127 +++++++
>  contrib/qemu-vnc/clipboard.c   | 378 +++++++++++++++++++++
>  contrib/qemu-vnc/console.c     | 168 ++++++++++
>  contrib/qemu-vnc/dbus.c        | 439 ++++++++++++++++++++++++
>  contrib/qemu-vnc/display.c     | 456 +++++++++++++++++++++++++
>  contrib/qemu-vnc/input.c       | 239 ++++++++++++++
>  contrib/qemu-vnc/qemu-vnc.c    | 450 +++++++++++++++++++++++++
>  contrib/qemu-vnc/stubs.c       |  66 ++++
>  contrib/qemu-vnc/utils.c       |  59 ++++

IMHO we should not really be adding more things to the contrib
directory, and rather wish most of the existing stuff was
not there. When I see "contrib" directories in projects, the
message is generally "unmaintained, abandoned junk".

If this is a serious maintained feature we expect people to use,
it should be formally under the ui/ directory, possibly a
'ui/dbus-vnc' subdir ?

>  tests/qtest/dbus-vnc-test.c    | 733 +++++++++++++++++++++++++++++++++++++++++
>  contrib/qemu-vnc/meson.build   |  26 ++
>  contrib/qemu-vnc/qemu-vnc1.xml | 174 ++++++++++
>  contrib/qemu-vnc/trace-events  |  20 ++
>  meson_options.txt              |   2 +
>  scripts/meson-buildoptions.sh  |   3 +
>  tests/dbus-daemon.sh           |  14 +-
>  tests/qtest/meson.build        |   8 +
>  29 files changed, 3971 insertions(+), 3 deletions(-)
> 

> diff --git a/meson_options.txt b/meson_options.txt
> index 31d5916cfce..ef938e74793 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -119,6 +119,8 @@ option('vfio_user_server', type: 'feature', value: 'disabled',
>         description: 'vfio-user server support')
>  option('dbus_display', type: 'feature', value: 'auto',
>         description: '-display dbus support')
> +option('qemu_vnc', type: 'feature', value: 'auto',
> +       description: 'standalone VNC server over D-Bus')

Every option is about QEMU, so 'qemu_' on a name feels redundant,
and QEMU alrady has a VNC server too.

I suggest 'dbus_vnc' is possibly a better name


>  option('tpm', type : 'feature', value : 'auto',
>         description: 'TPM support')
>  option('valgrind', type : 'feature', value: 'auto',

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


