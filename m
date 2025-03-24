Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118C1C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twit4-0004vN-7X; Mon, 24 Mar 2025 10:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twit2-0004v3-U4
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:34:45 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twisx-0001gG-LB
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:34:44 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2243803b776so8371775ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742826878; x=1743431678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nEm9CP3auvHRzOoVdXqE50UC+hB306dWmJ7OfPFGVGY=;
 b=Yp3/CqZiV8Sgnsk+MDbVqIUyCJv43vD39NbCtvLgbdkpPJkKdtroSoJHzmB+BP+SYs
 ifZe59FdijeTCfNTLjfPimqa3LP9hCdbPDACkvCGzaSPMaitySaMw4R+njqd/M0pCIBd
 HMpkwpBo6qQe7a3wLoWjmbQawYZJ8WMruUntyMYs0euPszK+PFjTu767eIwfDvuhFSnj
 nObp0B5Am6byiwAqmHZ4J9/7yqQyrli6OE7fTMNlzwz/mB0+187LfYZIVAfqA+7LCEhX
 sWMoRuHt+fWCdtdCZ0wkp/c4iwRuIZQBrQUameTsfA4iPtwHyC3xGrJ1FZvnjWJUFUac
 iIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742826878; x=1743431678;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nEm9CP3auvHRzOoVdXqE50UC+hB306dWmJ7OfPFGVGY=;
 b=QJKwwwmMSgweE89aMg+EedyjqVipg5CB+xpCs2E8O3k4+utVxZiJMam/+Ok8JxzLE+
 OtRsiIignypyHb5ntj+aHPveMv1hfFLUvMNHW34/eMvDwigQoF1x/t6diz97ptmp/3xI
 tJ6JGxUuNjkpb23g6JxZwAYHXsSbrOX/NKSTN62my5GfRZeSO9Z9BUseFGgvXkKMxvd6
 GtBCL9ug8AbVzvXfsvnOtG3rii70JsaMpa9Bn6dN922Jz2WlX90f5WujT6zjrMsCaRPH
 qR6PzzST+YHr5UBUylqAidzYZPlSRxuy/xRWEB1aKyGf/aNKXNcRrzWKMLiVEqpGk4zt
 JrMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJKJou0K52KcJ7NEbvprDYcg3g/foFB1VoS2HdF6U2UzEk8xTZ6j5zgjrwJukhEVNx9DCBN+H8zDsI@nongnu.org
X-Gm-Message-State: AOJu0Yz+mBrrMp8Om/5mmjuDX0drqix7QEcUYgdZW9bX6Knbb4jBUtWr
 SfK5yDHIBdAH0EGEo2Yg7K5ZupJD4p6Ot7q/cGwRMWYNDA24SMoT
X-Gm-Gg: ASbGncuckGrldRpKYng7J7InZG2Xi2bcpCcn7wz2Afk02JzgsBisnQUp+BHyWAovDR7
 z5N4/ctc5yGCH9RH/1+F7/Kob5oA6knC+v6kcOkJ1avTlSS+O9ZEg4XqPJI+lJMAXmPuGNRW25h
 4f4ardvK4J0iUvQm7WHS7sjv05IwlKGCtRapKFC96r/4NvcudJC5qUn74Nr+rUcgxFaoVA7cwp9
 9cSuONmaGtK4IFz7ok1d84rIX0m3lLMyg/qi58OvA0J9F1TKaJL/S+Zoi5vVVlR2WAod788RBpc
 T6WGJJVUR5cSi8U=
X-Google-Smtp-Source: AGHT+IFp+TG3iqheTKQ546DceHf+yD9U8j/w8Ps6OclOfNp/m6Aj19bVidEditbHJNnrR86f/KSfYA==
X-Received: by 2002:a05:6a00:1489:b0:736:3c2b:c38e with SMTP id
 d2e1a72fcca58-739059c8b01mr16707997b3a.13.1742826877757; 
 Mon, 24 Mar 2025 07:34:37 -0700 (PDT)
Received: from [192.168.1.18] ([223.233.81.147])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390618f080sm8288086b3a.176.2025.03.24.07.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 07:34:37 -0700 (PDT)
Message-ID: <49e5e2e1-4715-4949-93d5-b4e0f5425bbf@gmail.com>
Date: Mon, 24 Mar 2025 20:04:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 5/7] vhost: Forward descriptors to guest via packed vqs
From: Sahil Siddiq <icegambit91@gmail.com>
To: eperezma@redhat.com, sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, sahilcdq@proton.me
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-6-sahilcdq@proton.me>
Content-Language: en-US
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <20250324135929.74945-6-sahilcdq@proton.me>
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

I had a few more queries here as well.

On 3/24/25 7:29 PM, Sahil Siddiq wrote:
> Detect when used descriptors are ready for consumption by the guest via
> packed virtqueues and forward them from the device to the guest.
> 
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Changes from v4 -> v5:
> - New commit.
> - vhost-shadow-virtqueue.c:
>    (vhost_svq_more_used): Split into vhost_svq_more_used_split and
>    vhost_svq_more_used_packed.
>    (vhost_svq_enable_notification): Handle split and packed vqs.
>    (vhost_svq_disable_notification): Likewise.
>    (vhost_svq_get_buf): Split into vhost_svq_get_buf_split and
>    vhost_svq_get_buf_packed.
>    (vhost_svq_poll): Use new functions.
> 
>   hw/virtio/vhost-shadow-virtqueue.c | 121 ++++++++++++++++++++++++++---
>   1 file changed, 110 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
> index 126957231d..8430b3c94a 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -463,7 +463,7 @@ static void vhost_handle_guest_kick_notifier(EventNotifier *n)
>       vhost_handle_guest_kick(svq);
>   }
>   
> -static bool vhost_svq_more_used(VhostShadowVirtqueue *svq)
> +static bool vhost_svq_more_used_split(VhostShadowVirtqueue *svq)
>   {
>       uint16_t *used_idx = &svq->vring.used->idx;
>       if (svq->last_used_idx != svq->shadow_used_idx) {
> @@ -475,6 +475,22 @@ static bool vhost_svq_more_used(VhostShadowVirtqueue *svq)
>       return svq->last_used_idx != svq->shadow_used_idx;
>   }
>   
> +static bool vhost_svq_more_used_packed(VhostShadowVirtqueue *svq)
> +{
> +    bool avail_flag, used_flag, used_wrap_counter;
> +    uint16_t last_used_idx, last_used, flags;
> +
> +    last_used_idx = svq->last_used_idx;
> +    last_used = last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);

In the linux kernel, last_used is calculated as:

last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))

...instead of...

last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR)

Isn't the second option good enough if last_used_idx is uint16_t
and VRING_PACKED_EVENT_F_WRAP_CTR is defined as 15.

> +    used_wrap_counter = !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR));
> +
> +    flags = le16_to_cpu(svq->vring_packed.vring.desc[last_used].flags);
> +    avail_flag = !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
> +    used_flag = !!(flags & (1 << VRING_PACKED_DESC_F_USED));
> +
> +    return avail_flag == used_flag && used_flag == used_wrap_counter;
> +}
> +

Also in the implementation of vhost_svq_more_used_split() [1], I haven't
understood why the following condition:

svq->last_used_idx != svq->shadow_used_idx

is checked before updating the value of "svq->shadow_used_idx":

svq->shadow_used_idx = le16_to_cpu(*(volatile uint16_t *)used_idx)

Thanks,
Sahil

[1] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shadow-virtqueue.c#L387


