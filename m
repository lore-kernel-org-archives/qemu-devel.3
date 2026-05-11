Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9A9CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVQt-0002f7-77; Mon, 11 May 2026 14:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVQ9-0002Yw-9o
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:32:16 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVQ6-0005N8-Ba
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:31:59 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-697bcc9d769so2346769eaf.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778524315; x=1779129115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=15bYz6gNDZQ90kZSN7xWNFaeCyJ11AAVMUWNyW9HvFA=;
 b=fTRPyceOsrxR0zFdWDRGMUn46z/HcvaJgKQCl/aRwiC1ItwOfym7BL8O3LnASXzxRj
 x9A2djsUrW16ZC/+/WXQX7re/VpTNzqviKA3azROnZUVvCnspTGSVMplTd4JFfT3W389
 CVLDqDN/90+SlM75Ou8NCMqGQ/OKdO8g6jDc0q26tvijGOitEM6XKi4BRmHaYPA7WR66
 XXgEdLs9XpT+/NVnzvNkETq8L1FU+HZx+MB6SZPYXECqGfpNh/fX/wDQbTBqdE+nPyz1
 FQSj4adpH9OOGuOPHh3/+8yqGuGTTBpUE54TgorE1izUtTZX+wiyu5U5wW4gC5AiKOY6
 acvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778524315; x=1779129115;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=15bYz6gNDZQ90kZSN7xWNFaeCyJ11AAVMUWNyW9HvFA=;
 b=ceeWq1X0pZ+y8L7ytZXP2thoOEAC8Xm1MvszIZSJnaMH2PO12NS9kRB+TcmdCkZRvL
 kWAfIl3OZZ9DzL2hzp1dwyeRK6K9vVwPm9LDZqDFlalKAlhSgT+MSL1DynAIoUxX6kxW
 lHURqL2HPE2/K/8pPbpcvl4YpJLASeLVoRUYDXsF6jAyA4DZuvW4fU5kbzFd46Zail3z
 C6jLTCfOCETrGSyfBikkcd3GtwoSo4B7yFRplosRvD7nWAbIhUiRaVwiH/m1zWYfvEAL
 iSkLDz9bEP/O6S6PuFPb+ZeT5SgaGASeVKSGLRdhkj31mK3WZDQ8ZD0GIXGvOOpRqRUh
 cPdg==
X-Gm-Message-State: AOJu0YxruGV1v/e5Ot+J9puPJWzRRB1o8bKnB0vWicRKcFxSl3hAMzX0
 XHEmoouH3rdtHY0b1QmN7AbvU4Rjd66tKtqVrKnbgad5jTxUYhhEt0uqx09ZrwRXr2+vEDjIuVP
 9VowU
X-Gm-Gg: Acq92OHG3lRHBQ4EZIeeAldZPGD2AXtW3zupKc9M/p+XnrLz0AsjemPsECLG9CGicsy
 LAbzrqt5YHI/RABQaS2abfi0NE8y+N7ThqmMI52DJVG4GatJAC1yPVLn7wkqPW669/EkWnMLCG+
 w025IcZvvXl3KwyU84isrO3QVXneXxDzM/2AntNBKe7WTGOS+i1d4ekRZr1o4/uHcibfl9u+9gS
 5NId9xjhZxvLm66T5wCUJk3THBNM6+xy9rhiN7A5jyukRnJvgUSu+8pyxSMKJumSITghxXM5mDX
 g8eMNkZEHux73yhgLCsQ0dqWNsY0o4frVOWL6zIf1Y6e9bngxau7SHPI5HsCJypAvsKGEk6MA9y
 pnH7Jq4MqMswMQXxDDCMHE5ix3LymRhSb55pJ+Cn2wBzZ6+MhdN6Z0hksblGQG7PxDNw2i8uMuT
 EvbeXw8BkTXl/Sf2iDVLgbh1Lz9jpzBL/Te9Xla+bCYWr95w15IyJYmuehxeYTDpmc9LNg2FDPE
 Pq8Rwoonzvgl9dwjRGu
X-Received: by 2002:a05:6820:1747:b0:696:6f1f:3ee6 with SMTP id
 006d021491bc7-69998d6f9cemr13564362eaf.53.1778524314624; 
 Mon, 11 May 2026 11:31:54 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:e3e5:757d:3cef:3491?
 ([2600:381:c938:6375:e3e5:757d:3cef:3491])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25cb58b2sm6365151eaf.8.2026.05.11.11.31.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 11:31:54 -0700 (PDT)
Message-ID: <c7c97336-197c-4cff-8754-1adeb777719c@linaro.org>
Date: Mon, 11 May 2026 13:31:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/35] target/mips: add Octeon multiplier state
To: qemu-devel@nongnu.org
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-7-5062889c4d3c@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-7-5062889c4d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

On 5/11/26 13:22, James Hilliard wrote:
> Add per-thread Octeon multiplier state for the MPL and P limb banks used
> by the VMULU/VMM0/V3MULU instruction family.
> 
> Octeon3 extends the older MPL0-MPL2/P0-P2 state with high lanes
> MPL3-MPL5/P3-P5, programmed by the two-source MTM/MTP forms. Represent
> both banks as uint64_t arrays so the TC state matches the architected
> 64-bit limb layout used by Octeon68XX user-mode code.
> 
> Migrate the multiplier registers in an Octeon-only subsection so
> non-Octeon CPU models do not grow migration state.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split the multiplier state out of the combined Octeon arithmetic and
>      memory instruction patch.  (requested by Richard Henderson)
> 
> Changes v3 -> v4:
>    - Document and keep the Octeon3 MPL3-MPL5/P3-P5 high-lane state used by
>      the two-source MTM/MTP forms.
> ---
>   target/mips/cpu.h            | 12 ++++++++++++
>   target/mips/system/machine.c | 33 +++++++++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

