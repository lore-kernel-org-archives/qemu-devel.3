Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A68DC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 13:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tndmZ-0001Zm-60; Thu, 27 Feb 2025 08:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <meowthink@gmail.com>)
 id 1tndmU-0001Tp-Qs
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:18:28 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <meowthink@gmail.com>)
 id 1tndmS-0000ev-HP
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:18:26 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5452ca02bdbso947095e87.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 05:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740662301; x=1741267101; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yyvBZ2Jwlv7Blq19Tuoahs+2eKZjrmTDTeNA9eDHOMU=;
 b=B4ZXzWFUXryW+xGlf/HHc9dwANzWJkgqHQIbceA9Gltm8HTkJ//i6Cnbkwuywm2nUB
 JnisSfHsgHukXG9xfJPzB/WC/tD88mWYTOnTy7xWMWVaX5xFCNUTAScTtWCnGQ9xdPXG
 6bB2ih8S9fjtvfLSN3AqRnOlcUTJQ/kjq3MGTzDs/tUFmUNWQYeePYBGNgGIwlt2qGf2
 E8TfEDJapQHF3QbD4fXMby9yOLkQYCa1324/pvWBo4Gcv3kqdYWz6Pwe4/dk+yQRl/N+
 0/TPsBjk32EqpyCunGEQi7FDnSDMi4nR1o8VFmeyXrIdwxd7Z8YCHTfwe705CKyoeBDm
 M/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740662301; x=1741267101;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yyvBZ2Jwlv7Blq19Tuoahs+2eKZjrmTDTeNA9eDHOMU=;
 b=klFxx4ssEGyFiAqe50/yuT7XYGwy0rkXmp2NOKUy3MPie3g10Bg8bFeazmmOBpswU5
 cmHZjDX5ua+v2G2jopYlsmiKaCLfYVx/A8sXMWdcr7weYNl5jrGkcyOumH3URkr+fPc+
 ucQ5711eAqJrQ0QKGox5JR9eHHpjov1HTJ1rANyvsaiOthPAUSFBWbMNaP2ZlQXCrlpW
 OqJ/SaIK12s8aMUsTzkfTVamsQQFH418NSQWDgyOhDyZ3dmehrIenp1KcExveEkrTYqb
 W9zHz7qa7V3/dcZj9sG/yO1WRik8AjlYmxwQ2guGJOZZuQsH7yCYZIjSnOw3TiZVQclp
 HDNA==
X-Gm-Message-State: AOJu0Yw3LRrhhbQhUwSCyAhdl1vtpfD0mEQGQT+Cw/pZrILM3i7+UunK
 aM4tN9IF4CJ2I3YyftUOy9oL/m0/VSvLRaYldXVElMTMu2HUQE7U78+AqC4UQCcbBDB6eySJQe/
 WTbIaakS5/wUtdHqgNl6DZk9AQjrGJy71BYo=
X-Gm-Gg: ASbGnctvQSVN0jq5PE5kUeHT7d3cFLwR2glZ38PcWZw1bJLu5ULM89yhVfc4YTTHyrA
 BtrBsTJHcnNeM5BkoATWInJpfw7bHGm8kz9NODnvDluVObx9TJwlbWTWcW4DTIFTFoT8NZ3tYYH
 LEXbCkFCMG
X-Google-Smtp-Source: AGHT+IFtWnzEtSjNaxXeKVNHZu3rvLJ2WQ2eHquHwzNmdBj/icpcxEeIe60He5IKAEyzWW9mQ7mrmjwT6TRfTzwoNks=
X-Received: by 2002:a05:6512:3d16:b0:545:62c:4b29 with SMTP id
 2adb3069b0e04-548510d2891mr6035394e87.22.1740662301154; Thu, 27 Feb 2025
 05:18:21 -0800 (PST)
MIME-Version: 1.0
References: <CABnABob99XZCBwsWYQKKjT3aMWzodAzmTMM6AB7utVz_un_9gQ@mail.gmail.com>
In-Reply-To: <CABnABob99XZCBwsWYQKKjT3aMWzodAzmTMM6AB7utVz_un_9gQ@mail.gmail.com>
From: Meowthink <meowthink@gmail.com>
Date: Thu, 27 Feb 2025 21:18:10 +0800
X-Gm-Features: AQ5f1JpcprTjMK_jJg5wy1wmov45T6yAQpwI4hvId_s3M6oTmBszudF8JRXQ1pA
Message-ID: <CABnABoZ66-h9iUZtgoP9k_MMTP2_FpBw83LLiPOYe-CWbU-+PA@mail.gmail.com>
Subject: Ping: [PATCH] bsd-user: freebsd/os-stat: fix getdents(2)
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=meowthink@gmail.com; helo=mail-lf1-x136.google.com
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

Ping for this patch:
https://patchew.org/QEMU/CABnABob99XZCBwsWYQKKjT3aMWzodAzmTMM6AB7utVz._5Fun._5F9gQ@mail.gmail.com/

Though not used by recent(__FreeBSD_version >= 1200000) base libc,
this syscall is used by concurrent (like the newest v4.0.2)
cosmopolitan libc. Wrong emulation leads to things like python in
superconfigure broken.

