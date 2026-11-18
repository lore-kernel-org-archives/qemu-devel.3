Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E9606A7D4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RPqgOeTI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTiao-00080W-E5; Wed, 18 Nov 2026 11:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTial-000806-Mq
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 11:33:03 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTiaj-0002Bd-TH
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 11:33:03 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3b3af93b85cso678730a91.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 08:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795019580; x=1795624380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t2UP01JEv8heg+hu4pLFUehT+rhRaSVwU1kwGtst5bA=;
 b=RPqgOeTIKQHr63Iwp3csjFEAEP/Nd8ruq5G1yhgMwxstGwnACmU/my72YkpTM7+ztc
 hvuxawZSpV+G7h8L9gCFNikpRs8q19x1apXv9GJQFr6QmGds1amcYJfbkQiJDxvxrRkf
 wjQCKEzKf05Gb1VGBo9LF6Po8VQ/OPpzp1tEEeflR9QGHOlkqyd6sdsDb1B4PYGCJHrr
 Zf3KpvL9ZS13InQa54ZZfhCittgoXWGLRpfXOzLse+xJorObpzHS3hBCbPDSYScafNVT
 T8tTdp9yQQHcPxyvOYHiJ4q0XlWgeQ0X0iH5CPaT623Etu77qc9tAB93PDyGxwewOSEV
 VFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795019580; x=1795624380;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t2UP01JEv8heg+hu4pLFUehT+rhRaSVwU1kwGtst5bA=;
 b=pbxe8BCkAl7Tl4Hp8guW5TH2Eg/2uOy4N68dYTzqnrcfCAmpiYLG1EUSTR+YehSodl
 iTtSQRrFfHEbObozqwTMJI8QwMNBWPa3tO5kPWXDEQpEsOtRZzw0g3qiWl72zi/f70HN
 2O8VeejLcGySHDK8mPflBBZOy/6zCeRLDHRUAdCbY6jvZoT+V/dEIMxb9POCOyOk/ezk
 7NIpiLv8G3h+2kbX9hRiAI6Cwwqh0K/h+N2y/9nYwbS4zV8C9RoRBERMFxxA2+D7v/j1
 UPRoGXVrRf5aH0C0QB9WuRz4FirDsWh38TZP/B4T2IcPig6oSFMjJV5C1c9jBxfHbyJj
 OrUA==
X-Forwarded-Encrypted: i=1;
 AL+hErFF/2DOjPk9X4Tx8FU0nK+sUpIxU/JHnfa3OtTzb7ru9nTh5GgboXMfa281VZUCsreYHHbZfga4TgcL@nongnu.org
X-Gm-Message-State: APuU4Z/vTsX73haj52kun8mg8oVlA/lS2a46CP9pIzo6XRx+gk49QC40
 6UYl+N73dLYv98voe0lY21w8KibFKYzsbTxVWRU2DlnT+3mTxzrHnQuVQ420rYUZm9E=
X-Gm-Gg: AZFdTZfeiLdS6DaQKxPEw1kA9o2k5ErvCmQBptCI9BEKK5tEARIlpQC6AR4VGTufIlW
 ngCAk6Zzwg2tgbel7hCa8/sn6pu8a+NiGWkyoGVGT1R0Wz9MSP6RJ9lgg9b8EJC0tsdqpYBSbCi
 zAsIAXVcGee4UfSNEiAdrE16GJ32HIB7yY0gaUZBtbFI5z6Cerh7ktpV6sjiTC/p9vY4EMAGGb6
 eC3FY3PacZDkd+Gt2RbnffQR28/e6oIEVQCxXD+Alfsa6eOYWRqCstrjMBW8Yx9n4Q+lsm5qsHK
 rPI2eqFdvI208XxgOjqWRUTCZlAeWLTcSmi3karINz2Jwk/togGVBpbgvwXjqHWSlRJkolYFzgn
 w25fPY5kleSIOXiio5hOj3pI8k7uskGM9fTg5Wr69I90hStYig705NnPYOJpotndh/s7kIXfZu0
 tgccAYeyTfi8aW1pm0Wse8uCWkI7lRV7XnSoX0+IJIpcOszEdQF1hVwCq0EHqwvHoN9BbusHqzS
 fZxnnyWq1yohAN7KXIqY81+6ryC0v2aPPJiNm3n3wDynS7PocAVCeCQueVthezgZnLJXu0OUmf4
 tRDSypzU8453xrVZuqti6KtlkRvvfr5YT8NI6T7blPdu0ih8neii/ZruPbzIauiFlFgTpIA=
X-Received: by 2002:a17:90b:28c4:b0:3b0:b36b:66fc with SMTP id
 98e67ed59e1d1-3b3d07d02f4mr3339094a91.63.1795019579771; 
 Wed, 18 Nov 2026 08:32:59 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3f56df516sm41059a91.0.2026.11.18.08.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 08:32:59 -0800 (PST)
Message-ID: <7a623f61-e620-43a8-a2dc-54a90d56c40c@linaro.org>
Date: Wed, 18 Nov 2026 08:32:57 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] pull-loongarch-20261118 queue
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20261118020246.2432333-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261118020246.2432333-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 11/17/26 18:02, Bibo Mao wrote:
> The following changes since commit 6883fb508cb7a93e2e7b44c0582bfd9fc2196d4d:
> 
>    Merge tag 'for-upstream' ofhttps://repo.or.cz/qemu/kevin into staging (2026-11-17 13:09:47 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20261118
> 
> for you to fetch changes up to 305a62d8493aece79a523572177eee7ca44e5a85:
> 
>    target/loongarch: Discard vmstate_tlb field (2026-11-18 09:41:57 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20261118 queue

Applied, thanks.

r~

