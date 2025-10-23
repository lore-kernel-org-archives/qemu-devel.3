Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1329DCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBsbs-0005lz-AP; Thu, 23 Oct 2025 06:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBsbo-0005ld-Bd
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:31:52 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBsbi-0006S6-MX
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:31:51 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b5c18993b73so119389966b.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 03:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761215504; x=1761820304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Be6isMzjiBXvPjyPeYbZHaKO6zJaGypFLOfDgccmqXg=;
 b=l1bYbhAXDiY4Pd3VdflAcT2V6clgTMwHYmKHyuGIDLU0grdQWugx3gyyCVCpdnUjP0
 XS/xy0mg99aUmF9rKKWUSjEBPaC3wRkJAYWdki79bwM512JDmOXjB4B+10ngOgByEgQG
 Ykv8QEjHzNVayJcvy7uD30k575JQQBC09MyLHprGf/nlWAnUqDjORHqedlqEDEd8TvOu
 EAfDdQ+GCRWgJYffmoE+IbYy6MOKWllogdThGq+zypaHHELe0vjo9Bbc96yEwkkkOZRW
 SLepHqI4Q8OGOrfltVjtpQmfpzc/dK97oAjd80oJYOenNgiI+obLzujepbtAhT8O5fzR
 eGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761215504; x=1761820304;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Be6isMzjiBXvPjyPeYbZHaKO6zJaGypFLOfDgccmqXg=;
 b=ulBIgOSre6d7HdS28BhKj8teaheAFuDySnTW4PTfUT3h+O3R2ccXXOuU9ATZiWqjUd
 DC3e+UTx2PoqMy207VJffR60vxCV5S+5DVBc4TcijqkdjGNf0TKHTBh9Z8IWdfItuSd5
 jh8QM3VQTNJP4c+dvMd3Que7ZJ/ywfrahggj4IRnkHkC6sRmAd+WukHG3rPa9qn0B639
 DLWzx1fBUwR4vqdv2X+OkjT+X1Mw8xX9o4TFlULiULWOOgLHy78wGu1/QHTp6NOpbUmn
 25WJa+TkD0mmjQsSVvmXc+5ntXDeX/tFYiNMnm6rZPPhZmQvy1Jx6jz/H4q18duxkzUF
 M0dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZhQVE4BWuU7YtXESjEN6YA5SfZSQHnWclYYCozJn+GAad568zWJUjP+D5VlPzpjTPpVtO+RUfFcGQ@nongnu.org
X-Gm-Message-State: AOJu0YzJz38Z6PjqF6bIgTqqIMdS6XmoxepUh2USmXhxyXYJMDmZI2NK
 ROeqFk3jlAScj/YfP2cGEqP5hoAeI6mRd/UyqCeeBLvRzl/34rfEjsd7lzJ720UY8Tw=
X-Gm-Gg: ASbGncvUymlIOm4RNvjviuJdinZ6qhWgrTZ8TJcYB8c5nBgwWmRqgS0wINXJsC3VhJi
 zJdyTmZ2qo0B9EFxMcSyALQy3GBXTbB5igEscWNU3DeJnDBHiKQjMKHDOZMXq6PvWMA9T4l//iJ
 IhagZvJtWcJLiSF9loepeqPkgIs1etBWO1s12iU3uf02PPFMe4aaZ1uG6JkDlfa+2INmh6q0mPI
 5fKRmLBI59tf5OGjnNORuDrbELtERTU8LUk88nl5/MJxrzsCJHoKuKCEYdsJ44QfANt5AqJpQ0F
 5SCqZlcXrHcj6JvaPqhWbrUpsR6+YQCM1OjbLnARcX/qX1IFYGV2MqLawtoypskdTM0qUXXpeuC
 4flUVmQnujPfYNb4qfGfkLrVftmG/QH2I6ESLPXWuVIkV3uqVt0ogHnYVqjgZ6Ps7evXWCBs7ex
 sSDpbUZY5/kNYSx0l+3t3JNg==
X-Google-Smtp-Source: AGHT+IHiBPhsRlWGgkLw25LykeHEEzCmiJHa6uXtk5UtJr/LUaCbojfJP/wZ0YISvNn5yNovlr9T7A==
X-Received: by 2002:a17:907:7f22:b0:b2d:f6c3:f9b1 with SMTP id
 a640c23a62f3a-b647323f0damr2927976966b.20.1761215503997; 
 Thu, 23 Oct 2025 03:31:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d5144ece8sm175224666b.68.2025.10.23.03.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 03:31:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 407935F8DF;
 Thu, 23 Oct 2025 11:31:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: tangtao1634 <tangtao1634@phytium.com.cn>
Cc: pbonzini@redhat.com,  farosas@suse.de,  lvivier@redhat.com,  Eric Auger
 <eric.auger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Chen Baozi
 <chenbaozi@phytium.com.cn>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC v2 1/2] hw/misc/smmu-testdev: introduce minimal SMMUv3
 test device
In-Reply-To: <20250930165340.42788-2-tangtao1634@phytium.com.cn> (tangtao's
 message of "Wed, 1 Oct 2025 00:53:39 +0800")
References: <20250930165340.42788-1-tangtao1634@phytium.com.cn>
 <20250930165340.42788-2-tangtao1634@phytium.com.cn>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Thu, 23 Oct 2025 11:31:42 +0100
Message-ID: <87pladnc35.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

tangtao1634 <tangtao1634@phytium.com.cn> writes:

> From: Tao Tang <tangtao1634@phytium.com.cn>
>
> Add a tiny, test-only DMA source dedicated to exercising the SMMUv3 model.
> The device purposefully avoids a realistic PCIe/platform implementation a=
nd
> instead routes DMA requests straight into the SMMU, so that qtests can
> populate STE/CD/PTE with known values and observe translation and data
> movement deterministically, without booting any firmware or guest kernel.
>
> Motivation
> ----------
> Bringing up and regression-testing the SMMU in emulation often depends on=
 a
