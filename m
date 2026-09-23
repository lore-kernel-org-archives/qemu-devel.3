Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C95C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Mmy-0007e1-TR; Wed, 23 Sep 2026 09:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x9Mmw-0007dl-7o
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:13:30 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x9Mmu-0006HD-Fm
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:13:29 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f560398so115587266b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790169206; x=1790774006; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o7kjhimBtV/h3W37BHRa9QTsK81Tuiy7Rq8wmBtCvcM=;
 b=FeqX0rohH7HR7/BfIatqp+6COx+nakm8xH2gJGr5m3BNKMsybi/HknuJAw/On+feUj
 gmeKnOpZBOgRyTH7u8Rs/bdNRuloF/NMJimCoA4evknQJs40rKOBpFZNoHe0vRha8wP0
 V0UQq7togXfrOFwH0d/yZDC1FZyP4qo9x16fUHLFA9dts62Pa/+slykYCvscpbjdYIrL
 fJAfVdqKOFQirWo9uAxZTgnlTAoUzMuAq+Y5P/AdQHtE3lklH9VIW1vEO7mYXaoYvfIg
 qdbKREc5+TAwGWOFF76y4VDpm2+dy6WxuMlG0qzK+AYOxDwDyBxZpsRTitFBQOYLaWJg
 ueSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169206; x=1790774006;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o7kjhimBtV/h3W37BHRa9QTsK81Tuiy7Rq8wmBtCvcM=;
 b=cVmWI4U9OVRjQWJkla3BXwAxR07Pfl2tZav0Z7N8n9Oqvvu9yF/JUMY+yuz9tXWHvi
 d2nvlFUTK+s0BVksu06FDpXUojNmResZyH7mNVU9ZUhp2j07AyG5XrXY2u1gjsCnmE3M
 4bsTugTfHm581HxAJuD8ksGDPGVg6/sA0y8YwENBUe3kH1cVP+yW5FrGHJNgCWkFcejf
 eWHXucvbXIP7WFoW6KwlYPQPPM2MZDinRsruUT9UanBO90yLPu/bqvgxSHTkK6tRu4pz
 a9lp54/kxX4qzPqZ0G6KvH/IZqTfs9kR5s6ryNUZx623DlX6XDrTrtZU9yQdVpjkkair
 wepQ==
X-Gm-Message-State: AFuF++lsxNwSYwAxEUBETJdbEbHrEmMcOwti8R75cstvijq/GHunzUWG
 VIk50gCm1F+HDzH7IsdRmKaR1M3gJHaqv/5dtFf10fO8NdSCUmkkAUzWpRgyTaXZyash7vXTumX
 uogL4UpI=
X-Gm-Gg: AYBFou0D2OO4ACIV2z7dx8rD5MBLWXifdiFxVRt+tePb8KclsVXT9FvRpbL3tMRvhkt
 vhe8G7C7SlvZnPEIEZql1dm2VLBOiTfNtgo/zutMq4GGcOjzwtMPf4Mo4CtZ6uHhXBUG1zkza63
 Kbx1a96FrxnBKqQ3kgUbrlT3cFZ7fSdB2Rh7VcEB8so4COKPp9Fle9t7DHKB1tojDIteuExs05/
 24jztav5KDu0syIwOosMdRRjC5db07wrDYOVCUqMjLa3FWMXAJ+pN/pjAlGp2xlvRgTVi+/iHim
 5Bbyi0l4nFPwBnzKnJHcVHtzlo9wXEFnTdQxpBl2F5KiuV3aWI2H0S0HnAUGl9BHEOBwCiZ+di9
 SDIk9UdQgl4x1DxntUd9K7Ct7tnSxDR1G31n+sg95GMJEBaZDvH562F7OCWV+eiDKH/vZXZEuJ7
 ir278fv/dr/XotfZOUYh6fKICTWgFT6FoHKoe70AFYDltN1c/lPOl573tKw6m+rkaP5/IV5EA9
X-Received: by 2002:a17:907:970f:b0:c29:ab1d:b5be with SMTP id
 a640c23a62f3a-c2aae271d41mr217430566b.27.1790169205945; 
 Wed, 23 Sep 2026 06:13:25 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:805c:5b2c:d225:9d51])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae6a4adasm120085966b.47.2026.09.23.06.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:13:22 -0700 (PDT)
Date: Wed, 23 Sep 2026 14:13:18 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: Re: [PATCH v2 1/2] accel/tcg: Allow some address space wraparound
 during translation
Message-ID: <arPQbliiJEUKAJ08@linaro.org>
References: <20260916235158.294901-1-richard.henderson@linaro.org>
 <20260916235158.294901-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916235158.294901-2-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej2-x10.google.com
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

On Wed, Sep 16, 2026 at 01:51:57PM -1000, Richard Henderson wrote:
> Allow the two pages of translation to be non-contiguous.
> As long as the target translator wraps pc properly, this
> allows address space wraparound to function correctly.
> 
> This avoids an assert on a valid i386 system-mode test case.
> 
> Reported-by: Tao Cui <cui.tao@linux.dev>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/translator.h |  3 +++
>  accel/tcg/translator.c    | 45 ++++++++++++++++++++++++---------------
>  2 files changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/include/exec/translator.h b/include/exec/translator.h
> index 978dee25add..104e6d4f361 100644

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


