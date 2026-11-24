Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4341606A33A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=b45Blk7W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVxY9-0004lE-7K; Tue, 24 Nov 2026 15:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVxY4-0004dE-8e
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:55:35 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVxY2-0007TN-JX
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:55:31 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b4e04eda5aso37435107b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:55:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795553729; cv=none;
 d=google.com; s=arc-20260327;
 b=ajxgcaIGAikB2vip/LDalnN6rJkq+LnirEU5ZcyN2jJjtThSUs6t9R/MmcuD7N0g3b
 3SZggNgw9durzK0oCQ25WpSF7wEZ79LZdMk4kSiC65lH2jrfNU5dxaA5aD6QeA1mHgep
 BDK6ve+/S9+tnP+VV64Y/domau/ft3TIU19rY16ZJRcmqvKOrXZQCuAP+XP0LZtavmrC
 TJgMCS998ctrDnVzhRyUVsnCs4r3+6VYa0Ir5Cal6WJWIa26TNep20fEwnMuqTbuB9kl
 Z6aS2H9FJjz3KZyAwDMr7HCfDYEO2fB7yTtURbR+qOix+keBTp2SHlYEvs1k+3NZguqO
 tBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0UBlr6DoDDKoy+dInE9F8I2YxdB1ES29R4ivX400hsg=;
 fh=2Mdtv09fAjaPEKJ3rKz3+nYnGXvITfBX+bn2+Td7YQc=;
 b=hSeGIsqcpeT+ETwxDYkmHNXl4W+GQY4eAMMT5/ooQPplA7IjTIEsUQktkoXvR2BSOr
 EgymnJBILykmZ2NpQYww17ePcacUdmYCVkWAw2S/7/19fUKjQ0ivPHOCu6FVsgV9U6j7
 vK1tbOyJ0EQpF6+flLwDQG3EmEOZQBgUJb1ezVHlPbWOz44rtu9W6GVgXnA9VN2v2Gyh
 vYrrR0I3pMq5ahT2lXGdbFplLUJvnHPwGJWGpZZU5JwNpQShAfR0XDOmAw5CI6inz9yx
 lmhtd5XFmmFSycTfu/nNX8C7rPUIOLnwrlL5HtlhJwAmEYKtyu45pcOrscGl+6Yxfzfp
 lqNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795553729; x=1796158529; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0UBlr6DoDDKoy+dInE9F8I2YxdB1ES29R4ivX400hsg=;
 b=b45Blk7WoL7prOmzf3+iaDy+eqYBFRJMlugecOsbikprxGDIUXJGvGBTP929t6EiSO
 hfbEzjU8j7iRTkHi2WPeYFUUWKfjJoG8otasnRa0/+O2fS/OxLYURV6U0N8zscFxhkVq
 HVwbPVuHQdS0FPsjKQ62OY8E8rKxTHmwIrYMJdxTWGK/RsYsEI8q58q8WOzW86sdJ2m9
 5l4qjFowjM3S0N6WJRg9NVexS0RP4Q3+e66uiduioprpf5BB+JpEJwuiRS0MYP0nbuPj
 av2CUwNoP7SGWfyvs85MVcEOwh1sxTFKKH9HYB31K03NswK2ItqXH2pq+e6QYdYNw1V7
 ArJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795553729; x=1796158529;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0UBlr6DoDDKoy+dInE9F8I2YxdB1ES29R4ivX400hsg=;
 b=LfUvrXOa/qSxy4Jjy8eJdq2AcvtI+oQzAs6lqvDo0Y9DUnoyaVyoCeQAZ2lYgLse7P
 79GlL4N/ApgGGysxV3JQ70cRg1qj6WRaN0F4xvQrknj2hsprxyM5p1LeGelm/rGbC+b7
 AVcEDzfiX2RIhXM3mchY+V/4T9A/LKFzHECrByMDY+f6vOYEwOzbhEQBPQ9iGGtC+XlS
 CECJb8aCTu4z+pQc4D+RqnFU3nGPHssMfCfzqUNauYgiTTorRk3jVQlcx42i/Vr0wd0A
 ShtOpA1GwoiwoaI9JQ32w/qy2SahZkwqFoDCnsdkPYEqFUvGbZTcrMsa21NOdXNaMIGP
 GHxQ==
