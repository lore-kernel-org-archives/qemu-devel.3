Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8C1C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 01:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru0k3-0007OD-4P; Mon, 08 Apr 2024 21:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1ru0k2-0007Nt-2z
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 21:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1ru0k0-00051X-E7
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 21:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712627859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+42ipXqwQuXXtOk9qA2zLETHrzi/w24r5QbQrZ73KA=;
 b=R9lw45KTP9G01Khm5EE/FGn33cP2nwmvZTx5/o67yaRyfD1in7h27pSvbP3DHCgSTOfR+S
 FbMMqAvrlB+aX8uGfZlYaHOWs46DPaUeyj32bB1MFNl7XfatbvhJJaSwKLCw0yxXgLXyOv
 3PnrPVWCT7/IGwe/v4fSw3xfZ3rs/lQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-68kW_huDP1mwrkUKhkLn-A-1; Mon, 08 Apr 2024 21:57:37 -0400
X-MC-Unique: 68kW_huDP1mwrkUKhkLn-A-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6dea8b7e74aso1729960a34.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 18:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712627857; x=1713232657;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K+42ipXqwQuXXtOk9qA2zLETHrzi/w24r5QbQrZ73KA=;
 b=ebe5QHWk8ssSx+yK8WtKtmp/WEwpHwZxtdsi3EXF+WStiRs3xOtnM9PzEqgBkAJv4H
 uphB0SMYMkqkicqaNdJU0wwKIyVARWr9JNBgQ00skGXDK5bdG8uByT+RTbUBfWTRgKNK
 ZKii6nt43HOtmcp8zUSEU+uKp5JdrDCB8rg1YTz1yj43vYwq2nNNbDsEy8RWSN5JSr8u
 YVoLgRkvSXjUFx4nsn1hQoktg4LUFamMBMYZxoRUZfIQy3BER8QD2IWjs76ChQ/h9Vzk
 9vB04zMDE2u/wMYWJhAfnMFa7Lwy3S0A/Qj7b5eIABmGPb+VnQLJrfCocpz/TwxREfYu
 0esQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE4quqV5CSavrYnlQFIKSPoRC1zqLaQu6hird97/LjWCkbH6SvBsnss7jAPfIxxU8mQQyrs0ZNbVaEim47Z7ACaOZhARc=
X-Gm-Message-State: AOJu0YyI8lVGkgocnx3r2WS5tAJKziD5b2KyYb9RBAMWyVQ1OAmTu5wc
 uOoYimsoQl5RQtb54yYkLszdf+2rNzQRbImXo9XWYXMyo0R7OxP+F0v+OHKw7+ieaQfqqvGwmQ1
 E3zgWTcqf9A6to8S1y2BabvUO5B5CH0nk1oLZZtwxQAL+h0Xa2tQH
X-Received: by 2002:a05:6808:14d3:b0:3c5:faa0:64e1 with SMTP id
 f19-20020a05680814d300b003c5faa064e1mr3185258oiw.3.1712627856925; 
 Mon, 08 Apr 2024 18:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/4hjB9Vw0FZ2lQiXGy5RJzIJEi3y4S5CmqMnkf5vCjTyPVG1q1+Bfo7KNEjtFTSPbTFaoMQ==
X-Received: by 2002:a05:6808:14d3:b0:3c5:faa0:64e1 with SMTP id
 f19-20020a05680814d300b003c5faa064e1mr3185243oiw.3.1712627856647; 
 Mon, 08 Apr 2024 18:57:36 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 s129-20020a625e87000000b006ecf6417a9bsm7505819pfb.29.2024.04.08.18.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 18:57:36 -0700 (PDT)
Message-ID: <823e1cdc-1db3-4caa-8864-6eaead31da31@redhat.com>
Date: Tue, 9 Apr 2024 09:57:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, armbru@redhat.com
References: <20240312074849.71475-1-shahuang@redhat.com>
 <Zf2bbcpWYMWKZpNy@redhat.com>
 <1881554f-9183-4e01-8cda-0934f7829abf@redhat.com>
 <ZgE71v8uGDNihQ5H@redhat.com>
 <46f0c5ab-dee7-4cd4-844d-c418818e187c@redhat.com>
 <ZgwBvuCrTwKmA0IK@redhat.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <ZgwBvuCrTwKmA0IK@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Kevin,

On 4/2/24 21:01, Kevin Wolf wrote:
>> Maybe I'm wrong. So I want to double check with if the -cpu option
>> support json format nowadays?
> As far as I can see, -cpu doesn't support JSON yet. But even if it did,
> your command line would be invalid because the 'host,' part isn't JSON.
> 

Thanks for answering my question. I guess I should still keep the 
current implementation, and to transform the property in the future when 
the -cpu option support JSON format.

Thanks,
Shaoqin

>> If the -cpu option doesn't support json format, how I can use the QAPI
>> for kvm-pmu-filter property?
> This would probably mean QAPIfying all CPUs first, which sounds like a
> major effort.

-- 
Shaoqin


