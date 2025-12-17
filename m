Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CA3D637DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 00:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVfdp-0006aN-EQ; Tue, 16 Dec 2025 19:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfdn-0006Zv-Hn
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:43:43 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVfdl-0000me-RN
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 19:43:43 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a0ac29fca1so31736565ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 16:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765932220; x=1766537020; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8rtShpemeQfdXrQ4WeRsDWx/IwE/D0vUV/3Vf7ZgrQs=;
 b=b9x0O2E5EXjGuqXsxluNCL5IydW0FGWTxM88BlDxftItQl1MsQlKcNaBOgdUlTsXZW
 v4xqFcUvPmzEruL3EURFwjrWs4wrJA1sdeJLK1NCZqwg82CtF8AHKVhpRPZsvC2Xsp7d
 S3rCvOpjyiouc/Jjrl2RmLQj22CkIovmiCS16ZCjNXuBO2VVClizk68A1VJotM1Jc/eg
 uJMkdjVz3wEhA7EOg4ST8iz30GfhTXDvWfEZSwyS27irQNYq+cHcOndX6Y0uqBd37DsI
 lpKsyCTeppcF0ZrUV2wcH/LGGF4IMIbksEoiG6cRs1YbsxUnh8uwQc+aj5kJg+xFgTrf
 hiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765932220; x=1766537020;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8rtShpemeQfdXrQ4WeRsDWx/IwE/D0vUV/3Vf7ZgrQs=;
 b=oSOrQ/NVbsINDz/HQDj3z3ymf3BvNG8x/+V3DV3MjSjnxpFBZHfDfglNOqj/wlx6CQ
 EK3bgKuhSN+sw+qS8a0GgEYJRZZzN/pbRCVKcCBJ+wDMRSJELCEBKDokz6JSzU5Yyy2F
 iv1bBb+2FQ6KFD6jAQLcW6Sh8/Dhg5N8issVJdsx1h629G8o+ErvWl0csLDrDtrIEYCO
 5R+HxmcgncbIkpQ8y0zhWZjqofDUbRtUZU4LTsg6VyjVdA7ZiHitTpJA2Dju5C2WSLop
 KPha3ESlUvaZ2rnIjdQTh1nDzfZ3eD5rw+clZ5lEwj1tmx5D2zHz4fy6HOdkwefjrhTM
 o2Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmaEDaGgPQTvLzg/1FcHH515x6yLaPUVPvrWBU8LSnsYdcslmkkVD+P/7ub8Rh23dEr34g7Kh5u8dB@nongnu.org
X-Gm-Message-State: AOJu0Yyyq0O/fp0lrRqqp9g4Do7Ab9J45v843VtH16qNh7nSPokv9w5q
 8d/Got5wlBS+7RyZCwrXSTuKtiEvdCpByJoy0LKm5GbiB9TCFOYnyontbwncKdwdzGM=
X-Gm-Gg: AY/fxX759eNJaqm98p63VsUFHhe/Uj+DViPtu+6z9xr3wx1T+tNYYdmK1ZLGNxsGW0w
 UweKgIsGwn9rA3mOWPtnsxmTTnJMZqcLPfotqWVs7yKhhO5Qr+/3K+wkl+v3br6KsZuzVLKFl3k
 g8IN8F0fYrwTq2FxeQj3rj3HFUr4aQrjc+eDxgWa39kmzAFgbmA40B2TMijw89t6e8kIC3zL0FW
 FrbDsuBd5ZdEkBtlG7prwlM6zvQVzg1sQxzAtEQ8vbhX325yb0WLGt+/TCgGcmavX2Ns4t0Ls2u
 rG1z7mvCnCImgc2hC7qtV5daPmIm1tv5DPOPDcvxvYjk3ZP7bBkb1+qs1gwgCXEZUk62t36gOiR
 ShLxcXXpVPT+OHmxvt0HH3WwJa30njKVP8IjWtjlu2cqLalyE0ufkNFbCEZ71spWepQfBJGcYLj
 ztZJEqdmmJbG45Ms9ilq9QLbKNJhxjvMkt839uc8fmptTt4ZzRjkbw28g=
X-Google-Smtp-Source: AGHT+IFS920/LTxLM5ZBWJU/K80kYPBm7NTrYZO6X/N+pxXGltolAjaLFwyYs9dKVrQmHcdC4eH4WA==
X-Received: by 2002:a17:902:ef12:b0:295:9c48:96c0 with SMTP id
 d9443c01a7336-29f23b19552mr150260485ad.5.1765932220408; 
 Tue, 16 Dec 2025 16:43:40 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a1353ac579sm37940805ad.28.2025.12.16.16.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 16:43:40 -0800 (PST)
Message-ID: <724a52c5-ccb0-4db6-ba57-9bd96f8597e3@linaro.org>
Date: Tue, 16 Dec 2025 16:43:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] target/riscv: Remove ifdefs in cpu.h
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-8-d24a4048d3aa@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-8-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/16/25 3:51 PM, Anton Johansson wrote:
> KVM fields of CPURISCVState are now always exposed as CONFIG_KVM cannot
> be used in common code.
> 
> riscv_cpu_mxl() is changed to return CPURISCVState::misa_mxl
> unconditionally, as use of target_riscv64() would result in an extra
> load and compare with TargetInfo::target_arch.  We might as well just
> perform a single load.  Likewise, for cpu_recompute_xl(),
> cpu_address_xl(), and riscv_cpu_sxl(), we opt for returning the
> corresponding CPURISCVState field with ifdefs for system mode adding
> extra conditions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h | 36 ++++++++----------------------------
>   1 file changed, 8 insertions(+), 28 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


