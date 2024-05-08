Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E56C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 21:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4pGz-00089m-RW; Wed, 08 May 2024 17:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pGx-00089Z-ME
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:56:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pGv-0005wd-PT
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:56:23 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41b79451128so2237445e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715205380; x=1715810180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QGvdEy3sO2OUrF3alK2kh2fKOlKj4cjG5WVhYz4W+3U=;
 b=kA5zPtESHQ8hAHXSJqD1Ly1CMQpSqNlQfHmEXVC+NfDs2UTF9wI1L1eZLj1J50ht9y
 h/hocYT6yju1rFYri8xP5C8sgXIA2w7LwdU52tYDQKjLqAuoZQJOnf6A0NMM8d8ZythJ
 6C8R5n0qDlQCZhuYmu56MKJGV6hpLEni30Ih23L5tQlWYs/nWt/s7RaEHC8ahtK+gk3J
 J/VfgjDS+ZfwHCQ+BL0oHxBXscofReQ3uSYJcitkGLZhxkOBOA+3Ntb3xzAxcqmDXiVK
 Frv/wjv5+fg+HEwzmxu5E0DueSUWTapYLgKR5o7jp3U4AlU9QiZY7TzmDr4341rq4eFp
 aGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715205380; x=1715810180;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QGvdEy3sO2OUrF3alK2kh2fKOlKj4cjG5WVhYz4W+3U=;
 b=X0bDaWGnF2c4KYz5gC5YdGU37b4HoHd7xi5dBBrSiNMWSPK2IYDVsBwS1vWlNNi8w9
 VRDU5Sb+9SBZF9rw5BFpphaouPBRNICXkjDJdFB2SIRaCTQCwSI3vKdLK//BOlnxDGOx
 x2EKiFeq6Jc9SBeQKIe6P83soqRSxk6wzVJfZ179IJYrYDbXgClHGHOupyCgiLM4leNo
 7uc/R71YKUANkMWrfwK7Afnjhuh80Mvm6y235nJWeH0X/5mZv5bCarQ068frT2f9Guco
 zL3dL4IJqoCB/RvYtzy7HNUdk5P4yqMxIjZ8MsdgSR0UjhnJ8cHTTbqfGlmHESzuTsX6
 RRSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4YlXdZse597Ki7TTQlFz9yVQVq+Km76LIXGAYDjzFtuDaOaCh8uT1imqte0X9pzGHyn4TnKNQoMSFMWF2Zq4BHXGCiUU=
X-Gm-Message-State: AOJu0Yxfjc1wQ77HqtH/1mgGzKdX5Y7rGWKekZ3gi+HbQl/dib1jX4qy
 9hOZucvG2NnhfOXT7PjHm79QRiTrLencaNy7CxsE+KZl2WYcRLLKFjMM1jfCTds=
X-Google-Smtp-Source: AGHT+IH27qVkMtS5xqobD2sn0+nKbd1jOqQlKp1EsqPCigrcLhTyCvPhr8vxegKKgFLyM+4+vyf2AQ==
X-Received: by 2002:a05:600c:35c3:b0:41e:c9ad:c729 with SMTP id
 5b1f17b1804b1-41f721b0486mr28494315e9.28.1715205379916; 
 Wed, 08 May 2024 14:56:19 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d2ecsm5807566b.16.2024.05.08.14.56.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 14:56:19 -0700 (PDT)
Message-ID: <bbc97d72-fdc3-4a9b-ac7a-99810b2a6538@linaro.org>
Date: Wed, 8 May 2024 23:56:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/mips/loongson3_virt: Emulate suspend function
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Eric Blake <eblake@redhat.com>
References: <20240508-loongson3v-suspend-v1-1-186725524a39@flygoat.com>
 <30ac6d1d-6bda-473b-b212-25443efcde03@linaro.org>
 <37a227ca-af03-4f03-b135-b12ea2ef521a@linaro.org>
 <145ab58d-eb3b-4671-afc6-b0b556dba936@app.fastmail.com>
 <64758a2f-87f9-4bd1-a85b-51055592aab1@linaro.org>
Content-Language: en-US
In-Reply-To: <64758a2f-87f9-4bd1-a85b-51055592aab1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/5/24 23:54, Philippe Mathieu-Daudé wrote:
> On 8/5/24 19:28, Jiaxun Yang wrote:
>> 在2024年5月8日五月 下午5:48，Philippe Mathieu-Daudé写道：
>>> On 8/5/24 17:35, Philippe Mathieu-Daudé wrote:
>>>> On 8/5/24 11:31, Jiaxun Yang wrote:
>>>>> Suspend function is emulated as what hardware actually do.
>>>>> Doorbell register fields are updates to include suspend value,
>>>>> suspend vector is encoded in firmware blob and fw_cfg is updated
>>>>> to include S3 bits as what x86 did.
>>>>>
>>>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>>> ---
>>>>>    hw/mips/loongson3_bootp.c |  1 +
>>>>>    hw/mips/loongson3_virt.c  | 19 +++++++++++++++++++
>>>>>    2 files changed, 20 insertions(+)
>>>>
>>>> Thanks, patch queued.
>>>
>>> Fixed:
>>>
>>> ERROR: use g_memdup2() instead of unsafe g_memdup()
>>> #76: FILE: hw/mips/loongson3_virt.c:293:
>>> +    fw_cfg_add_file(fw_cfg, "etc/system-states", g_memdup(suspend, 
>>> 6), 6);
>>
>> Thanks, I omitted this one as it is copied from hw/acpi/core.c
>>
>> Should we fix that one as well?
> 
> Sadly for me I did the cleanup 3 years ago:
> https://lore.kernel.org/qemu-devel/20210903110702.588291-10-philmd@redhat.com/
> but neglected to address the comment from Eric:
> https://lore.kernel.org/qemu-devel/20210903211057.kvn6r5pvx7iuwf5a@redhat.com/
> so the patch never got merged. I might revisit...

That said it is recommended to run checkpatch.pl before posting a patch:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#use-the-qemu-coding-style
This can be automatized, see "Automate a checkpatch run on commit" in
this chapter :)


