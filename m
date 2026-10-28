Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C80606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o++Ja867
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6m1-0006Vf-K6; Wed, 28 Oct 2026 12:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xM6lz-0006Ub-9N
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:45:11 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xM6lx-0000go-Gz
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:45:10 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-3ab3dd966e1so9540811fa.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793205908; cv=none;
 d=google.com; s=arc-20260327;
 b=B5cgIdPGnMN7UmsCDYKUGQC3qGeDcdj1QXPIpOPdzNHW8ueIwMU4p6LjXDPBYqMNww
 HeFf+FL/ICw0Qt0VFVy807dI+dmxMItqKYrrrocJ++qNV8uB/hCR32O20DjK0/I1k1U5
 HYjOQ+k3Yd07H0htPLrzhcIfF2FMhyItEeHUgMptFu+6oMYMv6nDS2yUHH0vZJzgCZ4z
 ZW4XLHaj0QwRuqU2GwYH+tF51fCD70m7mt0/17zi4tEr10PEjLd8PEVaqGSuUbAl77pp
 BRgCpQWIQzaCveorbz587qM7ff18cJ50uLjj75w+kf5cGw4tpYGeO2MmJsoEpYD1/OV0
 pN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y2eCNQ121cuIdnChL893vgXFWM5DPqEQha4s/pRzVP0=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=iH4abp1DgK8BQf8sNLSEqnqJmsTmEivbxrLyHMslyxKnJZR7POncYq7TUZ1QdKrwv4
 KuFjDKd2G9IjmHyx05nXutytmchwNelW7i6ekK1P4+Kbw0Gyl1HnJmRwlplPKMFkFt0v
 KqgL4DsHepXILbpqpPIEB6ZHNFBJF8j/M+CxrB5st4njGMmoVAqZY0zBnB+JyyQcO/F6
 5+NnjP7qnYz3depigQ1aORdaMNDcRs6y11EfnvHP5E9RMTviRIkRF/mdjMWKmYGTDPIU
 8RO6L1YERKMyVhQMnwz4v6sTu/4Ej0vcfHJ4E+trZWF/sSMGfZbsQCF9clAQjzf35biT
 Y8Ow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793205908; x=1793810708; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y2eCNQ121cuIdnChL893vgXFWM5DPqEQha4s/pRzVP0=;
 b=o++Ja867eUxuBJgtqF09CqFeIxl+6+uR9KwFlVRKHV3T+jmZBUlZOQyjFf9tk/BZhd
 SDdVXZOpDpkDuRtotedXOiL+wR7qn6KpHDyR8ViVFnRA2VA+8N+SynUO+YpPFm1VXfWD
 nS2hiSHe9wEAn/z9xmC4Tfxt6NRpB0RUuL/HjGPlYmTf9/zL4GORz4VzZRZtxN5xDTRQ
 d3hfV+wHocxgP6no3k3CnWaD26SeyrneVhn5rLCSg4n7IuQyWfAa+PO5cbHThtvyx9q0
 dwYaLvhBzUgE15FjKbgBILKU/epxbCNJeWofpKNJ+cmDcvAQabHBvP6UoKXGIh1tMCFx
 X3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205908; x=1793810708;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y2eCNQ121cuIdnChL893vgXFWM5DPqEQha4s/pRzVP0=;
 b=Z319toGsw6YyONVQSQYD48SdrTID//HGefEXIRb/d6v/LChbBhnBX0sk6wKIitVoO2
 wgT+SsvvhazZuBOw7eyugEe3OKhuUu0hwD0gHH2h30fSSJdoXacd4YF2dfl+Ovm/nLFY
 PxMwnIPk+qWoiacjEW0PiS3ZU69zA5Aa4CMm+aDZDyGy6Um5vUwPsfcMNBr/vjHPo950
 Vfqvf8KACsB23mxutcSQMYUOgSWr7iPWx5+MowlqIO1wcS9sm2Hk1UH1iczwQKJmpXAB
 UCgI0VPrgLXKd/th7EAn6qjfY/kgWVd8qldXMuaRV2w0fMEHdwXNcIUATW088OY60X5+
 a/Kg==
X-Gm-Message-State: AFq9FYKvjh+L4VM22G7EWpZ8/YWKwH77FuFnZVgeMCRfIwVcQeCeYsep
 oj5+y070ENnI6ycdouYH1zIdElmE/6D0BjnZpbtRg9fmNXQCUr4jRMi4SOZy8EwmyB5xRJGPNj7
 KQ7S/orXZrJzEkSuaolR71ty9EMwkMUQ5xMzZ
X-Gm-Gg: AYBFou2L8vPZev3HaehPUnKFk0ZOQjEL7EOWQM3sjDFOl8rTcBhJg6i2mkAU/JXWpVP
 PfBSVtLrW1BZVZ2Ck1FIOam/2n1hUmvtPcoTDRkrJMhzGp3BTQrNY1TszD+iP8IAF8Sax942m1N
 QdELoQQM/F6uhRik0XLK4NG8MvoyFmxOg1Xc6YW4BC0laDSD2kJnEanQOPDjHC8tDBFp2LEuL7F
 tnwTtlv5F6cco2pTul6ngisGG72gCVmCmEzJ/ZY+l5AvE0/HLmt9NaeWAkcBsPXcb81jXuB3PTL
 dn+Z+RYCO9j1Xd1rqH1/VZhzyAZYxcb40KpHJojdsX33BIusk9B7Gh4KniJmuXTs/LlC4rbYDHL
 AA+3lTg5xz7D09VpsjmTy/XSaVwmhcZzLvCHukgk5NfMrP07rpH/TCwdiZLYwEXC5sHW4WHeJzS
 7GuL+FQlAlCIdORWNoTjNrM63d2WXyagymDerxGia/NTX55ajT5wYd
X-Received: by 2002:a05:651c:1994:b0:3ab:4eb4:5f19 with SMTP id
 38308e7fff4ca-3ac9cf7f751mr7223441fa.27.1793205907434; Wed, 28 Oct 2026
 09:45:07 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
 <20261028163245.1031673-15-richard.henderson@linaro.org>
In-Reply-To: <20261028163245.1031673-15-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 28 Oct 2026 12:44:51 -0400
X-Gm-Features: AclHuK86HhizvGxbhC5IpkwMBDW07SOO9V7TAeYituBySDr8CY0avynO-lAY1LU
Message-ID: <CAEdQ38FZaXoukNFLjCO5+eq4xw5JXF7f52LsWCkw6SFas3Mv5A@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] tcg/aarch64: Implement INDEX_op_lea
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 12:33=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> +#define TCG_TARGET_lea_sh_valid(type, sh)      ((sh) < tcg_type_size(typ=
e) * 8)

Minor: tcg_type_bits(type) says the same thing.

