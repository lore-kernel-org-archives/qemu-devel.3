Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4819C49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 02:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbWAn-0007wn-Fg; Tue, 06 Aug 2024 22:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbWAk-0007pr-9Y
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:13:06 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbWAg-0000OK-DJ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:13:05 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7a115c427f1so964244a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 19:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722996780; x=1723601580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e5HWZHMQfqC3/1v0O59SNkAG5CBfF1tu2kTGJ72IUbI=;
 b=cxyy9Kge/YEYViir3s9Wykdt1TSodncI86Z/m5wgbI7OIKIzU7k/ed2qwJ+lmAJtM/
 qqXZWPUlw1BTyT+6SenW9kI68v42+8xKFANQMoSq9VIDxoDBYsFeyAHwr+dcO8nUVksR
 ZUGzfFqph+OpO7QnQ89x141L8L894V3GHjjUcdsYQqZGEVCATl9kWFzjzdYEvOXhBCyA
 HO+jS6YGzcmMdqB4XgpUgbtNBzKllXYpYNYfe8HfWiCIfTbGPAf3SffsnRDtyer5p2sz
 HSGg9O31X/8tvSszKl+WwBMs+hXAYzHkFSDt8uNd1anWBtvk0ICxs1COWecmzBqhVodZ
 ER1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722996780; x=1723601580;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e5HWZHMQfqC3/1v0O59SNkAG5CBfF1tu2kTGJ72IUbI=;
 b=VYMjZTknHp+5Pyk5dFaiWrsT6bJUiRgU1d2L+ojWDy8JmUmhcR50WaVQd516Kz3rfI
 rFeZwtOQxiKVBvlRdnNbeigL8PtDCcablLynLGXZIECM1/+9rpUWafAfkrlB+s73XmLH
 MX5PWwzj40vGg6SvWydEPySYIwIjiPilcMeAjCTeE10sCAY7DrdT8hoaLMaPvC2lhx2k
 YrqE/dEJZMlhycrL8FpNDQrZ4Nw5VLgqXm3JhGOQEigOJvYk/PUj1LrOu4xqmKGT2BJL
 xwKuckBujYjK3chq/82SQhKZM8btD6w4fgYJLom5aF9rVFvzgsw+e4D0/OxsRJ9TmstA
 ZZ2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfujWGZDZ/z+9UMu8qCga7WkQlV9CE2MWTXfi0LALgR+eLoPfYXpXJVDMSK49ifgA//WF9a3qOX5LYWt0b25JcRW2NRTg=
X-Gm-Message-State: AOJu0YxtgUxXGR3LUc/MJb0+bpFeU6YHPa5E4jINrrtAe3DY4jMGEjNC
 7gataQwh0VUj9B0Nv5tW4mqAC9OKDL2jfyOxszleBDf68HWvtFnRTF7SXufGfTU=
X-Google-Smtp-Source: AGHT+IE05mCHWq2+ScTr1jYgkqkRmYeoG+ufajxtkwnTD80lJ4VtFldj3i+L/ONiMlvkbJmi345JDw==
X-Received: by 2002:a17:90b:3ec1:b0:2c9:73ff:6a0c with SMTP id
 98e67ed59e1d1-2cff94479a6mr16292381a91.20.1722996780246; 
 Tue, 06 Aug 2024 19:13:00 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b36a72e0sm208418a91.9.2024.08.06.19.12.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 19:12:59 -0700 (PDT)
Message-ID: <c530ae34-497b-4cd1-b3a6-d8b575c33fb2@linaro.org>
Date: Wed, 7 Aug 2024 12:12:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/20] target/riscv: introduce ssp and enabling
 controls for zicfiss
From: Richard Henderson <richard.henderson@linaro.org>
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-11-debug@rivosinc.com>
 <34411ccd-5fc8-46d8-bf5e-871949c755fb@linaro.org>
Content-Language: en-US
In-Reply-To: <34411ccd-5fc8-46d8-bf5e-871949c755fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 8/7/24 12:11, Richard Henderson wrote:
> On 8/7/24 10:06, Deepak Gupta wrote:
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index a5a969a377..d72d6289fb 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -185,6 +185,47 @@ static RISCVException zcmt(CPURISCVState *env, int csrno)
>>       return RISCV_EXCP_NONE;
>>   }
>> +static RISCVException cfi_ss(CPURISCVState *env, int csrno)
>> +{
>> +    /* no cfi extension, access to csr is illegal */
>> +    if (!env_archcpu(env)->cfg.ext_zicfiss) {
>> +        return RISCV_EXCP_ILLEGAL_INST;
>> +    }
>> +    /*
>> +     * CONFIG_USER_MODE always allow access for now. Better for user mode only
>> +     * functionality
>> +     */
> 
> In the next patch you add ubcfien, which would apply here.

... anyway, surely cpu_get_bcfien() is the right check anyway?


r~

