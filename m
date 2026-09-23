Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190D3C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 01:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Bv3-00032e-Og; Tue, 22 Sep 2026 21:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x9Bv1-00032A-Ju
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 21:37:07 -0400
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x9Buz-0003Bf-MM
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 21:37:07 -0400
Received: by mail-yx2-x0f.google.com with SMTP id
 00721157ae682-85d43f9b119so7856997b3.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 18:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790127424; x=1790732224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sSM04uZwPWrb7xGFV1avfmN4kYfGVTGyo77z4jlk6W0=;
 b=jWKQCeZtJUxhc8TnZymFM2FDi6DermrZ3mKXSjFUfzOKCgwCuXD+zQGi7TQiDCo9Hh
 ruW/zeZdQwbBfrJSSsgJOI95HESjEq+pzvQhoeSwgp66XFZNgTWnWq1dH5PuUfw388W3
 IwX0eLz0Berk27vmNYWCot7bCY9WpH7uJjBqQXhRGKszTIwhkSiWV3n0D2/6nm+QF440
 irBflW6YpJNDHebDJdOOIqlXmlRdCWSurwNYqF/Bb78bah9fqH5MYRDISOBC1+Gwyg86
 2n3ivYk3yeaBv2k0spRG9l9lMqZljhy4VlH/ymbL+qhFrfbDP5erStubP4RbYi7pFtkK
 Z7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790127424; x=1790732224;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sSM04uZwPWrb7xGFV1avfmN4kYfGVTGyo77z4jlk6W0=;
 b=vJ96xrBBOwF5uEgA2+28LobkHG0dWnawP1AdP4IufIWk8VMLKdtl52367JjoELsM+N
 6P8zbirjwYhih0H7Lcl3jzwuaN8q6gnVAhg1PupBNNCCrKZxe4WwT8aAWN5VZ1cisC6L
 bwTuKhO8mXmbe7dgcsOS6h1ERMkBeCJ5TV+GAurLzVajgknufHazhB6WYZamqSqEuN9A
 4vZJwgPZa19BCLpKTv9bnRRkleb/RZtrFA7nk9UviXaG12BnBubD7xeXhg3rlWR5mdOK
 jzjqqdW5ncqrPi+YZpzmQLptytUkW2sfsoMZoNo6f517UKwmv1pu6Kh0ugI1dejBFDUa
 SOhg==
X-Gm-Message-State: AFuF++n9poXKWS8QZFc8ef+N9tCQmbMTRQPT3XUeGeI8T65CGr2DHMgh
 DV0HU5RlJXnzbHp2iL2ZxAIi24Mp9Yl9lqDyuqUrOZP72r4IyCEhwK4QvtI7vSjx
X-Gm-Gg: AYBFou3aisIkFMo28SFiKIU+CmfQ3uhdgkGHdxikk4LVuSovOrz+H44YY6Bsh6bOzY9
 jP6jYxQLdJYqCnvQszF4Q/cG+Ppgl1ekgWf+rpPz/9XY29J7qnlgeGxlx2u3m+SJw5nqUEtMhio
 f+JeopdQGVBEKCWyNaohIi8u80AltvtIPwkQfavTur2hhiol0wonUsEsPhrRvPTpxeRaeNEvbtl
 NDvokyT0R+U2+pPt1k9khHaegUy/5h/BrrXdaTTGEXlGdZsYZJo18WWfKvD7OSwk/SuFq31LZ17
 wpf7QFHX7J62yVQogsf1kSH7I0LMAysmELJNb0fLz6tr94unSCS9Cj49E9qQKgASWr9qnSQVpUW
 aCThRn2VYs0eYX4tMVCya2e5tk2/4lmW8rS4ExN0oqzU5ZSI5qRWSm+p/AVi/NTANI5BRrlCCNH
 sJtROvvHFhvAJkmIiAXEVzXOeBiF3lg0ScAoG0sReLvETgQxnKubGAh8ApuSHibT7IgpFfg2g=
X-Received: by 2002:a05:690c:87:b0:882:31:3b02 with SMTP id
 00721157ae682-8a45901bbbbmr5877967b3.29.1790127423837; 
 Tue, 22 Sep 2026 18:37:03 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a466bc81a6sm4406577b3.46.2026.09.22.18.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 18:37:02 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH 0/3] linux-user/sh4: fix unwinding through vdso signal
 trampolines
Date: Tue, 22 Sep 2026 21:36:57 -0400
Message-ID: <20260923013700.1505113-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::f;
 envelope-from=mattst88@gmail.com; helo=mail-yx2-x0f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Unwinding through a signal handler with the sh4 vdso is broken in two
ways: libunwind no longer recognizes the trampolines, since they don't
use the kernel's instruction sequence, and libgcc applies the sigreturn
CFA to rt_sigreturn frames. Patch 3 aligns the trampolines like the
kernel does.

Matt Turner (3):
  linux-user/sh4: use the kernel's sigreturn trampoline sequence in the
    vdso
  linux-user/sh4: fix vdso CFA for rt_sigreturn frames
  linux-user/sh4: align the vdso sigreturn trampolines

 linux-user/sh4/vdso-be.so | Bin 2704 -> 2724 bytes
 linux-user/sh4/vdso-le.so | Bin 2704 -> 2724 bytes
 linux-user/sh4/vdso.S     |  31 ++++++++++++++++++++++---------
 3 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.54.0


