Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E97C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwOY-0006tM-Dm; Thu, 25 Apr 2024 06:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rzwOP-0006sp-NL
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rzwON-00032v-SR
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714041110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IESX+B7beJyN9hTPIT3+yMvE6r6QQt/tPl270mQzomU=;
 b=IUf0wz5qHVwypcpuuZF4xgIxJp8HXXfZ4NGlBqofTbGJicy1lkBUNkBBtYIEm2srLOFatZ
 7Ky/y7C3Q/cIExaCjruTArviEWGdE9mD/n646njRPB4pA7O6XQo1PhkJO0YcreYWonkQp6
 2eb7mJj0DNk9RlXILFtCHA4ibcKl9io=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-dlUU_1evOkeSSSgdF6MbVA-1; Thu, 25 Apr 2024 06:31:49 -0400
X-MC-Unique: dlUU_1evOkeSSSgdF6MbVA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-41a370b6acdso3735655e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041108; x=1714645908;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IESX+B7beJyN9hTPIT3+yMvE6r6QQt/tPl270mQzomU=;
 b=gZ/RPiUfx9mjyiQBMvZ7RBaaHnE88vC/+Pt0k2aYQehMHw/9eU/F9h+3ARmTfjNkok
 pzI2kyqXZ/97j7vrbUDRtb9bp8IXp1Wea9JZK1IFQFR93j0U6YhOfO1Isov9KPY4bowR
 7IEF5RBpCVpUgG95TEfJz/PxrP8phM8Z4v92JBtnYN5sXBt8kXOIQiKl2Fq4IQlotTEP
 rXDGxv75RXueO08GOlljxd1Ug8kUl2UGE+C+axlng/bk1xSzoaCMwqP67kl5ToGPpNDM
 ZqQajfT69E5RS1HUpbNjfQg8WtNCOH/5aywtTIF+vq7g4sxQnUbgdya/C/h6kpcVOio1
 JuQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE9w7RvWR3KkYX2B6KFBZNOvPGQNWmC5EOVw3I5Ozroxr6SbF1pXvi/kYc7iNWhkCEAebNa57xChLp1tbLDtPnszWM9BE=
X-Gm-Message-State: AOJu0Yzt6pCCBpXbMSCK6BYqStUV3y9f+DlLrmrdQ1J8/E419EDvZAGr
 U5x2X+kN8i6uKO3BwOyuD72iZ2Ksz/BGnWhdEqo8o1NQPYqJsnKIxXm52/NMq0V2qLrL34rwa69
 V4jRRfTyzgyFq1GOkGODsg3At6Lw+ht04dIvcPNGe2wnzvMPcirg+
X-Received: by 2002:a05:600c:1f91:b0:41a:81be:3e5e with SMTP id
 je17-20020a05600c1f9100b0041a81be3e5emr3878324wmb.22.1714041107910; 
 Thu, 25 Apr 2024 03:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRecBb/Korh9uRccURI39nHSgeeEUr1AWn15Npt6bAqJjAGYiOWj98MRPLkD59AKJd60dcWw==
X-Received: by 2002:a05:600c:1f91:b0:41a:81be:3e5e with SMTP id
 je17-20020a05600c1f9100b0041a81be3e5emr3878297wmb.22.1714041107359; 
 Thu, 25 Apr 2024 03:31:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:9e35:9594:88eb:df3e:840e])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c4f9200b004169836bf9asm30737266wmq.23.2024.04.25.03.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:31:46 -0700 (PDT)
Date: Thu, 25 Apr 2024 06:31:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
Message-ID: <20240425062717-mutt-send-email-mst@kernel.org>
References: <20240422170913-mutt-send-email-mst@kernel.org>
 <CAAjaMXZxFJtEdJh38_76ZdL82JBM52Ke0+p1K07miiFeQSJtcw@mail.gmail.com>
 <CAAjaMXaoPeCVpd=q-d2GH25SfrNPVqh6hCerMOrQ6payXVMmyA@mail.gmail.com>
 <f5c67478-4fb9-4fb9-a6b2-286d6372bd0a@linaro.org>
 <b9fb7a87-2328-4999-8f7e-6b6cf04984a3@ilande.co.uk>
 <CAAjaMXa00nWejPRc_Xc9fnoncXVDiWO9MNabwq-QU5nepA4b9w@mail.gmail.com>
 <fd6b0336-ecc7-4c0e-aa48-f8e984d293dc@ilande.co.uk>
 <CAAjaMXaBd8+DuNzeVO9k=6ojt5brt1nmm1gApdwgXJ3JzjisTA@mail.gmail.com>
 <20240425062213-mutt-send-email-mst@kernel.org>
 <CAAjaMXYTGUUeABd+Ghaf374pOFjoF7RdncTTiciLhmo1yXXZVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXYTGUUeABd+Ghaf374pOFjoF7RdncTTiciLhmo1yXXZVQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 25, 2024 at 01:26:38PM +0300, Manos Pitsidianakis wrote:
