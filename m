Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B60DC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYqG-0007qQ-DN; Fri, 23 Feb 2024 11:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYZC-0005EF-Ef
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:38:31 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYZA-0000RH-SY
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:38:30 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so1559622a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708706307; x=1709311107; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7rOqlIMsp9GkXrBRowxKYMz3u50Ze6PEWMK/mBreZEU=;
 b=d+U2JmOKRy+lIslKqQ4gV7st2owt2v6pgFllVrWWgIuSvYnygGIbBXJrBHeTvC4gmE
 VYcsRg54HwbOHeIsdGkVrzeVB/UTWYXV+UvNfeTJuxll8FFl5bbKsN5QYFxtOPVLi0v0
 Spgcf3aZRJcmjrm/SI8TMyZxgyfX0BjQiaqV5n1xBZoMRLbNPgajyZAesKimPGSQqDRe
 kM/aAn776x4INB8G/34wVvkrB/eCMv5xPZojAfNHMBqgn1trNZTdIXhzLGuuKJR9ZRLe
 alYOaQG2aey6uXwl6V5GDiX5zEemy+bHunfvH+zT4Lw6VBjVP0J7AAAQsrejPg96TfOM
 wwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708706307; x=1709311107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7rOqlIMsp9GkXrBRowxKYMz3u50Ze6PEWMK/mBreZEU=;
 b=CJAgGWp16z26zJgjH5xq1fgNfNRfBcGMUe48FbLET6eb7aDAzQv/jS/lryNNfmzpSi
 nELK2y/hYhWIG8zXmbKImgiG7vAKV1zJcxkvzcT6xiAjyQqOoSUhxXOOP/fXIB3weCYB
 oji4s6ePaGrIeVSqtGjOSW3e08xFn2j+FEeEhzybQZY3VXX8W536JVbCEv3j797cx2DI
 NIWlA7yPamRRwnMNYQs4NAhWLJYI6zfEMGqhkaQNI1bMh9XXS51kFqfPbYH00SSap4l3
 KkZx7kuhTJfS6KcgzHEIWbDSwNDZP5mcqxm8tzEu3gsyLdbTCjxM6Nyt86zp2S+kqrjc
 vCDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2omEQmtbm9KEl4cb6ZMDxUQe2UhyNbmbfLli1UV33IYaQXQn4AXmB92a2jYEcEhuvNELZYRdno/d77Q0ivqha9aq//54=
X-Gm-Message-State: AOJu0YxiZoHOLrqqM9aCSSazGatJUuYetX+WSy4oaAds6B06FbU1nFwu
 jDC5Y5Z1RMx41a+yu+AuAnzWnaHUjy817DBVGojsNJ1noTeyQB36I0iVsWecppb7/iitE/x6Xua
 YN21Rw+7ENVS3SzJDIOP2t32/tt5rUnl0ZUVD9w==
X-Google-Smtp-Source: AGHT+IFc/XQfnh8LHH3OZY0FCfEAFt52aMj6C33h6ve2imBURIV/qPNNdghR6JoR97FwYqp53A220hdXW8bMxnQEhSU=
X-Received: by 2002:a05:6402:40d1:b0:565:948d:36ad with SMTP id
 z17-20020a05640240d100b00565948d36admr95021edb.38.1708706307535; Fri, 23 Feb
 2024 08:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <20240219011739.2316619-4-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-4-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 16:38:16 +0000
Message-ID: <CAFEAcA-BdQxazvGJ6qRfVyMHPtgdUJBqogUDE51MOvxzvJPENA@mail.gmail.com>
Subject: Re: [PATCH v5 03/41] Split out raspi machine common part
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 19 Feb 2024 at 01:23, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Pre-setup for raspberry pi 4 introduction
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

