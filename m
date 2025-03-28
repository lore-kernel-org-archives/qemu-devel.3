Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF14C3600C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 05:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty26R-0004NQ-UB; Fri, 28 Mar 2025 01:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1ty26Q-0004NA-7e
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 01:17:58 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1ty26O-00023E-8c
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 01:17:57 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2241053582dso48377085ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 22:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743139074; x=1743743874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YKTpC35fN2G306WCM7HtMsJ4ekb+mCDKt6Q9Oo3M+6Y=;
 b=NJYFcsOkglxKb1BNoAROP7mDI/bmaT3s67iHTGwtbOyWw5ueJnbdUA5al50uQFBurF
 DUgfTx5c+jD2DEaz3hE14KyPw4yGeVtIF4DPQwGRGzbXPfCX0QXmgwdRRwrFw+zUXANx
 KWIWx55Yfebn/JY3unViYOpSFu0UDpLFBISe+QoIxaM4PY3fn0QfoNp3DUqt1MxdlY6Z
 +4nCA9QzurXrJmUQpSboTVYNIi1yxxEPcxehErrET8GNMaQSgF3e0z1SiD9+SUx/s3MF
 kY3Tm7BpgFnWt/dwjXgZb9PzQM+nxNFEyonjlBu93ijvf6ctqdiZzPOjwKa6tw1IGpU7
 /dgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743139074; x=1743743874;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKTpC35fN2G306WCM7HtMsJ4ekb+mCDKt6Q9Oo3M+6Y=;
 b=LFHH0a8ZZP+B0aAnXYfPGXEPl+r8gsKtT8alw/PxRU61YbQcv8HdaCKpMuvwmYjlye
 OE7rLOF4VDJAAkPkA/kvFrPxtzhSmXA10KCR/krJ5kvQGf9JQwrEgH9z/xw/MHLHJnwX
 xWqQDSw4Ao0jr6cSypmdUNDoIe6KJtZAaYbvcZmAI6AG+XXu37E6wp7uArQkF9UggLhx
 3XTlfUw3yaU8h+3vb6c8KwTvDjcOQnk5On9A/woM6hfNGJzzEu1Dzn/IIZH0lcYwYFgo
 HbiOQpY/QtraWVXuUk7L9CbsmJp5izov4iNw6IjAAq+M2fMvdiqUF7sFUNrNDbo8Kqq1
 KrJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmarBbhA7bfq1e2bV+iE24MadXE/aXIMGtVMHcwS2Sn1KD6LAKwIWqi07oC7OL0WR7md9oYnsdWfYe@nongnu.org
X-Gm-Message-State: AOJu0YzTN+k0doAKE6/5uA9xV53GKJe3XpXXvqP6T8ayE3M4MLZzHfRo
 kByPnR8OO6o2SePvF0wpQsSYBJVbjLqIImmG5hvmAxDLZTofnBry
X-Gm-Gg: ASbGnctCUEw14NmxiTsoIg67S7yhp6MBOONtim4XAFfbOqDe50PIWlK/gobwfiZzabV
 e4oeA1aEN8JlDICmKF76IAcOnxlgHkGnNV3fzEquKR3TpzhClUQaLWqJTTpJeZO8MkgGaReR8aF
 wQzLixHSwlvwaCAk6X33zcdHUCpAFuGEmHf4+UquBw2pQFbtT/l9nVbEC+63bCLCpoUGTEVBjSw
 yuUwDYI5Snw0Ni0UiX5KdLgW59RchegkxrCilQM0+WLRI5toq2BQaFyOuY7QZPLXICTSi361LSp
 6mC23RbgBXLOuYdV718q/t1mGB56cX4jgzZrU7bDbMXlht81mk2KRLXq0tXCN1ts079wEPryvQM
 MnkyOecEZigcx
X-Google-Smtp-Source: AGHT+IGDBGUfiXQRfxsjynZmf6Kf2RH6Aq/OEPjKe8tTnr+jFSiomrZGUhF2xcWsn4z5MOdEGJFVQA==
X-Received: by 2002:a05:6a21:3989:b0:1f3:47d6:aa05 with SMTP id
 adf61e73a8af0-1fea2c0b4efmr11946009637.0.1743139074260; 
 Thu, 27 Mar 2025 22:17:54 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d?
 ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73970e22433sm841215b3a.52.2025.03.27.22.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 22:17:53 -0700 (PDT)
Message-ID: <e78bbdba-4599-42eb-9003-512638383df8@gmail.com>
Date: Fri, 28 Mar 2025 10:47:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 2/7] vhost: Data structure changes to support packed vqs
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 sahilcdq@proton.me
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-3-sahilcdq@proton.me>
 <CAJaqyWfSFH7vrCRdg0zV4xrs7AmjMAnmZnqp1P3fMCeiMEGFMg@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWfSFH7vrCRdg0zV4xrs7AmjMAnmZnqp1P3fMCeiMEGFMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62f.google.com
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

