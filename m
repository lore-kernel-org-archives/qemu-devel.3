Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0ABC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xqU-0002K4-57; Fri, 11 Sep 2026 05:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1x4xqR-0002Jl-U8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:46:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1x4xqP-0006Gj-1F
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789119970; bh=BK2hCFQQhmCtetxcEo+Jtn8TYaxYUAPf4NQBY4r3WEk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mWzIfesX45yQcrs/nil5gBGauy1zOeG84ipy3hw5H0TmFHRVwBt4CAq03uEY8nFK4
 Zjhbz7m/7LiLCRGZsHU7ySzBexRK9zeUc48rvbcAN7kC2cv7Y4QXSKQ2+aPEWHhOpQ
 SZB2Bh+Xzno1mlWjTGOb617Vgjs2V8Qcsr05LreUs3f0FzCo18YsSnVH004vMtaAMb
 qknXOOGpEX6zfQoXFHJ6jFNq0RKCWpe3C7CW240ihQQ3/BHvi1rjwcfHyTkqkpXvt0
 lcFn0FR8M6ogbEPtTlnN+nT9kyQ/eXDojDkzJN4rG6os4beQiusIHZbYI47/n1n0+e
 +LfezYWsh/kFg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7062E1D3B4E;
 Fri, 11 Sep 2026 12:46:10 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EC1C4425DA6;
 Fri, 11 Sep 2026 12:46:42 +0300 (MSK)
Message-ID: <07a144fb-e8c0-4b79-aa53-1649358a01da@tls.msk.ru>
Date: Fri, 11 Sep 2026 12:46:42 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [GIT PULL 03/24] hw/display/virtio-gpu: introduce
 virtio_gpu_{simple,virgl}_resource_new()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
 <20260910-virtio-gpu-cleanup-v1-3-ccb8927a671e@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-3-ccb8927a671e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

On 9/10/26 16:29, Marc-André Lureau wrote:
> All allocation sites used g_new0() which zero-initializes fields.
> However share_handle must be SHAREABLE_NONE (-1 on Unix, NULL on
> Windows) and dmabuf_fd must be -1, not 0. Centralize allocation and
> field initialization in new constructors fix this and reduce code
> duplication.
> 
> This fixes -display dbus with virtio-gpu blob resources. The other
> end is currently receiving qemu fd 0.
> 
> Fixes: 5f899c34af1d (“virtio-gpu: allocate shareable 2d resources on !win32”)
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c

> +static struct virtio_gpu_virgl_resource *
> +virtio_gpu_virgl_resource_new_blob(uint32_t resource_id...

> @@ -853,10 +872,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
>           return;
>       }
>   
> -    res = g_new0(struct virtio_gpu_virgl_resource, 1);
> -    res->base.resource_id = cblob.resource_id;
> -    res->base.blob_size = cblob.size;
> -    res->base.dmabuf_fd = -1;
> +    res = virtio_gpu_virgl_resource_new_blob(cblob.resource_id, cblob.size);
>   
>       if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
>           ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
The newly introduced virtio_gpu_virgl_resource_new_blob() (static) has just one user,
in virgl_cmd_resource_create_blob().  And the latter is guarded with

  #if VIRGL_VERSION_MAJOR >= 1
  #endif

So if this condition is unmet, there's a build failure:

hw/display/virtio-gpu-virgl.c:328:1: error: ‘virtio_gpu_virgl_resource_new_blob’ defined but not used

So we either should not move this single place of code into its own function,
or we should guard this function with the same #if.

Thanks,

/mjt

