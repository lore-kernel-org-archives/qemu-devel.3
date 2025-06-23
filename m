Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920E9C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeDe-0002N7-Tl; Mon, 23 Jun 2025 06:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeDY-0002Mh-9S
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:16:01 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeDW-0007aj-3T
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:15:59 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e740a09eae0so3621834276.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750673755; x=1751278555; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2vH6AK11EZZWajas31md9RhjmGaHAE9vXu6JIOl2s9U=;
 b=e3xzGlDqi6t0H5HkmaOOabZqayxt0NyckYj43TXrSOakuZD/T4D8E6ew+MxAcsd5Uk
 Tq0ITzv4+M2Xthj1SqGGsFIYoj495cxFXbytpD26aUFL3jk9ii9Pa5wwLE6Bg4EnuR4x
 3ZjsukCTVTOtNAROjhLFWCTBcr0unl1ACtnFoHp3sQPGhnHlX7MMiHDj03DXMJdmVhBo
 90z4/b2zlH3TeBoHehxiEZ7/TgqlsYuAXkUD8NTsToP5TLhpAVAqiEpf0OLAGHgqUYND
 ajZQ596l4ZUXEjsSrYImRN8zJuaGJ+aKPGEDs63S9DctKS4u/Q76pCyCPjPmyH4hd2q4
 /jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750673755; x=1751278555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2vH6AK11EZZWajas31md9RhjmGaHAE9vXu6JIOl2s9U=;
 b=fREQHL6ttxACLiX3po/oUSQrI6UUJma44pibDN9+FYshFRZVs2EMq7IKMk9aoA72SK
 hWJodcs4G8YgUbTmiUQR/RaC6t2H239XchOGp7hFlsxM3BISDEqkWZZVr3SfgDoI/gim
 fpAxWHq0K8A7C+jkFm90nUBAWJ4fNdmsEdfP0LQcZuJfl/YYQ+Y8lRb4A9Mfd56V9WSJ
 rkNmeDGeVTpzE2MePKixaHIUlb5InYDtdGW/tDhbcjlr/f/Rhj0roAUBHO6rnYSdBnJP
 seKNWn4K2RYuZkMg5SXq+nVBD9AnhdHJnY6pQwOlLtreCwcT5lgmK8N9pwIaMQvc/8oP
 Du3Q==
X-Gm-Message-State: AOJu0YwzeeAwwkmJwlqqpUxSr0qkkTYJKnV2D5s4ZEHyB/3OlOEz0z7G
 glRwVujGllvPpurvKh+qZp/8JO6g9b1Q9ePL/lAL1BiA4G/pjvNXMrvKGPdp1WMxd0tRDFsk6Y6
 s+2PZHNE5BZ2hosRDzxZ5+Ynm/aWo03xttjxzfES2tQ==
X-Gm-Gg: ASbGncu9qGFXHCL5zq/pDgfgj5E2ARMBkuR3IV95jZf5BktU4kJZnbrSoyR7y/hMBAO
 snbcJCybx7q8LebtgQXat57mZIEosYX5OIzIxCOUAGRauT0eZutJYuTYMufJ0V346eQiHXkldTQ
 xLBSCxnxccR7MX1/0t1y+QmkV//TWAa8lEHZOP36g8RgG6
X-Google-Smtp-Source: AGHT+IHuDgtuQZNcyM7TUkxZ69uNHtIz3hpzyUOjq6RdKopYcSJRyqxuRld2VlSjuttbjWVTkEnm3aMe8KIQs22nYUY=
X-Received: by 2002:a05:690c:338e:b0:70e:2881:2f5f with SMTP id
 00721157ae682-712c64fc8e7mr175743787b3.20.1750673755061; Mon, 23 Jun 2025
 03:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-7-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 11:15:42 +0100
X-Gm-Features: AX0GCFvYK575ieMMifRRxQ6s095qNfc89COmLEBU7_G7k0KX0DdxTlF8jlXhSfI
Message-ID: <CAFEAcA9BmiU2TGaDc+5urKME_gGomxRTFy01ufN=nmY+q7VuPg@mail.gmail.com>
Subject: Re: [PATCH v2 006/101] tcg: Split out tcg_gen_gvec_3_var
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Sun, 22 Jun 2025 at 00:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-gvec-common.h |   4 ++
>  tcg/tcg-op-gvec.c                | 102 +++++++++++++++++++------------
>  2 files changed, 68 insertions(+), 38 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

