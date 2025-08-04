Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CE1C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 06:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uioJK-0006PP-SB; Mon, 04 Aug 2025 02:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1uioJI-0006Np-FD
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 02:04:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1uioJE-0002G3-S5
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 02:04:35 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2406fe901fcso25848375ad.3
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 23:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754287471; x=1754892271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hPSMLoOHO11dC87pyYHj+ODKe4XF4PYBj2SaXXMMOsw=;
 b=QLnB23lRLxWJOoQ1affdXtcgCcmkGdBFaXcBoUjgSvNl9JFTDFj6jJbD6/8WChXDFf
 L42X9CNXkmR/+8Hck/mEsw2Faph0vwNe7AYpAmk3he6qqbwl+p1Y7qRPrMfbHngOep9g
 yZ1LP2g1zM7qvRnKS/nvjXrwWZu99LssneGBmw129KTlbCZvcsSDT7WEff79RswPhZJm
 nhrYLiCUVIjU2uyNK/ur4Eu0I0H5mC8yd/sdgV/PDRFNfIfXG260nfhXR+WSQH1FklHl
 tXtDbqebPIzrKmDWPlLV1+BM9qgULpAsKGNNerXAZTkHbSQ/jWXu5TQE0L0mLBWNnu1w
 fg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754287471; x=1754892271;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPSMLoOHO11dC87pyYHj+ODKe4XF4PYBj2SaXXMMOsw=;
 b=K4i8f10arxeRKBioj64Pm+UUo+pVutTolaYbkRHLoKOxmeorY+HHi0AgNgfAelX8z4
 SjhX9DFqz7r0w4PyGrdK2M2UMfkEiek/bbfXZ4jFBPAN7D0bqYxlLJR9WLtxLb68FnM4
 aA57GDjOZW/+Abk+EDMsc6UKG2d2AEY2Y30wQYU9IVHl53LrD61iApcIeqDMya10dFQe
 /TRvsjEQF7HRodFk/omfD1yjRFbz+wIzUH5GBSeS03ZOCLho0/UCaHDabNj/RN2wzu7R
 p+iAQ2p0e10omZx7hlWcFo+Iln/ei/DrfUeZNVgKZvWbRLJfkLd+OUt4HRWIkUHB15lB
 EiaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKUv4+jgIq0ROn/dRf+9TwQlQ/YWx80laFQ+8Dt5Sorc8y5dolDJq8cVVc+mMd23L7JcJZsrfWimGm@nongnu.org
X-Gm-Message-State: AOJu0Yyj9vGYTaXPSDwO947DYdCvfDMYzCVKohgg01Wn9Tk65bEmj/8u
 rZO0dDKWKhwGbXWS4I4HCZdoF7mmmoIgZkmn7KCTV5hvUIYFGfCiBVr1
X-Gm-Gg: ASbGnct/vqtfwPCuQBrGgeN2+VGmnyDUcoxvNM/9P8h97mfNQgRbFzgDXQ/Yl/eGVy7
 V8CXf+6XLlAgtiy9GxzGU4vyO+MGxtiopQKb7iQuKWLhFL9dwTtXx0Zlo8KHuW8GhPTTdSx0XcP
 EBQyerIrVwLgKLhTwbtXL+eEhguQqDOTswA8B05MfNPFJboQlvmzrQD//TrJFSnjqLUhKuBGDdb
 HBr2OnNWihs5NuCzDJSXJlapdTMPY2+aoH/ga/lnxPl0kJztxbmJc+DUpVhXVQ+Lsv7TaCKElQV
 9+1WmnIGUV9g+hpnoKKJc/jR5RLDA2ru7dCcXh133BVW5/rN/RQK5gINpL3CfNXecgrvjnTlZFr
 zr1i+85mZ9VZBPZVSwSwOdSkUAD+OTNbMY7uFXzI6zNTvyZY1b2mUbtfZMD/fc3Q=
