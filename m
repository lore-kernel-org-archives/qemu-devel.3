Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4E8CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGZLU-0001Bf-CL; Tue, 13 Oct 2026 06:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xGZLQ-0001BG-Pz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:02:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xGZLO-0007u7-Kk
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:02:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48b042c0728so588324f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791885769; x=1792490569; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9l8QxLsARWG71X43UIA7zF2h/xgxES9j9wgsYMacm1E=;
 b=jwWCO6yMWyGnTpqKDtI1sRtNwExlDxNFqjar7e5C5JDN+eLKQ8ZxEnyUuahPFG/EQM
 gBY2QpaCacVgQDueuE1zudI5tUFjmCr9dJ5EjeJqyn+aL4EpVHBEirWjWIalspcOhr30
 zhnb9oFlJY1urY0tDZIVeC04xQdrIT+JbckhNkwNckVC1Nqd5r1T1IILcXb3DcIk6JPl
 zy79ctU7toizNTQI+t6kKxFHVGR//yEgd2V6Z9H1TJlplLrEov7FgrSQBUxLbfilKmG/
 ag4GbMNw3RveH6fV1VCszYEanP6IRtwygZ2ybK0mQ32ooe2uZowTHAny23priuuV80b8
 VNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791885769; x=1792490569;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9l8QxLsARWG71X43UIA7zF2h/xgxES9j9wgsYMacm1E=;
 b=U5+/Y183IcNFCT1JenWlnHVzSc1yNTUZhAY+iPwr0caMwXBFr448LprBm6Kl7yaQ0O
 SM85ECqesh4L4DETIJJDY/qXLadamq32aFQrGU8LWGPjeT6rfYfl9g6BDLPVU3usJpqD
 e7mcFv15OIHHrYLaz+zC3h5X0aJUGx+gaC60oYPHFylzYZkACmpF0z6wdcUqc3tyusTO
 9YeWNWuuRaAsnkdZ7IyHcagyFCMXLBUiV9i6FEfZN/4sLKVMSIwinh343NLE+kHupnj+
 +Eo1Wz/c8b4j5GyX4Tg4ddCxjk3kZxTo9e2vNAN9P0OD20tSQSFYcSB+xHr44POORA4o
 Ip8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDxdWwTUqFGh+Gtj/ZRwQjC3+8RjDV6eZPaN6Vj4vKg5e3bJLGzGngsNcI3EK2Rm/myx2/LcWx/FN2@nongnu.org
X-Gm-Message-State: AFq9FYLZTb3mJhV60CUmN3NxLIwC2eWVI+Rw6m5ZhWE9wbYGNL8eJTB7
 6WB1a4W8mlTv31OTik7/gOGhhEFOe0fAItPOY1AxV8BHHCqLsThZpA2BCN18Vg==
X-Gm-Gg: AYBFou1GJMWpgLvi/+dc01L91NKxadOdqr58K4Sm+WC/FMxxifaip7lRdP2UDPSt9vV
 1DznYsaC+cuL4xk8Ug/HgGhJcy1nDDkLEaiz0Hvjl9u1VnmKlRv+wS7QFsq+CG1vpKi49iNVEtE
 wFBLDi/pkiDWbn9pJRmO3P9XoFltpglUPG2AVXU5CsEvAP/gfzKkk8Jl2NDgubjpLVi06n0pJYf
 peiUpV8R1f9pH7WCu7722xm45FgbNQWqvTNW7yr0TrsjxSCg6arUj9PsQUNhazLuGIwjPZA/VjB
 7ItOp0syzeLEzTCsHYC9+0eiuK2uLLQwIqxNlC+QZiu73lLruWmEULs3qN7bw54R5sI3zkNjKxN
 b8h9UCmO1Sr8tB86tkSMRtvCEPNV/iMMZVUYhL2lMy3oe/TObuTLUUiPqk6/YiDsImyNGS++JzD
 bheKNfBOTfxuyOi/ZOPvxZNamNThf9V4GEkib+rM6tNba6MltVZiBXoNNEicK3aUK0+5Ke8qQSt
 +u66+ssYZTPlkgj4SQ5Ty+O3IR5zF83TS3McQBheSqwySuVBV1F5bTD/jHr/63ambg39+I=
