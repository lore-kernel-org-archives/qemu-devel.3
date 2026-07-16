Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1BFC44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkJQC-0007eT-A9; Thu, 16 Jul 2026 06:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkJQ8-0007e2-0n
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:34:24 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkJQ0-0006va-52
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:34:20 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66GAY4SY062537
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 16 Jul 2026 19:34:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=FzQtUzu6m9qTBly6omy7l0MZnKBjbwqMUXSYZBOtcnY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784198044; v=1;
 b=shwd7roTnG69BH/ntlmCXleUd2fNGVbsDKPwhA8hUqr/+Pc3sVbFSL57qYsrrd11
 f5eCxtbOKXj67EF197RykYLynmWC87HzvD/J+sE+WLA+5YdnOHQ3nWTkMeP+gaY2
 pYanh0+bS8hBae71qKFDbemyIeg5wcIPBH4pRVXlZkt12nrJMjZVdt6vCa+w618D
 Y+VZ13kNBxG86vSDsfOtYzi2euMCTrUyh9TJ/q0ih/qTeAXmLZi1Ybgt7QppzoFv
 ky8yuZEqIIcb/6QXCU527O2lH3LPCwnpFRDEGqeqGLlgH/vmPtnzP8ZXw2RXwqvo
 ztFmpHJd+lbEyIyDc9rSPg==
Message-ID: <809cedaa-0704-4ff9-954a-8e6e5724494d@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 16 Jul 2026 19:34:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: cap submit_3d command buffer
 allocation
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260716075529.3009491-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260716075529.3009491-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/07/16 16:55, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Both virgl_cmd_submit_3d() and rutabaga_cmd_submit_3d() pass the
> guest-controlled cs.size directly to malloc() without bounds checking. A
> malicious guest can set cs.size to an arbitrarily large value, causing
> an OOM abort that crashes the QEMU process.

I rechecked and found vhost-user-gpu is also affected. The changes of 
virgl and rutabaga look good to me.

Regards,
Akihiko Odaki

> 
> Checking cs.size against the descriptor payload length (iov_size) is not
> sufficient: indirect descriptor tables can repeat entries aliasing the
> same guest-physical range, inflating iov_size() to nearly 4 GiB while
> referring to only a small amount of unique memory.
> 
> Instead, cap cs.size at 4 MiB. With 4 KiB pages and QEMU's
> VIRTQUEUE_MAX_SIZE (1024) mapped-iov limit, the Linux virtio driver
> cannot carry more than ~4 MiB of inline command data, so legitimate
> submissions are unaffected.
> 
> Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering support.")
> Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3776
> Reported-by: admin@fluentlogic.org
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/virtio/virtio-gpu.h   | 8 ++++++++
>   hw/display/virtio-gpu-rutabaga.c | 8 ++++++++
>   hw/display/virtio-gpu-virgl.c    | 8 ++++++++
>   3 files changed, 24 insertions(+)
> 
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index f69fc194627..c10bfbd596f 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -299,6 +299,14 @@ struct VirtIOGPURutabaga {
>       struct rutabaga *rutabaga;
>   };
>   
> +/*
> + * With 4 KiB pages and QEMU's VIRTQUEUE_MAX_SIZE (1024) mapped-iov
> + * limit, the largest inline command is ~4 MiB.  Cap submit_3d
> + * allocations to this value to prevent a malicious guest from
> + * triggering an OOM abort via an inflated cs.size field.
> + */
> +#define VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE (4 * 1024 * 1024)
> +
>   #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
>           size_t virtiogpufillcmd_s_ =                                    \
>               iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index 6ff12639012..4d7d7b24592 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -351,6 +351,14 @@ rutabaga_cmd_submit_3d(VirtIOGPU *g,
>       VIRTIO_GPU_FILL_CMD(cs);
>       trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
>   
> +    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: command buffer too large (%u)\n",
> +                      __func__, cs.size);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
>       buf = g_new0(uint8_t, cs.size);
>       s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>                      sizeof(cs), buf, cs.size);
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 60c78af06a4..d9e5b011049 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -607,6 +607,14 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
>       VIRTIO_GPU_FILL_CMD(cs);
>       trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
>   
> +    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: command buffer too large (%u)\n",
> +                      __func__, cs.size);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
>       buf = g_malloc(cs.size);
>       s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>                      sizeof(cs), buf, cs.size);


