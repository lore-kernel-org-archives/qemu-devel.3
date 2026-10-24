Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DFC606A31E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fwJRcPuH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKZjU-0007nn-Lp; Sat, 24 Oct 2026 07:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKZjL-0007gw-Bd
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 07:16:09 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKZjJ-0003tR-Gp
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 07:16:07 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5b8f5e2ce5eso1832387e87.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792840563; x=1793445363; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NqvxWVt9ZhvtFP2fugVIw2CvJ6HxkuDPpgeajtJCPBo=;
 b=fwJRcPuH6414vV06tKd3GX4duJ4Go8MNy5+e2/2CXjYRm4F5dRJOPMdf3CflEhOwAj
 8kCDOjLB0b4MCKLa/c80f7bOhuRPfh57bVPciwjxHcxHNOPDccqH2D+Bckj15c9stW5g
 s1iK7ckDqgtQqYWe0m/nhI82HpS/Mv7rwOJR7skiPPQ53WDl+QDxEPELRLFAWYY7K4MI
 WwXpmhCjHpwjZUMufXhc4a5J3mgdlbfzDVjAvCV9NJMrDs4PW75zDOQYhpAGZhvrS2u1
 JWwLQpc/pKjGFlnCOQiHxZqsgJ21/ykBJN2a5TosF/l4SinY46Hg1glWs66ocHjy75+Y
 tAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792840563; x=1793445363;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NqvxWVt9ZhvtFP2fugVIw2CvJ6HxkuDPpgeajtJCPBo=;
 b=2HkgL/m7RlChTlj3HytyAJjqrwCUi8Td7+dm7aTfO2PghMyYLbrH8yCg6KMW+9Kdv9
 JjM7WZ9lzrAdilDRKe9ypLfGrJeAtdoocte2AzNgclDqnblF+WYpCLQ/TsL+V8uLHH7/
 EVdrUyI8Lki+J7XayLARnYgB4vVxsn5Wams61KeKYaaENoWeyvDPAai1DIdkJKAvd/PR
 A+VHxd0yTe2xss+QyPA1AWRHnZa3209kmoQDphNH6FM3brNfD2wVUe91sbucd1awdhVC
 B4XaeKHxr2xyiJ6Iz9Mru0y2KquewZedM4fLj6iYBHxxF9Bp/J73arudDkCRbq5czdS1
 AiSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6ZtN+DBrNPE0yBBbSe7jRH0IK/gDZNjE3GzonQvMIgzaONNlQESibekYLEEg5bQ+fBk0Or+zUNtXn@nongnu.org
X-Gm-Message-State: AFq9FYLELIrpmjewmcvZ4HJnbSVYSy63bR1sgVA+qjltOGleisq9v5t5
 UraGcg/0jJ7Ds7PJVK/2g4su6LLa9r0kligmidVrZ69Jf1zNMH6G7QHhaaDILShxKXQHZHCUZHo
 syPzd5Mc=
X-Gm-Gg: AYBFou2NrqpbiGkGu1+fZKZElDgp1fTp3Ndiup1rBtOTQOEi/ujzvzZ7AeA/xvA4UbD
 sLbT7NnIj87mSPQ++gp7whfIZkv8Zfxf58PZoBF8Hvk8PxU392vHF9pkNboIwC9E/xq7E10vK6q
 +WT9G+UWWoPne3dUSuwVqyKzgoq9bTf2ptTVv2B2NKAuh0bRD4jZERZKWhEVXNjoN5HbiQEVyUZ
 QvsP30VDKWzrCcqW6R1V6rjNIAdc49NCb/vmo6NmswPQ6p3m7qXim4Y03fptLwfYr0JBWEvLpYz
 YTWGJWFLcJEpuwfP/Bh06uUT7tXn0kRKjfjIB2iW77qc1K3c7FMhmlmTCqwByglsH7y0InPwFbW
 KoWjWJ6RabeVILk524OshLbELLir+sDJCOYfaXgNx1rFrYQVZInF0bezwCYqTry2Fguqy9Xeyu9
 pPGGvGHODQikO3pJPm7Fhu/43IYPv8/GQIpgjNv7p0JHCDEgfwvz8PYlg3Wx9vquvBz7lpqr5fH
 ExCeAGcfjrllszVWEz3+26fZ89PvOgDC931MXC5lh8cMEWcU/grPhFPF5O3xPlmUKO2
X-Received: by 2002:a05:600c:5253:b0:4a2:148b:c88c with SMTP id
 5b1f17b1804b1-4a35ac8ba2emr22577025e9.8.1792839978927; 
 Sat, 24 Oct 2026 04:06:18 -0700 (PDT)
Received: from [172.20.4.74] ([176.95.65.245])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0bae01sm60591765e9.7.2026.10.24.04.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 04:06:18 -0700 (PDT)
Message-ID: <1b4641ae-863d-40ae-9218-53fca02ab011@linaro.org>
Date: Sat, 24 Oct 2026 13:06:16 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/83] Misc target/ patches for 2026-10-23
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 18:12, Philippe Mathieu-Daudé wrote:
> The following changes since commit b6c4b7e86dec12d07f5cac65265b986d38ee9002:
> 
>    Merge tag 'pbouvier/pr/tcg_tests-20261022' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-10-23 09:09:11 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/target-misc-20261023
> 
> for you to fetch changes up to a0deb11baf6e5818ccd641088d9465e0e0eac9b7:
> 
>    MAINTAINERS: cover riscv GDB XML files (2026-10-23 17:52:30 +0200)
> 
> ----------------------------------------------------------------
> Misc target patches queue
> 
> - Make TCG halt-to-exec transition explicit and remove cpu_exec_halt()
> - Various conversions to translate_for_debug()
> - Add common CPUClass::exception_name() handler
> - multi-target: prefix helpers with target prefix
> - Remove target_long_bits() from GDB register reads
> - MAINTAINERS updates
> ----------------------------------------------------------------
> 
> Marc-André Lureau (3):
>    MAINTAINERS: cover m68k GDB XML files
>    MAINTAINERS: cover x86 GDB XML files
>    MAINTAINERS: cover riscv GDB XML files
> 
> Matt Turner (2):
>    target/alpha: Record masked exceptions in FPCR for /S insns
>    target/alpha: Determine tininess from the delivered result

This causes failures in the saved float_conv* test results:

https://gitlab.com/qemu-project/qemu/-/jobs/17436241199#L4986


r~

