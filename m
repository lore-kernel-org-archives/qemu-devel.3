Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4009BFA1FE8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdAW-0003UH-HV; Wed, 22 Apr 2026 15:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wFdAR-0003Tm-F3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:23:23 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wFdAP-0007Gy-Bg
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:23:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b2589c26e3so52905305ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776885800; x=1777490600; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SuwjZ5Y3pQdTT7osz6mAAFkp5K7vr2u8osvSou81iI4=;
 b=gS5CpyYUPVq6WlOkJWAUz/qbx4xusrAlMIs+PqusIW0kVcAqJBI/wvFH0rt5bijNqQ
 p2yBVKrzNjnpFwUIukTO15M5DZFF5CmxuHL+yaZuAfircr1w8MZGQaH/jozd5qTq+5gm
 iujSIdoVPfLsuI4hbLH6k6lEWMLQYSKOVl/uu5Gfnjkz74Hb8ncCQA9vO9uKgDP8yBJk
 UCUUg2x8e+f2OeVdtNd+nfce2SfTOx5KQLKWq8+1imy7T93p0H7TQVx9cwJshwkcSgxc
 r9GNpIKV30IRejGqe4se6xASnwyd/5TbytU6DdL2EuVbsyZbPR1JRMHwFZCOMdhRAb96
 AmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776885800; x=1777490600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SuwjZ5Y3pQdTT7osz6mAAFkp5K7vr2u8osvSou81iI4=;
 b=q5W+wDc7rStSH/d9iNx11b3DhdEVO9c3cGUm/Ou+Y6viIhf2yVYEy86GZ3OHnkXdWl
 NGpKykzwLAJR8gdJeoKmf1VlRRD1HXCK3pavDl5WwjPxnpW/iI1+sa4ZhGBOnXZauhFT
 tL3+BdkzO+vogpCNpSdr9QygoYn05Kpk1q09IbHwGbqkUf6K2bzV4XhHiLC9nizQyvEf
 p0ZGMeKuWa/F2bwg8xPwREojbRhi4ihmaOu+xDFuJhCmqS+Qdo9nBp09WauTs1xrVzsu
 +M4L9c4z0O97AdEoOQVTKndF98nYDzV4h6jldAmAQHf1gJN7d/YXKfcDvOGALL2jQSCE
 vUDw==
X-Gm-Message-State: AOJu0YwFpBBCbilov44pjPss2VjF0NbXk0OEWikIh9vzT/g7SYHtuGsP
 8VbVeQNp4CSdOo9RRxiu9txUqZU8aUn1hxRyPhZ33rLKHL+bZxkOI2rS
X-Gm-Gg: AeBDietkTAjqio3+CcLE2B6GJMAQ1Jbfe4YTOnJUtqHgeEdA7hj3ukDE0CTz7eFocZi
 CwxFCj1xvYY7f1qrAGqwaxr70Yo6oViCuf5Raa/MCANXuT7Zm5K40jFRU2W/eLSK7R4jDEB201P
 D/bVj4U0TraTNbi+WdfQ3+5IBD3WqYPas5tBEtMveUIbLs5am1XCEOkFS/sbUiQDNnyU4jDA2bm
 y1Av/QUUFc2gIc0uE8mzE99stYSZUZ0vuAFt62awtpfBuoWIklHvGFhmQdv30Vvph7YmV6v0cAQ
 R+JKP5IUGcuLW00whmujc9IWfTJ3lKVbsb06HWcOzd8VyjGdx2urNz/2iK6MLkOxnNGFkfSR/Pj
 FwfCqzXD7kIYZWdOPGOTBGi+xjiMSn5KHm2P+wdBgMjmP/SNB0sP+TeAidBDMcLQ5Etr6Qi6z5A
 uBBrSgKv5qjFbTxOGJmfWQaKtOjuTp0QK0NnyR4t1DSlFp
X-Received: by 2002:a17:902:7c0f:b0:2b2:b117:1e16 with SMTP id
 d9443c01a7336-2b5f9f7e95fmr180844305ad.20.1776885799648; 
 Wed, 22 Apr 2026 12:23:19 -0700 (PDT)
