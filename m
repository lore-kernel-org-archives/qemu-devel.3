Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B30BCA101A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 22:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk9hQ-0006Xf-GI; Fri, 30 Aug 2024 18:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1sk9hO-0006X7-QU
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 18:02:31 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1sk9hI-0008L3-GQ
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 18:02:30 -0400
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-5bed72ff2f2so2540354a12.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 15:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725055342; x=1725660142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbwgKz1smOQKvejk1P2mpas4f8vsWcrwGiyN4edb5yY=;
 b=gyYk/OTKgj8cKSAAGqXzYP2QegL06F3R2SF3jZXAY6qweEdwMD8L6r2Ut8YES5Kata
 rRuE+uoxOWthDXA/cd7dwo9916mEkEvGk7cb4Q9J9AFO4i5h1RRtLndFgNQ+dcPijFWc
 ATspaCJhxVJbobsnNPgvej2AVxFT2hroVmifvUWLgEb+oBqQE/V18Uz0QfwodqpLiUd5
 Zj0ZU0xqlqTowDF1nlfu++coZeirZtq9Vy9BdeQz6nb5R8XNxxUjjdNMmZdsWJA8ZcDU
 D09YDJoqxwfK96Pv2w4gN1jt57u8xHRQMp0LYQZvFzHaMjIaFqIGshh9V/cxJ7/n0p0K
 SV3A==
X-Gm-Message-State: AOJu0Yy0OJXCwqSiQRofSsw4kW1lb0eRNdWYzJyg/c8nU4yh/EFB8WgE
 IUOEgRXFJq2BxfssfhgWt6PhoNsedXS8ITD0v6xojWC2HZ++aPTX
X-Google-Smtp-Source: AGHT+IEkaqkwMNGwsibGNujfQbJT0Ez3HrscZLzA8na1AbCfLAU5Y0HOFaIqRHWAEL+g8wyxHAtk7A==
X-Received: by 2002:a05:6402:500d:b0:5c0:a8ce:9472 with SMTP id
 4fb4d7f45d1cf-5c21ed98ebdmr5668584a12.38.1725055341393; 
 Fri, 30 Aug 2024 15:02:21 -0700 (PDT)
Received: from fedora (ip-109-43-179-35.web.vodafone.de. [109.43.179.35])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c226ccfe84sm2325022a12.71.2024.08.30.15.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 15:02:21 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:02:19 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 2/3] hw/m68k/mcf5208: Add URLs for datasheets
Message-ID: <20240831000219.0ec8aef1@fedora>
In-Reply-To: <20240830173452.2086140-3-peter.maydell@linaro.org>
References: <20240830173452.2086140-1-peter.maydell@linaro.org>
 <20240830173452.2086140-3-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.51; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f51.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Am Fri, 30 Aug 2024 18:34:51 +0100
schrieb Peter Maydell <peter.maydell@linaro.org>:

> The datasheets for the SoC and board we model here are still
> available from the NXP website; add their URLs and titles for
> future reference.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/m68k/mcf5208.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

