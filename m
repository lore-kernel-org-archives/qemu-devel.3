Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461C7C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 18:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqG9k-0002rn-7I; Thu, 06 Mar 2025 13:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tqG9h-0002md-0d
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:41:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tqG9T-0006ZM-OY
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741286453;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlKjR6Qodze2phKQi0H9cwus77utvbmPa46ciFKpdjw=;
 b=CR0sCPLaWiZRdfpJ62TfxkSzMnGgZtIF8fIe47bh+yqw3eoEQRI2VRbCq1H+fmhPJ6y9N/
 pCFwI3KVGTox08dy6a5T1P+n6YfzMgkczsvEqIaY8R8NBDbHOz7uWUFQuFfnyBAlJZqRLI
 tujDBCiDI3u9Tn+ac2bjzsslmZ/ZabM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-z5DAz-UJNaSFc4kBmfGcbA-1; Thu, 06 Mar 2025 13:40:47 -0500
X-MC-Unique: z5DAz-UJNaSFc4kBmfGcbA-1
X-Mimecast-MFC-AGG-ID: z5DAz-UJNaSFc4kBmfGcbA_1741286446
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-390de58dc4eso1046961f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 10:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741286446; x=1741891246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nlKjR6Qodze2phKQi0H9cwus77utvbmPa46ciFKpdjw=;
 b=cB90H3MsGHiJbF0dGmPA/qGiPg0us5uM93SWExbBYInetrDhQPGUiXGP7K4vxX1vPV
 P8FQMyotos+jYDaxCovRcyQBXt17TYOr9sQ086hKVPfzcutth0FJOPIQMcxtrLpxr09c
 16Tj7P/Y40POj57jaGwzLT0mQzZi70n35ntveucJGhGbuQZxteBrOqn5W9LDoFM0aX2y
 Vpo21hLyMRW42koh54prT4o3TrDbipcOwGOHSJCUBeT9CE7h5Uda4qCiXnvp/cn4ccv4
 SttCUczlhc4PAmSN3oblRgM1iAswyjcJVWzII+z5UMYOt5UkQoFferRXfmpjnciz/znz
 P+gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvGlr7AAlIIcZCNnmR4yrdxzWPG4deORq/ex2jc1pKQ3Xa6jfGzDX/gHGEhVor7nzRCDAToVbPk8B6@nongnu.org
X-Gm-Message-State: AOJu0YwuE8RJFcNLBtQVqWDFfTn7nKeqgZ7m+emDSWdeLBAGxmqal4RP
 HFiPqf2BAlEd9dtrhqmxdh2Rk8c2xG5PPe5kk3ul5ONnIr5O4MoA0uecjvyVWQhMBZOExu7kAMI
 NElHg4l0QUmr2NvsnZYp/wKW7T8gR6RisMcBfat0hDhxHGOPQPNGb
X-Gm-Gg: ASbGncto//Glb6IP3CYZD/nHT9P47EtI8C3u3RBO5QLvhHYKmkiLzduIt8uDAyIocfg
 9gBq2R0fmQ/J3VwvV070TdiQgE9Q/I7VlgxsKeAtQfYfFvf3RKCu/AK9KuzSYfjDC4ElxwUoI9c
 sK6/COFSrcJjiQ5+HN0HLdog5lP1nP7feHCUmWLtUPLm/68flLcDRlp2DMNdBULBzjKyKCumfCX
 bSdvPjhxqQYRA9pydB8WWJ2VlPNQ2RO0NRQi9h7KN/zhgVz3qqcuQU0B+GHT/DIeUpi7eb1TG60
 xjlIfX1aCIzxj4B55jbplj/qchNV44QEGAabPE/UDWyxY8Yj/w1pNq1Kpr5CthA=
X-Received: by 2002:a05:6000:1548:b0:390:ee34:228b with SMTP id
 ffacd0b85a97d-39132d465b1mr261974f8f.24.1741286445878; 
 Thu, 06 Mar 2025 10:40:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt7itNn/gyOkBdiHICiTfgLjjl/YguChB/l1GnLjT+usq9T1ABX31pHCd8Y6b+o9BDBQ9Qjw==
X-Received: by 2002:a05:6000:1548:b0:390:ee34:228b with SMTP id
 ffacd0b85a97d-39132d465b1mr261949f8f.24.1741286445483; 
 Thu, 06 Mar 2025 10:40:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e1d67sm2805750f8f.74.2025.03.06.10.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 10:40:44 -0800 (PST)
Message-ID: <d4b7ebef-32f8-497c-9d55-306dd02edac3@redhat.com>
Date: Thu, 6 Mar 2025 19:40:42 +0100
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
 <2191c0b3-f3a4-4d90-9448-23c3bc876372@redhat.com>
 <e049b9f0e97d40b39e20ef3f330bbc94@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <e049b9f0e97d40b39e20ef3f330bbc94@huawei.com>
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

Hi Shameer,

On 3/6/25 7:27 PM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Thursday, March 6, 2025 6:00 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; Duan, Zhenzhong
>> <zhenzhong.duan@intel.com>; Nicolin Chen <nicolinc@nvidia.com>;
>> Donald Dutile <ddutile@redhat.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>; Jason Gunthorpe
>> <jgg@nvidia.com>; Daniel P. Berrangé <berrange@redhat.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org; Peng, Chao P
>> <chao.p.peng@intel.com>
>> Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
>> nested SMMUv3
>>
>> Hi Shammeer,
>>
> Hi Eric,
>
>>> I am currently working on refactoring the SMMUv3 accel series and the
>>> "Add HW accelerated nesting support for arm SMMUv3" series
>> so will you send "Add HW accelerated nesting support for arm SMMUv3" or
>> do you want me to do it? Thanks Eric
> Yes. I am on it. Hopefully I will be able to send out everything next week.
Sure. No pressure. I will continue reviewing Zhenzhong's series then.
Looking forward to seeing your respin.

Eric
>
> Thanks,
> Shameer


