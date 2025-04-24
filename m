Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04E7C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tDu-0007aJ-EK; Thu, 24 Apr 2025 05:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tDs-0007W5-8I
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:50:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tDp-0002tx-HB
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:50:23 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso1327337f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488218; x=1746093018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U/IxSYn3XdAWmDi2s6aY1jPBFUSDraEBur2+gJweeXw=;
 b=XYK3An6/MHkULINCvV7cS906bG5DtF5S4vKxAyIz3PiRJxdlSEgQFlxdzwdVReXXWm
 DsnFLl7wjOH9Ht2Ffhl1Nk6vIgFuUZkz8OYS6faysNhp3yRcmVbs70NM/6FQTFUkytUC
 mptnCCNKKIPL7NbfcR+Uf0uR1bfMxnx6vSsKntLhNSflkchBakQ2PFIi5UFrdhF9zloL
 9dwT5SE71pY2FIDQmMw6Us5GqMCqD1rjnyrciEVj/ognmuXPMKywotxy1Qfas+JBEIOY
 v7utnjCE9n4djUV5JfLOy6qy1xVLi1hMCLxF978lcUemj6TGnQndheBhkG/BZ4T+DeJz
 K02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488218; x=1746093018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U/IxSYn3XdAWmDi2s6aY1jPBFUSDraEBur2+gJweeXw=;
 b=u9RjaB5Vn30Iefqz5Ub/WqayuoFxCiKZSr1JlHDDhVrZuVeHoPAffY6D5rjcx14cpn
 6krfqLSJY652vLnNam55XSLC0w0om00xAWErZxi0GnEYXO8lBvHAfefLIzoCf6jqXCUg
 8r90kw6lLys3+8hhR/0ode+S4pZbsRgagw3oIeDbHVU17CRKS7gBjxa64h1C1V3DNjEX
 NJGmm2g8qPd8iVUk4Hv8X/klHctBT3ukwYmNgYueCQaaTaBgUmDAzTl22X2U844PlNX/
 GNv+ngHFPSXFBDt47cm1/kr5Cdr4DQ1f0+HYk+WpIgvKo3paAtIvLytqX+TnH+IwyqX5
 XylA==
X-Gm-Message-State: AOJu0Yxdo+ff6MtvKKsmpznP3aVjFZzPd0scmCYduVzpE5cYhwS6BNV6
 IzjA2vqZU7repEXiqw3qZF/JeaSRKQ9x9gLERwVifKwRBKzvUIRBsexxoKR22gFH+kr8+6D19/2
 1
X-Gm-Gg: ASbGncvPJh7hrwBh0mYQ0l94RByVa5Uxw8KH8a8Rt4CGBA9YozOWXiGKIjI9UWD6JaZ
 us+/UtKpxLvgaj8/C3YQ4GCeCHm6qGZ7AENwZ+C5mh2g5wrRqkmKVNzC81i9p0XWCADaX8u3vN4
 u05bfolsWkxzWW8cZxF0GXZ32yFsm19WzvbM1oQuMEW5S0vMP5m0jlSvFPh612mwZfx73cs8iuU
 yfIaV1qcqlD/vxW3J+5nTeMRBo5mB/oNo0AGI/QHeLXwD4yplbL0a+XIYCKYT2/sn0wBdFIbjUk
 puWrmyCgCtlsfQVBGDRf9bLqzYUSdcZt/oHH5qliSuzIPfDEGi+G5DCIbB90sSjVLjN1useWh38
 JLeZKHhrH0zTqEKEK7ABT6b1a
X-Google-Smtp-Source: AGHT+IGt2x/BXfLenJOu/ixpYqiOd1SKhhvyBgpa3NxZ7H5cmk9C3jAkV6aI1X7W40NBeryXEbrQCw==
X-Received: by 2002:adf:f58a:0:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-3a06d674aa8mr1268759f8f.18.1745488218462; 
 Thu, 24 Apr 2025 02:50:18 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d54ea37sm1525358f8f.90.2025.04.24.02.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 02:50:17 -0700 (PDT)
Message-ID: <f9ba5a20-ca41-49b7-9813-d8695138af77@linaro.org>
Date: Thu, 24 Apr 2025 11:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] target/riscv: Include missing
 'accel/tcg/getpc.h' in csr.c
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv <qemu-riscv@nongnu.org>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-8-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424094653.35932-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

+qemu-riscv list

On 24/4/25 11:46, Philippe Mathieu-Daudé wrote:
> "accel/tcg/getpc.h" is pulled in indirectly. Include it
> explicitly to avoid when refactoring unrelated headers:
> 
>    target/riscv/csr.c:2117:25: error: call to undeclared function 'GETPC' [-Wimplicit-function-declaration]
>     2117 |     if ((val & RVC) && (GETPC() & ~3) != 0) {
>          |                         ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/csr.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index c52c87faaea..13086438552 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -28,6 +28,7 @@
>   #include "exec/cputlb.h"
>   #include "exec/tb-flush.h"
>   #include "exec/icount.h"
> +#include "accel/tcg/getpc.h"
>   #include "qemu/guest-random.h"
>   #include "qapi/error.h"
>   #include <stdbool.h>


