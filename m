Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C80606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G2hAHv6a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNtt-0008I8-VG; Tue, 17 Nov 2026 13:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTNts-0008GL-DF
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:27:24 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTNtq-0004eb-Of
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:27:24 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3b3a914e4c8so14951a91.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794940041; x=1795544841; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P0mEH+H4NNwoXl7YSoG6SqKDOlQf1aO9wo0NwJfmnRc=;
 b=G2hAHv6aNFpTYSzgdkCySU5lSOHRyhFEwSSQOy4oz+MrhnbEiBTLayfvMVTsTduq4t
 vt4o43gN8G5nb6S+Z58BgZMYeVaJiNTswvFluXwmq52ZhsXXSSO7WwvhrcPryFV/Ovta
 C3niS3VQU7xVyM3THu8YQf6p7ZD1oY4Q3uJ5gsS3XD/sU2kR+Uj5qdBO9gvAvJhFB4YZ
 QuLIPLvP3561yTI3h0ahN3LVAyLf4s6wHXCIWz/+4kybB8WDik38XkB9TcuBWPk5lXiy
 D/MSO6UiNJDeIsdOiwKmc78SZuit/jz5dF4HSbG3e1wak0RByd4hlnCUlAvkf1hGTQ+F
 z1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794940041; x=1795544841;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P0mEH+H4NNwoXl7YSoG6SqKDOlQf1aO9wo0NwJfmnRc=;
 b=AgFVO2dOEAcVrficg74wWM/tX9L1mLxxpkI7YW6PkHB3JeR7oAxdOj1/+WZMxKuN2E
 2/RoGqYbqRHnyEC+zOQW8YFqt8PGUcWqjxSzmeefEt61Ow4aziNJXUXrtEekl+in8KT5
 Sovf16cciSLECFtV7QWnjVsy08t1AMMARs97uSArSFY9H29QzsaesFcZ8Rj7QFDHcGeU
 Aa+SqJlBA/5n2AYey8cAkBY3+BY/SmFTmjP81glifs0zZD5hM6H/PrbQF1RQYWqY/XxG
 D54rMrz6dXOTJDURkvHvaLstqhqxMAU0S/vWLClO9Oq3172qgTBVVlIUM4ZnyJLj10GF
 Cs7g==
X-Forwarded-Encrypted: i=1;
 AL+hErGc/RQnO0mxRsUJxvXZOEdaL+fDhV8XZ9aDAPxAY7XAWZPIB5c7x9KtiuB1Tl5r9yGChnsDKzWbwjiy@nongnu.org
X-Gm-Message-State: APuU4Z/ZM37ol7GOsgb2SeYG++DvT5xoO5MbZ4jC+sNELqabE3DQUV6H
 WQtNkqY8PqhlRCAZikCx4mCY7M1Pi1uKS4UXvmU3S2dYomovysDbfILukQqlYziI4s8=
X-Gm-Gg: AZFdTZfigqrLHQZXjYca91KpbYIWPteY8JgyC6hg2xvuZbuWXA8+PGsnknaLIayeobY
 gacpvICLxgckUDRzlCur1StvHKbjSbKkuJ42iXln0tjK2rbic2fM83cZ2hFWFg8PqFQmAI5Muif
 Xx3vG64eaIFvfvI6gLMqploAy0Fn/hYJAZj2Nc7Te2QqJgmv/cB0bNHIjQsLVvJ8zZGmndnESw8
 xPEavAw/hHybGaJ70K316l8cbmDHBgTmAeJHiZMcWImPp3exhQBKw+h81wCSP8SWezku6a+bVVh
 Gna+OM78OTb1hbdVo4o0Q+NCSQAyLs83L5Ea4xYcLzIpNdrJInCRMszIo1+obNFHWxQt51tm69o
 QUMrHblda/k1x5L2yjbFDVJfq8UzZUQxKlqcWBGbR7hhq4Nt6ghvVMuITD6Nar525citY+4SKnB
 8tEbr+6fVCAEJ6fBJ3dn/uhdQxDR2utJtmWqjFsqu5V35dde/PVq1EXz1xD2PFLA6GJXk8fGcqc
 5C1g0lrc6XMhgIeh73adOWfq79hUHyBrIz1i1cebckLEqNP+1dlomYDHaHPOnwgvLgc3aaL5+V4
 MTRKZDxm0vR7w63bOLijyzdNgFCRRC6Q5IbWR23R8qwGaYfskFAjTc5VD8utoPQnCFwI3AQ=
X-Received: by 2002:a17:90b:3c8a:b0:3b0:ada3:b505 with SMTP id
 98e67ed59e1d1-3b3d079ff57mr240517a91.19.1794940040883; 
 Tue, 17 Nov 2026 10:27:20 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d19b5e8asm166833a91.8.2026.11.17.10.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:27:20 -0800 (PST)
Message-ID: <3cdf07d4-a2d9-493c-9222-a8286b4f0f34@linaro.org>
Date: Tue, 17 Nov 2026 10:27:19 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20261117133149.2108068-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261117133149.2108068-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 11/17/26 05:31, Peter Maydell wrote:
> Hi; this is a small pullreq of little things that I forgot about
> but which I hope will still make it into rc1... The only big
> patch in here is the new ccid-card-emulated test case.
> 
> thanks
> -- PMM
> 
> The following changes since commit 97c88c61d45dee6e1f9bc160a338048189846d28:
> 
>    Merge tag 'docs-security-devices-pull-request' ofhttps://gitlab.com/berrange/qemu into staging (2026-11-16 15:48:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261117
> 
> for you to fetch changes up to 81641446c0b5aefdc814131f0ce7435b9f5787ca:
> 
>    tests/functional/x86_64: Add test for ccid-card-emulated (2026-11-17 13:06:01 +0000)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Revert recent qemu version.h handling changes
>   * target/arm: Get HVC UNDEF cases for Secure mode right
>   * target/riscv: Fix RCsc ordering of Zalasr store-release
>   * target/arm: Fix RCsc ordering of store-release instructions
>   * target/arm: Fix barrier polarity of A32 LDA load-acquire
>   * hw/i386/amd_iommu: Mask address when calculating large PTE page size
>   * tests/functional/x86_64: Add test for ccid-card-emulated

Applied, thanks.

r~

