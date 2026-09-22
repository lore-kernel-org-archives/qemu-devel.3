Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70249C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8tjW-00057E-0r; Tue, 22 Sep 2026 02:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8tjT-00056o-Um
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 02:12:00 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8tjR-00043i-Pa
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 02:11:59 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so27957875e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790057516; x=1790662316; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T+/yHe4yCOHiAnN13rJkhxmkDVw/fNDm23Jsp3UdS7k=;
 b=VukUiC9A+38PeOHscYgcKA0xIaX3uVDJCA/8Q290wcvWXeGn8pxkJIQAmvMOBr0dU8
 ZefbtoB4TCpABeCvBUcIbC+0JxUJaEra6RZMONKIrlA+FWAXIKnK7mnnhWeRkhU3QCNC
 PL2JTjLIndRz9z/ZskT90RMySe7v/C726mQuptmsD0OV48959f/Qk14mbwl80ZMdmIuX
 KhrhNKTvHYWimbyOhMTHd0FbOwU7X1D8dVCcpZmNJcC0gKLdOYnfPYFvzyoRcKERbS98
 nXZJuej2Y/2w9DDziQywagTMlN+qhT3eYHfY2PUMgTBgQl4xuMuqi9icPRL2UxkLf0Wq
 4P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790057516; x=1790662316;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T+/yHe4yCOHiAnN13rJkhxmkDVw/fNDm23Jsp3UdS7k=;
 b=p2L9SUba0PxNHE9/9dfWUJGKTXvaxrvr+IwwdimIHltLRlJmbeyAOANLJ6mYXKLear
 0Di7k/flnp78b3V5j9HDlx2hYIjAkrBImEFZV4ZhuHZYXox81NpWrSMwh1O2aoA8OxSB
 5cvl85UifMWkXQMuhM7ZOyBQfcIz4i34QVBp2wvnSbxqqtSCsYILyTMJSIgA3ZDcCxgQ
 6QwOtxrRBj7QRYt2VC5FlIFruCuN621NS2mn5Fdj7OQdtfFyQMB6T6Cl48+LJ2bzOt8o
 UdgDmVHxgELWQvcAjgZwgtr8w7SdWVFXIYr3LThuT/9cNAFhbLJ27OguiOdhXIsfiFi1
 5tYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5Orb7qn1L0M7SIMVXS1B1yKRMidavBdv5kcBUFSJu3SiaEl0ZIF1Oiuas42yeHIWAZ3Dw/Zjd7wbK@nongnu.org
X-Gm-Message-State: AFuF++luNtk+ytRx+wZMssqnVhMEYOA9kVy+V8jc0LpizyJ7rCXtER+H
 WP76m+ybZy/ObSo482KswEaTGgvSCo3BKawbS1i3lB1o2I/Hlms4p0sB
X-Gm-Gg: AYBFou3FNTetBQHjkRUNb58Dyw8VU5Jp05UaG+lo3hPsz9xgdAyw1ntIqz6RetGJFai
 AxYxwJCOU4rPpCryF1gPP85aROuIsOLhrE3fc4GGiEoOe1PAa2u93asZFvapLdUStfzt7FGeFlN
 88WYaWADNWkAkXkK5Ybv9Ek4vxWEWd+5e5xOq4kyi6rTmdZDn/NTkJ7pMkKuFnmtxgtQgVDTEKQ
 vjUSodPKt0LoLya2eZLn2cwprBkx/a+vKdckIN4ReF0tMJMyj8g1cB+A++9MUVE3mUsgHcjLaYW
 k599ASVss26GC73r9eupeYqzVtLhgdV81A2MacwZx0TAKZcKExFYJzvpTOJfKXeeF1QndIwqBMr
 6w/MevOxoOCOR7U3D98HKgZhDlo5X1CzjJCW7+X+582l10FPjZWwSfjyAmDbb6toiQbe98qk/bD
 9U2zAj6kuiapYKqSOSYfzwvCtocWa/Nc30R38LkDds4sOJf81RC2s1Qd7YF+LiVg8Avtk/tbnYM
 dhk5znHb8HCyoTAdHFmgO/MQqV3m4swEDKdDa+1ZtRO9qdRKYOBbvZ+4LMWTlJQPgQtq/tRRouY
 lFwlcHAQ6iZFB58PgYQ=
X-Received: by 2002:a05:600d:8496:10b0:49d:17d4:d6ad with SMTP id
 5b1f17b1804b1-49fc57414b7mr115432445e9.23.1790057515984; 
 Mon, 21 Sep 2026 23:11:55 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-1c91-bf00-d99b-d42d-2461-dbe0.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:d99b:d42d:2461:dbe0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdad53c7dsm22378045e9.12.2026.09.21.23.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 23:11:55 -0700 (PDT)
Date: Tue, 22 Sep 2026 06:11:55 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
CC: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv3_00/10=5D_hw/arm=3A_Adding_Cortex-M7_Asy?=
 =?US-ASCII?Q?mmetric_Multiprocessing_boot_support_for_i=2EMX8MP?=
In-Reply-To: <20260920115458.481605-1-gaurav.sharma_7@nxp.com>
References: <20260920115458.481605-1-gaurav.sharma_7@nxp.com>
Message-ID: <DC17DA54-3C43-4955-A38F-6FADFAA2EFF5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 20=2E September 2026 11:54:48 UTC schrieb Gaurav Sharma <gaurav=2Esharm=
a_7@nxp=2Ecom>:

Hi Gaurav,

