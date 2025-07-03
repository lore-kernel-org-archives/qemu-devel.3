Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821F3C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGah-0008UH-IQ; Thu, 03 Jul 2025 05:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGaf-0008Oq-Rz
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:50:49 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGad-0000o6-Tw
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:50:49 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-710fd2d0372so6476347b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751536246; x=1752141046; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bNPhw7XgE5bX3PLBlDJTCYk5/d5NJSqKBENsp4LCSrI=;
 b=YNAcIBA68TlXgqes8FVjyZAk0GViCBZVNASyr6+dOn59QhxGUx/GT2C2f5CF8SfFFd
 vfH5ejoYduG5VdhdlLZoNV7RNLnt8+wCNBsYC3X4Bi8DpTaUWtwr5lyilim9wfb7cyLM
 Rfgt76IfZI3xxWJgrsuXwCH4Yfju4o3n1gIPrZXQ+HXvz3+TPWkIxe5v4R16SPaeYg0h
 3OCQdbaPmoTdPoat0RBXpJQTE7WJ9lndYwYSqkgkQe7AvSX2l2pW9Prrashm+aQMcinj
 dQCkIBUdVTjS6RVLt382vfl6XfG3vRPUR/QOOZkQ93qWp6uGEMuwnX92ajWE0tyz8DWC
 8faQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751536246; x=1752141046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bNPhw7XgE5bX3PLBlDJTCYk5/d5NJSqKBENsp4LCSrI=;
 b=jw16ygWiB5Ofc4F5HjAIZFEek/WxVJwuuuEsVyi6obx+UaokYbFMfuChZQX9HnBdi4
 3IsKigshzN0NXhy8VWw+7KHDfpdMv1UsyorF6zHg3dNFxJUg7nZK3tUkHtbTBTjINibb
 6lyhKTXWmOVylSnmoTUOXBF3cG1tKzlEjF4AQTuSFvDOVeBYRLwrrprN8Fit2Ghf+m51
 2LVwj8z8VMksiPqhWS9v5VJnrDMZ82Z0wipN2F+NRGMaIgkOTaLXXct0LCZWXePDHCH/
 1u8ZZuVzVBATF/AbRr/UYuPGKoCYdlJldAIay8IJEYVqksNCEAyQJ0RTTR312GunTcy/
 DxRQ==
X-Gm-Message-State: AOJu0YzPAn41VmxVT9ckziFpAnja1sfwI7PoKHd/KBX9fcfI1CfnqRrT
 de+dvsUAZrOnEcCfxzsAF5ISAeR7aJ061Dnmj+tbIbuUSQEgaxtL4Jb0f7yRBcdTU6ZIfF+Oez2
 15f5kMvNhWrkC4GWu0JIGaqQSFouzzosOIKjG9qBSkQ==
X-Gm-Gg: ASbGncs8aECOHxQ6hOL3RjLSX5W+XSDqPGjYQuM1nfgZFczmj4JF47EEsfDC7CwMYZx
 6wc/NfQWy8/ynFT2kEmqOucGQRnn103tKeiD5K2PuO9OThMBc2xxdof6rHm8vBQ38rS7ugtPCyJ
 A3q+d6Oa4jyUZ1RoIEGrPZ61oMWNK6IhlFfg4Zm8dyJ9jO
X-Google-Smtp-Source: AGHT+IH6A3Crnno6sOFUDCpStM2OnSIzpPSy0NTG9F3uizXMfSxlXHydvzLOQCQWOIcDVGd4Kaj5pZIlYxeCJLKy2d8=
X-Received: by 2002:a05:690c:3388:b0:70e:4d8:5cab with SMTP id
 00721157ae682-7165d018322mr17392077b3.2.1751536246004; Thu, 03 Jul 2025
 02:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-39-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-39-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:50:33 +0100
X-Gm-Features: Ac12FXwfAtilA8WyTw5k-y7EPz27vP7VlFNddFTXcEVHIWm7_9rF6AqJxRrp0mY
Message-ID: <CAFEAcA_Onz-bXJ5k_Th5j4ZEP7pMAFarZOiDvFh8V7cF8cC3AA@mail.gmail.com>
Subject: Re: [PATCH v3 38/97] target/arm: Implement SME2 FMLA, FMLS
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 2 Jul 2025 at 13:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 95 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 48 +++++++++++++++++
>  2 files changed, 143 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

