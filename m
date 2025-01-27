Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18737C0218F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 07:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcJIh-0001i6-OI; Mon, 27 Jan 2025 02:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tcJIg-0001hU-BU
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 02:12:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tcJIe-0004PP-DN
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 02:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737961965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hq51L3rd9eKAlWCyzMCotVGOcy/s0SzqCvP2SsbdX6c=;
 b=XTHLYzdy1K9Nmw5OAZBAk+xc/hFoRCDOICdlFEEp+2ZQ8PfvlmbshP/dKI9MYv3nTUftgH
 yMvOuCBBeMmj14PvVGyfDy/UuQPt4Wf8ij+dQiAtLoivB/w4BRSmUz1OY6eyERdwKuj7RJ
 8j58Vj0vUl1Nw+LjyU+HjxLczDDPUWM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669--ZSoWSygNK-jE9LeGOV4GA-1; Mon, 27 Jan 2025 02:12:43 -0500
X-MC-Unique: -ZSoWSygNK-jE9LeGOV4GA-1
X-Mimecast-MFC-AGG-ID: -ZSoWSygNK-jE9LeGOV4GA
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa68fd5393cso394700066b.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 23:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737961960; x=1738566760;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hq51L3rd9eKAlWCyzMCotVGOcy/s0SzqCvP2SsbdX6c=;
 b=IiwRotRxk0wBT9onrGaofV6kCHBxrgW0ms2eBYGi456mrfeZUqp0HSJKJjuMzVgwxk
 Gw6nQh3ulTRgKehRvKbhsZBtQvqUTIMSMKOy2T59Vq3+TSOTiPYw13JeQQBLVylQjzzS
 QmsyY9a1JEslD9kRsbXu/sFQHlV4cnI/ieI7ucRvK95IBqFzM4IoI0EzkpVR4UZw9T7s
 3o4YCGQMnb6nCxSv8eKxF31S7CpjFddyTatjULJLu1QKsh1NjsjOjh5rRWBy6e73m4ha
 4c5rnYMOyR4YqPajrgfgQL8hwkGkHi3wrxuKX+LhZIqIVeIPTcLrNIoTHNL8JYPbbnE/
 45WA==
X-Gm-Message-State: AOJu0YwioPcbZUtUqn+cAx3UTgW5rEBVRA4HA7EL0Cl2CX1TLoS1lQuZ
 7gFQ2y8Muu56xcxczv6ic79GDEQpP0tWRP24i6NlBzaAc08BHXp4d4/8UwX0huW0BJRvE00ASq7
 THNgkFRnqicCXW34HZLVAd6yiWPpNOqLuJY8TzvGgir40HI/y1mZgW4nBNFhG/JAdRvwAdBamqS
 0any41jM6q+WJbwptqJTyyTrSRS2neqW4JNBE=
X-Gm-Gg: ASbGncuvNeM0QRA1ZGF8LI7aJRkoRIhG78DAA02upTpNzpokV17+fUYwTpqAYAKy9mN
 LfPP1YhJSrRXcFQo7W6ZwfxcWGHQZS5r3ertpVpAJK7Z5TPB3ng3mKI1MJx8ENAtd
X-Received: by 2002:a17:906:f584:b0:ab3:a2f9:d977 with SMTP id
 a640c23a62f3a-ab67466fca8mr891616066b.22.1737961960353; 
 Sun, 26 Jan 2025 23:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9IzPqadH1q88GiTNv2eLNgk3GPl+UcLXUhpxeXMdvdRWKBaRLBNTYC4urTVyyIW2htKmr+9WIAaAfcW1atiA=
X-Received: by 2002:a17:906:f584:b0:ab3:a2f9:d977 with SMTP id
 a640c23a62f3a-ab67466fca8mr891615166b.22.1737961959978; Sun, 26 Jan 2025
 23:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20250120043847.954881-1-anisinha@redhat.com>
 <20250120043847.954881-3-anisinha@redhat.com>
