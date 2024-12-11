Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16B9E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOzB-00019z-3J; Wed, 11 Dec 2024 10:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLOz4-0000z7-5k
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:50:44 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLOz2-0003Yz-Ho
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:50:41 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6efa5bf5202so63159347b3.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733932239; x=1734537039; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J2Y2/OOkfbhybpafVDJ1NXEoF9DX4I1K6zMWGuQvss8=;
 b=lzm2XtKEX6AmFF1O+grN+qTcqi4SFro+Nz4pTPMkqRSzyUDYdNxPdcd0PaLvRbGCtW
 X2LBnGqI5T+xTjOAFnpZNH2u1LhhGEq7tqDxshNCbc9MuwPYEi/sYWZkZM6vZPU+nhkA
 MOaNOeHDHQX7jtoPpDChebkCLyU1kzJGwlNUktcZzSa873IjLZdKiJjiBhChTrzYOR9A
 jOZ6AVgaCbyeAHVd+kJylRKOSn4IS3euBIOvMOtRm0YyhUUJCZWKPdeCxdkN5YfhsRo4
 qS+pUWhkPPe9oQ9FTzVj6NjtcJe+BnwNbT15iGYyyhP19Shbr3T74NaanitMDq5GLxVQ
 +8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932239; x=1734537039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J2Y2/OOkfbhybpafVDJ1NXEoF9DX4I1K6zMWGuQvss8=;
 b=hMPY7vvgdodWCPCzPlSZarSK+LpdmHBG0ZH6jtk4tnqiPC/7AlxsnzolKcvyikv0HC
 7WtkyrXo4Ir7FjUUxG+JbN4LxP2saq6Bcn88f3uDfwoBgxSnp/tAMQJCJ596xtvhjufr
 zMIOq8qSjfTjmFJ/fkFyF5EKyy5LpHPjdJDXIcg9d3BIAYcgXTq3IGPM8bLqNhQ3DMFW
 /jnK+AYNyvtWI1LXqM9jgeD76mD1HxwlWjzKa+hG09LAHwE8FeQ7pf5W03GvmHxskchE
 HX4RPYSCP2bek9N5UK0O5A1Pq42sJvahubisociatFC58QBXi3xTTGQQOHfMtrUPUlVc
 SsAg==
X-Gm-Message-State: AOJu0YxXv0TabJGel1x1hq8A+KmlHFAmp7WcOG+2exPFFxScXOl3jgSz
 /cze50VwZPg4NQvXoUG4PEkVxejjmiRU85AMBdXiYbFiu+lkNyYL3/EEKyWmCJiA7dFu1YC7MiP
 GQ4wE6NmhWoUVacVTTNZaJpQ7owWmejKnZPzlx4u2QQeMxK1r
X-Gm-Gg: ASbGnctDXWr8+BZhvTgsfYCfSnd58xNE4DnW6dcCb9nURXG5n8M4vRDiuLvYZ5R5wEK
 8ph8Ii0GgY2KmLqvcuZxlDbvNt/XKHsznvC9i
X-Google-Smtp-Source: AGHT+IE7lv3vl6LBgeHEc3ahOwSnUo7j+mZmlfCun08IXlUI1vnxFe1+gj58654bMIAhE6hU4UYJ5Y9uOUhXLYYKf5I=
X-Received: by 2002:a05:690c:9987:b0:6ef:8296:359d with SMTP id
 00721157ae682-6f17d61fe4cmr1145417b3.22.1733932239331; Wed, 11 Dec 2024
 07:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
 <20241210161733.1830573-25-richard.henderson@linaro.org>
In-Reply-To: <20241210161733.1830573-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 15:50:28 +0000
Message-ID: <CAFEAcA94MKwQpBnr04xNhL+jFFqysad8Ka1XPiciuX8S4r2sfA@mail.gmail.com>
Subject: Re: [PATCH v2 24/69] target/arm: Convert FMOV, FABS,
 FNEG (scalar) to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 10 Dec 2024 at 16:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 105 +++++++++++++++++++++++----------
>  target/arm/tcg/a64.decode      |   7 +++
>  2 files changed, 81 insertions(+), 31 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

