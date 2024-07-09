Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DE3C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 23:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRKWo-0001dV-Tx; Tue, 09 Jul 2024 19:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRKWg-0001cf-Aa
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 19:45:38 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRKWd-0000nD-G6
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 19:45:36 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-78512d44a17so40821a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 16:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720568733; x=1721173533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KQaZd7/ToTQTfknQyH108kYtxpV7jnGAznBa3GIK6ks=;
 b=eVhGfshNQJ0AVSZ+Uqxd5M9vxOZfhtEBIo/iqBLqkME0loWBd4gEKZKGxGr+07dX4h
 innNGKG03Zx4up1jQzDiXOd0YZ5al3ogktYib8Iq76nQbA2eIsYHM0XSXWi0/oP38G/A
 jsVJJA61kury1bJEb59kbfJuDokT6fXcNv8Z8h0rInUQpabuksOwFpwSElqECzqeG5AZ
 OCtKnKQnOOOk4TVh0+ZiCxTj7JfVwFmr61xrt9j+RWiT4Ir4Ui8k8hbDJbAWJSL12xuy
 jngiMHc8O9Te8wNPMuCOwjw07Y9O6NlMgm5RoNCpuFIShQ/Yi8AJGIWSftgf7uD/1z8s
 Y7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720568733; x=1721173533;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KQaZd7/ToTQTfknQyH108kYtxpV7jnGAznBa3GIK6ks=;
 b=EoaWfDYlr5awfmPTv13QdCrqQ/BrEMToMk0uPHqDllUj+pti+6F370Y7i4xudBrRRb
 CqOEPxG1I3AdKJ8hWncFiPaz0e81ZT/R3mXXVVRQo9pyEEDH4uvSQIXKA1JzLiIyoFBo
 SPDNEl5UQiG15hERG1Dwo6JvJd792itcR1QP7LuRXe+XH7gJIgklhHf2/c/aFZM0JbCl
 muRiX04PgX1tSXcILlZ+Ic8LPWJ5sHLzMRoLEmJVSwaw0gEXayZfrpY0HNasb+163FPB
 jFlXihvCA7LihM4rDgBf1zoQe9HXkc657ecemnl4KJUyDZXPLKRXbSzcE4k2Ht9FNPT6
 Pniw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjRrvWY3GY/XV00PUJ8cNjAVdNmSwatDSVlDI09YCkPu4872Oxxc78ubr3nDViQJpD34SW6T3dxBUbWeY7Bq/cvwLxnhs=
X-Gm-Message-State: AOJu0YzJQClDAJtp9scCuqcJLVbOTw0S7qciYA/uzdfDjrpgkgE/Dv1u
 vv6Hl4fLQyRAgtB4WCuDQcDVgNFzj5h1ZG9B9nE3SUMvp/KkY7fI5Qnc0bgM3Gk=
X-Google-Smtp-Source: AGHT+IGC5YiDVR+rYJbDO4N5l2dMM24bUdW76+aL0lK0SCLXVo+F/VahoEkeh0J/i8+L/nVmo6UPoQ==
X-Received: by 2002:a05:6a20:2445:b0:1c2:8ece:97a8 with SMTP id
 adf61e73a8af0-1c29822d107mr4613542637.35.1720568732747; 
 Tue, 09 Jul 2024 16:45:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ca352c2acdsm2472041a91.38.2024.07.09.16.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 16:45:32 -0700 (PDT)
Message-ID: <5aa7be9d-1ce1-4448-97c4-fb0d5c4c0985@linaro.org>
Date: Tue, 9 Jul 2024 16:45:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Avocado 88.1 vs Python 3.12
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <6d22c5c5-cab0-49d3-88a8-3dd34c8c4938@linaro.org>
 <56ef21cc-f2e3-42df-a114-b7368c77253b@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <56ef21cc-f2e3-42df-a114-b7368c77253b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 7/9/24 09:26, Philippe Mathieu-Daudé wrote:
> On 9/7/24 17:41, Richard Henderson wrote:
>> Hi guys,
>>
>> I have reinstalled my development box to ubuntu 24 (because the Rust support is better 
>> than my previous install; ho hum).  I thought I had tested everything in a VM before 
>> committing, but I missed out on Avocado:
>>
>>>   AVOCADO Downloading avocado tests VM image for aarch64
>>> Failed to load plugin from module "avocado.plugins.list": ModuleNotFoundError("No 
>>> module named 'imp'") :
> 
> 
>> If I understand things correctly, the python "imp" package was deprecated, and has been 
>> removed before v3.12.  This is fixed in upstream avocado as of v93.  But we have a hard 
>> stop in pythondeps.toml at v92.
>>
>> Remind me what the blocker is to upgrading?
> 
> IIRC we're waiting for v2 of:
> https://lore.kernel.org/qemu-devel/20231208190911.102879-1-crosa@redhat.com/
> 
> 

Yes indeed.  There are two minor conflicts in rebasing this branch, but otherwise it 
works.  Cleber, do you have time to pick this up again?


r~

