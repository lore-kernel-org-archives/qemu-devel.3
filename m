Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C906606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=d6iSV0fs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVYL-0000Si-E1; Mon, 23 Nov 2026 10:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xVVYC-0000Qs-5a
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:01:49 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xVVY5-0001Hy-NS
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:01:47 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-679aeeddc6bso3038312d50.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 07:01:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795446094; cv=none;
 d=google.com; s=arc-20260327;
 b=hcEm8s5e+DQHRhFxG6nNqcG2kLqE8v2S5rm4KGU6EF5sW2IdJyEKiKDDDkFzCdpi6w
 8+hvTMtBMfHgsyFtdCW5G4FBvty0qeWNqx2ZJ1v99Y3YCRf1jo+ZncjS7Wve/9RNtKs+
 vEMFm1xSupkaunBAL1JN+DlZ+Amrynk6iyxQ14oox44cPtqKQ52EGaM4zxJ/DWOTGEw3
 6BkfBOA7RK1gN8XMWaq9FiQ4UIZaL1pjOOD/M+8aRtLfYCZGsLq2VXevqRDIfDhclcwr
 7EPE5nBqF0g9DK96rWIZ6+97q5E9NVXXZbmHxAW+h6fUIt2q5Teg0WXyIyKx9TKe+4X+
 BXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=skuf2GYorXAzjSk8yFnNlIs/kze5ZuA+D8lM8hSq64g=;
 fh=OsllBEs4Bkrfkwpe9sTNr5asHprOcGPAHzTK6OGsLNA=;
 b=E9z7WvKMPqWRJVMTlygezeIlF25rrOKNR5VXMx3n7Ptph7obf5CCLuzLuYU2x4x1ia
 7bK9nciZqqhMlX4gHz6nq4jTpA9QuDW7/o12EA3bgZngtYxs7GjWeEfp2z0SHVW4sQ+b
 rrj0L6tK9H4J2DixSFrKtrPiAD3Co7jYHbUeFMREiO6jScGlFGyVpUubse4gzhIoetZ7
 FHDQZCc8zJqJe1u6Ga7vL7YG7uBbbyFeremnAzQLWx6rv8TEtYwygAFvwK0O7dYfon14
 L6UxKMR09V1bfX+SPVu8uP8Y19EDhsQg84fhC5WD1XMILOJsKeKNPFFlPBnV3gKr6ezf
 desg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795446094; x=1796050894; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=skuf2GYorXAzjSk8yFnNlIs/kze5ZuA+D8lM8hSq64g=;
 b=d6iSV0fsKOzhKhuRlkPWextBJBvL5KyaMWVr0xb3JyHElymuINs5tRmNzEglaw701H
 7tDA5PzhnWpmJbDWdMskTnegV57i4F1fdI6EqNaV7COt2J+QNrp4ReNY8v/f47QwsGqh
 r731Hg6i7GtSpoZPEPKL99UDNFfYNQRl2uQoibmIpj10TKL2Rge0euNTs1WmV4NJlyDV
 3oDjZiQVApsVvWes/df0YmYYAfwEs89JGZ5qe158yapbHjJlxGGRv42RP+jBKZbju0iW
 4SZ1nqymCmfWmd5R5UtRFYDoZO6/yVfzecy0kke8RKnHTvCFuhAaHeMFuvGtZDS+GL4i
 8aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795446094; x=1796050894;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=skuf2GYorXAzjSk8yFnNlIs/kze5ZuA+D8lM8hSq64g=;
 b=RruEvDWHFT7Sjf+IxrwiqpynJtTHpxQOyQIRG2aF6cu6fD3rms3dDfo7ISZBPTqRLD
 AuQatKzBW5+SKFkbcB5EisCnMNQ0s9gJQx3kGtg+PJLB+LduPUCcA3KnaQkKYb90b5o4
 K44niTg1w+Q+ec2i2Jhhsmfjj0g9PE6/mMrbkmJNkuIJ619ug0Z7dfgaYdvgxJx+ng1b
 8XnQByVbguSsETi9jCulQ5XE+tbfaLyaIP0EYyyZyN9DePttSDZq84nE+2/Y139xoS0A
 0NQrl9IAv8vc6AMfLB5VGe+ox3u4I6laBZReQHnXhaEeuAOpX5RhabYo9WOQUX42baI7
 qD4Q==
