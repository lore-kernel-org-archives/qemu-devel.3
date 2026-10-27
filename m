Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6751C606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rJo+nhqc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLfGs-0004A1-2J; Tue, 27 Oct 2026 07:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xLfGp-00049d-D4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:23:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xLfGn-0004AP-By
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:23:11 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so2690099f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793100187; x=1793704987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UzdvnQE5DogPqm0HZi7myHTOzRWh4hSw+7JgGD38Zjs=;
 b=rJo+nhqcreKZhG7Ou1JjaYwzveGAAl4yThXF4th15P6wICtJ5t7HZQ3SVmckSwHVFx
 f4wJMO9jufqbW2Kig3ROjGlZZnbGc1HF2aBKKqlfGojBGvijvZ1oB5t9WWuAaexY77E0
 yj3TcutkVhzZ1rWrRgXAExRal5liCil8n+kaes6W3boDKGfC8kQLARCw34XU2OLOm7NG
 6bHyJ+GCCfddqkqW1RJj5xu/DnRBNFDRo2ZTJ0ClHL5UgLzGwBFnEBoCaf70Zee6pvAE
 ddGxENAwsnpIVkanX3R40GWrM8XwqJ9QgkwCr6xY2xCoSxLXKtbVr4/pvUOdp9GYuHDK
 HEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793100187; x=1793704987;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UzdvnQE5DogPqm0HZi7myHTOzRWh4hSw+7JgGD38Zjs=;
 b=Ng8HyJMJ5ErZAryrVRKutzHdaOe9lt+dBmfuPi9OF35k6aPPiIB/ekXAIU4k99e7vm
 OvDHkmZglrzDf7DYK9yPTxf+RESS46M698TdhF1ICQIGX3z8O50jcn0fexpardIK7ReF
 2VOHUuu7L4pZ9pIF8DUPuBabM+6GdR4C5O7Dy/cytySYFtZq22rjZcy9oEdOZQWQtOPK
 7EkbiDFI+tCKS+YGAx40dTmEgvmfvrJlFDlohZVqPjCaAJs56iKgtsN7Pc8R0js+vpCX
 Kf0FYSN4/TUwOsUMbNZsV9Z3VxRrJkyjueFADkIFikt2lqglJh/nzglnhjUv+gGK1y45
 7C3g==
X-Gm-Message-State: AFq9FYI3yT4UsPS0fjNk1CNG66mk5VHrjifA+InBGUFWdJJw0h9/MeoC
 dOV5xUDS7110za31xoS8zTah71v91h9gEPe1fBi4tGSFzapdtiBiJ6fW/1Aukg==
X-Gm-Gg: AYBFou1PoBYg+SsgHqz4iH1MFy+dh1u4FUIldLtTGtzEsGgIdmxicYjn5WHsK3+lTUJ
 uvzo8t9jYdfQiuLuRPWjpjOQDp2JE/W6nNbbyeHG5UbtovwIk7pwtYTj+2tjbq/Ut0MvWCw7a4m
 eSzKwSwJTy+B+z4ZXBaMagXJp+/y1NDwhuZftVZhn063FK12df8brgQCQD5hcGdTLAlRELWviup
 82LG+cbkojdj+E/gnUTD8JLw5kqveNMQ2u/s9sj3xy4WPRlOmDPsxWFjHug3nICJXJF/7BWdSvL
 KdNFvrZ2oZo69R0BkItaMEYzflMDstnConTDZZyyKqU5qkYx5AVQmJWW4Z7FT6e/pWcyvYqNe7T
 ZKoF/wi57mCR7FaEVpLMb5CxU9ENkH5tCciYpf2yrH0oQu+ZNBGUWE3MC6hS0XsARIJ6+ofOGG2
 9wd1bWku875G57fkJW970wX2P4EDApcRSdz6qO5dzN+c2CurIa1tmbQ52GeO5JJDJWjL7II6q1v
 s+lrJ+HtheH1+IoRF8LJzWFFD8I8bpLA3EJCb/KfqNfPZ8hR1NjEKEwN4rc7w==
X-Received: by 2002:a05:6000:27c9:10b0:48e:d88:55e5 with SMTP id
 ffacd0b85a97d-48e3eb457f9mr13604159f8f.6.1793100187282; 
 Tue, 27 Oct 2026 04:23:07 -0700 (PDT)