X-Google-Smtp-Source: AGHT+IG05RgR1APstrPpY3qkjS10EK4JZTVtzHqow31vO7yHv6OwAMrRa5f4R7a1H1mwE4xrTj8CFg==
X-Received: by 2002:a17:903:947:b0:240:38ee:9434 with SMTP id
 d9443c01a7336-24247064308mr115122845ad.47.1754287470478; 
 Sun, 03 Aug 2025 23:04:30 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c44:ccf3:870c:1db6:e2c:fdf4?
 ([2401:4900:1c44:ccf3:870c:1db6:e2c:fdf4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e89771e2sm100524395ad.88.2025.08.03.23.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Aug 2025 23:04:30 -0700 (PDT)
Message-ID: <15d4f488-5431-460c-8e06-0741e11fe7f2@gmail.com>
Date: Mon, 4 Aug 2025 11:34:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 0/7] Add packed format to shadow virtqueue
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 sahilcdq@proton.me
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <CAJaqyWdXat-ugJHEcZyB5dbTuwGgvrO2+DdDd9YneS0=j-99NA@mail.gmail.com>
 <f1354888-74fb-44d8-8b48-c6a6a13db1a7@gmail.com>
 <CAJaqyWd=ssa5fkmV7Z=tzJvFeciC1P2U2pYheaSrZ2PZCaejHg@mail.gmail.com>
 <9a7c409f-cd7e-4906-812b-c8a4d77cfc4d@gmail.com>
 <CAJaqyWdme4GSTQr-mbGiWvV5Wu0Mnjc467ptWFoX2i3zHygf3g@mail.gmail.com>
 <97eafb50-492a-4571-92de-503fbc0d06fd@gmail.com>
 <CAJaqyWeG2n=BhjNhQzMagjh5t-dgno6q-esVjzqrw8z3_sUrHA@mail.gmail.com>
 <68e7a854-f7d3-4d21-87b0-3a23f4341493@gmail.com>
 <CAJaqyWcWoyGWeOG1B8FBZgGb6n99fVkTAvaTFco0A2cvr8Lf8w@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWcWoyGWeOG1B8FBZgGb6n99fVkTAvaTFco0A2cvr8Lf8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x634.google.com
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

On 7/31/25 7:22 PM, Eugenio Perez Martin wrote:
> On Wed, Jul 30, 2025 at 4:33 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>> I think I have finally found the reason behind this issue.
>>
>> The order in which "add_packed" and "get_buf_packed" are performed in the
>> nested guest kernel (L2 kernel) and QEMU are a little different. Due to
>> this, the values in free_head and svq->desc_next[] differ and the guest
>> crashes at some point. More below.
>>
>> On 6/26/25 1:07 PM, Eugenio Perez Martin wrote:
>>> On Thu, Jun 26, 2025 at 7:16 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>>> I think there's something off in the way "free_head", "last_used_idx" and
>>>> "desc_next" values are calculated in vhost_svq_get_buf_packed() [1].
>>>>
>>>> In the latest test run, QEMU sent ids 0 through 28 to L2. L2 started receiving
>>>> them in order till id 8. At this point it received id 7 again for some reason
>>>> and then crashed.
>>>>
>>>> L2:
>>>>
>>>> [ 1641.129218] (prepare_packed) output.0 -> needs_kick: 1
>>>> [ 1641.130621] (notify) output.0 -> function will return true
>>>> [ 1641.132022] output.0 -> id: 0
>>>> [ 1739.502358] input.0 -> id: 0
>>>> [ 1739.503003] input.0 -> id: 1
>>>> [ 1739.562024] input.0 -> id: 2
>>>> [ 1739.578682] input.0 -> id: 3
>>>> [ 1739.661913] input.0 -> id: 4
>>>> [ 1739.828796] input.0 -> id: 5
>>>> [ 1739.829789] input.0 -> id: 6
>>>> [ 1740.078757] input.0 -> id: 7
>>>> [ 1740.079749] input.0 -> id: 8
>>>> [ 1740.080382] input.0 -> id: 7    <----Received 7 again
>>>> [ 1740.081614] virtio_net virtio1: input.0:id 7 is not a head!
>>>>
>>>> QEMU logs (vhost_svq_get_buf_packed):
>>>> ------
>>>> size              : svq->vring.num
>>>> len               : svq->vring_packed.vring.desc[last_used].len
>>>> id                : svq->vring_packed.vring.desc[last_used].id
>>>> num               : svq->desc_state[id].ndescs
>>>> last_used_chain   : Result of vhost_svq_last_desc_of_chain(svq, num, id) [2]
>>>> free_head         : svq->free_head
>>>> last_used         : (last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR)) + num
>>>> used_wrap_counter : !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR))
>>>> ------
>>>> size: 256, len: 82, id: 7, vq idx: 0
>>>> id: 7, last_used_chain: 7, free_head: 6, vq idx: 0
>>>> num: 1, free_head: 7, id: 7, last_used: 8, used_wrap_counter: 1, vq idx: 0
>>>> ------
>>>> size: 256, len: 104, id: 8, vq idx: 0
>>>> id: 8, last_used_chain: 8, free_head: 7, vq idx: 0
>>>> num: 1, free_head: 8, id: 8, last_used: 9, used_wrap_counter: 1, vq idx: 0
>>>> ------
>>>> size: 256, len: 98, id: 9, vq idx: 0
>>>> id: 9, last_used_chain: 9, free_head: 8, vq idx: 0
>>>> num: 1, free_head: 9, id: 9, last_used: 10, used_wrap_counter: 1, vq idx: 0
>>>> ------
>>>> size: 256, len: 104, id: 10, vq idx: 0
>>>> id: 10, last_used_chain: 10, free_head: 9, vq idx: 0
>>>> num: 1, free_head: 10, id: 10, last_used: 11, used_wrap_counter: 1, vq idx: 0
>>>>
>>>> I have a few more ideas of what to do. I'll let you know if I find something
>>>> else.
>>>>
>>> I cannot find anything just by inspection. What about printing all the
>>> desc_state and all desc_next to check for incoherencies in each
>>> svq_add and get_buf?
>> In this test, all 256 descriptors were filled in the RX vq.
>>
>> In the TX queue, L2 kernel would add one descriptor at a time and notify
>> QEMU. QEMU would then register it in its SVQ and mark it as "available".
>> After processing the descriptor, QEMU would mark it as "used" and flush it
>> back to L2. L2, in turn, would mark this descriptor as "used". After this
>> process, L2 would add the next descriptor in the TX vq while reusing this
>> ID. This was observed from idx 0 till idx 7.
>>
>> L2's debug logs:
>>
>> [   18.379112] (use_indirect?) output.0 -> verdict: 0                <----- Begin adding descriptor in idx 6
>> [   18.387134] (add_packed) output.0 -> idx: 6
>> [   18.389897] (add_packed) output.0 -> id: 0
>> [   18.392290] (add_packed) output.0 -> len: 74
>> [   18.394606] (add_packed) output.0 -> addr: 5012315726
>> [   18.397043] (add_packed) output.0 -> next id: 1
>> [   18.399861] Entering prepare_packed: output.0
>> [   18.402478] (prepare_packed) output.0 -> needs_kick: 1
>> [   18.404998] (notify) output.0 -> function will return true        <----- Notify QEMU
>> [   18.406349] output.0 -> id: 0, idx: 6                             <----- Mark ID 0 in idx 6 as used
>> [   18.409482] output.0 -> old free_head: 1, new free_head: 0        <----- ID 0 can be reused
>> [   18.410919] (after get_buf processed) output.0 -> id: 0, idx: 7   <----- Next slot is idx 7
>> [   18.921895] (use_indirect?) output.0 -> verdict: 0                <----- Begin adding descriptor with ID = 0 in idx 7
>> [   18.930093] (add_packed) output.0 -> idx: 7
>> [   18.935715] (add_packed) output.0 -> id: 0
>> [   18.937609] (add_packed) output.0 -> len: 122
>> [   18.939614] (add_packed) output.0 -> addr: 4925868038
>> [   18.941710] (add_packed) output.0 -> next id: 1
>> [   18.944032] Entering prepare_packed: output.0
>> [   18.946148] (prepare_packed) output.0 -> needs_kick: 1
>> [   18.948234] (notify) output.0 -> function will return true        <----- Notify QEMU
>> [   18.949606] output.0 -> id: 0, idx: 7                             <----- Mark ID 0 in idx 7 as used
>> [   18.952756] output.0 -> old free_head: 1, new free_head: 0        <----- ID 0 can be reused
>> [   18.955154] (after get_buf processed) output.0 -> id: 0, idx: 8   <----- Next slot is idx 8
>>
>> There was no issue in QEMU till this point.
>>
>> [   19.177536] (use_indirect?) output.0 -> verdict: 0                <----- Begin adding descriptor with ID = 0 in idx 8
>> [   19.182415] (add_packed) output.0 -> idx: 8
>> [   19.187257] (add_packed) output.0 -> id: 0
>> [   19.191355] (add_packed) output.0 -> len: 102
>> [   19.195131] (add_packed) output.0 -> addr: 4370702342
>> [   19.199224] (add_packed) output.0 -> next id: 1
>> [   19.204929] Entering prepare_packed: output.0
>> [   19.209505] (prepare_packed) output.0 -> needs_kick: 1
>> [   19.213820] (notify) output.0 -> function will return true       <----- Notify QEMU
>> [   19.218792] (use_indirect?) output.0 -> verdict: 0               <----- Next slot is idx 9
>> [   19.224730] (add_packed) output.0 -> idx: 9
>> [   19.227067] (add_packed) output.0 -> id: 1                       <----- ID 0 can't be reused yet, so use ID = 1
>> [   19.229090] (add_packed) output.0 -> len: 330
>> [   19.231182] (add_packed) output.0 -> addr: 4311020614
>> [   19.233302] (add_packed) output.0 -> next id: 2
>> [   19.235620] Entering prepare_packed: output.0
>> [   19.237781] (prepare_packed) output.0 -> needs_kick: 1
>> [   19.239958] (notify) output.0 -> function will return true       <----- Notify QEMU
>> [   19.237780] output.0 -> id: 0, idx: 8                            <----- Mark ID 0 in idx 8 as used
>> [   19.243676] output.0 -> old free_head: 2, new free_head: 0       <----- ID 0 can now be reused
>> [   19.245214] (after get_buf processed) output.0 -> id: 0, idx: 9  <----- Next slot is idx 9
>> [   19.247097] output.0 -> id: 1, idx: 9                            <----- Mark ID 1 in idx 9 as used
>> [   19.249612] output.0 -> old free_head: 0, new free_head: 1       <----- ID 1 can now be reused
>> [   19.252266] (after get_buf processed) output.0 -> id: 1, idx: 10 <----- Next slot is idx 10
>>
>> ID 0 and ID 1 in idx 8 and idx 9 respectively are pushed to QEMU
>> before either of them are marked as used.
>>
>> But in QEMU, the order is slightly different.
>>
>> num: 1, init_flags: 128                                                        <----- vhost_svq_add_packed()
>> idx: 8, id: 0, len: 0, flags: 0, vq idx: 1                                     <----- Before adding descriptor
>> idx: 8, id: 0, len: 102, flags: 128, vq idx: 1                                 <----- After adding descriptor
>> Finally: new_idx: 9, head_idx: 8, id: 0, len: 102, flags: 128, vq idx: 1
>> svq->vring.num: 256                                                            <----- Begin vhost_svq_get_buf_packed()
>> descriptor_len: 0
>> descriptor_id: 0                                                               <----- Mark ID = 0 as used
>> last_used: 8                                                                   <----- Processing idx 8
>> used_wrap_counter: 1
>> svq->desc_state[id].ndescs: 1
>> free_head: 0                                                                   <----- Update free_head to 0.
>> last_used: 9                                                                   <----- Update last_used to 9.
>> vq idx: 1                                                                      <----- End vhost_svq_get_buf_packed()
>> i: 0                                                                           <----- vhost_svq_flush()
>> descriptor_len: 0
>> elem->len: 22086
>> i: 1
>> elem_is_null: 1
>> vq idx: 1                                                                      <----- End vhost_svq_flush()
>> num: 1, init_flags: 128                                                        <----- vhost_svq_add_packed()
>> idx: 9, id: 0, len: 0, flags: 0, curr: 0, vq idx: 1                            <----- Before adding descriptor
>> idx: 9, id: 0, len: 330, flags: 128, curr: 1, vq idx: 1                        <----- After adding descriptor
>> Finally: new_idx: 10, head_idx: 9, id: 0, len: 330, flags: 128, vq idx: 1      <----- ID 0 has been reused (versus ID 1 in L2)
>> svq->vring.num: 256                                                            <----- Begin vhost_svq_get_buf_packed()
>> descriptor_len: 0
>> descriptor_id: 0                                                               <----- Mark ID = 0 as used
>> last_used: 9                                                                   <----- Processing idx 9
>> used_wrap_counter: 1
>> svq->desc_state[id].ndescs: 1
>> free_head: 0                                                                   <----- Update free_head to 0.
>> last_used: 10                                                                  <----- Update last_used to 10.
>> vq idx: 1                                                                      <----- End vhost_svq_get_buf_packed()
>> i: 0                                                                           <----- vhost_svq_flush()
>> descriptor_len: 0
>> elem->len: 22086
>> i: 1
>> elem_is_null: 1
>> vq idx: 1                                                                      <----- End vhost_svq_flush()
>>
>> In QEMU, id 0 is added in idx 8. But it's marked as used before a
>> descriptor can be added in idx 9. Because of this there's a discrepancy
>> in the value of free_head and in svq->desc_next.
>>
>> In the current implementation, the values of ID are generated, maintained
>> and processed by QEMU instead of reading from the guest's memory. I think
>> reading the value of ID from the guest memory (similar to reading the
>> descriptor length from guest memory) should resolve this issue.
>>
> 
> Ok you made a good catch here :).
> 
> The 1:1 sync is hard to achieve as a single buffer in the guest may
> need to be splitted in many buffers in the host.
> 
>> The alternative would be to ensure that "add_packed" and "get_buf_packed"
>> are synchronized between the guest and QEMU.
> 
> Yes, they're synchronized. When the guest makes an available
> descriptor, its head is saved in the VirtQueueElement of the SVQ's
> head idx on svq->desc_state.
> 
> Reviewing patch 3/7 I see you're actually returning the id of the
> first descriptor of the chain in *head, while it should be the id of
> the *last* descriptor. It should not be the cause of the failure, as I
> don't see any descriptor chain in the log.

