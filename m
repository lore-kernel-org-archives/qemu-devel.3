Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB755CD37AC
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 15:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOdRB-0006Js-7n; Sun, 17 May 2026 11:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOdR4-0006Il-E6
 for qemu-devel@nongnu.org; Sun, 17 May 2026 11:29:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOdR2-0007Kw-TA
 for qemu-devel@nongnu.org; Sun, 17 May 2026 11:29:46 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso15784335e9.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779031781; x=1779636581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7wI3vnht/xV4G3FS9cyesXV4U07L6sp+UJQ2o8wF7No=;
 b=LAgh7ICXP2teQ3B3r86bFV6z8iyNL3n4bHR1+OnRzDGaun4YZBX1vmzZ6C2we3iVKy
 AjbD5l02YUst6IIVXP0u/NLeg4jI1GMUPf02Oz0rBCON87KVTuMco2mKo1y3dBsJgnfw
 RhPgq0YnOAbYZ4q1qwbTs38dXrEft1wIfTkJ5ilml2POlAa31b0/zqY3z+O87+bdgrjw
 xTm1q0i80znYj6Qc2aN0OvtPgVa1u8n7cW2/DVh+WDXs5F9uWKj+Lm60wjPTSOiLSzoJ
 wSFMUoCj1mhz+cvegeK9JaSRcvkHo5fzjfK/L+zj9seuoKNF/0aWjljx2eQrEwzCq/Hh
 uTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779031781; x=1779636581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7wI3vnht/xV4G3FS9cyesXV4U07L6sp+UJQ2o8wF7No=;
 b=HFKDxsk5DaWQSaoc/TDLTDDMZl3umnvuMUGojdz4JO6/CrJo+2EGRmwI0EN1WAKARK
 OioFeEZ38wqugq5fKFHhMhs4cz1bv9X7+i5thOATFs4ZgoSlSUWisxX+ETpb2/Z1lxKv
 9mz5Mw3rSTby7nEPl8cCBlD38kf3L3nTJpbpwvU6Pc9CHqwrIulk1QmL64REAjPO9HfJ
 oy5l7MqdbtTFJnvxVG4ISqRY3uP5WNqdyL3dYUVtY4db9XOd1Q3H4C4fh8UVvZuDcRmz
 nq0tgfdW9UG/6avdTnpFB6GFfYVFIqRgT0oLIQ2WRmrJSvSm2eOcZlS99jYb6/TZgAUP
 q4yA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/P2Pd5SsP/StjBTn6YEaMHC/+k2KGxHNHTgnTEVhl31WV8YrDP19EuPdNQlcafbVLg7zp2y3Ft9p8d@nongnu.org
X-Gm-Message-State: AOJu0Yzb4fjJ70pciV3KdssZ1btu0jSemDeXPRVre9063jjzdSz7cRmb
 ie0Qcz/91TlLFWrVk0nwkil6leXvu7ayfG/CppnMPu+xGbrTG135qZS5WGenpPSZOpY=
X-Gm-Gg: Acq92OEqZTdGGve7cpAr7ytvP1f/kay/wWAUm5KGvYn8b39XET6MmTBA1h5Oui5qnXX
 tzHIbg/yrmqDh2/v6ykk2tp9vtkt8zmgNTlAbgWRJSGznVdvTU/mlL/myNRrZbwSHMVCkiIgcrU
 X9Qnx7qvj3dhZGVMa3DDHzWxtbjsNEoVRiVetuDGJc886chgyO3Zl0w4p7doCuEN7zT+SZBaWz6
 bMJ4Wce/KjKJU1LaM0sVK0rDbVZzOQRegDzVd0BXJLBP9+maBrZDkfXP9HcRRG2wi+I32tLGX7E
 l0RegT9U6F0jRK13IS3kvAvWQocpkH5DKRX3Ma6fwy76ZK38IGMYA2VdqNOdUj1joutBX6TGuxH
 1CcSHNXxWQKinDb/gl7A4xxc1XH0pAy4HRRoXMxKWdHf5WuzUbkGdsjthAnuwXxyUcRf5BeB6l5
 3Kbe3gJsdfhxBaMD9HqO5qvSlcK2UG2urWOKZ/DA80qpM8wKQmIzvOEQ//6tiGFpsqJCsxuQFcj
 IUq
X-Received: by 2002:a05:600c:4e87:b0:487:21c7:2885 with SMTP id
 5b1f17b1804b1-48fe60e142emr175466505e9.5.1779031780627; 
 Sun, 17 May 2026 08:29:40 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe58638sm59422185e9.17.2026.05.17.08.29.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 08:29:39 -0700 (PDT)
Message-ID: <ac41251a-d66f-47e3-8757-7c998464889e@linaro.org>
Date: Sun, 17 May 2026 17:29:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/27] target/riscv: Fix size of irq_overflow_left
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com
References: <20260515180437.23620-1-anjo@rev.ng>
 <20260515180437.23620-17-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260515180437.23620-17-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 15/5/26 20:04, Anton Johansson wrote:
> Fix to 64 bits to hold all relevant values.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e9d3bed6f9..269bc07e2d 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -224,7 +224,7 @@ typedef struct PMUCTRState {
>       /* Snapshot value of a counter */
>       uint64_t mhpmcounter_prev;
>       /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trigger */

Should we update the comment?

> -    target_ulong irq_overflow_left;
> +    uint64_t irq_overflow_left;
>   } PMUCTRState;
>   
>   typedef struct PMUFixedCtrState {


