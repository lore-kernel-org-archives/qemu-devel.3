Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0AC606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=GqTBAVxJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpMi-0000pe-GU; Fri, 27 Nov 2026 01:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xWpMh-0000i3-0L
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 01:23:23 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xWpMe-000362-UT
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 01:23:22 -0500
Received: from [157.82.201.75] ([157.82.201.75]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6AR6NHBn003187
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 27 Nov 2026 15:23:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=KiT9C/2cohI4LaNgbfnJTXNKMjEQAZvgNmmxRAXY29Y=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1795760597; v=1;
 b=GqTBAVxJHu4mvhd/tPvcYmEY6rm5jH3bnhCYcXhzqZ8NLzSbl2PigRaQXL8cMlBS
 Fnbb0tXjmvWmr37WRi/G3/TruyvmaevevEgPi1aWdagw5kuutnWlBihRPOss5Sfj
 Vi3AmdkiWyIqVZhgm5zmrXy5dIaEvesia/ylzKTuush4ndiONv4B3HYF1RkuiUMt
 tTLdLd3GC12mWqGOrCweiQ8qmICsLafe2R6w7xGkMedfBS9LMA7+DMTaUFxpqbcU
 XO9GgcJ4r9XmRUNU3seDuXdo+dKtTe3d0VSACT4OtH/drUIYO3EVzpBGjgqqLvBX
 aVleSH3RyfkOKCzrnI23CQ==
Message-ID: <08b3774d-6aef-4238-bdfd-3cee94e99668@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 27 Nov 2026 15:23:17 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] contrib/vhost-user-gpu: use the stride of the
 exported dmabuf
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Dmitry R <rdmitry@taktcycles.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
References: <20261124-issue-4848-v4-0-24993c4766fc@redhat.com>
 <20261124-issue-4848-v4-6-24993c4766fc@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261124-issue-4848-v4-6-24993c4766fc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/24 21:47, Marc-André Lureau wrote:
> virgl_renderer_get_fd_for_texture2() returns the stride and offset that
> eglExportDMABUFImageMESA() gave the exported dmabuf. Use that stride.
> Reject a scanout with a non-zero offset, as the scanout message has no
> field to carry it.
> 
> This fixes dmabuf import/sheared with Intel driver when the resolution
> stride is not 256-byte aligned.
> 
> Left for later (after 11.2 release), add new message / field for offset.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   contrib/vhost-user-gpu/virgl.c | 48 +++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
> index c33b3dbeb8b7..4ab2c5fcdafc 100644
> --- a/contrib/vhost-user-gpu/virgl.c
> +++ b/contrib/vhost-user-gpu/virgl.c
> @@ -18,6 +18,23 @@
>   
>   #include <epoxy/gl.h>
>   
> +/*
> + * VIRGL_CHECK_VERSION available since libvirglrenderer 1.0.1 and was fixed
> + * in 1.1.0. Undefine bugged version of the macro and provide our own.
> + */
> +#if defined(VIRGL_CHECK_VERSION) && \
> +    VIRGL_VERSION_MAJOR == 1 && VIRGL_VERSION_MINOR < 1
> +#undef VIRGL_CHECK_VERSION
> +#endif
> +
> +#ifndef VIRGL_CHECK_VERSION
> +#define VIRGL_CHECK_VERSION(major, minor, micro) \
> +    (VIRGL_VERSION_MAJOR > (major) || \
> +     VIRGL_VERSION_MAJOR == (major) && VIRGL_VERSION_MINOR > (minor) || \
> +     VIRGL_VERSION_MAJOR == (major) && VIRGL_VERSION_MINOR == (minor) && \
> +     VIRGL_VERSION_MICRO >= (micro))
> +#endif
> +
>   void
>   vg_virgl_update_cursor_data(VuGpu *g, uint32_t resource_id,
>                               gpointer data)
> @@ -409,12 +426,33 @@ virgl_cmd_set_scanout(VuGpu *g,
>           }
>   
>           int fd = -1;
> -        if (virgl_renderer_get_fd_for_texture(info.tex_id, &fd) < 0) {
> -            g_critical("%s: failed to get fd for texture\n", __func__);
> -            cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> -            return;
> +        int stride = info.stride;
> +        int offset = 0;
> +        bool exported = false;
> +
> +#if VIRGL_CHECK_VERSION(0, 7, 0)
> +        exported = virgl_renderer_get_fd_for_texture2(info.tex_id, &fd,
> +                                                      &stride, &offset) == 0;

This will overflow with a multi-planar image, as it fills an fd, a 
stride, and an offset for each plane. Please check info_ext.planes after 
calling virgl_renderer_resource_get_info_ext() to detect and reject 
multi-planar textures.

Regards,
Akihiko Odaki

> +#endif
> +        if (!exported) {
> +            stride = info.stride;
> +            offset = 0;
> +            if (virgl_renderer_get_fd_for_texture(info.tex_id, &fd) < 0) {
> +                g_critical("%s: failed to get fd for texture\n", __func__);
> +                cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +                return;
> +            }
>           }
>           assert(fd >= 0);
> +
> +        if (offset) {
> +            /* the scanout message has no field to carry the buffer offset */
> +            g_critical("%s: unsupported dmabuf offset %d\n", __func__, offset);
> +            close(fd);
> +            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> +            return;
> +        }
> +
>           VhostUserGpuMsg msg = {
>               .payload.dmabuf_scanout.scanout_id = ss.scanout_id,
>               .payload.dmabuf_scanout.x =  ss.r.x,
> @@ -423,7 +461,7 @@ virgl_cmd_set_scanout(VuGpu *g,
>               .payload.dmabuf_scanout.height = ss.r.height,
>               .payload.dmabuf_scanout.fd_width = info.width,
>               .payload.dmabuf_scanout.fd_height = info.height,
> -            .payload.dmabuf_scanout.fd_stride = info.stride,
> +            .payload.dmabuf_scanout.fd_stride = stride,
>               .payload.dmabuf_scanout.fd_flags = info.flags,
>               .payload.dmabuf_scanout.fd_drm_fourcc = info.drm_fourcc
>           };
> 