X-Gm-Message-State: APuU4Z954t7ZKEAvH6UKe1Y9lzCOuqGHtZ+KG8V87dlVLsPUQaFFsQBI
 YjlEbxi5Y8ks9Xlzrt398c4hw2tFny/5+zK7HPKa+eG/M6ZWnV7Li/JZwlM3mrIKwAhYLrtLEsD
 YCMFbB4mnSS2odNb7FRJSZ6OFIWz6bG1MfvT26WKQlQ==
X-Gm-Gg: AZFdTZeZ5a3W5anXOY9X+S24ztQq7UdlExHMjl7XqAQry1595F7ivy3brAHYVe9FXjd
 5zAinR2UJXhK9f7wNnNyyuF12vYJuBUO2qQji+MHnu3VR3mVreWVAJFrx0t2VpqejRcZlYjl6JW
 ICIfTpgLRVZb+iTDgW4ymK5JbkT20fDGzZEwxc4UhJeSFQIzr0JGoFMZo6DLtjB663iciaPW0ea
 UHzyrOdgoaIkjwasF7FAJoj+5AIXHN0ZvNiJp8zSnx624ATtiUZxj8c2m16g4JAH/wRZd+IRw3P
 U0BxlTT23YwMNGKoU57yoXhJtAL1wiWM46Wwg+YzE4OhdvWnpOf7lKSCNOhwbNNMgA/Cxvzztb3
 qT1M1Mutb7kvzwqBvIkG5ELneBrizdjqMs5klSgAZhnd9E05wTPreQ3+VSbPcG2/IaQIbyV/NiG
 CZr4XqsP9FkShEEHbM9xYTNYbsofo8Qdmo13T9B/Tk6NZpXZM=
X-Received: by 2002:a05:690e:43cf:b0:67d:c878:7df7 with SMTP id
 956f58d0204a3-67df449a793mr1955028d50.66.1795446094270; Mon, 23 Nov 2026
 07:01:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com>
 <20261110-m25p80_write_enable_fix-v1-2-3a2abc0072b0@oss.tenstorrent.com>
 <39176a72-7756-477a-842b-e277ec07d321@kaod.org>
In-Reply-To: <39176a72-7756-477a-842b-e277ec07d321@kaod.org>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Mon, 23 Nov 2026 09:01:23 -0600
X-Gm-Features: Aa3M54pMIxVpsgHdhxN42mW8bRN1Czi4_5qOo11zwg6oAPx-qis8W0_UjRTfeSU
Message-ID: <CAEev2e_SbbLENO3YhkJPtBXyd2JKZktmnxzD6UbbDyfyih6C2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] m25p80: Clear write_enable after page program and
 flash erase operation
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Alistair Francis <alistair@alistair23.me>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello C=C3=A9dric, Alistair,

On Mon, Nov 23, 2026 at 1:13=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 11/10/26 19:11, Anirudh Srinivasan wrote:
> > NOR flash drivers in EDK2[1] and its forks[2] poll for write enable
> > (WEL) to be deasserted at the end of a SPI operation to indicate that
> > the operation has been completed. The m25p80 spec[3] indicates that rea=
l
> > hardware would desassert WEL at the end of page program and erase
> > operations.
> >
> > The m25p80 model does not deassert WEL at the end of these operations.
> > Update the model to do so to match hardware behaviour.
> >
> > [1] https://github.com/tianocore/edk2/blob/3c890c11dfdb5908dcbc84f977dd=
dc6c6d43789f/MdeModulePkg/Bus/Spi/SpiNorFlashJedecSfdp/SpiNorFlash.c#L987
> > [2] https://github.com/spacemit-com/edk2-platforms/blob/0b8b7182d8a20a7=
71b97a487d0e6f4ab89fb3492/Silicon/Spacemit/Drivers/Spi/SpiNorFlashDxe/SpiNo=
rFlashDxe.c#L532
> > [3] https://www.alldatasheet.com/datasheet-pdf/download/22807/STMICROEL=
ECTRONICS/M25P80.html
> >
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
>
> If this change is to be merged in QEMU 11.2, could you please provide
> a Fixes: tag ?

Looks like Alistair has picked up these to his branch already.

These would be the fixes tags. Not sure if i should send another
version or if Alistair could apply these tags.

Patch 1/2 (aspeed smc test)
Fixes: 3e62a32ddb ("test/qtest: Introduce a new aspeed-smc-utils.c to
place common testcases")
This bug was introduced in 7a2334f720 ("tests: add a m25p80 test")
back in 2016. The commit in the previous line refactored these tests,
so I think the fixes tag should mention that one.

Patch 2/2 (m25p80)
Fixes: m25p80 ("Initial implementation of SPI flash device")

Regards
Anirudh Srinivasan

