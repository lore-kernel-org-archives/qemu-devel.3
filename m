Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E10C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 22:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEya4-0006sk-EC; Tue, 13 May 2025 18:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEyZR-0006qe-8v
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:57:58 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEyZP-0003p8-ID
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:57:57 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso312736b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 15:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747177069; x=1747781869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M5rf1bjtht6iyReBakuEvnzGJtZo85rGyibPhgpM2fA=;
 b=KmSTRAyyxDepSllxeclrcuTsfRilvv2ppqYkTo/TejvvhtKD9qfmd1yhcrhfOSgzou
 qS8v4HBtSX5X8cjxxu1QxfuAjUlwhVfor7h6W3kw10B6dU1y+nknPuNweZiyZcYF0iw+
 Ur0k8wrkYtAJRCDJUSKC96cH5BtW8zcgSyUezCURteIxX0N4G/xw4y+xdoVrw8Ztc3Gm
 dOcgg9NYCl7lIj95QWAVXairJ3I0olWLPH3t46YcbeAYOKw7xzimDBE9tqy+6S67nROg
 uAKkknwlmt6DxBazTSQyTOJT1QWnsPJU6/6pqb/5wnLawh4N6q7eoVwg8PBxDwYqaVWR
 qQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747177069; x=1747781869;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M5rf1bjtht6iyReBakuEvnzGJtZo85rGyibPhgpM2fA=;
 b=W9EeGphteE5L/LgzyPjONWqNADPa3XWr6pVdr6/jvibyDQ1KaDldytzy6Eh51lsdUC
 /Xbx36cRLgpo/VNnDn9YP70706CuO0dtuuh97IiG+zRGHxO3hEomxPI+89sfFHt70clP
 pWcJU9LOLO4OWG93Gdc1cvoObTGaZcAib3h98AATe6iyVQZus8A3h7lG9Hj79Ec/tRUO
 4fKYfKqcN7I7t6sHztcABAx6Au7fyXC8R9AJyRMvFLcjnTmJ4ii0XDZpJR5kGh9hdSmh
 XTOILvtzValHFStxpPJMRoccj3+0/HGGHyqfiEI14V4gq2mx3MPI78lWpYp9+8S+ILLx
 xqwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzhp0cOgu1cUpCekxo0HxtHbaQB0eRkbR0t/xYpM8LGOJp9een7lG1YwJRIaHCFuZWZX2vJfzrSSiG@nongnu.org
X-Gm-Message-State: AOJu0YynjrYJNmmX5c2x3BW1erkycp7XEm21fHmsUwukJ54V0oQZ7zAU
 YTFXqK6kwZasw2wjFdu6vPT/Chr+yaaOcB0T4cNJ7mZq7ZSwVrekRr59GArnZX8=
X-Gm-Gg: ASbGnct7dNWRZsNEnIrldwLA0Zy29AHREDkVcFSEFcSPPq+SKM7Wd60jbzBg0T5KNV8
 265O8yYvyTaR8vojPDw7w5NHa/u63DSI+OL/Dg4YKrPwCB1IjIxWCWyBwmKrFBGbxo2RJnueMk0
 Xv/did8GnMerwqYvNPwVmNKsQvTlqXHAjALK/fzXTNKSJHTEFQtIFLX6XgdLpZP7Vh4cRekx01B
 mfUerY4Yfiaj3VwRYB4yKjSKSJr+TVwBdGi7R0DvWz22KWCgm6xe4fiGvI2PqKxjBf+M1faKzJ2
 5E5csr3BWxdyxT3PBKSxD2sI3bYaeY8DDeCtljejWgxiNxMpDNJe5Hs4B5wyBQHK
X-Google-Smtp-Source: AGHT+IGbdmOidwaG78zAYmPVfpTa0K4HwjSI4uAbk8hLcu0guRW9J5cBZhajYlXzilrFXLLg9dYG0g==
X-Received: by 2002:a05:6a00:6115:b0:736:b3cb:5db with SMTP id
 d2e1a72fcca58-742791a6a0cmr6088258b3a.11.1747177068922; 
 Tue, 13 May 2025 15:57:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74273ca9230sm2774162b3a.24.2025.05.13.15.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 15:57:48 -0700 (PDT)
Message-ID: <b83ec39b-cb77-4df6-8b02-7de46461eedc@linaro.org>
Date: Tue, 13 May 2025 15:57:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] target/arm: Always include full path to 'cpu.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
 <20250513173928.77376-20-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250513173928.77376-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 5/13/25 10:39 AM, Philippe Mathieu-Daudé wrote:
> Some files include "cpu.h", others "target/arm/cpu.h".
> Unify by using the latter which is more explicit.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpregs.h            | 2 +-
>   target/arm/cpu-features.h      | 2 +-
>   target/arm/tcg/translate.h     | 2 +-
>   target/arm/arch_dump.c         | 2 +-
>   target/arm/arm-powerctl.c      | 2 +-
>   target/arm/arm-qmp-cmds.c      | 2 +-
>   target/arm/cortex-regs.c       | 2 +-
>   target/arm/cpu.c               | 2 +-
>   target/arm/cpu64.c             | 2 +-
>   target/arm/debug_helper.c      | 2 +-
>   target/arm/gdbstub.c           | 2 +-
>   target/arm/gdbstub64.c         | 2 +-
>   target/arm/helper.c            | 2 +-
>   target/arm/hyp_gdbstub.c       | 2 +-
>   target/arm/kvm-stub.c          | 2 +-
>   target/arm/kvm.c               | 2 +-
>   target/arm/machine.c           | 2 +-
>   target/arm/ptw.c               | 2 +-
>   target/arm/tcg-stubs.c         | 2 +-
>   target/arm/tcg/cpu-v7m.c       | 2 +-
>   target/arm/tcg/cpu32.c         | 2 +-
>   target/arm/tcg/cpu64.c         | 2 +-
>   target/arm/tcg/helper-a64.c    | 2 +-
>   target/arm/tcg/hflags.c        | 2 +-
>   target/arm/tcg/iwmmxt_helper.c | 2 +-
>   target/arm/tcg/m_helper.c      | 2 +-
>   target/arm/tcg/mte_helper.c    | 2 +-
>   target/arm/tcg/mve_helper.c    | 2 +-
>   target/arm/tcg/neon_helper.c   | 2 +-
>   target/arm/tcg/op_helper.c     | 2 +-
>   target/arm/tcg/pauth_helper.c  | 2 +-
>   target/arm/tcg/psci.c          | 2 +-
>   target/arm/tcg/sme_helper.c    | 2 +-
>   target/arm/tcg/sve_helper.c    | 2 +-
>   target/arm/tcg/tlb-insns.c     | 2 +-
>   target/arm/tcg/tlb_helper.c    | 2 +-
>   target/arm/tcg/vec_helper.c    | 2 +-
>   target/arm/tcg/vfp_helper.c    | 2 +-
>   target/arm/vfp_fpscr.c         | 2 +-
>   39 files changed, 39 insertions(+), 39 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


