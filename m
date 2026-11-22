Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B825E606A320
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RDsp0IP1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV3nY-0005F2-W6; Sun, 22 Nov 2026 04:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xV3nU-0005EM-KC
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:23:45 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xV3nT-0006iT-3v
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:23:44 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b4e2fcc300so19134157b3.2
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 01:23:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795339421; cv=none;
 d=google.com; s=arc-20260327;
 b=OTtWj/P3GOz8Bt+VpZTX7i0TrJOF64kI44OHDNPx6TTlsze9FPO9niSblD1U12hgDF
 e4usDGh63XgNIGQ8AjMlPeQ/IqoLms6ifuVLXThHBUwuXyq/iIU2iyLXjGoElnnScajE
 FsSPwlQ5LESZIzqkUHiViZ+DuUY3V/qSb+qISnWXr3ry+b7XXUVDnKbkjtj+MEfmEdrr
 D/4IyNNUb03qONf6/W+2/Zt+GF/wLn/EC+2CH+rriY17uB9+M3opb8Dag4Ryapo2Zb+o
 iB7f0idLg7AQIliKNPVh09epSu7HkFoKIvZFvi4jWfKcuqGFoc0WOIh73G/FKUr8NQYG
 BlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5gnnsNywiSofMO7wLuiIvFpv5OuikOC1DdEsDbrD8PM=;
 fh=FEnsPW1+Jeui4H3TY0+cybeCikFuKHWTt4JZ8F3LATM=;
 b=ar79htEl2s2eutbMbRcK+2BoliHqzaFhPC/YJ9g3PAnYLFtX3gCXclcBNPzyeXjiDv
 b7GzZ1qCLOSKyaSZISoOjYvDv2tWLhzU82DN7Dx96VwmMlE5mtCv5Vt9dHVFD4f3DlY8
 FzzZ9ndX06FiG5uWWenjsK0Kc0EtE1eKgRiUHwgZVKv65rExFkggL9IWlOY0ZhvK72vI
 JdGu8A9wMlvasEverO53hIrz0nfsCvT5y5M/px6RT2R5jCjtpQ/y4kx/GTPi1fq+dIKe
 JRMY5IogWvCrDj5oQqoZ58RA+VQH4gFp1SPeue3cZ4ljQ3d058ranTDGibtjFa8804GD
 WvCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795339421; x=1795944221; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5gnnsNywiSofMO7wLuiIvFpv5OuikOC1DdEsDbrD8PM=;
 b=RDsp0IP1DPUZHAYaaOuRur9AAbM9U48f1XaafQFmmRbY8k4L6oUC9VNh7gOR5tNoLH
 mHRL7UlA8QlqN4YaFuXwIMzn5dRcx5UPzQUI7/RXSpCFb521EvSBpXO8CPE6WAP/yH+o
 xqQGFEy/DaGrfsG/udOPf3TiM2UjsuqmKBS5iDRrukoSQu2bGFK9aa+WtjMVVo2ylhoy
 9g7kJtaW/6uMKoGigj4YdwrUfhyRma1uyVT0qP8JRj86ZjVGsiMz2Q6gsCPz3dk9bGzd
 3M9eIEOyChaRzr/Y0JVgO8pXPfqfMu3aJnwJbudElp0f9EBhHf1z+UqpO38bjT+x9Hqy
 OLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795339421; x=1795944221;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5gnnsNywiSofMO7wLuiIvFpv5OuikOC1DdEsDbrD8PM=;
 b=Z5RC5dZzrfZ4fD8Qk5dJlwSiHkmR2SWF32TUU9Z8ScWTxYFvzN3lHmfBtxswWKC4E3
 K5oUqNdsy6NZWwPdxVKnT3MyzEhU+uO1MFUIPdm/AEZGTVnvJYkubqsYa2V32OQRLySB
 H49bTbRK7SUzpSGbGS44w9p2692qWRq8dSI1uu9j1Rb0ld2G7K5U8PAF7dOIqYr80ym0
 w1g/byfuRSKSx68WwG8A285mZjzHB76AKHy8BdCUBovT8BtMu8KnyWyJw+UVggXZrEr9
 TlQyLJlOQ2Myou/qBSInbGlniSq6gJWLn9KgPeuFS1iQihqz+MogPlwE1kzCjcWV8xsG
 lC5w==
