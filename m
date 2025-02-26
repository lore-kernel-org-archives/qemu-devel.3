Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7F2C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDO8-0000Xf-Vl; Wed, 26 Feb 2025 04:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnDO7-0000X8-6i
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:07:31 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnDO4-00010F-9A
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:07:30 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so62195275e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 01:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740560846; x=1741165646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MCmR7gS5Y87Fafs23xbKTTX7NDp3ttYUbOOqVgHLkY=;
 b=cVKjYs0aSB5Wobq86Z9PFdAmyByliHhqIHtlf5E5bdR2y3Gn69gZRm403W1la4RCem
 IwZdnl+9VYapyQjW8J+P6pRRhXlV9cxVAUmZMSb5xJg2S96ZiqRTMl/HMiQIXroYYr/4
 /4SNphD7ubAiTIx80swzLK+HY7eTjxbaFDcOfFsjHGITNznrZFwr3Wq4nxghRWg0WIBU
 e4ieaQMT07En4u42r4VFx4j7s79H+jefjLvMXLRtuXmjenyVrj8bcpCruNaa8P4xAIwe
 /m6yKoLAn1ybV/MgXjkWDTu550Fn4uqP7WaVBFEgUyUYfajzh93eUUblolZVju4Or/gi
 iCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740560846; x=1741165646;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3MCmR7gS5Y87Fafs23xbKTTX7NDp3ttYUbOOqVgHLkY=;
 b=B0W0dOvwWOEhxM+rEq4tBwTKWEG29NhvopgC7mjnmt7x0eZLdaIWuBGDL6zbMKXsV3
 C5TZrk3Y8rSZ4Q3gsa1HeraqqtvqtCjScdhoqGgp/7EED+kdnpiB5wrjy+Kg2ohIDuT0
 wPNK9i+HWG1NGPFcVq9ac8IoZtN0NlamaMPyx2Xl1Acoo017k53uYgkeTw/U6so9X0Vr
 sDAZTZNTkRfDneGK4oU/YYBagJ9PNfAwSsQ6tD6ys01gJ+1m+D8LIPgMeAvOvmHQieW4
 tiBX24JgwSM18F+Pv256bWVYXWCddYHoJWxjuZ4owz65fShfmZzWcSrI7MQ9rRkBTYLM
 4rbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu88UcYQopETV/MgnKJ21vAJ+yr3sjpQxEqy/skUSIzGzTgfWtYeIUCwQ8jKhlzj/xJVYRjJ8hCfvg@nongnu.org
X-Gm-Message-State: AOJu0Yyx77Sw+IqLp/iGcnd0XndEL0+kWGcB52LY334YG+CJodKB9hyR
 7we2qO0dYMu9xM7hidtHRAy2Rn4ZoHSkSpuy0RFvHni0Uv5i7vzjaJXrtk2BCjw=
X-Gm-Gg: ASbGncse/KAbfVh8uAUXylMDCKOA9pHPGEqw9D2xbGuwKbjkZ9ZDLzGFIW6TD3gHkmu
 TWPCUIMsuZXt7sCqfFPUEAopLswA4lCXL5kuKDLs3dM+ALng0xMJZ4y1oVxDS60DxroBU6pShH2
 AO4qr4UN70mEJbz8qxc5QA0Pxoky8ZcjbqN3ppv+Sbh1KWhVgeLRriEscqB6ULD7KnIKG8ZEc5C
 Za+V1XpeikBNmuyKDXiGp/70gDo7+Gt7ZfxdSKGSXPkwahoWEyA4PCE1Fd0zUj+eiAolVR519bS
 JCwr6aIytiQ2vMpxhVwEa+bEHUcJ
X-Google-Smtp-Source: AGHT+IGkHGGdrN0ajOa/uGFERpbJFWPASACiwouL4Vruqk8Ld4/gCMNeP2qLHTxTjKuwKxBCxJu7JQ==
X-Received: by 2002:a05:600c:4687:b0:439:9aca:3285 with SMTP id
 5b1f17b1804b1-439b6ad5cbfmr147501685e9.6.1740560837709; 
 Wed, 26 Feb 2025 01:07:17 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba532d7asm13929045e9.13.2025.02.26.01.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 01:07:17 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 94F305F87C;
 Wed, 26 Feb 2025 09:07:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH v3 5/9] target/arm: Refactor handling of timer offset
 for direct register accesses
In-Reply-To: <20250204125009.2281315-6-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 4 Feb 2025 12:50:05 +0000")
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
 <20250204125009.2281315-6-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 26 Feb 2025 09:07:16 +0000
Message-ID: <87cyf53whn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> When reading or writing the timer registers, sometimes we need to
> apply one of the timer offsets.  Specifically, this happens for
> direct reads of the counter registers CNTPCT_EL0 and CNTVCT_EL0 (and
> their self-synchronized variants CNTVCTSS_EL0 and CNTPCTSS_EL0).  It
> also applies for direct reads and writes of the CNT*_TVAL_EL*
> registers that provide the 32-bit downcounting view of each timer.
>
> We currently do this with duplicated code in gt_tval_read() and
> gt_tval_write() and a special-case in gt_virt_cnt_read() and
> gt_cnt_read().  Refactor this so that we handle it all in a single
> function gt_direct_access_timer_offset(), to parallel how we handle
> the offset for indirect accesses.
>
> The call in the WFIT helper previously to gt_virt_cnt_offset() is
> now to gt_direct_access_timer_offset(); this is the correct
> behaviour, but it's not immediately obvious that it shouldn't be
> considered an indirect access, so we add an explanatory comment.
>
> This commit should make no behavioural changes.
>
> (Cc to stable because the following bugfix commit will
> depend on this one.)
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

