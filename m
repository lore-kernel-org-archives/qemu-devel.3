Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A46FF886F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 03:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIe9A-0001EU-Vg; Thu, 30 Apr 2026 23:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIe98-0001E1-GW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:02:30 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIe96-0005Wj-Nm
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:02:30 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-42fdab683b7so904483fac.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777604547; x=1778209347;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=La9fZ55Ybv4Hk3SiJumG4N0jk+ElxiRkXK2LFs2Wz9s=;
 b=cD5Xz7cWcpxIvPeFvgMEVBQin7xXczJYJcyrW0hmCrMoI4clx/x3Vvno6oHqtn9lGh
 rdl9jv5G2h+3UFFlICD8CaJJzVDLDvXVeJPjdBmWSKmItdoELDfHSI+t6JzkrQhEcUpQ
 lgjMajZMhId5AIjxWRGClS52DWAETwLFsrC6dZQmNu9+Ywn9qK+B8bIuk7J1ZW0eFU/L
 +Yk/sQjcbTpod0YF3N2BqKnXUBf+/cOh9GJ6AaM7KbRhhsaBAL/6X1W6xk37BjNzeDzK
 EgqX7br7OnMKSZm8o/5rC+p3UovNHcgYEM8EwFIu2HemoBY1m9KjYo74eyZi8dUt7n7g
 vQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777604547; x=1778209347;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=La9fZ55Ybv4Hk3SiJumG4N0jk+ElxiRkXK2LFs2Wz9s=;
 b=gAywtuBAXoAal1kiym3KTzcVswe7gQiTlUWZShJM9kHL+8/1C1wcqcV3p71qPHDZey
 n5CeNwh/CVLzcWGUo3MGJLCEE3JqNL97bOQ5P4YdnJLLJ2ZSeNUnK/3Kd6I4DuKPmCjm
 sBAwegGCognzKwAR8Wk1/CpAvNSn+U06waRaoeIPW0F97JT9wu5PsrUWo4fB7IPlo+hV
 Cu7P9XrQ6I+Cm7PnFqI/uzdqDAgnHXdUK/HBj/XhOmIQWQLBObM85bYsjEuD73yJ1Miq
 WkxQW8nbxwizVu5kQx0Xd23qpwbWH2e6j7dk4bNrCea+Mkx9nywAXE6eoxv153ikXEjP
 Fa6g==
X-Gm-Message-State: AOJu0YyqCSks/zvN2VmBEdQjzJrS1r7gWabBiu2RxCxQck9hs2v73g2R
 4cNvaBaVY6kXuc4bVTshEMxZSX15ceHV2DMWBCAVqhJEO0EAmswLfx/rnV1G8acxPJ0=
X-Gm-Gg: AeBDieswclp22JMC3Cb0bIewVOb2CP2G/7aejYKlJMKJ9S7MWTbVB4GU6S0m1/QTI0I
 /t70nixAbH9brLwZiwwA2QDf8pgO2ewsqW5j6FaNQ6il87vv59NSdpXjodpBLNeyhdajXyBQXdx
 Ihq6AZfw8F2i/d7sFcU4ybytEsREMTLGQESdpJRBvTNAlxMRxmf9uvkTrSxIq/QYQ8gD+DtAeNs
 IsP19WixLvqPRaKMZGK2Slwlk5GEobzNrSNDH882wQlPoLAZ1/5nqNycAT4QA4RxQfw3a8Q2tpo
 ODOj0/GFcGCS/cdl9flmfJ6x1YMk8acvw8V3bVzXYmFrskXx5sNAsJgr0KgUmn2HhyU4PFfosUU
 aY4pmDdBj7m8FAnrmKtB9UTECWOr1/fooyd2fEhxACST9zstvO6gLIINHqRVArbnQhhY7vutDsH
 pRa6IYzS4wdR1iPBQLOkki
X-Received: by 2002:a05:6870:241f:b0:41c:bab:5f9d with SMTP id
 586e51a60fabf-4345c027f53mr636827fac.4.1777604546615; 
 Thu, 30 Apr 2026 20:02:26 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454cbc3c7sm1550875fac.12.2026.04.30.20.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 20:02:25 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 0/4] bsd-user: Generate system call numbers
Date: Thu, 30 Apr 2026 20:59:29 -0600
Message-Id: <20260430-syscall-nr-v3-0-4b1b2445e28f@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABEX9GkC/1XMywqDMBCF4VeRrJsymYiXrvoepYs0GeuAN5ISK
 uK7NwoFXZ4D37+IQJ4piFu2CE+RA49DGvqSCdua4U2SXdoCAQvIFcowB2u6Tg5eGjCVVo2l2oB
 IYPLU8HePPZ5ptxw+o5/3dlTb+8/oYyYqCbIpIYfKQY5k7q/guJ+uduzF1ol4sFifLCZblCbJ2
 lml6WTXdf0BKA4zueEAAAA=
