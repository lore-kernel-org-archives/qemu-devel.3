Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EB2C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhUxK-0007on-BY; Tue, 05 Mar 2024 08:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUxG-0007me-U5
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:35:39 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUxF-0002du-5B
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:35:38 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d2305589a2so86524301fa.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709645734; x=1710250534; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H7grErJGCiiBui7zAEjcphfBPQmjn5plbM0BRw5vzok=;
 b=QicprYWSpc6VwISNKZaaQShjss7DgXPuhK/ueICOqYLXBstt9281X8z5wqsd+aXKSE
 AMw/iDG9bJIkjDnUfuqttdl9mLsQ8/Qr0UVCpWYkUs7UauRSZbasCOAUuUg6d4IFA2sO
 SuyXZa0cElqirn35TNrC0T3ILqdgJh18Six13dZYtzrM9QU9laK27HKD161Wr2lJiHN6
 cpwSD6s3mGis9YtEMlt6kjW39gqyftLY2O98kOrYgUxZmykVPJCCtpWpFoaWLGMJAnG+
 PlakweM0M1acr+/4SMRH50/jCe2jnbq/rEul/G1FZCzC4rOi5w65h5/1mYTtAQRaHU3p
 ujHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709645734; x=1710250534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H7grErJGCiiBui7zAEjcphfBPQmjn5plbM0BRw5vzok=;
 b=mYqSx07rgoHlwFJNorp6W/Ugdht7rJE3KA9BDJScUn3cexIcjsBSWCLZ3v8Q/VGh6q
 qx5oYX1m7SshRCECGp5l2t9YA8we9aEBK6YVbPExOP206TFU4ZvJhgC8sXgpWueE5HzA
 Wm7ybCDmpOzzm2hP9wOMOF8Gs4PcCCe3AwOEiMIcuC0cuJJ19dpSwvbRfWl01IKpYMAA
 BNhifTbzgx9wWhND6PR5xtZ/CbbSg3o8lIwI4AfnqWkYzLR4d6NSOWVN8tg8X8QhVImj
 KTfq8HVwELgQLEXg+wjlKPhb8DukFbm350W1z/FhdMk8Ldca5rQ9FA64XOWw8GWC+Zr7
 fmjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZVU7zc5O+36X1X9vxQnn6sK6xQKKFoV1oeNNkr+EsllD91gJd7IQKK446/xP7T9+lY7iwCl5tQPOvJmifFVykIgmzhrU=
X-Gm-Message-State: AOJu0YyfZpSezHySrFoS6y6XX4LxEFnbVqf4kei+Z6CrPfC3IfVyj/0l
 yFpWVNWKJw7dIs3MUFhKsLolnfB39yBzG0SxyT6VeNgx+CCFSxGnQvqdvEDPCHoiSh6Cve8kI1p
 oEiekwkSm4bR4GIWmntQTkpHJ0wmaS1nwlv3OPw==
X-Google-Smtp-Source: AGHT+IE5apbx2HeNbV9cNvPHoG0nkbPmPj/tyzf5RGOY8+YB/qGyAFUN70EMuq2WUN7Z5xXwS/QqbnHA8Nno++I2+tY=
X-Received: by 2002:a2e:879a:0:b0:2d3:a7da:b17b with SMTP id
 n26-20020a2e879a000000b002d3a7dab17bmr1434620lji.4.1709645733950; Tue, 05 Mar
 2024 05:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
 <20240305-elf2dmp-v2-12-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-12-86ff2163ad32@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 13:35:22 +0000
Message-ID: <CAFEAcA8H-ThU_GP8AhXzzGESzLBGgudUKn_MJu_khwWcFkSowg@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] contrib/elf2dmp: Use GPtrArray
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

On Tue, 5 Mar 2024 at 07:37, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> This removes the need to enumarate QEMUCPUState twice and saves code.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

