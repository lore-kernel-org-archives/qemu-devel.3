Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969BEC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OaN-0001Ci-95; Tue, 21 May 2024 08:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9OaK-0001CC-GE
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:27:16 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9OaI-0000so-Tk
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:27:16 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-571ba432477so9692240a12.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716294433; x=1716899233; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4ZM+LtYxbuM9yFpWRF5JPDKaW85G5ryVOT1vlUCxbSs=;
 b=YhJwYT3AIKsylBTPpow2GUhUs+mxYESTKHEIswVc5NCrsbzK/yEhBp+E8rrikeHEHK
 GPdjCcodkoUgrzraiyYLOKFNl6pO50O5bXWN3RwG1fyBD9qTUsES/k21srXmoaECGFfZ
 MbptESiSEkYdDVsvx8D2lxI881LfGvluJ2vBvwB08cCHUNeVGQm3BDTZCluXHZh41TdL
 lIbtl6VAVOAJCVjWwF4sL1fZJt8ZMib+GyQ0NZ9aiLVfWnlQtXwwIBV7HaFV8B1fEDQe
 XBnqkrM+RSeNCznOatuLCr3aBS4DayKM2LACqriywpy+12EZSLa6KOx4Pv+n1nnCfi0z
 rGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716294433; x=1716899233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ZM+LtYxbuM9yFpWRF5JPDKaW85G5ryVOT1vlUCxbSs=;
 b=OWmvWKxX0rSsIN69EM9bKJ4+ULHkmpis68tHCDY7OTy4BrpSrfFGi72NWojODNvuam
 sqxhQsHDkp0x4FXfz5AVugfoOHQAWF//XdPfPtMv0xo386CBpwe5M7oRPC+XHwe2ilUW
 rJAs3JzvlrQWzuBexAx/iMC4S5bv2hogFYdheOoWtfOpy0JY14Ae4QBoI8lcYwqUdZ1c
 V/De48yRPUE7gwWs6llpAOG/aw9jU1OXq/oxPjA8v5ZfGuWlq1lHX2rG293PmufGvoY7
 ZTHqzoR9Yaw/EluTa02GfUk2jYYjokgf2BUmW50+n9W6IikRq/smLU3k9FZzYbC4/JsY
 IjDw==
X-Gm-Message-State: AOJu0YzNWY9V7GpBVX81oimKzeDO5yXdoA49A25gpdYxqdYxqmPPL4Qn
 7Uj0nrfcgAHGWYdBFfrVykyr0XDYuMoJDL0YnLtlnfAmY0Gm2vhE+Tt8LVdiAjfZlRONgCETpbs
 ygjg/MR7E/GPElu4sfQDEc31Ufy/mXhG3MI1xjg==
X-Google-Smtp-Source: AGHT+IGsGqXFeyg0o0AiLGSUdKmFf1SU3NzI+zQdd6loqfp4VByayDtvy/ZXGpPuJX1XiqjMsyZNhsDk/NewxTQ45JA=
X-Received: by 2002:a50:cd09:0:b0:575:96d:2fab with SMTP id
 4fb4d7f45d1cf-575096d309bmr10620875a12.32.1716294433415; Tue, 21 May 2024
 05:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-13-richard.henderson@linaro.org>
In-Reply-To: <20240511115400.7587-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2024 13:27:02 +0100
Message-ID: <CAFEAcA86+sP9NKMyWnCHCiem=7jBjYhg5LgT-bY0pZ7N8ykMyg@mail.gmail.com>
Subject: Re: [PATCH 12/17] aarch64: Trivial SME test
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sat, 11 May 2024 at 12:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  test_sme_aarch64.s | 63 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 test_sme_aarch64.s

Looks like we don't have makefile infrastructure for building
any of these "trivial test" test_foo.s files, so this is fine.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

