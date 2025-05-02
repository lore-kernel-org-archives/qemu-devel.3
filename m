Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA10C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 21:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyFZ-0006E9-8D; Fri, 02 May 2025 17:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAyFX-0006DH-Ek
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAyFU-00042G-TB
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746222526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qG1KShUeTk18GlOTqskYZG4cMnUbVcprVf33AbQqpCo=;
 b=PrcpQ/uKXAXKnD7Db8UjYQPqp1lFIzB3gMZuNDEwfb53WoVoMbbeMOXUvJvBYwVFPnokOC
 8spWm+qPvKQEzVtOF3rlQUlJmayP+Knoo6dQZ5K4I5SYrERWcGHMznJ/zOuOTSDp9j+hVy
 y9Z8tRAlcKTv/jVc55Y2cNrSKSTq06c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677--EfYRzunNJis3FCekEkZMQ-1; Fri, 02 May 2025 17:48:45 -0400
X-MC-Unique: -EfYRzunNJis3FCekEkZMQ-1
X-Mimecast-MFC-AGG-ID: -EfYRzunNJis3FCekEkZMQ_1746222524
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d01024089so15641775e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 14:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746222523; x=1746827323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qG1KShUeTk18GlOTqskYZG4cMnUbVcprVf33AbQqpCo=;
 b=ugTc7HzUrkdXLDDD8RFjWeDfQIwiRyukrkF+e0fGaTfJWeqSTV2b8UD3ln4eybjtnB
 fbrnDFN9T7mxUBmvFRRMOAHqUfXSrLS3NzP7Lo6SgjsKMBpqEwpHqhjWhWupMNoyJLKh
 AvFwGkcpOQIbPxoCILlOLFTmTH3oRYnPyF0++raQzZYYDh0WgA5fUa52A6tFX3rQxp/+
 gN9mO7imNUvMbpsHzOgyh1c/mehQKERdZHeNYFyWpu+P/jB48qdeO5X0elDWKOQRIJRb
 o0QE+9ldCwh2qEusC6pQsQNNbiDwYpaIB+5w7fMsiUCVGVg51kdW7JHWCZfQCIx7+v3m
 Pjcg==
X-Gm-Message-State: AOJu0YwrbYHcMNAhKo8JK0aNeHTM5tMIN0Mhs4fL65suOBM80lCUavWU
 8SIBc4bOjLInDdGQwMmos51ldV5bS6oTS+/iJJI8tVeSXvW5rIHDIw8Hz9+MIeSoVaTI9c3LlcN
 cM9RAbygsD/uLbd5T9pGn78lw1Lp7S8tUEO7u/7xwmfQ9vmlLm6h7EduyHTBCJTTupS3zG7u/3J
 qHuxQD6NryXYCUouUy1W0+V0U5hod2pfyiHq5o
X-Gm-Gg: ASbGncs18JYTIku37FSuxda0C0vOQnWzGl1Vo8ZLbFK1wlmft70LjDG+evBT7AySlLB
 dSTrWeIt2COklEeOzzgfo2ZgotqL2vrvWadCINEPH7Bbe+4cjuL2maZxVrvDWF4VmcgnMU07kc4
 WHuwULJf4h/Qx7Lc01/NvVg54t/6ZjPEb//lyD4e4a/vNZN31L9mVeeD4b0vObQoxYlQPlr1dK5
 PRzoK0jyA+6+/gzrKwPJ/OLifU/F4qgVqIXzECEugCJMCr6+ulDdnM7nvg3zB7vuHkvAMU2dSbk
 pwO1CPx+ptj8KTo=
X-Received: by 2002:a05:600c:1c26:b0:440:68db:a013 with SMTP id
 5b1f17b1804b1-441bbf2cb29mr32375665e9.25.1746222523283; 
 Fri, 02 May 2025 14:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwuk81mlIyv6PQ3wvB5qLXnMgSSE7ZmdcQ0wN7OGCPgzJyht+QjOYBVTdsl6UHLqA71PZQcA==
X-Received: by 2002:a05:600c:1c26:b0:440:68db:a013 with SMTP id
 5b1f17b1804b1-441bbf2cb29mr32375545e9.25.1746222522842; 
 Fri, 02 May 2025 14:48:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a315fdsm55302455e9.34.2025.05.02.14.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 14:48:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org
Subject: [CFT PATCH 0/4] target/i386/emulate: cleanups
Date: Fri,  2 May 2025 23:48:37 +0200
Message-ID: <20250502214841.242584-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These are some improvements to the x86 emulator that I wrote but have no
way of testing (right now).

I tried to place them in order of importance so that, if something breaks,
it is possible to commit a subset.  I tried to compile the resulting code
on Linux but I have not run it.

Patch 1 is just to fix warnings on Linux.

Patch 2 is the most important, as it fixes some real horrors in the code.

Patch 3 makes flags handling use algorithms somewhat similar to TCG.
It should fix issues with 64-bit ALU operations, but it's also the one
where it's more likely to have a mistake.

Patch 4 is comparatively trivial, though I cannot exclude any screwups.

It should be possible to test this with both HVF and Hyper-V.

Paolo

Paolo Bonzini (4):
  target/i386/emulate: fix target_ulong format strings
  target/i386/emulate: stop overloading decode->op[N].ptr
  target/i386/emulate: mostly rewrite flags handling
  target/i386: remove lflags

 target/i386/cpu.h                |   6 -
 target/i386/emulate/x86_decode.h |   9 +-
 target/i386/emulate/x86_emu.h    |   8 +-
 target/i386/emulate/x86_flags.h  |  12 +-
 target/i386/emulate/x86_decode.c |  76 ++++++------
 target/i386/emulate/x86_emu.c    | 125 +++++++++----------
 target/i386/emulate/x86_flags.c  | 198 +++++++++++++------------------
 7 files changed, 197 insertions(+), 237 deletions(-)

-- 
2.49.0


