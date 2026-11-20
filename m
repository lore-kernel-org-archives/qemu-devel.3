Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91815606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xbKDHKhm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUMYl-0001xU-2B; Fri, 20 Nov 2026 06:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUMYi-0001xE-Eh
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 06:13:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUMYf-0001Lo-Ez
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 06:13:34 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so7570165e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795173210; x=1795778010; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JnB6nPyXa3AHkTb6PkGaLhxzVpYZhdAodrXxGcl6foY=;
 b=xbKDHKhmKVQDfovBSvxNFLvQvp4BQtHJk10AUaCv0zJmh9Wi1sHmCdbNy/02Q93/JE
 J3bQGUSaGoarutUu0vHfzE/NcE9972wzT5POOg3r02cZhknIk/XM3McUQrT9zhzmTi3C
 ZvRMVwny711lGRRNhxEIij7mgorSbOmzOsDNh5hKIIQjzS8bETFblNky3OiRcsFnRB/9
 xukq3g2niZT6WfC75LfBjp9R2gozfQKeLYkZRDA6fGJrkhSjI0NBndXrwHqZV9Oljh5H
 yTqYHW6xgJMXNN0mENqjjVL08LOCV+EpkGloNxi5NrTDdkLKCmEOdf4aNkTEA3UQCCJm
 fblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795173210; x=1795778010;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JnB6nPyXa3AHkTb6PkGaLhxzVpYZhdAodrXxGcl6foY=;
 b=1HNT2mEn+RiOPTRd2KksCo4Bkivuzsi6Nc1vprK8ST0pCEpbEEzyoyrU76wNqYLMOZ
 mXxG6UituYXdX6cXh9Das/ql8FdTJTDEzVBvysHRsu2LZhwL2o4MJ4ubLjOYbmAOGYGi
 F2/avFBhoguWLlm3UcPp8Qs0Bx9XjKmOdROn3PgL1lrEP6yUgWfAAVQUQuhAaxicp0nh
 NJLHVwtFo+Zf3Yk8uoQWBGFN24ShNKJ1iX//JJ9Jv17SM6I3jB/FeuEX388I4gaBv3fl
 gw8aTS6yHwel5OzMkTXWtCjeB10h2qz2ska3Vgn+8V1MTGZTtJPjKBmxCiUsA0ankJ6b
 xmIw==
X-Gm-Message-State: APuU4Z+IR5SjrJ2XGODmXyY6MrB1qCJFM48KEh2WkTMI/zB3C5iQQ1BQ
 5FopbC5k1EoDBXfigaQoamLm9a05uyl8gNW+u0ICRVJUqk/PQk9yHruQrszbWvJ5eOo=
X-Gm-Gg: AYBFou2GBhsg6zwJ1EuoFuYeZCGzP+7fQAnJyH03shz0KzzHv1NTMUJE5eq8Lm3MkP/
 W4v97U7MrCc2UyZbesYbjw5V9ICHVfrYmV/JqOKZdkgi9PLVNynPa8OmOe1kgVXAICaCEBKrd48
 G/v6HyUxtpjIKNvPCDJa6PfnI51soNLNUIy0QBftFI7PWlQ2FvFQrpe1jWHxXifMKGWa9pSzDuE
 nFrNwAYXvZHQ/dFovqaIwfz5nBlQy8jztlUOFqajB8lL5aGwktVzUcBorkxFKAC6PI9lOYVZWVG
 mkR9pjRXbJnJDZ2p7IL/tTnDKvlLy9neC64ZXFYEU2kQu0hCyznedm2neNSloJRQhLxgsPkyavL
 XIZmASpOADIBoysJXFqf5GCZZ9a43EgUAB6hz4FAQuegLn9AAD6TuAadzaWcrzuyoCNa6ryWwct
 41Y0FRYe/b2ZFbTEnlbhkeOpuYquY9S/CHxVneiMWLTdLPOhWARf+r9O+l07I68BNZRoSDEF9Mp
 rGBZCIdSYrC1DBy4+GcCjF7iTeQ8RtyBD2IzT4bt8t2FnUi5dRrpmaJ3xl0IGkA8fGI+a94Fft9
 wOz69QqsOR+XmyXkI3aLPM5+V00s
X-Received: by 2002:a05:600c:1d29:b0:4a9:2a92:231f with SMTP id
 5b1f17b1804b1-4bb88804d4dmr66648035e9.7.1795173209767; 
 Fri, 20 Nov 2026 03:13:29 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849e598sm69252825e9.8.2026.11.20.03.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:13:28 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6FE3A5F7FE;
 Fri, 20 Nov 2026 11:13:27 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: Re: [PULL 3/6] MAINTAINERS: Step up as maintainer for PPC KVM CPUs
In-Reply-To: <20261119113207.79328-11-harshpb@linux.ibm.com> (Harsh Prateek
 Bora's message of "Thu, 19 Nov 2026 17:02:11 +0530")
References: <20261119113207.79328-8-harshpb@linux.ibm.com>
 <20261119113207.79328-11-harshpb@linux.ibm.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Fri, 20 Nov 2026 11:13:27 +0000
Message-ID: <87o6bj69ig.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Harsh Prateek Bora <harshpb@linux.ibm.com> writes:

> From: Amit Machhiwal <amachhiw@linux.ibm.com>
>
> Update entry for PPC KVM CPUs: move from Reviewer (R:) to Maintainer
> (M:) and reflect the improved coverage by changing status from
> "Odd Fixes" to "Maintained".
>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Link:
> https://lore.kernel.org/qemu-devel/20261112164617.85849-2-amachhiw@linux.=
ibm.com

You should check your tooling as these should be Message-id: tags.

> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dcfdecedcf..0492190107 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -515,9 +515,9 @@ F: tests/functional/aarch64/test_kvm.py
>=20=20
>  PPC KVM CPUs
>  M: Nicholas Piggin <npiggin@gmail.com>
> +M: Amit Machhiwal <amachhiw@linux.ibm.com>
>  R: Harsh Prateek Bora <harshpb@linux.ibm.com>
> -R: Amit Machhiwal <amachhiw@linux.ibm.com>
> -S: Odd Fixes
> +S: Maintained
>  F: target/ppc/kvm.c
>=20=20
>  S390 KVM CPUs

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

