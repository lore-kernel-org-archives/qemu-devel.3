Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A565C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u26Kf-0002zf-IO; Tue, 08 Apr 2025 06:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u26KY-0002xU-LQ
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:37:24 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u26KW-0007tv-Rk
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:37:22 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-47664364628so53667891cf.1
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744108638; x=1744713438; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SSd7JujKP98uknZpkgb2NpsEceKqZ4NoPf13pkdv/YY=;
 b=niY8TUfzW8M6+Cb4DkEa1I/UFMETWnePeOcHdotKgBB6oYUesSaG87ZupJfCzuixgv
 03012KhkGRqmcyPP7LarHHOeD6TK+frvPcvCiK9jWiNz21VZLrX2PYn/oNID4H5nWF4y
 SNSGuLxCiwCOYGBvxhKCn/gJdVPUBa382CtTeu4MHya50dwN/Rn20P/+kSl26nPFNSFC
 gO/EAV2s69p3bxiNYf8djHatrbYk161PpROlpjoeRLN2Kz2t4pzUbxyaQ6R4HU5Gh/m6
 Yk/bXEbKvtfnxptpm7xxA2CLrB4JkMqTDZjwwJ6gUDKxPUp9j9pxP8VHIU5ilKtV4vm0
 etLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744108638; x=1744713438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SSd7JujKP98uknZpkgb2NpsEceKqZ4NoPf13pkdv/YY=;
 b=wauV1BDthdXZeGFd+cMthsb4zI/Z9f/aXMA3XhL/EMrInnjls9RNKQD3uIbOg7JXj0
 ZMxEkP40p8k6n4rlymuLBBMs+fPwV6mfLngnsWnePHn7jjgCyKm2yYgjSSQV+VCAGO9v
 NNDP3EpdLRtV+CG6jq1BNONRLtne84OESEr0xcfoeDLcYoVZX8jSYc7TE3J7enxn6kWt
 Jkj3qcev4tXnymgl0auJExxvNxaDlbIcR9kF8v+xafXeAossZURPcQdcr4fRZ8AnaDwt
 FI+y8/C+QRnGVzhzzH0oknygyk3cELukxAXMqIe0Ror5eeM5FJabAe74t4h0WA6pbw7Y
 xsnw==
X-Gm-Message-State: AOJu0YwdutIoRgzfwbWUkjCelDiiAhu4n7gdC3SDuP5iw+EcESvo5Gfa
 ELy2pRElV5fx+NGKQz+2WIwfWtX0Mkmi7aJTwX8wpLqmFr9brpnnVGaRP6Il0eTfOZDGfe6NNDR
 gKSDEpFUUtIqnZp0huhBZjur/JuYJsw==
X-Gm-Gg: ASbGnctpeRdwhrsV1qq4FAe27Obr/rUUz4BrkycFBJYP/w6MqOYFKB5FWdasIVGdQSs
 2ijwT9oC/rT2u8TYtAqBa3kJn7IfIf/cbJkLl6Vdkp/P66SzD4F0gheSL57sRbfb8+V6gYiGOn/
 s6zDWfty33CaNLQ2NTOrYSooFeaNaBz9nLw83q3LSCiSIcfNdCrbLYB8U/js4=
X-Google-Smtp-Source: AGHT+IGMZeW0C2s1kbU/k8hdFSTeuoNL5E6I+sCYHwvVUIhLxfDZpzGnsj6sONyr7p+CNBYsuDPfqEenXEkBtI022H4=
X-Received: by 2002:a05:622a:1a9a:b0:477:84cd:a0c9 with SMTP id
 d75a77b69052e-47953ad0cc3mr40047721cf.0.1744108638491; Tue, 08 Apr 2025
 03:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250407105939.1997660-1-dietmar@proxmox.com>
 <20250407105939.1997660-2-dietmar@proxmox.com>
 <CAMxuvaxs+qM3msR-tdCXZfMZkQvHqNbHhHwhYKBPtRPLZGyuMA@mail.gmail.com>
 <1880642940.1156.1744105987725@webmail.proxmox.com>
In-Reply-To: <1880642940.1156.1744105987725@webmail.proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 8 Apr 2025 14:37:07 +0400
X-Gm-Features: ATxdqUFA9K8dqp1ZwXMcLLa2Xt8znEeiTQbxcy7Kb76Tk_6_iV6JDgNPfbc2rvQ
Message-ID: <CAJ+F1CKZUWEvJ54kF4J=pPuxZoozGcjB9H5KBJY+fzBrdLVBDw@mail.gmail.com>
Subject: Re: [PATCH 2/3] add vnc h264 encoder
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Tue, Apr 8, 2025 at 1:54=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.com>=
 wrote:
>
> > Please resend the series with a cover letter
> > (https://www.qemu.org/docs/master/devel/submitting-a-patch.html#use-git=
-format-patch)
>
> Ok, just resend this series with a cover letter and commit message.
> (patches unchanged)

ok, thanks

>
> > > +#include <gst/gst.h>
> > > +
> > > +static void libavcodec_destroy_encoder_context(VncState *vs)
> >
> > it's not libavcodec.
>
> I will fix that in v2.

What about encodebin suggestion?

>
>
> > > +#ifdef CONFIG_GSTREAMER
> > > +        case VNC_ENCODING_H264:
> > > +            if (vnc_h264_encoder_init(vs) =3D=3D 0) {
> > > +                vnc_set_feature(vs, VNC_FEATURE_H264);
> >
> > Before advertising support for the codec, it should actually check if
> > the encoder is present.
>
> ok.
>
> > It would also be useful to have an extra VNC
> > option like H264=3Don/off/auto.
>
> I thought it would be better to do that at the client?

Well, it can be worth it to prevent h264 usage from the server too. Or
to ensure the server is h264-capable. (this wasn't seen as much
necessary for other codecs that are low-resource and/or patent-free,
but may make sense too)


--=20
Marc-Andr=C3=A9 Lureau