>Changes in v1:
>
>This series adds Asymmetric Multiprocessing (AMP) boot support for
>the Cortex-M7 core on the i=2EMX8MP SoC=2E The M7 firmware can be loaded
>and started from Linux running on the Cortex-A53 cores via the
>remoteproc framework=2E
>
>The series introduces the following peripheral models needed for AMP:
>  - GPC (General Power Controller)
>  - GPR (General Purpose Registers)
>  - SRC (System Reset Controller) authored by Bernhard Beschow <shentey@g=
mail=2Ecom>
>  - MU (Messaging Unit)
>  - Extends the CCM with M7 clock outputs and wires into the i=2EMX8MP So=
C
>  - Enable Cortex-M7 boot in i=2EMX8MP EVK functional test
>
>Changes in v2:
>
>- Removed the usage of device_class_set_legacy_reset in imx8mp gpc,gpr,mu=
 and
>  src=2E
>- Removed the usage of 'smp' , 'maxcpus' and 'enable-cm7' to make the
>  invocation simpler=2E
>- Cleaned up imx8mp_src by removing redundant/unused code=2E
>- Updated Maintainers and improved the imx8mp documentation
>
>Changes in v3:
>
>- Added a new patch for smp removal from test_imx8mp_evk=2Epy=2E
>- Added a new patch to introduce IRQ splitting for i=2EMX8MP AMP interrup=
t
>  routing=2E
>- Added a new patch to rename FSL_IMX8MP_NUM_CPUS to FSL_IMX8MP_NUM_A53,
>  since M7 is being introduced now=2E
>- In GPR, parent_phases moved from global variable to class struct
>- M7 reset handling moved from the machine to SRC device model=2E
>- Added ITCM and DTCM memory regions to support zephyr firmware loading=
=2E=20
>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>
>Bernhard Beschow (1):
>  hw/misc: Add SRC (System Reset Controller) to i=2EMX8MP

I think you can claim ownership of the SRC since I think only non-copyrigh=
table changes are left from the original commit=2E

>
>Gaurav Sharma (9):
>  hw/misc: Add i=2EMX8MP GPC (General Power Controller) IP
>  hw/misc: Add GPR (General Purpose Register) IP to iMX8MP
>  hw/misc: Add MU (Messaging Unit) IP to i=2EMX8MP device model
>  hw/misc: Extend i=2EMX8MP CCM with Cortex-M7 clock outputs

>  hw/arm: Enable Cortex-M7 AMP boot on i=2EMX8MP

This should be the last patch of the series=2E The paches below are refact=
orings and should rather be the first patches in the series=2E Right now th=
ey depend on changes in this series which prevents them from being cherry-p=
icked for early merge=2E

Generally, touching the same code twice in a series is discuraged and shou=
ld only be done with good reasons=2E In favor of a clean history QEMU is no=
t interested in the detours during development and instead we pretend as if=
 we knew the shortest path towards a goal in the first place=2E Makes sense=
?

Best regards,
Bernhard


>  hw/arm: Rename FSL_IMX8MP_NUM_CPUS to FSL_IMX8MP_NUM_A53
>  MAINTAINERS: Merge MCIMX8MM-EVK and MCIMX8MP-EVK entries
>  hw/arm: Add IRQ splitter for i=2EMX8MP AMP interrupt routing
>  tests/functional: Fix i=2EMX8MP EVK SMP configuration
>
> MAINTAINERS                                 |  13 +-
> docs/system/arm/imx8m=2Erst                   | 188 ++++++++-
> hw/arm/Kconfig                              |   4 +
> hw/arm/fsl-imx8mp=2Ec                         | 227 +++++++++--
> hw/arm/imx8mp-evk=2Ec                         |   5 +-
> hw/misc/Kconfig                             |  12 +
> hw/misc/imx8mp_ccm=2Ec                        |   9 +
> hw/misc/imx8mp_gpc=2Ec                        | 146 +++++++
> hw/misc/imx8mp_gpr=2Ec                        | 155 ++++++++
> hw/misc/imx8mp_mu=2Ec                         | 328 ++++++++++++++++
> hw/misc/imx8mp_src=2Ec                        | 411 ++++++++++++++++++++
> hw/misc/meson=2Ebuild                         |   4 +
> hw/misc/trace-events                        |   5 +
> include/hw/arm/fsl-imx8mp=2Eh                 |  33 +-
> include/hw/misc/imx8mp_ccm=2Eh                |   3 +
> include/hw/misc/imx8mp_gpc=2Eh                |  34 ++
> include/hw/misc/imx8mp_gpr=2Eh                |  62 +++
> include/hw/misc/imx8mp_mu=2Eh                 |  53 +++
> include/hw/misc/imx8mp_src=2Eh                |  52 +++
> tests/functional/aarch64/test_imx8mp_evk=2Epy |   1 -
> 20 files changed, 1696 insertions(+), 49 deletions(-)
> create mode 100644 hw/misc/imx8mp_gpc=2Ec
> create mode 100644 hw/misc/imx8mp_gpr=2Ec
> create mode 100644 hw/misc/imx8mp_mu=2Ec
> create mode 100644 hw/misc/imx8mp_src=2Ec
> create mode 100644 include/hw/misc/imx8mp_gpc=2Eh
> create mode 100644 include/hw/misc/imx8mp_gpr=2Eh
> create mode 100644 include/hw/misc/imx8mp_mu=2Eh
> create mode 100644 include/hw/misc/imx8mp_src=2Eh
>