On 3/26/25 4:56 PM, Eugenio Perez Martin wrote:
> On Mon, Mar 24, 2025 at 3:00 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>
>> Introduce "struct vring_packed".
>>
>> Modify VhostShadowVirtqueue so it can support split and packed virtqueue
>> formats.
>>
>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>> ---
>> Changes from v4 -> v5:
>> - This was commit #3 in v4. This has been reordered to commit #2
>>    based on review comments.
>> - Place shadow_avail_idx, shadow_used_idx, last_used_idx
>>    above the "shadow vring" union.
>>
> 
> What is the reason for the member reorder?
> 

In v1 [1], I had made the decision to shift all the fields in the structure that
are used by split and packed vqs above the "shadow vring" union. But I hadn't
moved shadow_avail_idx, shadow_used_idx or last_used_idx.

The latter two are also used by both vring formats. "shadow_avail_idx" is only
used by split vqs but I think it'll have to be used in packed vqs as well in the
future.

To keep things consistent I thought I would shift these fields as well. Although,
these shifts shouldn't have an impact on the functionality. The shifts can be
dropped without issue.

>>   hw/virtio/vhost-shadow-virtqueue.h | 87 +++++++++++++++++++-----------
>>   1 file changed, 56 insertions(+), 31 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
>> index 9c273739d6..5f7699da9d 100644
>> --- a/hw/virtio/vhost-shadow-virtqueue.h
>> +++ b/hw/virtio/vhost-shadow-virtqueue.h
>> @@ -46,10 +46,65 @@ typedef struct VhostShadowVirtqueueOps {
>>       VirtQueueAvailCallback avail_handler;
>>   } VhostShadowVirtqueueOps;
>>
>> +struct vring_packed {
>> +    /* Actual memory layout for this queue. */
>> +    struct {
>> +        unsigned int num;
>> +        struct vring_packed_desc *desc;
>> +        struct vring_packed_desc_event *driver;
>> +        struct vring_packed_desc_event *device;
>> +    } vring;
>> +
>> +    /* Avail used flags. */
>> +    uint16_t avail_used_flags;
>> +
>> +    /* Index of the next avail descriptor. */
>> +    uint16_t next_avail_idx;
>> +
>> +    /* Driver ring wrap counter */
>> +    bool avail_wrap_counter;
>> +};
>> +
>>   /* Shadow virtqueue to relay notifications */
>>   typedef struct VhostShadowVirtqueue {
>> +    /* True if packed virtqueue */
>> +    bool is_packed;
>> +
>> +    /* Virtio queue shadowing */
>> +    VirtQueue *vq;
>> +
>> +    /* Virtio device */
>> +    VirtIODevice *vdev;
>> +
>> +    /* SVQ vring descriptors state */
>> +    SVQDescState *desc_state;
>> +
>> +    /*
>> +     * Backup next field for each descriptor so we can recover securely, not
>> +     * needing to trust the device access.
>> +     */
>> +    uint16_t *desc_next;
>> +
>> +    /* Next free descriptor */
>> +    uint16_t free_head;
>> +
>> +    /* Size of SVQ vring free descriptors */
>> +    uint16_t num_free;
>> +
>> +    /* Next head to expose to the device */
>> +    uint16_t shadow_avail_idx;
>> +
>> +    /* Last seen used idx */
>> +    uint16_t shadow_used_idx;
>> +
>> +    /* Next head to consume from the device */
>> +    uint16_t last_used_idx;
>> +
>>       /* Shadow vring */
>> -    struct vring vring;
>> +    union {
>> +        struct vring vring;
>> +        struct vring_packed vring_packed;
>> +    };
>>
>>       /* Shadow kick notifier, sent to vhost */
>>       EventNotifier hdev_kick;
>> @@ -69,47 +124,17 @@ typedef struct VhostShadowVirtqueue {
>>       /* Guest's call notifier, where the SVQ calls guest. */
>>       EventNotifier svq_call;
>>
>> -    /* Virtio queue shadowing */
>> -    VirtQueue *vq;
>> -
>> -    /* Virtio device */
>> -    VirtIODevice *vdev;
>> -
>>       /* IOVA mapping */
>>       VhostIOVATree *iova_tree;
>>
>> -    /* SVQ vring descriptors state */
>> -    SVQDescState *desc_state;
>> -
>>       /* Next VirtQueue element that guest made available */
>>       VirtQueueElement *next_guest_avail_elem;
>>
>> -    /*
>> -     * Backup next field for each descriptor so we can recover securely, not
>> -     * needing to trust the device access.
>> -     */
>> -    uint16_t *desc_next;
>> -
>>       /* Caller callbacks */
>>       const VhostShadowVirtqueueOps *ops;
>>
>>       /* Caller callbacks opaque */
>>       void *ops_opaque;
>> -
>> -    /* Next head to expose to the device */
>> -    uint16_t shadow_avail_idx;
>> -
>> -    /* Next free descriptor */
>> -    uint16_t free_head;
>> -
>> -    /* Last seen used idx */
>> -    uint16_t shadow_used_idx;
>> -
>> -    /* Next head to consume from the device */
>> -    uint16_t last_used_idx;
>> -
>> -    /* Size of SVQ vring free descriptors */
>> -    uint16_t num_free;
>>   } VhostShadowVirtqueue;
>>
>>   bool vhost_svq_valid_features(uint64_t features, Error **errp);
>> --
>> 2.48.1
>>
> 

Thanks,
Sahil

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg03417.html

