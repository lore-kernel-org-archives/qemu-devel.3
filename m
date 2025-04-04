Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8767BC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0gUY-00052r-HC; Fri, 04 Apr 2025 08:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0gUW-00052J-D1
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0gUU-0001kj-FF
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743770985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sVP9pI31859A6fgG2Q/nG68EM72h0IC7+i60Ncl9Dl4=;
 b=DKDvc8q3295DtKSk72qGpwapndHnOF+xHzh8s4YHUgvKwGdKU3gAk75uxXYzYdDxTQvOru
 uRG6+qLXk4tZHTuB4BbOsZFLa7I891HoIVIYEz0+M+SAIhJWZ+6ncio2u4ift67CBmH4jK
 NCS5CAxXlW9tpYf5jW+strWai6w1RLk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-wor5K1FWM5eIHZl8L5HVQw-1; Fri, 04 Apr 2025 08:49:43 -0400
X-MC-Unique: wor5K1FWM5eIHZl8L5HVQw-1
X-Mimecast-MFC-AGG-ID: wor5K1FWM5eIHZl8L5HVQw_1743770982
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43e9a3d2977so14737065e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 05:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743770982; x=1744375782;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVP9pI31859A6fgG2Q/nG68EM72h0IC7+i60Ncl9Dl4=;
 b=TA9Ee8LhL1YHpVY+TW0H4gFHKfdTZ571jZ/7w7MtaRr6SpmZycZWDcsvj4rlFJE79z
 TGW6w3ADclFD0FemdN6qWm8xpbwSNGTr8nuux9sAwvSGU4NAc6ImHZ+6LmQHk5TAi0JZ
 k/pfgbclKJHXUI6rgkOxK73Jgpl2rmLZM9y6Dk3KqdjMbtUgcdhCvQaUtMkQxjgyVBmG
 dFT+zgSE/MipdP527gAY1NLQkbZknnSHECclPKwCbvBuzkTRPe4qGpoJj5R802djzo+L
 EVM3RmaFgbQkMvwZo+noFrWH+8Quqq7ppTlmU2eVupEe2f/CykTLrvMtAWr31dxBCs+2
 ap7A==
X-Gm-Message-State: AOJu0Yy2Z6sUBdwFBg6TTCgS/RegClSntc60I59bP4IbVNlbjaKB5hjV
 Y4zyDiVpBPTdZmrp4ZC8WrOSz3X1jEuLzXypZ2kdsjpxlySmHjCtWculZ/vgA+n5Wx1T82cZsVw
 2gi1nOrRtKU+sT2HusGl+lOffihq3pIfj9dZ2erYdjOtao+dDnmK3
X-Gm-Gg: ASbGnctkKPJS/AqJ7fHO2fUvisvN6Mg0gXuKOFv63MG3maMeurqdpzvyncEdidvVsU+
 DV//vGn5EeWaY/puG4NxivpGOB9n1bUVmt0ZjKeoolOILi5EnNS/WAqcBA7QN4GnoXKXkBHHYgA
 mFcOvnWx2pf9JRFrtD4/kPmbgMzACZn6ObZY9KHT0pnsTVdYrM/B82M/wA5NS6+ZNCxEBlgtq26
 r8dNwSA/foTzLKykg+eh0GR4KBUKkd/Ivh9PtF49DSnDWpaHPVeqvzn9262KgkUIo9b4RLUInfe
 PHyvJG+YgIcrkaEr1P07/gZ6NnebJgVVxyv8Aw3FWzAd/jtmbop9iA==
X-Received: by 2002:a05:600c:b90:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-43ed0b76672mr26446895e9.7.1743770982504; 
 Fri, 04 Apr 2025 05:49:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7hbm+mk69Kx6nuSdUcYy8JhSoZLo4nUm2iCssfe6k4vGDBuBdttBPGi2hrjqbM7Pnq6RBAA==
X-Received: by 2002:a05:600c:b90:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-43ed0b76672mr26446565e9.7.1743770982151; 
 Fri, 04 Apr 2025 05:49:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b3572sm48493735e9.39.2025.04.04.05.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 05:49:41 -0700 (PDT)
Message-ID: <137a1646-0bb2-4d79-bb6d-272167140bd3@redhat.com>
Date: Fri, 4 Apr 2025 14:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/28] vfio: split out VFIOKernelPCIDevice
To: John Levon <levon@movementarian.org>
Cc: qemu-devel@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-10-john.levon@nutanix.com>
 <52ecc629-4138-4436-bc38-b5f427dd3d7f@redhat.com>
 <Z+7Oif+ZTFRYBqXa@movementarian.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z+7Oif+ZTFRYBqXa@movementarian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
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

On 4/3/25 20:08, John Levon wrote:
> On Thu, Apr 03, 2025 at 07:13:30PM +0200, Cédric Le Goater wrote:
> 
>> On 2/19/25 15:48, John Levon wrote:
>>> From: Jagannathan Raman <jag.raman@oracle.com>
>>>
>>> Split out code specific to the kernel-side vfio implementation from the
>>> VFIOPCIDevice class into a VFIOKernelPCIDevice. The forthcoming
>>> VFIOUserPCIDevice will share the base VFIOPCIDevice class.
>>
>> The new VFIOKernelPCIDevice struct is not needed. Please drop it.
> 
> I presume the idea was if something was ever needed in the struct that was
> kernel vfio specific, it could go there. But sure.
> >> I am not sure the new TYPE_VFIO_PCI_BASE class is needed too.
>> Are the properties the only difference ?
> 
> I'm not sure if you're talking about the type specifically (a bit sketchy on how
> qemu's klass/type system works) or the existence of the base/kernel/user
> separation at all.

I am talking about the base/kernel/user separation.

> If it's possible to set up vfio_user_pci_dev_info and its callbacks without
> needing a sub-type then maybe not? 

I think the vfio-user-device could inherit directly from vfio-pci
and override the io ops callbacks. It would minimize the changes.

> Honestly I'm not really sure why we have sub-classes and inheritance like this.

The VFIO Devices have a double nature : VFIO and a bus device
nature (PCI, AP, etc) and multi-inheritance is not (well)
supported by QOM. We have interfaces but they are stateless.


Thanks,

C.


