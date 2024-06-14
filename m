Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14112C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 01:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHw7G-0005de-Pe; Thu, 13 Jun 2024 21:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1sHw7E-0005dK-Uj; Thu, 13 Jun 2024 21:52:32 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1sHw7D-0001Ij-Fh; Thu, 13 Jun 2024 21:52:32 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3d2472450d6so770148b6e.3; 
 Thu, 13 Jun 2024 18:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718329949; x=1718934749; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SK1Url/JmvTvyc+MqjZ2Lc5bMtlOc8isPmLyQEMupyU=;
 b=Tvf7Vfx0dzzv4fZAINFCnpa/mkMQWzOzjpvz2WQVNTWnIm/pigXzntOLl/G92CF7iV
 ZQeAGLtjiBIObM2Y0jlc8E7h72d4ot+JrndT5SbQSfpAZr2dDGJkVmBTkZApFkE1wxZb
 hkNaJgs0+8y+x5EagXJWO1GD5vZRxijRck7aUgdbdJdvLweeZ26UAj8IHdrvZgscwu9J
 UN1BGy5znphGeAy88lWt9tqDiZ/7nbAjo9Bk5O8ClvDzlF4wLGNiFvyZmNsFfmqRCh2U
 lzmLERmJ3QCP/ml7fgpLQCcgO6x3k/dQEkx3KPc6j1DHECFTY5DXyS9P2rbw8IIsHwlp
 UyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718329949; x=1718934749;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SK1Url/JmvTvyc+MqjZ2Lc5bMtlOc8isPmLyQEMupyU=;
 b=LDXK0F7XcPTHYIhpuATrPwyIagQz5i3Ap77SjgRQezOzRkb8XUYZJR00Ut/gm9qvPn
 7BitgnSUrTzZz2eL+pSgBkSXlYpBYL67zasa7T6kuIFhCOeYn+sAq9scBM7mIr8G1fkE
 bEMn+9AAzFUJRO6agOZ3khOIYyR9wbA3uO+u2HbCpRLaMJGOYg35GYApMsdPPkY3av3j
 tP6kAuE3L08wrV9hsjd8Q65pNiU1/5M07phsMj3efbzqvvHusP8TAWOYC/i6OweLqUwX
 Ixs940qxm9hKaig9AkjJzxwIdXFAC5kLF9MAhWr+x1I76ls8gGqgMiDTC6lp5BJ8q3PN
 FBnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4OYQ5A5EtvkZOIBbnh/L7wWIbl0MxX97s6WCFXIzQiAOlbLRi9Jl0hQWD7nVjxZDbYF0xZZkRY23cFuIQnxcMSDawtxCraFKl7Tvhb+who0tuIpcbKBXYKg+zNg==
X-Gm-Message-State: AOJu0YxwJUTRbulJEd5pdmf54YAamTIejZdM6ET070tehnt0Zp5xnZ9/
 8BomOMVePRl/6Z8+B5/5tPCPaTsZOp9uBV2GIf8cxaKKqUgCc+Ll
X-Google-Smtp-Source: AGHT+IFsWoWxodW6xMb/pDoCqbEYQBIJ9NB9uXpn77j808YCq7tA4BiZPtkFrV6upbj84itKitQY+A==
X-Received: by 2002:a05:6808:219d:b0:3d2:28f8:c7ce with SMTP id
 5614622812f47-3d24e8f6cd3mr1625942b6e.29.1718329949336; 
 Thu, 13 Jun 2024 18:52:29 -0700 (PDT)
Received: from [192.168.0.247] ([159.196.15.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb6b1b2sm2000162b3a.156.2024.06.13.18.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 18:52:28 -0700 (PDT)
Message-ID: <59de3b17dbeb8199b956d39deceece86dded7c58.camel@gmail.com>
Subject: Re: [PATCH v7 1/3] hw/pci: Add all Data Object Types defined in
 PCIe r6.0
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair23@gmail.com>, wilfred.mallawa@wdc.com, 
 marcel.apfelbaum@gmail.com, lukas@wunner.de, qemu-devel@nongnu.org,
 mst@redhat.com,  Jonathan.Cameron@Huawei.com, kbusch@kernel.org,
 hchkuo@avery-design.com.tw,  cbrowy@avery-design.com, its@irrelevant.dk,
 jiewen.yao@intel.com
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Jesper Devantier <foss@defmacro.it>
Date: Fri, 14 Jun 2024 11:52:20 +1000
In-Reply-To: <20240614012846.1016856-2-alistair.francis@wdc.com>
References: <20240614012846.1016856-1-alistair.francis@wdc.com>
 <20240614012846.1016856-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-oi1-x231.google.com
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

Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

On Fri, 2024-06-14 at 11:28 +1000, Alistair Francis wrote:
> Add all of the defined protocols/features from the PCIe-SIG r6.0
> "Table 6-32 PCI-SIG defined Data Object Types (Vendor ID =3D 0001h)"
> table.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> =C2=A0include/hw/pci/pcie_doe.h | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
> index 87dc17dcef..15d94661f9 100644
> --- a/include/hw/pci/pcie_doe.h
> +++ b/include/hw/pci/pcie_doe.h
> @@ -46,6 +46,8 @@ REG32(PCI_DOE_CAP_STATUS, 0)
> =C2=A0
> =C2=A0/* PCI-SIG defined Data Object Types - r6.0 Table 6-32 */
> =C2=A0#define PCI_SIG_DOE_DISCOVERY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x00
> +#define PCI_SIG_DOE_CMA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x01
> +#define PCI_SIG_DOE_SECURED_CMA=C2=A0=C2=A0=C2=A0=C2=A0 0x02
> =C2=A0
> =C2=A0#define PCI_DOE_DW_SIZE_MAX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (1 << 18)
> =C2=A0#define PCI_DOE_PROTOCOL_NUM_MAX=C2=A0=C2=A0=C2=A0 256


