Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188EAC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 18:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwOIO-0002Jy-NT; Tue, 18 Aug 2026 14:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwOIM-0002Ja-Ul
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:12:18 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwOIK-0007xI-Tn
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:12:18 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47fe377a217so66563f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787076735; x=1787681535; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2zRzhjOdaPiQQ7x5CoGdktOL52iTjVw+qAke4aNJ/KY=;
 b=IKw3oYdLf0qK6HAAgnrjUnXlbNgWGsrPZr9GFOWGt5QII6q3PKW/YP/O9YyAk96pEc
 aj8jJh755ln2wUjBfqH6KCPUq7ifZlgojTo9in5OwTY+Jj3R/NWHgGRCNi0gl9Iv6/i4
 ClX4tl6AnqC7TqM09HDUm215je2/vtsaBdYQgpwPldaUybbAzeVlAIkKetsaAYFWeOWx
 dWOipZ+CQRw5XMmHsDbCUqO0xwMO9W6f8IG5OD/sSZ7OktPXSeRvaP5yeGqtK9J4BnfT
 ubKawHWs7p1BQ4Xj/gdkPklU0XotnMAK5OoBISCawgvi4hN5xFt3hb4c2teduQWXGw/n
 yeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787076735; x=1787681535;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2zRzhjOdaPiQQ7x5CoGdktOL52iTjVw+qAke4aNJ/KY=;
 b=OsSvW54uda61vvMklvPNFD5Okf7VP3Ech5FZIjWS5Qovdohp4ftBsaGrs480oWW5dN
 Pq4qU20xAS2aPPeWZj2f85IXgLXQxmPu2QtSq6Sk5KAZhwVWGK/RbjuX3SWHa/b7/OFq
 rdZ+4147AzYDaszT2RT7A5HRLuJsxnm0DFV/KvPm8QVYnu8+klWo6N1o5+mslJAiDUN8
 EXY6Qn+SOt2rkkuPZDhKzQe5RQmhdWJUARNgTw0eSImYx48LNeEsf6FbLp9NlZfPqyEH
 5XifDstLk6QTHzNau7FN91xF9U6WORWrTE7a6XsXyS7/B8Z90TL5Ijd8bfLUwkSNZUmq
 sGxw==
X-Gm-Message-State: AOJu0YwaSkdrw4raaEhmxqzsQ4RauWfok+aGOw5bZeDCh5/f+KEcDSQp
 hxAvCjvvYby3skrJ6mwVWfi8LedPPJTqEypC+ufrNXSBCCy3WUl9cAjlZwR2mrQeDnY=
X-Gm-Gg: AR+sD115d4TGyNR5Hlm6HyPjPYdVn825r3SLCdLbiEPTCxpE36tAr7GJBOW1mDBHO2V
 Fm2KG9jpGOEOf2ZIMDES9PalOtad6vS6TROuoI3yzDtQ12zcfQ+kFv7gAJhTv7Fs/AGwSqsw5cT
 PyORsnfpHpur+U3/btQs2OAAejWsfKyHpTQRviOk7/ECm0uAlzUOzwvGEJxW74hddM9w+lDEgTC
 yULOePPZNHJ0yWO9g9uvgyrKwQOVUKh9GictKbsX1dnXR4Taw7LtDMtWh5WghGDRfYLA56PasLB
 dqw6imY73GCy7YXPJHdYXs5odJqTVOP/yTtZq28M4742ZSxNpKU8cErfpHkJ1X2STnYk2nCTWPi
 9M1M/tHqkLiq6Mw3WAfUGT5bF0rX6XUxpf9YeGR4SWqY09xWDNBHETaY8Z6VMD06R5+UBTOe7D4
 DaYzAjXE+H8aKEBuAOXU7CRtPyHRh4AAFLEppTZpeMWOfZ3nOaIkTUMysRxQAB
X-Received: by 2002:a05:600c:1d20:b0:493:e365:7630 with SMTP id
 5b1f17b1804b1-4999fb98421mr183319085e9.14.1787076735117; 
 Tue, 18 Aug 2026 11:12:15 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d086c6dsm145296985e9.7.2026.08.18.11.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 11:12:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F02155F7DF;
 Tue, 18 Aug 2026 19:12:12 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 pbonzini@redhat.com,  philmd@mailo.com,  zhao1.liu@intel.com,
 laurent@vivier.eu,  deller@gmx.de,  pierrick.bouvier@oss.qualcomm.com
Subject: Re: [RFC PATCH 2/8] accel/tcg: enlarge the TB jump cache to 64K
 entries
In-Reply-To: <20260817190038.580257-3-mattst88@gmail.com> (Matt Turner's
 message of "Mon, 17 Aug 2026 15:00:32 -0400")
References: <20260817190038.580257-1-mattst88@gmail.com>
 <20260817190038.580257-3-mattst88@gmail.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Tue, 18 Aug 2026 19:12:12 +0100
Message-ID: <87wltnqow3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Matt Turner <mattst88@gmail.com> writes:

> The per-CPU TB jump cache has held 4096 entries since it was introduced.
> That is too small for guests running large programs: an emulated compiler
> misses often enough that the fallback qht lookup shows up prominently in
> a profile.
>
> Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
> the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host. The
> compile performs 34.2 billion TB executions, of which 8.4 billion take
> the indirect dispatch path.
>
> Sizing curve, on top of the preceding patch, instructions retired and
> wall clock:
>
>     12 bits (  64 KiB): 1,563,829,403,943          133.13s
>     14 bits ( 256 KiB): 1,493,865,985,972  -4.47%  124.89s  -6.19%
>     16 bits (   1 MiB): 1,469,729,281,442  -6.02%  120.97s  -9.13%
>     18 bits (   4 MiB): 1,462,262,363,257  -6.49%  120.16s  -9.74%

I'd be curious to see the system emulation numbers. You should see very
different profiles as more stuff gets directly chained in user mode.

> 16 bits is the knee. 18 buys another 0.47% of instructions for four times
> the memory, and since instructions retired does not account for the data
> cache pressure of a 4 MiB table, that 0.47% is probably not real: the
> wall clock difference between 16 and 18 bits is 0.67%, against a
> run-to-run spread of the same order.
>
> In a perf profile the mechanism is visible directly: tb_htable_lookup(),
> which is where qht_lookup_custom() lands once it is inlined in an LTO
> build, falls from 5.73% of samples to 1.52%.
>
> The cost is memory: the cache grows from 64 KiB to 1 MiB per vCPU. That
> is easy to justify for a single-vCPU linux-user process and less obvious
> for system emulation with many vCPUs, so this may want to be sized by
> target or made tunable rather than raised unconditionally.

Practically you wouldn't see many TCG emulations with more the 16 CPUs
(although it would be interesting to see where the MTTCG gains fade with
these proposals). With that in mind 1MiB doesn't see too excessive - I
don't know how it compares to other big allocations QEMU makes over a
typical run.

>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  accel/tcg/tb-jmp-cache.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git ./accel/tcg/tb-jmp-cache.h ./accel/tcg/tb-jmp-cache.h
> index c3a505e394..268dacd7ba 100644
> --- ./accel/tcg/tb-jmp-cache.h
> +++ ./accel/tcg/tb-jmp-cache.h
> @@ -12,7 +12,7 @@
>  #include "qemu/rcu.h"
>  #include "exec/cpu-common.h"
>=20=20
> -#define TB_JMP_CACHE_BITS 12
> +#define TB_JMP_CACHE_BITS 16
>  #define TB_JMP_CACHE_SIZE (1 << TB_JMP_CACHE_BITS)
>=20=20
>  /*

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

