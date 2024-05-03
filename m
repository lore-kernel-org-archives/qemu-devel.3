Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67851C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 04:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ku8-0004nX-JM; Fri, 03 May 2024 00:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s2kto-0004lp-7x; Fri, 03 May 2024 00:52:00 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s2ktl-0007jq-Qe; Fri, 03 May 2024 00:51:55 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ab1ddfded1so7507835a91.1; 
 Thu, 02 May 2024 21:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714711911; x=1715316711; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j10eyXPBUCpEdF7wae1fx+mAKO5/3gI4cTsZpLUfY3I=;
 b=gad3wpxauDqoUOoC+OoLvR50y2uknvqZQffbwe6RGmy/bTUC3SGERvYZclPb8GkITU
 TARoZUd/lfF19EAqQgKT8bIIwgrAYTjhzC4P5g+ezL38ai+W+pSWADjyqL02YyIcbLgk
 7EWcEtGKruYIrRrgCtxgYLk6htTL56670xIsjw1fuUEa+oQViWqSfqXKzECzCRC9Ut5f
 6fnN/j5wvjdL4+ggBHML4XIhN/qs3urrkzQip3WF+Y3UE8CKJxytpS+7HFTjneVwZ6n8
 N6JhKRObIXvgsULhcfpraxJ6b6uaAdfv+4cX5CzWbLXN7E3uWScKa/A4XNn/JFdFKBf4
 qsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714711911; x=1715316711;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j10eyXPBUCpEdF7wae1fx+mAKO5/3gI4cTsZpLUfY3I=;
 b=dhd7i1E0gk6IB1B5PXyCCPQLyctDZyD1pl3XSIaycD31NmaxFdhO/n1h6dHume67TS
 xspHjFXAfUXwzCQldtsbSK9RyjZLOVFUPkpBoZJemnEDk6TcZYEyA4fZw5xPf+/wQuFa
 bo6aq8cAd2S4PWcs9c9W9l4G86zUTV+RtCiSGzPRBjCArCgNHGVwblKfxCPyUNhrBKOz
 EcR3nRP+ix3VJFvVPcW5Mn2/7xbqFFGBBQBARgzYeRL19byqRol2O16IlbCnNKjXfFE7
 3k063H9pHoPeFQR2MrdOWlPIuZTH0j4q1Do6LO3PUnrrCFUdJE4xtxb2+zwaxCVgn6fD
 8rvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ1XLgXswPPTu4Vkr9rlzEKla0nTgjM+fshoKyh8R6x+ZKGig9EuKiuZaB1X7O4AElKP20m5P8wFNPA4C4qCv4ZqdA
X-Gm-Message-State: AOJu0YwxhJub+yjs6g8KXnHq0jKvYngFkrBang0EOyIGdedknc4S9Xw1
 CUWdvVTUpE5fNb+XAn5dEgas4d0peKJSxDvrmAFPTS9aUGZ41CBt
X-Google-Smtp-Source: AGHT+IHarciw1b+g+1u5v2nTzgWHxKRrut0Kk+Nw2eV40pdZKfSNMIHq3SsRJSlHGVspH8fSXY4GHA==
X-Received: by 2002:a17:90b:3148:b0:2b4:32ae:9932 with SMTP id
 ip8-20020a17090b314800b002b432ae9932mr1024796pjb.17.1714711911341; 
 Thu, 02 May 2024 21:51:51 -0700 (PDT)
Received: from localhost ([1.146.23.181]) by smtp.gmail.com with ESMTPSA id
 g4-20020a17090a128400b002b1581a0fccsm3713246pja.44.2024.05.02.21.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 21:51:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 May 2024 14:51:46 +1000
Message-Id: <D0ZQN2YAQ28S.3FGETJPE6XVC8@gmail.com>
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
In-Reply-To: <272a9f32-8d32-4681-b25b-9d45c6c787b5@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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

On Thu May 2, 2024 at 6:47 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/1/24 14:39, Nicholas Piggin wrote:
> > On Wed Apr 17, 2024 at 9:25 PM AEST, C=C3=A9dric Le Goater wrote:
> >> Hello Nick,
> >>
> >> On 4/17/24 13:02, Nicholas Piggin wrote:
> >>> This implements a framework for an ADU unit model.
> >>>
> >>> The ADU unit actually implements XSCOM, which is the bridge between M=
MIO
> >>> and PIB. However it also includes control and status registers and ot=
her
> >>> functions that are exposed as PIB (xscom) registers.
> >>>
> >>> To keep things simple, pnv_xscom.c remains the XSCOM bridge
> >>> implementation, and pnv_adu.c implements the ADU registers and other
> >>> functions.
> >>>
> >>> So far, just the ADU no-op registers in the pnv_xscom.c default handl=
er
> >>> are moved over to the adu model.
> >>>
> >>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>> ---
> >>>    include/hw/ppc/pnv_adu.h   |  34 ++++++++++++
> >>>    include/hw/ppc/pnv_chip.h  |   3 +
> >>>    include/hw/ppc/pnv_xscom.h |   6 ++
> >>>    hw/ppc/pnv.c               |  16 ++++++
> >>>    hw/ppc/pnv_adu.c           | 111 +++++++++++++++++++++++++++++++++=
++++
> >>>    hw/ppc/pnv_xscom.c         |   9 ---
> >>>    hw/ppc/meson.build         |   1 +
> >>>    hw/ppc/trace-events        |   4 ++
> >>>    8 files changed, 175 insertions(+), 9 deletions(-)
> >>>    create mode 100644 include/hw/ppc/pnv_adu.h
> >>>    create mode 100644 hw/ppc/pnv_adu.c
> >>>
> >>> diff --git a/include/hw/ppc/pnv_adu.h b/include/hw/ppc/pnv_adu.h
> >>> new file mode 100644
> >>> index 0000000000..9dc91857a9
> >>> --- /dev/null
> >>> +++ b/include/hw/ppc/pnv_adu.h
> >>> @@ -0,0 +1,34 @@
> >>> +/*
> >>> + * QEMU PowerPC PowerNV Emulation of some ADU behaviour
> >>> + *
> >>> + * Copyright (c) 2024, IBM Corporation.
> >>> + *
> >>> + * SPDX-License-Identifier: LGPL-2.1-or-later
> >>
> >>
> >> Did you mean GPL-2.0-or-later ?
> >=20
> > Hey Cedric,
> >=20
> > Thanks for reviewing, I've been away so sorry for the late reply.
> >=20
> > It just came from one of the headers I copied which was LGPL. But
> > there's really nothing much in it and could find a GPL header to
> > copy. Is GPL-2.0-or-later preferred?
>
> I would since all pnv models are GPL.

Some of pnv is actually LGPL. That's okay I'll change to GPL.

> I think some parts of QEMU were initially LGPL (there used to be
> a library, may be that's the reason ?) and other parts are relaxed
> to LGPL because they are reused in libraries.

Thanks,
Nick

