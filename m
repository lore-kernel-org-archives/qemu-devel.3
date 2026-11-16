Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B7606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nOgfDxXo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT313-0000rJ-6b; Mon, 16 Nov 2026 15:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xT311-0000qa-CD
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:09:23 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xT30x-00063r-RR
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:09:23 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3b3af93b85cso52144a91.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794859758; x=1795464558; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NouS9L0OCTWr+BF1lF0PGCZwKJoPGxM15U9v4QTEk3I=;
 b=nOgfDxXo1kRraWJFZoec0FKae6YRKPjrFh0z+GCaxrV4WIHU+vtztjHubNa2dWMM/w
 sVHtCl9gnAx7OTCeyZXg298zrlbwOZG+VmeXQeU8XcYiR8oc2L6wH6Aii1c/xwrl5T2a
 mtqoucUuk4dQeLn92BK2suATDBbusjGoJL+mDt+LkVfZmd9rZhKthp0DNe4T7Y3UXK8n
 uMchcEcET3iVnVd7xHuqXRnnwexQk15S+ACaYN/iWLqmHW6UllyqKaE1pAYF3dDejdDc
 O/71AO2E/yp3V2i6XQ2izo2Wh2oIZhAkbDhoDrelJoliv5j9PIBEEGBkj9g5v+Kzm/KI
 yjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794859758; x=1795464558;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NouS9L0OCTWr+BF1lF0PGCZwKJoPGxM15U9v4QTEk3I=;
 b=sGwVwhc70+XFA8iURV6Bd+u7nyYoI0w2xEV3uhhhdUQGjqb2dYoLMVwvliEzWhUfmg
 NzrB0eMleuoh62bAAHltCVP8dIgL2S98M+2K1FuTuSqcDZB4DWX93r1LU/8AV6KWlW7F
 nMJfQwgOi6mn81zbpK7UENbGKz4oalkeZ2/hpU7camZp0+K7xAWEuD8oarDPjt4trspm
 Ibr2Hv1/8gfNfWap4wZMuSVHU4Y5rsBAcHk4nfxwrqJph5nplMf/BshZI1uwlbtXixwi
 Ss3oRT7Fih0K0GP2OghV1TSfMuBhhpo1O/mjG3/LtrBcUcWYMrQML9KMeQSuSmu12cda
 pdLw==
X-Forwarded-Encrypted: i=1;
 AL+hErE285R+4rxRz9D2nGfVI27MpZW9ctrjAykHBbber0dIwQXOU5jU+Ny5y7UzYep7kU6ERpj/yGGPk5/1@nongnu.org
X-Gm-Message-State: APuU4Z/MYnTLDIbm6NNEeAqN15w3lloHp31nrimfrEbKq3x2zo5ZuUae
 UusEY2Ww+cV0oyZknBR7lfMdLNPeFbbFiin/0rYn5G3iL+ZSVGpzurMJWFEKHEAvHVY=
X-Gm-Gg: AZFdTZcXdC2rrSuizMHleIfWMfPF1MRCpKXLM1GoF1pHEyLVwYQU4dzinPnBgORdzRZ
 vgy8RSJSz8Bz4tLSpfOKQafpGllBnS425zCVObkZ9dcSnoB2IbihLT7op0luRlsg37DOhOtkUYk
 ztRuvPhhaBdPZh8rd7v/Tu8oiyU+VaKpJGvNy0yeV7OvK8aNUTlS8j+ZAF4+xw+FqPL3GEgdYoY
 Yx7HmKXQzvOaIaOjpVOoA1xFSvI45Gyn70E/cFnxPkaPIeWr5nj/hsOx57vwPyEgeQoqVOaKPoV
 b+wIV316aB7664Ej5zesyF48InynEpfuYwI6QEnC2deo5oIIASGgtmMR6aFaX9e9lkSh1Xy4rYk
 I/d+vCCs+AU8bzqLaXKnGzV0mlDpniWBM2pME5u39LHkjJgWf5erBAz2lFzGqVSnSq+UkQYDVNK
 +t56ryJ9f0puUtD++iMbVqHqhQgawnKazkH/pBIDAdGNNtNYCMM8qX2M5O1OYGcjWoHbjGQ3zmJ
 VXlWWscdlZ6RKIhBSI86or5p9h1OBNCrdA5lr1W87/9lYFlhMKnnT/Cf9v70ZQlNgis8nULazoO
 36DIY/Co6FKtjVBCDpfYDQFFr5Qa+OH+iFvgBfzWd1f7cSR7luR5yzAX
X-Received: by 2002:a17:90b:3ec4:b0:3b0:bc3c:3e7 with SMTP id
 98e67ed59e1d1-3b1b0a1bdc3mr11917677a91.10.1794859757798; 
 Mon, 16 Nov 2026 12:09:17 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abd063e8sm637015a91.8.2026.11.16.12.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:09:16 -0800 (PST)
Message-ID: <bf65e7cd-ebc4-48f8-8e08-a1c1b3ccea13@linaro.org>
Date: Mon, 16 Nov 2026 12:09:15 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] riscv-to-apply queue
To: alistair23@gmail.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20261115004819.2586336-1-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261115004819.2586336-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 11/14/26 16:48, alistair23@gmail.com wrote:
> From: Alistair Francis<alistair.francis@wdc.com>
> 
> The following changes since commit e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5:
> 
>    Merge tag 'pull-nbd-2026-11-10-v2' ofhttps://gitlab.com/ebblake/qemu into staging (2026-11-13 08:44:16 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20261115
> 
> for you to fetch changes up to 57bae3bdbf69777c8bf32f50a85c36283bbeb673:
> 
>    target/riscv/tcg: clear itrigger_enabled during trigger_reset_hold() (2026-11-15 10:41:59 +1000)
> 
> ----------------------------------------------------------------
> RISC-V PR for 11.2
> 
> * Fix minimal RISC-V system builds
> * Check RISC-V APLIC config value bounds in realize
> * Fix Server Platform Reference mtimer frequency
> * Clear itrigger_enabled during trigger_reset_hold

Applied, thanks.

r~

