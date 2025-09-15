Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756CCCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 19:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyEQK-0000O3-9F; Mon, 15 Sep 2025 14:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1uyEQH-0000Nq-TQ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:59:33 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1uyEQ6-0005qQ-RN
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:59:33 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-412a2fe2f36so21885ab.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757962754; x=1758567554; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xaX/fWfP49+8SaeYksc9gJpAga6hEcFc4Rbmx4y7b/E=;
 b=sDk1CvT1JBsPJ7bKCPKXq0lJoPJvQbxomFfr2xdSaYJEYOKiPjndaLVF6/PrjLRLoR
 XYYGbPsqbCsgmwzzkC5H9ZndsYJY8nhdd1StVZZKlpgErO0SosTj3+T/FvfTkVHZbQb8
 CACJcS1Ymxy1ZIaAY5RhzeVJNxCzSpczjsDrV7OZ/LbWZdyjd+m29Ir2OO14zUUDyga1
 MjwGr780nehSwRVscRSwg6XM6NVqDp4OZYyx3leT4HbXn20ENPlvjvJ5foXHtCOiETaL
 DVfDlufFToO/tF24qlny56igU03al5RUmHX2dtGghIO9BkCWwSTVMnN8epeVbPumiqVQ
 8prQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757962754; x=1758567554;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xaX/fWfP49+8SaeYksc9gJpAga6hEcFc4Rbmx4y7b/E=;
 b=d9hLOuhKdptB1L1UbEuq8fV6rd5RNjAI9N2ESsLkhWCRf8580Y8qxY809T4a6WE/3j
 tDNz6GraU+aTOf5aW3CLxbivnDt1iHGU1/Ib7z5Y2Qw/WyTGzTSc5rbGK0MJKt53vHzT
 Pc8mGbTcD/2wG2NfgnMR86lZk5dqJ/R+WMXN99TiwSfUz5mvFssTqlbA2QmRirAgaAtq
 TS6xCUlII/2QMWTUTtxh97qWa8JOuFty72smsBpY3T49qpzl1OdG215INYcN/Jpw8QJY
 6ubL2LWpwA2Y0yhc9rWQKL6QWmJUr++rjbAsXJJBDJJn4lpbUeGRsKZfluoHqZP6WvAB
 AxuA==
X-Gm-Message-State: AOJu0YzqRV9SOF4pOm2hP+Ask1MUHmyJprvfdEmdVNuu794jM391rDQe
 1VoChCBJWFiIxQJP7fxua4pK4Yl2IArX4pTjgMz++bCEo5RlMC41hYrsd38buJrl0o0PdiwMW4L
 YXm46DKmDprX98mBJqhXKP5V0xdhQq+CV0V+aHkm5fRfdTlH5fcBTkjVQ
X-Gm-Gg: ASbGncs6z2aMHOwwUyymEWEZbszN7ayxxpXiR6kYG0jleKsDTg7wU5JTruDsCwQUKpM
 tM/qlezFiJq0Ht9rtoaq0ShXM/nbhMoHufQkTp3WYnPIIpFI3Um5trgW38TF6pNsnhhlLHdp6Yh
 Bq2GQg6XsGUp9hmUcyLbhI1kea1DfkOC/+lujgoadxtn/cUGPnEzthSmQAbGtlKC2q3hZQR4w4u
 O1/Iw02Pk8eH4dv4fCkeRzlj69aAG5AGjvgDe1inwCFMIdd0bCDALA=
X-Google-Smtp-Source: AGHT+IG/FYbAUpLehiM2CGbvzvb6R/fA21DB/7YbaRSE6zKP2riUX38a6++H7pGcRNg3Sh5Vls+0OUQt7kbmwZqxkFI=
X-Received: by 2002:a05:6e02:16cc:b0:400:7d06:dd68 with SMTP id
 e9e14a558f8ab-4240e84c7b0mr1128405ab.14.1757962753627; Mon, 15 Sep 2025
 11:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250826205532.1500639-1-nabihestefan@google.com>
In-Reply-To: <20250826205532.1500639-1-nabihestefan@google.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 15 Sep 2025 11:59:02 -0700
X-Gm-Features: Ac12FXxY-dOQCNhWaS39kHKbUJB3gxyTEdAqWSJX4-gSDrsadKbDHx3-7h4aBqk
Message-ID: <CA+QoejUmDgKMuTbWY_1-7ok1spag-ANP-+TvsMgytkka+5PBdg@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/pci-bridge: Create PLX Virtual Switch Device
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 venture@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=nabihestefan@google.com; helo=mail-il1-x134.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Friendly ping on the review!

Thanks,
Nabih


On Tue, Aug 26, 2025 at 1:55=E2=80=AFPM Nabih Estefan <nabihestefan@google.=
com> wrote:
>
> Create a PLX PEX PCIe Virtual Switch implementation that can be used
> for modeling trays. This is a generalized version of the xio3130 switch w=
here
> we can set the PCI information on creation, allowing us to model differen=
t
> trays without creating specific devices for all of them. It is used the s=
ame
> way the xio3130 switch is used + the PCI Signature information.
>
> The idea is to minimize the difficulty of creating different trays whose
> only difference is recognition by some daemon through PCI signatures.
> Instead of having to create 8 different versions of xio3130 that have
> the same functionality but different PCI Signatures, we create one
> general version where you can declare the PCI Signature information,
> while keeping the same base functionality. This is not meant to fully
> replace xio3130 since that is easier to use without knowledge of the PCI
> Signature, this is meant to decrease the difficulty of creating switch
> trays that require certain PCI information for recognition without any
> significant change from a normal PLX Virtual Switch functionality.
>
> Changes from v1&2: Updating different formatting and API changes that
> ocurred QEMU-wide since these patches were first staged in 8.1.
>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Signed-off-by: Patrick Venture <venture@google.com>
>
> Nabih Estefan (2):
>   hw/pci-bridge: Create Initial revision for PLX Virtual Switch
>   MAINTAINERS: Add entry for PLX VSwitches
>
>  MAINTAINERS                            |   6 +
>  hw/pci-bridge/Kconfig                  |   5 +
>  hw/pci-bridge/meson.build              |   1 +
>  hw/pci-bridge/plx_vswitch_downstream.c | 188 +++++++++++++++++++++++++
>  hw/pci-bridge/plx_vswitch_upstream.c   | 178 +++++++++++++++++++++++
>  include/hw/pci-bridge/plx_vswitch.h    |  43 ++++++
>  6 files changed, 421 insertions(+)
>  create mode 100644 hw/pci-bridge/plx_vswitch_downstream.c
>  create mode 100644 hw/pci-bridge/plx_vswitch_upstream.c
>  create mode 100644 include/hw/pci-bridge/plx_vswitch.h
>
> --
> 2.51.0.318.gd7df087d1a-goog
>

