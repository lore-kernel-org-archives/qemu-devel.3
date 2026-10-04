Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8FECA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLO0-0004rx-Jy; Sun, 04 Oct 2026 08:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLMR-0003Ue-Gt
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:30:35 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLMP-0007dA-91
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:30:34 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6351831so371123f8f.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791117032; x=1791721832; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yOtfvk3TFyTt4v7wB8UBog4ERy/GTDuDkFhYZWXjGdI=;
 b=VEtmFT6es8yXTg+Ge4OSzzbMYdc8PQtab67hCG9hslnHv0uIH15yKG3DrvX6g0yJ3v
 nEoj3Evai4nPP7yQkjswuaokrcWxa1mj1nE6fblfSLFqJEfUtqIApQGvRs9SaV7aIeiN
 0sau5DY6TiI4WjchcOhMUcmINFqzf/76y++3ztiVwuXsgkNOrwYQSOkpEONAStkfknBh
 SJwuW1UXeZHxOX4yII5CfYUQKdw8wK/m/i2a6yMy7f7shZj8tusARr8W/qV70ocXQFGk
 wSEwtB2482Wk2d3r6u0PSpcCoeZNBvmZm6kl08CKFybVGSYv7YH+q7zoR4X7zEDQ/x4E
 uEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791117032; x=1791721832;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yOtfvk3TFyTt4v7wB8UBog4ERy/GTDuDkFhYZWXjGdI=;
 b=frbxkh8D/O2RXrgsIz5YDmFcBj9iwTh+g+TOBGMBdRvOC1B222j8XYRP1TEOvnXr7w
 t+vAL0mhJR9sLrNZHS/ClgY5AJ8R3tnyCQLggw1NBmsUg/imZhYmziod2TScCMCgJBNq
 yDsDnhewbXhS5iRsnsjxI4aD1GkeeJxkaEu4rjxoxUyqE329xLx9rvaOFFnqMy43i+gF
 bzHlt6pACZyiFCiYMqXc10zFd30/csD7fIaf80+Q3btHXfIYvl0KtDBcFKP9gDU1qXJe
 ebUIWLobuCWPs3bG2s8lfv7hpoKK3JZD1n+7QxJLR8NCNrDLeJVv5D5JFrX4HgxAwTQL
 rk1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzENbW5ND0vGJAkY4UjvRPjxkr/wvjWwQygcO1KE7QClkfi6k+Jr+FJQ3OBlxKbl/W29Qd1l4uaQiJc@nongnu.org
X-Gm-Message-State: AFq9FYKQ+TYh1zNr0bVWNWN1vFSWIgVyN3nqLue+zDtPvoiP5mYGNjmf
 H8XP/mPq0fIW1hNoVzWxgnxnXoUtPz12nscfGDwyssyUm9p4v6/5jMQM
X-Gm-Gg: AYBFou1KCfQYhhAkgWfU25ax6HCxi5r9ZiO72tp/tiKBRPKla8Qw3yS9WWZVptc8Qve
 MerLoXgFf5HlV8awU/W6x9MBDJh7r95ahaFUF0vi4PLvLtPZaU3hiSSXD6wtzZuA8u0AafXAR5W
 jPMTq1Z/ltIAcMPiyEW1H2y7JZ0nfLbdWB24vjrC3+qyPZUFBoMbnKUCnbUHxvHxBu9vhLUaRoe
 VXXNJ26lHx5XSxVrxVPex5AZ5w5U6EorniboNgY6P3RkcDHS4WNdcMEhOzsH/kVzURNMo6z5feE
 DrabDCKedCuUnkr2oOpsZe3D476tFigW1Dao6du0Vmun0SzEVQ0lgXxd9UHfOgL93D84nry1e8I
 4eRoAFuEJI4B/vpTbcfqbBZ1jpcMdmXNrbKg1KdfT+igHFnB9gEOckgFOXbklV8Gh9Zr5rUlP0M
 Cd4AgJ1CRJ26R6vUrpHceitlfen6aWjMR+OXC7cnDYfTNKUGMZdlmud0WvsoXFJl4uuLp9VA0Oa
 Uq5XrIdJI3AawJWNNpCErplMSN8dibkNKRCVaviGKL5MKCzcr1E2rUNr6/M9obnGBfGzzhxpLME
 w6po
