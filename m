Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76760A262D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tW56Bil6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNpTl-0007MD-8i; Mon, 02 Nov 2026 05:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNpTf-0007Kw-Dn
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:41:23 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNpTd-0007zF-Fw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:41:22 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8ac9d666d4eso24245727b3.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 02:41:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793616080; cv=none;
 d=google.com; s=arc-20260327;
 b=UiWyYGiecS9vSYX8+u/1eeSfB0fot4rmPRmInxhZp/XjcCoSl9oM1MOrKXXY7XLETR
 FymLX9vdJ7w2vCvh1qqquLlOeQiPcCInxX4rg2a0OM7gs4rG/JYkDhklWbNEYCjOF7Tn
 xzA7MPOhcJJK555AVAlDCmYLgBMdQowtF/pRGfY4TOQ9T1tHJhvLAUMTRIPIhUagzXM5
 FzYumIfu3AfgWo2MOViny4r06u203LHnw3dryC0aS7JgDZ4e+NoRWeNU1HzZqFZT170w
 p699s0dT1x9oRGfSvZZnCrJ1mCXa/ZhGHujXdjUSkMIyV53N9/I6Tow8rV096SUF4fm6
 iyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hAcwBoMkWZWMjtmooAgTPW2AvYPjmitE50OIa5OE2r8=;
 fh=TYgLo6LSaCnSg4LxfB/cFu8QqHO9C1zPedgQPfry9ms=;
 b=N7iRNJSb3bVtINKb34r8ymuLzv/JvHY8UQlWH0n0dj/cmulIjU0OaJuj9EuoNqERUh
 b/6r7EY4oUd98Kcy98iG1rK1iC1odLHcRpzcIwyIVZz2kfRtkloavmtj9JincscKJpna
 qi+p6CB0oLoqu5QtW/Jp42Qog9qLquWsdsYXay+RX4MdiOnne0+2xc5XKbjR4cBYUOey
 P6FVpTn8bCIWCvnRgErA/2yRcvPwRddBmLMFKWqh4C5VuxdiTiLIvOjvVuyiqd3+6g8y
 o5i5u92/KrwfK9m3NgTnyjOsPzPJRFTwdlbDXiHvjMdcUU4sDVOmGrR38P1WGoVVT+G/
 HftA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793616080; x=1794220880; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hAcwBoMkWZWMjtmooAgTPW2AvYPjmitE50OIa5OE2r8=;
 b=tW56Bil6B39bW8SkXuJN5REw7R4t1FyUtXGHgBQVnOBdt50efJNDhs0FswHEHyqoh0
 /MXgue+2t3ANodoWw58+NDVurUGplEhf4eXzgHSntFaaP/tn9LTM4NymiqeLTCZMrrQp
 W0VtACfFCotpqIChmaW1Ep7QA7ShE+M659o4ZuFDrZbcH3sEfceJEGoO3Y/XkfC+UF0H
 TLStF1JI7gexOsn5N23LCTWnCHtVDpBYRM7BlW4epd/ZJ58dEcC1sFdkBd+RTpMyD92y
 Z5l77dBZWHmvkUHSBwuX85Kzk3QHpDuHVT5LbgFiOEnW1duOURjR1ipzDmeZ88K13Veg
 vCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793616080; x=1794220880;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hAcwBoMkWZWMjtmooAgTPW2AvYPjmitE50OIa5OE2r8=;
 b=rftTwb1t0fiNThMSKPYpMbP8E6M0fI9mowkKyJnaCdaI87gSk+kIlBJP7wV64E21rC
 LU8BvR7q2elXDPa2JExlK7QWZIwvY8vFke/jLYuZtS6FLaTjjjz00o8nQsHN0wA92Y+r
 2hv9gBx+h5KcHPliHhk3SLvAxprzm0KFU3iRQZwEiw86sns8T5NR+UGtrVakcckZFno3
 jaXzCie3zQsQv2+pqFHnsrdb8q4uhXWkfI/m1s7E8t8XjLC1/07Ic1euJ9wdMYSA9QW1
 5PqPpAuQyTWuhgeVO9VZ+bQj+QQirsmGux6M8U4NFICFoo6AyCfhB8OZ07TcoVWbGd2T
 KdKQ==
