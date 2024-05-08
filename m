Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4490CC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 04:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4YUP-0003Mc-VQ; Wed, 08 May 2024 00:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s4YUN-0003MD-TN
 for qemu-devel@nongnu.org; Wed, 08 May 2024 00:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1s4YUL-0001Z9-D8
 for qemu-devel@nongnu.org; Wed, 08 May 2024 00:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715140863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDWrUcgV14lG0tCthI6zOtleStRUC+ga2Y1ul1N64bc=;
 b=IvDCn1Ldf9RBReBr+IRKDOuThHOtR7TUOWOQ5Puf6r1swTM3lJk9cpsyU4LQLbf14RpWG8
 hUPofaXt3YevNmCXLAhYebTDG+wHGY+ClNQvr9URriDwGd1sJgZFRyCfB2K7uxHI4WVHho
 +ls1dr572jS0lsKqVUxnwsccP1UZ9oI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-FqXEp5I6NHK1anIUhqgM1w-1; Wed, 08 May 2024 00:01:01 -0400
X-MC-Unique: FqXEp5I6NHK1anIUhqgM1w-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2b402090778so4242143a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 21:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715140860; x=1715745660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oDWrUcgV14lG0tCthI6zOtleStRUC+ga2Y1ul1N64bc=;
 b=BVqkv8vCS3dE17OEFNu56kJFGo1nhlbg5ggZ8P9z6ybwIN4AQCqkEyXaavJiLHL5vr
 SXGwGqCIy221PvMOB2eSaOJuP/DA9KlXvj3hl3c4pNFHzPXPCdZUMQVuP3IG6o44MKQI
 y1LuR5PlFOW0p/tqAj5W3hkNUj4F5rO3Bc80V7SIdqM6bceazdG1c6S0yK/Nsvg5Tixl
 uddBOXthrgVMtcdOC01icgNph8NAdrnuzy6BRwKoS4TovrwtYRdQ4lGR6JjhgARn3LDj
 0sNTEMVzZFa8sqsZL+0uJZstuvQQ4njWh6DeHMjxqyZEDHSRoM/4y/VgPmegxmPPC0j8
 uYjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg830ysO9o+IXJQWjahls5O3QscPOGpCl+f4INYxhsoHmNL6VxH5/raXVWHh0J31Eqk0kHgFMfLHIhtvanhNJacuvuOjo=
X-Gm-Message-State: AOJu0YweEdpI9gk1AmRT0L6agv2dpSSiTu8fnBjA+NjEsqLWl30+IES6
 ZQlGMdFI2hU+n7MEU5eIgWwrcim90XTHSyy+sb/L14mD+ADPR0bbsZ79XGYCBfpuHK8AxCG0c3d
 +j0IbiIVS0tz7tAmLi+D7GgSWSG2AHalhRGy0a/4orb17KoGjVzp9zKcQ/MCu3mn2O7+MeVu7js
 dVFVqCo1yck7HDpj5ut5Gr9bsdcT4=
X-Received: by 2002:a17:90a:d0c2:b0:2b2:d375:3b7c with SMTP id
 98e67ed59e1d1-2b6169ddafamr1586775a91.31.1715140859669; 
 Tue, 07 May 2024 21:00:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU8m3gaRHuvzXrV0YM0rYO8yxlFFpg9NPmk3tyq3U6Rseyd6maF+6uEXm3QAkqzNaaFci7CheGpCm6i5UbNds=
X-Received: by 2002:a17:90a:d0c2:b0:2b2:d375:3b7c with SMTP id
 98e67ed59e1d1-2b6169ddafamr1586754a91.31.1715140859284; Tue, 07 May 2024
 21:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240422014041.5706-2-wafer@jaguarmicro.com>
In-Reply-To: <20240422014041.5706-2-wafer@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 May 2024 12:00:48 +0800
Message-ID: <CACGkMEsx1TKnCwHWnPN0srv3Xvf_Ji1Kx=y6mxVZ0AW_Zg7hDA@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio: Fix obtain the buffer id from the last
 descriptor
To: Wafer <wafer@jaguarmicro.com>
Cc: mst@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org, 
 angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 22, 2024 at 9:41=E2=80=AFAM Wafer <wafer@jaguarmicro.com> wrote=
:
>
> The virtio-1.3 specification
> <https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html> writes:
> 2.8.6 Next Flag: Descriptor Chaining
>       Buffer ID is included in the last descriptor in the list.
>
> If the feature (_F_INDIRECT_DESC) has been negotiated, install only
> one descriptor in the virtqueue.
> Therefor the buffer id should be obtained from the first descriptor.
>
> In descriptor chaining scenarios, the buffer id should be obtained
> from the last descriptor.
>
> Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
>
> Signed-off-by: Wafer <wafer@jaguarmicro.com>
> ---
>  hw/virtio/virtio.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 871674f9be..f65d4b4161 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1739,6 +1739,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq, s=
ize_t sz)
>              goto err_undo_map;
>          }
>
> +        if (desc_cache !=3D &indirect_desc_cache) {
> +            /* Buffer ID is included in the last descriptor in the list.=
 */
> +            id =3D desc.id;
> +        }

It looks to me we can move this out of the loop.

Others look good.

Thanks

> +
>          rc =3D virtqueue_packed_read_next_desc(vq, &desc, desc_cache, ma=
x, &i,
>                                               desc_cache =3D=3D
>                                               &indirect_desc_cache);
> --
> 2.27.0
>


