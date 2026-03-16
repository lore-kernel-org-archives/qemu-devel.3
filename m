Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110E5F46445
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25J7-0005OV-BH; Mon, 16 Mar 2026 06:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w25J3-0005O6-IR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w25Iz-0002VS-EG
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773657369;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jrczenpk/Ie2q/bnJVGvTsZe3qMz3FFdtOL/x3thFNQ=;
 b=cYy1vA7yJTEKV127usz1tC3MuJMuwsD9TiszYqrgrqQ5QwIjTh7L578GD6Pf4zifL+5m9D
 hEwJpyZtDL8/b4MCGFniZWGncjmd0Hh4qwyBxkN6vEkJGeqDRQ/dSIrmTGF/d9SD2wlfMw
 cICzJx3jV1EFEAjc4vh4Hr688l7Euvg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-98WK9--2MnebsUo1hRJeAw-1; Mon, 16 Mar 2026 06:36:08 -0400
X-MC-Unique: 98WK9--2MnebsUo1hRJeAw-1
X-Mimecast-MFC-AGG-ID: 98WK9--2MnebsUo1hRJeAw_1773657367
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4853f33b7dbso38411115e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657367; x=1774262167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrczenpk/Ie2q/bnJVGvTsZe3qMz3FFdtOL/x3thFNQ=;
 b=a0tXeL9vGdkLDSxDC391pHVwpnN4G04OdaEoJFquFOVILU07rlqQjdZJgyt4jVpBV+
 d7fVB2oNwIu/NSuSdh8dU7T+pl51WKI7HIDYPjuETmoEgFOEkppzPZ9nuTH6rRnvpHOg
 5M+jbklLYrXTAtn4k2gFPQHkduAhFuzsfacN2YFOX0ZmC5cN+Fbt2kyw1iZliIRjF5Xh
 5Ndoh6WDxFHkYQu0tTJoeDNMDgpFyu2Zeurju/OcOtIwKmmxz7sbVWrXMUrO2sYQJmaW
 epTrPZY7gpbD2KiK9ww3foWm/IEhCbPL6mSkOXygnGWxZ6M4JHS0A791UQ154IZeJT31
 DEJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEIIz9LmWF5eqBCgPtPOOZPbCuS99DGb9/al55AIKl/l8hKGNKqqN/OA3LJEQnLY/XigJHPUh+Cfll@nongnu.org
X-Gm-Message-State: AOJu0Ywc6CJtjh3HT5fre9Sitm6XzshzX4riun0cNBSaYdlIU8/kA2+7
 JdPaUkqvAxbnjbNdjEJETfLqRN3j2BgPo2JWweB9zyTDsG1aID06g9bDry5rTbqVIhgGqtuQlBT
 oXoey5ZXqhmG9c0zTR5GOhmiLEgRs07xBpq6+8M29Z8I6SG9A1nbmN1yV
X-Gm-Gg: ATEYQzzgw2GRfJRHR7RsoMEidjA6jeK31QLSjeUJ5AmustrwT5HLxY5GXSc7IGDSQ0q
 HiAVO6/NEG6xi7PfinLOrocqo/8uv7OCNp7f/jL7K0YnwagVKoSKQCWevGd/5ythFEvxBJnU/UX
 cJhUcTo5otiYP/tNzf6qr0RUCemzwG93tAn2ShvsOlaxP/oOwG1Ak20EQElVZ/QNqal+sauCPqa
 0SxPDfsvMIn0E//v3cOimUMgQ2X6Hi1x+E7DhL4SiaIkWb1iIwQqmTd8EqUTBkBzGCw6KzYqIPL
 wOU4q7ZktayPLf88F+b2RLx+azoMRssvZw50i1+hQbIWMfo38wgLWFn8m88g0DicEkFqmhgkRWR
 ilLkwkGl9gtGu7wU+pa/Si3NNgDq6X4dab8yHNQupjybftaEkSfbBlJt3tufGht8JcDMSbA==
X-Received: by 2002:a05:600c:4689:b0:482:e5d4:b7ca with SMTP id
 5b1f17b1804b1-485566d6e49mr203071265e9.8.1773657366820; 
 Mon, 16 Mar 2026 03:36:06 -0700 (PDT)
X-Received: by 2002:a05:600c:4689:b0:482:e5d4:b7ca with SMTP id
 5b1f17b1804b1-485566d6e49mr203070655e9.8.1773657366234; 
 Mon, 16 Mar 2026 03:36:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5e912fsm1066948015e9.2.2026.03.16.03.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 03:36:05 -0700 (PDT)
