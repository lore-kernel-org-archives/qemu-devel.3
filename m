Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61962CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 13:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMnVp-0004NP-50; Tue, 12 May 2026 09:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuhongchao006@gmail.com>)
 id 1wMdJh-0001Iy-0R
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:57:55 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liuhongchao006@gmail.com>)
 id 1wMdJe-0002na-FG
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:57:52 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b4583f0a1aso32122615ad.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 19:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778554664; x=1779159464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/xC2L/LCqvnJPcRURIpvcJRdgYlFaajzQoA9qrJGRw=;
 b=s+wjE5xPp+6S8zSzQKVr5Fjmm3qmIjdLz8ykETCKq5rSXs2fNZiaUKQP7ajh5vZenH
 WNZGCsva6WPIDW7VWEKbShqH4pcnrjRlRU+qKybyvpHKU/dtLTyZFBzx0K6xJikXyR39
 KJvKY+TzEkL3/9Z2EcQtIQ5/54P0odzn/3MAnRKf1bBwhqXIT/R54tg02BNT4irDTfON
 xnCPLzDD6xzbtmWthWBhVrKPsoK13dmpc7OPtnmmaugdqGwvJFawfHiIXcJA6gCPCCKl
 9oPwLWqD9JWvSPCzqsy5CXtI3k9gLte8xuv1V+MugPIUZwYxEDd5RmKkoGo/s9Z6F2Rw
 jU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778554664; x=1779159464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j/xC2L/LCqvnJPcRURIpvcJRdgYlFaajzQoA9qrJGRw=;
 b=iW9Z+NUKq9542bcr9zT8cIw4T+JgNMrcBZ7z4I3Fy3SynTQDAnytnhSURtsSBksEoD
 1Jp8H2R3YM8pLJRclUGqSA6jO+v72hd/bObkNz9Me0QMis/p8OViDu69yn+Z78FC2k3O
 Dmlv4tIG8jZbrBtR37+nAVvCNvxh4VB5yfQTAYBJ7L1t1CQKK4Ao6H0tyUizFm3GGJLW
 Q0RiUBf+EwR2oWaDe4oJW5XbDjiWyVMhRzz3e0WA3BgpM3Wn5C0xT07GWN5scfR8tIY9
 XUUO8AKqS/BhimNUaS9ZWlslTf3+5kPZfkQonEX2NW3HXQUU0/2AqJEuPQuB8bshAC19
 xofQ==
X-Gm-Message-State: AOJu0YxxLrNrJPv7/nKkX/TnRvJZutcRscj4JcZQdquNxAN5LX3jmhDn
 GJ08HYaMsDgpIHdKxlvUcvHV7d7U9FaUq9nNpiobEH9JoEK/KA5pYDf4786/ng==
X-Gm-Gg: Acq92OFn49J4wA5LpSsjdt9KZiYFwKIaJ4uothg3CBipplsg5uqQzKHw9DlgroIljTd
 ipEYoztm5TtHOABMSCv4cMA46Z4sFUZV4rtAoNyh5hKC3AZlPYDSz1vmc/bTvR5rnBsxdNM1EdX
 JSNdN3O29Aqbu9Kzp+sihAGXi/IpBEI6jbuGmMAIdXSa60II74qQN2GOse9dB2AbgPwZHcq/cRP
 XTAKbWHxVevZayu2/pE2BkYgZlB+HJLVQWHnD4x07kvVmz7pmJbnzphcQYDOTjRkkUzdsIYoEBD
 OJ5B4GDf18pJMYbiKByOVuxh+uTy5BS1yOyXjFOzum5/IZMn2tV2iHLSVYLl3jR7ByRhr190l+e
 J8qQMd+pAkRkNc0AnCKf8GpzM4QdxQqcaxOSyf+YmW5GWKu5BMy3ZfPuqVcATyQvhLE8tkLcnPY
 iSAPIjIpdykFpVvPVB4wuIA+ZA3W6F3YzZiXEMDxHEdpobpt81YsGX72A=
X-Received: by 2002:a17:902:7c82:b0:2b9:fb9a:1103 with SMTP id
 d9443c01a7336-2bc7ac8b06amr87434565ad.38.1778554664423; 
 Mon, 11 May 2026 19:57:44 -0700 (PDT)
Received: from lhc-Computer.mioffice.cn
 ([2408:8607:1b00:c:f202:a9a3:a60a:7ccd])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1eac3afsm126905855ad.71.2026.05.11.19.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 19:57:43 -0700 (PDT)
From: Hongchao Liu <liuhongchao006@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [RFC PATCH v2 0/1] ui/sdl2: replace SDL relative mouse mode with
 manual warp-to-center
Date: Tue, 12 May 2026 10:57:25 +0800
Message-Id: <20260512025726.1842622-1-liuhongchao006@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3d86e8cfc12040eca14364739b0a35db@xiaomi.com>
References: <3d86e8cfc12040eca14364739b0a35db@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=liuhongchao006@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 May 2026 09:50:48 -0400
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

From: Hongchao Liu <liuhongchao@xiaomi.com>

Resend of an earlier RFC [1] which unfortunately reached qemu-devel
with a GB2312 charset (due to a corporate e-mail footer my previous
mailer silently appended in Chinese), so patchew could not parse the
patch ("error: cannot convert from gb2312 to UTF-8"). This v2 is the
same code change, re-sent via a mailer that preserves UTF-8 and does
not inject any footer; no source changes relative to v1.

v1: https://lists.nongnu.org/archive/html/qemu-devel/2026-05/msg01701.html

Summary (unchanged from v1):

SDL_SetRelativeMouseMode(SDL_TRUE), which ui/sdl2.c currently enables
on the grab paths via sdl_hide_cursor(), switches SDL on X11/XInput2
to consume only XI_RawMotion events. X servers that can only inject
MotionNotify (VNC via XTestFakeMotionEvent, nested X sessions, some
remote desktop setups) therefore never deliver input to the guest once
it enters a relative-pointer grab. The GTK backend in QEMU already
side-steps the problem by doing manual warp-to-center in gd_motion_event
(ui/gtk.c); this patch applies the same pattern to the SDL2 backend.

Points I would especially like feedback on:

 1. Keeping sdl_hide_cursor() around with G_GNUC_UNUSED vs just
    deleting it. I kept it for symmetry with sdl_show_cursor() and so
    the XI2 rationale has an obvious place to live; I have no strong
    preference.

 2. Whether the edge-detection threshold (<= 0, >= size - 1) is
    agreeable given SDL_SetWindowGrab clamping semantics.

 3. Any concerns about the default-behavior change for local-X11
    users. In my testing, local-X11 behavior is equivalent: the host
    pointer just gets warped by a different code path, while xrel/yrel
    delivered to the guest are unchanged.

Tested on:
 - Linux/X11 (local Xorg), SDL2 2.30.x, qemu-system-arm with a
   relative virtio-mouse: pointer is no longer stuck at the window
   edge in grab mode; release after quick drag delivers correctly;
   absolute (virtio-tablet) path unchanged.
 - Same host reached via VNC: no regression; mouse input stays
   functional inside grab.

Not tested: macOS Cocoa, Windows, Wayland-only setups.

Hongchao Liu (1):
  ui/sdl2: replace SDL relative mouse mode with manual warp-to-center

 ui/sdl2.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 3 deletions(-)

-- 
2.34.1

