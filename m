Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43EC606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zAestnSu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ6q5-0008Ro-6B; Tue, 20 Oct 2026 06:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ6q3-0008RR-Fh
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:12:59 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJ6q1-0001cg-TK
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:12:59 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b0f59a5fdeso22275187b3.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792491177; cv=none;
 d=google.com; s=arc-20260327;
 b=cRDg7GFED2mY7CzNSdnU7z+bG3mLKXDywrFqIM9BRyjxzn8Tvp5/62wd3TlClpkjqS
 CtydejOSixLbGlvnwC62PISzcSY/hFSWDOB471i9rFJPVyb+TxA6c9YN0Xz86vQuGVHN
 WzHGUo+FxtLihlGl2T2AzMOLcu4Hya0k+R5cGkCmv5bVqWL4N5EWZB1/AfqgdecbuMn7
 S+w82KuzYzkLSJHgFlkMeGaxgiItWdPbeSAIutQDhyHv+vhuIRfLfWeXJZuamAgKg/OB
 ZUCs0CdKq4MqNm3PVXa0O/6ouY2DTMd/mr8Q7eqZY8/1dKYZN0zUNkT/ODcIBh1nj89d
 6fqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pUCX5zCPpKMJHTf2oz5CuFqdtYBubbiFISxr1VT47x4=;
 fh=ph+ryZKmumhAj/6oVcMwnyNyN3yJgWzyxDSSIA6BwSs=;
 b=d3+DPZOVHLIjt5nWw1bP8SUe0dgsIRyCrqzjlRTjj9MHB4Yx96gHKCP8UtFOPaG/Xs
 adTJd34esMZM3GgXCQiySdKlhiHry8RGQ/WYNO97Mu3j1StZuSp5iIKyC/NM1ZwE4Jgv
 OEG8j88ontkhhOkOnWEGfZnfN2d/NPLV4IoiOlJJ4Ky+ot5utX3PR88wP+k4K/s3wwk0
 YK3pa7y48bj4uytlZ+nf8bYhFa15E8eCNYzT7weekn0WLJS9BYqIWF8kxG2gbheYTWY1
 Lm2DhCutAvKpRwWWO6+rUgziqzy0MMBPAQe8pfqRW/hNrOocafVwXSx0kChlWHXc2Iwc
 Wkcg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792491177; x=1793095977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pUCX5zCPpKMJHTf2oz5CuFqdtYBubbiFISxr1VT47x4=;
 b=zAestnSuQrXzdvi4hgl7mQ+CqDFbEt7ZsdshSe7rd4Y2EOSJwSVmdUf8ysLl2uWI2C
 zqYklEc4GBiMZYacz1b3Lj6SBWtOWdTWiDVqGhQUnSRXOntSeg1TXnRbuCF3sJeZS8Yn
 R85KYyG9X/R0OrarTzsekLufO1HqFUswaik7zX+X7nFeteNZZKDH1dEBSoEUoddovGy/
 Yx0jSoh8Ck8f/uF57iutN1e54jvkCAHs/WWe6BTq05YwYnYUjXBNmvmnfld2Zzuf/Jau
 pfvoq6bTJzpV9Fjwi+Vyda3omTd6pxCQuw9YaOLlqavlQhfKeZrjAkwcYwNsoZUqxsxc
 aOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792491177; x=1793095977;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pUCX5zCPpKMJHTf2oz5CuFqdtYBubbiFISxr1VT47x4=;
 b=oEPBlc4tREFGzYOpQ4rz9PtXAUjmEhfMxlHldr3ifDzzykGxT0zPGWtySCuxkvrEBo
 Q005+XgPq2qth+6bkCcC0EtsObsn21WR4KRRgcbBbe9PqDrhzbXQijdprtMG1lOtdCXS
 Iz352N3tn3azqkaM3hyFUa9jZmzRI/oFImvfzdUndNGOPqMrM86spNg8tyPTBf7313iz
 sqhlCGpPUqtupAH/JOSG9bfFChULC1QFxnNWdAXcp56t5rOdpq8wAD+OtiYSiJswBj+u
 WS0jZ8oqeDWORNv0ISF3nqtrmhueP65SSD7pDuHRc8MtQuGwoVyQkr3hp5YYGtgCtdJf
 Msvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwfY3peSwQWlWCFtXyoMWwTjGyrnARWxJdWAsVzlIRI5fCgFdhaGcwWiDP39Wj1irn8htY6iXI9jML@nongnu.org
X-Gm-Message-State: AFq9FYKKRUSOf4rQt+u+8BxwDIzU+BrKalmLWFLUfeDXhGmFZGLQ4qEu
 CMdOGcp+CWI44dAzUaSxzeP8tkLTpRe1D8Qha8u+hJy3AyESii7JBhZ+21Cm8yelU9XoxSkB3xR
 ijIBm3B683pyXj7ji98YetXe3YoxD4GOaIr6AH+j3Tw==
X-Gm-Gg: AYBFou2Xgr9oQdikNsJgItBS5wuUx0SwEtxsiKLcX8b1C3FhJqWUh/S4J0P11oHOQ82
 s62iHDRKBI5nje6V1GqQe4TuT6DaEDWC9bOH8BbwYU0r/tYCKaRbbrq5NgFjgUl+iJZkz7QfngB
 sDOXsYJxKdjkabyMDsxZrYjNLqn0HohTF4L2i2yYRKgaSNTSEanIUhqKxOR2/aMWb/UaWyc9xpd
 4HudYLGvAxzyp+hfkCkf3ttRdcjUGUChCMXfGQkOx9JmSH2e0wZRbm1sxVeIOX7/OEc4Wzla3tv
 ILG2kSQA6ENGngq3TFwJhXMCsiMPd0+dpGThFTfCR/q8tT5FFn9HmFBni4xV9IXu0ekVMMFWooH
 Aw9NO+L/8UIr/+UyPYmXLFynUeYZVOfWsy+2nqE7woCq+LBArow==
X-Received: by 2002:a05:690c:c6cb:b0:89b:6ecb:c33a with SMTP id
 00721157ae682-8b11c7b7ad3mr5485507b3.60.1792491176610; Tue, 20 Oct 2026
 03:12:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020033755.2618640-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261020033755.2618640-1-jamin_lin@aspeedtech.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2026 11:12:44 +0100
X-Gm-Features: AclHuK9evmsUed6Z4ov0yT6gdM_4pxGAcgePE51_DqHNRdoC8b3IFzXVca7Z09I
Message-ID: <CAFEAcA_hYV_MzAD771i8MyX5NJozq=AuvT_v370udEqqa59O7A@mail.gmail.com>
Subject: Re: [PATCH v2] hw/pci-host/aspeed_pcie: Fix global MSI setting during
 class initialization
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>, 
 "marcelomanzo@gmail.com" <marcelomanzo@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, 
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 at 04:38, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
>
> The ASPEED PCIe class may be registered for machines that do not
> instantiate a PCIe root complex. Updating the global msi_nonbroken
> flag from class_init() therefore affects unrelated machines.
>
> Defer the update to the per-device realize handler, so the flag
> changes only when an ASPEED PCIe root complex is actually
> instantiated.
>
> Reported-by: Marcelo Manzo <marcelomanzo@gmail.com>
> Fixes: f002aa35f320 ("hw/pci-host/aspeed: Add AST2600 PCIe config space a=
nd host bridge")
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/pci-host/aspeed_pcie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

As reminder for whoever picks this patch up, they should add
Cc: qemu-stable@nongnu.org

C=C3=A9dric, I assume you'll be taking this as an aspeed patch.

thanks
-- PMM

