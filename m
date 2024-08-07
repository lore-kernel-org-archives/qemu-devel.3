Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321B4C49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 01:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbVDS-0004mB-Pu; Tue, 06 Aug 2024 21:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbVDO-0004kt-W4
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 21:11:47 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbVDN-0001MT-2r
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 21:11:46 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fc5296e214so12211525ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 18:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722993103; x=1723597903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zXFDfcTZ0kga2DOLVA+DXpbkfDgIv5TS2piXSwWfv5s=;
 b=vuAdj+oLNI5qlA9qZNW73kZQTo/OyIHuCXjOl4hpvHXAdqJrOH7KHLAdCcKQvmmrKx
 T6KoNszOpU05/zUaPts8YEwRfTZm5CzJFzOeajqFkhr+8cqFquGsqybvfSmub3zH4u3F
 3Scyxadq9ZkL9Nuq8P3Q47n9OlO1iChDehL/RS93tKaza6baf6sl+2kV0XKmoigf071/
 /OPqoXXm70HAwdzdtGDdMx47X/pKUuFufw0O72SMfvBD0ZVwmn6D/qjyOCWV9I6fhzbU
 TPIQq7ynMCkuyUW4fWkMwueI394gCUSINVjceVCQb+xBsEEOYAA7gJoo4sWx1KbCmSWt
 PsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722993103; x=1723597903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zXFDfcTZ0kga2DOLVA+DXpbkfDgIv5TS2piXSwWfv5s=;
 b=n0YRjZt1LCVFz9GVaspwOx6kVcBzqIJADCoCVQfeA99sZ5kMP5kHaX3POHVEbZMVQh
 emufcncaJJeq75AO/Twh/RuKMbuc/P724w3ixF+2dmO/RdWu7F75BJW9drdUbwBQGFln
 DTBINatgkLXhLt0l0iNQfdiNu0IRTHQONiqW0MEqTLyxLpmcm069P4Gaq4I/pq6emXnz
 ZFEzf1bvds3cqqTGYxZU8ii0p3mIvrr9VUgKsN5bFdw5vf0lya3ywldwAlhlj3ZipxQR
 fa2+oswF0QxTk9lnX0rjByZm0xXGVZ9iWeDYpTjmfoV+MdncJh0UKLm3C04ZaZZw4V4i
 VbAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuQnt/NRzYkMiv3sLsfUChGfTD/iEety4jCY9ulvkYQrHxs5d/DWN/6u1mRn8v01MMXdQZa4Y5c4i7E9Of5ifOBPdp2P0=
X-Gm-Message-State: AOJu0Yz2qRkbq1aTGSOW7Ln8VDIoCr/hehadt24YjYpGR+wMHwDc6JQ2
 5gkLFjRqhukY6ueBwhlz+ukjkaIv2p8RVLVJvr7xKC7b0ZKGaI3dKWliP1ucKno=
X-Google-Smtp-Source: AGHT+IFqnwcGMnLy3q+8gI8doB8+mBVqA12Z3UynTSfmeaR5oYbvEZ8POL9IYqbDLKoivtprMkJRvQ==
X-Received: by 2002:a17:902:ec8d:b0:1f7:123e:2c6f with SMTP id
 d9443c01a7336-1ff57323889mr230059795ad.37.1722993102835; 
 Tue, 06 Aug 2024 18:11:42 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905b4ddsm94097655ad.173.2024.08.06.18.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 18:11:42 -0700 (PDT)
Message-ID: <2a2ee90a-dc31-47e9-884b-665253979064@linaro.org>
Date: Wed, 7 Aug 2024 11:11:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/20] target/riscv: additional code information for sw
 check
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-6-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-6-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 8/7/24 10:06, Deepak Gupta wrote:
> sw check exception support was recently added. This patch further augments
> sw check exception by providing support for additional code which is
> provided in *tval. Adds `sw_check_code` field in cpuarchstate. Whenever
> sw check exception is raised *tval gets the value deposited in
> `sw_check_code`.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   target/riscv/cpu.h        | 2 ++
>   target/riscv/cpu_helper.c | 2 ++
>   target/riscv/csr.c        | 1 +
>   3 files changed, 5 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 8c7841fc08..12334f9540 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -224,6 +224,8 @@ struct CPUArchState {
>   
>       /* elp state for zicfilp extension */
>       cfi_elp      elp;
> +    /* sw check code for sw check exception */
> +    target_ulong sw_check_code;

There's probably room for consolidating the different fields
that feed into tval, to be set when raising the exception.

But anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

