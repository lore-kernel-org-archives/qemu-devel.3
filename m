Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9412C282D0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 18:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpAcc-00069O-8E; Mon, 03 Mar 2025 13:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpAcZ-00067b-4F
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 13:34:32 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpAcW-0001OY-4P
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 13:34:30 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so2672533f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 10:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741026865; x=1741631665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yWxRzlZe+jHNOYKggML1w1WohV/QAJ0oYLml8lizNoY=;
 b=tsas/6AI956Hm9C3vA5MQVokCpFV4rZ7Vfnd7EjtI8/rZurlfaZXjJ5sR0nYKspr8v
 Fz0b9sqU2sdGKNS+Ow7O41E1XZ19bYKCNzVXGM/9bxCa/GV1kePGlLsbhU9Torbn2uuZ
 IkXSKV+7RhYAq485FlerMkCbjcXGv9ekWXoJ4Xb8gs4TxgGueaqNvPfke8wOD+IvCy5/
 FetD8dgAySf7HOPYsIwb4TfmUFQetNbuiqbWDnVB0hDg4MYZUvcVJ6sCHahtz7yMYOZt
 XFXIl19fDtwhp0kBZvD/7wCzRrjCnYfBzrVvinmR1tAQlni1wMBMpQNdXnw96Y/B6+M5
 y/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741026865; x=1741631665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yWxRzlZe+jHNOYKggML1w1WohV/QAJ0oYLml8lizNoY=;
 b=YoyxrYCn2e2Sk5fTO2MGbb10uRIyv/RpuIMKyP5LnTRRBXquutzH4VFN761lFR8s5J
 zpp5FU37CbHndGM/ZJ0wYEi+Sqj6zUDCftLAMLXvLSO2Xzyv+IF2Sumg7RdeCWheQA7+
 kvkGH0qbl97+uHNCkUt3Pri+oZCGvCIPkEPsCR9BoxsiR6Hf2dMiPUZahyDkDg6+p9V3
 Ti6EX7chWUCCd8Bmtw6wkQRLd9SMAV4cp/i+Eo6x3x2khONH8EJSJacSwZ3saZ1+MTNF
 0kmPNNv9jwru/gcxvhWcz/dxncZq+zwmvhxXc5ZBAubcaH670ng4AT+W+Zmm6xiRVvlW
 UE4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdfB0aJhJoW8+sE7JNvLpnaOJymwQEEzpppajT8efE7SZ5GtfR0UbEsOzGuQEmOCEV8z+/bICG1OTQ@nongnu.org
X-Gm-Message-State: AOJu0Yz7UxtNAESN1PtAJJ9T2gobNWbTD4oHF986k/bfRsoTq/Pp7jWy
 hQdcRXYZRoP/U9d5Lp2wLjFOyoX5RmbQvMwA1csVOw3MH6O3DMLxUJGfa80YpIJ7FTZTSDCFt3+
 qO24=
X-Gm-Gg: ASbGncvabJ5vjfk+uPoxSPbWbkQjTdV7ZVl+g96sdtx/1/XAetV5ZufvjYcEpH06ZTA
 jJ1AEdDNHODZI/a2TeGPNLgYDqwEtj2xw10QfqEvx6mv0CqhnwuQdqeBBnvsMhI6S2zxkCykfUe
 U6xkblDeqyzNVrmnFpQg1RHaa9Ah4SMtRV58wR9cSipryIzaHrhUnhkfGx548EjIVeHz+bF8Rzd
 GCciiaacO0FoCfR7iw9tNTCnOErkjCv8p2US8qEGAzL93sxwhv9eao5GUDvWvWj0GJ1v7u9Ze0N
 IuYpZCTM7u9SAYcONyloszu2U4ik5e0a8q1slQz6wsHhhQs1CBwVVc+wgrar13HGC+r+9NsCeWS
 6vZDi2YFVKEIU
X-Google-Smtp-Source: AGHT+IHRB8qCGYmmZhAtn3nbtu35JWLxYFT9WB8DSPr6uTRf5prFVzm6gsQF9t/1gr0gxgSy2oiDXw==
X-Received: by 2002:a05:6000:2ac:b0:391:42f:7e94 with SMTP id
 ffacd0b85a97d-391042f836emr4805426f8f.18.1741026865712; 
 Mon, 03 Mar 2025 10:34:25 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba539466sm206181115e9.18.2025.03.03.10.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 10:34:25 -0800 (PST)
Message-ID: <e2267f46-dea6-4881-9313-4493d68a6662@linaro.org>
Date: Mon, 3 Mar 2025 19:34:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/24] target/m68k: Update FPSR.EXC
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20250224171444.440135-1-richard.henderson@linaro.org>
 <20250224171444.440135-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250224171444.440135-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 24/2/25 18:14, Richard Henderson wrote:
> So far we've only been updating the AEXC byte.
> Update the EXC byte as well.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/fpu_helper.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


