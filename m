Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BABC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 06:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGMD-0005Ii-DM; Thu, 04 Jul 2024 02:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seven.yi.lee@gmail.com>)
 id 1sPGMB-0005Hi-QC
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 02:54:15 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <seven.yi.lee@gmail.com>)
 id 1sPGMA-0006Wy-Bz
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 02:54:15 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-64789495923so2644037b3.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 23:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720076052; x=1720680852; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0E4nWCkwSyppo2vTOEFWCnQRt133e23de5zypJvZXg=;
 b=L1nVbuxGzMQ5I6eJNUSr125y4WR6Qh4WGaSCpJ/DvjeaMhW88NNeidBKujekpiE67H
 +awuHlfwwwWu+oao45UvP86uO7uT0IHZezfaWjAFdFSsBkSoPY+hCzMMTws7dupatbd3
 6NT0NR05ttj+DVoqo7uffVPtcGWhI60Afx1oL+MZ/FMYKXjn1KSwbaduYBxkyKDnRg1Y
 pHJr3Jl9peU92UVCgbAia33qU8Pkz+q8Da0jxKtLdQfgAvZfpNA0f/jqlptJvHqfDxrc
 c58SxPg86J3UXrDh+rppKuedlJPJMJkRIie93145flH7pmG7FRHyeDQ0scV/YTMzoofK
 z//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720076052; x=1720680852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r0E4nWCkwSyppo2vTOEFWCnQRt133e23de5zypJvZXg=;
 b=NHlHZVsQVF/VIJbXgnQavwHEFGHuekFMveUqLtwXofXKvvGZlxP7pWH8ysU1etyYJy
 XB1S9cHHImsoDspCh2hB1JFAb9xTi5zfrSiQcsDPtp5YptdAjiw4U1rg0BiMQ0jZbBsm
 iD6DkjMaX9gPuA7mpeD7ZnpW5+inGuMJheDNdM80e0DBoT3LYLhPKfu0tlArGLhEfSZ5
 /5CU7BIgpajuRlubNDqbxvE4dxTAdw58mDmVULTkYOayPynqvDd3KtWOigfqvOjADptw
 XzAn67rKsyMRNJAw3nIFhZUbmx2GvYirrePXPEkcVt8MY3AGgvqBKqnFSvfA1sLftGJ6
 hJ3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjq/AuqMTvm3YUpoZf5CLcSJeI+zn9sROh5pdCCn5uMjpQANHXKM35HdinlK9Jb8eeiZJ4hXvw2KOZYXlmOLMFFym/Z8c=
X-Gm-Message-State: AOJu0Yz2ZV9oDQa5wRAJbbchw9oSVaJ9Vxobr7fE5Igk1uKWYWB9zNjl
 nbs39Y2s1GgYQgzCc2OgAA7PLOuR5m/4svYNVbqAUaV1vyGQZ4Sh3X9RlPfIfbOYnmUyfDv+9Uv
 4D3MSS9Bqu4WrrMjhEQUiCLvzcC8=
X-Google-Smtp-Source: AGHT+IG9tyH6c0rae0Kq720AZTIVqL2jdZM5TfWqeTPOMoD+ky1+u9gGqMhEjDmRESeQPux/amNtw5fCJaqoSewWQFE=
X-Received: by 2002:a05:690c:4d82:b0:61d:fcf7:b79a with SMTP id
 00721157ae682-652d5333774mr9579047b3.11.1720076051895; Wed, 03 Jul 2024
 23:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240704035302.306244-1-seven.yi.lee@gmail.com>
In-Reply-To: <20240704035302.306244-1-seven.yi.lee@gmail.com>
From: Yee Li <seven.yi.lee@gmail.com>
Date: Thu, 4 Jul 2024 14:54:00 +0800
Message-ID: <CALX8JfT5ecx4qQTsBMdFAqS-r4FoBd0T5WQFGr0MwYnAMo+Meg@mail.gmail.com>
Subject: Re: [PATCH] intel-iommu: fix Read DMAR IQA REG DW
To: mst@redhat.com, jasowang@redhat.com
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=seven.yi.lee@gmail.com; helo=mail-yw1-x1134.google.com
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

Sorry, the patch missing "((  ))"
Replace "& VTD_IQA_QS" with "& (VTD_IQA_QS | VTD_IQA_DW_MASK))" is correct.
Revised patch as follows,

Signed-off-by: yeeli <seven.yi.lee@gmail.com>
---
 hw/i386/intel_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 37c21a0aec..23562ba26b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2938,7 +2938,8 @@ static uint64_t vtd_mem_read(void *opaque,
hwaddr addr, unsigned size)

     /* Invalidation Queue Address Register, 64-bit */
     case DMAR_IQA_REG:
-        val =3D s->iq | (vtd_get_quad(s, DMAR_IQA_REG) & VTD_IQA_QS);
+        val =3D s->iq | (vtd_get_quad(s, DMAR_IQA_REG) & (VTD_IQA_QS
+                    | VTD_IQA_DW_MASK));
         if (size =3D=3D 4) {
             val =3D val & ((1ULL << 32) - 1);
         }
--=20
2.34.1

YeeLi <seven.yi.lee@gmail.com> =E4=BA=8E2024=E5=B9=B47=E6=9C=884=E6=97=A5=
=E5=91=A8=E5=9B=9B 11:53=E5=86=99=E9=81=93=EF=BC=9A
>
> From: yeeli <seven.yi.lee@gmail.com>
>
> When dmar_readq or devmem2 read the DW of IQA always 0UL because
> "& VTD_IQA_QS". So, try to fix it.
>
> case:
> after vtd_mem_write
> IQA val: 0x100206801
>
> after vtd_mem_read
> IQA val: 0x100206001
>
> Signed-off-by: yeeli <seven.yi.lee@gmail.com>
> ---
>  hw/i386/intel_iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 37c21a0aec..e230a45940 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2938,7 +2938,8 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr a=
ddr, unsigned size)
>
>      /* Invalidation Queue Address Register, 64-bit */
>      case DMAR_IQA_REG:
> -        val =3D s->iq | (vtd_get_quad(s, DMAR_IQA_REG) & VTD_IQA_QS);
> +        val =3D s->iq | (vtd_get_quad(s, DMAR_IQA_REG) & VTD_IQA_QS
> +                | VTD_IQA_DW_MASK);
>          if (size =3D=3D 4) {
>              val =3D val & ((1ULL << 32) - 1);
>          }
> --
> 2.34.1
>

