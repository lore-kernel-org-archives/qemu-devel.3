Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A146AE77172
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJBzT-0005bt-RS; Thu, 05 Dec 2024 08:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJBzQ-0005Kg-Fi
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:33:56 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJBzO-00073S-Tn
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:33:56 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d0e75dd846so1378261a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 05:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733405632; x=1734010432; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2S3YbeSnos0LzG8We5jvBTGDq6r02IvTSqUHnZKBJ+4=;
 b=eksS1vebjANbflfndIeKCZHor1gbx7IVxiWJsxgiGb9KZc0/w42cUJwjblvbwD2SlM
 rSKw8N7xiMvG3oaENG2trI/uVS56WQwqwZ4W6QOMoaUaZUR+jCfe946wTi+quxF7fRQa
 QqnlHMVWZwdF9f/mXfOJMObeMTeehXNPidFE5q9BeHQoeD/5/h2R2NUfR2s9V2zQeXA8
 Nxu+FgpywtM9G4yRFX5njDEzIodHcHU7/aNg7kmHum9qrVk5P/gf6dDgrSzAJOoZKJUn
 DKb1GMaRs86HyFCXNnrzLIAtTw5YTlHeIHAQtikXsPDjiw136oPL5aonsj5Wq8ymkPEQ
 2SSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733405632; x=1734010432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2S3YbeSnos0LzG8We5jvBTGDq6r02IvTSqUHnZKBJ+4=;
 b=WpWHCaWnDs7duPKwEUqBMHUFkHOnu3ZRjTu9Ywvt5lpAmDdKT69co01sUkhpx0f5aR
 oByjmd7vvqzCgmo3gaTHA183en+wVWDmkL1Y560sizX61dvU8bK3VtLWYbbQAlu42+zt
 PRNjTmg8XxFLfLAunRF813WrSbu/cm1umaTj9iPv+0C39crahBuqQV1TK/wZDr2UwFok
 BUaaHCt3XvBbGEn6al8P0cgHdT4Sb5kFlztM/aU/R8/+jqM9IzNeGu71N03uHQ/TOiyT
 g1IhqzP03DVLoNJb3tV9IUzlyWPxWFqKfEmnjnQ4L57Y9k1O7T270hC9hL2FBLQv/t3L
 c5Ew==
X-Gm-Message-State: AOJu0Yx89qe5szfYLgs1VhDFqK+g1DzqlxKpUi96VgwUBNvSUBxMYtro
 BZ4IqnEt8d8Ou2LWtcFISb4REq7cVe+dZiNb25tgJrrJ+xK/fvLUUlPdwSwtCwjP8cKrSNsz9Av
 pWbo+d0qQL7I0FvGV5fwIOTz4ktUOFmVBT2u17X/nSRRU9qJT
X-Gm-Gg: ASbGncvqq/nds4XjKjnmqsacfP9f3aewyWEg5AWiUXRi7ocUFBVw8Sji+FVC59w8uM1
 4li/oSeAAxUQLsvPDia2dN6LuKu/aFNDibbxA
X-Google-Smtp-Source: AGHT+IH5qx5lkTTR4XLeHIEIGFrHetRhHV7ZKeDDPy/ryLYG2hQP+OSR1kzVxNIk3+Llgy+0TUGv1yo72gT+qq14y1U=
X-Received: by 2002:a05:6402:2553:b0:5d0:cca6:233a with SMTP id
 4fb4d7f45d1cf-5d10cb565f3mr11525038a12.10.1733405630802; Thu, 05 Dec 2024
 05:33:50 -0800 (PST)
MIME-Version: 1.0
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-7-richard.henderson@linaro.org>
In-Reply-To: <20241203203949.483774-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 13:33:40 +0000
Message-ID: <CAFEAcA-MzVYe6aTVdfcLD5ovU14-BriJJBJ9rVinOAwU5tn3EQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] softfloat: Move propagateFloatx80NaN to softfloat.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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
> This function is part of the public interface and
> is not "specialized" to any target in any way.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

