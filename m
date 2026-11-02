Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D956075044
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p51MHKjy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuP7-0004yN-Eo; Mon, 02 Nov 2026 10:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNuP4-0004xw-U1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:56:58 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNuP3-0007gX-9L
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:56:58 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ea0efd636dso29581495ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 07:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793635016; x=1794239816; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8uTZJfTirItKmrSGCUnXTTBv+JkAs5opFFvVM8Qlmgc=;
 b=p51MHKjy/RnUcfALIdxQzOl/b+dawdl1Knzi8dkzlRteqppLABacBLKYB90OxDo9Yk
 WpGd8yD61sCTjTFvn1eijayr0b+4OKhLBNUPbGpKL1mZeVeX11/53GmQMRAeaAGUvy5N
 gg9TM63XC8vWkX62hy/9Ei3db/LBBoiun+Xqsf7+bp3mRnb3tQET/Lo4Q2Q/mecHVxgR
 iChsdyV8A4Xn9qXAqM9MBiuXJ1V1ODd9pAnMaNzXIMKv5wsydno/FjdEZc3LZ/MQ2AjX
 0g2urqeRFtf2CaDkJ3dpEZUPJPJkfcw2v05xJn+sq42t9eE02eQpLIqbo/dSyAiM7N5O
 CwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793635016; x=1794239816;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8uTZJfTirItKmrSGCUnXTTBv+JkAs5opFFvVM8Qlmgc=;
 b=nsgWq50KJ9svOCad2NYPK1eOult5c0SBsImwfADCWPUEnLWZ36FXGhbeuaneadt0A3
 LZ6Z9kBS5f2slOSl93PzxySrueWbv/IQQ9dnA0FcRLDzYNUhGPtxS1EjjfS51pczJg5h
 c6xdAif/dxv3u9h3lFUZgqlFybTAgMVgWpLiXJHGuW2N/7zVAKP1O3XqLS4vn2yVZuwb
 lkkicTYcvucdR+PPEfXzCLsBtkGR+p2utiviMDQUa686Hbp2DwSQxSXVjl6/EnfcGAhz
 xwYVzmlMfq2pTSZl674VRnhT8s5FZOejE32+nnuEzkEOIfX0nRASRPH7sIxQT/dWqbJU
 MvRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxj3HG8TtFvamJtdOr0ZqfQS+qcHQEuldMftxaT+OaSnUelg2W7/fZ2WpkVXOx7OXmdSWntgSWasLla@nongnu.org
X-Gm-Message-State: APuU4Z8KOUOMR0nwHeMeq6L5qJJW8j5X4xFhQu/s7FAyKDo7IX7FhaP8
 wdxBzhhlOps/aUwwCfn58VszyQ+EPe6k9UifEL+OEJFkZelTXbeVcZYtLcH8aVYfmEg=
X-Gm-Gg: AYBFou2V0NQ4TJgtJP9PcLetjG35i6zjA5FJFfPd1CPILXdnTRAxDk0s5/biTXqNkNX
 qP7D3esC7Ww/u8oPyx6AHJDGznTqOOWZDhrzNfbPuUVu34FEU8UKY5642WKNNX9G/FBeGOCsCZX
 J3tjsahUXpOeGp/OIPYP2fYtOjP3JZ/8uwMP+eix0TF3FpSf1g99HSqSjXMM8/R+gGECEl9R7++
 xk8deay+2YcnCgEi9zmHUni5cr37L3ixEPf89al+iSEO+XOf8J5tRTpjZaaLv6Kds+CsWKyEU+w
 627afKB9+Zy9LDJsKenDXUsaMGSVELUtHssSHPd5HjFCEF9MsDVMEQGw+AKQjiGG5+cNYwkmYIP
 9HKvM2GCf+bG4EkLkQ36C/pPHlTvSALB/6g/o2LEg8LuNSoQIAjj+gdGw6SVNcCr/45+rNfCZqL
 orhmYNajuOstJEGqb5O/CEFda6oDKO8Ls9qSMQE1xQuP4S/PdDkjmnt/0DaUklU81+TyuzuaIzF
 nalYbkjQgWIEnH9e58jymiqFRwk5y0qvKkzx6qsVCwUpPrEVxp7C+PPfEE93gdI4ad8Mh+A9pkw
 3uF2h2/w6umK9YrprWA2eQ2bcQY6cX1KfuUGXK8nl6XYXK2GDRGO0t5MbvkDtvY3iJD07rdDLFv
 VUF5EqXmdULpoYp0=
X-Received: by 2002:a17:902:ec85:b0:2e9:a23b:643d with SMTP id
 d9443c01a7336-2eb364d253fmr93917105ad.35.1793635015524; 
 Mon, 02 Nov 2026 07:56:55 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb3929b27bsm29701215ad.62.2026.11.02.07.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 07:56:55 -0800 (PST)
Message-ID: <9c5199bd-f8d5-403b-8044-a34070c793b9@linaro.org>
Date: Mon, 2 Nov 2026 07:56:53 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] PPC PR for 11.2 Soft Freeze
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20261102114558.62509-1-harshpb@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261102114558.62509-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 03:45, Harsh Prateek Bora wrote:
> The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:
> 
>    Merge tag 'qemu-sparc-20261101' ofhttps://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.2-sf-20261102
> 
> for you to fetch changes up to 9e0dff1dca5d50a79b02de6e72a8adcc22b23143:
> 
>    pnv/phb5: Mask off LSI Source-ID based on number of interrupts (2026-11-02 12:44:37 +0530)
> 
> ----------------------------------------------------------------
> PPC PR for 11.2 Soft Freeze
> * PowerNV: Add initial support for PHB5

Applied, thanks.

r~

