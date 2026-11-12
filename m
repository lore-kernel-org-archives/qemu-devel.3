Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D07606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=IQfjk2PS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QuNDsjaV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRXq7-0001m1-EX; Thu, 12 Nov 2026 11:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xRXpu-0001ZX-4f
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 11:39:42 -0500
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xRXps-0001v7-2r
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 11:39:41 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 706D17A00F2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 11:39:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 12 Nov 2026 11:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1794501578; x=
 1794587978; bh=fxQiuGH8irVoZTqNy9QdMALg/tzNtpJuMCBrplSjhEQ=; b=I
 Qfjk2PSXfPLxQgWfNbyDNqcxDkTUsHIro1wVecDz4s4IMd5rNYZrQ1x4f14uQaDm
 ZY4vAuultx/zyRjig+qNQdUrQpbpJuuwnMCf5eBdJv35OIrY0ebj65f8hnFaiwy3
 ICploRB0qn0ovz2tm69KYGSn0klI1dxYfcP+pgs4MnAYnIuaThFwj0A3OCXVXgeH
 e/zWZ/Pxw4pSIK7s9MRj/tSm9Jzto1ZyNbotd3m/5lk4KzGt2amsBK6SbB6NtWBt
 Fn1WsnNBHztC4U3u2Xrb5eTdjWCsfEsGM9UrGCLNu+orlWEEQf06zzXpI0nKBwWc
 J7wdoCxOvgltskwkMOomA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:mime-version:references:reply-to
 :subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1794501578; x=1794587978; bh=fxQiuGH8irVoZ
 TqNy9QdMALg/tzNtpJuMCBrplSjhEQ=; b=QuNDsjaVylpcgKjLOVNMqoGsPLhRi
 QkmiGjJr0Ar2Oso0b57XSYY19i329XugAt8KrcibFxE89JHnpiX9R672Jm+MUxFt
 +jMs3dpYRj1cZakatfm5zfg7b3IEYDqztClnaUHVIFvmVOkq/FoC+VktanLKqe57
 x0V238rLnOvw535Q7m32deOMIrSubVCf2LRDcZVJLAZSqvG6mwKSmnTPOn1UyAjL
 XaoD+3j9XIhMp2H/pDUhPIOW4XCZNOrqcBuzwVCA3duaHtIkjxohMHXk+OV70xay
 +jBBaHNHMiG/pdDu+V4etnO+2KzvwxRUaUvMA5IHVwxMimgu8ghSzfeGg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794501578; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:M1+4/dOM3Yp6YO2toBgJZA7BfDzr0hoywukoANrZsQfr8D3
 /8DoLHUzBG7Cq7hOMVavd8kYJ6yZs4c5MFvTFcqmfnDdpb2W5i5rqaTcAsU3PayM
 k2/fQGn6pGrgs0pz4ZIYds3vmxUC3gyEKoKX836eeBUEWwIaVOlZvm5nFEd55Ehz
 /NGqzwKE5ohyS9Xlog1GJpepHreCNxi6ew1A17R+oQJ32thW+SQ/YqL0OtDNd9AF
 799CUr8No69A//PC38VDPTMuaDAqY/NvJNCd+o8YKKQKcalIAh8nEmnt030LZVsj
 PPX4HBXbGmmU+rWC1qQCeTet3bPwPTXhk0dQ80A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
 mime-version,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:oZ9EZHPFmqLadZ7RXJvi3nMLG3Ebd8R1V4hmCgi4FJA=:V3gxg1MPXoESE0/RvSwIb4XczfNtrGgws3VeYRUuzPg=;
X-ME-Sender: <xms:yev1alPaLJhhYdSzXjug9-Sa2K5Kj1uO2CEVLbYfZY8oZPgz27lRXQ>
 <xme:yev1ajbVWaQPWQqTUAeqOz3jVe4HmNTsIfOtXtXFI991EKhNaSG1OmalTjLlo6rlA
 wlKmK0uExf0FNNAch9YKjTJu7oJvPQfqL_NTopv4DBSqCVCNkIkuZym>
