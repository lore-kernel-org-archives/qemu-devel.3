Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DAFD132C9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xJe-0000KZ-Ev; Mon, 04 Nov 2024 08:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7xJd-0000Jp-6q
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:40:21 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7xJa-0002im-5N
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:40:20 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c95a962c2bso5794906a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 05:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730727616; x=1731332416; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xZzZWomi7E61nalesQ7NCm3j1+4saL0Ju5AYCkvIeAM=;
 b=PFKXvpXLhFqIjQ7yI5VnQzkT+UNYhF61RuO2HQw6pNuwTX2uiEsVThQvrMDmorSzWS
 0YKhZCPIVm19NPpZ/ZKNmbdBuZgxXoSRMkesqAUvR6Gq/grHCT6HhPSyQrNjTwwTgua2
 ic7w3sX5hgGfNoIRzj6+RQWFh7oVs1UPDiRWjobLKxwrQiC2nIKZZHh9F5uq6FwibGJJ
 56h7xbWdxMdtsXmsNrT7z4kfwe/evd3GRC7N6WomU3eawcR9/zAu5+8E1u2pSXTcu1zW
 Aj/aEV5kJQ1iSYEGH8c6z4NKOIv2vug68aulviNWa9PT8cfvxY0f0lMq4NyY5v9aHdTt
 qacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727616; x=1731332416;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xZzZWomi7E61nalesQ7NCm3j1+4saL0Ju5AYCkvIeAM=;
 b=e2/EN26I3lWjugyq+7Fbl9/ZLv51EmO2XcLIwh1nU6UwSz3R3ivBw2J4qfl+6YhCTA
 Cv67PM/79rr5lrMSBsM41UIC6piilfWilbY5mYCHr3JOtZ0kPheEPzWuntUFouoV7jB8
 4bTbg61BiUtuJWL1KmtDgJZQMGqss3YmsflUV8FmnfrUO3RsnuLs56N07QeM8jtKjvvi
 Pg/9gwCQ1GtPdISalKQuZGUEC6Jrf/VWJnXHowORWKQLjz4OVULl966BvBXfBF1QBDJA
 dcJZk2XdHJeIZJd248hwvFGO/9GSEefWagJgAKrgHsaKPSHjpZ0u8SAO+JS01b4l+n9A
 FXfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqr4xbIBmf0iQ3axBuiG02+qQYIekj5eP5mdWqGCV4RzBsY+htRPkKPBROifQn4XjQAUGxuqUwsTz+@nongnu.org
X-Gm-Message-State: AOJu0Yxeizq8iQ3OgXmt3s04QJxeHoygu92BvPSFTidrXGnsoY4ggxNS
 LxnNOXVnDrhGWZW1dZbYqwwWM49zKmpFCWrte88dBMXw3ZraaiimvCFLoeVdo3Hf4v5QwxSs69E
 1Xq4irRoDuAIrrYSpBQdwUeLMnMpMXI1ykkphbg==
X-Google-Smtp-Source: AGHT+IEdNLjWZygoDVHiU6XYwXeyCG28+MtvF7gNTRle8C17j/YCMsYqvKyy2fJ+gua2ePB5m2azI3hyhqNsaIkrdzo=
X-Received: by 2002:a05:6402:270c:b0:5ce:cffa:41e9 with SMTP id
 4fb4d7f45d1cf-5cecffa446emr5160611a12.15.1730727616489; Mon, 04 Nov 2024
 05:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20241022013047.830273-1-richard.henderson@linaro.org>
 <8becca82-a708-4a19-9f67-92b4a418b6a3@linaro.org>
In-Reply-To: <8becca82-a708-4a19-9f67-92b4a418b6a3@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 13:40:05 +0000
Message-ID: <CAFEAcA-EdpDCfde=zFPnq1uKOBk1qqe7wNh8dp6ziG_79o7vew@mail.gmail.com>
Subject: Re: [PATCH] disas: Fix build against Capstone v6 (again)
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Sat, 2 Nov 2024 at 17:46, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Hi Richard,
>
> Sorry, I've missed that one and just found it when doing a
> check before the soft freeze :)
>
> On 10/21/24 22:30, Richard Henderson wrote:
> > Like 9971cbac2f3, which set CAPSTONE_AARCH64_COMPAT_HEADER,
> > also set CAPSTONE_SYSTEMZ_COMPAT_HEADER.  Fixes the build
> > against capstone v6-alpha.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >   include/disas/capstone.h | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/include/disas/capstone.h b/include/disas/capstone.h
> > index a11985151d..c43033f7f6 100644
> > --- a/include/disas/capstone.h
> > +++ b/include/disas/capstone.h
> > @@ -4,6 +4,7 @@
> >   #ifdef CONFIG_CAPSTONE
> >
> >   #define CAPSTONE_AARCH64_COMPAT_HEADER
> > +#define CAPSTONE_SYSTEMZ_COMPAT_HEADER
> >   #include <capstone.h>
> >
> >   #else
>
>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>
> @Peter, would you mind adding this to your queue?

Sure; applied to target-arm.next, thanks.

-- PMM

