Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7A6C5CFDB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuqE7-0006b6-8q; Fri, 14 Aug 2026 07:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wuqE6-0006ao-Fq
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:37:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wuqE4-0007Jp-P4
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:37:30 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so11883065ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 04:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786707447; x=1787312247; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8XDSjibgMTV3XWum35vrlTytl2FLR9rc+9sSmrpjMeQ=;
 b=RwWdlznPvB6QUGEdJZ1ssaHszAsk+gjrKH/HIk2ANPgJ0v86JpMeVr2PUK7JjxD+UX
 48SM6FRiHb3NyVXGNPB+5Y90QmbtE9qkMwEputqYJYcaTL78sVJ52deoZ3zOkAhQNl4X
 5vQL7XENsNxbJj2jAmGfWsVs1BjNz6MCwn/6qamo4W7uGKP8t3S1ocfotPNbdPBtCP5i
 1HJZ67Migtw6+wNyucOLcVldYUhn1vl0hvUh1Fw6QRrQwrGRm2U8VtGCKFKynzHgl6dl
 CWmNmCgGwrqCmxjT+KZA/7PjDTgWUqQU4VOE5RFduhs0nN/Uj9gmJJWvldA1IQdDn+Kj
 m+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786707447; x=1787312247;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8XDSjibgMTV3XWum35vrlTytl2FLR9rc+9sSmrpjMeQ=;
 b=GkQ7RnB5SgCmEcyyvCv+4e6QhCmyrI4cJOn0RYDXi4XAM8+SofO6zULJBIoBJEQOV0
 bd5rrplBbL6q4e46RBxnRk+fbmHhGbn2j0US4CaSqAxpR4PdBe3fC48CLxAbCtHSI0Fw
 1ov/ZYrvOtOu+cJm8fVkTD6JbxP0NEEAWGcF80fBqTgeft8IjhvDUuQnAslletPqvPO/
 jP1E0UXxAA7ErGf9oW4J8azKlR/Wji9krlg231WYWxJVYB28KFY0OMKaA1R+R8SHyNXx
 LyeJoqMeSXBQOZ1kCK7Tm0FOOMFl7iMw9IIjfK2LaNdOjIc5uKEgjwD9ILKaRdsVQ3dG
 NnAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHkPjUcNeUQwOsj9oiXr45CPJGeNTIRVILpejPd6GMlUQLjrSvZGnqGOta/UZ9xNS/GYdS7Sn9t8Gv@nongnu.org
X-Gm-Message-State: AOJu0YwLdxMu08mXByp+SBu+mKadl27A7bnMhiCo1Dvf6lf2WH2rQGs7
 5a32vbg3WXPODLvd786nq1DaM2SmRMIno1KP0ckia1wmgqooV2u1brIm
X-Gm-Gg: AR+sD12uxENtASmfY/eiywAqp6p0u1cgCY3/utrak4/PQfSILMgiuRknuH61XQ4rvHV
 z/IekOYIKkoDZ+hjiJSPrNwswbWr/bQ2daRsALK4y9qXhfwoStlXtsYMzaXrTZi2957TpPvhO69
 kbyxQs7vZYXvG6SHVxCzUl4VVfhd82mJFW8arLBtuHhRg/VaTKYpx4E/UeX5Hg9z7+BW8+ZO6wo
 +T6mQL3utkRPVQANpwWrTMdEEP6PmCRi4hNu/FqHGstG4jt8nny6XU/u5mLbGUHv6wYPgo6txf5
 7hH5S4fJIbqEaXTBFsthKEt660MKIPyX2STXDhisPMAStywD59hw7uGdQ+3o7VjOsKcvbiHSWXc
 a6ALBL1kiuvFUzvvnDG2hAxojwZTJQ0gv8dqKruJrh0ZMCjbauHf4TKVEXM9NZfzOMvgNYW0kpn
 wM7qIAwyh1kVOka78tyLwKLVXpBebX98UFww2o6hXSaLWxFRhPQh/e6z8Aeb4lybLuMKNCWMBu0
 Hb7z8/UUs56Ed09dFt1OZCHjxFvK7oH
