Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C5FC369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 23:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5CL4-0007PF-FA; Wed, 16 Apr 2025 19:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5CL2-0007Ol-Rg
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 19:38:40 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5CKy-0002H2-Vn
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 19:38:40 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22423adf751so2491515ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 16:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744846714; x=1745451514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eapEQPF2KNnMa7sI55bTpadCqRkhMi5xjeV7Dq2Dl00=;
 b=TLyTegtGn+/C+MM5TPV/XaCTohnt6O8NQGCIJ81bCAY1wKSHxZPQYQyC4mEfLu6/wk
 NuBsdg0b6htobnIr3kv6E2dh97xccuJ7KOgk1zaBYV5O2kYJkWYXw+YfNA6dBNusqLdy
 M6Rahm57agbSKCtsf+esrayQXgqYfyXt2FDZ4tgkoCXVQnaU3oBrQSH6WFEEDpklBq7g
 DnSuu6rYok0srOYF5rEmc252Oh10Jc4m6+u6xppp7BMxIwFzthx00Zw6dyg/2S/j6kBG
 curSTYpw7bR1Dm0+zR7vWlMnZBaVSd9kN5WP26crcz6KilCLolJZc5+2d+aGAh+O8JD+
 QufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744846714; x=1745451514;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eapEQPF2KNnMa7sI55bTpadCqRkhMi5xjeV7Dq2Dl00=;
 b=C+u4vyCsLkECCsZ6+bYnjG55eg1KKGVk0MfttJjkwRRpkxDuB44ed90bbD90RNZ6gx
 LTgpzgSr1e++6SQkz/OS8K7cf+pkzEMC0rfYHSx8tiijfQWXoWT9OIrFoxygYIkLv8RI
 B0/GmkrTRmeG0rjmCWiZXk3AKKZ2RAM8bmICqewwI93DqI18FexaKBWoJ+RERTxqHq2h
 wxJmRaDTzMoLos+qjm+3xMl2K5CkgMTekz/Gctd/Hch3ASLnJcrYX2y9LSCIMXUYVT6f
 CK7lJBo9bHAOTpErIGdYV701lbeGIrbcj39JhDaw3QsUERBfvsCJeQ6M7mxnBHzbrLMy
 0JSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkNNm7mL8MYyLQ86K4o74dapf89pAztk8D2ckSSHXr04RtR5oWnM5XJws7Z8sOslFXvOMc7y/HIcNs@nongnu.org
X-Gm-Message-State: AOJu0YyNNYtGue9U6uOnlxT3TImCNwusvm3B7c2z5bmcK3pyPGxIwS59
 ooW6SKV2c74IExDB68b0N6DqjCIgS4spWnVUduz/3rC2hhhDRk0GAWDh87yzzQw=
X-Gm-Gg: ASbGncv6c0kcI0A+5EzsuJCbgvrKvGpZOfGdlCPIudEX6La/osuA2bBKJgXbtXs1KJE
 GgKQ1f+in3qLy5mc0A+rcdQhb/VaoPml+pZZK/gP4+jrZ1tsmFM6nB5zteLimkOirJ/yyT8Se4A
 cT9s6cTqO+wAqpWjRsSeif2dZtvrn4khamcZyDCOzmlIa8PnAFdee9RwuABx1sMPZrc3/1GOem6
 /j5w3XoXGnBKneeWCCPEpCm/UyBwCIzNO2KjJbl/zzK+WTDQ5dDha4FoQXe4DxZbB5VlCl4fPwo
 F6rD/I1KqDtzYM1bRNS+gCns64Bpw/qqLF4F5JJdtPqrjSX0a8/YAA==
X-Google-Smtp-Source: AGHT+IFNwHztofyEwIPX75udaPDxZZeGxyIzYH593JU+L1CXzY1woQ+VLbBCDp+LszqcvKhUIe2HMA==
X-Received: by 2002:a17:902:d4c7:b0:223:2630:6b82 with SMTP id
 d9443c01a7336-22c358bcd40mr54252655ad.10.1744846714081; 
 Wed, 16 Apr 2025 16:38:34 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fa7794sm20358185ad.156.2025.04.16.16.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 16:38:33 -0700 (PDT)
Message-ID: <a093de11-8901-4e1b-83eb-fd3b6a557249@linaro.org>
Date: Wed, 16 Apr 2025 16:38:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 000/163] tcg: Convert to TCGOutOp structures
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

Hi Richard,

On 4/15/25 12:22, Richard Henderson wrote:
> v2: 20250107080112.1175095-1-richard.henderson@linaro.org
> v3: 20250216231012.2808572-1-richard.henderson@linaro.org
> 
> Since it has been 2 months, I don't recall specific changes from v3 to v4.
> It's mostly application of r-b tags.  There is one more patch, which I
> believe was Phil asking for one patch to be split.
> 
> Patches still requiring review: 29, 41-43, 46, 47, 49-51, 55, 57, 59-62,
>    64, 66-68, 70, 72-78, 80, 82-87, 89, 91, 93, 95, 97-102, 104, 106-162.
> 
> 
> r~
> 

Thanks for this series Richard, reviewing this is a good opportunity to 
look at register allocation and associated constraints in tcg.

The new way to define dynamic constraints is quite neat, and readable, 
as it was one of the feedback you previously asked.
The only concern I have is that we could create silent "performance" 
related bugs, where a specific feature is deactivated because of a bad 
combination, but it's inherent to this approach and not a blocker.

Even though I reviewed this series, it's hard for me to review all the 
target specific implementations, as I don't have your expertise on such 
a wide range of architectures.

As a more general question, how do you approach testing for a series 
like this one? I see two different challenges, as it touches the IR 
itself, and the various backends.
- For the IR, I don't know how extensive our complete test suite is 
(regarding coverage of all existing TCG ops), but I guess there are some 
holes there. It would be interesting to generate coverage data once we 
can get a single binary in the future.
- For the various backends:
   * Are you able to compile QEMU on all concerned hosts and run testing 
there?
   * Or do you cross compile and run binaries emulated?
   * Or another way I might ignore at the moment?

Regards,
Pierrick

