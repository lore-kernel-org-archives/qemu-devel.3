Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238A6E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 05:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW7V1-0002DB-Bb; Fri, 10 Jan 2025 00:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tW7Uy-0002Cw-Pg
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 00:23:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tW7Uw-0003Vo-Pd
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 00:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736486632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M6EGlMAiVUqsx4wXEDPBYJlOJYLcgNpbkdnsv4HjbpQ=;
 b=RxtX8zHHYlMe7wTBz72GguthK/4BXnmAMZWlOiUotGqIfjDfQWPuh3tjq/Z121vMZhu9po
 OEpFoX+y1rf42tzbTVJJ3V4iTK1Eqv9/UCzCMR1iH49ffBZjz0NZjyAuchN0M4RnIrTFtC
 RqmECa6qHjnCpbvs+DMBn0aT41SpySQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-cYaISfFxNSmDag81mO1Lww-1; Fri, 10 Jan 2025 00:23:50 -0500
X-MC-Unique: cYaISfFxNSmDag81mO1Lww-1
X-Mimecast-MFC-AGG-ID: cYaISfFxNSmDag81mO1Lww
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2166855029eso32752555ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 21:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736486629; x=1737091429;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6EGlMAiVUqsx4wXEDPBYJlOJYLcgNpbkdnsv4HjbpQ=;
 b=ICyK00rqO24F8qTtN37FfB0fitOPigBM6CkZ4GbWBcJqrJ9SP8j3gkzic7p9+dlKBV
 o20WvLK++OHRqjxH8krwWhGqxuZAh58CkEyNhHvOKU2AD27EApuw1DHheKc6Cpkblrnk
 5XMV/8ooEo121GgfdeZXXgp8ITx59iW1nQQQ1m4kKsOWWgr6FFB/iPHIwb7XXSEq7fX2
 QeF8xnwhCG82ignv7ArR+wLHq8NyQAD6b6S3oA4zWuEpsFj0bWKLztQOMe0oB77Y1p9z
 1loEMtJ7HN0iwFtZGyoYJRCkB6FICLlUgAzx5NPRalN3LFpgTX5CXiQoLKKJ83kV3jHx
 5PEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXoamtE+fSfu2R67qhZFCMhUxKWTg+JLZw9ISWmFn4RS53IKVvet2O2sCRlQPIW+rT8UGjt6R88S6m@nongnu.org
X-Gm-Message-State: AOJu0Yys0w26DpV5PxTt6hDo0kRZ6jojJB77RLgrwPty4PU8/o0NC0wP
 UAJWT3YemYQEZmV9onqB7R36F3NYAROKMN5uyPD7cuWAlV4+3LhlAyjEhFWPW7vJBf//0CPVR45
 q3ljMQ51UDB8pqP6/s4TKcBScujIHkQ+mPqTyeUYpHPwmmgE9jGI7
X-Gm-Gg: ASbGncsBRyLfAVAb40ZLKohU4BwEHpzTV/A2jQnaa45o7sb1Ruihst4YWsLncXBLhtw
 vxjip7pma/f+EM9OA/OiWtvzLScm7yrk40ier6AH0VYjnttVPXhvnHsJQSrA7xUZNls9alZutQ3
 /fNESrGlKO+lV/kCmMsLPfpTyKgi9jrZzwWxlIE0cFYgiNMxXt1kHJZ9AaJcZHe5nYfVlESKVNT
 L4DeoA5EZ49kugjAkmyccYJB9+5So75DmNMBNsoyqy3mkJG90elS+vpwUrUwlvsTKZFm+YIhA==
X-Received: by 2002:a17:902:c951:b0:216:5b64:90f6 with SMTP id
 d9443c01a7336-21a83fd28e4mr137232805ad.45.1736486629291; 
 Thu, 09 Jan 2025 21:23:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg3niPxrcfe+67EL6ZhBluujDHFlHpEn/RHi55lRehVswH5MW05ifYFk8Fhjx9LnOlcgWoUw==
X-Received: by 2002:a17:902:c951:b0:216:5b64:90f6 with SMTP id
 d9443c01a7336-21a83fd28e4mr137232405ad.45.1736486628894; 
 Thu, 09 Jan 2025 21:23:48 -0800 (PST)
Received: from smtpclient.apple ([116.72.129.231])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22d134sm6395135ad.187.2025.01.09.21.23.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jan 2025 21:23:48 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v4 2/2] tests/qtest/libqos: add DMA support for writing
 and reading fw_cfg files
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87ikqnenn1.fsf@suse.de>
Date: Fri, 10 Jan 2025 10:53:32 +0530
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <790B9C73-B5B0-4AB4-9132-7734248E8B4F@redhat.com>
References: <20250109074929.252339-1-anisinha@redhat.com>
 <20250109074929.252339-3-anisinha@redhat.com> <87ikqnenn1.fsf@suse.de>