X-Gm-Message-State: APuU4Z8PJBwrJy7P3tm3quNTpqB/awpUzuKwBFW11xj20oSE/Imp8jhS
 udXVxOZjhg862KZWzouJAr2baIFRYs7cfrO4Um6CVZ7FN7U1NzTLgiQCONQ+pCK1MRZoIWMf2dt
 1kwH8KRN4lXmCILOlbnU3OI63rbm1tGyZrmjtFXA8eQ==
X-Gm-Gg: AZFdTZeKA8DSooa6ei8xtHFdOavz7R0Fiidi4mReXOFwfuDNWOJP2lLcI6QQ4qIvRmR
 ntoFZQnTImbJtlo/joVWWrJwtkDp4Gfux8k8p/rG31S5mObT4ZIPmszSpkjS8RjZJIhMZTqdaI2
 aeJGyph7WZr0hvPZ1/7PxlDrB7gIyjg8sJCFPo8H6W4H3ZQoQLWPLHbkc6lpfw6J1xXmUlxuN+3
 WNUOtaVjohxBSEtJ0/MmW0EUoxDUci7aDBhAdvmC9+eWiBT/kLjNm3UFr2UTI/FZReTC20b83sa
 PCi+qjkfe9gsj9R+sJEMS91FSSvgjcDUQ3xHXXG8bhx+DiH9nYJ3D2VDE1S0LIgz9PbJZ5+x1+c
 VGotbk3CaqW0ZOwyYRvi47/5juTHEHwH2kVO8sWNtiK/dY0Ifaqf6zQiNO9WOTn/hPdl3NZ6+dS
 dyXfbprFMpAGCRZNEFfDgh
X-Received: by 2002:a05:690e:150a:b0:67d:ba55:4be2 with SMTP id
 956f58d0204a3-67df448c8acmr7358001d50.84.1795553728903; Tue, 24 Nov 2026
 12:55:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124185556.81132-1-philmd@oss.qualcomm.com>
 <20261124185556.81132-2-philmd@oss.qualcomm.com>
In-Reply-To: <20261124185556.81132-2-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 20:55:17 +0000
X-Gm-Features: Aa3M54rnmCSXfb0aVuecGdw_m4LQOchF5XPV_Z954E0YqhmEKMdbQczicqH3SEU
Message-ID: <CAFEAcA_+xFaBa1MhSa4caycYEhvC4-P3WcUoG7u3x1HVpneAXw@mail.gmail.com>
Subject: Re: [PATCH-for-11.2? 1/3] hw/block/pflash_cfi01: Register VM change
 handler once
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, 
 Wang Jianqiang <wjq.sec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 18:56, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Each pflash_post_load() added a VM change-state handler and
> overwrote pfl->vmstate. Loading twice before the VM resumes
> left the first entry on the list, and resuming then ran a
> freed entry. Register the handler only when none is held.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 90c647db8d59 ("Fix pflash migration")
> Reported-by: Wang Jianqiang <wjq.sec@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2635
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/block/pflash_cfi01.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 486fc6350d85..78cb221ddab0 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -1039,7 +1039,8 @@ static int pflash_post_load(void *opaque, int versi=
on_id)
>          memory_region_rom_device_set_romd(&pfl->mem, false);
>      }
>
> -    if (!pfl->ro) {
> +    /* A second load before the VM resumes must not add a duplicate entr=
y */
> +    if (!pfl->ro && !pfl->vmstate) {
>          pfl->vmstate =3D qemu_add_vm_change_state_handler(postload_updat=
e_cb,
>                                                          pfl);
>      }

It's a bit surprising to me that this needs the double-guard (by
which I mean that I wouldn't have noticed the bug in code review).
I guess state-change handlers are one of the few things that aren't
cleared back to "state at start of simulation" by a reset.

Mostly this function gets called in realize or init functions that
are definitely called-once. But we have a few other uses in
post_load hooks that have this same bug:

 * hw/block/pflash_cfi02.c
 * hw/misc/mac_via.c
 * hw/ppc/spapr.c

(round of applause to hw/i386/vapic.c, which is the lone user of
the function in post_load that does get this correct.)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

