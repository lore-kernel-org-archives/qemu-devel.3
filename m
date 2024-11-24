Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8C4E668A0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 04:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tF4Go-0003hw-Ko; Sat, 23 Nov 2024 23:30:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xndchn@gmail.com>) id 1tF4Gn-0003hm-J4
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 23:30:49 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xndchn@gmail.com>) id 1tF4Gm-0005G2-3f
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 23:30:49 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-382588b7a5cso2233669f8f.3
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 20:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732422641; x=1733027441; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j84R7S4u5qFoSng2S1WnpKvSJ4jAccScvN5kudKagkY=;
 b=EIXh/g5m6+O4fT4H/cgxR5tr71ePfB6I56uMMN0owSSe+/rhdKdcOWWqLy6N65y+Fr
 FwZI55NyTNhekseeqipipiPU1tZnfIthhwhjIrTaoJHg85cXWQdF/N8s7kvhRpj0Os+T
 ASow5Vrp8f6eIRyWjdt8Sw1pRJ+S8UehUsBhV0NP5TrMnf2IPTEsGApE8BFZMHPvuaKk
 G71Dl01kVTuellDVA7h/iKj2N+Az0XVzcYYx5vojcJp4bFr+dseMDddfslUa4hTEIquF
 9NTOwiYg8gUHWcPdY2T5Gx1tHX1FZXMQ6am5ZmFPnsH8mgbHIMAzbF7T3nVnnY4zGWfa
 x6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732422641; x=1733027441;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j84R7S4u5qFoSng2S1WnpKvSJ4jAccScvN5kudKagkY=;
 b=kb3zEUBN8BYIVc4/mbSG2zDNw77jpnabH38kjx1uZJFQ2h6RLfyt2DHTru9x1V1tsq
 yQafN1vd7C49d5/nekejUGYdVYyL/ZicFYgUDrRyqymXHv3JHkFwM1jhg0IDK28qm4/+
 MRHmYlrP6e38DJ+mBHMOr5TJGungRzU8+9gX/m3e8xmzzplfL83RiMHBgw/+/9tJEN0u
 lBd9G4/FDc4zkNbsGhxm42vyrCKcKG3DKJNl5WflKWvzGMIf4qJUsaKJItEIods53FGW
 eAsxzhQv/fUYesndbQkR0v6r4+j+lEdJ8Zw7Zv9ag/yA5zU9/caCsTBb5uNyMkAO1x26
 p4Fg==
X-Gm-Message-State: AOJu0Yy89i4qnO/6RV3PGkfsFFinfBHjUZDxbk9OTZLtTpesUedzDtxO
 w0j9fphCIvSj3HluG9sMSohXhuwy44NEt803JM7428tx1iXWrELnZCSfWc7AD5boVDlB3jb4/Tx
 NlmZ83xwx3kpEoz9Lb2A+eW0MKFU=
X-Gm-Gg: ASbGncuWoJ7w/FA2OssRC5SFFwIwCTCBblt7NKaFB2lPDgQ7XU3KGwUgJiRZqx5zfDq
 Q/R7czfS+qYBIVgU8LPyQvKkHJTWaQcM=
X-Google-Smtp-Source: AGHT+IF901QaET9KyJbY8FhNQtRUvpTH1xHI7UinXbbJ3MEq+IQkmKTotue0aJruQeOt5Bsy3XdWMnX91I4kwuR9gaA=
X-Received: by 2002:a5d:59a3:0:b0:382:346b:3654 with SMTP id
 ffacd0b85a97d-38260be30d4mr7536260f8f.56.1732422641315; Sat, 23 Nov 2024
 20:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20241120151515.56884-1-xndchn@gmail.com>
 <20241120151515.56884-2-xndchn@gmail.com>
 <4d3f8a83-7c03-4b48-9a84-d99b88b0d47c@linaro.org>
In-Reply-To: <4d3f8a83-7c03-4b48-9a84-d99b88b0d47c@linaro.org>
From: xndcn <xndchn@gmail.com>
Date: Sun, 24 Nov 2024 12:30:30 +0800
Message-ID: <CAJ=gGT3v9WrDButDKP7C_6b7dLnX7AS0Gfyy5x1cLYunJqWBwg@mail.gmail.com>
Subject: Re: [PATCH] system/physmem: Fix cpu_memory_rw_debug for armv7m MPU
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=xndchn@gmail.com; helo=mail-wr1-x432.google.com
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

Thanks. This patch at least guarantees normal read/write access to
addresses with r/w flags, although there is still a risk of
misidentifying accessible regions within continuous address spaces.

Actually, initially I did write a patch with a modified page size as
an argument, but I soon found that the current implementation of
armv7a (pmsav7) will return the page size (lg_page_size) as 0 in many
situations (such as overlapping regions).
Maybe we can simply make the page size as 2^5 (minimal page size) when
the returned lg_page_size =3D=3D 0?

On Sat, Nov 23, 2024 at 4:32=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/20/24 09:15, Xiong Nandi wrote:
> > The actual page size (region size for MPU) of armv7m may
> > smaller than TARGET_PAGE_SIZE (2^5 vs 2^10). So we should
> > use the actual virtual address to get the phys page address.
> >
> > Signed-off-by: Xiong Nandi <xndchn@gmail.com>
> > ---
> >   system/physmem.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/system/physmem.c b/system/physmem.c
> > index dc1db3a384..a76b305130 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -3564,11 +3564,12 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr ad=
dr,
> >           MemTxResult res;
> >
> >           page =3D addr & TARGET_PAGE_MASK;
> > -        phys_addr =3D cpu_get_phys_page_attrs_debug(cpu, page, &attrs)=
;
> > +        phys_addr =3D cpu_get_phys_page_attrs_debug(cpu, addr, &attrs)=
;
> >           asidx =3D cpu_asidx_from_attrs(cpu, attrs);
> >           /* if no physical page mapped, return an error */
> >           if (phys_addr =3D=3D -1)
> >               return -1;
> > +        phys_addr &=3D TARGET_PAGE_MASK;
> >           l =3D (page + TARGET_PAGE_SIZE) - addr;
> >           if (l > len)
> >               l =3D len;
>
> So... I guess this might accidentally work, but L is definitely incorrect=
 under the
> circumstances.  So we could easily be exchanging one set of bugs for anot=
her.
>
> We really need to be returning the range of addresses under which the add=
ress translation
> is valid.  One solution could be passing in 'l =3D len, &l' to be modifie=
d so that (addr, l)
> translates to (phys_addr, l) after the call; iterate for sum l < len as w=
e're currently doing.
>
>
> r~

