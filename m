Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED69CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRoDK-0003je-Ti; Tue, 26 May 2026 05:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoDJ-0003jK-1z
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:36:41 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoDG-0006Pl-R2
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:36:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49040362e4aso47356105e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779788197; x=1780392997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bfhIcT4yZmZojjtnPpmiJlC5FXYfOsX5Lz/gL7M12mw=;
 b=CqIA43VfCmC7el4KNdSyMyM7eM1dV16aRTl4dQnqnk8gMPt6CamHooiGs3Nb950oS2
 929Lr/EvXuN6l2JXYIWTDNVsFrUSW6N2kByhi+VYKmrStVfcGEHHbFmoe+gnIfBPOYWC
 QutLUPCAtqe8eAC339TplmrVaqzPQ18m/dNFcfWLOWVkRGkUDqmpVJtrk2xzg9tXtZ0n
 2+89Lzjjtq3V3oZS+deLzOHFOmtCgmSlDNOkXiBTLQ/TQ0WHs7xeMNmPn7yFTKUSoo0V
 5cu/c6zfmE2ZgiLS0kK9M40RcVhLyngZCZ6SXDnl5lwX27uBkBN+CcSfFbGiK39dC1YG
 A/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779788197; x=1780392997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bfhIcT4yZmZojjtnPpmiJlC5FXYfOsX5Lz/gL7M12mw=;
 b=OoAMIisxjt2LN7pD4tNd2LW2dTUXyDgqoJYDcs24xFSHsjCIzBJn9sOA8IYpZ5CQWA
 hG0ZcXclyy0TW7ACtN6m3UyjzHPw6NfrSXKoCr5iP7fxadj9Sw0gc3y67lm5fwLxSq05
 Bugg5kJCYuDcv9QcfrLh3j/9UfFPXjzfnznxjHWPeb0tEIukJnPIjR4dHf1ptBvMUb9H
 kCs0jHtAQ8Ta2P+IKY6r+ssPQcjNsVuaPwMRTt9T0SGsFRx7flLvoqlowdyFKqN36a/V
 zfgtl+EPoEDyXiDvwfzfJ78KNUDa6l8PWuGfC1/wgp2uldPC16oj/pMmNm4ecDv/frhK
 JeAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ85q9IELoRyWsgfpKcjBU7RZdWdoorMpJrEatT9C6rTJGhBx8PlTV077s90yWuh7h7fnB1XyoUaSiCi@nongnu.org
X-Gm-Message-State: AOJu0YwxdLVLCr5u/Ug4Vk4PhlRUnloN5JjxbouROmychjLLRJBscgT6
 ky/cxw8cj3WfIDtBUDuy2AoA/iPBDjvoI66+FsgWDWeKuBPdU+mzqLMczLZ9XWF7WdVnP55pmjM
 jX2YXW5XOAw==
X-Gm-Gg: Acq92OG3AzIo9ZZa/Uw4e3KKMtlDgyCn8FnasimcwqbjpxLAZLN1R9OmhwdnF1l416Q
 GvmNcKvZGSb/oonA0+epo+v++yAdVFZFZ1WTeJkPf4MKe2roI1REAy3X0pE+KAcSgXjLm93Kl0m
 fnkLPejmslVvxx006S1OXpkoXvEliqY50yUUCgQZkFTehR4ZORsBx49Pz6/xCEE0D/pT6Bn5jDB
 b88aK/j/7HjJzFKLmAQwuEe4jh3SE+6P73VBRXzhAik6x5b/qRwvegJ9/cvVU6fK90Uni49lzeG
 vtxhKBJiONls67yF+gjSsKkj0C93bU1kjjTz19iLbytBl8URiTgcn8FiyRKLm4M1unQtI2gwd4X
 stNL7j8zgO6kJKtlmSld3lXOqOkqI9axeeE5lxLeOgIPvF5o6OOG1hnVtMs30BTdCTbqbr1bLIL
 OSqlhfJ+VtNd3JtdYT0RZl4pPOOh/aNaH1dvVqSbXtzbQOxZq9AM0nivnhKlEan6SS8w==
X-Received: by 2002:a05:600c:3b29:b0:490:5466:8591 with SMTP id
 5b1f17b1804b1-490546687c1mr199662135e9.12.1779788196806; 
 Tue, 26 May 2026 02:36:36 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm36483516f8f.36.2026.05.26.02.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 02:36:35 -0700 (PDT)
Message-ID: <7e390cae-b12b-4a3a-984b-068543085b69@linaro.org>
Date: Tue, 26 May 2026 11:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] target-info: Add target_riscv64()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
 <20260520-hw-riscv-cpu-int-v3-6-d1123ea63d9c@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-6-d1123ea63d9c@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 20/5/26 15:12, Anton Johansson wrote:
> Adds a helper function to tell if the binary is targeting riscv64 or
> not.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/qemu/target-info.h | 7 +++++++
>   target-info.c              | 5 +++++
>   2 files changed, 12 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

