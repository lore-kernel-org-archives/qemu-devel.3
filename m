Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B51CC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 06:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZQt-0001FZ-7q; Thu, 30 May 2024 02:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCZQr-0001EX-Fo; Thu, 30 May 2024 02:38:37 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCZQp-0007jg-QA; Thu, 30 May 2024 02:38:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f60a502bb2so4337245ad.3; 
 Wed, 29 May 2024 23:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717051113; x=1717655913; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISgpFswh6K3lqC0w3N8gQYlpCmPstnpzIl+2CV5icYw=;
 b=Wywvy9oWjTQzUmHiFcHY+R3OTLX7qjEBmJI57kvU+TsG0G2SCFwoVSDmipFvwp70bq
 nvSrpLMOHxLCuzu8nUvf4ofOVdE4XMqjsWdRprgY2euvEwNIZGoB41fs/O0c3kGY23wO
 cVBFRIfXtrLsou7kYvIM7hiIK0p9mAEf1cveHGVSsfv1YfObcmplE0HkcCSWZRd9DLFx
 BsKBK5e4N07E9HR+zJxpVRdNcIyox9ML+NbyMwSP8ksh80guEJMAXywP3MBlYTDL3+6v
 bPnlNDd914ANUrsC5J7+qcTUy0AGdpHlRq74UghmZ0Ifib7Cj3J+vZtV649seuEGUto7
 CnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717051113; x=1717655913;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ISgpFswh6K3lqC0w3N8gQYlpCmPstnpzIl+2CV5icYw=;
 b=NfAI3ZKrAT1zTKLI9PdMG56bRl9dv+XWz4mnAxcltRSaOvrjJKhyE/KvBlmQj0V6MT
 oOl5WeekqsSeQHBmfHQT2vDy6ZS7chZcj89S6PWphRLLXBZ5zsZzYGM5GAIT2o8Rn4VM
 nC/D88s6f2gsuc1iDIlGBCLi2lddMLfu6BMMfYS6jZJMlm062uGNNnCVueXdLxXUKJE0
 /tpnJehKTKLfwGCYJeh47aeAhtn+ILs8LpTgM5IHtd9kTvJSvKaetY4fvuNTMuqrFRFx
 VQvWT9VGOJfMrU7Ad8l0SBk/sk8wYSP5El+OrJWprXoXOhtvNzzNxSh/4/Lx4Z9fbtKH
 8DhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo/7hZcICidgdWMfU7GQeQhw+f6Fmo9WEAT34L5EvhSgNUbYaKULCMV3gBHcR5BnmzBGHsgIv9GlvhKTUqq9XWoOvStqqdykm/LtHkmi2jOh5BcyJ4mXnh8Dg=
X-Gm-Message-State: AOJu0Yw1ZWp+XDFJRGF81gi+GtCCp4nmQrvxZVjMrW5ygF1PMaZpJEup
 vMHMzHgnFmpXY5aKf4GBShnKcho0pdZBXqaDCi4l1oP7SKqRlAmm
X-Google-Smtp-Source: AGHT+IGPhoUWNWrWt0c7GprashJwIdpIn9ilL/1C+IrlDlCOo7xFdMWEqlYn52KHuge0TuJTwljX0Q==
X-Received: by 2002:a17:902:d4c5:b0:1f3:590:71d9 with SMTP id
 d9443c01a7336-1f6192efdf6mr14850325ad.2.1717051113366; 
 Wed, 29 May 2024 23:38:33 -0700 (PDT)
Received: from localhost ([1.146.118.54]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f4ac27c5aasm63995695ad.251.2024.05.29.23.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 23:38:32 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 May 2024 16:38:26 +1000
Message-Id: <D1MRTGSNBMIG.UM9QTB7080GH@gmail.com>
Cc: "Caleb Schlossin" <calebs@linux.vnet.ibm.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 05/10] ppc/pnv: Extend chip_pir class method to TIR
 as well
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-6-npiggin@gmail.com>
 <39e4ac93-256b-424b-8ecb-7ed87afeb048@linux.ibm.com>
 <D1LP8QHR9GGW.2QAD6R00QARSG@gmail.com>
 <53791846-3b8c-4da8-8cca-c2c521c59450@kaod.org>
In-Reply-To: <53791846-3b8c-4da8-8cca-c2c521c59450@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Wed May 29, 2024 at 4:30 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/29/24 02:24, Nicholas Piggin wrote:
> > On Tue May 28, 2024 at 6:32 PM AEST, Harsh Prateek Bora wrote:
> >>
> >>
> >> On 5/26/24 17:56, Nicholas Piggin wrote:
> >>> The chip_pir chip class method allows the platform to set the PIR
> >>> processor identification register. Extend this to a more general
> >>> ID function which also allows the TIR to be set. This is in
> >>> preparation for "big core", which is a more complicated topology
> >>> of cores and threads.
> >>>
> >>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>> ---
> >>>    include/hw/ppc/pnv_chip.h |  3 +-
> >>>    hw/ppc/pnv.c              | 61 ++++++++++++++++++++++++-----------=
----
> >>>    hw/ppc/pnv_core.c         | 10 ++++---
> >>>    3 files changed, 45 insertions(+), 29 deletions(-)
> >>>
> >>> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> >>> index 8589f3291e..679723926a 100644
> >>> --- a/include/hw/ppc/pnv_chip.h
> >>> +++ b/include/hw/ppc/pnv_chip.h
> >>> @@ -147,7 +147,8 @@ struct PnvChipClass {
> >>>   =20
> >>>        DeviceRealize parent_realize;
> >>>   =20
> >>> -    uint32_t (*chip_pir)(PnvChip *chip, uint32_t core_id, uint32_t t=
hread_id);
> >>> +    void (*processor_id)(PnvChip *chip, uint32_t core_id, uint32_t t=
hread_id,
> >>> +                         uint32_t *pir, uint32_t *tir);
> >>
> >> Should it be named get_chip_core_thread_regs() ?
> >=20
> > Yeah, the name isn't great. It is getting the regs, but the regs are th=
e
> > "pervasive id" used as well... but maybe that's not too relevant here.
> > What about we drop chip_ since we have the chip and no other methods us=
e
> > such prefix, then call it get_thread_pir_tir()?
>
> processor relates to chip and so, processor_id() is not great indeed.
> get_pir_tir() would be enough I think.
>
> What would be good though, since pnv is growing, is to start adding
> documentation to these common helpers.

Okay we'll use that name.

You mean just a comment them in the header? Might as well do that for
new ones at least.

Thanks,
Nick

