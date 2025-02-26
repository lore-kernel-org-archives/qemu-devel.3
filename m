Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223D2C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDLu-0005xG-NE; Wed, 26 Feb 2025 04:05:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnDLn-0005t6-S5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:05:08 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnDLl-0000YB-K2
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:05:07 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-439846bc7eeso41443395e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 01:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740560704; x=1741165504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9dyEMddKkFct7hLjjh+4wrvVczoiVESZ2551xZPFh7Q=;
 b=cYeQ2x5IJYgF9wYoBaca5sXQkrH7r0SINfCiHXdoj6tsGl0CHve6gdFTbBPy7Rgs3V
 S6qvxqmKb51SeAv01bL9sPOSdUhkmcquwbvR2WTv9mJ2yz0VsDwG+SFwJT/CyZ0OsW5q
 IRrU1y9f1v1nf+WhNW1Jh8yEWVCWccOm/dkaxJ4i2uTXMNugsbUv9mry16lFDPiK5Ozs
 rbXT02EiuF820oBC6VTHS2F3AWgDOHeW7rstvSmLgsnZACOugU8llUW1S29v9K/zTue0
 YKSuO6xfAP2ngA7gWhjgg/pCorAtaulMoFJVm1IOtyKX5jLg36xnd8svxTC4o15+5YMQ
 7Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740560704; x=1741165504;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9dyEMddKkFct7hLjjh+4wrvVczoiVESZ2551xZPFh7Q=;
 b=TQr2qjoSct+c4yhGlT8hBhGq1i6ljC/Rbv1zvNIvkIhPX0TT6WRcWXC44s8Hq3pP0s
 DHnmV/0941udoxga2lDyM3SmqdpyvcktnmGsLv9NJKuB9oAnjb7zth/QMemEYdjz2kfR
 svJEz5eik7e34tDQcKCxmmxkrzDb3Uuexvsq6YRq3FqhhOgiwmr5Vc3uOuZSft9+0tcx
 zNMwrjBvyyQJi+yKooLdPdpKoksYWy8pkvTMpJ4KQ92ysUhx1gN8ZhJ2O+0Fx6IRvJ/Y
 PDmz3yB3g9bW3f0Ye6jJgfrQeROj0dFN00yCsl8ITB7/7rMTd6mfXLDmABS9tBaEP50e
 JHOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXstv8Aqm4ZJivx6SDh34EjxKBmQLvMvpELlGB10EoQfWLi70bhmTVtQ0wfU7Ixz8dmdweLDuglQ2Yl@nongnu.org
X-Gm-Message-State: AOJu0YwWCx17yZX7UP7x4g9gEokbo6ckLSEqDe/RlK+FVPgBGijNnxqT
 vqQTe3/ltBxAkY9z2TSLZUnfq0qL5ILILxePLTovzkL1PZKKKrRG5VrjitUilrq6y5SfsKSlhVZ
 nRxw=
X-Gm-Gg: ASbGncsjvsBe0NCwNSn2Y+YdEOxKf85qy/KcvyqIhX2NhVml4X2CyXldk2DetjSH4Nm
 Kav5IW4OhbPAP7wBgKw3YFD8axjUGQt9gkrLvbpZjibXqnRYwcyhYCePLmn2H/46iTP9xLsyBNL
 aIaC8E6vp/7OJ4gpu9guSwaMxs3tsrtSPNXwVzU+NQ2g4T6rBQwh/9KQemUHd0ax3WmKvGJeQM0
 X3no05Jg4YFvtOujtZMEqgi2jrTd2NlBDSIbEY4NNQWrYOjBMQjGsJcvI369KgNQmIHAPX5eO6L
 LQmeDpErsQUj+HLOuazj3SJyqoA5
X-Google-Smtp-Source: AGHT+IEyFx093mOFxRayokSEofueuq2s5Lt58Gy2dgVytQmdAFWzBmLwNbhG4IWhzJu7EAHAOdF+fA==
X-Received: by 2002:a05:600c:871b:b0:439:65fa:5872 with SMTP id
 5b1f17b1804b1-43abb77bc24mr8127305e9.24.1740560703800; 
 Wed, 26 Feb 2025 01:05:03 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5329besm13777935e9.15.2025.02.26.01.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 01:05:03 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E54605F87C;
 Wed, 26 Feb 2025 09:05:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH v3 2/9] target/arm: Don't apply CNTVOFF_EL2 for EL2_VIRT
 timer
In-Reply-To: <20250204125009.2281315-3-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 4 Feb 2025 12:50:02 +0000")
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
 <20250204125009.2281315-3-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 26 Feb 2025 09:05:01 +0000
Message-ID: <87o6yp3wle.fsf@draig.linaro.org>
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

> The CNTVOFF_EL2 offset register should only be applied for accessses
> to CNTVCT_EL0 and for the EL1 virtual timer (CNTV_*).  We were
> incorrectly applying it for the EL2 virtual timer (CNTHV_*).
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