X-Change-ID: 20260412-syscall-nr-a0a831fce9a0
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2289; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=lKHqamAG62DpM7OjBtdX0S6TLOZtOlswz9aiG/8nzDw=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9BdS2s9Owk9Sfexk9/FDpzOtWgYLLlTKTbvzQ
 mUZmRKuE1eJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafQXUgAKCRBsHNEofbAR
 AOmbEADNf1bRQU9A0v7qTjvhrQ+r0A4W3CPdD1NJaDU3+2HN84TREY5X1ZB3GhvYn0g2lGZkotF
 FSPPSqwrGRdwSl/7jXajQ46/0U8v1GWHPwKGTJ9wjBaYu6PUTpxkt+jh7lIMXkcX9JCyAzl4Y6s
 wmTghRb9VuyipyZ0t/J0BTQuiFc4hx5sMGEst6AibGFylMV/I8FaSalVOPNBayMn+30wBpqYFxQ
 8yk7SRUxoBp7+NKteK9zkUJ4QlJ/xql3SaTBT33doOhEqIzwVSZkZ0Ik9IvXPGTO8lwREM85ob4
 x9vxAxhEF8LHSL1beiuP2wl5KDcd17M0Fn4xyHFgWcUycU4xSnoAUcaLMo8w9vICMS+l8+0qz6B
 2kY2IRl8z4w9EVByIFNYh+Qud+chKn7ixDqB+7hRmTzedRZ/ZrDubImPR42OdvOaXmnuEPAP++W
 Z7omNPVoD9TEw0tAaCLVByLJcvsROFDYhqbPtK9cYRYxBOrJez2a7lno5Voo+0SRhR3M265f2Xu
 usR0e+NUNEutaxjLhzTWPxlzcxsZCIULD0yn2j8f6H2/FsLuBP9IfOo/cSgK989hv/PEdlzehpx
 6rBBy0ZRek4UbHEk87E2Zv5HFyfnzehgGjX6Q2QrqZKIL83SZWr+46bE0SarZX7SKcFtDDKC5LJ
 YNK11QzkZMDdCoA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::31;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

FreeBSD has a system call number header, sys/syscall.h, that's installed
on every system that can compile qemu. Generate the system call numbers
from that table rather than re-regenerating it yet again.

To do this, I have to clean up a few stragglers for system calls we've
removed. But these returned not supported anyway, so there's no net
change.

I also tried to do this in a way that the other bsds can coexist with
should they show up again in the future. To that end, I moved the
definition of time_t into os-syscall.h, where I noticed it was wrong for
amd64 targets (which is little used and missing features, so it went
unnoticed for a long time).

More will be generated in the future, but this is the first steps.

Finally, while this does add files, no adjustment to MAINTAINERS is
needed.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Changes in v3:
- Drop the strace stuff, since I thought it was ready, but not quite.
- Drop extra files included in bsd-user/freebsd/meson.build (soon though)
- Link to v2: https://lore.kernel.org/qemu-devel/20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com

Changes in v2:
- Rebase to tip of master after 11.0 release
- Regenerate strace.list, can't do this at runtime just yet so include script
- Simplified syscall generator meson integration.
- Link to v1: https://lore.kernel.org/qemu-devel/20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com

---
Warner Losh (4):
      bsd-user: Add syscall header generator for FreeBSD
      bsd-user: Delete sbrk and sstk system calls.
      bsd-user: Create os-syscall.h
      bsd-user: Switch to generated syscall_nr.h

 bsd-user/bsd-mem.h                     |   2 +
 bsd-user/freebsd/meson.build           |  10 +-
 bsd-user/freebsd/os-syscall.c          |   8 -
 bsd-user/freebsd/os-syscall.h          |  21 ++
 bsd-user/freebsd/scripts/syscallhdr.sh |   9 +
 bsd-user/freebsd/strace.list           |   4 +
 bsd-user/freebsd/syscall_nr.h          | 515 ---------------------------------
 bsd-user/syscall_defs.h                |  18 +-
 8 files changed, 45 insertions(+), 542 deletions(-)
---
base-commit: 759c456b1d22fe4083c8b384da27d3f56fd53f82
change-id: 20260412-syscall-nr-a0a831fce9a0

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


