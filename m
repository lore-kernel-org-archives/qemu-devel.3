Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5377C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 22:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seMJ4-0003j3-BM; Wed, 14 Aug 2024 18:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seMJ2-0003hq-Ec
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:17:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seMIz-0003kZ-Qg
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:17:24 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fdd6d81812so3704625ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723673840; x=1724278640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1hVfgHwuQrlv/c5qWfHl0seKMqpfR/kfZiiynF9diOk=;
 b=nr0Gp6HzqTeMbqbNo8I0AeuWLgolrw4mOCwdM6HHV8g4opGRztfA6qNfnFgg8ySULg
 hQF403WLDyKK6fpfpnK6Y+GBCOKqpsblgeLFTPr2+qkFULjih7nsgYGuixAoop+LW4X/
 R/0QZYMSQaWvWCSg55AXfdknJQfckeBIhInLs3PR77ucmCQXcx0sGdUyHZcHcdjpfU0/
 afwmWcbJ+8tglkPueM4xUfN2qiLUoFjCf0btge6C8+Z5wgu532CCR2bdaA3NILa/hGfS
 2j295XDumaHBJX/AJyihBTjq841gDKDfIHydELsym3QftJ/dU+d683flWRbI4cUcjVcF
 Vp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723673840; x=1724278640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1hVfgHwuQrlv/c5qWfHl0seKMqpfR/kfZiiynF9diOk=;
 b=HWQFVVjXsCAV7h7VVB0Lmivl34hUO10oBMu0Str3x/vYGwcep8CjI0oogfcJX69tSF
 bOp/IG9QNCw/Higu65RDpS3aLB4leG368F78h3uT6Q3Dk5HBX7ERSpuK+G1hyw3pLEF+
 230D6O/5XQ2YK2kvvTPsZ9UycVGyDNLCTKy/31aQN4bbH/gkB0WBLF9E5ETEt7zqRlV/
 vOSiu3NbF/X3x/K4cGKPD8b5r58vQTq27CAtxobbcfhUNPFGFfagNZMZMnD0KDVZbHku
 x1/F6Hga6STAaHVtu5vOer5j7FPtHml3ei78oeBp88+uaw3TLM4gfyMzltAU3pApisKZ
 CSrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp6L98IypCtLrpbPvv0ksrU2Xq5p22Ram/DZKWU5ZnkfhXpDkb2ghA/wbscHqkbgmuJgDY+KW1QnR4eDnrO5vp4vguqPc=
X-Gm-Message-State: AOJu0YxBPt3FVBLVULnluTkKG/6H+Og8ldfM37vU73R3br48IlymIGg9
 2mEj3i0zPBb4G8hLMRa3lApBQv8lpm99gqZre/1JvgUJVwAFV30K6lk61DcfTKs=
X-Google-Smtp-Source: AGHT+IESj4ZgVklYp4AsWOTRQFSa63fWABCRP2l5zUTHhp4b0cttPc3QETy2yQxB3IBRROUXBjIbcA==
X-Received: by 2002:a17:902:c951:b0:1fb:57e7:5bb4 with SMTP id
 d9443c01a7336-201d643f146mr61475885ad.37.1723673839616; 
 Wed, 14 Aug 2024 15:17:19 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f03a3607sm1073135ad.250.2024.08.14.15.17.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 15:17:19 -0700 (PDT)
Message-ID: <c0e96c3a-37cf-47bf-b893-dbbfc878c90b@linaro.org>
Date: Thu, 15 Aug 2024 08:17:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 2/4] linux-user/mips: Select Octeon68XX CPU for
 Octeon binaries
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier
 <laurent@vivier.eu>, YunQiang Su <syq@debian.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?B?Sm9obmF0aGFuIEjhu691IFRyw60=?= <nhtri2003@gmail.com>
References: <20240814133928.6746-1-philmd@linaro.org>
 <20240814133928.6746-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240814133928.6746-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 8/14/24 23:39, Philippe Mathieu-Daudé wrote:
> The Octeon68XX CPU is available since commit 9a6046a655
> ("target/mips: introduce Cavium Octeon CPU model").
> 
> Cc: Pavel Dovgalyuk<Pavel.Dovgalyuk@ispras.ru>
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1722
> Reported-by: Johnathan Hữu Trí<nhtri2003@gmail.com>
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   linux-user/mips64/target_elf.h | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

