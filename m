Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF211C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 12:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYOev-00069X-F8; Thu, 16 Jan 2025 07:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tYOet-00069D-Nq
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:07:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tYOer-0004qQ-L3
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737029252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Irmt0F4o1E7z/BpnG+Ry//F+o0sHD9WqDVz9BgHNXKs=;
 b=ADFwtO7clQBeJEi1lQbZMxXQShWYSgqevDbs+xtkUNngnVQeGbYVzRmqjkOPGvPvNzSJRd
 mwrdcxgjjO3iTNYQUVCUfIpgVBUT2FX4kUoIXfmQFB+XKzFzC9MVTKxL2eZe5leunC1ss+
 g+UyuSwK2SIbWMIsGwYoLJrMMD6Q1a8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-w_dCb1ymPOijYj2ZRhUfWw-1; Thu, 16 Jan 2025 07:07:30 -0500
X-MC-Unique: w_dCb1ymPOijYj2ZRhUfWw-1
X-Mimecast-MFC-AGG-ID: w_dCb1ymPOijYj2ZRhUfWw
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa68203d288so70857466b.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 04:07:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737029250; x=1737634050;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Irmt0F4o1E7z/BpnG+Ry//F+o0sHD9WqDVz9BgHNXKs=;
 b=DJBqsaZ6fDMeMTHrkYfmsEEj99p/oKRdhQYgfj11wMiLLyXL9cfkcPJBj702F4/NKP
 3svkikS++0rAS7Lti2LGM14aN71eHjComNAHFYTThv4yZNaXgovPRey2RWoF4sFlTAVz
 jK9yV+Ki6C7CZ7ppZPimfvqAUbHdsROUPD1pUcM3DwGinUTG/z4uJugOrwJe/dBktBaL
 F3I9atKkK9WsHsfvbHCUyVwDC0wgqqfIjP9ufLb1SK92sZp8zOu7sMoYYVLKoumHukFi
 C+DDpHWBaH9BV5h50Mj9dRXWD8lCNTIiDzgIgF1O4diIb9YZ1VW3HsaTzKbnepPbEY8q
 JdMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOle2p23pRmQ4TO8B+H5vUYaBw9qELCKImoBmUXveeh+X8TDG82lrgsV9qQDdd4MYSplrbet7EeSkw@nongnu.org
X-Gm-Message-State: AOJu0YyBGxF7HCrd90k6LrTiW8IgeXKY+RNiorQcCZAGscbjbjX+CqA3
 rRGTOR0kAqibK0jra3HMQ8tWep7kL3ny2SoHZbvTjb6QgO0Wb3ASpeDXOhqNupV5zSjVIopJjCp
 xIS6k+GWeorV9tAOvI+YW3tFVA01Scmy2O3XYAtUWX+dGvwYdgFAQkWyP8ZuqqUSkaijI+eK9qD
 ozpYR+pu8+MhStLcKJIY8Js+7QgHY=
X-Gm-Gg: ASbGncvVAfhWNuZagWhNqn/5fINYGy0D+xUue9/930uY2x7LVee7cn4WbfCfrZqU0Nt
 q6xPbrp1f+AoDE3nHdzRkCQHLaIUFp2SYjqWtZgg=
X-Received: by 2002:a17:907:1c8c:b0:aa6:7cf3:c6ef with SMTP id
 a640c23a62f3a-ab2ab70a362mr2966136466b.15.1737029249532; 
 Thu, 16 Jan 2025 04:07:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIeRqGVbguA6VQWAM54RWj/y3G0WaxE/LU8M0u/Kov4Cff70pSoMVyXOG8MIx+46DCjwUCC+epJ1czHO4CaCc=
X-Received: by 2002:a17:907:1c8c:b0:aa6:7cf3:c6ef with SMTP id
 a640c23a62f3a-ab2ab70a362mr2966132166b.15.1737029248989; Thu, 16 Jan 2025
 04:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20250110104619.267564-1-anisinha@redhat.com>
 <20250110104619.267564-3-anisinha@redhat.com>
In-Reply-To: <20250110104619.267564-3-anisinha@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 16 Jan 2025 17:37:17 +0530
X-Gm-Features: AbW1kvaLAw1Hnq7Sndd8BYCNDunZ_jeWr644HfItb6aOSSjG9L7qv2MohK0qg-w
Message-ID: <CAK3XEhOgmm_+67Sk8vum9td7+xju++wfVKcBgK76n2iQLCQb0A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] tests/qtest/libqos: add DMA support for writing
 and reading fw_cfg files
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: armbru@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Jan 10, 2025 at 4:16=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
>
> At present, the libqos/fw_cfg.c library does not support the modern DMA
> interface which is required to write to the fw_cfg files. It only uses th=
e IO
> interface. Implement read and write methods based on DMA. This will enabl=
e
> developers to write tests that writes to the fw_cfg file(s). The structur=
e of
> the code is taken from edk2 fw_cfg implementation. It has been tested by
> writing a qtest that writes to a fw_cfg file. This test will be part of a
> future patch series.

Ping ...

>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/libqos/fw_cfg.c | 142 ++++++++++++++++++++++++++++++++++++
>  tests/qtest/libqos/fw_cfg.h |   6 +-
>  2 files changed, 147 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
> index b178d0b1b8..7c86f0fecf 100644
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
> @@ -60,6 +62,63 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t =
key)
>      qtest_writew(fw_cfg->qts, fw_cfg->base, key);
>  }
>
> +static void
> +qfw_cfg_dma_transfer(QFWCFG *fw_cfg, QOSState *qs, void *address,
> +                     uint32_t length, uint32_t control)
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
> +static void
> +qfw_cfg_write_entry(QFWCFG *fw_cfg, QOSState *qs, uint16_t key,
> +                    void *buf, uint32_t len)
> +{
> +    qfw_cfg_select(fw_cfg, key);
> +    qfw_cfg_dma_transfer(fw_cfg, qs, buf, len, FW_CFG_DMA_CTL_WRITE);
> +}
> +
> +static void
> +qfw_cfg_read_entry(QFWCFG *fw_cfg, QOSState *qs, uint16_t key,
> +                   void *buf, uint32_t len)
> +{
> +    qfw_cfg_select(fw_cfg, key);
> +    qfw_cfg_dma_transfer(fw_cfg, qs, buf, len, FW_CFG_DMA_CTL_READ);
> +}
> +
>  static bool
>  find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
>                  uint16_t *sel, uint32_t *size)
> @@ -122,6 +181,89 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *=
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


