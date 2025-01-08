Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E720E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdVL-0001aP-RF; Wed, 08 Jan 2025 16:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tVdVI-0001a8-VF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:22:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tVdVH-0005dE-BB
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736371334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Bfj03Z1hailZKFXRLUXKAdtZqhCy+9zpwuchbFoqM/Y=;
 b=Jjl+Uz47LpkPkvTGVx0fDd8+XE4o00hoZzjEZ+ijP6Da7s06s4FU1cAVJ8+U6Zha/goSvl
 QCUb+eKJaSfcz1hn+RaPhrOdMa4lGSrI4+bSHslq9frnDeVGCS62N6LiUqDOsQ5tYT2w9e
 TxmoNkbEQw6vw7CVTJgHtVIUZrLAuT8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-nr4K_BfCOrGUCYS6oip73g-1; Wed, 08 Jan 2025 16:22:09 -0500
X-MC-Unique: nr4K_BfCOrGUCYS6oip73g-1
X-Mimecast-MFC-AGG-ID: nr4K_BfCOrGUCYS6oip73g
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436248d1240so1202195e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736371328; x=1736976128;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Bfj03Z1hailZKFXRLUXKAdtZqhCy+9zpwuchbFoqM/Y=;
 b=BkOhfw8kJu2rtTwBAa6jKWIU/PxGhY9nAOa+vP8zCzgC5G0HzLggLxpXCHGUZjUb3I
 auOBTtI8oOTTv+7nDAVcRyzaTNiMZjilCD6pBCURGgzWV9PZ/gWywKMMPgPDjOplQwfb
 kkf8eFJf/MMqKgxpNFWtm40odSwKwbLu33mPJaU4RTHNjKNtiRDNLJ8f/hn2tjs2VrX3
 SKDA1seMcZZEoZr8umIyVU2pzZEqsx7fK2MBuC8fBzWhHWhWOGPDevT0x5+wakqTJI71
 P8gMFhwWH8QYvoCehi3c6pJzD4z7krVGc5E3+GNgJgdfcn7/mbqo0nN1nquIqNnFirAp
 +Yjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAOAcJnIzwTFz8FYweExWkZOxTe5OhwrXTrN5gqAwXOZc4giD/JsD4A4lZ+wwEf2am513AehnH6ZIU@nongnu.org
X-Gm-Message-State: AOJu0YwH/NCsbOxK2oFYq1ca/zmBkq1eAr+XKvMFwYviraHf5lyHqXO9
 sJL5OzkISR6oCyn53o3OTaxhtQqvm/N0oPOPs4pYfr1IgUbmjFE8dNpWpPwxVC5MZPcJx+Xw0E9
 UAgIDf0XrYbXhhQCWeaAVHG0V5BvFs44VtGn43xx1DgeTl49jWiWG
X-Gm-Gg: ASbGncujJb1ZYBm5zVUxps/lO3+AjVrF8HMPcpRLh/rJdughEXrV9/bX+DL2JmQ6439
 FWQYV0RzjvftJvkAoFs2N+VBmQKZ0jqIJ5tUMqvGlwTfhXzs2zrncAuOBaDWnDyogO5EDHkvNzc
 TB5Os9k+ekGSInFlZ9oCUiluqqOU+bl1VpOAK4xyIHiO44wDlNSFRJYsHsQRrQatlal/EKGiLuv
 z7s34pMUdVXu26dZ1iMK3Vnw1qK38nvvt2Vqx252ZB/2D2594WrHhMbCcVIHiBnjCNxplGj049/
 IEY53LHyxqBAbZ3rozxRkqSiqnrjIVBm5AgBNvkAjcr1MOe65O5ZgvRSWHwUftoGsCs7lkch7ZS
 vp2crfw==
X-Received: by 2002:a05:600c:4f95:b0:434:a1d3:a326 with SMTP id
 5b1f17b1804b1-436e2678213mr35028655e9.6.1736371328495; 
 Wed, 08 Jan 2025 13:22:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExWh9zYA05FKQUbHVuvm6/DNDgU3VRZGy31QFodIFIbAXgOWwcsJ5+GVAxWwXAoOZSsckkQw==
X-Received: by 2002:a05:600c:4f95:b0:434:a1d3:a326 with SMTP id
 5b1f17b1804b1-436e2678213mr35028465e9.6.1736371328150; 
 Wed, 08 Jan 2025 13:22:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7?
 (p200300cbc70d3a00d73c06a8ca9f1df7.dip0.t-ipconnect.de.
 [2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e99a6e04sm141615e9.10.2025.01.08.13.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 13:22:06 -0800 (PST)
Message-ID: <6d771c8c-1ebe-48aa-b74e-6195738a041a@redhat.com>
Date: Wed, 8 Jan 2025 22:22:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Poisoned memory recovery on reboot
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20241214134555.440097-1-william.roche@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241214134555.440097-1-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 14.12.24 14:45, “William Roche wrote:
> From: William Roche <willia.roche@oracle.com>
> 
> Hello David,

Hi!

Let me start reviewing today a bit (it's already late, and I'll continue 
tomorrow.

> 
> Here is an new version of our code and an updated description of the
> patch set:
> 
 >   ---> This set of patches fixes several problems with hardware 
memory errors
> impacting hugetlbfs memory backed VMs and the generic memory recovery
> on VM reset.
> When using hugetlbfs large pages, any large page location being impacted
> by an HW memory error results in poisoning the entire page, suddenly
> making a large chunk of the VM memory unusable.

I assume the problem that will remain is that a running VM will still 
lose that chunk (yet, we only indicate a single 4k page to the guest via 
an injected MCE :( ).

So the biggest point of this patch set is really the recovery on reboot.

And as I am writing this, I realize that the series subject correctly 
reflects that :)

-- 
Cheers,

David / dhildenb


