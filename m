Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A996CC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 05:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u37LB-0007Ol-Lc; Fri, 11 Apr 2025 01:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u37L6-0007OE-21
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 01:54:08 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u37L3-0002Zi-RY
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 01:54:07 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22401f4d35aso19009385ad.2
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 22:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1744350844; x=1744955644;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nyT+P1u3hb6IZ6A9lSPIvcPo2eBdLT28pg5FUj2iG8Q=;
 b=qAQWOMCf3QDSrz3U0qou/DEZkhnXIonWd9X//EwQzeU8tJwDHuqIDItLSzmWRFjyr4
 rGDB7n+YavTq2k4ohWWpafi+KAn76oAt1fj98T3PbWAg7che/LefaLfOZu+g+Ek3iE0v
 a1JbCPvLnALohy2kmdniQDRLbEGyOMEWbRTvCidV+PShGsPRIAWgLqcWdM+J9ImGM9it
 wErtllvl+poAZgGJaL49Boe1xqjiHR+vG4O4/qahByLK6p1Sz6emlQblLWHUh0m9PzkW
 smcum/Wx+g4Pnr9HO2kX3AunXzlOq09eNGazR+njFqI9x4sx8G8EsHj3X1yR/hhWjyYo
 VwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744350844; x=1744955644;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nyT+P1u3hb6IZ6A9lSPIvcPo2eBdLT28pg5FUj2iG8Q=;
 b=fQ/JYVPoQUtOAgzpiW63uVmEMK2T27tGOo0jpz2//oG1J/C2Tw9dzLwL8+j25ffeXR
 pY4yc1yo6YQS6N3PMgiEjis8Zu/p9TF2WuWTzvC+NEiMMOMFbjAgKRhFVFRy286jRkfp
 4C9zYQLLmlZ8I+ruLapgn3hEMucN3I3aRLsHNtHXrcDVFn6h9bGYUuHJvLjEWhBgIgGU
 /6ghkHrlcWScZKmY6cCWP5CH0HWW58ffjhFM9G4PxXAxF48VNXho0y6ffV44SXWj2xfH
 pyytUmfq660j4A7QMXWy5wdSDEsBcDeXr1kk7bgAAJUvndDlczn6ovI+f4NjGCzeoXmV
 G+vg==
X-Gm-Message-State: AOJu0Yx5VhMhBpa9cSxr7l3WzUikbDuWXpdvS0ouBYIg64wuR3XTdTLD
 Cu2fpIdm5X3vDOW7KpvAVd7sIBZnGQtqbc0s+WhbygMWwba03PbksppD8iPfVWQ=
X-Gm-Gg: ASbGncvjLotrDiEzmlQbhyIEZxbKI9/VbQH3fKBnHPKo4kVCYgsB74O8SGZzCGt6Wrl
 3wEb/U9cuYQ613uClBTeZEkY/KJrQPZwHWrvlEM/0JMfMdgCYvgtuBOtuOr1iT4QmYRhBZr1sMg
 mfcsq7r9YJwuSlCaHI21dFRzB1QmX992NMW3AbPgmSXVVe2eoT2Be+5z2owDWu4XrKwdBp7r7uu
 kMMncPV0i0KLqUfHujn7uri4uvbwuiOAxJ7UgESPnDXwFTT2lZoo370+l3Agni1FKNHr+wp/yTT
 69aNitnqZmIAGoIwk56BgU/sqQBP9Wss8lhmkgrgR1XJVHMbW7Bhsg==
X-Google-Smtp-Source: AGHT+IH2zzaW4numjERzdl9roZ6J0orkhsW8ITQC/54ZQD5b7gCvWqqTqQmeshjA3rAXIQ11Gs0tfg==
X-Received: by 2002:a17:902:eb8a:b0:220:c813:dfce with SMTP id
 d9443c01a7336-22bea4f273amr22223845ad.39.1744350843777; 
 Thu, 10 Apr 2025 22:54:03 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df2fb171sm4635385a91.34.2025.04.10.22.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 22:54:03 -0700 (PDT)
