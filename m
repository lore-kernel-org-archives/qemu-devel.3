Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B89CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 11:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCGJy-0004DM-Vc; Fri, 24 Oct 2025 07:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCGJw-0004Cu-FZ
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 07:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCGJt-0007CX-Hu
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 07:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761306654;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qwg8VvmHwn7K1X45VRhRPfJH99x+rg/PW1Hb82nCdDE=;
 b=JhErYO2yN+nulTNvNODviDGlbdX2uoHTPRrQBWm2U5y0euTKcum3vX4ym0n0vNTAu7ZY1v
 WHKlG5liJLjX8L7GHUfRtswdqeAl/OdDVedbeNtfuIAdxYbMDLXXMzO88oIyu9S3r+S/MC
 4xIfgY4mePDo6Cu92Zr5gbPH4CYYtnM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-HUWYhhdAMtyvRkd2LvmFcg-1; Fri,
 24 Oct 2025 07:50:50 -0400
X-MC-Unique: HUWYhhdAMtyvRkd2LvmFcg-1
X-Mimecast-MFC-AGG-ID: HUWYhhdAMtyvRkd2LvmFcg_1761306649
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 919DC196F754; Fri, 24 Oct 2025 11:50:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B367519540EB; Fri, 24 Oct 2025 11:50:42 +0000 (UTC)
Date: Fri, 24 Oct 2025 12:50:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "open list:Xilinx ZynqMP and..." <qemu-arm@nongnu.org>
Subject: Re: [PATCH 35/43] audio: rename QEMUSoundCard -> AudioFE
Message-ID: <aPtoD4KB8sDmy_gn@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-36-marcandre.lureau@redhat.com>
 <e8232530-ce04-c542-d39e-c0e2dc5014b3@eik.bme.hu>
 <CAJ+F1CJ8Ojiwen+rPrrFAineLYX0-qyXVysCaUSNeSytWPSYkg@mail.gmail.com>
 <22226473-1730-9c09-4fce-0aa03ff244f6@eik.bme.hu>
 <CAJ+F1CL9_vM0nXt1XKsx-SWG1kxdHfgNJWppx-aTZ7DK3MktpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CL9_vM0nXt1XKsx-SWG1kxdHfgNJWppx-aTZ7DK3MktpA@mail.gmail.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 21, 2025 at 05:06:01PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Oct 21, 2025 at 4:50 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
> >
> > On Tue, 21 Oct 2025, Marc-André Lureau wrote:
> > > On Tue, Oct 21, 2025 at 4:13 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > >>
> > >> On Tue, 21 Oct 2025, marcandre.lureau@redhat.com wrote:
> > >>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >>>
> > >>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >>> ---
> > >>> audio/audio.h                       | 20 ++++++++++----------
> > >>> audio/audio_int.h                   |  6 +++---
> > >>> audio/audio_template.h              |  4 ++--
> > >>> hw/audio/lm4549.h                   |  2 +-
> > >>> include/hw/audio/asc.h              |  2 +-
> > >>> include/hw/audio/virtio-snd.h       |  2 +-
> > >>> include/hw/display/xlnx_dp.h        |  2 +-
> > >>> include/hw/isa/vt82c686.h           |  2 +-
> > >>> include/hw/qdev-properties-system.h |  2 +-
> > >>> audio/audio.c                       | 10 +++++-----
> > >>> hw/audio/ac97.c                     |  6 +++---
> > >>> hw/audio/adlib.c                    |  6 +++---
> > >>> hw/audio/asc.c                      |  6 +++---
> > >>> hw/audio/cs4231a.c                  |  4 ++--
> > >>> hw/audio/es1370.c                   |  6 +++---
> > >>> hw/audio/gus.c                      |  6 +++---
> > >>> hw/audio/hda-codec.c                |  6 +++---
> > >>> hw/audio/lm4549.c                   |  2 +-
> > >>> hw/audio/pcspk.c                    |  4 ++--
> > >>> hw/audio/sb16.c                     |  4 ++--
> > >>> hw/audio/via-ac97.c                 |  4 ++--
> > >>> hw/audio/virtio-snd.c               |  4 ++--
> > >>> hw/audio/wm8750.c                   |  6 +++---
> > >>> hw/core/qdev-properties-system.c    |  4 ++--
> > >>> hw/display/xlnx_dp.c                |  2 +-
> > >>> hw/usb/dev-audio.c                  |  6 +++---
> > >>> 26 files changed, 64 insertions(+), 64 deletions(-)
> > >>>
> > >>> diff --git a/audio/audio.h b/audio/audio.h
> > >>> index 845e078169..a43ca0700c 100644
> > >>> --- a/audio/audio.h
> > >>> +++ b/audio/audio.h
> > >>> @@ -70,18 +70,18 @@ struct AudioBEClass {
> > >>> };
> > >>>
> > >>> typedef struct AudioBE AudioBE;
> > >>> -typedef struct QEMUSoundCard {
> > >>> +typedef struct AudioFE {
> > >>
> > >> You could also leave it as it is. While it's a bit odd naming it's clear
> > >> enough and not at least the local variables now called "card" match the
> > >> type which would not be the case if you rename it to Audiodev or something
> > >> else but not rename all the locals. So maybe it does not worth the churn
> > >> to change this type name.
> > >
> > > I think it's still worth it. Local variables are locals, and usually
> > > easy to understand by the context and using their types. It's easy to
> > > rename "card" to "audio_fe" or "frontend" though, I can do this in
> > > this change too.
> >
> > The point is to have less churn not more so renaming locals from card to
> > fe or something (but definitely not to a longer name than currently) would
> > just be more churn for not much more clarity. Therefore I argued that
> 
> Renaming is making churn, I agree. But if the end result allows more
> readable code, even slightly, we should consider it.
> 
> Imho AudioState and QEMUSoundCard are bad type names that don't help.
> I value type names a lot more than variable names, especially now that
> we have LSP, I am probably not the only one.
> 
> I proposed AudioBE and AudioFE, for simplicity consistency and to
> avoid some naming clashes with QAPI types.
> 
> Agree, BE and FE are not the most readable, so AudioBackend and
> AudioFrontend seems agreeable (local variables or in fn_name_for_be
> use usually a shorter version though).

I find both ChardevFrontend and AudioFrontend as somewhat confusing,
because the Device is frontend. IIUC ChardevFrontend/AudioFrontend
act more like a way to associate a frontend and backend together.
Can we call the objects something like a "Connection" / "Attachment"
/ "Link" ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


