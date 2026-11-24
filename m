Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DAC606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=clO712ea
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVotr-000364-CZ; Tue, 24 Nov 2026 06:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVotq-00035o-6z
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:41:26 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVoto-0007bY-J7
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:41:25 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-67bee1f693bso3439635d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 03:41:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795520483; cv=none;
 d=google.com; s=arc-20260327;
 b=Ael3NIxbDzWqqbmhO3sSI2mDoVicbXDB459pV4Pvbng55xmxBv6k9W8f3MbFhC2DVN
 fKhtlmINwqELIUntsxs68kdJ6ksyOPHMkVj4k0DxjWyMrFmG/07hNMyyvq7nGPX+dLep
 iy4JvdADiHAtGYRzw+Dr6y8QOOZ5hlmYsddXy16SQyq+dR141PWMgWbsDCDAV0lfjPjl
 L3b/uZGqtOFe4gyQEHxtgxCuIHv7IGfwk6+ihZxfTyvL5KXpsEfXcjWGOefbGYvEP+tE
 HPptEbTssCf+zwTbOxCJ1YGs2Nl+TWqobaOObF53o5Fd4LEksXIT0OIm1nQylQpCpaat
 +PrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mSNp3LHYVA9rrGkN0fGjR13X1h98sMbNiZu45jZWbMg=;
 fh=kjIIHBxOc2+eheqJ3UOmUVeT86hj4XqWJtrPoTu5ZIs=;
 b=Xr+O0RuadJ3CRxtu5XDkTzGNwnvEWUyLQY0y4vKw8o/jas9BrwPkhDTio+9q5qeU3c
 SxoJswwGV7FmHaVLTC9dwWpcgMEUFkM41Cwra/dTx663pOSSLZoFcJIG4n1NnV/FBal6
 i3SqfecNrRG4US9k5WRUq9/Dt417qd4vfc3uprYkW3waS2k47i+DCUlrVHdYk3FQca8f
 umq6bJyb5Gq9bMlI4jeM6daWrey68R3jFcTAiHJW3SHtbuYmJy74z5BPjpF74A9qhibM
 P+HSlEENYW8uMg1BlTN1sliipQjS5dFFhuhaXOPAGEsnaa4Hl7K0JpL4SXybyLyy3Eya
 TTAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795520483; x=1796125283; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mSNp3LHYVA9rrGkN0fGjR13X1h98sMbNiZu45jZWbMg=;
 b=clO712eavML3HoDCSuLRXWU0BNRomdfbWIjwq1VpQPjbHzuk+7QI1/MiFFePt3edAx
 EEdb8RpZ6ar033S+8lbGjKD4sqv2coWD04pvD+5YZAx895MlYN5F3Y5184dpLn4Xieu5
 j2DPiEyvu6q+T/ybx3Wl5UOxPVyVJlokkqkbKFiWvw6uPmi0C3khBmL/4237GPZKM13t
 6e6Q2CfMZ2BYXwk3PyZuPfcsR/3dodXZg/s+oeGJw5eXsgGYsOGAfj0jckfcph8Y5jXx
 RWvTNuEz+B6FvFIKibps6hFUDw2LKiJEAqorcA+9hItAPglD0ucG5YzSX6vrhMwQI6+O
 zp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795520483; x=1796125283;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mSNp3LHYVA9rrGkN0fGjR13X1h98sMbNiZu45jZWbMg=;
 b=LVWPW6pTuVjSfYpeKCSm1MRG374JcmhH4NyYbsxVdq0IUYasfDLdIW2WMSdwTuOH7K
 htz52qUOg0vNjgw2ViGYE/DTQ0CpVAntPHsx8fa1TdmUooerjS8n9XfgL5Jco7mdJTv0
 qdgQuobDbirPPYbtV0OuuUuGvL4yjbUeYwLPJVIUtIneDWqXq8unyP0R3q/stjWRd2lf
 5a5d2W5OvnRlJYgWkMtQcLtPi1GY2sZxhnw20Nz+Qu3wK97w/wIkd5NAUZhXMIBHOw0T
 1olLn/7JymIJBsFUMd/4OcS2YxiuhdfHPs4mGlpffT3UAjUdynwPtsm4xV8q6c0tBnxQ
 yCDA==
X-Gm-Message-State: APuU4Z+6F+jTHAmzSsIWl0Pc/Icoe+AlVOl8rTdCkaZ5r3OOZj8xDkRc
 /AQcgpfHVqnfFwW64CpdgY0p9JIzpvmSLyFT8nVzsRY4fXaOtXQf3VZUESBwJkveY7k9I8EnnjM
 /SVk3WvSNperEdsrAWuGN0fG4vxVfCmWGo2lLBgZ3Hg==
X-Gm-Gg: AZFdTZfEzGE9PSLUhIDFNt0bEhk90G8TUNO7J3NEiMXYSE+8IsJIQ0lVzpIhkSxv0GA
 8+QastIf9b7R+2aOjls9eLR1XSerKC6vzyKSchOsvsKThwTXJcyjSYgeHogc3w4yq/BRsP0L9OF
 0GjhqBbcwkRr/utjCsEx7IUUkDczxDF/tlIzPHJWTupKSGzBw9bYFS7c5AZZ0ok5RH91Zjgsi+E
 aGHk2Xu7Jwudjhh+/aN/jaeCethJfF/roD9KrvpgZG3QPZJGEP17+dUcEPPkGSjCDWudQfzRyLM
 BGxnEf8qwVqM+6auXBdfsWP1u3MW+2bmT7n06J4c9FZEgrDc+tzwa9dVio68gFtLzI8L3zUfRjk
 6gEqpOXCohXYzRoZb5p6iz4HC7q37UKdVAcFHDWhoaW3TPlSYGYjrD/83p5K3JqtBlBTuzZG73p
 gtv0t8575C53kLnvUs4hxo
X-Received: by 2002:a05:690e:bc7:b0:67d:bb23:6312 with SMTP id
 956f58d0204a3-67df43f6d9fmr6178246d50.33.1795520482917; Tue, 24 Nov 2026
 03:41:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
 <20261123225349.54981-2-philmd@oss.qualcomm.com>
In-Reply-To: <20261123225349.54981-2-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 11:41:08 +0000
X-Gm-Features: Aa3M54q1AV5hwEivHzyOQiAM8aAmnLP-1a7WGbUB6f1AVqv_ClaHDXqqe4uw0Hw
Message-ID: <CAFEAcA_Sd3oJM7vCtXSANLAit6FEY9i-vFyBfUV=gDyQrX2vDw@mail.gmail.com>
Subject: Re: [PATCH-for-11.2 1/9] hw/sd/sdcard: Reject zero block length
 (CMD16)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 22:55, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> SET_BLOCKLEN (CMD16) accepts a zero block length. A following
> READ_SINGLE_BLOCK (CMD17) on a Standard Capacity card then reads 0
> bytes from the backing image and enters the sending-data state with
> the data size of the previous transfer, so the guest reads back
> stale SDState::data[] content, such as the password sent by a
> previous LOCK_UNLOCK (CMD42):
>
>   CMD42 (set password "secret-password!")
>   CMD16 0
>   CMD17 -> data block contains "secret-password!"
>
> The spec only requires BLOCK_LEN_ERROR above 512 bytes, but a zero
> length cannot carry any data. Reject a zero block length: set
> BLOCK_LEN_ERROR and keep the current block length.
>
> Cc: qemu-stable@nongnu.org
> Fixes: a1bb27b1e98a ("SD card emulation (initial implementation)")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/sd/sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

