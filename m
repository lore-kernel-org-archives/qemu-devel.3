Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AE9C282E3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 11:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpmfR-0004bs-MF; Wed, 05 Mar 2025 06:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tpmfM-0004aX-HL
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:12:00 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tpmfK-0003s5-Nw
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:11:56 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e5b572e45cso376307a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 03:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741173113; x=1741777913; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Bf/g3042Wak8eOrAzj9XZVU1E8jDH2VAYy9m7CZ/0Dk=;
 b=bdDEvFTiWVk+Y2fkTJLYskwdxUer+ZiAYmHr3g924U/JSHe5cAJ4U9EFFcyll5ySxU
 R20RGVWTBrvgFAyF2novYZse9k52HKKAZu+s3nvz36Aj3ZdIRYG0WNG4uErtiiN08L7f
 wKNblrcl3qODJ4bWwtPZ5SpVqRY2uMDCC6j5WRXaglgv1OwyYZUgmcUOZew7WiFQQekM
 nuNrLxvNXCGHs6xvp41fBSM/qIJaROe93888q5MXEZNkCczeB9Z8hOP4Xssl+GLc6wsj
 Oa4vuR46Fcr8FJlEtcejALJPf7FVC7ONH2WzY0YrwYUmynjk5GQ0quiPscwCEwot75OX
 EBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741173113; x=1741777913;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bf/g3042Wak8eOrAzj9XZVU1E8jDH2VAYy9m7CZ/0Dk=;
 b=MHEPLdlfjdAd1GHtf3R4L27naORrl3u2c6PeNKC1sMT10tS1hslXdjUNhIvZO7ujaA
 g/ZavspP1ns3b09DoQ8V2KcVoE1Erk/mv77Jt38qnxyNunA+uh9cyprbBI38XjGLmQcQ
 7nKlRy/WbvnowyCIzdwzcAtkJqX++6SLhs5qFzDfG2co5jlwwhB24cJVR24uM9vhSzgf
 OMFHKxTxhz2aDkqw/6Lkt8EiEsYs7u63hw2bWkdB4jydFFL4Zga+qdG8r4aReWEpY83d
 RRjwQVAyidd3ia+xfLsnvvlTkpFpMPsG7PRALx+flkr43YfwiySVAoaxIEhinMOvn2Xw
 4nAg==
X-Gm-Message-State: AOJu0YznzTy1tmZ5po2i6OuSLWOi7oDGnT9h0NjbZUcId9tdHFdqIq3K
 P0VcfS8V4qavYDnPCN52d6h5LK1Kyu3C5JKcep+od/kBzgisESGX+/yGzajx4p/hiZWSe02yO1B
 RkJOaggGLYddbTmAONbc5LSARHtD/T8XXYgQ=
X-Gm-Gg: ASbGncvMDo9aYSvN9uEXwSZg5BCZO+yifZRRPX5pNrCoGRT2BOmkwUNirNxc785WWkF
 dddhD+Uirvud3vnNb1Ayue7fDFYd7iSHOytYiacKZ+y9NO8lK8hf8SugqTX7or2wRyvurIig98w
 2I549ZaRWYY4dI8T0/f4oLutsPyg==
X-Google-Smtp-Source: AGHT+IHG9lmcg6LEBxptug/KrlMBmK9DLefcBHlNyF+EJ3vF+/XciI/lRPEs7d/f9XAedbfMMCdVbvDPup+OljO8RpY=
X-Received: by 2002:a05:6402:909:b0:5e4:d499:5ed with SMTP id
 4fb4d7f45d1cf-5e59f495e91mr2347178a12.31.1741173112770; Wed, 05 Mar 2025
 03:11:52 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 5 Mar 2025 19:11:40 +0800
X-Gm-Features: AQ5f1JoYbLuL8OKdiNKWzagF8jwCcr4qGl8blZBQiWXTdOHfRV34hjqkUdJD0RM
Message-ID: <CAJSP0QVzNieSgkecZEjsfjwpQsXL3-7yrwech7-QH433V_u+Gg@mail.gmail.com>
Subject: QEMU is participating in Google Summer of Code 2025
To: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Rust-VMM Mailing List <rust-vmm@lists.opendev.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x529.google.com
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

Dear QEMU, KVM, and rust-vmm communities,
QEMU has been accepted into the Google Summer of Code 2025 open source
internship program! GSoC is a paid, remote work, summer internship
where first-time contributors work with mentors to begin their open
source involvement. It's a great way to dive into becoming an open
source developer!

Applicants can now check out the project ideas list and get in touch
with mentors to discuss the idea:
https://wiki.qemu.org/Google_Summer_of_Code_2025

This year we have QEMU and rust-vmm project ideas in C, Python, and Rust.

If you are interested in participating in GSoC 2025, please see the
GSoC website for details about eligibility and how the internship
program works:
https://summerofcode.withgoogle.com/

Stefan

