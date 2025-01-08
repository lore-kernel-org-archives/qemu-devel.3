Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351D9E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdBh-0003S9-S9; Wed, 08 Jan 2025 16:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdBg-0003OA-9d
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:02:00 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdBe-00087w-Rn
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:02:00 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361f796586so2675565e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736370117; x=1736974917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ehfq1ffV8wUj/TGvS0nA3MzfJWjNX6FtUOdpJIjzIEM=;
 b=KybJJxOlBqkPui0zFMLPT/WUsOktnh2A3uxV/lizruYdbAjd/kl5tcDzgCNneqhnRI
 3ap0eXStBmlcHklyhkAfvgIblsiCq87i756BR7KhhdF2nO/+zrjwUzCNaDK/2vDZy3b/
 Q4+OrZPyke/MxIE0mX2SkznQ2uyDV6mXbgsIq96Ku7GfrDDY1tO/Y7FfzmXj6/kGvLqL
 bt+cXHTHqPKW6zin8hDFxxRA6XcrjHy2a4n7ccS9dYdTgtXoFwpZhlkxhdQlyxCnb/4+
 UbaiHFAXcUJv2uGX+QPVI3tLKys685HBGOhpHe3FdKlGPkfctq+b4Um6rDctuFNUWgcw
 Gl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736370117; x=1736974917;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ehfq1ffV8wUj/TGvS0nA3MzfJWjNX6FtUOdpJIjzIEM=;
 b=WA04/5SfI8naMeJ1o9zrdOPrmhNhKFc6kYkosYUnOa3K1U+4H15lcjkebMUuURVAkJ
 IpCMSpdQ0Ak5G9ExneVfd/Qv+b+ic1F63Wkc8JaJtVtOvsotr1Uj9QQqeeOPIE0GQRZn
 gJpEG2CX6o8Ylt6zo/zqQtW+V8XFyGzEzZPEbqbCTho4/pRih1uVhTSTCDK24poLv6Co
 WzR/0d4rLaIrZ6R0J2zXZkZmOR0NLdB5ImS0Hult6WTbTW96VU+sRog25pRrpmjbu3G2
 yzZoCLg/wAT4SBTsa68x1LcUetBjorTKQHdqntgpuYVXJsItH5dt+AwcfWFlPwwh493K
 mGuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb92dIe/5hMaLwJDnZpwtH3ZzMYPvbJzDrxkl8axXX1/LJkQNqKYtIDbUGGMB33KxgyFrYaMHUEzG3@nongnu.org
X-Gm-Message-State: AOJu0YzcdJx8i6qkUDsnbBpf7laRwKSBTlBZ82VmYgMR4J+7mgZE3rrR
 87jdj/gHQwAimob6G82B2ZJAmUScWFVFoHmv3ajCntrs0IIlsvMY3riE1xTp/qw=
X-Gm-Gg: ASbGncvIY6E5rArU47LyE/And6xCU+4JtgFTQKKWuVd2yRP1WEosVtqNN9NIHIalrR5
 j44kyZszdncgSrRWuNwtoNOX1TtbCagQds4xK3hsM2C6xy4c4MFk35NST5fclF7c7i+1ZzrN8QB
 28DbZG1EqqRhZLuleELhx+N51mG4c1g7LsqkmVuIwEWQv5/K3ztGZLgp9SsdwKZWt3nvJMJR26c
 tXCigLjwIlomFqw63r4Kd7LwfKgDdz2JgqgZEAmtU1uLqiF98n8qkFNEWjf3GIqZR05nYZ7Uh2j
 BI6ZdUQHEDiixJKkUmUkwMKy
X-Google-Smtp-Source: AGHT+IE5Z8IQVdUA2hUzCBk5DyBKnN7FT0O87HzcWeyGpzo1yZ6S02Q8paJriD+pzVHuG4+bJd6+Ig==
X-Received: by 2002:a05:600c:314e:b0:434:f5c0:329f with SMTP id
 5b1f17b1804b1-436e2697947mr41991385e9.14.1736370116673; 
 Wed, 08 Jan 2025 13:01:56 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc08eesm33208745e9.10.2025.01.08.13.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 13:01:56 -0800 (PST)
Message-ID: <8a54e773-1508-419a-a351-0e50291bf25b@linaro.org>
Date: Wed, 8 Jan 2025 22:01:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 74/81] tcg: Merge INDEX_op_nor_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-75-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-75-richard.henderson@linaro.org>
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

On 7/1/25 09:01, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    | 3 +--
>   tcg/optimize.c           | 6 ++++--
>   tcg/tcg-op.c             | 8 ++++----
>   tcg/tcg.c                | 6 ++----
>   tcg/tci.c                | 5 ++---
>   tcg/tci/tcg-target.c.inc | 2 +-
>   6 files changed, 14 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


