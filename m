Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4CBC54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 19:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmfZi-0001AW-6L; Tue, 19 Mar 2024 15:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmfZg-0001A6-T1
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:56:40 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmfZf-0002yd-GW
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:56:40 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e709e0c123so2854936b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 12:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710878198; x=1711482998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hj9UCcOv8js+xpzVVP2juKNQpBfrsfcJKFiKM9L/O1Y=;
 b=fLUtAmJjy+XokOTmbMqkjEH51XTrnhw/QeVQNxmxczyUPY5zdGpE0CE7hs2uFj42cH
 n1AbAuotF0D8bHWqGV4UpPvsJo+Ec0fz2Hcd4NZjX8AqxFPTzQMUpBdUzze5X0ofsOza
 sV0qhZKe6q4zmchNbVssm7iyD4OqAPvUFAtZEphxboHfYqjeMjxzSVsJvFUqKEQ+pcn3
 wmLtF7a7ghaq8AyfFu5Egt5uBjZAbaRAAWBgiP/2nOCOX7bYoJcdAR+L9ZjBnT9hKDU0
 gln1e03Q6P7GQbo9k2W6+oGk2Nde4TKy9/7Db48ecxtDyjJBrnBIcpEZqUouvDR6fRZp
 awUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710878198; x=1711482998;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hj9UCcOv8js+xpzVVP2juKNQpBfrsfcJKFiKM9L/O1Y=;
 b=bp+CPUoOImV+MSsInCYBAcTNi8iJMl8/NAghuOt6q5VVFvtDux+jJVPL3iCGOgC7LM
 p2XgUEF8j4Y0NcHcxdP5zJ65HqOIX5tcHJA7oJN03k8slwNWkSF7JWa6fSGk5VlafEqk
 IjeHXRqL0NXhoiFjtNGvHrEF0qzbMFGUZ6Ovf4o7257uTRMs2efWCaWqHhlZN/j8Lb2g
 NmTSODALVP6FQy6jjorclwMIYzZvaJdXamO3T4km2ogcjy1Hk9yzkgf377thc3AJHut1
 q0lS4BC2Xvzb+RGqIWti2SandEP9W8FzBb0e/BiIPeuR1UTtic+RazWWiQkDF5BYIlvf
 ZjWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/EBwHODu3gCPOz8ZmZrF77DDkDtoVrsmyC3ZemUPvoslvvKDewDrN/RtPcRgnFfUlUgC0nfrCeqK1OKfg5sSAi3i+vNU=
X-Gm-Message-State: AOJu0YznTlbPdegVpPC7MFCTqtB4P+ccPvXywkxOuev9g4iL35spdcdl
 unYYf4Z5jecYRduC9RN/i2mHzsnwMQFSEhftVi9AI1xANrqC4haC9w0ay1rspTOHnUup4IcClnF
 k
X-Google-Smtp-Source: AGHT+IHlLmwIJ8GLPqQLW4DTtxwVODML3u2GFAKgO7s7J/HbQ8f4UTqQpQQgkYqEExo4YfSA77FCZg==
X-Received: by 2002:a05:6a20:b915:b0:1a3:69a9:e3e7 with SMTP id
 fe21-20020a056a20b91500b001a369a9e3e7mr3398159pzb.18.1710878197929; 
 Tue, 19 Mar 2024 12:56:37 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 j14-20020a170903024e00b001dd66e6ec91sm11816048plh.140.2024.03.19.12.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 12:56:37 -0700 (PDT)
Message-ID: <1eb36792-22e4-4f0c-b7b5-968b78e3a1bc@linaro.org>
Date: Tue, 19 Mar 2024 09:56:33 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/22] plugins: Use emit_before_op for
 PLUGIN_GEN_AFTER_INSN
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-8-richard.henderson@linaro.org>
 <5b9ff51d-439f-4e65-acb5-909bdfaf350c@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5b9ff51d-439f-4e65-acb5-909bdfaf350c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 3/19/24 03:32, Pierrick Bouvier wrote:
>>   static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>>   {
>> -    TCGOp *op;
>> +    TCGOp *op, *next;
>>       int insn_idx = -1;
>>       pr_ops();
>> -    QTAILQ_FOREACH(op, &tcg_ctx->ops, link) {
>> +    /*
>> +     * While injecting code, we cannot afford to reuse any ebb temps
>> +     * that might be live within the existing opcode stream.
>> +     * The simplest solution is to release them all and create new.
>> +     */
>> +    memset(tcg_ctx->free_temps, 0, sizeof(tcg_ctx->free_temps));
>> +
> 
> Not an expert at this, but wouldn't that break an existing TB that already has some ops on 
> those temps?

No, this only affects allocation of new temps -- if free_temps is empty, a new temp will 
be allocated from tcg_ctx->nb_temps++.

Zeroing free_temps here ensures that we *do not* reuse a temp that might already be live 
across any plugin insertion point.  Between insertion points, we will free plugin temps 
and only reuse those.


r~

