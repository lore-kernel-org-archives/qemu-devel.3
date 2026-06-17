Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05224CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZuNY-0003oi-HE; Wed, 17 Jun 2026 13:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <valium7171@gmail.com>)
 id 1wZuNT-0003o9-Vm
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:48:40 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <valium7171@gmail.com>)
 id 1wZuNR-0008FT-UP
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:48:39 -0400
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-36b8d414666so3757636a91.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781718516; x=1782323316; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NMF/OoF6fBI7za8JTW/EHaXghj3hC5UwNWhq9oXKKo=;
 b=Sj7NIDralVjz+8Mt0PsjE8Y9i9WS2Jt2xkfydZEnUufmbVvRTEBLHnrSnh2vTuL0pE
 57J1c/YJ588R+Ndgp5gc1EAbNt6sFkouyMBbtoh0WpEbJhJ545rRQEpDtbt+nFCYOaTV
 HchYzFaLV2bNgA9X5CNobGk1MxX/Mrmx0o7rVyCUHadJUQ2zgM5aXwJFFoplUHLsTAs0
 0DO8e83Uf6hmKvSGsXR5YaKKDPABhu1CaUyD2qI10ZjB0L9wjmQxs7YTF2qjEKKoKGUg
 9NMR4PcF7D4/B/4KrcrKmWWVEa0TB5UzMH7NwnRpP75IrbhoQSkCYqWlAmKTOqyAXn2f
 h9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781718516; x=1782323316;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8NMF/OoF6fBI7za8JTW/EHaXghj3hC5UwNWhq9oXKKo=;
 b=JCuZt/e3xhHrdex6ZlBDxqBM0nh0ycGadf9EoT7T7E7RUgb8jiJ+IPGV4IgcYFcnn1
 zOwWvBFXdr3z0XdUld76y/JXuLSS4GbPWK+jbPdXHRwniEZoeKQC9I7zWcipmSj+LtOC
 9iJ9LjuUwya/ID+A7gYdLpmW78D0r9Y4A3MymoyqhiWiorVejwfm5QODfI28TyNcILbC
 4K4/vOK1NdXnAEoS9pWnrQKIBEqTHQOunjm59VQXU1fI73dDUqzY/6mEYRx3JcgvIICU
 f+RCtg+3PbcTULXhfyA2r373RODwOg/cxWD9eJ2dg24ngZU/V26SHclRI+8cEjge6u1a
 WZxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ946c/xx4VPrOK6/gCAOxt/pFDHQZzMoh9qPeeL+5t/zl8g4nACD+pvu3Bh1yh6M7Lrnoc/ZT1MPwbq@nongnu.org
X-Gm-Message-State: AOJu0Yy1ywxkmMmnobj0ha+nlpYEfZqY4tn0dwp32pUPgvrA3EI26CMw
 1p2YW0rJZc6gVt3+EdmEz7STT1iQkBcjQ145bLVAZSirn03PIEk1dpwI
X-Gm-Gg: AfdE7clXVcisezn5Xcy9Lazuo/5dZe3f341WXgI1W9BUm+aOjCGENdaesmTjysGs0zj
 dqqfeWCxHKuzVM63ZIKTL2o8/OyszSpBeybN5r+wocXWSxV0x0groU+7RK03fUusm1DbGJfnapX
 DBtAVjJTwyIMhm7Cu5CUGkzynH3u2TblFPPr512r7ohC5nWA+Il+kj3X8GaFzf0czknHIqHmbi1
 X9GMwPDGPmXNWJaGTq9fpxmfNGvd9X5A82DLXZgOwpS0OeVOlZve9N7fZF+hNTybq5O/0A9Yun7
 VrRop86XBYX+YU2iwpyM+EDJ279iMvLFXt9zT1Gkwj5VneEkAH+Spk6jB2iD85An2cBPcuKrAFD
 SBMLL0hfyNseSgBc2SPLZyDqRJ/vlQUULtaZHjAEilXRgRWGq+0Q4KXxx34gtNQ/Z8L/mCW4mtR
 og1WdT985fAmpE0Q==
X-Received: by 2002:a17:90b:224a:b0:36a:d6dd:9fee with SMTP id
 98e67ed59e1d1-37c9392a7bfmr4843214a91.12.1781718516279; 
 Wed, 17 Jun 2026 10:48:36 -0700 (PDT)
