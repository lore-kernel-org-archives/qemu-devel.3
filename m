Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B0606A322
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xeoazvHX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPu4-0005lR-6L; Thu, 29 Oct 2026 09:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMPta-0005eg-NG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:10:22 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMPtY-0005xV-3e
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:10:17 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8565d77c277so18136797b3.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793279415; cv=none;
 d=google.com; s=arc-20260327;
 b=qS/zwBTzYtRQUj0W73Ddj4KwEIdXWsFGUd4T1gIKZDpjQ3PAUObIoiSQS816Fp/gVx
 1X7CxITpDCfVi2WmQ0wg7zbK6BerTjoa7VLujX/ailKLok81izo19+LmOC7JUdYG2J1O
 OF/ZRRyNC8BNPX490/4BNZ1wY6F0D2WJm8Pd1TF8RDtCUZ/k2oyfAUZvUoFrmMlbeaoq
 J1rAFmzRcn7tcqJXJOb6t9sAQXYiGWG2LvW4TADMpJ6N810T4qhRXJO0AHPp2+biajIa
 GKtAW+hyANav3r++QoxmK44Y4RXSEy+0R+XLSsXgnIOXLW8s2Fp3ppUV3ju1q/6JzyNP
 DpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bIaJCNBfi4KmYzBubyQiQSnbguZje7+rK9K8hzJsz4U=;
 fh=fDgAdR6s4Rv/RG/wfiju8Wkiz1gSdCDUZZ5Xo7x1Moo=;
 b=bIgjNeFOR99+gh9V9WyeRX/H2csNbZc/+NYaSsr2BnQ4kP9IbPu7zF36Yy/L6R1Y2i
 4j9mubAXl1FrqTXvO5tGuE6fO0/5b9zClW7lGBORcFTrGq81JeCphumnC4zW7RFQVIK6
 XgPcCENteM+1ueFkAffll77SmhR9RfDXE6okcu3JVXZ9TBJrEKTP6lQM44UI0MraC1zC
 D01PovFjdxqzXwhYqSElT32NavrfLkMLB0xRFjqQxeCqhbEv/rpTGCFA+fj/bvxjU07A
 Ud2r4fiOtfZqe23RM4xmfnEGI+p70kXM8DMjZ8k6J5fwfSZBtW/iC2Lelnpm5JueNSZ4
 h2iw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793279415; x=1793884215; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bIaJCNBfi4KmYzBubyQiQSnbguZje7+rK9K8hzJsz4U=;
 b=xeoazvHXL6Cy6uPoo/Oj4SLo7nSkDiJrEO1BZUuyiwgXl0o3Qj8OnoB5lK1ehq6WSA
 j7m5GjFnfO7rx0wxGc8x5v8eZcMCZf93pT8XuIYAnrV709LbBD5dJ0+8Epn6e2LEy1LE
 Ad7D4m+0aqhwd+Vdb41DVz1aW8ipe/Hz0d60RBJAvrb4JvZMyXqZ+FrUMhBKZC8RJU0R
 k5zQCPC3FzlytSD1uFKkUJ+5atyEyioQ8eUskuelHnvlxVwwOrxOUex7KfVdAPAbHP/C
 4hcyS1Nm+TAi3dtd5u+6mmghzGiXcXsawj/e4khISM6+mHcGwPIyjRrs0swuw/h+RxoE
 5DXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793279415; x=1793884215;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bIaJCNBfi4KmYzBubyQiQSnbguZje7+rK9K8hzJsz4U=;
 b=dtgXOQXs/MnY4ahTlrPR0TZoztIeD3/iLkCUjqEm0W72jUom+j0P3QKkMSTqyW4EVc
 vQ9f6WqJNHHxSGPGUsWb130REhiybBvLT+aRfBP1cSQ9Rzp137cv32YWB4Pygn1cxmzE
 cRZKrYWBc30SA/VTiDRtYwvWq/p2xG9R86kyOJikax5d609o4Yf/hWoqPvHfTFl4Qf5x
 WzFn+sgT1uOz1R2SxlF5LyXs2i8BfpveMAWcNQYRfzi7Tvl7k1tO4mU6LrBE8hOPnSOT
 ghx/Lcgs3OlCF6jO4t77X72DQqhkdwpHuUa9w+6lfo2Yu7uQS3A5NgWkJ4wmPFKwsf6Q
 cDFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbMaC1qD8okWiDRyEwztQdaBkcsE8VsqmcCSg+Farpmz+fCWP8o9Hi0wOEcybpSfhcPO30uGe473bT@nongnu.org
