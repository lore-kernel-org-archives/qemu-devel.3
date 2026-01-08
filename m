Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E109DD1D47C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrzW-0006gs-W1; Thu, 08 Jan 2026 10:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdrzT-0006fs-6f
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:32:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdrzP-0008BI-OE
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:31:58 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so36275705e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767886313; x=1768491113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gR9txCIB0ux64fgXeZ/Chimfnw3NnD3GofqzeO2GPi8=;
 b=jPOhkC9BMHOrghi7Wk/QNJljcQBs0ky8uZdJ+cIKqufFTgOmW5+zka8H1UsZAYVzgD
 TxUjG7f808uD4fOmMi2LbKLq2Ss/RllxsUFNE4iT8VJcxxQXXb+lgZVM8pFhwu/aWHKZ
 zAGrwUr+S1EkNdiWuK5jaAA0kKUnNrTUgQwvwYK60fU6gix2EDXVL0SAaF8auAI6VSSI
 GxqhoySPpaF9CVMrBapLPEUxg1GMhMV/gW45SyDVthKrig3oG4p/4b/r0f3yZTBqEtEx
 YGJTCjSZcgGUf7YphtUTuIwnhcsdqog3ciE0qB4nJMhnTb+2/uRqY/wYLxuag5rdLnUQ
 28QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767886313; x=1768491113;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gR9txCIB0ux64fgXeZ/Chimfnw3NnD3GofqzeO2GPi8=;
 b=F6Hye4DcsRuzrRYLRua32FpAn66TeLX/6qyWCGIVoqVdpdaAqKUFr/EKYMhY4RoZ4C
 BUyC1pdOYswSKbzhGlJ1KNxLFlEpHzzzRuz896XsNXnz0lzLdkq3CrwxqkBr6yB86JkK
 xFefeZO5RPh7LjmNPmpqDDnBCR/l9Or27KfRH2NFzdONre6Kpnh8n/H34h/WDfg4pZBn
 JqUt6DWhnKUft77B/CWoWxmivXyuyAdLcLJhdQ8/Ulpx8pLzkmLIZRPGN4DQvV8FKSWR
 K6MwARbJ4rN8f8WyLYmq0/lYj6+pnZVnayPwMyT/c2m1PbSZInKjVrGWrQQQW1nWiPh5
 o05g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgm1btEg+LqVRK6GYMFcfo/nmFyhDaiAMF5q0bpQ8Fv00UJmb8Sr+zS76Q9IYDr7CUuqWqXNDGT8Z+@nongnu.org
X-Gm-Message-State: AOJu0YwEVYjdhuRMT4i39Yu0Pxav0ZciowIh9YaeSSR4r3OLQyTFGTZN
 UUW8K6K6QrKnIbLwVfpqC4b4I79Wj+W777yUBwHvfyigztNYpnvSivmL4CueiFsQbMA=
X-Gm-Gg: AY/fxX5ovVpejgo0f1cDIhhR3WSj83VmwEb8Wt/e9mKBbOaScIkYIcsKY1DXRJIdeau
 Dba4zmvP3OS+6m2TCiGtG3HBJ9vk+P7xPb8tDGWGfgX3qIpUINGSbumNuVn5qU0oJg9DYETDury
 X+SE5TwDI9joQ5/MPkfVvG0PBzxXHczta4a7uf/N+CGJidZgVTuswkLFaamuO6gIv1gbJ7sNRWI
 LoUhOMF7mataNxEf0J3JLwdRIp6UDv8zb3bAfsDf5yk1W7NYktpxKxux98WYzXvR9iuxG/3jIaQ
 5FuZS4z8C1x+uGHvV/ogx3AP7MxWtkU9aQKwF+7pla3IpG7lERaJOQSRsVM9fb3OGM+q8EFAEl3
 qJ1fzR08QQti+DGNuONkSMls9F129x5jo7X58aOwqsyB8kwHKzGsxZGUzdmo0Lg57zwbfP39nof
 4lz5FJQjjH9SrkSOQNftg3lC2S279+bYI36TFjy+Qxf5JIIeACicvcXQ==
X-Google-Smtp-Source: AGHT+IGUtjdPNkY7Uyxd7uEFkyOa7ZO0VS7VrhSqFG3aSJxQD5dKdXAicSbx4zsD0kmB+q1wTVDkQQ==
X-Received: by 2002:a05:600c:1d19:b0:47d:5089:a476 with SMTP id
 5b1f17b1804b1-47d84b386fdmr89898065e9.31.1767886313262; 
 Thu, 08 Jan 2026 07:31:53 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f668e03sm164827665e9.14.2026.01.08.07.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 07:31:52 -0800 (PST)
Message-ID: <7515c883-1e0f-4a23-b65c-e63067737aea@linaro.org>
Date: Thu, 8 Jan 2026 16:31:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/12] riscv: Add support for MIPS P8700 CPU
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 8/1/26 14:41, Djordje Todorovic wrote:
> Rebased again on top of very latest master branch by resolving
> build issues occured due to the changes in the code organization.

I'm sorry for the unfortunate workflow pain you had with this series :(

> Djordje Todorovic (12):
>    target/riscv: Add cpu_set_exception_base
>    target/riscv: Add MIPS P8700 CPU
>    target/riscv: Add MIPS P8700 CSRs
>    target/riscv: Add mips.ccmov instruction
>    target/riscv: Add mips.pref instruction
>    target/riscv: Add Xmipslsp instructions
>    hw/misc: Add RISC-V CMGCR device implementation
>    hw/misc: Add RISC-V CPC device implementation
>    hw/riscv: Add support for RISCV CPS
>    hw/riscv: Add support for MIPS Boston-aia board mode
>    riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
>    test/functional: Add test for boston-aia board


