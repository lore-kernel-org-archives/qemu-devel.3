Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD62C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwqE-0007Oo-LJ; Tue, 11 Jun 2024 04:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGwqD-0007JY-Bu
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:26:53 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGwqB-0003ow-Gx
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:26:53 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a6ef46d25efso414590666b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 01:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718094410; x=1718699210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P28ahqKzuIGVS2J3ZZMcOkZ6w/itYTHmdHzvmXZV1X4=;
 b=G9l68g9n3DtyzxuuZBVgg7cvFnMQHkjyAPxXc8ojAk2Of2GKYl2S6gbf6XFPIXTcii
 XjrvA928fHS9PXSfy4zxsWaimnrQafz8AWzSNvZtcCD/OUNOTlREDpJJffhy9d3SCV+t
 2UAIIU9Wn7KDZw64zgqfnWy8VHTy8qJSfatGLOmFaGM9773a8uHgevC2Q0wAQkzS69vi
 /uKP8PMRMF3o0w1zAoBpUfFhkO0+mHgk2fkN28MQFXKGYVA76HPBdVEukRAwvYuG5mBw
 S4RpWmFDr76Q+amULq/DDJcOcBg55LpbKJAA7VG1CH8FlL8nNXkm4D5NBp2XSYVrI18H
 +1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718094410; x=1718699210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P28ahqKzuIGVS2J3ZZMcOkZ6w/itYTHmdHzvmXZV1X4=;
 b=Beb/ZdHIdQlSKH64+QIAi6XJLo1kDpKhrZLeF2NS0lNQ3SvQ/+3Qr5MgqNBCbL1okZ
 ehXEu1BMeAdbvZR5xsv3LjZiFXeBMr4q3Xkk9KJ/sMnY3ZwHg8dR0laNnv/s1zIYTXRA
 8wcQfmSI3xHB9zRKlqAD0tIxhtXdt5dOwehnnXW+aRDHyTVvyUpOSKzQF2M1BvIMW3Hc
 8pE7fb/ycqQlLA893Umso17fbXRfK9M5VNpbr6PUnuADrQ2OY3e+f9U3rKdbAPZFgQY3
 QDh4jlTHrA97WxoknJZLGeTaQXVbHC3YY+zHRLAtl8EhCSa/jyyZ4uo0OhPKBJEeQQ22
 CrbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrxbf8xXWW0KErwqMWA/+uToxJzOw+ncMVKrl2P3SOMyPXDC/RmdRDWc6TYArvgkDjZG/gKLe+asVoqi5xkZIuw3q1Rxw=
X-Gm-Message-State: AOJu0YyJwhxbwS3mcSO5/qQFfgGZF1mtXy06Zlhf10DxnWSJM/1boS0R
 3wslcScLBG5pOoD1mCqISQrdBPt5kYuZfxzzsx2vIkW5KZb4YDyJqGStjFkjkWRGtnqWwHc3tCp
 i
X-Google-Smtp-Source: AGHT+IFhCJyOImlGg/rHs8TXaQRbkJ2PgX0JvgaBQisCBwWbxVyvuPAaQIkBJT7v9EKMC5V9kRymgg==
X-Received: by 2002:a17:906:79d0:b0:a6e:f847:2cd9 with SMTP id
 a640c23a62f3a-a6ef84730a8mr561006066b.21.1718094409479; 
 Tue, 11 Jun 2024 01:26:49 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f0dd008c8sm395165666b.128.2024.06.11.01.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 01:26:48 -0700 (PDT)
Message-ID: <0b63712f-898b-400b-83a6-182effd6ca5b@linaro.org>
Date: Tue, 11 Jun 2024 10:26:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/arm: Set arm_v7m_tcg_ops cpu_exec_halt to
 arm_cpu_exec_halt()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20240603160933.1141717-1-peter.maydell@linaro.org>
 <20240603160933.1141717-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240603160933.1141717-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 3/6/24 18:09, Peter Maydell wrote:
> In commit a96edb687e76 we set the cpu_exec_halt field of the
> TCGCPUOps arm_tcg_ops to arm_cpu_exec_halt(), but we left the
> arm_v7m_tcg_ops struct unchanged.  That isn't wrong, because for
> M-profile FEAT_WFxT doesn't exist and the default handling for "no
> cpu_exec_halt method" is correct, but it's perhaps a little
> confusing.  We would also like to make setting the cpu_exec_halt
> method mandatory.
> 
> Initialize arm_v7m_tcg_ops cpu_exec_halt to the same function we use
> for A-profile.  (On M-profile we never set up the wfxt timer so there
> is no change in behaviour here.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/internals.h   | 3 +++
>   target/arm/cpu.c         | 2 +-
>   target/arm/tcg/cpu-v7m.c | 1 +
>   3 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


