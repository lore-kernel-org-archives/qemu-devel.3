Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222A606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WDTlWUoF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVpXH-0006E5-Gn; Tue, 24 Nov 2026 07:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVpXG-0006DO-5v
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:22:10 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVpXD-0003G6-5Y
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:22:09 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-67c246c0c60so4024915d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 04:22:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795522926; cv=none;
 d=google.com; s=arc-20260327;
 b=bpHUuBpEtgpDXolFOv1/f35Z8Jw+nfEXz8P6uRLqLdbGB7L+PKXC3TM2L3lbS5b9RG
 MdrAjdbigaRUO5gJqJsd0bfk5oBNHS5l3ILaNggmNE3jGcIBjjM7bRLzrXB6B/ALL4xQ
 axLOJQjSFK55HyCxOTtgygHKljlYP/TZ6LpnQSNbJLthzRZHGuW6BrvtaOvRqCQkTz84
 /PG5UO3IU2Ky8DBW7YaymPL6MP9zLsbp6/hmnzgyXn5I1Z7VPyliNav5uGxa4BTRBz48
 DHWJVZVjuZF/BMzHOemue0dMUMfsZVIxmy0J7mceknzStcBv8rO8Fd/xWWQIc+tYMbLu
 nbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eGaDkRPwsGj9BnEYCn4ZitDoV851srEpbpKLxSWs1Us=;
 fh=kjIIHBxOc2+eheqJ3UOmUVeT86hj4XqWJtrPoTu5ZIs=;
 b=j5fbYAL83pvVf2XLZX8vQQsyCqjzjUUAT9qaKa36Ola4YBT2SFs2O3G8BNPbreFP0w
 x0CIx4xYCmhWKZlWwnV2qbYQLDARN+nmT0UcKn/2wXX52bclyOHzY3KfI+h0gX+mxZTG
 kWD2Nsqp/o6F4x7CG1m72hpGiI0mgWGDOGZxmYEoqSpY5YH0gqcBHX6O6PDEBYQU7NdW
 AApedAOb9TAWL0iyjeYubDAVWejtHQMVUDzUVNOEVkGue11FP37ptPq/MlrNL+jbgWKK
 LaP6US25cy7XJv7/8VVzvui/YAY3sQiZ6Fd4TVyY8v0jRObjDZP+26y+kjmlb0ly80L0
 rMfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795522926; x=1796127726; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eGaDkRPwsGj9BnEYCn4ZitDoV851srEpbpKLxSWs1Us=;
 b=WDTlWUoFEPH/Q6AdvmxuWG54b33dIiIcFuvlBum6TA7U7baTeBEIZm3i9mJuGab7Vm
 XGqhYSajh2d312LuHfys+lUDPz97o4bvEnZYKWajBKctmy8JDVnq/2XjnECRTCrhnqpK
 zCR5PuyrGfiHklI3e//2ncOh15eRZNRx1QJUKsRfrogFUJeiiCGhLVtBKZW/GP/ZN62n
 hWZnUUnhJuQFHUwsjB4XocaLswTXFlyYvZnSL3T5QkazdxPiv9HHf93ZuUodIbNN5eRi
 UhW63DHsBwzGYh4IQtDpDoPaYnSlql2EnezvQQ0NBeCA29qT0+4E9J2cGk03ORhHEfiI
 uz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795522926; x=1796127726;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eGaDkRPwsGj9BnEYCn4ZitDoV851srEpbpKLxSWs1Us=;
 b=R5A9d0F2KUoO5hptg64iKuUAeOf7pG+IrLnVjKZmb6vbiCuulaBQtEXquaaV+YO5k3
 KNCyYfaVMGlmv6NCnW57AcMZUFaRpzQ7inC2YJZuBp2vVvmQDYNUm3v1njujxO2L45uv
 BhKu9amwrB8NZpMGaXQgDdnDrjzQVDXcoCQdgK/M490R/SKmUu0cUgD2dOOSvS8tjgOd
 W0uir/QSQyit7jQtpzMMC/Hz1jU/jPbIFJQnFbThU1sukCVCtgwR6W+XDZSVY3JZisch
 PVNysk09bndUwvP8gf/r7lPDGiaATySCoQLQQbyZCW2tNOnGmTw2Q+D2tPoZNj6mA2ws
 SBhg==
X-Gm-Message-State: APuU4Z8mRShGYpVa3t6ql0Pq9kXrOlvft5MYBUDjQ0YIc7ED+Lu/rbjS
 dCGvh9jt/Zn8Ggey06eq5kABrLRY8+aJ4Vx2MODl0sH22gTK4YRd2bJPfTghQh526+X6Lo7tJ/V
 5lhAxmPZJIJXlak1W89ri/z60SnyGFKt5CKgeGjPD6A==
