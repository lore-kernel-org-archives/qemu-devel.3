Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EF8E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPI7-0005Xb-4J; Wed, 11 Dec 2024 11:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPI4-0005XH-BH
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:10:20 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPI2-0005y4-RA
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:10:20 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e3983f8ff40so4936045276.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733933417; x=1734538217; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8biidVMmOxgF97yUIesnJzNMpRHgvFxmy9ix4gxPD+g=;
 b=yVCcGv6RQzWg0sLpeIVlj+en9uyIEXd49OuHYQf63JhzYDXboE9c4ZQhTM9SYur/ob
 4v3FsntV8j6LD/+FcHr4Dj7yqGMLgBonl/IRddprsHdshL4TCpMc0VNiSE0wCpRi9jkz
 MKstMxnqh/p6EPL5rmepdFjXakTS6vtXMXXJJEYPMWepj4TSzPENNvu7h6ZP4qSWSFzd
 TtLErplm00mznnZFB/eS8ZxPitsqaFE0wO0F8fNpJb3HDlTRNPAWKOlW2qNNGgcvFlUm
 8jmgj9C92fyh0W6TCwrcWfDDGmn5bxArWB3Jd9vE2skAPYQQdY/4xfp7XHZHxPVs+fs7
 vMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733933417; x=1734538217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8biidVMmOxgF97yUIesnJzNMpRHgvFxmy9ix4gxPD+g=;
 b=AOm+u7biu0iBZ6OtnDA7Op376BVDhgfXMTAlMwKUl8HFzjjhCfs2J521VkkbtifIvZ
 a9Vv5NBozzLFsm9WNbX/8Th02ZXto2pcWMNer2rVmgfnLjfRZdhOghrmwrcaqV/gqv9r
 6l6fDIKyn1rlZ90XG0Sx4WX6y586xaMRMXpBK0vg9Aqa6pWjeYD3+DuSfdTpd+wV+sV+
 lFiwgefaudLIyCE4HvgAbwsBfpDuolH16Qfd+GLJqBSQ+LrKaPw70zEbhaZBd5NtKruY
 uE5mQov1K1lvaJ8W4EKkJgBboOsG/wWeSmZIGRXLuahbkOFOb/QSNyxh1TfZ85agKXF2
 t8Mw==
X-Gm-Message-State: AOJu0YxQG1hkqsckzrQXQemREvnh2dU04J91wM5pH6QmMHUJJgaWzyLt
 kTAOPHRRd9BhyaosPlM/x99YhB/f5UsAtJmMnxtri31hal7rD+HIUcPTc54YnDlygoK5hxD3fB9
 F3CCnQp67Q7AZearFZetQmeFgjWlPXr3pp9NafdyAsknWC5Vu
X-Gm-Gg: ASbGnctdBWkbamARl73kgHz/FYeWup8V0CeHTEZf6DmsgBFzUSK2XaP9p5o1mIN5v/e
 WDe20LH+K1HFlUK8KSi6vTcw+wtGZjlQkae7O
X-Google-Smtp-Source: AGHT+IEcC2++WxfPS89rqaexWI211k6/0CbvLG4Qa3O2pK1g52BbxyEkSllAmlM2WVU/d95mgPE+DspoDA7FuJQRhjg=
X-Received: by 2002:a05:6902:120c:b0:e39:8e5e:494d with SMTP id
 3f1490d57ef6-e3c8e42da05mr3125361276.3.1733933417596; Wed, 11 Dec 2024
 08:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
 <20241210161733.1830573-68-richard.henderson@linaro.org>
In-Reply-To: <20241210161733.1830573-68-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 16:10:06 +0000
Message-ID: <CAFEAcA9e7qEGE0k3yCR=gFfK836hKfGtjoXYQeLNStToeRBOXQ@mail.gmail.com>
Subject: Re: [PATCH v2 67/69] target/arm: Introduce gen_gvec_urecpe,
 gen_gvec_ursqrte
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Tue, 10 Dec 2024 at 16:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h             |  3 +++
>  target/arm/tcg/translate.h      |  5 +++++
>  target/arm/tcg/gengvec.c        | 16 ++++++++++++++++
>  target/arm/tcg/translate-neon.c |  4 ++--
>  target/arm/tcg/vec_helper.c     | 22 ++++++++++++++++++++++
>  5 files changed, 48 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

