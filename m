Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5BFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PrW-0000HN-KV; Thu, 02 Oct 2025 16:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PrK-0008U5-Q4
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:25:05 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Pr4-00087T-Qs
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:25:01 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-782023ca359so1547083b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759436675; x=1760041475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Boor/c93Uw/375YCAmBTFeEORfD7BuHyNdLHU4k1tcs=;
 b=FjFOl1L2qp8MMWZD+iOPO52nG6cDjIl5zR5+cHsg/O6s2PNbv9Xhw8Bzp8MndM3ona
 vRAli/wqN4HAmJwtBJVwkPDGfV/wDRBg89UYsk+2q3vxcSpoAozFXohzvgjhu/D99Qim
 4GLTlxz7hN73RzlStzzUUY8QRf1yWb6hczsdwLt0EKZX6ynogM2twdaHUKakP4FD4Ma3
 P6mW0bwCAi4+Scu2Q8VGESNzvhsdZjGVAHP5F6Ue29MCsv2rDzKhHGOjWvX+Z7nbunxX
 ehS8FPRVGVjtbrQPHgW++n3MlC9S2SQmJ40VjzQtnpfb+ZnV7418DAQzaEjtpz+k+gqw
 hCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436675; x=1760041475;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Boor/c93Uw/375YCAmBTFeEORfD7BuHyNdLHU4k1tcs=;
 b=Rak9+lIJv4TVx1KZc55JrWqP/7DnAEwm7LZQVFv6ofJcg729gPzzXEdLJqoa0/q1Bs
 HaC3J7JAA/IXITnqe9t2kilm3ND1CfjgdEErGfvE5NxCx8LpZeIR0qojg4J9cztNbtIx
 lnn2g0maG3JsbB4SEzFc8Ri3zY8D8++NMqKngww6PlKtlLdfymgK4MmsbUjeNiv0q9Ru
 XnLljKjmuw3MO8YQquON3wk0H6tuG5nHg8MJtgNDUaJ0V3SwhGxWU8j8b1vwuWqM9Opb
 aYx32wx32j/Ft8PWAUdJsqHQljfDMUEwf0kUYwoadkjNDfetiVPDHoQ8L5emIwvaRY5f
 DloA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVKfR+0HrqRXcVGlw3j4xsgmb5IS+T8n0hXHRmh8HEtpEcvdCioUPS5bw+9rVwWxpWqARHDcNI6HP6@nongnu.org
X-Gm-Message-State: AOJu0Ywg6/trCIeBBo8PgruTTpdOowSj9FGM2WjGUHiXkLUJxhs8ETZU
 I/PphnL7cEhWASKjMjuG6DZOulwIb22YOHI2XgG3ZgrewGsTVaNpFyL+vR/QtmE/grA=
X-Gm-Gg: ASbGncuo/0PEe6+OUqp9cEbw/6BB0ozNCnSU+ctA8GjSKBNA9qQCblAi69CvKBQamBZ
 KwiyOrzLiBBGz09LVVFFB1QGDuF/W8VsaLxAE2ngzMKhInV/sPuP+sMIRcBRLtHnZL8mUTIMReD
 K6hbZaiQMo0zhFADGBhLEmG/7vuaWfoBnCBewTGUwvcQv+yCauWeLqeIiRal9I0cmR4eJFox9ut
 xdn0eiLaN0AYCDc24uAb+ngwqAYI0QBqgUJvhyTgUV29/UgFBgIFYOIC1sFDWtD0JRzGQxVbvBp
 akmMksmX5wZd20x29jp2pRBqNusxZHSA3kn09KH9bCLBGPI+eCwJtYYesWy2sV73BNrovlBcVlX
 zscNMA/fWAW86ETDQXlLAinCTNpMdUsvOcQoSjCJqIIV5q5d66Tq1AbqChuu7wvTNRGpsh6ADiA
 ==
X-Google-Smtp-Source: AGHT+IFfppH2wAiW9f8yDPWqGagsNO3EmZ5E/yrhR7plS6asvXIyz+qaIf/adbqNJsMh02MxgV9IQw==
X-Received: by 2002:a05:6a00:8c4:b0:781:18dd:31de with SMTP id
 d2e1a72fcca58-78c98a77c8cmr975956b3a.12.1759436675244; 
 Thu, 02 Oct 2025 13:24:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b01fb28adsm2926576b3a.35.2025.10.02.13.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:24:34 -0700 (PDT)
Message-ID: <47bb0bff-9690-4a7b-991b-c58b38568810@linaro.org>
Date: Thu, 2 Oct 2025 13:24:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/33] target/riscv: Introduce externally facing CSR
 access functions
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-33-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-33-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 10/1/25 12:33 AM, Anton Johansson wrote:
> Convert riscv_csr_[read|write]() into target_ulong angnostic CSR access
> functions that can be safely used from outside of target/ without
> knowledge of the target register size.  Replace the 4 existing CSR
> accesses in hw/ and linux-user/.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h        |  7 ++++++-
>   target/riscv/csr.h        | 13 -------------
>   hw/riscv/riscv_hart.c     |  7 +++----
>   linux-user/riscv/signal.c |  5 +++--
>   target/riscv/csr.c        | 17 +++++++++++++++++
>   5 files changed, 29 insertions(+), 20 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

