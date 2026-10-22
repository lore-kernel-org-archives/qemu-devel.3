Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A490C606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kGEQYU6i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJpdg-0003Ga-7X; Thu, 22 Oct 2026 06:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJpdd-0003FS-Hs
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:03:09 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJpdb-0004GJ-Qb
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:03:09 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b0cf2c0785so16256947b3.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 03:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792663386; cv=none;
 d=google.com; s=arc-20260327;
 b=DvBgADEBUmEwa2nuJ6ZB71oLlhN20nEgP00z8O2ZMilD5sh+Kiocu8zqcuDUsNjUe8
 B/We4R6ShZgHjbCi1b3NT3o3HlrVmSoB81jTskZA+p101IYTX7srUtDkEMX1zHud3lEw
 /FXCXGqN+8A4L7SqvEe3QBSLmtb2LpDgv0HXglmBy9PzwOX2niHcfHEFIuCokF2ncLRJ
 pgH0wUzL4jKdMJNI/C8VtaxphJPeiY66+jfiKM+aU0P3ywT/e7FfZGKRz0CUiDhm90zq
 +GiNlND5+MITMjnw3jWmTbmoialMT6soOogj4tKufUEdwZbL83TN63lK0nJcSPj/5Cu6
 OsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VQyXgmdD1qRyobtEPRICTfSuPxsKzCbE3omY8esYT2I=;
 fh=g8qcssbpofqjuqYEB1gj4ZELlUSywUEtjBwh4pQGvz8=;
 b=gKtUA7+UG3DUPq8i8pW180ETmcv2Ur3N/yh71DXp0k9pwpJ6JAqRbamxjFcJJCcwPn
 14nA5oSHkRpIhDYIX1tzh59KZ9gQWoXJ5+XpsdGHT+NWTBkIiMVBlNGzSM4zETBr+4QF
 bX7C2GkVNpAmEKxqnkzMhq5IQ4Y6bTXxgmsZvgDX+uc7BMp8bxu2y/AKVLoTDyjBS3no
 VkgA5MG88XccXuPpKMkrBcDa9k+yuOlhpIYZOXwmpBH4bX4Kf1rIN3CgMHV7Ry6nj3A7
 9VN7SNhpPd/8C73HBlxgrYTCjv15Tbtpjl6jCHKxBUX364inKj0qQfLKRVZhNRBAtW/M
 yzoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792663386; x=1793268186; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VQyXgmdD1qRyobtEPRICTfSuPxsKzCbE3omY8esYT2I=;
 b=kGEQYU6iNFl/v3o9uNx9vBbN8rdsADsYXgaqg6NYyf1GckJNmcUT0R/tvSWmBIWYt0
 uUodTq11dLNF0tGUsETggssPAr3adwrNuglAnqcNWktIxCCvGIFFfxyAX0cTX04f9NZh
 ePqR8eNvykmUYtAsE5JNpJcdfuASDcxSYbAsBhngkYayTE1WoXwZJutNZ6wEuCW9lR0/
 J/4sP73VZ+WIsBfgA/aXuR+B8Jg+t6YhazypNDRMyguv5TKOMSrRQ5mYgtRluyCIdvh8
 DorRuWpJLb+ReK6ICNnokZn9coRX/Q7qwTehSKUcIQyn7PMGwuBZQQ53DUvzIL/28mDJ
 7WjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792663386; x=1793268186;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VQyXgmdD1qRyobtEPRICTfSuPxsKzCbE3omY8esYT2I=;
 b=XIk7JZLwMgOnuA8Q15yEh4Qbm4yB15uVzAavRdUQPigENcfvNhCrFL+Z0Sv7BeyRFs
 regB6YDrR2kfH44nGgsWfzqhqKAvTwIPIvtv2x8+Ou50Q366fW8+vIbam5YDXBQ9whyo
 1hwXWlEW2CTDeaB4aOOf9LK1/Cy1E/cx/utzJCJ/RZ5a78+JSmCs5rdjDudYtzXvIAaH
 Nvzsy4p4a5xqtQ0NEgqgFuEFLL7/rUsh5wioMSowoiagTHkLjjmGvMG8z5daugprYsfR
 VwoTOSshcDFcNTSrRwWluz8KWGDr+5+bK7bzUCfmrnnum1/VxVOr4IEanVwuCFB54exE
 WZMA==
X-Forwarded-Encrypted: i=1;
 AKwUvByGBzYL/dmBheqFRnMCm/OeMKR8HLUBmc7b4Zrefl43t8CNVm943Cztl27EAb+PNpMYAY8Ok809V+hf@nongnu.org
X-Gm-Message-State: AFq9FYKuyreZO7lD80Z5XdkVYJin7cs38QLIcgKeLnAqBD/0ndDS2hMO
 8CaurjxAa1aI+E29Be/J3miMR0vWcz46Fc8O/boryLlx0W1IawCtzcoXogFE7/nn7UZg9o0XXel
 afqEizjflI/+wenQ1msoQGlWt1+DZgFINYNMmS5lMwg==
X-Gm-Gg: AYBFou2Xka4M2d9jpELzj6lxb/QS7aEGwO+RdagfGA9Yklb9lc89TXqZY1kGgRdJO8V
 0EgpajH3DxCUhs5btVp76DMhm+nhfYeXRV3vlrJQaYBfNQ5VuC28Ldf6HRxgfoOMGn/zjreKVN4
 1mTobqazxWJ3GEiNUwCflfDwsWrqLfInBOGJbJslcWpvGWR5GkHFnsVizHyHFznQrS/bZv+sEoX
 nX18fIROiTbGNuPW+kCzqn+e/zG7GoV85/v/hK54iDP0KmXntmY7LZzzscXHgJ2NS4sKpEAnls3
 qBAFC24h0tkHxypmwVZ88pQIDXQICOLeQ6cRsCl4QPtGUWv/USGwv/IqX5azAmLqLlglnAY5W84
 tGbuC3uf5A4b2hpLRS2dJtFIC2/tn8wcf5SvzULaWlgM6ar0MPsXQ7TxD1037QZ0t1azfWAVpyy
 2f0vzLTDYkLX2pkFvwhPIh
X-Received: by 2002:a05:690c:e653:b0:8b0:4f12:d36f with SMTP id
 00721157ae682-8b133fbf773mr16097787b3.52.1792663386040; Thu, 22 Oct 2026
 03:03:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019161900.3271815-1-peter.maydell@linaro.org>
In-Reply-To: <20261019161900.3271815-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Oct 2026 11:02:54 +0100
X-Gm-Features: AclHuK82WUUhfW-HJw5yGT8S5vv5fwU7PGBdk7Hi5IG_nHI3q9KMZUMvt6liVyA
Message-ID: <CAFEAcA9PxT3XGtoc6VG4Bhxx6Qb7+R+ns6+DycpZsn_YA7UkyA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/bcm2835_cprman: Treat invalid clock mux source
 select as GND
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 at 17:19, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The clock mux control registers in bcm2835_cprman have a 4 bit SRC
> field that selects the input clock source to use.  There are only 10
> valid SRC values.  Treat the invalid values as producing no clock
> output, as if the GND clock source was used or the mux was disabled.
> This avoids reading off the end of the mux->srcs[] array.
>
> Cc: qemu-stable@nongnu.org
> Fixes: fc9840850ba ("hw/misc/bcm2835_cprman: implement clock mux behaviour")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4695
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/bcm2835_cprman.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>



Applied to target-arm.next, thanks.

-- PMM

