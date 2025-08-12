Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136D9C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliSu-0001ze-1a; Tue, 12 Aug 2025 02:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliSp-0001yg-NO
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:26:29 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliSh-0007bk-5x
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:26:27 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b783ea502eso3504347f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754979973; x=1755584773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MaZesIfsMfFiMIqO7r3EVg8Euj+Lu2UnTUbnzTqaLUI=;
 b=DMG4+kLdcTM6nHGqFJUXLfeDXot7jk/EHNNNHLVnFrO1Ad0N1bY4kuJPsWsFDG2Qke
 cYZByCXVySy6rp17ymizdkjq6KuWpylDyiJ2msgvwbIDGoPHWOVr+3b7p1i97Su5D77M
 TtB8p5L799BDUD/UKpBkVtfH1+wslSNVtsj8Rz4FWOPmBx7NGCr5JONfDIIvopieo8B8
 6HgCHVUGfiZloIt5FqhFWA85JoujI4nyg9LZ6m8tSE0bnW+sv2B0hWIrgtK93LwSleBM
 heKizj7l2hKgXbekXRQHr5LxN7N4jRHd9SluWP7pu/OzYf449ce/B7GSk0HAglVV5gOX
 pahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979973; x=1755584773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MaZesIfsMfFiMIqO7r3EVg8Euj+Lu2UnTUbnzTqaLUI=;
 b=agMN7W+Vqdr4T4UtrO64WyPvGv2CGfxzuObyj8680800Ij/q8UkyVlrsMZNmsrJ99/
 sC4+r0RFksmg/Eyz6/EBVWTIIZK7ZkkkWRkMgbSVXPXiu4iwL2ilgxJhPvIrNt/GU/4m
 URNk4zLsn53AbPvrgGleF7nU5n93hHppFyMzPDOcDaSn72Z9/RHfaShLkNs8ug++vTL3
 w3nsqmHO1EjvX2ulVpwxwwYiR4mbMyFjmG+qk+bKXqctwNl+YqjuVBFEX60CPQiKic9M
 h7wETQIDQM9amRSTrH0KMZFkd0vP+EE7QMPmdqwpmDGqzfzfgUYTRqeM1QPYUr+GGtTm
 ZeSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1uSKp7wYaA59DtenLBlZClfDi+xgnsy3oukGIu64EFR1wWcxUcOzWcd8OQyh9pPD/IOcOigEqns5n@nongnu.org
X-Gm-Message-State: AOJu0Yx4TXdDJ3wR4RWkdnULylFoOrA6Cix0Qy0nPPcJHjTHcg6D+sL/
 Bc8qXxV7aIwonkEc5lVTwhBlm04oZxgQVRlW0ot6iFX69WGTn0cau/OsMlQ34EGat18=
X-Gm-Gg: ASbGncv3Y/XX3oJMtG/dhWpqS+DVMSIpWZ7/DsJxS6tNwPN76zXz6Vsvu18bChc451z
 FUd+QF50xN5EGt/jdZOzuesxXv8WCgGg6aAh6JBnMEyfRDzn2slc3KrPL4tK1MzontoGyaPMoWL
 P7GLRQA7H1XeCdclcaNoWs5oF7G4W3e2lPvU8/uF1NqiFdfMlsB9O7XTpqTR9mBJyvr9Ewg9nrU
 5zZ/KHsl1uFbu8F9T26zYhkR8x/eLy6VKQSjmU0SeAVO/MiGzCAQdurWghNR986bBDDfd0yGq3A
 0m8GAxdXF0zz4tY5Zi6y/WRUFoMaYKqqe/tlSqoaItWWuS3P8WGLI7hWouh/mlzfbRjEYtJfEUQ
 sLvy6iHi/XyxIrGNZhMSGv7Gg+X9bNn5lESMzU/uCVB4xUbwxpuTiJ5Sb6twYAsmcEcrxk4QB9L
 RN
X-Google-Smtp-Source: AGHT+IGIHjzsp5mHSDzX845fNj3QIun4CKGDIGmtOFUoFgqB1C6G4qkkQ9q8qsQc1TO1VApMWR6i4w==
X-Received: by 2002:a5d:5f4b:0:b0:3b7:7909:5b22 with SMTP id
 ffacd0b85a97d-3b911160834mr1716920f8f.8.1754979972783; 
 Mon, 11 Aug 2025 23:26:12 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c470102sm42759081f8f.53.2025.08.11.23.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:26:12 -0700 (PDT)
Message-ID: <3abbb8de-bbe6-4404-9714-50b487c46a8d@linaro.org>
Date: Tue, 12 Aug 2025 08:26:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/85] target/arm: Expand syndrome parameter to
 raise_exception*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-24-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/8/25 01:28, Richard Henderson wrote:
> Prepare for raising exceptions with 64-bit syndromes.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h     | 6 +++---
>   target/arm/tcg-stubs.c     | 2 +-
>   target/arm/tcg/op_helper.c | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)

Maybe re-order with previous patch?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


