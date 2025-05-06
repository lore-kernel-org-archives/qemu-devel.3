Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F272C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 07:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCCIW-0007Jr-4Z; Tue, 06 May 2025 03:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uCCIT-0007JO-AY
 for qemu-devel@nongnu.org; Tue, 06 May 2025 03:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uCCIR-000291-Fz
 for qemu-devel@nongnu.org; Tue, 06 May 2025 03:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746514854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tpKzTWgP8+hspjgJI+1eIVSJGlvEJ452Vvbd8N2ejA0=;
 b=PRi5OoaWVXWwjjYgwsfciLpYTwcy8zjUnFLtJpjSBZIhZpnMEIczt5QkJ6DgwCEAkR2DOV
 dSmt1J5sWqadRXN9k7ecrNWNsbdWSZiXD5hE6sJaVuqHt7gs5VynNg6n8iiCCzhhk38S1S
 MBKEq9sq/bGswVOpUmJNk3v4s4ASNi4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-aRrBZMu0Nq-Ee7JoxMKDFQ-1; Tue, 06 May 2025 03:00:53 -0400
X-MC-Unique: aRrBZMu0Nq-Ee7JoxMKDFQ-1
X-Mimecast-MFC-AGG-ID: aRrBZMu0Nq-Ee7JoxMKDFQ_1746514852
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d6c65dc52so37118135e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 00:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746514852; x=1747119652;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tpKzTWgP8+hspjgJI+1eIVSJGlvEJ452Vvbd8N2ejA0=;
 b=EbVDtoQhJMBs0sPtDLUUtcoo6o4paVMjeWu1Er0sKW93ZnvE+b24hwhIlOnqSQ4r76
 q76F95HmYKjPtkA9luSRnmqBDiDIUmDxC+rU+FZ1PDX73v3mLqIyVuphIJtJ7mDYoB/r
 Hd+1emzXAkVapk26l8ndOkH7VBUt6mLhDjza389t9S9UO9siokFS7qNtqF3gIaBRNGQz
 W6358hYp0dY2g2v28YZXAj2FEe/45n2FISzQo3DfrXnrisjfd1zDIOBXlYUg4v2FUALg
 Q4iDSpDWJvSTw6iPmATqt9acsjByRmv6HToZnPaNf1/V4yXccRmLSGteLVOtqqjJghd/
 FtJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRIIwaN/UHmR+CVOJSQMBsa9YVAlXz85RpsjcUIiC05yCv8vOgdLIdSBNa0ULXcJD0C35KC/xUMquC@nongnu.org
X-Gm-Message-State: AOJu0YxtSqLi+qQ1wl64Wc+MnpWNyAH2zhl2laqC+dIOpcILb2USP5Yj
 F7G0T5Y6MRo2egeuZtCIPlRYtW4AhMVO+q2nd+z/Lpl/WuEHWYjFvH6IFAcROFbQaAHdftNAi54
 Ef7dABqmeC0WUQhhqFWOtMRhDQsh4vdx7Uet+OUDm1xCjtymbF8rG
X-Gm-Gg: ASbGnctGVX+3Ko4V1BX6X0ZGrPPunc3HPbjshAzKy287XA2kM4k99hK+Yj0j/Fv2GXi
 EHlHbMbQfZbmeUhrYUUH2L7BZeI9jw773ESbTqNqvn3qNVFHri40Hs6hoMhb7jG0PMGsLFhtNlR
 HSUCXNe8GU8Xi16wvaO/IXqmZIoOIeKQTJBsG9eHJmlDMgXL60Tl2RjZvtrc3xF2zA2348ia3Vk
 sMXCiMWSGPOX4dH4/B2ptHoJULT/HWQujohs3jjgQzPemizyhoI/kDlx1LFD/nmJRscwXGB+iYz
 Bk5atvkVE0vEWM6i7RIdFD5qIbG0Uer8FnBGkX/NMQjgdk7irA==
X-Received: by 2002:a05:600c:1e85:b0:43c:ed61:2c26 with SMTP id
 5b1f17b1804b1-441d0fd2c76mr14832195e9.17.1746514851896; 
 Tue, 06 May 2025 00:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjxO7mle5uJ5RR6tDlZKpW3W+w4SCgjZPiTIbP/syG211WX72BPMLgHxgZ2AulXKOkXaQpcg==
X-Received: by 2002:a05:600c:1e85:b0:43c:ed61:2c26 with SMTP id
 5b1f17b1804b1-441d0fd2c76mr14831815e9.17.1746514851514; 
 Tue, 06 May 2025 00:00:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b20c3fsm205468385e9.28.2025.05.06.00.00.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 00:00:50 -0700 (PDT)
Message-ID: <172a4e60-8c3e-4c02-98b2-2f4a1fcfae17@redhat.com>
Date: Tue, 6 May 2025 09:00:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] Report vfio-ap configuration changes
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250425052401.8287-1-rreyes@linux.ibm.com>
 <e35561c9-f104-4be0-8bf4-cae726118028@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e35561c9-f104-4be0-8bf4-cae726118028@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On 4/28/25 23:29, Cédric Le Goater wrote:
> On 4/25/25 07:23, Rorie Reyes wrote:
>> Changelog:
>> v7:
>> - Dropped initial commit for linux-header file vfio.h since I created two new commits
>> to address the changes made in v6
>> - Moved patches 6 and 7 to the beginning of the series after dropping the first patch
>>     - Because I dropped the initial commit for linux-header file vfio.h, I had to add
>> VFIO_AP_CFG_CHG_IRQ_INDEX
>> - Resyncing latest to v6.15-rc3
>> - Still need Thomas Huth's review of v5 changes for patch 6/6
> 
> I checked the build without default devices.
> 
> Applied to vfio-next.

I kept patch 1,2 in vfio-next and dropped 3-6 because of the build break.

C.


