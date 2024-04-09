Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF75FC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 02:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru1Sm-0006Ff-3f; Mon, 08 Apr 2024 22:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1ru1Sl-0006FN-7W
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 22:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1ru1Sj-0005Ot-Jw
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 22:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712630631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MyyuXgBpprcBYNy2gIXa1GFduEQyPKUGuClL+1I3Pso=;
 b=Fp+6yKetQJSd+xiQXaWuVATVuFYzJs6jCg44v8MZuEsSqNpvlpsRe6Z0aSWU5lR0XoXGVS
 J8ZAtBPSPd74A9QYfOo1BrQeKv0y4AT7Q60brlek8zTGqdzbQFmgLHoxNXOW12P81GVmNX
 empgYTSMzaWTr7XlTITch6Ilawp4PRg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-rZ5yCy_8MUeniDQ8GoJqIg-1; Mon, 08 Apr 2024 22:43:46 -0400
X-MC-Unique: rZ5yCy_8MUeniDQ8GoJqIg-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1e3f43caf06so3419945ad.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 19:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712630625; x=1713235425;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MyyuXgBpprcBYNy2gIXa1GFduEQyPKUGuClL+1I3Pso=;
 b=uar4uhMQCP3phFS12Yw/4l1gUXqBIXZn8xs3KD/uhOYaSpAZNIkUwsBZ9ELhHlXiSM
 YEhmreGk/k0zxffrvmP1yt76waBR4ihTEmol0xnlfCZhV0xpRDszhWf4ZjYI9Ljmhtjh
 hl+ziQpXE2fseKpx6gzMM/Y6hEzLrEBeJUoyLH565zIJKueg9xEu7wPSimSnkjl6uhjm
 AOcUJfB0ViKp1BPt89A5eAsrnYKSRGWFkqa5xHeC9QGxQF44PQhVF8DzldVndT55yDwa
 4TedzS/ffAvdtVKmcnhjYvQPu6LJZoO9xo1cQjSM3xn+jwhnO1hVsqdXcUMOZq7tJUKt
 vqew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTPiXxtPnofA0vMMoLts0ik1FxIL4XL5pwGP8Ly/4YCUDtk5Qy0w+xnoiKtHDwdZaLsoG5L3/2wlzOkuLObP62QBu5iCw=
X-Gm-Message-State: AOJu0YzxdRKpaQG/ngPd3dQ/hGc61/NjcLdidgaKfA1BRoKP9eIwLDj3
 VVLyRLSx3mYQpTD7v5alSCckIsz/+MvmKHsCQUvO7JV7gk2tUPDWqJqHNnCW1T+sT5IbYOXDKvw
 qHQw60BEdKdtSVtIgmacogtEh8PbmCq/8EvVjLajemTw9kIhiD3ks
X-Received: by 2002:a17:903:2352:b0:1e0:b5f2:3284 with SMTP id
 c18-20020a170903235200b001e0b5f23284mr12926313plh.0.1712630625197; 
 Mon, 08 Apr 2024 19:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUvmOw3YuDQOIL95rGxa9MHouOtpUFseFfsXabwL8g0vtENStUp5sh3HJxmpdOBzzR4LsO8Q==
X-Received: by 2002:a17:903:2352:b0:1e0:b5f2:3284 with SMTP id
 c18-20020a170903235200b001e0b5f23284mr12926293plh.0.1712630624858; 
 Mon, 08 Apr 2024 19:43:44 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 lo4-20020a170903434400b001db3361bc1dsm7753160plb.102.2024.04.08.19.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 19:43:44 -0700 (PDT)
Message-ID: <5b44a2a2-5326-4ca9-a981-08f59d588e7a@redhat.com>
Date: Tue, 9 Apr 2024 10:43:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Content-Language: en-US
To: Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20240312074849.71475-1-shahuang@redhat.com>
 <901a0623-c93b-4930-9ef5-89adf505929d@redhat.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <901a0623-c93b-4930-9ef5-89adf505929d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Eric,

On 3/19/24 23:23, Eric Auger wrote:
>> +        if (kvm_supports_pmu_filter) {
>> +            assert_set_feature_str(qts, "host", "kvm-pmu-filter", "");
>> +            assert_set_feature_str(qts, "host", "kvm-pmu-filter",
>> +                                   "A:0x11-0x11");
>> +            assert_set_feature_str(qts, "host", "kvm-pmu-filter",
>> +                                   "D:0x11-0x11");
>> +            assert_set_feature_str(qts, "host", "kvm-pmu-filter",
>> +                                   "A:0x11-0x11;A:0x12-0x20");
>> +            assert_set_feature_str(qts, "host", "kvm-pmu-filter",
>> +                                   "D:0x11-0x11;A:0x12-0x20;D:0x12-0x15");
> Just to double check this set the filter and checks the filter is
> applied, is that correct?
> I see you set some ranges of events. Are you sure those events are
> supported on host PMU and won't create a failure on setting the PMU filter?

What I test here is that checking if the PMU Filter parser is right 
which I write in the kvm_pmu_filter_set/get function, I don't test any 
KVM side things like if the PMU event is supported by host.

Thanks,
Shaoqin

> 
> Thanks
> 
> Eric

-- 
Shaoqin