Message-ID: <671d4604-9656-4f74-961c-88f447058858@redhat.com>
Date: Mon, 16 Mar 2026 11:36:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 14/43] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
 <20260129160917.1415092-15-peter.maydell@linaro.org>
 <CAFEAcA-AoJmHpcAydqk9x_Y6M8_7N=7-izYFPxerLuTdYUKsNg@mail.gmail.com>
 <CAFEAcA99c+-qQX+wfVTZ5bKeYozm+WrFHsb=GEQriu_SuWjhWQ@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA99c+-qQX+wfVTZ5bKeYozm+WrFHsb=GEQriu_SuWjhWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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



On 3/13/26 3:06 PM, Peter Maydell wrote:
> Ping for opinions on whether Coverity is right about a leak here...
>
> thanks
> -- PMM
>
>
> On Tue, 17 Feb 2026 at 14:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On Thu, 29 Jan 2026 at 16:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> A device placed behind a vSMMU instance must have corresponding vSTEs
>>> (bypass, abort, or translate) installed. The bypass and abort proxy nested
>>> HWPTs are pre-allocated.
>>>
>>> For translat HWPT, a vDEVICE object is allocated and associated with the
>>> vIOMMU for each guest device. This allows the host kernel to establish a
>>> virtual SID to physical SID mapping, which is required for handling
>>> invalidations and event reporting.
>>>
>>> An translate HWPT is allocated based on the guest STE configuration and
>>> attached to the device when the guest issues SMMU_CMD_CFGI_STE or
>>> SMMU_CMD_CFGI_STE_RANGE, provided the STE enables S1 translation.
>>>
>>> If the guest STE is invalid or S1 translation is disabled, the device is
>>> attached to one of the pre-allocated ABORT or BYPASS HWPTs instead.
>>>
>>> While at it, export smmu_find_ste() for use here.
>> Hi; Coverity points out what looks like a missing
>> deallocation on an error-exit path in this function (CID 1644832):
>>
>>> +bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>>> +                              Error **errp)
>>> +{
>> [...]
>>
>>> +    /*
>>> +     * Install the STE based on SMMU enabled/config:
>>> +     * - attach a pre-allocated HWPT for abort/bypass
>>> +     * - or a new HWPT for translate STE
>>> +     *
>>> +     * Note: The vdev remains associated with accel_dev even if HWPT
>>> +     * attach/alloc fails, since the Guest–Host SID mapping stays
>>> +     * valid as long as the device is behind the accelerated SMMUv3.
>>> +     */
>>> +    if (!smmu_enabled(s)) {
>>> +        hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
>>> +    } else {
>>> +        config = STE_CONFIG(&ste);
>>> +
>>> +        if (!STE_VALID(&ste) || STE_CFG_ABORT(config)) {
>>> +            hwpt_id = accel->abort_hwpt_id;
>>> +        } else if (STE_CFG_BYPASS(config)) {
>>> +            hwpt_id = accel->bypass_hwpt_id;
>>> +        } else if (STE_CFG_S1_TRANSLATE(config)) {
>>> +            s1_hwpt = smmuv3_accel_dev_alloc_translate(accel_dev, &ste, errp);
>> In this function we allocate memory and return it, assigning
>> it to s1_hwpt...
>>
>>
>>> +            if (!s1_hwpt) {
>>> +                return false;
>>> +            }
>>> +            hwpt_id = s1_hwpt->hwpt_id;
>>> +       }
>>> +    }
>>> +
>>> +    if (!hwpt_id) {
>>> +        error_setg(errp, "Invalid STE config for sid 0x%x",
>>> +                   smmu_get_sid(&accel_dev->sdev));
>>> +        return false;
>> ...but in this error-exit code path we don't free it.
s1_hwpt is allocated if iommufd_backend_alloc_hwpt() succeeded and if it
did hwpt_id cannot be NULL I think.
Shameer, Nicolin, please could you confirm

Adding Shameer in TO

Eric 
>>
>>> +    }
>>> +
>>> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
>>> +        if (s1_hwpt) {
>>> +            iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
>>> +            g_free(s1_hwpt);
>>> +        }
>> Compare the error-handling here which does tidy up s1_hwpt.
>>
>>> +        return false;
>>> +    }
>> thanks
>> -- PMM


