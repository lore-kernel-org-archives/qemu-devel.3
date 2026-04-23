Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E45FC0379
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwR9-0008UN-Sf; Thu, 23 Apr 2026 11:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wFwQv-0008Pq-HG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:57:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wFwQt-0004eM-04
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:57:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso94106425e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776959854; x=1777564654; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oSPx4npbmHcNl5H/9QkfcHw/Tq3Ch1VoNg1DUrmAglA=;
 b=Bv3Ay5sP9k9C/Ukb0DhjkmrBmo58gfRgRKkQA2oFxcEtNn8/hsakxlv328lITmQMXo
 1QM3oy6rCg+A1L5sMSc8yVPdJ50JCd9NSmHCg/sSBN84I9QJOK6GreHdiuLFlfuXSKJF
 DQ3Rx65ZjnbPoiXeFqZU/R+RBen95deC18s/1It4np4cb6SJrc9NvDTTt/2u8H+Kete7
 Eh9af42TC0tsT7e3c7nhzYDHT7uIe9haEhj+XuIoHMF5w9ETxDEdjRUoIOe9IgZ3uyz1
 AYziKnM+xg77lvv3DkTTOLOz4tPvu5gEZyW0AgfO7xlPOtGn/xFCJOhrvp7zTtQcQZEc
 +GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776959854; x=1777564654;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oSPx4npbmHcNl5H/9QkfcHw/Tq3Ch1VoNg1DUrmAglA=;
 b=Ypc4OVuRjKqECRfCP7Azx6cJCjL0ltKGB9VAX3yRLuKKxgmSYzfghJNameB4hz8Gsl
 JPhmV5pdWSSuziotMycFb8iMkgT6xWg/BQYfW3BL8dhdWECFcxYr5ruouPuRhPfEdnlv
 j77Yxnf0AngNiIg9Fbyh5OZLNq892ILpR2XuOSCiHVcqHzYJWAZeCL8v+DNv+JPhmqbk
 nFpyyLKTvnCtlfSlg0leYAs73k6r7fqpf1xbHHAGrez3P7AbTcP1vCUtfW/jvqajRpvR
 qrj5OVOnuaXMNCFLHX3/2ArxcBswI+CGJrkK1zDl7Ex6xhoq17WtcXksir1Mg7u1eE0p
 5ASA==
X-Gm-Message-State: AOJu0YygEa0RtmEwqJBaLj1YeKQTCJ8jT8nGyy3O7dYhm5dSxVAh+ip1
 I0yz6n/IjIfKmBYHwCSpOv15VeoTjWBZnBFdzq/Cybw6fG+y1Yr/bCBOVxDqli6yL0C+rRD2OWs
 kY5QA
X-Gm-Gg: AeBDiev+5N4he+QA9wV3FlLWuOL90vyWrr6167z2VrGKACh96FOVFgEkgzD8ejVFy+C
 ANEFy6UkjcSYlHimssdBui14K0sgERKtKxB++2mnV7HaOYo6bVHLkiMLAiYNUO7Q0lvgOwo3D7J
 DwoNpCNaVUTEyUl/NRbEflQt0DASKHK3sq0yZKZbD2lUxWF6lwnrPXubWY5wPbI8KQ4TiYAGTpE
 XskRLFhq8IGt9c8Foffna/+nIMRPESzmKb6xP5WOFZMh3k2X6a6c7dOEgQ8TnWH49hx6am85fiA
 QrteSnpSCyRjWVAffhbfLcfoEnDOw8b1OBAvNP1lfxM87YEOAc9E7mm8/32bJoVbNKl9BXDBRtK
 nCAHoylS4n2i0Q9R/j7LCHj5oIZOUV0zTQSqgviY+DtT7yY5rAzuxII5KLSJmq7T1++jMM3T3sm
 ZfxrOcIVnToXCgfiYytb06eXSxy4oEScD9yin5
X-Received: by 2002:a05:600c:3110:b0:487:2439:b7be with SMTP id
 5b1f17b1804b1-488fb7389dfmr414085605e9.6.1776959853709; 
 Thu, 23 Apr 2026 08:57:33 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:652e:244a:1fdc:38a2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891978ef6bsm153590855e9.4.2026.04.23.08.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 08:57:33 -0700 (PDT)
Date: Thu, 23 Apr 2026 16:57:31 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 7/7] tests/tcg: add basic test for aarch64 wf[ie][t] insns
Message-ID: <aepBayHKD_RWFcxV@linaro.org>
References: <20260417164328.1009132-1-alex.bennee@linaro.org>
 <20260417164328.1009132-8-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417164328.1009132-8-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x332.google.com
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

On Fri, Apr 17, 2026 at 05:43:27PM +0100, Alex Bennée wrote:
> This is based on a generated test case which I've since refined and
> cleaned up.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---

> +    /* Validate the timer fired and then disable for future tests */
> +    if (!read_sysreg(cntv_ctl_el0) & 0x4) {
> +        ml_printf("Time ISTATUS not set!\n");
> +        return 1;
> +    }

Should this be if (!(read_sysreg(cntv_ctl_el0) & 0x4)) ?

Jim

