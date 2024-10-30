Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88238D5CCA8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 12:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t689Z-0003Z9-Nk; Wed, 30 Oct 2024 08:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1t689O-0003Yc-KT
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 08:50:14 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1t689L-0006M0-Bj
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 08:50:14 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e2b549799eso5017226a91.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730292609; x=1730897409;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/aF3DvWgIw8mU8q89qCDaYFP3Mb8iGTlwiqL9cn51M=;
 b=gG8nsKP20rddXFdcYklkVvInlOvl4EKGszXLjCmgf5kS4TqRBkDSXQkjw7nvzYpiDA
 y6Xsz0cVZm9WRF2UsYtQ56GJuI+0g6n9uKs3rkmv527ZzmOKMPF/aYb4F0HhPVd/7+1V
 dhbs5JrzVnafg/KmCQ+VQ61aazOLFtMaBvnadFQ5Z5c+qNkdZjTc9CDihBQknDH6oX/S
 YmcR0FuXwdPmTpUNxZJ23uKasBoBOBZkhzC5EWMO3G305c6ehUpcpF3cSak11m7EaGEX
 YyLjDAI801hXU3aVzSK+RIZswLSkb90Cu5bki4UWItlumLbLthRc6LK1ZCMg9feE+uwy
 xqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730292609; x=1730897409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/aF3DvWgIw8mU8q89qCDaYFP3Mb8iGTlwiqL9cn51M=;
 b=hRFASXEpGjf9QwelglNtNGE744rWWvbNO+3a9VVAefaukn6D5D165P1iYT2cONBxDI
 tYfStaBnrWXToyeX9i5N28XyRUQhWcRMlae0VK3iODd0XgHN3BBIyV5uVHUs/cU0Dlmp
 kH9jPsB5zaoHczh7ovB9s8jsk27HcrSC7G1jWwdNv6PL5t9T9Eo1XhUsHFI6GSh1+NI0
 ZTzQGyUh2vwX57TlyEa8XMEVAZ2qP37q+TMKFSuftLH3jjHsXcclg34l3NzdD46ScJo+
 5Zdxso2GEJ8ik4bNkhdkZvLL90vXvOAfJ4qr1DXfjdUWvrGGdNbOhEa0GOSWvylUb9rv
 KJQA==
X-Gm-Message-State: AOJu0YwDGsNzoKXDpK3bcVyauQBHccMeWwHDbxEcdqe7AVPE+M5Lbzc7
 pDKpEXEPkZGN9b8gjXhJkhLF49idiDrFD/mSKUrS8MdmjwTMRZn0pBEWZBo+r9xtCZL6qNsiZTs
 FbA/6eH484bqPlRaEjaFFS+UZiKJg+sXyfHBZ
X-Google-Smtp-Source: AGHT+IGj0XtRjcFZ7xFzEF3Dn96cQqMjc3ELL5eIcOpTIO2IB0PcqsIqJ9sIM87H3SVyrgqTxi3nzPB4dEAODy/ZPRE=
X-Received: by 2002:a17:90a:1fc3:b0:2e2:9077:a3b4 with SMTP id
 98e67ed59e1d1-2e8f105562bmr17060874a91.7.1730292609090; Wed, 30 Oct 2024
 05:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <CANto9c6QV-KAuUau_CqK-rVsyNB=42HQ3AHuQPn34yMs2-iPkg@mail.gmail.com>
 <20240818063344.6969-1-wsh@wshooper.org>
 <CANto9c5u+-Wg+XPxu4CCEE733MuXJbL35nWgTEPxk9y12PH7mA@mail.gmail.com>
In-Reply-To: <CANto9c5u+-Wg+XPxu4CCEE733MuXJbL35nWgTEPxk9y12PH7mA@mail.gmail.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Wed, 30 Oct 2024 13:49:57 +0100
Message-ID: <CAGCz3vsusRSsT8-Fi3a2Z4aeQMtxCzDZ73D8ZgefxVZvm=qY6Q@mail.gmail.com>
Subject: Re: Ping: [PATCH v2] net/vmnet: Pad short Ethernet frames
To: William Hooper <wsh@wshooper.org>
Cc: qemu-devel@nongnu.org, Bin Meng <bin.meng@windriver.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2607:f8b0:4864:20::102a;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

On Sun, 20 Oct 2024 at 05:17, William Hooper <wsh@wshooper.org> wrote:
>
> On Sat, Aug 17, 2024 at 11:33=E2=80=AFPM William Hooper <wsh@wshooper.org=
> wrote:
> > At least on macOS 12.7.2, vmnet doesn't pad Ethernet frames, such as th=
e
> > host's ARP replies, to the minimum size (60 bytes before the frame chec=
k
> > sequence) defined in IEEE Std 802.3-2022, so guests' Ethernet device
> > drivers may drop them with "frame too short" errors.
> >
> > This patch calls eth_pad_short_frame() to add padding, as in net/tap.c
> > and net/slirp.c. Thanks to Bin Meng and Philippe Mathieu-Daud=C3=A9 for
> > reviewing an earlier version.
> >
> > Signed-off-by: William Hooper <wsh@wshooper.org>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2058
> > ---
> >  net/vmnet-common.m | 22 +++++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/vmnet-common.m b/net/vmnet-common.m
> > index 30c4e53c13..bce1cc590d 100644
> > --- a/net/vmnet-common.m
> > +++ b/net/vmnet-common.m
> > @@ -18,6 +18,7 @@
> >  #include "qemu/error-report.h"
> >  #include "qapi/error.h"
> >  #include "sysemu/runstate.h"
> > +#include "net/eth.h"
> >
> >  #include <vmnet/vmnet.h>
> >  #include <dispatch/dispatch.h>
> > @@ -147,10 +148,25 @@ static int vmnet_read_packets(VmnetState *s)
> >   */
> >  static void vmnet_write_packets_to_qemu(VmnetState *s)
> >  {
> > +    uint8_t *pkt;
> > +    size_t pktsz;
> > +    uint8_t min_pkt[ETH_ZLEN];
> > +    size_t min_pktsz;
> > +
> >      while (s->packets_send_current_pos < s->packets_send_end_pos) {
> > -        ssize_t size =3D qemu_send_packet_async(&s->nc,
> > -                                      s->iov_buf[s->packets_send_curre=
nt_pos].iov_base,
> > -                                      s->packets_buf[s->packets_send_c=
urrent_pos].vm_pkt_size,
> > +        pkt =3D s->iov_buf[s->packets_send_current_pos].iov_base;
> > +        pktsz =3D s->packets_buf[s->packets_send_current_pos].vm_pkt_s=
ize;
> > +
> > +        if (net_peer_needs_padding(&s->nc)) {
> > +            min_pktsz =3D sizeof(min_pkt);
> > +
> > +            if (eth_pad_short_frame(min_pkt, &min_pktsz, pkt, pktsz)) =
{
> > +                pkt =3D min_pkt;
> > +                pktsz =3D min_pktsz;
> > +            }
> > +        }
> > +
> > +        ssize_t size =3D qemu_send_packet_async(&s->nc, pkt, pktsz,
> >                                        vmnet_send_completed);

Nit: Move the declaration of 'size' up to the function header with the
rest of the variables for consistency.

Apart from that:
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>


> >          if (size =3D=3D 0) {
> > --
> > 2.37.1
>
> Ping?
>