To: Fabiano Rosas <farosas@suse.de>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
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



> On 10 Jan 2025, at 2:00=E2=80=AFAM, Fabiano Rosas <farosas@suse.de> =
wrote:
>=20
> Ani Sinha <anisinha@redhat.com> writes:
>=20
>> At present, the libqos/fw_cfg.c library does not support the modern =
DMA
>> interface which is required to write to the fw_cfg files. It only =
uses the IO
>> interface. Implement read and write methods based on DMA. This will =
enable
>> developers to write tests that writes to the fw_cfg file(s). The =
structure of
>> the code is taken from edk2 fw_cfg implementation. It has been tested =
by
>> writing a qtest that writes to a fw_cfg file. This test will be part =
of a
>> future patch series.
>=20
> What's the blocker for the rest of the series?

The broker is that the consumer of this api is a new qtest which is =
written to test a brand new feature. I would rather post that patchset =
separately.
A compromise is ...=20

> It would be preferable to
> merge it all together, rather than this going in first without any
> users.

In my cover letter I have pointed to the patch series that actually uses =
this api. That way those who want to check out that branch and test =
these changes can do so.

>=20
>>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> tests/qtest/libqos/fw_cfg.c | 138 =
++++++++++++++++++++++++++++++++++++
>> tests/qtest/libqos/fw_cfg.h |   6 +-
>> 2 files changed, 143 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tests/qtest/libqos/fw_cfg.c =
b/tests/qtest/libqos/fw_cfg.c
>> index f1ed4898f7..b3ae97d32d 100644
>> --- a/tests/qtest/libqos/fw_cfg.c
>> +++ b/tests/qtest/libqos/fw_cfg.c
>> @@ -14,6 +14,8 @@
>>=20
>> #include "qemu/osdep.h"
>> #include "fw_cfg.h"
>> +#include "malloc-pc.h"
>> +#include "libqos-malloc.h"
>> #include "../libqtest.h"
>> #include "qemu/bswap.h"
>> #include "hw/nvram/fw_cfg.h"
>> @@ -60,6 +62,65 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, =
uint16_t key)
>>     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
>> }
>>=20
>> +static void
>> +qfw_cfg_dma_transfer(QFWCFG *fw_cfg, QOSState *qs, void *address,
>> +                     uint32_t length, uint32_t control)
>> +{
>> +    FWCfgDmaAccess access;
>> +    uint32_t addr;
>> +    uint64_t guest_access_addr;
>> +    uint64_t gaddr;
>> +
>> +    /* create a data buffer in guest memory */
>> +    gaddr =3D guest_alloc(&qs->alloc, length);
>> +    g_assert(gaddr);
>=20
> Same here, none of these asserts are needed.

Ok will remove.

>=20
>> +
>> +    if (control & FW_CFG_DMA_CTL_WRITE) {
>> +        qtest_bufwrite(fw_cfg->qts, gaddr, address, length);
>> +    }
>> +    access.address =3D cpu_to_be64(gaddr);
>> +    access.length =3D cpu_to_be32(length);
>> +    access.control =3D cpu_to_be32(control);
>> +
>> +    /* now create a separate buffer in guest memory for 'access' */
>> +    guest_access_addr =3D guest_alloc(&qs->alloc, sizeof(access));
>> +    g_assert(guest_access_addr);
>> +    qtest_bufwrite(fw_cfg->qts, guest_access_addr, &access, =
sizeof(access));
>> +
>> +    /* write lower 32 bits of address */
>> +    addr =3D cpu_to_be32((uint32_t)(uintptr_t)guest_access_addr);
>> +    qtest_outl(fw_cfg->qts, fw_cfg->base + 8, addr);
>> +
>> +    /* write upper 32 bits of address */
>> +    addr =3D cpu_to_be32((uint32_t)(uintptr_t)(guest_access_addr >> =
32));
>> +    qtest_outl(fw_cfg->qts, fw_cfg->base + 4, addr);
>> +
>> +    g_assert(!(be32_to_cpu(access.control) & FW_CFG_DMA_CTL_ERROR));
>> +
>> +    if (control & FW_CFG_DMA_CTL_READ) {
>> +        qtest_bufread(fw_cfg->qts, gaddr, address, length);
>> +    }
>> +
>> +    guest_free(&qs->alloc, guest_access_addr);
>> +    guest_free(&qs->alloc, gaddr);
>> +}
>> +
>> +static void
>> +qfw_cfg_write_entry(QFWCFG *fw_cfg, QOSState *qs, uint16_t key,
>> +                    void *buf, uint32_t len)
>> +{
>> +    qfw_cfg_select(fw_cfg, key);
>> +    qfw_cfg_dma_transfer(fw_cfg, qs, buf, len, =
FW_CFG_DMA_CTL_WRITE);
>> +}
>> +
>> +static void
>> +qfw_cfg_read_entry(QFWCFG *fw_cfg, QOSState *qs, uint16_t key,
>> +                   void *buf, uint32_t len)
>> +{
>> +    qfw_cfg_select(fw_cfg, key);
>> +    qfw_cfg_dma_transfer(fw_cfg, qs, buf, len, FW_CFG_DMA_CTL_READ);
>> +}
>> +
>> static bool
>> find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
>>                 uint16_t *sel, uint32_t *size)
>> @@ -123,6 +184,83 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const =
char *filename,
>>     return filesize;
>> }
>>=20
>> +/*
>> + * The caller need check the return value. When the return value is
>> + * nonzero, it means that some bytes have been transferred.
>> + *
>> + * If the fw_cfg file in question is smaller than the allocated & =
passed-in
>> + * buffer, then the first len bytes were read.
>> + *
>> + * If the fw_cfg file in question is larger than the passed-in
>> + * buffer, then the return value explains how much was actually =
read.
>> + *
>> + * It is illegal to call this function if fw_cfg does not support =
DMA
>> + * interface. The caller should ensure that DMA is supported before
>> + * calling this function.
>> + *
>> + * Passed QOSState pointer qs must be initialized. qs->alloc must =
also be
>> + * properly initialized.
>> + */
>> +size_t qfw_cfg_read_file(QFWCFG *fw_cfg, QOSState *qs, const char =
*filename,
>> +                         void *data, size_t buflen)
>> +{
>> +    uint32_t len =3D 0;
>> +    uint16_t sel;
>> +    uint32_t id;
>> +
>> +    g_assert(qs);
>> +    /* check if DMA is supported since we use DMA for read */
>> +    id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
>> +    g_assert(id & FW_CFG_VERSION_DMA);
>> +
>> +    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
>> +        if (len > buflen) {
>> +            len =3D buflen;
>> +        }
>> +        qfw_cfg_read_entry(fw_cfg, qs, sel, data, len);
>> +    }
>> +
>> +    return len;
>> +}
>> +
>> +/*
>> + * The caller need check the return value. When the return value is
>> + * nonzero, it means that some bytes have been transferred.
>> + *
>> + * If the fw_cfg file in question is smaller than the allocated & =
passed-in
>> + * buffer, then the buffer has been partially written.
>> + *
>> + * If the fw_cfg file in question is larger than the passed-in
>> + * buffer, then the return value explains how much was actually =
written.
>> + *
>> + * It is illegal to call this function if fw_cfg does not support =
DMA
>> + * interface. The caller should ensure that DMA is supported before
>> + * calling this function.
>> + *
>> + * Passed QOSState pointer qs must be initialized. qs->alloc must =
also be
>> + * properly initialized.
>> + */
>> +size_t qfw_cfg_write_file(QFWCFG *fw_cfg, QOSState *qs, const char =
*filename,
>> +                          void *data, size_t buflen)
>> +{
>> +    uint32_t len =3D 0;
>> +    uint16_t sel;
>> +    uint32_t id;
>> +
>> +    g_assert(qs);
>> +    /* write operation is only valid if DMA is supported */
>> +    id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
>> +    g_assert(id & FW_CFG_VERSION_DMA);
>> +
>> +    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
>> +        if (len > buflen) {
>> +            len =3D buflen;
>> +        }
>> +        qfw_cfg_write_entry(fw_cfg, qs, sel, data, len);
>> +    }
>> +    return len;
>> +}
>> +
>> static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
>> {
>>     uint8_t *ptr =3D data;
>> diff --git a/tests/qtest/libqos/fw_cfg.h =
b/tests/qtest/libqos/fw_cfg.h
>> index b0456a15df..6d6ff09725 100644
>> --- a/tests/qtest/libqos/fw_cfg.h
>> +++ b/tests/qtest/libqos/fw_cfg.h
>> @@ -14,6 +14,7 @@
>> #define LIBQOS_FW_CFG_H
>>=20
>> #include "../libqtest.h"
>> +#include "libqos.h"
>>=20
>> typedef struct QFWCFG QFWCFG;
>>=20
>> @@ -33,7 +34,10 @@ uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t =
key);
>> uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
>> size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
>>                         void *data, size_t buflen);
>> -
>> +size_t qfw_cfg_write_file(QFWCFG *fw_cfg, QOSState *qs, const char =
*filename,
>> +                          void *data, size_t buflen);
>> +size_t qfw_cfg_read_file(QFWCFG *fw_cfg, QOSState *qs, const char =
*filename,
>> +                         void *data, size_t buflen);
>> QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
>> void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
>> QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);



