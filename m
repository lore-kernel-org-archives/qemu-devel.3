Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B65D606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MIWSzqS6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwlD-0004CS-Ng; Fri, 27 Nov 2026 09:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWwlA-00041M-Ls
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:17:08 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWwl8-0002up-PX
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:17:08 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-67db763cec7so8257934d50.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 06:17:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795789025; cv=none;
 d=google.com; s=arc-20260327;
 b=V+Htkqwy2MAmzNvSPm0sXAL1OZihVy6xPL5WcfhQ41HWNezbtK+3RkbrZEUmvJHOSI
 ylGT3yyHchRDB8nXhXwrj8CZVokZg9b7v1jBTQc6Soe6N51I3MaJQTpj6smnUtB7G1y0
 wdrdN5HcmFF4TrlzfJE/2GLfluSZIK5tDNB2sWGTW1cGyVyuiPzMqAE517rML9dDn4Rg
 ZNjqdgCxKO6haMgKwt6HfW2m4qy6Ui2JvrKBdC/RGQ50VLaeelgkSV3wofHtZWi2lObj
 glJ0Kw6kQGtIsor68LWpp6qHciXWgwDRP6TXD9BOu11VAm7Yd0Qpkn3aweCjqoyEARer
 CBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GbpEC63hqEjsFzvTM2QQbaF/x3kqLYxTdNHM//EoEpQ=;
 fh=JAgZ/zPes7161L/QPkOIUuvaLld3FzVUr9A/hsiquPE=;
 b=Od0UjqbYV4+WTHBKyvlp+I59XtRKDzQPRY4m3LbKoj0q7OZYUiW0o0rEEebMrGduaa
 cWR27xSbkPRmrs9Ny7J+AqjezyLFE09li+ddCyXOKAL9StJ7+dV8WTpqtou3IbMsMcAf
 DtkK4bOpGhH9kwBdpjHXvHimG52IQtHaDhBN076Wla3D83FLuzpCznkBdRwRGq6MCusG
 Ab7UGaVMU6xpbpoYQULabagIQJRvjD/pH0DjSoyzR3HIfqdtxDbrHfz3X/iuImVW/GKf
 RopQtkvOlTHlQ5t2TIfLfUCzVZoQRampTJ3gnmvUTTFv7RNGoqLio8YbGVwEzoXWC7DD
 kX9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795789025; x=1796393825; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GbpEC63hqEjsFzvTM2QQbaF/x3kqLYxTdNHM//EoEpQ=;
 b=MIWSzqS6fkTm0Ss12lrh6CvWbU37qeS2Jc3rlCQ5G5DAu+53Er2IzcW7fsW8ULLhEG
 +sklWR6BGuNezilnDia7Fq1CE3q+zPNlHw3SrbslBCCVoolgLahSa6vThVkoXs1MZURE
 wREVNIE7H5JEH5WjnfFc/u4tEAnddT29htuT9frEAOrYQ7YB4+GS08dt8Roj4a9csrpE
 0Pt+Ue5AOeCPPIs+YGZN3PiVm+A2BwmUGT6xK+zM5Z8cAjnEJBRd+WBKXAmvJEDDevpO
 E8wz1caS0gy2j9ypMhUCCuDQzMw7pzI0ZZNXXqGjhXm/35P0BkWoL43lZg2sTucL7ZT+
 ArNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795789025; x=1796393825;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GbpEC63hqEjsFzvTM2QQbaF/x3kqLYxTdNHM//EoEpQ=;
 b=o/zxnFJa/oNO/Iem6/O4ezgWHNf03QcPs+uxORZSQeRfp5CMU9WOAE5z5C+WF2ksf9
 WMni2/dlw59V/PB5qGCV2cyutqEQu1UzKB4SSwNfkeUFcYgCZsfFF7ZTBrlazmPtoNvD
 UsKza/WrL/Um0KGK9y2tsvKXEz7LutqKve0XXT3DSrcadcORCejW/digtbUHyVSKnc+z
 /e29YGdNgxAimdqVZ5kzIAlZvSzfmgHtI9yBaebtb+iao1Yf9BgS7ZdWLhsMWqFHz94O
 IqGdb3hTyIizu5zVc+JCrmYbM1qe5YDNpCVGooyf4D8rCvO4FJsL4TsR7yMn8LiC3rp5
 4EZQ==