Message-ID: <7b267f4a-ab18-4626-9db6-f5e5b7deca0b@daynix.com>
Date: Fri, 11 Apr 2025 14:54:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Call set_features during reset
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, qemu-stable@nongnu.org
References: <20250410-reset-v1-1-751cd0064395@daynix.com>
 <20250410034550-mutt-send-email-mst@kernel.org>
 <ece28e1e-ea85-4247-b2b1-54fbd8d2ce37@daynix.com>
 <20250410035935-mutt-send-email-mst@kernel.org>
 <d387d721-a5fc-4661-8a3b-576c34780398@daynix.com>
 <20250410094119-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250410094119-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/04/10 22:45, Michael S. Tsirkin wrote:
> On Thu, Apr 10, 2025 at 05:26:47PM +0900, Akihiko Odaki wrote:
>> On 2025/04/10 17:02, Michael S. Tsirkin wrote:
>>> On Thu, Apr 10, 2025 at 04:54:41PM +0900, Akihiko Odaki wrote:
>>>> On 2025/04/10 16:48, 'Michael S. Tsirkin' via devel wrote:
>>>>> On Thu, Apr 10, 2025 at 04:42:06PM +0900, Akihiko Odaki wrote:
>>>>>> virtio-net expects set_features() will be called when the feature set
>>>>>> used by the guest changes to update the number of virtqueues. Call it
>>>>>> during reset as reset clears all features and the queues added for
>>>>>> VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS will need to be removed.
>>>>>>
>>>>>> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
>>>>>> Buglink: https://issues.redhat.com/browse/RHEL-73842
>>>>>> Cc: qemu-stable@nongnu.org
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>
>>>>> The issue seems specific to virtio net: rset is reset,
>>>>> it is distict from set features.
>>>>> Why not just call the necessary functionality from virtio_net_reset?
>>>>
>>>> set_features is currently implemented only in virtio-net; virtio-gpu-base
>>>> also have a function set but it only has code to trace. If another device
>>>> implements the function in the future, I think the device will also want to
>>>> have it called during reset for the same reason with virtio-net.
>>>>
>>>> virtio_reset() also calls set_status to update the status field so calling
>>>> set_features() is more aligned with the handling of the status field.
>>>
>>> That came to be because writing 0 to status resets the virtio device.
>>> For a while, this was the only way to reset vhost-user so we just
>>> went along with it.
>>
>> It is possible to have code to send a command to write 0 to status to
>> vhost-user in reset(), but calling set_status() in virtio_reset() is more
>> convenient and makes sense as the status is indeed being set to 0. I think
>> the same reasoning applies to features.
> 
> I don't know who makes assumptions that features are only set during
> driver setup, though.
> This will send an extra VHOST_USER_SET_FEATURES message for vhost-user,
> for example.
> I want to have a good reason to add this overhead.

This change won't add an extra VHOST_USER_SET_FEATURES message for 
vhost-user because QEMU sends one when VIRTIO_CONFIG_S_DRIVER_OK is 
being set for status. The only current implementers of set_features() 
are virtio-net and virtio-gpu-base.

We may have more implementers of set_features() in the future though so 
it can be worth to think of the semantics of set_features() before that. 
When thinking of that, I found the current semantics of set_features() 
is not aligned with set_status(), which is confusing. I hope changing 
this in virtio_reset() will eliminate this source of confusion and 
prevents a bug like what virtio-net has in the future.