X-Gm-Message-State: APuU4Z+OUFqL0YUJy49/2OhibmJQWqWdwLRGWX9//ZdRG8KELuvBoWsK
 aHIGnV/TERTCrgX/47eAhWIa1QWf+hIISMWe6mVYQZBrQdXujVFsrtJMbBWF0t7Kd3uUBf0xHLr
 5jMHmnR3OfnjaHZ1wmEzJ1YNvYZGGPYiGJPnXeNbADA==
X-Gm-Gg: AZFdTZfUrm6u7k5qfIpxukytRlTKfsOFeZwXB73tHh0rjAzg6ZRXpNJHeSN9ySUsHzs
 T/UBEG2BK+M3ChTBvDEVU/PyhgIV7VkbUzr367/E/inRlrxYwohZh+ZaVP268G8dVGxyTl6HLPe
 XZPx0iNMpdSQTQxyarv33+XwxwCALJjskL9rFlbyP+9W9yp0G7NQk1b1A3lpeTjtquQyJfkQfmD
 GSf+PlvhK3rXW1mZAgTumbv3ny2XFIaKCOGDqGcGyatiCs/hz8GsRef2bcDo6QNliyFE7PDGBLa
 IobV9vZZLzzzlxyLS+K6OAdckeCOqAshZHEkHKv8uvtc0z7WPxVqM75Whqf5Op8ih3sEg93Kyb7
 Rzd72Do6bUNfb2i8EaCLL7zDm2OuUGEDRbe79UCnHHU1NfjUBN1XMB1U6KwRfXCCaLaYAM3Bod6
 E4g+NOZpPIqzNPN5evl99X
X-Received: by 2002:a05:690c:6b0b:b0:8b4:c35e:5fe3 with SMTP id
 00721157ae682-8b520498199mr31107577b3.46.1795339420820; Sun, 22 Nov 2026
 01:23:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120143453.1998949-1-farosas@suse.de>
In-Reply-To: <20261120143453.1998949-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 22 Nov 2026 09:23:29 +0000
X-Gm-Features: Aa3M54qtNzi7GKIQJRWRCw3H0QmK4IwG1yrgvvJUSn9JcoQVODtLGjXj1Qmnozc
Message-ID: <CAFEAcA_KuTApe-Rozy4KhCdeTiw=EYazc_7UOqHrSwYWU1oTQw@mail.gmail.com>
Subject: Re: [PATCH] docs: migration: Clarify the security posture
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Fri, 20 Nov 2026 at 14:35, Fabiano Rosas <farosas@suse.de> wrote:
>
> We have documented[0] the scenarios in which a migration bug is
> considered for a security vulnerability but some ambiguity still
> remains, mostly because of the mention of live migration in the
> untrusted entities list. Remove that mention and expand the "Security
> boundary scope" and "Sensitive configurations" sections with migration
> content.
>
> 0 - commit 8b6405a493a ("docs: Add security considerations for migration")
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/system/security.rst | 39 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/docs/system/security.rst b/docs/system/security.rst
> index c0254fef113..a41b84ea70d 100644
> --- a/docs/system/security.rst
> +++ b/docs/system/security.rst
> @@ -28,7 +28,7 @@ malicious:
>
>  - Guest
>  - User-facing interfaces (e.g. VNC, SPICE, WebSocket)
> -- Network protocols (e.g. NBD, live migration)
> +- Network protocols (e.g. NBD)
>  - User-supplied files (e.g. disk images, kernels, device trees)
>  - Passthrough devices (e.g. PCI, USB)
>
> @@ -136,12 +136,17 @@ an issue as a normal bug.
>  * **migration/snapshots**. Migration failures and snapshot load
>    failures are considered part of normal operation as long as the
>    source virtual machine and savevm file, respectively, are still
> -  functional. Aborting the QEMU process at the migration/snapshot
> -  destination is similarly not considered a security issue. The
> -  migration stream is assumed to be secure as long as the design
> -  principles described in the Architecture section are held, in
> -  which case plain manipulation of the stream is not considered as
> -  an attack vector.
> +  functional.
> +  Aborts, crashes or misbehaviour of the destination QEMU due to an
> +  externally manipulated migration stream are bugs, but not security
> +  issues. The user must deploy QEMU following the design principles
> +  described in the Architecture section to ensure that the migration
> +  stream is not compromised. Manipulation of a plain-text stream is
> +  not considered to be an attack vector.
> +  A crash of the destination QEMU that can be triggered by a guest
> +  manipulating a device on the source QEMU before or during a
> +  migration may be a security issue, if it meets the other documented
> +  criteria for security issues.

Personally I thought that making this three sub bullet points
(splitting "normal" from "bug" from "maybe security issue")
was clearer than having it be a single paragraph of text.

thanks
-- PMM

