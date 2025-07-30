Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D35C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 15:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh91T-0005l5-8o; Wed, 30 Jul 2025 11:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1uh7rs-0000Jh-D5
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 10:33:26 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1uh7rp-0002Gh-Sm
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 10:33:20 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2401b855980so8928835ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753885995; x=1754490795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=m3WWiHrCZp2ljVmM8XOUbZqNjGd/jByLjWkPv+bq7To=;
 b=ebcDbgvhKzHu4+Rc5r6kD07UHsWXiBOTPwIe4NBP8Fyf9tdrCj4e+z6MoG++kXjUEP
 sfa3xa8CtS0EXaKTgEAaJYSwhC8or02zMVb+C9K5EjdbaTPh25xtIeGygCIHyovpGf4C
 38V+VJxyFI3nKdN8LtfsF51gLhYy8EGjk83OLZvthwshUivl3mKlpyimewP2OyhNgQfA
 a8FeHn1nVp9X4DBgS/vBlGHPd9dqRgckc5BNopaP0pI57ruruLhfcfm5sV/j2yRaoeRh
 nSXunVDpsxutODDBIHxiQl6/RiM16yBWl+HIa/5pZfVhLZ8YxyBYg7KRPQ88iR2bI6Og
 D1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753885995; x=1754490795;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m3WWiHrCZp2ljVmM8XOUbZqNjGd/jByLjWkPv+bq7To=;
 b=qotwdXnP+u9shZr2ZoYvhV/wfr5K7tbQxyzdTECcHCOHe3/dERZqMaSqv9bGXt89oS
 /rqBvpDXCh2bfBGb7NYlarS9ClISOf0O74Xbdc4qESKryceW3094DicvK+XwnqEN7uFF
 ZwiAbOy/km91AmYp1RdPfeBMbDrIOoGCwwMzZQ7jhYsYeHghbLdlBnSq7mZB1/O9Dq8+
 O2KGyafqrsH2T2VSZiKQr0N1xMEzBp3l9yggEVFFt8kNfaSSt0koCgS8KLe6z0LIMBJs
 MmU3vjtWrIEz/irvs4twXIMNnmYfqxQhASaehKDDM8XUXJQr4TwO+s7Kr4pmxqo2dysK
 ZMPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFgee1HyaWn7RSVAzqwHzvLJ0WWMyMNjFZfkO+dHN3CbHGkB618dBJ+EC7/dc90Tql0hFqvY1UedA3@nongnu.org
X-Gm-Message-State: AOJu0YyZtzHGySa4PoV4eFSZ0UxyIwVs7YLIlaDLG165wR5Wj7G/Gw4y
 9SK5oKqvtcxN3BVqEWtbb6F+L2wzkn15/34WVe0q/3uZkSt+AjEVTuuh
X-Gm-Gg: ASbGncvwmVvlFSQ/UQAG78tBCWgi6f5281R3R4kxrd2SFKHMTayC4+uj2AGCno3TMih
 PComturODAkMcAzQl8gLXhJwl5v6D6snqna1VZErqG18kBtBkyz/q0//yxK+fPDT88QmfkkmcaQ
 4PNC780Vke+L5kW/sFJ5ZnGD9PbWrP3y9FgHb2vXFLcEic5Pu7gfCLn51yxQ71OUjVMoBXS/vT9
 yNhbdV4Yft1lieI9lsynVWvjOjl3ER4RBFHkVCaqqrVfAX9otI/LxdtEWueZkwsdmJ7ctjJ0w0h
 sxUnndiwrRFOKyj+isD+WtSMVgkQ4cIcEMW4nPL8fbRtb+5LBABfSCiGTfxo/4r0AkjvjIcKsCL
 FPnZtOBkJq3zcYJdQ2C26F5+y6+Za6Z1JSATJVArXexrez+e3GQ0urwJJJbCPiUs0qMGGny9mzb
 4w
