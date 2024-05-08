Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B5AC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 21:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4pFW-0007JX-57; Wed, 08 May 2024 17:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pFU-0007Iq-Mp
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:54:52 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pFS-00057q-DD
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:54:52 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-573137ba8d7so2510713a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715205288; x=1715810088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7/+DRBt5r8kPcwIBPiWP3d/qoEaI/o03lyeoKzijgpg=;
 b=ZlKJWpugI6f4YtJrAjCfisa30sz6jI/uCwlGrrCquYn9VQOoivvZbyoyy50nMfJUKW
 J+6HPvUMSyHV3vmSXXP6DYcYVFNlNSoj8YoW91S3zmNz5BvVzsoW65PrN5MFaslMUfK7
 e661xFtmJoIiVX2J9iWgrGq3zFXWNq8v5FWEX4R6ZVORzQvUD1oUodeb5EU/su2PBu80
 6DkRVgh9dnyUiWqhRY1ogErBP/27CcaKhFOY3x/Yr7eckVIgzpaQUwCY1APZEaKUlf8p
 rQ5PDm8uYXzm6gJWvqK4ZRb8GOGLxCQwYRDtjLb7oMYM99qCvIdHYLoOeuRulPsWJcnD
 xzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715205288; x=1715810088;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7/+DRBt5r8kPcwIBPiWP3d/qoEaI/o03lyeoKzijgpg=;
 b=GQvQReoNodcPKnrYhwIyvSLfl/0Jo9BWQfkWMf1b2cgh7KR/GkgIUfihYcgodf0kl0
 G18ZTfq2mHy/wWv70bXoZgSvdYVlem6Vro3/8dFMWo/3j8cCJlbqvVSxy2DhcV1Jy3/s
 tnkeyd9wCsaSEpQGg39JX9LaMsBP+ewPSt+qSv8yzdQfAyDt5/gLuSDIvylm0YbfDLcp
 /N3GzrhjCH7L3AEBKAg6Soxe15wQhB3D2sV1NzA6E7B0Y3CNGOSBODCvjIXlYG/Tg4WN
 mpinvQxF4UhzLoQZAJcuW0YebfVsSwfLbhO2ct7PTCNqNRzkt3YJBMERvDD9jLHelRTy
 ylYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBpsyW2E13cKZ7/7txODJ0bbsMVArY+UuWZuxr3RNE5esbhmX1xvJF7F3uzVGZ/I2ucaNSpVof8oDCPqp9bKj681vfhBA=
X-Gm-Message-State: AOJu0Yz1oIUU4z0fvtN4/GrfuRoVrogZ2Kn/Cpz1CsBuMnV7ejb0pXW+
 dFs9lqITGQCuSBoTX23ZKCECpnb9pQ8xgMClWZrm0sWk6+Etu0YJteN/JG4UOnY=
X-Google-Smtp-Source: AGHT+IGs9iIMqPv4x0m+Wo2Xg+Lf00m8fuLRy0Z+6R0rMO1gu9SI1WaHYgDpO8Za7KzyvsyPaWWoyA==
X-Received: by 2002:a17:907:7ea1:b0:a59:c698:41ae with SMTP id
 a640c23a62f3a-a5a1180eb0cmr80297966b.34.1715205288044; 
 Wed, 08 May 2024 14:54:48 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b01948sm4898766b.175.2024.05.08.14.54.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 14:54:47 -0700 (PDT)
Message-ID: <64758a2f-87f9-4bd1-a85b-51055592aab1@linaro.org>
Date: Wed, 8 May 2024 23:54:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/mips/loongson3_virt: Emulate suspend function
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Eric Blake <eblake@redhat.com>
References: <20240508-loongson3v-suspend-v1-1-186725524a39@flygoat.com>
 <30ac6d1d-6bda-473b-b212-25443efcde03@linaro.org>
 <37a227ca-af03-4f03-b135-b12ea2ef521a@linaro.org>
 <145ab58d-eb3b-4671-afc6-b0b556dba936@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <145ab58d-eb3b-4671-afc6-b0b556dba936@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 8/5/24 19:28, Jiaxun Yang wrote:
> 在2024年5月8日五月 下午5:48，Philippe Mathieu-Daudé写道：
>> On 8/5/24 17:35, Philippe Mathieu-Daudé wrote:
>>> On 8/5/24 11:31, Jiaxun Yang wrote:
>>>> Suspend function is emulated as what hardware actually do.
>>>> Doorbell register fields are updates to include suspend value,
>>>> suspend vector is encoded in firmware blob and fw_cfg is updated
>>>> to include S3 bits as what x86 did.
>>>>
>>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>> ---
>>>>    hw/mips/loongson3_bootp.c |  1 +
>>>>    hw/mips/loongson3_virt.c  | 19 +++++++++++++++++++
>>>>    2 files changed, 20 insertions(+)
>>>
>>> Thanks, patch queued.
>>
>> Fixed:
>>
>> ERROR: use g_memdup2() instead of unsafe g_memdup()
>> #76: FILE: hw/mips/loongson3_virt.c:293:
>> +    fw_cfg_add_file(fw_cfg, "etc/system-states", g_memdup(suspend, 6), 6);
> 
> Thanks, I omitted this one as it is copied from hw/acpi/core.c
> 
> Should we fix that one as well?

Sadly for me I did the cleanup 3 years ago:
https://lore.kernel.org/qemu-devel/20210903110702.588291-10-philmd@redhat.com/
but neglected to address the comment from Eric:
https://lore.kernel.org/qemu-devel/20210903211057.kvn6r5pvx7iuwf5a@redhat.com/
so the patch never got merged. I might revisit...

