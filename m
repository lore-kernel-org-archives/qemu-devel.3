Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2899DC27C52
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 00:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFNQS-0002PI-3H; Thu, 06 Jun 2024 20:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFNQQ-0002Ih-9X
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 20:25:46 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFNQO-0007CM-KK
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 20:25:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-703f1e39c07so1277354b3a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 17:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717719943; x=1718324743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iwCt8FATEIZBouRB9xiwPs35pZPCkv3qME1H+RwEG/E=;
 b=RS6YNtcEzqn/2cSxo4huxhYAQIW10As++S8IivA93N+oiu7O4gdayRO8WoE84LaUFt
 8+e2URNMEjlPMJkZ3yLwaibKXZpmYqtqyc/VQSa5aAoqMK+DWoFsLNBxKgAvM7yJLrnI
 zp2WMIH/AxISw90IuM53+hBDQcrAOzX7zVZvdedk3sPaViKoo32eSfR4ngdFBsIabhhm
 Y0yzPSo6zSD5ViBCMIus2XVRHKSQmP09sVts1z5tAEB0cI5mMclLNND8Glmv7PWUEEkG
 tDuwAwognfIZu9A7tMBVyv+rQa5eiiKkoAiNlAb0uguPsIevZDUGAVJzWsyMLBR60E0c
 9fEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717719943; x=1718324743;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iwCt8FATEIZBouRB9xiwPs35pZPCkv3qME1H+RwEG/E=;
 b=VdmqLGpWyLgUW8LZdVKJcqHfCHapTVju9wxzPq7Gk74x3fSmxym8dK+2ZV7zYgsGTI
 aC/+S6poA1mfU78qzSeC7CFlBIZ7XbueKCs30P66qp7e0THUzNGtrptm9OiUEWKg7X6e
 0/629AkETlgQEFSSp+lv696eKh05k8xGBpHmbBXRYMbh/x/0uRlI+Eu64leS0cCLxxYD
 0AV4r5DJc8fmcPmY/HWCG2VH1VR/b2fPTGasfI0SG/fsyibgTVFaH/uk7RjHyA2pZ24d
 cVqkGbE4KgxWFaPFWEVtUS8oM/AlF+jUyy4NYUT7B8E4Tm4Ms1nRBxD9YsXSP6lgRUNc
 NVyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmhdpVRPOB92DcQka4u6/ods6SKy1VbafdzmMUX1/WRWGj9J15qBglk/m0RKtFaQs4j7IzGNvs+BDWEIQoDL3e0ZcQZKY=
X-Gm-Message-State: AOJu0YyZ3SyHzCCr0iI/xckyFPEgeGJLqUONQU9DqaLqBB9x/ve1Qw4C
 2OBZ3BCH/ogy3KI0Rp051id49m2+VNWH0Niz2JS/UcilYQCEqTGCVm861xD10aE=
X-Google-Smtp-Source: AGHT+IGBCaL7u1vQo5CJvU03IqZyDYCNAAjZXKvbs1WHa/IY88UX26Ew833iJyzzAwGj2epEwaHLMQ==
X-Received: by 2002:a05:6a00:1409:b0:6f4:59cd:717 with SMTP id
 d2e1a72fcca58-7040c74d7e7mr1090967b3a.28.1717719943147; 
 Thu, 06 Jun 2024 17:25:43 -0700 (PDT)
Received: from [192.168.101.177] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd228784sm1657839b3a.0.2024.06.06.17.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 17:25:42 -0700 (PDT)
Message-ID: <cde14013-8852-4e11-8ea5-499940f0b807@linaro.org>
Date: Thu, 6 Jun 2024 17:25:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/2] util/bufferiszero: Add simd acceleration for
 loongarch64
To: maobibo <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
References: <20240605093213.2191929-1-maobibo@loongson.cn>
 <20240605093213.2191929-3-maobibo@loongson.cn>
 <5d78d82d-a939-4103-8411-507b1a0372ac@linaro.org>
 <7b4c6909-40e8-def7-03e8-18a3303295f1@loongson.cn>
 <58ba9ea7-cc45-47d4-a278-3777b496cb44@linaro.org>
 <d504ffbb-353a-452f-bfb1-2640ee1badc9@linaro.org>
 <da613eb1-65f8-b690-4517-04640581261b@loongson.cn>
 <5dc13c38-353b-4f17-97f3-fefd7f188570@linaro.org>
 <704a2aa4-8a78-8942-ba70-982c9155dfce@loongson.cn>
Content-Language: en-US
In-Reply-To: <704a2aa4-8a78-8942-ba70-982c9155dfce@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 6/5/24 21:00, maobibo wrote:
>> No, because the ifdef checks that the *compiler* is prepared to use LASX/LSX 
>> instructions itself without further checks.  There's no point in qemu checking further.
> By my understanding, currently compiler option is the same with all files, there is no 
> separate compiler option with single file or file function.
> 
> So if compiler is prepared to use LASX/LSX instructions itself, host hardware must support 
> LASX/LSX instructions, else there will be problem.

Correct.


> My main concern is that there is one hw machine which supports LSX, but no LASX, no KVM 
> neither.  QEMU binary maybe fails to run on such hw machine if it is compiled with LASX 
> option.

Yes, that would be a problem for packaging qemu for distribution.

An alternative is to write these functions in assembly.  While it's worth prioritizing 
implementation of __attribute__((target())) in the compilers, the very earliest that could 
happen is gcc 15.  Which is far away from being reliable for qemu.  It would also allow 
this optimization to happen with gcc 13, which doesn't support the builtins either.

I just sent a patch set along these lines.


r~

