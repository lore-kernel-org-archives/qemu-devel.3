Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18CEC369A4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 09:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2oHU-0002a6-8L; Thu, 10 Apr 2025 05:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2oH0-0002K7-77
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 05:32:38 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2oGx-0003dH-CK
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 05:32:37 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so416383f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744277553; x=1744882353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y/3uNvEhSiUtMrMIDAyTCVGfurS1FjC7H0G6McwxFKA=;
 b=R66U7V83DfcGZQ1cZiwXurKo23DTuVfxBO3Jh1KccTXMznKzAGtyYfcM9V7TzL9BTV
 xY36Lu2B+Iy0kC0EIZd+5+k8mUTaj8Q2Z52r7TcoBMTCcAMmJW+JVGkXZOSN2E/I7rws
 vuoWtlSxO9ToIbp7D5UUZQiMMSa1S3lNtwEBUUi/TUDJIV3dYSndPH7FuXBbxlEYOSPG
 5kQh72z+660M/gQxIUMuYVunPg7L8qCVsn2qmiIBkhr9x+pgaMPTwsbmLU2vWuENkoqs
 cPhUR3mzNbuQXxl3OeZazi4Yh3x6VQ8QKei9VOf2qTa77hgRBwXN1NL6kxEfhgHs8hrA
 RyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744277553; x=1744882353;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y/3uNvEhSiUtMrMIDAyTCVGfurS1FjC7H0G6McwxFKA=;
 b=eKw5xXj+aZx1v+FNI2/hjj/Udio+vhE+P7prwsKmYDOaymOJmyfZU7fVSvVF5k0srq
 DWBV/Ls94gPBkFpTw7Xa9Hwx3Mce9jbimDKVV1DpOIs/f6R1yACuoGn/U4YpqSY+squC
 pwtof6ddaM+MpZzQ8/oFfhCmz3okEWr44g4pN1w0nmqt/+6Z2ZZ73P8bM6DA8/3UXvcN
 eRe9lD9OC4Oo57Mre0+eJmjtdGV8vCyij73sMi7fGsEYmT5Cemovrdt2Btmg1Zz0NMlu
 sUGh+tOSGnUhmdt0JzEFhx7rAwrWwnC2PxvXUXJTLujJjOBtlWP0HunFvR1G3LFq5396
 BNCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfqcp2mLSi0Ho8OKzL7SWwvp2sMaonQcH+b9DA954HE+wfMyOX6nWYSLt6byoBuJaRceixEGZmAH9A@nongnu.org
X-Gm-Message-State: AOJu0Yzu8FJTzXjxrwFSTaf2qWq3M61SwCfQwS8re5XoN3JbIgntoJXg
 7yXvcoPrdjh0LkwUFJp9CeAS81GcxD49/48lFcbmeAJ3gLzM2dyJhL6ieTv8aFRYFkHd/cVfBkt
 KI5s=
X-Gm-Gg: ASbGnctORhMCayoZSXR5nHHcUDohSElkM7xvLTNEhPAbhhAwZMqSJ/pT5Eq0jArRQmX
 1YUnC9F7/6Cv1J9IFVXUPlg7rAz/s47IMIlujddLER751R4zs1LarQ0n+HFeZnjzPxHXd0ibCSd
 yo7KtnZbzqKznRDy+EEz+QfDfGkZQYON79JBj9ZslGjpilEhWLaGj6JJ1FR8Y5R++ShalN1Poe8
 opqQfX7rSGRZKVGzUHl24zdpiwNSoRV8uafxS+ipv083M7OCfoIog5xkJyi0QH9/x9Srr2kztl9
 xf8TGAW5f2iMYGNihHg8iY1RTvJ03im8RrHU1OyPF+Eb8fL6nrTa/xK2PaVaNqNga5Tp/3Q8EUB
 Vq0x/ehKREQ7vjoGx8uY9sqo0oSIqKg==
X-Google-Smtp-Source: AGHT+IHW0Vip4Hn4gIrcEUlOfx2f5op5CPMcqQqYMMqIW68O96eIaLqJHyie/mdDgWNFMne5S840Uw==
X-Received: by 2002:a5d:64ed:0:b0:391:41c9:7a8d with SMTP id
 ffacd0b85a97d-39d8fdebf24mr1268856f8f.54.1744277553020; 
 Thu, 10 Apr 2025 02:32:33 -0700 (PDT)