Does this mean if the current free_head is 3 and the length of the chain
is 4, then ID 7 should be saved in the descriptor ring? In the current
implementation, *all* descriptors in the chain are being assigned the same
ID (= free_head instead of free_head + length of chain).

> To keep the free linked list happy we may need to store the head of the
> descriptor chain in the vq too.
> 
> Now, why is SVQ id 0 being reused? Sounds like free_list is not
> initialized to 0, 1, 2... but to something else like 0, 0, 0, etc. Can
> you print the whole list in each iteration?
> 

The free_list initially has the following values:
index 0 -> 1
index 1 -> 2
...
index 254 -> 255
index 255 -> 0

free_head is set to 0 at the beginning. When add_packed() executes for
the first time ID 0 is used and free_head is set to 1. If get_buf_packed()
is run immediately after the "add" operation, free_list[ID] is set to
the current free_head (ID 1 in this case). After this free_head is set to
the used ID (0 in this case).

So, free_list still looks like this:
index 0 -> 1
index 1 -> 2
...
index 254 -> 255
index 255 -> 0

But the free_head is 0. So, ID = 0 is reused again.

When 2 IDs (such as with idx 8 and idx 9 in the guest) are added to the
SVQ without either being used, then free_head is updated as shown:

free_head = 0 -> 1 -> 2

And then marking both IDs as "used" results in:

free_list[0] = current free_head (= 2)
free_head = 0
free_list[1] = current free_head (= 0)
free_head = 1

So free_list looks like this:

index 0 -> 2
index 1 -> 0
index 2 -> 3
index 3 -> 4
...
index 254 -> 255
index 255 -> 0

None of the indices in free_list hold the value 1.

Since at this point free_head is 1, ID 1 is now used very frequently
if add_packed() and get_buf_used() run one at a time in an interleaved
fashion.

Thanks,
Sahil