> large and flaky software stack (enumeration, drivers, PCIe fabric). For t=
he
> class of tests that only need to (1) program translation structures and (=
2)
> trigger DMA at a precise time, that stack adds noise, slows CI, and makes
> failures harder to attribute to the SMMU itself. A hermetic DMA source
> keeps the surface area small and the results reproducible.
>
> What this device is (and is not)
> --------------------------------
> * It is a minimal DMA producer solely for SMMU tests.
> * It is NOT a faithful PCIe Endpoint nor a platform device.
> * It is NOT added to any machine by default and remains test-only.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/misc/Kconfig                |   5 +
>  hw/misc/meson.build            |   1 +
>  hw/misc/smmu-testdev.c         | 943 +++++++++++++++++++++++++++++++++
>  include/hw/misc/smmu-testdev.h | 402 ++++++++++++++
>  4 files changed, 1351 insertions(+)
>  create mode 100644 hw/misc/smmu-testdev.c
>  create mode 100644 include/hw/misc/smmu-testdev.h
>
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 4e35657468..c83a0872ef 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -25,6 +25,11 @@ config PCI_TESTDEV
>      default y if TEST_DEVICES
>      depends on PCI
>=20=20
> +config SMMU_TESTDEV
> +    bool
> +    default y if TEST_DEVICES
> +    depends on PCI && ARM_SMMUV3
> +
>  config EDU
>      bool
>      default y if TEST_DEVICES
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index b1d8d8e5d2..862a9895c3 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -4,6 +4,7 @@ system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('=
vmcoreinfo.c'))
>  system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
>  system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
>  system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'=
))
> +system_ss.add(when: 'CONFIG_SMMU_TESTDEV', if_true: files('smmu-testdev.=
c'))
>  system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
>  system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
>  system_ss.add(when: 'CONFIG_LED', if_true: files('led.c'))
> diff --git a/hw/misc/smmu-testdev.c b/hw/misc/smmu-testdev.c
> new file mode 100644
> index 0000000000..156f4cd714
> --- /dev/null
> +++ b/hw/misc/smmu-testdev.c
> @@ -0,0 +1,943 @@
> +/*
> + * A test device for the SMMU
> + *
> + * This test device is a minimal SMMU-aware device used to test the SMMU.
> + *
> + * Copyright (c) 2025 Phytium Technology
> + *
> + * Author:
> + *  Tao Tang <tangtao1634@phytium.com.cn>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/units.h"
> +#include "system/address-spaces.h"
> +#include "exec/memattrs.h"
> +#include "system/dma.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pci_device.h"
> +#include "hw/arm/smmu-common.h"
> +#include "hw/qdev-properties.h"
> +#include "qom/object.h"
> +#include "hw/misc/smmu-testdev.h"
> +
> +#define TYPE_SMMU_TESTDEV "smmu-testdev"
> +OBJECT_DECLARE_SIMPLE_TYPE(SMMUTestDevState, SMMU_TESTDEV)
> +
> +struct SMMUTestDevState {
> +    PCIDevice parent_obj;
> +    MemoryRegion bar0;
> +    uint32_t attr_ns;     /* Track Non-Secure for now; reserve room for =
more. */
> +
> +    uint64_t smmu_base;
> +    uint64_t dma_iova;
> +    uint32_t dma_len;
> +    uint32_t dma_dir;
> +    uint32_t dma_result;
> +    bool dma_pending;
> +
> +    /* Future-proof DMA config */
> +    AddressSpace *dma_as;   /* IOMMU-mediated DMA AS for this device */
> +    uint32_t dma_mode;      /* 0=3Dlegacy pci_dma, 1=3Dattrs via dma_mem=
ory_* */
> +    uint32_t dma_attrs_cfg; /* bit0 secure, bits[2:1] space, bit3 unspec=
ified */
> +
> +    /* Translation build configuration */
> +    uint32_t trans_mode;    /* 0=3DS1, 1=3DS2, 2=3DNested */
> +    SMMUTestDevSpace s1_space;
> +    SMMUTestDevSpace s2_space;
> +    uint32_t trans_status;  /* 0=3Dok; non-zero=3Derror */
> +
> +    /* User-configurable BDF (device/function) */
> +    uint32_t cfg_dev;       /* PCI device/slot number (0..31) */
> +    uint32_t cfg_fn;        /* PCI function number (0..7) */
> +
> +    bool debug_log;         /* Enable verbose debug output */
> +};
> +
> +/* BAR0 layout */
> +enum {
> +    REG_ID            =3D 0x00,
> +    REG_ATTR_NS       =3D 0x04,
> +    REG_SMMU_BASE_LO  =3D 0x20,
> +    REG_SMMU_BASE_HI  =3D 0x24,
> +    REG_DMA_IOVA_LO   =3D 0x28,
> +    REG_DMA_IOVA_HI   =3D 0x2C,
> +    REG_DMA_LEN       =3D 0x30,
> +    REG_DMA_DIR       =3D 0x34,
> +    REG_DMA_RESULT    =3D 0x38,
> +    REG_DMA_DOORBELL  =3D 0x3C,
> +    /* Extended controls for DMA attributes/mode (kept after legacy regs=
) */
> +    REG_DMA_MODE      =3D 0x40, /* 0: legacy; 1: attrs path */
> +    REG_DMA_ATTRS     =3D 0x44, /* [0] secure, [2:1] space, [3] unspecif=
ied */
> +    /* Translation config & builder */
> +    REG_TRANS_MODE    =3D 0x48, /* 0=3DS1 only, 1=3DS2 only, 2=3DNested =
*/
> +    REG_S1_SPACE      =3D 0x4C, /* SMMUTestDevSpace for stage-1 path */
> +    REG_S2_SPACE      =3D 0x50, /* SMMUTestDevSpace for stage-2 path */
> +    REG_TRANS_DBELL   =3D 0x54, /* bit0=3Dbuild, bit1=3Dclear status */
> +    REG_TRANS_STATUS  =3D 0x58, /* 0=3Dok else error */
> +    REG_TRANS_CLEAR   =3D 0x5C, /* write-any: clear helper-built CD/STE/=
PTE */
> +    BAR0_SIZE         =3D 0x1000,
> +};
> +
> +#define DMA_DIR_DEV2HOST     0u
> +#define DMA_DIR_HOST2DEV     1u
> +#define DMA_RESULT_IDLE      0xffffffffu
> +#define DMA_RESULT_BUSY      0xfffffffeu
> +#define DMA_ERR_BAD_LEN      0xdead0001u
> +#define DMA_ERR_TX_FAIL      0xdead0002u
> +#define DMA_MAX_LEN          (64 * KiB)
> +
> +/*
> + * Compile-time calculated STE field setting macros.
> + */
> +
> + #define STD_STE_OR_CD_ENTRY_BYTES 64 /* 64 bytes per STE entry */
> + #define STD_STE_S2T0SZ_VAL 0x14
> +
> +#define STD_STE_SET_VALID(ste, val)  \
> +    ((ste)->word[0] =3D ((ste)->word[0] & ~(0x1 << 0)) | (((val) & 0x1) =
<< 0))
> +#define STD_STE_SET_CONFIG(ste, val) \
> +    ((ste)->word[0] =3D ((ste)->word[0] & ~(0x7 << 1)) | (((val) & 0x7) =
<< 1))
> +#define STD_STE_SET_S1FMT(ste, val)  \
> +    ((ste)->word[0] =3D ((ste)->word[0] & ~(0x3 << 4)) | (((val) & 0x3) =
<< 4))
> +
> +#define STD_STE_SET_CTXPTR(ste, val)                                    =
  \
> +do {                                                                    =
  \
> +    /* Lower address bits (31:6) occupy the upper 26 bits of word[0]. */=
  \
> +    (ste)->word[0] =3D ((ste)->word[0] & 0x0000003FU) |                 =
    \
> +                     ((uint32_t)(val) & 0xFFFFFFC0U);                   =
  \
> +                                                                        =
  \
> +    /* Upper address bits (47:32) occupy the low 16 bits of word[1]. */ =
  \
> +    (ste)->word[1] =3D ((ste)->word[1] & 0xFFFF0000U) |                 =
    \
> +                     ((uint32_t)(((uint64_t)(val)) >> 32) & 0x0000FFFFU)=
; \
> +} while (0)
> +
> +#define STD_STE_SET_S1CDMAX(ste, val)  \
> +    ((ste)->word[1] =3D ((ste)->word[1] & ~(0x1f << 27)) | (((val) & 0x1=
f) << 27))
> +#define STD_STE_SET_S1STALLD(ste, val) \
> +    ((ste)->word[2] =3D ((ste)->word[2] & ~(0x1 << 27)) | (((val) & 0x1)=
 << 27))
> +#define STD_STE_SET_EATS(ste, val)     \
> +    ((ste)->word[2] =3D ((ste)->word[2] & ~(0x3 << 28)) | (((val) & 0x3)=
 << 28))
> +#define STD_STE_SET_STRW(ste, val)     \
> +    ((ste)->word[2] =3D ((ste)->word[2] & ~(0x3 << 30)) | (((val) & 0x3)=
 << 30))
> +#define STD_STE_SET_NSCFG(ste, val)    \
> +    ((ste)->word[2] =3D ((ste)->word[2] & ~(0x3 << 14)) | (((val) & 0x3)=
 << 14))
> +#define STD_STE_SET_S2VMID(ste, val)   \
> +    ((ste)->word[4] =3D ((ste)->word[4] & ~0xffff) | ((val) & 0xffff))
> +#define STD_STE_SET_S2T0SZ(ste, val)   \
> +    ((ste)->word[5] =3D ((ste)->word[5] & ~0x3f) | ((val) & 0x3f))
> +#define STD_STE_SET_S2SL0(ste, val)    \
> +    ((ste)->word[5] =3D ((ste)->word[5] & ~(0x3 << 6)) | (((val) & 0x3) =
<< 6))
> +#define STD_STE_SET_S2TG(ste, val)     \
> +    ((ste)->word[5] =3D ((ste)->word[5] & ~(0x3 << 14)) | (((val) & 0x3)=
 << 14))
> +#define STD_STE_SET_S2PS(ste, val)     \
> +    ((ste)->word[5] =3D ((ste)->word[5] & ~(0x7 << 16)) | (((val) & 0x7)=
 << 16))
> +#define STD_STE_SET_S2AA64(ste, val)   \
> +    ((ste)->word[5] =3D ((ste)->word[5] & ~(0x1 << 19)) | (((val) & 0x1)=
 << 19))
> +#define STD_STE_SET_S2ENDI(ste, val)   \
> +    ((ste)->word[5] =3D ((ste)->word[5] & ~(0x1 << 20)) | (((val) & 0x1)=
 << 20))
> +#define STD_STE_SET_S2AFFD(ste, val)   \
> +    ((ste)->word[5] =3D ((ste)->word[5] & ~(0x1 << 21)) | (((val) & 0x1)=
 << 21))
> +#define STD_STE_SET_S2HD(ste, val)     \
> +    ((ste)->word[5] =3D ((ste)->word[5] & ~(0x1 << 23)) | (((val) & 0x1)=
 << 23))
> +#define STD_STE_SET_S2HA(ste, val)     \
> +    ((ste)->word[5] =3D ((ste)->word[5] & ~(0x1 << 24)) | (((val) & 0x1)=
 << 24))
> +#define STD_STE_SET_S2S(ste, val)      \
> +    ((ste)->word[5] =3D ((ste)->word[5] & ~(0x1 << 25)) | (((val) & 0x1)=
 << 25))
> +#define STD_STE_SET_S2R(ste, val)      \
> +    ((ste)->word[5] =3D ((ste)->word[5] & ~(0x1 << 26)) | (((val) & 0x1)=
 << 26))
> +
> +#define STD_STE_SET_S2TTB(ste, val)                                     =
   \
> +do {                                                                    =
   \
> +    /* Lower address bits (31:4) occupy the upper 28 bits of word[6]. */=
   \
> +    (ste)->word[6] =3D ((ste)->word[6] & 0x0000000FU) |                 =
     \
> +                     ((uint32_t)(val) & 0xFFFFFFF0U);                   =
   \
> +                                                                        =
   \
> +    /* Upper address bits (51:32) occupy the low 20 bits of word[7]. */ =
   \
> +    (ste)->word[7] =3D ((ste)->word[7] & 0xFFF00000U) |                 =
     \
> +                     ((uint32_t)(((uint64_t)(val)) >> 32) &             =
   \
> +                      0x000FFFFFU);                                     =
   \
> +} while (0)
> +
> +#define STE_S2TTB(x)                                                    =
   \
> +    ((extract64((x)->word[7], 0, 16) << 32) |                           =
   \
> +     ((x)->word[6] & 0xfffffff0))
> +
> +/*
> + * Compile-time calculated CD field setting macros.
> + */
> +#define STD_CD_SET_VALID(cd, val)                                       =
   \
> +    ((cd)->word[0] =3D ((cd)->word[0] & ~(0x1 << 31)) |                 =
     \
> +                     (((val) & 0x1) << 31))
> +#define STD_CD_SET_TSZ(cd, sel, val)                                    =
   \
> +    ((cd)->word[0] =3D ((cd)->word[0] &                                 =
     \
> +                      ~(0x3F << ((sel) * 16 + 0))) |                    =
   \
> +                     (((val) & 0x3F) << ((sel) * 16 + 0)))
> +#define STD_CD_SET_TG(cd, sel, val)                                     =
   \
> +    ((cd)->word[0] =3D ((cd)->word[0] &                                 =
     \
> +                      ~(0x3 << ((sel) * 16 + 6))) |                     =
   \
> +                     (((val) & 0x3) << ((sel) * 16 + 6)))
> +#define STD_CD_SET_EPD(cd, sel, val)                                    =
   \
> +    ((cd)->word[0] =3D ((cd)->word[0] &                                 =
     \
> +                      ~(0x1 << ((sel) * 16 + 14))) |                    =
   \
> +                     (((val) & 0x1) << ((sel) * 16 + 14)))
> +#define STD_CD_SET_ENDI(cd, val)                                        =
   \
> +    ((cd)->word[0] =3D ((cd)->word[0] & ~(0x1 << 15)) |                 =
     \
> +                     (((val) & 0x1) << 15))
> +#define STD_CD_SET_IPS(cd, val)                                         =
   \
> +    ((cd)->word[1] =3D ((cd)->word[1] & ~(0x7 << 0)) |                  =
     \
> +                     (((val) & 0x7) << 0))
> +#define STD_CD_SET_AFFD(cd, val)                                        =
   \
> +    ((cd)->word[1] =3D ((cd)->word[1] & ~(0x1 << 3)) |                  =
     \
> +                     (((val) & 0x1) << 3))
> +#define STD_CD_SET_HD(cd, val)                                          =
   \
> +    ((cd)->word[1] =3D ((cd)->word[1] & ~(0x1 << 10)) |                 =
     \
> +                     (((val) & 0x1) << 10))
> +#define STD_CD_SET_HA(cd, val)                                          =
   \
> +    ((cd)->word[1] =3D ((cd)->word[1] & ~(0x1 << 11)) |                 =
     \
> +                     (((val) & 0x1) << 11))
> +#define STD_CD_SET_TTB(cd, sel, val) do {                               =
   \
> +    (cd)->word[(sel) * 2 + 2] =3D ((cd)->word[(sel) * 2 + 2] & 0x0000000=
F) | \
> +                                ((val) & 0xFFFFFFF0);                   =
   \
> +    (cd)->word[(sel) * 2 + 3] =3D ((cd)->word[(sel) * 2 + 3] & 0xFFF8000=
0) | \
> +                                ((((uint64_t)(val)) >> 32) & 0x0007FFFF)=
;  \
> +} while (0)
> +#define STD_CD_SET_HAD(cd, sel, val)                                    =
   \