Received: from localhost ([157.49.125.56]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c5df3588dsm4956481a91.8.2026.06.17.10.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 10:48:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 23:18:21 +0530
Message-Id: <DJBIHVW6VRRY.3DGG8P9IB8SKL@gmail.com>
Cc: <laurent@vivier.eu>, <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] linux-user: Fix AT_PHDR when program headers are
 relocated into their own segment
From: "valium" <valium7171@gmail.com>
To: "Helge Deller" <deller@gmx.de>, "valium" <valium7171@gmail.com>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.21.0
References: <20260613152156.41147-1-valium7171@gmail.com>
 <7d65e071-ca12-4d48-88df-9ff08c70fa75@gmx.de>
 <DJBBZ2BGKC09.1PYR052VO8LCK@gmail.com>
 <b68ba255-8f8c-4c46-8090-5a7c73b4b46f@gmx.de>
In-Reply-To: <b68ba255-8f8c-4c46-8090-5a7c73b4b46f@gmx.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=valium7171@gmail.com; helo=mail-pj1-x1043.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed Jun 17, 2026 at 10:18 PM IST, Helge Deller wrote:
> It's sufficient if you let us know what it should be.

My real name is Akshit Yadav.
>>=20
>>>> ---
>>>>    linux-user/elfload.c | 21 ++++++++++++++++++++-
>>>>    linux-user/qemu.h    |  1 +
>>>>    2 files changed, 21 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>>>> index b05b8b0..8049c8a 100644
>>>> --- a/linux-user/elfload.c
>>>> +++ b/linux-user/elfload.c
>>>> @@ -699,7 +699,7 @@ static abi_ulong create_elf_tables(abi_ulong p, in=
t argc, int envc,
>>>>        /* There must be exactly DLINFO_ITEMS entries here, or the asse=
rt
>>>>         * on info->auxv_len will trigger.
>>>>         */
>>>> -    NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff)=
);
>>>> +    NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->phdr_addr));
>>>>        NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
>>>>        NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
>>>>        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
>>>> @@ -1469,6 +1469,12 @@ static void load_elf_image(const char *image_na=
me, const ImageSource *src,
>>>>        info->data_offset =3D load_bias;
>>>>        info->load_addr =3D load_addr;
>>>>        info->entry =3D ehdr->e_entry + load_bias;
>>>> +    /*
>>>> +     * Fallback for AT_PHDR if the program headers do not fall within
>>>> +     * any PT_LOAD segment (see the loop below, which overrides this =
with
>>>> +     * the correct in-memory address when a containing segment is fou=
nd).
>>>> +     */
>>>> +    info->phdr_addr =3D load_addr + ehdr->e_phoff;
>>>>        info->start_code =3D -1;
>>>>        info->end_code =3D 0;
>>>>        info->start_data =3D -1;
>>>> @@ -1523,6 +1529,19 @@ static void load_elf_image(const char *image_na=
me, const ImageSource *src,
>>>>                vaddr_ef =3D vaddr + eppnt->p_filesz;
>>>>                vaddr_em =3D vaddr + eppnt->p_memsz;
>>>>   =20
>>>> +            /*
>>>> +             * If this segment contains the program headers, record t=
heir
>>>> +             * in-memory address for AT_PHDR. This matches the kernel=
, which
>>>> +             * locates the headers via the containing PT_LOAD rather =
than
>>>> +             * assuming load_addr + e_phoff (false when the phdrs are=
 not
>>>> +             * mapped 1:1 from file offset 0, e.g. relocated into the=
ir own
>>>> +             * segment by a binary patcher).
>>>> +             */
>>>> +            if (eppnt->p_offset <=3D ehdr->e_phoff &&
>>>> +                ehdr->e_phoff < eppnt->p_offset + eppnt->p_filesz) {
>>>> +                info->phdr_addr =3D vaddr + (ehdr->e_phoff - eppnt->p=
_offset);
>>>> +            }
>>>> +
>>>>                /*
>>>>                 * Some segments may be completely empty, with a non-ze=
ro p_memsz
>>>>                 * but no backing file segment.
>>>> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
>>>> index 07fe801..2268493 100644
>>>> --- a/linux-user/qemu.h
>>>> +++ b/linux-user/qemu.h
>>>> @@ -26,6 +26,7 @@
>>>>    struct image_info {
>>>>            abi_ulong       load_bias;
>>>>            abi_ulong       load_addr;
>>>> +        abi_ulong       phdr_addr;
>>>>            abi_ulong       start_code;
>>>>            abi_ulong       end_code;
>>>>            abi_ulong       start_data;
>>=20
>>=20


