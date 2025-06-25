Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD02BC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 21:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUXMD-0006ni-MI; Wed, 25 Jun 2025 17:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUXMA-0006nM-TA
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 17:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUXM9-0004iJ-1K
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 17:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750885711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ga9EfVwEHYTNrrWORLPgzkQzM2DSnBtXRrggnr3bFtI=;
 b=QNM9zCPA+/SDA3dN8C5sQ4fXFcQX1lmUqYn4hmG5vMvVNBj8vGi8sEMkc2nm0KO+Ws6uld
 ATiW6/7fQL4crT7q8mwbSicn6I6WGHtc6CVl0v+h8ElV61Vl5GmWUYb63hxmnj93dpdpgf
 J211rZAExdffQ9BNFB2lwWUBspLl4Co=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-KOz9XnpgMSiIee3Tk9biqg-1; Wed, 25 Jun 2025 17:08:29 -0400
X-MC-Unique: KOz9XnpgMSiIee3Tk9biqg-1
X-Mimecast-MFC-AGG-ID: KOz9XnpgMSiIee3Tk9biqg_1750885708
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d5600a54so1698765e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 14:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750885708; x=1751490508;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ga9EfVwEHYTNrrWORLPgzkQzM2DSnBtXRrggnr3bFtI=;
 b=cc4USFVYpOs1e3OeXlDcPWHKp5/t1bqJ+UBBlE9Hnj+V3s3dWO3UM7cw7Nq0536GQB
 oWCICGYiiWohPgvrhlhdqyNF4KM8LGjxB5M8OMqPCih+9ElM/8mOudEmBLxzuQ1DTd4T
 wnkuGWl9NQpi/Q4BbfnCi7eRZRCjEZ4kMRzi1NR8jTDSnh3qD+G5wGlXYq3tVoeay8fJ
 38LsxzXSJ/f2Z3VOj4VgjogqwpyCsnch5+9FDtruEEfDnZqCQGaN3Z6071jtTU1twh+d
 A5vu7CaKr1mX+xAuXLdxwMSjiLwHjx2Vrkf0ReRaGKFFSnWPWyIKFDLqdhJPRKDm+DPs
 yLyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlxc+VburE4h7wL65g8PA/1Z6HJZkFcawgQ78ieAReMwrmqFoqCfWpXpw8vrmarSox340sJdju8aSh@nongnu.org
X-Gm-Message-State: AOJu0YxMcpW9OvwwN3AYqrYLV70poYAk56WMWaID8y7f9qkEsBJ38Mrl
 AiUJK2XjB7zw9iwl64ZDbje1Ygn0TSI6EdSV6u+NKKnyuBrVKwz+VmZRDzmxx94GxTasMTm0gNP
 ttfq5fN9fXHy/EJRwuNXFlf4OjOpqmaZSw6alLH3gdcgVAX1sJncqCDNP
X-Gm-Gg: ASbGncvUIAS3hk/DTdL2PXidgo3D6eVkcwsWbNjZFaRamy+mWjsDYGLfBoALGzPZbIg
 gKjcnJjqF5BEhPrxB1Z50MDPXmIV41kmCxw2OR5Kqbz+JIfe0dOyjhWEXPFy14B84/2QXJYstoY
 DY99Py2M+Go+HMwE88hSdSf2JsLKUkI+guYZAoJwTYE8xZMBm4uq8aux9rtTbqMAmmJUQX4b+7r
 btaR725g6KctMserdQmDCeKI0JEy2o+MEvA+Sx6nrePCRA1iTJvaGoe1Iyx++/m0D4MsqDMz1Xy
 3rW81WZrHIEQXb37yqe2L8EPpxZ0PhjMEnpcWhV0ZRIuioiv5LNDO3vLxkst
X-Received: by 2002:a05:600c:8714:b0:43c:efed:733e with SMTP id
 5b1f17b1804b1-45381af6270mr51644965e9.14.1750885708283; 
 Wed, 25 Jun 2025 14:08:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcpjPjwQXDCdcH04DQnRG98p4aoVheNSkYZDUDaP53oiqAQsZ3LLMH8Q4f+8NioCO/T7MjWA==
X-Received: by 2002:a05:600c:8714:b0:43c:efed:733e with SMTP id
 5b1f17b1804b1-45381af6270mr51644815e9.14.1750885707849; 
 Wed, 25 Jun 2025 14:08:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538234a1f1sm29479735e9.15.2025.06.25.14.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 14:08:27 -0700 (PDT)
Message-ID: <1e67c23c-6027-4fa2-bc9e-0bc9502265d2@redhat.com>
Date: Wed, 25 Jun 2025 23:08:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vfio/container: fails mdev hotplug if add migration
 blocker failed
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com
References: <20250623102235.94877-1-zhenzhong.duan@intel.com>
 <20250623102235.94877-3-zhenzhong.duan@intel.com>
 <afc6b039-4569-460f-a15e-ac000bd44d5f@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <afc6b039-4569-460f-a15e-ac000bd44d5f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 6/24/25 11:21, Cédric Le Goater wrote:
> On 6/23/25 12:22, Zhenzhong Duan wrote:
>> It's aggressive to abort a running QEMU process when hotplug a mdev
>> and it fails migration blocker adding.
>>
>> Fix by just failing mdev hotplug itself.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/vfio/container.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 2853f6f08b..68b4fdb401 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -992,12 +992,16 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>>       if (vbasedev->mdev) {
>>           error_setg(&vbasedev->cpr.mdev_blocker,
>>                      "CPR does not support vfio mdev %s", vbasedev->name);
>> -        migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, &error_fatal,
>> -                                  MIG_MODE_CPR_TRANSFER, -1);
>> +        if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, errp,
>> +                                      MIG_MODE_CPR_TRANSFER, -1)) {
> 
> migrate_add_blocker_modes() returns -errno. Testing with '< 0' would be
> better.
> 


Reviewed-by: Cédric Le Goater <clg@redhat.com>

I changed the test on the value returned by migrate_add_blocker_modes().


Thanks,

C.



> Thanks,
> 
> C.
> 
> 
> 
>> +            goto hiod_unref_exit;
>> +        }
>>       }
>>       return true;
>> +hiod_unref_exit:
>> +    object_unref(vbasedev->hiod);
>>   device_put_exit:
>>       vfio_device_put(vbasedev);
>>   group_put_exit:
> 


