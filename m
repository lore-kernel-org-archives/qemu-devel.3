Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AFAC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqVn2-0007qK-C1; Fri, 07 Mar 2025 06:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqVmz-0007pt-Ik
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:22:49 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqVmx-0001dF-R6
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:22:49 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so1437538276.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 03:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741346565; x=1741951365; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/XqEZqQSMqwKJzAfJesa//jWakwfQolJQlkZIz7sJ9c=;
 b=IymjG/r0U/p7r5kX7gqTrexeVjznYOerZxj/ZkpM0cUeWHsRfdO/5vyN2h1Jda0qr1
 w1klFUEVBFa9IW6l95SnMS96Rr+irzXdVgdyvHPkaisO1/tmpzHNQRP2frssoM+3dkxy
 fERFbLTsudyEjjtqCOZdr/ep+KB0M5EF2XEGD+kyLc+ucRsQiRDV+AHxy+yyOyIxflkK
 1C/ttUybO6poo/xctvS15YBgNDIbX4tNS2uxvdI0V2C86yKv2uHoATgN0KESlr6xQBfr
 xMhu3fZhkZLL5us0kXxfM1KSktc9p+lOcKX5kBo+jjMkzn536VDW/RRL94VyOROESj5t
 e2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741346565; x=1741951365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/XqEZqQSMqwKJzAfJesa//jWakwfQolJQlkZIz7sJ9c=;
 b=Cpiy0C26j7qx+sOMXCktoZqBXAy5cIykkByFm0XEG3MJ4pV9ZpD4ENLL1ro4qUkLPo
 MjDkcvX2zQ64i3UQEYsaxJPE1GRYxpcK7WMxl7n45RRev3ob705t/V13YFQopRWhTxUu
 NR/A7YjvwdpgYBUoJn0wC6b+OkfijBhMER/CewdcSrbPVw9CdAWTVv/anmnn+fDUqNXe
 eFTdTGEO+DbcqTy/OGpmJnGyRGuUmnarndRNhBxUh+KpVWcyKYivme6+cbiuWNfYWYiD
 kpPIapCW8GQnjhZ9s7gNLvKzSv45OkvnWI75NVcwUjZV9iNMGOpLgF7UTy8c/Vhz5+B6
 E5+g==
X-Gm-Message-State: AOJu0YyGqM3vo/mizbavMFuWaGuY2Qfn4nXj03wPxLgw1RiodYVtzZJc
 GXPp+woWLVfewyZmKLTatf4SGBSP7Buqt/L0zTEN0S3TY8symDrrJLPOpCpZQ6qd0XdArFCAsy5
 4R80nN1h0YUlmvbrbKNWs7S90S7CUrEwtg1p54w==
X-Gm-Gg: ASbGncsMVRU+fGqvi+92GJQwCfS2IIYC7EVy4wJYVImoqpDNXuzILpc4zt9DsZ8/0MQ
 B637P/RAyCt5zFk5owNQhwC+rdBhI1lnK1vMdx/2NEsrveXiY2sEv1eyOn5nHDOoOEUzJnX7YQF
 Ia/iofUJeCi3N+LabyK67Ll6pK2XE=
X-Google-Smtp-Source: AGHT+IEyxh7t8qaZFSgFeI6N81cqVXC41CggBHU9wDnfR5sOta7mCeZ6/MHDctMucojh3Mx7re1Kn8epLS3bOiYcZXM=
X-Received: by 2002:a05:6902:1028:b0:e60:a246:4d55 with SMTP id
 3f1490d57ef6-e635c1dbc70mr3631218276.30.1741346565404; Fri, 07 Mar 2025
 03:22:45 -0800 (PST)
MIME-Version: 1.0
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250218212103.2024039-1-keithp@keithp.com>
 <20250218212103.2024039-3-keithp@keithp.com>
In-Reply-To: <20250218212103.2024039-3-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 11:22:33 +0000
X-Gm-Features: AQ5f1JonKpYZCPb8SjZ8lmp8QcH_f4THDWItN0h0MgwpawbHKkCws8eCEJ-8xmk
Message-ID: <CAFEAcA_o2cj2Xx5_SLg77UdMynW6hftJDRbXp9s9S0Cr+OvQug@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/rx: Remove TCG_CALL_NO_WG from helpers which
 write env
To: Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Tue, 18 Feb 2025 at 21:22, Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> Functions which modify virtual machine state (such as virtual
> registers stored in memory) must not be marked TCG_CALL_NO_WG

More accurately, functions which write to TCG globals.
It's fine for a function which modifies virtual machine
state to be marked TCG_CALL_NO_WG as long as that
virtual machine state isn't stored in a TCG global.

> as that
> tells the optimizer that virtual registers values already loaded in
> machine registers are still valid, hence discards any changes which
> these helpers may have made. This seems to also mean that functions which
> set condition codes may also not use this flag

...because target/rx makes the (sensible) choice to put its
condition codes in TCG globals.

> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  target/rx/helper.h | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

