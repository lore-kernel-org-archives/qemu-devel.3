Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=Tfxjhhgi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpF8-0005cP-GK; Fri, 27 Nov 2026 01:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xWpEm-0005NT-Id
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 01:15:14 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xWpEi-0007jN-QO
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 01:15:12 -0500
Received: from [157.82.201.75] ([157.82.201.75]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6AR6ExwY095082
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 27 Nov 2026 15:14:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=JY0lNV7CSl/weacx/t5PybOsUnw/Kzo6QOOaeBMr5Zw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1795760099; v=1;
 b=TfxjhhgiOuzNG6CE0Va31jfz9DHHeUy3oMm1DYHyKyGgmI2MvGkjXiePcNgoQ3nY
 6pIj2QmyCv+WNNwi0SaKo9m62ITTu2wcnSDRdH9Yw+zXXKMu2Xp4Y/e/5YZRCipM
 N60WcLFCocaqlu1paBF87iu7S7og5jLyZMtO++KkjPSvShvqbGiW2yQKn8Zo0O8t
 RBtrdsJFCEk6uBw/VWEyhshAf2A1z75bDqxHS6/y/49YRvm3ygjf9D6kFmMgwCoB
 b1maJLE+gXdOuej7udBuLYDuN9FmngwILCpetukGtUgvpXkuGXpCcTcb8Cv+uQrC
 +tUivmo3Pre8GN5ap1MTRA==
Message-ID: <3158bb16-400f-4c60-a204-0a1115c06020@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 27 Nov 2026 15:14:59 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] contrib/vhost-user-gpu: don't fence commands
 waiting for a reply
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Dmitry R <rdmitry@taktcycles.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
References: <20261124-issue-4848-v4-0-24993c4766fc@redhat.com>
 <20261124-issue-4848-v4-1-24993c4766fc@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261124-issue-4848-v4-1-24993c4766fc@redhat.com>
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/24 21:47, Marc-André Lureau wrote:
> virgl_write_fence() completes and frees every command on fenceq whose
> fence_id is not above the signalled fence, without checking its state.
> GET_DISPLAY_INFO and GET_EDID wait for a reply from the frontend on that
> same queue, in VG_CMD_STATE_PENDING with a zero fence_id, so the next
> signalled fence frees them. The reply callback then takes QTAILQ_LAST()
> of the queue, which is either empty or another command, and crashes or
> trips the type assertion.
> 
> Keep the command that waits for the frontend reply in VuGpu instead,
> free it from the reply callback, and don't put it on fenceq at all, so
> that the queue and the inflight count only track commands submitted to
> virglrenderer.
> 
> Fixes: bd690feb1554 ("vhost-user-gpu: handle display-info in a callback")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4848
> Reported-by: Dmitry R <rdmitry@taktcycles.com>
> Tested-by: Dmitry R <rdmitry@taktcycles.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   contrib/vhost-user-gpu/vhost-user-gpu.c | 21 +++++++++++++++------
>   contrib/vhost-user-gpu/virgl.c          |  4 ++++
>   contrib/vhost-user-gpu/vugpu.h          |  3 +++
>   3 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
> index f70b34c179f3..5240b171d538 100644
> --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> @@ -268,17 +268,18 @@ get_display_info_cb(gint fd, GIOCondition condition, gpointer user_data)
>   {
>       struct virtio_gpu_resp_display_info dpy_info = { {} };
>       VuGpu *vg = user_data;
> -    struct virtio_gpu_ctrl_command *cmd = QTAILQ_LAST(&vg->fenceq);
> +    struct virtio_gpu_ctrl_command *cmd = vg->pending_cmd;
>   
>       g_debug("disp info cb");
> -    assert(cmd->cmd_hdr.type == VIRTIO_GPU_CMD_GET_DISPLAY_INFO);
> +    assert(cmd && cmd->cmd_hdr.type == VIRTIO_GPU_CMD_GET_DISPLAY_INFO);
>       if (!vg_recv_msg(vg, VHOST_USER_GPU_GET_DISPLAY_INFO,
>                        sizeof(dpy_info), &dpy_info)) {
>           return G_SOURCE_CONTINUE;
>       }
>   
> -    QTAILQ_REMOVE(&vg->fenceq, cmd, next);
> +    vg->pending_cmd = NULL;
>       vg_ctrl_response(vg, cmd, &dpy_info.hdr, sizeof(dpy_info));
> +    free(cmd);
>   
>       vg->wait_in = 0;
>       vg_handle_ctrl(&vg->dev.parent, 0);
> @@ -297,6 +298,7 @@ vg_get_display_info(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd)
>       assert(vg->wait_in == 0);
>   
>       vg_send_msg(vg, &msg, -1);
> +    vg->pending_cmd = cmd;
>       vg->wait_in = g_unix_fd_add(vg->sock_fd, G_IO_IN | G_IO_HUP,
>                                  get_display_info_cb, vg);
>       cmd->state = VG_CMD_STATE_PENDING;
> @@ -307,17 +309,18 @@ get_edid_cb(gint fd, GIOCondition condition, gpointer user_data)
>   {
>       struct virtio_gpu_resp_edid resp_edid;
>       VuGpu *vg = user_data;
> -    struct virtio_gpu_ctrl_command *cmd = QTAILQ_LAST(&vg->fenceq);
> +    struct virtio_gpu_ctrl_command *cmd = vg->pending_cmd;
>   
>       g_debug("get edid cb");
> -    assert(cmd->cmd_hdr.type == VIRTIO_GPU_CMD_GET_EDID);
> +    assert(cmd && cmd->cmd_hdr.type == VIRTIO_GPU_CMD_GET_EDID);
>       if (!vg_recv_msg(vg, VHOST_USER_GPU_GET_EDID,
>                        sizeof(resp_edid), &resp_edid)) {
>           return G_SOURCE_CONTINUE;
>       }
>   
> -    QTAILQ_REMOVE(&vg->fenceq, cmd, next);
> +    vg->pending_cmd = NULL;
>       vg_ctrl_response(vg, cmd, &resp_edid.hdr, sizeof(resp_edid));
> +    free(cmd);
>   
>       vg->wait_in = 0;
>       vg_handle_ctrl(&vg->dev.parent, 0);
> @@ -344,6 +347,7 @@ vg_get_edid(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd)
>       assert(vg->wait_in == 0);
>   
>       vg_send_msg(vg, &msg, -1);
> +    vg->pending_cmd = cmd;
>       vg->wait_in = g_unix_fd_add(vg->sock_fd, G_IO_IN | G_IO_HUP,
>                                  get_edid_cb, vg);
>       cmd->state = VG_CMD_STATE_PENDING;
> @@ -940,6 +944,11 @@ vg_handle_ctrl(VuDev *dev, int qidx)
>               }
>           }
>   
> +        if (cmd->state == VG_CMD_STATE_PENDING) {
> +            /* freed by the frontend reply callback */
> +            continue;
> +        }
> +
>           if (cmd->state != VG_CMD_STATE_FINISHED) {
>               QTAILQ_INSERT_TAIL(&vg->fenceq, cmd, next);
>               vg->inflight++;
> diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
> index 0ef4b9d8c903..3242bf13586d 100644
> --- a/contrib/vhost-user-gpu/virgl.c
> +++ b/contrib/vhost-user-gpu/virgl.c
> @@ -608,6 +608,10 @@ virgl_write_fence(void *opaque, uint32_t fence)
>            * the guest can end up emitting fences out of order
>            * so we should check all fenced cmds not just the first one.
>            */
> +        if (cmd->state == VG_CMD_STATE_PENDING) {
> +            /* not fenced, completed by the frontend reply */
> +            continue;
> +        }

This is redundant because those commands are no longer queued on fenceq 
as the patch message notes, but keeping it is harmless as a defensive 
check, so:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

>           if (cmd->cmd_hdr.fence_id > fence) {
>               continue;
>           }
> diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
> index aaf2870cb24d..1c2b0ed4fbe8 100644
> --- a/contrib/vhost-user-gpu/vugpu.h
> +++ b/contrib/vhost-user-gpu/vugpu.h
> @@ -147,6 +147,9 @@ typedef struct VuGpu {
>       struct virtio_gpu_scanout scanout[VIRTIO_GPU_MAX_SCANOUTS];
>       QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
>       QTAILQ_HEAD(, virtio_gpu_ctrl_command) fenceq;
> +
> +    /* command waiting for a reply from the frontend */
> +    struct virtio_gpu_ctrl_command *pending_cmd;
>   } VuGpu;
>   
>   enum {
> 


