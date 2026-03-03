Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01230EC1454
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQFO-0000K6-2G; Tue, 03 Mar 2026 08:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxQFK-0000Jl-Jc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:57:10 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxQFI-0005HL-Kd
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:57:09 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-65c4152313fso8179595a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 05:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772546226; x=1773151026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/18ZVhZMJZmiSk696wE27fLnSMTgZOxXbNF+TK8Xww=;
 b=hAVawPfCB3g0xeOrWGrTwC6w7WH59amwOMzQuDTMPJnIVmO6W60uQDm3V9Dr7pm/uR
 wfTQ2wd9EP7zzzHtnLaWJ0YeWIgfI9jeGvdTeIffOiBX6IR/v/ucW6ntG+QKbDmBv1ZR
 QUfaUAt5Sbq4BjNU8324Deuw6hqfNLILNioTJHxuXQpphEuOUCQy9tKhVLJuxujwovMm
 mU4AcXGy2HfWroF73583p9+c2F12xv9eDJyhuJxgKdFFr8WuxQ9gp2dqC/U0MxkzQXp3
 TBIcn6jpp/9e6HttHR/efDZemEphQ4ox0ThSuQod8V7LkTB86s+cCPs6T8HuhTuDrRNc
 Tuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772546226; x=1773151026;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F/18ZVhZMJZmiSk696wE27fLnSMTgZOxXbNF+TK8Xww=;
 b=ZVjz8rp95s5NUPbKk8M1NKTwqVYN4dPQoj+nx4bqUfhaUXek4bo+gof+x0XZ44cIlp
 EEi7z+PCFa++hyl91zYYz0kx3sdEvrGOjdQtkXU0UhNUZXAZxAXTncurCWBIWDzLUU3d
 k+pbvrOXvhjDQSM9j//2E/XAshdLy6bgtY/XYQcdT9iO2PgJQxn5pwwIIBjwKsWZtJht
 NV/pC5JsOkIpI5+IS8i0Y+vkqgoNJxHKvRvxfn3Xt8IAfaTIJjnDV88yjMbn2/4qTB3/
 hayFKxoAHzvqsKrGleKSoQ41NSlxjl94Lst2bC2FAFlGn+SIxYLG7jbEub/9z4a1lpu2
 6SNg==
X-Gm-Message-State: AOJu0YxA01yPlWyAOjB8iX2Qq10x7ckt/21Ey66L6qyw6U6KdSQ2LVeu
 +XTU8vRhhMY5w4rKO7/otX0Rxuk1GJ0XvK6244fRWqUklsUBQ+Ym2ckoSuxmFcflGKo=
X-Gm-Gg: ATEYQzxqV+CqScSP7fJH5t2qe9TTjn0YDDIKucW+7VAB711WsZuf+ZmdkL9A6Pe7VyZ
 nzv2cD+F5RVJdiCs4AZkI9uiytcsJ4JDULa/Z3yJHv41TzETNE5/tNPlK2qhA5uTrReUOnVbO+d
 zgqoxMqkStkCvyOe3wDU49nputv/sLQ+QU0NUwgPL3kE1JwaOkX+a96iChZe0vNczvaLK6hpVqi
 himCGOToJ1D56rMdIdkN0ivGSkA37j9uetqozMgIiY46wlCtJnnIHxJrYeBEB8qgTXdx0OKv+lo
 C2OrfKP3gZ4QYgbru4O1yu0pTk8KikK6gr3FxkISQ0BjoFXwke6NOfkibgK5xKeCr2t02lLm6xY
 rQm8KcabLcUvZd6wQBsOFfE+LiZEhh8dbKHbTzDnSLAOhMTzxSexIbnjzCYAoahWz8MQOHPFLdx
 iVujhg3QYPpkcixP8e1LpcvOc=
X-Received: by 2002:a05:6402:27cf:b0:65f:76d3:f2c3 with SMTP id
 4fb4d7f45d1cf-65fddceee2emr10043731a12.15.1772546225773; 
 Tue, 03 Mar 2026 05:57:05 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabf6cfd9sm4441639a12.22.2026.03.03.05.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 05:57:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 16E815F811;
 Tue, 03 Mar 2026 13:57:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,  berrange@redhat.com,
 richard.henderson@linaro.org,  imp@bsdimp.com
Subject: Re: [PATCH v6 6/7] plugins: prohibit writing to read-only registers
In-Reply-To: <20260303-setpc-v5-v6-6-15c77cfe184e@epfl.ch> (Florian
 Hofhammer's message of "Tue, 3 Mar 2026 14:07:32 +0100")
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
 <20260303-setpc-v5-v6-6-15c77cfe184e@epfl.ch>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Tue, 03 Mar 2026 13:57:03 +0000
Message-ID: <87jyvtauds.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> The opaque register handle encodes whether a register is read-only in
> the lowest bit and prevents writing to the register via the plugin API
> in this case.
>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

