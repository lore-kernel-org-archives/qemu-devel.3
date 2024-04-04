Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFFACD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNsv-0006nM-SG; Thu, 04 Apr 2024 10:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNss-0006gC-R3
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:16:06 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNsm-0008Jv-IR
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:16:05 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56e1bbdb362so1157323a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712240159; x=1712844959; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FOFYLuC+9bWDj0GanXiQ2N7HompSHdmbgm3PtoBl904=;
 b=JPaChZy7bNXPdvfTsiGlybG1s6Fbp82gBaWNtU49wRC08B5+l/Aa/vg3QrmElDofx8
 NwjXdCmUCl1BlKEJOod02GhCkZm6Z26hz0mb0pobCpXw0FYUAAYGoHI8qxzvgp8FLG9O
 eTaTUJem+WrYBhBIAkirjjzxGN/Nma25+f4vM3L2wzq8bkYPdKAwzgudfEfHjC6xTTRt
 vS8WKxB9xfNF1Rf8R+2umpicEUjW+NXOhwJ3nqsjfAqQwK5DOa+tORrQPY6zxbV5yiEI
 KNbNunuyMl8mX2xwkaVxdZrNoFNglu7wDirQkUUAHhpe5zDOhErfjkPkd4j3xtg7WR1h
 qPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712240159; x=1712844959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FOFYLuC+9bWDj0GanXiQ2N7HompSHdmbgm3PtoBl904=;
 b=NnSJ23QOwHRrxNodG9dYk/paCbGWqv28jIke1xtH7CYtNHMqipzU2GdDaWLxvSmJ82
 gEsutVPcV/oBlJHP3+nvrnmW0dYNTebge2HFdg/2s2uehUmk5PcGkoL+pwGd1IRT043y
 r6fRXXnP+db/uPTVTG8hNhR8ok57dzRGMp8hyMPbeu42iUkvaXs4GBFgraNFJlCX1JsQ
 Iu2Q0wM7jzirub00LoP6KRkJn32/1s/uYHy5sXcNkJ5Su8HJTwzuJJjE2PSviGR/tTpA
 fCX2Sk3Le9offl3NfqRBZzL3+QWcygM0RV5QLo8q6HtwtPAcYLLQERwTI3ykqlXMlKJW
 o5gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKdrBQTSY0AiZEBkBQ3VSFmmHMQ7FDAwN8oYUPz3NEwOcWl7rRtHIgIgSngQG79Ti3DsTboqEDQPanp/NQloR4i/PI0QM=
X-Gm-Message-State: AOJu0YywVadbCs6grIYeOu6McmNa9022Ggup0be0y/XRHlx2zRXECcow
 nG0oFnvoBLEfWCIGyr3nKsmKDTaio6UFeAq3v4+nHLSNhoNxqBFrMAquABsGlU5UoKZLjKxfUOd
 aiHpvzGsFCYJSWR4SybXhYewlFNkolljGyRbbPQ==
X-Google-Smtp-Source: AGHT+IG+mXTdF0C3Vig4Ey1nZrk2m1JPDOlk5PJrvqaLbJhYgOH/fTNt0sGIhRq9ZVC0NZxk5ayKuh2bVHK8stCxytc=
X-Received: by 2002:a05:6402:22fb:b0:56b:900b:a2e with SMTP id
 dn27-20020a05640222fb00b0056b900b0a2emr1755200edb.32.1712240159060; Thu, 04
 Apr 2024 07:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-5-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-5-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 15:15:48 +0100
Message-ID: <CAFEAcA-J8wgX6sGP+qXzdv2moGFUpuqbEfPhycMir91Kh9PYXw@mail.gmail.com>
Subject: Re: [PATCH v12 04/23] target/arm: Implement ALLINT MSR (immediate)
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 3 Apr 2024 at 11:18, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Add ALLINT MSR (immediate) to decodetree, in which the CRm is 0b000x. The
> EL0 check is necessary to ALLINT, and the EL1 check is necessary when
> imm == 1. So implement it inline for EL2/3, or EL1 with imm==0. Avoid the
> unconditional write to pc and use raise_exception_ra to unwind.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

