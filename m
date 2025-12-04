Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE8ED1D87B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 07:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR3Xe-0001tI-VA; Thu, 04 Dec 2025 02:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vR3XS-0001qp-5m
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:14:08 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vR3XP-0004pr-5E
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:14:05 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5B47DReH066733
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Dec 2025 16:13:49 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=/iAQLPOyNneM21DlFZSbY5znUEjTfQ4WSqfaIGIwRr8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1764832429; v=1;
 b=j4NfrG9SLPK4pSkuPC/zuWIpqfWhGIpGVSG6+zxoxgxn6sqmkfYkRK7XU/f1guOV
 B3kQUKRkKttLziC1B9VRo3OlFFrK/MdWBjkkA3Tc6whxYb7bBB+w9c0BrbfPwzTD
 99dRKseWIRAMjjuX2p1B6DAeKl+Dy5Y7CYaaHUwdWKFcDPS0jA79ICVhmJ69b6T5
 i3vklqjPsfMtGqscWyj4LuBBPqWlnQ/TVffxfMgjkVG2tnybTFA1oZgAUOZ6vWXI
 YLZmsO+hbmbVLJbIjricFF3XhjoAWCtj0DXZ1fcsNwabbCIdIvNN9XjU+i608VcE
 P0JFvHBdvDv88ZwCHQxTEw==
Message-ID: <32a0ad66-5c42-4d98-8c5d-0a601e31b76a@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 4 Dec 2025 16:13:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/7] virtio-gpu-virgl: update virglrenderer defines
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-5-j@getutm.app>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251203040754.94487-5-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/12/03 13:07, Joelle van Dyne wrote:
> In order to support additional native texture types, we need to update the
> defines in virglrenderer. The changes are backwards compatible and so
> builds should work with either the new version or the old version.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   hw/display/virtio-gpu-virgl.c | 28 +++++++++++++++++++++++++---
>   1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index d0e6ad4b17..36c670f988 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -24,6 +24,8 @@
>   
>   #include <virglrenderer.h>
>   
> +#define SUPPORTED_VIRGL_INFO_EXT_VERSION (1)

This naming is a bit confusing because version 0 is also supported.

> +
>   struct virtio_gpu_virgl_resource {
>       struct virtio_gpu_simple_resource base;
>       MemoryRegion *mr;
> @@ -441,12 +443,30 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>           memset(&ext, 0, sizeof(ext));
>           ret = virgl_renderer_resource_get_info_ext(ss.resource_id, &ext);
>           info = ext.base;
> +        /* fallback to older version */
>           native = (ScanoutTextureNative){
>               .type = ext.d3d_tex2d ? SCANOUT_TEXTURE_NATIVE_TYPE_D3D :
>                                       SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
>               .u.d3d_tex2d = ext.d3d_tex2d,
>           };
> -#else
> +#if VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION >= SUPPORTED_VIRGL_INFO_EXT_VERSION
> +        if (ext.version >= VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION) {
> +            switch (ext.native_type) {
> +            case VIRGL_NATIVE_HANDLE_NONE:
> +            case VIRGL_NATIVE_HANDLE_D3D_TEX2D: {
> +                /* already handled above */
> +                break;
> +            }
> +            default: {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                            "%s: unsupported native texture type %d\n",
> +                            __func__, ext.native_type);

It is not an error condition; the d3d_tex2d field is an optional hint 
that allows zero-copy inter-process sharing and the tex_id field is used 
if it is missing or inter-process sharing is unnecessary. It should be 
fine to dismiss the native handle unless the semantic changes.

Regards,
Akihiko Odaki

> +                break;
> +            }
> +            }
> +        }
> +#endif
> +#else /* VIRGL_VERSION_MAJOR < 1 */
>           memset(&info, 0, sizeof(info));
>           ret = virgl_renderer_resource_get_info(ss.resource_id, &info);
>   #endif
> @@ -1169,11 +1189,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>           virtio_gpu_3d_cbs.get_egl_display = virgl_get_egl_display;
>       }
>   #endif
> -#ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
>       if (qemu_egl_angle_native_device) {
> +#if defined(VIRGL_RENDERER_NATIVE_SHARE_TEXTURE)
> +        flags |= VIRGL_RENDERER_NATIVE_SHARE_TEXTURE;
> +#elif defined(VIRGL_RENDERER_D3D11_SHARE_TEXTURE) && defined(WIN32)
>           flags |= VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
> -    }
>   #endif
> +    }
>   #if VIRGL_VERSION_MAJOR >= 1
>       if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
>           flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;