X-Google-Smtp-Source: AGHT+IGJdxRmzJqxi/C4lICNZgZ6/STRft55f8FQuJL7F1+pa4X7b+wvmscF3RVAUf/OFWg33L3ZZA==
X-Received: by 2002:a17:903:1967:b0:23d:dd04:28e5 with SMTP id
 d9443c01a7336-24096af6b3amr45125195ad.34.1753885995072; 
 Wed, 30 Jul 2025 07:33:15 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c7e:3276:1bfa:40c6:8594:9193?
 ([2401:4900:1c7e:3276:1bfa:40c6:8594:9193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2401e95208bsm75888905ad.112.2025.07.30.07.32.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 07:33:14 -0700 (PDT)
Message-ID: <68e7a854-f7d3-4d21-87b0-3a23f4341493@gmail.com>
Date: Wed, 30 Jul 2025 20:02:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sahil Siddiq <icegambit91@gmail.com>
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
Content-Language: en-US
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWeG2n=BhjNhQzMagjh5t-dgno6q-esVjzqrw8z3_sUrHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x631.google.com
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

I think I have finally found the reason behind this issue.

The order in which "add_packed" and "get_buf_packed" are performed in the
nested guest kernel (L2 kernel) and QEMU are a little different. Due to
this, the values in free_head and svq->desc_next[] differ and the guest
crashes at some point. More below.

On 6/26/25 1:07 PM, Eugenio Perez Martin wrote:
> On Thu, Jun 26, 2025 at 7:16 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>> I think there's something off in the way "free_head", "last_used_idx" and
>> "desc_next" values are calculated in vhost_svq_get_buf_packed() [1].
>>
>> In the latest test run, QEMU sent ids 0 through 28 to L2. L2 started receiving
>> them in order till id 8. At this point it received id 7 again for some reason
>> and then crashed.
>>
>> L2:
>>
>> [ 1641.129218] (prepare_packed) output.0 -> needs_kick: 1
>> [ 1641.130621] (notify) output.0 -> function will return true
>> [ 1641.132022] output.0 -> id: 0
>> [ 1739.502358] input.0 -> id: 0
>> [ 1739.503003] input.0 -> id: 1
>> [ 1739.562024] input.0 -> id: 2
>> [ 1739.578682] input.0 -> id: 3
>> [ 1739.661913] input.0 -> id: 4
>> [ 1739.828796] input.0 -> id: 5
>> [ 1739.829789] input.0 -> id: 6
>> [ 1740.078757] input.0 -> id: 7
>> [ 1740.079749] input.0 -> id: 8
>> [ 1740.080382] input.0 -> id: 7    <----Received 7 again
>> [ 1740.081614] virtio_net virtio1: input.0:id 7 is not a head!
>>
>> QEMU logs (vhost_svq_get_buf_packed):
>> ------
>> size              : svq->vring.num
>> len               : svq->vring_packed.vring.desc[last_used].len
>> id                : svq->vring_packed.vring.desc[last_used].id
>> num               : svq->desc_state[id].ndescs
>> last_used_chain   : Result of vhost_svq_last_desc_of_chain(svq, num, id) [2]
>> free_head         : svq->free_head
>> last_used         : (last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR)) + num
>> used_wrap_counter : !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CTR))
>> ------
>> size: 256, len: 82, id: 7, vq idx: 0
>> id: 7, last_used_chain: 7, free_head: 6, vq idx: 0
>> num: 1, free_head: 7, id: 7, last_used: 8, used_wrap_counter: 1, vq idx: 0
>> ------
>> size: 256, len: 104, id: 8, vq idx: 0
>> id: 8, last_used_chain: 8, free_head: 7, vq idx: 0
>> num: 1, free_head: 8, id: 8, last_used: 9, used_wrap_counter: 1, vq idx: 0
>> ------
>> size: 256, len: 98, id: 9, vq idx: 0
>> id: 9, last_used_chain: 9, free_head: 8, vq idx: 0
>> num: 1, free_head: 9, id: 9, last_used: 10, used_wrap_counter: 1, vq idx: 0
>> ------
>> size: 256, len: 104, id: 10, vq idx: 0
>> id: 10, last_used_chain: 10, free_head: 9, vq idx: 0
>> num: 1, free_head: 10, id: 10, last_used: 11, used_wrap_counter: 1, vq idx: 0
>>
>> I have a few more ideas of what to do. I'll let you know if I find something
>> else.
>>
> I cannot find anything just by inspection. What about printing all the
> desc_state and all desc_next to check for incoherencies in each
> svq_add and get_buf?
In this test, all 256 descriptors were filled in the RX vq.

