Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1C5D1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxLm-0001uH-6g; Thu, 08 Jan 2026 16:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxLj-0001sn-QB
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:15:19 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxLi-0005EN-F0
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:15:19 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a3e76d0f64so10890765ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906917; x=1768511717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UAPRbvCGuIaOqiu8Mw8FFrRALBE9CwcRyWE/jTkdr4I=;
 b=ocQTEkAXOB5z8D+7OJtXl9JZh00BbRl7T0CUx4Ha6ZQlyx17ozYvNWWVOkQWn5BcYg
 chvlf9KUycdHypZ7zonPmFHTwLolgwbLSwa+bdg99jM53KktZ11ger1RBQDGFFLTmQXD
 ZlKCTBIi8x45V9utHCBYOUTkEQJhE7um9klfjWRS4oP/caGBCI8JydTgOWuqd3ZxqYPe
 A7A5Bl7Z0E1+7M1BmxAg9RsWwScjr0lLU3+e5KyIljHF4LZQNeW55XoeU9CrUSXRTS7/
 oiNBt4g55ViGez0Dt7SgjexZjz0frjMsHwIjqzJZruDDTsN+bpkP8+GSIowXqH7tFGgM
 XqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906917; x=1768511717;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UAPRbvCGuIaOqiu8Mw8FFrRALBE9CwcRyWE/jTkdr4I=;
 b=N0YC8IyH0VFmUke5Al9+TobxjgfI6FvrBrz3/BeS34pMdQ2MPuiMb/fzko80CiIZco
 fSC3HHDIfJZ19N0s7xRjBBgtcgeitoG3s7tLT4rGpbtmslzZqXEH3e1zcz1GxRYOdGXK
 EdQeS8u/2lx3pd2A1ZSwMyXuuZABLyISO8KUgXhNSY09o5VZDKrsP6soxeIyfdXWaaye
 7Fv95Tkem6/ilvUm+0mPhiCjMjYQGw4UrvK86WYTkSEtX5ezxErCRNiu/do9rRo9oaBz
 Pdk71u/galLxMYeykFQ2q+Jg7/lylzpZsgQMagc9OO+GitakD4BCa+4dN+iokxkjGOJO
 6s+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkNcXkqoB5G17EXQ6Uzvx5KXPBR0xqdM4tLWao1ZR4eTQswTV0eeVSjr1fp22HMRyWIXphjYoya5LV@nongnu.org
X-Gm-Message-State: AOJu0YxV87D1uvKKdq7JTzS/BtXXqmHHWBG56MTt/nXFGuqPFP/VF8ge
 /pAWyeTwsmSSmYn4sk/A5Vl/8/ak/c956QP8Cdp1SQBXzHBc8q/Jb9eAw1F75Lf7wY2x7atHKHL
 QSlWR
X-Gm-Gg: AY/fxX5p8QPTohCDGUW0plrlTTnlAJ+VtjkXtJblcl3PMT3HgGnckDdDo0mf6SA1TgH
 HsFbi4VViiyxz4To6PAcS51LMS2yuc87KhoaaEl8bFUkIO/cAY/ns94d+l6/K83c+QQ5hSi/FDm
 Est/zu+MgNrlxKUfurTmZE7GdoafENfihgJP+oJAUuOVOeiQgJroXERsW1+toOvAcD2c9Xfp2sz
 q6izKQ5/aiL4PO5rP4SQFaSCZdJmJoF9EIrjwL3erJzjEhXEYi9uD9rPat1MgWZe/TnchqkfnP6
 1ntmMbLd5fzulvdKBP5uZK61YJrbvaXz6aJLW8YlAYcSUgw0+2Chfz4rO20MNPd9Dinxb3qphAM
 UwCyRsH2dh55lujz6/4WSgptkG8tp15RgP6E839zI+w54QKRrRHEmnaO6y7gcwUm0Ual8rrTNZn
 lMzPvd5Wi+NBGnNiqhTnIrk6iMEka9IWj12E6xnBqZZRmbzzRej14V/CKk
X-Google-Smtp-Source: AGHT+IGGCX7BLDnyZlgZr4CeFLiZ+M8Q9P6ypeENGJgemot1ubuw4bvFrkO5MSIhoBe7DypmObh3mA==
X-Received: by 2002:a17:903:3d0b:b0:2a1:3ad6:fab3 with SMTP id
 d9443c01a7336-2a3e398244bmr101364015ad.1.1767906916919; 
 Thu, 08 Jan 2026 13:15:16 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c39fefsm87611845ad.17.2026.01.08.13.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:15:16 -0800 (PST)
Message-ID: <e00afd34-ac5f-46eb-a1bd-19b47db0b0ce@linaro.org>
Date: Thu, 8 Jan 2026 13:15:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 47/50] util: Remove stats64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-48-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> This API is no longer used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/stats64.h | 199 -----------------------------------------
>   util/stats64.c         | 148 ------------------------------
>   util/meson.build       |   1 -
>   3 files changed, 348 deletions(-)
>   delete mode 100644 include/qemu/stats64.h
>   delete mode 100644 util/stats64.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

