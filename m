Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EA6CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 22:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS09W-0006Ex-Ub; Tue, 26 May 2026 18:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wS09U-0006ES-An
 for qemu-devel@nongnu.org; Tue, 26 May 2026 18:21:32 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wS09S-0004uS-Ch
 for qemu-devel@nongnu.org; Tue, 26 May 2026 18:21:32 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45e9f4a3510so3218654f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779834089; x=1780438889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZMPaD0nqZqi9xe2gwsji6WABpUOiXcG8kaBcvLAQrU=;
 b=KYWbBOEFrsqE5pl97XTf4O9KSnTyuPZYKJsY3xRlSNLMozNRgfgm4oM6nPKKVQKwHl
 nqqdUXv0dYZT/mxIYSM5uJneDWxpUlCFE2QdW+is33qse+m4efnrUtxZCG6gTT1vGZDS
 9YlsuV6UHv2a7DjZTh9vFH6y9Eb328ZIOFfbE3DRoHWnPo6G0ChWnLSP+SozGtVU+jJF
 2b+33HcEhJEbJDmRImjsJxq4v34P+S5XYEFlSZoXv4n51kx8s2KVL5MMWQ2TtGltFQjJ
 Gw0ULyVxBa14us4Ocj6h6i75UwbFTE+S6XZGQZJJK9gU4FV1VPposqXhGua9oMLzY/7+
 4ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779834089; x=1780438889;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VZMPaD0nqZqi9xe2gwsji6WABpUOiXcG8kaBcvLAQrU=;
 b=r9DTBWWI2/ILhHrDKeSM/94JvaY2907GKhF8HDMPdyCpG9P5gJjD7IVfDV/ySN2AXK
 2HbwpNoSQVrZBURg8jz3c0Rsot0QMHDUJW65sPieKfl98kAbZYcOzwQ+YeZjw6zRs7a8
 omJO/dOL6KeZ9zPzH6VKegX3+52y7sWp3ZgmvneLfKPpcoyFWV1e0Grkjy/3ZaFLj0VM
 AOWG9NkXgn4T56lJMwrg9yBfD+1juuSrUKtuIpWQq8fsEmtP7Ci9QSzea2knCeRoG8jq
 WTTb2FcUCQWQvRuxpkcdFGugLc1Dir3cHKFXjTYe5kDevAroyL+Qp4DOCW97gp1E+wzM
 qVRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+I9T+HMOSVLaGbHO+GUK+86KZOmJpE+iB1YxZXSEU8YzL2zlOlCEUSV0AxKhRVBAZ/D7aGX4q64gEN@nongnu.org
X-Gm-Message-State: AOJu0YwVSyJ1qwh9Y+jsWrDiLeyS+HRq+HjNthiHiHG0e99SCMVoe0AB
 YxKDHKLV/k3/21TIAPYvYhsBJl94pZyvfwvqIFtC0hL78MWKoRIrw+90
X-Gm-Gg: Acq92OEQfeVurCYD+YSyOkYMsUHNK+mbYmBQWxMgZlzgZzhGiu4/yVQcAfczPFIWykz
 o4EMVuOyCyeAivE+CqDPjDE3wT3p2eeoaH8ujKQcnovI9hbGNDItqbACFArSvVfSb81HnSmB9Jf
 Eu7DFHqB5CN+Yi2mHoEozytYDkj8z5urbSGZ0yOp3xUCPwDQSIiRQMpUNdigL84xjzal/3mCJ1p
 AR9qmHtXNzfAhL7P5eOOjVuMLg2xU8Wb3UF019WFi2EjHV6zrR/PX5AOMxujyNOjw1VgBK0CSOQ
 l6rFCiwhBBMQ1zfJmA00/crUy1nAxMzhuojWrdfqG3ukSzY447wA+KctNCtvLAHIsasalpAbpp3
 pJzPMBL4tlf+YvD/6ljy/hJrCpVMg6U0hwfLuLLofey/76fCofeCsRKRkfVrvxIzOhgQeuXRB/5
 UkBqHaY8cm+/xK8ZjbUM4iXD6yJUtccWFy8SrdcijgrI1k6lf0NzwZbA0CQvNHkDyxUPKAaztVE
 7wpufICOafe2oIM9MBRY3bbofUnt7iNYkxLOvSOtXcDfwHkh7zm5iVF
