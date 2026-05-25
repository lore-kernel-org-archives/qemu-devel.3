Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BC7CD5BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRMwo-0008BT-Hl; Mon, 25 May 2026 00:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wRMwl-0008B2-2r
 for qemu-devel@nongnu.org; Mon, 25 May 2026 00:29:47 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wRMwf-0007Ug-Qt
 for qemu-devel@nongnu.org; Mon, 25 May 2026 00:29:43 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2ef8d6ba48bso4956073eec.1
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 21:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779683379; x=1780288179; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mKS6ZtzMox7hJr+d7N0SCcVnL73DioUjkJgBoaAGVsg=;
 b=I97MTjfX4YK1wHVRIMBZNQxlfWzEcx1ybYDEVtm865sEygt2L88JNSy5KquewOyjjv
 B3JhryQO7JkyyX1Qnj6Mz57FJVVsY4Hp6C+hfT8dSaXl3ClrOhQo/7/QyqE9i/Pynm55
 0UoIiduEjGFDcp+bqTHqj7+CjZWcv6YZcLwh5RpqT18pkA4gwMhu30YStUD1yaLQ4y40
 pSs7F1naxGa0x2Wn4bjOc/K786gsX3Vv1wbP7kuJrFMkHWpjYeO8ByP6Te2tMhMCsEbX
 ErW5XOEuxVpvuuRaheYLJCxjIfgSMGtlQJubsih/Yo3A1Yb0VpNBKbMvA0c98sDyAx6g
 NHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779683379; x=1780288179;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKS6ZtzMox7hJr+d7N0SCcVnL73DioUjkJgBoaAGVsg=;
 b=Tbp1IX6HvkqG05tUuyRq4Mb09yhSatVZnA+gckrpwq8bw2+IWItbsk2JIHZaV5aocy
 WxNNln0azqTtZbSieiR3evkBg6gRiEf1y+GNzLRTZdvfwzaL8obr64EuVo1xvIVUdfeI
 ZoVg5EvbnNt3dKx+4jcz8jidnG8k9PjPcHQzRqJ9wjjGUy9cCiZDKV5+7+qLxsvv7O9t
 7qg0KkWie/8qdreTADV5ky8Ifi/x9qX6hUiOrliAhqcviPlVWwGzrzd5a5DngKYxwwwx
 e9NmDSTvrCeDzV8iwlkPgBmEPuf5aPL0LWO545GOHYMlH2gDw84ueKTaigtrrDHt/h9T
 sBRw==
X-Gm-Message-State: AOJu0YzND25XBcydd3liqSoS1B0wOpYOqmXv+7FQvcWmw8BlPDGYq75A
 HDDEifZOLheCg09cvXeMgq/2Pk6I7aXHFanPkdlFjTIfMm4OWuqHwIB/rYm/bbMeCBScPg==
X-Gm-Gg: Acq92OGtrTmam7cEE9cfQoyuj4GEwT798Dqtn+u2vtwCgDg8waO0aF/8O9/cCIy2j2Y
 WqozM/V7S43KUscuw+6Zl3ltMm9OLh3iUPfZ1iDZQUZ2QkjMjywR79FyMIQpqPhw87Kryf3COJ5
 lMIZ9SPut1c3dw02MEVYOWIAr8qeLqoMkQThsqyYjeVfT50m7qy9XqmSM8h+Laepee8pj3Q6hnI
 wGv/NMrWLMxw8X9xSBn1oKt8QhccwsaDYtxX5rwx3Hnbfl0vZicARdRLUmh35ymKI3saTdsTmD7
 lStpTv6073Pek52Wp6jQWWUwHmxjra8AsWZsvgIPJA5tKZtxcuqfyK21/KY/OFbabRKYIKlJPsH
 YZc90DYs+AvWUuz5vQtRdL5socfiNajJS90YGyyRgt37cxTtMv8r38pjzdn2ZytW5/+IH+eq8Fh
 ET7P7N7HAepppEYj6ciEFbzVzIBRiTkOQWuQGaIZ2rnpvQaQVuDxhsUpWA974=
X-Received: by 2002:a05:7300:7c0d:b0:2ed:a58c:942 with SMTP id
 5a478bee46e88-3044a41f423mr4649199eec.8.1779683378466; 
 Sun, 24 May 2026 21:29:38 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm6778727eec.14.2026.05.24.21.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 21:29:37 -0700 (PDT)
Date: Mon, 25 May 2026 12:29:35 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Zephyr Li <fritchleybohrer@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 daniel.barboza@oss.qualcomm.com
Subject: Re: [PATCH] target/riscv: Do not hide Sstc CSRs from gdbstub
Message-ID: <ahPQJbUYBqXx8dfc@ChaodeMacBook-Pro.local>
References: <20260525024220.39027-1-fritchleybohrer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525024220.39027-1-fritchleybohrer@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, May 25, 2026 at 10:42:20AM +0800, Zephyr Li wrote:
> The Sstc predicate currently checks both ext_sstc and rdtime_fn. This
> causes the gdbstub CSR XML generation to skip Sstc CSRs when rdtime_fn
> has not been initialized yet, even if the CPU supports Sstc.
> 
> As a result, GDB reports $stimecmp as void with a CPU that exposes the
> sstc extension.
> 
> Only use ext_sstc for the early existence check, and keep the rdtime_fn
> check for non-debugger accesses.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3496
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
> 
> Testing:
>     Start QEMU with:
>         qemu-system-riscv64 -M virt,aclint=on -cpu max,sstc=true -s -S -nographic
> 
>     Before:
>         (gdb) p $stimecmp
>         $1 = void
> 
>     After:
>         (gdb) p $stimecmp
>         $1 = 0
> 
>  target/riscv/csr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index da366cf562..c17df147f7 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -586,7 +586,7 @@ static RISCVException sstc(CPURISCVState *env, int csrno)
>  {
>      bool hmode_check = false;
>  
> -    if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn) {
> +    if (!riscv_cpu_cfg(env)->ext_sstc) {
>          return RISCV_EXCP_ILLEGAL_INST;
>      }
>  
> @@ -603,6 +603,10 @@ static RISCVException sstc(CPURISCVState *env, int csrno)
>          return RISCV_EXCP_NONE;
>      }
>  
> +    if (!env->rdtime_fn) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
>      if (env->priv == PRV_M) {
>          return RISCV_EXCP_NONE;
>      }
> -- 
> 2.43.0
> 

