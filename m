Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2E8C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCYs-0005MZ-Hq; Mon, 04 Mar 2024 12:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCYr-0005MF-DF
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:57:13 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCYp-0005CG-QY
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:57:13 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-563d32ee33aso5941895a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709575030; x=1710179830; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GL3aiZiJM15uGsxD3QqB/zA+pota5yeZ+pRdMpkByf0=;
 b=t6yIZa58qM7wk8gaLLWJHucogEpbOTV2Ij8mvSBTE6HC2TKJkdsGb1XBHo5jABDo+H
 8SUogamOLbShW0HWhtReju/GUX8hVHMQMdji6ccWRSv6nck2uJthhrBKwDaC99sH9Zvs
 Q5S8slTHn1IqczFq+LScPMIS10XBqEJUNZ4bpvdAnWW2u4A/kUFHBMFAccvsk565Xo3Y
 8uet02s7K0/4fRaA/sySCWfUB6/a0CRU2RUtRqJaiGneZXxf/zVxFHWl8Au6DBB4DMQ6
 u4+fgRYL5Jy4DoDpyPyAeRdly7yXFrajwzkwNLDLVR1EQsVnd5A2yoV3MYtBLCTUZD+3
 LUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709575030; x=1710179830;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GL3aiZiJM15uGsxD3QqB/zA+pota5yeZ+pRdMpkByf0=;
 b=IRtItvXspAyQE1ozLFie9KMgAP0UViegIaejhl7YZuc2ce3sc8Z0P9T/B4EQaoWc5d
 nlo9zxzCtaDZLgVbM2+pfUXzIskmWC0YAdKbcE5PBOdaK6SAfG0VCNYzWFb+pKVZW4cF
 X0Pb8NGAcFuy6j0CPpHzg60xBOjllA7Y+QRsLd0oR+kj/SenhFhguLeOMHmTISm/jaHZ
 NjozF/YQr6Ugr10/rhE4QQlCiG3fcpoYMrW9NhTTG0auBaAQLU5h2jCAOp0Y9kOFCuQz
 moGR2QXkySgR6cveR19WA3SBSoV0znu1Nc3U+llv1TRHfMsiEm7thA/E0F1hg8SeV78P
 yXDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF6jRzWhK89VHS6QtWoMu4eaicegi2lJKbauJDlsWth6UJ/AYr+n0MyGPNHkstmdvYnpF0/v2+ZmDB2ga1kgo96YDggp4=
X-Gm-Message-State: AOJu0YzygwPspQlEmrQ/7cEZvRiCs433g7qzHuWQIuwE6dnxdjeG6XjB
 6FSe9CpmbRLUfJUS4CajLd1Y4sNqksVISLsWMN4ATTOhuGGz6GNyIXPgMB/SaHUPSHBonpL8gNt
 IJheutiX01kmuQTRcYOBKEZvu0HOeRKGWjhMQIg==
X-Google-Smtp-Source: AGHT+IGyE7me+zybtlBc2VbuZDZ7ywBafK1J84/K3Ms9rd57UtnsahmHDpwCwxRupHKxJyz05jn5Y+Ce+sPPfyr69+g=
X-Received: by 2002:a50:bb68:0:b0:565:b934:3301 with SMTP id
 y95-20020a50bb68000000b00565b9343301mr6945854ede.16.1709575030213; Mon, 04
 Mar 2024 09:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
 <20240303-elf2dmp-v1-4-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-4-bea6649fe3e6@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 17:56:58 +0000
Message-ID: <CAFEAcA8TmKAPU_egO5tkHHFEodSJX_yssqx9kWaq=+tS1mrxnQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] contrib/elf2dmp: Use lduw_le_p() to read PDB
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, 3 Mar 2024 at 10:52, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> This resolved UBSan warnings.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  contrib/elf2dmp/pdb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
> index 40991f5f4c34..2541234205c3 100644
> --- a/contrib/elf2dmp/pdb.c
> +++ b/contrib/elf2dmp/pdb.c
> @@ -19,6 +19,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/bswap.h"
>
>  #include "pdb.h"
>  #include "err.h"
> @@ -187,7 +188,7 @@ static int pdb_init_symbols(struct pdb_reader *r)
>
>      r->symbols = symbols;
>
> -    r->segments = *(uint16_t *)((const char *)symbols + sizeof(PDB_SYMBOLS) +
> +    r->segments = lduw_le_p((const char *)symbols + sizeof(PDB_SYMBOLS) +
>              symbols->module_size + symbols->offset_size +
>              symbols->hash_size + symbols->srcmodule_size +
>              symbols->pdbimport_size + symbols->unknown2_size +

This is a behaviour change -- previously we did a load in
host-endian order, but now we do it in little-endian order.
Which is correct?

If we need host-endian, then we have lduw_he_p() for that.
If we need little-endian, then maybe other parts of the code
also are loading data in the wrong endianness?

thanks
-- PMM

