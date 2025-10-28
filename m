Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D45ECCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDgzZ-0002ya-Ps; Tue, 28 Oct 2025 06:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDgzV-0002xQ-JR
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDgzP-0003hR-TJ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761647499;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rAZXFKEqBGsDhZK9VnZoSejw1t+Bb1+2hbkybSdTJFk=;
 b=hZBlxr6RlOhBYG71WymCJFfp/mIUevOhQoTH+G6Ko04uj/IQMjsHzBhtCLnry6TodM2SI6
 ubJ2KXw5+p9ZKVDtCkCexhCbMpWaBEGZ6WNVe8uKslJR8lrIlIz7kQGkzcJ6TsdGiG6DjP
 xVXf8jhw1UhCcvXc0E32Xt78wCqO4lo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-s9nmokixMOa9PafmSd7G9Q-1; Tue, 28 Oct 2025 06:31:36 -0400
X-MC-Unique: s9nmokixMOa9PafmSd7G9Q-1
X-Mimecast-MFC-AGG-ID: s9nmokixMOa9PafmSd7G9Q_1761647495
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47105bfcf15so33053545e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 03:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761647495; x=1762252295;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rAZXFKEqBGsDhZK9VnZoSejw1t+Bb1+2hbkybSdTJFk=;
 b=VlPgTTLba7P18D/qrXNaKHYxgMQPk3cn6qGpZfl/LyN4B0Kh2qkyV+oouhHXannxHO
 NDDBebrSydrNOFBlgD4rVO01toBYCf/8w5+sh59mbN/L4dw6xd5F7eSz4Kye98rfi/+x
 8gR6lsawZcUaavlBW6DvyS0+ty/rEnyrPxUGkCgjtbIDlyOvyqmEKSuC5+E+W/gpXlgX
 edho/LExR1dOzuuw2d0AJd0TSImpFAsn9uGb0Fvh9I/6tTENjpPaqgjjsLF/3qZwxjHK
 n6BIIxP6sAlh0X1zlNI1yGekmgv05FagqnpkAeyq3yl1FQsgMC8Jxz4JUPXmpg6i6Rvd
 2NwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoVx9d9jDAeOw8NPNEt+MuVDYHgY9LIsGlhrBiJOjsZHPZcmx2/d2WQzP2UCQaltF2IXS0KRz6eAiX@nongnu.org
X-Gm-Message-State: AOJu0Yyg/1BLxtr+ksXqdI7zOwptE424dmeYQhnGTLEOIDY63/nIoZrU
 eQYXuLC3lWVQBui+Isgjedcx++J6CGil/RcwvlAAiUi+AJM5j0caymlVHi+mHKe0pK9yfK+tBIk
 A5nipK/AovKEmfPgSe6zRbbkDTt5EHbUitlPRANp0mSLMdo09pMPeBxig
X-Gm-Gg: ASbGncur1u3LxBbPhS6iLDcWRb6CLvKHWsh7JgmTgbs/HTAZOhUnWxTlDOPgLL+aXJ3
 eo20K5ilG0mfhvXjZ7t7rFmSb99fo1rKxbWRfEfGTRrrBmDTOdLNkqlbdjEqdYo/n/pqflEWobl
 GsAN4Crw/u+mGMoQN/YY1myXM616TPBljoYM0fQFPyFek6UyBjGra6kfp8EZDGgOOj3Lf+9r20d
 /oQoUTYhvYyYk2ULofmEjuoH8AMFPcY6XhiVgf72u+Cqtl22BUjRBLmoHULxQDxyijfv+abL7K+
 CjFWpdMWMXnSBTxt7e7zi/yIPbkEm0pakuKmVCfhgmPAPhWHbgecgaJ93xbb4hKcRn4TtRLoVKC
 nXU+i2E4TqlfeZqw3OzRzrik6ErLI29R6ExUs0ASVVbfmAA==
X-Received: by 2002:a05:600c:3b24:b0:475:d944:2053 with SMTP id
 5b1f17b1804b1-47717df6bdbmr26651545e9.2.1761647495001; 
 Tue, 28 Oct 2025 03:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9mFKIhrC2yy1h9/7dLNPZvVstS4Dlnni5kDIDSHqKFaskf4eMV8uVP0EijH+cYjVIdqSAdw==
X-Received: by 2002:a05:600c:3b24:b0:475:d944:2053 with SMTP id
 5b1f17b1804b1-47717df6bdbmr26651205e9.2.1761647494590; 
 Tue, 28 Oct 2025 03:31:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd48942dsm190938325e9.4.2025.10.28.03.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 03:31:34 -0700 (PDT)
Message-ID: <daaa6f78-c822-48e8-8081-90e16e2773b2@redhat.com>
Date: Tue, 28 Oct 2025 11:31:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/27] hw.arm/smmuv3: Add support for PASID enable
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-28-skolothumtho@nvidia.com>
 <e4eef901-174a-4dad-bd0a-860d705673e1@redhat.com>
 <CH3PR12MB754886D66A38C699CBA87D8AABFCA@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB754886D66A38C699CBA87D8AABFCA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/27/25 7:40 PM, Shameer Kolothum wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 27 October 2025 18:15
>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; Jason Gunthorpe <jgg@nvidia.com>; Nicolin
>> Chen <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
>> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> shameerkolothum@gmail.com
>> Subject: Re: [PATCH v4 27/27] hw.arm/smmuv3: Add support for PASID
>> enable
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
> [..]
>
>>> -    if (STE_S1CDMAX(ste) != 0) {
>>> +    /* If pasid enabled, we report SSIDSIZE = 16 */
>> why do we chose 16 and not a bigger value to avoid incompatibility?
>> worth a comment
> I am not sure what a good value here to support most hardware out there.
> If we select a bigger value, anything less can't be supported.
ah yes you're right, that's the opposite. this is aligned with sid size
anyway so let's keep it as is.
>
>>> +    if (!FIELD_EX32(s->idr[1], IDR1, SSIDSIZE) && STE_S1CDMAX(ste) !=
>>> + 0) {
>>>          qemu_log_mask(LOG_UNIMP,
>>>                        "SMMUv3 does not support multiple context descriptors
>> yet\n");
>>>          goto bad_ste;
>>> @@ -1962,6 +1963,10 @@ static bool
>> smmu_validate_property(SMMUv3State *s, Error **errp)
>>>          error_setg(errp, "oas can only be set to 44 bits if accel=off");
>>>          return false;
>>>      }
>>> +    if (s->pasid) {
>>> +        error_setg(errp, "pasid can only be enabled if accel=on");
>>> +        return false;
>>> +    }
>>>      return true;
>>>  }
>> Just skimming though the SMMU spec, I don't see any handling for STE.S1DSS
>> anywhere Also I would expect some C_BAD_SUBSTREAMID likely to be
>> emitted?
> S1DSS is passed down to host kernel during S1 translate HWPT install. And if
> anything is mis configured w.r.t CD by Guest, the host SMMUv3 will generate
> the events.
OK
>
> Do we need to check S1DSS in here?

about C_BAD_SUBSTREAMID it is likely to be returned through events by
the host. I see it handled in smmuv3_record_event() so maybe that's
enough with accel.

Eric
>
> Thanks,
> Shameer
>


