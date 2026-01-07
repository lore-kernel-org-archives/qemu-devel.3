Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B76CCF6BF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 08:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdOhW-0002tk-GU; Wed, 07 Jan 2026 03:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdOhN-0002sf-Mu
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:15:21 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdOhJ-00015J-Vq
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:15:21 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-43246af170aso303028f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 00:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767773715; x=1768378515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M8BrIFyt0UgdkZgi/wylEf9M1Txl3S/+wvAkiSYc0hc=;
 b=u95K9xuVFOw4Wa/wVBABBPEhuGEl3gfzjPDmKb8dUYMAeQYX6s/Q8sZ6wYdd7bJ8uB
 0yFyilxfh7cOO0k+clxDO8llunbbCetFI9JA9NUS/l20Zop8zGK+eH8dOUX+/eG4P4ve
 WGzo3LWL+HXloYhwp5QIFJ7G6JGGZDCD/vk2CL2imBa7GXr3kMzIHKqxnNmEST73UVON
 3TLQx9iwn7w65MR1yY/mmasWzO3dt9wNHRPDBAWcrI8PSxM3iyBbiE32vRUhFAAojQ/H
 aWiQ3a6ggIRzmLnJEioydODGGeknwy2xtNcAW/IiQI2OzdBr2ocRInS8vHP+qs8hoU5j
 VeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767773715; x=1768378515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M8BrIFyt0UgdkZgi/wylEf9M1Txl3S/+wvAkiSYc0hc=;
 b=eRmJGsf0SPHuPfsRSjWYJaoeo5puR/vrnGNlE87s/d02rGMbQYsA85TShJoDFuGv9E
 /QROLr5hZyMd1FNiKudyxUzgRjHQb/oILbHQ7ccqyIZNDo09omH2x5jIo3UnFBevcc+Q
 egenkYa0oXhedmoWqFZWEVHw9OnmlqxzUWSDRvWmrajeGDPRtKmR3suxCSN890m0Iw7j
 +KN+PbVQt9N9CZiD8Z+/0WlaMxw3jVtQWCLoDbnGY2eNxGHcAoIweP1FgpnD37dNu+OO
 81h7ObEBUQ/6LHpZyHwC7hnOsH1LvjAe6JeGi51UYF/1SzjX3ldLsHDwdZ1c9A4He+Hq
 2u/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKj8slY31WGXQ/K4cGGHizxyY6u67h9g30FKsNUZWu1DbolVf7KMvYL3jn/RRsXiqQruFO8eBE076M@nongnu.org
X-Gm-Message-State: AOJu0YyMZ7WAzkynrr5zF4f6I/zCw9kL5QHRwWtCl9VtK6pUbkPTUgGR
 utue9+MmghRA5KapXJfpqrU6bxqlUl2Qfuy0vLttNhxHBbIsOcHqv8o4P+3YyFDMiOY=
X-Gm-Gg: AY/fxX6dSpFGS2rpH7IoJJuhYSMhhklz5wBXGhx5uzGmw1OtiszZ5SQjFLUu+4VSNPw
 y51nZyOAZ+vJ/AlZzpMgQ/6PkxyYB0T0oBVLSsoqWD/vAw6E8c1m0wM1+6SCXA8KXV6uWXxfz1v
 4AmK8YN4VIg9TG3h7Q8BlzDc/TuLtolIWLTHtLZ9LBbXf/frVnUkaIFNTbyF6oRpKGbI70DkU3j
 KcJu1s0pKhZvT5rn7/g834Hip17i0+XQj3vQ3MCfXyy3VVkdLLcn5PAow4QB9D5jg1KNpKVgMKC
 q4c7ZoOgfpuozx1B06o3KjbCOcO9KE35Q0CCxvaoh5ug2wDk5/0f6hDJ2EkEHmZgxugWlxuNBOy
 YR+fDbu4lGAzB+HXwWuRGhTIMqztQSHPrTLsK6S/uWaDL1fx9cFRUqB86dNitM6ISKOtVvmdWC6
 tG2uengqx/TCjIW+t8ly54NS3LZOvHRhWVEBO21x15iYGUOPj5srWP3A==
X-Google-Smtp-Source: AGHT+IEk6mFJwpwVd12sdEzHgn3qmfedaU63Qu5lakogYE6HzxYqgN89SArjisCsqLFAFq7SiKqH/g==
X-Received: by 2002:adf:f191:0:b0:432:c03e:a78e with SMTP id
 ffacd0b85a97d-432c03ea97amr3947235f8f.27.1767773715262; 
 Wed, 07 Jan 2026 00:15:15 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16d2sm9232572f8f.13.2026.01.07.00.15.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 00:15:14 -0800 (PST)
Message-ID: <d950dfac-5c36-49d0-a9b6-7577362d083c@linaro.org>
Date: Wed, 7 Jan 2026 09:15:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Drop stray '+' in pmp()
Content-Language: en-US
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
References: <20260107-stray-v1-1-6658efecbb0b@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260107-stray-v1-1-6658efecbb0b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

On 7/1/26 08:57, TANG Tiancheng wrote:
> Remove an unintended leading '+' left in target/riscv/csr.c (pmp()).
> 
> Fixes: cd633bea8b0
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> ---
> This patch fixes a stray '+' character that was accidentally introduced
> in the PMP (Physical Memory Protection) CSR handling code in target/riscv/csr.c.
> 
> The issue was introduced in commit cd633bea8b0 as part of the PMP region
> count configurable feature and causes a syntax error that prevents
> compilation.
> 
> Fixes: cd633bea8b0
> Link: https://lists.nongnu.org/archive/html/qemu-riscv/2025-06/msg00089.html
> ---
>   target/riscv/csr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