> +    ((cd)->word[(sel) * 2 + 2] =3D ((cd)->word[(sel) * 2 + 2] &         =
     \
> +                                  ~(0x1 << 1)) |                        =
   \
> +                                 (((val) & 0x1) << 1))
> +#define STD_CD_SET_MAIR0(cd, val) ((cd)->word[6] =3D (val))
> +#define STD_CD_SET_MAIR1(cd, val) ((cd)->word[7] =3D (val))
> +#define STD_CD_SET_TCR_T0SZ(cd, val)                                    =
   \
> +    ((cd)->word[4] =3D ((cd)->word[4] & ~0x3F) | ((val) & 0x3F))
> +#define STD_CD_SET_ASID(cd, val)                                        =
   \
> +    ((cd)->word[1] =3D ((cd)->word[1] & ~(0xFFFF << 16)) |              =
     \
> +                     (((val) & 0xFFFF) << 16))
> +#define STD_CD_SET_S(cd, val)                                           =
   \
> +    ((cd)->word[1] =3D ((cd)->word[1] & ~(0x1 << 12)) |                 =
     \
> +                     (((val) & 0x1) << 12))
> +#define STD_CD_SET_R(cd, val)                                           =
   \
> +    ((cd)->word[1] =3D ((cd)->word[1] & ~(0x1 << 13)) |                 =
     \
> +                     (((val) & 0x1) << 13))
> +#define STD_CD_SET_A(cd, val)                                           =
   \
> +    ((cd)->word[1] =3D ((cd)->word[1] & ~(0x1 << 14)) |                 =
     \
> +                     (((val) & 0x1) << 14))
> +#define STD_CD_SET_AARCH64(cd, val)                                     =
   \
> +    ((cd)->word[1] =3D ((cd)->word[1] & ~(0x1 << 9)) |                  =
     \
> +                     (((val) & 0x1) << 9))
> +#define STD_CD_SET_TBI(cd, val)                                         =
   \
> +    ((cd)->word[1] =3D ((cd)->word[1] & ~(0x3 << 6)) |                  =
     \
> +                     (((val) & 0x3) << 6))
> +#define STD_CD_SET_NSCFG0(cd, val)                                      =
   \
> +    ((cd)->word[2] =3D ((cd)->word[2] & ~(0x1 << 0)) | (((val) & 0x1) <<=
 0))
> +#define STD_CD_SET_NSCFG1(cd, val)                                      =
   \
> +    ((cd)->word[4] =3D ((cd)->word[4] & ~(0x1 << 0)) | (((val) & 0x1) <<=
 0))
> +
> +typedef enum TransMode {
> +    TM_S1_ONLY =3D 0,
> +    TM_S2_ONLY =3D 1,
> +    TM_NESTED  =3D 2,
> +} TransMode;
> +
> +/* Minimal STE/CD images (bit layout derived from test helpers) */
> +typedef struct {
> +    uint32_t word[8];
> +} STEImg;
> +
> +typedef struct {
> +    uint32_t word[8];
> +} CDImg;
> +
> +/* ---- Debug helpers for printing current translation configuration ---=
- */
> +static void G_GNUC_PRINTF(2, 3)
> +smmu_testdev_debug(const SMMUTestDevState *s, const char *fmt, ...)
> +{
> +    va_list ap;
> +    g_autofree char *msg =3D NULL;
> +
> +    if (!s->debug_log) {
> +        return;
> +    }
> +
> +    va_start(ap, fmt);
> +    msg =3D g_strdup_vprintf(fmt, ap);
> +    va_end(ap);
> +
> +    if (qemu_log_enabled()) {
> +        qemu_log("%s", msg);
> +    } else {
> +        fprintf(stderr, "%s", msg);
> +    }
> +}

Why are we re-inventing logging here? Either use qemu_log or probably
better define tracepoints.=20

> +
> +/* Only support Non-Secure space for now. */
> +static bool smmu_testdev_space_supported(SMMUTestDevSpace sp)
> +{
> +    return sp =3D=3D STD_SPACE_NONSECURE;
> +}
> +
> +static MemTxAttrs mk_attrs_from_space(SMMUTestDevSpace space)
> +{
> +    MemTxAttrs a =3D {0};
> +    if (!smmu_testdev_space_supported(space)) {
> +        g_assert_not_reached();

Isn't this the same as just saying:

  g_assert(smmu_testdev_space_supported(space));

?

> +    } else {
> +        a.space =3D space;
> +    }
> +    a.secure =3D 0;
> +    return a;
> +}
> +
> +/* Convert SMMUTestDevSpace to AddressSpace */
> +static inline AddressSpace *space_to_as(SMMUTestDevSpace sp)
> +{
> +    /* Future work can dispatch Secure/Realm/Root address spaces here. */
> +    if (!smmu_testdev_space_supported(sp)) {
> +        g_assert_not_reached();
> +    }
> +    return &address_space_memory;
> +}
> +
> +/* Apply per-space offset for addresses or values that encode addresses.=
 */
