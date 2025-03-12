Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D6DC28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMz2-0001a9-4k; Wed, 12 Mar 2025 10:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsMz0-0001Vj-Na
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:22:54 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsMyy-0002kD-RR
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:22:54 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e4419a47887so5316731276.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741789371; x=1742394171; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=upYZflBtbp3LTMXlSsDXzvwbnhvBR9tGhMHw/rAPqao=;
 b=aqEw0UxwmYmPnCzPbpvWe+WUbIrLIW4P7fDf7Du4VJnyX6KS4AScioLwAHOUMwDfKf
 +lx4p7taxuR/L8CyFFfhj1cZuWGQvHkD7SdNzJdpu1mCJjaHgDF0TRVpwkv+vi9bXh0w
 06LE17jjTVuODFb4XeWL8Fv3WWNzkDwSjKYCZDVEpdVcnoXwecJhzipm26QAtSWzIZRz
 F1NwBjwhXe0X/pO3MpxdsAHabFzrQjZ4s7t8g1oWV62V0CBapkSDGic11SKvbzKtO8Pt
 a7xiHSSSOOkgT6pn+G6BUmlhinxs9Iom2spupF00AHRdtT0IdUF7tmDWgJyuvMercvZ4
 b7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741789371; x=1742394171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=upYZflBtbp3LTMXlSsDXzvwbnhvBR9tGhMHw/rAPqao=;
 b=c6EGaUNsb3j5HGoqEPy9PP/OPzoe+Cb/exFmzLZY5TEUXWqSMkyiYrL6VtibmBcDxQ
 ovFHfRwL8ZsknEL1jaAXNGpDgGewjNKUYvUzG/pF1il4aI1sO3EZzQSJI+vC6y7A3s7n
 LV0fK8xJE2ULVThxMpeS/QfaoG9qBygz2zlf7vJXuQpzGL2VXyEESDUPkVmqTh9W34OJ
 LJPlQ/x2ZOliwzJ+4uvJfRHypaB4t6cBvBZo47vBFDxor5vOn7VZDKc7bRxdNPOvYBMG
 DiWyN5VfKfiq4EJzYs53gpQJfwsEkEosrrB4uf84opPherq/c2eeWaJbHkKnse2LLFH3
 UHiQ==
X-Gm-Message-State: AOJu0YyffDNioAXP26UW6jmtPjDqmNSgfWuY+Qo9/rLyRce+aZxubeuK
 /+EQobpF1eUrkwMDAMS7zVEi50/4qdrljS5P3kFkiQ5c2sp4lR7q6U5Q7Srep1Ab98pJqGyWHOy
 Vt+vZNuLLtPSSWj+MqDmypZQ9Ob9zc04X65WP0A==
X-Gm-Gg: ASbGncudgKOAW+2qsQUbZLrDAQimKV2AC6jFBYF5bHL4Ao21DICTaweZ/Hu+opxSDBm
 zhyGunaERV/Jlg3IJOVX8+jTue1RZEU9GN5v8djfHP0Yu+/g7yK1JCmpKd8fl+3EtDwMa90bnhB
 JQXtmYm1HzzrLXv4gc6+SOj4dqIPM=
X-Google-Smtp-Source: AGHT+IH9FcO0JXQvOwy2kVJxMYZlbkxaXhuGgi7ouxV/+qoSjLiSNKHMsQMbhbtEULHWuwY9/ZI+8XlUf5G2xaA3quM=
X-Received: by 2002:a05:6902:983:b0:e5e:700:92f5 with SMTP id
 3f1490d57ef6-e635c1008c7mr32070121276.2.1741789370921; Wed, 12 Mar 2025
 07:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250311153717.206129-1-pbonzini@redhat.com>
 <CAFEAcA-TVaickhbxJ6d4Sc_Wi8HUuzKCaJTGHrNY6X3FcGvrfg@mail.gmail.com>
In-Reply-To: <CAFEAcA-TVaickhbxJ6d4Sc_Wi8HUuzKCaJTGHrNY6X3FcGvrfg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Mar 2025 14:22:37 +0000
X-Gm-Features: AQ5f1Jo0ih_I4s9hBZOC3oKtkSGRthAMEw4vb6qqqYkfDgkz0_NZI0P-gaGpWDI
Message-ID: <CAFEAcA_9XAH4bQJKAp2+NLinUXXiFb_ae3AtQ9wEEK4CrDK7Aw@mail.gmail.com>
Subject: Re: [PATCH] Revert "hw/char/pl011: Warn when using disabled receiver"
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Wed, 12 Mar 2025 at 13:36, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Tue, 11 Mar 2025 at 15:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The guest does not control whether characters are sent on the UART.
> > Sending them before the guest happens to boot will now result in a
> > "guest error" log entry that is only because of timing, even if the
> > guest _would_ later setup the receiver correctly.
> >
> > This reverts commit abf2b6a028670bd2890bb3aee7e103fe53e4b0df, apart
> > from adding the comment.
> >
> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  hw/char/pl011.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> > index 23a9db8c57c..efca8baecd7 100644
> > --- a/hw/char/pl011.c
> > +++ b/hw/char/pl011.c
> > @@ -85,7 +85,6 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, =
Chardev *chr)
> >  #define CR_OUT1     (1 << 12)
> >  #define CR_RTS      (1 << 11)
> >  #define CR_DTR      (1 << 10)
> > -#define CR_RXE      (1 << 9)
> >  #define CR_TXE      (1 << 8)
> >  #define CR_LBE      (1 << 7)
> >  #define CR_UARTEN   (1 << 0)
> > @@ -490,16 +489,9 @@ static int pl011_can_receive(void *opaque)
> >      unsigned fifo_depth =3D pl011_get_fifo_depth(s);
> >      unsigned fifo_available =3D fifo_depth - s->read_count;
> >
> > -    if (!(s->cr & CR_UARTEN)) {
> > -        qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "PL011 receiving data on disabled UART\n");
> > -    }
> > -    if (!(s->cr & CR_RXE)) {
> > -        qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "PL011 receiving data on disabled RX UART\n");
> > -    }
> > +    /* Should check enable and return 0? */
>
> We decided deliberately not to check the enable and return 0
> here, as described in the commit message of abf2b6a028670bd:
> we think there's too likely to be existing works-on-QEMU code
> out there that doesn't ever set the enable bits.
>
> Otherwise, yes, agreed with the revert.

I've applied this to target-arm.next with the comment expanded
(and I left the define of CR_RXE in too):

+    /*
+     * In theory we should check the UART and RX enable bits here and
+     * return 0 if they are not set (so the guest can't receive data
+     * until you have enabled the UART). In practice we suspect there
+     * is at least some guest code out there which has been tested only
+     * on QEMU and which never bothers to enable the UART because we
+     * historically never enforced that. So we effectively keep the
+     * UART continuously enabled regardless of the enable bits.
+     */

thanks
-- PMM

