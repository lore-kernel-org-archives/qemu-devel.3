Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEFFC54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 07:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp0rN-0001Is-8D; Tue, 26 Mar 2024 03:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp0rL-0001IZ-IG
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:04:35 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp0rI-0008Hc-Ms
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:04:34 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e0d8403257so8074715ad.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711436671; x=1712041471;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X3XpEffPJkB/vxEACHsRUQ714jMP4/rwnj9UtQPZyKQ=;
 b=2zGsc2WjgXcFlF39U4VHoltfMIXdzLxX/oo8TEyY8RdrbBE7jEKbXXb4YnD/2M9dFJ
 21VvujJMwBJN+IoeS5eijcHfNJpJrhcDp/hk62vF3LdcXet6m5ZJYODrdGBEMLDPIs+x
 GGyyh+jyV3XpsU/B1DJrgFoUqxuzk39Mz4y2MdsM/6Fvf11tKFs6epl2prarDGknClJH
 9FY6Ry1Cn0AQI8GwdJ7EGk3IaoDFDMvfvL/gMoqiyAzHqB+qzOb0rq/xLdr8pOGtmK9w
 m+ynsKVfPsYcVrgkJgzZQpwvknqbUTpp45eFcxO0OPBzkkzKP4wPT5g+c7P8LfsZjrRm
 y3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711436671; x=1712041471;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X3XpEffPJkB/vxEACHsRUQ714jMP4/rwnj9UtQPZyKQ=;
 b=GGMEgVWDX8t7UZjEkBgB5S+LKrT1sSmfKqjbq5RHqnNoo6HOPzdjB76xAhugjZEn4p
 P63WUzDzCwhxjjZWke7yMOPnekbFUUlzt0t05+v++qwhELhn4z+q2r0pknnqiNUlE8k4
 2xRbPGtG3bfzDfAxkA4sGNhBn6UF2ZqPsjijdbVaQTJ8IrOK5OrHTc3zm31GkXD1M9zc
 aqXlmUDRJ2qEH1zV/Ko8Ua1JPxPkl5QBoYy0xGzZXETntToSXh/NCFr26bjSyF6agcwV
 6L9r/TuEdt+0yl9djc0/Q361spy0f59kJIENg9+j8mI8pL5sBSM8jdRQSLUat/jcFRra
 tnVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi/COqQ4mgxb6E6XIhj9xwY6tt6Se+5n+dtmUvCtoCMq41+QMWIS7sM2SBw5doGr0bUri6juOd7hpzSsbfhUlwsIe+SYE=
X-Gm-Message-State: AOJu0YywcIfbz8YspparlYksm5If5ZD1hlSilkvqsJk/yQQnmUH/hKeO
 VRQaUUndw4TwJ/wiT6KZ9KCx8SpsDBds4Ygcf6Muet2fP9snsr5c5YSmzVEaRtU=
X-Google-Smtp-Source: AGHT+IFsFHJzZjPhcd7FXNdN+lx0nA5tEEt4vQkObhp1mmFhIOWx74IXKgeJ37mkP/0I4E/DKK3U9g==
X-Received: by 2002:a17:902:6541:b0:1e0:a0d5:1d23 with SMTP id
 d1-20020a170902654100b001e0a0d51d23mr6585503pln.29.1711436670692; 
 Tue, 26 Mar 2024 00:04:30 -0700 (PDT)
Received: from [157.82.200.213] ([157.82.200.213])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a1709028d9200b001dde403a060sm5986889plo.44.2024.03.26.00.04.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 00:04:30 -0700 (PDT)
Message-ID: <a31d0734-823b-4b67-8888-46f0c787cf8f@daynix.com>
Date: Tue, 26 Mar 2024 16:04:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/net_tx_pkt: Fix virtio header without checksum
 offloading
To: Jason Wang <jasowang@redhat.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
References: <20240324-tx-v1-1-a3b4135749ec@daynix.com>
 <CACGkMEvBoe4XQeHOR64rNwAPM-vBMsfLQApWpUoMtvwsSVCpUQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvBoe4XQeHOR64rNwAPM-vBMsfLQApWpUoMtvwsSVCpUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

On 2024/03/26 15:51, Jason Wang wrote:
> On Sun, Mar 24, 2024 at 4:32 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> It is incorrect to have the VIRTIO_NET_HDR_F_NEEDS_CSUM set when
>> checksum offloading is disabled so clear the bit. Set the
>> VIRTIO_NET_HDR_F_DATA_VALID bit instead to tell the checksum is valid.
>>
>> TCP/UDP checksum is usually offloaded when the peer requires virtio
>> headers because they can instruct the peer to compute checksum. However,
>> igb disables TX checksum offloading when a VF is enabled whether the
>> peer requires virtio headers because a transmitted packet can be routed
>> to it and it expects the packet has a proper checksum. Therefore, it
>> is necessary to have a correct virtio header even when checksum
>> offloading is disabled.
>>
>> A real TCP/UDP checksum will be computed and saved in the buffer when
>> checksum offloading is disabled. The virtio specification requires to
>> set the packet checksum stored in the buffer to the TCP/UDP pseudo
>> header when the VIRTIO_NET_HDR_F_NEEDS_CSUM bit is set so the bit must
>> be cleared in that case.
>>
>> The VIRTIO_NET_HDR_F_NEEDS_CSUM bit also tells to skip checksum
>> validation. Even if checksum offloading is disabled, it is desirable to
>> skip checksum validation because the checksum is always correct. Use the
>> VIRTIO_NET_HDR_F_DATA_VALID bit to claim the validity of the checksum.
>>
>> Fixes: ffbd2dbd8e64 ("e1000e: Perform software segmentation for loopback")
>> Buglink: https://issues.redhat.com/browse/RHEL-23067
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/net/net_tx_pkt.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
>> index 2e5f58b3c9cc..c225cf706513 100644
>> --- a/hw/net/net_tx_pkt.c
>> +++ b/hw/net/net_tx_pkt.c
>> @@ -833,6 +833,9 @@ bool net_tx_pkt_send_custom(struct NetTxPkt *pkt, bool offload,
>>
>>       if (offload || gso_type == VIRTIO_NET_HDR_GSO_NONE) {
>>           if (!offload && pkt->virt_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
>> +            pkt->virt_hdr.flags =
>> +                (pkt->virt_hdr.flags & ~VIRTIO_NET_HDR_F_NEEDS_CSUM) |
>> +                VIRTIO_NET_HDR_F_DATA_VALID;
> 
> Why VIRTIO_NET_HDR_F_DATA_VALID is used in TX path?

On igb, a packet sent from a PCI function may be routed to another 
function. The virtio header updated here will be directly provided to 
the RX path in such a case.

Regards,
Akihiko Odaki

> 
> Thanks
> 
>>               net_tx_pkt_do_sw_csum(pkt, &pkt->vec[NET_TX_PKT_L2HDR_FRAG],
>>                                     pkt->payload_frags + NET_TX_PKT_PL_START_FRAG - 1,
>>                                     pkt->payload_len);
>>
>> ---
>> base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
>> change-id: 20240324-tx-c57d3c22ad73
>>
>> Best regards,
>> --
>> Akihiko Odaki <akihiko.odaki@daynix.com>
>>
> 

