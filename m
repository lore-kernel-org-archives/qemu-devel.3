Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6815606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=EcWbhkPh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwcX-0003RM-GO; Fri, 27 Nov 2026 09:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1xWwc8-0003IB-8p
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:07:53 -0500
Received: from sender5-op-o11.zoho.com ([165.173.182.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1xWwc6-0001Nf-4X
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:07:47 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1795788450; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SDjmWji5MWh1eqrJOmsQHfokDWwSRK3TwrcMEblP3nPUd7ylg+PX/WlXCoAp6WQzzsiP1GnXFNKa92ON0l4OZJ7ZUlBZol1DJXcbiI/CeAqWbuX+T0zPX8AM87os0sg00L8xOmFu5BYv+nAKu5eES7FEtuG9JJxljpjsFCZTLak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795788450;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Osor7OOhlK3dgsOdZDsGjnx0SOCP3mLYtPDTjDWAX8Y=; 
 b=cX8mnyN0vEKzyjhWLmeieJJYJQ5qaV2EpAkLBXwi45n1YER6HT/pcaA19tbG80PD7yt0XpiSn5kPjYx2B0KqQRmkQ4WUXviy/RqUueJc7LE4Ds1PeTFEBKP8Uoh28c/kfX52GrpGoj/pUChMxXqZB3dndGcGYvpvzj8npqrvLGY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=EcWbhkPh5YeGSXq3krzO9vvh8X4iw2Ku2Mny7eVR4KVH+rocqmQjccKGNKYOMdv573cSQTAx79Qns9eoaMpK2TW2qcopBpuJhIkfieng9K80RccqeLj1s8GVdTTBzQQOtpTLv0aIvqWWQ6D1GGJ4dz2iDVH/4roJp7rxFlB0zlU=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=Osor7OOhlK3dgsOdZDsGjnx0SOCP3mLYtPDTjDWAX8Y=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795788449198878.2946255035238;
 Fri, 27 Nov 2026 06:07:29 -0800 (PST)
Message-ID: <8aec6ee1-bde8-48a9-9332-89164b622133@collabora.com>
Date: Fri, 27 Nov 2026 17:07:25 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 5/5] virtio-gpu: advertise readonly blobs for ROCm
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp, Ray.Huang@amd.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20261106082711.813336-1-honghuan@amd.com>
 <20261106082711.813336-6-honghuan@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261106082711.813336-6-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=165.173.182.11;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender5-op-o11.zoho.com
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
> Mark readonly blobs available when the ROCm capset is present, and
> advertise the feature only for ROCm devices with blob support enabled.
> Treat readonly registration support as part of the paired ROCm backend.
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>   hw/display/virtio-gpu-base.c   | 4 ++++
>   hw/display/virtio-gpu-virgl.c  | 3 +++
>   include/hw/virtio/virtio-gpu.h | 3 +++
>   3 files changed, 10 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 270fbaae102..b6333e67c0f 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -269,6 +269,10 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
>       }
>       if (virtio_gpu_blob_enabled(g->conf)) {
>           features |= (1 << VIRTIO_GPU_F_RESOURCE_BLOB);
> +        if (virtio_gpu_rocm_enabled(g->conf) &&
> +            virtio_gpu_blob_readonly_enabled(g->conf)) {
> +            features |= (1 << VIRTIO_GPU_F_BLOB_READONLY);
> +        }
>       }
>       if (virtio_gpu_context_init_enabled(g->conf)) {
>           features |= (1 << VIRTIO_GPU_F_CONTEXT_INIT);
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index f3512337d05..87ee7ac57c4 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1593,6 +1593,7 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
>       uint32_t capset_max_ver, capset_max_size;
>       GArray *capset_ids;
>   
> +    g->parent_obj.conf.flags &= ~(1 << VIRTIO_GPU_FLAG_BLOB_READONLY_ENABLED);
>       capset_ids = g_array_new(false, false, sizeof(uint32_t));
>   
>       /* VIRGL is always supported. */
> @@ -1629,6 +1630,8 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
>                                      &capset_max_size);
>           if (capset_max_size) {
>               virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_ROCM);
> +            g->parent_obj.conf.flags |=
> +                1 << VIRTIO_GPU_FLAG_BLOB_READONLY_ENABLED;
>           }
>       }
>   
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 3c5119ce0e4..dacf70b41a6 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -113,6 +113,7 @@ enum virtio_gpu_base_conf_flags {
>       VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
>       VIRTIO_GPU_FLAG_DRM_ENABLED,
>       VIRTIO_GPU_FLAG_ROCM_ENABLED,
> +    VIRTIO_GPU_FLAG_BLOB_READONLY_ENABLED,
>   };
>   
>   #define virtio_gpu_virgl_enabled(_cfg) \
> @@ -139,6 +140,8 @@ enum virtio_gpu_base_conf_flags {
>       (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DRM_ENABLED))
>   #define virtio_gpu_rocm_enabled(_cfg) \
>       (_cfg.flags & (1 << VIRTIO_GPU_FLAG_ROCM_ENABLED))
> +#define virtio_gpu_blob_readonly_enabled(_cfg) \
> +    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_BLOB_READONLY_ENABLED))
>   
>   struct virtio_gpu_base_conf {
>       uint32_t max_outputs;

The RO flag is generic, it shouldn't be made specific to ROCm and should 
always present. Should be up to a context type how to handle this flag, 
AFAICT. Any reason it shouldn't be generic?

-- 
Best regards,
Dmitry

