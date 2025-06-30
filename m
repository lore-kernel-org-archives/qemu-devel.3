Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FACC83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 14:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWFev-0004bf-6I; Mon, 30 Jun 2025 10:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWFet-0004bT-A1
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 10:38:59 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWFer-0002SE-Ai
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 10:38:59 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71173646662so21761597b3.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751294333; x=1751899133; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k3Ylj9DNAVRcWx8IAQeGFYFdFGT0rQPLKF+5ViLJpc0=;
 b=SAqfu4mRrLcu/Oqr8z7PlTEL/LM/S7Xmah2W/MkEjGfmx1/ttQvpXhjKCyINQDiCGX
 GB96KXZDQc8gxmtec4jdi5yxcxGt/q/i5ZO4O4l1flpdObANA4mU2aQe367kDbplyl1y
 m9s5E+DlFHIq8FPr55W4IIz9gCGEZr/dpcnUfXFEMQfEkVI1Lcee/4DS/cU0gfQoukH3
 a4vYs+DNHX/tR4vlKwL5cU/tWHj2LLG41C/bEn8LA/AztQfb8VnI+od8I+4RcBe/l4gw
 tIwyGMia6b125y0ZQCRZitr/qNV+jczKXWVdJbzYQ8l2Ql42b+7Oi0MoUI6W50MRx2Km
 iWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751294333; x=1751899133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k3Ylj9DNAVRcWx8IAQeGFYFdFGT0rQPLKF+5ViLJpc0=;
 b=iSjSbHNzyDUy2PuPlW5jv7vYjlBklFvT5FcrAnGSxByJ5XOeormEls7kO75k0dPs77
 AhbWsFgHJRtdZ8N0CFLF+T8z6oKiFyPY+h+IqbK0YpE6mdqfNoqePM1zjWvI1mvlyGT+
 zZWbT33WsEg3CeACt9FIx8dj9h+ukIilHny/K7ikkDmYWMu3to/A7iapxGsinIarc7Y5
 493wlPTBGic41nYOkcPxHEJodpt2o2j6ZATl1rgQHzEJ4vWBFAWC7TiSUfMEexPItYdk
 IZUESFUBLD/t1GmZ+90gQhjGlXzzmHNN73ARyLX+FIN6REJO8sDYSp75rsNkohfCQhFv
 YepA==
X-Gm-Message-State: AOJu0YzSmEBIAnzQ+rXAP2ob5clY0e0i54NCEHpPL+gkkF1zZ0OSv2tM
 VCLWDHM5KqLifHJ1eMSCt7UKXN+jbRwspUVn3yfFXXnVwgx6pO2tD1TQ9rvLSZ0qJIM+IsqQFWn
 B+2ArYxpvMQjmjtTOe8xMr5tTWbbBRrPNsktWtEkp6A==
X-Gm-Gg: ASbGncseafTMXsvQRaA4+ebFOeSkrv5Pn0TIwG6AQKb/cAUB52HtDt5W45vjXVVoaLe
 fNZAaoAukNt21j2t1x9kf5+/XVvOubxemMQlIrrsaxWohXgZdwRSPehBCSASPefKO+ONebCig+G
 wAbyoP+82PzgS8rgX1jTBgCWEHYBUreQCYBxTT4nk2okxd
X-Google-Smtp-Source: AGHT+IERMjdIrrcT56vEhKEYRHyAbfLdnPK825x7gHe4/xookfFIv+Inx2DeISn1ZEtnSdiU4AsKtuKZFleUobHP4YI=
X-Received: by 2002:a05:690c:67ca:b0:70f:7483:5a34 with SMTP id
 00721157ae682-715171aba9fmr209300037b3.32.1751294332822; Mon, 30 Jun 2025
 07:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250617093001.70080-1-mads@ynddal.dk>
In-Reply-To: <20250617093001.70080-1-mads@ynddal.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jun 2025 15:38:41 +0100
X-Gm-Features: Ac12FXxEDR6iq1R6nx6Fwax_ZAhLGuzmAhCn67-bD6WdDIdp2hsVNIYLj8ivxag
Message-ID: <CAFEAcA-QZjmmkD1wo+hs4wQr94u--J0qm8arQbnR9VH2tuT-mQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as reviewer for Apple Silicon HVF
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>, 
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 17 Jun 2025 at 10:30, Mads Ynddal <mads@ynddal.dk> wrote:
>
> I've both publicly and private been digging around the Apple Silicon HVF code,
> and use it daily as part of my job. I feel I have a solid understanding of it,
> so I thought I'd step up and assist.
>
> I've added myself as reviewer to the common "HVF" as well, to be informed of
> changes that might affect the Apple Silicon HVF code, which will be my primary
> focus.
>
> Signed-off-by: Mads Ynddal <mads@ynddal.dk>

Thanks for volunteering! I've applied this MAINTAINERS
patch to target-arm.next.

-- PMM

