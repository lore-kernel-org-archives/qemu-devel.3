Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EDAC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 04:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpKeU-0007xk-8W; Wed, 27 Mar 2024 00:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpKeQ-0007xV-9M
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 00:12:34 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpKeO-0007bj-1v
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 00:12:34 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e0b213efa3so25589105ad.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 21:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711512750; x=1712117550;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PyCyQLXvPkiPchKCU6cIu3hLiO89MUexpf59/T0oH+Y=;
 b=kshB8zWmNBSJ8mDw8H9+DNREK+W4Nt2jF76fa11yJA03BbNN7hh+czOpxEyBV6UOBb
 ZUkpM/fuOBTT3FZrUhM2OoPrcSRStGmiZzGAGdVL25UbG2ctYg4VIUF787RR+VhxwMdU
 siWDyM0h0Th9LqN8F3yRiffIONcHrnWI3uJVhAzz2qhjP6vWGuHdbJPzNW7dDd3ru6Ju
 XkaHXNCq/0VlUWofU8RC6QC9zxuuT6xaXVGg159kcx4z+DHv9usX60eq/28lC8rkukvz
 Lsp2qq3sqAFF6WJxIyjic3m0NCqBJKV9emPEIl8WIZewcTR2AqaSyztT2vAemfP9LiUS
 fqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711512750; x=1712117550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PyCyQLXvPkiPchKCU6cIu3hLiO89MUexpf59/T0oH+Y=;
 b=Bojfa72WKPzBnlo1n0ylHkLCRiSVrn8GW5IZHQMj/+LZ4luJtLsK/i+0hdt/dQiYZR
 HUc9E/0ucEjnkdqwahjBa/CeVzkmZfINt+nit05ZmA4RaJcclm1eQV45Hw2De2mSBXz7
 q/diH+LRFGZTB0jWTUNiCR5dlhypNrG01fq7gC/S0CMtS1jqnUIjfHRtQhzWnY393EAH
 OfIfRaFEZIxgttWWZLFL/b2kkbHfbJS9sfsKMc0QKrUJfY2W5qrSfox/STPYfeGyN7vM
 Jkv3cPDmAXJSjE4AoD0PJxvvhIJyI2xvIj48ERBJ6KCWRCZfSFNbAk0ukzMquvVg1r4g
 WhKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpl9sfvrQ/mo797mN8LmdEcBxH5SBtVSdzvN5tudVEL6Lyo+KLm5dP11PyOgo/0c8dy+NrBHhM7rinCt4qwH1tsHdRP6E=
X-Gm-Message-State: AOJu0YyxR69apl4AoKNEpOBCFb2O8LlfO2hhfIaZWtkMXpyku9U9gCIG
 rP7O5ujbz1zvYf4sPQGg0TOmbndD4LdNlc2NvXmnfuqRwxCWQ/z3DHJ1Y5k2OUA=
X-Google-Smtp-Source: AGHT+IGGzW39DZdr+sRLOxCUNWVS9FjGP0n6p2AJxgwB92a4foJYXQBZ+mkUtjqGRfiul2ps1kO6KA==
X-Received: by 2002:a17:902:d544:b0:1dd:c7fc:2b16 with SMTP id
 z4-20020a170902d54400b001ddc7fc2b16mr3702297plf.68.1711512750277; 
 Tue, 26 Mar 2024 21:12:30 -0700 (PDT)
Received: from [157.82.202.248] ([157.82.202.248])
 by smtp.gmail.com with ESMTPSA id
 j13-20020a170903024d00b001def777afc5sm1165812plh.77.2024.03.26.21.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 21:12:29 -0700 (PDT)
Message-ID: <47c84cf2-2e38-4cec-b88e-8799cf49e775@daynix.com>
Date: Wed, 27 Mar 2024 13:12:27 +0900
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
 <cc71e6c8-eca5-4ce1-9c16-8f85c6a5073e@daynix.com>
 <CACGkMEvW+_MTvJ5TwJLNxKC=u0bTTLETuHqK5_0P27GQra5Dng@mail.gmail.com>
 <72ccd5e9-8e9a-4d01-bbdc-94c2dfaf6468@daynix.com>
 <CACGkMEuR=Q1cUitrsxQwhV16jJnZiV5bzs5PHXYt=mpmBKaddA@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEuR=Q1cUitrsxQwhV16jJnZiV5bzs5PHXYt=mpmBKaddA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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

