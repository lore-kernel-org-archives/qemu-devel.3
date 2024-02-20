Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E34C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 07:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcKHC-0000nH-WC; Tue, 20 Feb 2024 02:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcKHB-0000mt-TA
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:10:49 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcKHA-0008JN-AC
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:10:49 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so805774866b.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 23:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708413045; x=1709017845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v+S6ZJERfThL4wLhWONge+QXGq/6LbhlTg2kdjWmYNg=;
 b=I5wejuz2/fUcuUx5y/PLIEZYg8udlS0ubsFebONQPJGyqm7QJVO/L2Bdp1NQG/PXZe
 V9I1FediOTeG5y92wVDTZMTW2vroIHgVbCPs3P4subumce9gX8SZBB0qYuJeVy1eRJFo
 E7pB8jXMceLgrWhsyNSx3hIaYHGrvop3bYO8sDIwW3vfHrSoegCYF3MpM50mcaTq3JZF
 fiCYyGQK/OeYHsbAcvNRzsJUcEmBSc7Bg7xC7XeUS11BNcj61qklBd0Bx/I12TXagcSf
 nMiOhT310KGBWm2o7h0KyURQfL2+9J0W/JiTa8gyyF8dwgEU17nkdYC1uDnNgMb5LOFQ
 6erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708413045; x=1709017845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v+S6ZJERfThL4wLhWONge+QXGq/6LbhlTg2kdjWmYNg=;
 b=Osifgcoz1JyQbt9AdnTA/vl7OeiyV+Eea+9pl27DqjRinIdO9PXJuH9Cf7alloUTKT
 7WsMVxaYmPdz4SJ4LH0zt/L344DhvIIzwdVFpSEAHRrbX0CTgWIxU94+aQuSoRrRPSBB
 QafYSsWmfi9WpV2pChHhlZiRJY76y4TXhk0VdHoOtnWLTB2V0ghWuAnjHn78laeWliYu
 7bW5q8wfHA/bwLtQQ06kgZI1EDWTY7VNqAc7gxxPJ90s91TYW7zpGF9VMGePrR9MIvuk
 G4iFhyebBYTraXVPJLcPX3SRYuPtp4AelSdi7gaK7zM90bHBFa72SeTTP+DTBeQlFF4P
 iWkA==
X-Gm-Message-State: AOJu0Yw6pWYEs9z8thtIy1KLDIXNI8ZVUynbsc/fsefJfko/ayUbACvA
 kWgANQBecW7XSJnYNLw+msgwjNXUZoKw9fHFOdO6h9kbxbFX8hX1QCI7jZynx/M=
X-Google-Smtp-Source: AGHT+IEr6xEJn0c+v5xmNJyx0k3J5t5yBhNCoOWzRaBU0KZwZs+nNIzx06G601uc7XrZWvddMSScPQ==
X-Received: by 2002:a17:906:3616:b0:a3e:4e48:43a with SMTP id
 q22-20020a170906361600b00a3e4e48043amr6699497ejb.55.1708413044984; 
 Mon, 19 Feb 2024 23:10:44 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 qw23-20020a170906fcb700b00a3e426149a1sm2878011ejb.50.2024.02.19.23.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 23:10:44 -0800 (PST)
Message-ID: <7cae30fb-2a84-4a59-b7d9-d02c0807cede@linaro.org>
Date: Tue, 20 Feb 2024 08:10:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/i386/q35: Include missing 'hw/acpi/acpi.h' header
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org
References: <20240219141412.71418-1-philmd@linaro.org>
 <20240219141412.71418-6-philmd@linaro.org> <ZdQSOiQiRxoEoR58@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZdQSOiQiRxoEoR58@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/2/24 03:45, Zhao Liu wrote:
> Hi Philippe,
> 
> On Mon, Feb 19, 2024 at 03:14:11PM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Mon, 19 Feb 2024 15:14:11 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH 5/5] hw/i386/q35: Include missing 'hw/acpi/acpi.h' header
>> X-Mailer: git-send-email 2.41.0
>>
>> "hw/acpi/acpi.h" is implicitly included.
>> Included it
> 
> I'm guessing it's an imperative and shouldn't be in passive form. ;-) So,
> 
> s/Included/Include/
> 
>> explicitly to avoid when refactoring headers:
> 
> s/to avoid/to avoid the following error/

Oops, thanks :)

> 
>>
>> hw/i386/pc_q35.c:209:43: error: use of undeclared identifier 'ACPI_PM_PROP_ACPI_PCIHP_BRIDGE'
>>                                ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
>>                                ^
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/i386/pc_q35.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index d346fa3b1d..a91f414922 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -58,6 +58,7 @@
>>   #include "hw/hyperv/vmbus-bridge.h"
>>   #include "hw/mem/nvdimm.h"
>>   #include "hw/i386/acpi-build.h"
>> +#include "hw/acpi/acpi.h"
>>   #include "target/i386/cpu.h"
> 
> Here it is unordered, and similarly, does it need to be sorted
> alphabetically here?

It shouldn't hurt ;)