X-Received: by 2002:a17:902:da83:b0:2ca:6d87:cda0 with SMTP id
 d9443c01a7336-2d3b08589ddmr43214855ad.6.1786707446926; 
 Fri, 14 Aug 2026 04:37:26 -0700 (PDT)
Received: from google.com (114-137-1-217.emome-ip.hinet.net. [114.137.1.217])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae7a32bbsm8533725ad.26.2026.08.14.04.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:37:26 -0700 (PDT)
Date: Fri, 14 Aug 2026 19:37:16 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: WX Chen <wxchen0913@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v3 0/3] riscv: Add K230 DW 8250-compatible UART
Message-ID: <an797N3cUZj5EX0h@google.com>
References: <20260808-feat-k230-uart-v3-v3-0-d73b31f0034b@gmail.com>
 <CACPK8Xfgj+AUx0h_46f=qG_UEE_o7kTZ0=Buxr7+bdHDODHpgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xfgj+AUx0h_46f=qG_UEE_o7kTZ0=Buxr7+bdHDODHpgw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=visitorckw@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 13, 2026 at 07:50:18PM +0930, Joel Stanley wrote:
> On Sat, 8 Aug 2026 at 12:02, WX Chen <wxchen0913@gmail.com> wrote:
> >
> > This series adds a QEMU model for the K230 SoC DesignWare 8250-compatible
> > UART controller, wires it into the K230 SoC, and adds qtest coverage.
> >
> > The implementation supports the registers and features required by the
> > Linux 8250_dw driver, providing an interactive shell over the serial port.
> 
> This is a model for the same hardware as this patch:
> 
> https://lore.kernel.org/qemu-riscv/20260616190147.1286316-2-visitorckw@gmail.com/
> 
> I'm not fussed which one we end up with in the tree, but it would be
> good to name it generically so other machines can use it.
> 
> 
Ah, I've been a bit busy lately and totally forgot to send out the next
version of the milk-v duo patchset. I will probably make the changes
and send it out soon.

As for the dw 8250 uart part, I'm not sure if I should keep my uart
patch in my series, or if I should wait for WX to respin his patchset
and get it merged into the riscv tree, and then rebase my patchset on
top of it?

Regards,
Kuan-Wei

> >
> > Signed-off-by: WX Chen <wxchen0913@gmail.com>
> > ---
> > Changes in v3:
> > - Removed all hardwired preprocessor #if conditionals from the logic
> > - Added a helper for the receiver line status interrupt check
> > - Encapsulated CPR and UCV register values in header macros
> > - Replaced g_usleep() with qtest_clock_step() in the qtest
> > - Link to v2: https://lore.kernel.org/qemu-devel/20260725-feat-k230-uart-v2-v2-0-d5fe82c47c28@gmail.com
> >
> > ---
> > WX Chen (3):
> >       hw/char: add K230 DW 8250-compatible UART
> >       hw/riscv: k230: connect DW 8250 UART
> >       tests/qtest: add K230 UART test
> >
> >  hw/char/Kconfig              |   3 +
> >  hw/char/k230_uart.c          | 816 +++++++++++++++++++++++++++++++++++++++++++
> >  hw/char/meson.build          |   1 +
> >  hw/riscv/k230.c              |  33 +-
> >  include/hw/char/k230_uart.h  | 198 +++++++++++
> >  include/hw/riscv/k230.h      |   6 +-
> >  tests/qtest/k230-uart-test.c | 514 +++++++++++++++++++++++++++
> >  tests/qtest/meson.build      |   2 +-
> >  8 files changed, 1559 insertions(+), 14 deletions(-)
> > ---
> > base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
> > change-id: 20260808-feat-k230-uart-v3-0ff3651d70ef
> >
> > Best regards,
> > --
> > WX Chen <wxchen0913@gmail.com>
> >
> >

