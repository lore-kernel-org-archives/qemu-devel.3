Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898DDC54FC6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2024 21:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sksDp-0005cp-Mi; Sun, 01 Sep 2024 17:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sksDo-0005cC-FT
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 17:34:56 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sksDm-00077s-G0
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 17:34:56 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7b0c9bbddb4so2431563a12.3
 for <qemu-devel@nongnu.org>; Sun, 01 Sep 2024 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725226492; x=1725831292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L0l86dsR15zM1/iSfH6MKHDEgb6ug0F5pGHJ9wbVPeQ=;
 b=HtQt1Hm5cu+7nqJQO5UAtcYVrBjSiVE/yUkxaSmAbNvsENDS8kaZRn7ZAmN07uU2Nd
 YXhuVBt2CokWKVa7/L0VpPC7v8F5GzjqnikfdNHfjYXClDzBWLP4UIzqKYMqq+60AvNZ
 qdrKot6mWjWFN3HixVstDQgZm8NsTBYvcLnvEMW1935g3y9qg29mFyFofTPoUnGrSzUz
 feKN8Jami7YNnvRbiZw3TMPx/S31mwxgp1VCyg3WM8JioxfcvhqD3FcwIhCR/cHQsXA8
 Z4No9xmSGmISPhbDV7nmT+f6IxT+9IIAV+61YDW0ED3p7cdU6TxyVMurUfKsbrZQ9jwt
 q/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725226492; x=1725831292;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L0l86dsR15zM1/iSfH6MKHDEgb6ug0F5pGHJ9wbVPeQ=;
 b=EThG0E20Jt78i1SBxim4unrN3Or9Gvtfd1q8B1/y4iFtwbE5W9cO899z+NcQX+p8XY
 1p8iB8hW9JL/PcJkRTA6PeMXyRV2sSvx9WV/TkDYrLjHMA0FxcBGaXosnnvVlY1SMa5G
 Glsa+omHHP9OkJxVMujkf7mgyycBf99QX6t0+RTjOPwTbHrNGjmARvk+BbKog54EV/yg
 6OxxsgQdpATI2/4wZzp4uXNDxR6s6soaZ4QUzDidtP3uuATFJ7eMqIntvilj6i05ahZf
 BrFKoHdCgxjrEcM8Gxo9pe4n/HrJ+ZgpFGz0yi7lV7BJbYffFHttuAtwBqKTlJkd/cCn
 H+Zg==
X-Gm-Message-State: AOJu0YxtLFYctZ4p2wlwfznXUUFes0QJ7JJdQWl8IPHVzyl8WJ4n8/8w
 7PSi/y4iIxbxXhuvNmlQn5NvDnlj+VKqnoit/PKREmo0IgtzrBvyZvPPMIcs2kDp4/ZGQVGbfdG
 4Tng=
X-Google-Smtp-Source: AGHT+IERCpR+i57YfzySdB1gJqRYd60V5g6XzaRGRGtrjQxWKczAOw0+CfklIEM+92Kq8wE/hIuhPg==
X-Received: by 2002:a05:6a21:78b:b0:1c4:7d53:bf76 with SMTP id
 adf61e73a8af0-1cce10aafe2mr12443555637.38.1725226492082; 
 Sun, 01 Sep 2024 14:34:52 -0700 (PDT)
Received: from ?IPV6:2001:8004:5170:1fd8:ef9d:e346:b99e:7072?
 ([2001:8004:5170:1fd8:ef9d:e346:b99e:7072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2054f9deeb8sm23361655ad.188.2024.09.01.14.34.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Sep 2024 14:34:51 -0700 (PDT)
Message-ID: <65291b1a-e1cd-42ea-8aad-233bd899b528@linaro.org>
Date: Mon, 2 Sep 2024 07:34:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/m68k/mcf5208: Avoid shifting off end of integer
To: qemu-devel@nongnu.org
References: <20240830173452.2086140-1-peter.maydell@linaro.org>
 <20240830173452.2086140-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240830173452.2086140-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 8/31/24 03:34, Peter Maydell wrote:
> In m5208_sys_read(), we have a loop of n from 0 to 31, and we
> calculate (2u << n).  For the n == 31 iteration this will shift off
> the top of the unsigned 32 bit integer.
> 
> This is harmless, because we're going to stop the loop with n == 31
> anyway, but we can avoid the error by using 64-bit arithmetic here.
> 
> (The SDCS0 register is documented at
> https://www.nxp.com/docs/en/reference-manual/MCF5208RM.pdf
> section 18.4.5; we want the lower 5 bits to indicate the
> RAM size, where 31 == 4GB, 30 == 2GB, and so on down.
> As it happens, the layout of the mcf5208evb board memory map
> means it doesn't make sense to have more than 1GB of RAM
> in any case.)
> 
> Resolves: Coverity CID 1547727
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/m68k/mcf5208.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index ec14096aa43..0ad347dfa81 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -158,7 +158,7 @@ static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
>           {
>               int n;
>               for (n = 0; n < 32; n++) {
> -                if (current_machine->ram_size < (2u << n)) {
> +                if (current_machine->ram_size < (2ULL << n)) {
>                       break;
>                   }
>               }

   31 - clz32(ram_size)

?

r~

