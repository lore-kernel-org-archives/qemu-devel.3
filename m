Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935D3C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 21:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxvOU-0001ve-3M; Fri, 19 Apr 2024 17:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1rxtq4-00049I-Ig; Fri, 19 Apr 2024 15:24:00 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1rxtq2-0007D5-Tc; Fri, 19 Apr 2024 15:24:00 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7d6230233f9so74172739f.2; 
 Fri, 19 Apr 2024 12:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713554637; x=1714159437; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uJUxi9tsBykObmLhNkXt9AkdhoGWi4TZIDvAKqsWtAw=;
 b=mPQiJTAjEa1oMKDn0tDsAiVAtQ+YYu7QougqTjRgn56uHIA5mQy/v2uFxezyXmmo0j
 5n+k0F/IJLWBOXul9KHaTBljyiOERVnS0m35T8GMDxVPfLsaah8IvKD2N7zUuu9Ti9g/
 ox5Hn59Bi/c3kgl/txwrNbP1LvPACYG0S2En/mm/yfOLl8ceIsEjZOt/ZJHge8Qe314D
 ccd5QlNyKqD3zmhazlTegaCNaOwwF0gGHMuXchiw7xmRkyIV4EooaWbenX7CnYjWJRWu
 AFhJpwo6HnQKviM5h1uw687h0bZGDPtvV6kMXQfGz8jbrm9vuZ0eMIx1rAi8DQyzHGY7
 surA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713554637; x=1714159437;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uJUxi9tsBykObmLhNkXt9AkdhoGWi4TZIDvAKqsWtAw=;
 b=RyDIajDFQvwbp2oaF8XJyZtq7Rx0biLCbIOLxuxa03C61dCjwQIA9EYQz5dwwHYa9B
 ypIAeyyUagm0uQFmr1Z+UX8Dg4lTe7sxwghb/ccck/+CXJOyuD2xZuxwgjI4YaPaTwpT
 /rREtlUeHzI4xwtqf46H4Uv1xfG+qjlzVvIWmGhFQFWAtv9BZ2eXVc2ggl+lgGSWCJRA
 cWUEqrB0IK30DbWVZjm8ELlv2mu3ApPBmx6WHKrbehH43E17N97TZQzjAD7KFsmJoMfY
 6elxgavw3yjL5ercOcAShArPymmryO4bXeO1Ug28g2ophbOsS5LNGpJQng8bcUWeMX4t
 tcBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyfMjmn41RSp2jsl54Ub3MlubqSM99+hT7IINra0xAyJPj6D3h/x4AWpBOFHqHicZTVbAVg3SJC6vrLUevKCL1lvspWLhrVg==
X-Gm-Message-State: AOJu0Yw1W3mDh3Ccq4K8bjUW1yjHb+U06ARswMxI8NWClW7gc60HGQLD
 H+3+njwanPRlZdTY5Ghu6OCX8gjiEurX7hn5indas8DjqmCnNsSjXWtXgpYa7pGE0jpVYmR+bCn
 SjF1QvsgRqd4CIIvs0dxA2WyV15i82MXlpHyJuD8S
X-Google-Smtp-Source: AGHT+IFj03IyUHw5iRx1QaD1dsphTATHaQm9ALf9MYpMXMiLUlpNdiNAFuwgE1N2HPli148KTa7xL5pisnxekQlnl6s=
X-Received: by 2002:a05:6602:1485:b0:7da:4645:4703 with SMTP id
 a5-20020a056602148500b007da46454703mr4569830iow.20.1713554636698; Fri, 19 Apr
 2024 12:23:56 -0700 (PDT)
MIME-Version: 1.0
From: Vilhelm Gyda <vilhelmgyda@gmail.com>
Date: Sat, 20 Apr 2024 00:53:45 +0530
Message-ID: <CADe4k3LvHf5j+nedOq_4w0QrRWz60kBRxJ7W+fW6dyM7_invqg@mail.gmail.com>
Subject: Issue#414 and qemu_mutex_lock() API Conversion
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, jsnow@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=vilhelmgyda@gmail.com; helo=mail-io1-xd2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Apr 2024 17:03:36 -0400
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

Hi,

I am new here, so I found some issues suitable for beginners at [1]. I
am currently looking at the API Conversion task of replacing
`qemu_mutex_lock()` and `qemu_mutex_unlock()` with `QEMU_LOCK_GUARD()`

After reading the macro definition of `QEMU_LOCK_GUARD()` and
`WITH_QEMU_LOCK_GUARD()`, I think I can replace an instance of
`qemu_mutex_(un)lock` at line 1065[2] and 1072[3] with
`WITH_QEMU_LOCK_GUARD(&rs->bitmap_mutex) {}`

Will this be an acceptable patch? Do I need to do anything else before
submitting(other than the checkpatch script)? How and what should I
test before submitting? This page[4] has some tests, but will running
all these be too much for a change this trivial?

Also, about this bite-sized issue[5]. @jsnow has commented to get in
touch about it. So, what should be my next step for working on this
issue?

Thanks,
Will

[1]: https://wiki.qemu.org/Contribute/BiteSizedTasks
[2]: https://gitlab.com/qemu-project/qemu/-/blob/master/migration/ram.c?ref_type=heads#L1065
[3]: https://gitlab.com/qemu-project/qemu/-/blob/master/migration/ram.c?ref_type=heads#L1072
[4]: https://wiki.qemu.org/Testing
[5]: https://gitlab.com/qemu-project/qemu/-/issues/414

