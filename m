Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED36D68BE8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 07:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW8mh-0005Ya-4M; Thu, 18 Dec 2025 02:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vW8md-0005Y7-Q3
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 02:50:48 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vW8ma-00044f-I8
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 02:50:46 -0500
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-431048c4068so154549f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 23:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766044243; x=1766649043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BNuBMvcfRMJftO6hvS2QM/ySAK+YceG+Do76sWoYe0o=;
 b=BtIQ0N2s6GmdMwlx4WHBvMbrEbJnSRhjjilIUn3GAWZ8lq9Ok2bn0qaTJQaRVIaXIQ
 8LPtp1vF5P0rfMlgWV/F4vA8Mcuc7ATg98M4I5qxSP3zEBw0vRZS38noY7HMruaFxB0k
 kSE4FxO8BQvGfK8tQ2wSbgBk7IrKNnDmgEz2sWgwLqyhuWuL4+i9X3kHp8RhT4FJXBJz
 QqiY0tjk3LFzs4Xw7JTp493H+0W+blmVl0x15MSqXNVo+PRJuYgjFF506khICm17kTHj
 WTIWnvy4THp/0QweH1YP+t/cRYeIvzModeJjSICwt1zpSakhtHrEWCGGaMv5/X/qrHoS
 1aLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766044243; x=1766649043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BNuBMvcfRMJftO6hvS2QM/ySAK+YceG+Do76sWoYe0o=;
 b=FfZuTtj0JU7ZsCTG9bHL+2ouMyH3xWyq/ka5Udt3+lLtpWTOZKBtQndNqrEIP+pUj2
 kRmbqg4RzPItAL7oEEOZQh71KZ2/C0ymv1cDDkNwLAfRdzcLZKBFUDUVn43cxuYvaf3I
 9bNVqBCFK1aAx4CWYE+SkQpFAwmMOk//x8r4DIcOCy6/nzXqTL8YOFqpMd0IIjYugrnI
 XzcCSTuqBetafQ7RnsGTDfsm3N5LTgBqCwG++A7qQ30ih7QExtgVmcMBq3bfUai+khBO
 0JSz9BO7bvqujvooLNuAR4tUKO1Frh/hTNK/AYmGbzhPSQ2fv3BW0I37fyaKH04iyHu6
 JPaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjyyIvJvYfXpbEm69HpHyPjo1Ih+aJq2HMOz7Ri8oLAryZVecTBaNrLzjxSiilXsQQH5HLsp5bRGLa@nongnu.org
X-Gm-Message-State: AOJu0YwdZX5gnTRibJMe0pR8cPKcO16cZUQEawqzf+xOV8CWyrdIzhM1
 d5sZ9mVZphPuwwdFUasEq4y/YvkEkUdytcVr8jzrtb45aFbMoQ2mrAK/LJsQ1jD3wmM=
X-Gm-Gg: AY/fxX51rNmZzdaqfU7G6svjPLFpwCvHH6OY5O3r2PLPhYg5Ekh55PUqJh0yz7JWO+x
 6xiHiWf+ViarBCppGoQD33sMAzIq11rmIrmIniWEWIyTcBpDcSUZAaty3xmTx8DbUhbA2C2K+Ye
 AZdYAzgcieHRMH+YrnQOqzVvl/mqoyHsWGoStP1eR/Q9P9SPGweIqfHpw3V/QRidjoIKFyhf33d
 KL64us4nK7I/Zf9oGi0NbuOPSdYIYBRnAxqzmUJGr5jnfnnopc+L+vKSIXzsKtw0IjjXKeC4+YV
 x+B8HiYu4WiDUnK8NF7F137bn/tCVpyCMOU2nCJ6t2yZChxaCCyk8P4AtmFyLLVsbHX02hPcYz0
 FscGaDAvqQvNGW5ZAwhZ4Y0FhJRDTeeHFnyxHQYDD38eMgvBD3drBOSx5fUvoqCiZZr1wb39Eqc
 SUJ/oJYFeEulIAAEGHih248h1JELeHBsr9jvgtGvgmSK+yoq8PKcdmEQ==
X-Google-Smtp-Source: AGHT+IE/sk/Zaxi6Kn05S/nIUD/VoHHTMkLi7wP2/3qnhVmfuSDi3wxqB+seCrnUYZruKllxei1iRQ==
X-Received: by 2002:adf:e588:0:b0:431:1c7:f967 with SMTP id
 ffacd0b85a97d-432447ac138mr2019724f8f.17.1766044242575; 
 Wed, 17 Dec 2025 23:50:42 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324493fd7esm3574073f8f.10.2025.12.17.23.50.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 23:50:40 -0800 (PST)
Message-ID: <ae1c0c21-a464-4893-ac11-c0e831056df9@linaro.org>
Date: Thu, 18 Dec 2025 08:50:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-options.hx: use KiB, MiB, GiB for power-of-2 units
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20251218073208.160482-1-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251218073208.160482-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

On 18/12/25 08:32, Michael Tokarev wrote:
> Use MiB &Co instead of MB &Co when the talk is about
> power-of-two-based sizes, in qemu-options.hx.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3222
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   qemu-options.hx | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


