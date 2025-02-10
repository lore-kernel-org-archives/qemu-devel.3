Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0FDC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 19:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thZEC-0004sw-K4; Mon, 10 Feb 2025 14:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZE6-0004rs-Ts
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:13:52 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZE4-00051d-I4
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:13:50 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f62cc4088so48728185ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 11:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739214826; x=1739819626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+A4au3vXJN4SBI9FUHGja5KpFxEw5x7W8EVXZtbwkY0=;
 b=mhak3fH95+HNOVDn34B5r7pGVlZzRTe1XJAjsd1UNVxq6fRRNnHax5Krk0vKvq2p/q
 FORfaaRxY/t6SssK2UQHNrwKWn9YkuG951d9b3fJCOSPuc2mo/hgW8/p39XSUHUMJkX9
 SbqjkeyuoS/XW5UtotLn3yAxWrPeS6Y8bi/p40JzPBmucPg0DwNVwaAlAs8aeG1Kq0ua
 MCCWowF4xlsy+lSvcb8OBaATmWW8vrfZ7REWBZt+suduM28Yy2VkU6YCRGBr4RuS/UqE
 EXOzZ3qxDkEogiBPxYPpfaMJ/6B03ehjh6tyjX/lvuEbXI4AYmj9wfYAWiYrOqB8cLEC
 NS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739214826; x=1739819626;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+A4au3vXJN4SBI9FUHGja5KpFxEw5x7W8EVXZtbwkY0=;
 b=CmfUTPf1L0/UYHYK+pTY3vW7YA7+fY0ZYNZEqOdST38S9U40frdUWCIdiLzSKs7gde
 hSlnXd4nN+L/fGBWdTQPq74O2lo+FMFVoyrI7qaGY1/ufTy1jscThmtnp7g6WCJ2fJDY
 oRELhxAH7BeVXS8IxAsmfrCKUg4Hj2znFdBc9OyY9YzM4V8WdNU+vrYuQgmUuaNlMp6R
 oGrGYTvtfY2kEJAiBgsATvSdnUVsnQUnL7PCX6JzHr9KFXlAVx5lPpn4M/fwvkZbUo9A
 FLDESs2fZmu35pN3wIMopLu3Gf2B9jzaPN8LWuQmUR8HNk/X7YfYmr7PRANBv5Hbnsz7
 UWQw==
X-Gm-Message-State: AOJu0YxDS84YdH/wPoVVN0QWCYOG27wdzinc9U+yieNSi6oUNwqm6HAG
 nkVNV+pcBmPb4hFABRew9fK/DtwplNTWra8NtuPs6EaEV1kDshxL8CicW6iu0Znm/hOhFDfEHg9
 K
X-Gm-Gg: ASbGncsDti3gzOwoU6VtXKJOjTSgqWcbUVcnygfxrUSrx2oiC/x797YNcZooqayWWQl
 qPemvifouplHY4+qZRJ4m03fn5yp5jED5DPtIWumm3fxlxYDFY7m5vMJbVMPhzALHyzfHka7qsv
 UbNKrESJSKmamLYJfMKkFw4ltexqSvXpZeFP8rqjv/mKG3MbO5rX7EYP4Ro0Q9vrUxSMzyVctou
 wegYdLPFX6TMi86F+kDIFprXa1aSm9sHxNA1bLbTgh6YmyaC62PiUS/hfYNp3CZVjNY0NNACH9w
 NxZ65GRaKV9CGs45j66h4/q3Xrp/grQbFgkNMQzBAAsMyqUeiAeI1xQ=
X-Google-Smtp-Source: AGHT+IH5GSFdvf23lZVlYUYOpaBtjuUyYopeoHlE/x5CykL3lmsRVLPbpQzPtWZdTlryFPMiZzA4Jg==
X-Received: by 2002:a17:902:e802:b0:21f:4c8b:c514 with SMTP id
 d9443c01a7336-21f4e76391amr223689185ad.45.1739214825713; 
 Mon, 10 Feb 2025 11:13:45 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653c839sm82226155ad.71.2025.02.10.11.13.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 11:13:45 -0800 (PST)
Message-ID: <8fdb1c90-c35b-4772-9173-9313115fe256@linaro.org>
Date: Mon, 10 Feb 2025 11:13:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] target/arm: Make CP_ACCESS_TRAPs to AArch32 EL3 be
 Monitor traps
To: qemu-devel@nongnu.org
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250130182309.717346-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/30/25 10:23, Peter Maydell wrote:
> In system register access pseudocode the common pattern for
> AArch32 registers with access traps to EL3 is:
> 
> at EL1 and EL2:
>    if HaveEL(EL3) && !ELUsingAArch32(EL3) && (SCR_EL3.TERR == 1) then
>       AArch64.AArch32SystemAccessTrap(EL3, 0x03);
>    elsif HaveEL(EL3) && ELUsingAArch32(EL3) && (SCR.TERR == 1) then
>       AArch32.TakeMonitorTrapException();
> at EL3:
>    if (PSTATE.M != M32_Monitor) && (SCR.TERR == 1) then
>       AArch32.TakeMonitorTrapException();
> 
> (taking as an example the ERRIDR access pseudocode).
> 
> This implements the behaviour of (in this case) SCR.TERR that
> "Accesses to the specified registers from modes other than Monitor
> mode generate a Monitor Trap exception" and of SCR_EL3.TERR that
> "Accesses of the specified Error Record registers at EL2 and EL1
> are trapped to EL3, unless the instruction generates a higher
> priority exception".
> 
> In QEMU we don't implement this pattern correctly in two ways:
>   * in access_check_cp_reg() we turn the CP_ACCESS_TRAP_EL3 into
>     an UNDEF, not a trap to Monitor mode
>   * in the access functions, we check trap bits like SCR.TERR
>     only when arm_current_el(env) < 3 -- this is correct for
>     AArch64 EL3, but misses the "trap non-Monitor-mode execution
>     at EL3 into Monitor mode" case for AArch32 EL3
> 
> In this commit we fix the first of these two issues, by
> making access_check_cp_reg() handle CP_ACCESS_TRAP_EL3
> as a Monitor trap. This is a kind of exception that we haven't
> yet implemented(!), so we need a new EXCP_MON_TRAP for it.
> 
> This diverges from the pseudocode approach, where every access check
> function explicitly checks for "if EL3 is AArch32" and takes a
> monitor trap; if we wanted to be closer to the pseudocode we could
> add a new CP_ACCESS_TRAP_MONITOR and make all the accessfns use it
> when appropriate.  But because there are no non-standard cases in the
> pseudocode (i.e.  where either it raises a Monitor trap that doesn't
> correspond to an AArch64 SystemAccessTrap or where it raises a
> SystemAccessTrap that doesn't correspond to a Monitor trap), handling
> this all in one place seems less likely to result in future bugs
> where we forgot again about this special case when writing an
> accessor.
> 
> (The cc of stable here is because "hw/intc/arm_gicv3_cpuif: Don't
> downgrade monitor traps for AArch32 EL3" which is alsocc:stable
> will implicitly use the new EXCP_MON_TRAP code path.)
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

