Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B851C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twiZT-0007Ue-RQ; Mon, 24 Mar 2025 10:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiZS-0007U8-9p
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:14:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiZQ-0006D4-6P
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:14:30 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22435603572so77842485ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742825666; x=1743430466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/1QXAsBf/kG47KGLqoBvUDdn+FdykaRCJkXL/V9RtUE=;
 b=VtFts/+14G32hQp9gUKBcGAh09zEJMXPBk3C73eyFtLsFpgTM+TBhbziOa2UAgRB2j
 3mONJMHNvUYmRvwiQxvodAkVdfbhs4+pu7x0oopzuFOGYEX/RDgrWPIcZkxcqPqksCfN
 YqkKjUvgQuNUV5FggCv4EbmWh3s57r6tU8H7rwGbn52G7Lypx/I0LMwt/ciKdpyUm5TI
 MfX8M4+Zuf19mAd/zbPkWuOpPQp++2y0zuE3k1MA1vGUNwLnwm9lnUs5ycBchnZ70xsx
 PWoMl5KVd12Op73pVYSqm0N1NNgXb600cWDMAFpJfj5OugmdDd5C4dpwKjZkCjsWDAJk
 B+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742825666; x=1743430466;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/1QXAsBf/kG47KGLqoBvUDdn+FdykaRCJkXL/V9RtUE=;
 b=p5waBcfpxbGd9Hzy7KKvwgQm57n7fMgupT7DIqbKDSIdOKh/GJpFAM+ia3Nkff7UL8
 2cxLd/tIbqRCMiwFehFW/giHeTVcMHkRAG/MoBl3/NahjsY9LJv6r4vTlyuRXtHQPehf
 /OoDkuma4VVbbISuXMIr9UMIF80/3AaDPPb4iz3B2EQgF4BTyo+Znqw78pcRJBr6OirF
 WwW2iU+1uIuPGEnV2ULUAltbPkW9XX9qBeKo4u4UJS90klXsXmsb184DJf9gWJyYTVbB
 ibqx7hxjiGCZ0MWyR3s8Y8DoUyXuDxePwNRbcWxS8LDz56ZixZQSAp1n20XloVRdQAsw
 aocQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmz/7P7yRunJNOA5p9q14gr2K+6NAd1CLzyWjH0OZhVXt5PEg9jkd4r1QdURxUIKh6NZZjkbwVx5IK@nongnu.org
X-Gm-Message-State: AOJu0YwnClGuVwb2RMALSKths7uC4OTwqPcUI/ZBg3w1Iy9wxpqvW793
 b7HmsLGPT5eIyKi2oOfA1VQLSkyuppWRk9dWJeUM6qH1n5Jq86aGU1FzYQ==
X-Gm-Gg: ASbGnctdwWxCerb7d5ZtCV2rX0M+ahu0rKjC2HLuS0wRUljxGpxmmPwa9j5ZyrMdeTd
 pbs6MM5z1fsF08jEB18C0yRaR3JmJ06XRDHeUYDFiwQT31+p9FTPXeFoCXvQNge1k/mHADOBBlb
 f9XtRpxV4/9XLIs0QP35OsHKryE0Ny0mEMHYjD5buVrjDSr1DEXJaT7MdZZAE/ZtIqVmhfrSCdp
 L2nWr8kL+WyPg2cDhYfQTtzreMZ4VETZEb5fjb3FqP1uzQRwjCyAx9l185itv9g+575x4CAFCls
 gXO+7RuB+KaE3b0TpZ9ojwy/09qga4icx311bd+Nqz44k3rUqanH/GufWUVTXc3COeaGzvOgNMN
 NPJx39k6oGkRl
