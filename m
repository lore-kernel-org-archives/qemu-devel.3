Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF02606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gdYax4BS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVp4g-0006k6-MK; Tue, 24 Nov 2026 06:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVp4Z-0006f0-JC
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:52:33 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVp4X-0007YX-Iq
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:52:31 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-67da69e7c31so4584749d50.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 03:52:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795521148; cv=none;
 d=google.com; s=arc-20260327;
 b=rsmENWK/9idqMK4l67ubEhHv2mMxHE9UEDtSxL8j9SxehNdxERx2fgWzBF3zgf8dP1
 LnUPGIyV393dsB4+6DaUaysA5s2meJW4UXFVi8ghqUhnHHBg1HJdWv6jXOvJruVHWD0H
 pMK62sqprv/9tqwo+zZodRPGUhTINlFeNftnaJNG2KW9jLnHYF5Iw6ukWZty7xwL99V1
 BM13an/QsKifk+0s8th2RiHFEy+8drsy7UpuxxPYBbamPyEc0wKI0Wj7e/+axM+lDyR4
 eM8A+ze3C2TK7nrnCpz/4vTrPPbH4iqHItwazWLDHKSd3pOXOzV9QrQh9q53NBDPRBk/
 P4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GmrZTVnD4qHSCdHeLEXeCSuJkPlieGR3EuOjmjRaOPM=;
 fh=kjIIHBxOc2+eheqJ3UOmUVeT86hj4XqWJtrPoTu5ZIs=;
 b=fh7SYVKzSEY8NllkglUxQru+eNCGiMMeQpFE8Dk/kMokHiyLozPgUYYDewStiRtJWK
 zCpx86JCNk1GxS4v4jo33C3o6zJmkBFvcYd33LwTXcLamd2aqneuvk7T+C/HPp/HV2f4
 FZOVgKh34Ft3aK/YSkKN2usajXNf4Q0V5voKVYkZu1p0AZ5DSNwdUMjZYs3w+D/1/Idq
 THIPKJbPyAB2A8tavqlG1wJxJE8FqsxHP9MOLCTIQFKZBtYETzm49uc3x7lQezLOERPh
 MMi+yOI9hxqcjCdgHKEKeQpHQ86leccu7GvHpLth8t28n5xBVmR6FkzMmVl4AQytXFhq
 f8tQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795521148; x=1796125948; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GmrZTVnD4qHSCdHeLEXeCSuJkPlieGR3EuOjmjRaOPM=;
 b=gdYax4BSDeqQ6su3cWGE8NUrqhD/1rTR359glS144GiL4KRD0cxzzfQBQSE+LcxCQG
 W+OZuUGb1fhLUevBx2Y1ZEJIUp6c31LYD6tqPxBmffki5F5qkC4vLZAc+h6pwibyJzTO
 kAbY1iz3j6wbWoyI0exmzN4pyj5bhP+AVzMa95Abpj3MAh3WCRabXzmUqlgaIoeXHC9T
 /y/E5TbQ+8S+kWZXjPMkRIPgL9LQChJiRuyhqLK8QbIKzvm1H3Yl/VrcwIZFFBDOzBbU
 3W+1ESRQ2cTztdittavcIoiJ84SSiREWYQ/h5VF1KRV69AAz6+L79zC6PI6rlXkuk09a
 qTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795521148; x=1796125948;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GmrZTVnD4qHSCdHeLEXeCSuJkPlieGR3EuOjmjRaOPM=;
 b=d/BxSNFQ4Vyo5zwN2wF2BY1w5osZxH3j5It5qcKk7Ilvv7NjLtTfrPNWhHR7j2zOQZ
 zi0gt0+vqv0H86MNG9v4i314Ges154lHY+MY5oWSkkd7oKVQR27iojXlEd96mm/JTWwt
 ljOBo40iEgl+GXYrmJCC0prLiRprORuC2/MqMizyQoKp7JP/AAGZw+DcCy9JsHdTuS4K
 jt5x1AqbaJGIkvbRn/JRoZzM3XxPbiMBJXeXBW67x37yywdogS9gU0rKR81k5Oveil+w
 SqFQecfHZSC35lHY6rvlcrPMJfwhZgVSm2TTToCBTkWe/aQ+KmPDB7/YZgdEOJnkRPcR
 sz2A==
X-Gm-Message-State: APuU4Z+OZrLehP0o37TcTM9JhAaFKCMiM5iG75W85TjCUVIOFmCLzRQS
 KySaYwzR9umEC+WDngTLidJcZ7fDT3U2UWmZdvxvgZgDeulzJq6kIlcKCKyp+/1YMEnSe6N/2OT
 OxUdC3VkMDa9dea2EKTIVQC78vislWvctfVFHWu8bDA==
X-Gm-Gg: AZFdTZevHH+gR3hRImuWogEPq2WNXLV6ykX007JhfvbUK8SSFJOeis1SaFTgKxlTIVN
 +xzeSccvpBP29Wyny3a1jvjlAqMPsS4QjqaV2/tiRKVvr/Pe/9WghVAjLazq10+hexWRqdeCHhr
 kC1WIbiaoJW6x5ggBm5cMvEE8UwUlwxGRuJ1vZpGVyAR18T/kvSjywxnocxq2ysEfC70gqCqE2N
 iKX1z3Y2oLlp2MHxTlAxKpEsfqZjT9F8vmQNTf3Vh2/YRN/wsItYzoEblsTRQGKZ4MZmn89tHFd
 slq/CvwpsKKVHcaEZrCFreGxGcDMcfd6DHisKOD8T4Qf0hFbQ4peZatOHD9hHsf41vc5LoGD1lb
 VGa3zWED3n+9Lx4tU2Q+WE6fmEZ+3q02bs9AmF/0jV3AlWF38t/A2PreOsDZpaefKigmTOEJfy8
 uX1GXkqQaSm4bvyQywjfXH
X-Received: by 2002:a05:690e:4891:10b0:67d:be3c:9582 with SMTP id
 956f58d0204a3-67df449824cmr4474627d50.74.1795521148229; Tue, 24 Nov 2026
 03:52:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
 <20261123225349.54981-4-philmd@oss.qualcomm.com>
In-Reply-To: <20261123225349.54981-4-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 11:52:15 +0000
X-Gm-Features: Aa3M54o6ijvzYlXZg-WhKcG2C314jwIuAho2FN0yeUkcCdGse3a8T1Qsst9Mezw
Message-ID: <CAFEAcA9-TFZbOcPW8mrdC+LN5_AsxkCCkh16noLjYFhtf2UKUQ@mail.gmail.com>
Subject: Re: [PATCH-for-11.2 3/9] hw/sd/sdcard: Do not abort when writing DAT
 lines on invalid cmd state
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Mon, 23 Nov 2026 at 22:55, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Since commit e2dec2eab04d, an illegal command resets
> SDState::current_cmd to 0 but leaves the card in the receiving-data
> state. Data written afterwards reaches the g_assert_not_reached()
> in sd_write_data():
>
>   CMD24 (WRITE_SINGLE_BLOCK)   -> receiving-data state
>   CMD2  (illegal in SPI mode)  -> current_cmd =3D 0
>   data token + data            -> sd_write_data(): abort
>
>   ERROR:../hw/sd/sd.c:<line>:sd_write_data: code should not be reached
>
> Commit bd6207903eb8 already fixed the read side. Fix the write side
> the same way: log the guest error and ignore the data.
>
> Cc: qemu-stable@nongnu.org
> Fixes: e2dec2eab04d ("hw/sd/sdcard: Remove default case in read/write on =
DAT lines")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