X-Gm-Message-State: AFq9FYL5JuaRiwhH7Sm7dA7jtMK12wbA7fk15BwuCybuVP4xpycfN/74
 Xjd53Rbfmze4+o006yYKOqbS0uNwk7TUPaTQ4c5vORkCspd7SAbBruVl6qPusuaaKCN7IGurk3q
 uEf3y31yRMOXxvvIP2PnswK7InPOnJa3Pmx3yvPMa6A==
X-Gm-Gg: AYBFou31ufLxCrFxMKt3Et0GnJL62KCNlW4YpyQ0ced7WEaqA0v8eas0cLCMEg069PA
 NxsUkvu2/iwHl9VByol/eMiF5y5Y+HVqwGtlt1uOZYRIDRzXU/nV6I363MyzpyyoN1ESbh41A6a
 H+pLbAH3aECx19TauEVzo+vqtqqYOwzlcwZ8EepjaS7Are1VaaO1Fk4y88HHv7VPDRuqxfvCmUK
 jmjSSzcgoHAXHYTrPYwTNETZw9it1mtOcKFTjEcXAb8FSqew6dHeLV6s+R/yN1weo6bX0RPO5U3
 bdXgSN7DEO0ctCYHQ1xPajqOYYxtrpyyVcMOxnXbcnjts2nD7FQhYWUX5n68T8hiAWa86HZA6mx
 Saij/ju0BHUxC0rZoqTseUhGn3AUkMlWMVJeb4fPpxcQVIy3zmnhLWKe8LBMwW/2CCfWQ0MTu3K
 Lu1dNZC6wvaHo87XvlGlkZhx0kd/N0QyYBluQRka/eHQ==
X-Received: by 2002:a05:690c:fc2:b0:8ac:b167:4877 with SMTP id
 00721157ae682-8b1b5c9ff05mr35361347b3.36.1793279413797; Thu, 29 Oct 2026
 06:10:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026175220.85545-1-philmd@oss.qualcomm.com>
 <7f2fb4fe-887f-449b-9a08-c65375077551@linaro.org>
In-Reply-To: <7f2fb4fe-887f-449b-9a08-c65375077551@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 13:10:02 +0000
X-Gm-Features: AclHuK-3-varx5bWt8ih7prViqxnZ_xC8y4te9XYlRzDSQGlrQtsNA07NVDnreE
Message-ID: <CAFEAcA9Lo63kyMmQqeE_LEzBT5OV-Lm5YoVp05LvPRugrxk_aw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Initialize SMCR_EL1.EZT0 for linux-user
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Samyuktha K <samyu@qti.qualcomm.com>,
 Sritam Paltasingh <spaltasi@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 at 11:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/26/26 12:52, Philippe Mathieu-Daud=C3=A9 wrote:
> > On SME2 systems, Linux sets SMCR_EL1.EZT0 in cpu_enable_sme2()
> > to allow user space to access ZT0.
> >
> > linux-user already initializes SMCR_EL1.LEN and FA64 to match the
> > kernel's setup, but leaves EZT0 clear (see commit 3aad4bc8beb9
> > "target/arm: Add zt0_excp_el to DisasContext"). Set EZT0 when SME2
> > is present to keep the emulated EL1 state consistent with Linux.
> >
> > This has no functional effect because CONFIG_USER_ONLY omits the
> > ZT0 trap checks.
> >
> > Reported-by: Samyuktha K<samyu@qti.qualcomm.com>
> > Suggested-by: Sritam Paltasingh<spaltasi@qti.qualcomm.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9<philmd@oss.qualcomm.com>
> > ---
> >   target/arm/cpu.c | 4 ++++
> >   1 file changed, 4 insertions(+)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

