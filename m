Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08B1C54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 14:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd9eH-0004R5-77; Thu, 22 Feb 2024 09:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd9eF-0004QZ-GN
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:02:03 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd9eD-0001aR-NW
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:02:03 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-563d32ee33aso8942568a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 06:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708610520; x=1709215320; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hkEHmSykmiu2S4q24ZuWxA0osK+QBcPhCnbS+tLwg4M=;
 b=Zk8xP8tScwFEZhWbuAdidnF5xlBaL1KIc+KI8fEexRVgpuK7MTwr9ypFpSN9D7DurW
 gwTjDmz+GdBMEax9cP9XjKU1ecoIREvSacrpHze5O8GAmdk8VW2n1+SwGw3eNLYBoNnx
 e7YWCvJxNsEMGCYtBHys5aeDdSQkKYiIE9FycpZyypXqVevj3VjAoA6SOBAP6wk9HEVC
 8XdmgLsmSPsM716Exc+P6FM5npfPFdyWk3mFkaPSTk4JSQWsN9JxHsjzgUXln7vW3NmB
 8YHAhGrl9o0NMd53u170sTBYQUZabvu0v4YibcyZ4CHx3SMNjiVGllOYmMz7/dTbO8zd
 JIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708610520; x=1709215320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hkEHmSykmiu2S4q24ZuWxA0osK+QBcPhCnbS+tLwg4M=;
 b=WtAgr28qLpfSgLlq0qjSy8PY2M4XqhQWY6y/HxIeKHIgOfmiGzM7fx0ozddPNiFvrt
 QtePx8DsiaxHJO/DSflHBVfWrR1NQgHmMmKXzjYCUEffO2Wcz9oE535PyEMjYpbFMFTL
 VmHdcSqKzwgVvqJ5qfBjpiDlt3HsSGdqkbDu0K8rZX4UozGIjfKXW1G4SkuHNKTUfPP8
 r6un9X2374vfiR9JI1tF4UA1yAW/KYTCZqHM8Uu5S5z0PC88Rij00wxDEY3n3jospteU
 1+Cr5RSwTxriEKCb7MoZvo3dKhT7QTe4h+2HO05VVVljIwIvuOYNOU9NVh3YYZASG8Zi
 djdw==
X-Gm-Message-State: AOJu0Yz1kDj4mkzE3/pS5+nUayF4Pc0jGeB124+6+2SGHbM/+H8T9BiY
 +vIeHk+JX1GXzNflNhXi278MXgk31lM2Pyd0FU3ft8BwumEjWHih4okxp08KlgR0oMizNt7y5H8
 w55GLzi75sXvPbeOeoZVF9iddtdGP1+dqTnJGxpSm7cdXNWHq
X-Google-Smtp-Source: AGHT+IHISdBvnp7c3TTphQcP6U7MbWxw1IMHGYpusnMxzMAr0/VIfvNHW3TbzHcHoljhcLPGmVCz/DlXZovsFKMQdI8=
X-Received: by 2002:a05:6402:28f:b0:565:3ba0:f576 with SMTP id
 l15-20020a056402028f00b005653ba0f576mr1127836edv.9.1708610519835; Thu, 22 Feb
 2024 06:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20240216192612.30838-2-atp.exp@gmail.com>
In-Reply-To: <20240216192612.30838-2-atp.exp@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 14:01:49 +0000
Message-ID: <CAFEAcA9qjsOdoGoc0DxqoEwdj=SYGOgUCVNAgdCneti35fDR+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Misc: Make watchdog devices using
 qemu_system_reset_request() use watchdog_perfom_action()
To: Abhiram Tilak <atp.exp@gmail.com>
Cc: qemu-devel@nongnu.org, clg@kaod.org, david@gibson.dropbear.id.au, 
 harshpb@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 16 Feb 2024 at 19:27, Abhiram Tilak <atp.exp@gmail.com> wrote:
>
> A few watchdog devices use qemu_system_reset_request(). This is not ideal since
> behaviour of watchdog-expiry can't be changed by QMP using `watchdog_action`.
> As stated in BiteSizedTasks wiki page, instead of using qemu_system_reset_request()
> to reset when a watchdog timer expires, let watchdog_perform_action() decide
> what to do.
>
> v2:
>  - Remove redundant comment in patch1 in m48t59.
>  - Exclude patch 3 from patch series due to current call being more preferable.

Thanks for sending this contribution; I've applied it to target-arm.next
and it should get into git either this week or early next week.

-- PMM

