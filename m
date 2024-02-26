Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8B7C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 22:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rejia-0000wq-5O; Mon, 26 Feb 2024 17:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rejiW-0000rt-V4; Mon, 26 Feb 2024 17:45:00 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rejiU-00074O-Q5; Mon, 26 Feb 2024 17:45:00 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d28468666so3280081f8f.0; 
 Mon, 26 Feb 2024 14:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708987496; x=1709592296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rH5sAsg1JoBx2gzOe/SGrOs6C3DSp+ohCi71CKlrpgo=;
 b=QD5X1Vt/ntH4xds+Pjij6PQ73jr5V3GV96jdQ0U7ADM2eAvgplLro2+KiVW2tp7d2f
 2/rVG2rk/mTj3U1K7X7dLkwvUT2MEU/Boe0VjY2eKmOzl5mabmbmM+KTGzGQP4uePZrD
 UuuDoRK3L3n8mwkzwzPawORYAsnypEr+NQrwFyqkbVBVtjpzXbC4dkH7CADJ60BnQCTI
 5mXcMqxPQoZ1AR5xFdy2m8ZlLuaaH9LtF1skcmx0e1mIvxtc60z/o3yCGekM9yMaIZrr
 UxxBsuy+QIRG8xNe4p4Hz/yGyf9xDqOikk+nnkc0AZL7Tn3/r4mOABC4Xu909DrMIKEd
 rypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708987496; x=1709592296;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rH5sAsg1JoBx2gzOe/SGrOs6C3DSp+ohCi71CKlrpgo=;
 b=cgeXOBhwyltuXLrWPqTVGpxFO+TYMC7Ak7pZryauDVSad82WzZany7uJ6XvU3S8D1z
 rVKaZntqgdcmet+7T+eNUIa6gCPMobvvFhsk6GuZ6SC+FlLgrdq/qEXVzGzMkZr1rsNx
 1ZJ2Sk4R1z/XN2QD0I0qXExvItlT1F2jKt3fLnkT9PpHCTuAECrTegkhU/axT2SIybfK
 K+IK3Wp0EvL5xBYTMh1FlJb7KyAg+Qwc7h/z5gbtzVXMyPv09e6hHeyc/y88WX/xX+D6
 73sQTX4T5nR7NG4ItXkY/6ajawe/XfxdStU+03k7PB/RyRCl7uCoW6OZnHgnuFihI6Zr
 090w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPyt/jqcN7PiLkWKcW26nw3o8wuXeGoxHPyIcwksCAJOgptiZK8Yjf4j3L6OrbXEhxaI/MzpPjsEi5ZnkFLK5jveXlZvt+lomaEOjUGZ2XooZ38s08etgA68/onA==
X-Gm-Message-State: AOJu0Yy/ohC/tJsK5HqznPM8UngNgebqJS3wLWaFywpU9hONoHvqGEzu
 QAlbTFMG28OzszQW+tTB1P5q7i6dSmuMWLQYmlK31WkVpJkTpOna
X-Google-Smtp-Source: AGHT+IFONHgKGCfPIpmP06GDRDVEQnxMi6WEkeqh83ss0nSYUhMT/jD8N4C1N/J0FpPHpJuOVDBVPw==
X-Received: by 2002:a05:6000:2aa:b0:33d:4978:6e37 with SMTP id
 l10-20020a05600002aa00b0033d49786e37mr7722312wry.71.1708987495721; 
 Mon, 26 Feb 2024 14:44:55 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-188-008-186.77.188.pool.telefonica.de.
 [77.188.8.186]) by smtp.gmail.com with ESMTPSA id
 ay14-20020a05600c1e0e00b00412a589d446sm4090230wmb.5.2024.02.26.14.44.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 14:44:55 -0800 (PST)
Date: Mon, 26 Feb 2024 22:44:54 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 00/15] hw/southbridge: Extract ICH9 QOM container model
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
Message-ID: <091FBE60-DC3C-4B59-A6E1-DD2C7174D3A2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x435.google.com
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



Am 26=2E Februar 2024 11:13:59 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>Since v1 [1]:
>- Rebased on top of Bernhard patches
>- Rename files with 'ich9_' prefix (Bernhard)
>
>Hi,
>
>I have a long standing southbridge QOM rework branches=2E Since
>Bernhard is actively working on the PIIX, I'll try to refresh
>and post=2E This is also motivated by the Dynamic Machine work
>where we are trying to figure the ideal DSL for QEMU, so having
>complex models well designed help=2E
>
>Here we introduce the ICH9 'southbridge' as a QOM container=2E
>Since the chipset comes as a whole, we shouldn't instantiate
>its components separately=2E However in order to maintain old
>code we expose some properties to configure the container and
>not introduce any change for the Q35 machine=2E There is no
>migration change, only QOM objects moved around=2E

I really like the simplicity of the machine code and that the ICH9 southbr=
idge becomes a proper device rather than being scattered around in machine =
code=2E I've made some reviews in form of a branch: https://github=2Ecom/sh=
entok/qemu/commits/philmd/ich9_qom-v2/