X-Received: by 2002:a05:6000:144c:b0:43b:3e40:2223 with SMTP id
 ffacd0b85a97d-45eb3696cffmr34387462f8f.19.1779834088642; 
 Tue, 26 May 2026 15:21:28 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-1b54-f900-0110-758a-6876-5140.310.pool.telefonica.de.
 [2a02:3100:1b54:f900:110:758a:6876:5140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb4bae01sm1403917f8f.0.2026.05.26.15.21.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 15:21:27 -0700 (PDT)
Date: Tue, 26 May 2026 21:26:21 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
CC: pbonzini@redhat.com, peter.maydell@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv1_0/7=5D_hw/arm=3A_Adding_Cortex-M7_Asym?=
 =?US-ASCII?Q?metric_Multiprocessing_boot_support_for_i=2EMX8MP?=
In-Reply-To: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
References: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
Message-ID: <D6AE3A65-8ED9-47B9-B7D5-51D8500B47AF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x434.google.com
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



Am 19=2E Mai 2026 17:56:28 UTC schrieb Gaurav Sharma <gaurav=2Esharma_7@nx=
p=2Ecom>:
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

Awesome work!

I'd like to experiment with this series myself=2E Could there be some "coo=
king recipe" in the board documentation for easy reproduction/failsafe tuto=
rial? Is there perhaps some Buildroot defconfig with the appropriate suppor=
t enabled? Or even better: Are there any binary images that could be used i=
n a functional test in addition?

Last but not least: Wouldn't it be useful if you became co-maintainer of t=
he imx8mp-evk? Perhaps the two sections in the MAINTAINERS file could be me=
rged=2E

Best regards,
Bernhard

>
>Signed-off-by: Gaurav Sharma <gaurav=2Esharma_7@nxp=2Ecom>
>
>Bernhard Beschow (1):
>  hw/misc: Add SRC (System Reset Controller) to i=2EMX8MP
>
>Gaurav Sharma (6):
>  hw/misc: Add i=2EMX8MP GPC (General Power Controller) IP
>  hw/misc: Add GPR (General Purpose Register) IP to iMX8MP
>  hw/misc: Add MU (Messaging Unit) IP to i=2EMX8MP device model
>  hw/misc: Extend i=2EMX8MP CCM with Cortex-M7 clock outputs
>  hw/arm: Enable Cortex-M7 AMP boot on i=2EMX8MP
>  tests/functional: Enable Cortex-M7 boot in i=2EMX8MP EVK functional tes=
t
>
> docs/system/arm/imx8m=2Erst                   |  90 +++-
> hw/arm/Kconfig                              |   4 +
> hw/arm/fsl-imx8mp=2Ec                         | 212 ++++++++++
> hw/misc/Kconfig                             |  12 +
> hw/misc/imx8mp_ccm=2Ec                        |   9 +
> hw/misc/imx8mp_gpc=2Ec                        | 124 ++++++
> hw/misc/imx8mp_gpr=2Ec                        | 129 ++++++
> hw/misc/imx8mp_mu=2Ec                         | 308 ++++++++++++++
> hw/misc/imx8mp_src=2Ec                        | 431 ++++++++++++++++++++
> hw/misc/meson=2Ebuild                         |   4 +
> hw/misc/trace-events                        |   5 +
> include/hw/arm/fsl-imx8mp=2Eh                 |  29 +-
> include/hw/misc/imx8mp_ccm=2Eh                |   3 +
> include/hw/misc/imx8mp_gpc=2Eh                |  34 ++
> include/hw/misc/imx8mp_gpr=2Eh                |  56 +++
> include/hw/misc/imx8mp_mu=2Eh                 |  53 +++
> include/hw/misc/imx8mp_src=2Eh                |  32 ++
> tests/functional/aarch64/test_imx8mp_evk=2Epy |   3 +-
> 18 files changed, 1535 insertions(+), 3 deletions(-)
> create mode 100644 hw/misc/imx8mp_gpc=2Ec
> create mode 100644 hw/misc/imx8mp_gpr=2Ec
> create mode 100644 hw/misc/imx8mp_mu=2Ec
> create mode 100644 hw/misc/imx8mp_src=2Ec
> create mode 100644 include/hw/misc/imx8mp_gpc=2Eh
> create mode 100644 include/hw/misc/imx8mp_gpr=2Eh
> create mode 100644 include/hw/misc/imx8mp_mu=2Eh
> create mode 100644 include/hw/misc/imx8mp_src=2Eh
>

