Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA6EC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJU36-0002I5-NN; Mon, 26 May 2025 05:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJU35-0002Hv-Bj
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJU32-0003Fe-Ar
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748251385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=phTdJj0KAJyBPbCCmlZgtPAAFKe+8e9lUlf5Yjatomc=;
 b=JL5PftdvCD7/efD0x2f/5XX7Nyg6/9Wu3ulAYIOl7z9Q9nU+2+tfGI66I04dlQd/rGv+JD
 KCugjp389R7udtXwE0J7f9LTyGnVj0IsGqSm2v3F9dSjeya4ce4cx/5LVdzkTrwpnOuz7j
 XIpD6USjUDdewKi34jQSPPSC/sXH2uw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-R81_1an7O9C4HUHZeb1www-1; Mon, 26 May 2025 05:23:02 -0400
X-MC-Unique: R81_1an7O9C4HUHZeb1www-1
X-Mimecast-MFC-AGG-ID: R81_1an7O9C4HUHZeb1www_1748251382
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4cfda0ab8so517925f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748251381; x=1748856181;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=phTdJj0KAJyBPbCCmlZgtPAAFKe+8e9lUlf5Yjatomc=;
 b=MjuvyJjjYN2Joui18N1okvlhnZbnCvhk+o6eCHvgsZMEkZHUcpat9Dckb+c2Hkzhqt
 a1tM4xCrScVUu7i18b3ScJflCETOeBkG2BySrOfuLQhtA0i9UR3WcB9fzxpjEmuftush
 PrIgSJCzI3KCa3n/2uA3tQ8WhPTUfl/fvUwxVTHbZp3Tp79vmmjV7KqabYP4TwIbjlA8
 4GZ3g93n8SW1yw0KNaqBUMJomwpXSTWUXpeKR2y49IT8lqXzxyvR6cCGyWdodTE95Sc3
 wnaToJl1ZM1GV1a6/LvEBDPjeF29TU5muhRCbIqYizQzAAOoAfQEcj2lVUBvOjz/7/vo
 r9FQ==
X-Gm-Message-State: AOJu0YwV1eEyfEUsXwRI0fmGqUwK0lCTCstmPMQ9/vQgStUBoVyW69HU
 /RGBPCzOs4fSqMBweYvjJ9qwtK+vfBBuWEpvqxwzZarDG5PtjwnUwwEDz+DE8/3vwukUIHEbtBo
 b8Y6m6kkmSBJJAPYnzSUwhyV+nP3+8mtYZ9uCZBG+GZ7Z/5yhn/JkWYPC
X-Gm-Gg: ASbGncsNuPF59wyotOShBd92DxuCmgq7UTCKzr5GQ2RsBflWgcVK4Co5vG2Pumr0pSs
 VhLp6rm576/FtoP8RNIhpuqnxwTW02+9iMliM3TiTWoAniHyeRd7xS4DPMjSByCCR1Ayb9fiFDf
 UNnuowPbda2LaBd4LAA6eoZnqmHSpzmqbL4p0yeA6peNGX0VBd6Qqma/s4RIoEpFlnwaNnssXwT
 s6sFz+DtW0lF9GiBv+pDjWK6EwO4iAgOo0iYxQbdwJXOVKJVic+oSQQNOET9EV3ehE2TAJV2N28
 98Ad1utTmRQWyKuaTuWJVDbmgDQrI+9zvOZ2FAS7sKh6n0Ty0Qi1OWu8behlqh5s2QlKfUsvElz
 J7Z5IIOTp4OxO80rgvTjH03j4BIPLjH+ey6botCs=
X-Received: by 2002:a05:6000:2082:b0:3a1:f68b:57c9 with SMTP id
 ffacd0b85a97d-3a4cb407b33mr5416597f8f.6.1748251381646; 
 Mon, 26 May 2025 02:23:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0Iy+mETN512dlt1DljBDoAYB1upu7FTX113bm5Gtwq9OByr75EkOWODGpn6zZkGn10wi9vg==
X-Received: by 2002:a05:6000:2082:b0:3a1:f68b:57c9 with SMTP id
 ffacd0b85a97d-3a4cb407b33mr5416576f8f.6.1748251381293; 
 Mon, 26 May 2025 02:23:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:6500:e1c1:8216:4c25:efe4?
 (p200300d82f196500e1c182164c25efe4.dip0.t-ipconnect.de.
 [2003:d8:2f19:6500:e1c1:8216:4c25:efe4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cdde6415sm6767370f8f.60.2025.05.26.02.23.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:23:00 -0700 (PDT)
Message-ID: <ccb81d9b-1c89-45e4-86b0-1d30a8e94930@redhat.com>
Date: Mon, 26 May 2025 11:22:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] KVM: Introduce RamDiscardListener for attribute
 changes during memory conversions
To: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy
 <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-10-chenyi.qiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250520102856.132417-10-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20.05.25 12:28, Chenyi Qiang wrote:
> With the introduction of the RamBlockAttribute object to manage
> RAMBlocks with guest_memfd, it is more elegant to move KVM set attribute
> into a RamDiscardListener.
> 
> The KVM attribute change RamDiscardListener is registered/unregistered
> for each memory region section during kvm_region_add/del(). The listener
> handler performs attribute change upon receiving notifications from
> ram_block_attribute_state_change() calls. After this change, the
> operations in kvm_convert_memory() can be removed.
> 
> Note that, errors can be returned in
> ram_block_attribute_notify_to_discard() by KVM attribute changes,
> although it is currently unlikely to happen. With in-place conversion
> guest_memfd in the future, it would be more likely to encounter errors
> and require error handling. For now, simply return the result, and
> kvm_convert_memory() will cause QEMU to quit if any issue arises.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---

[...]

>   static void kvm_region_commit(MemoryListener *listener)
> @@ -3077,15 +3140,6 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>           goto out_unref;
>       }
>   
> -    if (to_private) {
> -        ret = kvm_set_memory_attributes_private(start, size);
> -    } else {
> -        ret = kvm_set_memory_attributes_shared(start, size);
> -    }
> -    if (ret) {
> -        goto out_unref;
> -    }
> -

I wonder if it's best to leave that out for now. With in-place 
conversion it will all get a bit more tricky, because we'd need to call 
in different orders ...

e.g., do private -> shared before mapping to vfio, but to shared 
->private after unmapping from vfio.

That can be easier handled when doing the calls from KVM code directly.

-- 
Cheers,

David / dhildenb


