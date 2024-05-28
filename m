Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C74C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBz1n-0006fa-7H; Tue, 28 May 2024 11:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBz1l-0006eZ-VK
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:46:17 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBz1k-0005Zt-F2
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:46:17 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-578517c7ae9so1279874a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911175; x=1717515975; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kpJ7180e+TZ5lWjPD0LmR2ZLmDkI0u1LkSQbPu8TQ60=;
 b=WDioyZtAiaah1d3/ublZXbX0VAsLFJ3SyeHdqxJZXUXCsdTFOSa5kWFNYhGE9IJRMJ
 czox1gN4ruoQcAdwywvYyOFvoRM8Wa5/t+V5CvF6xFnRN0KEXzLoRAxtCwrqaODGplnn
 TjWYvgGyewFG11EUSNQXPuzWOtewKsTtayfKUd7mRsta3paikTyPKZKeNiOVRgSRy54r
 eyCAjEB/USXojuwXu0mn53D3aY2UOUCxm9zurYYdlcCC3/ylhMi3iP20qWz3NcDtre1W
 /eoIQHF7ZYiIQcmgBddshETRtQ9UrIDaWJKmKVJYMfh2iI/Vy1y9pIY74P/tSJnYEgeK
 7yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911175; x=1717515975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kpJ7180e+TZ5lWjPD0LmR2ZLmDkI0u1LkSQbPu8TQ60=;
 b=P/CK+gcNqsDPpaNDGffQUtjMKFdAfjURrNQvWaVOFUQbTu1hE7l+40qC6ekq0WJobY
 wM4acCZLtBvt/tJB9TQS6gzpuvrZb/j92WdVFuT5H1yuC8tNfh90btfd1dacO+RR+8fK
 KcJla6ib+5swYptv8KZRUOJTGYfz9vhgGztLnH1RqRP2O+CiR8e91ZttsSg90kRqLLtG
 jVGyhCDZiXZ62HUJgtEIW+0OPgYGkHVK8lqknkhxJPSybR5bXJb/VIBYcA+DdNvL8J/N
 FQ6rnvfBNq9meOeP8ylHYK20aYYivH4HDIUdU8QEwmCie7zkkCyYAcDC1MHnk+fB9+yI
 4lXQ==
X-Gm-Message-State: AOJu0YwIM/v+kNnqdz45LNAFo2D/LOsuE/vShYHPN4KeCET+UMdrkpus
 I+OlnMB0Jqr7KX4MuThXXr/PlyWp7UjhDt3YqmL95WOaMyuolTrF9Np0g5kVB09vWWlY1BE9sN6
 gHXaFhiVZ8gEBvZtkuVuPiNwc6m5aJKawObN6Iw==
X-Google-Smtp-Source: AGHT+IFrY3xud96FAVks2wds1KOLzMimkJUAh4OSoqUWbACPXdZjbxmPjrY2/gTcHAzWlt39HWukXHcli/EV7iwe+Qw=
X-Received: by 2002:a50:858b:0:b0:572:a158:8a7c with SMTP id
 4fb4d7f45d1cf-578519cea28mr5871268a12.42.1716911174721; Tue, 28 May 2024
 08:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-44-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-44-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:46:03 +0100
Message-ID: <CAFEAcA9VVu_iT0TXDuBjK_DPqsQa3PNgFUCf4s775dYJv4-4Vg@mail.gmail.com>
Subject: Re: [PATCH v2 43/67] target/arm: Convert SSHL, USHL to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 25 May 2024 at 00:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  7 ++++++
>  target/arm/tcg/translate-a64.c | 40 +++++++++++++++++++++-------------
>  2 files changed, 32 insertions(+), 15 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