X-Gm-Gg: AZFdTZeaqnomPslg1Bb5cVBDl2PS6z/hPtidFIBEaYqCBl+2G0Otuw5H9Ytj0tJ5uLc
 PHD5xl38C5w5+ae+WcvvI48uejtdY4ka6a56FzUOOMwhYuPvvuKnHZDi4LhfZ/pjQLrvQkZ9ZIo
 2i3bVf2G2PxrEKo58/Y0uVQLatnJr7/iDToAvE4TUXfomuPpDEUdA9Bl3q6G5zsBBi6LUtV0kem
 SCh9AhqqRaHKqp4pJm5THB1Woa2QEo9Si3v1xOMzr4bqdW3MZ0A8Y8T8UyMAuw2fxk5Bw+8v9y8
 S5P/cJfrVzJdJtfS4Ht3AQbyVh5953fUEz8UbQU9+jxSCrJlWkfKIptF9tB0F1FHbK/J6hSswlZ
 bKgYyr7clsEwbS/5TMs79uhBErqX4Je1H0GG9oDU+vg6PQ3CEiIHS5m3aGZg09Obn5QpaNlhrJJ
 b3xRz4qVkgcbUTM2jLtqS6
X-Received: by 2002:a05:690e:c46:b0:679:a5fc:2f35 with SMTP id
 956f58d0204a3-67dec43f09amr5817369d50.19.1795522925702; Tue, 24 Nov 2026
 04:22:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
 <20261123225349.54981-10-philmd@oss.qualcomm.com>
In-Reply-To: <20261123225349.54981-10-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 12:21:54 +0000
X-Gm-Features: Aa3M54rR1r2VU271mesLSGr4Hyb3GJagclmk-9Xi3r_BKWVWhQBEbH59BjpBbOs
Message-ID: <CAFEAcA-DrMWdQEQuXa0UArTjob+N4Y6Bwq_BwQaQdkZVotG8Ww@mail.gmail.com>
Subject: Re: [PATCH-for-11.2 9/9] hw/sd/sdhci: Report Auto CMD12 response
 timeout in error status
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 22:56, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Auto CMD12 copied an uninitialised stack buffer into the upper
> Response register when the card did not respond.

NB that this is harmless since we compile with
-ftrivial-auto-var-init=3Dzero, but explicitly zeroing it
is clearer.

> Zero the buffer. On timeout, set the Auto CMD12 Timeout Error status
> bit and, if enabled, the Auto CMD12 Error interrupt.

Fixes: Coverity CID 1619307

(Coverity was complaining that this is the one place where we
call sdbus_do_command() and don't check its return value.)

> Cc: qemu-stable@nongnu.org
> Fixes: d7dfca0807a0 ("hw/sdhci: introduce standard SD host controller")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/sd/sdhci-internal.h |  1 +
>  hw/sd/sdhci.c          | 18 ++++++++++++++----
>  2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
> index 2116995dccaf..9bc6f302b62e 100644
> --- a/hw/sd/sdhci-internal.h
> +++ b/hw/sd/sdhci-internal.h
> @@ -174,6 +174,7 @@ FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
>  #define SDHC_EISEN_CMDTIMEOUT          0x0001
>  #define SDHC_EISEN_BLKGAP              0x0004
>  #define SDHC_EISEN_CMDIDX              0x0008
> +#define SDHC_EISEN_CMD12ERR            0x0100
>  #define SDHC_EISEN_ADMAERR             0x0200
>
>  /* R/W Normal Interrupt Signal Enable Register 0x0 */
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index bd74c60f7287..8c81b90f1a73 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -414,14 +414,24 @@ static void sdhci_end_transfer(SDHCIState *s)
>      /* Automatically send CMD12 to stop transfer if AutoCMD12 enabled */
>      if ((s->trnmod & SDHC_TRNS_ACMD12) !=3D 0) {
>          SDRequest request;
> -        uint8_t response[16];
> +        uint8_t response[16] =3D { };
> +        size_t rlen;
>
>          request.cmd =3D 0x0C;
>          request.arg =3D 0;
>          trace_sdhci_end_transfer(request.cmd, request.arg);
> -        sdbus_do_command(&s->sdbus, &request, response, sizeof(response)=
);
> -        /* Auto CMD12 response goes to the upper Response register */

Should we keep this comment? It seems like it goes with the setting
of s->rspreg[3].

> -        s->rspreg[3] =3D ldl_be_p(response);
> +        rlen =3D sdbus_do_command(&s->sdbus, &request, response,
> +                                sizeof(response));
> +        if (rlen =3D=3D 4) {
> +            s->rspreg[3] =3D ldl_be_p(response);
> +        } else {
> +            trace_sdhci_error("timeout waiting for Auto CMD12 response")=
;
> +            s->acmd12errsts |=3D R_SDHC_ACMD12ERRSTS_TIMEOUT_ERR_MASK;
> +            if (s->errintstsen & SDHC_EISEN_CMD12ERR) {
> +                s->errintsts |=3D SDHC_EIS_CMD12ERR;
> +                s->norintsts |=3D SDHC_NIS_ERR;
> +            }
> +        }
>      }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

