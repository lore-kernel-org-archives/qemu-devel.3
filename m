Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FDFC531CC
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 05:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnrcV-0001BS-My; Sun, 26 Jul 2026 01:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnrcL-0001AG-Fa
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 01:41:43 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnrcG-0007IA-Bb
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 01:41:39 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66Q5fNid080542
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 26 Jul 2026 14:41:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=d+zoJn2Kq0jcjePZeoZ51t6sm4OCpDbmMketADHJpls=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785044483; v=1;
 b=Fh7PjRLlFyQxToPCby+zTtGjk7dk2AkaDE55N2rVfV9VwI6yCC4a285gEfCmEZ3c
 7IQUTGjjOFYcHrXT98kgRHiAwwFapiiC6+B9xY80+Y3cH21w5d17uyxTWr2oImMm
 m8HsSdxrCIJRJ/s4ETD1M0/yF+O01TbFZD95uCkzb8qBLp54gUK6/O4FYWalo/Fk
 X3iYh8Otp4i3+gZ8OFF04JTeNoUfzT+UfT7wHZVBfS6sQsw2McGti6a4+0anq2xD
 ycGuap8K8WZuwQLvasnJ1yyVKCKRcZ+ReF2TdTXEDWyKxsZ5RNcyaRkTukKX1uvf
 FOvJzlxQvlGJK3b+MoQKYA==
Message-ID: <42417ff6-5f79-4dac-b38d-ae4d772964aa@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 26 Jul 2026 14:41:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/display/virtio-gpu: validate blob iov size
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260725111333.1659833-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725111333.1659833-1-marcandre.lureau@redhat.com>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/07/25 20:13, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> virtio_gpu_resource_create_blob() stores the guest-controlled blob_size
> without checking it against the total size of the iov backing entries.
> Since both values are independently guest-controlled, a malicious guest
> can set blob_size much larger than the actual iov backing. Subsequent
> SET_SCANOUT_BLOB checks bounds against the inflated blob_size, allowing
> a pixman surface to be created over the undersized buffer. Any display
> refresh then reads past the actual allocation, potentially crashing
> QEMU or leaking host memory contents depending on the backing type.
> 
> Validate that the iov backing is at least as large as the declared
> blob_size in create_blob (when nr_entries > 0, since the spec permits
> deferred backing), attach_backing (when attaching to a blob resource),
> and the blob migration load path.
> 
> Fixes: CVE-2026-66021
> Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3945
> Reported-by: "sundayjiang(蒋浩天)" <sundayjiang@tencent.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> v2:
>   - moved validation to attach_backing()
>   - added validation during blob_load()
>   - accept nr_entries == 0 during create_blob()
> ---
>   hw/display/virtio-gpu.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index eac039c3c366..211a529ed720 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -372,6 +372,17 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
>           return;
>       }
>   
> +    if (res->iov_cnt > 0 &&
> +        iov_size(res->iov, res->iov_cnt) < res->blob_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: backing storage smaller than blob size\n",
> +                      __func__);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        virtio_gpu_cleanup_mapping(g, res);
> +        g_free(res);
> +        return;
> +    }
> +
>       virtio_gpu_init_udmabuf(res);
>       QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>   }
> @@ -992,6 +1003,16 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>           return;
>       }
> +
> +    if (res->blob_size &&

This check of res->blob_size is redundant.

> +        iov_size(res->iov, res->iov_cnt) < res->blob_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: backing storage smaller than blob size\n",
> +                      __func__);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        virtio_gpu_cleanup_mapping(g, res);
> +        return;
> +    }
>   }
>   
>   static void
> @@ -1489,6 +1510,13 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
>               res->iov[i].iov_len = qemu_get_be32(f);
>           }
>   
> +        if (iov_size(res->iov, res->iov_cnt) < res->blob_size) {

This check should be applied only when res->iov_cnt > 0, matching the 
create path.

Regards,
Akihiko Odaki

> +            g_free(res->addrs);
> +            g_free(res->iov);
> +            g_free(res);
> +            return -EINVAL;
> +        }
> +
>           if (!virtio_gpu_load_restore_mapping(g, res)) {
>               g_free(res);
>               return -EINVAL;