Received: from localhost ([42.114.219.141]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa32ad8sm178851765ad.31.2026.04.22.12.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:23:18 -0700 (PDT)
Date: Thu, 23 Apr 2026 02:23:13 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] chardev/msmouse: save and restore device state for
 migration and savevm
Message-ID: <izunxfckxpm3tcsb5zzbxpwjzfz6goldhtgsofoedfpfngc5fh@eqa4ojekufcl>
References: <20260418115230.17809-1-viking4@gmail.com>
 <CAFEAcA9yq2RH226fx5vybumH=fjosPVgMSvigauAz=OK8-RWQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9yq2RH226fx5vybumH=fjosPVgMSvigauAz=OK8-RWQQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Apr 18, 2026 at 04:13:55PM +0100, Peter Maydell wrote:
> On Sat, 18 Apr 2026 at 12:53, Trieu Huynh <vikingtc4@gmail.com> wrote:
> >
> > From: Trieu Huynh <vikingtc4@gmail.com>
> >
> > MouseChardev holds state that must survive migration and savevm/loadvm:
> >
> >   tiocm   - serial line control (RTS/DTR).  When zero the mouse is
> >             considered powered-off and all input events are silently
> >             dropped.  Losing this field after migration leaves the
> >             mouse in a dead state: the guest driver must toggle
> >             RTS/DTR again to re-detect the mouse, which most drivers
> >             (Linux sermouse, DOS ctmouse) only do at initialisation.
> >
> >   axis[]  - accumulated X/Y movement not yet encoded into a packet.
> >
> >   btns[]  - current button state.
> >
> >   btnc[]  - per-button change flags used for middle-button tracking.
> >
> >   outbuf  - Fifo8 of encoded mouse bytes waiting to be delivered to
> >             the serial port receive FIFO.
> >
> > Add a VMStateDescription covering all five fields, registering it in
> > msmouse_chr_open and unregistering it in char_msmouse_finalize.  This
> > follows the same pattern used by ui/vdagent.c
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1234
> >
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> 
> > @@ -263,6 +279,7 @@ static bool msmouse_chr_open(Chardev *chr,
> >                                              &msmouse_handler);
> >      mouse->tiocm = 0;
> >      fifo8_create(&mouse->outbuf, MSMOUSE_BUF_SZ);
> > +    vmstate_register_any(NULL, &vmstate_msmouse, mouse);
> 
Hello Peter,
Thanks for the detail feedbacks. I've spent time to check your
concerns.
> Adding a new use of vmstate_register_any() is a bit
> unfortunate -- this is supposed to be a legacy function.
Agreed. Thanks for the point.
> 
> More generally, it seems odd that the chardev has any state
> that needs to be migrated at all. The chardev should have
> state corresponding to the host's situation, which is all fresh
> for the migration destination. State corresponding to things the
> guest has or has not done ought to be in a device model somewhere,
> surely?
> 
> Put another way, why is this msmouse code in chardev/ and a subtype
> of TYPE_CHARDEV, and not a device in hw/input that's a subtype
> of TYPE_DEVICE? I guess that the idea is we want to be able to
> plug it into any UART device, but that seems to have some issues
> when it comes to migration. wctablet is probably in the same boat.
You're right to concern.
When at this point, IMHO we can either
- add TYPE_VMSTATE_IF to TYPE_CHARDEV as a preparatory patch, then
use vmstate_register() here and in wctablet.
- or follow your suggestion more fully: move MouseChardev into
hw/input/ as a TYPE_DEVICE subtype, attach it to the serial port via
the existing interface, and use dc->vmsd for migration. wctablet could
follow the same pattern.
The later is architecturally cleaner but is a bigger refactor. OTOH,
the former is minimal but still adds vmstate to a chardev, which
you've flagged as conceptually wrong.

Which direction would you prefer? Happy to go either way.
> 
> -- PMM
BRs,
Trieu Huynh

