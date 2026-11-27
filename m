Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7E606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=bS3JSK7B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwmv-0006HO-6U; Fri, 27 Nov 2026 09:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1xWwmt-0006F1-2D
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:18:55 -0500
Received: from sender6-op-o11.zoho.com ([165.173.180.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1xWwmr-000848-7r
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:18:54 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1795789119; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cZb9nuijX+IYnFyskFAuhJ6tAcsrZm8r2S4gasmylcGiIE7V8gqvzNT1nR6Qqv0dnpzxby1wSnmhpKeqvaxkA/qg2L1X35XR3p6PpxUDAxuOKxG64WtEt+++1ruwuH5hz7EDRFJA8n2qp1xOUqrh2oNWLUdWN3lkzSMb1IRzK5c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795789119;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qQ5jPG6VJSj90YyYlCpvOgtdhphd4aruiMM3SUtklKQ=; 
 b=XWVcmRVQ60ZQowchbFkLjnVhKgGH7Da7ezMv1p9vFoeEW2tpyK+OzDLnB1Jgb9SQnelcXcJzSwxkmU0+oPfdV6Fgw7MyaHgOe1/cBvCk9FaXlCIpSckYPqtAH/vJ401bTKGZRGpEHUbK3X8hZSHA2lERflC8x37XzafFeaQTKls=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=bS3JSK7B/MlECqCVdaRNWtPvQLoQIpgdEFedI/cGHb8VfMmUuphYXUjqv3fENpJaNRYNnWeQ87E2JOIDNYQfYoqfCYghjk0r55r+sAuiWSEwvLsJcdOsUbHjXN8bBJ/0lZqSZFLcC+Q4oRbSX7ygmUDEqtcLWnrkjalqWC9J6+Y=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=qQ5jPG6VJSj90YyYlCpvOgtdhphd4aruiMM3SUtklKQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795789117709877.6886875865706;
 Fri, 27 Nov 2026 06:18:37 -0800 (PST)
Message-ID: <ae203d4a-691f-4cdf-bbe0-da1b2a28f823@collabora.com>
Date: Fri, 27 Nov 2026 17:18:34 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 2/5] virtio-gpu: Add ROCm capability support
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp, Ray.Huang@amd.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20261106082711.813336-1-honghuan@amd.com>
 <20261106082711.813336-3-honghuan@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261106082711.813336-3-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=165.173.180.11;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender6-op-o11.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 11:27, Honglei Huang wrote:
> Add support for ROCm (Radeon Open Compute) capability in virtio-gpu.
> This enables GPU compute workloads using AMD's ROCm platform through the
> virtio-gpu interface.
> 
> Changes include:
> - Add "rocm" property to virtio-gpu-gl device
> - Define VIRTIO_GPU_FLAG_ROCM_ENABLED flag
> - Enable VIRGL_RENDERER_USE_ROCM flag when ROCm is enabled
> - Add virtio_gpu_rocm_enabled() helper macro
> 
> This allows guests to detect and utilize ROCm capabilities through the
> virtio-gpu device when the feature is enabled.
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>   hw/display/virtio-gpu-gl.c     |  2 ++
>   hw/display/virtio-gpu-virgl.c  | 17 +++++++++++++++++
>   include/hw/virtio/virtio-gpu.h |  3 +++
>   3 files changed, 22 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 2b7a41c4664..d1f11a5bb92 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -170,6 +170,8 @@ static const Property virtio_gpu_gl_properties[] = {
>                       VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
>       DEFINE_PROP_BIT("drm_native_context", VirtIOGPU, parent_obj.conf.flags,
>                       VIRTIO_GPU_FLAG_DRM_ENABLED, false),
> +    DEFINE_PROP_BIT("rocm", VirtIOGPU, parent_obj.conf.flags,
> +                    VIRTIO_GPU_FLAG_ROCM_ENABLED, false),
>   };
>   
>   static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index f71f287d948..f3512337d05 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1514,6 +1514,14 @@ static int virtio_gpu_virgl_init(VirtIOGPU *g)
>               return -EINVAL;
>           }
>       }
> +    if (virtio_gpu_rocm_enabled(g->parent_obj.conf)) {
> +#ifdef VIRGL_RENDERER_USE_ROCM
> +        flags |= VIRGL_RENDERER_USE_ROCM;
> +#else
> +        error_report("rocm requires a ROCm-enabled virglrenderer");
> +        return -EINVAL;
> +#endif
> +    }
>   #endif
>   
>       ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
> @@ -1615,5 +1623,14 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
>           }
>       }
>   
> +    if (virtio_gpu_rocm_enabled(g->parent_obj.conf)) {
> +        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_ROCM,
> +                                   &capset_max_ver,
> +                                   &capset_max_size);
> +        if (capset_max_size) {
> +            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_ROCM);
> +        }
> +    }
> +
>       return capset_ids;
>   }
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 631dfc63a4d..3c5119ce0e4 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -112,6 +112,7 @@ enum virtio_gpu_base_conf_flags {
>       VIRTIO_GPU_FLAG_VENUS_ENABLED,
>       VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
>       VIRTIO_GPU_FLAG_DRM_ENABLED,
> +    VIRTIO_GPU_FLAG_ROCM_ENABLED,
>   };
>   
>   #define virtio_gpu_virgl_enabled(_cfg) \
> @@ -136,6 +137,8 @@ enum virtio_gpu_base_conf_flags {
>       (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
>   #define virtio_gpu_drm_enabled(_cfg) \
>       (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DRM_ENABLED))
> +#define virtio_gpu_rocm_enabled(_cfg) \
> +    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_ROCM_ENABLED))
>   
>   struct virtio_gpu_base_conf {
>       uint32_t max_outputs;

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

