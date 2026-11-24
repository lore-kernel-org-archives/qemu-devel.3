Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E94606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M4xkJstD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVpS7-0004U0-Sc; Tue, 24 Nov 2026 07:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVpRl-0004QW-MQ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:16:31 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVpRj-0002wb-Hh
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:16:29 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b4cc793704so32112407b3.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 04:16:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795522586; cv=none;
 d=google.com; s=arc-20260327;
 b=k/FgDw/oOwI2m+nzjzrH3cs8tmCA6CY8D+YSkGJ6hcqcwEYydnz593ES89S0a7p20y
 CvoAXWWWeueus8iyvFfz01knu46quDrpHKUUar9ti+ZQjuD6ca1MGO4mX8OREqX9JRvv
 xGliVzaDqrlVRKyWi56CWdVUcIh/B+03ERYqi9OkxAHKIpNxU19pObuMDUw69zk8+f9v
 TTEpgNdEuC7wVSk5U7P5Q8DFg2HYriV7M6uIAjS26QiWKt3gnt5Q7CIRV+w4nudR6mlC
 dLttlZeD3X8gIMLSNijrxV+uxcTFwh3fJB7wX41ml08DHg/Yh+RUwgD2oToDx/qeLpXl
 rhRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XyU6eJLDQzieLof/AMIWNkRru3RQ6oui8OzFTEUxLWw=;
 fh=kjIIHBxOc2+eheqJ3UOmUVeT86hj4XqWJtrPoTu5ZIs=;
 b=rk8RW5yEmtKF4tUQhhyCv8jx/BwIwm4uRLvowtE8fUNMjfdmn+jFQqblQKVgeLjMXN
 mg83PCxMIE84bkmOmLSW8xnEdq5UlRg+KHvxC00LpVNuSb3EFneRxlwRyB/yP2pVX5hw
 X05LyXU8ytCMWz3vM76vGj43CVhajiZnGTTE76dBO3Y2X5OjY6ij66SwuTutYl8TAzUn
 76r68ALmwb4fgtkWb1/t6LYNihz7+9zPeVOh5c76tZXpqUM/u4l2hmP2uFd03FIIpY+H
 vHruA3Gjgbb0q/ybo5YrVbJjTXKfCls0t5daKZ+IoTnbyLMpyWuhdVdCRBcwWbthaHgF
 miWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795522586; x=1796127386; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XyU6eJLDQzieLof/AMIWNkRru3RQ6oui8OzFTEUxLWw=;
 b=M4xkJstDzH+l2ZpUXKdIwGAp04LoypBnqVDOzrN4UadOkY0reXWXomFCyDt6QQYBky
 KyzKULzOrknj2h2Jj1J31wDeql4UPTIHg973rMFknnnMWoMZhARRYgKkxt0L1w/KbELG
 d7mpMQ5Ac88rX2pQU/eV6Q81RyglmN+K04JsDmzjbN8qu0904NacaVTJEl/B2LGDh9M4
 J2mFX6mMvUuDnrL+H/D3aE//IUXTS+5ZKQ9Fx0i2rgpJJXzY22ADcTBDs4F61fgs210g
 YCR9bHComK/zDPhx+qZ10LcWYKIqHEL+1NpWLjK2wMzwJpUI1/+vDKRvN32pq3kV5prw
 ffbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795522586; x=1796127386;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XyU6eJLDQzieLof/AMIWNkRru3RQ6oui8OzFTEUxLWw=;
 b=bgVeLO7gijX7MWvauTBaYTSYWMl1QClApRZn/e30Xtfm3Yr9oT4yziifxqriKt03lF
 boaxGUGHQlJ2z/lZZk98l1sbUxqj+LaKdzDypBNTgr9KrTsvu/k3y1XrD5n8ZkPp/2nu
 R9OKiy7SGAEqqINEloTfUCPcm4AOnvvJBv65gxgg2v1mvvJEmOvtwF98f3nGJlo0/HID
 Iq78UbJShs42y7WDyfFyBkORGbCTkLlwKw/D528oMnpOT/ohARfXDGWhdXH1h3B5TeUo
 4Midg7Kz1/OHYYR7h/BG5qt7xwkq2RewO1aEtY49iMFTjUH4aS06ivNbJU8PxvmAuykM
 Cb7g==
X-Gm-Message-State: APuU4Z/vdHdkEF0mmhdAVfZv36F8Gl0sMKlXKPg4HDsPhDbPEFpv4e+Y
 g8TsuLUJ9VnhPLtd94VuG6ZCGNkvYsOKE4VnTV8PZ5yxAON0BT/mimjGhlrzsmYdAHG2lJtp2PM
 W1d3fIwQEriwElOTkZNLXzUanbRKWlWu9oLDKsh7uNw==
X-Gm-Gg: AZFdTZczNJqQmsIDOvPIavLdcZ1AwPs3lNJobi9/A9elqB8CftVpEHHU0v6TI6QgziG
 tABEIhcdU693E/x/ipZisnMXP1sXhdZnPbsmjk/ZX0gkYoyy/34/VlNe43M5V5XcTxS4vp91TMN
 A3+u/eSfpnMFdJ2GQWYLAxAxWVdGu+qHm956jzvxeAvS2Dees9FTUdMZw8TXg0m7ryClNMIelpC
 eiSTMpF2UYdmEi55Ih7zoWpJlvLAh1bwYtD/cMOSrD5NQR+EuzCd2ZeRQLviXosa8HMZGQzXyZ0
 6rwPINCzFmw9I9Cga59S6zEoAD6koEv7SKllDmt1LE7UJU1/dbg1v5zrxDCAuWdlKL10gER9ZF3
 ZSAx+9TI627naTsKoLWk1ScRj0sxx28PX/snvAKqcHp7NOVgESntC1k0I2Gtlz2KfUU8fgr1zAC
 g4WZDEPhFh+d/CYwgNEZyg
X-Received: by 2002:a05:690e:441c:b0:67d:be3c:959f with SMTP id
 956f58d0204a3-67df44bf990mr2878362d50.105.1795522584486; Tue, 24 Nov 2026
 04:16:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
 <20261123225349.54981-9-philmd@oss.qualcomm.com>
In-Reply-To: <20261123225349.54981-9-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 12:16:12 +0000
X-Gm-Features: Aa3M54oooq9duknAP99OzqA96RUNdlrUQ9qk8PgHZjBagAPa0qdTIQlyJ1Gn8K8
Message-ID: <CAFEAcA8bHKjmH5RadxZpjNgT=odmfx1+RvVru8-Lqy+ajTuQmw@mail.gmail.com>
Subject: Re: [PATCH-for-11.2 8/9] hw/sd/sdcard: Fill SPI R1 response for
 rejected commands
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 22:56, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> In SPI mode the card always responds (Physical Layer spec v1.10,
> 7.2.8 "Error Conditions"), so sd_response_size() returns 1 for sd_r0
> and sd_illegal. However sd_do_command() does not fill the response
> buffer for these response types, so the ssi-sd bridge returns
> uninitialized bytes instead of an R1 with the "illegal command" bit
> set. Before commit 1585ab9f1baf, ssi-sd itself replied 0x04 (illegal
> command) in this case.
>
> Build the R1 response with the "illegal command" bit set.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 1585ab9f1baf ("hw/sd/sdcard: Fill SPI response bits in card code")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

