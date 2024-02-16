Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89CEC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayBT-0003tv-G9; Fri, 16 Feb 2024 08:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rayBR-0003tE-Rc
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:23:17 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rayBQ-0004R3-7M
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:23:17 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e0cc8d740cso528992b3a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 05:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708089794; x=1708694594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LyLCivfqZa23nrrykauv9ToagVI5dPGKej7mi0dzbO4=;
 b=QJfylCF0wTDDDfrG51CK16n+7t8wnUMKpx7+NkItufFaxfzdvFqZ88TBMZVLWzCxji
 gbIQr3TNIrjaE5EepYp5vuTi9LGVvqJfZ0K0lnuq4MNMBESt5N80b5/3jK6Q91eSOljR
 0nHMtlZgx50gg5ELtcBYjKHSbeCsFyg17R9OHCsOgwsJViwUuYDLDWtHEt2/coRsS3Bp
 wjadU5Ii8mcOnVe36zvHNx7ubg6q2ge0aHbJTqYLD0gLnpm5s3OuksJpFn/omr/rBTxA
 jMwopYJRtqBzB2TKU3FnM9QvoPfPyZt5qeUhFFvfi7U/e8l0W9om2KL6d2wf/XDsNHRp
 9BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708089794; x=1708694594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LyLCivfqZa23nrrykauv9ToagVI5dPGKej7mi0dzbO4=;
 b=BV/aGVy7D7SnSo7TlrlotoP7FzhNP7WoM23T5GE3ZLuVFW9zYO6IlF38cWKZ2vMgmE
 k0wMrgVgoWrf9CM+IBiyXcAejHx3szMwlmtZ0HVOW6D2Q7vCUJb5GHOLAa1MjY5d8xgj
 C7wAuGw853skZDdtBtE+gQyvk3ruydrGKKiOQiffs/blRe4olRBSereekPlvz4Al0iRB
 hQPCCJ2buvJ9RS0/i6Y5XhCfpCumsi/nQbA4TEf5NnpcRTUrCzGhNv0lcqJWcbYVQNwK
 vOu3UcvqdBVLnZVZH4i9IgDoNo1UGcRt7XhJYKWahBUmetbQ0PcaFCAOZMOYbrktlnDi
 Cs2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBjl/9WxL1933hu2+eRW49w3kU/90EEuk9yomZdy0nPElMjShGwVbhXLaTMBTNt/djpAW0Q2VFbtWs34uewP4i19iYN0g=
X-Gm-Message-State: AOJu0YyLqYpKoOHIpPHLe0bPfJ+gGmmTQYg6m3Yop9ZwPvpssiVw/yb6
 vIKotgFTiY9jh9Cir6TNS3vePAccfS/yTY1v8AjBYrZK9yv+o2aoS3CJU6o01uoiBc3iRmTneJW
 s
X-Google-Smtp-Source: AGHT+IElTz94niM5FMyWuOO+LhIqmLJckvCpypPNvqBs7wLS8Oo9Ox58zZ5s5Rcr+4BYzxcPB4AElQ==
X-Received: by 2002:aa7:9992:0:b0:6e1:1460:1840 with SMTP id
 k18-20020aa79992000000b006e114601840mr4186572pfh.29.1708089794605; 
 Fri, 16 Feb 2024 05:23:14 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 o26-20020a056a001b5a00b006e0e35c1e55sm3054626pfv.79.2024.02.16.05.23.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 05:23:14 -0800 (PST)
Message-ID: <6c3d27c6-82f4-49f7-b074-73d04274c1b7@ventanamicro.com>
Date: Fri, 16 Feb 2024 10:23:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/riscv: Set the value of CSR tcontrol when mret
 is executed
Content-Language: en-US
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240216061332.50229-1-alvinga@andestech.com>
 <20240216061332.50229-5-alvinga@andestech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240216061332.50229-5-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
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



On 2/16/24 03:13, Alvin Chang wrote:
> The RISC-V debug specification defines the following operation for CSR
> tcontrol when "mret" is executed:
> - tcontrol.MTE is set to the value of tcontrol.MPTE
> 
> This commit implements the above operation into helper_mret().
> 
> Note that from tech-debug mailing list:
> https://lists.riscv.org/g/tech-debug/topic/102702615#1461
> The debug specification does not mention the operation to tcontrol.MPTE
> when "mret" is executed. Therefore, we just keep its current value.
> 
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/op_helper.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index f414aaebdb..12822b3afa 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -347,6 +347,12 @@ target_ulong helper_mret(CPURISCVState *env)
>           mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
>       }
>       env->mstatus = mstatus;
> +
> +    uint64_t tcontrol = env->tcontrol;
> +    tcontrol = set_field(tcontrol, TCONTROL_MTE,
> +                         get_field(tcontrol, TCONTROL_MPTE));
> +    env->tcontrol = tcontrol;
> +
>       riscv_cpu_set_mode(env, prev_priv);
>   
>       if (riscv_has_ext(env, RVH)) {

