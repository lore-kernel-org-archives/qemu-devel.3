Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359C5C5DF9D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyXpk-0000Fg-Sr; Mon, 24 Aug 2026 12:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sinxx198@gmail.com>)
 id 1wyXpi-0000FA-Uc
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:47:38 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sinxx198@gmail.com>)
 id 1wyXpc-00016g-J4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:47:35 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2d5cad1a6baso34785025ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787590051; x=1788194851; darn=nongnu.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tMlYqhJMbZiPC7gUT8G48tTW7xJKfzGAYPtkNaRLyKc=;
 b=qmhpvgAvvB4MAsOFx8cBvAEQlpm9TypF99VUEPDPJrgmUYVltj7Uv4936Wii0bUmwq
 G1SlImw3cGYAjOFuJQ27UcjyLkwOn6bN3n/hdBteq3RuBLC9IOdB2CVF6WJ632DjrvYQ
 ZNUDqUaQcxpB/EQNsBXjMGXAC6i7qFuJD1jK8W7c7K3KDza4X226pUy1QU2A6RBNGxTs
 LL3783U/GDBY+zDNIiXEazilZgAvnYikL5MSiTwmCPEhwaN8jue1cKMyVn33E35lVAj8
 Li/Mr22WoY4rYiW8gjYYQI+rWte3WcuJaF9jkxIn4arkpASdOoQXZFXyQYfVu8Z1awkB
 ZovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787590051; x=1788194851;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tMlYqhJMbZiPC7gUT8G48tTW7xJKfzGAYPtkNaRLyKc=;
 b=MiJgJ0bSb60YlD+K8ca+SLOifvmOTLVf7OeMm52yIn5mrU1kAgHLKVO01i2ZPLzgxG
 CDXr2FDIbapeNLdzqEMD27iuTh3awCGE/yBh3Bk21OoLVZo5euhTEFp52zn5O4iyOD7t
 fbs3rBdCh+m3dYqrD6YuTlebqRLjmU4l1QQ9nZcAzwqKzhJFFFVGGEJ2XcF00/O5PmY3
 LSsd8euUbefm7av+auozkl+l3x9MstTmJr03yKaYtjzRXFjPnvAZaPe20M0yvZVKgiGa
 O2GeIciB8m3PTc2Pbl8S8auW5vwDd3Gsjvv9hhLEuo3QlopbhLKZdyRzvO0voS+gHRUU
 FRYw==
X-Gm-Message-State: AFuF++ny5FNzirDkZSTHXD74BfcRfdgFbSxjQh2s/EOdvRroKdGxNn8b
 VVkbL5GGg2loYxcaLtrSHGvn7w3nb6JT4Ea6vkzloOdOvBbVbT9qWS8w+NO7ANiHaz8=
X-Gm-Gg: AR+sD11yXIWFkwJvgomRFoLBdTJmbpbtJcwJkiYJXiXHwm+hyq+/1D6htS3w6/yA/2b
 H7nJEn1u2I8XwvligDAfoQUlEem+QiyDfTHIsrFJUxwMfIdKqZg+kH7C9+KaY2rHC0ezwRS2che
 pIA+nkY4ILNaO5HUvzRBRxgyPEyUvh/3vio+c7eaL48aeZZSemo02I86wnJe+pPoZ9rwYOiLMOw
 ok/zuuBE+8NMpZ/xR4Z/5FTPkkpyw0Lgoti63xbSQCDwwmsfcP8bO029XhwTknJCPE4raplMDkP
 sLq2z3rJO15pRiH5rLX9XJ4DdLfg+s9jPcr9FBkvNq+2OluM4ugmf+oD7HlBRINHvI99JUQD/od
 KME22auO49xqCxiYm/fuHsIBa0fRC3+DfkDgPgs7J4ZzDH3Mve5y9YsbejFjnZ7pVCvlhcXQjtM
 ReL4gVgupmAdVBbMaxFoeYAhjWITbgeZkUOXLW/ywZSiezsdVy+xLhrT6MiA==
X-Received: by 2002:a17:902:ebc3:b0:2ca:1479:d9dc with SMTP id
 d9443c01a7336-2d64b0427fdmr556391425ad.12.1787590051200; 
 Mon, 24 Aug 2026 09:47:31 -0700 (PDT)
Received: from kali.sinner ([38.240.225.76]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d6768dad15sm19664295ad.72.2026.08.24.09.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:47:30 -0700 (PDT)
From: Warisjeet Singh (sin99xx) <sinxx198@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: Re: [PATCH v2] hw/display/vga: fix text-mode OOB write after a
 graphics surface switch
Date: Mon, 24 Aug 2026 12:47:26 -0400
Message-ID: <vga-v3-reply-20260824.sinxx198@gmail.com>
In-Reply-To: <CAMxuvaySFoRqkz2UpWNeooBaqouyMLaZy9N38UbykQ38j3NWgQ@mail.gmail.com>
References: <vga-v2-20260823.sinxx198@gmail.com>
 <CAMxuvaySFoRqkz2UpWNeooBaqouyMLaZy9N38UbykQ38j3NWgQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=sinxx198@gmail.com; helo=mail-pl1-x62c.google.com
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

On Mon, Aug 24, 2026, Marc-André Lureau wrote:
> We should finish separating gfx and text state.
> The text functions and paths should only manipulate
> last_text_{width,height} (in vga_draw_text/update_text, and text path
> in invalidate_display/common_reset)

Done in v3: vga_update_text() (predicate, cache stores, the -1
invalidate handshake, and the mode-message box) now uses
last_text_{width,height} too, so the text paths never touch the
graphics cache fields.  last_{width,height} are written by
vga_draw_graphic() and the shared reset/invalidate points only.

Re-verified on master @ eea8fe61b8: the qtest PoC (graphics 80x25 px
-> text 80x25 chars) is caught by the surface check, QEMU survives;
SeaBIOS text boot screendump still gives a clean 720x400 frame.

v3 sent as a new thread: [PATCH v3] hw/display/vga: fix text-mode OOB
write after a graphics surface switch.

Regards,
Warisjeet

