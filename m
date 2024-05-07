Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7D3C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HCj-0000iI-PD; Tue, 07 May 2024 05:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1s4HCh-0000hs-Lo
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1s4HCc-0004Ts-0I
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715074417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q55ABqTCNonI0FXQbPBXszur4ikvmXTqLMyy1VF/Rvg=;
 b=eLJN+mDVNzB8xQ1VMxdFiy1jAWH147JhIY9ke6XRbOhSjCsQwZkULIuqI6z/+T5BuhIEIW
 d1SzmsEKY8NwEaRB6hAXJEV+S/o5+fJdrBNI2+owzlzLAgDzdgmPVml3gA62YxtvEL/rxo
 v9cRcnrcuOhmX/KrDdpmIY6VxJ5bh8A=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-e6G4_L-qMU6cBZkopVS5cg-1; Tue, 07 May 2024 05:33:32 -0400
X-MC-Unique: e6G4_L-qMU6cBZkopVS5cg-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7e1817ad7d3so11453639f.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 02:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715074412; x=1715679212;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q55ABqTCNonI0FXQbPBXszur4ikvmXTqLMyy1VF/Rvg=;
 b=DWhhZDHhvb3Y7oViWVm3CJKJ18ggNXVga45mf1lXAp9Yf+9WQ3mXsKOyQBlOBEmw1+
 EUVtyJ4n3D9nIt7QVv9yYiOGmJ8q6ep377r02vScYJJlAwG3Tda4acRYCYo+pq9PG+yi
 wREmfynUAuw+Z/qKywfHxZ3jgbEDAbqECO+2DKdOAX6sz0z2w3BP5ZYzMJ2S3ObzsDLp
 zpVokXLxmZJLfdKb6m3eXSL+8DevPhIhRb0JtfFvdbpjX2+UpKfe21rEKMNhWlNHnK9p
 ksRxjUlsx00zTsHrqmMo5tK1PzdLsqu7WfkRnai4H1bTKrpWMQ3yp5vORcSNopeFxZFC
 aJLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS97cCoz4NcXsiMCSCIGWrXYBwmqtMUh5wo78iKXpojSDOsJC4oIFT9r3LpxqExwuMi3qRBXl92YcUeIKVua8JfY1vkeg=
X-Gm-Message-State: AOJu0YwKFrHxsQ/mGpY9cUsYuvgDHMAIMFycuxR9bXNGgIv9OCgKQ0aE
 ak8PITV3VJazwLcaiWLFPk7JyhP7//Rq7NkVOBAeDW/fa/WANZxOnsEVRjyt0tUW7SJ+I2kXAmO
 YovtCrPgqwolxVYZvXDuY2WTunmDE5N2GrLfD/L0aPuXmbUYr3Hde
X-Received: by 2002:a05:6e02:1d13:b0:36c:5572:f69d with SMTP id
 i19-20020a056e021d1300b0036c5572f69dmr14984573ila.1.1715074411802; 
 Tue, 07 May 2024 02:33:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy8kBGxNUFTj9x5oRKEt9YsqYNbn2od4gy+bBYwdTJXnUWfPHHNdagNmRbwKs8dK03PsgQkw==
X-Received: by 2002:a05:6e02:1d13:b0:36c:5572:f69d with SMTP id
 i19-20020a056e021d1300b0036c5572f69dmr14984557ila.1.1715074411415; 
 Tue, 07 May 2024 02:33:31 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 n10-20020aa78a4a000000b006ea8ba9902asm9025877pfa.28.2024.05.07.02.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 02:33:31 -0700 (PDT)
Message-ID: <2df3915c-8928-4c01-979e-8c71603a2279@redhat.com>
Date: Tue, 7 May 2024 17:33:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20240409024940.180107-1-shahuang@redhat.com>
 <Zh1j9b92UGPzr1-a@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <Zh1j9b92UGPzr1-a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Daniel,

On 4/16/24 01:29, Daniel P. Berrangé wrote:
> On Mon, Apr 08, 2024 at 10:49:40PM -0400, Shaoqin Huang wrote:
>> The KVM_ARM_VCPU_PMU_V3_FILTER provides the ability to let the VMM decide
>> which PMU events are provided to the guest. Add a new option
>> `kvm-pmu-filter` as -cpu sub-option to set the PMU Event Filtering.
>> Without the filter, all PMU events are exposed from host to guest by
>> default. The usage of the new sub-option can be found from the updated
>> document (docs/system/arm/cpu-features.rst).
>>
>> Here is an example which shows how to use the PMU Event Filtering, when
>> we launch a guest by use kvm, add such command line:
>>
>>    # qemu-system-aarch64 \
>>          -accel kvm \
>>          -cpu host,kvm-pmu-filter="D:0x11-0x11"
> 
> I'm still against implementing this one-off custom parsed syntax
> for kvm-pmu-filter values. Once this syntax exists, we're locked
> into back-compatibility for multiple releases, and it will make
> a conversion to QAPI/JSON harder.

Thanks for your effort of reviewing my patch. I think if I need cost 
more time about the QAPI, that's outside my initial idea and deviate 
from supporting the PMU Filter.

So I decide to not update this patch now. And wait until I have time to 
look into the QAPI or the -cpu option has been transformed to QAPI format.

Thanks,
Shaoqin

> 
> With regards,
> Daniel

-- 
Shaoqin


