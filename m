Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ED9C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 13:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYn7C-0000cu-1n; Tue, 30 Jul 2024 09:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sYn6f-0000XD-RW
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 09:41:39 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sYn3o-0006NO-4s
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 09:41:23 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3992195d08aso26635255ab.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1722346601; x=1722951401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rGba+10zNXuurM/lwFKrTYh3r5c9cCPnSmp5y0KbeF0=;
 b=KvA5v8/2y3tarBcSR+6y8vtrmQnTAuuz84/Bvq9JmXnj6Nijh/sxvOFj0DPuBFPLFf
 CV5lkLJzIuaOq0HTeCUFwwNTHqN0IljWOFVVBlnzSu8xf7YSS14ivdJEtoHkxbOmFPn+
 q0YB51Xiq9lkcahok8k+zhG7QfFA9M1D8FnTlVLi7meFKZ8LIm262JTFTSNvo/8ksbbF
 TL0cbDNzwMHiTEGl/u0+PhNw1ti0W+ie1JgLp2dqDDJZ4NmKq0cnKGyAWRZoALjA+UcR
 00sdBSe2AAVzpNjMWdvmMK044XkwIc0hiU2cpSnaFNpiYZxSry5fLo1zrde1NqxnRZOT
 12JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722346601; x=1722951401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rGba+10zNXuurM/lwFKrTYh3r5c9cCPnSmp5y0KbeF0=;
 b=XrupnyO/XKhf+1Cm+QK6VxNcOGgmPhkvLlNVjJ1yn0xJ7IzfczDEmHcXR8R8wvPpRW
 e3Ty6WQ3eBlMwVbnS/9mu1/6qv0XUZCeWEtnZcffNWNAEjBDsOGJUuvTTEwmZbxdeELW
 OnRZUZI8LM8W791kM8cat7qITebVyiWfE+JuLIyi1foAJ9SOjpwNMjuWjDlgdTR7oNDC
 653t0VWc5bPfHpUiib8YT38tG/LZQ2++JV121h3pJh/EMVyUGaEm/P9SZ7OpaNizOSnA
 J5kpkY+QIGZd0nary3HU79w1p+ZqQyTGAodiSyYTJJSaj9VFPTycPGZ5iI8LX0xSdru8
 QekQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVElXZH7KFThB7yzxRjkD056uf0VzakeSRSx5jH9M8RkKXcl38cyJ880l5m3nnhB5D/jMOQiOzKjItokaNicqZ9uQRUaL4=
X-Gm-Message-State: AOJu0YzvDob1RtDCqHnrhbvkjeSGrZfqJZ6AzhYyiB8NjXtt6RST3aJ2
 ShtKgQL5Y3RysWgcM617ADrOC9c4bL7djAzmDysNb9oOpgLzegJyM+wLO+NlDQGljrMdQApszRD
 CIVk=
X-Google-Smtp-Source: AGHT+IH2r0rX+h58NGoqrHj47Usvq4GZ8Xplz2ngRvXteAg4Kq9DnbUIqpm+1jNlpMX9TzP7akrR4A==
X-Received: by 2002:a05:6a20:7f94:b0:1c4:8da5:5825 with SMTP id
 adf61e73a8af0-1c4a0e05515mr10370529637.0.1722346149859; 
 Tue, 30 Jul 2024 06:29:09 -0700 (PDT)
Received: from [100.64.0.1] (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7d39489sm101615415ad.119.2024.07.30.06.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 06:29:09 -0700 (PDT)
Message-ID: <5b668c1b-24c9-4d54-80a5-cd92221b481c@sifive.com>
Date: Tue, 30 Jul 2024 21:29:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 5/5] target/riscv: Inline unit-stride ld/st and
 corresponding functions for performance
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240717133936.713642-1-max.chou@sifive.com>
 <20240717133936.713642-6-max.chou@sifive.com>
 <abdab05e-3001-4a6f-afdc-05fc997657ee@linaro.org>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <abdab05e-3001-4a6f-afdc-05fc997657ee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=max.chou@sifive.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2024/7/25 2:05 PM, Richard Henderson wrote:
> On 7/17/24 23:39, Max Chou wrote:
>> In the vector unit-stride load/store helper functions. the vext_ldst_us
>> & vext_ldst_whole functions corresponding most of the execution time.
>> Inline the functions can avoid the function call overhead to improve the
>> helper function performance.
>>
>> Signed-off-by: Max Chou <max.chou@sifive.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/riscv/vector_helper.c | 56 +++++++++++++++++++-----------------
>>   1 file changed, 30 insertions(+), 26 deletions(-)
>
> You'll want to mark vext_page_ldst_us similarly.
>
>
> r~
Yes, I'll mark vext_page_ldst_us at v6.
Thanks.

Max.

