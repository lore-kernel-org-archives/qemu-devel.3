Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4095BC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52bT-00037F-Uv; Fri, 11 Sep 2026 10:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1x52Tp-0002Gu-6c
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:43:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1x52Tl-0001IH-45
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789137793; bh=7qMCWn8GUpGlDk89PGZVv1CxL3YbHVROsZr8nAfm5p4=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=lS0Ub94z73k/1J6eirulwwp6vavLJWzERqdP5L9CjiS3OYHdOoMenFH8thUzcpmhG
 GRkmX3Wm/0jQC2yQ1oDwxs27C3qkp69rUSDQPKHwDshCDkDrzl9wMLpRACFLj2rpcw
 HJTV4nxXxD7R+/5H3DifpcQHvHWm6/UV/Zp1G9Zzo+iF1aKXaJUh78GEFAbLObmNPJ
 5HPy9AS3EB6cR3GtWwlW4RGz1ekkTk8VCbrpELND/oQDQ+A3G/Mia/hALqBRLXu/ZT
 XWOhoatUee3oThIjMGgKziYtmYHhW2Lo0unpofJy5P0p3xi1yO/Ctse9UP/kKz8q/U
 rghVKYymz9DgQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2FC4E1D3D05;
 Fri, 11 Sep 2026 17:43:13 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 230BA425F83;
 Fri, 11 Sep 2026 17:43:46 +0300 (MSK)
Message-ID: <67241f9a-395a-453d-a08e-881d7f6644dc@tls.msk.ru>
Date: Fri, 11 Sep 2026 17:43:46 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] virtio-gpu-virgl: guard new_blob with
 VIRGL_VERSION_MAJORS>=1
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260911140645.56094-1-marcandre.lureau@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260911140645.56094-1-marcandre.lureau@redhat.com>
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

On 9/11/26 17:06, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> virtio_gpu_virgl_resource_new_blob() is only called from
> virgl_cmd_resource_create_blob(), which is guarded by
> VIRGL_VERSION_MAJOR >= 1.
> 
> Fixes: d814b44636d0 ("hw/display/virtio-gpu: introduce virtio_gpu_{simple,virgl}_resource_new()")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu-virgl.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 1c9380e2a6d2..f45571060fea 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -324,6 +324,7 @@ virtio_gpu_virgl_resource_new(uint32_t resource_id, uint32_t width,
>       return res;
>   }
>   
> +#if VIRGL_VERSION_MAJOR >= 1
>   static struct virtio_gpu_virgl_resource *
>   virtio_gpu_virgl_resource_new_blob(uint32_t resource_id, uint64_t blob_size)
>   {
> @@ -335,6 +336,7 @@ virtio_gpu_virgl_resource_new_blob(uint32_t resource_id, uint64_t blob_size)
>   
>       return res;
>   }
> +#endif
>   
>   static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>                                            struct virtio_gpu_ctrl_command *cmd)

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

What's the reason to move it into a separate function, when
there's just one user of this code?

Thanks,

/mjt

