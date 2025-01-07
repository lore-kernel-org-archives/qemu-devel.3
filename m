Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825EFE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCFv-00057t-Tb; Tue, 07 Jan 2025 11:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tVCFh-0004zd-Gb
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:16:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tVCFe-0001zP-QP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736266577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZHR4jRh6F/lBIKYBO8qd+nqCY/Z/cW22ly0OdZy9sY=;
 b=ThFJcH+go9lE1dCHqHnRRdCBTW93mS0yLymNq/hSEiFRJE93IZzAkUvzI0apWqpn2LUSOQ
 xwKgtRRCFCFKnnhiiufIqKccQKDaorZv4LSwEyxKcDq61+jqGRwETrGPRNGphEolP4ZgME
 zCNShpoDRykJXU40rM5tF0D0ZzWtsrw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-VfK30XtoPoGYyS6olmx08A-1; Tue, 07 Jan 2025 11:16:16 -0500
X-MC-Unique: VfK30XtoPoGYyS6olmx08A-1
X-Mimecast-MFC-AGG-ID: VfK30XtoPoGYyS6olmx08A
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ef35de8901so22321237a91.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736266575; x=1736871375;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZHR4jRh6F/lBIKYBO8qd+nqCY/Z/cW22ly0OdZy9sY=;
 b=WIVcP/teiy4UdrleIuZ5Z8vatGMRRe85XUpJX/k4K72aDGfQSCyY75JHpslc7Yd7pG
 tbr6XVLieQBbdU4tp+wcol7bRfRozcXJcDeTR08VbJ168tz+bbJGjQuMSJBIO9YH4s++
 DHqCwiT/Bhlyj+3GAT9tIhdmN4VRBp1CZWvHQjct7a2/8OThnv/lYOMg3Yoe8gUkBiHw
 Kc+4nDKa/2JjVJSR5NR7US5/lr2QirPPJ6wYGrp2ypmTR9FQA01OOaHzFteBT5FPp9lx
 UhV7hr2UMQMSKvYZwqCaxmUKG2jmtZwRmCFBTy6AkRe5unZOMDJMZYynxcr0nLSo36pz
 cZEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRTVzIsjpH+jMXYillkBYP9bTpRj9Ey7bCprUeeelrwWRtO2kJI7EGHeNhiSTvUXdNRqWzQ6JI36cq@nongnu.org
X-Gm-Message-State: AOJu0YyjH6pPt5Xbhq8P6BPGyE94pRi97n2zw1KIi/n8Rlg6pHPPzxez
 JIha8FGqqDO4S+McBWyZQwHVbJqSh37KsZv3uUvpflHcGyG9WQHzml4wdT4fRvpQog3yCoWxyTF
 HYCsA+QEh0/EbJfSWFGdwM+oivpsCP0wXjgR0EhP2Lo3QFprNMg27
X-Gm-Gg: ASbGncsrWUXYdGTjJC1eqJfP/sW1LdBrTVCoRW/ejspL9zc7JhXSWU+AV0Xk8rT4dVP
 g41EdhfNtbyc2V64CZCCeqcev50mXMPC5JPwzykO+gEVerD6dDWYKcsteIpUD6RQi8pMeg2AU7m
 E0uvKs3Q7NdRPXwU0A9GZPA3zeaP8tQY5wJvbvH1yRgRB0iXmizcixCGT67Y+fhX6cbeg5YS08T
 ijUQeeedH72pLpTbW2c6OaUPuUHrxe43Wpo+dF2id8/Z4Lvl/fDvgqqt8mgZP5NPVTFrQPOIg==
X-Received: by 2002:a17:90b:1f91:b0:2ee:d63f:d8f with SMTP id
 98e67ed59e1d1-2f452e225a9mr87869530a91.13.1736266575046; 
 Tue, 07 Jan 2025 08:16:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFo5odT4CAHca8HvQpGdh27pII4pyO43aJW+nta4uE4qHnyyMTAR9ZLJI0qgYW4OwIY/JPRKQ==
X-Received: by 2002:a17:90b:1f91:b0:2ee:d63f:d8f with SMTP id
 98e67ed59e1d1-2f452e225a9mr87869498a91.13.1736266574628; 
 Tue, 07 Jan 2025 08:16:14 -0800 (PST)
Received: from smtpclient.apple ([115.96.125.221])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f447882d11sm36306377a91.39.2025.01.07.08.16.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jan 2025 08:16:13 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2] tests/qtest/libqos: add DMA support for writing and
 reading fw_cfg files
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20250107145138.157696-1-anisinha@redhat.com>
Date: Tue, 7 Jan 2025 21:45:58 +0530
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <828A6271-D16C-4BF3-A434-82D85495738A@redhat.com>
References: <20250107145138.157696-1-anisinha@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 7 Jan 2025, at 8:21=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> At present, the libqos/fw_cfg.c library does not support the modern =
DMA
> interface which is required to write to the fw_cfg files. It only uses =
the IO
> interface. Implement read and write methods based on DMA. This will =
enable
> developers to write tests that writes to the fw_cfg file(s). The =
structure of
> the code is taken from edk2 fw_cfg implementation. It has been tested =
by
> writing a qtest that writes to a fw_cfg file. This test will be part =
of a
> future patch series.
>=20
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Please disregard this patch for now. I was under the false impression =
that this was working. More testing revealed that there might still be =
some issues with this patch. Apologies for this.

