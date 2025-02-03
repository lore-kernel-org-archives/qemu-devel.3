Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CF5C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 12:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tevWY-0007s3-9k; Mon, 03 Feb 2025 07:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tevWU-0007rV-LI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:25:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tevWS-0003uX-Tj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738585551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F/Ei73A+R34BFsMMKcXQPqaoUG3WdnAb8QGSbItsb78=;
 b=jRc7MqCv8FU1XQ3SDZ7BW4rHiF+YlZI2DY4Eoa0fR6BlCydTGtbfaG9XVJD81npSzZsPul
 bDqzXh3J/ossmdzY+SI5uAwo0T2GLXQhVBO6pDA8SZBQnX3x4bkFWSMnGf2mKoOYZRFGKl
 m77la3KjSXREC9tujY25eMJ/6DaLVfE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-YMzLMp5VM76ArfMdZ1q1Yw-1; Mon, 03 Feb 2025 07:25:48 -0500
X-MC-Unique: YMzLMp5VM76ArfMdZ1q1Yw-1
X-Mimecast-MFC-AGG-ID: YMzLMp5VM76ArfMdZ1q1Yw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43623bf2a83so34883695e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 04:25:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738585547; x=1739190347;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F/Ei73A+R34BFsMMKcXQPqaoUG3WdnAb8QGSbItsb78=;
 b=aTnYx4GWj6XnRfVxai28SAPHYeEpHQXRlzioSDcYdn2WEdgvisIyIQt54oKDIBtBRy
 1wdCExYeXa1krgazqOeRchwBfni2M9bkkvXCZJTdDcp6+E4uC9wtDIdr4MJxrgBQbgCc
 XDC3X8FKnEmWlwOQhipaveiP0TYZp1j8fumjibvaG/Zd16/TWIQKzctcNiNDotkVNcLV
 LdLBVx3g8J9sdFVIWA4bStrxnSnD//OIb9CIzrWyoL6CiVHacA1bHzwlMqavna2FJ6hd
 CYk23hghl3hQmeQpcjIKHkRBmT8oBg6GL5TH5lJAewAh4LqmA8wMovT9OTuX8Q6oNzvS
 e9Dw==
X-Gm-Message-State: AOJu0Yz0xATAek4A7opCTU+RQdIsYU57ADlHUBdncidBkseQkFtOEYec
 ycb1m5FxJIduaimpR9DFNYi0AF2NAsA50Sw6MAamm2UU2eYzt6Sfz4Fw4udc0x+d6uIOIdxTr7h
 FhjXc8kZdu1XQoVg/QpB2sUaYPCNsyo3atklV8JgYevLygNao4XZs
X-Gm-Gg: ASbGncuvCqDDuZuC1nzWw8Z3jUP/AQHZo6vuhUU7bZjrUpvRkStc4Gcc8MxUHk+Jh7u
 ngztGDyo34EonZrcqXqn7ni2KKPjNpufB6KCJBr3UT5bZQTomqfWfnGLFTkJgjmI5+Td1ytO0/9
 5psVvdsjNi7a46f3+7nFbQ/ag8YnRnwyRx3DYfjNqpY6pSa/P5Zb/VjRuGKRPY45FfOsEZVajpU
 uSIHOaa00JR/0ES4X0SCw4bLJkCfefffPS1tLM7PFtISOrezGNK0JF1zXtbrlGxtDSIqKwvHj2W
 hp1Q8y/l5aHneB9EtyaL8nMA0UTPUA==
X-Received: by 2002:a5d:5846:0:b0:38a:2658:bbc7 with SMTP id
 ffacd0b85a97d-38c51b5f3d9mr17000432f8f.29.1738585546910; 
 Mon, 03 Feb 2025 04:25:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6oVFJbiU8kVhuBtV/m5CbhrYJL+EgRGxqg8CnQaxP/IbtJUpQKqjb1zj+dgJpJwLOuqkhOA==
X-Received: by 2002:a5d:5846:0:b0:38a:2658:bbc7 with SMTP id
 ffacd0b85a97d-38c51b5f3d9mr17000415f8f.29.1738585546566; 
 Mon, 03 Feb 2025 04:25:46 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ec78esm12439153f8f.3.2025.02.03.04.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 04:25:46 -0800 (PST)
Message-ID: <746a84a4-2703-45b3-bd79-5b31660b8c38@redhat.com>
Date: Mon, 3 Feb 2025 13:25:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add a ppc sam460ex test
To: BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250203092606.491933-1-clg@redhat.com>
 <bd96e71e-c516-6a09-ba7b-904809c17c84@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <bd96e71e-c516-6a09-ba7b-904809c17c84@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 03/02/2025 12.29, BALATON Zoltan wrote:
> On Mon, 3 Feb 2025, Cédric Le Goater wrote:
>> The test sequence boots from kernel a sam460ex machine with a
>> virtio-net device to check PCI.
>>
>> The buildroot is built with config :
>>
>>  BR2_powerpc=y
>>  BR2_powerpc_440fp=y
>>
>> and the kernel with the '44x/canyonlands' deconfig and virtio support.
>>
>> Cc: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> MAINTAINERS                           |  1 +
>> tests/functional/meson.build          |  1 +
>> tests/functional/test_ppc_sam460ex.py | 38 +++++++++++++++++++++++++++
>> 3 files changed, 40 insertions(+)
>> create mode 100644 tests/functional/test_ppc_sam460ex.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8d30c5bafd87..e4ab6031511b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1555,6 +1555,7 @@ F: pc-bios/canyonlands.dt[sb]
>> F: pc-bios/u-boot-sam460ex-20100605.bin
>> F: roms/u-boot-sam460ex
>> F: docs/system/ppc/amigang.rst
>> +F: tests/functional/test_ppc_sam460ex.py
>>
>> pegasos2
>> M: BALATON Zoltan <balaton@eik.bme.hu>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 868f4a64b60b..6a5f1dc405cb 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -193,6 +193,7 @@ tests_ppc_system_thorough = [
>>   'ppc_40p',
>>   'ppc_amiga',
>>   'ppc_bamboo',
>> +  'ppc_sam460ex',
> 
> Instead of adding a new file this could be within ppc_amiga which was meant 
> to be a place for all AmigaNG boards but only has amigaone for now. Unless 
> there's a good reason for it to be separate due to how tests work that I'm 
> not aware of.

Tests that are in separate files can later be run in parallel, so I think it 
makes sense to keep this in a separate file.

  Thomas