X-Received: by 2002:a5d:4e4c:0:b0:48b:10c8:2181 with SMTP id
 ffacd0b85a97d-48dbaaec6a7mr17303506f8f.27.1791885768649; 
 Tue, 13 Oct 2026 03:02:48 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf35e00015f07061f2b3fa54.dip0.t-ipconnect.de.
 [2003:fa:af35:e000:15f0:7061:f2b3:fa54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd1843sm4292643f8f.56.2026.10.13.03.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 03:02:47 -0700 (PDT)
Date: Tue, 13 Oct 2026 10:02:43 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 QEMU <qemu-devel@nongnu.org>
CC: Bin Meng <bmeng.cn@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3 00/10] hw/arm: Enable U-Boot boot on MCIMX6UL-EVK
In-Reply-To: <20261004090500.3082641-1-bin.meng@processmission.com>
References: <20261004090500.3082641-1-bin.meng@processmission.com>
Message-ID: <B64519F5-5D6E-4098-9B27-B2941EA0B2EF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 4=2E Oktober 2026 09:04:45 UTC schrieb Bin Meng <bin=2Emeng@processmiss=
ion=2Ecom>:
>
>The mcimx6ul-evk machine can boot Linux directly, but it cannot run the
>U-Boot proper produced by Buildroot far enough to load a kernel from its
>SD card=2E Early U-Boot boot test accesses currently abort or observe
>placeholder values, and the i=2EMX uSDHC model exposes several issues=2E
>
>This series lets an unmodified Buildroot 2026=2E05 U-Boot 2024=2E07 image
>run on mcimx6ul-evk, load zImage and imx6ul-14x14-evk=2Edtb from USDHC2,
>start Linux, mount the SD card root file system, and reach the Buildroot
>login prompt=2E It also documents and tests the existing direct Linux boo=
t
>path=2E
>
>Patches 1 through 4 provide the minimum early-firmware-visible state=2E
>Patches 5 through 8 address i=2EMX uSDHC behavior needed by U-Boot=2E The
>last two patches document both boot paths and add functional tests for
>U-Boot and direct Linux boot=2E
>
>This series is based on:
><20261003170232=2E2450916-1-bin=2Emeng@processmission=2Ecom>
>as the sdhci changes have conflicts=2E

Series applied cleanly for me onto latest master (615ece3c406b) with the f=
unctional test passing=2E

Best regards,
Bernhard

>
>Changes in v3:
>- Rebase on the v3 PolarFire SoC Icicle Kit series
>- Model the full reserved page as a child of a15mpcore_priv
>- Validate MMDC RAM geometry and document supported capacities
>- Translate uSDHC vendor clock gates in its MMIO handlers
>- Cover partial reset accesses and migrate vendor clock state
>- Extend contiguous SDMA completion to both eSDHC byte orders
>
>Bin Meng (10):
>  hw/cpu: a15mpcore: Model the reserved page as RAZ/WI
>  hw/misc: imx6ul_ccm: Update PMU_MISC0 reset value
>  hw/arm: fsl-imx6ul: Map early firmware register placeholders
>  hw/arm: fsl-imx6ul: Add a minimal MMDC geometry model
>  hw/sd: sdhci: Use a QEMU-local no-busy IRQ quirk bit
>  hw/sd: sdhci: Honor i=2EMX uSDHC vendor clock gates
>  hw/sd: sdhci: Preserve uSDHC status enables for U-Boot
>  hw/sd: sdhci: Skip SDMA boundary stops for eSDHC and uSDHC
>  docs/system/arm: Document MCIMX6UL-EVK Buildroot boot
>  tests/functional/arm: Add MCIMX6UL-EVK boot tests
>
> MAINTAINERS                               |   1 +
> docs/system/arm/mcimx6ul-evk=2Erst          |  72 +++++++++++
> include/hw/arm/fsl-imx6ul=2Eh               |   2 +
> include/hw/cpu/a15mpcore=2Eh                |   6 +
> include/hw/sd/sdhci=2Eh                     |  10 +-
> hw/arm/fsl-imx6ul=2Ec                       |  87 ++++++++++++-
> hw/arm/mcimx6ul-evk=2Ec                     |   2 +
> hw/cpu/a15mpcore=2Ec                        |  53 ++++++++
> hw/misc/imx6ul_ccm=2Ec                      |   2 +-
> hw/sd/sdhci=2Ec                             | 151 +++++++++++++++++-----
> tests/functional/arm/meson=2Ebuild          |   2 +
> tests/functional/arm/test_mcimx6ul_evk=2Epy |  69 ++++++++++
> 12 files changed, 416 insertions(+), 41 deletions(-)
> create mode 100644 tests/functional/arm/test_mcimx6ul_evk=2Epy
>
>---
>base-commit: 3ee3bacb1edd0896cb26f0f66493b4ab006fbffa
>branch: imx6ul-evk
>

