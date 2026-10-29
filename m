Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C1A606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Swr7YRaZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQ1L-000749-7y; Thu, 29 Oct 2026 09:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMPyq-0001pL-Ot
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:15:45 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMPyo-0006v8-Ut
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:15:44 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6dde81a6820so1659402eaf.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793279741; x=1793884541; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tfYpPWHFha7ZgGnJVfs3SmtYz4Dt6bskx2rd6eaT73M=;
 b=Swr7YRaZYR4Ka5Fd+jj/Utqu2J+yOM/cyW5YuICweN4sKNzZBC5o6jmuD6BDyGwq12
 dWpOXsCXK6WGtPu4zpsMbxKgTHxcFkzumuEs6TGNNwEnFewztuj2fq8Zoj4gaAVL07qE
 xZPXTRUzgZa1IGjSj2MvAGqHTimmgwUyLE6PbluutN00AkHx2//klvgQMXzyXcrFu8i5
 I0jhhIMoJ8KdYIE9+QcbVlgahJEwVN9rLckch8QKqMYwPe+KGZpnwZGtuovDmIRyUPxl
 Q69YWFkDzp0MxZ63c+BSZ8ATriK7+f/TVD1mB2mO5kReB37iUy+wKZ4085HHcAE1zFTq
 H3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793279741; x=1793884541;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tfYpPWHFha7ZgGnJVfs3SmtYz4Dt6bskx2rd6eaT73M=;
 b=d/94cmeF25BCKymA4C1+H2hlUVaVO28glX9weGUmw2qM3rEtA6WL0ejSGVh4F2Ojy5
 y4Ac8OpnlOaOb5CiaWKK4LGo+8yKvVmBtSNeNcbtuGvZFG8BM1gkHzGn9neHBydH1AAP
 jVvu6B7X3xara3Nv/pISEGY4Pa/w6AR73mzREm/qT22hK29+oNHvxzV/BtJFA8YRfXax
 6BnfdqFIeSGpPQB19iPFXPsb50Iof+G0DXxaxRRNPbmuqf53ti3iveuG6zg3k/zGHc2O
 NNgcr7qO9o+TnG00Jzdb/nN4lld65ezp4wOxvmAiDH9xkPSTluu92GzxAbP7B4ksZ5tI
 D4iQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0MNrqTAykkGWCDBmoL6JdRI0lmrmZl7tyrGp6OunC8+074C0CaODWZR8YYWS15jIaFdj2i7ftEd5Y@nongnu.org
X-Gm-Message-State: AFq9FYLA45mCm/RzdSq3J4pj7vxfz9wAUazKuQiWar2WKjmTmoWNM2gX
 bIWLGBPukZjBcV45qWLu89LXSyPF/QpRElSz5mPS6qz8liODGFtEV62zf2xCkLYLzoo=
X-Gm-Gg: AYBFou02FspX0FZsphF49Cn80tJi5PDDwRBNadzYY6Ws9qRo8BTuvdPr0VIb9yWd/9D
 PqBRR8j8PY+AQLfW6qCVYSBODmowkLk3mnc74vW4OAejmDwIZPkQ1l+Xb4Z7dDxjLUVCCUggmhO
 mlgrCMv7wwYE1oxYQs+IXBptaEQTWTUYinKfGpD57BeObfcS/p08RCpjRRm/VnlE7akztfUTRK/
 boOJL9J4Wtfq3iCFFV4A/7rpXCmdNMmzN0fDSdEIv1lUJsxR9TwyEVAkJyNg5RG30m8BmO/1yJu
 7JAwLcHaVI0wPbubtjXuqbqnGkasiH1MteyMIQQRCYc/oVyuGoD+V5PYr8KBfxCETHIXY7wihAs
 YbUYRLIS8a+5DBdU6z6shspMoDAXcUWuv8b+yQ29e3IUtykxNifrHVNH0pnm4Jx6Qfbr1YltUTM
 Ac6viVzT2tjr4qv9zHI6MkgjJZl3aBtbIN+pekadxGLmTWp5tJeoReThqFw2WXDjh75dsRHUkwz
 DJDz6+DlnvcQLquDwOK372brJwpdkG9OC0qt+l3IfWn74Pll1YqgmJlemmcwv9m8O5wRrvVo3aa
 VoBfc93THRiqjTMTnM53h8h3vnV3o6z47KrDRtg2XUCJ
X-Received: by 2002:a05:6820:240b:b0:6b7:83d6:292c with SMTP id
 006d021491bc7-713ef53341bmr2344521eaf.47.1793279741455; 
 Thu, 29 Oct 2026 06:15:41 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1fd3170dsm4680206a34.16.2026.10.29.06.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 06:15:41 -0700 (PDT)
Message-ID: <edd1d26c-5dd0-4b38-8912-a57ecf421ba0@linaro.org>
Date: Thu, 29 Oct 2026 08:15:39 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] target/mips: Constify and remove TARGET_BIG_ENDIAN
 uses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20261028180040.22848-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261028180040.22848-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 13:00, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (5):
>    target/mips: Constify CPUMIPSTLBContext::map_address() handlers
>    target/mips: Constify get_physical_address()
>    target/mips: Constify read-only CPUMIPSState arguments
>    target/mips: Do not use TARGET_BIG_ENDIAN in cpu.c
>    target/mips: Use CPU endianness in MSA LD.D / ST.D helpers

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

