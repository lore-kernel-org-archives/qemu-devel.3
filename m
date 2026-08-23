Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDA8C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 16:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyBG1-0005YV-DJ; Sun, 23 Aug 2026 12:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sinxx198@gmail.com>)
 id 1wyBFv-0005Xo-36
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 12:41:14 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sinxx198@gmail.com>)
 id 1wyBFr-0003HH-Pu
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 12:41:10 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso3628871a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787503266; x=1788108066; darn=nongnu.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bag0Z/yGV5dcU8WnQwFsE29YnVkVQLZxuBD2VCcCgLc=;
 b=rI3YTMoaz1MakhVzazyWGzc3505VWSuO6hTGdD796Fg3pWYsx5BED15AdV3XAHAQiz
 Q49q14uCcAuj0o9ZaHsWDA96J4MDOAdNraynxurW3ufCWzE4dCG38VIU/Zqg3Wr3GCgT
 oWNfj7P3NxqDpnyfyWwmO0HUQrN4ZFRTWmFE5ht50XrFrNGjOPA4p4sa6AkXFqyMJn9B
 9hm+/4bJM5FqX91msmRipYTO2G93rkYiy5t7a562Ed2vmKC0yfkVloAeFU8XlfiIcnOW
 +03sp8vWyg67BdPxvKiKkGPVFkCr6jQosSrCuNQj7rgvYxGfCoJc+Psej7dfJ8+SvWTO
 KTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787503266; x=1788108066;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bag0Z/yGV5dcU8WnQwFsE29YnVkVQLZxuBD2VCcCgLc=;
 b=Pqxsb9CEZywGUnKdJHWl6z2/VKJI2VCnblC80qDuyE88GKv8AuLprTZnor2XFJDT/i
 Q2PdxzJ+uK0haDEW7sHIu+2uxFXbl+xDC2gqYCR3ai8I/MDFS/ltGWQXXlzvt1o3Btvi
 F8feVO+iAhULoXA7pujMGT2zqMbP4yMErsVYcywBCaA/95DXK6Dt151+sPGE5h5DkKb9
 ZDzE+ig5Bs9S7mA3/XnnuxfZJcz75HBbdciIr0fXwM4TR+Q+RqUAUIOKuySSp/2NszMZ
 7hqbn8CCsOTqM36j+fOh4Bzo5/tOv5ot6ArxuckRfUCkts3zxvYKRDDXTdPLIT1IKeUa
 NKuw==
X-Gm-Message-State: AFuF++lCyOkxiFjNh1EzUvMONMwJZF0vZ9EqHhALoulRvZyRS4aW1GAT
 1WcGTnjHYlTG8WwurXNquCDcMgrbpJJJZQYmQNa4ZavYxK5g4vIyolP5XynYHQ==
X-Gm-Gg: AR+sD11nCYYv7v6oxek7Cp09N6jT5ZCeJ+qqvVnoqzdSqB8V8BUUe7fU6vjuveMGnlZ
 2x+8hJ+lFHE1AazsJ1Tp7hG5IZeoCEMqjEUTG/T40Vz9hrAj+fdqz6KXzZ45uE2dNcRBFEqYIX5
 eegsjGZG1t4X1lJw5X0AJK2Xlqw8+qs6iWbiabxZF7AYzNmHg4n2pYlXUj1cnnDHB5KF3/XePN0
 9NkIwIN69n5NekUyaI2sIdYHKwZcTTdt2dzo0FkJsOfCWCind3mXUfMXyQBrQCA1KcQOb13JKw9
 tvRWzy/zyR+6z6jM7ny4vvN78D2DCIN4iLRN2+Pv0W3E1dFnrsy+K2x7Ir8nnl4JNd1p+r4DYh2
 ml3t76PobRTimezDTqgJiAbUNYSMG2vPqsjfy6xsp3LiKQ4m4AM9xykkRaPTMR/b6ofg++XWJZf
 Pf+F350J2nIhKpGRSOI+Yt5SBC0W91G5FOcOdT6iv5Dh9azojDr7ofwTK/gw==
X-Received: by 2002:a17:90b:5846:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-395c3718ee4mr39862984a91.8.1787503266061; 
 Sun, 23 Aug 2026 09:41:06 -0700 (PDT)
Received: from kali.sinner ([38.240.225.76]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e49b4060sm6540221a91.6.2026.08.23.09.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 09:41:05 -0700 (PDT)
From: Warisjeet Singh (sin99xx) <sinxx198@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: Re: [PATCH] vga: split text renderer geometry cache from graphics
 renderer
Date: Sun, 23 Aug 2026 12:41:01 -0400
Message-ID: <vga-v2-reply-20260823.sinxx198@gmail.com>
In-Reply-To: <CAJ+F1CK7TVCTrPsRHtHj3VYqa1vKnFGck5mrGqFdPib=tH0CNw@mail.gmail.com>
References: <CAJ+F1CK7TVCTrPsRHtHj3VYqa1vKnFGck5mrGqFdPib=tH0CNw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=sinxx198@gmail.com; helo=mail-pj1-x1032.google.com
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


Hi Marc-André,

On Sat, Aug 22, 2026, Marc-André Lureau wrote:
> No worries, but drop it from the commit message, or use '---'
> (three-dashes, see git-am(1)) section instead.

Done — v2 keeps notes under '---' only.

> Also add
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4215

Added.

> But the patch doesn't fix the test you reported though.. Can you
> check? Compile qemu with ASAN.

You were right, and I found the exact reason. The split alone is
insufficient because the text predicate still can't observe the console
surface being replaced by the graphics renderer:

- G1 in my reproducer is a *legacy* (non-VBE) graphics mode, and
  vga_get_bpp() returns 0 there — so s->last_depth stays 0 and the
  "|| s->last_depth" term that normally forces a resize after a
  graphics frame never fires.
- With v1, last_text_width/last_text_height still hold (80, 25) from
  the first text frame, so the T2 predicate compares equal, the resize
  is skipped, and the glyph loop paints 720x400 px into the 80x25 px
  surface the graphics path left behind.

v2 keeps the split (units are now unambiguous) and adds the term that
actually catches the swap: the text path compares the pixel size it is
about to paint (width*cw x height*cheight) against the console
surface's real dimensions, and resizes on mismatch. Caches in either
unit can be stale wrt the surface; the surface cannot.

Verification (master @ eea8fe61b8 and v11.1.0, same qtest PoC as in
the report):
- unpatched: SIGSEGV in vga_draw_glyph9() during the T2 render.
- v2 patched: T2 forces the console resize, QEMU survives, subsequent
  screendumps work.
- ASAN build with qemu_pixman_shareable_alloc()/free() routed to
  g_malloc() as you suggested: unpatched, the PoC triggers
  "heap-buffer-overflow WRITE of size 4" in vga_draw_glyph9()
  (vga-helpers.h:80), 0 bytes after the 8000-byte surface region —
  fired through the ordinary console refresh BH, no screendump needed.
  With v2 applied the same run is clean (no ASAN report, all redraws
  succeed).

v2 sent as a new thread: [PATCH v2] hw/display/vga: fix text-mode OOB
write after a graphics surface switch.

Regards,
Warisjeet

