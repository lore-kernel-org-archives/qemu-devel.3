Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D249606A32A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rsrroNq9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQJA3-0004vz-1b; Mon, 09 Nov 2026 01:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xQJA1-0004vZ-T2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 01:47:21 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xQJA0-0004lA-IH
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 01:47:21 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-67c05273c38so554334d50.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 22:47:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794206839; cv=none;
 d=google.com; s=arc-20260327;
 b=VvVttkZAsOET3kPHQhIAfDGErDXZM0wY8KNjB5wtxA5iWkXralq+u9vRNs6dqPCgxd
 ZRbiy09/FEyINS9fdLW6u452FfH2f3DLdGAKJ0RplNuRD4+vqucVy4uWNnoAq49N/qfI
 s6ej98k0f3Z4gD07bKVkjGYdfyy7UdmJvoN2/bEwkI5vhoyAQVYa9qsT9hYpShqieTwE
 U1BtO66JwwMpaPf9Rhpqf4r3EhEnxEqK5F2UAofd+z1jF3SC4/xSbI2Sii+ET1YWpywi
 O8l0wagr7KTzHhISr/oDjtjQ2LbkNvHuowdDZGnHdgY13UqtzvvZK1dgcWY2BciQAld4
 aSRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JtYI2bswTvOZejr/2eSca0LUR7HwUbbtr0PQryubxWI=;
 fh=vT5UwVdGpIVE3rNQSJresYRMIbS//jA3g237DCtFP3Y=;
 b=RqVLjDwHKhPa3pK3Nu7CbiwuBzVEf8/f+FEmhyOUVxeRr8JuAGHOZjPO0ld4sBClAK
 l0gwnWcGdnUbVDhlidxuywIgpY+idZf8nUhkGsgkGkbtyzfJNUY4Qh0QSFmNiD1BLN0P
 Dm5M3zFIDBn35HtDA95VZ5cCIwRJ9v8nbMMyF0H2/ablFV710E8Dwg4SFYnPzvKRIZn0
 WD0otOrkORa9juLq5kSW8euqlX5/MhrAI66lKcl6RPbWzoIPKXohbx2bloof4U6lSIvZ
 abCQmVkVvP39nsS88lHqK6gCw5EFXksOhEu5u2LG+SLxJFJuQ+8Z9n3yaBu0I/78jCdO
 xiHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794206839; x=1794811639; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JtYI2bswTvOZejr/2eSca0LUR7HwUbbtr0PQryubxWI=;
 b=rsrroNq9lvBI8PYqNBXSItVjLKFi4R+Leo6SeUZCpvemFtxL5y9Y+6Jrq6HqgaSkjE
 vjaPxpKX0YDN4uT+UYyKyeN870H4oy3FxgYrgSu3y2RIJ5qAIlf9ilJvS5NT6SXBU0/Q
 dPJYUsasiRZDvWwg9OQ+KdRbqrJRwAAq5ytTOOoVzcZ42/aUEnAEo7qVihVfzbcFRvV7
 nM9OW6UxGj6YKmVa2p2fVicmvgAe65JKNxpD6VUYF0YYQVqnr4JDQXEEzVBn7rNFb+FS
 udcPzdKhHLKrAReRtiqnPv9p+k16Lq2UJxv7vVvLW0r4iIQLOPn/Yr1dEy4/oeT2nsnU
 AcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794206839; x=1794811639;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JtYI2bswTvOZejr/2eSca0LUR7HwUbbtr0PQryubxWI=;
 b=uAZjqawdrjYJn2e/goDi8zONfQJtC3THjcapv7akcv5ojcdlFxoUcqe19cUlyrHOtb
 s5qK2vEfu1yGDkT4zHK5Ywuxu6jTH7qsYXRgRUIQS8MQ4XMxpmpw1oFEhAeQ5OxYABbY
 HSpCt6VVOXqG7CIvanHhZG0U9GgFbB6q0g0+mqD4UOliG83c+PW1faKLwElUEk8aArfO
 T7kyKz1Er5MpFLvhC7IEBvCy2uTApVlb54tqILmBWAPfuVZo5PTG+NdNlHhMpFNvmCtn
 BnwQ0J3vNjbvYusDN0PQQDAT4CNNAA6GYi0sGIA8DKs6fD4CEzDrukE2ov1XfzaqTdZu
 VYyQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGxdWmy14+TTUXxc3rCoDqWyt876b57WoYAlVl6vlB6WS9qOvqQUxt262/6mROnJ+iMLQklWm38vcPY@nongnu.org
