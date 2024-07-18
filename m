Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430C4C3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 16:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUTk7-0007hw-TO; Thu, 18 Jul 2024 12:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sUTk5-0007fx-F6
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 12:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sUTk3-0005iX-Ob
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 12:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721319147;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2Ud0gHl4Mbtr9KId2Tohk+NnW7qrXEhvcFaA2i6Cu0=;
 b=A64D26Wd6WS9MDNzfcDS2fdwNaKUen6Eg7fmyhfvrMgDY9r6kfI7TW/CO6ZsKOk6om5Otj
 DqZyxgC++QOoZeq+6WtWkePLAmyxwgqrHWbJPFRUS5IFXCcpnMnouXQcmM8J15Klnfxgoc
 R1oikRk4VGIzhYQYl+42Y2BjOcA0IG4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-CP9Ul1KeNlWLaHeCeqQBFw-1; Thu,
 18 Jul 2024 12:12:24 -0400
X-MC-Unique: CP9Ul1KeNlWLaHeCeqQBFw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1EA21944B30; Thu, 18 Jul 2024 16:12:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9FB21955F40; Thu, 18 Jul 2024 16:12:19 +0000 (UTC)
Date: Thu, 18 Jul 2024 17:12:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
Subject: Re: [PATCH v2] vnc: increase max display size
Message-ID: <Zpk-31nhmIAj7P5N@redhat.com>
References: <20240530111029.1726329-1-kraxel@redhat.com>
 <CAFEAcA8ShMnj43QwhKZxPvqQ9ei3s6LBGgXHQwRvpKf98dvuBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8ShMnj43QwhKZxPvqQ9ei3s6LBGgXHQwRvpKf98dvuBA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

On Thu, Jul 18, 2024 at 04:58:10PM +0100, Peter Maydell wrote:
> On Thu, 30 May 2024 at 12:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > It's 2024.  4k display resolutions are a thing these days.
> > Raise width and height limits of the qemu vnc server.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1596
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  ui/vnc.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/ui/vnc.h b/ui/vnc.h
> > index 4521dc88f792..e5fa2efa3e5d 100644
> > --- a/ui/vnc.h
> > +++ b/ui/vnc.h
> > @@ -81,8 +81,8 @@ typedef void VncSendHextileTile(VncState *vs,
> >
> >  /* VNC_MAX_WIDTH must be a multiple of VNC_DIRTY_PIXELS_PER_BIT. */
> >
> > -#define VNC_MAX_WIDTH ROUND_UP(2560, VNC_DIRTY_PIXELS_PER_BIT)
> > -#define VNC_MAX_HEIGHT 2048
> > +#define VNC_MAX_WIDTH ROUND_UP(5120, VNC_DIRTY_PIXELS_PER_BIT)
> > +#define VNC_MAX_HEIGHT 2160
> >
> >  /* VNC_DIRTY_BITS is the number of bits in the dirty bitmap. */
> >  #define VNC_DIRTY_BITS (VNC_MAX_WIDTH / VNC_DIRTY_PIXELS_PER_BIT)
> 
> Hi -- somebody on IRC pointed out that this simple patch
> had been code-reviewed by Daniel but never made it into git.
> Marc-André: you're listed maintainer for ui/ -- do you have
> a pullreq planned?
> 
> Alternatively we could take it via qemu-trivial since it's
> a pretty tiny patch (cc'd).

I'm working on a misc pull request, so I'll just include this
patch

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


