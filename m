Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759E7C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhlt-0007pa-0D; Fri, 04 Jul 2025 10:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhlp-0007hH-AQ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:52:09 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhln-0001W8-Hg
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:52:08 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7111d02c777so8203597b3.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751640726; x=1752245526; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j7vN+IJh7hfv/iYhj9mBOHpmMOeViS2uAOtapOSpZOo=;
 b=tCj8XcW+xzelnYvn5ZxtBrtLvswIElU9HTSbVXngv4W4bWOdlFPnzwu6m5ZUrPxP8R
 SCRBRM2Br6X+wGoGK1Rq37uIZMXyJyi1fCpCqpYTJd15Ud0zPNgq/pOBzPoAlb+qNjJt
 kL0N0YGxU87fBbEF9PuJpuRMFisuzj1pUXHVlGtauO208ePgbGisygeF1PSg+Yzf23Fz
 j+OKjdADpdzpQDR/cqaTk6GJZeU72C/8t/j4YB9e+wSkbU4K8WIq7Z4gwAaNuL2QPL7d
 42hh87s/vwNJwM6nplMboxSBz+c1DOjM6TUSmmw1fblWCJWtN95nIK4El6RiLPkURPtU
 +OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751640726; x=1752245526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j7vN+IJh7hfv/iYhj9mBOHpmMOeViS2uAOtapOSpZOo=;
 b=Ae2VoB0vMkM68mivlDXFWh0V8mQ7O/L/lrDJhxxu4IRBOisr8CzpeYjHtwMEArZGyY
 CYlvsruHCuEDydHnnbb6QFO1prydFSRk0WuccBkZ4Roe3C2shn3w1hUU2eTOnMdBgCgZ
 bqeSbht2W7abdYwXkm4Mf9YsDOFFdi96TaqHKXsb2HYxoPcovO3wsh0EwIFK9M9b3M0l
 2+vo5SQz+3RPKXztJvplAixpUY6Fl3y/e5HwELvAo7W0rh9W85Inle8lVSfPUWN2eKTW
 GeusQZHvVWHrQZkmqGaCzztkgj5Gb4r8LhEk75n3TcDV8VcyZUus0vXeQTKY3eXnECo5
 elZQ==
X-Gm-Message-State: AOJu0YyCOb10o6VMphl4+f02A9NGe6LnSbKtotwLu0Gip27DX1VUh09d
 pItsKhIehPWLjXi0oSdGrhVFtuIV4zLuA4Tmd8X2bgEKhOwmPsOIHTGipUNiFdn36K7o1TYqCQ+
 cuR8DH7qide58GkGq5U8VRVJjEK9IoMlWCUztAXyGEw==
X-Gm-Gg: ASbGncv6W0CtpNKlGKD5B+tRbtCSSnL8jU6HXwOF1XB7PkqyDXYR3TucIPtiIOdUODW
 IxHn0gvzQLazpsf60PVVh6q1nJ5Jhpe+qeEs2LgK1heRhaz3dxhdH+EjfR0Caib3JsrMgMONY27
 KFTvrfp9RhJKhQjYc0gZEjXKpNSaJsvKKAq6j12GLTJglX
X-Google-Smtp-Source: AGHT+IFI6VMfmtZyV4RtNnh8woZk9Q0nz13vDaVroiEiP5UHpTKVHShf3CMmD/eU5C65+7CjdAF41N8ajBjHcLjLmx0=
X-Received: by 2002:a05:690c:685:b0:70d:fd2a:1457 with SMTP id
 00721157ae682-7166b593dd6mr28224047b3.1.1751640725871; Fri, 04 Jul 2025
 07:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
 <20250704142112.1018902-91-richard.henderson@linaro.org>
In-Reply-To: <20250704142112.1018902-91-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 15:51:54 +0100
X-Gm-Features: Ac12FXyxGGoXJI5oYR_U53ev64yKXZIL7jTsrOgnseFjhFonaKDg_22LaX1ZfTE
Message-ID: <CAFEAcA-PfzqB-4qUddxG2Qp2RSir4U3VGcn8-1etGKrK87Axkg@mail.gmail.com>
Subject: Re: [PATCH v4 090/108] target/arm: Implement PMOV for SME2p1/SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Fri, 4 Jul 2025 at 15:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve.h    |  8 +++
>  target/arm/tcg/vec_internal.h  | 34 ++++++++++++
>  target/arm/tcg/sve_helper.c    | 50 +++++++++++++++++
>  target/arm/tcg/translate-sve.c | 98 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sve.decode      | 17 ++++++
>  5 files changed, 207 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

