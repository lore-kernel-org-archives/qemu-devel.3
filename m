Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189C4C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 06:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW8ZC-0007MU-Ey; Tue, 23 Jul 2024 02:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW8Yu-0007Jz-L1
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:59:52 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW8Ys-0004u4-RA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:59:48 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70d1a74a43bso1263507b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 22:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721714385; x=1722319185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zfqy+KQKyoi2Q8Kn/90Lwx07X5p6KKXjr7MHcp1h5h0=;
 b=Bm/XggqO95paUVEujtTojrq/co9AQ8GYhnAzyMbo2H5wTm7YTCCLdjNHBI9mJtbvJj
 tqjcdU0tCN9Unke3BaVeHbwm1CTAVfGJXUOIEohtDn6Y3CI7MuZSqCdKc8GRmzd//054
 KkRyDCUWS+2Iu0RHA19oI4jAz8FmUt4aTTMjwcEmh9okEbIbJ5V5OrFKf97phQ2fT9YQ
 pGYxrYYjRDZMHrz2RJnI96pyOVxvfHVKHHj4m0Ur5mBiKgh/Yee5QA7BOHOYQjMGb5dw
 07AhQ3Bsmlko67v4VmNDyUvHjf553tp71zxtSLXMtVf9wPL46CumAC9cFje9SMkSu8ZJ
 z7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721714385; x=1722319185;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zfqy+KQKyoi2Q8Kn/90Lwx07X5p6KKXjr7MHcp1h5h0=;
 b=BWHOXuey4FBEn5DF40MqfBRlW7DVKa/j107EOZvTm3xa5zNbFDDp6TO2bqYocPBoHs
 zIlQNrg+xS9rZiQesJfAVQb9uZ5dxunDyZyMaaXOArbUOAnwSCBfAzSLQ0C/f5y+dX0L
 08/2kaFpCnYpgXZjRGX7GQDH6DQPJsTqAyd7U5ceap9JInFSRdtvkD1GBLmnfxyH+dFI
 0QSJ1i2mS24y8RltPpW7q//YNVXfq7f9fdQGKBM6Tf1mzQhXX7F3q4KmQ73bbIsVci5E
 iPWNVYHjBU//Ks1ipCJw1EWuZ8Y6HwB4du8udV4vdCpVUd4lW+yx3nlNdiDnNdiF0zE/
 nWew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpNlTmmSPGjud72NduhwDOPpnmyd4woPqMn7WnqI2HLojtmIYM0vFkVnugnrgsdk/k6GMkEJVzHet6T5FFaQ2IkHZ8UY0=
X-Gm-Message-State: AOJu0YyUsllJNPKBZ7Pg5LxPJujmYYTemG1oKphIfs5HlKoUkHgn3G2M
 CJRuFMmuJ+9HGYWtokcawG0iGJQTqFBRkTCu2CEd6JiwsUG6rKOMhtwecSE8tc3a+ACgOMAWAMo
 Mdcm4BQ==
X-Google-Smtp-Source: AGHT+IEMO8eILTuyHzWn5WGfeVw74N7mimmUn05HTdbNPzCoQss52bzypyRGYQTzug+e6FgqPc8H9w==
X-Received: by 2002:a05:6a20:842a:b0:1c0:f677:e98f with SMTP id
 adf61e73a8af0-1c4229b453emr9967283637.46.1721714384680; 
 Mon, 22 Jul 2024 22:59:44 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-79f0af5e618sm5591652a12.25.2024.07.22.22.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 22:59:44 -0700 (PDT)
Message-ID: <8d12202f-7170-4127-a1a6-c23c03835cf6@linaro.org>
Date: Tue, 23 Jul 2024 15:59:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: Remove redundant insn length check for
 zama16b
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240723013012.1443-1-zhiwei_liu@linux.alibaba.com>
 <dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org>
 <df37fdc2-79c6-420c-bcf4-e7c3649fe446@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <df37fdc2-79c6-420c-bcf4-e7c3649fe446@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 7/23/24 15:29, LIU Zhiwei wrote:
> The more detailed information about its meaning is in priviledged 1.13 specification. More 
> exactly, in 3.6.4. Misaligned Atomicity Granule PMA.
> 
> The specification said:
> 
> "The misaligned atomicity granule PMA applies only to AMOs, loads and stores defined in the base
> ISAs, and loads and stores of no more than MXLEN bits defined in the F, D, and Q extensions. For an
> instruction in that set, if all accessed bytes lie within the same misaligned atomicity granule, the
> instruction will not raise an exception for reasons of address alignment, and the instruction will give
> rise to only one memory operation for the purposes of RVWMO—i.e., it will execute atomically."
> 
> That's the reason why I do not apply zama16b to compressed instructions.
Given the non-specificity of this paragraph, I think not specifically calling out 
compressed forms of the base ISA is simply a documentation error.  In general, the 
compressed ISA is supposed to be a smaller encoding of the exact same instruction as the 
standard ISA.

However!  It does explicitly say "no more than MXLEN bits", which means that an RV32/RV64 
check is appropriate for FLD/FSD, since MXLEN may be less than 64.

In addition, your change for AMOs is incomplete.  From the text:

   If a misaligned AMO accesses a region that does not specify a misaligned
   atomicity granule PMA, or if not all accessed bytes lie within the same
   misaligned atomicity granule, then an exception is raised.

The second clause corresponds exactly with the Arm FEAT_LSE2.
See check_lse2_align in target/arm/tcg/translate-a64.c.


r~


PS: The first clause is similar to Arm access to pages marked as Device memory, for which 
all misaligned accesses trap.  I didn't dig deep enough to see how PMAs are defined to 
suggest how that might be applied.

