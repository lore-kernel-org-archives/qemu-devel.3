Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A38C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 08:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDIyY-00071c-UT; Fri, 09 May 2025 04:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uDIyR-00071I-QI
 for qemu-devel@nongnu.org; Fri, 09 May 2025 04:20:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uDIyO-00030x-VR
 for qemu-devel@nongnu.org; Fri, 09 May 2025 04:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746778847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HWS8+mZdzL4jlk/OZD2nUTjtbWJ4mc2U2ewq3SV89ns=;
 b=cJFFCymXhYxHrWdP3ShNHK8dDb3uG+dmdXLpsqeKPBEbsIdYqPtu/j8/A3TLmQTwdPsmDE
 hqU+7/KJuhUdtkleayzTEnPCBscuLR10IzN6hsAsOXmwfvOtGFk6FYtzTyG3Q8k7b2S7t0
 nxLjeCKy3fFvrMitz5JPcdqqu5koOVk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-7_xg5NwcNRiCK7HCPUY_Cw-1; Fri, 09 May 2025 04:20:46 -0400
X-MC-Unique: 7_xg5NwcNRiCK7HCPUY_Cw-1
X-Mimecast-MFC-AGG-ID: 7_xg5NwcNRiCK7HCPUY_Cw_1746778845
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso9490235e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 01:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746778845; x=1747383645;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HWS8+mZdzL4jlk/OZD2nUTjtbWJ4mc2U2ewq3SV89ns=;
 b=XtrcBh414dT98V8U06/nmvM067gPD3n6t6mvDKka1VtxPkfEv7MhL0mMHWRPmU1/xf
 yVTu+KnhPWdKVjms8ZCk2LBYHe12hjk60LNNTrSIWcAIlawCF/hdQLgDPlWCNTL3qgtr
 6YEFybEabnDAzZe1agTH1TcSnnlVDcfIlh4Jho50qgtNpXQC0RuUwRCtAcEq5Xhkstkv
 loNZvk2yzDTS8Zv6x5MTph7b5M42UOAUTFu/6KVykZkUGlyMYTIsrHy2ARbdKr6IWR7Y
 OFmR2ZldNWtJ2Qe5j6dxyVFK5iCYkLeNOdAc3IhFqjYFmsgnb4nXA54UZT9gnV07ChLg
 HCLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVILnIYOe5UMSrWJ6wvKKEisGZ2LzT4eHdAYGPNqesmSsmvQOqxXD/n9QpDzsgbzmvIDmrdgZwI5RiT@nongnu.org
X-Gm-Message-State: AOJu0YxF6rcPyrkjPTC7K8jX0q1AuLnNSBjSaT3sihmiOQhyyRhaJ8BE
 LYqmGzhyUDdnbAho5c83eqMDzEK3jouPKwJrFZM1fgF5clK7YOW8umdP18k8e/APFRySsSyvbrj
 kO7+ESQHb0upovuAp2hfveyhv0uRPeuUtT2YtPUBjYPPDIW5t89Nm
X-Gm-Gg: ASbGnctgmbxOrZdxOTRApH8iYZUFy2kbOJswPAPLIyYaOatmA0hFGDlGUxSsncBrOPU
 r+qgenRCvkRFy3BXlnnfrYsnuOBIuiDF7RWYtqabAbcvyGq2A/GwKZo+xgaHf9u7SiDKb63mTes
 oeww84gWrH6OimwnhODNYnpVHnD5yd7Hjh2L6SZvt2oIWkkI2yVSnS7x9jlfxP5DhGEJsLY9h25
 F565FnkhS49oeek9AJo0H/O4KUOJdJkPkFV74IhPgJcxR+oOS7X09YE//bAb15WPb8tQ/XvY+rU
 8Iiraurcinv4fXpxHTlKhIw9s6EWOrq/Rf40+n93JUOKf83a0ReyhkfE2bV1wi7bvrZZGuKcv3O
 Or8Gh+vAzR97fq/+17iK5u6xVJeN+VrZSHKUYHww=
X-Received: by 2002:a05:600c:8208:b0:43c:eec7:eabb with SMTP id
 5b1f17b1804b1-442d6d3e163mr19216625e9.8.1746778844820; 
 Fri, 09 May 2025 01:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2e9pCUasla3fGuPSa5UWW5g1pyHN0N3zjoZK55joCOri0I1sx1WIaAdFDQ1xcuyTS3CCdGQ==
X-Received: by 2002:a05:600c:8208:b0:43c:eec7:eabb with SMTP id
 5b1f17b1804b1-442d6d3e163mr19216475e9.8.1746778844486; 
 Fri, 09 May 2025 01:20:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:5500:8267:647f:4209:dedd?
 (p200300d82f4555008267647f4209dedd.dip0.t-ipconnect.de.
 [2003:d8:2f45:5500:8267:647f:4209:dedd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2cf0esm2488518f8f.79.2025.05.09.01.20.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 01:20:44 -0700 (PDT)
Message-ID: <79730f95-6684-42fa-a6a4-630e3e346174@redhat.com>
Date: Fri, 9 May 2025 10:20:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/13] memory: Change NotifyStateClear() definition to
 return the result
To: Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-11-chenyi.qiang@intel.com>
 <c7ee2562-5f66-44ed-b31f-db06916d3d7b@intel.com> <aB1qqUGEayKbkL+2@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aB1qqUGEayKbkL+2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 09.05.25 04:38, Chao Gao wrote:
> On Sun, Apr 27, 2025 at 10:26:52AM +0800, Chenyi Qiang wrote:
>> Hi David,
>>
>> Any thought on patch 10-12, which is to move the change attribute into a
>> priority listener. A problem is how to handle the error handling of
>> private_to_shared failure. Previously, we thought it would never be able
>> to fail, but right now, it is possible in corner cases (e.g. -ENOMEM) in
>> set_attribute_private(). At present, I simply raise an assert instead of
>> adding any rollback work (see patch 11).
> 
> I took a look at patches 10-12, and here are my thoughts:
> 
> Moving the change attribute into a priority listener seems sensible. It can
> ensure the correct order between setting memory attributes and VFIO's DMA
> map/unmap operations, and it can also simplify rollbacks. Since
> MemoryListener already uses a priority-based list, it should be a good fit
> for page conversion listeners.
> 
> Regarding error handling, -ENOMEM won't occur during page conversion
> because the attribute xarray on the KVM side is populated earlier when QEMU
> calls kvm_set_phys_mem() -> kvm_set_memory_attributes_private(). 

I'll note that, with guest_memfd supporting in-place conversion in the 
future, this conversion path will likely change, and we might more 
likely in getting more errors on some conversion paths. (e.g., shared -> 
private could fail).

But I agree, we should keep complex error handling out of the picture 
for now if not required.

-- 
Cheers,

David / dhildenb