> ---
> tests/qtest/libqos/fw_cfg.c | 191 +++++++++++++++++++++++++++++++-----
> tests/qtest/libqos/fw_cfg.h |   4 +
> 2 files changed, 172 insertions(+), 23 deletions(-)
>=20
> changelog:
> v2: refactor common code into a helper.
>=20
> diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
> index 89f053ccac..ac4c6b73e5 100644
> --- a/tests/qtest/libqos/fw_cfg.c
> +++ b/tests/qtest/libqos/fw_cfg.c
> @@ -17,6 +17,8 @@
> #include "../libqtest.h"
> #include "qemu/bswap.h"
> #include "hw/nvram/fw_cfg.h"
> +#include "malloc-pc.h"
> +#include "libqos-malloc.h"
>=20
> void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
> {
> @@ -60,6 +62,94 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, =
uint16_t key)
>     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
> }
>=20
> +static void
> +qfw_cfg_dma_transfer(QFWCFG *fw_cfg, void *address, uint32_t length,
> +                     uint32_t control)
> +{
> +    FWCfgDmaAccess access;
> +    uint32_t addr;
> +    QGuestAllocator guest_malloc;
> +    uint64_t guest_access_addr;
> +    uint64_t gaddr;
> +
> +    pc_alloc_init(&guest_malloc, fw_cfg->qts, ALLOC_NO_FLAGS);
> +
> +    /* create a data buffer in guest memory */
> +    gaddr =3D guest_alloc(&guest_malloc, length);
> +    g_assert(gaddr);
> +    qtest_bufwrite(fw_cfg->qts, gaddr, address, length);
> +
> +    access.address =3D cpu_to_be64(gaddr);
> +    access.length =3D cpu_to_be32(length);
> +    access.control =3D cpu_to_be32(control);
> +
> +    /* now create a separate buffer in guest memory for 'access' */
> +    guest_access_addr =3D guest_alloc(&guest_malloc, sizeof(access));
> +    g_assert(guest_access_addr);
> +    qtest_bufwrite(fw_cfg->qts, guest_access_addr, &access, =
sizeof(access));
> +
> +    /* write lower 32 bits of address */
> +    addr =3D cpu_to_be32((uint32_t)(uintptr_t)guest_access_addr);
> +    qtest_outl(fw_cfg->qts, fw_cfg->base + 8, addr);
> +
> +    /* write upper 32 bits of address */
> +    addr =3D cpu_to_be32((uint32_t)(uintptr_t)(guest_access_addr >> =
32));
> +    qtest_outl(fw_cfg->qts, fw_cfg->base + 4, addr);
> +
> +    g_assert(!(be32_to_cpu(access.control) & FW_CFG_DMA_CTL_ERROR));
> +
> +    guest_free(&guest_malloc, guest_access_addr);
> +    guest_free(&guest_malloc, gaddr);
> +    alloc_destroy(&guest_malloc);
> +}
> +
> +static void
> +qfw_cfg_write_entry(QFWCFG *fw_cfg, uint16_t key, void *buf, uint32_t =
len)
> +{
> +    qfw_cfg_select(fw_cfg, key);
> +    qfw_cfg_dma_transfer(fw_cfg, buf, len, FW_CFG_DMA_CTL_WRITE);
> +}
> +
> +static void
> +qfw_cfg_read_entry(QFWCFG *fw_cfg, uint16_t key, void *buf, uint32_t =
len)
> +{
> +    qfw_cfg_select(fw_cfg, key);
> +    qfw_cfg_dma_transfer(fw_cfg, buf, len, FW_CFG_DMA_CTL_READ);
> +}
> +
> +static bool find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
> +                            uint16_t *sel, uint32_t *size)
> +{
> +    unsigned char *filesbuf =3D NULL;
> +    uint32_t count;
> +    size_t dsize;
> +    FWCfgFile *pdir_entry;
> +    uint32_t i;
> +    bool found =3D false;
> +
> +    *size =3D 0;
> +    *sel =3D 0;
> +
> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
> +    count =3D be32_to_cpu(count);
> +    dsize =3D sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
> +    filesbuf =3D g_malloc(dsize);
> +    g_assert(filesbuf);
> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
> +    pdir_entry =3D (FWCfgFile *)(filesbuf + sizeof(uint32_t));
> +    for (i =3D 0; i < count; ++i, ++pdir_entry) {
> +        if (!strcmp(pdir_entry->name, filename)) {
> +            *size =3D be32_to_cpu(pdir_entry->size);
> +            *sel =3D be16_to_cpu(pdir_entry->select);
> +            found =3D true;
> +            break;
> +        }
> +    }
> +
> +    g_free(filesbuf);
> +    return found;
> +}
> +
> /*
>  * The caller need check the return value. When the return value is
>  * nonzero, it means that some bytes have been transferred.
> @@ -73,37 +163,92 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, =
uint16_t key)
>  * populated, it has received only a starting slice of the fw_cfg =
file.
>  */
> size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
> -                      void *data, size_t buflen)
> +                        void *data, size_t buflen)
> {
> -    uint32_t count;
> -    uint32_t i;
> -    unsigned char *filesbuf =3D NULL;
> -    size_t dsize;
> -    FWCfgFile *pdir_entry;
>     size_t filesize =3D 0;
> +    uint32_t len;
> +    uint16_t sel;
>=20
> -    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
> -    count =3D be32_to_cpu(count);
> -    dsize =3D sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
> -    filesbuf =3D g_malloc(dsize);
> -    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
> -    pdir_entry =3D (FWCfgFile *)(filesbuf + sizeof(uint32_t));
> -    for (i =3D 0; i < count; ++i, ++pdir_entry) {
> -        if (!strcmp(pdir_entry->name, filename)) {
> -            uint32_t len =3D be32_to_cpu(pdir_entry->size);
> -            uint16_t sel =3D be16_to_cpu(pdir_entry->select);
> -            filesize =3D len;
> -            if (len > buflen) {
> -                len =3D buflen;
> -            }
> -            qfw_cfg_get(fw_cfg, sel, data, len);
> -            break;
> +    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
> +        filesize =3D len;
> +        if (len > buflen) {
> +            len =3D buflen;
>         }
> +        qfw_cfg_get(fw_cfg, sel, data, len);
>     }
> -    g_free(filesbuf);
> +
>     return filesize;
> }
>=20
> +/*
> + * The caller need check the return value. When the return value is
> + * nonzero, it means that some bytes have been transferred.
> + *
> + * If the fw_cfg file in question is smaller than the allocated & =
passed-in
> + * buffer, then the first len bytes were read.
> + *
> + * If the fw_cfg file in question is larger than the passed-in
> + * buffer, then the return value explains how much was actually read.
> + *
> + * It is illegal to call this function if fw_cfg does not support DMA
> + * interface. The caller should ensure that DMA is supported before
> + * calling this function.
> + */
> +size_t qfw_cfg_read_file(QFWCFG *fw_cfg, const char *filename,
> +                         void *data, size_t buflen)
> +{
> +    uint32_t len =3D 0;
> +    uint16_t sel;
> +    uint32_t id;
> +
> +    /* check if DMA is supported since we use DMA for read */
> +    id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
> +    g_assert(id & FW_CFG_VERSION_DMA);
> +
> +    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
> +        if (len > buflen) {
> +            len =3D buflen;
> +        }
> +        qfw_cfg_read_entry(fw_cfg, sel, data, len);
> +    }
> +
> +    return (size_t) len;
> +}
> +
> +/*
> + * The caller need check the return value. When the return value is
> + * nonzero, it means that some bytes have been transferred.
> + *
> + * If the fw_cfg file in question is smaller than the allocated & =
passed-in
> + * buffer, then the buffer has been partially written.
> + *
> + * If the fw_cfg file in question is larger than the passed-in
> + * buffer, then the return value explains how much was actually =
written.
> + *
> + * It is illegal to call this function if fw_cfg does not support DMA
> + * interface. The caller should ensure that DMA is supported before
> + * calling this function.
> + */
> +size_t qfw_cfg_write_file(QFWCFG *fw_cfg, const char *filename,
> +                          void *data, size_t buflen)
> +{
> +    uint32_t len =3D 0;
> +    uint16_t sel;
> +    uint32_t id;
> +
> +    /* write operation is only valid if DMA is supported */
> +    id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
> +    g_assert(id & FW_CFG_VERSION_DMA);
> +
> +    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
> +        if (len > buflen) {
> +            len =3D buflen;
> +        }
> +        qfw_cfg_write_entry(fw_cfg, sel, data, len);
> +    }
> +    return (size_t) len;
> +}
> +
> static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
> {
>     uint8_t *ptr =3D data;
> diff --git a/tests/qtest/libqos/fw_cfg.h b/tests/qtest/libqos/fw_cfg.h
> index b0456a15df..62221a9500 100644
> --- a/tests/qtest/libqos/fw_cfg.h
> +++ b/tests/qtest/libqos/fw_cfg.h
> @@ -33,6 +33,10 @@ uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t =
key);
> uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
> size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
>                         void *data, size_t buflen);
> +size_t qfw_cfg_write_file(QFWCFG *fw_cfg, const char *filename,
> +                          void *data, size_t buflen);
> +size_t qfw_cfg_read_file(QFWCFG *fw_cfg, const char *filename,
> +                         void *data, size_t buflen);
>=20
> QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
> void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
> --=20
> 2.45.2
>=20


