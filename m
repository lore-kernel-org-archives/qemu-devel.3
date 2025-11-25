Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FCAD0E6FA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNuU4-0005UQ-3a; Tue, 25 Nov 2025 09:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNuTr-0005RF-WB
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:57:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNuTo-0008SS-MW
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:57:22 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso54978435e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 06:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764082638; x=1764687438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKkgigyUCCUZ6+9NK+O7DJtddxbtff2Jby3Ze6AdtF8=;
 b=ek9VObL0Vs69RBEpuT3dIB3srFHiQsou1K16m/MUUzCmcH/F4CIPp73x98q1SgsuIQ
 sb8v+T9hvO9bRuTQC57hCRb17GsHNCrwB/wk/zIUiwzhWnEL3kD0PlETGfJL31JZY12B
 Sfi1m3eSK4H3SOtRQuP1gNaW8J67OZhUR8L3HQx8PPHlz2yWodGHqgbkaGDo95OeCjvv
 BvkFbXLDUGitZGNQvrNTIXzf3/k6EZOFWxfwqNppwJK0xHpfJaTIKWB4u8tkT9ZGHrOg
 pel8Y5VKOecZlyPZJb3X7u/7c9aQ9aiiiu1Iutr18gNwFD9RkPNEn7n/fd1VKjZfR/cG
 Ogbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764082638; x=1764687438;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GKkgigyUCCUZ6+9NK+O7DJtddxbtff2Jby3Ze6AdtF8=;
 b=t6LGDVn5XIeGBomf+3nOAZmnEuVdEFUa4qhGFfFoSQ0v040J1VChFSxperRHqhf1bG
 5m9H1FW46S3KGGsyqJeX8SD7Ish06cwnFaSfJt8O8Uk+9rT6wbksqRjYtEFWt78eDVCQ
 jp/eSQIfbpFZxM64jroY25duRWOwyIfSkOFBwF7Q0XMnxp8z1EQRPkQfb5ps4xKZsSTE
 3owp8+N63FTw5rE9R5G7QV7zSWtdpxpEPb+yp1PWM3RIt321vLbOLVxLNINtJCYN+P0v
 ekRPl+onenZt4ulrtZVsl7KBLI8m5Cw2EAIdAEYsJExrL9aP6MM5OgmnnACmK6fmfsV8
 uYBA==
X-Gm-Message-State: AOJu0YwDMBuM6dbhMmne17ZmTf5cp8gwxeuxbgNExbuhTwFLDNHccsSQ
 wFE2QkQ/krFQZ8hm3Stra7YkC83LTV/YTsi3gGbe+4htmuIvsPFVTSYmrr1Ngrs+pwfVz+LqQgt
 l9RkZ
X-Gm-Gg: ASbGncsOdQ85H4N3g4Y0LbGGirbZEz7UPjsXKFP4qfiNsOct7PslVloPfGPgxOmGZQq
 QQOJQDdNKign0L3lt9wTSTzP1nbU/pnYr1IVfIsc+PWdrDBx7rziT9kQXPRlPZpR0JI1qIsFezj
 bGWgCAB4LG+n9wJtja3uM8vXGn0nGTsOk6hjzadp64aTEEjNZK02PkcrS0ZAZ6DJ9J9Jn0qKnjr
 g1E5syF22Y5ep6OQ6bDheumTjgog2FDbuWtATNYc9bxyvjFOYJeEdzawBZX1VFdAQo+w5a9xJni
 l6xSOroHjmc95rUSQ99f/JtP2Xgmrmb4K7E/3+0fnDdmEAt2UobgLJhxAV1KTxitPTPJA5H+6x/
 UC8ZPRMYWun11tDe1iWAzqOQdHAFJf4xRCgkWFfueD6kfvmSD95557jWfri3vKu+mriK2hJnIND
 kCiZumNkrj9zA=
X-Google-Smtp-Source: AGHT+IHEtiaJMB3Bykj31isn3NW6aW5EMOTlTUsTkSrb/u3VcGRGj4rvXhPJ9LdT8ew7DIqn146FhQ==
X-Received: by 2002:a05:600c:1c02:b0:477:9caa:1a26 with SMTP id
 5b1f17b1804b1-477c01eed7cmr162222745e9.29.1764082638171; 
 Tue, 25 Nov 2025 06:57:18 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb8e62sm34778869f8f.35.2025.11.25.06.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 06:57:17 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E6E2C5F7EF;
 Tue, 25 Nov 2025 14:57:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 3/3] docs/system/generic-loader: move TODO to source code
In-Reply-To: <20251125143141.216056-4-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 25 Nov 2025 14:31:41 +0000")
References: <20251125143141.216056-1-peter.maydell@linaro.org>
 <20251125143141.216056-4-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 25 Nov 2025 14:57:16 +0000
Message-ID: <874iqi6tyr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

> Currently we have a "Restrictions and ToDos" section at the bottom of
> the document which notes that there's no way to specify a CPU to load
> a file through that doesn't also set that CPU's PC.  This is written
> as a developer-facing note.  Move this to a TODO comment in the
> source code, and provide a shorter user-facing statement of the
> current restriction under the specific sub-option that it applies to.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