X-Gm-Message-State: APuU4Z8Nsn8IjUtJ61WDaPrJWZtxM+o0dStoJz/hxGv3T+HmcuWlGkWJ
 Z/X7dRCwpNAbSNSageY/Xvkuql9pAhzJTT/np6Be2Robq78QZggUd4ca71eU1aLDpEHKGpQLS3+
 /8TbHhQqKmzlhGNxx9moq1yLTdgEZYGwSiR7saFjq6Q==
X-Gm-Gg: AYBFou3X6VxyvA3+LpNl8Xdp1GReb42il+lxvZuUm6tRW7peMMZ6ehTPgbidu4RQQoC
 IayD8NgqbJgSMWDu7/4X6D96+VqMrfsivE/d7KwWTIy7ne6wxIEe2KU8RqD7QeSDmuE2+PzXeC3
 GyP5Nb8A2b4SLFZ8vSzIfZwcmrEDkZwXGybTjoqywzXzqS+/Dew4170ajk2hDdrqeEWfhikFf+I
 p3a6DQMZvOEJOjDbiVJ72s8n+5w/bTX7XozuICtpxx5DetI+bbuP1KI7Jy++xYH5OPaEJpJFx2y
 pxuIt5HZ7dF0JEwM4MTb3aqs/fybzE129gw/gAlAQRC/ShYB0lIIyZbL3Z4m7NRbsVnAhCjHIO9
 0TiQPCapBsTs12UsHjUmzlg6BzNaHnD/wkSewOS5oUNrs0BZNwohiqL78jzFL2/QSEnDqYUOIlm
 7xqRZuQH+0DxH/bhdNBUO3
X-Received: by 2002:a05:690c:c18b:b0:8b0:e8e5:923f with SMTP id
 00721157ae682-8b2b676aa68mr45656237b3.67.1793616080240; Mon, 02 Nov 2026
 02:41:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793613972.bcm2835-fixes-v1.git.lorandmarton.dev@gmail.com>
 <9c983d1ee9590f2dc2d373a4a035f1b3c1a04801.1793613972.git.lorandmarton.dev@gmail.com>
In-Reply-To: <9c983d1ee9590f2dc2d373a4a035f1b3c1a04801.1793613972.git.lorandmarton.dev@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2026 10:41:06 +0000
X-Gm-Features: AclHuK9-WZ8bBMO97M9jp7E97uGMNBR2cblMSjFM0KZbtsz3QH5HexKSg6erIyY
Message-ID: <CAFEAcA8Nz0L3mTPq3aKsgnL158GK0e6ioaZ6a4fG1YCdwrFLKQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] hw/i2c/bcm2835_i2c: update the interrupt when the
 status is cleared
To: Lorand Marton <lorandmarton.dev@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 10:18, Lorand Marton <lorandmarton.dev@gmail.com> wrote:
>
> Writing 1 to DONE, ERR or CLKT in the S register clears the bit, but
> bcm2835_i2c_write() did not recompute the interrupt, so with INTD set
> the DONE interrupt stayed raised after the guest acknowledged it.
> Linux i2c-bcm2835 clears C before it clears S and so lowers the line
> anyway; a driver that clears DONE in S and keeps INTD set took the
> interrupt again and again.
>
> Update the interrupt after the write, as the C and FIFO writes do.
>
> Test that clearing DONE lowers the interrupt.
>
> Fixes: 9cf3bc65afdb ("hw/i2c: Implement Broadcom Serial Controller (BSC)")
> Signed-off-by: Lorand Marton <lorandmarton.dev@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

