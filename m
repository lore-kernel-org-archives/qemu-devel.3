Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0893606A332
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Rpsc5FF9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3MV-0001On-LJ; Mon, 16 Nov 2026 15:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xT3Kn-000802-2V
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:29:49 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xT3Kl-0001i7-5Y
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:29:48 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-675617e81f9so4099584d50.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:29:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794860986; cv=none;
 d=google.com; s=arc-20260327;
 b=G6etPp3OUTmu/MC9iK9jCz4g6RbpXV1glIntFhR/wHpWpOTDzmuG8leKy/UD07Af/q
 HLYKokkpMcGPMRbZL7C/5DqS9KBkWe5vnPYgq+zjU2iAX3FVMgFNGztS4MQkyPO2KeCW
 WHNbtdNkIwUHgI6gDe+3EuqYQ9s6V/1vvny96P1fA/tDHxe8ZgXtFmIZEa6U5DhWcNiK
 7CEtu+l5gTr7LE7XZc115xUqMFHIZNeDNGDQ55ERKBLJEAtWBVwtALHi2yECIG2OA2Om
 MN+5by0cE0TmgQaxSaYhLkBvi3UtMdKNtizhZ4P5H4WHCIYXmhVOvSyinZriZhNvBMB5
 JuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Di/Co25TOMnCoLBddZarc9fTvAM8rnUwb2zZVhmiqAo=;
 fh=Z0Hw1uQhdJSwbvRV9kqOuue3cpAZhnadh1EaqfLZDQs=;
 b=Po0NVxMlLuvzlM27J2gFuYvAl5zd6ppH5V+2gxy7Tp49zVBQMHXxRjNPiMPJFxWfkv
 cKtAwIHB36aZ8FR1J77uW4ROAv02EDa2yJonhoIgO+wPBHmxGeEQuaJ3KbWRT1zp/eG2
 bo7FOY06nx0k6csfhwwhLXR+lb2qhHwIRYwdiTBQhAm5GWfOfD8sEO0TpMYrNMpqBdYO
 4Hq0MW0dq8RvZvR/ncMjTXlHlqFEPy9BRt3F40kWrIR46SU+SX6Y29ys7bNa5pPAM1rt
 ObeOyG1ktOdVKJ/vQM/Atb6vePp/bycjPVowbiSQyPbK3AJkto3dpygDKzgUKicoR5JI
 gOMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794860986; x=1795465786; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Di/Co25TOMnCoLBddZarc9fTvAM8rnUwb2zZVhmiqAo=;
 b=Rpsc5FF9p4WWGLGvEdUYiMbLZJz0HYdObM0SSYzzdb+poO3Dd5jkvdDcl3F1lcvA/j
 BVfnuad3XEJM5JFsRtkbRxti+c12swM9dVn+a5LxVeCk8wwrr3EkgGYvuj3q4qD9fYQm
 +gYDCQ6mcPFKj6ZzyfrmA8cMqPq3O/gUM00LSMKfQalmrzMfzWtWS0qGPccGFyVI3Gpv
 H2b8FgGMFhdD/s3/9ElhTiD2gGiD+sRZVTWg03USKm/aoC/F3Q5O131f/4UVYa2/vprt
 xMLTRMiXnkAw8sdeEfdQ6flaqQVRZdMJFLZuzT9fmlCYfC112m65EpfcxQQP1rfY3hVW
 dVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794860986; x=1795465786;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Di/Co25TOMnCoLBddZarc9fTvAM8rnUwb2zZVhmiqAo=;
 b=KMd4LX7BZbcLSb/72iLiFKEaVz++24Q537NTON1YqOPExsTngq9rRmcrh+B80m9rYN
 NCjgNmlws3fmwc36wZ6RMHFKmIXkT//ciQBpgez73FaeRIq5PtqFtc5wDU8jUuniYImb
 IdMMMEWCe1Y/niE0bkLkLSEhPEmuAnkvDgQtDxdCOsJT7ZSp3dAzMSh6eyPHTk99Owmj
 1e03lrQutO6h3Xzhq6+aJaOE8k8uEss/+vdhPzWvD8DEWxUlW+rvWjirmYjKHkI7MEzk
 MDXqapohAwxr9VUGgk4k4T/mzAjxUd8SAYzy6V+ESxynacEwWqLF94Qq4bW4lJVRc2Dp
 creg==
X-Gm-Message-State: APuU4Z9boNVbBjKznK2YCS54ZIlnQfZ95ntH8zxFge5AC9iA54HT2mBU
 d+3DpVU2L//M20pxc8jJrVCXwWMWioIbZAqV6A68wWVxKZCKsKjoptFMJc/vtxz2RAsWak2Mbz2
 Csoipil1LiMfCtLcBAzve652Kj70AbRTaGzofXv2ctuqJ/3jgeFxShyA=
X-Gm-Gg: AZFdTZcMNSIRm2bZuhOHGfsgXmeEr+IcQFjgqeAZyzxgSwQgcHQcxfDjhZegx7vzvnl
 YR+aOfyyBFMW5JzKmDfoXNBW4lUBa8nmjXweIVtXJF14o3FRrP6TtLgalDIrN+lwpgskbledPVi
 Bs0PveIv1zkjxytLQDNeelBrJ/Um5zE1FlK764M1Qf7+Y6fdSBC7vi8YPOW6tMnFZDfuOQCPm9L
 zmWOv9TGMEpdR3z1DlmDaX6scevuVtfmQ2LBeD2n1R0N9x0VlGPicJt7inLs5Y07TiUNqBqrBW9
 y8+RYWqQ3kvZknEfjXw2bavz5MNafYoUniWr/LhIvmAraHPXrhYkGcAzr8EjMhFFjhSAv5QIQC4
 g0OxYg2TSlgz5HiyUyZQtE6qhsjmtWIzC8FBvPnltWky1sf0wxXZDPP3PahxuwY4Ah3iuY84Uf3
 e4DJbMnR0MPSzTlgjx+KGnPb27Nn6WWVT6FhlDw9xnBw==
X-Received: by 2002:a05:690e:1287:b0:67d:a096:d8b7 with SMTP id
 956f58d0204a3-67da096daffmr4535989d50.3.1794860985653; Mon, 16 Nov 2026
 12:29:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Nov 2026 20:29:33 +0000
X-Gm-Features: AclHuK-yp3Q11H5MBWsrprssvqUxiFHcq2YddMZEht1-44lEBppstnNPi6-l20Q
Message-ID: <CAFEAcA-LG0yvbbOW3UyvitEHAXAq9C5Nos+Ac6k92e+aWA6MVA@mail.gmail.com>
Subject: Re: [Stable-10.0.16 00/59] Patch Round-up for stable 10.0.16, freeze
 on 2026-11-26
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 at 20:25, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> The following patches are queued for QEMU stable v10.0.16:
>
>   https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0
>
> Patch freeze is 2026-11-26, and the release is planned for 2026-11-28:
>
>   https://wiki.qemu.org/Planning/10.0
>
> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should (or shouldn't) be included in the release.

I think the net/ fixes that are in my target-arm pullreq are
worth putting into stable (they should have cc tags); they ought
to make it into master within a few days.

thanks
-- PMM