>
>More work remain in the LPC function (more code to remove from
>Q35)=2E Maybe worth doing in parallel with the PIIX to clean both
>PC machines=2E

Would be nice if the pattern could then also be applied to the VIA southbr=
idges, otherwise this could break my via-apollo-pro-133t branch: https://gi=
thub=2Ecom/shentok/qemu/tree/via-apollo-pro-133t

Best regards,
Bernhard

>
>Also we'd need to decouple the cpu_interrupt() calls between hw/
>and target/=2E
>
>Note that GSI is currently broken [2]=2E Once the LPC/ISA part is
>done, it might be easier to fix it=2E
>
>[1] https://lore=2Ekernel=2Eorg/qemu-devel/20240219163855=2E87326-1-philm=
d@linaro=2Eorg/
>[2] https://lore=2Ekernel=2Eorg/qemu-devel/cd0e13c6-c03d-411f-83a5-1d4d28=
ea4345@linaro=2Eorg/
>
>Philippe Mathieu-Daud=C3=A9 (15):
>  MAINTAINERS: Add 'ICH9 South Bridge' section
>  hw/i386/q35: Add local 'lpc_obj' variable
>  hw/acpi/ich9: Restrict definitions from 'hw/southbridge/ich9=2Eh'
>  hw/acpi/ich9_tco: Include 'ich9' in names
>  hw/acpi/ich9_tco: Restrict ich9_generate_smi() declaration
>  hw/ide: Rename ich=2Ec -> ich9_ahci=2Ec
>  hw/i2c/smbus: Extract QOM ICH9 definitions to 'ich9_smbus=2Eh'
>  hw/pci-bridge: Extract QOM ICH definitions to 'ich9_dmi=2Eh'
>  hw/southbridge/ich9: Introduce TYPE_ICH9_SOUTHBRIDGE stub
>  hw/southbridge/ich9: Add the DMI-to-PCI bridge
>  hw/southbridge/ich9: Add a AHCI function
>  hw/southbridge/ich9: Add the SMBus function
>  hw/southbridge/ich9: Add the USB EHCI/UHCI functions
>  hw/southbridge/ich9: Extract LPC definitions to 'hw/isa/ich9_lpc=2Eh'
>  hw/southbridge/ich9: Add the LPC / ISA bridge function
>
> MAINTAINERS                               |  21 +-
> include/hw/acpi/ich9=2Eh                    |  15 ++
> include/hw/acpi/ich9_tco=2Eh                |   6 +-
> include/hw/i2c/ich9_smbus=2Eh               |  25 +++
> include/hw/isa/ich9_lpc=2Eh                 | 166 +++++++++++++++
> include/hw/pci-bridge/ich9_dmi=2Eh          |  20 ++
> include/hw/southbridge/ich9=2Eh             | 235 +---------------------
> hw/acpi/ich9=2Ec                            |   9 +-
> hw/acpi/ich9_tco=2Ec                        |   5 +-
> hw/i2c/{smbus_ich9=2Ec =3D> ich9_smbus=2Ec}     |  36 +++-
> hw/i386/acpi-build=2Ec                      |   1 +
> hw/i386/pc_q35=2Ec                          | 126 +++---------
> hw/ide/{ich=2Ec =3D> ich9_ahci=2Ec}             |   0
> hw/isa/{lpc_ich9=2Ec =3D> ich9_lpc=2Ec}         |  37 +++-
> hw/pci-bridge/{i82801b11=2Ec =3D> ich9_dmi=2Ec} |  11 +-
> hw/southbridge/ich9=2Ec                     | 213 ++++++++++++++++++++
> tests/qtest/tco-test=2Ec                    |   2 +-
> hw/Kconfig                                |   1 +
> hw/i2c/meson=2Ebuild                        |   2 +-
> hw/i386/Kconfig                           |   3 +-
> hw/ide/meson=2Ebuild                        |   2 +-
> hw/isa/meson=2Ebuild                        |   2 +-
> hw/meson=2Ebuild                            |   1 +
> hw/pci-bridge/meson=2Ebuild                 |   2 +-
> hw/southbridge/Kconfig                    |  11 +
> hw/southbridge/meson=2Ebuild                |   3 +
> 26 files changed, 587 insertions(+), 368 deletions(-)
> create mode 100644 include/hw/i2c/ich9_smbus=2Eh
> create mode 100644 include/hw/isa/ich9_lpc=2Eh
> create mode 100644 include/hw/pci-bridge/ich9_dmi=2Eh
> rename hw/i2c/{smbus_ich9=2Ec =3D> ich9_smbus=2Ec} (77%)
> rename hw/ide/{ich=2Ec =3D> ich9_ahci=2Ec} (100%)
> rename hw/isa/{lpc_ich9=2Ec =3D> ich9_lpc=2Ec} (95%)
> rename hw/pci-bridge/{i82801b11=2Ec =3D> ich9_dmi=2Ec} (95%)
> create mode 100644 hw/southbridge/ich9=2Ec
> create mode 100644 hw/southbridge/Kconfig
> create mode 100644 hw/southbridge/meson=2Ebuild
>

