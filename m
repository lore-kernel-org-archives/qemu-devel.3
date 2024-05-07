Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACA3C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 04:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4CVf-00071H-8z; Tue, 07 May 2024 00:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4CVb-00070A-SK; Tue, 07 May 2024 00:32:57 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4CVa-0006U0-0P; Tue, 07 May 2024 00:32:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ee5235f5c9so8629975ad.2; 
 Mon, 06 May 2024 21:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715056372; x=1715661172; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uAoPhyorj6EitS242+fxxENQEPtgu5DnsXCRH6c768=;
 b=dM9ZF23U3n+lDAY3iOfG6rZ7zj4jFcZnB43jAMpaVSwC7mUbSGnRETbIO/1pd8NzZm
 UkejUMdEHCWojVzDFqxkMJ1taoSxn+xDm1N/uLxxRAz6NSVlWUgVjvwiQl31cnR/Sch6
 rP3NmrZvVk4cx1Js33SmeCIr/Ud09cG6333R9N9vn1O8lb/j6cHdur391mtJn+vbd5UY
 rNZz4sAtZ8klizdfb+T714ejwJwJXlTkI1JMsxlYiw3EKj0H86IWydo5iRJPp1/IAMe9
 Pqf9/XCSZoOdpbsD6chOpgfKG4yz2WTPy4yrXd7iFKXOte4iZKlWjpHg2u0UtyV+bZNs
 G2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715056372; x=1715661172;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+uAoPhyorj6EitS242+fxxENQEPtgu5DnsXCRH6c768=;
 b=roHkajKLXaIGlSy56OxsR1+uu7vQB+VQ4lEa+UCQR2L1Ns3XXI82a8O00p0x1yeHtU
 gWsmgkBaUESjaEjYYFK60Lft+w33vU2PEBgT1naxDAfbNa3fk0V6R6W80AYK+gYg26pN
 lq/qSFOX+8B0JPnIid8jld37MkiE+SbmGJtXtmxI8yzqbfJSYJem7/vJwoWGu58oySeO
 652kEUKwC9a040TW44REcBMd+/LgcK74UBGj73ppd2LIqtIHYKHml2QP00LaK7Q/Doxn
 66hBB21VZUAuvYBTZOy5HBlH//5OTuH5QbFN3QU0O9qNI54BqfNC+ui/2LhSkhDkctNX
 68Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrslLCneug/GAxCU+EBDzO4RvCCe0MCNRlaCNwcptq8rl+T3quZV6otFmcT3lg8KTN2ZSO3DgHksreBsr75lodh99t
X-Gm-Message-State: AOJu0YyZakqSpjetZG2uGQgkYUUML5//waSmBnNemteoSYUauuzCy+Al
 mebWzaIlUXmNV59J8qHr+RD03m2Av/7FnW+ZHXaxHgSVdeYL3aZPzy/wcw==
X-Google-Smtp-Source: AGHT+IFmrTh5DGGkVZjA6hLD0Y23O3v7P46LzysiTXwSCnQqS6Z8hS1reVhQP9HtApo2XJ9UzcwPsw==
X-Received: by 2002:a17:902:b607:b0:1e1:214:1b7d with SMTP id
 b7-20020a170902b60700b001e102141b7dmr12876947pls.61.1715056371713; 
 Mon, 06 May 2024 21:32:51 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a170903234800b001e2b4f513e1sm9079529plh.106.2024.05.06.21.32.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 21:32:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 14:32:46 +1000
Message-Id: <D134QQ0G9D1C.1W05PMY7F4LKJ@gmail.com>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Saif Abrar" <saif.abrar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] ppc/pnv: Begin a more complete ADU LPC model for
 POWER9/10
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240417110215.808926-1-npiggin@gmail.com>
 <20240417110215.808926-2-npiggin@gmail.com>
 <577fd77f-a6b9-41f5-8193-f2cc80503a7d@kaod.org>
 <D0YBCHP9K12V.3JU88W5WITYRM@gmail.com>
 <272a9f32-8d32-4681-b25b-9d45c6c787b5@kaod.org>
 <D0ZQN2YAQ28S.3FGETJPE6XVC8@gmail.com>
 <e1875754-1b85-4f85-a9e0-d5cbe41b1711@kaod.org>
