Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7637EF8FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpEh-0000TA-Gj; Wed, 04 Mar 2026 11:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxpEb-0000SW-EW
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:38:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxpEZ-0007t1-KQ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772642281;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8brnyqqtWbtIOxiPRqwBOxDFBXvm2/fcZcwh2WUTBqY=;
 b=hwr3OSS06C1waaFmNPFnF34PhwlHj7NFIPSUSY6WENydhxscuR+P25p0v/kzUWrlbmlmkA
 nb7kNlNvww5JoZ3qmnJnQMUdrsLjP+5IxxsLhS8FHLwn6z2lFNAB+VvRFHUQSnusbFUNjS
 wDZq4a06g9h/2+e1Mn/7y12T92GRs3M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-EQ36vWcQO26B8jixJRAyCA-1; Wed, 04 Mar 2026 11:38:00 -0500
X-MC-Unique: EQ36vWcQO26B8jixJRAyCA-1
X-Mimecast-MFC-AGG-ID: EQ36vWcQO26B8jixJRAyCA_1772642279
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837b9913c9so53498015e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772642279; x=1773247079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8brnyqqtWbtIOxiPRqwBOxDFBXvm2/fcZcwh2WUTBqY=;
 b=F0plsn5fCCMhemqwyRGq6QRGEMrtgEaErMQZJnvDrDxErEscMbFmbMq4wXHl4+xonB
 Xwj/9Cq2PaUNJNxwHj5Mxl0bjj68wSfk0zp+OQttUtrI828Dpkdqzzeb82Da4wq24CJZ
 Ci6ZKeAXkalGs/T5ywhcgM4StSFmVti42KNkbHYvwgKtSrpmmcG+ta3ojOZ3hck5aX15
 vGFLM3T8i5gDGhvoQNY+abt49adFwQKE3GI8lujb/qBTe4zVug/UPhM/puTx7TJRKD3J
 jtvUl8a1+l/BM6Q2mrGnyKOf9JNppQKRbWTNYY2nvWvztGjpo5JcRgRfqU+C3aJmWKbL
 484w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzcC6HhXxdaBa4pKEnUqfY1Ao/LcGGzUcgUlpfSctRY637SlfOoo7jK/IHTcCgybk3K9RunVBCpm/I@nongnu.org
X-Gm-Message-State: AOJu0YwtOsvxZQLGAcPfop1PHA7eLFcX+uSBDSxoVgnM5Nfg2rHIVq99
 jTOpm+LtxsEKI2p2KSWyRnBzANdgo5lVRg9/s9YhL0TONK/qyFtMjdbz4KxNKfCrKv/sRaCtrVA
 EytZNVaZdnB1QQyVGpmVAojq3xlKYWZo+etFW9shjsGLJrph7snBagsYA
X-Gm-Gg: ATEYQzwOS/SpNOcFabMfHfYYgecN9QM1kxvi/zh228HxsUeJlNc8A33epwN4X02loOY
 uPdmwEjDUVsx83y3XV2m/wMC8xjAwm25JK2Rbazwe//EwyPg1c6woH9KGZqXG/rX2sa5w3+W60H
 cdSCgGVbWUfHqBBdMcsPGUawoC7lX7qYQxA0+ccDhH/2F6LiHaBVOfyUO/LSLzCXscQY4QAGv8w
 2zwsKEOslrSsjICwsX4VU9xZe6Nyt+wdEMUCUbQGdEe+fR2TninY5kAVcRzQ2FCNNjDI34Yp5gv
 iD249irLOJSl27mXdD8WcbcnAy9sORRYVkkZC+hv3IerVqupbxeEQMLZYY24UciDQ0qNMtsX5im
 4Wz6KXp7nWBIFd3hGwsjviKpbjw9uSYEawXEjQFvQEUIMOsJOfRli0iV+rE2O1Q8kYMQ6Ag==
X-Received: by 2002:a05:600c:4e8a:b0:47e:e9c9:23bc with SMTP id
 5b1f17b1804b1-4851989fb4cmr39239625e9.30.1772642278718; 
 Wed, 04 Mar 2026 08:37:58 -0800 (PST)
X-Received: by 2002:a05:600c:4e8a:b0:47e:e9c9:23bc with SMTP id
 5b1f17b1804b1-4851989fb4cmr39238895e9.30.1772642278199; 
 Wed, 04 Mar 2026 08:37:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851acfbd1bsm20826565e9.6.2026.03.04.08.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 08:37:57 -0800 (PST)
Message-ID: <b3257dcf-4a15-45e6-8d2c-c98ed13cde96@redhat.com>
Date: Wed, 4 Mar 2026 17:37:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify OAS
 bits
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Pavel Hrdina <phrdina@redhat.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-32-skolothumtho@nvidia.com>
 <d9192ae6-a94f-479a-b19f-734cc52a6be0@redhat.com>
 <CH3PR12MB754867E986856DC7718D4051AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202151917.GO2223369@nvidia.com>
 <CH3PR12MB754835BE4A5C54387122504AAB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202160000.GR2223369@nvidia.com>
 <CH3PR12MB7548DFE7F7CE555A3B3BF947AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CH3PR12MB7548515EDA96BD03F64DCAA2AB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <41aaf959-b417-469e-89aa-41c20a4b906c@redhat.com>
 <IA0PR12MB755548A48375D1856ADE89F5AB7CA@IA0PR12MB7555.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA0PR12MB755548A48375D1856ADE89F5AB7CA@IA0PR12MB7555.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On 3/4/26 9:26 AM, Shameer Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 04 March 2026 07:47
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; Pavel Hrdina <phrdina@redhat.com>
>> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
>> peter.maydell@linaro.org; Nicolin Chen <nicolinc@nvidia.com>;
>> ddutile@redhat.com; berrange@redhat.com; clg@redhat.com;
>> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
>> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> Krishnakant Jaju <kjaju@nvidia.com>
>> Subject: Re: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify
>> OAS bits
>>
> [...]
>>> This is how the usage would look with an added "ats" property on the
>>> vfio-pci device:
>>>
>>> -device vfio-pci,...,ats=on
>>>     if ATS_NOT_SUPPORTED then reject
>>> -device vfio-pci,...,ats=off
>>>     keep ATS off
>>> -device vfio-pci,...,ats=auto (default)
>>>    if ATS_NOT_SUPPORTED, disable ATS
>>>     otherwise, enable ATS if the PCIe ATS capability is present
>>>     (this also covers behaviour on older kernels)
>>>
>>> Does the above make sense?
>> Do you have plans wrt the migration to auto properties for the various
>> vSMMU properties (RIL, ssidsize, OAS, ATS)? I just would like to make
>> sure libvirt integrators take this new design into account.
>> Please let me know if some help is needed for the conversion of some of
>> the properties?
> Yes, Nathan is working on a QEMU series to convert those to auto
> properties. I have also sent out a kernel series to report the effective
> ATS status for the device. Sorry, I missed CCing you on that thread.
> Please find it here [0]. The QEMU series needs to make use of this
> as well.
>
> Hopefully, Nathan will be able to send out the QEMU series soon after
> internal review and testing.
>
> Thanks,
> Shameer
> [0] https://lore.kernel.org/linux-iommu/20260303150348.233997-1-skolothumtho@nvidia.com/
>

Thank you for the update & pointers!


Eric

>