X-ME-Received: <xmr:yev1anxfgZk6wdKxKoclqim6hdnztcb_370_gmgFLWCw9vhBEhQJpUNBU2rs9OE7pl7-poUrrIvHDGq_mTUDD_lg3A>
X-ME-Proxy-Cause: dmFkZTERXMn7Gjk8SjQxyqKeYahIIaUS0QifA1MgxC7Zh2gdfbz9HXxyE/HSUMZMwlXJBg
 kD34GTKLnvZZeu1hsZdcNNjXGmWfooCjaFRG1iGFZSHRUjqkVrXF9vAqqp8rd95mCPuZxl
 j07CzQByS0b/Vesh1SatnvHNwRn3/NRGN2BZomo/kfPy91TFbOaFXyjmT3gW5Aj7I62pRm
 GgT8WSs2Mur7LCXicdpQH4Sasxg7d16hWEaoCJu9rYD3E40mrHAfSIanuTRqnyfywqtPQE
 ZO2JAs8BQjGeDE+LS1S5fHI33TEL217goefacGjNLeqV8IO+Ce4hNA8/XHbwm7USqB4+kG
 2W9Y6W7K6+0NA/PiXaAKFVknmt4yTqwd4d/P5cMMJHuDRzIn7ucrH+Xz89mAGRKklsuXss
 a7R4o9hjRpHcj4ROaWAbFOyGZB+AKYm4aOB4NjOJGaVfZ9OdUTUYdNUe0FEDcokGue4QMo
 DuWdoQDSUqlLdCeh9rFmC0+GxluGmooaupI7A0meXEar3fnrsigJJ9VqNcVcvv7ilrBQLF
 nX64DQGeOAHcVIJIRg/yHjV3QgsnNi6Sz3wQjwLEzy/JUz9PPQSn7i/YwFvNRmEeZ6vC0S
 Y2vsqQX5am49209UeS7heodfeZkQo7UKnMkx8h4XLe4C2xeMqjLDX89zfhhQ
X-ME-Proxy: <xmx:yev1amL2W0E4BaHNH5b4bru5oselwnJFpWWUM4uP6GBighpqE027qA>
 <xmx:yev1apqG7jRAPdL3Qn7p6xVSgr0ZGFfXYCaSeppvVyNDNX1Q-4hnYA>
 <xmx:yev1atLVFv5DFJH4JdCCI3EsNoOmrU-2yIAW_N5xxBlGbgcSSdxHSg>
 <xmx:yev1amRzgSJPmpUEPyMbYDmbRpnVwNr4OqSlFpFUwsrkoBD8PcVjLg>
 <xmx:yuv1amQLbNOPFk5urxDwxjjLMCDOE9iwMOZwqeCjQ66kX3JuoV1v2OEK>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 11:39:36 -0500 (EST)
Date: Thu, 12 Nov 2026 17:39:34 +0100
From: Jesper Wendel Devantier <foss@defmacro.it>
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 3/3] hw/nvme: fix broadcast fdp events handling
Message-ID: <20261112173512.0-foss@defmacro.it>
In-Reply-To: <20261112-nvme-for-rc-v1-3-69b3e5dcd5c8@samsung.com>
References: <20261112-nvme-for-rc-v1-0-69b3e5dcd5c8@samsung.com>
 <20261112-nvme-for-rc-v1-3-69b3e5dcd5c8@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0, 1.0
X-Mailer: neolore
Received-SPF: pass client-ip=202.12.124.159; envelope-from=foss@defmacro.it;
 helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Thu, 12 Nov 2026 10:53:30 +0100, Klaus Jensen <its@irrelevant.dk> wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>
> The Set Features handler for the FDP Events feature asserts that a
> namespace is passed in the command because the feature is
> namespace-specific. An invalid namespace is rejected prior to reaching
> the handler, but the "broadcast nsid" (0xFFFFFFFF) is considered valid
> and causes the assert to abort QEMU.
>
> Reject it with Invalid Field in Command instead as per the
> specification.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4792
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index a0d22dacedfa..71c24dc02b67 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -6636,7 +6636,9 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
>      g_autofree uint8_t *events = NULL;
>      NvmeRuHandle *ruh = NULL;
>  
> -    assert(ns);
> +    if (!ns) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
>  
>      if (!n->subsys || !n->subsys->endgrp.fdp.enabled) {
>          return NVME_FDP_DISABLED | NVME_DNR;
>
> -- 
> 2.53.0
>
>
>

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>






