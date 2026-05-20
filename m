Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CAACD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf8h-0006ud-Ef; Wed, 20 May 2026 07:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf8e-0006lI-WF
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:31:01 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf8c-0005AR-V7
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:31:00 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-670ab084a39so10067144a12.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276657; x=1779881457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9P6kJLGlxBj21okoCV6Px71wWiHku6OLNHzb1zVa5zE=;
 b=Jdj2VmHhhd3d+anXPW/DdiBij+3+EP+KcnEOtSz76lblILNQnhyhxXjlWkHQe4w5WI
 cZ91ZH1IHuFBoIvxmc5+7KWKyU5nA2t+TaUUZHa3HCmTd/QUQIoLZrSO6toMO36VUdaz
 1JouvJHiAumSgnVGpVfrRcZa1u7Fq5+0tTAkc5WrlbL+mySkGnEoU1MbB+ej7MjFQiJg
 6Wtk6g0Td7YgU6Y78kqyiSpO+jbXfqxh/wB1UN3J979FPCgX2HKSS1UgX77oKlQHpBNr
 GDoeMILIR7trbks1d5D4AK+tR4+zBzI09OkEOjshYFhtv9sCgFJhDuoNC/W1Ai/GJkfD
 i4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276657; x=1779881457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9P6kJLGlxBj21okoCV6Px71wWiHku6OLNHzb1zVa5zE=;
 b=XyRwCvxTq8+xj+eNquFfMmRYmfJpksf5Q2D0ov+SVDoXbMBgi+6v5WmWT1ubHzT3Mu
 B2ZGfvV+MoSrhWCbUewLHTgr2nB2FPg/WsB0pvn514ecpYzrF2ykmBBT2Qz4tc6Rlr6z
 v/jZlc06UOFHkwdAmpNYhnPx9VaMxBd217XscuyXAx2U02vzEKqH1onb4EIWp+DqJU+v
 A8vbFlHkfLvaQp5AD41d6jOXSPKt2SuZa2l1RHE67cHAOyXJxT+NI0wqUKCl5QtzyEEg
 9bBXjrCN7P2uAqBbekce08KUV8887VCRzDrMYoWxKCPwQXncn/u+dA3RSetW7s5s02/I
 hu/A==
X-Gm-Message-State: AOJu0YxO21wGuzvWTi3Aw4d5Npv1vkXVPWXmzLchGuY3yAWXCJ8XLSie
 J3MjKjqmM6AeAZ8hD0xfqOs+M0fDbyVVd95GRUv9PEvu9fF8X/WXTV+P/2r6Cu3nPK72OyyNEIR
 SYNEkAZg=
X-Gm-Gg: Acq92OHnQR7pbHgSUn4e18AXcQECZrGfgHpTIBnvVg7Gc2jQ0rT3YRetTS7IlXxc4uT
 Mx2dAfzoxPoPffccjDwqtfOri3lQXN1yoVJSMaCCMyuFa8VEgXelZTK1vksA/SmesUWF9sqyQcT
 ZaTWFf9sBm3GaxGxZh1PLaJrQMSPEuhdlsV3pM4tcAGM9Oq/QOLGVAPKIBcuY4UQ0n2wJg1BlHH
 m2YtPNucn7In3wqhdpoM8oG5y+egZkEpQCGMbaBZmg/UnVhGRemyERyVxeHJUc+8Wn1Qc4d5ymf
 oDNqSfkBBqrcGSSuvC7ieeeFAreWlHlWNRLDIOFvqziA0NEDQkpnxHOFRIM48zDLX78Jd3LFiul
 q31u+EMerhGcGvv2CdsQOHDlGDUVb/pVp2OciEXYy9OgZe2gDd5kb3ETw7EuzTgWRqaaCGRw3BA
 lrjOUb/QcC0hhnaFaTiUvyTfdabx32dI1lRIdMGTxXmwibJRSCnRNVY0VmxUDQLeFz4OyAsK4=
X-Received: by 2002:a05:600c:1512:b0:48f:e26a:1744 with SMTP id
 5b1f17b1804b1-48fe60ecd67mr213745285e9.9.1779272645236; 
 Wed, 20 May 2026 03:24:05 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe2464sm54040882f8f.32.2026.05.20.03.24.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 03:24:04 -0700 (PDT)
Message-ID: <078d2012-a1cc-4cb8-87cd-95893070d2db@linaro.org>
Date: Wed, 20 May 2026 12:24:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/24] target/mips: split Octeon SEQI/SNEI decode
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260520101807.9971-1-philmd@linaro.org>
 <20260520101807.9971-10-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520101807.9971-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/5/26 12:17, Philippe Mathieu-Daudé wrote:
> From: James Hilliard <james.hilliard1@gmail.com>
> 
> Decode the equality and inequality forms as explicit SEQI/SNEI
> instructions rather than using shared generated SEQNEI entries.
> 
> The explicit decoder names match the architectural mnemonics, which
> makes the translator entry points and trace/debug output easier to
> correlate with the instruction set.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> [PMD: Split SEQNE vs SEQNEI (this patch)]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/octeon.decode      |  4 +++-
>   target/mips/tcg/octeon_translate.c | 27 +++++++++++++--------------
>   2 files changed, 16 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

