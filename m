Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24356C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTjl-0002AG-LW; Mon, 26 May 2025 05:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJTjj-00029y-NP
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJTjh-0000O8-Q0
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748250183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W8Sf1Q1EHOlydNpyyMjYCFB8msCORH2a4E6iY0Ef1R8=;
 b=SwTbhjKvex0cbVJJTy8T00BHYN+wvnfS1AZD87tIFamNukJarMaBW2vITbzfbbGKnKZb+o
 h4qBw1g5b1mUOLxniQ56ydYS1Za8MMG4BaCqbX4bbsfj/lx5ck5KBL/49SPVWzQQ0tTgbA
 TMMJCFiLbcuuj4xsFYbiISWiacJ2SUU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-tbcJZz81NJCTJ9fRc0n8wA-1; Mon, 26 May 2025 05:02:32 -0400
X-MC-Unique: tbcJZz81NJCTJ9fRc0n8wA-1
X-Mimecast-MFC-AGG-ID: tbcJZz81NJCTJ9fRc0n8wA_1748250151
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4dcfc375aso219276f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748250151; x=1748854951;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=W8Sf1Q1EHOlydNpyyMjYCFB8msCORH2a4E6iY0Ef1R8=;
 b=okqYcil4DHcgNs7kY0Bo0fSuis/AhwLeG/aKGMlDNZYYGMDBc1hWlb/hU5Hhi0rALb
 JdoYdqvAjfvQkih4RGqzCYCvL02ijAxCd3gOOIKq45Edz32uvCPWA/aixUjOY7UAnsrV
 0W+GfbDgil2zZsQys5XFuMYHwYEdXQmZeBADjM7qRjnPW2OGv8akgtHm4/ZYTjElUAgH
 kUVQrX17jWichYjeeV9EAekEXBdBhe2oPSaer1mKjzrlr0KtEnOjWwRudxPui+wvYgoJ
 HNDqtgGNtWGETFaeJEWaYLXoxTFeGnmE6xNKH+CtPIBlBFzhO0UL3pVGRRLszr/znDf7
 q/Iw==
X-Gm-Message-State: AOJu0Yy01/espmp9OpVvsUuZDGWEfKVJTx7Ic0ya4XZ1HpOq9wrV9/oD
 PIqK9i+7uxCPZRuBPLf5irEnf1ABD5s06UyD11xdPninh8drlOVVPPsmLnaRWeTRR29jRYeSOB8
 YrnBVUa9Mr1u73X6LQm8H2QU4ledpIOsP8vdaG6d39Zys11P3iUF3NXtd
X-Gm-Gg: ASbGncvFjCt2xOdS3z0aTA9m+GLARvnUdWxiDh9amzE0kalzUlMGU27PV/d/lp41qMF
 MHzej+av4XzskbxFOl8jM9PXq0ykpaIJAnx66MX/5LNnj9Ivk41shjR/uvM3HiDAdqUKsjjHg9N
 aeV2DcqB0CtK470NcabpL5iCGy7gyww9C5sYKkbSqHvUEPO6Ri8BPMNREOUIVVc0uwsM+K69GY4
 20kjxNpHYfn1tVTH5QkJ2OW7ramx9YPic0nd8pU2cU8D1dbTnGoAR/7vAc4XLmInlNUQ42J0Fnl
 NrHBolb2GjM/Gwa4gOsgUeivQ5gG8lVbp/z33GQAWDkmHiVzhoG6Oze6LW4yFfdS3F7PLtGLN+D
 E5QOfwn+PoDhV6xeFlHPniDHM2oPlwVlCHi2sMH0=
X-Received: by 2002:a05:6000:2481:b0:3a4:d738:f98c with SMTP id
 ffacd0b85a97d-3a4d738fb73mr2313829f8f.30.1748250150826; 
 Mon, 26 May 2025 02:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFjV4M1AIjTPUqHzek2iW3vn2zmGxBCMtVSIzmXN788TDCibtHuIdIIC4kDphSNCdhCBOv/g==
X-Received: by 2002:a05:6000:2481:b0:3a4:d738:f98c with SMTP id
 ffacd0b85a97d-3a4d738fb73mr2313806f8f.30.1748250150388; 
 Mon, 26 May 2025 02:02:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:6500:e1c1:8216:4c25:efe4?
 (p200300d82f196500e1c182164c25efe4.dip0.t-ipconnect.de.
 [2003:d8:2f19:6500:e1c1:8216:4c25:efe4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4c5360a13sm9178781f8f.96.2025.05.26.02.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:02:29 -0700 (PDT)
Message-ID: <5cce0547-79de-4765-9797-093639c430ed@redhat.com>
Date: Mon, 26 May 2025 11:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] ram-block-attribute: Introduce a helper to
 notify shared/private state changes
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
 <20250520102856.132417-6-chenyi.qiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250520102856.132417-6-chenyi.qiang@intel.com>
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
> A new state_change() helper is introduced for RamBlockAttribute
> to efficiently notify all registered RamDiscardListeners, including
> VFIO listeners, about memory conversion events in guest_memfd. The VFIO
> listener can dynamically DMA map/unmap shared pages based on conversion
> types:
> - For conversions from shared to private, the VFIO system ensures the
>    discarding of shared mapping from the IOMMU.
> - For conversions from private to shared, it triggers the population of
>    the shared mapping into the IOMMU.
> 
> Currently, memory conversion failures cause QEMU to quit instead of
> resuming the guest or retrying the operation. It would be a future work
> to add more error handling or rollback mechanisms once conversion
> failures are allowed. For example, in-place conversion of guest_memfd
> could retry the unmap operation during the conversion from shared to
> private. However, for now, keep the complex error handling out of the
> picture as it is not required:
> 
> - If a conversion request is made for a page already in the desired
>    state, the helper simply returns success.
> - For requests involving a range partially in the desired state, there
>    is no such scenario in practice at present. Simply return error.
> - If a conversion request is declined by other systems, such as a
>    failure from VFIO during notify_to_populated(), the failure is
>    returned directly. As for notify_to_discard(), VFIO cannot fail
>    unmap/unpin, so no error is returned.
> 
> Note that the bitmap status is updated before callbacks, allowing
> listeners to handle memory based on the latest status.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---

I think this should be squashed into the previous patch: I fail to see 
why the split makes sense.

-- 
Cheers,

David / dhildenb