Received: from ehlo.thunderbird.net ([213.138.33.179])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3555sm21703165f8f.42.2026.10.27.04.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 04:23:06 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:22:35 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>, Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v4 00/31] i.MX fixes and cleanup
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
Message-ID: <2FD6FED6-EBED-47A4-9096-D4FDF2F17406@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 6=2E Oktober 2026 08:34:12 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>This series fixes various issues in i=2EMX device emulation, cleans up i=
=2EMX
>
>Kconfig handling, and improves some code=2E Functional console tests for =
the
>
>remaining i=2EMX boards are added where images are publicly available, ex=
cept for
>
>imx6ul which is taken care of in a different series [1]=2E Fixes which ap=
pear safe
>
>for backporting are cc'd to qemu-stable=2E
>
>
>
>The series is structured as follows: Patches 1-5 fix some issues and are
=
>
>mostly marked for backporting=2E Patch 4 is a follow-up on patches 1-3 an=
d
>
>should not be backported since it breaks migration=2E
>
>
>
>Patches 6-11 add and improve functional tests for i=2EMX devices=2E While=
 at it,
>
>saner defaults for the amount of RAM and number of CPUs are established=
=2E
>
>
>
>Patches 12-16 turn the remaining i=2EMX SoC device models into SySBus dev=
ices
>
>which fixes their reset behavior=2E
>
>
>
>Patches 17-30 are Kconfig cleanups where CONFIG_IMX gets split into dedic=
ated
>
>config items=2E
>
>
>
>The last commit just fixes some typos in the code=2E
>
>
>
>Changes in v4:
>
>* Fix triggering of watchdog_perform_action() (Bin)
>
>* Pick up R-b tags
>
>
>
>Testing done:
>
>* `make check-functional-aarch64`
>
>* `make check-functional-arm`
>
>
>

Ping

All patches reviewed=2E One may need improved commit message=2E Am I suppo=
sed to resubmit the series or will this be done inline?

Best regards
Bernhard

>Changes in v3:
>
>* Add dedicated patch fixing write one once WCR bits, cc'd to qemu-stable=
 (Bin)
