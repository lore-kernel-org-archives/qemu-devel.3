Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EDD606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BvpH311b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRo4y-0001QJ-Rx; Fri, 13 Nov 2026 05:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRo4w-0001KP-RW
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:00:19 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRo4u-0007TV-3A
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:00:17 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6767d92cde6so664730d50.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 02:00:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794564014; cv=none;
 d=google.com; s=arc-20260327;
 b=Qy/z2L4/EFOEeeXIOkjd39uY/vE/7qnM8VZNKq6h83hfwr22Vl1XblYUWfKXcxAst7
 /2NC4CmiCc82G+j2Eaa4fAjRKXcNl98GYD+U3dtVj2Guqi2uPdgjNRfGYSZw3U4mvxmv
 D3+xElJ2ThV/SysulAfzuNGGL0hWAHR9FYSgGu9r4uHLlLYDVBiKlMkfSPEcN/o114DB
 U+2R977khpkagY63NZjRErj040hCetVA5sPmr2w1u+Hn2gIOheATvWxmqq91nXny0UJi
 qVHrLa4F8Xwt10xgS2WxE0AqwiUkhjr52e4puoPTTgOPMadTNPXGBvYYNB0JS8fZ0zwZ
 tALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aq6uGbA16KipBYFu+IqvT/+AQJhgjQvkg4GEQtBIZBE=;
 fh=1mhOCKu/YyJBw/doyDs+X6nLPKdcgnVBC/WuVZxRIpU=;
 b=TaFEmk8DlBIlTXWyNvBUp8w1vEL7xkStoZv9NJCUNb5yxeHGLFYn2m/4tafBosftPW
 1MbHMf1dAh4PxofxOOXb723tgsuUlQS5MikvHs3g44gU7T9REDBdWo3l5BX+07OpV3hf
 hI32ku9jB815bSkShuDeJ0JGJO/qtJPUgG2gGE2K76ylBYupS0NJg+GgBKKIEhb6sJ0V
 ht4TiZ9eXcBX9H9d65FIEBlFL7YWwiKGo2xBmZEn1gJ3P9oP0Q7pxnw0xGQ8xUBnycVd
 gY0r4xTLShoRmPdInhUsabcOpE+1MORlQT08Kh05pig3W9+JCisTCYNnOv6m4iSm+Qr5
 oRXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794564014; x=1795168814; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aq6uGbA16KipBYFu+IqvT/+AQJhgjQvkg4GEQtBIZBE=;
 b=BvpH311brTYlQl7hLZaTozEEMkVjkRZ0ETUa6+20AtiFUME+Xho5IYR9YGWwdCPHvs
 dtIAwWPbuHBL4yrjMTgUG8JZr5qD7zYLQpuPCKjZmLnUYQQh/ueBn6Y64SrwKEGPLuFo
 FvCFz1mrSidMExnQjndctJwRZwSdwdJK2mfBfb+67aSnVRMXL2Zrtu8hrUzS9udmz/Ur
 DxWSRKd8SJtJL0QW1en5u7h23X9mm0ilTq6TqOJ6+t1ouUonLGSDV9KgXtNtfs0YVFWp
 Xqvepxn336nVPSStBcOSv1xwj2yaqbuaEJvu4uYiwiq0JBGm/unnIzSFNCtu9+/mXJuw
 d8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794564014; x=1795168814;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aq6uGbA16KipBYFu+IqvT/+AQJhgjQvkg4GEQtBIZBE=;
 b=uf6N9yp9kFc3Rs7Mrms6l92KDyuN8oubwruK3LT0fSx5voLy8g4ZhXm1KnjOFClZnH
 6/ZL5vlJ0wRsWVVKxQoVCJpLQE1ltqIax6e4XLsUyriq6YuQ1A7SBD91XE1GlcxZlFrg
 CFjQsFy4kwRJCWLzIAn5snoeuIoqec74aURcFuBVtkqsIZ1qVJhS7GTEQkdjOAHlvBAP
 JS3glDT/++9L4VDGZ+jYtGbBkmjlas47Ih9itL26crMlrVYR2PmLoDYp29EJo/BFpIyw
 RFxiBeAb+s8s7qURiTT2D6DbecqWtxV1vR8jVDs/Ap2Co7AmGISzSvCUk79RMgmML0MQ
 E6wg==
