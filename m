Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED4FC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 17:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rShEM-0003pH-Ji; Wed, 24 Jan 2024 12:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1rShEF-0003l4-HH
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:40:00 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1rShED-0002Hw-Nm
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:39:59 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-429d2ebdf05so3691cf.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 09:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706117996; x=1706722796; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXTaes9a+DpnB/iregs+Axn1k2lzOZ8nIqaAsqGVNkc=;
 b=DEj4hP8rs28nBShVxNlL4Y0Fw6iKS0+MdIE/JZKJCTv8GVMqpXMZg/OLR1Z3sPWtpH
 g4oVWpLlRYwf7ChDgijcuentFpxFqK/rhiGIRak9Ns5tJOWoGVKyhyT5gPl4qj5Rl/9Q
 HxodKKcT0y6hGcXK2TYTwXR3ykaYxRXA+PAu1uQ8ADAET1qPKN/QCNttU4DQToyCUPUA
 0nzVycO/dcD84pdXy+kWIs0GELmPW04++7S5f6G4sNQApMk/c12m4sgBLc3zSpTjQSpX
 fpTfMvFb14F1P0SjmJpkSNfhTDOhec9qjUxNr04YjpnbYLAho0iKeStWkr3RU3xKSmjs
 rk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706117996; x=1706722796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yXTaes9a+DpnB/iregs+Axn1k2lzOZ8nIqaAsqGVNkc=;
 b=X/6uYYxpMEbEozSp8tiIjp+7nN1j9GF8n1a3azOR7HcBFSsxWRCyj+2Q7EFbvx2/uI
 Q5fG6ZOxONGIVS8srOorOcotNwHQ0kn8RMcAEgn6+YjXd/CJXKsPs6BM4e2v3Q5lftF9
 D+YBsNoXXcmg0FkrqlPPx3/KNEKgHR0GOeUuV8yCaQy7+Oi1lSyMdTKdVz5J1RSqp6EF
 UHYep9eQjwtOQHHFBw0PGraNMggyp0/YOlLgcZfMfDbMSs3RYplVjOi9GJ0k6q68tizc
 jpyXjcI2EnIox2duo7yBIZh95Y36z5px0pyWHhV+nYj/VRFZygEynycQAONExVe6Kh40
 UI+w==
X-Gm-Message-State: AOJu0Yw3zh3rS/32yTte1Nc0IvM6vA8MfTs+TfuQc3JuucILhcF1NgVs
 ttFjCcu6LYacbodGwI5o8mBhSHBN7tPFQn2asweemP1uhWxSj4Zx3bxLy/Od7k+gatl16zwTOz8
 6NkqSL9qIDQiwMW0mO4Jww/DuBu0EDSmHuvAy/EAat5C3QKeWPQ/N
X-Google-Smtp-Source: AGHT+IHVTUDl5HeBL8gOoHkniaoDDrUYhyn0JxDPM3kADBliPZ0ptXaZW9yHOKoqT5c9slkf8nOYtXFemlUJSGYunnM=
X-Received: by 2002:a05:622a:100b:b0:42a:6098:8122 with SMTP id
 d11-20020a05622a100b00b0042a60988122mr171591qte.3.1706117995919; Wed, 24 Jan
 2024 09:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20240110212641.1916202-1-komlodi@google.com>
 <ZZ/1J4q1TEFmc72P@mail.minyard.net>
In-Reply-To: <ZZ/1J4q1TEFmc72P@mail.minyard.net>
From: Joe Komlodi <komlodi@google.com>
Date: Wed, 24 Jan 2024 09:39:44 -0800
Message-ID: <CAGDLtxssLuFYutF-GUksbWmaOb7FCdhoOH-OdbfMEZ2Ma3Bu4A@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/i2c: smbus: Reset fixes
To: minyard@acm.org
Cc: qemu-devel@nongnu.org, venture@google.com, cminyard@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=komlodi@google.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Jan 11, 2024 at 6:03=E2=80=AFAM Corey Minyard <minyard@acm.org> wro=
te:
>
> On Wed, Jan 10, 2024 at 09:26:37PM +0000, Joe Komlodi wrote:
> > Hi all,
> >
> > This series adds some resets for SMBus and for the I2C core. Along with
> > it, we make SMBus slave error printing a little more helpful.
> >
> > These reset issues were very infrequent, they would maybe occur in 1 ou=
t
> > of hundreds of resets in our testing, but the way they happen is pretty
> > straightforward.
> > Basically as long as a reset happens in the middle of a transaction, th=
e
> > state of the old transaction would still partially be there after the
> > reset. Once a new transaction comes in, the partial stale state can
> > cause the new transaction to incorrectly fail.
>
> This seems wrong to me.  In a real system, the reset would be done on
> the smbus master and not necessarily on the mux (though I looked at a
> few of the PCA954x devices and they appear to have reset lines, but
> different systems may drive that reset differently).
>
> It seems to me that the bug is the smbus master device isn't getting
> reset in a system reset.  Just adding the reset logic there would be
> easier and more consistent with the real hardware.
>
> -corey
>
Oops, sorry, missed this in my inbox.

That sounds good to me, I'll send up a v2 that resets the SMBus master
instead of the mux.

Thanks,
Joe

> >
> > Thanks,
> > Joe
> >
> > Joe Komlodi (4):
> >   hw/i2c: core: Add reset
> >   hw/i2c/smbus_slave: Add object path on error prints
> >   hw/i2c: smbus_slave: Reset state on reset
> >   hw/i2c: smbus: mux: Reset SMBusDevice state on reset
> >
> >  hw/i2c/core.c                | 30 +++++++++++++++++++++++++-----
> >  hw/i2c/i2c_mux_pca954x.c     |  5 +++++
> >  hw/i2c/smbus_slave.c         | 20 ++++++++++++++++++--
> >  include/hw/i2c/i2c.h         |  6 +++++-
> >  include/hw/i2c/smbus_slave.h |  1 +
> >  5 files changed, 54 insertions(+), 8 deletions(-)
> >
> > --
> > 2.43.0.472.g3155946c3a-goog
> >
> >

