Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EC0D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 11:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOaHU-0004Ri-2X; Thu, 27 Nov 2025 06:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vOaHS-0004RI-98
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 06:35:22 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vOaHQ-00028k-Qd
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 06:35:22 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7a9cdf62d31so975475b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 03:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764243317; x=1764848117; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nRuf9e9htrjlcoWjm82qmYj7ZbkH7/9T0fHo1lzijoQ=;
 b=ip2L3KZMs40cQ6+y0mvwna5XOtQ6J+76h+QkpI7LqT8/NFkaLeibQcGQSljoNGLoHj
 vAhZ/OEpzAjMTpfONAd/8ibNYo1Kfh1IxtVx5tnbuGQ3HhWM5LqdqLy2mQ05/tSEvp2f
 BQPdPuCyossPSSKfFae7QC691CErNHmdqwYnOZDN/uNvpgsk8P0exwGIV/FD+mUEfiD9
 34zeD6XBIFXxtM9nchV7EWoqjkRsM2FDgt+o9PnE+4R8utBuirX8SoZFR9MqSmncu+Ox
 v3VQbcY5ijDeENuh94+Y3TwNRcA7ywUyOBsiAohHqc0x6rmiqzqiwZV9wf3swg9vuSGs
 2QQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764243317; x=1764848117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nRuf9e9htrjlcoWjm82qmYj7ZbkH7/9T0fHo1lzijoQ=;
 b=cLn3TYXGKI8/QVRNpbxi4xZjRgZ7ddnmpGnXAgweCzdV5LuEHgMZeeMk/X0r0Ac5f/
 DnlOsOyDlnp9UP5h21jgArVaZE1nZjexMUVybD0KIT2sOfOKEvRjy6F6CgR97lPoqSE9
 la/DKEKUylmwwbJL9h01O93vyqIGVnZfd0yE1d1MU4FkZ7BztRgXMMpZa7tKolD9HzlU
 JaXtVQQHyE54ZzWvHRE1tDXS6rUnY1JdU7crSPPoMo8C99RmioCI6D3SXaTs0BfSn7Sr
 H39GOx+iQUs47ox11j0eSAcOTrl84/t6xO/KHGdv67AkxdjQVixvAYaf7akOVPDBhwWY
 bjkg==
X-Gm-Message-State: AOJu0YyLgQlpKNvgXgp3IOqCFfhct2UyV3xjPPfVOJYCDfbGWuJ3tQfi
 dAKOlx/OZ3vHBMJ1qYwLzNVOnSLKF+kDQOhxakLjGWeL61VkzTf2LgsxOye1tihQ+4RVc4bHzI4
 Gndx8v3jb5nxsreVZ8nm2Yr9ASOgc5g8=
X-Gm-Gg: ASbGnctKcsnfELvqIxe3WlykvDW4T9iaAcjX5He2yCl+lJk9/7YSlej6Wr0NYhTSwkd
 0X9Mml0+u0AsqTDa7/meVdGq9ALHRkHkzwzEQpv86jPw1bU49ffNz2jWYr6MpR6SE3mxo4uowJS
 z57i4ppOprmsMbvkNb63riHf86qJUnJ9zWlcWtl0No2S+xEvGpH3isH/gHamExsIzm1Vm/QR7Z5
 NxEPLJ5BWQyIoOhDLPrBnTwGY0hO9lvYH2PKJKss6DV8EGvNnv0fHXuUlAw2U55C2NFcQ==
X-Google-Smtp-Source: AGHT+IEuU5IR7wgy6jCNXIg1Hn7J8V/bAIXc8BLAARXvH4oqZlZG3ue8gQWAkqDhPBu6175WvJ67d05YznMhXdrsQF0=
X-Received: by 2002:a05:7022:b881:b0:11b:a8e3:8468 with SMTP id
 a92af1059eb24-11c9d861131mr13038689c88.33.1764243317178; Thu, 27 Nov 2025
 03:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20251126154734.940066-1-pzmarzly0@gmail.com>
 <aSd0ROg_3snWMuCB@x1.local>
In-Reply-To: <aSd0ROg_3snWMuCB@x1.local>
From: =?UTF-8?B?UGF3ZcWCIFptYXJ6xYJ5?= <pzmarzly0@gmail.com>
Date: Thu, 27 Nov 2025 11:35:06 +0000
X-Gm-Features: AWmQ_blbvIVxuevPv2ADMrwCJMATwF3PCrp0HqD12ggWL7m_Yloz0vByq12FNy0
Message-ID: <CAEZNvsuV=++SxRhSXe__zSCO7ShyQheL8yHVsbeAH2J4ReJ08Q@mail.gmail.com>
Subject: Re: [PATCH] migration: Fix writing mapped_ram + ignore_shared
 snapshots
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pzmarzly0@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, 26 Nov 2025 at 21:42, Peter Xu <peterx@redhat.com> wrote:
> Now I start to question whether I should have that other fix of yours to be
> for this release or next.
>
> If this use case is completely broken, we shouldn't need to rush -rc
> window, now I plan to merge all these fixes later when 11.0 dev window
> opens.  Let me know if you, or Fabiano, has any comments.

It is broken if you set ignore-shared and actually have any shared
block, but what could work today is if you just toggle the
ignore-shared flag on without setting up any shared blocks. In that
case, writing will work fine, but reading will crash. That's how I
stumbled upon this rabbithole in the first place: I forgot to unset
the flag and was surprised by parsing error. Whether it is worth
fixing now - I don't know, setting ignore-shared when there are no
shared blocks doesn't really make sense, so most likely nobody does it
on purpose.

In either case, I need to stop working on this for now, I thought this
will be a tiny side project that'll help me get my first patches in
(and get used to collaborating over email), but now it's growing in
complexity and I have other things that I need to prioritize.
Hopefully I'll come back to this within 11.x window. Thanks for all
the help so far, Peter, Fabiano!

