Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5360C19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzvyT-0005GE-CZ; Thu, 25 Apr 2024 06:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rzvyH-0005F7-Ie
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:04:53 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rzvyD-0007D4-RJ
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:04:52 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56e78970853so3325690a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714039488; x=1714644288; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ru0Daz2d54FCM9lMBHe/6KP+V8nu7XS8peRkxeMpr7c=;
 b=t+YE9hir54zN8EzvN3sLgWgpkTRi1rywMOpXK5CP8fQ9r6kPxd6Kv5JHiKfLI4KMys
 mm8g+3RJWIfMAazb5NY7/UtSOoyX1+UrjMlad5/afEY6iELYR2fhpJR645C6us6atc/0
 QB1+21tNvho62hHgqQE/9smgMYmGWhHA3TP6CuuLkQfdFQy5sG+71slBKpIZIX21/ejc
 /jFvToBBQ4EQeeP1BAiis4QyWtVfmPqvxs0PnrXO5ukmgKjEaowFDgpv8bwMTiojZZc7
 epZNZiWk5AUQdfTKH+fy66cpd/sKczm/xUKilMTz0WlcHqBnOs6Td17HI3IHmfTIF8y2
 zc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714039488; x=1714644288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ru0Daz2d54FCM9lMBHe/6KP+V8nu7XS8peRkxeMpr7c=;
 b=nHJikqUj6Ox9LppncFqib6tAlCf3Np8CSd3gWw7B8Vr2ZZ0NmpG5qJhU4gJKP55/7F
 eQxemG87ac6q8J/uasqXE7YK7j/765VeQNOL53rxdzLCSzxgy4onKhWcpDUJo85EHtw4
 bGoukFWdPo31VHOxuSV7z8I1eLUPhXorriOBP1/oc8HAVv+SdKWyp+AeqSM1idk5A0II
 9eToHc9eNtK0qdHSiFybILg2GmSoAe3qSIiFioumXsA8oKeSXmRNh/1hNjdswhtNnxi9
 FRmdK7+X6Sfe5cHadxw98XSLNTpjEtUs8wr4aA2J4/g3B2l2403PNYUNGOsBNZkHLdOc
 sajw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX61hOpl3e+c7Mobi+b5tO1z/MKLMaUCteIWfiSdWOXcacdzdr2T33qvFiAwcFmU+3tjLJDH/cEd/WzdeslA1c4aCGid1g=
X-Gm-Message-State: AOJu0Yx7RN3oQdD7B376czVoVHUOfYc9ayNgUYqSUweWBZ2AMoV74PZ9
 DYA/v4QQFnS2s2JxU66QJy1wu+ly/9vEbwRovgD1PVu08q9g26vAwdaba5rSNiCiGZZgCgDM+vt
 nd0hjfoZNB/P9PavVSmOEOtQyly9HvyWfZFxfag==
X-Google-Smtp-Source: AGHT+IGfoAtNDLzDzAInxg1ZgJmjhkcX3/d5drHWNzpYIfiTupXk3zlRYnQ233ArbuSybWfcZnHDD2DJIHKGNFl3Sg0=
X-Received: by 2002:a17:906:f358:b0:a55:aded:200d with SMTP id
 hg24-20020a170906f35800b00a55aded200dmr2430742ejb.12.1714039487634; Thu, 25
 Apr 2024 03:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240422142056.3023-1-philmd@linaro.org>
 <20240422170056-mutt-send-email-mst@kernel.org>
 <1f6447c4-ea4c-4bd3-a879-8efb72448bb8@linaro.org>
 <20240422170913-mutt-send-email-mst@kernel.org>
 <CAAjaMXZxFJtEdJh38_76ZdL82JBM52Ke0+p1K07miiFeQSJtcw@mail.gmail.com>
 <CAAjaMXaoPeCVpd=q-d2GH25SfrNPVqh6hCerMOrQ6payXVMmyA@mail.gmail.com>
 <f5c67478-4fb9-4fb9-a6b2-286d6372bd0a@linaro.org>
 <b9fb7a87-2328-4999-8f7e-6b6cf04984a3@ilande.co.uk>
 <CAAjaMXa00nWejPRc_Xc9fnoncXVDiWO9MNabwq-QU5nepA4b9w@mail.gmail.com>
 <fd6b0336-ecc7-4c0e-aa48-f8e984d293dc@ilande.co.uk>
