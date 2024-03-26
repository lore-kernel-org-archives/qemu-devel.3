Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41887C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 20:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpDBs-0003k7-OS; Tue, 26 Mar 2024 16:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpDBq-0003jq-UH
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 16:14:35 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpDBo-0007HU-Sf
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 16:14:34 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33ed7ba1a42so4017821f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 13:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711484070; x=1712088870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AmfBwCsoa7+XjHQ3O5ziyv79PT7uoKscXzCDLXQMwnI=;
 b=VKGlHkUF8mA0YQ8uFSCPEgxHGMPdMTS8T1LIWTLOaqA+0G4XjtFBKGH/vknIcj7y6l
 //8Im56fRN1zoIbZdqPDWFsBTcqs0yL+kPsNEHcXy6zUzuH0zNbppDouyCgwYCwVud4S
 3k6pbIZQYw0H69JRqQoG0BxX4s05KabaaI1MBYSDZmNhYctkkFW9nrB0bOreza7WvLw3
 ZYkrI/yfbc897zf0drsdL6U5C73X/kYyX/QN8FNLEsXY3FIq4giq4R2tT51PBy7UKuES
 8R5c1olIxTwPnkFpw5fK398GtfTGQ2h/xWCG9Jc02xWAQggIZLBugRz2IyFDNvAGADCl
 xwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711484070; x=1712088870;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AmfBwCsoa7+XjHQ3O5ziyv79PT7uoKscXzCDLXQMwnI=;
 b=UNvdeHvwDG7uaH6Nil3R6TXW7xfwR/AGSSB9oRVsKknDmPzslZfAO1rXHGeH/WXbLU
 dUZQjJbIuRK2FohoUflJMLOzZmWQmNi80Yz/p3a2VXU/tPLlR5Zy3r/oEo8U7VGOZkR9
 yHWGQsrNBWdMlBNCVJxGYBGegCutyb2zd7x0d+MnZCXr7h1mbOyM+PsxjFdDifmFVDAS
 P9rlCkUVi4gFaL8prTuTHDzgduVl4lk+070wd8vs2srpgNtGrBU4I/PzTDLhOdak2dyj
 Zh5/w1h+V2NYRJKCmmhRDTv2XQoCMYIL8OVdUUOL8svlBjIm/EAUYGIwqnm/rDPVmimp
 Tw/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvUPKJLxd92UHDDGF1/GeE3GpqOkw+FgSNO2oUTxx8oL/5ismpE23/XjlLSrqzJwvt/pzF3T3xMj/kBOM6XAR9+Rur+1M=
X-Gm-Message-State: AOJu0YzBKFx2mSK25GKygt/By2Ps9MOmPEiQANf8FiagxF8KVGJy4JY/
 PbtpvVeUWR0j1+bgI9KZsg0rdtT76hoSU2UDEByrWyZcAHrTBcElWnuMe03K+JI=
X-Google-Smtp-Source: AGHT+IFUgutgMpli1IUsZyX4Sfy9n4lnQ/83PAqNX90dYuPlqmJHpPpRf71X3pO6KMyZre7r4umWOA==
X-Received: by 2002:a5d:564c:0:b0:341:6b6d:ec34 with SMTP id
 j12-20020a5d564c000000b003416b6dec34mr9099784wrw.46.1711484069795; 
 Tue, 26 Mar 2024 13:14:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 bo15-20020a056000068f00b0033ec8f3ca9bsm9563752wrb.49.2024.03.26.13.14.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 13:14:29 -0700 (PDT)
Message-ID: <f06fd00c-af68-463d-ad75-c525cf48258b@linaro.org>
Date: Tue, 26 Mar 2024 21:14:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] target/hppa: Clear psw_n for BE on
 use_nullify_skip path
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sven Schnelle <svens@stackframe.org>
References: <20240326183501.333914-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240326183501.333914-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 26/3/24 19:35, Richard Henderson wrote:
> Along this path we have already skipped the insn to be
> nullified, so the subsequent insn should be executed.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Sven Schnelle <svens@stackframe.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