> On Thu, 25 Apr 2024 at 13:24, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Apr 25, 2024 at 01:04:31PM +0300, Manos Pitsidianakis wrote:
> > > On Thu, 25 Apr 2024 at 10:49, Mark Cave-Ayland
> > > <mark.cave-ayland@ilande.co.uk> wrote:
> > > >
> > > > On 25/04/2024 07:30, Manos Pitsidianakis wrote:
> > > >
> > > > > On Wed, 24 Apr 2024 at 13:31, Mark Cave-Ayland
> > > > > <mark.cave-ayland@ilande.co.uk> wrote:
> > > > >>
> > > > >> On 23/04/2024 12:05, Philippe Mathieu-Daudé wrote:
> > > > >>
> > > > >>> On 23/4/24 11:18, Manos Pitsidianakis wrote:
> > > > >>>> On Tue, 23 Apr 2024 at 11:47, Manos Pitsidianakis
> > > > >>>> <manos.pitsidianakis@linaro.org> wrote:
> > > > >>>>>
> > > > >>>>> On Tue, 23 Apr 2024 at 00:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >>>>>>
> > > > >>>>>> On Mon, Apr 22, 2024 at 11:07:21PM +0200, Philippe Mathieu-Daudé wrote:
> > > > >>>>>>> On 22/4/24 23:02, Michael S. Tsirkin wrote:
> > > > >>>>>>>> On Mon, Apr 22, 2024 at 04:20:56PM +0200, Philippe Mathieu-Daudé wrote:
> > > > >>>>>>>>> Since VirtIO devices can change endianness at runtime,
> > > > >>>>>>>>> we need to use the device endianness, not the target
> > > > >>>>>>>>> one.
> > > > >>>>>>>>>
> > > > >>>>>>>>> Cc: qemu-stable@nongnu.org
> > > > >>>>>>>>> Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
> > > > >>>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > >>>>>>>>
> > > > >>>>>>>>
> > > > >>>>>>>>
> > > > >>>>>>>> This is all completely bogus. Virtio SND is from Virtio 1.0 only.
> > > > >>>>>>>> It is unconditionally little endian.
> > > > >>>>>
> > > > >>>>>
> > > > >>>>> This part of the code is for PCM frames (raw bytes), not virtio spec
> > > > >>>>> fields (which indeed must be LE in modern VIRTIO).
> > > > >>>>
> > > > >>>> Thought a little more about it. We should keep the target's endianness
> > > > >>>> here, if it's mutable then we should query the machine the device is
> > > > >>>> attached to somehow. the virtio device should never change endianness
> > > > >>>> like Michael says since it's not legacy.
> > > > >>>
> > > > >>> Grr. So as Richard suggested, this need to be pass as a device
> > > > >>> property then.
> > > > >>> (https://lore.kernel.org/qemu-devel/ed134c9d-6e6f-465b-900f-e39ca4e09876@linaro.org/)
> > > > >>
> > > > >> It feels to me that the endianness is something that should be negotiated as part of
> > > > >> the frame format, since the endianness of the audio hardware can be different from
> > > > >> that of the CPU (think PReP machines where it was common that a big endian CPU is
> > > > >> driving little endian hardware as found on x86).
> > > > >
> > > > > But that is the job of the hardware drivers, isn't it? Here we are
> > > > > taking frames passed from the guest to its virtio driver in the format
> > > > > specified in the target cpu's endianness and QEMU as the device passes
> > > > > it to host ALSA/Pipewire/etc which in turn passes it to the actual
> > > > > audio hardware driver..
> > > >
> > > > The problem is that the notion of target CPU endian is not fixed. For example the
> > > > PowerPC CPU starts off in big-endian mode, but these days most systems will switch
> > > > the CPU to little-endian mode on startup to run ppc64le. There's also the ILE bit
> > > > which can be configured so that a big-endian PowerPC CPU can dynamically switch to
> > > > little-endian mode when processing an interrupt, so you could potentially end up with
> > > > either depending upon the current mode of the CPU.
> > > >
> > > > These are the kinds of issues that led to the later virtio specifications simply
> > > > using little-endian for everything, since then there is zero ambiguity over what
> > > > endian is required for the virtio configuration space accesses.
> > > >
> > > > It feels to me that assuming a target CPU endian is fixed for the PCM frame formats
> > > > is simply repeating the mistakes of the past - and even the fact that we are
> > > > discussing this within this thread suggests that at a very minimum the virtio-snd
> > > > specification needs to be updated to clarify the byte ordering of the PCM frame formats.
> > > >
> > > >
> > > > ATB,
> > > >
> > > > Mark.
> > > >
> > >
> > >
> > > Agreed, I think we are saying approximately the same thing here.
> > >
> > >  We need a mechanism to retrieve the vCPUs endianness and a way to
> > > notify subscribed devices when it changes.
> >
> > I don't think I agree, it's not the same thing.
> > Guest should just convert and send data in LE format.
> > Host should then convert from LE format.
> > Target endian-ness does not come into it.
> 
> That's not in the VIRTIO 1.2 spec. We are talking about supporting
> things as they currently stand, not as they could have been.

Okay it's a spec bug then.
I do worry that if we just work around it now no one will bother
fixing it properly though.

How do other drivers handle this? Could you check please?


-- 
MST