In the TX queue, L2 kernel would add one descriptor at a time and notify
QEMU. QEMU would then register it in its SVQ and mark it as "available".
After processing the descriptor, QEMU would mark it as "used" and flush it
back to L2. L2, in turn, would mark this descriptor as "used". After this
process, L2 would add the next descriptor in the TX vq while reusing this
ID. This was observed from idx 0 till idx 7.

L2's debug logs:

[   18.379112] (use_indirect?) output.0 -> verdict: 0                <----- Begin adding descriptor in idx 6
[   18.387134] (add_packed) output.0 -> idx: 6
[   18.389897] (add_packed) output.0 -> id: 0
[   18.392290] (add_packed) output.0 -> len: 74
[   18.394606] (add_packed) output.0 -> addr: 5012315726
[   18.397043] (add_packed) output.0 -> next id: 1
[   18.399861] Entering prepare_packed: output.0
[   18.402478] (prepare_packed) output.0 -> needs_kick: 1
[   18.404998] (notify) output.0 -> function will return true        <----- Notify QEMU
[   18.406349] output.0 -> id: 0, idx: 6                             <----- Mark ID 0 in idx 6 as used
[   18.409482] output.0 -> old free_head: 1, new free_head: 0        <----- ID 0 can be reused
[   18.410919] (after get_buf processed) output.0 -> id: 0, idx: 7   <----- Next slot is idx 7
[   18.921895] (use_indirect?) output.0 -> verdict: 0                <----- Begin adding descriptor with ID = 0 in idx 7
[   18.930093] (add_packed) output.0 -> idx: 7
[   18.935715] (add_packed) output.0 -> id: 0
[   18.937609] (add_packed) output.0 -> len: 122
[   18.939614] (add_packed) output.0 -> addr: 4925868038
[   18.941710] (add_packed) output.0 -> next id: 1
[   18.944032] Entering prepare_packed: output.0
[   18.946148] (prepare_packed) output.0 -> needs_kick: 1
[   18.948234] (notify) output.0 -> function will return true        <----- Notify QEMU
[   18.949606] output.0 -> id: 0, idx: 7                             <----- Mark ID 0 in idx 7 as used
[   18.952756] output.0 -> old free_head: 1, new free_head: 0        <----- ID 0 can be reused
[   18.955154] (after get_buf processed) output.0 -> id: 0, idx: 8   <----- Next slot is idx 8

There was no issue in QEMU till this point.

[   19.177536] (use_indirect?) output.0 -> verdict: 0                <----- Begin adding descriptor with ID = 0 in idx 8
[   19.182415] (add_packed) output.0 -> idx: 8
[   19.187257] (add_packed) output.0 -> id: 0
[   19.191355] (add_packed) output.0 -> len: 102
[   19.195131] (add_packed) output.0 -> addr: 4370702342
[   19.199224] (add_packed) output.0 -> next id: 1
[   19.204929] Entering prepare_packed: output.0
[   19.209505] (prepare_packed) output.0 -> needs_kick: 1
[   19.213820] (notify) output.0 -> function will return true       <----- Notify QEMU
[   19.218792] (use_indirect?) output.0 -> verdict: 0               <----- Next slot is idx 9
[   19.224730] (add_packed) output.0 -> idx: 9
[   19.227067] (add_packed) output.0 -> id: 1                       <----- ID 0 can't be reused yet, so use ID = 1
[   19.229090] (add_packed) output.0 -> len: 330
[   19.231182] (add_packed) output.0 -> addr: 4311020614
[   19.233302] (add_packed) output.0 -> next id: 2
[   19.235620] Entering prepare_packed: output.0
[   19.237781] (prepare_packed) output.0 -> needs_kick: 1
[   19.239958] (notify) output.0 -> function will return true       <----- Notify QEMU
[   19.237780] output.0 -> id: 0, idx: 8                            <----- Mark ID 0 in idx 8 as used
[   19.243676] output.0 -> old free_head: 2, new free_head: 0       <----- ID 0 can now be reused
[   19.245214] (after get_buf processed) output.0 -> id: 0, idx: 9  <----- Next slot is idx 9
[   19.247097] output.0 -> id: 1, idx: 9                            <----- Mark ID 1 in idx 9 as used
[   19.249612] output.0 -> old free_head: 0, new free_head: 1       <----- ID 1 can now be reused
[   19.252266] (after get_buf processed) output.0 -> id: 1, idx: 10 <----- Next slot is idx 10

