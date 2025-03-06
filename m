Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A21C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDZT-0001xk-GN; Thu, 06 Mar 2025 10:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tqDXj-0007cz-EQ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:53:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tqDXg-0006uE-Hp
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741276424;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxQdVCmnI3Aqsh0ic0CdkLhW0EOUUimR6/7hs+syd1M=;
 b=IwtWl4vJ5D5P4kxXsRvk/UGVg22HEYcloV486J3Fi2DXLl1vumhHQ9UbOr8aMhbZtKXPXh
 GiJ7/GMhbfdyNojWdHqQzE3WctlFOGYD/tdsPdInOU3kl2kGVdDJk6yMNOqzROnv1E8VHQ
 m98xkPAWVnjXOx9q0wz3rGJIqBBYLpw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-ls7wGqcWNguPotixr1Uofg-1; Thu, 06 Mar 2025 10:53:42 -0500
X-MC-Unique: ls7wGqcWNguPotixr1Uofg-1
X-Mimecast-MFC-AGG-ID: ls7wGqcWNguPotixr1Uofg_1741276422
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43942e82719so5806095e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276422; x=1741881222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xxQdVCmnI3Aqsh0ic0CdkLhW0EOUUimR6/7hs+syd1M=;
 b=KutSmDTn3GyRFBXQh8X9l1ZqbpQQ1HfMud0j8JzE1nITA2yHIfsq6q1/1Roh7kWY2R
 +qLSMqn3bK5cgZW6gC+U0BOg7baPBDR+pHjuIRbmB7J9uxySnaCqzH/MvLGZe8YX+FqA
 ORvd8we3NHqRnI8n4GNlnf5JvvIHLmUQPiHz0uurdUbkh3bVsNvcwctVQsP6MB6NnVqe
 6BgVlizn3P+2o99Qsdg1+7FEn08+C0QwljpBlE9u8koS8EAfRAMzh5dfxX5CqVdUAVf+
 qS86vKXAno0eODGLfpxPL/5psHJfxBicq0eWlWdYrkfIWhuM18xT7riXHPFQTI9ORpeE
 Hy6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN89c2ouqQs5WtsrFLaLJEhaXaFnOOxxZseNnlGtXb2hRWG0BdsQAM/rkPHyW3l2Guf4vAVT/T0G/S@nongnu.org
X-Gm-Message-State: AOJu0YwiwdJEruS2ircklWEcRUa79NVqXup8OIy4taBin5zoPj4M6Cul
 mPsVZNv0On3XpyNtaEiI5SBxT3sl9dIFdmKs/Wz9q4Ig+ySDN9haNjbjDxDqL20kM7e7LzG7ar5
 2TuD7AiTxyHDf5SlPwsQnm2pMelyVqWgRapSQ1Se9aSftJo3B5nX3
X-Gm-Gg: ASbGnct9lQ6k8upekbD175JRLDquks7r4X5GixZTkVQuQ2shmGg44C+0t1fn5dXKT2N
 my2mUI9dF/Uc4FeyLW6qXag4u/plmqqTEOp2Z9PoO7NE+rjETj4Po/G1OlYb5bzedfdXQlNTXg8
 KuB4SdxX55ptgsrblx1J32Jv3+MzLYqBXqK/n7a6Q0vAv775Df1hHuroC+DyH8DnC9xr4jWg8xk
 x+cx8YtzW2qmFO3RS4PpEyNdwTTBe4lanR3QPCxKQNxbmfjyskXrdV+Hc9th50esW/aByMTeje+
 SSRZrLgi6HiMCliTtqSlTS74V30kJU52UEkBLz6WFD6dhBOgrRcX8+EORYwlKV4=
X-Received: by 2002:a05:6000:1ac9:b0:390:f4f9:8396 with SMTP id
 ffacd0b85a97d-3911f746e95mr6723725f8f.28.1741276421795; 
 Thu, 06 Mar 2025 07:53:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB3ybbOubmeHxtfmX0OjLXsF7gR3/V0JMnCi4n3v0TXXFDru69LyuLCM2pnIlTmZCVzfVrSw==
X-Received: by 2002:a05:6000:1ac9:b0:390:f4f9:8396 with SMTP id
 ffacd0b85a97d-3911f746e95mr6723707f8f.28.1741276421417; 
 Thu, 06 Mar 2025 07:53:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f39sm2385652f8f.80.2025.03.06.07.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 07:53:40 -0800 (PST)
Message-ID: <37a28de6-dd57-4501-adc1-3e2484e2081d@redhat.com>
Date: Thu, 6 Mar 2025 16:53:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 03/20] HostIOMMUDevice: Introduce realize_late
 callback
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-4-zhenzhong.duan@intel.com>
 <5322a196-017e-46c1-98d9-bf2f30d148e9@redhat.com>
 <SJ0PR11MB6744096111D47692257CD1B392CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744096111D47692257CD1B392CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Zhenzhong,

On 2/28/25 9:16 AM, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH rfcv2 03/20] HostIOMMUDevice: Introduce realize_late
>> callback
>>
>>
>>
>>
>> On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>>> Currently we have realize() callback which is called before attachment.
>>> But there are still some elements e.g., hwpt_id is not ready before
>>> attachment. So we need a realize_late() callback to further initialize
>>> them.
> >from the description it is not obvious why the realize() could not have
>> been called after the attach. Could you remind the reader what is the
>> reason?
> Sure, will rephrase as below:
>
> " HostIOMMUDevice provides some elements to vIOMMU, but there are some which
> are ready after attachment, e.g., hwpt_id.
>
> Before create and attach to a new hwpt with IOMMU dirty tracking capability,
> we have to call realize() to get if hardware IOMMU supports dirty tracking
> capability.
>
> So moving realize() after attach() will not work here, we need a new callback
> realize_late() to further initialize those elements.
>
> Currently, this callback is only useful for iommufd backend. For legacy
> backend nothing needs to be initialized after attachment. "

OK this helps me

Thanks

Eric
>
> Thanks
> Zhenzhong
>


