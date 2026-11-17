Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53D6606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZuJUo90r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOeT-0002EU-Mp; Tue, 17 Nov 2026 14:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOeR-0002EH-3F
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:15:31 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOeP-0002cR-Gd
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:15:30 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3b0ae87069dso26838a91.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794942928; x=1795547728; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D13w5QasMmdbaO+wYyb/bxjsMntx0KGgTnDfRLKVJSM=;
 b=ZuJUo90rklZfNglL2qZ6v89GHE1//vqEvcLUeFGR3ayoGCOuIthwzGDx9yFEno8aSK
 qvYfjcD2pCgmSHCuJSRT9coGg40Xm1fu6uhIFiWsxkvVcO1ivfZRXQj0UshU50L3zczp
 EHeges7hSANWQpqE11xHC4EzAQGfnWB6317f6nv3q9jFg9iHJ5J1mP41oIbbACNLJHjK
 InItgC3T2byoeQdUFLKNH3mOCxOYlrTpuNTwRJDYS2j2vpzUIYeYo6GF+pLLN+ufM5Fh
 I4IA+Q6P0P+ojOGqsMHk7vnd1G03bTgQIXtMxAxUBONGZzuZNtAVDTjvPc1KaBKDdpWc
 AdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794942928; x=1795547728;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D13w5QasMmdbaO+wYyb/bxjsMntx0KGgTnDfRLKVJSM=;
 b=Ou6Jv4Y9tmrkmp4+4ocvz2Y3aJDigG8MDsjXSXr9pf7hGKgKiLn/ZSo3M8dVK97e1O
 hIk9qw3xIWfyB217Aez9wjZkW5smFKsFuXYP7HG/6FIW2f4RIZY94GkeSfgUZrllv5mW
 KlyajJKrksT5V3E1PevqF/psRB489PNz1PDKA+bropgphdmdjcxpuXoyVZmQ1H8+AdIZ
 ZbnHf2pfSt7ychPc4jGPCHH6W4K75d4/2Zs5ACIqXLDy4eW75mUQ0xpUGUcu+7+TTFZc
 N3yP5mOU5ewIhOJNRa8s5hePyHWatGg7r7KjC7o4X9TldyGlMfoSaWJXdPLqeYsZiLfP
 aKzw==
X-Forwarded-Encrypted: i=1;
 AL+hErEcEjoulfcwyfkFdimyVZ8IwG7Rc/6NRlLbDvy2EcONg7av3AKyWyNkzRz8k/SsvNE9fr/rJP1iWwP3@nongnu.org
X-Gm-Message-State: APuU4Z+rmLW/xZtV8R2quf9wnLRPyZGqZT3Cmq4w+fmXqpoua9MbjKYh
 W8bZb3o4jTnuJb+LQG6yuf+65SFPU+oNmSCUD9Ryh2KE/PJvLhOuilKYBd61BmXpuN0=
X-Gm-Gg: AZFdTZfS3TpktZoLALyFwUBMv/GzS9NLk7j/JyOMDrlTJTJJDmr07u0yDpPGxJ5H8Mk
 Kr6RwMn7MDzxEKlG2RKrDy2Hzq+A5lKX6fmw1Rs2+KOmIdOkXGhUCX19/1ZD61RHGvufWZfiwzg
 +gzQnrMj/4dWeK9iiDT7+aWFk7ghD6iXQ7xLKo3yfqBAFbPS+51gq4eTZ2Dyum+GQ8i/u1uU+CY
 P+F7tYVn6NIHbw4Z0QNGMFfK4E5CD728BvpK84VFmNoQdGRQAZMYlW/ZcZnJdm+BHzYjY5B3PNq
 UefxU9P/dHoS7mdU6AWdejBlELzCM7JmM/mMO0ijcxcjNxC958DAcQAYjNpzFfzTFvPi1yqmObZ
 msk6+7efytzY3S+4q/859OcfRyhaHNCHuncjXR6cFef8bURRdC+X7hTmel2Fey4MgBDLD0w4hD7
 J8VGaB//2CHMEJ1F8wL7iZ/vD3EOzfU7fqGVdTvmECA1nZylsdbOZoQpjO5d8d8ndKUl0IOSCQm
 U0IKjEXD0UIKmw+0r0pFFLTCp6zBCR6BAoPkZD0QUycLBbB5QOCwNB/GQPHWqdNhqXoMEcKNwiI
 bCfHX2Ld+l5x5EDoSYzSW3FBBa1zfwVtkYC1p5nLF9L3JLMcm/7LCymexWsxPvkV1hNJ8YA=
X-Received: by 2002:a17:90b:2b4b:b0:3b0:9e2f:cfc3 with SMTP id
 98e67ed59e1d1-3b3d07b927amr323167a91.32.1794942928131; 
 Tue, 17 Nov 2026 11:15:28 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3af4a70c7sm4870049a91.6.2026.11.17.11.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:15:27 -0800 (PST)
Message-ID: <2c91f19e-6b3d-412b-97b2-24fbdea9fa36@linaro.org>
Date: Tue, 17 Nov 2026 11:15:25 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/19] target/mips: Pass the right instruction size for
 nanoMIPS RESTORE.JRC
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-12-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-12-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> RESTORE.JRC[32] is a 32-bit instruction (MD01247, printed page 155),
> but gen_compute_branch_nm() was called with an instruction size of 2
> (copy/paste from the 16-bit form), which wrongly set MIPS_HFLAG_B16.
> 
> No functional effect: gen_branch() clears MIPS_HFLAG_B16 before
> anything reads it.
> 
> Fixes: c02809830346 ("target/mips: Add emulation of some nanoMIPS 32-bit instr")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/nanomips_translate.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