Received: from [10.155.70.213] (224.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.224]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d89389ed6sm4128482f8f.41.2025.04.10.02.32.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 02:32:32 -0700 (PDT)
Message-ID: <59239d14-e50a-4a39-81dd-03580b025dc9@linaro.org>
Date: Thu, 10 Apr 2025 11:32:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Call set_features during reset
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, devel@daynix.com,
 qemu-stable@nongnu.org
References: <20250410-reset-v1-1-751cd0064395@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250410-reset-v1-1-751cd0064395@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Akihiko,

On 10/4/25 09:42, Akihiko Odaki wrote:
> virtio-net expects set_features() will be called when the feature set
> used by the guest changes to update the number of virtqueues. Call it
> during reset as reset clears all features and the queues added for
> VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS will need to be removed.
> 
> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
> Buglink: https://issues.redhat.com/browse/RHEL-73842
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/virtio/virtio.c | 86 +++++++++++++++++++++++++++---------------------------
>   1 file changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 85110bce3744..033e87cdd3b9 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2316,49 +2316,6 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
>       }
>   }
>   
> -void virtio_reset(void *opaque)
> -{
> -    VirtIODevice *vdev = opaque;
> -    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
> -    int i;
> -
> -    virtio_set_status(vdev, 0);
> -    if (current_cpu) {
> -        /* Guest initiated reset */
> -        vdev->device_endian = virtio_current_cpu_endian();
> -    } else {
> -        /* System reset */
> -        vdev->device_endian = virtio_default_endian();
> -    }
> -
> -    if (k->get_vhost) {
> -        struct vhost_dev *hdev = k->get_vhost(vdev);
> -        /* Only reset when vhost back-end is connected */
> -        if (hdev && hdev->vhost_ops) {
> -            vhost_reset_device(hdev);
> -        }
> -    }
> -
> -    if (k->reset) {
> -        k->reset(vdev);
> -    }
> -
> -    vdev->start_on_kick = false;
> -    vdev->started = false;
> -    vdev->broken = false;
> -    vdev->guest_features = 0;
> -    vdev->queue_sel = 0;
> -    vdev->status = 0;
> -    vdev->disabled = false;
> -    qatomic_set(&vdev->isr, 0);
> -    vdev->config_vector = VIRTIO_NO_VECTOR;
> -    virtio_notify_vector(vdev, vdev->config_vector);
> -
> -    for(i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> -        __virtio_queue_reset(vdev, i);
> -    }
> -}
> -
>   void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
>   {
>       if (!vdev->vq[n].vring.num) {
> @@ -3169,6 +3126,49 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>       return ret;
>   }
>   
> +void virtio_reset(void *opaque)
> +{
> +    VirtIODevice *vdev = opaque;
> +    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
> +    int i;
> +
> +    virtio_set_status(vdev, 0);
> +    if (current_cpu) {
> +        /* Guest initiated reset */
> +        vdev->device_endian = virtio_current_cpu_endian();
> +    } else {
> +        /* System reset */
> +        vdev->device_endian = virtio_default_endian();
> +    }
> +
> +    if (k->get_vhost) {
> +        struct vhost_dev *hdev = k->get_vhost(vdev);
> +        /* Only reset when vhost back-end is connected */
> +        if (hdev && hdev->vhost_ops) {
> +            vhost_reset_device(hdev);
> +        }
> +    }
> +
> +    if (k->reset) {
> +        k->reset(vdev);
> +    }
> +
> +    vdev->start_on_kick = false;
> +    vdev->started = false;
> +    vdev->broken = false;
> +    virtio_set_features_nocheck(vdev, 0);

It would be simpler to review having a first patch doing code
movement, then a second one with the addition.

For my own education, are feature sets modifiable at runtime?

> +    vdev->queue_sel = 0;
> +    vdev->status = 0;
> +    vdev->disabled = false;
> +    qatomic_set(&vdev->isr, 0);
> +    vdev->config_vector = VIRTIO_NO_VECTOR;
> +    virtio_notify_vector(vdev, vdev->config_vector);
> +
> +    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> +        __virtio_queue_reset(vdev, i);
> +    }
> +}
> +
>   static void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
>                                                              Error **errp)
>   {
> 
> ---
> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
> change-id: 20250406-reset-5ed5248ee3c1
> 
> Best regards,


