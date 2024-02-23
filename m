Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC411C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 20:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdcWF-0007qv-PZ; Fri, 23 Feb 2024 15:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdbq2-0005xw-Pl
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 15:08:08 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdbq0-0004AJ-DW
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 15:08:05 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d7881b1843so10526745ad.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 12:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708718883; x=1709323683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QX6/T2QeldjjxGrISb3yv8KTYxm8I1meBUaegPmpnJQ=;
 b=zjIb2mURlpAhC9n4fK+cvd5fkN+JxrYYCCdBfD1PX3K91/s+817IoZwnM7CWOiZbZg
 0LcourNV7aN3B+vr4dkmCi61FxDZG7nF94DTQc3HIimaHmr66LOIyrvEHcvrgJ1Yk97U
 fbF9I8sVS/rVEuWQUWOEjPTJ3ys4Fev9Ghkdd8WNjNTfNAt9GxKH2j9643UHTZkIsKP2
 UBVVSXLniw9DodSLog57dSIBxLVKHUf8fsAnDS3b1WuwlXqLyFEpRUlLsG9rJqpYKb1U
 HdzuNc6zF95VG6HB40jv8ZvWhiz3/dmMvqT8RLlS0pec4Ei4PVji7n8ZPUnPAbfc0QaG
 qPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708718883; x=1709323683;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QX6/T2QeldjjxGrISb3yv8KTYxm8I1meBUaegPmpnJQ=;
 b=SSRJTQl1drd0W00z9flNP0auxkNM5jqsi7/VQWJYi8gHWCVEZ19H0/a5SRPFhvM1bq
 V6dPwO7tXGGj+OP31tqlTXYpbsP9qdMThmb5QZmbgLNm6meXxqeUp75Cluq+V0ADj1Ef
 yPnuwKCXDH6pBrwmcAtU6ALyyoUlV6oFYfbMjNO8Pwy333gjDAHrjCFgZLgR88zwWfGk
 tp/QARY1RVp8FNjN7YOzKm7ucZo1TBSojXqoFQaTPQFrHEjdck7/IVMtfDzq0a790jR5
 /E4m82NMEvzqTiLpsYvnfatKhSe1DfYGkwSY2PnkEoI/g5hedi8CREAY1CzNMMSLwtYz
 WlKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxsr4RUsCbZi8DuVpvAHFIB3lWxlewzzYb7FxxqhUwpQwq7kqWI6wP1miusjcw5HvqmWSqiLOOK7kDIuSzbTOGaN1jCWM=
X-Gm-Message-State: AOJu0YwowKMwzP18eohv6v50/dVLcsbK5SgdJ49vHT3UAsmlFu1pshSD
 I62ffoQ4XGO2QrRBykEUvYBbMbpBhZ4IblHePzt1dVq785BSCiM150U+YeRPz9w=
X-Google-Smtp-Source: AGHT+IEtTuzF+1TYa5fk7ypDeuOqQYuKeYQfk+DBupy/xODysDbeGviKeD1tL37AAZwbwAOzRkRqXg==
X-Received: by 2002:a17:902:d3cd:b0:1dc:744f:5317 with SMTP id
 w13-20020a170902d3cd00b001dc744f5317mr780766plb.50.1708718882876; 
 Fri, 23 Feb 2024 12:08:02 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 lj10-20020a17090b344a00b00298ca46547fsm1885987pjb.36.2024.02.23.12.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 12:08:02 -0800 (PST)
Message-ID: <fbfee197-27c0-4fc5-bf0b-9041e0748801@linaro.org>
Date: Fri, 23 Feb 2024 10:07:59 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 12/21] target/arm: Handle NMI in
 arm_cpu_do_interrupt_aarch64()
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-13-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223103221.1142518-13-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/23/24 00:32, Jinjie Ruan via wrote:
> According to Arm GIC section 4.6.3 Interrupt superpriority, the interrupt
> with superpriority is always IRQ, never FIQ, so the NMI exception trap entry
> behave like IRQ.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v3:
> - Remove the FIQ NMI handle.
> ---
>   target/arm/helper.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0a69638651..1a5e992d26 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11452,6 +11452,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>           break;
>       case EXCP_IRQ:
>       case EXCP_VIRQ:
> +    case EXCP_NMI:
>           addr += 0x80;
>           break;
>       case EXCP_FIQ:

Handle EXCP_VNMI.


r~

