Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0B9C531F8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvxv-0004IP-Lr; Thu, 23 Jul 2026 12:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wmvxt-0004Hy-EE
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:08:05 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wmvxr-0007WH-F1
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:08:04 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6689f36ae56so996299d50.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 09:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784822882; cv=none;
 d=google.com; s=arc-20260327;
 b=dErpwYfkLk73PRjhK4h+8+NJbI4HzEBGNqV7IXIeg+15P/VsHuTOKo6LBgmkAmxW1I
 MBkXAJroFrmMyYhD1m+AaCZJEPTm4yMJLaZW0k4RhBwtwCsPQJAKt1NAgqX9EKUe60tW
 qNPK31guYsw68anbjL/BDTRiO60gz3Xhgt8eGZiJR35KocEcPCcxCT6Q+rTIuM5Kf0s+
 UJzewEcnSUpiBaDzzjx8qqpsHTywm2gCvrtRGcolGoNCAaXKcz0s+6fI/v9pWMulMbKc
 xAuA9Nr5U91lIsGRnHHZPAYjHIBIHJoSwv3siEOz9FEwu3H+DWh+mFWZwx9Zw/7m66+p
 kuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Vp/UAfBxtrNkqiFGWr8HdOUPysHpaod4R8kEC8Gjb40=;
 fh=gcwxmYuefGfJFGwl4Y4QoHgJrREB0HMtrQNy8AVp0Uk=;
 b=I0xPYHDaGkaavP5RT3qbmGh+0tqALDF6rJz9c6RCn5aiUM+5ilX9bjv5z+Uqb5+C6f
 uPg+3hauoUi7BG5+ypnmLhokeLPJG9yjm8rmTPUtw3moPPLGUBmMT7dWc+M9MMLDkEGs
 1vGbALMY31shpjpgOjr/dFlfE+mEoYx4C6uVou6ShqNS+35UFZQze/qWMfUn3u+dJCTa
 iP92UuIBZErI7jR2QFw1GH9wuCgZNkPznkdnFAkXK6dd1sZyIn+2XVYmBanmUuPTnY/I
 oEl5eEU+07aYHFuiD/q1TYS3R3PsKVLBGYZhG+K6YvYTz8kUbSfuUIVpmis+Sj1c7pMO
 TSVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784822882; x=1785427682; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vp/UAfBxtrNkqiFGWr8HdOUPysHpaod4R8kEC8Gjb40=;
 b=BMMgzEHem2ZR4VM+CGt+ZK9keLlzVzKSXs1wiLRL2zK0t0cP4VL3y1FtdKsfrxZ43o
 vWAiLnHFYoFodz0U+Bb1sjlqI4LKtZwpTBi+LEZG3hxzwvYWZ3K5mUY4uRZUCf/+gEzS
 z64eCk5+4yMGauFlF7/znd30P1RiMwkN+/xosrNrAV01/LiIRu620qcxsIkmZDYVjzZg
 cB70Zv1I6wbPk2LMAri7WmcVD+SaLw7RUitkSAgvsiyhw3ErwX416l+/NwND4IszGuCi
 /B81mDyMLlw8pchxZgkn9CLSzOOPmMUqEiWw7pKN8ugO4iKBbHwdqThov3CjwV+jlhzz
 4gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784822882; x=1785427682;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vp/UAfBxtrNkqiFGWr8HdOUPysHpaod4R8kEC8Gjb40=;
 b=Uqc/efv6xa3rql5xwWQtxm/0LnaqFQaXKNQcqFSNyV5kj8WrCHRNLcHbYh6X6KDlCo
 uiE/NvFKcsf5JNg5kTUPGsSOGPqpE3HwSJPG3J9u3p+Ee/NSPBOxtYYEMETsDmc9cm9f
 /9DD5Nu/gLWwqLgl32xOomjps00xqcfsr0PtSE901qQHwv/9HILIev6hlK5Ss8l9/3dm
 svPNLdDuZ+RmrjxLcbgCU/rG57Vui6KpT01S6i/qduT7y49dauO7bS74ZbMOQcPMsiCD
 78YWRfhQn92g087j3Rn7Mklw5dFjGECJ1IVKZ1MPtnReWZcvw1JY456wpLR5ZQIUXyFC
 4TvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqj2HbRQs1lTxvblEQ+y8kJXpx3xtmlrrKDejhipt8oMnN0O3/2YHoGZoR/zJNmiePb+WZPHqtrYWu6@nongnu.org
