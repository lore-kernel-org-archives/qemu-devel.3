Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28BEC3ABA5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 02:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9xUk-0003YZ-3x; Tue, 29 Apr 2025 22:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9xUg-0003YI-4u
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 22:48:18 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9xUe-0005OB-CE
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 22:48:17 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso562827b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 19:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745981294; x=1746586094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ONT8Deby67wycf5K2UhRwvBQs243yc2+QWu5SFdoVvQ=;
 b=InAR46oJF7GIPGzc1IgNcOOZYD2IraZrL6FgN0eSCBCYLwDRpAyas09j06V4otat+J
 RnLgqIJVNY816qFqMjmgvENZDXl5Xq4oLexORdsTDm8+FAlXIZm5gOVycrGiuY6LI1ie
 Fk3XGB2HxXWZVlgME/anKiMH7GcK+bhhxCQZY1gbkOtHJamEK0L5qqVeJa7BK6sScQ+0
 EneqWoq/w7hmMJyQkBIWNbkqO6TtMxQyMdWzE7kqM46v9JxD201yc/VM9fl0QBViNlW6
 Vi3ihcMNb8yFzHzpPJhyeRDQ5BdyrLwCBCJz6P8HLR89H8ATaKdctkNZN0LZs9rcUjhN
 m7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745981294; x=1746586094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ONT8Deby67wycf5K2UhRwvBQs243yc2+QWu5SFdoVvQ=;
 b=mH2stMRRKH/Ry6CRpoGf/7jm2HznFtvXEj6Gp5qtsiiKsG2F5pPQyo60mybaeVl5PD
 M8h81UxNza/pfUiCSkZOT128wuX1JGCLRB7gg949qzReTLWcjH8O8Y6EFBMhqy06sFTn
 t7eeo7OFF+hol9njUIkGGDwO1SEd5XdgZ3W5MEOlXw0pkn4MlU0C89kw3UYiGZkFjRTl
 B3qcO9nUAWWW24wrBze2dGcuR61QfxE71Pq+PlZh73mEn4Ed+dpPj8giD4zrONHRmP0C
 Cd90aq757jD6DA5WvD9oqdtZencHOwtWvtCTfbhqtjZtvV0XLYcttc7HSk30tTyAFLAf
 m0Lg==
X-Gm-Message-State: AOJu0YwsKMMr4Ycdz4UHzL4/ugIGwk+xRG/i5zA+/WRYn8zqjW5CE83D
 RuODm2VDDUXoG/+Bb6IQ2r6rxAgkD0y89ydcFCriUNAizQg4P/TTzipyb6uHAPFJ+1NvxYnUTTS
 s
X-Gm-Gg: ASbGnctfXEhUvHXlcwaj/C++RMtKBeRtoDVRKac5YqeUpN0JfrH5L8UBlMnloLvN75l
 F35hZqSzCqxCqII2CO8OE5wMLcy1+JosnJUkjfQymsCVO2t4AX61/REapaxbIvUlMv+9pvS2Mlm
 OQSR2q8WMvSIQA+fpiiaOS6c1xV9GoeytyxX+tDuR2xwym6JAH6hUSx7Nj/Yf1lVHruCc/Zz/ZG
 v/p+jTZGptoGawP+TTJVC/EQOf69HXLSiZpmRHw7D0Xkp8msmfTa+u9gcg8fEWoKkdpCLJMllfR
 cQFyUdq8jYwSCdRdMS3GHnJovrlGxohfKAu1KUgi0XhWeRw+FYHmcQwEavaXLh0p7zFdTowf69s
 QWJJxGFs=
X-Google-Smtp-Source: AGHT+IF2XVKZje7rYvRyaX2iJSe4zUx/dIc1SXngGJpskGBN3rZ/Y5382kS0XqugJ+jcsy8AJG96GQ==
X-Received: by 2002:a05:6a00:638a:b0:732:56a7:a935 with SMTP id
 d2e1a72fcca58-74039bcc704mr1399397b3a.12.1745981294442; 
 Tue, 29 Apr 2025 19:48:14 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a9451csm480712b3a.167.2025.04.29.19.48.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 19:48:14 -0700 (PDT)
Message-ID: <c64af9ee-5208-4395-9b30-a60df8b8bdfc@linaro.org>
Date: Tue, 29 Apr 2025 19:48:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Running with `--enable-ubsan` leads to a qtest failure:
To: qemu-devel@nongnu.org
References: <20250429155621.2028198-1-nabihestefan@google.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250429155621.2028198-1-nabihestefan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/29/25 08:56, Nabih Estefan wrote:
> v2: used ldl_le_p and lduw_l_p instead of memcpy as per upstream
> suggestion.
> 
> ```
> ../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned address 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment
> ```
> Instead of straight casting the uint8_t array, we use memcpy to assure
> alignment is correct against uint32_t and uint16_t.
> 
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> ---
>   tests/qtest/libqos/igb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
> index f40c4ec4cd..2e0bb58617 100644
> --- a/tests/qtest/libqos/igb.c
> +++ b/tests/qtest/libqos/igb.c
> @@ -104,10 +104,10 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
>       e1000e_macreg_write(&d->e1000e, E1000_RDT(0), 0);
>       e1000e_macreg_write(&d->e1000e, E1000_RDH(0), 0);
>       e1000e_macreg_write(&d->e1000e, E1000_RA,
> -                        le32_to_cpu(*(uint32_t *)address));
> +                        ldl_le_p((uint32_t *)address));
>       e1000e_macreg_write(&d->e1000e, E1000_RA + 4,
>                           E1000_RAH_AV | E1000_RAH_POOL_1 |
> -                        le16_to_cpu(*(uint16_t *)(address + 4)));
> +                        lduw_le_p((uint16_t *)(address + 4)));
>   
>       /* Set supported receive descriptor mode */
>       e1000e_macreg_write(&d->e1000e,