X-Google-Smtp-Source: AGHT+IGJbwfGBev3WEq5Vq5PE0WMQ369RldooHKsG4X54Tk2lk4AUx9S90Fov2ImiSdmMs1NZp+UMA==
X-Received: by 2002:a17:902:da86:b0:224:1001:6787 with SMTP id
 d9443c01a7336-22780c53fbbmr230477175ad.4.1742825666166; 
 Mon, 24 Mar 2025 07:14:26 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d?
 ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811b2ae1sm71093875ad.114.2025.03.24.07.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 07:14:25 -0700 (PDT)
Message-ID: <a878b49b-0d00-483a-a5b6-27d048c4ebc7@gmail.com>
Date: Mon, 24 Mar 2025 19:44:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 3/7] vhost: Forward descriptors to device via packed SVQ
From: Sahil Siddiq <icegambit91@gmail.com>
To: eperezma@redhat.com, sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, sahilcdq@proton.me
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-4-sahilcdq@proton.me>
Content-Language: en-US
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <20250324135929.74945-4-sahilcdq@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

I had a few queries here.

On 3/24/25 7:29 PM, Sahil Siddiq wrote:
> Implement the insertion of available buffers in the descriptor area of
> packed shadow virtqueues. It takes into account descriptor chains, but
> does not consider indirect descriptors.
> 
> Enable the packed SVQ to forward the descriptors to the device.
> 
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Changes from v4 -> v5:
> - This was commit #2 in v4. This has been reordered to commit #3
>    based on review comments.
> - vhost-shadow-virtqueue.c:
>    (vhost_svq_valid_features): Move addition of enums to commit #6
>    based on review comments.
>    (vhost_svq_add_packed): Set head_idx to buffer id instead of vring's
>    index.
>    (vhost_svq_kick): Split into vhost_svq_kick_split and
>    vhost_svq_kick_packed.
>    (vhost_svq_add): Use new vhost_svq_kick_* functions.
> 
>   hw/virtio/vhost-shadow-virtqueue.c | 117 +++++++++++++++++++++++++++--
>   1 file changed, 112 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
> index 4f74ad402a..6e16cd4bdf 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -193,10 +193,83 @@ static void vhost_svq_add_split(VhostShadowVirtqueue *svq,
>       /* Update the avail index after write the descriptor */
>       smp_wmb();
>       avail->idx = cpu_to_le16(svq->shadow_avail_idx);
> +}
> +
> +/**
> + * Write descriptors to SVQ packed vring
> + *
> + * @svq: The shadow virtqueue
> + * @out_sg: The iovec to the guest
> + * @out_num: Outgoing iovec length
> + * @in_sg: The iovec from the guest
> + * @in_num: Incoming iovec length
> + * @sgs: Cache for hwaddr
> + * @head: Saves current free_head
> + */
> +static void vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> +                                 const struct iovec *out_sg, size_t out_num,
> +                                 const struct iovec *in_sg, size_t in_num,
> +                                 hwaddr *sgs, unsigned *head)
> +{
> +    uint16_t id, curr, i, head_flags = 0, head_idx;
> +    size_t num = out_num + in_num;
> +    unsigned n;
> +
> +    struct vring_packed_desc *descs = svq->vring_packed.vring.desc;
> +
> +    head_idx = svq->vring_packed.next_avail_idx;

Since "svq->vring_packed.next_avail_idx" is part of QEMU internals and not
stored in guest memory, no endianness conversion is required here, right?

> +    i = head_idx;
> +    id = svq->free_head;
> +    curr = id;
> +    *head = id;

Should head be the buffer id or the idx of the descriptor ring where the
first descriptor of a descriptor chain is inserted?

> +    /* Write descriptors to SVQ packed vring */
> +    for (n = 0; n < num; n++) {
> +        uint16_t flags = cpu_to_le16(svq->vring_packed.avail_used_flags |
> +                                     (n < out_num ? 0 : VRING_DESC_F_WRITE) |
> +                                     (n + 1 == num ? 0 : VRING_DESC_F_NEXT));
> +        if (i == head_idx) {
> +            head_flags = flags;
> +        } else {
> +            descs[i].flags = flags;
> +        }
> +
> +        descs[i].addr = cpu_to_le64(sgs[n]);
> +        descs[i].id = id;
> +        if (n < out_num) {
> +            descs[i].len = cpu_to_le32(out_sg[n].iov_len);
> +        } else {
> +            descs[i].len = cpu_to_le32(in_sg[n - out_num].iov_len);
> +        }
> +
> +        curr = cpu_to_le16(svq->desc_next[curr]);
> +
> +        if (++i >= svq->vring_packed.vring.num) {
> +            i = 0;
> +            svq->vring_packed.avail_used_flags ^=
> +                1 << VRING_PACKED_DESC_F_AVAIL |
> +                1 << VRING_PACKED_DESC_F_USED;
> +        }
> +    }
>   
> +    if (i <= head_idx) {
> +        svq->vring_packed.avail_wrap_counter ^= 1;
> +    }
> +
> +    svq->vring_packed.next_avail_idx = i;
> +    svq->shadow_avail_idx = i;
> +    svq->free_head = curr;
> +
> +    /*
> +     * A driver MUST NOT make the first descriptor in the list
> +     * available before all subsequent descriptors comprising
> +     * the list are made available.
> +     */
> +    smp_wmb();
> +    svq->vring_packed.vring.desc[head_idx].flags = head_flags;
>   }
>   
> -static void vhost_svq_kick(VhostShadowVirtqueue *svq)
> +static void vhost_svq_kick_split(VhostShadowVirtqueue *svq)
>   {
>       bool needs_kick;
>   
> @@ -209,7 +282,8 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
>       if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
>           uint16_t avail_event = le16_to_cpu(
>                   *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]));
> -        needs_kick = vring_need_event(avail_event, svq->shadow_avail_idx, svq->shadow_avail_idx - 1);
> +        needs_kick = vring_need_event(avail_event, svq->shadow_avail_idx,
> +                     svq->shadow_avail_idx - 1);
>       } else {
>           needs_kick =
>                   !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_NO_NOTIFY));
> @@ -222,6 +296,30 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
>       event_notifier_set(&svq->hdev_kick);
>   }
>   
> +static void vhost_svq_kick_packed(VhostShadowVirtqueue *svq)
> +{
> +    bool needs_kick;
> +
> +    /*
> +     * We need to expose the available array entries before checking
> +     * notification suppressions.
> +     */
> +    smp_mb();
> +
> +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> +        return;
> +    } else {
> +        needs_kick = (svq->vring_packed.vring.device->flags !=
> +                      cpu_to_le16(VRING_PACKED_EVENT_FLAG_DISABLE));
> +    }
> +
> +    if (!needs_kick) {
> +        return;
> +    }
> +
> +    event_notifier_set(&svq->hdev_kick);
> +}
> +
>   /**
>    * Add an element to a SVQ.
>    *
> @@ -258,13 +356,22 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
>           return -EINVAL;
>       }
>   
> -    vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> -                        in_num, sgs, &qemu_head);
> +    if (svq->is_packed) {
> +        vhost_svq_add_packed(svq, out_sg, out_num, in_sg,
> +                             in_num, sgs, &qemu_head);
> +    } else {
> +        vhost_svq_add_split(svq, out_sg, out_num, in_sg,
> +                            in_num, sgs, &qemu_head);
> +    }
>   
>       svq->num_free -= ndescs;
>       svq->desc_state[qemu_head].elem = elem;
>       svq->desc_state[qemu_head].ndescs = ndescs;

*head in vhost_svq_add_packed() is stored in "qemu_head" here.

> -    vhost_svq_kick(svq);
> +    if (svq->is_packed) {
> +        vhost_svq_kick_packed(svq);
> +    } else {
> +        vhost_svq_kick_split(svq);
> +    }
>       return 0;
>   }
>   

Thanks,
Sahil

