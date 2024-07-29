Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76207C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcNX-0004xr-0F; Mon, 29 Jul 2024 22:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcNU-0004vR-TY
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:14:16 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcNS-00055x-Uk
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:14:16 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b7b349a98aso23521026d6.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722305653; x=1722910453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u7FNqUvF+XJzNco74MQlt6Xl8tIcakoaxeK08Lo7sIw=;
 b=pvJD/wyOmeLhkMinuGsaXlMH7nRsrKn7b79q3+7xJDso3Dx7vbml6x2wBvs3snkaYv
 05dv8THEirq/Od5XGBeE2VncAXHv7sI2Pjxn11/rr3qVoxpV75p2OachbjQUOriHg1A2
 1+mArG/zF9UYx2F0Px6Kl1HdZMq54FcSsKeijajqtJ9c8o6f9gw2IkVgPwrDxuuuQjvR
 359eUGbGIUAOzDikfzjQSHrf8W0t9QkFjLlWlBBzBB45iBHtnowj+oqM6CvZPJ5RI8km
 o0ftzuyMH5211ADCNBjvRJk6tl6ClhFYvOsjhMC0BMo+9JbCnsVA85XschGBLJrHxg0f
 APgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722305653; x=1722910453;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u7FNqUvF+XJzNco74MQlt6Xl8tIcakoaxeK08Lo7sIw=;
 b=jZdBY1V83buApWHA6Jw78w1MBFq/XsQ18T1T+vqS3A8tejXC6DJlDjtwyL4Xj7EV6Z
 mYWRE/kfaYwnCmHFxXZld6iIhJsmP/TzfSTl4/CvuClw/jkNgits58s0PkwKRvHyf4sb
 /rCyRQDH0BNxYMfzVOML2jQ4XJgLeGqU03u5tZPubPw/6ZXnUcmQoy/P5i+HhutU5tAf
 Em2ssQbQujuNtzqjmfTS6HMkG5jqwncmvVtiH1vuJm0xu+jvW7hCEGQFWwDpFC07j9xs
 aPyxifQCsTKB7tG0T/bwpXSGLKQN3gSukdmpEh90ZbvpCnSlfhYWGekHRWFwjt/fJw7Z
 eyOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU96eGJO7ir6bZIVLjNb4YE0EYfhiEfnzkgMM7pyb4d1M6ulkGbDnqkwJv+DPaJ9MiLrHi1Z3+EE1IDol0hpGfrVJxk0NY=
X-Gm-Message-State: AOJu0YzFYDRVCBEjXPpTqfKV+PglTaAfxH8WphYMiF0hGpCJR3WWsd/1
 pTKpZ84gEO87LfDS1kwlvjXQQc59LUKdT62iXGpilUNSwYEvFPyHOq470S4SSN110BSCYaeTwr+
 gE9g=
X-Google-Smtp-Source: AGHT+IHxaVpnasTBLevsuWtlKoA0IxUJXPaGaErgyId59ZLGqLmmQskc15liu0cTH84jMh32qN1g4Q==
X-Received: by 2002:a17:902:f550:b0:1fd:8c25:4145 with SMTP id
 d9443c01a7336-1ff04809b95mr131361515ad.17.1722294278743; 
 Mon, 29 Jul 2024 16:04:38 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7c8d9a5sm88846875ad.10.2024.07.29.16.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 16:04:38 -0700 (PDT)
Message-ID: <2fea7463-89e9-4fc4-9926-dba304838aab@linaro.org>
Date: Tue, 30 Jul 2024 09:04:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/24] target/riscv: save and restore elp state on priv
 transitions
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, jim.shu@sifive.com, andy.chiu@sifive.com,
 jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
References: <20240729175327.73705-1-debug@rivosinc.com>
 <20240729175327.73705-4-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729175327.73705-4-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf32.google.com
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

On 7/30/24 03:53, Deepak Gupta wrote:
> elp state is recorded in *status on trap entry (less privilege to higher
> privilege) and restored in elp from *status on trap exit (higher to less
> privilege).
> 
> Additionally this patch introduces a forward cfi helper function to
> determine if current privilege has forward cfi is enabled or not based on
> *envcfg (for U, VU, S, VU, HS) or mseccfg csr (for M). For qemu-user, a
> new field `ufcfien` is introduced which is by default set to false and
> helper function returns value deposited in `ufcfien` for qemu-user.

Why are you using a different field for qemu-user?
Much better to simply configure menvcfg the same as for system mode.


> +        return (env->menvcfg & MENVCFG_LPE) ? true : false;

Never use ?: with true/false.  Use the correct boolean expression in the first place, 
which in this case is just the & expression.


r~