On 2024/03/27 12:24, Jason Wang wrote:
> On Wed, Mar 27, 2024 at 11:11 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/03/27 12:06, Jason Wang wrote:
>>> On Wed, Mar 27, 2024 at 11:05 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2024/03/27 11:59, Jason Wang wrote:
>>>>> On Wed, Mar 27, 2024 at 10:53 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2024/03/27 11:50, Jason Wang wrote:
>>>>>>> On Tue, Mar 26, 2024 at 3:04 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> On 2024/03/26 15:51, Jason Wang wrote:
>>>>>>>>> On Sun, Mar 24, 2024 at 4:32 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>
>>>>>>>>>> It is incorrect to have the VIRTIO_NET_HDR_F_NEEDS_CSUM set when
>>>>>>>>>> checksum offloading is disabled so clear the bit. Set the
>>>>>>>>>> VIRTIO_NET_HDR_F_DATA_VALID bit instead to tell the checksum is valid.
>>>>>>>>>>
>>>>>>>>>> TCP/UDP checksum is usually offloaded when the peer requires virtio
>>>>>>>>>> headers because they can instruct the peer to compute checksum. However,
>>>>>>>>>> igb disables TX checksum offloading when a VF is enabled whether the
>>>>>>>>>> peer requires virtio headers because a transmitted packet can be routed
>>>>>>>>>> to it and it expects the packet has a proper checksum. Therefore, it
>>>>>>>>>> is necessary to have a correct virtio header even when checksum
>>>>>>>>>> offloading is disabled.
>>>>>>>>>>
>>>>>>>>>> A real TCP/UDP checksum will be computed and saved in the buffer when
>>>>>>>>>> checksum offloading is disabled. The virtio specification requires to
>>>>>>>>>> set the packet checksum stored in the buffer to the TCP/UDP pseudo
>>>>>>>>>> header when the VIRTIO_NET_HDR_F_NEEDS_CSUM bit is set so the bit must
>>>>>>>>>> be cleared in that case.
>>>>>>>>>>
>>>>>>>>>> The VIRTIO_NET_HDR_F_NEEDS_CSUM bit also tells to skip checksum
>>>>>>>>>> validation. Even if checksum offloading is disabled, it is desirable to
>>>>>>>>>> skip checksum validation because the checksum is always correct. Use the
>>>>>>>>>> VIRTIO_NET_HDR_F_DATA_VALID bit to claim the validity of the checksum.
>>>>>>>>>>
>>>>>>>>>> Fixes: ffbd2dbd8e64 ("e1000e: Perform software segmentation for loopback")
>>>>>>>>>> Buglink: https://issues.redhat.com/browse/RHEL-23067
>>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>>> ---
>>>>>>>>>>       hw/net/net_tx_pkt.c | 3 +++
>>>>>>>>>>       1 file changed, 3 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
>>>>>>>>>> index 2e5f58b3c9cc..c225cf706513 100644
>>>>>>>>>> --- a/hw/net/net_tx_pkt.c
>>>>>>>>>> +++ b/hw/net/net_tx_pkt.c
>>>>>>>>>> @@ -833,6 +833,9 @@ bool net_tx_pkt_send_custom(struct NetTxPkt *pkt, bool offload,
>>>>>>>>>>
>>>>>>>>>>           if (offload || gso_type == VIRTIO_NET_HDR_GSO_NONE) {
>>>>>>>>>>               if (!offload && pkt->virt_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
>>>>>>>>>> +            pkt->virt_hdr.flags =
>>>>>>>>>> +                (pkt->virt_hdr.flags & ~VIRTIO_NET_HDR_F_NEEDS_CSUM) |
>>>>>>>>>> +                VIRTIO_NET_HDR_F_DATA_VALID;
>>>>>>>>>
>>>>>>>>> Why VIRTIO_NET_HDR_F_DATA_VALID is used in TX path?
>>>>>>>>
>>>>>>>> On igb, a packet sent from a PCI function may be routed to another
>>>>>>>> function. The virtio header updated here will be directly provided to
>>>>>>>> the RX path in such a case.
>>>>>>>
>>>>>>> But I meant for example net_tx_pkt_send_custom() is used in
>>>>>>> e1000e_tx_pkt_send() which is the tx path on the host.
>>>>>>>
>>>>>>> VIRTIO_NET_HDR_F_DATA_VALID is not necessary in the tx path.
>>>>>>
>>>>>> igb passes igb_tx_pkt_vmdq_callback to net_tx_pkt_send_custom().
>>>>>> igb_tx_pkt_vmdq_callback() passes the packet to its rx path for loopback.
>>>>>>
>>>>>
>>>>> You are right, how about igb_tx_pkt_vmdq_callback()?
>>>>>
>>>>> We probably need to tweak the name if it is only used in rx path.
>>>>
>>>> igb_tx_pkt_vmdq_callback() itself is part of the tx path of a PCI
>>>> function, and invokes the rx path of another PCI function in case of
>>>> loopback, or triggers the transmission to the external peer.
>>>
>>> Right, so if it's an external TX, VIRTIO_NET_HDR_F_DATA_VALID may not
>>> work there.
>>
>> It should be fine since it's just a hint.
> 
> It is not defined in the spec AFAIK. So we should try our best to avoid that.
> 
> For example vnet header might be hardened by failing a TX packet with
> that by kernel
> 
> I would bother now than bother it in the future for safety if it's not too hard.

I checked the specification and found:
https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-2310001
 > 5.1.6.2.1 Driver Requirements: Packet Transmission

 > The driver MUST NOT set the VIRTIO_NET_HDR_F_DATA_VALID and
 > VIRTIO_NET_HDR_F_RSC_INFO bits in flags.

So it's explicitly prohibited. I'll send v2, which removes 
VIRTIO_NET_HDR_F_DATA_VALID.

Regards,
Akihiko Odaki

> 
> Thanks
> 
> 
> 
> Thanks
> 
>>
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
>>>>>> Regards,
>>>>>> Akihiko Odaki
>>>>>>
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Akihiko Odaki
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>>>>                   net_tx_pkt_do_sw_csum(pkt, &pkt->vec[NET_TX_PKT_L2HDR_FRAG],
>>>>>>>>>>                                         pkt->payload_frags + NET_TX_PKT_PL_START_FRAG - 1,
>>>>>>>>>>                                         pkt->payload_len);
>>>>>>>>>>
>>>>>>>>>> ---
>>>>>>>>>> base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
>>>>>>>>>> change-id: 20240324-tx-c57d3c22ad73
>>>>>>>>>>
>>>>>>>>>> Best regards,
>>>>>>>>>> --
>>>>>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