ID 0 and ID 1 in idx 8 and idx 9 respectively are pushed to QEMU
before either of them are marked as used.

But in QEMU, the order is slightly different.

num: 1, init_flags: 128                                                        <----- vhost_svq_add_packed()
idx: 8, id: 0, len: 0, flags: 0, vq idx: 1                                     <----- Before adding descriptor
idx: 8, id: 0, len: 102, flags: 128, vq idx: 1                                 <----- After adding descriptor
Finally: new_idx: 9, head_idx: 8, id: 0, len: 102, flags: 128, vq idx: 1
svq->vring.num: 256                                                            <----- Begin vhost_svq_get_buf_packed()
descriptor_len: 0
descriptor_id: 0                                                               <----- Mark ID = 0 as used
last_used: 8                                                                   <----- Processing idx 8
used_wrap_counter: 1
svq->desc_state[id].ndescs: 1
free_head: 0                                                                   <----- Update free_head to 0.
last_used: 9                                                                   <----- Update last_used to 9.
vq idx: 1                                                                      <----- End vhost_svq_get_buf_packed()
i: 0                                                                           <----- vhost_svq_flush()
descriptor_len: 0
elem->len: 22086
i: 1
elem_is_null: 1
vq idx: 1                                                                      <----- End vhost_svq_flush()
num: 1, init_flags: 128                                                        <----- vhost_svq_add_packed()
idx: 9, id: 0, len: 0, flags: 0, curr: 0, vq idx: 1                            <----- Before adding descriptor
idx: 9, id: 0, len: 330, flags: 128, curr: 1, vq idx: 1                        <----- After adding descriptor
Finally: new_idx: 10, head_idx: 9, id: 0, len: 330, flags: 128, vq idx: 1      <----- ID 0 has been reused (versus ID 1 in L2)
svq->vring.num: 256                                                            <----- Begin vhost_svq_get_buf_packed()
descriptor_len: 0
descriptor_id: 0                                                               <----- Mark ID = 0 as used
last_used: 9                                                                   <----- Processing idx 9
used_wrap_counter: 1
svq->desc_state[id].ndescs: 1
free_head: 0                                                                   <----- Update free_head to 0.
last_used: 10                                                                  <----- Update last_used to 10.
vq idx: 1                                                                      <----- End vhost_svq_get_buf_packed()
i: 0                                                                           <----- vhost_svq_flush()
descriptor_len: 0
elem->len: 22086
i: 1
elem_is_null: 1
vq idx: 1                                                                      <----- End vhost_svq_flush()

In QEMU, id 0 is added in idx 8. But it's marked as used before a
descriptor can be added in idx 9. Because of this there's a discrepancy
in the value of free_head and in svq->desc_next.

In the current implementation, the values of ID are generated, maintained
and processed by QEMU instead of reading from the guest's memory. I think
reading the value of ID from the guest memory (similar to reading the
descriptor length from guest memory) should resolve this issue.

The alternative would be to ensure that "add_packed" and "get_buf_packed"
are synchronized between the guest and QEMU.

What are your thoughts on this?

Thanks,
Sahil




