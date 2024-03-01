Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FACC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 20:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg98m-00081k-KE; Fri, 01 Mar 2024 15:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rg98i-000804-Jq
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:05:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rg98g-00005i-KT
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709323549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0k1fdxRndW6WC9hnwpKSKEP8NpQ5ahA5LhfJu/UmZgI=;
 b=PsaS9mHAACco8fTawxcNHE6SeqiAkSLlRRrCRpjrqAozypmJPdf/zPrpMx0vlSIWOoS3Hn
 hcxcTQyrWn54nV8JRWs41CiGx/dZ3iZuWepBQVrNxETTCECRs2E9PzG3VC2TT5hhNEiJVR
 IJr8ATAECZ+VZEZbDnUWgMjQm0Xyhjo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-fx9Lqk76MjeNhZSR-y2iXg-1; Fri, 01 Mar 2024 15:05:48 -0500
X-MC-Unique: fx9Lqk76MjeNhZSR-y2iXg-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-608e4171382so34617427b3.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 12:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709323548; x=1709928348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0k1fdxRndW6WC9hnwpKSKEP8NpQ5ahA5LhfJu/UmZgI=;
 b=P+k1QO1yGHNOfxpWhMKi4YN/o7pRcCdTKiWwRe7uTHbDBGHOlbjv7JTr8i2MzFSie9
 7uNNzyYsR2JD2jm7zlLBA8VMy8xWzTh1xBmozbup+jTfpwemZ7QIazV2a5tfgY7Xtat1
 5/BLFOAuj8lC5Fbxy19ATk4+QUnuA2Js7kRQXrYSL9RN5wlTD3scvuIfoRHazx6cdYWV
 6PHfTDaQSfmUd82n2MZ3kzpcjCBkoyu9oTsqFVMhKUxJXh63GLVK49+sJ9CcjZZfxmK2
 +tNbg5Hdv1cemuQzaJSxZSXbLg/V2M6LjqdHGsEbJRA1M8G8lXgtcG1mUj/+Zs0eWeYq
 FI/A==
X-Gm-Message-State: AOJu0YyjoDcoVIS2JNkKnfCiiyP9mKOuXJSERCJH7qFmp4mTXSj1REyC
 hqw3WonB8/M2EZwohpBy8MXGMB74jcBJ3fwOdGASaP0evyHJycmBQRvAm425GOwD186IWRh4cvT
 MOVQh1u5lZyVeN5/U/YdtRiFlSpigfNL6pUdnmUkCeWFQx7dSxBpj1OHf2dwQb85FhkCQdoeuqM
 5vo+pQMvld0LS796zxGJMdS4/RFRQ=
X-Received: by 2002:a25:9745:0:b0:dcd:3663:b5e5 with SMTP id
 h5-20020a259745000000b00dcd3663b5e5mr2335757ybo.25.1709323547891; 
 Fri, 01 Mar 2024 12:05:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+1J8CIrLVnCpOEnOKyL5JwwC+uAVHVjmjxs+speuALEy6QlX/n95Cutd7uqUX6W05k8ndzfNg4uW7CPBiNdU=
X-Received: by 2002:a25:9745:0:b0:dcd:3663:b5e5 with SMTP id
 h5-20020a259745000000b00dcd3663b5e5mr2335735ybo.25.1709323547659; Fri, 01 Mar
 2024 12:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20240301134330.4191007-1-jonah.palmer@oracle.com>
 <20240301134330.4191007-9-jonah.palmer@oracle.com>
In-Reply-To: <20240301134330.4191007-9-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 1 Mar 2024 21:05:11 +0100
Message-ID: <CAJaqyWcEvYJm0WSZtVd5qj-eLRwT00DbUGjnb6J63snRvpH2og@mail.gmail.com>
Subject: Re: [RFC 8/8] virtio: Add VIRTIO_F_NOTIFICATION_DATA property
 definition
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, farman@linux.ibm.com, thuth@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com, 
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, 
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Mar 1, 2024 at 2:44=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> Extend the virtio device property definitions to include the
> VIRTIO_F_NOTIFICATION_DATA feature.
>
> The default state of this feature is disabled, allowing it to be
> explicitly enabled where it's supported.
>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  include/hw/virtio/virtio.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c92d8afc42..5772737dde 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -369,7 +369,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
>      DEFINE_PROP_BIT64("packed", _state, _field, \
>                        VIRTIO_F_RING_PACKED, false), \
>      DEFINE_PROP_BIT64("queue_reset", _state, _field, \
> -                      VIRTIO_F_RING_RESET, true)
> +                      VIRTIO_F_RING_RESET, true), \
> +    DEFINE_PROP_BIT64("notification_data", _state, _field, \
> +                      VIRTIO_F_NOTIFICATION_DATA, false)
>
>  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
>  bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
> --
> 2.39.3
>


