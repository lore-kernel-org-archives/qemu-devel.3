Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67694C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 13:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOzs0-0003g9-7U; Wed, 03 Jul 2024 09:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOzry-0003fe-JW
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:17:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOzrv-00027W-TO
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:17:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42562fde108so38507835e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720012672; x=1720617472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8UDK0RhQ6+rp4+e5mvOryc0BFJtIxtnEzt49uLM60zI=;
 b=bqiHCXZJd/lXEbJAbaj3QbQH1jcPJONO35MA+Mdp6mljNBjQJwvhWEZtWyRHojeHK0
 T1yK5ZdZkGKEEtt6T0SKygAzM/n95L2z2VxmlFnH562LS/REimDQxftw0Q5Z7lNL86S5
 EAQC1PruReUHOnhjMEzYQhlfpY7ZJPTWcaWjfiRxUCmJIAy0MoThQA76sgR6LaoVx+h+
 oGgaUzmaVUbOv52rVEy1Ty15ho2wOLMOGO5OmO0QpW7aoH+kSdoIWyw6eeYL3FhOkouX
 H03ie8FgeIwRERveDQzTThKgUS1sKNwuSzw5oAMuCKylraGQouOxqIK1g2+yf+fKQ81d
 dD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720012672; x=1720617472;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8UDK0RhQ6+rp4+e5mvOryc0BFJtIxtnEzt49uLM60zI=;
 b=CRdMiYQX1OBzzOavPKEDcvr8hWQNgJq1mKf4CFVO2bONV30yI5/y+6vT/vNS6Bb28T
 lC1aI5Cs8WEaIolx6e+OmFMSQA8rSvhximsx91crG4/9pVTYGOWZIcrqgN/fWZ2HUBJC
 45vRun+ZJLOBMNzcF+NMoFA58AOuLrzmil+B6lKYNrBzyuJRjdK9d7Dm9zmEMUdnSwv1
 kaFiAMUW1rR4WIm0QVSmZuT4TI2o77R+QlwJQ74MiwZmAfT6+4kbprB+C9rVRDJX1zku
 HFLvz0s9oBU1qbefm+Rb7DmfCfti9LxxtwSeh3Y4AmpRPvqQCO+4/Vygj3dk++es3SRa
 1rVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUscCdcpuLtp5L/PmWhScjWrsncB1GLpjlL8uvcLggp3Xr9oEUX1Hu8qcD/Fu4/yQuUwOlAKx9GNezfUuOLFiTg8vknOoY=
X-Gm-Message-State: AOJu0YwSaKILhgpwRGhL+X8iJQfVPAYdtFdGHHJwIv40VP6jzsiD1m02
 F1hNhw1xhu8Qf5Pz68PWxjBHNN4RpLZSRk18OR/nd723764QyLhBlTDPEz7WqcU=
X-Google-Smtp-Source: AGHT+IH9Jmc2A1ELTCjVdFx+VsKig4UMDu4fVgUwLTVEIv3K+Vt9ZWQOEioKQilfn8MsrgBuXReEbA==
X-Received: by 2002:a05:600c:4f93:b0:424:acb4:2798 with SMTP id
 5b1f17b1804b1-4257a02b908mr74189035e9.7.1720012671882; 
 Wed, 03 Jul 2024 06:17:51 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a073sm239004815e9.32.2024.07.03.06.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 06:17:51 -0700 (PDT)
Message-ID: <32a4bff3-2148-4a3e-b60b-20eb76d86b63@linaro.org>
Date: Wed, 3 Jul 2024 15:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v45 3/3] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?C_=C3=A9_dric_Le_Goater?=
 <clg@kaod.org>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Luc Michel <luc.michel@amd.com>
References: <20240703085907.66775-1-philmd@linaro.org>
 <20240703085907.66775-4-philmd@linaro.org> <g1ry6.dru2gk6m73t@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <g1ry6.dru2gk6m73t@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 3/7/24 14:24, Manos Pitsidianakis wrote:
> On Wed, 03 Jul 2024 11:59, Philippe Mathieu-Daudé <philmd@linaro.org> 
> wrote:
>> "General command" (GEN_CMD, CMD56) is described as:
>>
>>  GEN_CMD is the same as the single block read or write
>>  commands (CMD24 or CMD17). The difference is that [...]
>>  the data block is not a memory payload data but has a
>>  vendor specific format and meaning.
>>
>> Thus this block must not be stored overwriting data block
>> on underlying storage drive. Keep it in a dedicated
>> 'vendor_data[]' array.
>>
> 
> 
> I am reading the 4.3 spec, and it says:
> 
>   The bus transaction of the GEN_CMD is the same as the single block 
>   read or write commands (CMD24 or CMD17). The difference is that the 
>   argument denotes the direction of the data transfer (rather than the 
>   address) and the data block is not a memory payload data but has a 
>   vendor specific format and meaning.
> 
> The vendor here (qemu) does not support any functionality with CMD56. I 
> think the correct approach would be to read zeros and discard writes, 
> without storing anything and without changing data_offset (which is for 
> `data` buffer)
> 
> What do you think?

As Luc suggested in v42. Indeed simpler thus clever.

>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> v43: Do not re-use VMSTATE_UNUSED_V (danpb)
>> v44: Use subsection (Luc)
>> v45: Remove APP_READ_BLOCK/APP_WRITE_BLOCK macros
>> ---
>> hw/sd/sd.c | 29 +++++++++++++++++++----------
>> 1 file changed, 19 insertions(+), 10 deletions(-)


