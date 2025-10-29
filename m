Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1178CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 07:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE14f-0000b4-81; Wed, 29 Oct 2025 03:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE141-0000Mr-QE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:57:50 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE13v-0002jM-3r
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:57:49 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b6d70df0851so1069251866b.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 00:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761724659; x=1762329459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1qFC3g53MkoT0qsaeE9Mn7mzGOM2YB74Jw0WcZeFkBc=;
 b=e7XGcOSJVEFuxuQywyUzDqdH7UcqQTKXqrvrycrTHE2NNz6yzzsPNHIZKmhb5BJqFU
 b4ESaO6wDJw6xm/yy6UWiwVCluIpJvLRmBycn5NdtJQ4JZDHkI7OKa1TBDGSHUxZM4Q7
 BXufZE4mkxZhQEv7HOzesOMI/+SZpDSRWLAt5GOAIlLGS1xOq1pL0WsVtCzU3eKpbxS5
 8M2tNmfhTQyNot2S8rAyvuDnyUDT1NRNkzbTSEzCR2QhsGyEJoEP96VwIRC6LWyez1Bd
 VgxYDdxkWqbWR4+7lFcg6FDZt+MWJh09DoobxjzG7cOCFLssDhj2ZtN+sJceawZjRhLf
 Urmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761724659; x=1762329459;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1qFC3g53MkoT0qsaeE9Mn7mzGOM2YB74Jw0WcZeFkBc=;
 b=dIYMIY+TxLN/b0AGtXhzt53mIm40AUTVCCnVqfItmetMagNxVTooyjK9Kdc9GsrEJj
 MNmrXIBwtguQiHEQH7RgZFMl+gqKPw21owgemciQLF52DGY+8314rTCKHMM0c/YvMWjW
 mKGqyDoV0Qo61hiY7yyqIjZggb4dwlkbNCKemTtqIcUv6zVOBqMlbGRKFJBs6pBFzpTi
 togptu2SJw416pFAE2B+hyej/X0H1hxq0hR+C3J9l/KVXTezhFLPwLvVPiztBfW6Vurw
 SeZeQ3C7d3J7OuOY7bTYmgepcAtKqwBnamMilrMFoCpaRyqVqedrKOR4+gihWYwoVsCu
 25nQ==
X-Gm-Message-State: AOJu0YxVEeQzvg5rfynI+Qmx/w687jRZKQ6I0YiJMFaylGAvp++0OZgt
 u3flTVWOEWMgPrx2AL6vp2MMDNzwGI6CvkVAWgLxKAw5YQuM5oenvYEcrLFDD3XdQqYOsUjmTrN
 HoEHUZ7A=
X-Gm-Gg: ASbGnct6OO0xs8501yVteXlLgWJfMttQXG8EbKmz5TVEgHgzjFWP9ZQv/RObeqlpLzH
 HTqiItgJ1F5VSj4OOPxhgkVClkRO5j4cWYzN3ji4HR0IzKJMPAPsqRMSH/pXVjcuyBJOcyfz5qU
 ibfoW9lyhzk73MNmJPz/A0lJnWNe24W2dZd1VzWzNIG8Waw3hTp8DHG9Nf4I5p2owGBg/ZBRpO4
 yq26E1CHpddTISGq9tfCQJuCzN+l7upV7HPs9/tCTlsLKir0iKjVLkdjF89l361URsQfKnX9an7
 p9yQS0rnJ9YbDw1qjXTrQOWUz330zCiMd6WzEz9T5kqgRp6CXvntz6ELBg3/87+vgHDDS3BfNhw
 ay6pq2vLJjz7L8oJgPNdP/1C4t/FGLNKKML2wcRXDp3rKtG78e4KtIGlsFf36Muj5s01K11QRD/
 z/ebMJDpiwSCB9BqzS
X-Google-Smtp-Source: AGHT+IHih2RhGaDUDY6Shrof0F5jERqu6l5RipJpoMFoeThCL+NTGSVGS4pz2ZA6tqViM1dF1xdhmw==
X-Received: by 2002:a17:907:9481:b0:b6d:53f5:7a13 with SMTP id
 a640c23a62f3a-b703d58a35dmr163901266b.53.1761724659532; 
 Wed, 29 Oct 2025 00:57:39 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6da1e2226fsm939738566b.20.2025.10.29.00.57.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 00:57:39 -0700 (PDT)
Message-ID: <e1398eae-951f-425e-9cff-4b7bd925b8bd@linaro.org>
Date: Wed, 29 Oct 2025 08:57:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/25] hw/sysbus: Use memory_region_name()
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> MemoryRegion::name is private data of MemoryRegion. Use the
> proper memory_region_name() accessor, which might return a
> different name.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> ---
>   hw/core/sysbus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

