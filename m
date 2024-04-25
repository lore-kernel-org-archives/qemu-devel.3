Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBFDC10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 06:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzsdp-0007B2-7y; Thu, 25 Apr 2024 02:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rzsdS-00078s-Fs
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 02:31:11 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rzsdP-00074v-2f
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 02:31:10 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a58772187d8so64672966b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 23:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714026664; x=1714631464; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYqxWEbLSrcYijpknte7PN8iRVmpQEttDAYSUsMkhfk=;
 b=YcImAkKOAF4jpz38ZWMBYFpyFhLjcVHaL+qnpTWw9q4TaXvCSRytzaPYnF/AY350SS
 2agcxO8PfPoPCKJmAHDU/UcwvZpR9Oi+vvlSAyS09Kn07iqg6x3tt9cw6OXDjeaDosyZ
 52MuxPQsE9xBdT349wk0qals2VDl2wqqXFJxYZZieOWEBPWu79RQWKX/SYw5jeqG5+oU
 taNfBFp2DzZS33zfd/+KuG08GRPb7Mzfalvl9s1nZaGvWOAMprK8cDAje3dPZM4lFcvw
 +19MHN5NEAJDh8ELUaMYygTKRiFxqRqGM6IAj4ZZuTTRQ3RZUGP4LI8NhfSvXc4ssjPe
 x8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714026664; x=1714631464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pYqxWEbLSrcYijpknte7PN8iRVmpQEttDAYSUsMkhfk=;
 b=Fvy09z9JjcrJVVOAMdmHCin4EgkB/WK3LKBqI7HQgG0LGiO6UCUb2h5OGNbnhzxsxS
 DTTFgG5qyVWbrKS9fMetpt8wdwdbwcJeVkkX34iYzKZFftNaX+8Ao4nkAu0/29K/e0/t
 G/1SjKjNAW3hdgCvoAspa314zHXPhO/WDU2jd0j2dxYmag4lY8ZcjAOqiLzWanQ0vC9K
 E1lbwwIJNC1QUGjkj02bM4Dp2zKBcKO9Xgu//eLskgpZVTMp0srfTgZyhM0Bn7KexqeC
 tq2KDzV89BJ9N9DPU+McvKzxai824vLYIM89PkZEbN9iXtpUb/OFfMpdemRwwaQkrpEv
 6o5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu702LuXSNwXo91ceZewrx5VCapuAfd2+Sc5W3PeP4HDPFlYoC8R3f7OOXLXLBkpUfIt6kR/oMdDI9fB8ziVN9dA5vz+Q=
X-Gm-Message-State: AOJu0YxdKFZyzJUYff4IZ19Q9nswLnT/90P8ctBkvrtYm/AdbXJaJg6Y
 D7YH4TZQWIDicwuprF7/NLpiyvlt6aY5ZgrBwKR6nMc3Vv0Gclf5zg46xGwq/nFCEpcmVmSjkWJ
 HzkI49YaTrTQqO6gaDT3NYpHCw/YGFzP9b/Gn4Q==
X-Google-Smtp-Source: AGHT+IG/elVwNYQElwd3Q9Q2fJ3NboyH9yfheh6eXSMwesrpsst2PRkvGmbiBIQQGt25VbB/Gba4UaR+aYzGs99We50=
X-Received: by 2002:a17:907:2685:b0:a55:a1d4:84f5 with SMTP id
 bn5-20020a170907268500b00a55a1d484f5mr4374281ejc.43.1714026664174; Wed, 24
 Apr 2024 23:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240422142056.3023-1-philmd@linaro.org>
 <20240422170056-mutt-send-email-mst@kernel.org>
 <1f6447c4-ea4c-4bd3-a879-8efb72448bb8@linaro.org>
 <20240422170913-mutt-send-email-mst@kernel.org>
 <CAAjaMXZxFJtEdJh38_76ZdL82JBM52Ke0+p1K07miiFeQSJtcw@mail.gmail.com>
 <CAAjaMXaoPeCVpd=q-d2GH25SfrNPVqh6hCerMOrQ6payXVMmyA@mail.gmail.com>
 <f5c67478-4fb9-4fb9-a6b2-286d6372bd0a@linaro.org>
 <b9fb7a87-2328-4999-8f7e-6b6cf04984a3@ilande.co.uk>
In-Reply-To: <b9fb7a87-2328-4999-8f7e-6b6cf04984a3@ilande.co.uk>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 25 Apr 2024 09:30:48 +0300
Message-ID: <CAAjaMXa00nWejPRc_Xc9fnoncXVDiWO9MNabwq-QU5nepA4b9w@mail.gmail.com>
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 24 Apr 2024 at 13:31, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 23/04/2024 12:05, Philippe Mathieu-Daud=C3=A9 wrote:
>
> > On 23/4/24 11:18, Manos Pitsidianakis wrote:
> >> On Tue, 23 Apr 2024 at 11:47, Manos Pitsidianakis
> >> <manos.pitsidianakis@linaro.org> wrote:
> >>>
> >>> On Tue, 23 Apr 2024 at 00:11, Michael S. Tsirkin <mst@redhat.com> wro=
te:
> >>>>
> >>>> On Mon, Apr 22, 2024 at 11:07:21PM +0200, Philippe Mathieu-Daud=C3=
=A9 wrote:
> >>>>> On 22/4/24 23:02, Michael S. Tsirkin wrote:
> >>>>>> On Mon, Apr 22, 2024 at 04:20:56PM +0200, Philippe Mathieu-Daud=C3=
=A9 wrote:
> >>>>>>> Since VirtIO devices can change endianness at runtime,
> >>>>>>> we need to use the device endianness, not the target
> >>>>>>> one.
> >>>>>>>
> >>>>>>> Cc: qemu-stable@nongnu.org
> >>>>>>> Fixes: eb9ad377bb ("virtio-sound: handle control messages and str=
eams")
> >>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> This is all completely bogus. Virtio SND is from Virtio 1.0 only.
> >>>>>> It is unconditionally little endian.
> >>>
> >>>
> >>> This part of the code is for PCM frames (raw bytes), not virtio spec
> >>> fields (which indeed must be LE in modern VIRTIO).
> >>
> >> Thought a little more about it. We should keep the target's endianness
> >> here, if it's mutable then we should query the machine the device is
> >> attached to somehow. the virtio device should never change endianness
> >> like Michael says since it's not legacy.
> >
> > Grr. So as Richard suggested, this need to be pass as a device
> > property then.
> > (https://lore.kernel.org/qemu-devel/ed134c9d-6e6f-465b-900f-e39ca4e0987=
6@linaro.org/)
>
> It feels to me that the endianness is something that should be negotiated=
 as part of
> the frame format, since the endianness of the audio hardware can be diffe=
rent from
> that of the CPU (think PReP machines where it was common that a big endia=
n CPU is
> driving little endian hardware as found on x86).

But that is the job of the hardware drivers, isn't it? Here we are
taking frames passed from the guest to its virtio driver in the format
specified in the target cpu's endianness and QEMU as the device passes
it to host ALSA/Pipewire/etc which in turn passes it to the actual
audio hardware driver..



> My feeling is that either the VIRTIO_SND_PCM_FMT_* constants should be ex=
tended to
> have both _LE and _BE variants, or all frame formats are defined to alway=
s be little
> endian.
>
>
> ATB,
>
> Mark.
>

