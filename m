Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E15C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 20:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhy64-0004M0-Cf; Wed, 06 Mar 2024 15:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhy62-0004Lc-PD
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:42:38 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhy61-0004Mt-7k
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:42:38 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412fc5f5099so1528265e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 12:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709757755; x=1710362555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DPx0WKsr3WD8stnEbU6nk/HiuAb1e9AnM+Gm0M50IM4=;
 b=K4jPZqftQBnscYizISbCv/2PzNvlC1kQ609Kohx8Qu9fxcLCfArls3NDw89uC1byFH
 IH3zpfvDhGy/XokuirkLuAN+ExVTMk4bUBsvbETyTII5gGTLndkqSsp9YHz3CHTT1AFh
 oNoypCP2js8vTHaF1IP6cMQV2TtQWekgPwkNxaHJ8sB6iv0CqGteFOP7kUQPTcSFu4Bx
 TzLiNviBhNE81kMTNw9++X7tVWakBxic11HFf9hU6C7pdnr44z1cUUaYC80GOTzkvoOS
 KLK8LWbsojsIrKAXXjIjtqQrQt2kz/4c5tjzIBEZXG9V6GfdV9GBwHnYIUKtwe4T2zPE
 O/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709757755; x=1710362555;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DPx0WKsr3WD8stnEbU6nk/HiuAb1e9AnM+Gm0M50IM4=;
 b=Cuyff/fpuDn5mFuyeKSOoxB6PhbJHyyBIC7R0HNsl1YCwLyRo9Lnun9qLrpYxPkYnT
 IA4hEk+ccw93FdYKtNQ0ls9L9FpTrru1hPiJsyIYxxqDyGiFtt2hzYnfObNgKYDikrbd
 eSSIV/SSmwvTAnz8Kdj4h0V8YdiE/V0+Tj1oD49Wgm/qTRWf5l6Jza85uE2eecFHUn0v
 VYLUEEKnGPEydURz9zTd3zNwSSdPvSm4S7wAqqyec60Sho0ukGxxiqIt8Lyx/lpyJgT5
 cxI2kXOfP2ikeLRrHS89IY6roszkaCUnQGsarQUWXAlhxCald5+8tI91UcCxbUGk1bM5
 WfAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5/mYyZLfxwy6lkrbCanTmsalY4mkwy2F5w7MjHMP4C5F/1Hl2/OZqxLyPp2b/KJA9KD4t5Z3kqBgDcN2+z1MH0DjGf0c=
X-Gm-Message-State: AOJu0YwRA5kPrOcY/9xTQ4onaFEb/Um3pJ2xkjmXoxSMvC7p0byzXtcg
 6rdqBXJtE34Nsx9oDMsdEzwLxDtPdABkU3AVh4FnWXRVBTxpHLZw1B4ZbsykWxY=
X-Google-Smtp-Source: AGHT+IEJ9ILdKfidupcWR4qRrm9ea8ASr3oQgB5S3mF2qAxXsNXDlMNDxk5Csj1Ukm88AwBsFg1ApA==
X-Received: by 2002:a05:600c:468a:b0:412:bcc9:32dc with SMTP id
 p10-20020a05600c468a00b00412bcc932dcmr12859000wmo.31.1709757755325; 
 Wed, 06 Mar 2024 12:42:35 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 bg13-20020a05600c3c8d00b00412fe0eb806sm367392wmb.14.2024.03.06.12.42.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 12:42:34 -0800 (PST)
Message-ID: <970fa729-46be-44e7-b882-34a87e328319@linaro.org>
Date: Wed, 6 Mar 2024 21:42:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] trans_rvv.c.inc: remove redundant mark_vs_dirty()
 calls
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240306171932.549549-1-dbarboza@ventanamicro.com>
 <20240306171932.549549-8-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240306171932.549549-8-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 6/3/24 18:19, Daniel Henrique Barboza wrote:
> trans_vmv_v_i , trans_vfmv_v_f and the trans_##NAME macro from
> GEN_VMV_WHOLE_TRANS() are calling mark_vs_dirty() in both branches of
> their 'ifs'. conditionals.
> 
> Call it just once in the end like other functions are doing.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