>
>Done as yet another patch to tell the issues apart=2E
>
>* Add and fix some commit messages (Bin)
>
>* Add functional tests to 'tests_arm_system_thorough' (Bin)
>
>* Fix typo in functional tests for mcimx7d-sabre machine (Bin)
>
>* Use sysbus_realize() rather than sysbus_realize_and_unref() in case of
=
>
>embedded SoC struct (Bin)
>
>* Pick up R-b tags
>
>
>
>Changes in v2:
>
>* Remove patch adding `mc->ignore_memory_transaction_failures =3D true;` =
(Peter)
>
>* Rework wdt_imx2 patches (Peter)
>
>* Remove all but "hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS from =
config
>
>IMX" already queued by Phil=2E The preserved patch is required to remove =
all
>
>dependencies from CONFIG_IMX such that it can be removed=2E
>
>* Pick up R-b tags
>
>* Rebase onto latest master
>
>
>
>[1]
>
>https://lore=2Ekernel=2Eorg/qemu-devel/20261004090500=2E3082641-1-bin=2E
=
>
>meng@processmission=2Ecom/
>
>
>
>base-commit: d7a65d1793d691d356a56833620f7d1e6f5d653b
>
>
>
>Bernhard Beschow (31):
>
>  hw/watchdog/wdt_imx2: Preserve own locked bits in WCR
>
>  hw/watchdog/wdt_imx2: Fix handling of write one once WCR bits
>
>  hw/watchdog/wdt_imx2: Clear WDT lock on reset
>
>  hw/watchdog/wdt_imx2: Remove redundant attributes
>
>  hw/arm/imx8mm-evk: Fix reference count of SoC object
>
>  docs, tests/functional: Drop redundant CLI arguments in imx8m*-evk
>
>    invocations
>
>  hw/arm/sabrelite: Have 4 CPUs and 1 GiB of RAM by default
>
>  tests/functional/arm: Add console test for `sabrelite` machine
>
>  hw/arm/mcimx6ul-evk: Have 512 MiB of RAM by default
>
>  hw/arm/mcimx7d-sabre: Have 2 CPUs and 2 GiB of RAM by default
>
>  tests/functional/arm: Add console test for `mcimx7d-sabre` machine
>
>  hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
>
>  hw/arm/fsl-imx31: Derive from TYPE_SYS_BUS_DEVICE
>
>  hw/arm/fsl-imx6: Derive from TYPE_SYS_BUS_DEVICE
>
>  hw/arm/fsl-imx6ul: Derive from TYPE_SYS_BUS_DEVICE
>
>  hw/arm/fsl-imx7: Derive from TYPE_SYS_BUS_DEVICE
>
>  hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS from config IMX
>
>  Kconfig: Extract config IMX_AVIC from config IMX
>
>  Kconfig: Extract config IMX_GPCV2 from config IMX
>
>  Kconfig: Extract config IMX_RNG from config IMX
>
>  Kconfig: Extract config FSL_IMX7_GPR from config IMX
>
>  Kconfig: Extract config FSL_IMX{6, 7}_SRC from config IMX
>
>  Kconfig: Extract config FSL_IMX7_SNVS from config IMX
>
>  Kconfig: Extract dedicated config FSL_IMXx_CCM from config IMX
>
>  Kconfig: Extract config IMX_GPT from config IMX
>
>  Kconfig: Extract config IMX_EPIT from config IMX
>
>  Kconfig: Extract config GPIO_IMX from config IMX
>
>  Kconfig: Extract config IMX_SPI from config IMX
>
>  Kconfig: Extract config IMX_SERIAL from config IMX
>
>  Kconfig: Remove config IMX
>
>  hw/arm/fsl-imx8m: Fix typo
>
>
>
> MAINTAINERS                                 |  2 +
>
> docs/system/arm/imx8m=2Erst                   |  2 +-
>
> docs/system/arm/sabrelite=2Erst               |  4 +-
>
> include/hw/arm/fsl-imx25=2Eh                  |  5 +-
>
> include/hw/arm/fsl-imx31=2Eh                  |  5 +-
>
> include/hw/arm/fsl-imx6=2Eh                   |  5 +-
>
> include/hw/arm/fsl-imx6ul=2Eh                 |  5 +-
>
> include/hw/arm/fsl-imx7=2Eh                   |  5 +-
>
> include/hw/arm/fsl-imx8mm=2Eh                 |  4 +-
>
> include/hw/arm/fsl-imx8mp=2Eh                 |  4 +-
>
> include/hw/watchdog/wdt_imx2=2Eh              |  2 -
>
> hw/arm/fsl-imx25=2Ec                          |  7 +--
>
> hw/arm/fsl-imx31=2Ec                          |  7 +--
>
> hw/arm/fsl-imx6=2Ec                           |  4 +-
>
> hw/arm/fsl-imx6ul=2Ec                         |  4 +-
>
> hw/arm/fsl-imx7=2Ec                           |  5 +-
>
> hw/arm/fsl-imx8mm=2Ec                         |  2 +-
>
> hw/arm/fsl-imx8mp=2Ec                         |  2 +-
>
> hw/arm/imx25_pdk=2Ec                          |  2 +-
>
> hw/arm/imx8mm-evk=2Ec                         |  4 +-
>
> hw/arm/kzm=2Ec                                |  2 +-
>
> hw/arm/mcimx6ul-evk=2Ec                       |  3 +-
>
> hw/arm/mcimx7d-sabre=2Ec                      |  4 +-
>
> hw/arm/sabrelite=2Ec                          |  5 +-
>
> hw/watchdog/wdt_imx2=2Ec                      | 21 ++------
>
> hw/arm/Kconfig                              | 56 ++++++++++++++++++---
>
> hw/char/Kconfig                             |  3 ++
>
> hw/char/meson=2Ebuild                         |  2 +-
>
> hw/gpio/Kconfig                             |  3 ++
>
> hw/gpio/meson=2Ebuild                         |  2 +-
>
> hw/intc/Kconfig                             |  6 +++
>
> hw/intc/meson=2Ebuild                         |  3 +-
>
> hw/misc/Kconfig                             | 41 +++++++++++++--
>
> hw/misc/meson=2Ebuild                         | 24 ++++-----
>
> hw/net/Kconfig                              |  2 +-
>
> hw/ssi/Kconfig                              |  4 ++
>
> hw/ssi/meson=2Ebuild                          |  2 +-
>
> hw/timer/Kconfig                            | 10 ++++
>
> hw/timer/meson=2Ebuild                        |  4 +-
>
> tests/functional/aarch64/test_imx8mm_evk=2Epy |  4 +-
>
> tests/functional/aarch64/test_imx8mp_evk=2Epy |  4 +-
>
> tests/functional/arm/meson=2Ebuild            |  4 ++
>
> tests/functional/arm/test_mcimx7d_sabre=2Epy  | 46 +++++++++++++++++
>
> tests/functional/arm/test_sabrelite=2Epy      | 46 +++++++++++++++++
>
> 44 files changed, 273 insertions(+), 108 deletions(-)
>
> create mode 100755 tests/functional/arm/test_mcimx7d_sabre=2Epy
>
> create mode 100755 tests/functional/arm/test_sabrelite=2Epy
>
>
>
>-- >
>2=2E56=2E0
>
>
>

