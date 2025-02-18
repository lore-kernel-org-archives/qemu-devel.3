Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A883CC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 07:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkHyJ-0004CX-F3; Tue, 18 Feb 2025 02:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkHyH-0004CD-8U
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:24:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkHyF-0003IL-0h
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739863481;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kxCCkdRmXeLy1Nydo7YHZSrx6nZc3sBidRkQdw6j4Aw=;
 b=be0P/0daRmLndK0JPOfGL5lBwQMNQgKmn2uMGVOL1pQQ5ZoBdzVgNQ0fmjr5+URUs6+MJS
 /mdNTvfMOQEQC/qSS6Pmq4AK4xIWV55CzyXmIbVHRg+QKdwgby08RgoPBFjyoJXSiPQFUD
 W8x9/mBGH/FVziIdEVHCw3W+3oiv1ms=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-V6DwTWekNaSL7JfEYBewhQ-1; Tue, 18 Feb 2025 02:24:39 -0500
X-MC-Unique: V6DwTWekNaSL7JfEYBewhQ-1
X-Mimecast-MFC-AGG-ID: V6DwTWekNaSL7JfEYBewhQ_1739863478
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-439868806bbso7323515e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 23:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739863478; x=1740468278;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kxCCkdRmXeLy1Nydo7YHZSrx6nZc3sBidRkQdw6j4Aw=;
 b=DG3BJYQeSQnmLWMyfHshBBFnzXzz4LZPHLIglbnIeeJEisnuik5mlHQ/NQTmxllwb5
 AmCrOOnvBYuUZbt9VPj1PAFbhTR/HfiLLJIIkrmbicndg8LngY83U0SR1uNNfMYeaKfX
 G4bGGWwLQ7MTZaFS2v6rMAZX5nULcEJkncPu1rTopn0bGBEQIFTshHINup4PR+XmBgra
 OF2VV59r055oJocV7BU82au+TK+SWgjXNO99bXeFwW8nmVg56s7nOameNhDiTlmSc4mC
 mviQLTxDJ3LhAX/jYOrduPzJZxcYuVjzQi065ObKWVx+L4CRXmw51RuEIGygW7OZ3m+M
 uAQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTGGZoy9F4c1CaycAktMinAaHu1dICmdSBvwWUxjFVxqOtaTLcjHJnidT8OckJMtz7tKZKQZfbYvOx@nongnu.org
X-Gm-Message-State: AOJu0YwoLcWobyFva4mE/f6fBG/XVsIuLngcH9hg5XIJVvTCW6tu/Sk5
 Du3YB2qi4wI1rO+SvdUrT/IrI2/ll87MC64QHqoEyXPlUMccAZugRbsGEESnOpwijqZOycgXTEG
 ciLs+QrvV7bu6iBZxO2JmMAayRKNNHc2oPGI2qUvfgqsS788QSCx0
X-Gm-Gg: ASbGnctR+lA3tyLtMkZH5jEAsDlW+ATw8iMpUjoJLDg6wekGBslhZcH6AWhDUwYkO35
 l9Po2/+AYnHivIOSzEyCl2b9ZZJQOjFkmJPX65+t/4EFKhvxFYAX3yuPT7Q7mArtZ5Q/QtDZgcd
 LVOUl2uzDDsOb/aW8Ww0NPbVfaUcSva4iDWawlMAmOJS4bcQVUW9iVQR43cJ6HqD3gMysQQdolZ
 0rjdrBkNFJG8YxQ2AVaFmTsbbFSreNdedd1bcN8T/BE1i/X95Wl+v4kmhTHj2A/Mgj+h00cXqJ4
 6UTxm0bX0uieNptVbGxuDVBQwtJQiB50ANEukusGPx4oUpM2UsCI
X-Received: by 2002:a5d:6c66:0:b0:388:c61d:4415 with SMTP id
 ffacd0b85a97d-38f33c20aa7mr10663869f8f.18.1739863478072; 
 Mon, 17 Feb 2025 23:24:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE1Wc4tUgTsc01rFK9TjzILbz6gihOAOlXWQ+WRRzNECKSmVSHs37IYYOqTAwvM2NSk+DY1A==
X-Received: by 2002:a5d:6c66:0:b0:388:c61d:4415 with SMTP id
 ffacd0b85a97d-38f33c20aa7mr10663851f8f.18.1739863477730; 
 Mon, 17 Feb 2025 23:24:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25915719sm14344352f8f.60.2025.02.17.23.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 23:24:36 -0800 (PST)
Message-ID: <88169d47-f3a1-4dbe-aa9e-9ca3617adca8@redhat.com>
Date: Tue, 18 Feb 2025 08:24:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Fix vIOMMU reset order
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>
References: <20250217133746.6801-1-eric.auger@redhat.com>
 <SJ0PR11MB67449A41C11701DC5719A63292FA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67449A41C11701DC5719A63292FA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 2/18/25 4:32 AM, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: [PATCH v2 0/5] Fix vIOMMU reset order
>>
>> With current reset scheme, DMA capable devices are reset before
> s/before/after
ugh definitively! :-)
>
>> the vIOMMU which translate them. This holds for the different
>> IOMMUs and various DMA capable devices such as virtio devices
>> and VFIO ones. With virtio devices spurious traces can be
>> observed at qemu level such as "virtio: zero sized buffers are
>> not allowed" while for VFIO devices, translation faults can be
>> observed at host level.
>>
>> Virtio devices use 3 phase reset and virtio-pci devices are reset
>> in the 'hold' phase. VFIO device reset are registered using
>> qemu_register_reset() and as a consequence they are also reset
>> on 'hold' phase.
>>
>> Note that the tree of QOM devices resets depth-first but it does
>> so while enforcing the 3 phases. First the tree is traversed doing
>> the 'enter' phase, then the 'hold' phase and eventually the 'exit'
>> phase.
>>
>> However the QOM hierarchy is not built so that vIOMMUs get reset
>> before the DMA capable devices (IOMMUs are using either legacy reset
> s/before/after


>
>> scheme or hold phase). Changing the QOM hierarchy does not sound
>> trivial while forcing the vIOMMUs to be reset on 'exit' phase
>> sounds reasonable and much simpler. Obviously this relies on the
>> assumption that all DMA capable devices quiesce their DMA before
>> (ie. during 'enter' or hold' phase).
>>
>> This was tested with qmp system_reset and virsh reset.
> For the whole series,
>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Thanks!

Eric
>
> Thanks
> Zhenzhong