> 
>>>
>>>
>>>>>
>>>>>
>>>>>> ---
>>>>>>     hw/virtio/virtio.c | 86 +++++++++++++++++++++++++++---------------------------
>>>>>>     1 file changed, 43 insertions(+), 43 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>>>>> index 85110bce3744..033e87cdd3b9 100644
>>>>>> --- a/hw/virtio/virtio.c
>>>>>> +++ b/hw/virtio/virtio.c
>>>>>> @@ -2316,49 +2316,6 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
>>>>>>         }
>>>>>>     }
>>>>>> -void virtio_reset(void *opaque)
>>>>>> -{
>>>>>> -    VirtIODevice *vdev = opaque;
>>>>>> -    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>>>>>> -    int i;
>>>>>> -
>>>>>> -    virtio_set_status(vdev, 0);
>>>>>> -    if (current_cpu) {
>>>>>> -        /* Guest initiated reset */
>>>>>> -        vdev->device_endian = virtio_current_cpu_endian();
>>>>>> -    } else {
>>>>>> -        /* System reset */
>>>>>> -        vdev->device_endian = virtio_default_endian();
>>>>>> -    }
>>>>>> -
>>>>>> -    if (k->get_vhost) {
>>>>>> -        struct vhost_dev *hdev = k->get_vhost(vdev);
>>>>>> -        /* Only reset when vhost back-end is connected */
>>>>>> -        if (hdev && hdev->vhost_ops) {
>>>>>> -            vhost_reset_device(hdev);
>>>>>> -        }
>>>>>> -    }
>>>>>> -
>>>>>> -    if (k->reset) {
>>>>>> -        k->reset(vdev);
>>>>>> -    }
>>>>>> -
>>>>>> -    vdev->start_on_kick = false;
>>>>>> -    vdev->started = false;
>>>>>> -    vdev->broken = false;
>>>>>> -    vdev->guest_features = 0;
>>>>>> -    vdev->queue_sel = 0;
>>>>>> -    vdev->status = 0;
>>>>>> -    vdev->disabled = false;
>>>>>> -    qatomic_set(&vdev->isr, 0);
>>>>>> -    vdev->config_vector = VIRTIO_NO_VECTOR;
>>>>>> -    virtio_notify_vector(vdev, vdev->config_vector);
>>>>>> -
>>>>>> -    for(i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>>>>>> -        __virtio_queue_reset(vdev, i);
>>>>>> -    }
>>>>>> -}
>>>>>> -
>>>>>>     void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
>>>>>>     {
>>>>>>         if (!vdev->vq[n].vring.num) {
>>>>>> @@ -3169,6 +3126,49 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>>>>>>         return ret;
>>>>>>     }
>>>>>> +void virtio_reset(void *opaque)
>>>>>> +{
>>>>>> +    VirtIODevice *vdev = opaque;
>>>>>> +    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>>>>>> +    int i;
>>>>>> +
>>>>>> +    virtio_set_status(vdev, 0);
>>>>>> +    if (current_cpu) {
>>>>>> +        /* Guest initiated reset */
>>>>>> +        vdev->device_endian = virtio_current_cpu_endian();
>>>>>> +    } else {
>>>>>> +        /* System reset */
>>>>>> +        vdev->device_endian = virtio_default_endian();
>>>>>> +    }
>>>>>> +
>>>>>> +    if (k->get_vhost) {
>>>>>> +        struct vhost_dev *hdev = k->get_vhost(vdev);
>>>>>> +        /* Only reset when vhost back-end is connected */
>>>>>> +        if (hdev && hdev->vhost_ops) {
>>>>>> +            vhost_reset_device(hdev);
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    if (k->reset) {
>>>>>> +        k->reset(vdev);
>>>>>> +    }
>>>>>> +
>>>>>> +    vdev->start_on_kick = false;
>>>>>> +    vdev->started = false;
>>>>>> +    vdev->broken = false;
>>>>>> +    virtio_set_features_nocheck(vdev, 0);
>>>>>> +    vdev->queue_sel = 0;
>>>>>> +    vdev->status = 0;
>>>>>> +    vdev->disabled = false;
>>>>>> +    qatomic_set(&vdev->isr, 0);
>>>>>> +    vdev->config_vector = VIRTIO_NO_VECTOR;
>>>>>> +    virtio_notify_vector(vdev, vdev->config_vector);
>>>>>> +
>>>>>> +    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>>>>>> +        __virtio_queue_reset(vdev, i);
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>>     static void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
>>>>>>                                                                Error **errp)
>>>>>>     {
>>>>>>
>>>>>> ---
>>>>>> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
>>>>>> change-id: 20250406-reset-5ed5248ee3c1
>>>>>>
>>>>>> Best regards,
>>>>>> -- 
>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>
>>>
> 


