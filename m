Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07609C5B549
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 07:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNR3V-0002qz-9o; Fri, 06 Jun 2025 02:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uNR3T-0002px-2q
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uNR3R-0003MP-BT
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749193190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8C5TBCJwHwY36Xj9VQOxwa2yf2nZuqRSc98GM5TUFB0=;
 b=avRoHQJt3ND/bMmmjI7lToZEjYavYZcSlaxZOYDaDserhA4j8p0Rvbz75WTRQK9kvkLrJT
 rxYFlJ/k81QsHQAUqeer+kua0quzH4KXL/tA3E0+mGZrgijoXy9JlSz+dOfqqHSeHTf80v
 IMWX2/IrmxuJ3deAgMbbwb6rxzTTQPw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-4r387sCJMXKL663AGINzxw-1; Fri, 06 Jun 2025 02:59:48 -0400
X-MC-Unique: 4r387sCJMXKL663AGINzxw-1
X-Mimecast-MFC-AGG-ID: 4r387sCJMXKL663AGINzxw_1749193187
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-747cebffd4eso1535827b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 23:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749193187; x=1749797987;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8C5TBCJwHwY36Xj9VQOxwa2yf2nZuqRSc98GM5TUFB0=;
 b=Kr6DHkKYRZ+MmkzFfQS+OcT1QcXJpJeyBViuj9GLZ0HSwnsY32jTYs1iRK61fTAzYz
 yzXSi6hRiW9DZRXmeef2aHQ+ybkjg46Wy3AOPUS2rvu3LWPNLpkPqNCuzhL6CqVj1e6j
 5uXSDucvcxRNBpZENknrumXkSS2GUWB4t0R+sYHfV+A5XGf5f4whvw1pHEbddZD1OSC0
 0ksFncWLPpR9+ijwsOpjVLNbf53IXCF9PnfqjkbBvHnvrmkOJT6PvGPyOPuqf39/5/3I
 j/JqfnRgHD5b2J6iSHKBX5ibDF8Fci878mSHqKZiK0jwXy1cVLGb/vm+2kLwEEJoT2z6
 PMLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTV9qlwKlqBP3e7rkYHs0JXht/RQPeKTsd2hdEdPL/Q0o/czjfD3Otb2EwU/2PbvdX9r/b/VSH0D9e@nongnu.org
X-Gm-Message-State: AOJu0YyEoeQTOv/SChnbqBrNiyAGHyRRG4K63vwVU/72uzBxks7x7NzN
 jsLxFSBUU2c5pvDQz9cw/eLjeE4TczxnmdLk0At2zqKafTzHEi0Ct9V71zLkibySnXHuY6pHAQn
 aPaMbpV3xBOa2jjO8Zd9SUoumFsH6j8u50s3oEbt64urAy3E9TWLv2APz
X-Gm-Gg: ASbGncuRze0CxEFWQPuLSy4AWF+f+xCeItws60jQN8ftqn5pdKbX3pfTevheYeiDK96
 fqVyGfYWuVjS9EoVs/nlIclvYbo/x7C8gplIg8Y3TwNsaMWQEKe45S+O8poM+c6lfHeiz4tWanh
 g1XWZ1e8D4Ou9iNsFxzIm+Cs8LvTlZN9OtghCWNaWP4876tSgeLZ+P1LAYj2sBebvB606qNrzaw
 U3bXvW0f2HT9syismNW3aL4yFsL59sjEWu/qGeAWAU9AxmPHYHNXqi3vMErRrnuXdoS6R4Cy+gQ
 8uPfOq/X/AkwTDA=
X-Received: by 2002:a05:6a00:3d0f:b0:740:aa31:fe66 with SMTP id
 d2e1a72fcca58-74827e4e9bamr3543292b3a.4.1749193187373; 
 Thu, 05 Jun 2025 23:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/WSQrkF78RoLvthakUMZJRTrPo6mC9REhxpdCl5YEUGgHNrYufYodPdrBMAT4YYlem/8R2w==
X-Received: by 2002:a05:6a00:3d0f:b0:740:aa31:fe66 with SMTP id
 d2e1a72fcca58-74827e4e9bamr3543260b3a.4.1749193187041; 
 Thu, 05 Jun 2025 23:59:47 -0700 (PDT)
Received: from [10.72.116.52] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482af383f9sm664553b3a.25.2025.06.05.23.59.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 23:59:46 -0700 (PDT)
Message-ID: <618a4880-4bf5-43b6-afc7-8279fe2c080d@redhat.com>
Date: Fri, 6 Jun 2025 14:59:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ramfb: Add property to control if load the romfile
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <20250605030351.2056571-1-shahuang@redhat.com>
 <746b078e-bd06-4361-aec7-2301412abb18@linaro.org>
 <kep5frpl24d74evoyf367pqkyoj6xez2pirk7xlzcoompyzq4c@ouxab77sdm55>
 <2030db73-4f1e-46ed-98ea-c469e8b0ecea@redhat.com>
 <aEGsbkhdT_k5JErg@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <aEGsbkhdT_k5JErg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Daniel,

On 6/5/25 10:40 PM, Daniel P. Berrangé wrote:
> On Thu, Jun 05, 2025 at 04:24:07PM +0200, Cédric Le Goater wrote:
>> On 6/5/25 14:21, Gerd Hoffmann wrote:
>>>     Hi,
>>>
>>>>> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
>>>>> the x86 need the vgabios-ramfb.bin, this can cause that when use the
>>>>> release package on arm64 it can't find the vgabios-ramfb.bin.
>>>
>>>> Simpler to directly pass the ROM path instead of using a boolean,
>>>> so board (or CLI) could pass path to non-x86 rom.
>>>
>>> The rom is loaded into a fw_cfg file which only seabios will look at.
>>> So this rom logic is x86-specific.
>>>
>>> edk2 ships an EFI driver for ramfb, that is how ramfb is used on !x86
>>> platforms today, and I don't expect that to change.
>>
>> Should we also set the vfio-pci::ramfb-romfile property to false in
>> a compat property for ARM machines then ? I don't know for RISC-V and
>> PPC.
> 
> Sounds like we'd be better setting the property to false by default,
> and then special case x86 machine types to set it to true.

I want to do that setting the property to false by default, and only the 
x86 machine types to set it to true.

But I didn't find the similar things on x86 with the arm_virt_compat[] 
in the hw/arm/virt.c which can set the compat global in one arch.

Thanks,
Shaoqin

> 
> With regards,
> Daniel

-- 
Shaoqin


