Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CEEC36011
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 16:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txpse-0006Gx-IY; Thu, 27 Mar 2025 12:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txpsc-0006GQ-LI
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 12:14:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txpsa-0002gx-Ih
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 12:14:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3913cf69784so861498f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743092091; x=1743696891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7VvvJItbrsPc15D2fUJevR4Fujmck9LQcS5osmhSGio=;
 b=XLqq9fBef/bwcVynhULDr+L/SGMzFOHVNcnro2tVR+ucDYejdZKQ9VW8uOeLn82CDb
 pbiQGqiQmKQqJfM3sALRo0sI1EoFNBBz9inXRcbWxARUDr3ZW72zoZ2ZeunamjMoCIo9
 O7N4+mdPCw15btfSVC6sakyngF240dcpRtt2uJSNWRawJoUTUNqDa56JsVvWAPAWRWqS
 Th3Xd9/r65Lv5Oy7QCd+6czBzfAmZ03OlMSYv3M6YrVajquVpTQfTVpE+XkQrnZ4iA42
 +KLqU9sMgTJEm3TM9dLfOGTbNnWpkWfp9cTzZI7m7Mgrh8xPENCAeJjyL9IQexCH/Mm+
 mvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743092091; x=1743696891;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7VvvJItbrsPc15D2fUJevR4Fujmck9LQcS5osmhSGio=;
 b=ms0+wb9vnoDQyjdyO2ZIAB5aBvZousSO8wSYSPTsULxgPPeLMk5PqeRDRN7UYYarq4
 ZPek64NYd9YXwNhbfxnNqibjbjqvDqX7LfuZjb8RlwKEbuTgoFDXU0wAQ0FKs/j2S3mD
 +XRmC8SvQEmM344eRBSQYvoEs6CWhkYfxTphh+ymjS/602U1FDXx7K/kd9btngSBGYlR
 vRTv1A1ebXGkrfpjuYXRvlmgJc6KAAHu7YazdGX9o325fFNr/8dBYwhfqicslczwv8MJ
 fVI/DQQEcIlmsFgA71CkwKfZcqZJhxvX5Pi6jlg2zGxCyU9UxjSTSz6Y+dI0D0tpvYMh
 xiog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtv8dGBcjN8I6XpJee6LXjFfnIHPuzBfe39ubXQKXnS85N+HsyTDBZCqLl29CfxG6/JfcmoOfqZg9X@nongnu.org
X-Gm-Message-State: AOJu0Yzut1tQCCyQAFkEuGn28GQw15sKdG1dCNGCUe7EusDAEeCqNdD0
 XbDurDYYpljZEhwYX2zSCrW1CJq4ISabBoMbVESRgxk6xkDCBvLwy09Amr+1LS8=
X-Gm-Gg: ASbGncv0BiEJ7xFjsLleo6gRsLkDqwNJEzApuVgvAm3Ui9Gn1hRsv1UfVZ6DqaQ5SMI
 mdGBTwLLOqFY5hb9yyPKhJ7AFL9gaMoxj8uUWHedVYORJzuLjVDq+BadKAHxCsCgy+sDHJJXXGp
 XEDZgt2E2+1ROV3SHgJTc932xRSnkXEFIFzupFv0f/pTIeZke6Kala7P/13smVTcwGsKQenKg+q
 W2ax9Pf0kD/CgrVPUigZ73q1jnXan/AM44VHSfK675wb/MAZiwrmw7iMb+nn+Yw0YXkmGjYN/YZ
 Hgvac07vANYJfkbrIcGRVQ1AKG9UkfZGMhceQAoA+jxwTRQR0ALyu2s3cuEfPegqNAAWWrcrbL6
 wos28QqVjhArx
X-Google-Smtp-Source: AGHT+IGfROHAwUGt673Yn3ssciFM362VMe1sVHCS+2aBd7/5AtbOyh05amk4CsHVKyfQcbxmYEXhpg==
X-Received: by 2002:a5d:5989:0:b0:391:47d8:de23 with SMTP id
 ffacd0b85a97d-39ad175bcacmr4235450f8f.31.1743092090829; 
 Thu, 27 Mar 2025 09:14:50 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9957c3sm20848681f8f.18.2025.03.27.09.14.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 09:14:50 -0700 (PDT)
Message-ID: <cbbf1715-5393-47e2-aade-f05144299ed9@linaro.org>
Date: Thu, 27 Mar 2025 17:14:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1] hw/riscv: do not mark any machine as default
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250327130256.653357-1-dbarboza@ventanamicro.com>
 <19d7409d-35a0-486f-a626-9d382fb8a6bf@linaro.org>
Content-Language: en-US
In-Reply-To: <19d7409d-35a0-486f-a626-9d382fb8a6bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 27/3/25 17:14, Philippe Mathieu-Daudé wrote:
> On 27/3/25 14:02, Daniel Henrique Barboza wrote:
>> Commit 5b4beba124 ("RISC-V Spike Machines") added the Spike machine and
>> made it default for qemu-system-riscv32/64. It was the first RISC-V
>> machine added in QEMU so setting it as default was sensible.
>>
>> Today we have 7 risc64 and 6 riscv32 machines and having 'spike' as
>> default machine is not intuitive. For example, [1] is a bug that was
>> opened with the 'virt' board in mind, but given that the user didn't
>> pass a '-machine' option, the user was using 'spike' without knowing.
>>
>> The QEMU archs that defines a default machine usually defines it as the
>> most used machine, e.g. PowerPC uses 'pseries' as default. So in theory
>> we could change the default to the 'virt' machine, but that would make
>> existing command lines that don't specify a machine option to act
>> weird: they would silently use 'virt' instead of 'spike'.
>>
>> Being explicit in the command line is desirable when we have a handful
>> of boards available, so remove the default machine setting from RISC-V
>> and make it obligatory to specify the board.
>>
>> After this patch we'll throw an error if no machine is specified:
>>
>> $ ./build/qemu-system-riscv64 --nographic qemu-system-riscv64: No
>> machine specified, and there is no default Use -machine help to list
>> supported machines
>>
>> 'spike' users that aren't specifying their machines in the command line
>> will be impacted and will need to add '-M spike' in their scripts.
>>
>> [1] https://gitlab.com/qemu-project/qemu/-/issues/2467
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   hw/riscv/spike.c | 1 -
>>   1 file changed, 1 deletion(-)
> 
> I'm in favor of this change, which I believe is the correct way to
> go, so:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> but I'd rather we follow the deprecation process. Up to the maintainer.

And if we deprecate, the deprecation patch is OK to be merged for 10.0.


