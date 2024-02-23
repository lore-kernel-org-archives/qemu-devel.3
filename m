Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D42FC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 11:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdTub-0002Fn-7R; Fri, 23 Feb 2024 06:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdTu8-00026U-Ag
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 06:39:48 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdTu6-0007FT-Lj
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 06:39:48 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d146737e6so213366f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 03:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708688384; x=1709293184; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vFrTC68/Vm1sl9Kf1uhunphqhN11iyt5Dx2XdhQzjgA=;
 b=pnA8tjwcoy9IQi60p/k0XDBHhZIPTpcAQnEp8O1zJ7oad4B8MHTaHrZXB3QCK181Nw
 NTTeceJxcTZ9CcRtiFFx6pqvLhDq37V07+GIBgJWvR9t5z2DOtJcGORkx9kH+NEV/4mH
 wTO1CjNz35naioN4b7C1TSxO/XZ2WfNKJIc2SKYYdtlPkrh4w9eI6RvEufZ2y0pdTvJb
 9N9FZs+mTra0nNMGQg+24T5G84SXasgISFut0gPznDe5mSoQQKrOxWAp8fWEFaRCrwci
 JDyNy5hgc3K3PDpGCKUYOafwRMG5nbHAX53w2FEJ6tZ1xutWrms4nxfnSL3qzJdaMGki
 qqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708688384; x=1709293184;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vFrTC68/Vm1sl9Kf1uhunphqhN11iyt5Dx2XdhQzjgA=;
 b=eBEZlVBMHOfu5jysAdj3pZ43joJvEu8WuyHS3lEX0UOSq8kaWAhnY6bT19hIzHIVck
 LhzCsgaaURHFq8cUwguOHAcdZs9LMc9DOkcZh6DqHNa5tuPOc+G446aHKkGqpFLeJLlo
 JbHLMY1HIuQMpbLjJhgy0/oCRkSF/fKWuANhZ5pYLQHEZNQ4zTnHrFgF3OXTt3Xl5xX3
 LKr5ne6KDyzPu3iWo4uEL2pnWL8xyhObLn82NCWbhuJPSIcn4avrWaHNjoNRqNk80mjD
 BvU46TppLeo/1ysHmUl1TRI5eyL3VBA3rmuoTpUIokT5JjxL4oVRIppOG15GWlFkznOw
 20wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSlV3KAKQ2cT6Tl6UQvf6UFFtr3cwJIS58v1nFLFeCBBjvBaLdEeGFKL6Edxe/bBCSQMaPAPnJ1kWfCZuhqid/06tPPwo=
X-Gm-Message-State: AOJu0Yy3wMPGvdlXRiAWSAzrphHhSpO5O3gvQc7JXlwOmhTckD1x73L9
 bagL3GcwYJOrqSO7uiRSbkQZEUw4fYugRF9rDdt3bgn5tT/F5bSNSPRhbES9liU=
X-Google-Smtp-Source: AGHT+IFIleO98zEDjGXo7816D2w90h/K8ZhPz4ufFLhm0322UXovbZXkva1VEuSUsbM0JbJgqyr7tw==
X-Received: by 2002:adf:e0c4:0:b0:33d:28a9:2fd8 with SMTP id
 m4-20020adfe0c4000000b0033d28a92fd8mr1091529wri.39.1708688383663; 
 Fri, 23 Feb 2024 03:39:43 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 q25-20020a056000137900b0033ce06c303csm2469799wrz.40.2024.02.23.03.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 03:39:43 -0800 (PST)
Message-ID: <26eb60f4-d9e6-4be5-b114-5a695ab89509@linaro.org>
Date: Fri, 23 Feb 2024 12:39:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] qdev: Add a granule_mode property
Content-Language: en-US
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 Markus Armbruster <armbru@redhat.com>
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com,
 jasowang@redhat.com, pbonzini@redhat.com, berrange@redhat.com
References: <20240223074459.63422-1-eric.auger@redhat.com>
 <20240223074459.63422-2-eric.auger@redhat.com>
 <07d4a2a4-1880-4402-a12a-94eeb649f8b0@linaro.org>
 <fd894834-622f-4d1e-b594-87beb35deebf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fd894834-622f-4d1e-b594-87beb35deebf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 23/2/24 09:30, Eric Auger wrote:
> Hi Philippe,
> 
> On 2/23/24 08:52, Philippe Mathieu-Daudé wrote:
>> Hi Eric,
>>
>> On 23/2/24 08:27, Eric Auger wrote:
>>> Introduce a new enum type property allowing to set an
>>> IOMMU granule. Values are 4K, 8K, 16K, 64K and host.
>>> This latter indicates the vIOMMU granule will match
>>> the host page size.
>>>
>>> A subsequent patch will add such a property to the
>>> virtio-iommu device.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> ---
>>>
>>> v3 -> v4:
>>> - Add 8K
>>> ---
>>>    include/hw/qdev-properties-system.h |  3 +++
>>>    include/hw/virtio/virtio-iommu.h    | 11 +++++++++++
>>>    hw/core/qdev-properties-system.c    | 15 +++++++++++++++
>>>    hw/virtio/virtio-iommu.c            | 11 +++++++++++
>>>    4 files changed, 40 insertions(+)
>>
>>
>>> diff --git a/include/hw/virtio/virtio-iommu.h
>>> b/include/hw/virtio/virtio-iommu.h
>>> index 5fbe4677c2..e22327548f 100644
>>> --- a/include/hw/virtio/virtio-iommu.h
>>> +++ b/include/hw/virtio/virtio-iommu.h
>>> @@ -31,6 +31,17 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOIOMMU, VIRTIO_IOMMU)
>>>      #define TYPE_VIRTIO_IOMMU_MEMORY_REGION "virtio-iommu-memory-region"
>>>    +typedef enum GranuleMode {
>>> +    GRANULE_MODE_4K,
>>> +    GRANULE_MODE_8K,
>>> +    GRANULE_MODE_16K,
>>> +    GRANULE_MODE_64K,
>>> +    GRANULE_MODE_HOST,
>>> +    GRANULE_MODE__MAX,
>>> +} GranuleMode;
>>> +
>>> +extern const QEnumLookup GranuleMode_lookup;
>>
>> Aren't this, ...
>>
>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>> index 2ec5ef3cd1..a9bdc03d12 100644
>>> --- a/hw/virtio/virtio-iommu.c
>>> +++ b/hw/virtio/virtio-iommu.c
>>> @@ -44,6 +44,17 @@
>>>    #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>>>    #define VIOMMU_PROBE_SIZE 512
>>>    +const QEnumLookup GranuleMode_lookup = {
>>> +    .array = (const char *const[]) {
>>> +        [GRANULE_MODE_4K]   = "4K",
>>> +        [GRANULE_MODE_8K]   = "8K",
>>> +        [GRANULE_MODE_16K]  = "16K",
>>> +        [GRANULE_MODE_64K]  = "64K",
>>> +        [GRANULE_MODE_HOST] = "host",
>>> +    },
>>> +    .size = GRANULE_MODE__MAX
>>> +};
>> ... and this supposed to be QAPI generated?
> If I remove both, it does not compile. How do you make it generated?

The following:

-- >8 --
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 19c7c36e36..c8d38d23e2 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -959 +959,19 @@
    'data': { 'unused-iothread-vq-mapping': ['IOThreadVirtQueueMapping'] } }
+
+##
+# @GranuleMode:
+#
+# @4k: granule page size of 4KiB
+#
+# @8k: granule page size of 8KiB
+#
+# @16k: granule page size of 16KiB
+#
+# @64k: granule page size of 64KiB
+#
+# @host: granule matches the host page size
+#
+# Since: 9.0
+##
+{ 'enum': 'GranuleMode',
+  'data': [ '4k', '8k', '16k', '64k', 'host' ] }
---

generates in "qapi/qapi-types-virtio.h":

---
typedef enum GranuleMode {
     GRANULE_MODE_4K,
     GRANULE_MODE_8K,
     GRANULE_MODE_16K,
     GRANULE_MODE_64K,
     GRANULE_MODE_HOST,
     GRANULE_MODE__MAX,
} GranuleMode;

#define GranuleMode_str(val) \
     qapi_enum_lookup(&GranuleMode_lookup, (val))

extern const QEnumLookup GranuleMode_lookup;
---

