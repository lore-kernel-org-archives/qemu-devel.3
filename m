Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB5606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=D8KkhK9O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQTIm-00018M-Fh; Mon, 09 Nov 2026 12:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQTIT-00014e-FU
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:36:49 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQTIO-0006RR-JF
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:36:41 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cc4be0e5351so488831a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 09:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794245798; x=1794850598; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EaMUCAtTR2C/ZNQik8LFJrXcDOLPTd4ZW0zSoMFY7u4=;
 b=D8KkhK9Oy/tka+IKoKPf/eB7KbSIU7QR2Bc4OCHWDHe4Po9ES1gwZQNAvPLOmoOugB
 iyXvbBjYNyXpylWfuWzVaVn7nXA5cEyV09SG+s97j7ogNz2gr39El+N30H5LvFoBRtxN
 G81DH3/SisQ6uEXBqtxwDcansJpR47j8n1SHCLqohV1LNsUedYKyRSJRsH0RSY68vz+w
 r28NGqC8xzU4lEz2K/qu7WFJBxvB8wNKTMMbOXVxBwHw6vKPP83s6Qtjf5pwO6yaln9E
 qkF1xE1m8kmaCGWUmKYzrOsRJEdPwZThEcbQ9gVrkIubSfimDQTbY+Jzih2ve5jIqXni
 saTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245798; x=1794850598;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EaMUCAtTR2C/ZNQik8LFJrXcDOLPTd4ZW0zSoMFY7u4=;
 b=c6Q8aWk+eQc5bekxw5EUyFvKJTmn70Lghg5eRT1WGyfQXSVmo1OxJJIRBYQyrAtJ99
 QVufkiIzpPeG+VbhFhwgXLAUKUJWA+sb6a46/xQFwnJFIbHOWHm21rAjuKFWJXU0Ihci
 livqYBrjL1fOffE24nYv8EYABy2xJOIUjxY7lZVkBzkfWhKqD7weo6xJczPgRfZMpvS7
 p1ieDWfxIh9UmAdmmTVPerRe93K3H2yl8RRPBsn7AyINgk0X63eqOTJOYy3gp//NjJHI
 QRZcU1Qq1qRT+2iFrms6ljZTvMQGQbggBJ4g2aMx+w7LxcBDZnPkKMhEVitlOIY4RXUI
 V1vQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHv82Rcfi/6qbhHDQwRzOB/wpKdpaVIIwIl0EInBc9XCzwWomo6O94HgEMDgvPKqsDWLHoMwjPjp3c8@nongnu.org
X-Gm-Message-State: APuU4Z9kvRSq8hyhS/UefdOF7geB+qcAVFZEw4Olwn2a+Nnf4TOIHkvg
 6fFp1yVJ23zS9TOaBC4jsdpoI8O2U+tOZLz0p13RF03H18/NAdrseHfAVDZhDtMTW1g=
X-Gm-Gg: AYBFou3yiATAtrJ9n/7yQFT8k0qR1DE0kQYN897OisBHrTpacG4frYDTcRrtwvyex0F
 u5QdourjzjW9DT+BRrpdWpg43FHxNz19CuvmI3xFY3iaHMcqAlo8zV2WwCc+rCOW9YLeuV+Tl1A
 M4G7RF/cXf44YYGQYOZAILB36w+R2FMRwh5m56BY/iyWPy2OsJzwijYuXrQu/p+x+dDOA0wAAQt
 lvESC8N154DB+XZzDXto6VMiYEFMPo5u19MhKQK9/E8GnJ7bW9zpyZYdCnH1+gYyFTRB2Lpqwcb
 gdzSY0bf0/qwdorGvApm3IzHSSVOYiaUwhI94v9U+WkOTH1Gosm45gcWxWEtQyvhsdi/yOocHqt
 N006EfPZooUvEGlQSIlohbFICfKAzATphuNQ7rbZ7bEqtU2GXnL6xENw5a1L30mU/YNCzILIKUg
 OJtDxszMJUt16Em04X9L0m02C5NaxBecuGjLbJ1SHz+9wEhcrm/isUCwiULsxTe0Dls1JWXs0Vw
 91zG/87C+4/McQhLVjYsAow+FPcUepYcIR6VgdmJEZgbizb2qxPal5T3iUcFCXcE5V5UI6StS/O
 TyQBrNzb1i7fnsnaWNnMLoKUz4aPneP0G6p1EjfjqFmoN2dMXMs7rS/y06znZrdPWUfZQg==
X-Received: by 2002:a17:903:380d:b0:2ed:205e:eac3 with SMTP id
 d9443c01a7336-2ed83740024mr46835925ad.12.1794245797540; 
 Mon, 09 Nov 2026 09:36:37 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6a42d89sm770195ad.8.2026.11.09.09.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:36:36 -0800 (PST)
Message-ID: <566e05d5-1abf-42f1-8888-4fb6e2fa7987@linaro.org>
Date: Mon, 9 Nov 2026 09:36:34 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] whpx: QEMU 11.2 pull request
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>
References: <20261109133035.7985-1-mohamed@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261109133035.7985-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 11/9/26 05:30, Mohamed Mediouni wrote:
> Content-Type: text/plain; charset="utf-8"
> Content-Transfer-Encoding: 8bit
> MIME-Version: 1.0
> 
> The following changes since commit 71f25c75417d31c214ba2cd26b273c114fc99987:
> 
>    Merge tag 'pbouvier/pr/multi_target-20261106' ofhttps://gitlab.com/p-b-o/qemu into staging (2026-11-06 12:28:21 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/mediouni-m/qemu tags/whpx-fix-0-pull-request
> 
> for you to fetch changes up to 1e682edf3fc3c5dcad9ba0cee214dbf54a3cb462:
> 
>    whpx: i386: fall back to xAPIC when the MSR exit bitmap is unavailable (2026-11-09 06:23:33 -0700)
> 
> These include:
> 
> - fixing reset on x86
> - CPUID fixes (leaf 0xd)
> - handle systems where nested virt is advertised but not working
> - xsave fixes
> 
> v1 -> v2:
> - Adding Signed-off-by to all commits
> 
> v2 -> v3:
> - x86 only, and removed arm patch with pre-requisite not on the list...
> 
> This is a cut-down version of the "whpx: i386: updates for QEMU 11.2" patchset
> with fixes for QEMU 11.2.

Applied, thanks.

r~