In-Reply-To: <fd6b0336-ecc7-4c0e-aa48-f8e984d293dc@ilande.co.uk>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 25 Apr 2024 13:04:31 +0300
Message-ID: <CAAjaMXaBd8+DuNzeVO9k=6ojt5brt1nmm1gApdwgXJ3JzjisTA@mail.gmail.com>
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 25 Apr 2024 at 10:49, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 25/04/2024 07:30, Manos Pitsidianakis wrote:
>
> > On Wed, 24 Apr 2024 at 13:31, Mark Cave-Ayland
> > <mark.cave-ayland@ilande.co.uk> wrote:
> >>
> >> On 23/04/2024 12:05, Philippe Mathieu-Daud=C3=A9 wrote:
> >>
> >>> On 23/4/24 11:18, Manos Pitsidianakis wrote:
> >>>> On Tue, 23 Apr 2024 at 11:47, Manos Pitsidianakis
> >>>> <manos.pitsidianakis@linaro.org> wrote:
> >>>>>
> >>>>> On Tue, 23 Apr 2024 at 00:11, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> >>>>>>
> >>>>>> On Mon, Apr 22, 2024 at 11:07:21PM +0200, Philippe Mathieu-Daud=C3=
=A9 wrote:
> >>>>>>> On 22/4/24 23:02, Michael S. Tsirkin wrote:
> >>>>>>>> On Mon, Apr 22, 2024 at 04:20:56PM +0200, Philippe Mathieu-Daud=
=C3=A9 wrote:
> >>>>>>>>> Since VirtIO devices can change endianness at runtime,
> >>>>>>>>> we need to use the device endianness, not the target
> >>>>>>>>> one.
> >>>>>>>>>
> >>>>>>>>> Cc: qemu-stable@nongnu.org
> >>>>>>>>> Fixes: eb9ad377bb ("virtio-sound: handle control messages and s=
treams")
> >>>>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> This is all completely bogus. Virtio SND is from Virtio 1.0 only=
.
> >>>>>>>> It is unconditionally little endian.
> >>>>>
> >>>>>
> >>>>> This part of the code is for PCM frames (raw bytes), not virtio spe=
c
> >>>>> fields (which indeed must be LE in modern VIRTIO).
> >>>>
> >>>> Thought a little more about it. We should keep the target's endianne=
ss
> >>>> here, if it's mutable then we should query the machine the device is
> >>>> attached to somehow. the virtio device should never change endiannes=
s
> >>>> like Michael says since it's not legacy.
> >>>
> >>> Grr. So as Richard suggested, this need to be pass as a device
> >>> property then.
> >>> (https://lore.kernel.org/qemu-devel/ed134c9d-6e6f-465b-900f-e39ca4e09=
876@linaro.org/)
> >>
> >> It feels to me that the endianness is something that should be negotia=
ted as part of
> >> the frame format, since the endianness of the audio hardware can be di=
fferent from
> >> that of the CPU (think PReP machines where it was common that a big en=
dian CPU is
> >> driving little endian hardware as found on x86).
> >
> > But that is the job of the hardware drivers, isn't it? Here we are
> > taking frames passed from the guest to its virtio driver in the format
> > specified in the target cpu's endianness and QEMU as the device passes
> > it to host ALSA/Pipewire/etc which in turn passes it to the actual
> > audio hardware driver..
>
> The problem is that the notion of target CPU endian is not fixed. For exa=
mple the
> PowerPC CPU starts off in big-endian mode, but these days most systems wi=
ll switch
> the CPU to little-endian mode on startup to run ppc64le. There's also the=
 ILE bit
> which can be configured so that a big-endian PowerPC CPU can dynamically =
switch to
> little-endian mode when processing an interrupt, so you could potentially=
 end up with
> either depending upon the current mode of the CPU.
>
> These are the kinds of issues that led to the later virtio specifications=
 simply
> using little-endian for everything, since then there is zero ambiguity ov=
er what
> endian is required for the virtio configuration space accesses.
>
> It feels to me that assuming a target CPU endian is fixed for the PCM fra=
me formats
> is simply repeating the mistakes of the past - and even the fact that we =
are
> discussing this within this thread suggests that at a very minimum the vi=
rtio-snd
> specification needs to be updated to clarify the byte ordering of the PCM=
 frame formats.
>
>
> ATB,
>
> Mark.
>


Agreed, I think we are saying approximately the same thing here.

 We need a mechanism to retrieve the vCPUs endianness and a way to
notify subscribed devices when it changes.

 I think that then, since the virtio device is mostly certain of the
correct target endianness and completely certain of the host
endianness, it can perform the necessary conversions.

 I don't recall seeing a restriction on the byte ordering of PCM
formats other than the CPU order; except for the ones which have
explicit endianness in their definitions. Please correct me if I am
wrong!

A straightforward solution would be to set an endianness change notify
callback in DeviceClass. What do you think?

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

