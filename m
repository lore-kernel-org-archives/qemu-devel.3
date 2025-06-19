Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80729C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 14:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSGeg-000427-KV; Thu, 19 Jun 2025 10:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leetroy@gmail.com>)
 id 1uSGee-00041Q-38; Thu, 19 Jun 2025 10:54:16 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leetroy@gmail.com>)
 id 1uSGec-0006nn-9K; Thu, 19 Jun 2025 10:54:15 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-313f928718eso622200a91.0; 
 Thu, 19 Jun 2025 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750344852; x=1750949652; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eak0OZ1v1XW00XZMJ/aMzb0NE0RwdLT7+UVeEZBSXc4=;
 b=dtEqm2WjtWcsR8Vm02A7+XgGag5Xyc2pZyfMtk3dOVX75SDuZrHsyyLCKQFZGsPd+0
 KT7iRM4S3c9OOEulhlsMr3/u57RoCSnEMF35cYxsnynv5kKfKumvdMrPSMz9ekF/osul
 6RXE9PvB1FEr/0GZdxFs7oECVR/Ec0eet+Z6xNSx/Th5yuLSOJZDPQZn76NEVom8+V82
 B3VgAjeMnMIDDCQoMSsjOvdL8mCOKlf+igpmETUfJXz1ezD9aJhbaUwn6GmcS+Wni3n5
 hnKu6f+cyeMq42JVb3Y1h7ljTvV2cBjNmnnvyjCVV9ZViBXWzoIVX7f7r7AJfg2kgCa9
 wtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750344852; x=1750949652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eak0OZ1v1XW00XZMJ/aMzb0NE0RwdLT7+UVeEZBSXc4=;
 b=lOjFzaNgIZ+PQAzRAM4BDT7jYyIGefsYCwsS5YdjJUJFS33OpdzRRM3XkgdMn2FhfR
 fkM/wEDgaEDWpxgErJR4oILTTkhio4c/n68gw+DiZjQav4AxKj5fpbSB/DbBeV8XA5sU
 dDrQMw2TdaooUCL2yVn7Pu2wAPvXTMSA1OLzfoFUxF9fNnf9iLvRR1cx457T7vV8qvmU
 D+iUqibqaXzzo0dknnPd3BzDe3EehmdZnXaG1eI9TCCSckXFj8baJIuUwfCO0dZcDzz0
 V3ru030tBmJLpOmPq3JBVrnoQYjIb9U5x1BIF3VWKIT/XxruOB/coYgMpIBeb+L0U0aj
 C4Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR0DOM2k2cPthlFWsZsMlzmwczu6HB+mgBKyQbbtDQKB+LLk2pssa82FKYSFesL2Ar5IcBRBkKk7nj@nongnu.org
X-Gm-Message-State: AOJu0Yxxrd1EpHcRbhTWqQdoxVMk6lgf74rxL2oFnj9ZJCzaoYES+zX8
 zQEvN92pmSlkefjmmKg869TDczHPMpqd3oZvc+ThNryWvbUn1oj9fx0Mk1zgbq9yDB/3n3AcPXs
 2nKCRsqW2Z+eVCvTpeX2qAGMThT5mTy8=
X-Gm-Gg: ASbGncvSIfHY8sB2Ph0DM02yyvbQe6Hk/c9fZGP/p7Hw/tz6TbGu17uETcVNpSlTj3f
 cFeI69Tf5TY5MgHziTeF44ltD/arYtd7w6OnHUHuB3Vp+0Raa0xYDVyJ4whpaycQi+6yq9XxOfh
 5u+M5Qdw9mNfUV6wO7UwyMJ2oeL294aIWFLCNzV/FvGElrJX7GoKZOlgs=
X-Google-Smtp-Source: AGHT+IGReQt3RYr+us8AgNXWYi8PKhXlFqOduL+Xhk9LlVx8olv/3no4AdWlouMunmrB8/VmTFn2rSZKxESzQafyiVE=
X-Received: by 2002:a17:90b:3b4e:b0:312:e618:bd53 with SMTP id
 98e67ed59e1d1-313f1ce2b77mr25890209a91.26.1750344851685; Thu, 19 Jun 2025
 07:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <e2df1ff1-3ce4-4233-b32e-2bc680725c71@kaod.org>
In-Reply-To: <e2df1ff1-3ce4-4233-b32e-2bc680725c71@kaod.org>
From: Troy Lee <leetroy@gmail.com>
Date: Thu, 19 Jun 2025 22:54:00 +0800
X-Gm-Features: AX0GCFsCtrLKA9THJERQubk15_hyJ0q_lAX8IjRoR9UeemtGeKDEfHcBIRDJeKw
Message-ID: <CAN9Jwz2m=YX-1_U6z6-=opxoYL8RkFT76--WMcgzOkVZjsFyrA@mail.gmail.com>
Subject: Re: aspeed: Split the machine definition into individual source files
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Patrick Williams <patrick@stwcx.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=leetroy@gmail.com; helo=mail-pj1-x102e.google.com
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

Hi,
On Thu, Jun 19, 2025 at 5:24=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> Hi,
>
> This is a follow up of a private discussion with Patrick.
>
> Aspeed modeling started nearly 10y ago with the palmetto-bmc machine.
> We now have 5 SoCs and 25 machines which are mostly defined in
> in a single aspeed.c file. Multi SoC machines, fby35 and ast2700fc,
> are defined in fby35.c and aspeed_ast27x0-fc.c respectively.
>

Sounds good to me.
While we're on this subject, we have many variants of the AST27x0 SoC
and development boards in different form factors. Should we also create
separate SoC models and machine definitions for each one? Or can we
treat AST27x0 as a superset of AST2700, AST2750, AST2720, and
any future models?

Thanks,
Troy Lee

> Since we started separating the SoCs :
>
>    hw/arm/aspeed_ast10x0.c
>    hw/arm/aspeed_ast2400.c
>    hw/arm/aspeed_ast2600.c
>    hw/arm/aspeed_ast27x0.c
>    hw/arm/aspeed_ast27x0-ssp.c
>    hw/arm/aspeed_ast27x0-tsp.c
>
> We could do the same for the machines keeping an 'aspeed_ast<rev>'
> prefix (and maybe avoid the 'bmc' suffix). I think this would ease
> introduction of new machines. We would be able to get rid of
> aspeed_eeprom.[ch] and move machine custom data in the machine source
> file. Which seems cleaner.
>
> Timing is about right for code reshuffling, still 3w before soft
> freeze, no important changes inflight, but if we start doing this
> conversion, we should do it for all. See the list below for the brave.
>
> Comments ?
>
> Thanks,
>
> C.
>
>
>
> * AST2400
>
>    palmetto-bmc
>    quanta-q71l-bmc
>    supermicrox11-bmc
>
> * AST2500
>
>    ast2500-evb
>    romulus-bmc
>    sonorapass-bmc
>    witherspoon-bmc
>    yosemitev2-bmc
>    supermicro-x11spi-bmc
>    fp5280g2-bmc
>    g220a-bmc
>    tiogapass-bmc
>
> * AST2600
>
>    ast2600-evb
>    qcom-dc-scm-v1-bmc
>    qcom-firework-bmc
>    rainier-bmc
>    fuji-bmc
>    bletchley-bmc
>    fby35-bmc           (fby35.c should rename to aspeed_ast2600-fby35.c)
>
> * AST2700
>
>    ast2700a0-evb
>    ast2700a1-evb
>    ast2700fc           (aspeed_ast27x0-fc.c)
>
> * AST1030
>
>    ast1030-evb
>

