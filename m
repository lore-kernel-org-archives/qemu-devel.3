Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B6CCF3963
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 18:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srLvL-0003Of-IX; Thu, 19 Sep 2024 14:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1srLvG-0003NW-LJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 14:30:34 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1srLvF-0006Br-5h
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 14:30:34 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c26311c6f0so1588491a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726770630; x=1727375430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qLMr/wHlqkt7H+gvj7Z1lmYaQT/drtv/TdJd0tsjzs=;
 b=QAY02rWbPluGDo90B82l7Tih1ybo7BxFZs98VuJzFU5kFMLkWe8Mb/6QUe7V0AhNFm
 Z+9+QThOghuGO/VvanOncYNQj/TxLFuY5ENBW4wi/Z9uXL0y/V3DEJOa22lcwcC0Rg8+
 Z3MydzMXqHs0sxK0qIwbg2cJf/iMCqure7ZN8JpFjMXtkcVKUpe/VBaXa40/JGAY+e/f
 3Gxfuov1N2xvwfh5wnUAKHk5jcv/tIKwX91l6+F782iWvUc7vhbCXfhHneWlZjy9zW0Q
 +EkugxbPIqrJrFCpIB/vE93ZcYy26bPCDe1zd5LPEYJ8gpQzPGyNlbHU7+/bZort7naC
 epAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726770630; x=1727375430;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qLMr/wHlqkt7H+gvj7Z1lmYaQT/drtv/TdJd0tsjzs=;
 b=Ig68KA++bl4ij0HWGuMZ4/sdxVpen1NcxsMxC2fhTv3ckpeCb7sbCbaZ+3F0LQZsdc
 hFOCwBqHkKXY6tT38OdiwBPkDYfz0vwvSwqOn1dSympbQHpVNMBennpcpqPhtN5hsBtq
 yLsjtWhCTHyNvWfnTDnRhjnWKiv8bJe/L9+y/5KggVE5IFSqvkpks35AyT1qZF5bvFIn
 DnbTolQ5XS7ChDR5CWkNK4TYaGUqC4TYPa5LehKaDP9WMd5MfFvYIXDDa5dInA5SzuAb
 kwNTB6nqLV3k/LDTjNrJmRI0VYYsJzliUWcLRCXvrBjMFyfU6QMqAfYcv609nRtmHyZd
 Zaew==
X-Gm-Message-State: AOJu0YweEr4RE31N0iGcbjL/hYTICUXzthgKFQelbuLJ396LtQbVxtcQ
 N0He7gKpvh7yv43JlqjwRxidqLzlywCb+NuGb+d3LN5q72mMqhmfRDE9bg==
X-Google-Smtp-Source: AGHT+IExUHsuXDK/Grq+D5rPgeODIVM9sOR+/PB3pCr/FcE8b6At99Qf949YtYpaHsQ6LT6Ro4DTmg==
X-Received: by 2002:a17:907:f74d:b0:a8a:8c92:1c76 with SMTP id
 a640c23a62f3a-a90d5033f31mr12594966b.36.1726770629794; 
 Thu, 19 Sep 2024 11:30:29 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9061328b2esm751663366b.194.2024.09.19.11.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 11:30:29 -0700 (PDT)
Date: Thu, 19 Sep 2024 18:28:50 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com
CC: "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH] q35: Remove unused mch_mcfg_base
In-Reply-To: <20240918005132.187517-1-dave@treblig.org>
References: <20240918005132.187517-1-dave@treblig.org>
Message-ID: <A4D1CDE0-9424-44EB-8E50-46FB84BAA509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
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



Am 18=2E September 2024 00:51:32 UTC schrieb dave@treblig=2Eorg:
>From: "Dr=2E David Alan Gilbert" <dave@treblig=2Eorg>
>
>mch_mcfg_base has been unused since it was added by
>  6f1426ab0f ("ich9: APIs for pc guest info")
>back in 2013=2E

Indeed=2E

>
>Remove it=2E
>
>Signed-off-by: Dr=2E David Alan Gilbert <dave@treblig=2Eorg>

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

I'm curious: How do you detect such unused code?

>---
> hw/pci-host/q35=2Ec         | 10 ----------
> include/hw/pci-host/q35=2Eh |  2 --
> 2 files changed, 12 deletions(-)
>
>diff --git a/hw/pci-host/q35=2Ec b/hw/pci-host/q35=2Ec
>index d5a657a02a=2E=2Ef3e713318e 100644
>--- a/hw/pci-host/q35=2Ec
>+++ b/hw/pci-host/q35=2Ec
>@@ -662,16 +662,6 @@ static void mch_realize(PCIDevice *d, Error **errp)
>                                    OBJECT(&mch->smram));
> }
>=20
>-uint64_t mch_mcfg_base(void)
>-{
>-    bool ambiguous;
>-    Object *o =3D object_resolve_path_type("", TYPE_MCH_PCI_DEVICE, &amb=
iguous);
>-    if (!o) {
>-        return 0;
>-    }
>-    return MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT;
>-}
>-
> static Property mch_props[] =3D {
>     DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mby=
tes,
>                        16),
>diff --git a/include/hw/pci-host/q35=2Eh b/include/hw/pci-host/q35=2Eh
>index 22fadfa3ed=2E=2Eddafc3f2e3 100644
>--- a/include/hw/pci-host/q35=2Eh
>+++ b/include/hw/pci-host/q35=2Eh
>@@ -181,8 +181,6 @@ struct Q35PCIHost {
> #define MCH_PCIE_DEV                           1
> #define MCH_PCIE_FUNC                          0
>=20
>-uint64_t mch_mcfg_base(void);
>-
> /*
>  * Arbitrary but unique BNF number for IOAPIC device=2E
>  *

