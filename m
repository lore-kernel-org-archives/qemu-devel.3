Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A16CCD184
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62ye-0005PX-BO; Tue, 07 Oct 2025 04:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62yd-0005N5-G9
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:23:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62yb-0002rH-Qy
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:23:19 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso43323945e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759825395; x=1760430195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LhkBGrkcQizru5o/RwDfuGYAG1Xze+s+h1beY6CBUxo=;
 b=xnEeltVFD2wEQ3Q55YU9nGwh5eS0yMmMhT9RGggHzd58NDtwdIgJ/quPhB4bdu+hPI
 szwxoSqb7RXRW8RltoaZ30QlWupFUhScJANc6cYkS44MetbOc8vtrZxdXRB6byfjibNF
 eHjBBkOx4KzyuhlAzgFE1tq8sZMY+3M+UKwfQrghjUO32PPUGUxtzcycI2L+f44gdNW+
 6Py4Q4gYQGi1nbOzLmcR7wsX7n+ZeIC/dXOA6WbsVHPA0d+emTilde97bAXtfHXM4NFu
 Z7T8FGIDhQlIvnNanqpvwTICFPOl1kbvHClbyApWgH5dlcaTA5izRESFqTkTE5vOqaxv
 RcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759825395; x=1760430195;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LhkBGrkcQizru5o/RwDfuGYAG1Xze+s+h1beY6CBUxo=;
 b=CoIo+hrrrtAjHwmW1KamubWTOjnIQ+tl1Ax2Jrpcam2R0vq3xN5lIis+h1cAfW9KQw
 YLdcO4uUTQY2I+WpmDtSNkrfLVlLtNcy37guYX+sytCYEB2lbKuLC7jGRaQhPFNqIUie
 Niy1xyJob3HB68CQv3w724UUdHceISRRA2aD7WQMk/hPw2EOHgp3XY1FXnsVtKoYoX8Q
 SqSN1UXCf9wx9ZpD1t6ZHEtgg816h0/As3XafJIzOJ/HR6RGSilYxiI8Q0qfYaAr04M5
 l57LbKB57mvuoROtuAEfq2Wx/GPv5LGEqrFn7Y+y2PsmL0XO89/u2Gd0RDJYRL1Vkqsq
 waQQ==
X-Gm-Message-State: AOJu0Yz9M0SNnU1KfBHGdAY8oa7drat/0+v9LAfuo/fMXZ5+FdWxV8Fx
 8SCs/U202aCITA7t+Bpr5S2ubzJs1TX2fyk0FpSq6/y4fsWF6unsPMbrnd6sqFOx2rzqmi+tWsL
 Kwj1dmRQo1g==
X-Gm-Gg: ASbGnctqbb9/YZAwYO+I4bn9mPAh0efMq1S4BOiZrIvoJX0Qqacxp67jMY9AyYuEbjk
 dasae8RiMVi2muJHcQ+kttp1uCTFVVdJJ8cp7SxDpiTpJsDYjjjp62hU49NAlJsupUNEKjUvx56
 JaYD/Hb8ntCiPHWk1+Zjo9DZT6tcKoTDt7qwrw62O2M/lyDMgVHcQRw3o4hIJXpMVK3xd3i/aNs
 O7FO+TsCpOs6/KRxog2DOx8Wa2Bw6KvM2sMO5iv40myFoTW8AVk787BK1mDlTa0bFiF+45SVKtS
 uhGiL/NJFXf6xIC0y58dYHbvZ7TTENTZ2oipnHBPGmTZqMR/WvP/HeK9cXA4eiB6c/ELp9huZG7
 rVnnWc2dYtHBPjGhPFrCrQEUKqwgUfnpUEvjLjzfRoPu70Zfc/gZPxkG4UmTxFemAH1VRpem6iv
 +6ZObBJYFrAIBNOzSDqsg9IrbHc1+F
X-Google-Smtp-Source: AGHT+IHFCv+tRgvzYJ9NM3tRgmLIiPsBQAp3pkh09U9UlZvlRq92P/QUMSiazjcZRUiat77xzVMiVA==
X-Received: by 2002:a05:600c:354d:b0:46e:6a6a:5cf7 with SMTP id
 5b1f17b1804b1-46e711026c4mr107567795e9.12.1759825395519; 
 Tue, 07 Oct 2025 01:23:15 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6daasm24705348f8f.7.2025.10.07.01.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 01:23:15 -0700 (PDT)
Message-ID: <ee598083-e266-4a05-b632-9bb6f56d0903@linaro.org>
Date: Tue, 7 Oct 2025 10:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xtensa/xtfpga: Have xtfpga_init() only initialize MMU
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
References: <20250925013513.67780-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925013513.67780-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 25/9/25 03:35, Philippe Mathieu-Daudé wrote:
> cpu_reset() should not be used with an unrealized CPU.
> Here we simply want to initialize the MMU, not the CPU,
> so just call reset_mmu().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/xtensa/xtfpga.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Patch queued, thanks.