X-Gm-Message-State: AOJu0Yw/bvkoteCGHSSV+k/ZQ4eJE3Dm90/k5cLDwGNWKdeOj6CxTVZV
 GxT/MODgw0MmdXVtDW9bqnPAAgZGOw453F4GZ3798ZRDtXbRFbf1lPDlFzxNwnfXD9ojowZxcOz
 gUfkuwEHKgy/nl4aWygr2Bilpki0D0Xc=
X-Gm-Gg: AR+sD11PyEfvOPjtsxn3QByyoZUpUcRCFX6V0u/Owh+doyJaNkq56ZKcyXQHGyg4PZs
 p8WxnQMQfG+K21mh2QZ9teVgieHHic1LWyNym4qOmlaVQxwaGDt7dYUzLDY6RrYNxCwYZ5w3bv6
 hRCR3eCupzi/C0h+abStlpqQl4fd2zAY950AgGngJ31WVTUXe6q//sLMn1CZHk0JOiVsu5GBifx
 iLGvfEAoljSfU9KVp4fnaktlix/agH6eFNQb21ZLFAS80aqsRnpBQ6S24hN9V97aUsJGziY
X-Received: by 2002:a05:690e:1583:20b0:667:d808:af7d with SMTP id
 956f58d0204a3-668a4bae19fmr849846d50.14.1784822881671; Thu, 23 Jul 2026
 09:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-17-bin.meng@processmission.com>
 <20260723-seducing-plunging-ef7d4c60d917@spud>
 <CAEUhbmVYdwUbp_y8TKZggoz7oNRWo7+sfe1Q+vbqApawp7jEmg@mail.gmail.com>
 <20260723-sliding-plural-bf980dc1e567@spud>
In-Reply-To: <20260723-sliding-plural-bf980dc1e567@spud>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 24 Jul 2026 00:07:49 +0800
X-Gm-Features: AUfX_mx_3-qV5-6YKA0203tBzlND2xWQFxjH3QqwMXHNVbrbPC2l9RaiC5nat74
Message-ID: <CAEUhbmUVQ5M4Gw_viYq3BShCYCuA1HCDufKy9xV+TmfWKbpv8w@mail.gmail.com>
Subject: Re: [PATCH 16/26] hw/rtc: Add PolarFire SoC RTC model
To: Conor Dooley <conor@kernel.org>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 23, 2026 at 11:58=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Thu, Jul 23, 2026 at 11:55:03PM +0800, Bin Meng wrote:
> > On Thu, Jul 23, 2026 at 11:29=E2=80=AFPM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Thu, Jul 23, 2026 at 11:18:43PM +0800, Bin Meng wrote:
> > > > The PolarFire SoC exposes an RTC with binary and calendar modes,
> > > > programmable prescaling, alarms, and wakeup and match interrupts.
> > > >
> > > > Add a standalone device model with explicit MMIO handling for time,
> > > > commands, alarms, interrupt state, reset, and migration. Add its
> > > > Kconfig and Meson entries and list it under the PolarFire SoC
> > > > maintainer section.
> > > >
> > > > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > > > +
> > > > +#define RTC_REG(offset) ((offset) / sizeof(uint32_t))
> > > > +
> > > > +static uint64_t mchp_pfsoc_rtc_get_count(MchpPfSoCRtcState *s)
> > > > +{
> > > > +    if (!s->running) {
> > > > +        return s->frozen_count;
> > > > +    }
> > > > +
> > > > +    return s->tick_offset +
> > > > +           qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
> > > > +}
> > >
> > > Just to be sure, this is done to match the hardware's behaviour of
> > > resetting the count when the device is power cycled?
> > >
> >
> > Yes, the rtc_clock + tick_offset scheme is commonly used by other QEMU
> > RTC models, such as PL031, etc. It is not specifically intended to
>
> You say "yes" here, but the rest of the sentence is addressing something
> I did not ask so it is not clear if you actually mean that this matches
> the hardware's behaviour.
> Could you clarify please?

I mean yes this formula is commonly seen across all other RTC models.
The resetting of the RTC model is not controlled in this routine here
but in mchp_pfsoc_rtc_reset(). Currently the counter is reloaded but
maybe it should be left as it is and just initialize once.

>
> > model the counter being reset on a power cycle. Instead, it maps
> > QEMU's clock source to the guest-programmable RTC counter value.
> >

Regards,
Bin

