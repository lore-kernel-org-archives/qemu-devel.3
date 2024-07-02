Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDC0C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfnK-0005e3-6z; Tue, 02 Jul 2024 11:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOfnI-0005YR-9Q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:51:48 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOfnG-0001iJ-EA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:51:47 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-36742cc9c12so2889527f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719935505; x=1720540305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XGFCpeal+AJeTPFXfvST7Qrayc9pVZjCQTEoFN/8DTg=;
 b=giUFBcE/jHu+leoy3Kmj7b1scNa0vnev5EW9+1bpyoZIRCfLFkiex3r7AwTQ++8GCx
 wMt8z/6n0Hm3gTBDFQwJooxqiPozFnSfUwlNULbH3e8MDitGL9muQP04krJPwb9B8973
 ThEKUxY7R2wA/v5pGzVvR3UR3/zGH1Qw/cxgL0bdCM9+LYGbLZg4BIhxBynR7dL/wQdr
 VkkEMVWiUk5EPdpDAHyt2xyiSPjBmlgIBY6JJyEbvwJaN+EnfLG8IO37prZMKrHv3Rry
 i5ovNNr92liatkoZAkMexRMhamHfVSuZtuV/Q9mfSqnyZ0H+ZfE9yQRCveWMYFlruYUX
 tmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719935505; x=1720540305;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XGFCpeal+AJeTPFXfvST7Qrayc9pVZjCQTEoFN/8DTg=;
 b=Hx/gA/603keupl39BQfX71V2RMuXsXbg6AF2VdcVvg29U34XhYr/OTKBjshjf00BMX
 RpsrRd85ajTd664Wszel6mU2qY49qf3enuV7yEhIO9Q+e2jIpoG/NT9VQdlhUSUIc4pV
 cgeTnxb3ItPq6XdeGhrPDJtnuzVq9EfU7E/zvuUb535FnedQpRr2DyWTJJymbDR2Qh3k
 pFi9W7cbUIFPIGs3TXjj4Kof2U+OPxnKBghDqiZldLUALCEri7gxwGwk5VEgT+cpEV8S
 nYnG+1nkCY4IDJFUn+gPHjaPZIDwYdm3LbRxjvXKt9AY3S82w5yfyUq8Q2ooKL2fOmLo
 8PTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVBSRifLypZIkikO84Oai3LnUs6D3ZjYXvkxT0ep722N5TCbwfivl91X9G7ISCJM5QCoBKq2djoRDiJafgCwn4GxwGJWc=
X-Gm-Message-State: AOJu0YwdTLKZQcrTakx+4F4ao0GTfwV4GDlJ41AuAPhBSEkw8hCD/0ei
 ohefL2Kco4/NMx66bkGqfP+izmE08Kso/3/aL9S1YjbIaVHVhZ6JeVlu01sVUBc=
X-Google-Smtp-Source: AGHT+IEKomvjqlq2pAMi1FcYgmzvzqPx9oNPuekDMU4aIQTFh/qevQDheTDiQTSzrYx0zlJa4HLYEg==
X-Received: by 2002:a5d:64e4:0:b0:366:ec2c:8646 with SMTP id
 ffacd0b85a97d-36775724495mr8657476f8f.43.1719935504933; 
 Tue, 02 Jul 2024 08:51:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fc4c9sm13594444f8f.86.2024.07.02.08.51.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 08:51:44 -0700 (PDT)
Message-ID: <6859017a-e2ab-4762-a853-aa52dba7a4ac@linaro.org>
Date: Tue, 2 Jul 2024 17:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Use cpu_env in cpu_untagged_addr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240702154911.1667418-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240702154911.1667418-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 2/7/24 17:49, Richard Henderson wrote:
> In a completely artifical memset benchmark object_dynamic_cast_assert
> dominates the profile, even above guest address resolution and
> the underlying host memset.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


