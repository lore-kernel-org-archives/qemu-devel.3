Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B89D606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sJtDWPrh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKcQ6-0005ml-BF; Sat, 24 Oct 2026 10:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKcPv-0005kn-07
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 10:08:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKcPt-0006vv-6t
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 10:08:14 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so1339465f8f.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792850889; x=1793455689; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8wQACexlvQwMP3uLF/sDlBd4VTttcHA4IiNct0iFR2I=;
 b=sJtDWPrhe+SflnEHdiMxRGo90ET+BeLGb2F3wu+lZJVQ1VLqwh0hhT00/RiVnAc2Ud
 K9iIhmfvaXoVh5HCMmdzArCuxSgZSQXi3N9zoHC6lDy+jyAU4YBb9ISa8x/aVhE1KaAl
 gnR5zemf/MCwskCYhxs1OO6mlg7V6osNHEhkvLU/KTKUzy22hY8+T22d7HaTwFju5t6O
 gGqp6NvkIzDzkiGVvqsm7mpet4TArCsElYEzcJzGiiNDkpx9cpWnCuxNJtBNwd8yAVc/
 01S7LDyDEGqkbpUOO5VfaCiT8suivCVzykckyVuvuJgcj+N/6Y6tjO0c0jbTm/obgChO
 JO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792850889; x=1793455689;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8wQACexlvQwMP3uLF/sDlBd4VTttcHA4IiNct0iFR2I=;
 b=FRgdKoqN4/yhrn9inDTnnxRez+4WxHvoisXZzcby+iLRXIDac32t1n4cKBCL+wKcrj
 kpcGr/iVEhAzJFGaBqeVBbal9GFgMUehAZ13BBmshargDYUJyPg5eWKteQ+titGrv2pS
 BUhJj+jm81uEflDM8zWlBs5apGW2LJwVB/49RFzDr+YjP2qoOm5fl/FAP4nVEwMU1Vrd
 GmFzMl+Mzm/6QDzKaATWLpxajjr+VQbKc2c7Ogc0ni4/9YQGMU9M6D13Pga7ZF4KMRhA
 Bp4gW+oqNnfF/LQp1KBPvQbgz+BgTkHrKo0LasnWM7XEChT1WqIFpwrrFknc3RsH4nEo
 zWAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxX+WBoL4wE8udMEKS1IKYUDEiASNIJDFr8n3/oz05GCuFgt/k2oKcLcuBlGGF4USTh1gdRil9H/kma@nongnu.org
X-Gm-Message-State: AFq9FYLddiEmZUWtAhaI0Al+oiJZdtdS6W7+qss2hr5Z7nzm09If+nmq
 pTxVlE2JBA1JS3tXMKCmw8HpaYS4q5GVnglI3N33QPwKoIG1M43M64S80l33HTd0belW2MRQ985
 zB8etq64=
X-Gm-Gg: AYBFou0NmOpdVrrhNTJQhk0LEHx8etpVwCHPdvDfde4RHk2uIYreNVDtql3Q8nysBvP
 qqAV0lM36QhOcWWq0xRX3L0OrXD6fMYEJXA9KrrP0Xvq68bbYxUs0sL+hCWUgnccMh/sZpH4bwO
 HKTzVpqsAg8YQsAsp4X0R4I0w8m36wbN+XiquKWHdAwO+tzJh9cv6H4EPwlpahl1IDk8OtL8OCZ
 IECn0ao+CNiBvm8UI783eJe+fKCIa4rpC0pYC2ispVB/pY+oMRtIF+qb7zKkbl4UJRWfZgdAIgV
 l++OU8zBaiXkivpC/nPEcK1MCG8ArnDMkNgUQh2J/CW2qHMiGFKyjJFNVdJBQEl3iOHV7uSROTS
 +SlHfuM8VHULP1W9JCTRD73+a3ChtrNlYDLw6cZWN5bWsRVpxvaznwHrM/+iqJQ7f+V5KF1aCxi
 Gd9zoVWUurC6JxrR+bd0QQ/gkjqKqQ/MMLhXDcK6b5nuspJ8RLSghH7YcuTmWVdK+Jh9CKXYLNQ
 i4mJXkz8nivy7KLTslyCG0PBGBkJTjChKBLs784TgZXRdZOo1Yg8CMsrt5Qu0GKL8P/NQ==
X-Received: by 2002:a05:6000:41cd:b0:48d:f36e:ccc0 with SMTP id
 ffacd0b85a97d-48e3eab5794mr3623572f8f.0.1792850889463; 
 Sat, 24 Oct 2026 07:08:09 -0700 (PDT)
Received: from [172.20.4.74] ([176.95.65.245])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd37f4sm5466153f8f.44.2026.10.24.07.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 07:08:08 -0700 (PDT)
Message-ID: <79abc419-18f7-4846-afb4-f202eb168a3e@linaro.org>
Date: Sat, 24 Oct 2026 16:08:06 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] qemu-sparc queue 20261023
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20261023210650.559141-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261023210650.559141-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

On 10/23/26 23:06, Mark Cave-Ayland wrote:
> The following changes since commit b6c4b7e86dec12d07f5cac65265b986d38ee9002:
> 
>    Merge tag 'pbouvier/pr/tcg_tests-20261022' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-10-23 09:09:11 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/mcayland/qemu.git tags/qemu-sparc-20261023
> 
> for you to fetch changes up to 5d9cd4fb378a4c33b837d7ee1e9ef3f877c66d15:
> 
>    target/sparc: Add the SHA instructions (2026-10-23 20:11:08 +0100)
> 
> ----------------------------------------------------------------
> qemu-sparc queue
> - First set of Stian's crypto instruction patches

Applied, thanks.

r~

