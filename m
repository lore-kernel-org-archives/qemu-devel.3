Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EB6C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 18:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFW6-0002JK-5h; Thu, 06 Mar 2025 13:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tqFW1-0002Ev-OB
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:00:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tqFVy-00081Z-0X
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741284005;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2nIPruIQ08U8Iyvv5h184/O0l7dO44/GMt0kItqu+2A=;
 b=XfErerd0RCx8L3OIQaFbZzvl+a1Emjh9JXKFOpoXqpeslj072WGMxd3E8JkF4zE6b1ER08
 lY1AfdsXadVPR4YvyT3cACrubUxBCascI131piDgxJwzkfh1c4jzAe6cEV74N3CUann/UI
 Nrf9PFYlEou+e+npqHRVs7KtLWm+5jM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-BpgNBt7qO7esyg68HHXQ7A-1; Thu, 06 Mar 2025 13:00:00 -0500
X-MC-Unique: BpgNBt7qO7esyg68HHXQ7A-1
X-Mimecast-MFC-AGG-ID: BpgNBt7qO7esyg68HHXQ7A_1741283999
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so6464705e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 10:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741283999; x=1741888799;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2nIPruIQ08U8Iyvv5h184/O0l7dO44/GMt0kItqu+2A=;
 b=QVU73yOxst+4jki3/e3FVpx/GmWjdUko2bYH57Gl2qELvKpYgjOGN26Au4E48Sa+ON
 liKU/cHu/0CPTPw4FQB3HNpq07lGWq/eAUMq7f3KnD5GSXmNHrDswbIXy0oMFvoJxpya
 c/NRZBmM3Tnz+j2i+k2/tMuddVFOvdv8cNA3eE1aMvUzBmQBN22DsHAtn82551qR1phB
 21MEXEYx3faeh636eS6sHMdh5FCfHBuhb5K5nU7KNNoXSsz5B6+UgDxEmwaLLUZrlWK3
 x/A8cONg+a5515lWjtMYKSPClsUnNUKD4qakt+wtfPZV6oxmn2A16cobRFSzcsYJirWi
 M5RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWamCbb7cLgCkaprm8fykwOp2UU46F7cka4cKqpsTI4UGG8qQYRJgdPCiyFet3F70qeQq/T5idW/iN9@nongnu.org
X-Gm-Message-State: AOJu0Yxg5XsSstuX4unm+Lmox++nDb+vo89LajKpxl5OZFizApLZ52sh
 9ywzkcYRRGpDmWcOeMTfCVW3ba1oX5b9vaJd/q7OBZ2LlRXkJ9cSseX4FdbpB01dfUMp5Zd3yxr
 uOlTOGbG1R5nfMGlXa0QwZuDNbXyGSiJoy9rm+giDpG/kS8dm/KJp
X-Gm-Gg: ASbGncuiqeIYiAuhIXENUEo2mQqB054gVzGNzrKOZW8CrRiUNhpKuVR0h1zrh0PuVSJ
 65lULxHGlltpHZKdXa7B6STVB2tmWCodC8LnnamL/vqG4HNOSrdaFOFP/Qyf/N1vcNG09C0yMb5
 vV7ovMfYrYujaNumU/EMVPctQx/058i0e4qxKBDvT/PHYcQJcRsocO2Wm8Yn5yQjHpgQJwviDdq
 z6IwvUz7MGkNKYdz73w9ZvCOAqRnFBm5tvU8dMza3HHq5i9yTcFyPNsByiD/0/UqN+UAlcDqESB
 Jy/Wm6CMSsjVAegpMAISngPDXFo7GSud+omdEHzRdTGPi8XC92SssqsT/GzSVw0=
X-Received: by 2002:a05:600c:45d1:b0:439:6118:c188 with SMTP id
 5b1f17b1804b1-43c5a62a276mr3597135e9.19.1741283999275; 
 Thu, 06 Mar 2025 09:59:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRTVwuEDWIpoljkTS/M8J/cM8c+rzmTj8Fu8wqKHTHPhxF0ADiDkD8VaDrZ06NHboxSl7wmA==
X-Received: by 2002:a05:600c:45d1:b0:439:6118:c188 with SMTP id
 5b1f17b1804b1-43c5a62a276mr3596955e9.19.1741283998878; 
 Thu, 06 Mar 2025 09:59:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01ebddsm2814820f8f.60.2025.03.06.09.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 09:59:57 -0800 (PST)
Message-ID: <2191c0b3-f3a4-4d90-9448-23c3bc876372@redhat.com>
Date: Thu, 6 Mar 2025 18:59:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Donald Dutile <ddutile@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <568014f5-25fd-439b-b70c-9cf50f31255b@redhat.com>
 <Z5HBJOgO4tUJApY+@nvidia.com> <8fe09b60e6f04cc6aec99b72b46b2fb3@huawei.com>
 <SJ0PR11MB6744943702EB5798EC9B3B9992E02@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB6744B3D96A98584525B0401292FB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c975f6dfaa9243c5a2db9e37d592ea51@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <c975f6dfaa9243c5a2db9e37d592ea51@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Shammeer,


On 2/18/25 7:52 AM, Shameerali Kolothum Thodi wrote:
> Hi Zhenzhong,
>
>> -----Original Message-----
>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Sent: Monday, February 17, 2025 9:17 AM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; Nicolin Chen
>> <nicolinc@nvidia.com>; Donald Dutile <ddutile@redhat.com>
>> Cc: eric.auger@redhat.com; Peter Maydell <peter.maydell@linaro.org>;
>> Jason Gunthorpe <jgg@nvidia.com>; Daniel P. Berrangé
>> <berrange@redhat.com>; qemu-arm@nongnu.org; qemu-
>> devel@nongnu.org; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
>> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org; Peng, Chao P <chao.p.peng@intel.com>
>> Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
>> nested SMMUv3
>>
>> Hi Shameer, Nicolin,
>>
> [...]
>
>>>> Hi Zhenzhong,
>>>>
>>>> Just wondering what your plans are for the above patches.  If it make
>> sense and
>>>> you
>>>> are fine with it, I think it is a good idea one of us can pick up those from
>> that
>>>> series
>>>> and sent out separately so that it can get some review and take it
>> forward.
>>> Emulated series is merged, I plan to send Intel pass-through series after
>>> Chinese festival vacation, but at least half a month later. So feel free to
>>> pick those patches you need and send for comments.
>> I plan to send vtd nesting series out this week and want to ask about status
>> of "1) HWPT uAPI patches in backends/iommufd.c" series.
>>
>> If you had sent it out, I will do a rebase and bypass them to avoid duplicate
>> review effort in community. Or I can send them in vtd nesting series if you
>> not yet.
> No. It is not send out yet. Please include it in your vtd nesting series. Thanks.
>
> I am currently working on refactoring the SMMUv3 accel series and the
> "Add HW accelerated nesting support for arm SMMUv3" series
so will you send "Add HW accelerated nesting support for arm SMMUv3" or
do you want me to do it? Thanks Eric
> from Nicolin.
>
> Thanks,
> Shameer.
>
>


