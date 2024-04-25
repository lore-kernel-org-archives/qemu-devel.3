Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF36FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwH4-0004cz-WE; Thu, 25 Apr 2024 06:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rzwH1-0004cB-0G
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rzwGz-0001Rc-6A
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714040650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6j02RYkUUQb00KRG71q5eBPjihBsJ1tSODo97t0Pc8E=;
 b=N+esXzn+RSrfVYEiAYHfNqbaYtOdla878L1ctNgu5YxHabgeaoa/itkY0anEPkupRD9fJu
 vtndniIOMnRf8/nlc8An5bu4EPU5aK7TBN8VpdIGRbi3JTUfaKYVwyJ/g/X0UIK4zlhNcm
 THh0O4takFub6v3ZuXgpNaI0A8LCEa4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-f-NS0dpeMUS-pjrPl_0ZQw-1; Thu, 25 Apr 2024 06:24:09 -0400
X-MC-Unique: f-NS0dpeMUS-pjrPl_0ZQw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-34bb415008bso545297f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714040648; x=1714645448;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6j02RYkUUQb00KRG71q5eBPjihBsJ1tSODo97t0Pc8E=;
 b=DeHoe8HWoQoBqsQA7U4xZCyB9DBrd2UIXMZESmqs/jfbX7yFKcZ1jXOBqOdbVbAg5j
 qEtfECCbzJQgESSrU3kXLCGGHkztQGT5BK2H5GEQKJCKi0ZIdAnJb6ASKGKFyq6qEBB3
 g6BHSurL+sXUv2vC5WaUD9HKZLHh8lfzdy9z1E2tMxdy5nlxh/gQxRaxlJQKLZkO7/9G
 ZNai+PLhJW4fFWztr+lAzw92v0pFksj/hh740cMNDk2vmooSknFB9GXMTiuVJdaBIn2Y
 uJGR2fCSWHXWDqp9Y89g0nPTebKg3DnFvixBIXIzQZFF4qhUVcQY4vrsMjc7obwvH6JK
 2iuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUWrAcfSAYDldulGGqiusmpD5xb7e3Gl6rZNKHCZYUQNOV5VEUuWoydWaMfcV+/NhMEAnKPeMJPOJVy+GZpeGJu8lGc38=
X-Gm-Message-State: AOJu0Yz9U0IVv2tSHgVh+HLBPlIw6FI2DD1qiMNCSqL1qcJmENILEMJ3
 Ec4eKPBwVtEj8gg6sdO5zN+8JDgyAduRJHwI7zzQ7r4U80enqCAcnBw3n4FBflHtx/cZWLhfGRw
 CsEciptQ3ScUuOVLYvS8jLp+MGEgtOFwHn9NJA0+UwsA7YcrP8mAZ
X-Received: by 2002:a5d:5702:0:b0:34b:58a2:dea3 with SMTP id
 a2-20020a5d5702000000b0034b58a2dea3mr3374069wrv.64.1714040648204; 
 Thu, 25 Apr 2024 03:24:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxtVNnG0RoHT1jHCJJZJD4foEsQ66wo0c3+3J8NeggQISJWmKTvHMdh6PGs8LOfpbAG9MG4A==
X-Received: by 2002:a5d:5702:0:b0:34b:58a2:dea3 with SMTP id
 a2-20020a5d5702000000b0034b58a2dea3mr3374051wrv.64.1714040647607; 
 Thu, 25 Apr 2024 03:24:07 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:9e35:9594:88eb:df3e:840e])
 by smtp.gmail.com with ESMTPSA id
 t15-20020adfeb8f000000b00349ff2e0345sm19596983wrn.70.2024.04.25.03.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:24:07 -0700 (PDT)
Date: Thu, 25 Apr 2024 06:24:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
Message-ID: <20240425062213-mutt-send-email-mst@kernel.org>
References: <20240422170056-mutt-send-email-mst@kernel.org>
 <1f6447c4-ea4c-4bd3-a879-8efb72448bb8@linaro.org>
 <20240422170913-mutt-send-email-mst@kernel.org>
 <CAAjaMXZxFJtEdJh38_76ZdL82JBM52Ke0+p1K07miiFeQSJtcw@mail.gmail.com>
 <CAAjaMXaoPeCVpd=q-d2GH25SfrNPVqh6hCerMOrQ6payXVMmyA@mail.gmail.com>
 <f5c67478-4fb9-4fb9-a6b2-286d6372bd0a@linaro.org>
 <b9fb7a87-2328-4999-8f7e-6b6cf04984a3@ilande.co.uk>
 <CAAjaMXa00nWejPRc_Xc9fnoncXVDiWO9MNabwq-QU5nepA4b9w@mail.gmail.com>
 <fd6b0336-ecc7-4c0e-aa48-f8e984d293dc@ilande.co.uk>
 <CAAjaMXaBd8+DuNzeVO9k=6ojt5brt1nmm1gApdwgXJ3JzjisTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXaBd8+DuNzeVO9k=6ojt5brt1nmm1gApdwgXJ3JzjisTA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 25, 2024 at 01:04:31PM +0300, Manos Pitsidianakis wrote:
