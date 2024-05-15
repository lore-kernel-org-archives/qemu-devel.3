Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86AAC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7H5s-00017D-O8; Wed, 15 May 2024 12:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s7H5o-00012t-Vj
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s7H5m-0000Qj-OK
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715788977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBPMHWk/3X9EOsFM9ZyHhxSqY4SAOc/HnPCkNSCS9iE=;
 b=aJ/fMCKfhXvl2AKn7/w2KIztEo960T/ReqyyYpb0PLLFANNAgHfO0zxVs8tyu6TNX1rs88
 MPCUZEJRt35QsDBmkqZLBH19wj4PSpImp8yZkM6K5KpYKpajZ05zYBNjGTwL0JYbvPoNRC
 pEPhT8urU+PtpsMInsr2j6hzMIhARCw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-ZX_WUVaGP-mq34nRyTH7Eg-1; Wed, 15 May 2024 12:02:55 -0400
X-MC-Unique: ZX_WUVaGP-mq34nRyTH7Eg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-351bd229b88so2283279f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 09:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715788974; x=1716393774;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oBPMHWk/3X9EOsFM9ZyHhxSqY4SAOc/HnPCkNSCS9iE=;
 b=vgFLWtl1szOg/Q6r8TxNMyR87XzsUn2M3tLDiedF5ebo4q7a4Qy9PpPgk3MSRm2vOb
 6ztCLWajst/fXennUkQNgZEcHtQjZjPAbCl/b3ZSRJ4vSM2lP1DvJhwFY/nUainNz2pR
 a6Uyb+r8TA1yiqyGeC1flrk/Btzc+TWIKi1qjTk0fWx9lv0w1nWBaJJlPc9iTbles86f
 ZZ70zRvW3JGe11w+7+9x+cC32M3FkkUCNcMw+ggvoHUVnpg1jb4jiPnyYoHuZqqk05pm
 bJQRBWX76QG8Jb4qgAInKdmOhooMLEdAiXyydVZLr6APMZsO/nUKbLOA97gRZOFrBvhe
 /Ogg==
X-Gm-Message-State: AOJu0YzX88j8RGz7glsum5vDJOA/IW3MC+kVNfiaokfTmJ+H4JrMcQwJ
 OMlYLcJonDfOGyLeRFgVfXbz+KXYJ4/ctzjEiqwO2KJB4dbM7LvZUIHltVXHMQ0wxUQJkA1XYXt
 Nm/5ejENshHr9tVIYU2nrYjFBk2o+npO6yOSYb9bdX/Lk0RA+fFw8
X-Received: by 2002:adf:ff92:0:b0:34c:9b4d:a7ee with SMTP id
 ffacd0b85a97d-3504aa66822mr13132979f8f.67.1715788974434; 
 Wed, 15 May 2024 09:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8ennYiDKAMn5JdA3oEK2QfGf07K4zUKt0aZ/yTdRDkg5qECqAW5j7SvixrHBkcDVZ5DuUbA==
X-Received: by 2002:adf:ff92:0:b0:34c:9b4d:a7ee with SMTP id
 ffacd0b85a97d-3504aa66822mr13132944f8f.67.1715788973742; 
 Wed, 15 May 2024 09:02:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c01e:6df5:7e14:ad03:85bd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-351cb0fb6b4sm3632961f8f.24.2024.05.15.09.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 09:02:53 -0700 (PDT)
Date: Wed, 15 May 2024 12:02:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 5/5] virtio-gpu: fix v2 migration
Message-ID: <20240515120104-mutt-send-email-mst@kernel.org>
References: <20240515141557.1277999-1-marcandre.lureau@redhat.com>
 <20240515141557.1277999-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240515141557.1277999-6-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

On Wed, May 15, 2024 at 06:15:56PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Commit dfcf74fa ("virtio-gpu: fix scanout migration post-load") broke
> forward/backward version migration. Versioning of nested VMSD structures
> is not straightforward, as the wire format doesn't have nested
> structures versions.
> 
> Use the previously introduced check_machine_version() function as a
> field test to ensure proper saving/loading based on the machine version.
> The VMSD.version is irrelevant now.
> 
> Fixes: dfcf74fa ("virtio-gpu: fix scanout migration post-load")
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

I don't get it. Our standard way to do it is:
- add a property (begin name with x- so we don't commit to an API)
- set from compat machinery
- test property value in VMSTATE macros

Big advantage is, it works well with any downstreams
which pick any properties they like.
Why is this not a good fit here?


> ---
>  hw/display/virtio-gpu.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index ae831b6b3e..b2d8e5faeb 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -20,6 +20,7 @@
>  #include "trace.h"
>  #include "sysemu/dma.h"
>  #include "sysemu/sysemu.h"
> +#include "hw/boards.h"
>  #include "hw/virtio/virtio.h"
>  #include "migration/qemu-file-types.h"
>  #include "hw/virtio/virtio-gpu.h"
> @@ -1166,10 +1167,14 @@ static void virtio_gpu_cursor_bh(void *opaque)
>      virtio_gpu_handle_cursor(&g->parent_obj.parent_obj, g->cursor_vq);
>  }
>  
> +static bool machine_check_9_0(void *opaque, int version)
> +{
> +    return machine_check_version(9, 0);
> +}
> +
>  static const VMStateDescription vmstate_virtio_gpu_scanout = {
>      .name = "virtio-gpu-one-scanout",
> -    .version_id = 2,
> -    .minimum_version_id = 1,
> +    .version_id = 1,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(resource_id, struct virtio_gpu_scanout),
>          VMSTATE_UINT32(width, struct virtio_gpu_scanout),
> @@ -1181,12 +1186,12 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
>          VMSTATE_UINT32(cursor.hot_y, struct virtio_gpu_scanout),
>          VMSTATE_UINT32(cursor.pos.x, struct virtio_gpu_scanout),
>          VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
> -        VMSTATE_UINT32_V(fb.format, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.bytes_pp, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.width, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.height, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.stride, struct virtio_gpu_scanout, 2),
> -        VMSTATE_UINT32_V(fb.offset, struct virtio_gpu_scanout, 2),
> +        VMSTATE_UINT32_TEST(fb.format, struct virtio_gpu_scanout, machine_check_9_0),
> +        VMSTATE_UINT32_TEST(fb.bytes_pp, struct virtio_gpu_scanout, machine_check_9_0),
> +        VMSTATE_UINT32_TEST(fb.width, struct virtio_gpu_scanout, machine_check_9_0),
> +        VMSTATE_UINT32_TEST(fb.height, struct virtio_gpu_scanout, machine_check_9_0),
> +        VMSTATE_UINT32_TEST(fb.stride, struct virtio_gpu_scanout, machine_check_9_0),
> +        VMSTATE_UINT32_TEST(fb.offset, struct virtio_gpu_scanout, machine_check_9_0),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> -- 
> 2.41.0.28.gd7d8841f67


