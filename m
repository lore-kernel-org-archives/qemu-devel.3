Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338EFD1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwdU-00036a-Rq; Thu, 08 Jan 2026 15:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwdR-000315-K9
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:29:34 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwdQ-0005Av-3H
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:29:33 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-81c5ff546f6so689858b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904170; x=1768508970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jW3LWGwMwgEozNO1PkbqsGNfqsVIRo3SkKhO12bp0Xg=;
 b=PdUxvlZ+YCP+0wp+599rwjuskXiLe9KGtgsY6lGFo7Ni+JC+KVyJquV/gxDUaB6ef4
 9yx3+yHMR/Seh6UUXrifOBd6hV6cEp9l8veDad5XOjUCqqbZrMM/OuNibmXIkjplNEkE
 UCBPud2nkPapz6JiSdVVmhd4D0luCY+5ABpws4k01VvZFhFfcMNGXv8aaXUaye+mIaQy
 xsQ8dEW6A5JQ43VX/ghAnm8wB3IrUA4+TdCpkmg1bi99cVETTKU/Wq73uf0xx8KzV35w
 VuOhjTWv9xHdnlgfmvmZAgu5ugncKrHdBoJZFu989PgJJwYfY0kSbHs5JRdnmR2eU7j6
 ys5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904170; x=1768508970;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jW3LWGwMwgEozNO1PkbqsGNfqsVIRo3SkKhO12bp0Xg=;
 b=OJtfC8VwrHtuwFqMLAkX3Os0pvQktD1yZN6tSyejg7iuNvI65H+iBE3Y6CWE1bl19q
 +rrDxrxaVp56QGXLXj0BhJa/ZvW/D3X1L6WAqUOiWzaGr9zXdA+r+aDMIYXysnYt/TW8
 ohynoH6cYC3Sd0TgLVMdYEAutzzY0mhaLab/J9gOyB/LW0L6SOTqxODPPbC7ljFY846/
 0zJKD4NiN+JVuIkiY9Z9ZuA2Oi1dd1gAIXAYdU9b+uXvmMVZrR8XN4nJema3DAviOLCs
 sa2LPAP9DE6w7HPRgaE4hl/XKtY5J0+Jqthj5ye98pCKmioU/XzGA45n9Kz/vmOhoPmt
 3TLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhdXCL2NomDI0GR9+sDvvWXAZy7a42QjrBhLiCmA6U1IJ1ahNGJXeno/eGbzfUF2psO1JXfA8x7ntN@nongnu.org
X-Gm-Message-State: AOJu0Yx0h6N/i+OzaGRAUlOZnglWWwrt/UDAXxuUObgZxt1N9XDN8dCf
 V5Br/pIg/Sqs1fpdsL9UZuZEa4LgRdzPZrmpu7rgH/zZ/nUoTnR8lJBASEDiCwewwqc=
X-Gm-Gg: AY/fxX5Dc+EVWYZJNvFSP6U4FczIrYm2Q1/c7UG5mLD38cMYutFpb42E77tIb2S2oEy
 1egMlP4+etur/QA5R8kujH00nQwPuXQrh3keQ02PhE++CZDZ9cxRJ52h2s3ZesoM5XnhtqgJ5MJ
 prq+yib6OEwyviP18qbjIbo1htjuynn1cGP35Nsw4ogcabqxPWoH+bS1vjQFe2AVIg2za1nwBtl
 RIYD2dI0rK2wXkm7L0ZaAcoVQ+jC4xH+XTH+QKhHDwczVU8DWPWdtD5cmsFhE8ntn5YNuPTwN0z
 G6uqTMciM5Fu3KanDH2U2zW9ZtA6auNyyfRxmYkUnNpg0XAIl4+7AAcyDCO2cVk2lBIgC0uG8zr
 /ZPowjxYUt6qLrn0gB1XRdWS4zSkEPlunmUJI+d9eWA6R3/wkoqfhFmfHPHhxeko6MmrBg+/V6l
 uNn+YscDEJghsTuJE+mL35v6Wy4rC09lHpSXP01NjzHKxm0NrYMRRCbkXW
X-Google-Smtp-Source: AGHT+IFM50YujG19DwdgHjwTTZEj+HylH87oUQJNs3rUmFJ8xCLfJfF7WxE/nmAvPlnrhsroepwyKQ==
X-Received: by 2002:a05:6a00:4390:b0:7e8:3fcb:bc4d with SMTP id
 d2e1a72fcca58-81b78e9a2femr7234949b3a.34.1767904170378; 
 Thu, 08 Jan 2026 12:29:30 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c52fc9bdsm8439456b3a.32.2026.01.08.12.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:29:30 -0800 (PST)
Message-ID: <32de5a38-9e9b-474c-b0e7-1f63e197433d@linaro.org>
Date: Thu, 8 Jan 2026 12:29:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/50] tcg: Remove INDEX_op_setcond2_i32
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-21-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> This opcode was exclusively for 32-bit hosts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |   2 -
>   tcg/optimize.c           | 205 ---------------------------------------
>   tcg/tcg-op.c             |  47 +--------
>   tcg/tcg.c                |  32 ------
>   tcg/tci.c                |  10 --
>   docs/devel/tcg-ops.rst   |  27 +-----
>   tcg/tci/tcg-target.c.inc |  16 ---
>   7 files changed, 8 insertions(+), 331 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

