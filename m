Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9E606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SJOLPJPI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoys-00059A-Uf; Fri, 30 Oct 2026 11:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMoyq-000589-0q
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:57:24 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMoyn-0004R9-Rm
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:57:23 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-8439fe796ebso650297a34.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793375840; x=1793980640; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8FLy1IVBSFoy+pCwoMM5Z3zaCHkIMQJT6C82sCooXvQ=;
 b=SJOLPJPIU5n/RMRVn+IROg2GnHDK9F02W9CjCN+KXsWOcFajGH7czPLL0jHG7o6lcD
 fSrSeqFSQRGwWm+KM//vBVVJSmEhQrCqjoR5fRZQidUrnMTs2TYoXs1pDamwdPeHwIXK
 mhGOu1v6IJo45F2WVcuox8IzkkLqTUosSIV9VD2LU4MCsq1yllwmsutiRJdHTOhExP2k
 /u74rzoHS4dgZIW4F8Sj6z4W1RaWSS9lRD6CCjlkr1CIFs1LVTxbhZfdHQfH4JhNptTX
 WZsPhcesqZs+YvnDYrsRzJAeh45KB+pdJAd8XcuWSavn2FO2kHmpa7dE6scpcPGj8QQy
 cQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793375840; x=1793980640;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8FLy1IVBSFoy+pCwoMM5Z3zaCHkIMQJT6C82sCooXvQ=;
 b=g3S4bEAVqMSjgZgkXCYOo5OYgDuseZzunXXwQ6FilVPtrRDtgd8ag0VTsPdLsH9n/x
 tRX88M4scb+VlaQFP9X1AMDHA7uwP7KXP8musrmmI04FiruD0zPrsZUIuF3AdgGXDUBe
 Hkpv7gmoK9TV7aZX8xVgeGPApr2NZmyisJR281wsAKuNyAREq92FwhFWuivbl63cklzZ
 /YWGLp6SrTSw16mKcuy30prViWzxk6METvB45p3+443KgOq2IaYoCKHm/AYzkPFMYQEW
 PeSbW5kG5a1AIC8vdu3Juczj06RQahlStjpTtK9bKt5IIcBPUjsmxcQY3UpOU07LPJy/
 upBQ==
X-Gm-Message-State: AFq9FYIBHNmcRg4dRC0hODp9Pq9NtwNF8xFS3FBYka0L7e5PabwGqRlX
 qfu1DOERoF0FVYU2vKtVE70ea/f6TcQGkMkrBIBkUDqJHqiTQTTWuka69mrLwfpZozDm9tiqHEF
 DsKwk
X-Gm-Gg: AYBFou0MsgdXm2VXP3ZF9OIfcNiM8slc3ldrYsDaczhu0I2Sj4uzgo3Z6c2lQ7hy4dY
 ukn9xc88f356c5Z0cuoaJhZEDIlAy4sygB1tGYcixyCWoVS2CpvC5dftehUnTbs5Nh9Vv7wg9cw
 jLpID1NOcqG8IE+b3q7S0K3XjjySLtdH0UkO96lf5V0fnFCE/Y6kpXmjw6oSm5jaU7QVom7hkGv
 7NGiBknYeKdVAM+rX26IeRZqmq1PY1AYju3GHLOPPOOkx1siJLd8v48uu2yXkeNd5MkXCWVzi4Y
 7ggEa7V79uvkpdFJM2b9XW7zCm3Z/AdupHYcZxna1WW+hCzED/Gl9wEe4qZKSncOYkqq+LL/Jtr
 0n6xAtVR3Mhf3BnaTWwhJaUOUiD7q0mxpq4kZ30VTe3sD4PWXP+CyGRh2KX7YXOtB5fY+VREP9A
 uM+MJjr0s+vujFxsB3eplUycRIjOw9HNZ8YcwGJwVdA2HgM37BpHwlW9+mXtfISoZaT9eztjAy0
 KMCWzlHiMPBaSOPbEuo4AyB69CF58sM5/CIBr/da/iWhGs0zY5+AfOalrFj1S7Q8z91GhKUHdfh
 CpCdrxTh8jYt3eWLXFYxcJu6J0PGrTH3ihbfXsYz2cPK
X-Received: by 2002:a05:6808:1713:b0:4d6:9412:46a3 with SMTP id
 5614622812f47-5640deb2c05mr1964053b6e.68.1793375839564; 
 Fri, 30 Oct 2026 08:57:19 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fd9888bsm1896604b6e.5.2026.10.30.08.57.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 08:57:19 -0700 (PDT)
Message-ID: <dd0813ab-584d-4332-afac-33f979e1268e@linaro.org>
Date: Fri, 30 Oct 2026 10:57:17 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/19] tcg patch queue 20261030
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20261030131554.41208-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

On 10/30/26 08:15, Richard Henderson wrote:
> The following changes since commit 61436f5ff1c4e5ee8f60fa1a37962a60f73ea7a4:
> 
>    Merge tag 'pbouvier/pr/dockerfiles-20261029' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-10-29 17:09:01 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20261030
> 
> for you to fetch changes up to 0e68878f962a2117fc5de8a0025f3064bf5cbe9a:
> 
>    tcg/s390x: Implement INDEX_op_lea (2026-10-30 07:06:16 -0500)
> 
> ----------------------------------------------------------------
> accel/tcg: Fix false awakening of gdb
> accel/tcg: Do not flush and retry in place in tb_gen_code
> tcg: Adjust NONNULL annotation on *_diff functions
> tcg: Add tcg_gen_lea_{i32,i64,tl}
> target/alpha: Use tcg_gen_lea_i64 for S{4,8}ADD{L,Q}
> target/loongarch: Use tcg_gen_lea_tl for ALSL
> target/riscv: Use tcg_gen_lea_tl for SH*ADD
> target/s390x: Use tcg_gen_lea_i64 in get_address
> target/i386: Use tcg_gen_lea_tl in gen_lea_modrm_1
> target/mips: Use tcg_gen_lea() for [D]LSA and MXU S32LD*V opcodes

Applied, thanks.

r~

