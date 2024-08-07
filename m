Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B74C49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 02:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbW9B-0002xQ-1w; Tue, 06 Aug 2024 22:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbW98-0002vA-Lb
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:11:26 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbW96-0008Tk-19
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:11:26 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2611da054fbso748671fac.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 19:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722996682; x=1723601482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YQ0+RaQnf487FmqMm72N/Wt0muxuUWCQihqtHZxTsbA=;
 b=jkcWV2xa2cxSQu+62o9/huzR/5Z3UF5jmRSVoifbbU1IwikpkzdmCiul0bAMSk25sF
 DWhdznE9XCOJ20jlYw3uem79f/wcAYTPn84iYJx9F7cJc0CywymwHcKo9h1XBfBkm5EL
 pM0lUBOg+l6NLspjLldJRHGafLI9alMTAdbFyTbrm7A4QOnrrWMP9YwMtuc7smmbIiGI
 3AIfuATLisu904xojnHRsk/Q+u8/q9Uu29sqDMkbrgnbMg120sE9SO5Np5v5z8AqWPMj
 Nedi0mQXJh+KrYm0GWkMS8J8HjB/K5vFaCXZxshGyJ3PM7J6fYRBUbqoiUqgY9LSn9Wu
 X9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722996682; x=1723601482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YQ0+RaQnf487FmqMm72N/Wt0muxuUWCQihqtHZxTsbA=;
 b=cCjfKh227l8OteSLosHcKPFikQUTr13If9NZMsq9BE0geOwF8sBGuMpkE+rG+gBoRM
 wH0zd33sVNTSuxE61giwiA7P7tkQtnSr2XYR1pYy3S8mo+xEUb38J4inXXPLB2svbtll
 SOv1BB6jARYdPGn7OcylNokgizBU/9q+8VF3h7vIKkh3mKu/wrmieazow3XpamVmsciF
 SkWT+OoB8g7x8cHI3pf6VV++l84RbvUlxOGC5mBHp6o4v5stfMkJVqAJVkVc4WoDd6ky
 +dcnLuPF6GmceM3kLV7TaBgvJlHou1USLmg8Besyljo0EHVF0Q67LZcHZ/rFc2A+NXZ1
 fVEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMt2WqBlZI9KpLbLuCAA2vMivN3fTsBB5S/KU5MqSCFZFY8WrZW6/llVDzOplGPY+3IdM9YAqFxBuYd6cq3ClpZCkY7bY=
X-Gm-Message-State: AOJu0YwkVaba71d46RMl7dY4yItm5Dps/2x4Go8i+K9aaKdctNx0xfMt
 KyZL8IH83cHToYAxvs3cjaxY7UN6L1CMwx8OtXdfaDXWjt7kviYzUOK8ftVg5QQ=
X-Google-Smtp-Source: AGHT+IGVZCrS6mQLdaLmnnblyYZivIjZcRjXJGPkmxM7RM3TCjLFGlbjs3z8EWFlA0lXOwl+9ccNHg==
X-Received: by 2002:a05:6870:37cf:b0:261:113c:1507 with SMTP id
 586e51a60fabf-26891d208c1mr19262934fac.20.1722996682167; 
 Tue, 06 Aug 2024 19:11:22 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec269d2sm7802908b3a.17.2024.08.06.19.11.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 19:11:21 -0700 (PDT)
Message-ID: <34411ccd-5fc8-46d8-bf5e-871949c755fb@linaro.org>
Date: Wed, 7 Aug 2024 12:11:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/20] target/riscv: introduce ssp and enabling
 controls for zicfiss
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-11-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-11-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a5a969a377..d72d6289fb 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -185,6 +185,47 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
>       return RISCV_EXCP_NONE;
>   }
>   
> +static RISCVException cfi_ss(CPURISCVState *env, int csrno)
> +{
> +    /* no cfi extension, access to csr is illegal */
> +    if (!env_archcpu(env)->cfg.ext_zicfiss) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +    /*
> +     * CONFIG_USER_MODE always allow access for now. Better for user mode only
> +     * functionality
> +     */

In the next patch you add ubcfien, which would apply here.


r~

