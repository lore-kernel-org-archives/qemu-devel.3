Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3ACCC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ran-0001rk-DY; Fri, 25 Apr 2025 18:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Rah-0001gc-5x
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:32:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Raf-0005jw-BK
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:32:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso31675335e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745620331; x=1746225131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LTF3dHMDJ8DGd7HUVYtct6ypdLDT3aX3SWYNaA01+Yo=;
 b=lzC9+AZgxYJ7fr6itGviXGdI1kx5oRchWnUNeOucRKNsKW6VdKZt0NVjQdaG2aJyT4
 DvuPwVQnd6xS/5+9QWLHtmFnofnujvk35sG4nQS2PoS9tEuKDXEWkyC8HDkg0Zs+axvq
 dq3mjRtt/gu4GNkrekG7l5e8OxHpFywzaOhTUo8tphADeep4UHnotxs+Q7ZRk5O2mmo3
 tgQV9nv3mqQwwIrLVgAKLoStoQe8Mz2mnZuknjhaE4npl3blzjF3+1kQM8OIufVhnh/1
 U8b69xpDSlDCTsqc65CR5oYWGbzhuwuKPkdZeqjc/zcWkYSgTW9U0llX/VU7KyrmBQ5T
 Agqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745620331; x=1746225131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LTF3dHMDJ8DGd7HUVYtct6ypdLDT3aX3SWYNaA01+Yo=;
 b=TxMG/cEOAXr/f29pR/Q8V0/r6Nbz2YoYQV7v4vcK1QbGJvz/RxtyZ/sZg5j1hN1hcQ
 emZB9H2OIKXJQQFtX6keZLrVxjILPDGrol+M0MKGeZvFgReErOkDM5ni+y68jFKB5W19
 SSVgfzNmlZJVdMZzwScL799NKHr66eIhfww4Ama961yMQSHqOUd7waLkqY0jSIxTXpaH
 f5dbY+2DoXONsHcsV5XCUAtf/hK0TRdLQuXNK4hsXtgjzQIlkaneC1p/+HidBMjonK5s
 KktkMMRS7gXx78VKDenp9LmJJ6AUlhLnhkMy4rD4s/+47GBspY2I04pMQ8+ZDe6l1iS8
 9hpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO6sTOB8bAcHPZ9hT/oeXZvUfdh/8MLu6bKshPPosVV4EfO/xdL7XhlM2UGUFc0l9VMaGaMYQ/IfCM@nongnu.org
X-Gm-Message-State: AOJu0YydgKwsaebbFWjxJ1RSm1/Yv9R9Fzn8o9x6+oq63r7YGN+pyMZ4
 wF8MjcCYfzRtZWjiUPlOHws3DpDZKv+4UcRoAt4TA2mHllvIJqqpYrF5bposm0U=
X-Gm-Gg: ASbGncsrckPDQxFYkpwnemewR2o732NEY1uN/ECEHGlmlRiqcSp5D1BPayfBbU7Wn4B
 DwhuR+oYXx4GyXR51PyWSWtm57icvpifrK6Yt9cUWa9sy8EtsBKDBFoKw53WZM/5rLB+2oPuaKN
 +PhA+0Um9HAyWXHO2ep6Qa98RNMSylhkYKX5gRowYcvo1FWJAEIRHKmtS2mDO6RSy+8gN1Ckd4Z
 bRH1nNLcZlOeyHKdoV2J5yRew1GOSSMPWL9w49Wp9wkVMEHLjZH+ZoQgdAHe7gWioZ+ixEjIyvb
 CbtzqlVNoB4PbsUJrhmlo3WRWQketq/wkR3CoJofFYEPfkHwgtsE2IEyhrX431Ekq2UwWodPkGS
 mJnGrldz0
X-Google-Smtp-Source: AGHT+IFygLjwcOyAWg97Q0XD660TthsoPvEpI8drBG/KWoymQtocaI+7HAtLp2CF2k15lUtPp7mzAw==
X-Received: by 2002:a05:600c:a345:b0:43d:82c:2b23 with SMTP id
 5b1f17b1804b1-440a66985e6mr32095505e9.23.1745620330692; 
 Fri, 25 Apr 2025 15:32:10 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46538sm3588650f8f.64.2025.04.25.15.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 15:32:07 -0700 (PDT)
Message-ID: <039d122f-fe09-4c18-8683-aab6d92f5535@linaro.org>
Date: Sat, 26 Apr 2025 00:32:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] target/riscv: Pass ra to riscv_csrrw_i128
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, dbarboza@ventanamicro.com
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250425152311.804338-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/4/25 17:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/cpu.h       | 4 ++--
>   target/riscv/csr.c       | 8 ++++----
>   target/riscv/op_helper.c | 9 +++++----
>   3 files changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

