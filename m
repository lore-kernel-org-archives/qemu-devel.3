Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01586C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 15:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLlUZ-00030Z-SF; Mon, 24 Jun 2024 11:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLlUX-000306-GX
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 11:20:25 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLlUV-0007A5-Na
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 11:20:25 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57d1012e52fso5087270a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719242422; x=1719847222; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKjiSwSwKMBRX60f68EPnqgsF0h6wyV+tEGsj0Doh0g=;
 b=SDG6Mh9cE7RT9nTZw2ZdIvmi7SDphgO99aPVBiOv29yofA8Lork6UnrPYxJ/LqGq5H
 jweY9vsBBPR+fSvkygiHiHyDwO7rohRkSpoq42GK0j141+zEZZvARE5coRFZjsgyTWD8
 XA4jGcb6i2ejB9lJ00HmhQyCSNTiHOG3zviyD4K6JxUOuJLjtZsaDZIPUbjHx06PGdA5
 a/1p8Soh3H7xjNqG2+2whpRmZBG8nR3z0eNHAY8A1UY8LnxRiDjIPac7r3HmaqzHnBzm
 3XgoIwHh0AYs/GXoVnMzoMYuEc55gR6f8AmzstcSnxheHPoyivxPWIZaHkzTK1iSb2QU
 V3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719242422; x=1719847222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wKjiSwSwKMBRX60f68EPnqgsF0h6wyV+tEGsj0Doh0g=;
 b=OLP4+8raKikHwLY9QLpzvbWa98YCHY3/kPO+f32UAXDLiA96IAW/ZvdZ7shuX+hY5Q
 j6C/f5HGTt6iokL6wnH4EVsM8xg1jQuADW6skzdXMzQ4K1B+B3vC7NhJ3E+WBWPe5V5L
 sXic9ICU8P97si9ds1N5oEoqsHAUVkHCvt7tUwz77+DrLBVe/TgWNNafPuWlL4oEdv2S
 t3nS1K1x9bVVZfBeMTakSPgwMTlubaXBjjB3PDqHj1LRjipaq3AaQMvvdQWSDmMdewC9
 5TIjKDSGymQcR021KEwbdTOemfBcUTR7s4HbB0NoqfE48Qk1E50kHD3Kcyx6cRuOmHZn
 I+zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDaSoIrkZ9Rqmv/yJnTz1PBpwp+1dO4KzI61UcaNdZ8ovM4LFSA2kJT0jOtlumLqBp14RAJHMyWqOMqcjRn/rhOG4vpKM=
X-Gm-Message-State: AOJu0YxSyg3NImLiuptLHWS03FgQpQplcYmj+WgsQB88DC7eMccB4BWR
 S0XOjUhR7jHM3lyWWPwdggSh28UukMtJ90AKHqEKJr7h7jkYxWKPoCY6wCGIX4eA3sEbHd3HuyZ
 Ds7glLHZidCmMrXI/0aRmgL0eesmet7TQj/vB5A==
X-Google-Smtp-Source: AGHT+IG4W5Gutxan5zQ5jTgBaG5Di6YJRaeCDdsXG3TD6imUaLpEb2rw9R19y8Rs3lTeekNlLMioVMURA28HcGArzrI=
X-Received: by 2002:a50:cdd5:0:b0:57d:788:aaa2 with SMTP id
 4fb4d7f45d1cf-57d4bd53410mr3106657a12.8.1719242403742; Mon, 24 Jun 2024
 08:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAFU8RB_pjr77zMLsM0Unf9xPNxfr_--Tjr49F_eX32ZBc5o2zQ@mail.gmail.com>
 <CAGxU2F4Q5ewt442zGvUhfMuXYcRENEingFQVuu5VK_wQBizE3Q@mail.gmail.com>
In-Reply-To: <CAGxU2F4Q5ewt442zGvUhfMuXYcRENEingFQVuu5VK_wQBizE3Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jun 2024 16:19:52 +0100
Message-ID: <CAFEAcA9hdkZU0GF=v9Fj3GrYha=kgFr3GaKjd8kvsPHDdVCfRQ@mail.gmail.com>
Subject: Re: [Bug Report] Possible Missing Endianness Conversion
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Xoykie <xoykie@gmail.com>, qemu-devel@nongnu.org, 
 Eugenio Perez Martin <eperezma@redhat.com>, thuth@redhat.com, cohuck@redhat.com,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 24 Jun 2024 at 16:11, Stefano Garzarella <sgarzare@redhat.com> wrot=
e:
>
> CCing Jason.
>
> On Mon, Jun 24, 2024 at 4:30=E2=80=AFPM Xoykie <xoykie@gmail.com> wrote:
> >
> > The virtio packed virtqueue support patch[1] suggests converting
> > endianness by lines:
> >
> > virtio_tswap16s(vdev, &e->off_wrap);
> > virtio_tswap16s(vdev, &e->flags);
> >
> > Though both of these conversion statements aren't present in the
> > latest qemu code here[2]
> >
> > Is this intentional?
>
> Good catch!
>
> It looks like it was removed (maybe by mistake) by commit
> d152cdd6f6 ("virtio: use virtio accessor to access packed event")

That commit changes from:

-    address_space_read_cached(cache, off_off, &e->off_wrap,
-                              sizeof(e->off_wrap));
-    virtio_tswap16s(vdev, &e->off_wrap);

which does a byte read of 2 bytes and then swaps the bytes
depending on the host endianness and the value of
virtio_access_is_big_endian()

to this:

+    e->off_wrap =3D virtio_lduw_phys_cached(vdev, cache, off_off);

virtio_lduw_phys_cached() is a small function which calls
either lduw_be_phys_cached() or lduw_le_phys_cached()
depending on the value of virtio_access_is_big_endian().
(And lduw_be_phys_cached() and lduw_le_phys_cached() do
the right thing for the host-endianness to do a "load
a specifically big or little endian 16-bit value".)

Which is to say that because we use a load/store function that's
explicit about the size of the data type it is accessing, the
function itself can handle doing the load as big or little
endian, rather than the calling code having to do a manual swap after
it has done a load-as-bag-of-bytes. This is generally preferable
as it's less error-prone.

(Explicit swap-after-loading still has a place where the
code is doing a load of a whole structure out of the
guest and then swapping each struct field after the fact,
because it means we can do a single load-from-guest-memory
rather than a whole sequence of calls all the way down
through the memory subsystem.)

thanks
-- PMM

