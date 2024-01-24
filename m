Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7962C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 13:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSd5P-0006ae-5j; Wed, 24 Jan 2024 08:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rSd5J-0006Ta-QJ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:14:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rSd5I-00056Y-7H
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706102067;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kikj5Q9USpTy7MPHUzO0q8pIzEJ5a9YPFpJuSzTrSjU=;
 b=cGLOVONxs3zvuit1hKGlwBq4A/gM2aq7QQcoOIDaJ820cAMtOP/tTsJKP687gtje1QYftp
 rms6Ol5qcLAYfKDDSxWqiUMl7Eh2XvMvOasgutTEnL1FJg9PvvVctDF1t3J8i18BT+WPQk
 +fUkO8V2InMnuCiuXN3QOznPpRPV5J8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-aSzfa7C7PFK0vaZ_o4096w-1; Wed, 24 Jan 2024 08:14:23 -0500
X-MC-Unique: aSzfa7C7PFK0vaZ_o4096w-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7838d129bf8so638836285a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 05:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706102063; x=1706706863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kikj5Q9USpTy7MPHUzO0q8pIzEJ5a9YPFpJuSzTrSjU=;
 b=PveRDKDtZ5wD7Ane56/rotubtU9sThCx5zsdzigsLrU0LhNj/bSxLPqsODh5scwtjb
 cRKYOvshCvM/mJ6GeOWyy7l0SPMcTE3W7bG/vuDw2esbhWRRyhXaByIvwxXCseXL1eu5
 Rl3RNQZVh+UVG9oOvAkzUVoZwLD2yUAcPyANGePRPJJCvyubpdlkTqsOLDpxT+h/wE2o
 W0LBXt6/QeIY8QSBV/bvjvOfZxptNjQRSw5EYBy37cuRgStd0N44F1fcbblFoE3vqyuV
 ye4bfo+r79jIV9py0T4Ci0+kfQJ9ecy7xU/uZguuTRprw9i72d09Ee9UuIBgLT3ZVIg6
 pEAg==
X-Gm-Message-State: AOJu0YzBDF5PWtkm6b3btjk5Sqc/hW7YrXwsIjiQEBlHriHOp++KjoLM
 z18FyrC4VMDFpidPp8DfD74EJiKueX+uW174+sY0X2kX/QfDh18okAnzt8wkQANGFOen+CjjQSl
 5OcFoFQ8vJYcGlkpW/tVul4aubveuOmsJ8kXOmm958vYa/ygWDPzR
X-Received: by 2002:a05:620a:218a:b0:783:3625:9e35 with SMTP id
 g10-20020a05620a218a00b0078336259e35mr7571491qka.20.1706102063350; 
 Wed, 24 Jan 2024 05:14:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYHiE6amf5nxZH3g53MA8KkSFzXbJDRFrFpKq2pqBxFGO97G1AelU82EA69a7m2V1iolBaHg==
X-Received: by 2002:a05:620a:218a:b0:783:3625:9e35 with SMTP id
 g10-20020a05620a218a00b0078336259e35mr7571475qka.20.1706102063081; 
 Wed, 24 Jan 2024 05:14:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a37ac10000000b007816dc2ef52sm4019251qkm.8.2024.01.24.05.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 05:14:22 -0800 (PST)
Message-ID: <a35c4fad-a981-4fbf-81d1-be5625a537b9@redhat.com>
Date: Wed, 24 Jan 2024 14:14:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] virtio-iommu: Add an option to define the input range
 width
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, peterx@redhat.com, yanghliu@redhat.com,
 mst@redhat.com, clg@redhat.com, jasowang@redhat.com
References: <20240123181753.413961-1-eric.auger@redhat.com>
 <20240123181753.413961-2-eric.auger@redhat.com>
 <20240123165141.7a79de34.alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240123165141.7a79de34.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alex,

On 1/24/24 00:51, Alex Williamson wrote:
> On Tue, 23 Jan 2024 19:15:55 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> aw-bits is a new option that allows to set the bit width of
>> the input address range. This value will be used as a default for
>> the device config input_range.end. By default it is set to 64 bits
>> which is the current value.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  include/hw/virtio/virtio-iommu.h | 1 +
>>  hw/virtio/virtio-iommu.c         | 4 +++-
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
>> index 781ebaea8f..5fbe4677c2 100644
>> --- a/include/hw/virtio/virtio-iommu.h
>> +++ b/include/hw/virtio/virtio-iommu.h
>> @@ -66,6 +66,7 @@ struct VirtIOIOMMU {
>>      bool boot_bypass;
>>      Notifier machine_done;
>>      bool granule_frozen;
>> +    uint8_t aw_bits;
>>  };
>>  
>>  #endif
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index ec2ba11d1d..e7f299e0c6 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -1314,7 +1314,8 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>       */
>>      s->config.bypass = s->boot_bypass;
>>      s->config.page_size_mask = qemu_real_host_page_mask();
>> -    s->config.input_range.end = UINT64_MAX;
>> +    s->config.input_range.end =
>> +        s->aw_bits == 64 ? UINT64_MAX : BIT_ULL(s->aw_bits) - 1;
> What happens when someone sets aw_bits = 1?  There are a whole bunch of
> impractical values here ripe for annoying bug reports.  vtd_realize()
> returns an Error for any values other than 39 or 48.  We might pick an
> arbitrary lower bound (39?) or some other more creative solution here
> to avoid those silly issues in our future.  Thanks,
You're right. I can check the input value. This needs to be dependent on
the machine though but this should be feasable.
Then I would allow 39 and 48 for q35 and 64 only on ARM.

Eric
>
> Alex
>
>>      s->config.domain_range.end = UINT32_MAX;
>>      s->config.probe_size = VIOMMU_PROBE_SIZE;
>>  
>> @@ -1525,6 +1526,7 @@ static Property virtio_iommu_properties[] = {
>>      DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>>                       TYPE_PCI_BUS, PCIBus *),
>>      DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
>> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>  


