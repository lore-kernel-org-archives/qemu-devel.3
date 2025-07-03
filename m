Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1DDC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHIk-0002NE-0T; Thu, 03 Jul 2025 06:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXHIh-0002KF-0z
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:36:19 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXHIe-0001b2-R0
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:36:18 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e81749142b3so6181366276.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751538974; x=1752143774; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KF6zoX91AyM6LhsFaWF5PbY2Ng+TsVki1uz84skKwBI=;
 b=qnnWJIfViFeDm8W7z0TlDd4cAh02ODq9K0BoozTj+uF/4CeDIHA+hrUP1NQdM4iQ8q
 eNbWQ2xINi8NbiOwGJSpGYsxFmumx/SEYHd0p/E9quzQgAfy1piRg+4nFxWsn5N8Q0Hl
 cPDRInzd8usW/EINNYNgFJdHFqBFaGIbiewBM5l1bDB9t77ltGGc40MGgZUv5K8eWETG
 zdXjR15HuZWoyqW2EFvKic3vNtWwafaz82nBZBvCJ1hLU616HkVUpUFtzVJpxNo2eHQd
 DJ2I/t+hGHPmSyZVd5sJbO1iXKPodUyXR3rNIx2E3HljUBJ+iQ4C0eh1EbEbvXI8FROT
 ZidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751538974; x=1752143774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KF6zoX91AyM6LhsFaWF5PbY2Ng+TsVki1uz84skKwBI=;
 b=mIPASlBZ6x58Df++dtH925pc9TImKrpHOSSBINw/qfOuxCIAlm2fPm1JTD1Zc5bHA2
 WSHd+6lRKXmtKnTL8dt5d7WrOCQSA2fRsSVBPKoikSK6z4i/891gp5GxFEEyiytZN/Zk
 THJiuFlY24fq2QAPtUoUwvSQdmg9zhknONkSJB3fx7nQdLccBU6DkQdCR1R2qeS94p5r
 yMo6Y6Cmhwu/KUmksBYHnzHSonaxzid/B2inJhP3zVO4zL66mDIdpObdb0EQXfNEbvLr
 CQU0zOkrgsYV7zli8YdNItbXvNyG/HfGTlMnTJA8P4bunfBUm9WFVUiU+VSrnypq4evR
 /XFw==
X-Gm-Message-State: AOJu0YzvT61GxiXqakYPj/UM9M5o4vGHjyHfhYow7l2DM/x4YA82Iybf
 XvuEyBADBjD42GKegNCr5Fik7d2idziccTRFyEakc7Q8OpIgQ/GerUzsG3AdopOaCNLUmHPIehf
 zNeIG3iZtRnKdOI0bpOGQGJFuBsRYfImpS7p/r+cn7A==
X-Gm-Gg: ASbGncstm05oMpP8+mhV54IqaEQZDUkCdp8yIC4HRA1/2/kgMBjH0er46SFLbqjSXAi
 KykAZM/oiQ/CnKb45EPe+gNErmYHvD0qEVVsNT5PJ8A8yQiOchkm42ELIj/1VhczBQet6QDdMzm
 rJG/WagOgdXdm96aYOjUuggRVi+TcZEMP+0HTUIlkR4Z9L
X-Google-Smtp-Source: AGHT+IGuqRzNko2DeDZtMftFH5JmesNgtXJe00Dg3Zl0P91tBNcmj/lneX/e0WJMZVws6N2AMIi9MCHPIzAkcKk7oI4=
X-Received: by 2002:a05:690c:8689:20b0:716:5986:e4c7 with SMTP id
 00721157ae682-7165986e512mr31052747b3.11.1751538974362; Thu, 03 Jul 2025
 03:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-62-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-62-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:36:02 +0100
X-Gm-Features: Ac12FXySC4Att10MwcFNYdvmftAY2lt-q2zsS9oXeKMQ5jzheEpgPC1jfmK6ITg
Message-ID: <CAFEAcA_W=Mf9odOjV4d28M=MpC27GBFz0i_Uj3JJ8Gp2GzQJAQ@mail.gmail.com>
Subject: Re: [PATCH v3 61/97] target/arm: Fold predtest_ones into
 helper_sve_brkns
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge predtest_ones into its only caller.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

