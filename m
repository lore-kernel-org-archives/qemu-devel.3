Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D93CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 12:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s29Iy-0004CG-SO; Wed, 01 May 2024 08:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s29Is-00049F-Tf; Wed, 01 May 2024 08:43:19 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s29Iq-0001yN-D1; Wed, 01 May 2024 08:43:18 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2b3646494a8so93226a91.2; 
 Wed, 01 May 2024 05:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714567394; x=1715172194; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlAqjCUHaBUYqqVltywm/SDnAvn5/4ac+4LedazZ5QA=;
 b=GGKCEuA+wvMdVZyIiUps7zCjjfGK7IH8bvhZTJ9jp1zXBTo6HfWyUquHFT2Egy+t8i
 SSVQfCVtI6mpht/8ZES+LXqtL2d27OcWvz33kc6/BsmdxlRFXX2yrn3CyVo7+lNk7ddj
 iMt9xcoXuNkyqq/tAOMNjB4GR4ULbNEVVI68aNVH/DPMOa+iuTSRgns6jbQzvgW/Y4a7
 XHpVMRMCe7t/I7GClTYzExLsIC8YKsaBrYoxbQDh3a64zLH2QbYCVbB+86nU/JsR2U8T
 j0ppIREUF6dv1bqvY82UYVew4S2dlDukloMUODUwEIqHNDKdNuvYgSa1ucYb1XfL+siZ
 G/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714567394; x=1715172194;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jlAqjCUHaBUYqqVltywm/SDnAvn5/4ac+4LedazZ5QA=;
 b=FWmdhjYuFbI0xwi/SSYAJrp9NZG5jKdKG4+g4Y66BKD7hYAYi0G+iT9+dHWcyDIbS1
 QYNIEHaJtoHhpmcVPuhsnKPKSaZZuu0qOFpA6Z/rEn4v2f55S+bAhuN6z2pcYU+bzA7i
 4CFT24/1hz90QaVXnts7gpmzfTSNNhIOG9vLITu735Q9+AOmPszB3yRu7kUVLBu1t35A
 /4J391e1kaZHpGpOr18pQrB+SwXHd71qAuP+l1Nt4htpgYEgv8swyBRP/qMMun2ALEqk
 JVTsJPQJ8lZH9DuTNM3zpTONcA6UUUTsL0sZdRgzYhi2pd+GxtcG72hWo9I+BlTMLLvW
 bSyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRXqkgJ4zPrjt2DYyCcfAivkT27wwnuusfb3oZOPG25M3jaO3m3ycloby+7GcZDjgUDgXE2NtInZWFbFOAB0EtozLG
X-Gm-Message-State: AOJu0YwAdkuTUQIke39N94NtYcM9+cGVFYYW8uxXrxvb+rxROJLnw/Xp
 Zs7B8FB7WN/1T0JcMxZe2zRAt4fY2pgJTE1Gjy2zLDCMgefzElq8
X-Google-Smtp-Source: AGHT+IEefL72Sx187Z2VN0rfyITMTKcmsMAiwhbhSbgxHzKBQvGXXj/0Vntg5GAoiq3/xiqec6VVKQ==
X-Received: by 2002:a17:90b:3d0b:b0:2b2:b921:a99 with SMTP id
 pt11-20020a17090b3d0b00b002b2b9210a99mr2104199pjb.16.1714567393915; 
 Wed, 01 May 2024 05:43:13 -0700 (PDT)
Received: from localhost ([1.146.40.196]) by smtp.gmail.com with ESMTPSA id
 h4-20020a17090a710400b002b1314ba8c0sm1233902pjk.57.2024.05.01.05.43.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 May 2024 05:43:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 May 2024 22:43:08 +1000
Message-Id: <D0YBEWF2CP6Q.121MBJ0QG4HS1@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Saif Abrar" <saif.abrar@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] ppc/pnv: Implement ADU access to LPC space
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <20240417110215.808926-1-npiggin@gmail.com>
 <20240417110215.808926-3-npiggin@gmail.com>
 <f8b689f4-50b0-4f96-bd64-21b9eda6862e@kaod.org>
