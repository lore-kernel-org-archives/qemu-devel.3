Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB833C25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 02:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDxsh-00015S-NM; Sun, 02 Jun 2024 22:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDxsc-0000xE-BI
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 22:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDmJo-0000En-2l
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 10:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717338979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOiQWelfsvCuTOBh54Zg8345vYYblEdKtiJmi87wNRA=;
 b=g7Meb31IySgk76se4x9SvZxYTEzSmgyFIFlxJ+93SVW3s/BUPndWonR0yOcyu7N/MaN2vo
 d7G6W27HhiaOSUzJ8G9PlPu/oZQd/LWuwmxgZKKTf+FhKUIFe85kiY13NnH9sTYQwTg7IK
 6ebaSJyyko93N1otyIBvhFbKruT8PEc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-_HkT3N0RN0qbtPDRWm9hnw-1; Sun, 02 Jun 2024 10:36:18 -0400
X-MC-Unique: _HkT3N0RN0qbtPDRWm9hnw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4212e2a3a1bso14491415e9.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 07:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717338976; x=1717943776;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qOiQWelfsvCuTOBh54Zg8345vYYblEdKtiJmi87wNRA=;
 b=wjy3zMPLoRlGjHXkvaLoosX7F/chzfAM3lfd+Q1g6LKZf7bPOSfoR1THDZMn3fp9w4
 3QIkZi2fs9p7bvff3S1eXRWPPHmxelK5r3rydKCRI6czhIpcY8UPjPOZKqSKvhTkYjBj
 CUy3rjdkJepyJceD3muSLVVsLAw48lmk1nN1vUOGZ6U9P9DBnTM15m7QLWXIs/DNCVr/
 2KH1D5ijfIsKp5ABu+5JqQscxO5Bi3yAyH7DlnpGE75+bF3zH7MtFqETyBIDRHdAHqFw
 X1zzp7OarojTY8Zg3KeD0JPHdxvJ3ex8SbwWoSYtZyG6wBW2epQOUzG5PBoBlUI5lqTW
 SGSQ==
X-Gm-Message-State: AOJu0YwXDHWR5tkUXBEX35stWjm+/dGvhhjClG4T7rTEbWQpqg5ej30r
 6yOeP3pLx3RalaMs2r1ebZ/vGOC7M1P742sNer9VqhZvR3Bzq9UUvehVvFgS5J9qyNfK5j9mW6u
 afhYxBBdNvC3J71GjqucOrJbURTAo7MABJUHu/hl4SHovB8CluRF9OHJb3fI3
X-Received: by 2002:a5d:6d05:0:b0:356:4cfa:b4b9 with SMTP id
 ffacd0b85a97d-35e0f25e190mr5953629f8f.2.1717338975684; 
 Sun, 02 Jun 2024 07:36:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgAtCY+lAetQ0mtVEJg+zGfZqsPkxXdP4HPadCu/nLvG5EftUYDWWWFJLuOuLFb8Ls97uiGA==
X-Received: by 2002:a5d:6d05:0:b0:356:4cfa:b4b9 with SMTP id
 ffacd0b85a97d-35e0f25e190mr5953619f8f.2.1717338975208; 
 Sun, 02 Jun 2024 07:36:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35e56669a23sm1460571f8f.83.2024.06.02.07.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 07:36:14 -0700 (PDT)
Date: Sun, 2 Jun 2024 10:36:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, dongwon.kim@intel.com,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3] vhost-user-gpu: fix import of DMABUF
Message-ID: <20240602103555-mutt-send-email-mst@kernel.org>
References: <20240515105237.1074116-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240515105237.1074116-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, May 15, 2024 at 02:52:37PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When using vhost-user-gpu with GL, qemu -display gtk doesn't show output
> and prints: qemu: eglCreateImageKHR failed
> 
> Since commit 9ac06df8b ("virtio-gpu-udmabuf: correct naming of
> QemuDmaBuf size properties"), egl_dmabuf_import_texture() uses
> backing_{width,height} for the texture dimension.
> 
> Fixes: commit 9ac06df8b ("virtio-gpu-udmabuf: correct naming of QemuDmaBuf size properties")


should be:
Fixes: 9ac06df8b ("virtio-gpu-udmabuf: correct naming of QemuDmaBuf size properties")


> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/vhost-user-gpu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index e4b398d26c..63c64ddde6 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -281,8 +281,9 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
>              modifier = m2->modifier;
>          }
>  
> -        dmabuf = qemu_dmabuf_new(m->fd_width, m->fd_height,
> -                                 m->fd_stride, 0, 0, 0, 0,
> +        dmabuf = qemu_dmabuf_new(m->width, m->height,
> +                                 m->fd_stride, 0, 0,
> +                                 m->fd_width, m->fd_height,
>                                   m->fd_drm_fourcc, modifier,
>                                   fd, false, m->fd_flags &
>                                   VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP);
> -- 
> 2.41.0.28.gd7d8841f67


