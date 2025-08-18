Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4295BCA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 06:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1untBq-00020b-Pa; Mon, 18 Aug 2025 02:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1untBd-0001v1-N9
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:17:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1untBX-0007PU-BU
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:17:39 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b9dc52c430so1740887f8f.0
 for <qemu-devel@nongnu.org>; Sun, 17 Aug 2025 23:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755497850; x=1756102650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UaYRKbe3ZCB4ljIMRd5az/DexuULkRPJeujHDq9qu7c=;
 b=Mbvo9Ws2SthGGsCSFaxl1KFh98ONC/tOCUF6zKeg2DlGqrxP15J0vpsbWKa6PWiucV
 SlAiQYhNB4Idz9fGMA8i8xspe+WTeVq73nZqg/viMekoDGtwf3z3xCLHgpKh94F0+/qV
 8lKbgJ4HndPN2HozwH6lOvg7EAoiYdvnorS9kOlOEKIZeLM5NQ0A1cxMQKHEjMP8Mpme
 wJs9o3ciMIoWRZHgeod0s4p4zNTX2MJ/bo4ePQxfP0tPqeZbKr+Wz4uAJlEXFLFrcjaG
 bbUEJkQPQQ2NWUtIuDrzby5xbDVkbWxWQ9aL/LtQVecqDeTwXoYzCEWDACBvINehAze6
 O2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755497850; x=1756102650;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UaYRKbe3ZCB4ljIMRd5az/DexuULkRPJeujHDq9qu7c=;
 b=OIsKipiBzqBJqFhGc0uk1KH8GXy9umROG42s4R4+7PMj01DCDHfaSHWTkNKAP27N+J
 zdcENYVdCcPLF/VGtB541EUYN2DXbs8/msm9qfuaD94tVTMhotzguRS9+lRsSgaaUJMM
 bOLdmnPF1RPtEKUXm1pB4W/Bg+cF53JonGg0NT6T49nYapoZh29xPLR7vGqyzZuNIp7i
 iotmJExDWHfx3Ts4ocS74w5pbYnmALhvCkipMis1BjBkyM2x38OD44DDtXtHrJu5hyXg
 zkJucdn3IDYUNqlajyolvCJGuLNiDbTkIUpIufIiRcFYUvlz7C+nz8DlWi7RlcUKyaLL
 6ocA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA0O/Q2a40gS4Xmr6rV1e/itNfMYpNARtR++Sclt+40dybihLIcSNI4Klbmn1AbQclvR8XiftpKDGn@nongnu.org
X-Gm-Message-State: AOJu0YxS48c5KOunqwTilyfwR3qls/CRc48Odn+U+DVH1Nc0uDaypAtB
 aSI2TH8cDDAXBMr4UB4tiPnbsMnWxcstN3vW8hVx08NZTZEYS4wXLWjHgxHCPmhTsy65J+whHWG
 Ai4UW
X-Gm-Gg: ASbGncuxNj7v6vF4o8Q0XY+hbicSjRiKpUF07g6tKBb9vED/FXVB6vAoNUDtKL0JeMp
 ZNnlWwkLSrV0qEzvNhLIYAUmufG1nCGV3HFb2EIdhZBR45XV8fsRGWrs5zyIyv89f1GhI+vrh/R
 RXUUPPgqfd7LI4A6zE5aCOZovxxzJYo0dHHZ2Dkn0Qj2kBJJuu85hoG9C0mnmN5FEIo+JCQamCe
 /pk0hywA+Wbbi3PjZ1QecJg1qfBNAKfNr+UPiOQQbuoQ5y0jz2O44Q89YAQlZFP0gr8wXS42Y7n
 GPJYcg1Ea8giqPERmkyfODreRSIcCHMVPnuHqrKdQk0v0UCFrQttae+/QnvqMVYxbA6qMlf+Xgc
 LsyTiVnFh/g+zuAcjEAlbbGcSyIK7/SyNyLftqNpSXrjWEg38vH7yyPzNiryVIdxtNw==
X-Google-Smtp-Source: AGHT+IGEwDxNzKN5K+myiRAR+Hrj9Wt1aNQEiTltR27F1w7KqIpz42O5hiYroHOOLHmcs8KrKUaoYw==
X-Received: by 2002:a05:6000:250e:b0:3b5:dd38:3523 with SMTP id
 ffacd0b85a97d-3bb66567ae3mr8083337f8f.8.1755497849949; 
 Sun, 17 Aug 2025 23:17:29 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c748a9esm156887465e9.19.2025.08.17.23.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Aug 2025 23:17:29 -0700 (PDT)
Message-ID: <d1a1b9cc-578c-4aea-a1c3-f4323fc89e06@linaro.org>
Date: Mon, 18 Aug 2025 08:17:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] target/arm/hvf: Replace hvf_sreg_match with
 hvf_sreg_list
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mads@ynddal.dk, agraf@csgraf.de, qemu-arm@nongnu.org
References: <20250818041354.2393041-1-richard.henderson@linaro.org>
 <20250818041354.2393041-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250818041354.2393041-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 18/8/25 06:13, Richard Henderson wrote:
> Change hvf_get_registers and hvf_put_registers to iterate over
> cpregs_indexes instead of hvf_sreg_match.
> 
> This lets us drop the cp_idx member of hvf_sreg_match, which leaves
> only one member in the struct.  Replace the struct with a const array.
> Instead of int, use the proper enum type: hv_sys_reg_t.
> Rename from hvf_sreg_match to hvf_sreg_list because there is no
> longer any matching going on.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 45 +++++++++++++++-----------------------------
>   1 file changed, 15 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