X-Gm-Message-State: APuU4Z/mowvAJep2WTgiKJYFLLxQ6EFsxVLkDE50gLD6nro8M6HkS0gm
 O3mB6cav5p/z8ZB27fYLGu2oW73rqCfjnErdEaR6TB2NyHUevgmkMZhgF0md+0i+Ah7OBOAtu95
 C/gQEkjYuiOgqHEwn4jACL4pilseOFwHml4azmyqWCA==
X-Gm-Gg: AYBFou1mYkXbiamJ2hrpsG9UfLfA8XufxfxQi/yKM6ii8NWfzLB/EteFNaao5WCM3bs
 QTA6t3pe634yzt2gLgjRkK7reWkIARTpeEs4feuo2g9Hu35sn/0OMtdRCNsoTL+QSnyhQrfwG9a
 /e9ipirUcjdpTcjnLSHPVEQSj6Rxh/DKdS7YuGcP8oRGVwcboj4T1iLox6HQuE6eBJ1lQAMXcU2
 U41MydIqSxisrOpzRx+EVXBah6+15UHa/26FlGp8bvOwKP0qG7+mZxEhy6W+KRW+xhpmHTag7CT
 BaqgPJ7q8qWFlEGSS+PYcOciJ9WupLuTAnx6UPbf4v5eUwfxP/skaXCS0iJBmGOyfIGB9boaBtA
 57ynAfj6TtT6Q6e0WS7I9BWNdJbn1yyGX59IWzVj5pCUD4SojX4omjISOIfu3mDkyh6Mvh+b9LO
 HwLBiECDtXTG0mjx87/zt4XFEa8tlaTbL9XQQeF6CwfQ==
X-Received: by 2002:a05:690e:1448:b0:67c:fa3:f181 with SMTP id
 956f58d0204a3-67d895cdeffmr1376079d50.30.1794564014097; Fri, 13 Nov 2026
 02:00:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109143410.3279305-1-bin.meng@processmission.com>
In-Reply-To: <20261109143410.3279305-1-bin.meng@processmission.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Nov 2026 10:00:02 +0000
X-Gm-Features: AclHuK_6hgmI7phLDamoumoK0Wu1uPXJZ8QsgoYpC2YT9BcFJ_pC9BJTvc37nA4
Message-ID: <CAFEAcA-yqrPWXngq-pR5F2Eg9qSN=7f+AJThw9SzFtCF-pj7+w@mail.gmail.com>
Subject: Re: [PATCH v3] hw/net: cadence: Honor subword lanes in the GEM
 registers
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 at 14:34, Bin Meng <bin.meng@processmission.com> wrote:
>
> The GEM MMIO callbacks ignored the low address bits and access size.
> Byte reads therefore always returned lane zero, causing guest driver
> that reads the station address byte by byte to turn four unique MAC
> addresses into the same value. Partial writes had the corresponding
> lane-selection problem.
>
> Extract the requested little-endian read lane and merge partial writes
> with the current register value. Preserve the existing read-clear and
> write-clear behavior and dynamic queue pointer readback.
>
> With this change, reset the TX queue pointers only when a write covers
> TX-enable and leaves it clear, and only start a PHY operation when a
> write covers the OP/ST fields in the PHY maintenance register.
>
> Fixes: e9f186e514a7 ("cadence_gem: initial version of device model")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

This device is used by both arm and riscv machines. Alistair,
do you plan to take it via the riscv queue?

thanks
-- PMM