> +static inline uint64_t std_apply_space_offs(SMMUTestDevSpace sp, uint64_=
t x)
> +{
> +    return x + std_space_offset(sp);
> +}
> +
> +/* Direct write helpers (no mirroring) */
> +static void std_write64(SMMUTestDevSpace sp, uint64_t pa, uint64_t val,
> +                       uint32_t *status)
> +{
> +    MemTxAttrs a =3D mk_attrs_from_space(sp);
> +    AddressSpace *as =3D space_to_as(sp);
> +    if (!as) {
> +        *status =3D 0xdead2011u;
> +        return;
> +    }
> +    MemTxResult r =3D address_space_write(as, pa, a, &val, sizeof(val));
> +    if (r !=3D MEMTX_OK && status) {
> +        *status =3D 0xdead2011u;
> +        return;
> +    }
> +    *status =3D 0;
> +}
> +
> +static void std_write32(SMMUTestDevSpace sp, uint64_t pa, uint32_t val,
> +                       uint32_t *status)
> +{
> +    MemTxAttrs a =3D mk_attrs_from_space(sp);
> +    AddressSpace *as =3D space_to_as(sp);
> +    if (!as) {
> +        *status =3D 0xdead2012u;
> +        return;
> +    }
> +    MemTxResult r =3D address_space_write(as, pa, a, &val, sizeof(val));
> +    if (r !=3D MEMTX_OK && status) {
> +        *status =3D 0xdead2012u;
> +        return;
> +    }
> +    *status =3D 0;
> +}
> +
> +/* Build the translation tables with specified stage and security spaces=
. */
> +static void smmu_testdev_build_translation(SMMUTestDevState *s)
> +{
> +    smmu_testdev_debug(s, "smmu_testdev_build_translation: stage=3D%s s1=
_space=3D%s"
> +                       " s2_space=3D%s\n", std_mode_to_str(s->trans_mode=
),
> +                       std_space_to_str(s->s1_space),
> +                       std_space_to_str(s->s2_space));

tracepoint

> +    uint32_t st =3D 0;
> +    SMMUTestDevSpace build_space =3D
> +        (s->trans_mode =3D=3D TM_S1_ONLY) ? s->s1_space : s->s2_space;
> +
> +    if (!smmu_testdev_space_supported(build_space) ||
> +        (s->trans_mode !=3D TM_S2_ONLY &&
> +         !smmu_testdev_space_supported(s->s1_space))) {
> +        /* Only the Non-Secure space is supported until more domains lan=
d. */
> +        s->trans_status =3D 0xdead3001u;
> +        return;
> +    }
> +
> +    /*
> +     * Build base page tables (L0..L3) in the chosen space.
> +     * For Non-Secure, place tables at Secure-base + space offset and
> +     * update descriptor values by the same offset to keep internal
> +     * relationships identical across spaces.
> +     */
> +    uint64_t L0_pa =3D std_apply_space_offs(build_space, STD_L0_ADDR);
> +    uint64_t L1_pa =3D std_apply_space_offs(build_space, STD_L1_ADDR);
> +    uint64_t L2_pa =3D std_apply_space_offs(build_space, STD_L2_ADDR);
> +    uint64_t L3_pa =3D std_apply_space_offs(build_space, STD_L3_ADDR);
> +    uint64_t L0_val =3D std_apply_space_offs(build_space, STD_L0_VAL);
> +    uint64_t L1_val =3D std_apply_space_offs(build_space, STD_L1_VAL);
> +    uint64_t L2_val =3D std_apply_space_offs(build_space, STD_L2_VAL);
> +    uint64_t L3_val =3D std_apply_space_offs(build_space, STD_L3_VAL);
> +    std_write64(build_space, L0_pa, L0_val, &st);
> +    std_write64(build_space, L1_pa, L1_val, &st);
> +    std_write64(build_space, L2_pa, L2_val, &st);
> +    std_write64(build_space, L3_pa, L3_val, &st);
> +
> +    /* Build STE image */
> +    STEImg ste =3D {0};
> +    switch (s->trans_mode) {
> +    case TM_S1_ONLY:
> +        STD_STE_SET_CONFIG(&ste, 0x5);
> +        break;
> +    case TM_S2_ONLY:
> +        STD_STE_SET_CONFIG(&ste, 0x6);
> +        break;
> +    case TM_NESTED:
> +    default:
> +        STD_STE_SET_CONFIG(&ste, 0x7);
> +        break;
> +    }
> +
> +    uint64_t vttb =3D STD_VTTB;
> +    STD_STE_SET_VALID(&ste, 1);
> +    STD_STE_SET_S2T0SZ(&ste, STD_STE_S2T0SZ_VAL);
> +    STD_STE_SET_S2SL0(&ste, 0x2);   /* Start level 0*/
> +    STD_STE_SET_S2TG(&ste, 0);      /* 4KB */
> +    STD_STE_SET_S2PS(&ste, 0x5);    /* 48 bits */
> +    STD_STE_SET_S2AA64(&ste, 1);    /* Enable S2AA64 (64-bit address for=
mat). */
> +    STD_STE_SET_S2ENDI(&ste, 0);    /* Little Endian */
> +    STD_STE_SET_S2AFFD(&ste, 0);    /* AF Fault Disable */
> +
> +    STD_STE_SET_S2T0SZ(&ste, STD_STE_S2T0SZ_VAL);
> +    STD_STE_SET_S2SL0(&ste, 0x2);   /* Start level */
> +    STD_STE_SET_S2TG(&ste, 0);      /* 4KB */
> +    STD_STE_SET_S2PS(&ste, 0x5);    /* 48 bits ?*/
> +    /* Set Context Pointer (S1ContextPtr) */
> +    STD_STE_SET_CTXPTR(&ste, std_apply_space_offs(build_space, STD_CD_GP=
A));
> +
> +    STD_STE_SET_S2TTB(&ste, std_apply_space_offs(build_space, vttb));
> +
> +    /*
> +     * Start assembling the STE, which is 64 bytes in total.
> +     */
> +    for (int i =3D 0; i < 8; i++) {
> +        std_write32(build_space,
> +                    std_apply_space_offs(build_space, STD_STE_GPA) + i *=
 4,
> +                    ste.word[i], &st);
> +        if (st !=3D 0) {
> +            printf("Writing STE error! status: %x\n", st);


  qemu_log_mask(LOG_GUEST_ERROR, ...

> +            return;
> +        }
> +    }
> +
> +    /* Build CD image for S1 path if needed */
> +    if (s->trans_mode !=3D TM_S2_ONLY) {
> +        CDImg cd =3D {0};
> +
> +        STD_CD_SET_ASID(&cd, 0x1e20);     /* ASID */
> +        STD_CD_SET_AARCH64(&cd, 1);       /* AA64 */
> +        STD_CD_SET_VALID(&cd, 1);
> +        STD_CD_SET_A(&cd, 1);
> +        STD_CD_SET_S(&cd, 0);
> +        STD_CD_SET_HD(&cd, 0);
> +        STD_CD_SET_HA(&cd, 0);
> +        STD_CD_SET_IPS(&cd, 0x4);
> +        STD_CD_SET_TBI(&cd, 0x0);
> +        STD_CD_SET_AFFD(&cd, 0x0);
> +        /* Disable TTB0 translation table walk */
> +        STD_CD_SET_EPD(&cd, 0, 0x0);
> +        /* Enable TTB1 translation table walk */
> +        STD_CD_SET_EPD(&cd, 1, 0x1);
> +        STD_CD_SET_TSZ(&cd, 0, 0x10);
> +        STD_CD_SET_TG(&cd, 0, 0x0);
> +        STD_CD_SET_ENDI(&cd, 0x0);
> +        STD_CD_SET_NSCFG0(&cd, 0x0);
> +        STD_CD_SET_NSCFG1(&cd, 0x0);
> +        STD_CD_SET_R(&cd, 0x1);
> +
> +        /*
> +         * CD belongs to S1 path: compute offsets using s1_space so the
> +         * GPA and embedded addresses are consistent with that space.
> +         */
> +        uint64_t cd_ttb =3D std_apply_space_offs(build_space, vttb);
> +        smmu_testdev_debug(s, "STD_CD_SET_TTB: 0x%llx\n",
> +                           (unsigned long long)cd_ttb);
> +        STD_CD_SET_TTB(&cd, 0, cd_ttb);
> +
> +        for (int i =3D 0; i < 8; i++) {
> +            std_write32(s->s1_space,
> +                        std_apply_space_offs(s->s1_space, STD_CD_GPA) + =
i * 4,
> +                        cd.word[i], &st);
> +        }
> +
> +        L3_val =3D std_apply_space_offs(build_space, STD_L3_S1_VAL);
> +        std_write64(build_space, L3_pa, L3_val, &st);
> +    }
> +
> +    /* Nested extras: CD S2 tables, CD.TTB S2 tables, shared entries. */
> +    if (s->trans_mode =3D=3D TM_NESTED) {
> +        /* CD.S2 tables */
> +        std_write64(build_space,
> +                    std_apply_space_offs(build_space, STD_CD_S2_L0_ADDR),
> +                    std_apply_space_offs(build_space, STD_L0_VAL), &st);
> +        std_write64(build_space,
> +                    std_apply_space_offs(build_space, STD_CD_S2_L1_ADDR),
> +                    std_apply_space_offs(build_space, STD_L1_VAL), &st);
> +        std_write64(build_space,
> +                    std_apply_space_offs(build_space, STD_CD_S2_L2_ADDR),
> +                    std_apply_space_offs(build_space, STD_L2_VAL), &st);
> +        std_write64(build_space,
> +                    std_apply_space_offs(build_space, STD_CD_S2_L3_ADDR),
> +                    std_apply_space_offs(build_space,
> +                                         STD_CD_S2_L3_VAL), &st);
> +
> +        /* CD.TTB S2 tables */
> +        std_write64(build_space,
> +                    std_apply_space_offs(build_space, STD_CDTTB_S2_L2_AD=
DR),
> +                    std_apply_space_offs(build_space, STD_L2_VAL), &st);
> +        std_write64(build_space,
> +                    std_apply_space_offs(build_space, STD_CDTTB_S2_L3_AD=
DR),
> +                    std_apply_space_offs(build_space,
> +                                         STD_CDTTB_S2_L3_VAL), &st);
> +
> +        /* Shared mappings between S1 and S2 page tables */
> +        std_write64(build_space,
> +                    std_apply_space_offs(build_space, STD_S1L0_IN_S2L3_A=
DDR),
> +                    std_apply_space_offs(build_space,
> +                                         STD_S1L0_IN_S2L3_VAL), &st);
> +        std_write64(build_space,
> +                    std_apply_space_offs(build_space, STD_S1L1_IN_S2L3_A=
DDR),
> +                    std_apply_space_offs(build_space,
> +                                         STD_S1L1_IN_S2L3_VAL), &st);
> +        std_write64(build_space,
> +                    std_apply_space_offs(build_space, STD_S1L2_IN_S2L3_A=
DDR),
> +                    std_apply_space_offs(build_space,
> +                                         STD_S1L2_IN_S2L3_VAL), &st);
> +        std_write64(build_space,
> +                    std_apply_space_offs(build_space, STD_S1L3_IN_S2L2_A=
DDR),
> +                    std_apply_space_offs(build_space,
> +                                         STD_S1L3_IN_S2L2_VAL), &st);
> +        std_write64(build_space,
> +                    std_apply_space_offs(build_space, STD_S1L3_IN_S2L3_A=
DDR),
> +                    std_apply_space_offs(build_space,
> +                                         STD_S1L3_IN_S2L3_VAL), &st);
> +    }
> +
> +    s->trans_status =3D st;
> +}
> +
> +/* Manipulate SMMU command to invalidate caches */
> +static void push_cfgi_cmd(SMMUTestDevState *s,
> +                          SMMUTestDevSpace bank_sp,
> +                          uint32_t type,
> +                          uint32_t sid,
> +                          bool ssec)
> +{
> +    MemTxResult res =3D 0;
> +    g_assert(smmu_testdev_space_supported(bank_sp));
> +    g_assert(!ssec);
> +    hwaddr bank_off =3D 0;
> +    uint32_t base_lo =3D address_space_ldl_le(&address_space_memory,
> +                                            s->smmu_base + bank_off + 0x=
90,
> +                                            MEMTXATTRS_UNSPECIFIED, &res=
);
> +    uint32_t base_hi =3D address_space_ldl_le(&address_space_memory,
> +                                            s->smmu_base + bank_off + 0x=
94,
> +                                            MEMTXATTRS_UNSPECIFIED, &res=
);
> +    uint64_t base =3D ((uint64_t)base_hi << 32) | base_lo;
> +    uint32_t log2size =3D base & 0x1f;
> +    uint64_t qbase =3D base & 0xfffffffffffc0ULL;
> +    uint32_t prod =3D address_space_ldl_le(&address_space_memory,
> +                                         s->smmu_base + bank_off + 0x98,
> +                                         MEMTXATTRS_UNSPECIFIED, &res);
> +    uint32_t index_mask =3D (1u << log2size) - 1u;
> +    uint32_t slot =3D prod & index_mask;
> +    uint64_t entry_pa =3D qbase + (uint64_t)slot * 16u;
> +
> +    uint32_t words[4] =3D {0};
> +    words[0] =3D (type & 0xff) | (ssec ? (1u << 10) : 0u);
> +    words[1] =3D sid;
> +
> +    /* push command to the command queue */
> +    MemTxAttrs a =3D mk_attrs_from_space(bank_sp);
> +    AddressSpace *as =3D space_to_as(bank_sp);
> +    if (!as) {
> +        printf("push_cfgi_cmd: space %d not supported\n", bank_sp);

qemu_log_mask(LOG_UNIMP?

> +        return;
> +    }
> +    int ret =3D address_space_write(as, entry_pa, a,
> +                                  words, sizeof(words));
> +    smmu_testdev_debug(s, "push_cfgi_cmd ret %d\n", ret);

tracepoint

> +
> +    /* update PROD to trigger command handler */
> +    uint32_t new_prod =3D (prod + 1) & ((1u << (log2size + 1)) - 1u);
> +    address_space_stl_le(&address_space_memory,
> +                         s->smmu_base + bank_off + 0x98,
> +                         new_prod, MEMTXATTRS_UNSPECIFIED, &res);
> +    smmu_testdev_debug(s, "last res %d\n", res);

tracepoint but really see if it can be merged with above.

> +}
> +
> +/* Clear all the cache to avoid the incorrect cache hits using SMMU comm=
ands */
> +static void smmu_testdev_clear_caches(SMMUTestDevState *s)
> +{
> +    uint32_t st =3D 0;
> +    static const SMMUTestDevSpace spaces[] =3D { STD_SPACE_NONSECURE };
> +
> +    for (size_t idx =3D 0; idx < ARRAY_SIZE(spaces); idx++) {
> +        SMMUTestDevSpace build_space =3D spaces[idx];
> +        if (!smmu_testdev_space_supported(build_space)) {
> +            continue;
> +        }
> +        /* Clear L0..L3 entries written by the builder. */
> +        uint64_t L0_pa =3D std_apply_space_offs(build_space, STD_L0_ADDR=
);
> +        uint64_t L1_pa =3D std_apply_space_offs(build_space, STD_L1_ADDR=
);
> +        uint64_t L2_pa =3D std_apply_space_offs(build_space, STD_L2_ADDR=
);
> +        uint64_t L3_pa =3D std_apply_space_offs(build_space, STD_L3_ADDR=
);
> +        uint64_t S2_L0_pa =3D std_apply_space_offs(build_space,
> +                                                 STD_CD_S2_L0_ADDR);
> +        uint64_t S2_L1_pa =3D std_apply_space_offs(build_space,
> +                                                 STD_CD_S2_L1_ADDR);
> +        uint64_t S2_L2_pa =3D std_apply_space_offs(build_space,
> +                                                 STD_CD_S2_L2_ADDR);
> +        uint64_t S2_L3_pa =3D std_apply_space_offs(build_space,
> +                                                 STD_CD_S2_L3_ADDR);
> +
> +        std_write64(build_space, L0_pa, 0ull, &st);
> +        std_write64(build_space, L1_pa, 0ull, &st);
> +        std_write64(build_space, L2_pa, 0ull, &st);
> +        std_write64(build_space, L3_pa, 0ull, &st);
> +        std_write64(build_space, S2_L0_pa, 0ull, &st);
> +        std_write64(build_space, S2_L1_pa, 0ull, &st);
> +        std_write64(build_space, S2_L2_pa, 0ull, &st);
> +        std_write64(build_space, S2_L3_pa, 0ull, &st);
> +
> +        /* Clear STE image where it was placed. */
> +        for (int i =3D 0; i < 8; i++) {
> +            std_write32(build_space,
> +                        std_apply_space_offs(build_space, STD_STE_GPA) +=
 i * 4,
> +                        0u, &st);
> +        }
> +
> +        /* Clear CD image in S1 space (matches builder placement). */
> +        for (int i =3D 0; i < 8; i++) {
> +            std_write32(build_space,
> +                        std_apply_space_offs(build_space, STD_CD_GPA) + =
i * 4,
> +                        0u, &st);
> +        }
> +    }
> +
> +    /* Invalidate configuration cache via CFGI_STE and CFGI_CD commands =
*/
> +    if (s->smmu_base) {
> +        /* Compute this PCI function's StreamID: bus 0, current devfn. */
> +        uint8_t devfn =3D PCI_DEVICE(&s->parent_obj)->devfn;
> +        uint32_t sid =3D PCI_BUILD_BDF(0, devfn);
> +
> +        /* Non-secure bank invalidations (SSEC=3D0). */
> +        push_cfgi_cmd(s, STD_SPACE_NONSECURE, STD_CMD_CFGI_STE, sid, fal=
se);
> +        push_cfgi_cmd(s, STD_SPACE_NONSECURE, STD_CMD_CFGI_CD,  sid, fal=
se);
> +        push_cfgi_cmd(s, STD_SPACE_NONSECURE, STD_CMD_TLBI_NSNH_ALL,
> +                      sid, false);
> +
> +        /* Add Secure/Realm/Root invalidations here once those domains e=
xist. */
> +    }
> +}
> +
> +static void smmu_testdev_refresh_attrs(SMMUTestDevState *s)
> +{
> +    /* Report the baked-in Non-Secure attributes until more exist. */
> +    s->attr_ns =3D (STD_SPACE_NONSECURE << 1);
> +}
> +
> +/* Trigger a DMA operation */
> +static void smmu_testdev_maybe_run_dma(SMMUTestDevState *s)
> +{
> +    if (!s->dma_pending) {
> +        return;
> +    }
> +    smmu_testdev_debug(s, "smmu_testdev_maybe_run_dma: dma_pending: %d\n=
",
> +                       s->dma_pending);

tracepoint

> +
> +    s->dma_pending =3D false;
> +
> +    if (!s->dma_len || s->dma_len > DMA_MAX_LEN) {
> +        s->dma_result =3D DMA_ERR_BAD_LEN;
> +        return;
> +    }
> +
> +    g_autofree uint8_t *buf =3D g_malloc(s->dma_len);
> +    MemTxResult res;

Keep local vars at the top of the block.

> +
> +    if (s->dma_mode =3D=3D 0) {
> +        if (s->dma_dir =3D=3D DMA_DIR_HOST2DEV) {
> +            res =3D pci_dma_read(PCI_DEVICE(&s->parent_obj), s->dma_iova,
> +                               buf, s->dma_len);
> +        } else {
> +            for (uint32_t i =3D 0; i < s->dma_len; i++) {
> +                buf[i] =3D 0xA0u + (i & 0x1fu);
> +            }
> +            res =3D pci_dma_write(PCI_DEVICE(&s->parent_obj), s->dma_iov=
a,
> +                                buf, s->dma_len);
> +        }
> +    } else {
> +        SMMUTestDevSpace dma_space =3D
> +            (SMMUTestDevSpace)((s->dma_attrs_cfg >> 1) & 0x3);
> +        if (!smmu_testdev_space_supported(dma_space)) {
> +            /* Default to Non-Secure until other spaces are modeled. */
> +            dma_space =3D STD_SPACE_NONSECURE;
> +        }
> +        MemTxAttrs attrs =3D {
> +            .secure =3D 0,
> +            .space =3D dma_space,
> +            .unspecified =3D (s->dma_attrs_cfg & (1u << 3)) ? 1 : 0,
> +        };
> +        /*
> +         * If 'unspecified' is set, bypass IOMMU AS and use system memor=
y.
> +         * This helps tests that want deterministic success without full
> +         * IOMMU programming.
> +         */
> +        AddressSpace *as =3D (s->dma_as && !attrs.unspecified)
> +                               ? s->dma_as
> +                               : &address_space_memory;
> +        if (s->dma_dir =3D=3D DMA_DIR_HOST2DEV) {
> +            res =3D dma_memory_read(as, s->dma_iova, buf, s->dma_len, at=
trs);
> +        } else {
> +            for (uint32_t i =3D 0; i < s->dma_len; i++) {
> +                buf[i] =3D 0xA0u + (i & 0x1fu);
> +            }
> +            res =3D dma_memory_write(as, s->dma_iova, buf, s->dma_len, a=
ttrs);
> +        }
> +    }
> +    s->dma_result =3D (res =3D=3D MEMTX_OK) ? 0 : DMA_ERR_TX_FAIL;
> +    smmu_testdev_debug(s, "iommu ret %d , dma_result: 0x%x\n",
> +                       res, s->dma_result);
> +}
> +
> +static uint64_t smmu_testdev_mmio_read(void *opaque, hwaddr addr, unsign=
ed size)
> +{
> +    SMMUTestDevState *s =3D opaque;
> +    switch (addr) {
> +    case REG_ID:
> +        /*
> +         * Only reads of REG_ID intentionally trigger the side effects
> +         * (SMMU CR0 write and pending DMA). This lets tests poll
> +         * REG_DMA_RESULT to observe BUSY before consuming the DMA.
> +         */
> +        smmu_testdev_maybe_run_dma(s);
> +        return 0x53544d4du; /* 'STMM' */
> +    case REG_ATTR_NS:
> +        return s->attr_ns;
> +    case REG_SMMU_BASE_LO:
> +        return (uint32_t)(s->smmu_base & 0xffffffffu);
> +    case REG_SMMU_BASE_HI:
> +        return (uint32_t)(s->smmu_base >> 32);
> +    case REG_DMA_IOVA_LO:
> +        return (uint32_t)(s->dma_iova & 0xffffffffu);
> +    case REG_DMA_IOVA_HI:
> +        return (uint32_t)(s->dma_iova >> 32);
> +    case REG_DMA_LEN:
> +        return s->dma_len;
> +    case REG_DMA_DIR:
> +        return s->dma_dir;
> +    case REG_DMA_RESULT:
> +        return s->dma_result;
> +    case REG_DMA_MODE:
> +        return s->dma_mode;
> +    case REG_DMA_ATTRS:
> +        return s->dma_attrs_cfg;
> +    case REG_TRANS_MODE:
> +        return s->trans_mode;
> +    case REG_S1_SPACE:
> +        return s->s1_space;
> +    case REG_S2_SPACE:
> +        return s->s2_space;
> +    case REG_TRANS_STATUS:
> +        return s->trans_status;
> +    default:
> +        return 0;
> +    }
> +}
> +
> +static void smmu_testdev_mmio_write(void *opaque, hwaddr addr, uint64_t =
val,
> +                                    unsigned size)
> +{
> +    SMMUTestDevState *s =3D opaque;
> +    uint32_t data =3D val;
> +
> +    switch (addr) {
> +    case REG_ID:
> +        if (data =3D=3D 0x1) {
> +            smmu_testdev_refresh_attrs(s);
> +        }
> +        break;
> +    case REG_SMMU_BASE_LO:
> +        s->smmu_base =3D (s->smmu_base & ~0xffffffffull) | data;
> +        break;
> +    case REG_SMMU_BASE_HI:
> +        s->smmu_base =3D (s->smmu_base & 0xffffffffull) |
> +                       ((uint64_t)data << 32);
> +        break;
> +    case REG_DMA_IOVA_LO:
> +        s->dma_iova =3D (s->dma_iova & ~0xffffffffull) | data;
> +        break;
> +    case REG_DMA_IOVA_HI:
> +        s->dma_iova =3D (s->dma_iova & 0xffffffffull) |
> +                      ((uint64_t)data << 32);
> +        break;
> +    case REG_DMA_LEN:
> +        s->dma_len =3D data;
> +        break;
> +    case REG_DMA_DIR:
> +        s->dma_dir =3D data ? DMA_DIR_HOST2DEV : DMA_DIR_DEV2HOST;
> +        break;
> +    case REG_DMA_RESULT:
> +        s->dma_result =3D data;
> +        break;
> +    case REG_DMA_DOORBELL:
> +        if (data & 0x1) {
> +            s->dma_pending =3D true;
> +            s->dma_result =3D DMA_RESULT_BUSY;
> +        } else {
> +            s->dma_pending =3D false;
> +            s->dma_result =3D DMA_RESULT_IDLE;
> +        }
> +        break;
> +    case REG_DMA_MODE:
> +        s->dma_mode =3D data & 0x1;
> +        break;
> +    case REG_DMA_ATTRS:
> +        s->dma_attrs_cfg =3D data;
> +        break;
> +    case REG_TRANS_MODE:
> +        s->trans_mode =3D data & 0x3;
> +        break;
> +    case REG_S1_SPACE:
> +        s->s1_space =3D (SMMUTestDevSpace)(data & 0x3);
> +        break;
> +    case REG_S2_SPACE:
> +        s->s2_space =3D (SMMUTestDevSpace)(data & 0x3);
> +        break;
> +    case REG_TRANS_DBELL:
> +        if (data & 0x2) {
> +            s->trans_status =3D 0;
> +        }
> +        if (data & 0x1) {
> +            smmu_testdev_build_translation(s);
> +        }
> +        break;
> +    case REG_TRANS_CLEAR:
> +        /* Clear helper caches so the next iteration rebuilds cleanly. */
> +        smmu_testdev_clear_caches(s);
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps smmu_testdev_mmio_ops =3D {
> +    .read =3D smmu_testdev_mmio_read,
> +    .write =3D smmu_testdev_mmio_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +static void smmu_testdev_realize(PCIDevice *pdev, Error **errp)
> +{
> +    SMMUTestDevState *s =3D SMMU_TESTDEV(pdev);
> +
> +    /* Apply user-configurable BDF (default 0:1). */
> +    uint8_t dev =3D s->cfg_dev & 0x1f;
> +    uint8_t fn  =3D s->cfg_fn & 0x7;
> +    pdev->devfn =3D (dev << 3) | fn;
> +
> +    smmu_testdev_refresh_attrs(s);
> +    s->smmu_base =3D 0;
> +    s->dma_iova =3D 0;
> +    s->dma_len =3D 0;
> +    s->dma_dir =3D DMA_DIR_DEV2HOST;
> +    s->dma_result =3D DMA_RESULT_IDLE;
> +    s->dma_pending =3D false;
> +    s->dma_mode =3D 0;
> +    s->dma_attrs_cfg =3D 0;
> +    s->dma_as =3D pci_device_iommu_address_space(pdev);
> +    s->trans_mode =3D TM_S2_ONLY;
> +    s->s1_space =3D STD_SPACE_NONSECURE;
> +    s->s2_space =3D STD_SPACE_NONSECURE;
> +    s->trans_status =3D 0;
> +
> +    if (s->debug_log) {
> +        smmu_testdev_debug(s, "[smmu-testdev] debug logging enabled\n");
> +    }
> +
> +    memory_region_init_io(&s->bar0, OBJECT(pdev), &smmu_testdev_mmio_ops=
, s,
> +                          TYPE_SMMU_TESTDEV ".bar0", BAR0_SIZE);
> +    pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar0);
> +}
> +
> +static void smmu_testdev_reset(DeviceState *dev)
> +{
> +    SMMUTestDevState *s =3D SMMU_TESTDEV(dev);
> +
> +    smmu_testdev_refresh_attrs(s);
> +    s->smmu_base =3D 0;
> +    s->dma_iova =3D 0;
> +    s->dma_len =3D 0;
> +    s->dma_dir =3D DMA_DIR_DEV2HOST;
> +    s->dma_result =3D DMA_RESULT_IDLE;
> +    s->dma_pending =3D false;
> +    s->dma_mode =3D 0;
> +    s->dma_attrs_cfg =3D 0;
> +    s->trans_mode =3D TM_S2_ONLY;
> +    s->s1_space =3D STD_SPACE_NONSECURE;
> +    s->s2_space =3D STD_SPACE_NONSECURE;
> +    s->trans_status =3D 0;
> +    /* Keep cfg_dev/cfg_fn as-is across reset */
> +}
> +
> +static const Property smmu_testdev_properties[] =3D {
> +    DEFINE_PROP_UINT32("device", SMMUTestDevState, cfg_dev, 0),
> +    DEFINE_PROP_UINT32("function", SMMUTestDevState, cfg_fn, 1),
> +    DEFINE_PROP_BOOL("debug-log", SMMUTestDevState, debug_log,
> false),

We have tracepoints so we don't need this flag.

> +};
> +
> +static void smmu_testdev_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PCIDeviceClass *pc =3D PCI_DEVICE_CLASS(klass);
> +
> +    pc->realize =3D smmu_testdev_realize;
> +    pc->vendor_id =3D PCI_VENDOR_ID_REDHAT;
> +    pc->device_id =3D PCI_DEVICE_ID_REDHAT_TEST;
> +    pc->revision =3D 0;
> +    pc->class_id =3D PCI_CLASS_OTHERS;
> +    dc->desc =3D "A test device for the SMMU";
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    device_class_set_legacy_reset(dc, smmu_testdev_reset);
> +    device_class_set_props(dc, smmu_testdev_properties);
> +}
> +
> +static void smmu_testdev_instance_init(Object *obj)
> +{
> +    SMMUTestDevState *s =3D SMMU_TESTDEV(obj);
> +    s->cfg_dev =3D 0;
> +    s->cfg_fn =3D 1; /* default StreamID =3D 1 (slot 0, fn 1) */
> +    s->debug_log =3D false;
> +}
> +
> +static const TypeInfo smmu_testdev_info =3D {
> +    .name          =3D TYPE_SMMU_TESTDEV,
> +    .parent        =3D TYPE_PCI_DEVICE,
> +    .instance_size =3D sizeof(SMMUTestDevState),
> +    .instance_init =3D smmu_testdev_instance_init,
> +    .class_init    =3D smmu_testdev_class_init,
> +    .interfaces    =3D (const InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { }
> +    },
> +};
> +
> +static void smmu_testdev_register_types(void)
> +{
> +    type_register_static(&smmu_testdev_info);
> +}
> +
> +type_init(smmu_testdev_register_types);
> diff --git a/include/hw/misc/smmu-testdev.h b/include/hw/misc/smmu-testde=
v.h
> new file mode 100644
> index 0000000000..6d97f6c704
> --- /dev/null
> +++ b/include/hw/misc/smmu-testdev.h
> @@ -0,0 +1,402 @@
> +/*
> + * A test device for the SMMU
> + *
> + * This test device is a minimal SMMU-aware device used to test the SMMU.
> + *
> + * Copyright (c) 2025 Phytium Technology
> + *
> + * Author:
> + *  Tao Tang <tangtao1634@phytium.com.cn>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_SMMU_TESTDEV_H
> +#define HW_MISC_SMMU_TESTDEV_H
> +
> +#include "qemu/osdep.h"
> +typedef enum SMMUTestDevSpace {
> +    STD_SPACE_SECURE    =3D 0,
> +    STD_SPACE_NONSECURE =3D 1,
> +    STD_SPACE_ROOT      =3D 2,
> +    STD_SPACE_REALM     =3D 3,
> +} SMMUTestDevSpace;
> +
> +/* Only the Non-Secure space is implemented; leave room for future domai=
ns. */
> +#define STD_SUPPORTED_SPACES 1
> +
> +/* BAR0 registers (offsets) */
> +enum {
> +    STD_REG_ID           =3D 0x00,
> +    STD_REG_ATTR_NS      =3D 0x04,
> +    STD_REG_SMMU_BASE_LO =3D 0x20,
> +    STD_REG_SMMU_BASE_HI =3D 0x24,
> +    STD_REG_DMA_IOVA_LO  =3D 0x28,
> +    STD_REG_DMA_IOVA_HI  =3D 0x2C,
> +    STD_REG_DMA_LEN      =3D 0x30,
> +    STD_REG_DMA_DIR      =3D 0x34,
> +    STD_REG_DMA_RESULT   =3D 0x38,
> +    STD_REG_DMA_DBELL    =3D 0x3C,
> +    /* Extended controls for DMA attributes/mode */
> +    STD_REG_DMA_MODE     =3D 0x40,
> +    STD_REG_DMA_ATTRS    =3D 0x44,
> +    /* Translation controls */
> +    STD_REG_TRANS_MODE   =3D 0x48,
> +    STD_REG_S1_SPACE     =3D 0x4C,
> +    STD_REG_S2_SPACE     =3D 0x50,
> +    STD_REG_TRANS_DBELL  =3D 0x54,
> +    STD_REG_TRANS_STATUS =3D 0x58,
> +    /* Clear helper-built tables/descriptors (write-any to trigger) */
> +    STD_REG_TRANS_CLEAR  =3D 0x5C,
> +};

Aren't we just duplicating the anonymous enum in smmu-testdev.c here? I
think qtest is allowed to include qemu headers so lets just have a
common set please.

> +
> +/* DMA result/status values shared with tests */
> +#define STD_DMA_RESULT_IDLE 0xffffffffu
> +#define STD_DMA_RESULT_BUSY 0xfffffffeu
> +#define STD_DMA_ERR_BAD_LEN 0xdead0001u
> +#define STD_DMA_ERR_TX_FAIL 0xdead0002u
> +
> +/* DMA attributes layout (for STD_REG_DMA_ATTRS) */
> +#define STD_DMA_ATTR_SECURE        (1u << 0)
> +#define STD_DMA_ATTR_SPACE_SHIFT   1
> +#define STD_DMA_ATTR_SPACE_MASK    (0x3u << STD_DMA_ATTR_SPACE_SHIFT)
> +#define STD_DMA_ATTR_UNSPECIFIED   (1u << 3)
> +
> +/* Command type */
> +#define STD_CMD_CFGI_STE        0x03
> +#define STD_CMD_CFGI_CD         0x05
> +#define STD_CMD_TLBI_NSNH_ALL   0x30
> +
> +/*
> + * Translation tables and descriptors for a mapping of IOVA to GPA.
> + *
> + * This file defines a set of constants used to construct a static page =
table
> + * for an smmu-testdev device. The goal is to translate a specific  STD_=
IOVA
> + * into a final GPA.
> + * The translation is based on the Arm architecture with the following
> + * prerequisites:
> + * - Granule size: 4KB pages.
> + * - Page table levels: 4 levels (L0, L1, L2, L3), starting at level 0.
> + * - IOVA size: The walk resolves a 39-bit IOVA (0x8080604567).
> + * - Address space: The 4-level lookup with 4KB granules supports up to a
> + * 48-bit (256TB) virtual address space. Each level uses a 9-bit index
> + * (512 entries per table). The breakdown is:
> + * - L0 index: IOVA bits [47:39]
> + * - L1 index: IOVA bits [38:30]
> + * - L2 index: IOVA bits [29:21]
> + * - L3 index: IOVA bits [20:12]
> + * - Page offset: IOVA bits [11:0]
> + *
> + * NOTE: All physical addresses defined here (STD_VTTB, table addresses,=
 etc.)
> + * appear to be within a secure RAM region. In practice, an offset is ad=
ded
> + * to these values to place them in non-secure RAM. For example, when ru=
nning
> + * in a virt machine type, the RAM base address (e.g., 0x40000000) is ad=
ded to
> + * these constants.
> + *
> + * The page table walk for STD_IOVA (0x8080604567) proceeds as follows:
> + *
> + * The Translation Table Base (for both Stage 1 CD_TTB and Stage 2 STE_S=
2TTB)
> + * is set to STD_VTTB (0xe4d0000).
> + *
> + * 1. Level 0 (L0) Table Walk:
> + * l0_index =3D (0x8080604567 >> 39) & 0x1ff =3D 1
> + * STD_L0_ADDR =3D STD_VTTB + (l0_index * 8) =3D 0xe4d0000 + 8 =3D 0xe4d=
0008
> + * STD_L0_VAL  =3D 0xe4d1003
> + * The next level table base address =3D STD_L0_VAL & ~0xfff =3D 0xe4d10=
00
> + *
> + * 2. Level 1 (L1) Table Walk:
> + * l1_index =3D (0x8080604567 >> 30) & 0x1ff =3D 2
> + * STD_L1_ADDR =3D 0xe4d1000 + (l1_index * 8) =3D 0xe4d1000 + 16 =3D 0xe=
4d1010
> + * STD_L1_VAL  =3D 0xe4d2003
> + * The next level table base address =3D STD_L1_VAL & ~0xfff =3D 0xe4d20=
00
> + *
> + * 3. Level 2 (L2) Table Walk:
> + * l2_index =3D (0x8080604567 >> 21) & 0x1ff =3D 3
> + * STD_L2_ADDR =3D 0xe4d2000 + (l2_index * 8) =3D 0xe4d2000 + 24 =3D 0xe=
4d2018
> + * STD_L2_VAL  =3D 0xe4d3003
> + * The next level table base address =3D STD_L2_VAL & ~0xfff =3D 0xe4d30=
00
> + *
> + * 4. Level 3 (L3) Table Walk (Leaf):
> + * l3_index =3D (0x8080604567 >> 12) & 0x1ff =3D 4
> + * STD_L3_ADDR =3D 0xe4d3000 + (l3_index * 8) =3D 0xe4d3000 + 32 =3D 0xe=
4d3020
> + * STD_L3_VAL  =3D 0x040000000ECBA7C3
> + * The next level table base address =3D STD_L3_VAL & ~0xfff =3D 0xecba0=
00
> + *
> + * 5. Final GPA Calculation:
> + * - The final output physical address is formed by combining the addres=
s from
> + * the leaf descriptor with the original IOVA's page offset.
> + * - Output Page Base Address =3D (STD_L3_VAL & ~0xFFFULL) =3D 0xECBA000
> + * - Page Offset =3D (STD_IOVA & 0xFFFULL) =3D 0x567.
> + * - Final GPA =3D Output Page Base Address + Page Offset
> + * =3D 0xECBA000 + 0x567 =3D 0xECBA567
> + */
> +
> +#define STD_IOVA              0x0000008080604567ULL
> +
> +#define STD_VTTB 0xe4d0000
> +
> +#define STD_STR_TAB_BASE      0x000000000E179000ULL
> +#define STD_STE_GPA           (STD_STR_TAB_BASE + 0x40ULL)
> +#define STD_CD_GPA            (STD_STR_TAB_BASE + 0x80ULL)
> +
> +/* Page table structures */
> +#define STD_L0_ADDR           0x000000000E4D0008ULL
> +#define STD_L1_ADDR           0x000000000E4D1010ULL
> +#define STD_L2_ADDR           0x000000000E4D2018ULL
> +#define STD_L3_ADDR           0x000000000E4D3020ULL
> +#define STD_L0_VAL            0x000000000E4D1003ULL
> +#define STD_L1_VAL            0x000000000E4D2003ULL
> +#define STD_L2_VAL            0x000000000E4D3003ULL
> +#define STD_L3_VAL            0x040000000ECBA7C3ULL
> +
> +/*
> + * Nested stage PTW maybe a bit more complex. We share the page tables in
> + * nested stage 2 to avoid complicated definitions here. That is to say:
> + *
> + * At each level of the Stage 1 page table walk, a corresponding 4-level=
 Stage 2
> + * page table walk is performed. The intermediate Stage 2 page tables ar=
e shared
> + * across these walks, with the key connecting PTE values being:
> + * - l0_pte_val=3D0x4e4d1003
> + * - l1_pte_val=3D0x4e4d2003
> + * - l2_pte_val=3D0x4e4d3003
> + *
> + *
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + * Nested Page Table Walk (Stage 1 + Stage 2) Example
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + *
> + * Goal: Translate IOVA 0x8080604567 to a final Physical Address (PA).
> + *
> + * Prerequisites:
> + * - Stage 1 VTTB (as IPA): 0x4e4d0000
> + * - Stage 2 VTTB (as PA):  0x4e4d0000
> + *
> + * ----------------------------------------------------------------------
> + * 1. Stage 1 Page Table Walk (IOVA -> IPA)
> + * ----------------------------------------------------------------------
> + *
> + * Level 0 (L0) Walk (IPA as PA)
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> + * iova            =3D 0x8080604567
> + * l0_index        =3D (0x8080604567 >> 39) & 0x1ff =3D 1
> + * s1_l0_pte_addr (IPA) =3D 0x4e4d0000 + (1 * 8) =3D 0x4e4d0008
> + *
> + * --> Nested Stage 2 Walk for S1 L0 Table (IPA 0x4e4d0000 -> PA 0x4e4d0=
000)
> + * ---------------------------------------------------------------------=
----
> + * ipa_to_translate      =3D 0x4e4d0000
> + * s2_vttb               =3D 0x4e4d0000
> + * s2_l0_index           =3D (0x4e4d0000 >> 39) & 0x1ff =3D 0
> + * s2_l0_pte_addr (PA)   =3D 0x4e4d0000 + (0 * 8) =3D 0x4e4d0000
> + * s2_l0_pte_val         =3D 0x4e4d1003
> + * s2_l1_table_base (PA) =3D 0x4e4d1003 & ~0xfff =3D 0x4e4d1000
> + * s2_l1_index           =3D (0x4e4d0000 >> 30) & 0x1ff =3D 1
> + * s2_l1_pte_addr (PA)   =3D 0x4e4d1000 + (1 * 8) =3D 0x4e4d1008
> + * s2_l1_pte_val         =3D 0x4e4d2003
> + * s2_l2_table_base (PA) =3D 0x4e4d2003 & ~0xfff =3D 0x4e4d2000
> + * s2_l2_index           =3D (0x4e4d0000 >> 21) & 0x1ff =3D 114 (0x72)
> + * s2_l2_pte_addr (PA)   =3D 0x4e4d2000 + (114 * 8) =3D 0x4e4d2390
> + * s2_l2_pte_val         =3D 0x4e4d3003
> + * s2_l3_table_base (PA) =3D 0x4e4d3003 & ~0xfff =3D 0x4e4d3000
> + * s2_l3_index           =3D (0x4e4d0000 >> 12) & 0x1ff =3D 208 (0xd0)
> + * s2_l3_pte_addr (PA)   =3D 0x4e4d3000 + (208 * 8) =3D 0x4e4d3680
> + * s2_l3_pte_val         =3D 0x040000000E4D0743ULL
> + * output_page_base (PA) =3D 0x040000000E4D0743ULL & ~0xfff =3D 0x4e4d00=
00
> + * Final PA for table    =3D 0x4e4d0000 + (0x0000 & 0xfff) =3D 0x4e4d0000
> + *
> + * s1_l0_pte_val        (read from PA 0x4e4d0008) =3D 0x4e4d1003
> + * s1_l1_table_base (IPA) =3D 0x4e4d1003 & ~0xfff =3D 0x4e4d1000
> + *
> + * Level 1 (L1) Walk (IPA as PA)
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> + * iova            =3D 0x8080604567
> + * l1_index        =3D (0x8080604567 >> 30) & 0x1ff =3D 2
> + * s1_l1_pte_addr (IPA) =3D 0x4e4d1000 + (2 * 8) =3D 0x4e4d1010
> + *
> + * --> Nested Stage 2 Walk for S1 L1 Table (IPA 0x4e4d1000 -> PA 0x4e4d1=
000)
> + * ---------------------------------------------------------------------=
----
> + * ipa_to_translate      =3D 0x4e4d1000
> + * s2_vttb               =3D 0x4e4d0000
> + * s2_l0_index           =3D (0x4e4d1000 >> 39) & 0x1ff =3D 0
> + * s2_l1_table_base (PA) =3D 0x4e4d1000
> + * s2_l1_index           =3D (0x4e4d1000 >> 30) & 0x1ff =3D 1
> + * s2_l2_table_base (PA) =3D 0x4e4d2000
> + * s2_l2_index           =3D (0x4e4d1000 >> 21) & 0x1ff =3D 114 (0x72)
> + * s2_l3_table_base (PA) =3D 0x4e4d3000
> + * s2_l3_index           =3D (0x4e4d1000 >> 12) & 0x1ff =3D 209 (0xd1)
> + * s2_l3_pte_addr (PA)   =3D 0x4e4d3000 + (209 * 8) =3D 0x4e4d3688
> + * s2_l3_pte_val         =3D 0x40000004e4d1743
> + * output_page_base (PA) =3D 0x40000004e4d1743 & ~0xfff =3D 0x4e4d1000
> + * Final PA for table    =3D 0x4e4d1000 + (0x1000 & 0xfff) =3D 0x4e4d1000
> + *
> + * s1_l1_pte_val        (read from PA 0x4e4d1010) =3D 0x4e4d2003
> + * s1_l2_table_base (IPA) =3D 0x4e4d2003 & ~0xfff =3D 0x4e4d2000
> + *
> + * Level 2 (L2) Walk (IPA as PA)
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> + * l2_index        =3D (0x8080604567 >> 21) & 0x1ff =3D 3
> + * s1_l2_pte_addr (IPA) =3D 0x4e4d2000 + (3 * 8) =3D 0x4e4d2018
> + *
> + * --> Nested Stage 2 Walk for S1 L2 Table (IPA 0x4e4d2000 -> PA 0x4e4d2=
000)
> + * ---------------------------------------------------------------------=
----
> + * ipa_to_translate      =3D 0x4e4d2000
> + * s2_l0_index           =3D (0x4e4d2000 >> 39) & 0x1ff =3D 0
> + * s2_l1_table_base (PA) =3D 0x4e4d1000
> + * s2_l1_index           =3D (0x4e4d2000 >> 30) & 0x1ff =3D 1
> + * s2_l2_table_base (PA) =3D 0x4e4d2000
> + * s2_l2_index           =3D (0x4e4d2000 >> 21) & 0x1ff =3D 114 (0x72)
> + * s2_l3_table_base (PA) =3D 0x4e4d3000
> + * s2_l3_index           =3D (0x4e4d2000 >> 12) & 0x1ff =3D 210 (0xd2)
> + * s2_l3_pte_addr (PA)   =3D 0x4e4d3000 + (210 * 8) =3D 0x4e4d3690
> + * s2_l3_pte_val         =3D 0x40000004e4d2743
> + * output_page_base (PA) =3D 0x40000004e4d2743 & ~0xfff =3D 0x4e4d2000
> + * Final PA for table    =3D 0x4e4d2000 + (0x2000 & 0xfff) =3D 0x4e4d2000
> + *
> + * s1_l2_pte_val        (read from PA 0x4e4d2018) =3D 0x4e4d3003
> + * s1_l3_table_base (IPA) =3D 0x4e4d3003 & ~0xfff =3D 0x4e4d3000
> + *
> + * Level 3 (L3) Walk (Leaf, IPA as PA)
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + * l3_index        =3D (0x8080604567 >> 12) & 0x1ff =3D 4
> + * s1_l3_pte_addr (IPA) =3D 0x4e4d3000 + (4 * 8) =3D 0x4e4d3020
> + *
> + * --> Nested Stage 2 Walk for S1 L3 Table (IPA 0x4e4d3000 -> PA 0x4e4d3=
000)
> + * ---------------------------------------------------------------------=
----
> + * ipa_to_translate      =3D 0x4e4d3000
> + * s2_l0_index           =3D (0x4e4d3000 >> 39) & 0x1ff =3D 0
> + * s2_l1_table_base (PA) =3D 0x4e4d1000
> + * s2_l1_index           =3D (0x4e4d3000 >> 30) & 0x1ff =3D 1
> + * s2_l2_table_base (PA) =3D 0x4e4d2000
> + * s2_l2_index           =3D (0x4e4d3000 >> 21) & 0x1ff =3D 114 (0x72)
> + * s2_l3_table_base (PA) =3D 0x4e4d3000
> + * s2_l3_index           =3D (0x4e4d3000 >> 12) & 0x1ff =3D 211 (0xd3)
> + * s2_l3_pte_addr (PA)   =3D 0x4e4d3000 + (211 * 8) =3D 0x4e4d3698
> + * s2_l3_pte_val         =3D 0x40000004e4d3743
> + * output_page_base (PA) =3D 0x40000004e4d3743 & ~0xfff =3D 0x4e4d3000
> + * Final PA for table    =3D 0x4e4d3000 + (0x3000 & 0xfff) =3D 0x4e4d3000
> + *
> + * s1_l3_pte_val        (read from PA 0x4e4d3020) =3D 0x40000004ecba743
> + * output_page_base (IPA) =3D 0x40000004ecba743 & ~0xfff =3D 0x4ecba000
> + * page_offset          =3D 0x8080604567 & 0xfff =3D 0x567
> + * Final IPA            =3D 0x4ecba000 + 0x567 =3D 0x4ecba567
> + *
> + * ----------------------------------------------------------------------
> + * 2. Final Stage 2 Page Table Walk (Final IPA -> PA)
> + * ----------------------------------------------------------------------
> + *
> + * ipa =3D 0x4ecba567
> + *
> + * s2_l0_index           =3D (0x4ecba567 >> 39) & 0x1ff =3D 0
> + * s2_l1_table_base (PA) =3D 0x4e4d1000
> + *
> + * s2_l1_index           =3D (0x4ecba567 >> 30) & 0x1ff =3D 1
> + * s2_l2_table_base (PA) =3D 0x4e4d2000
> + *
> + * s2_l2_index           =3D (0x4ecba567 >> 21) & 0x1ff =3D 118 (0x76)
> + * s2_l3_table_base (PA) =3D 0x4e4d3000
> + *
> + * s2_l3_index           =3D (0x4ecba567 >> 12) & 0x1ff =3D 186 (0xba)
> + * s2_l3_pte_addr (PA)   =3D 0x4e4d3000 + (186 * 8) =3D 0x4e4d35d0
> + * s2_l3_pte_val         =3D 0x40000004ecba7c3
> + * output_page_base (PA) =3D 0x40000004ecba7c3 & ~0xfff =3D 0x4ecba000
> + * page_offset           =3D 0x4ecba567 & 0xfff =3D 0x567
> + *
> + * ----------------------------------------------------------------------
> + * 3. Final Result
> + * ----------------------------------------------------------------------
> + * Final PA =3D 0x4ecba000 + 0x567 =3D 0x4ecba567
> + *
> + * ----------------------------------------------------------------------
> + * 4. Appendix: Context Descriptor (CD) Fetch Walk
> + * ----------------------------------------------------------------------
> + * Before any S1 walk can begin, the SMMU must fetch the Context Descrip=
tor.
> + * The CD's address is an IPA, so it also requires a full S2 walk. This
> + * walk RE-USES the exact same S2 page tables shown above.
> + *
> + * ipa =3D 0x4e179080 (Address of the CD)
> + *
> + * s2_l0_index           =3D (0x4e179080 >> 39) & 0x1ff =3D 0
> + * s2_l0_pte_val         =3D 0x4e4d1003
> + * s2_l1_table_base (PA) =3D 0x4e4d1000 (*RE-USED*)
> + *
> + * s2_l1_index           =3D (0x4e179080 >> 30) & 0x1ff =3D 1
> + * s2_l1_pte_val         =3D 0x4e4d2003
> + * s2_l2_table_base (PA) =3D 0x4e4d2000 (*RE-USED*)
> + *
> + * s2_l2_index           =3D (0x4e179080 >> 21) & 0x1ff =3D 112 (0x70)
> + * s2_l2_pte_val         =3D 0x4e4d3003
> + * s2_l3_table_base (PA) =3D 0x4e4d3000 (*RE-USED*)
> + *
> + * s2_l3_index           =3D (0x4e179080 >> 12) & 0x1ff =3D 377 (0x179)
> + * s2_l3_pte_addr (PA)   =3D 0x4e4d3000 + (377 * 8) =3D 0x4e4d3bc8
> + * s2_l3_pte_val         =3D 0x40000004e179743
> + * output_page_base (PA) =3D 0x40000004e179743 & ~0xfff =3D 0x4e179000
> + * page_offset           =3D 0x4e179080 & 0xfff =3D 0x080
> + *
> + * Final PA for CD       =3D 0x4e179000 + 0x080 =3D 0x4e179080
> + *
> + */
> +#define STD_CD_S2_L0_ADDR     0x000000000E4D0000ULL
> +#define STD_CD_S2_L1_ADDR     0x000000000E4D1008ULL
> +#define STD_CD_S2_L2_ADDR     0x000000000E4D2380ULL
> +#define STD_CD_S2_L3_ADDR     0x000000000E4D3BC8ULL
> +#define STD_CD_S2_L3_VAL      0x040000000E179743ULL
> +
> +#define STD_CDTTB_S2_L2_ADDR  0x000000000E4D2390ULL
> +#define STD_CDTTB_S2_L3_ADDR  0x000000000E4D3680ULL
> +#define STD_CDTTB_S2_L3_VAL   0x040000000E4D0743ULL
> +
> +#define STD_L3_S1_VAL         0x040000000ECBA743ULL
> +
> +#define STD_S1L0_IN_S2L3_ADDR 0x000000000E4D3688ULL
> +#define STD_S1L0_IN_S2L3_VAL  0x040000000E4D1743ULL
> +#define STD_S1L1_IN_S2L3_ADDR 0x000000000E4D3690ULL
> +#define STD_S1L1_IN_S2L3_VAL  0x040000000E4D2743ULL
> +#define STD_S1L2_IN_S2L3_ADDR 0x000000000E4D3698ULL
> +#define STD_S1L2_IN_S2L3_VAL  0x040000000E4D3743ULL
> +#define STD_S1L3_IN_S2L2_ADDR 0x000000000E4D23B0ULL
> +#define STD_S1L3_IN_S2L2_VAL  0x000000000E4D3003ULL
> +#define STD_S1L3_IN_S2L3_ADDR 0x000000000E4D35D0ULL
> +#define STD_S1L3_IN_S2L3_VAL  0x040000000ECBA7C3ULL
> +
> +/*
> + * Address-space base offsets for test tables.
> + * - Non-Secure uses a fixed offset, keeping internal layout identical.
> + *
> + * Note: Future spaces (e.g. Secure/Realm/Root) are not implemented here.
> + * When needed, introduce new offsets and reuse the helpers below so
> + * relative layout stays identical across spaces.
> + */
> +#define STD_SPACE_OFFS_NS       0x40000000ULL
> +
> +static inline uint64_t std_space_offset(SMMUTestDevSpace sp)
> +{
> +    switch (sp) {
> +    case STD_SPACE_NONSECURE:
> +        return STD_SPACE_OFFS_NS;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static const char *std_space_to_str(SMMUTestDevSpace sp)
> +{
> +    switch (sp) {
> +    case STD_SPACE_NONSECURE:
> +        return "Non-Secure";
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static const char *std_mode_to_str(uint32_t m)
> +{
> +    switch (m & 0x3) {
> +    case 0: return "S1-only";
> +    case 1: return "S2-only";
> +    case 2: return "Nested";
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +#endif /* HW_MISC_SMMU_TESTDEV_H */

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

