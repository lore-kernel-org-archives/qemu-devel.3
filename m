Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80829C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 17:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYTGx-0008OT-Cc; Thu, 16 Jan 2025 12:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tYTGq-0008NN-LF
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:03:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tYTGp-0006VB-4e
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737046980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8qN0dnUuiS89lnNjnqRZZCIqKHIemj06y4bLy44NHt0=;
 b=QSM1fFK8p6RhjLp8anX/Ec9wrhF5yBfzB71l2lmY5C8+SxygOWymmgpCs/57upYCsJZzp7
 AHYQbliImtSjbqTJ3uZC5utg8ozG9tyZMHDVMeat7MWlAghIUVh4Z479gVtQRcUZIlY25D
 aYxRhbuZ62zTlMPritxg3HV1EsNIZ5s=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-jCfClD1hOtOzK-nym5y8iQ-1; Thu, 16 Jan 2025 12:02:58 -0500
X-MC-Unique: jCfClD1hOtOzK-nym5y8iQ-1
X-Mimecast-MFC-AGG-ID: jCfClD1hOtOzK-nym5y8iQ
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e572df6db3eso1031368276.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737046977; x=1737651777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8qN0dnUuiS89lnNjnqRZZCIqKHIemj06y4bLy44NHt0=;
 b=mOsoZ+dkoisdrawM7Oqymw9LIJmlX9wrnolWAY9hwmUl4uQ2L3uP+8hsaKqmk27h4d
 +FPLVFAyJC0o1Oe7yteo/QIkAtAadeSBNFc1lCTgY6uy+LTpKNtkeDVPL3aqAIuutt58
 Lt7YcgY9gDAKz8c+tGb8K+qbq4WSf2kUki46FhR2OWbrnANDVtKq8RQBUYf4yxdg6b0B
 a7xq79zHKUiGH8mhJV4w0SEZ0tJuKtP6emHu0Fpjjo1w1ajvBzdZzcFMgR0+0MgUrC05
 uy36UyeLmvzvdWe3SvidEjvBD1FPzkF/eE5zGEXEq863AFpfIZ9GFFB8CppU2Yzpjhmg
 ZpJQ==
X-Gm-Message-State: AOJu0Yx+ruLGICG0L6LI/QiE4EIOGCorV+8EJdLKRnGOdv2w/scq/0xM
 gmAuBok5Jz2d2lNo9f5NHrbWwrTpbrSVz2SWDtK9IHSdxOR0E90+XQ4YHHotTgb2TDfEd3h4AOn
 GGJLhSzL/o8rl2zVP3eXL3drxyhUfzuyFnky8D9fts/oXW7Gq2fQ4pObn7a4tDkHcpX5cD39vgW
 Tp3cHVZI8A8ge3wTde0NacdTYsy0Y=
X-Gm-Gg: ASbGnctdvgyo+CLi3M70GFtjZ4qYer1ncM3EkOX8gNBcF0Wo5R3w9XNsLce0s+/flfG
 7fxInrjZsilGKXoXdRBD68XBgpY9K2fO8Flb/PQ==
X-Received: by 2002:a05:690c:688e:b0:6ef:91a0:dd30 with SMTP id
 00721157ae682-6f53123e372mr292066947b3.12.1737046977616; 
 Thu, 16 Jan 2025 09:02:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDh5ChpdZWcMNxkHxYUw7caXzQ+4GqxajWZwhxcYMTZhPE3mVhd9rnCyW7xOZ2Z65/CDJ7CukIyr7ZE0nJP3w=
X-Received: by 2002:a05:690c:688e:b0:6ef:91a0:dd30 with SMTP id
 00721157ae682-6f53123e372mr292066497b3.12.1737046977207; Thu, 16 Jan 2025
 09:02:57 -0800 (PST)
MIME-Version: 1.0
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
 <20250110170837.2747532-3-jonah.palmer@oracle.com>
In-Reply-To: <20250110170837.2747532-3-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Jan 2025 18:02:21 +0100
X-Gm-Features: AbW1kvYxoEpitCelvt2XvDNn3GLTkRHt-pZGUbE-VKEeZVIONVF9mHzHLqzJOms
Message-ID: <CAJaqyWcVNaUkOSwe_BNbhS88+fOyXAPkuETGpak4k=uCdM=MFA@mail.gmail.com>
Subject: Re: [RFC v3 2/5] vhost-iova-tree: Remove range check for IOVA
 allocator
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com, 
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jan 10, 2025 at 6:09=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Removes the range check portion in vhost_iova_tree_map_alloc.
>
> The previous patch decoupled the IOVA allocator from adding mappings to
> the IOVA->HVA tree (now a partial SVQ IOVA->HVA tree) and instead adds
> the allocated IOVA range to an IOVA-only tree. No value exists under
> translated_addr for the IOVA-only mappings, so this check is no longer
> needed.
>
> This check was moved to vhost_iova_tree_insert in the previous patch
> since that function handles adding IOVA->HVA mappings to the SVQ
> IOVA->HVA tree.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/virtio/vhost-iova-tree.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
> index b1cfd17843..f6a5694857 100644
> --- a/hw/virtio/vhost-iova-tree.c
> +++ b/hw/virtio/vhost-iova-tree.c
> @@ -93,8 +93,7 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAM=
ap *map)
>      /* Some vhost devices do not like addr 0. Skip first page */
>      hwaddr iova_first =3D tree->iova_first ?: qemu_real_host_page_size()=
;
>

This is not a static function, so I guess it is better to duplicate
the check if needed? Otherwise a buggy caller can create invalid
entries.

> -    if (map->translated_addr + map->size < map->translated_addr ||
> -        map->perm =3D=3D IOMMU_NONE) {
> +    if (map->perm =3D=3D IOMMU_NONE) {
>          return IOVA_ERR_INVALID;
>      }
>
> --
> 2.43.5
>


