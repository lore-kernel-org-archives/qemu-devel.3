Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E126FC83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG4b-000077-PG; Tue, 08 Jul 2025 17:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uZF39-0007nF-HF
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:36:23 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uZF34-0001R1-QV
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:36:22 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7d7f2600c17so421927085a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 13:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1752006975; x=1752611775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1X4IAeA2O2T066BMmgQNMiWh7XnPFYJbke9bUDYN7EM=;
 b=TpRJRH29OV+bgpbF4m3c0UlDt0ydz81OkApjRuRilG/EhuzAGoJOayFtRLzsJuCRJP
 fCloZLpshB5Jtwsg0q2v1tCjMlpw+XXIZMFFpDKLx2BI6c5ZMkMZVYFebjjRX5vBml//
 QtUZ0rphWmw0L8QI1NtFeLA+HSUqD7HoYILcY/WjOcCZcgkxD2Jwl9DOwj5UoNAATlT7
 aOpDGKBGgrjsNIpQDAGz/RwsoB096eAHdQyNe9x8H21vMKFm7cgnhtXyiJdOL7RdKNlv
 tvDCeJhPVkt2uf7jKUXVKLHPBEfAtl2Y3YcGwdNGt66xV6nzvDPPVGBn3JDi+IpgE8Sn
 22qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752006975; x=1752611775;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1X4IAeA2O2T066BMmgQNMiWh7XnPFYJbke9bUDYN7EM=;
 b=WiDVydxedQctLmJV33K2u6FWjja6IUBiv1U2OBDLva1dg04LK7uxqOcHFnM6A3xSpX
 BW75vHaQ5zuIQg2Qcw64HEio3mWgZTerQ1b7HJ3Pfgfx7wTH5JZSrgxZ3QysTeRWkqh0
 4bmXSVt9MfBbBYb5x+A0OX4ueiakl0mljGY4RSgQAc9U2LRuFUsO0ArhVsiegEtifIiT
 ZEm7wR/T+ry3ek1bMr4BpFNyzAno1DSjHa1gCGdS5Y6r2J6mbmlbyYTAgO4llbkEyrvL
 Zf0YEd9FTggHoNmN23BskdbCGz9Px2G86x83yPupocaZdUaPbk67WU8MPvLqOhiVYQZr
 s4+A==
X-Gm-Message-State: AOJu0YwdlImd8lhtO6vEONhJCn1rzHAEt8EWFdsOkqDzpfR9w+mccaAn
 lvu90vUJahVpxQdlnR3BcskpIfyMu6Gnj6usk6TsYiVJj3/gHTNN8E5DXMpn/0nmP9YVQxhzG1Y
 rb1SL
X-Gm-Gg: ASbGncsT+/o1ip10/t+f7ReP6qtWvPlKuch+M4vpIWL9WPbXT8pdh2zO28cAJWzduK4
 p+P2MgWKhInm6yLKOMdVdg/rGZQGFIp/O7/a+CmW6ySsd2I33VKjPd+cd5HgRehWYVM/Ln+AOZQ
 g93/4Fuf2sNLslhRBnOoZrSvWSeq65/lvBJqtv+jMQx7wydckreqW7q1vuHKIc17LV1p35rrtYj
 /tmXKt4cWSlBx5D3saGDTRvEFOMFsc3Tr7zcjgdlEuV6jONXR3pL+uXwWQuFyFEEr7Fcpxe9W/O
 untzA2RXACTM3rPvAk+CSlcih3z71o/pdrefZeE0uD3E9svOj3q3fynpAuGdmr6YjxYXKIBiEPh
 5vQ==
X-Google-Smtp-Source: AGHT+IE1RAIpgU7PfYmnyNhZFs+JOB2uhU0+u5Bzss/zroThLGY4tIyQjh/pcBTd+I7qj4plzcvEUQ==
X-Received: by 2002:ae9:ec01:0:b0:7d4:3c5d:3256 with SMTP id
 af79cd13be357-7d9ecdfaea0mr403667685a.53.1751971708033; 
 Tue, 08 Jul 2025 03:48:28 -0700 (PDT)
Received: from [192.168.68.110] ([189.110.107.157])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d5dbe8f844sm754423885a.82.2025.07.08.03.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 03:48:27 -0700 (PDT)
Message-ID: <b9e539ee-cf63-4a64-a3f2-03dfe7bc82a5@ventanamicro.com>
Date: Tue, 8 Jul 2025 07:48:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] riscv: add all available CSRs to 'info registers'
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
References: <20250623172119.997166-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250623172119.997166-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x72c.google.com
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

Ping

It would be nice to have all CSRs for 'info registers' for the next release.
We have one week before the freeze :D


Thanks,

Daniel

On 6/23/25 2:21 PM, Daniel Henrique Barboza wrote:
> Hi,
> 
> The output of HMP 'info registers', implemented by the cpu_dump_state
> callback, returns way less CSRs than what we have available in the
> default rv64 CPU with default options.
> 
> This series changes the callback to add all available non-vector CSRs
> when issuing 'info registers'. The vector CSRs are being handled by
> another patch [1].
> 
> Patches based on alistair/riscv-to-apply.next.
> 
> [1] https://lore.kernel.org/qemu-riscv/20250623145306.991562-1-dbarboza@ventanamicro.com/
> 
> 
> Daniel Henrique Barboza (3):
>    target/riscv/cpu: add riscv_dump_csr() helper
>    target/riscv/cpu: print all FPU CSRs in riscv_cpu_dump_state()
>    target/riscv: print all available CSRs in riscv_cpu_dump_state()
> 
>   target/riscv/cpu.c | 107 +++++++++++++++++----------------------------
>   target/riscv/cpu.h |   2 +
>   target/riscv/csr.c |  18 ++++++++
>   3 files changed, 61 insertions(+), 66 deletions(-)
> 


