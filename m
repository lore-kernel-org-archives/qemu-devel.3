Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6992CC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 09:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBWm7-00088m-Dm; Mon, 27 May 2024 05:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBWm3-00086u-SN
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:36:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBWm1-0005Di-Id
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:36:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-420180b5897so43862165e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716802567; x=1717407367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yy5PRIVdEb77I/eexM2zbRlXxcgfRGKq/R8nyRoojLQ=;
 b=oXkW1jenTXF+U9TRzL5yvMetzJGXfOCcbUfpPGOIcoxRkvho3Hc/TCiK88mGRFOeWL
 sKwqlRBm0SWSlP+i3JGGLTULArMgwFE5R7DeQyvsnX0BguB8d2OR36dV7BeJiQD0kr6G
 FvaUUNHyIW6Ly5bSjNowUiQtaSWxAkhQJdrVC/7kz7vzs5uRb4Jf65KT8iKmLtHtH80M
 Rkzq0HG3tQdY8OTprm5ikxef3DujSTzNRhL92Bb/9sWF8xldCFpbL+awVPGBHiZVVrMI
 /p4Wo3W5FROpsMFKojUXt61UrHWXZTMcOZ8odlwzpQwfxWg5qlp9oSVG9eCA9pXSu1s1
 ijbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716802567; x=1717407367;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yy5PRIVdEb77I/eexM2zbRlXxcgfRGKq/R8nyRoojLQ=;
 b=K3pquMVCUf+yNnj9MARyr05yyZaKUR6UWIrDgbLd6SMk5mTPJMnm05KnwFrBzHHIKe
 gDO6QADS8HuF5tkpaqmdkLlH1SDG0VGIpw7TNxE85FUdt4roJ7nyTrRVOchxO1qGN745
 JhUGqBLb/aw1olztcUIBDPR285aUiYrhCYAZj0rvijS4J3BX7NmG4Bss9zLXFatYUVTH
 1oN8WazAF/A/Sa13F5KWnglcYvbr6AJwPSmYX07h6c8emDAdlYYQs8ZOUntu/Mn7jGWP
 8o7cxLo/MM+NHemNY3z28tFK16X6zwOAruoQW/OxBzfcjAh1PZcVhFbuEGFibyYtm3FW
 hEBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwePp7aioK5J953n/gNiduHZiFzVSqdhPyEt9hKGRXqMYjnwiDVRBBtg825SCksRk16Q4HiT0xe2V4W7QwyvYH2P3QY9o=
X-Gm-Message-State: AOJu0YwQXgoIzNMBmEsfEbaYWW3B/Vuz06LUSpQGvaXq6VvaAQKSUTvL
 Au7tnzpiIPkn2O7Yz0CrIZGwW8m6omTqyK0ZDmKh6CwmnJWeLYa7EZ6TXvHxExPbNm2ogzAbgOn
 UGsI=
X-Google-Smtp-Source: AGHT+IEQ17KoZzYpZBK/3138NBVTWnZxNigZ5LrrFdfiDHtdkggxZ4AdRSSySS1P6KsQgGoyWJOBsg==
X-Received: by 2002:a05:600c:286:b0:41b:d8df:93a3 with SMTP id
 5b1f17b1804b1-421089d1907mr77539725e9.1.1716802567151; 
 Mon, 27 May 2024 02:36:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421089711e8sm103192275e9.18.2024.05.27.02.36.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 02:36:06 -0700 (PDT)
Message-ID: <bcee2ec3-c3fe-4d89-898b-0f78c5ea7e31@linaro.org>
Date: Mon, 27 May 2024 11:36:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: generate simpler code for ROL/ROR with
 immediate count
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240522123914.608516-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240522123914.608516-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 22/5/24 14:39, Paolo Bonzini wrote:
> gen_rot_carry and gen_rot_overflow are meant to be called with count == NULL
> if the count cannot be zero.  However this is not done in gen_ROL and gen_ROR,
> and writing everywhere "can_be_zero ? count : NULL" is burdensome and less
> readable.  Just pass can_be_zero as a separate argument.
> 
> gen_RCL and gen_RCR use a conditional branch to skip the computation
> if count is zero, so they can pass false unconditionally to gen_rot_overflow.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/emit.c.inc | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


