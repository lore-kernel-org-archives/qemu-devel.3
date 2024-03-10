Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEB0C54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 10:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjGFo-0005jN-7i; Sun, 10 Mar 2024 06:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjGFk-0005iG-4h
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 06:18:00 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjGFh-0006WF-FI
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 06:17:59 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e64a9df6c3so2826065b3a.3
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 03:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710065874; x=1710670674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=azdffTNh6udvmP3cv3bOT+TTLL69mPC4GDh7DQC14+A=;
 b=iqDug+rah4G5gzt8HUEDpGdSxEaXFDLUKydYpDYt3cA8TJyU09Gpkt8p4j/bRFOtCZ
 6+Kw514Z/iAlGuAc41Z6H0deW9F2IPR/5sll7xGlYTaG3Iz8VM8+lz7z43w76/Unmgyx
 BUXx519ZZX+ZwIQBF9Qt9hsiHJGZ7pBvtV3OMQqFuGNJA+t/yTYxaLtAIPRIeI0Totrm
 rW4kHDz03gKxy3x+0SSjI9IA2nk5DItEMn7pUzEFw8hcumbQk6aPNDw+hvIHnU6djvaQ
 T8Ec48TMbj0A+aqFQMsW8XiXxKfhnYKd03OPuNe+a3peJz9VMSnUeaYHgJ/Q2OMRIDDS
 g5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710065874; x=1710670674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=azdffTNh6udvmP3cv3bOT+TTLL69mPC4GDh7DQC14+A=;
 b=KXxZFHdzAoCjWwHkHEnh+zsFunHrSmutEmZkdodtM6utTxBpKJTE2RDAikwtO8oWSt
 5kmR9iDSJgX8FUd9er2nWpUe7npPeEJtOCfCwtlgcFgY+LOz/PKZNkGyNfctXm0JjhTb
 zKKDZNgREqfCulNuIoN/OpVO1Jt10YK79btVYc0s8LTIcVOpfZThCBc8k6sBEPj/3ovG
 /m5vdq39G8awYMDgrZ7vOA+UBTYu1OB2uOBIKElkuaDcYN9ESolJ16QtEzgCc3d9108z
 pIJxpfH/rX90bSsARPS44z4rtAMFeC1J1ZLWH3gNqQH25HRk37wyuIVYuLMmgS7KKwhe
 PR5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpuT6HDrWio/7mLLC8EOlq6P8DRDextrP0VRq/WaLpk0D7FsW3y5k2AFjom4gDLQDFN1H65sM+4SDozrmoQTytV38bDYw=
X-Gm-Message-State: AOJu0Yzb8gqQwSTubhvBZHVANY8Bhtqb6PvG+4C1zpsF/AC03Rgva/D/
 5lest0aedWMZE4d+SoE26JFPo2tjK45zn+1ixO5trUnKfOnFcJRoy4j2qrx4oSw=
X-Google-Smtp-Source: AGHT+IG5e6rELQTRHMxIqKsCJQlM0w+o+pmxQ8+0eWVF8j7Dz2PAVkpQggFvSV8w0ELOe4UBQ1Z7Rw==
X-Received: by 2002:a05:6a00:98e:b0:6e5:fb97:ed05 with SMTP id
 u14-20020a056a00098e00b006e5fb97ed05mr6384580pfg.25.1710065874417; 
 Sun, 10 Mar 2024 03:17:54 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 o26-20020a056a001b5a00b006e66894df88sm2335300pfv.195.2024.03.10.03.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Mar 2024 03:17:53 -0700 (PDT)
Message-ID: <93e34ed6-9876-4a1c-897b-b0bc59831a01@ventanamicro.com>
Date: Sun, 10 Mar 2024 07:17:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/10] target/riscv: Clear vstart_qe_zero flag
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, Ivan Klokov <ivan.klokov@syntacore.com>
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
 <20240309204347.174251-10-dbarboza@ventanamicro.com>
 <a3765207-28bb-44fd-b207-58327516a6cc@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <a3765207-28bb-44fd-b207-58327516a6cc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 3/10/24 04:47, Richard Henderson wrote:
> On 3/9/24 10:43, Daniel Henrique Barboza wrote:
>> From: Ivan Klokov <ivan.klokov@syntacore.com>
>>
>> The vstart_qe_zero flag is set at the beginning of the translation
> 
> Here and subject, s/qe/ne/.

Hmmmm  ... the flag name is correct - vstart_qe_zero. But the patch isn't
clearing it at the end of insns, the patch is setting it.

I'll change the subject to "enable vstart_eq_zero in the end of insns".

And in this first quote I'll change 'set' to 'updated':

"The vstart_qe_zero flag is updated at the beginning of the translation (...)"

Because 'flag is set' can give the impression that we're enabling it. 'flag is
updated' is more in line with what happens: vstart_eq_zero will track the result
of vstart = 0.


Thanks,


Daniel





> 
> 
> r~

