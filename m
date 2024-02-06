Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B39C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXO5I-0006hQ-TW; Tue, 06 Feb 2024 11:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rXO5H-0006hA-2B; Tue, 06 Feb 2024 11:14:07 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rXO5F-00071d-Hq; Tue, 06 Feb 2024 11:14:06 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3392b12dd21so3275196f8f.0; 
 Tue, 06 Feb 2024 08:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707236043; x=1707840843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vu+SlaH8cSLBcazYkK4A4iOZDJum2ZYJ9nAcqFD2xg8=;
 b=XRSZIMmWvzY59WEzFZAqV8l/Pskj9/59PweLfpZkPAw577c824iMMb9MJquEqcq/AV
 dMDSjmVuBJ39cXO9mZy7Vbt00ej0XNm7psZCy3Sv/dxikDX4nUnOI/+bZYiiAy1r6I+v
 2vqSdRDMViTVq2C9fZvWo1vcO+5GsBG2TyfPingQoFVKe2lzcBpLgAZ6mzH3+Qsu/sWk
 FooiilpIz3E3V5h2f1I+uBIMFMsz0lRY548XqL0n+jfrg6s7RdJNQxCANsua8h/dTULB
 hNkhNdwYIb5A+9g1xANZSHJp3vvnntiVLWSw4tJw16GN/DY2zZU+eSR+JDB3Ym+LrXyP
 Y0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707236043; x=1707840843;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vu+SlaH8cSLBcazYkK4A4iOZDJum2ZYJ9nAcqFD2xg8=;
 b=rM8cGr1KypnjIybqjJTqWqdQlNsBrUonv9XJVgWxoeQUGjS7C3+0Z9W9GEMbtLffmc
 5FziMVtezlGLj0AmOj23sZ7wBVcyncxr5eBocpX/HzKXyLXG6CSJ1PuWkmPDyWIqomum
 5fay5xUitDsCWzKKoDVsZzs7QsdBbl3PGRq120CXNdZf5gdC94jkaRVL1SbW3q9m8kD9
 nNr79X9GHGe8f45HdB+xk9ogDvoZwxQfDDdkuC5bF9nHt3VgIKfSUBtwk9w5grpGLf9O
 J5clmE43apJkClt6pbeNcjE9SzTxiVh3MLsdwGQj6KqOCdq6x9DRUskxY26Mk/HuX65p
 JcFA==
X-Gm-Message-State: AOJu0Yxp1rrE1FQWHVT4bYc1iUBGPi9PCApARLFhjatzM1lokwAHIuze
 E4B8H+u5RqPgXSzAAovOgAGWDQdCyIXcwASExbmOcykJJmIPxmOP
X-Google-Smtp-Source: AGHT+IGcPxfxWzMXxCDjbhmPhkRQ+moh3QaXn3uyNY6r11cfU/Zi9P2giCCgZqex3IwmSvfQV+exGQ==
X-Received: by 2002:adf:fecf:0:b0:33b:3ad8:22c5 with SMTP id
 q15-20020adffecf000000b0033b3ad822c5mr1658557wrs.68.1707236042861; 
 Tue, 06 Feb 2024 08:14:02 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVF/MJ/g9rehWPguNlTHvh29wEGC2+oGAiHmpkmO111KO98Fb8fS3qDPQHt35YgYnYlN4LjRXjLq9MvP6F6Nkqh0DrWbHsdy5H4HyzyVZVE8Gv8HBIOo0Bq9ntQ2LuW1UdkkwjYx2BQGoBJmP9cjjlm0iSWRkyoyBM7z6s6CvqOYGRWPZ57GAvBRpDxl0USuLFHrmAzxaUXPEVWgpxgxMOThh7gZpYpHHOGq/MTG/RQaR3yUYP45XoicCphVDPqYczi4fqzl5sl34z2HV17YliJcUGVFqGWzRR711Z8P5awLcT+h7U=
Received: from ?IPv6:::1?
 (p200300faaf1724007ccdd0ba9e70da1e.dip0.t-ipconnect.de.
 [2003:fa:af17:2400:7ccd:d0ba:9e70:da1e])
 by smtp.gmail.com with ESMTPSA id
 u17-20020adff891000000b0033b3d726d41sm2425851wrp.104.2024.02.06.08.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 08:14:02 -0800 (PST)
Date: Tue, 06 Feb 2024 16:14:00 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/4=5D_hw/pci-host/bonito=3A_Access_?=
 =?US-ASCII?Q?memory_regions_via_pci=5Faddress=5Fspace=5B=5Fio=5D=28=29?=
In-Reply-To: <a93b8601-8f45-4781-8ba1-0d894c0e0139@linaro.org>
References: <20231011185954.10337-1-philmd@linaro.org>
 <20231011185954.10337-4-philmd@linaro.org>
 <5FD62714-3C33-4A93-B7E3-F3523FCE69C1@gmail.com>
 <bf5d344c-84a1-c6b9-3d17-0362a4c2c9e7@linaro.org>
 <a93b8601-8f45-4781-8ba1-0d894c0e0139@linaro.org>
Message-ID: <E8D65EFB-6806-4992-B904-E3080B6C494E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x432.google.com
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



Am 6=2E Februar 2024 15:45:13 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>Hi Bernhard,
>
>On 16/10/23 09:04, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 16/10/23 00:19, Bernhard Beschow wrote:
>>> Am 11=2E Oktober 2023 18:59:53 UTC schrieb "Philippe Mathieu-Daud=C3=
=A9" <philmd@linaro=2Eorg>:
>>>> PCI functions are plugged on a PCI bus=2E They can only access
>>>> external memory regions via the bus=2E
>>>>=20
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>>> ---
>>>> hw/pci-host/bonito=2Ec | 6 +++---
>>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>>=20
>>>> @@ -719,7 +719,7 @@ static void bonito_pci_realize(PCIDevice *dev, Er=
ror **errp)
>>>>=20
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 memory_region_init_alias(pcimem_alias, NULL,=
 "pci=2Emem=2Ealias",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
>>>> -=C2=A0=C2=A0=C2=A0 memory_region_add_subregion(get_system_memory(),
>>>> +=C2=A0=C2=A0=C2=A0 memory_region_add_subregion(pci_address_space(dev=
),
>>>=20
>>> I need to keep `get_system_memory()` here to get the same results for =
`info mtree` in the QEMU console before and after this patch when running `=
qemu-system-mips64el -M fuloong2e -S`=2E The other two changes above seem t=
o work as expected=2E

With that resolved:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>
>Can I use add R-b tag after dropping this change?

Yes, formally added above=2E

While at it, could you possibly double check if you really queued https://=
patchew=2Eorg/QEMU/20230105154440=2E259361-1-shentey@gmail=2Ecom/ into mips=
-next?

Thanks,
Bernhard

