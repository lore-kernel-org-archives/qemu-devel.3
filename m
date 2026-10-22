Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01EE606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nHT58z7H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrUW-0005lD-CX; Thu, 22 Oct 2026 08:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xJrUM-0005jT-Qh
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:01:44 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xJrUK-0000wf-Mq
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:01:42 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b3dd83e779so3073169a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792670497; x=1793275297; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vEAJJiibtECHIdFJL+AvHw+zcl0sKWHWkW53grohAYQ=;
 b=nHT58z7H+lUAkJ+y4Bnnu7CNtcB+866RxIsbjRMzuAo8AgPATrQ3j3UvxPKDH3BXdu
 aYuL2Juathb6Bd33Bz9oDheQJaVn64JdY3WhNZ7oHW+IO/eBcLqownpjuvw/6JsIX20O
 ZKr0Zl40j6bCqQIiwgIZM+kovDHPoD6P+Cu84VB8nOyrLOgIHlDoGGjX1Cklb5b0Ig15
 qeLvy/kl0IH6CDbu1fDSFectfdA5tzr+AFNQYQn8+dGCvlYH7oYzsj08xk0GPdIlwPwH
 9pY6/HSoITjob9FdvblPcCaagOIHGx5c/rzBMDzpsN/6SIHU7tZh/NHtt5xBBY7gsFvr
 IaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792670497; x=1793275297;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vEAJJiibtECHIdFJL+AvHw+zcl0sKWHWkW53grohAYQ=;
 b=wHs1hYzGiKzBLI6MaJqaJeTMKbi9oCX37bxDieguuOPL5ejRjlyWjZL+K+T+TEPyJE
 kGdIKqAs/eD9TliF921aYYzxKyHRWEFIPt2BOI0xeYQiEuv2F5lo4YZ2doCRQJQFTv1K
 3ZbLLXA+fyy5eGosoPxDfL7VT7Jo+R3NhPAvmLpmCcE1nQpHycj+szXSb8HsNvwNTEvS
 sTjDxWaoHlTkCRl/80T4Xe/oJ6EhaOWc+Dl4hxpBibmXuMINmeQYoY7dRVgoGxvYgtUm
 p4voRWXzMqU+lnuhXl0WnUkzO4xeomOmdsaa+lamiRJgyBoptFFdQhbeEmjRwFSefB40
 dC2Q==
X-Gm-Message-State: AFq9FYKyApIaK2Z95f2vO2mEr6wV/EneOsqzU67L5yXkPbGtU2oY7oaS
 roshLc2D6E8pAT3xhLIScQ/NE06h6zncwsqCp2bC9qgQ8UOTZaPFCwYBwVFYf2Lk
X-Gm-Gg: AYBFou0USArGeED4ioiUl/A7seVEoTJ4svAyF12a65qb7ubb1w0sxVhu65c/w7LnJbd
 8Ch1KlBh1C34BS7N14XJJDEr2LFI+076aWHhQ4W7YXnLqKFwaOQvgZm36BoSH++ecz9yPirJSgP
 sr6OJbwYIiQWGtiJIEcp6DPBx0tsUX+6Sv3Ia9yDGJqP8TzQ525+cWSUL3jYZq8OR5ZmQAxNJ9y
 RPMMwdWtHKJIW8DQgba/kYPeanfO0NE9n7KmjsDSZlnAH2Rm4RzHQIpiRbtGnoQ6letDoPnzEyE
 t/ekmVxTN+zt/e9TD58QCyNDAyiND3Q9GgRCXbQAllYHOAUoOPTA0RFkqXBDPAAqN4/qlvmtr3t
 kr8unUFBWf05aZc4g4NyEhABrKv8FR/m1ivsZsokF4IuPTSbPMpGgfMtqYaPekMgPm/u3eEuFik
 lOoSH6E3wao6zvaYbJOgloRyG7an7/E6reY4VWiNbWZ+Z2B2KLoR+MfZdR9mzsykVLMuF2iV/NM
 0fKfPvVn45V3Ik9p5ylGCaMhR943oYOdsiW2ugNAU2Ttx6CUxgNzrSAOrMvSSpI9mJkgEbWNmCL
 9nHOffOTRQGCvhr+ZnMsAvBIZdWALhFzfz36OU0UwbUXpW8M8qzh6tglNN3tdYUgGW60S5BcStk
 =
X-Received: by 2002:a17:907:c22:b0:c2e:893:7010 with SMTP id
 a640c23a62f3a-c467976d92amr454263966b.37.1792670496627; 
 Thu, 22 Oct 2026 05:01:36 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-25f6-628e-6064-de9b.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:25f6:628e:6064:de9b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c468a59689bsm96871066b.48.2026.10.22.05.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:01:36 -0700 (PDT)
Date: Thu, 22 Oct 2026 14:01:04 +0200
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2] tests/unit/test-qga: enable on FreeBSD
Message-ID: <atn7ALZqDJw7bGjU@tulp>
References: <20260929150100.66035-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929150100.66035-1-bogorodskiy@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Roman Bogorodskiy wrote:

> FreeBSD has all necessary commands implemented,
> so enable test-qga for it.
> 
> Requires only minimal portability fixes for sockets
> in connect_qga().
> 
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
> Changes since v1:
> 
>  - Drop SUN_LEN() for 'len' calculation on FreeBSD,
>    use 'len = sizeof(remote)' on all platforms.
> 
>  tests/unit/meson.build | 2 +-
>  tests/unit/test-qga.c  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

ping?

