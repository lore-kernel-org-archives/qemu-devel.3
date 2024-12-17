Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF605E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbd8-0003aM-LM; Tue, 17 Dec 2024 12:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tNbd6-0003a6-Cw
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:45:08 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tNbd4-0006Vo-Jp
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:45:08 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cedf5fe237so9193020a12.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734457504; x=1735062304; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yrYJamrZy4F4vKdhgAoiUYA9tkW/ZoouGfFWVJ902E8=;
 b=LWyYX0PaZ8mxbXAU3ZHmQ4f4/rvnm7OsYuEfEI13Iftc9xdktczOO69tYW/N40nxjr
 YPHOcKToVBuYeksJyyTC3j0xMV2KVhUnHHtjFBkIWvnAesnDT6M2ll6cSAMeTz0WWV1j
 EQ90ujJVUr+YrF0b6K3jdjzCOj0h99yfQXREqFweJucKf0hzYYdmZ6b8eghutgjS9H7f
 oMb+sdbmpm+4Yb13S+CTDzB7XCloJ6z4aC4MjTXo05A7rWNbRveDzVmMyaGuKdx+aR1K
 X2EUIWJnaGHI0EHAvh7AQZS0qV1hOVVadE+GHpXlL6dAMzCnXyHhGKxuG25U1jpONX4B
 vpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734457504; x=1735062304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yrYJamrZy4F4vKdhgAoiUYA9tkW/ZoouGfFWVJ902E8=;
 b=m0TdwX+N8VJrKeEdkTSMqPJzdHoHjF/nmAQtzpr6xy6i3iKehgfpUZy6Q9vOoKo7kV
 JhVPL/go+NnH7ExXjvwIP6M3pLVHHCagrSeO+I63GZZuk0fH4vclMvTJC1m42cVGTle6
 vZWAR25eK4zZtJl5Mj3VHOOI/f6mnstk6/q4Cc8fmLQA3LyfsKLBp1vseVrO+L+vsr57
 SwPbjXmmrzTV9G5LCs/9lFfv4/ikf5QsuudtITmiHcFDwYrOdkNLD6VhNGHjrYv+vaeL
 MAkm/24u8rjOsKzY5l4YtcqWkepiNN7q2Tj3HZiOg5fXNqoGruT3uzIY6VRaPMBCyJn2
 MOWQ==
X-Gm-Message-State: AOJu0Yxn4RhmmuwSAIJwviQPQlrOSrwPi13IkYaRhbMEuzU+NLHKGCON
 8Ny6pryd7Z7T96jYDev0cSXYj6sfoDkoZ4Q8JW9iFcv2A93fZqpcL9VlWN1eLFayQcLHYAuVoxn
 95y77OMZ7nkm4deXrtnIV/iXSVsEVSw==
X-Gm-Gg: ASbGnctJLpo6mIrjFNRr2gSEpAyCUKqqPpuYCvA6SWmDxCU83YYel+Ft56NYutAO7Vi
 zbMSFzptgqYuXUie+ErHsATterqlNS5FkPohx
X-Google-Smtp-Source: AGHT+IETm17b5sZlTppCanARf2g6ZE5TN0fff1dHeAzma+HOsc1E6P0giZpWac7exI8KlxEz75MUezcTi+rzImIxjGs=
X-Received: by 2002:a05:6402:354a:b0:5ce:d028:e11 with SMTP id
 4fb4d7f45d1cf-5d63c32e25dmr16062761a12.17.1734457503405; Tue, 17 Dec 2024
 09:45:03 -0800 (PST)
MIME-Version: 1.0
References: <CAOzwu7cgeUmy_kxrTXS5Emi8ZmNK7JHUyXKXEXz7_hHG-VVNwQ@mail.gmail.com>
In-Reply-To: <CAOzwu7cgeUmy_kxrTXS5Emi8ZmNK7JHUyXKXEXz7_hHG-VVNwQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 17 Dec 2024 12:44:51 -0500
Message-ID: <CAJSP0QXen6dbsfV95_NTqR2zkJ6oddE24QmwNw7rrZwHgahnAA@mail.gmail.com>
Subject: Re: Missing PDF file download.
To: Asif <asif.haswarey@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 20 Nov 2024 at 17:41, Asif <asif.haswarey@gmail.com> wrote:
> Secondly, you have broken links on you page:
> QEMU Internals: Big Picture Overview
>
> Broken Link:
> Jan Kiszka's Linux Kongress 2010 presentation on the Architecture of the Kernel-based Virtual Machine (KVM). Very good material.

Hi Asif,
Sorry for the late reply! I have updated the link to a mirror of the
PDF file. Thanks for letting me know.

Stefan

