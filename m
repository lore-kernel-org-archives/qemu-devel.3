Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0FEE83856
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 06:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsEvZ-0001O2-D3; Tue, 17 Feb 2026 01:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsEvW-0001Jm-6S
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 01:51:18 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsEvU-000766-DC
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 01:51:17 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48329eb96a7so20246595e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 22:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771311074; x=1771915874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cTKeTtulh4xZljYtMeXi7Zzv5jjQ2xB7gfYXEyx5JsA=;
 b=Rk+p96/cweRJNX9GLSZ4s+KgDUR87wXr6+r5paAvz3aFQ4jvxRorZBBujKV8O+fuw6
 nisgD8n7p6DqJo+CHbAuqAHSTK89vr+6wmi7sJe8qvBDBSOB2/nG/hLgYOIbReqejMnr
 I4M7hBZKCh6cCTkY0+JPPYkzOW552E+vahki4WOQj7wm1pY8IGImbaw2q/Gq9OQp5oHZ
 4V2pMyfP1o5C/gN/oilqhNCYHkLfw8+v5DkbFIqPOw3oBp4qq4uHaBUxWPlXideU5RJp
 9Rq8pOzTGBs7lZW34AmA27mPFUJNFlWNX/gjr4z8q6rLFXl1dY/+RZO7cs+KSaZ+VHyR
 5SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771311074; x=1771915874;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cTKeTtulh4xZljYtMeXi7Zzv5jjQ2xB7gfYXEyx5JsA=;
 b=qdmF0YuCABIvfYd7AQIFFzQDzdEiIu8FlJkxaRaAVEGGrSICUBgzN2gcWcd0Z7bvi+
 BsS5mP6a127eRW6NzCJ2hP4YqEgHRgK3k4kykaY924ti0zStwvcXHQ7Yn4KhxuP8kMET
 XK2gl08LMz0l8HwDbnjXSFrm1iI8UnXLZzIuEa4OrCMJVHC+6+rp/RWiGQp2zhYh632b
 Rl0k0yKyR/1S6CtL7IENhbqZnqYrtY3pBoMd5zdSmsQ7mh9GG0k5xaOj4CcqeNLC0LHj
 F5DDjPcD7VNNrerOqTwmrW34lSBok3ZUpjWuDHY3ptFjpA3hEYgk916NKTD6pvwgahmg
 S6FQ==
X-Gm-Message-State: AOJu0Yxhp/xp0fBJEANt+q4nIeJUMUnpVvUUzdBcPZA3ZUwTxRoW4f8W
 lcmAvHxzl+B29Ev4+c/WUmGw/I1iJYnoZhgiHNTdnEyyhLpoDeoAbiprMLjlHrEZPyySk+VteNC
 oYVPvgzU=
X-Gm-Gg: AZuq6aKIHCB2tfPyokHSw+9xwsoz0SVRhJXOZO0SsytCKJEGzS3AklNEdavkLQ02czf
 O6tg5RgvofpXHM2bz6dA/EeiQa3yBfrHgNF14udLtdDQ7FOr1VHmW2FLeUm5txLwBkRxFP5zUy5
 Ml08Y+zCbCeXurdW3EdglaxqAI9IRH35sWPvutIDNb9wiqg75TVcLflBbVfU6kpnVaaPs8qjnBT
 TkcZbkz4Sx6B6nH15nhk4yXwjUTOvvXYUKHZD4QazsOO4E249l/p5HmPC5x05blbLCK4GbH62NG
 pGv8jO8ayIG1KJoVSGNCAqJpJUz7CTB6Ly8Hf3MexcXmoDmVAbMSrky7KW1Plh2Y2EE74seO86Q
 SzemIR+ZttdxY2EVeNMa4qtBE4qHZqvxUy8iGT7xhyKLELm3YHNefLOnnc/toC7gPdgZoaMIUxp
 92lfwT2JKVjjpa3TfCeptR0QDJS/4WYtbovuOtpzedZWKYh9ztaD3Xg6gcONs5dOO+qg==
X-Received: by 2002:a05:600c:c108:b0:483:78c7:e1c1 with SMTP id
 5b1f17b1804b1-48378c7e1d3mr152102665e9.12.1771311074274; 
 Mon, 16 Feb 2026 22:51:14 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm554494705e9.6.2026.02.16.22.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 22:51:13 -0800 (PST)
Message-ID: <5acb7c2d-5ab3-4689-9e6e-ae46bee05875@linaro.org>
Date: Tue, 17 Feb 2026 07:51:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] monitor/hmp: Handle gdb-xml exposed registers via
 gdb_get_register()
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, unisono@quyllur.org, qemu-ppc@nongnu.org
References: <20260216225228.53959-1-philmd@linaro.org>
 <20260216225228.53959-8-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260216225228.53959-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/2/26 23:52, Philippe Mathieu-Daudé wrote:
> Implement the gdb_get_register() helper and call it before the
> regular get_monitor_def() one. Registers is exposed via the
> GDB XML files will be directly handled, possibily allowing new
> registers added to XML files to be automatically accessible in
> QEMU monitor. All targets having GDB XML files can now be used
> within the monitor.

For example with Loongarch, before:

   $ qemu-system-loongarch64 -M virt -S -monitor stdio
   QEMU 10.2.0 monitor - type 'help' for more information

   (qemu) info registers

   CPU#0
    PC=000000001c000000  FCSR0 0x00000000
    ...

   (qemu) p/x $pc
   unknown register
   Try "help p" for more information
   (qemu)

and after:

   $ ./qemu-system-loongarch64 -M virt -S -monitor stdio
   QEMU 10.2.50 monitor - type 'help' for more information
   (qemu) p/x $pc
   0x1c000000
   (qemu)

Similarly RISC-V:

   QEMU 10.2.0 monitor - type 'help' for more information
   (qemu) p/x $pc
   unknown register
   Try "help p" for more information

VS

   QEMU 10.2.50 monitor - type 'help' for more information
   (qemu) p/x $pc
   0x1000
   (qemu)

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   monitor/hmp.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 46 insertions(+), 3 deletions(-)