> On Thu, 25 Apr 2024 at 10:49, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
> >
> > On 25/04/2024 07:30, Manos Pitsidianakis wrote:
> >
> > > On Wed, 24 Apr 2024 at 13:31, Mark Cave-Ayland
> > > <mark.cave-ayland@ilande.co.uk> wrote:
> > >>
> > >> On 23/04/2024 12:05, Philippe Mathieu-Daudé wrote:
> > >>
> > >>> On 23/4/24 11:18, Manos Pitsidianakis wrote:
> > >>>> On Tue, 23 Apr 2024 at 11:47, Manos Pitsidianakis
> > >>>> <manos.pitsidianakis@linaro.org> wrote:
> > >>>>>
> > >>>>> On Tue, 23 Apr 2024 at 00:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >>>>>>
> > >>>>>> On Mon, Apr 22, 2024 at 11:07:21PM +0200, Philippe Mathieu-Daudé wrote:
> > >>>>>>> On 22/4/24 23:02, Michael S. Tsirkin wrote:
> > >>>>>>>> On Mon, Apr 22, 2024 at 04:20:56PM +0200, Philippe Mathieu-Daudé wrote:
> > >>>>>>>>> Since VirtIO devices can change endianness at runtime,
> > >>>>>>>>> we need to use the device endianness, not the target
> > >>>>>>>>> one.
> > >>>>>>>>>
> > >>>>>>>>> Cc: qemu-stable@nongnu.org
> > >>>>>>>>> Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
> > >>>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> This is all completely bogus. Virtio SND is from Virtio 1.0 only.
> > >>>>>>>> It is unconditionally little endian.
> > >>>>>
> > >>>>>
> > >>>>> This part of the code is for PCM frames (raw bytes), not virtio spec
> > >>>>> fields (which indeed must be LE in modern VIRTIO).
> > >>>>
> > >>>> Thought a little more about it. We should keep the target's endianness
> > >>>> here, if it's mutable then we should query the machine the device is
> > >>>> attached to somehow. the virtio device should never change endianness
> > >>>> like Michael says since it's not legacy.
> > >>>
> > >>> Grr. So as Richard suggested, this need to be pass as a device
> > >>> property then.
> > >>> (https://lore.kernel.org/qemu-devel/ed134c9d-6e6f-465b-900f-e39ca4e09876@linaro.org/)
> > >>
> > >> It feels to me that the endianness is something that should be negotiated as part of
> > >> the frame format, since the endianness of the audio hardware can be different from
> > >> that of the CPU (think PReP machines where it was common that a big endian CPU is
> > >> driving little endian hardware as found on x86).
> > >
> > > But that is the job of the hardware drivers, isn't it? Here we are
> > > taking frames passed from the guest to its virtio driver in the format
> > > specified in the target cpu's endianness and QEMU as the device passes
> > > it to host ALSA/Pipewire/etc which in turn passes it to the actual
> > > audio hardware driver..
> >
> > The problem is that the notion of target CPU endian is not fixed. For example the
> > PowerPC CPU starts off in big-endian mode, but these days most systems will switch
> > the CPU to little-endian mode on startup to run ppc64le. There's also the ILE bit
> > which can be configured so that a big-endian PowerPC CPU can dynamically switch to
> > little-endian mode when processing an interrupt, so you could potentially end up with
> > either depending upon the current mode of the CPU.
> >
> > These are the kinds of issues that led to the later virtio specifications simply
> > using little-endian for everything, since then there is zero ambiguity over what
> > endian is required for the virtio configuration space accesses.
> >
> > It feels to me that assuming a target CPU endian is fixed for the PCM frame formats
> > is simply repeating the mistakes of the past - and even the fact that we are
> > discussing this within this thread suggests that at a very minimum the virtio-snd
> > specification needs to be updated to clarify the byte ordering of the PCM frame formats.
> >
> >
> > ATB,
> >
> > Mark.
> >
> 
> 
> Agreed, I think we are saying approximately the same thing here.
> 
>  We need a mechanism to retrieve the vCPUs endianness and a way to
> notify subscribed devices when it changes.

I don't think I agree, it's not the same thing.
Guest should just convert and send data in LE format.
Host should then convert from LE format.
Target endian-ness does not come into it.



>  I think that then, since the virtio device is mostly certain of the
> correct target endianness and completely certain of the host
> endianness, it can perform the necessary conversions.
> 
>  I don't recall seeing a restriction on the byte ordering of PCM
> formats other than the CPU order; except for the ones which have
> explicit endianness in their definitions. Please correct me if I am
> wrong!
> 
> A straightforward solution would be to set an endianness change notify
> callback in DeviceClass. What do you think?
> 
> -- 
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd


