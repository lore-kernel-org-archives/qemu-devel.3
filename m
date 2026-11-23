Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA1160A5BCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Na4tS6jI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVU34-0006y3-So; Mon, 23 Nov 2026 08:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xVU2v-0006vZ-7e
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:25:25 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xVU2t-00044Z-8Q
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:25:24 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b86fcbd647so5184950a12.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795440320; x=1796045120; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5uBHfXxarlQxThHI3qmHMfwnqha/W1yW36nDRLB1Shc=;
 b=Na4tS6jIQwBy0qAa9NGnAFETeh3kuflzkWZpuWPmfq3QkQtUKf9d+XehFMwagExZZQ
 lFur+x89PiKLsIufawUh9gkQ0WAOGbiEe3w/8h0/WgeqaUv/QImUSTSkJV4WGmuhwqde
 Mzl5eO81J8G1MO5DKmh76cvuba8/MDuTN1JSVVobFarfggFiMYnYmnUN2TdTM5BhBbvD
 ncXS5GPeAkA41Vv6wjKR+1NZzV2vW+z9qFcE0NfTfyS6pOkSro56h5kUsN53GNSegGxg
 QJ3TC4wB6ELmcaY6yBWeYOx44hZZNvTvMnUvzWbiJJYs7wx5Z8XELT+/dsQk2O5Qn0V3
 urfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795440320; x=1796045120;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5uBHfXxarlQxThHI3qmHMfwnqha/W1yW36nDRLB1Shc=;
 b=0ZvZ4z/or55CoWXvmqMGRQ0dA3RcSNSec2SbiK0GBWTOTfz+Tjv8Hx/yyTVlU3UxyG
 ZGNSSr9OlStkrIikZXRysEX7qspc6u2wd8r1BO+14tofhWHhdJCvlyi//GM7KZlArnGD
 Usctg1lecUUnGCudeBxSdQH6tEf1CUkbXJPnCWw63VixXFY9Flvgae8T56clBf9d3k72
 5ASg7dxLzFyfeOjehZynfIG3mxe5aO3uC91mahX92Mf4KPkGYZJ64bsjRzpBtXQiYHzf
 q8C5w1ifgPrKeW4APfBgEFIuw82KZ8fYSR61NzGX/gFhGSIEIkTGVmdXtEAZyTIyK4mw
 2G1A==
X-Forwarded-Encrypted: i=1;
 AL+hErGXBuxu50k6usXEGkDDmpK8Hap6ziLwGMga3yeHAYP3KQqJUO1dErVvLsJ7HIUlxOVmj8nB4/QjPiif@nongnu.org
X-Gm-Message-State: APuU4Z82V8S+xgXFMNASApbyE6fjEm9Z7c6BaTxdC3niozVo2nTi/f6H
 imeKYGhFlC/zow4BgVrBEZ8iMp9Sjc6WJBQclZ4gmQY9jCxjKAGi9E9+c6tYlUQi2Gw=
X-Gm-Gg: AZFdTZdL7gu2ypo/gfwXISsyTGFNK4h2z0T1rzHsu5oT65EE0x96k0UMzwTjqQFRPnv
 +q0SBWV1IYwucYfVrlskPVBYxopIDZucXxZHqd3gwfe1oX361YyOJtvo5XcoyiGSZbyd+Jmac6J
 uEpJfwuLGDYMMhE4rEApivffhA0qq/HkOxhEHzLNo+Px5mklKpZUxQelK8KOO65XDXPGjQTwZxv
 Hfsi951a6am7Cn1acYoHWcClR78GXgaKLWG5NDr+T5mchd2iTaD/A+3WGxsPk0TD5ssW58/2vgP
 t09RHi9fhrX5qMJw8/2rb+UigS5LwoVFHb7IAQ6AGnXWm9Sl3CpQdI83o7kEzpeG18Ah4xe2LfT
 dFFGB/yuqYPZ2zYgT4uMOnS1r/MVyZICNUPaXea9PQ/7PCUGRMwR0UYCHtAQ8SgQ5AVOvG/hkaC
 RHxIhkFSfJKuBCmfq9W3NL/JHMCg//YvlOWgtGOGtVZgk1e19aoBu6ZSgy2iOlH4q7bcLkz4ln/
 F6NVWoZFGGCWSdRfxD8Sbq4bw/bBRBRgy5e+RZOS7+ua8tkgFg8FG1IXLGjRpbkWW9MLGpYbO0n
 rdLzBrfx/eEeGJk0qunz8GHEu5jTxGAz
X-Received: by 2002:a05:6402:13d6:b0:6ba:a799:d9bb with SMTP id
 4fb4d7f45d1cf-6baa799dc20mr2261300a12.9.1795440320194; 
 Mon, 23 Nov 2026 05:25:20 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:638f:5754:a31d:8f22])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370cd368sm5325860a12.8.2026.11.23.05.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:25:19 -0800 (PST)
Date: Mon, 23 Nov 2026 13:25:18 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
	Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH for-11.2] target/arm: Handle "PMU disabled" in migration
 validate functions
Message-ID: <awQ-vnYjY8BEAdFi@linaro.org>
References: <20261119165546.3050013-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119165546.3050013-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ed1-x536.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 04:55:46PM +0000, Peter Maydell wrote:
> In various test functions for VMSTATE_VALIDATE() fields, we check
> whether the migrated region number register is within bounds (i.e.
> less than the total number of configured regions).  These tests fail
> spuriously if there are zero configured regions, because then "x <
> cpu->pmsav7_dregion" is always false.
> 
> When we allowed v6M CPUs to have PMSAv7 in commit 157f6c69edd06, this
> exposed a bug, because we now have a CPU which has PMSAv7 according
> to the pmsav7_needed() function but which is configured with 0 PMSA
> regions: the Cortex-M0.
> 
> We could fix this by having pmsav7_needed() return false if there
> are 0 regions; however, the cpu/m-security vmstate struct does
> migration of the secure equivalents of these fields, and we also do
> a VMSTATE_VALIDATE that checks against the number of MPU regions
> there. Making those fields be migrated only if there is more than
> one region would be awkward (we'd need to pull them out into their
> own vmstate struct), and it's unnecessary -- migrating something
> that's all zeroes and not used isn't a problem.
> 
> So instead we relax the checks to handle the "no configured regions"
> case, insisting then that the rnr field in the CPU state (which
> should never be used) is zero.
> 
> Similarly, we adjust the check in sau_rnr_vmstate_validate against
> sau_sregion; this one is currently theoretical as all our CPUs which
> implement the Security Extension have at least one SAU region, but
> architecturally it is permitted to implemnt no SAU regions.
> 
> Fixes: 157f6c69edd06 ("target/arm: extend PMSAv7 support to v6-M CPUs")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/machine.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index c3aef3f3301..d624425c0dd 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -593,7 +593,8 @@ static bool pmsav7_rgnr_vmstate_validate(void *opaque, int version_id)
>  {
>      ARMCPU *cpu = opaque;
>  
> -    return cpu->env.pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion;
> +    return cpu->env.pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion ||
> +        (cpu->pmsav7_dregion == 0 && cpu->env.pmsav7.rnr[M_REG_NS] == 0);
>  }
>  
>  static const VMStateDescription vmstate_pmsav7 = {
> @@ -693,14 +694,16 @@ static bool s_rnr_vmstate_validate(void *opaque, int version_id)
>  {
>      ARMCPU *cpu = opaque;
>  
> -    return cpu->env.pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion;
> +    return cpu->env.pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion ||
> +        (cpu->pmsav7_dregion == 0 && cpu->env.pmsav7.rnr[M_REG_NS] == 0);
>  }
>  
>  static bool sau_rnr_vmstate_validate(void *opaque, int version_id)
>  {
>      ARMCPU *cpu = opaque;
>  
> -    return cpu->env.sau.rnr < cpu->sau_sregion;
> +    return cpu->env.sau.rnr < cpu->sau_sregion ||
> +        (cpu->sau_sregion == 0 && cpu->env.sau.rnr == 0);
>  }
>  
>  static bool m_security_needed(void *opaque)
> -- 
> 2.43.0
> 
> 

The logic makes sense; it would be nice to have a comment in there explaining
that RNR==0 indicates an unused value rather than a genuine region numbered
0, but I'm OK with this being applied as is.

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>

Jim