X-Received: by 2002:a5d:6f16:0:b0:48c:4649:b020 with SMTP id
 ffacd0b85a97d-48c4649b382mr8342976f8f.19.1791117031580; 
 Sun, 04 Oct 2026 05:30:31 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf09ae00194a0cc2b67f93fe.dip0.t-ipconnect.de.
 [2003:fa:af09:ae00:194a:cc2:b67f:93fe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380fada5sm17476540f8f.24.2026.10.04.05.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Oct 2026 05:30:30 -0700 (PDT)
Date: Sun, 04 Oct 2026 12:30:23 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
CC: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: Re: [PATCH 00/42] i.MX fixes and cleanup
In-Reply-To: <d50928dc-f932-403e-ba86-b0708555f9d4@oss.qualcomm.com>
References: <20260921214710.29422-1-shentey@gmail.com>
 <d50928dc-f932-403e-ba86-b0708555f9d4@oss.qualcomm.com>
Message-ID: <FD415C9C-BA09-4D16-9AF8-C58FE6755622@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x10.google.com
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



Am 29=2E September 2026 12:39:29 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@oss=2Equalcomm=2Ecom>:
>On 21/9/26 23:46, Bernhard Beschow wrote:
>
>> Bernhard Beschow (42):
>>    hw/watchdog/wdt_imx2: Fix handling of write-once WCR bits
>>    hw/watchdog/wdt_imx2: Remove unused attributes
>>    hw/arm/imx8mm-evk: Fix reference count of SoC object
>>    hw/arm/mcimx7d-sabre: Ignore memory transaction failures
>>    docs, tests/functional: Drop redundant CLI arguments in imx8m*-evk
>>      invocations
>>    hw/arm/sabrelite: Have 4 CPUs and 1 GiB of RAM by default
>>    tests/functional/arm: Add console test for `sabrelite` machine
>>    hw/arm/mcimx6ul-evk: Have 512 MiB of RAM by default
>>    hw/arm/mcimx7d-sabre: Have 2 CPUs and 2 GiB of RAM by default
>>    tests/functional/arm: Add console test for `mcimx7d-sabre` machine
>>    hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
>>    hw/arm/fsl-imx31: Derive from TYPE_SYS_BUS_DEVICE
>>    hw/arm/fsl-imx6: Derive from TYPE_SYS_BUS_DEVICE
>>    hw/arm/fsl-imx6ul: Derive from TYPE_SYS_BUS_DEVICE
>>    hw/arm/fsl-imx7: Derive from TYPE_SYS_BUS_DEVICE
>>    hw/timer/imx_gpt: Wire clock control module via link property
>>    hw/timer/imx_epit: Wire clock control module via link property
>>    hw/arm/Kconfig: Select missing UNIMP in config FSL_IMX8MM
>>    hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS from config IMX
>>    Kconfig: Extract config IMX_AVIC from config IMX
>>    Kconfig: Extract config IMX_GPCV2 from config IMX
>>    Kconfig: Extract config IMX_RNG from config IMX
>>    Kconfig: Extract config FSL_IMX7_GPR from config IMX
>>    Kconfig: Extract config FSL_IMX{6,7}_SRC from config IMX
>>    Kconfig: Extract config FSL_IMX7_SNVS from config IMX
>>    Kconfig: Extract dedicated config FSL_IMXx_CCM from config IMX
>>    Kconfig: Extract config IMX_GPT from config IMX
>>    Kconfig: Extract config IMX_EPIT from config IMX
>>    Kconfig: Extract config GPIO_IMX from config IMX
>>    Kconfig: Extract config IMX_SPI from config IMX
>>    Kconfig: Extract config IMX_SERIAL from config IMX
>>    Kconfig: Remove config IMX
>>    hw/vmapple/Kconfig: Remove unused GPIO_PWR dependency
>>    hw/arm/fsl-imx8m: Fix typo
>>    hw/misc/imx6_src: Avoid casting from void *
>>    hw/char/imx_serial: Avoid casting from void *
>>    hw/intc/imx_avic: Avoid casting from void *
>>    hw/misc/imx*_ccm: Avoid casting from void *
>>    hw/usb/imx-usb-phy: Avoid casting from void *
>>    hw/net/imx_fec: Trace with QOM path where easily possible
>>    hw/net/lan9118_phy: Trace with QOM path
>>    hw/watchdog/wdt_imx2: Trace with QOM path
>
>If no objection I'm queuing the following trivial reviewed fixes
>in my hw-misc tree to reduce the size of respin:

Thanks, Phil!

>
>hw/watchdog/wdt_imx2: Trace with QOM path
>hw/net/lan9118_phy: Trace with QOM path
>hw/net/imx_fec: Trace with QOM path where easily possible
>hw/usb/imx-usb-phy: Avoid casting from void *
>hw/misc/imx*_ccm: Avoid casting from void *
>hw/intc/imx_avic: Avoid casting from void *
>hw/char/imx_serial: Avoid casting from void *
>hw/misc/imx6_src: Avoid casting from void *
>hw/vmapple/Kconfig: Remove unused GPIO_PWR dependency

>hw/misc/Kconfig: Remove redundant USB_EHCI_SYSBUS from config IMX

I needed to preserve this patch in v2=2E Otherwise, CONFIG_IMX wasn't empt=
y and could not be removed=2E

Best regards,
Bernhard

>hw/arm/Kconfig: Select missing UNIMP in config FSL_IMX8MM
>hw/timer/imx_epit: Wire clock control module via link property
>hw/timer/imx_gpt: Wire clock control module via link property
>

