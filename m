Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8A4C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 12:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9lXj-0005bf-Pe; Wed, 22 May 2024 08:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9lXh-0005b4-Ts
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:58:06 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9lXg-0002b8-3s
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:58:05 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f44b296e02so1733155b3a.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716382682; x=1716987482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZakG4gdFrCffcgn4XA9dGcrf2l5petDhae6M+vQ4FyU=;
 b=aedOqnDaFxsgatwq5PwhtxNr7Zau9L6jFF1RwnfCbhw3YTwpdSzAQ8wa7dStTVdJdP
 EpI9mySJ5K6h73ppOAU8CQ6sNChkomLsthAGR50rzW/FDeCrFwRGIX+F0XWLYOmV6LZi
 ZY0cHOtGelIOWx/VTkmuW1WIVH+RdwoP2tpoizFM8TEJxCzbR6DJqn/0kyf9y62z/MNI
 RLZjddy203ITRcfaI00xCMO0lDPoEWekzBZ5wzMUxWY9Sav6JzKGshZqYh4HPsE8K1pp
 QIe6Y6s0vhV0vzPgVuEVB3Q4dUsADmVfo7kc9DYw0tqY5t5/j4Gq9Pd6nquAlAGhBqqg
 UUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716382682; x=1716987482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZakG4gdFrCffcgn4XA9dGcrf2l5petDhae6M+vQ4FyU=;
 b=DQ2BOZWl//kJNaKjMDqIPR1LizdduIw09evYVKbB07cv0bF1e2NqujrRVY2MepDzUz
 lA93BuC9PI1MI4upLzS0ZWF4cwFJ+mjb3HCi09J8B6ysCXt3dkHTxqA35OBflu0w9o6S
 t8og3kGLNBh3h6D3qePhwr142QY7sw6WXdLqWMbNO8/Y764FX2Cd9tm9mUJ+ZsoP+ZR6
 1RCR2yiJTCJh9qApdqMn5DXz4Lh8Xmlg8ueom+RwRMXg5jjZn/09XKB3/PVCNrgFOtCX
 tivImabYqonptft7fbUc2M0Q/yxqfsWXd2Fkyw9xkk+Yrjsu1x8Vy0+b/Q/RH+Syse7u
 YKsA==
X-Gm-Message-State: AOJu0YzEbbOCvANKYV4E/+XAOIBPF3MSt91BmqghErSALFBEtuqHW3e+
 S+XwgCdIem04YYjcdWPzdsWrTuuuNGHVzWtmLHLZr+dKAin6joF0ikWKZn5oces=
X-Google-Smtp-Source: AGHT+IE4LdH5adN63A/cOYXHEdFph8Nrx5S7qgTPW20k9lkuDqyLwcjuOVuT7rleajtPhpVaNe/cSQ==
X-Received: by 2002:a05:6a20:258d:b0:1af:cce1:6fc4 with SMTP id
 adf61e73a8af0-1b1f89fb3d5mr2106270637.29.1716382682358; 
 Wed, 22 May 2024 05:58:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bad7dc1sm238618635ad.89.2024.05.22.05.58.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 05:58:01 -0700 (PDT)
Message-ID: <f01a18eb-3570-422f-b836-1c789a7c3d10@linaro.org>
Date: Wed, 22 May 2024 05:57:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/57] target/arm: Convert SUQADD and USQADD to gvec
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-32-richard.henderson@linaro.org>
 <CAFEAcA_ASs4_O22dMi4chcZTT+K=3swJfp3KY83JPbsEJoF-RA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_ASs4_O22dMi4chcZTT+K=3swJfp3KY83JPbsEJoF-RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/22/24 03:01, Peter Maydell wrote:
> (Did you do much risu testing on this series?)

Yes.  Complete run of my test cases on every patch, with -cpu neoverse-n1, traces 
re-generated on aarch64.ci.  That said, qemu master does not pass 100%, failures not 
investigated, merely no regressions.


r~