In-Reply-To: <f8b689f4-50b0-4f96-bd64-21b9eda6862e@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
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

On Wed Apr 17, 2024 at 10:25 PM AEST, C=C3=A9dric Le Goater wrote:
> On 4/17/24 13:02, Nicholas Piggin wrote:
> > One of the functions of the ADU is indirect memory access engines that
> > send and receive data via ADU registers.
> >=20
> > This implements the ADU LPC memory access functionality sufficiently
> > for IBM proprietary firmware to access the UART and print characters
> > to the serial port as it does on real hardware.
> >=20
> > This requires a linkage between adu and lpc, which allows adu to
> > perform memory access in the lpc space.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   include/hw/ppc/pnv_adu.h |  7 ++++
> >   include/hw/ppc/pnv_lpc.h |  5 +++
> >   hw/ppc/pnv.c             |  4 ++
> >   hw/ppc/pnv_adu.c         | 91 +++++++++++++++++++++++++++++++++++++++=
+
> >   hw/ppc/pnv_lpc.c         | 12 +++---
> >   5 files changed, 113 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/pnv_adu.h b/include/hw/ppc/pnv_adu.h
> > index 9dc91857a9..b7b5d1bb21 100644
> > --- a/include/hw/ppc/pnv_adu.h
> > +++ b/include/hw/ppc/pnv_adu.h
> > @@ -10,6 +10,7 @@
> >   #define PPC_PNV_ADU_H
> >  =20
> >   #include "hw/ppc/pnv.h"
> > +#include "hw/ppc/pnv_lpc.h"
> >   #include "hw/qdev-core.h"
> >  =20
> >   #define TYPE_PNV_ADU "pnv-adu"
> > @@ -19,6 +20,12 @@ OBJECT_DECLARE_TYPE(PnvADU, PnvADUClass, PNV_ADU)
> >   struct PnvADU {
> >       DeviceState xd;
> >  =20
> > +    /* LPCMC (LPC Master Controller) access engine */
> > +    PnvLpcController *lpc;
> > +    uint64_t     lpc_base_reg;
> > +    uint64_t     lpc_cmd_reg;
> > +    uint64_t     lpc_data_reg;
>
> I don't see reset values for these registers. Is that ok ?
>
> >       MemoryRegion xscom_regs;
> >   };
> >  =20
> > diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> > index 5d22c45570..016e2998a8 100644
> > --- a/include/hw/ppc/pnv_lpc.h
> > +++ b/include/hw/ppc/pnv_lpc.h
> > @@ -94,6 +94,11 @@ struct PnvLpcClass {
> >       DeviceRealize parent_realize;
> >   };
> >  =20
> > +bool pnv_opb_lpc_read(PnvLpcController *lpc, uint32_t addr,
> > +                      uint8_t *data, int sz);
> > +bool pnv_opb_lpc_write(PnvLpcController *lpc, uint32_t addr,
> > +                       uint8_t *data, int sz);
>
> May be rename to pnv_lpc_opb_read/write ?

Yes that's more appropriate.

> >   ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Erro=
r **errp);
> >   int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_offset,
> >                  uint64_t lpcm_addr, uint64_t lpcm_size);
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 5869aac89a..eb9dbc62dd 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -1642,6 +1642,8 @@ static void pnv_chip_power9_realize(DeviceState *=
dev, Error **errp)
> >       }
> >  =20
> >       /* ADU */
> > +    object_property_set_link(OBJECT(&chip9->adu), "lpc", OBJECT(&chip9=
->lpc),
> > +                             &error_abort);
>
> I would add an assert on the lpc pointer in the ADU realize routine.

A assert !=3D NULL, in case this failed to link correctly? (Maybe if it
was called before lpc object was realized). I will do.

Thanks,
Nick

