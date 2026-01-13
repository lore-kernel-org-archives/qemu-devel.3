Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC52D2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfeBw-0003KT-FC; Tue, 13 Jan 2026 08:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfeBu-0003Jg-Kc
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:12:10 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfeBt-0002wO-7N
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:12:10 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64669a2ecb5so7089873d50.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 05:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768309928; x=1768914728; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sllnZarZq26uZAc+wtPOmNJKeYrKmmlVWQJwR/aLv18=;
 b=fXKUYGEU8tQDfbJhyKxJ5IGvNdLd0J28hwGHcg7LSfBXXH9hnixWNA5VCu0BKKyGnZ
 p1DTxToroN+2xpsfLWUkrR96oKNSGZoQy0DlqJ9ZvDclqDsyawDUdm/mgFldZGEFllNT
 77mCEGlXhXqEmq5H1VIehPsOkpG5pr/MeYYOugETXg89lQ0DrMPHJOyKJ4Zdjl6nsTea
 lCDtqlxNM7VjKQ4KtbcY7IZxjgQTTioip/rBbp7S3aCLpI2pAIB79jEd0ArRTtgktylh
 GShc6K4WayLDrwbm/sqp8QSKmE2WLUP8EQ6JkUNkk5eCZJs8fixJunqPVC2xlcVwG+KH
 5++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768309928; x=1768914728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sllnZarZq26uZAc+wtPOmNJKeYrKmmlVWQJwR/aLv18=;
 b=vwF85CPk53n0urueaUb85h0OKB1jjd9mjs0vEjG7YR7tKU+Wdt4bydzTmje30Ks8DA
 INVDlH38nYID3zDV+LTOZsHYuubUHaF4Wj3l94dGVkjBLC/CRAc+euQi16BbTCYD+248
 55hybIY/ubPmclbCO6rT7SJsxmuXhjLyhq81uH8y/s0Fcp9tKzzq9BXNRRcbI5iAM3Du
 2pUWl7M9RuU1BmitcFT+UyiK24fb0BRoleWKwyTHjOPj4S0hsMAifMBZ2KmGfwc2ao51
 jLiXaH41WjJ6HgiPCeX3PKpN54vHfzkuToG799qpjCfMMIQLjcFLsXlb1USSMWfvFbln
 qKAw==
X-Gm-Message-State: AOJu0YyUIL7SUgPEHaN2J1uYIxm76/sjeZaEyOvaF+LVtRMNRutl/Ee+
 jql1rMmM/ciitFe8352Fx1X6a/xmb6j9ZRNEPbLH/RedJ/qrbrPlPsDKNlMJeQFBuVImuUxfyAZ
 lAwhZCLDWsoemLQaHvRwWLrSiAeO1jZogva6kajnsU95NRq5dovDC
X-Gm-Gg: AY/fxX7DuU97ru5wZVCa4zktW6f3KOxkkQCJI9+b8Z0ASOafiyjwxiYN4h7ifBp7eMr
 L9q7CuRTmZ7fNo4q3seH34mqe5O5pC9o2RqBf8hchZ8xAz8fP6C1azEBxTTq+FQlL1k36A36Hlj
 1c613cwsjD7eYkUA+nKMegaCZmdUsHzW9JQGDFMaB22YuFA7Vdmlo529SLA4ZC9ZoyX4GLiHMf0
 bVbT5s3Hk+4uqeFr2iKpxz1tV+dIvBaz6ozfwSd48GCZ5KuGOcPRYCOdLlmLiY/kcxXpFIeFwYk
 DRBynpFgpo5snw7mz/R8IfQ=
X-Google-Smtp-Source: AGHT+IHoQHVJdYGyr7t2bz9w6shpFAaiY7t6KX/eFKbOTtm88mRQYAdDDLCT59g7FRNXcZNgwGsrRrUbNlvZMRxohSA=
X-Received: by 2002:a05:690e:118a:b0:63f:b605:b7f2 with SMTP id
 956f58d0204a3-648f61ff3b3mr2681309d50.10.1768309927937; Tue, 13 Jan 2026
 05:12:07 -0800 (PST)
MIME-Version: 1.0
References: <20260113130008.910240-1-mjt@tls.msk.ru>
 <20260113130008.910240-2-mjt@tls.msk.ru>
In-Reply-To: <20260113130008.910240-2-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jan 2026 13:11:56 +0000
X-Gm-Features: AZwV_Qhz86aVIko0N3iAKT9lXL6IaQnCAY2HKOp0_3adyOt_qFfHXH15lu3N7pU
Message-ID: <CAFEAcA9Fe2mVx+tY7D7XaYxkJ8sg3akLBVar_ONHEePrjEZGsg@mail.gmail.com>
Subject: Re: [PATCH trivial 1/7] linux-user/syscall.c: assume splice is always
 present
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 13 Jan 2026 at 13:00, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> splice() &Co are defined since linux 2.6.17.
> Assume it is always present.

Since we're calling the C functions here, the
relevant version is glibc 2.5, but either way these
have been around way longer than our minimum supported
version.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

