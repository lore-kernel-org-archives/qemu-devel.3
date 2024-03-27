Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A32EC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 03:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpJb8-0000kn-Ls; Tue, 26 Mar 2024 23:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpJb6-0000kR-2u
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 23:05:04 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpJb3-00047m-Lz
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 23:05:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dde26f7e1dso48160135ad.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 20:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711508700; x=1712113500;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8oRu0j+df+XshbmcrwthY9vfAcxVy7LWAGXO9AnigXc=;
 b=2nskp59Y4nDSWYRpQs+eig5o+TxUqwOtGyHugDu6s/b8WD8L+kUeF67LQ1U0cayqW3
 HpHyDArJ7ljOVYZX1JlihabYviwzl765VnchXGlVZWXv6rNbIIj943jF+mdYA2+eceE+
 O7FDT7rDiow066X5B26zB58ytSBQdsXTHFcAS6IJJLtMBiL3FSoQzF/4Gty97VQZ6E7D
 MVoWYw8r14dD74kUiQB18uAj7aWjHeoCnLv1S3i3312WBqkbvJiDZY9ej0JMLWXMpSKy
 PMKvrnhPKWr9apBBI20NhuhIadVqzwO+UnorVPgU7Ae6evW6fueT64jgo6CHmi+lyiGp
 3fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711508700; x=1712113500;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8oRu0j+df+XshbmcrwthY9vfAcxVy7LWAGXO9AnigXc=;
 b=k+reHrMjikiU6GCQRAWG9x3jux6ngrLRf8h1WKMOEZ9O0WttNmOih3+Xmz5GbbzH/w
 1GzCkX8Fxl4b7HNmv4zVkFu4PE622Lsv8wNVkMr0PeKHRVbXEoljIgLWgkyuCwyzO+gU
 SUgPyYEEL1rlrhkeh0Wh+Oty0du9GtRmwNuuvi4OnmrXqDtN+ZMz/7/gjkn1Ce9ymFq8
 I+DI/jXqqGXlSExXhdPcmaEge/G6xwHjfPg8ezd+LdCp6JJeXRp9CPBBnuKBaDluAmi8
 MghhfG+KTjdJemThFIg8rbUkK55/FjpsFfdoCtMmdNdgNQsGd45RyAy85+6M05Zzhy99
 JWeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1QwJW7qUnxyShdknIf0IR3JkJ2Md3hXGXDoDKS9MqODhtVmUNZfY3hQL9VIRDeoh95HSGE1i2ZeTrHjMgrr+oDyTUohg=
X-Gm-Message-State: AOJu0YwwX/XzDZtuKW3J0Ib1cESpgqLGy+ODh7UOIRpQgx5rXO+3ob/q
 ytiFrHOEDB6PO01gBSRnsgta8KF7l+dFE+LT4XxolzCIRtoBhPjN2cTC94n39Ho=
X-Google-Smtp-Source: AGHT+IF4op9lf33Jy4TfeGAvOlN4tcA7LRHnx7hw7jsTn156z86HmZFQbHdq61KtaJrAGo97POmazw==
X-Received: by 2002:a17:903:1112:b0:1e0:e85f:3882 with SMTP id
 n18-20020a170903111200b001e0e85f3882mr1837870plh.38.1711508700003; 
 Tue, 26 Mar 2024 20:05:00 -0700 (PDT)
Received: from [157.82.202.248] ([157.82.202.248])
 by smtp.gmail.com with ESMTPSA id
 n19-20020a170902969300b001e12013ae07sm229080plp.231.2024.03.26.20.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 20:04:59 -0700 (PDT)
Message-ID: <cc71e6c8-eca5-4ce1-9c16-8f85c6a5073e@daynix.com>
Date: Wed, 27 Mar 2024 12:04:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/net_tx_pkt: Fix virtio header without checksum
 offloading
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
References: <20240324-tx-v1-1-a3b4135749ec@daynix.com>
 <CACGkMEvBoe4XQeHOR64rNwAPM-vBMsfLQApWpUoMtvwsSVCpUQ@mail.gmail.com>
 <a31d0734-823b-4b67-8888-46f0c787cf8f@daynix.com>
 <CACGkMEvYQr2=0DF99ge9DotJg-O3H1FmZQAzhb=6RVWSvvGqmA@mail.gmail.com>
 <a4bdd207-e069-47ef-8e80-7b27528a315d@daynix.com>
 <CACGkMEsCTsQ8H6=XYMZ+8Pb9X1o19j9A4N8kiO500Dbgnw-i6g@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEsCTsQ8H6=XYMZ+8Pb9X1o19j9A4N8kiO500Dbgnw-i6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/03/27 11:59, Jason Wang wrote:
> On Wed, Mar 27, 2024 at 10:53 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/03/27 11:50, Jason Wang wrote:
>>> On Tue, Mar 26, 2024 at 3:04 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2024/03/26 15:51, Jason Wang wrote:
>>>>> On Sun, Mar 24, 2024 at 4:32 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> It is incorrect to have the VIRTIO_NET_HDR_F_NEEDS_CSUM set when
>>>>>> checksum offloading is disabled so clear the bit. Set the
>>>>>> VIRTIO_NET_HDR_F_DATA_VALID bit instead to tell the checksum is valid.
>>>>>>
>>>>>> TCP/UDP checksum is usually offloaded when the peer requires virtio
>>>>>> headers because they can instruct the peer to compute checksum. However,
>>>>>> igb disables TX checksum offloading when a VF is enabled whether the
>>>>>> peer requires virtio headers because a transmitted packet can be routed
>>>>>> to it and it expects the packet has a proper checksum. Therefore, it
>>>>>> is necessary to have a correct virtio header even when checksum
>>>>>> offloading is disabled.
>>>>>>
>>>>>> A real TCP/UDP checksum will be computed and saved in the buffer when
>>>>>> checksum offloading is disabled. The virtio specification requires to
>>>>>> set the packet checksum stored in the buffer to the TCP/UDP pseudo
>>>>>> header when the VIRTIO_NET_HDR_F_NEEDS_CSUM bit is set so the bit must
>>>>>> be cleared in that case.
>>>>>>
>>>>>> The VIRTIO_NET_HDR_F_NEEDS_CSUM bit also tells to skip checksum
>>>>>> validation. Even if checksum offloading is disabled, it is desirable to
>>>>>> skip checksum validation because the checksum is always correct. Use the
>>>>>> VIRTIO_NET_HDR_F_DATA_VALID bit to claim the validity of the checksum.
>>>>>>
>>>>>> Fixes: ffbd2dbd8e64 ("e1000e: Perform software segmentation for loopback")
>>>>>> Buglink: https://issues.redhat.com/browse/RHEL-23067
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>> ---
>>>>>>     hw/net/net_tx_pkt.c | 3 +++
>>>>>>     1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
>>>>>> index 2e5f58b3c9cc..c225cf706513 100644
>>>>>> --- a/hw/net/net_tx_pkt.c
>>>>>> +++ b/hw/net/net_tx_pkt.c
>>>>>> @@ -833,6 +833,9 @@ bool net_tx_pkt_send_custom(struct NetTxPkt *pkt, bool offload,
>>>>>>
>>>>>>         if (offload || gso_type == VIRTIO_NET_HDR_GSO_NONE) {
>>>>>>             if (!offload && pkt->virt_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
>>>>>> +            pkt->virt_hdr.flags =
>>>>>> +                (pkt->virt_hdr.flags & ~VIRTIO_NET_HDR_F_NEEDS_CSUM) |
>>>>>> +                VIRTIO_NET_HDR_F_DATA_VALID;
>>>>>
>>>>> Why VIRTIO_NET_HDR_F_DATA_VALID is used in TX path?
>>>>
>>>> On igb, a packet sent from a PCI function may be routed to another
>>>> function. The virtio header updated here will be directly provided to
>>>> the RX path in such a case.
>>>
>>> But I meant for example net_tx_pkt_send_custom() is used in
>>> e1000e_tx_pkt_send() which is the tx path on the host.
>>>
>>> VIRTIO_NET_HDR_F_DATA_VALID is not necessary in the tx path.
>>
>> igb passes igb_tx_pkt_vmdq_callback to net_tx_pkt_send_custom().
>> igb_tx_pkt_vmdq_callback() passes the packet to its rx path for loopback.
>>
> 
> You are right, how about igb_tx_pkt_vmdq_callback()?
> 
> We probably need to tweak the name if it is only used in rx path.

igb_tx_pkt_vmdq_callback() itself is part of the tx path of a PCI 
function, and invokes the rx path of another PCI function in case of 
loopback, or triggers the transmission to the external peer.

Regards,
Akihiko Odaki

> 
> Thanks
> 
>> Regards,
>> Akihiko Odaki
>>
>>>
>>> Thanks
>>>
>>>>
>>>> Regards,
>>>> Akihiko Odaki
>>>>
>>>>>
>>>>> Thanks
>>>>>
>>>>>>                 net_tx_pkt_do_sw_csum(pkt, &pkt->vec[NET_TX_PKT_L2HDR_FRAG],
>>>>>>                                       pkt->payload_frags + NET_TX_PKT_PL_START_FRAG - 1,
>>>>>>                                       pkt->payload_len);
>>>>>>
>>>>>> ---
>>>>>> base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
>>>>>> change-id: 20240324-tx-c57d3c22ad73
>>>>>>
>>>>>> Best regards,
>>>>>> --
>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

