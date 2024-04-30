Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC74C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 17:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1rKB-0001Jy-1U; Tue, 30 Apr 2024 13:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1rK7-0001JX-OU
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:31:24 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1rK2-0007SJ-CK
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:31:23 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f0aeee172dso38373b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714498276; x=1715103076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X/0BQ0Zo0xdN//RoQCbUKq7i7MvhbnttPfBvLSp3mMs=;
 b=onM5SP6RxVVPXzJCzzWKwRS+PNJxjuh6eFkJ45q0XQ08sysGmv67qfVZVF6bZ2kenx
 ObHoPB2vUtpxOu353KPRK8GfD8eRzvH4N3ZKA5N9gACXVt/8mvz31jnh1oO3P+1RbuCv
 6qLhHrY+bF7v6pY2C+fVZ6zuXlnN1aM12+iLuHNXyt5L2ekZfw1YOO1t3v9irgEsbSys
 l53saiWOXV474lRFNhnFBrkKlRQokgGgxCoRstgjOMZvNy5jywQ4yPmrIzS+0aXN40vy
 SYapQrOf55qGYqtD3zSQlTsVca2AZw4noJyw+P01qOInopbJCzqPJXzOPqGOkWtQt5TG
 mJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714498276; x=1715103076;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X/0BQ0Zo0xdN//RoQCbUKq7i7MvhbnttPfBvLSp3mMs=;
 b=khjRO3759+JLlAo3/3qmN2MzCtQUIhFA3MU1rFvXhcSdVaTat1kv9Vm8IRS9eYg+9Y
 JX3SImkH0pXOWb6Ciry0NDku15CruiO08j8LAKj+CGRPLgbKrFaSgxuZ6s0w3/CmPtGs
 PteC8tpSrLOgN82gzR5mX7J0NT1l3DMDLr7N/2ZkpAnvxeCyfeQVah0KvmRBHQmbkNcJ
 /T15JTpyu93yCRoviPtefjdduvrcPcU0u5eI4BKG3DsNDN2mKyYWXBye6RQ1smHwWmnX
 CWGONZGuELB2OgvhuG2HB+3k1CaeoHSKdpAsCfgIja+2/DBdGhKYCMLFhdpgM3O0GkOu
 pgVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUURxNr91hsLUK2TrHKTPkAWOLNg+tQCHWB9QnCW56woPEdrHA8G/KXQZaCRF768hPhhj8ngdFXiaQzgx+Fi57PGNQesJ8=
X-Gm-Message-State: AOJu0Yx2DIrgQEgqb7r3CHYg9aoXnYJ84ziHIBwIZLyfn44xM/eZIMtY
 CgT4PexIim31vfIuaG2hFVmoEbSha9mOnX4TTqA3HJy39b6Cbdm3Nv3B/WeYmfbmSqxCJqjO9RT
 z
X-Google-Smtp-Source: AGHT+IFUvp/HuhzbX3mEuUrHR6MDWw0LhcII6hRj7gEuozf3dfGkqDJ5fNhYnvec/1rgtd67/cokag==
X-Received: by 2002:a05:6a00:2450:b0:6ea:c7bd:90e3 with SMTP id
 d16-20020a056a00245000b006eac7bd90e3mr706698pfj.14.1714498275955; 
 Tue, 30 Apr 2024 10:31:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 b186-20020a62cfc3000000b006ecf56cb55fsm22839331pfg.96.2024.04.30.10.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 10:31:15 -0700 (PDT)
Message-ID: <8004c7bf-3185-4eba-8e1b-4a913bc1143f@linaro.org>
Date: Tue, 30 Apr 2024 10:31:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm: Implement FEAT WFxT and enable for '-cpu
 max'
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240430140035.3889879-1-peter.maydell@linaro.org>
 <20240430140035.3889879-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240430140035.3889879-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 4/30/24 07:00, Peter Maydell wrote:
> +    if (uadd64_overflow(timeout, offset, &nexttick)) {
> +        nexttick = UINT64_MAX;
> +    }
> +    if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
> +        /*
> +         * If the timeout is too long for the signed 64-bit range
> +         * of a QEMUTimer, let it expire early.
> +         */
> +        timer_mod_ns(cpu->wfxt_timer, INT64_MAX);
> +    } else {
> +        timer_mod(cpu->wfxt_timer, nexttick);
> +    }

The use of both UINT64_MAX and INT64_MAX is confusing.  Perhaps

     if (uadd64_overflow(timeout, offset, &nexttick) ||
         nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
         nexttick = INT64_MAX;
     }
     timer_mod(cpu->wfxt_timer, nexttick);


Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

