Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2929BC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 08:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYhjl-0007ZW-DN; Fri, 17 Jan 2025 03:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYhjj-0007Xw-2D
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:29:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYhjh-00037g-BE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737102587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L8OgWe2scRS5+cvGHDsJJrW+IZVHGxvWxU4RiRh0Cv8=;
 b=hQ7M3bHNpiig9tp5plo4dhp2xTYOOrPUbGi5l+2Ms1eKJygQYl7e735wCCyB/lTOCOrsy4
 ZQYeft1w3lOZ1GWy9oVU9IvL52KpHtzASDWpSAxUcqDK8MSm+ji8QreV+kS1+PthxP32ga
 dAsNysZs/Oj+ruzcW0xHSK0sDLWlCnY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-XzXIuCI1OXGl7f_PvE9dCg-1; Fri, 17 Jan 2025 03:29:45 -0500
X-MC-Unique: XzXIuCI1OXGl7f_PvE9dCg-1
X-Mimecast-MFC-AGG-ID: XzXIuCI1OXGl7f_PvE9dCg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4362153dcd6so8808645e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 00:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737102584; x=1737707384;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L8OgWe2scRS5+cvGHDsJJrW+IZVHGxvWxU4RiRh0Cv8=;
 b=A15syq9gdI/PS95EGcvCYeGrPCdPL26eOE1s1vQPVTrpyne1zqMTzTn+a7CAMh5z0E
 wBH/7/PcGE45nkOLTG7AuQSwqCGcLXPc3VASU/dkpT/e7YAdEYos3rUQRHdKtxAfDRgW
 CZSnTmZck0LBVASQUb/A/LThHDBLQSRT3g1j0hSZjPrCO7W8oO8c1E21A7hAsjHN4VCA
 PRJuNJ/wFYm42mNLjDF0kZUHbbZ5so9IJsCS9pR2BQZAG06yagSIoxwcsbjJgBsnEnos
 /mAqehwhPvaStkK5GTW4IHo49PcTx6Cl+K0UGBtKzXMjknJNyB7Gg2oQqkIw55ctSgj+
 EXbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoV4ZceNk0i8e4uyojAKw2+KYs3gDZEhKYySsEsaN2D460saUlfiTa/gjP6eVQmaD/VBJ8jR1asKtZ@nongnu.org
X-Gm-Message-State: AOJu0Yw0YCvXD/KNDv/8Iw3eyaR2hfNvB8mMM0ylaRBb/iEF0Z6mXSZG
 LCVLC4YuD2q7+cDI24xcT8OGt3dA++k8iq+wOaDSJ3Cvcbpl/iqvnPFS8vKuj14aQ8FwTPgDvwk
 0/wyYeMUyg0NVuoX9izk500Xci0p39ezY6ELJbl0CJybF+bOUSXvt
X-Gm-Gg: ASbGnctTygKr/a4ebVlzBHfjCd5bgVisJPcJXDkoaK1BE3fY7Km5JAe9TFqxGNFSSYO
 g3uiygtmRdJNj0jdx28k7ZnHiD+c1G3B1Bij+eipNOMHWC2+xcsu7nXKxQq7aCU4bT2hxzTLqSC
 UwD6mvlMC164OCk0a4kAvmWgu9Ti9O48VMjDywIympH9iEy0ttnEZ4nR9YTZoEcaUUEdHTXsjG3
 Gp32OR4GJWX7KEEYomAWy0NdNjWcVL+T2D0ww6e0ZH9gZZ2QFzoK6brLf0M7lcDoqF5YYYHbEbJ
 3lMJDD+eFFUK
X-Received: by 2002:a05:600c:a06:b0:436:1c04:aa8e with SMTP id
 5b1f17b1804b1-438913dfebfmr16909935e9.16.1737102584321; 
 Fri, 17 Jan 2025 00:29:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt6zkUUhtkIjB5SxCWhEJx1y6mr3TvOk8cztEybb80BHx02tPEZ5SyHK34cNykY+Ahz1bZPQ==
X-Received: by 2002:a05:600c:a06:b0:436:1c04:aa8e with SMTP id
 5b1f17b1804b1-438913dfebfmr16909125e9.16.1737102582867; 
 Fri, 17 Jan 2025 00:29:42 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ac604sm85393825e9.13.2025.01.17.00.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 00:29:42 -0800 (PST)
Message-ID: <70342038-6bd6-4c80-b46f-69a3c58fb5b5@redhat.com>
Date: Fri, 17 Jan 2025 09:29:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 00/13] hw/arm: Remove virt-2.6 up to virt-2.12
 machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <823a0892-e9d9-4d26-b862-83ffd60c2ad1@linaro.org>
 <d9f97b63-dbfc-4322-b7a1-8759d6be5cd7@redhat.com>
 <Z4oP9YEBc-opiL4K@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z4oP9YEBc-opiL4K@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 17/01/2025 09.09, Daniel P. Berrangé wrote:
> On Fri, Jan 17, 2025 at 07:47:15AM +0100, Thomas Huth wrote:
>> On 16/01/2025 22.13, Philippe Mathieu-Daudé wrote:
>>> Hi Peter,
>>>
>>> On 16/1/25 15:59, Philippe Mathieu-Daudé wrote:
>>>> The versioned 'virt' machines up to 2.12 been marked as deprecated
>>>> two releases ago, and are older than 6 years, so according to our
>>>> support policy we can remove them. Remove associated dead code.
>>>
>>>> Philippe Mathieu-Daudé (13):
>>>>     hw/arm/virt: Remove deprecated virt-2.6 machine
>>>>     hw/arm/virt: Remove VirtMachineClass::no_pmu field
>>>>     hw/arm/virt: Remove VirtMachineClass::disallow_affinity_adjustment
>>>>     hw/arm/virt: Remove deprecated virt-2.7 machine
>>>>     hw/arm/virt: Remove VirtMachineClass::no_its field
>>>>     hw/arm/virt: Remove deprecated virt-2.8 machine
>>>>     hw/arm/virt: Remove VirtMachineClass::claim_edge_triggered_timers
>>>>       field
>>>>     hw/arm/virt: Remove deprecated virt-2.9 machine
>>>>     hw/arm/virt: Remove deprecated virt-2.10 machine
>>>>     hw/arm/virt: Remove deprecated virt-2.11 machine
>>>>     hw/arm/virt: Remove VirtMachineClass::smbios_old_sys_ver field
>>>>     hw/arm/virt: Remove deprecated virt-2.12 machine
>>>>     hw/arm/virt: Remove VirtMachineClass::no_highmem_ecam field
>>>
>>> Please ignore this (reviewed) series for now. I'll rebase it and
>>> repost after the 10.0 release.
>>
>> Why? IMHO it should be ok to include them now already. While Daniel's macro
>> only starts the automatic disablement for 10.1, it should be ok to remove
>> them now already according to our normal deprecation policy: The machines
>> have been marked as deprecated in the 9.1 release already (via commit
>> https://gitlab.com/qemu-project/qemu/-/commit/ce80c4fa6ff ), and thus they
>> have been deprecated since two releases already. So it should be fine to
>> remove them now, shouldn't it?
> 
> No, because as of 9.1.0 we documented that machine types are under the
> new policy, and these were only deprecated in 9.1.0, hence the new policy
> applies to them.

Hm, I guess we could argue now about the wording (I don't see a spot in 
ce80c4fa6ff that says that this only happens starting with 10.1), but in the 
long run, it doesn't really matter much whether we remove these machines 
with 10.0 already or just with 10.1, so let's go with 10.1 instead.

  Thomas


