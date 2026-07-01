Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CB5C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 21:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf2FL-0004ME-Vn; Wed, 01 Jul 2026 17:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wf2FK-0004Lz-4N
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 17:13:26 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wf2FI-0002Sp-Ni
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 17:13:25 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47488efcf30so686848f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 14:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782940403; x=1783545203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYWncgd4BpMBO95bMghyX1tlUeGJ4Op9c1/EUT/vMS0=;
 b=PjIFevNK5hNFoZiu19npcYxK4fcYG/rcCdGQAmW1xKI1qr9guOJ8B272t3Go/nWoBf
 YMuCRjXv8ijbf/BXvhVIaRHuJPrXYMDzYrQFGA9ZCPwXRZXRk3udCqShCBqb7eMT0AjQ
 EsPRty3qA+PrIYeQMfmxhkJl8idy1U2/ZUYAXOBpMvAMQxjKTX+2Bg1VpYEyYsscSzUV
 b6uBlyE6IeGvrOwyvkySBFGER8KH4qluCtUFej8uFle5MdMouAwFHcUQpZ0yfxZAzhBH
 b5gHYfYYiMfpa0T7xmAkt0dvIrKcuC2b80B8silxZJUO5dBOjR4X23z34xV0bVhnDgZr
 XbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782940403; x=1783545203;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gYWncgd4BpMBO95bMghyX1tlUeGJ4Op9c1/EUT/vMS0=;
 b=MSBOneqX4Q5Q/z0GLeVdajST9Up6EsLIyw9Uy79BzYJOeOtn/tL2apx3IF56rSHD66
 lmw0KpTNo7cuAQsDDWYJqXuHu2gQEtJgwLcM9CAonIAXzsm3T7yNiXD1i4P1u258xu18
 w7pmfq44n1a5HHaICL8rcOuUfDY+a3lruVQJ3IHge9/3fkvOA7NUKK6rwuSvjSjIBs4z
 slFLIKauECGGOiPSKVkgba5IIcT1drvgzdDcD3CeQ0hRQ83IrULKM5017O92iSBvB0pz
 FwDKtd+SIVUluH9FcUXDqAf0eDOu1mRyfR1Tuc8nt5Nw79Xn0A8Xxd5IA2S8u9qV/jxQ
 UrHw==
X-Gm-Message-State: AOJu0Yz5oD/mlzvba1bF4sNdqD6hnLFULguoUiJ7sF+YwSd9LCmosk4c
 b/ypwjrvqKFqEMZM8NskBse9jOx4490wBM3G/3YlJlF/ClrZJEZTLsqzx/xh5nQdxXQ=
X-Gm-Gg: AfdE7clbfNY5SVshHezJZL39RuPtlNG5FVQMFoy4TAXfwLHSiYAu5bV7n9i3We3CGIv
 oDV8mSdYgo1BMvlEJKKznVhy0bKv0W7R0FK+i0xDObamVT7hLAtzZfSLKRYvTy7EtG7NikoQP7s
 fanrhRqH1J8jnGsYwhA/xFH/hpFgJgrQOJ3P/77vTNUTSWhtWiNfsDoCBA/RxTaLiA8+RaMsBwK
 cxUBYXeGQk2iibyXkZyZBXqtQyTjkIe1DqWuB/eu5Me++tBdTy8uOINhFKfBAJBWJSddgYStoqy
 wLthbwtndtTghQwn2Upb4QKC0BXJBwyfmLHRYgMBE8ZFcJwbHRKR/LgqTunHGaXAh/hJE+OPSrw
 8LomTC97Gz9EGC1/VXaYu32dw5o7CGBWjQdNW4ECSug/6ayl1ZXMtj8La6VjHKRKdsz/NctMbqr
 ozLGDYrIO/R9Pm
X-Received: by 2002:a05:6000:480f:b0:476:82c:b869 with SMTP id
 ffacd0b85a97d-4775a2f64c2mr4644755f8f.35.1782940402693; 
 Wed, 01 Jul 2026 14:13:22 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dd94c9b5sm2805609f8f.20.2026.07.01.14.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 14:13:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EA11D5F889;
 Wed, 01 Jul 2026 22:13:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2] docs/system: rewrite gdb breakpoint and watchpoint
 explanation
In-Reply-To: <20260629105837.71103-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Mon, 29 Jun 2026 11:58:37 +0100")
References: <20260629105837.71103-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 01 Jul 2026 22:13:20 +0100
Message-ID: <87a4satnv3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> There are a couple of gotchas we should point out:
>
>   - software breakpoints can fail on early boot
>   - TCG treats all breakpoints as "hardware" breakpoints
>
> Rewrite the text to explain this more clearly and call out the gotchas
> in a note and warning sections.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3596
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

