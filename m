Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55D606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=trUem9xH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpMZ-0008T9-Pj; Fri, 27 Nov 2026 01:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xWpMW-0008GO-SJ
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 01:23:12 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xWpMU-00035e-PI
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 01:23:12 -0500
Received: from [157.82.201.75] ([157.82.201.75]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6AR6N8vc002985
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 27 Nov 2026 15:23:08 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=yagpUAWgDJsvudIEl0gimPA1GR4eksCHuIBDinRC+2M=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1795760588; v=1;
 b=trUem9xHoOhMzDzIh8rlPn9AXFR4Wr/sdDZoeLHZud5wRsKGnXy0ure26XdqMZ2o
 5eGTFU2MfwErPauAIkKTCtzT1EXExS9cofjfXfNWSUO7CJEQt2OA9YtbsERCVq+d
 JX7JpRvE2wJtJUH9SxAKBEZVwr2f+UinchBZBS5WxUbFvK21d7E/TbZ0vAt3agMB
 pzMNyTStJlcMEJCdyFMv8MQChPMxjiSeauhWz/HEquArnx01e0ldfljNH4O5fsCS
 JL8t7KK5u+R4H5ErfowMfl3GaBPlVwuZMq4sOA1hC4KGjyFjwZb220K7R/JhU2Io
 2YhO7kkdaEvTOqo03nLvHw==
Message-ID: <966144b6-7211-45e9-b354-454ed87f16a5@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 27 Nov 2026 15:23:07 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] hw/display/vhost-user-gpu: resize the console on
 dmabuf scanout
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Dmitry R <rdmitry@taktcycles.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
References: <20261124-issue-4848-v4-0-24993c4766fc@redhat.com>
 <20261124-issue-4848-v4-4-24993c4766fc@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261124-issue-4848-v4-4-24993c4766fc@redhat.com>
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
> The frontend installs the backend dmabuf with
> qemu_console_gl_scanout_dmabuf() and never resizes the console, unlike
> the in-process virgl/udmabuf paths. The console surface, and with it the
> UI window and the EDID preferred mode reported to the guest, stay at the
> initial size, so the guest display is scaled.
> 
> Resize the console to the scanout first, and release the previous dmabuf
> only after the new one is installed, as virtio_gpu_update_dmabuf() does.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/vhost-user-gpu.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 61a15dd916f8..ef9aa73ceed5 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -278,7 +278,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
>           uint32_t offset = 0;
>           uint32_t stride = m->fd_stride;
>           uint64_t modifier = DRM_FORMAT_MOD_INVALID;
> -        QemuDmaBuf *dmabuf;
> +        QemuDmaBuf *old, *dmabuf;
>   
>           if (m->scanout_id >= g->parent_obj.conf.max_outputs) {
>               error_report("invalid scanout: %d", m->scanout_id);
> @@ -290,16 +290,14 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
>   
>           g->parent_obj.enable = 1;
>           con = g->parent_obj.scanout[m->scanout_id].con;
> -        dmabuf = g->dmabuf[m->scanout_id];
> -
> -        if (dmabuf) {
> -            qemu_console_gl_release_dmabuf(con, dmabuf);
> -            g_clear_pointer(&dmabuf, qemu_dmabuf_free);
> -        }
> +        old = g->dmabuf[m->scanout_id];
>   
>           if (fd == -1) {
> +            if (old) {
> +                qemu_console_gl_release_dmabuf(con, old);
> +                g_clear_pointer(&g->dmabuf[m->scanout_id], qemu_dmabuf_free);
> +            }
>               qemu_console_gl_scanout_disable(con);
> -            g->dmabuf[m->scanout_id] = NULL;
>               break;
>           }
>   
> @@ -315,8 +313,14 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
>                                    &fd, 1, false, m->fd_flags &
>                                    VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP);
>   
> +        qemu_console_resize(con, m->width, m->height);

This allocates a QEMU display surface from the message dimensions, which 
may be too large and trigger error_abort in 
qemu_create_displaysurface_from(). The in-process virgl implementation 
bounds the viewport size to the texture size with 
virtio_gpu_check_scanout_bounds() before resizing the console.

Also, please move patch 5 before this since this installs a new surface.

Regards,
Akihiko Odaki

>           qemu_console_gl_scanout_dmabuf(con, dmabuf);
>           g->dmabuf[m->scanout_id] = dmabuf;
> +
> +        if (old) {
> +            qemu_console_gl_release_dmabuf(con, old);
> +            qemu_dmabuf_free(old);
> +        }
>           break;
>       }
>       case VHOST_USER_GPU_DMABUF_UPDATE: {
> 


