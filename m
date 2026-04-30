Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1286FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISyZ-0001Z4-C7; Thu, 30 Apr 2026 11:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISyY-0001YZ-3W
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:06:50 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISyV-0001oJ-3O
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:06:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso10052595e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777561605; x=1778166405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dsRNIVLlBT/nwMjDRWv76e9/h3ujSWWHFamNc54CMZ0=;
 b=JZVkQe72yNzDXGxZniJKyrkRJDEbYOXmfEy4iEBYsodlKo2fwFO64ZI1fNhHr/r+T4
 K6sgi339fyy9GqvVfMLHW2JU7iZ/iPUGGFLWXOFjpF1lksf+v5247PgUncgp88hzjVAO
 mElu1Iclf1Sngaiv4Sg7nWAnuYcTG6GZizRngMleA58RtCcJY+nnsIWCZrNEuX7HVXxD
 kvz3VCl6z5nccSdmFTgidMJ76k8saplsRMoD1qbij9zmiBqSRetWY46E9fphtD7x3ReF
 QIcEYVx8x3F41iBL0n9hJUUzS2MGm3rspAhtO0ct8+QqlHNwWj70X9/dlxVgXOkDPFpv
 oU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777561605; x=1778166405;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dsRNIVLlBT/nwMjDRWv76e9/h3ujSWWHFamNc54CMZ0=;
 b=oveQSM/nANpQFsvcc/B6PYQnm6ubTZY9/M+Q6Lvzj9iDV6VF5dKSObTE8wenyj8DJx
 M+mD4OHlirioLHLNRBHTJ/m0m5yP9ubPgHHtCyAmXs2zEoUb+hZhCQPX1tRrI2glqT6v
 Upel7ydxrNgXEkWRhe4witzbud2wX6DZkz5PMt2rMLEHPZdPUatMYrdrkSybGEEARIOI
 /Tq2a1ypi7iepKw4TTMlalTdaPcdPUcm7LEqaH6kSZY+4/wgmyx4eEY15k0L9eNSBAEg
 cpjE+gFr/mhJ4w8OVBdJO6oNdL6asc1c5pPj9+b7vD6Mq6QCRQGXgJMaawizLcK4CJMB
 jWJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Hqb89urknn100XKJo0P3+dkA4RVyC/mH/At3+hekm8LbeM6blFpqBJ+0VPQI1R9yUCSNP5plo8uvT@nongnu.org
X-Gm-Message-State: AOJu0Yzr83bD9xFZ0IV4cKXQ5GixkTZOMFA3sPLWh1Xc8KaazKgyKrto
 n1SMyMh+VfXtsNCGQG5RXUi4LO6cRHwo52Hlba8oaWQTGBZn29Ge5WJdU1Vro6fIxf5zXZRymgX
 7w9fBpHc=
X-Gm-Gg: AeBDietkxV1budOb8tGLKXTNSGtTfq+nghkp/geQUp4RUARCe7YA1J/B4nwahN74adg
 IEefFc3sqeGdXKNqgbbO4xhVaZ+MtKBdyke2obaat5SRcYpoJ94Zbpa3vkcn/ZW2REr0rXvwu7b
 WYx1SmeOrfc8hU36LnsKNj4lKm++fh0CGKpW2uDnQotpSUl5kyW8c7AjH6ekYeu3pL4JdaEqLEP
 TdC9kWwLZUI0roKGKGbm5G8+LUqBmNb38fcnmzMgwon0N04btGvldTYHku1YuYU9paQyzlR8UYE
 tRdKEf4XF6gIFUWpl0AUGN2DcpUomom7B5u8U4klnlht2ogd92bIiRrArThsq50oBvZsvJtRymw
 K2WvtKVNABNcvYqLrxxjHVYT+V8jOlTG+RWbOHXOWAzZ4d53M2qhgkpaKn5UCPhYbZjeIOOmlGg
 NcSa97HUbi39C4EcZ4zKcK7Cu21BiI7KhQiB7D4XUj7fC1wwt3pr/RGU3pAnOI8R65ewupYSonw
 Ito
X-Received: by 2002:a05:600c:4e55:b0:486:fa35:aef2 with SMTP id
 5b1f17b1804b1-48a83d62fdbmr60553765e9.4.1777561605277; 
 Thu, 30 Apr 2026 08:06:45 -0700 (PDT)
Received: from [192.168.69.232] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822d4b57sm179884035e9.15.2026.04.30.08.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 08:06:44 -0700 (PDT)
Message-ID: <4101be5e-15ab-4eec-8336-6b3c6136dadc@linaro.org>
Date: Thu, 30 Apr 2026 17:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/40] fpu: Return struct from parts{64,128}_mul
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-30-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30/4/26 02:05, Richard Henderson wrote:
> At the same time, export.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-parts.h |  5 +++++
>   fpu/softfloat.c               | 34 +++++++++++++++++-----------------
>   fpu/softfloat-parts.c.inc     | 35 ++++++++++++++++-------------------
>   3 files changed, 38 insertions(+), 36 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

