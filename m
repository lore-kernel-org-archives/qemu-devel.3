Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B541C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KfS-0000ba-Kx; Tue, 22 Apr 2025 16:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KfR-0000bH-Ab
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:56:33 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KfP-0007Uq-MH
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:56:33 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so5940595b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745355390; x=1745960190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W5EcTRLxah+sIofd+jQxOFhQ9CcsTjwwmUTLPMsw+5s=;
 b=tC9sIKBhalJqpH2w6uYRR8sTrpe2wHUTcDf0AOIf31t/RIlgJ6HvaaetueHAZ4/Gs0
 TGVPLSH+gUDsHCEwn83870HgElCk1SOq+rEa8X8/A1QKpbydhUu9JlJYEf3wJL3pRl2W
 y8I1jAvf+88kBKF19fasgSK0y4iPf6pSA06bOG8gknCnXhQMYaYVaH920Ypn/6BkCPdA
 rIC9DNCZgJzfkROHDLTD6U+NwVaO+ldDgJH4+TeyU/e3ZZrWrBWW6hF9dKWdThu8lCB1
 pmb0HTNrXo+CX0W+Sv+tyjAx7uSCDmCej+orFVSF8aDmiqE5jUf58xmZXeMv2bz4YAuX
 Lyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745355390; x=1745960190;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W5EcTRLxah+sIofd+jQxOFhQ9CcsTjwwmUTLPMsw+5s=;
 b=Gp0YH248g1i478MHFbSKXPIYMmoK3u9RfUOKaHahT6Rfr8HehvHvU7Xo0WP4//e9YI
 SwkdkEEOMh+5MuU1nNKRp3Z7fBUca4LGEOT66vEklc1vuh40cS5dyugSwgGaWctgAXrq
 O4nDjwq5cOiATDD5U9Dtwh1dbYTSk1QCEC/gnYx2uv6+wM4tc21GYB4chEWaDgHUISQr
 J+k4yDsrmkWCv9y7dKefaWRqMHnfhi/szrEZ/WlkGplZaDjd194gdI518/CUtndT7EMt
 +98HaIfJtVAXounsNBAKbfDq8nrR0HZZvubXoVJotJc9omgi3egxNzjRXrwmZzBIcakX
 e0/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6tafrJGtUceX/5ElACZsXyntzTamc+0qn8a7F4e7NGwKs5KDsT7C5PQ2UUcCfDmqDH8RZTbS1Kv35@nongnu.org
X-Gm-Message-State: AOJu0Yz0BqdoLUDkMn6c4IXtcoKF9bSTgiZKeDR1dyWcb9vG9c42G3GK
 zx+b5RuJMJ3KoWIWtnb+4rVKGvLrKusTHkGgQKIJjFaRt7l2WIjtr/sIqaT5VYr4c4pCzJmlJIK
 l
X-Gm-Gg: ASbGnct95uhrWm0GnCqQsEe7AjgMCEQfRe/geyQwt7YO1xbeeOebhXwDuSeeQOvwb3D
 wUgNBVejtjL0TyGryAZxwxynMMSfR1d23Z3VAB7qJhH/T8LZMH0cNzoPEekLwYm9f3SZC6BzOWu
 /T2PzlzfKeDZxZud5aBlld++iJIbXyuhcsNcQ2vaC60t6XBqiZSXYCRPgTRc3/3aL0YPZ7zligN
 iNVHwM+I7/IEH3RA2PMNGjkQjVUWGqMr7LISG+n7ytP/W7hlczbwmnzB/0N1I6RgSJhY2bTOiDW
 w41cjNPZI08HhrpG75wb8ZVe4U23uaoSA6e4KzFV8Zuz0P8MbzMmow==
X-Google-Smtp-Source: AGHT+IFqbDp4g6NG7YbsyGREa1zLyK2XLbcjyDzi3GFGdtoGO4+CiFeRSqLI0y2CexRooO+P+fDt+g==
X-Received: by 2002:a05:6a21:4603:b0:1f5:874c:c987 with SMTP id
 adf61e73a8af0-203cbc4d57fmr24532347637.15.1745355389947; 
 Tue, 22 Apr 2025 13:56:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db13a7549sm7872221a12.26.2025.04.22.13.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 13:56:29 -0700 (PDT)
Message-ID: <0044a86b-7820-484f-9447-5f302f47fa63@linaro.org>
Date: Tue, 22 Apr 2025 13:56:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 142/147] accel/tcg: Remove mttcg_enabled
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-143-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422192819.302784-143-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/22/25 12:28, Richard Henderson wrote:
> In qemu_tcg_mttcg_enabled, read the value from TCGState
> and eliminate the separate global variable.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-all.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


