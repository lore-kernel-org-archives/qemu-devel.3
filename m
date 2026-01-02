Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4455BFA3726
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 11:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbdDu-0004OF-2X; Fri, 02 Jan 2026 06:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vbdDe-0004HY-6z
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 06:21:25 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vbdDb-00077T-52
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 06:21:21 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so5610005f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 03:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767352877; x=1767957677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvkHfIXU49/3sbrKLDzfPPfC2Fy/Qln7AT3KBtF5Ow4=;
 b=F8LVbCST2ANyVr9cY1plK8owv8+RFhat1Ah2AWPOrAcnxd1yDtqtmNgJafAu4R8lr8
 dA/dHKuPXKffbhsQprGilgP4W+hR+aQks0Ez82cm5RU+UxUlwbGOYMrgNNZ/q8iNV42L
 iApchyi1zGvvyxMeaz5VYXO0n3QpHW8ZF5m8tNjJ0iKJNNZSKQIp4oq/xtoygCi/LT5I
 DUTWfk+wCvhQge2mXhXz0Cafcv4xP7PnVaOXv8vKrnBOL0UvCAQ0dK2NTKiV3SnWqFFf
 SIgl1+BF7EEYMD2+KcVtboDjDjOmjapmLGEIUmqWJiUE6oV+H45H/p2rzM5uGCeeM9nX
 Vi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767352877; x=1767957677;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZvkHfIXU49/3sbrKLDzfPPfC2Fy/Qln7AT3KBtF5Ow4=;
 b=XOQbwbx8UrfRUdiDYL+A38OR3tKoMELBC8DEE7GmLnfJxz+UZipppTBN2YrTonEaXj
 WZnf9Ziznmu9RzHtjddY2+6jmcCuQ6uGUvwXNGMTsnIY2yvpFyZQvqj9kEkCnvMKgVyA
 mbvLwP1DOHP39GQNh+zQbHClKdcxteCgx/5+cpOAIyAmIY28Z2b6u0vZHv67d17OGZHw
 QKPduwb+V8P8Ajlg8x0SqwuYh7UdAowCmeMSZtcjhLKuDzTtjPxGeooSgj47ZfFVsgdj
 01llmCf0JbaaZl+u4hffaHc+BCE/7KhhekBimZXVN7PEIoXBG+a22t/5n9/clVkg4+dr
 bs4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZc+ljATZoJ9hWyosc7XLRiYmLLXwo38hcWezLl+uOnfBgizE+dHTGw/QrjA7cRSCH1g2rwNxi7fIl@nongnu.org
X-Gm-Message-State: AOJu0YwIY/uKUpg86C3zc5O662yxotLOxCIrFeopjpBPQ0nTTucvxg+M
 dAMojHVWq12ePAYEVhC42rOWGH0RoOuT9uLQKHmSSWLmu4tF3vhCD9XuCYRq0hwun9dFs5Xi7Be
 gDjwT
X-Gm-Gg: AY/fxX63GdFr6ZWaq63edsnJbZflEF/ecvvE5eb/0mI7N8uSYA/TH566v2sFuTR9rsw
 kNO45xLamL8l9cEU3BO1zvs5HRwhat4GU1r3WVt7jMQ1Dla7jbxW47nQRlzVKVXxs+s9/v4tyuD
 q0txILktXPbwg7GVY4rbXgAPNwoSOqBKVnWQWyZV36HMgCkQUap2P52stLCDNHYtTETIc4M2vju
 1TW6zf/GcjvMEDyjqPYGEH9cQ+IiEcj4M8kNDfr62gLbNHUd57isk11dtmVCeLt/P8/5zFENv3E
 3xzRQGrfMuMJq/l8sk9JQ2jY2lvwWntjTxHZb3uQD6l3garKbFvTD/9GI8qBeNHIbzEOdVW8YZa
 WoBiC7WaZTaT9AEmajzS9eNrBWroXL0bn9IV5EELZ4v4ZU2O2or95yvE3+qSg4tVngA3O+Eomev
 3GhHuu1e0wNQQaSBWG4ycJeA==
X-Google-Smtp-Source: AGHT+IEaudZ3WJISNHjxxwgftzOGv2KnTO99iCQyXWJHMX793HgnUgy17bTrZG9vUfVl1w652K+mpg==
X-Received: by 2002:a05:6000:2002:b0:431:2b2:9629 with SMTP id
 ffacd0b85a97d-4324e709588mr54249014f8f.51.1767352877471; 
 Fri, 02 Jan 2026 03:21:17 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b1bdsm83387899f8f.8.2026.01.02.03.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 03:21:16 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 415FF5F7FE;
 Fri, 02 Jan 2026 11:21:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH 3/4] target/arm: Correctly trap HCR.TID1 registers in v7A
In-Reply-To: <20251231170858.254594-4-peter.maydell@linaro.org> (Peter
 Maydell's message of "Wed, 31 Dec 2025 17:08:57 +0000")
References: <20251231170858.254594-1-peter.maydell@linaro.org>
 <20251231170858.254594-4-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Fri, 02 Jan 2026 11:21:16 +0000
Message-ID: <87tsx4w98z.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In v7A HCR.TID1 is defined to trap for TCMTR, TLBTR, REVIDR and AIDR.
> We incorrectly use an accessfn for REVIDR and AIDR that only traps on
> v8A cores.  Fix this by collapsing access_aa64_tid1() and
> access_aa32_tid1() together and never doing a check for v8 vs v7.
>
> The accessfn is also used for SMIDR_EL1, which is fine as this
> register is AArch64 only.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c4f73eb3f3..0896e90965 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -924,8 +924,8 @@ static uint64_t isr_read(CPUARMState *env, const ARMC=
PRegInfo *ri)
>      return ret;
>  }
>=20=20
> -static CPAccessResult access_aa64_tid1(CPUARMState *env, const ARMCPRegI=
nfo *ri,
> -                                       bool isread)
> +static CPAccessResult access_tid1(CPUARMState *env, const ARMCPRegInfo *=
ri,
> +                                  bool isread)
>  {
>      if (arm_current_el(env) =3D=3D 1 && (arm_hcr_el2_eff(env) & HCR_TID1=
)) {
>          return CP_ACCESS_TRAP_EL2;
> @@ -934,16 +934,6 @@ static CPAccessResult access_aa64_tid1(CPUARMState *=
env, const ARMCPRegInfo *ri,
>      return CP_ACCESS_OK;
>  }
>=20=20
> -static CPAccessResult access_aa32_tid1(CPUARMState *env, const ARMCPRegI=
nfo *ri,
> -                                       bool isread)
> -{
> -    if (arm_feature(env, ARM_FEATURE_V8)) {
> -        return access_aa64_tid1(env, ri, isread);
> -    }
> -
> -    return CP_ACCESS_OK;
> -}
> -

This logic makes more sense from the descriptions compared to 2/4.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