In-Reply-To: <20250120043847.954881-3-anisinha@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 27 Jan 2025 12:42:28 +0530
X-Gm-Features: AWEUYZmP37_jZNd3hh89fiIrtN6IkwMyDByrgfZGjDqgaeGCRQp9HyyfJXn_9bI
Message-ID: <CAK3XEhPQjHA5e2EtGg9m5b-gxB1H0_hgcq-xFe2=PExUEdSwZA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] tests/qtest/libqos: add DMA support for writing
 and reading fw_cfg files
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 20, 2025 at 10:09=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wr=
ote:
>
> At present, the libqos/fw_cfg.c library does not support the modern DMA
> interface which is required to write to the fw_cfg files. It only uses th=
e IO
> interface. Implement read and write methods based on DMA. This will enabl=
e
> developers to add tests that writes to the fw_cfg file(s). The structure =
of
> the code is taken from edk2 fw_cfg implementation. It has been tested by
> writing a qtest that writes to a fw_cfg file.
>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Final ping on this patch series ...

> ---
>  tests/qtest/libqos/fw_cfg.c | 139 ++++++++++++++++++++++++++++++++++++
>  tests/qtest/libqos/fw_cfg.h |   6 +-
>  2 files changed, 144 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
> index 22435873d9..0ab3959171 100644
> --- a/tests/qtest/libqos/fw_cfg.c
> +++ b/tests/qtest/libqos/fw_cfg.c
> @@ -14,6 +14,8 @@
>
>  #include "qemu/osdep.h"
>  #include "fw_cfg.h"
> +#include "malloc-pc.h"
> +#include "libqos-malloc.h"
>  #include "../libqtest.h"
>  #include "qemu/bswap.h"
>  #include "hw/nvram/fw_cfg.h"
> @@ -60,6 +62,60 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t =
key)
>      qtest_writew(fw_cfg->qts, fw_cfg->base, key);
>  }
>
> +static void qfw_cfg_dma_transfer(QFWCFG *fw_cfg, QOSState *qs, void *add=
ress,
> +                                 uint32_t length, uint32_t control)
> +{
> +    FWCfgDmaAccess access;
> +    uint32_t addr;
> +    uint64_t guest_access_addr;
> +    uint64_t gaddr;
> +
> +    /* create a data buffer in guest memory */
> +    gaddr =3D guest_alloc(&qs->alloc, length);
> +
> +    if (control & FW_CFG_DMA_CTL_WRITE) {
> +        qtest_bufwrite(fw_cfg->qts, gaddr, address, length);
> +    }
> +    access.address =3D cpu_to_be64(gaddr);
> +    access.length =3D cpu_to_be32(length);
> +    access.control =3D cpu_to_be32(control);
> +
> +    /* now create a separate buffer in guest memory for 'access' */
> +    guest_access_addr =3D guest_alloc(&qs->alloc, sizeof(access));
> +    qtest_bufwrite(fw_cfg->qts, guest_access_addr, &access, sizeof(acces=
s));
> +
> +    /* write lower 32 bits of address */
> +    addr =3D cpu_to_be32((uint32_t)(uintptr_t)guest_access_addr);
> +    qtest_outl(fw_cfg->qts, fw_cfg->base + 8, addr);
> +
> +    /* write upper 32 bits of address */
> +    addr =3D cpu_to_be32((uint32_t)(uintptr_t)(guest_access_addr >> 32))=
;
> +    qtest_outl(fw_cfg->qts, fw_cfg->base + 4, addr);
> +
> +    g_assert(!(be32_to_cpu(access.control) & FW_CFG_DMA_CTL_ERROR));
> +
> +    if (control & FW_CFG_DMA_CTL_READ) {
> +        qtest_bufread(fw_cfg->qts, gaddr, address, length);
> +    }
> +
> +    guest_free(&qs->alloc, guest_access_addr);
> +    guest_free(&qs->alloc, gaddr);
> +}
> +
> +static void qfw_cfg_write_entry(QFWCFG *fw_cfg, QOSState *qs, uint16_t k=
ey,
> +                                void *buf, uint32_t len)
> +{
> +    qfw_cfg_select(fw_cfg, key);
> +    qfw_cfg_dma_transfer(fw_cfg, qs, buf, len, FW_CFG_DMA_CTL_WRITE);
> +}
> +
> +static void qfw_cfg_read_entry(QFWCFG *fw_cfg, QOSState *qs, uint16_t ke=
y,
> +                               void *buf, uint32_t len)
> +{
> +    qfw_cfg_select(fw_cfg, key);
> +    qfw_cfg_dma_transfer(fw_cfg, qs, buf, len, FW_CFG_DMA_CTL_READ);
> +}
> +
>  static bool find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
>                              uint16_t *sel, uint32_t *size)
>  {
> @@ -121,6 +177,89 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *=
filename,
>      return filesize;
>  }
>
> +/*
> + * The caller need check the return value. When the return value is
> + * nonzero, it means that some bytes have been transferred.
> + *
> + * If the fw_cfg file in question is smaller than the allocated & passed=
-in
> + * buffer, then the first len bytes were read.
> + *
> + * If the fw_cfg file in question is larger than the passed-in
> + * buffer, then the return value explains how much was actually read.
> + *
> + * It is illegal to call this function if fw_cfg does not support DMA
> + * interface. The caller should ensure that DMA is supported before
> + * calling this function.
> + *
> + * Passed QOSState pointer qs must be initialized. qs->alloc must also b=
e
> + * properly initialized.
> + */
> +size_t qfw_cfg_read_file(QFWCFG *fw_cfg, QOSState *qs, const char *filen=
ame,
> +                         void *data, size_t buflen)
> +{
> +    uint32_t len =3D 0;
> +    uint16_t sel;
> +    uint32_t id;
> +
> +    g_assert(qs);
> +    g_assert(filename);
> +    g_assert(data);
> +    g_assert(buflen);
> +    /* check if DMA is supported since we use DMA for read */
> +    id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
> +    g_assert(id & FW_CFG_VERSION_DMA);
> +
> +    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
> +        if (len > buflen) {
> +            len =3D buflen;
> +        }
> +        qfw_cfg_read_entry(fw_cfg, qs, sel, data, len);
> +    }
> +
> +    return len;
> +}
> +
> +/*
> + * The caller need check the return value. When the return value is
> + * nonzero, it means that some bytes have been transferred.
> + *
> + * If the fw_cfg file in question is smaller than the allocated & passed=
-in
> + * buffer, then the buffer has been partially written.
> + *
> + * If the fw_cfg file in question is larger than the passed-in
> + * buffer, then the return value explains how much was actually written.
> + *
> + * It is illegal to call this function if fw_cfg does not support DMA
> + * interface. The caller should ensure that DMA is supported before
> + * calling this function.
> + *
> + * Passed QOSState pointer qs must be initialized. qs->alloc must also b=
e
> + * properly initialized.
> + */
> +size_t qfw_cfg_write_file(QFWCFG *fw_cfg, QOSState *qs, const char *file=
name,
> +                          void *data, size_t buflen)
> +{
> +    uint32_t len =3D 0;
> +    uint16_t sel;
> +    uint32_t id;
> +
> +    g_assert(qs);
> +    g_assert(filename);
> +    g_assert(data);
> +    g_assert(buflen);
> +    /* write operation is only valid if DMA is supported */
> +    id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
> +    g_assert(id & FW_CFG_VERSION_DMA);
> +
> +    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
> +        if (len > buflen) {
> +            len =3D buflen;
> +        }
> +        qfw_cfg_write_entry(fw_cfg, qs, sel, data, len);
> +    }
> +    return len;
> +}
> +
>  static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
>  {
>      uint8_t *ptr =3D data;
> diff --git a/tests/qtest/libqos/fw_cfg.h b/tests/qtest/libqos/fw_cfg.h
> index b0456a15df..6d6ff09725 100644
> --- a/tests/qtest/libqos/fw_cfg.h
> +++ b/tests/qtest/libqos/fw_cfg.h
> @@ -14,6 +14,7 @@
>  #define LIBQOS_FW_CFG_H
>
>  #include "../libqtest.h"
> +#include "libqos.h"
>
>  typedef struct QFWCFG QFWCFG;
>
> @@ -33,7 +34,10 @@ uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key)=
;
>  uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
>  size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
>                          void *data, size_t buflen);
> -
> +size_t qfw_cfg_write_file(QFWCFG *fw_cfg, QOSState *qs, const char *file=
name,
> +                          void *data, size_t buflen);
> +size_t qfw_cfg_read_file(QFWCFG *fw_cfg, QOSState *qs, const char *filen=
ame,
> +                         void *data, size_t buflen);
>  QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
>  void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
>  QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
> --
> 2.45.2
>


