Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EFCD489A3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjtn-0006zM-D8; Fri, 16 Jan 2026 08:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgjtl-0006ym-Id
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:29:57 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgjtk-0006Al-2n
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:29:57 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7926d5dbdf7so16387767b3.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 05:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768570195; x=1769174995; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kGvP/5llXGP8HBwea63W+/aP9cLMTXlPBzR53AVuHbA=;
 b=lPfb+GAy1AobPS5GrnJIxReQ9Y8LFgGYDnp+67lrQeLBDNiGePgsF0FfJv0wfu3E6a
 cMlU3K+aDhfpDGEKZ4193nZRBllsumpMPSSSrKKYVqhYazZMBBkHsh5iDivGEpzTGk8N
 H7wRFKdkV/kzAPGBlVG4G6BzgYxMbM0U02SooQjZHgtkWrXubz+bjvYjRjOOg+3i7Ktr
 Dx6nW/36yqtxRySurZ2fAPErOhQWIH98cGcTnw/WYM2pH9XFLGks3LUHj1hUqI7V5nwb
 lFN2u6Mr/PujEKI1eLASIxTU7Sr6+Z0tECtth96dmMwprjvHiLk72inFB4hAzs5THPie
 x/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768570195; x=1769174995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kGvP/5llXGP8HBwea63W+/aP9cLMTXlPBzR53AVuHbA=;
 b=XqIbpSelQcl1vmglBFLDUTo8x+F6AJWawikbRqBqnDuPP6qdjZ8ThcNANOEescavJ9
 bTcpwrTq8o9JN+AqR8O4DP6dIlXoxfmGMETjA1qmGe80+eU4OtGBQvd839YQ4mp6/NVL
 TgrOKDQGqFkyOMyisE8xd0vm41uS8vLm4ZMgvRhZB4N09morkEep/CCc34As7Eukv9h8
 V50tRhSeNpZh7c3bqSHdVTHxexkRpmflFT2W583/+P4svrCD9U5Da4fn9Hqhpju5GkNk
 z5zr7mmcmnf/PUM5QyDPIAS0O6jZpuULesrmN44i8GRYrVTw3ecuQqpCY5oBI1r2mrkO
 /17Q==
X-Gm-Message-State: AOJu0Yyl+EWD/GV9aKhkn4VDZ2V1u7hh2przdVwplRvmqJaAkQRBVNKh
 dcYDTiG+rCp555rsrgVMuclVHPn3cMEocvOnioAWrlZVfLbPxsKI3m1WoXH4q6BTuj8bje+usg+
 Beiqur4c/4j8zTj9x+bGIbNMdj2mjDJmNG0WuJE6UIQ==
X-Gm-Gg: AY/fxX7x6vfqColBIpkIJEy2z7Pyweh2+ysZRKqGvTVmcfkxyrCfHBsL4daarocPXxd
 ByLs4P0OAV9Quv+9CxHiJMGEqhIwlS5ODh6QE6lDgQD0sHtBPuBSlzU8iPc8XlCeTx4FXrI4GNs
 2DcB/qblla4T92gOMYy/6MeakseblcMHV0tbn0/xkYyPNcuSKJywzbGZ8LFvpsstBSjgCFFTNQA
 0EZn5+Mxb8jqHg9p0Sw+VhqbpxdoDYTaU7ywkEhpuPebsoo92cPGyjOXNqa2jcpetrWAnmaupYc
 3Hrku4P79Pxrd3ig3hMKl2g=
X-Received: by 2002:a05:690c:6d8c:b0:786:660b:82b5 with SMTP id
 00721157ae682-793c52c7b89mr25323537b3.27.1768570193298; Fri, 16 Jan 2026
 05:29:53 -0800 (PST)
MIME-Version: 1.0
References: <20260109063504.71576-1-philmd@linaro.org>
 <20260109063504.71576-2-philmd@linaro.org>
In-Reply-To: <20260109063504.71576-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Jan 2026 13:29:41 +0000
X-Gm-Features: AZwV_Qg6wr5Qw1WTdbSEd564Rk3pKRuo9X0AghVCyqMdjgf9wwg18HHjZF6JqPI
Message-ID: <CAFEAcA-m2jz+V1EvbAdn1+EWjszsdhqWnREkWBcQ2seHYHhXZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] docs/devel/loads-stores: Clarify regexp are POSIX
 basic ones
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Fri, 9 Jan 2026 at 06:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> While git-grep uses POSIX basic regexp by default, git-config
> can select a distinct one. Add the '-G' (--basic-regexp)
> argument to be sure our regexps work on first try.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

It's a little unfortunate that now we suggest to the user
to use an option that almost none of them will actually
need to type (because -G is the default and most people
probably don't reconfigure their git grep default options),
but I don't have a better proposal, so:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

