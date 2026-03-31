Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA2E109B47B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7afh-0007IS-2x; Tue, 31 Mar 2026 11:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w7afe-0007Ho-Ok
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w7afd-0003B9-3j
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774969579;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gryvpOsyuTGg3mo1MKJLcyqv19wF5b49hWrsT2skrY=;
 b=LyNJcaB7ckvwkuxDhWERz+aZ2EggbiFhf0y9spWPzBjuOtqsAiHvdUi6Z8dM1G4vIyyqHT
 lCWQb8SHgvHo6hLWjjaqxMv/LY9pp4l+PsVEtx6Qw3Joqt+kHMk4dXoc3pGQR6yvEGz2wB
 DSgZXbj/Amqu2xkJrLdFHnSZdeIWf1A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-0fPPMFwuPh68ej1mYA0KZQ-1; Tue, 31 Mar 2026 11:06:18 -0400
X-MC-Unique: 0fPPMFwuPh68ej1mYA0KZQ-1
X-Mimecast-MFC-AGG-ID: 0fPPMFwuPh68ej1mYA0KZQ_1774969576
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4888230f434so1036825e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 08:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774969576; x=1775574376;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gryvpOsyuTGg3mo1MKJLcyqv19wF5b49hWrsT2skrY=;
 b=RqqZarsxlsMN4far9KcsT3cyotXw21usymbv9RhSve3gLBZYGkkJNXe/2Jl5bEUukG
 46UOqz9qv5FHs/69+6JwhgZnr5l/7APcGXo8V+oD7ZoiuH4LwdnKagAr3pwWWDxt2VV7
 gtJlU4y1A6tpG00Jo+fov/8GoshkpgYEPDKcBSuTtTzPOia3iFFsaDwKZ/LNUPvtYnBD
 tuwXGmcDnBXkEiRQIE1wAtagINizSyFk/MrS4iaLgXztcNECWF/fAwv4usfpQ/w/wVl8
 65XoVgTIf3Y0GrtWwJXRPB+7jPOJwoq1XFQXETx8khBMDNS1INUFwsJMqITxPQAzlfGR
 Wr/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBiSFelITtIuLkw6M0QM95LfjA+TWeW7rG1Oy7AxaSpRqyj1wsTEC9zoyBINDNfeKaj95V2CusqsD6@nongnu.org
X-Gm-Message-State: AOJu0YzlzRk+y68brNViqnWmVEYJAnZC7VoHVlu8e2vuENpIkgFc4bPn
 1eYQrjYPww7vuswWUiFIjq9j73pn0GeS5RLXOYQxnUmZWfqgxJ1i6m3KRdxh8bKk9f4V1twyTCE
 ekBIcd33g0bY1vn+I9yMdvJ9ffQhL36/KcCtywLLqHtTJ34MYgW0J9jwP
X-Gm-Gg: ATEYQzwJfoKGCiVmNnOyo6zWGO+aZm3tzoDaDQsO8RYgAF/Vnodycaybn2qR2cCvUZo
 UAY/quKODAo1GHrCeAqKR5j4bHC6vaNqPlnCkI1nL3H8i70QaqDv5NHkPYllhknkqCDx6fiXX18
 a8kK+OMbSA02FHtX58bb3wOUbWE17mO69UQZTyB/QidCgn8F2xWrS9nBQ8Typt8eNm15tTzqSAn
 dh/nEW+wiTu9hRvDZcTY6HeaKSAzb20+QO6+YD8rZyyzF5UC2XNjH1x7GzbchJK7KMORPiE3XLp
 Yi0IjkGVSudW3THP/rXgAC/fBoG5YlCYW5rDgRWewVWsuAT6yxk4l/SFL6qy6S9Q/vIVY9QlwMk
 1nqS10FX1YA1zMCL7RZS1Ru03wO94iaqAIYixlQ15sP1Uc04UKCSe1olD9nTChN8oAogFOg==
X-Received: by 2002:a05:600c:6c8:b0:488:7ff5:2c67 with SMTP id
 5b1f17b1804b1-4887ff52e31mr18568765e9.12.1774969576024; 
 Tue, 31 Mar 2026 08:06:16 -0700 (PDT)
X-Received: by 2002:a05:600c:6c8:b0:488:7ff5:2c67 with SMTP id
 5b1f17b1804b1-4887ff52e31mr18568255e9.12.1774969575443; 
 Tue, 31 Mar 2026 08:06:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e7e9786sm40892595e9.3.2026.03.31.08.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 08:06:14 -0700 (PDT)
Message-ID: <5ccbdd38-e63f-4a4a-8d28-9621bf8883fe@redhat.com>
Date: Tue, 31 Mar 2026 17:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is called
 only once per bus
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, mst@redhat.com, skolothumtho@nvidia.com,
 nathanc@nvidia.com
References: <20260323183024.4069032-1-eric.auger@redhat.com>
 <aco9ECUbZ1+QvbOR@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aco9ECUbZ1+QvbOR@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/30/26 11:06 AM, Nicolin Chen wrote:
> On Mon, Mar 23, 2026 at 07:30:20PM +0100, Eric Auger wrote:
>> @@ -3307,11 +3307,16 @@ void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>>   * IOMMU ops are returned, avoiding the use of the parent’s IOMMU when
>>   * it's not appropriate.
>>   */
>> -void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
>> -                             void *opaque)
>> +bool pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
>> +                             void *opaque, Error **errp)
>>  {
>> +    if (bus->iommu_per_bus) {
>> +        error_setg(errp, "An iommu is already attached to this bus");
>> +        return false;
>> +    }
>>      pci_setup_iommu(bus, ops, opaque);
>>      bus->iommu_per_bus = true;
>> +    return true;
> Do we need the same check in pci_setup_iommu()?

For machine wide IOMMU the check is handled in machine code (at least in
arm virt).

Nevertheless a more generic solution could be to check in
pci_setup_iommu() that bus->iommu_ops is not already set. If set, return
an error, cascaded up through pci_setup_iommu() and
pci_setup_iommu_per_bus().
However the change is much more invasive and impacts several archs. What
do you think?

I don't think this can be a valid use case to call pci_setup_iommu()
several times on the same bus?
>
> Apart from this question,
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks

Eric
>


