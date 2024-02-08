Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85247C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 21:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYBnb-0003mI-KL; Thu, 08 Feb 2024 16:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBnZ-0003hc-Jz
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 16:19:09 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBnX-0005vu-HZ
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 16:19:08 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d932f6ccfaso2132895ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 13:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707427146; x=1708031946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qgglX5ExBmqL73gQsR4vVRqWweoxnOFu+yjTFFRsidg=;
 b=LY+wbf+sIUymvwZ/7UATJrjBJ6UPNrlu0xCm1UkWcVGlT3p9vRAF/Aq+V/SjHpF6E1
 PylvIkcO4uhxyIkamRv7a82dCeI4bPT0lUGyNqlLBUBq4Ez4Tfe1j9/DUJnf9pltsQYN
 oPYByyXh1tCn+yKijt9G3mcutqJdgz8xMcPoMvMOx3QEJI6RxolPmt49P1v1Drx8+zOW
 vu0IG0isUtp97tJFTmUEortNpneGAnsHO8NpXM18X9iUT6NtSPoA8EgD2W6HuxPwDasf
 5eM2SYvRttj4ZbAM0ercD4o/Fu49XlAc6+x+jBkbWHq3PuR9XMFkUo+b6wA+uCgs0eCj
 3AFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707427146; x=1708031946;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qgglX5ExBmqL73gQsR4vVRqWweoxnOFu+yjTFFRsidg=;
 b=GmugdkTmE9A/Ix6oiox0c6KG2ckm1Ia0JzAfCZP54s461/l9ZHWiK4mCq3hitDvE/f
 CyNNZMakIvG+/+rrPY07vWydIPkD1X3mNifjGlqpQQMCcHGBPkT20Vax9XWusGVK6p8D
 vSUPtXZQdJfbTPXLUN/LkmwifJwag71yt9ozvf++bcb9HmUWJ7ZahtgK9oL/ytbNbWrS
 XjLm1QhQ5KO7mMFOQJ6sQvDhfuyRwecRSHuFuBNra/1KZgUrfRGiP7pkNTL/xTO95eu9
 gg/IOWth54u3zRUdDF99hPQ2jgcwOpOg/gCkzm/E9X5v208W2+nkLhpZHgqujLLhTG1V
 td7w==
X-Gm-Message-State: AOJu0YwGE8yLhsStNQJDrc6V2SrzZKbS8/TTBVmDgTBJbwelx8cZnARh
 Cmrpa9F7REzZ8V9Dd1FUh19jZZHuY+L9txmKPwhcwe2dsvc8symO33D0N6+W92Y=
X-Google-Smtp-Source: AGHT+IFXewVlTdmlOHKB1A41KjFRNXPn2v73H23VQ2Cigt8zRGIi0WSc7nh02tBzttBZZBaGGh5jOA==
X-Received: by 2002:a17:903:2304:b0:1d8:fb03:a01e with SMTP id
 d4-20020a170903230400b001d8fb03a01emr585447plh.32.1707427146052; 
 Thu, 08 Feb 2024 13:19:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCULzTiLnqCje6KQg+TUKCTNHNpRkq7ChqPQxiDnFQrvwAy6xPkPQtRj7AQ2fotaaBfhDo2UsZwW3RC0+UZ6GOCA5kC5u6U=
Received: from [192.168.4.112] (066-027-223-101.inf.spectrum.com.
 [66.27.223.101]) by smtp.gmail.com with ESMTPSA id
 q13-20020a170902c74d00b001d8d04a4fa8sm198458plq.300.2024.02.08.13.19.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 13:19:05 -0800 (PST)
Message-ID: <0632276e-4fb8-44c1-aacc-877ee606f65b@linaro.org>
Date: Thu, 8 Feb 2024 11:19:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] target/hppa: Update SeaBIOS-hppa to version 16
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240207182023.36316-1-deller@kernel.org>
 <20240207182023.36316-13-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240207182023.36316-13-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/7/24 08:20, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> SeaBIOS-hppa version 16 news & enhancements:
> 
> - Initial 64-bit firmware release
> - Added fault handler to catch and report firmware bugs
> - Use Qemu's builtin_console_out() via diag 0x101
> - parisc-qemu-install Makefile target to install firmware in qemu
> - Added -fw_cfg opt/OS64,string=3 option
> 
> Fixes:
> 
> - Avoid crash when booting without SCSI controller
> - Avoid possible crashes while detecting LASI LAN & graphics
> - Don't check layers in PDC_MEM_MAP_HPA, fixes NetBSD
> - Ensure cache definition does not trigger endless loops
> - Mark B160L as 32-bit machine in inventory
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

