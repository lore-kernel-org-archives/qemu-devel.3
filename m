Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5835C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 05:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty2Lu-0007wm-1z; Fri, 28 Mar 2025 01:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1ty2Ls-0007wM-No
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 01:33:56 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1ty2Lr-0004AY-1j
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 01:33:56 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso4450084a91.0
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 22:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743140033; x=1743744833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xymrStJaY7dbxbtpmmsm7xi1LNGlJ+HGXVfRoFbm5Rs=;
 b=l6fvIH5XHlSI1glri9zDmrdpgOpHfMsqxtOcGBZk36gkxpIhjurCtSp5feVzS97O/I
 XUewwXm3+GUAGHyqypjHeulWW5JCEqnSBRBZV+3lJcVjapHEZsIOrJNWASMVZMZ/4eZv
 n6OWEmo1ictBokX+Evk2o4HtcMSl220u8/cQgBZifX7AURL7Z+5D0/Cg83rbNkSKf9dg
 IeQmz+vVo54LFN+BeAvu1esY3tqGzHDD6MmA3jB1Qt+waD2OkpFDqBVUY/Zgc34EZ6lA
 BSpkEGrF58Xcai7yzA2j66c4RQcfvZAvRXEswFPSs9sxA91wO2a1f+qd7dPUDIm963mw
 7weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743140033; x=1743744833;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xymrStJaY7dbxbtpmmsm7xi1LNGlJ+HGXVfRoFbm5Rs=;
 b=TZypEx6oSkIK7hxxgRy2Dsoj+MvYZZxFGqArv62vBzdB9RvHEHZl0bObKmi8+7EtOV
 LAOd1ivqePnUeq/Qm/pRj1v+dzX+de0KgZqeWzyxINErorDCOPsVH+VTnT4rLJbkkWml
 TzbxTujiI7c3gaoln8Q7oN0QFPb8BgrX3Uh2KGOXIIV8lc22/+wC4NX7bw7EkCgJ8fsy
 lN+RWrmK2vRI+O0os1E77ZV7jYKBTwyMyLazmlTZXUEvpMjidcaA1F8FrhdVGZXKUQuP
 j23c//EJaE9Cy2Kb7KZGHLAP3q9HFMQ0KeB5cXoo/SNpGDM4GA6W+lkmXOss+PaI7sNX
 hqdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZOB45g+CbDw8KTFERQz8ThaDCd5STQnnrmW4iF4fD9BL9x3SKFmg+VMzTRkepp+FMUopN/01Xh7xX@nongnu.org
X-Gm-Message-State: AOJu0YyzIFmiMNX1wy/9ntT5MYmYgrbS4+fktaFYr9Ra7+SMsjBjTx7t
 oF7n4Ep48wAuRLqDkORX8DlrHP+AHr58VEADaAa4Fjhi7Wiyv5DG
X-Gm-Gg: ASbGncuGGn5mrThVIzn+S7RK3ieSuQERtS+PTfiwz3hAgViZoBXJWEuXL+5hhhXsHfF
 SzLzRUf/t5HLUcqmkBVklD0qdqvOt7grPDqt8a2e2OKtgBqJBuYCUXLdiGeLcUYbULlVte2Qh3H
 FWnkRTk/dSUoZXEwLZUvFxfynyfn6WbI2UyvIbW2a5DVic4VCCy0xnuY3Cj3gnS9OVmr42qHYPQ
 t8buByJU8MnSXOmiWnE4lyd2MvRh/jyLDshYICW8qNSOU5kmeSnIRb2x3uuVbkrq01dk409Oa7t
 lJb46LWU14cokjuGA+I5jvvQvyAlIyGTsMSsCywlk/46pBQ8cFxIOSB7cPNuxu67ZLtmvf7xFto
 Ku9iDiBCYYqDe
X-Google-Smtp-Source: AGHT+IF/XI3FlRK4a1qsNZG8L/tfM+hFPMoEzp6pgiyR/n//cwkN+jIe0/6aVSVECPefC8VDunEa/A==
X-Received: by 2002:a05:6a00:2918:b0:736:5813:8c46 with SMTP id
 d2e1a72fcca58-7397271aadcmr2652350b3a.8.1743140032364; 
 Thu, 27 Mar 2025 22:33:52 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d?
 ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73971090aeesm829306b3a.124.2025.03.27.22.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 22:33:51 -0700 (PDT)
Message-ID: <18a9abc3-6be2-46ca-9228-a53b5c668374@gmail.com>
Date: Fri, 28 Mar 2025 11:03:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 6/7] vhost: Validate transport device features for packed
 vqs
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 sahilcdq@proton.me
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-7-sahilcdq@proton.me>
 <CAJaqyWecV3X9PmRHikjkGYT1jbN_ygyKYqvi5AuMtb_aE9oZ0g@mail.gmail.com>
Content-Language: en-US
From: Sahil Siddiq <icegambit91@gmail.com>
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <CAJaqyWecV3X9PmRHikjkGYT1jbN_ygyKYqvi5AuMtb_aE9oZ0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=icegambit91@gmail.com; helo=mail-pj1-x1034.google.com
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

On 3/26/25 5:36 PM, Eugenio Perez Martin wrote:
> On Mon, Mar 24, 2025 at 3:00 PM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>
>> Validate transport device features required for utilizing packed SVQ
>> that both guests can use with the SVQ and SVQs can use with vdpa.
>>
>> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>> ---
>> Changes from v4 -> v5:
>> - Split from commit #2 in v4.
>>
>>   hw/virtio/vhost-shadow-virtqueue.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
>> index 8430b3c94a..035ab1e66f 100644
>> --- a/hw/virtio/vhost-shadow-virtqueue.c
>> +++ b/hw/virtio/vhost-shadow-virtqueue.c
>> @@ -33,6 +33,9 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
>>            ++b) {
>>           switch (b) {
>>           case VIRTIO_F_ANY_LAYOUT:
>> +        case VIRTIO_F_RING_PACKED:
>> +        case VIRTIO_F_RING_RESET:
>> +        case VIRTIO_RING_F_INDIRECT_DESC:
> 
> This should only enable _F_RING_PACKED, there is no code supporting
> either reset or indirect descriptors.
> 

Without _F_RING_RESET and _RING_F_INDIRECT_DESC, I get the following error:

qemu-system-x86_64: -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,x-svq=true,id=vhost-vdpa0: SVQ Invalid device feature flags, offer: 0x1071011ffa7, ok: 0x70011ffa7

Evaluating 0x1071011ffa7 & ~0x70011ffa7 gives me 0x10010000000 as the
set of invalid features. This corresponds to _F_RING_RESET (1 << 40)
and _RING_F_INDIRECT_DESC (1 << 28) [1].

I get this error when x-svq=true irrespective of whether split vqs or packed
vqs are used.

Is there a way to turn them off in the QEMU command?

Thanks,
Sahil

[1] https://gitlab.com/qemu-project/qemu/-/blob/master/include/standard-headers/linux/virtio_config.h

