Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA84DCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf6q-0003MG-Gp; Wed, 20 May 2026 07:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf5l-0002xi-Ch
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:28:06 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf5e-0004OC-NF
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:27:59 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67389cf78b0so11054988a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276470; x=1779881270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HfEVDfOeYr2KCaEmdrur19frHUH/yqzbbXUjON7IsyQ=;
 b=uJ6Vjct5v3DOBANM0aOuaKXvrhT+Qz3GSUS+UnFGxvr4MezW9ECkg76QGb5lXNg57v
 7PTHzxjJsdHywe8WiZ1J6l3YgKOK8t1gxEHigrD02blUoLBgL/DO4cGzEGqMsLi1QBMz
 pTb6Owbl/IGWbw6tSCzX/1C/bQvUVN0CZjEHmt1Fu3oHS5CSaNemK3Si35a0hvYSHKgK
 o28pjbgJHWuRZfoQhM1S6SmFgE9dECm/lpzllqezw6ybZvLhyqTN7ZafB6IMmDyBNEKH
 7KFGuD1J2jvUV3I+Xg++XVBnIkPEzE3YKzywc2mWSGJmJVJxDi6k75yCzvLbKjy2Za9y
 M9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276470; x=1779881270;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HfEVDfOeYr2KCaEmdrur19frHUH/yqzbbXUjON7IsyQ=;
 b=kMyMlCL/DaV1bWyAhWbgwScw3rItP1YA/5d5MDpIiK4VcHKJtykK6625KIZdmrS+rL
 29alkctby4nVCTYSolTIOgx7lwhWp8A0PREZE3SiGeLzlnB+pkrtKhQN87E4Wt0Tj4T6
 vtRB2ikofd4ifUongcGS3xtxqIqHXmxE827ykneVBOchnLIwYDLldhwBVvdT1wa76AWk
 DsfoZxd6bUM5Zhy/+LbINjD8DtbYj/KHbf59O8gqAKiJ1fxqQVylTyFg0uGcCCFmM3qz
 zUre/fqi5IYHpGb2zP5c4NtcHnIK9r3H6FIFDXggGJj83GeVLZjas3BIMJORza0e/4fT
 ITAw==
X-Gm-Message-State: AOJu0Yw/XZLPg0iVbdt02qZPN1u3HWsNj6Fp4T0EDRD9raeg3uARiNQr
 dTVgZ+ohgrPN8Ju3Xf0FAkE+yaXhcnXm3W3JiBCOA8wj7uXz51uSWr8DA6vEkxQESYhw1Z5t9GN
 w4DxoN1E=
X-Gm-Gg: Acq92OHvN0A5VWDFPmZLDMfZepvgHV2WwidgPmVqhTDtEv8FhaNAQVl+te2ccoxfBzZ
 539c/FONPsNfJbxzR1w3oRADCatj7jLD7Hp5Coul4yLxqHUL1AeFPcq/tiUMvtIoWVjLdEQaydr
 oc/UEOH7n9DxN1TF6/Xmu0sQsZbBmQmyss+Tqh47SDMC5AIEI1pLaGs8PMWY0fUs4TZsXOi3Fuv
 K70m4qxkGedOt2IknHb1d7ffaSeZ6o7DFWbrtTozkHdQpo/KpIAN0UYkv3dog6VncBayUmw/+yl
 N0GlLtdPkM7axtIyz3QzOG48Ju4QBD9moSbIOEocdJTekRUJKqr8IN3zXf97sEK/Y5diZyCA9Aq
 HOodFjsrLsUWdSZr07w/ARPBqD9sCPNzjtspQkZy+9dS1MNkCV9xNOkjf6LaNz+erdDdKMWx0uV
 DQKI+4jfy0OqX0ywDDIzNoN3CdhSmQOh2AWXxzE2rBaI199Cx3iSYBRtof2EyrdyXCkfUOCnQ=
X-Received: by 2002:a05:600c:4692:b0:48e:51f8:eb39 with SMTP id
 5b1f17b1804b1-48fe6325746mr382418235e9.28.1779272624447; 
 Wed, 20 May 2026 03:23:44 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45e6a135f0csm34179323f8f.27.2026.05.20.03.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 03:23:43 -0700 (PDT)
Message-ID: <c6075773-0ca7-4e54-a91c-8e4e86808570@linaro.org>
Date: Wed, 20 May 2026 12:23:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/24] target/mips: split Octeon SEQ/SNE decode
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260520101807.9971-1-philmd@linaro.org>
 <20260520101807.9971-9-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520101807.9971-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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
> Decode the equality and inequality forms as explicit SEQ/SNE
> instructions rather than using shared generated SEQNE entries.
> 
> The explicit decoder names match the architectural mnemonics, which
> makes the translator entry points and trace/debug output easier to
> correlate with the instruction set.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> [PMD: Split SEQNE (this patch) vs SEQNEI]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/octeon.decode                 |  3 +-
>   target/mips/tcg/octeon_translate.c            | 25 +++++++------
>   tests/tcg/mips/user/isa/octeon/octeon-insns.c | 36 +++++++++++++++++++
>   3 files changed, 52 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

