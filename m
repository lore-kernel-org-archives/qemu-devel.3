Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE117C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGJY-00073W-Ob; Thu, 03 Jul 2025 05:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGJV-00070c-Of
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:33:05 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGJT-00012o-Ae
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:33:05 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e81749142b3so6135759276.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751535176; x=1752139976; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=26QHZQPTntyN3BkXTjCvYecn8ebMiBue53nPN4y+JeI=;
 b=Ppw/mJUxSVlFl2xLEny1vlbnNAddpyZvX3F/EFsHUykPB0N0wI4B3/hb6RmWvvNQYw
 2c6RK+SdFi+r1JejPYB3rlrFkxaba72ObrXjW23dtOfX6F74ZfPyDSAiBYCwxoPt4xwJ
 0y1TA2AWIBXMhzfHibPa8IZf0+KOdKdfxx1iJt84sLTf9IUwPaWqCX0ywdS//HsRgxH0
 XDRvPLzYNbr6IXsALCLAmr6Ra33vqDTKw/qZpqglarCt5FiwQQoYgBy5miZJef02AI6h
 OKLn7ly0zS4diBWApHLtqO27EVDPh2eigYN6BiaQxhFK3Mi2Qgghl908QGCW2dr0ghc6
 IXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751535176; x=1752139976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=26QHZQPTntyN3BkXTjCvYecn8ebMiBue53nPN4y+JeI=;
 b=U5MavFF5Ilqh+gW/wAab25LT9q0vI6VxpguK3Vbxpw8ZhnIeenFQBEN1I1RfDKpvny
 e1d5LwoRGxOMLIEsOryV8qHJ/631X2NR6i5W5WvpPyzBogi6eZWy1tcAEDFJZ8E+uboI
 bet6I6zse/vZ7HT8psB/JVCM185FS0me3QMQIleu5ccqqNwXE2UjavcHAugHWQe0CkMV
 9C7kPNsaKyKOkho6rId3dXG+43jbiWvClsBfrASk0U8IylpJRuaWs+9uT4+foe49Ijac
 fMImpVddlUSiKJmeOIHWAleVXdSx4aIEaMpiciOtY8iVyRMoIewhOdbCSLjYGhWcGbTb
 ouuw==
X-Gm-Message-State: AOJu0YxzS1C3GyPFlcT/GKnP2ZIz9onnGcDKtXXloLHVWcCZjP/gzJnh
 s2bQW0zF0OW72IECg83ATEAdBo5L0OsQhngRu6wIFucj0RnlwcXgJgEEcBOuFLLXmpLexr9nVnA
 IWXWar+or7Te6Fv4HlulM42tpX4iyp/h0fyFJE4ygiA==
X-Gm-Gg: ASbGncvPhwO7tKuMMPk+quR/5Mv0oPDdQAfm0rKKSF5rsLEiFm5ddiKDta0pHUl1Nkq
 yHP89ITT1Ac652SyPZiuH5kBIxZ2e7QRnUES2lZ3Vp60IuicZwNY679wLxZb82bKaJC6EbQyjVJ
 7LwzR6RrUCT/ze1mttwJYxDMmRSVZtPHhDyj2DNW9oEyvn
X-Google-Smtp-Source: AGHT+IFxYzA9V65SsYl8384U4R1Ht3nD2pxsp/rvapbsvheVv6VnIi7wLOq+WT/aV+U+FUvaNign631GY/zavwyuDdM=
X-Received: by 2002:a05:690c:9b0f:b0:70c:b983:f058 with SMTP id
 00721157ae682-7164d3615cemr83412397b3.14.1751535176292; Thu, 03 Jul 2025
 02:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-7-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:32:44 +0100
X-Gm-Features: Ac12FXzD_0HPfTKeXYFP4cQu59Ilfczv8cwSxXTb8KIf0gR4jCeaejDxFUBOq7w
Message-ID: <CAFEAcA_vC2-zJhbR9JuQHTJ3BHsoCfC+uUT62KgV6PTYuxsujw@mail.gmail.com>
Subject: Re: [PATCH v3 06/97] target/arm: Add zt0_excp_el to DisasContext
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Wed, 2 Jul 2025 at 13:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Pipe the value through from SMCR_ELx through hflags and into
> the disassembly context.  Enable EZT0 in smcr_write.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

