Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0566109B467
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Yoa-0001MX-DA; Tue, 31 Mar 2026 09:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YoY-0001Ka-8g
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:07:26 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YoW-0002jK-Nr
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:07:26 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d02a71526so1049819f8f.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962443; x=1775567243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ImOpE9AiA2HDI0aZmx/p6wm7Ofe4Wr2IKsnTmQi3p6c=;
 b=phSFffRryf6fjyZ6JrFZ0IWGIFjauvk96V1G8nDofX6twaX25BaExHOnSMkZS0Z80y
 oc+74FEOUZkR5nc0rks5ahioqWQ0oD4HydlUwGQEuSKWr5FmQzlSBna3cuBjKSOwPNnP
 +HDh8MKlVX0A5VsXUbAlVln734ZWZiIea0sDAGxFVgr6H8vC5X1jsNbd50RaDRpM4Y9S
 bzf7DXGPhDmK5pv25+bwObg6evoIB2G/2ZxRZgRiK812EXeKdjixguQMc7mAHyP8CCqT
 Oe0xCRj8WvTUM7Lr78c8lajywKfBQ8yAsYMJENT9WnbKn1yObGiE5CYLRVlRIGu3nQjn
 kZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962443; x=1775567243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ImOpE9AiA2HDI0aZmx/p6wm7Ofe4Wr2IKsnTmQi3p6c=;
 b=AfYMhUK9DSoTgZUWxc+5qHWZoNFPnXa7g8aOr3YbEk2O1shWrwBMZPifNNudiR7Gyu
 0M1o9NY62ERfD2OOw+jeEjXUBgCl6ImvH+P5KrErQGEziiVE6OpgmX1BZpH33HgNMjXw
 Ph4XLYT/piVUnwMP+FkOsi8/X96N8RwHsfllpM87h22e6NvmYqsR0Y1CFo2S8zPZwATr
 loxiFjH0pFmuiQNUatMPGeBqTvvDUHm8vMZ4g3TXseJKdvhgmWtpqRRHkKcJUa6s4zPg
 RtvUhIrees/HHLmthsWiaGD32ShGhHBqVGhl184pDUZEcSH3g7eKpAjWmw3Q9UBXSQq4
 xReA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1Y+hFsWf+zjUJHX1kSzgGMFnqM3Gpbt/ZP8kXvar8nCRBLBgLc6mQGzgSkbu4cIQzMfaO9BZwDf7h@nongnu.org
X-Gm-Message-State: AOJu0YzN/rQ2+AkV5tTgFxIEhu7IvloU9tIqfvqDejMd4/cFumbcggfd
 cWP/jtVn7g+BUfh+sbUIpLZwpmYfkxpsjQN/NwcusmvmY1L1w6fO+QDWWITN5QxwBxSvtF8OYqR
 JtRvzhrs=
X-Gm-Gg: ATEYQzw3NRy12M/EamSdBm6Zckth0IhHu+/9gEYgnOYd03lrdfMjx/oRmjq2be/Dzf/
 o3eutiCd9WGJWbxdEGRvMerLRq9qQh5y8PNVBmEgMSNza74rCT+r5m8novJgcBF5YPtVadzPo/t
 WGaUUivERf/MzrpvFwwkHGJY2JRgNdMydG5xybXU+f0u5u1WVVcd/3Wm0zf9Tr7FtSXzBUoGhsV
 ePKB5/B9tMidJ72pQxd+NezGPVlNM4eKJoYiU9wxcuGia6yhDG89QDrtG9ot1PQg/LCyZWnkG3q
 XIrH00KC+stV98S+ULOzy01wfQh9k/wPmHXcWerUYKjdgfa75Yd2/Sj7t4ZqHYQOgt0kjBAzBin
 IhBDJTUs1Twx5U+unWAHReyd0D7DC1Ev7lIXdGhjxJuGKV1XY46KqaU9icRsLHGVeGbmvFLFD3g
 HywBDGT75dYiiRMskukJIzK3LWijWM4stwXmt33SZu7anC/+rycFadeLYnZA==
X-Received: by 2002:a05:600c:1d15:b0:485:ae14:8191 with SMTP id
 5b1f17b1804b1-48727ee99f6mr268363275e9.5.1774962442961; 
 Tue, 31 Mar 2026 06:07:22 -0700 (PDT)
Received: from [10.193.39.66] (43.149.216.82.rev.sfr.net. [82.216.149.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e822078sm43903575e9.9.2026.03.31.06.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 06:07:22 -0700 (PDT)
Message-ID: <a3f6359b-36bb-44fe-9996-bb80c343b3d6@linaro.org>
Date: Tue, 31 Mar 2026 15:07:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/cpu.c: Correct minor grammar error in warning
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260330151309.1786787-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330151309.1786787-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 30/3/26 17:13, Peter Maydell wrote:
> Fix a minor error in the grammar of the warning messages
> produced if both MPX and APX are enabled:
> 
> $ ./build/x86/qemu-system-x86_64   -cpu max -accel qtest -S
> qemu-system-x86_64: warning: this feature conflicts with APX: CPUID[eax=07h,ecx=00h].EBX.mpx [bit 14]
> qemu-system-x86_64: warning: this feature conflicts with MPX: CPUID[eax=07h,ecx=01h].EDX.apxf [bit 21]
> 
> Fixes: 91bc4d81078a ("i386/cpu: Add APX EGPRs into xsave area")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> As a side note, it seems a bit harsh to turn off *both*
> the conflicting features if they're both set, rather than
> removing only the older one.
> ---
>   target/i386/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Queued via hw-misc tree, thanks.