X-Gm-Message-State: APuU4Z9reVud5hbqyFCEAzkFYdzrZU+uyYjijDY1YZgmhlLXRnBL8Gf3
 /LGhJFm1aXY6tKv0fj7ARqbceA619oqrvG0RIcf9ryJVEHNlbuGLnnYZEw45IOyqyVj1pqO56UK
 BCns86xGBnQ3lEXQUvfeBrt1uPXLKvgGbpncErYFeKw==
X-Gm-Gg: AZFdTZfv9FgBqvHBeJQK0ejkZSD2vHX7FrH2QmwOCSk1MochBWjmKkCzw1pSNkkMO0b
 Rs65KuXr9xAncEBXsKNpQM/khwQCzVPGF2jSGyf9uKVDKxbxQVqgiaUr2vEowxlJHknaazcdIkH
 +W6Pv/4q6sgq5ZZPZQg2cDzXznjgKcSYQNUZaD2skia8oHHQxnzEJlH4iYG06avfIAW2f0QViha
 h+yt1MK7IPbaKk3bSmHn7jg2dnyKkrTi0QMspam4txlkWS7oCXoRSNATezbnj7SgiX5awwWSkEr
 unWzZANWDkkMrfKAqbd51oDrwcwUD9/xh1EcYN6MRT0aTvo/0vp2P9TP6QQgxvp+sRcmqHHhLql
 h2mGE36HeOP30krxcQXMIKljKsI2A+yWMQ1dsav3UenWzOxflifE1bsjO+iuOSMoLe3GSVZDfpn
 5NCekAPrkyGtR1uyPRUQWT+pN45kYgH0NdYDSM5onvEw==
X-Received: by 2002:a05:690e:bc2:b0:67b:f00a:ccf3 with SMTP id
 956f58d0204a3-67df450c811mr7696288d50.140.1795789025254; Fri, 27 Nov 2026
 06:17:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124185556.81132-1-philmd@oss.qualcomm.com>
 <20261124185556.81132-3-philmd@oss.qualcomm.com>
In-Reply-To: <20261124185556.81132-3-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 14:16:53 +0000
X-Gm-Features: Aa3M54oxRpMy4dw-vP4GpSqEVD0a2kvpOISFSBJx568VF-5XuB46No15anC8VMs
Message-ID: <CAFEAcA-cCgtPvJmqnwCw7PV6EcdheXLTQxt4JT7MW5J1G7oJtw@mail.gmail.com>
Subject: Re: [PATCH-for-11.2? 2/3] hw/block/pflash_cfi01: Allow zero-count
 buffer write
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, 
 Daniel Skinstad Drabitzius <daniel.drabitzius@northern.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 18:57, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Linux's Intel CFI driver emits a zero count for a single buffered
> write (one write cycle, at any bank width). The block update buffer
> was only started for non-zero counts, so the data was rejected with
> a programming error. Enable the block update buffer for any count.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 2563be6317fa ("hw/pflash: fix block write start")
> Reported-by: Daniel Skinstad Drabitzius <daniel.drabitzius@northern.tech>
> Suggested-by: Daniel Skinstad Drabitzius <daniel.drabitzius@northern.tech=
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4111
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/block/pflash_cfi01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 78cb221ddab0..72c544dee8d2 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -605,7 +605,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>          switch (pfl->cmd) {
>          case 0xe8: /* Block write */
>              /* FIXME check @offset, @width */
> -            if (pfl->blk_offset =3D=3D -1 && pfl->counter) {
> +            if (pfl->blk_offset =3D=3D -1) {
>                  pflash_blk_write_start(pfl, offset);
>              }
>              if (!pfl->ro && (pfl->blk_offset !=3D -1)) {
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