In-Reply-To: <e1875754-1b85-4f85-a9e0-d5cbe41b1711@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

On Fri May 3, 2024 at 3:44 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/3/24 06:51, Nicholas Piggin wrote:
> > On Thu May 2, 2024 at 6:47 PM AEST, C=C3=A9dric Le Goater wrote:
> >> On 5/1/24 14:39, Nicholas Piggin wrote:
> >>> On Wed Apr 17, 2024 at 9:25 PM AEST, C=C3=A9dric Le Goater wrote:
> >>>> Hello Nick,
> >>>>
> >>>> On 4/17/24 13:02, Nicholas Piggin wrote:
> >>>>> This implements a framework for an ADU unit model.
> >>>>>
> >>>>> The ADU unit actually implements XSCOM, which is the bridge between=
 MMIO
> >>>>> and PIB. However it also includes control and status registers and =
other
> >>>>> functions that are exposed as PIB (xscom) registers.
> >>>>>
> >>>>> To keep things simple, pnv_xscom.c remains the XSCOM bridge
> >>>>> implementation, and pnv_adu.c implements the ADU registers and othe=
r
> >>>>> functions.
> >>>>>
> >>>>> So far, just the ADU no-op registers in the pnv_xscom.c default han=
dler
> >>>>> are moved over to the adu model.
> >>>>>
> >>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>>>> ---
> >>>>>     include/hw/ppc/pnv_adu.h   |  34 ++++++++++++
> >>>>>     include/hw/ppc/pnv_chip.h  |   3 +
> >>>>>     include/hw/ppc/pnv_xscom.h |   6 ++
> >>>>>     hw/ppc/pnv.c               |  16 ++++++
> >>>>>     hw/ppc/pnv_adu.c           | 111 ++++++++++++++++++++++++++++++=
+++++++
> >>>>>     hw/ppc/pnv_xscom.c         |   9 ---
> >>>>>     hw/ppc/meson.build         |   1 +
> >>>>>     hw/ppc/trace-events        |   4 ++
> >>>>>     8 files changed, 175 insertions(+), 9 deletions(-)
> >>>>>     create mode 100644 include/hw/ppc/pnv_adu.h
> >>>>>     create mode 100644 hw/ppc/pnv_adu.c
> >>>>>
> >>>>> diff --git a/include/hw/ppc/pnv_adu.h b/include/hw/ppc/pnv_adu.h
> >>>>> new file mode 100644
> >>>>> index 0000000000..9dc91857a9
> >>>>> --- /dev/null
> >>>>> +++ b/include/hw/ppc/pnv_adu.h
> >>>>> @@ -0,0 +1,34 @@
> >>>>> +/*
> >>>>> + * QEMU PowerPC PowerNV Emulation of some ADU behaviour
> >>>>> + *
> >>>>> + * Copyright (c) 2024, IBM Corporation.
> >>>>> + *
> >>>>> + * SPDX-License-Identifier: LGPL-2.1-or-later
> >>>>
> >>>>
> >>>> Did you mean GPL-2.0-or-later ?
> >>>
> >>> Hey Cedric,
> >>>
> >>> Thanks for reviewing, I've been away so sorry for the late reply.
> >>>
> >>> It just came from one of the headers I copied which was LGPL. But
> >>> there's really nothing much in it and could find a GPL header to
> >>> copy. Is GPL-2.0-or-later preferred?
> >>
> >> I would since all pnv models are GPL.
> >=20
> > Some of pnv is actually LGPL.=20
>
> I was grepping for 'LGPL' and not 'Lesser' ... Indeed you are right.
> Most files miss an SPDX-License-Identifier tag also.
>
> > That's okay I'll change to GPL.
>
> LGPL is more relaxed if the code needs to be used in libraries, but
> I am not sure it applies to the PNV models. What would you prefer ?

GPL seems to be more common and I don't see a need for LGPL here,
so maybe GPL?

We could probably switch all LGPL pnv over to GPL if we wanted to.
I think LGPL permits such relicensing. Will leave this discussion
for another time though.

Thanks,
Nick