X-Gm-Message-State: APuU4Z9kDXrHua8ONSmycEmTC5LG8CqmKvZPyFWz+kNH5h+6JH9l6R/k
 jH432AbpgRzYLs7jzRjLkAfAEu+75ADjtQgM0O7rDD5H6CSo5wjOtEWZ1ixwqTNz/kpIrN+rY45
 7kDiWvvQSG/bzDdJsZV+iJ4UfxR/QbWk=
X-Gm-Gg: AYBFou2veUkC2TyQcv9kehqXnxeQOkeTeMx1H2dMhA+Npvz7E1597ENQdByzFPLGzAr
 b7asG5sNwxLRAJaDOkyvyY+zO0cndVtYi+zaxNc72OpEWAk4HL+sQEpJaoPjRssaTlQZSvbSGyo
 JhLFXzU4/+yCALXcS9bveg7/EC1uPJplMM0xONuxxTnJyfpKEbt1WyutTXMev1AZtdAbpIVASKf
 z58oeppGth7bNsQpbN5UT9vtmqLTUaO0aHfByXLh42St4nZvn8uzjqEawd4BBe5CH66Zc0rQai5
 t5HHDbG/sxElJt0sh7BL9+d6RBpUin9SHdu1gS8OIE2Y4M5waWl+4sRZeFPU+3dZP2jP4UVRwwU
 HKz++3ORZYZn0GD9hvbTnLlcn/0JepAmFmNNVYayWBB9LQZflVbRH1TKWuPGeLt0r/maKhEpANv
 39VQ==
X-Received: by 2002:a05:690e:134f:b0:67b:fbde:ba7a with SMTP id
 956f58d0204a3-67c3da64c01mr1953808d50.85.1794206838992; Sun, 08 Nov 2026
 22:47:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260927075108.3621107-1-bin.meng@processmission.com>
 <20261104151128.600958-1-bin.meng@processmission.com>
In-Reply-To: <20261104151128.600958-1-bin.meng@processmission.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 9 Nov 2026 14:47:06 +0800
X-Gm-Features: AclHuK9Qk4NvDXC9KP7FRdkcY67bTZt3y5hCzQ52ytSFFyDukB_VtuEFHn8sf_M
Message-ID: <CAEUhbmUwpvcAU5z2QxmK_8t3t4PC2ATFVMV-6bq8gvZhDW6O2g@mail.gmail.com>
Subject: Re: [PATCH v2] hw/net: cadence: Honor subword lanes in the GEM
 registers
To: Bin Meng <bin.meng@processmission.com>
Cc: alistair@alistair23.me, edgar.iglesias@gmail.com, jasowangio@gmail.com, 
 peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb130.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 11:13=E2=80=AFPM Bin Meng <bin.meng@processmission.c=
om> wrote:
>
> Bin Meng wrote:
> > The GEM MMIO callbacks ignored the low address bits and access size.
> > Byte reads therefore always returned lane zero, causing guest driver
> > that reads the station address byte by byte to turn four unique MAC
> > addresses into the same value. Partial writes had the corresponding
> > lane-selection problem.
> >
> > Extract the requested little-endian read lane and merge partial writes
> > with the current register value. Preserve the existing read-clear,
> > write-clear, and command side effects, including dynamic queue
> > pointers.
> >
> > Fixes: e9f186e514a7 ("cadence_gem: initial version of device model")
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> >
> > ---
> >
> > Changes in v2:
> > - drop the gem_get_register() helper
> >
> >  hw/net/cadence_gem.c | 55 +++++++++++++++++++++++++++-----------------
> >  1 file changed, 34 insertions(+), 21 deletions(-)
>
> Ping for review?
>

Ping?

