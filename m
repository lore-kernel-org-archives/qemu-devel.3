Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A090AD4335D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 13:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t92Hc-0007zA-Ou; Thu, 07 Nov 2024 08:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t92HV-0007w6-Hy
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:10:39 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t92HS-0000DP-BI
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:10:36 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4316cce103dso10908665e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 05:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730985032; x=1731589832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BUf9kZ4QecCHPVnx0XEn4abuyIAHebvi0zxc/xewyG8=;
 b=WoS9NZnlP9ugNk3vwPjKW81pXVzCLzqR/GjNVI9+3PP3p8KwHC0dwzYBm0c4QWxkQZ
 xFFM1MMCm4OPqIkk+u1HwYaoGIvT9GLj1SRgApygyyPTeCexwQdXdogqxgeWUvDOqJ+2
 4h/z+s/538ux4F4H7NrcMcegHn5W5ITiUwwsUJhlULpUt+r0ixXoQR4sNbcE9CpAAM1K
 FK3Rg2f7DFXxN5vJWegoM2wBnHu/MxCAgauxIhw6kTYQIDmeWc5t8vqtcx8Rl34Cxadf
 jtaAvX6Xm0KN2chUQTgeRL2TrCzgQASINa0Kl4UlAS5kxrfdlU6AL/KnxCfuhD1EsPsD
 r4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730985032; x=1731589832;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BUf9kZ4QecCHPVnx0XEn4abuyIAHebvi0zxc/xewyG8=;
 b=YMHuhc4efnXTw9AC3vDigEvr3xHSjq19fAsw3mX8mHdAP9mQ8PcjwONjKxoIScoHMt
 CyETWz+UPUMuRYJHcBx/FRmnwG6tKen9bNuKl7hbMVZDT1Dm2BL3BnJUqp8T5ceD8Nkm
 9f7vJcN7Ogd7z4plSnygaTLSSfJH6bjZsRbEBHehIIzhnf4e6lVZiClxZmJs4gsdlz0m
 a4AD/dYDP6p0Omc12sGAmDX4SdKUGxFXsuTT1Y+Ba0Bvx+F0kZzXyS9TccVczkqCFjkI
 oM0qoMcFNaCOSFExvZCwq1u6ibIP/A0YCD/hE/2LWeGc8IG4dTuh1ZJitdNLmsIWz41L
 sF/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvD1Z+zz9im0k+yo8H/EQmDHlHmW486U8iBRxSk5RjURQswxUH+mcWlR1vWC52p/i5cbbpRXPWJVH1@nongnu.org
X-Gm-Message-State: AOJu0YxFH7mqXNM/Vg+yOw5EdWjkMyCSpuwWi8OHUPplUDH1NQO+uio0
 ELxC8L96x+A2VmLw96KtVnJykU+u8+rVObHZ/P8+o8CGCDL0jpWm4bGLa35/QgY=
X-Google-Smtp-Source: AGHT+IFLik3kZSqolID/FCcv42FY46JOLnyeUfOQN1Upmn6vLlsCpc/zDPf+hLB7PkqpHqaeVVt1gQ==
X-Received: by 2002:a05:6000:1885:b0:37d:332e:d6ab with SMTP id
 ffacd0b85a97d-381c7ac4120mr22272116f8f.43.1730985032523; 
 Thu, 07 Nov 2024 05:10:32 -0800 (PST)
Received: from meli-email.org ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed987d95sm1714617f8f.44.2024.11.07.05.10.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Nov 2024 05:10:32 -0800 (PST)
Date: Thu, 07 Nov 2024 13:09:45 +0000
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH] rust: pl011: fix device id matching
User-Agent: meli 0.8.7
References: <20241106185136.582198-1-pbonzini@redhat.com>
 <2ee0bab1-1baa-4b52-9856-4c1fa4c9ef0e@linaro.org>
In-Reply-To: <2ee0bab1-1baa-4b52-9856-4c1fa4c9ef0e@linaro.org>
Message-ID: <ml0lj.kelxgd4xtqc7@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

On Wed, 06 Nov 2024 22:56, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>On 6/11/24 18:51, Paolo Bonzini wrote:
>> The offset that is compared against 0x3f8..0x400 is not shifted right.
>> Adjust the pattern matching.
>> 
>> Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   rust/hw/char/pl011/src/device.rs | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>

The device id reporting is still buggy even with this patch. I will send 
a proper fix within the day.

