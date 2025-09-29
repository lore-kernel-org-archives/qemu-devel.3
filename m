Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DC9CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 23:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Mt8-0000a6-La; Mon, 29 Sep 2025 19:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3Mt1-0000Vk-Md
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:02:28 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3Msz-0006nz-Ei
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:02:27 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2698e4795ebso54944305ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 16:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759186943; x=1759791743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KPQiasIK8QQrqRfnx9hkyJ3s4JJz+SS06xvPEptv/GA=;
 b=M3Ub/DRsL6wLNtdZTJJzyLEtsyIMarrCIqt3YD1wujF4sfQ2QeVS1PDWrZyB7GAhCz
 IDYaPwko/zjzLMOTp4wili54NpzGYm7ApVgDx93XkkwXj8uuQH/zv/G31agLC8votEg0
 vlyboAVRyUdDAPoagJsNLMGMESow56WtyAUDyJH3l70i39dVflklrnLqt9InWJa04pWQ
 AG2ovOvRewlBJuC1qGjRBTfVKGSx8Znb3447oq8LCdi9ZA26mp/12SeWteHEMyiQo7ST
 bWLoADme0rfHmGiCGNcnpMZpExQIxbVS5OZ78WzEAufKeO1guP2X/EI6BHrhrAvdKOk3
 MLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759186943; x=1759791743;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KPQiasIK8QQrqRfnx9hkyJ3s4JJz+SS06xvPEptv/GA=;
 b=t+WJW8joUvc6DNtV304HN0sRmEwvraveC/KIP09ySfzQXNf6JRL6rpkP5asyShUeNr
 CG7fjhLMP28csi/rX4qpqZ0tTEfj1jHB7O4Q3z5OckcfyO6nZU/9cJByZaPjMRRZxEns
 kM9YpN9mWzcMMZzVImvqm0MeRztqf7a7MbQ6FrsPga4kGmGABxWmoNZopR29MbzpK4Ev
 Y0ZWjfP8Ry/R7aluDUn45hlS0kFUGvqXgZ0BdFdUc8jbaR3PFwffIoJVMnUsll245sfb
 AOpMM3MGH5cD2//nTREzOzeGIZ/lzxCKMVAbhBan5VOGVzTM+zHSsjWx6EzQqerXu6j6
 WlLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlW1hKMIu0oGMmBsFcfE2rPkEImlw3607pthI39sptAjZ8V0sLsezEaseg/c6Zeoj1PuuTRqqIAEd8@nongnu.org
X-Gm-Message-State: AOJu0Yx1iytNq3aH/SO1z2hCCjAYG8Mmi5fK8+HvD31p3aQG/fyiJicv
 bqE9Aposun3IMb+72kLuN+If45HDwu13MWeEOyKJj7MsIO/KTTnnIYxsLJbfsmDoCBn2kw3kaQw
 PiOnXIxA=
X-Gm-Gg: ASbGncuMY9+6fYVvah4Es7IfP579Oc7+lezT9BQw4evDBIS6lzM9xCEXvPUOgLEa3l2
 ueUYyWoVTWbzEPM/t/LVcbcH3pK7lcgY/X3M9SEPTK5VIQa9solZ0WeHjBlPpKpM8B/M1+OmQj6
 Qsgh8EgLHIDiBmr8y3lt1NhnzpRwoyRHB3guvJIOASaRg4ubAIwhWNmsIZj5T6VGOe4HY2mLLAB
 bx/fp3rMQY/THxfMYFhbeG7V/fOK8bWLMi7zs49NorvWxRvYZe2MX8ELJuT48Y+uYhgymaSkMX5
 uB7ZavMZoulLTWUfWN6fZ/lCBmOjynQ2VKiMP2ahCFsBN6SNzV7C58vm6vOCnYHN15XR0pUBvRT
 VEUxQEYn2Iwp0+LwfMEpUbqEaNaGsCqdsFCmd8tsatQTBSQ==
X-Google-Smtp-Source: AGHT+IGDoUEgnOgFNdTqwk+c7q5XTcIDxAYWcHH+BF8bRAsJj4CC3RTp0RUu77/x9JdfFOJHUnNRsQ==
X-Received: by 2002:a17:902:f548:b0:278:bfae:3244 with SMTP id
 d9443c01a7336-27ed4a89272mr241695805ad.54.1759186943376; 
 Mon, 29 Sep 2025 16:02:23 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed67076ffsm139465855ad.39.2025.09.29.16.02.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 16:02:22 -0700 (PDT)
Message-ID: <748e83e5-2719-4cc0-a73a-1de17c73bf1c@linaro.org>
Date: Mon, 29 Sep 2025 16:02:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/arm: Enable FEAT_RME_GPC2 bits in gpccr_write
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250926001134.295547-1-richard.henderson@linaro.org>
 <20250926001134.295547-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250926001134.295547-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 9/25/25 5:11 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 5 +++++
>   1 file changed, 5 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


