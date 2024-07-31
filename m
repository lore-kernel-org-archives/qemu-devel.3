Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4879DC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 09:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ5jg-0006p3-UB; Wed, 31 Jul 2024 05:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sZ5je-0006gh-Mk; Wed, 31 Jul 2024 05:35:06 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sZ5jd-0004gT-1z; Wed, 31 Jul 2024 05:35:06 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4f524fa193aso477994e0c.0; 
 Wed, 31 Jul 2024 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722418503; x=1723023303; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqMSl8I9SORzqtd+odV06K7tSI6pNmP2+c9g8or19zE=;
 b=JvPmb0vs65Nex5GeSZKBSb904lSHB/39K/SfDghEkcQ3BQWbmFGhh7qhMtAfqQsz4C
 7qxEg0Ug9hbgXSdDy5t0H3twWy5XCPbr+/h6Qo8a3bCD4u7vYEXA0qNC0Xu6XaerjL9J
 /vl8dPb1xKO9ulAltJM44B6V55rxSOzzUVIU9BpFURvLqrL90xcH24s0s2JQrUieoybY
 pvQ0rayyqCY5TN25QIpYQO7f8a/c8xD82bZaedkrxniLy8cEjWRwRwiYsg4mGe90KVP8
 CLBMEyahMPImh7QUFLLA7uSGi4DyjTy3iJTHJdprA+oaNzMoch43g/sus+5CtR1bzTAP
 P8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722418503; x=1723023303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqMSl8I9SORzqtd+odV06K7tSI6pNmP2+c9g8or19zE=;
 b=ES4chpIX/LseJsX1bE0prxi9p5mXFFZD+0IQ2i7r1wBeGTu6KEzpJe1XbSHXfqGIgz
 hnKuiQ7MQF1GI73SD2ApVV55NHkruoFXPurCwhKKXYQYP57HieirPylxO0A6r2/y6v6Z
 n/qBt+VWRDD8t0oQ9GZypYpPgT5d6tz/pkeM80wVwXkw4olULz9vYUuocsso2TbGhpzE
 KLoIJ1g47/F1pKhBDqANrGH3cWoFeXX+LJh1e6cnDDZ7Vva79E04/XnXJPsqUz5ca7Qe
 2Lz17Wk8JDVVu+Emdt5HRoAV2ffRjGJbBgauvHQNcJhNu1oMAZjTOLW8GQtRVwKl+H7d
 XpZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp3FvGpN3n0BWf1IlChCnx1mlF+dCHNsCJ4DHCTZ7GMlqzvUrh7xaJ/lNqWDeX2TQpmNKUQ3NOhId7h9ijHcM2vu6eptw=
X-Gm-Message-State: AOJu0YxspYJ2ofitwEUVqqnYYZMk2DLU0dOF21b4T/5IWd37OyohtY9L
 uQnMxtTnl8YhZzm1+XLDwDRvd+5OcdhL8t5V937IatMw+GPXjSI2ZxR+wknw0IsevSA2dm7ySDV
 t4Yh2bKDY5M+suf0psQDEyUInTrJwlzQHciI=
X-Google-Smtp-Source: AGHT+IFvRNpWXpNva0Zm9LQtmUun/x+xswgQ/NaePx+Iqy8QO3E4Z3QKpDdX40cdZ4T8BeaTQskHS+XnQWTMhn+cMhc=
X-Received: by 2002:a05:6122:3b08:b0:4f5:d98:5ec3 with SMTP id
 71dfb90a1353d-4f87f80f0e3mr2540452e0c.6.1722418503496; Wed, 31 Jul 2024
 02:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240724-fixes-v1-1-4a64596b0d64@rivosinc.com>
 <CAKmqyKPhCzrYxwpBF+NQi-5KgcKkhWeVNX6nwwx3ZjeE9rWEAg@mail.gmail.com>
 <CAHBxVyHBtnhFnFYN0=_5PoKvc7DadJABH71s+wCZzPiYAmPM_g@mail.gmail.com>
In-Reply-To: <CAHBxVyHBtnhFnFYN0=_5PoKvc7DadJABH71s+wCZzPiYAmPM_g@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 31 Jul 2024 19:34:37 +1000
Message-ID: <CAKmqyKNM14jC+HVau=QDfHTztANmAEBiX5pQBnjFRDzRtrjr2w@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Add asserts for out-of-bound access
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Sat, Jul 27, 2024 at 11:36=E2=80=AFAM Atish Kumar Patra <atishp@rivosinc=
.com> wrote:
>
> On Thu, Jul 25, 2024 at 10:12=E2=80=AFPM Alistair Francis <alistair23@gma=
il.com> wrote:
> >
> > On Wed, Jul 24, 2024 at 6:33=E2=80=AFPM Atish Patra <atishp@rivosinc.co=
m> wrote:
> > >
> > > Coverity complained about the possible out-of-bounds access with
> > > counter_virt/counter_virt_prev because these two arrays are
> > > accessed with privilege mode. However, these two arrays are accessed
> > > only when virt is enabled. Thus, the privilege mode can't be M mode.
> > >
> > > Add the asserts anyways to detect any wrong usage of these arrays
> > > in the future.
> > >
> > > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> >
> > Fixes: Coverity CID 1558459
> > Fixes: Coverity CID 1558462
> >
>
> I think one of the Coverity issues was about the get_field issue in
> the other thread?
> This doesn't necessarily fix the coverity issue also as the issue
> reported is a false positive.
> But I don't mind citing the coverity issues as it is reported by that.
>
> Is there a link to both coverity issues to know which issue describes
> the out-of-bound access one ?

I don't think so. I can see the report though and I think it should be
both of them. They are hard to read, but they both seem relevant.

1558462 is the confusing one, but it has

CID 1558462:  Memory - corruptions  (OVERRUN)
>>>     Overrunning callee's array of size 2 by passing argument "env->priv=
" (which evaluates to 2) in call to "riscv_cpu_set_mode".

so I think this should fix it

Alistair

