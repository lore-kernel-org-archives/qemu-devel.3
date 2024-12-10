Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC42E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 17:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL3xs-0006zo-9a; Tue, 10 Dec 2024 12:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL3xg-0006xt-UX
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:23:54 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL3xf-0002ft-IT
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:23:52 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6eff5ad69a1so30810257b3.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 09:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733851430; x=1734456230; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MkaK1+UaiT90ra3pK3kV3i3Tmv4DsRh6m9PQzMu9wXU=;
 b=f9s9lpPNRnsuTlhPzHXjXCNJlY2TzeSYJLdBDJbDzclPXMOCQns5z64bLg0EkrbaaH
 j8PypAQd9nlT8l5C49vEaMkuO7+dktMD6oFLbuxR1FJt7tfN5L+ZdabQFFKQCRBoit6t
 rFZnSuXhbf+pyo4IWJh3lkKBDIKr3vPNijuo6eLn1GtW+wI29hH6SwXfSpZeKbWzpg6T
 dIBfROGdAPLcHESqtpmyk3FLCsbkKAhcLqXBaQViRxUnFUjcmUS3lqep4pG16myG2vdy
 6dQI85YOqYwhaFXSOHjKOeELwmvKWfo+qqKAH70R2QTyuA0LSJesR5CizUBsWu6UBRSF
 HwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733851430; x=1734456230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MkaK1+UaiT90ra3pK3kV3i3Tmv4DsRh6m9PQzMu9wXU=;
 b=g9MplqKgV34JWSPHF+RX7brsJZM/6pLbzOUko2bFkN4/2I6FnfWVw4NYIr7VbKoM2j
 9cQL1d7kP+fS81983dBcTdWXX1KqLEQVtKG1bjYAU7/+ZdVgq3cpdhHOu69x9KK9vT/X
 ypIuPP0AIDLq5ZJrI+zhEoSxYFs/RIRB0wgKDMW6K14VtrJpp8LP0hgNdmVVTCm4K3Jz
 7KyZa66fjdN75mPp0BR3ecqJO6yFn34Mq9mb7Q9OiP12w5kGTmB5oGJt1OiQjKmn2EEK
 HgMSCikjo9OLCDaDanTFei4LeTiIWnFM7xwaZex31sPML/oP+yQV9UnkOB8svG9p5/ob
 1Qig==
X-Gm-Message-State: AOJu0YzIu3eWSJ5YKvwVca75arqnaHNE73hCmdWhLU89NxqxAD1fb+O7
 JzVdUkAUUX6TWvNtq84HQCXjRtsU3IATTVzECwSmwOJNzb+XM1yQbZtyiZEvUFwrhj5UZGZNXxy
 yyGsbDxxdAg++oNg7/Vvmsiqjgn1j/8PtAgBUJPzVKpCbgokZ
X-Gm-Gg: ASbGncsnuILPXJsLDj4plXVUngBp5UZMVPb2hXkIE5dLcsnk1gkCrfw3jpHDIinJLX5
 PVaPKCLow/VCwOIybNijHZ4RrOeRkJPT2/Xlv
X-Google-Smtp-Source: AGHT+IGL4I3h/g2azUiu+tLuCnhUSe3dy/A2WmrC6fviidVHo9mKd9UpUP3DWwu+KZYlefvMryOBSn7yPgdDSxxxIZM=
X-Received: by 2002:a05:690c:9686:b0:6ef:910d:7859 with SMTP id
 00721157ae682-6efe3bd720cmr154598877b3.9.1733851430572; Tue, 10 Dec 2024
 09:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20241203203949.483774-1-richard.henderson@linaro.org>
In-Reply-To: <20241203203949.483774-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2024 17:23:39 +0000
Message-ID: <CAFEAcA9AXwm3zW=Cvcr-Dx36jZb8uaPXhyw4sXUvhY6QEHQ6Xw@mail.gmail.com>
Subject: Re: [PATCH for-10.0 00/11] fpu: pickNaN follow ups
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Tue, 3 Dec 2024 at 20:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: 20241202131347.498124-55-peter.maydell@linaro.org
> ([PATCH v2 for-10.0 54/54] fpu: Remove default handling for dnan_pattern)
>
> The first patch needs to be inserted into Peter's patch set,
> any place before 54/54 when dnan_pattern becomes mandatory.
>
> The rest are cleanups that become possible when the
> softfloat-specialize.c.inc functions are inlined into their
> single callers in softfloat-parts.c.inc.
>

I've queued this to target-arm.next for 10.0.

thanks
-- PMM

