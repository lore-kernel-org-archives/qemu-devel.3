Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B7606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e2QXhYK9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhbu-0006we-DT; Tue, 10 Nov 2026 03:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQhbs-0006wO-OF
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:53:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQhbq-0005fu-NX
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794300819;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xUyTHTcpLqwRfq4HgFPKAe1BFEY5Pr96IJ82viWhfC4=;
 b=e2QXhYK9OESvgHRdOsk8mCCQNNfJDdeJzChyfo1LHt1R7tvJ20mMyfnsOzShdfLGEanvAV
 pb1KKRO/AH4sI/NPi/HHxYVuNFgPqmGm/J2lMCQkhAmOfTqAW1aACR+SorbpkdanPDuyq9
 gE4p6fawlG4B7OTuCuJtZN8OmX7yCS8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-QjKHWIO6P4mTEDtTgp2V4g-1; Tue,
 10 Nov 2026 03:53:36 -0500
X-MC-Unique: QjKHWIO6P4mTEDtTgp2V4g-1
X-Mimecast-MFC-AGG-ID: QjKHWIO6P4mTEDtTgp2V4g_1794300814
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 838EC1800547; Tue, 10 Nov 2026 08:53:34 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 824AA1800347; Tue, 10 Nov 2026 08:53:32 +0000 (UTC)
Date: Tue, 10 Nov 2026 08:53:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Gurchetan Singh <gurchetan.singh.foss@gmail.com>
Subject: Re: [PATCH 2/4] virtio-gpu/gl: reject non-32bpp cursor resources
Message-ID: <avLbiXYoG2KTpBj3@redhat.com>
References: <20261110-master-v1-0-7a0505d6c259@redhat.com>
 <20261110-master-v1-2-7a0505d6c259@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110-master-v1-2-7a0505d6c259@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 12:31:12PM +0400, Marc-André Lureau wrote:
> Cursor pixel data is copied as 32bpp, but the resource format is never
> checked. virgl_renderer_get_cursor_data() sizes its buffer for the
> resource's own format, while virtio_gpu_gl_update_cursor_data() copies
> width * height * 4 bytes from it: a 64x64 R8_UNORM resource gives a
> 4096 byte buffer and a 16384 byte read, so 12 KiB of host heap past the
> end of the allocation is sent to a connected VNC client as cursor data.
> 
> Look up the resource format and refuse anything that is not 32bpp,
> matching what the non-virgl paths accept. Querying the renderer covers
> blob resources: a blob carries no format in the virtio command and QEMU
> stores 0 for it. The virgl and virtio format enums have the same values
> for the accepted formats.
> 
> Fixes: CVE-2026-122027
> Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering support.")
> Reported-by: Fernando Bortotti <https://gitlab.com/fernando.bortotti>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/virtio-gpu-gl.c            | 18 ++++++++++++++++++
>  include/hw/virtio/virtio-gpu-pixman.h | 13 +++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 2b7a41c46643..c314631b05f3 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -31,6 +31,7 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
>                                               uint32_t resource_id)
>  {
>      VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
> +    struct virgl_renderer_resource_info info = { 0 };
>      uint32_t width, height;
>      uint32_t pixels, *data;
>  
> @@ -38,6 +39,20 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
>          return;
>      }
>  
> +    virgl_renderer_force_ctx_0();
> +    if (virgl_renderer_resource_get_info(resource_id, &info) != 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown cursor resource %u\n",
> +                      __func__, resource_id);
> +        return;
> +    }
> +
> +    if (!virtio_gpu_format_is_cursor_capable(info.virgl_format)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: cursor resource %u has unsupported format %u\n",
> +                      __func__, resource_id, info.virgl_format);
> +        return;
> +    }
> +
>      data = virgl_renderer_get_cursor_data(resource_id, &width, &height);
>      if (!data) {
>          return;
> @@ -45,6 +60,9 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
>  
>      if (width != s->current_cursor->width ||
>          height != s->current_cursor->height) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: cursor resource %u has unsupported dimension %ux%u\n",
> +                      __func__, resource_id, width, height);
>          free(data);
>          return;
>      }
> diff --git a/include/hw/virtio/virtio-gpu-pixman.h b/include/hw/virtio/virtio-gpu-pixman.h
> index 4dba782758dc..d6043d2ca1df 100644
> --- a/include/hw/virtio/virtio-gpu-pixman.h
> +++ b/include/hw/virtio/virtio-gpu-pixman.h
> @@ -42,4 +42,17 @@ virtio_gpu_get_pixman_format(uint32_t virtio_gpu_format)
>      }
>  }
>  
> +/*
> + * Cursor data is copied as 32bpp; formats without a pixman mapping are
> + * rejected.
> + */
> +static inline bool
> +virtio_gpu_format_is_cursor_capable(uint32_t format)
> +{
> +    pixman_format_code_t pformat;
> +
> +    pformat = virtio_gpu_get_pixman_format(format);
> +    return pformat && PIXMAN_FORMAT_BPP(pformat) == 32;

Seems like 'pformat &&' is redundant since pixman_format_code_t is an
int (enum) and thus it is impossible for it to be 0, at the same time
as PIXMAN_FORMAT_BPP() reports 32.

Functionally it works though, so with/without it, 

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


