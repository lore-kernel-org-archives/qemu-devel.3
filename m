Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CCAC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 00:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC77a-0006ks-U4; Tue, 28 May 2024 20:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC77Y-0006k5-Mm; Tue, 28 May 2024 20:24:48 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC77W-000186-VC; Tue, 28 May 2024 20:24:48 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f693fb0ad4so1213501b3a.1; 
 Tue, 28 May 2024 17:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716942285; x=1717547085; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhG+YegobqS05mUNKlgPplskXbsE48G2QNKL6TYgg5Y=;
 b=bakOe0y8Cu1rxxJhoM5IiFQJBrPB6geQji+OE1WVcdsW2ReV1dPF1LEASRfEXFZUsA
 etL36g+XBkyB5Z0e09cBErgB5nomMFBjWzA7pGGl95s4tldjMAgJg/IhW4y9Jh7uvXsp
 7Eld13YDuvCK3r9yD2QKuyB0uT+69KDo9I9v6xsKwx4G5vgKxk+zapQRN9K1KMNlnwc8
 KmW09fue6rVrm9FQVViT/7PsjSPc7JdtMFNkECa466yxj0v2LcPnpD8COClSqBARoON/
 UtSL9nm+D+r2tmvhczWlfJzs3d9VAKFqa1XygbJLcyTV/wi7mLH8ybb+DoirFwg9QjD8
 SfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716942285; x=1717547085;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xhG+YegobqS05mUNKlgPplskXbsE48G2QNKL6TYgg5Y=;
 b=Eae87WQOWdcOsvzSzRCLykZq73egvlZlf2Jzo0doeJFoEMesAIcDQlUFNo5BOCWw3p
 n0y/KcyLdpC8y0hJ6Q3mQzmRSVMBm5nLvJpUtgg5hwYhEgWYVLGaBSiHfgZiKGHQDGlC
 8kAxUOl8dzuhf8VmrUgcUodQKUX4JYHhxE+XFDSNyWvx9qLJE4K1l/ZZejw5bdMyXXN4
 sFPj2cBACI6GIuWVCGBWhhn1BHLq1Tp1lWou+2MtSDeobR6x877G3udlPUbE7WG7+ncs
 eDdItRH0hafZOUBPu94loCcIuqODtIuGubm8nswKPZ5Z0oQdYdsu8qZAn0NSUbfC0T8C
 nG7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw4A6WZ8EV2IRpJQwxUmiPjjz9BEsi5iEK4GIAhV+81X6YdHc30SXPT3FmvYpgfnbfDdIygSD29hior4VGHdPniU2BlyHPOFFzVrQsOJL/YTVFQu6Jl8AWjWo=
X-Gm-Message-State: AOJu0Yy3x3K3qrK4R7KytCEmIZlJQNiM4C+Ws/NpLxX92ngJYXjcfmkG
 8w4i8BvNDSiy6ZUs95UJz1cFo1gwA5VzXIMF2X0nzoU+YOb4KZYQ
X-Google-Smtp-Source: AGHT+IG2NTihMBK4+T8X4QSgqL8u4A7+ehOiDSa99mL+T3jZL47+/jiq9ysuj+jlFdeaNbn48hr4mw==
X-Received: by 2002:a05:6a20:841c:b0:1a9:b3e9:a62c with SMTP id
 adf61e73a8af0-1b212e1c902mr16198594637.48.1716942285068; 
 Tue, 28 May 2024 17:24:45 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcbea8a9sm6991825b3a.139.2024.05.28.17.24.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 17:24:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 10:24:39 +1000
Message-Id: <D1LP8QHR9GGW.2QAD6R00QARSG@gmail.com>
Cc: "Caleb Schlossin" <calebs@linux.vnet.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 05/10] ppc/pnv: Extend chip_pir class method to TIR
 as well
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-6-npiggin@gmail.com>
 <39e4ac93-256b-424b-8ecb-7ed87afeb048@linux.ibm.com>
In-Reply-To: <39e4ac93-256b-424b-8ecb-7ed87afeb048@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue May 28, 2024 at 6:32 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 5/26/24 17:56, Nicholas Piggin wrote:
> > The chip_pir chip class method allows the platform to set the PIR
> > processor identification register. Extend this to a more general
> > ID function which also allows the TIR to be set. This is in
> > preparation for "big core", which is a more complicated topology
> > of cores and threads.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   include/hw/ppc/pnv_chip.h |  3 +-
> >   hw/ppc/pnv.c              | 61 ++++++++++++++++++++++++--------------=
-
> >   hw/ppc/pnv_core.c         | 10 ++++---
> >   3 files changed, 45 insertions(+), 29 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> > index 8589f3291e..679723926a 100644
> > --- a/include/hw/ppc/pnv_chip.h
> > +++ b/include/hw/ppc/pnv_chip.h
> > @@ -147,7 +147,8 @@ struct PnvChipClass {
> >  =20
> >       DeviceRealize parent_realize;
> >  =20
> > -    uint32_t (*chip_pir)(PnvChip *chip, uint32_t core_id, uint32_t thr=
ead_id);
> > +    void (*processor_id)(PnvChip *chip, uint32_t core_id, uint32_t thr=
ead_id,
> > +                         uint32_t *pir, uint32_t *tir);
>
> Should it be named get_chip_core_thread_regs() ?

Yeah, the name isn't great. It is getting the regs, but the regs are the
"pervasive id" used as well... but maybe that's not too relevant here.
What about we drop chip_ since we have the chip and no other methods use
such prefix, then call it get_thread_pir_tir()?

> > @@ -155,7 +155,7 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, =
void *fdt)
> >       char *nodename;
> >       int cpus_offset =3D get_cpus_node(fdt);
> >  =20
> > -    pir =3D pnv_cc->chip_pir(chip, pc->hwid, 0);
> > +    pnv_cc->processor_id(chip, pc->hwid, 0, &pir, &tir);
>
> As a generic helper API and potentially expandable, it should allow=20
> passing NULL for registers whose values are not really sought to avoid=20
> having to create un-necessary local variables by the caller.

I'll do that.

Thanks,
Nick

