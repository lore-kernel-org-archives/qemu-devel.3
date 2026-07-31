Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02833C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpjfH-0007R2-Mu; Fri, 31 Jul 2026 05:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpjfE-0007Qk-MO
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 05:36:25 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpjfC-0002d7-Lq
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 05:36:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47f707e5d75so540993f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 02:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785490581; x=1786095381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QTQkt42F2hscRyHtvxvg8wwiTcMOrENCPf1iXntbkuA=;
 b=rPted6jbqMne/2tsVB2Ys3B4SBpNHFDsNCJB7urmQxcaNT3toIEZt5QEaCng4EE4Wh
 5tbUfNs89RAHARjJ2p+Q5O/BRDx9YTuNoDiBaWRkodeKnVZHgDaDFVdAB8V9SBoj8phn
 52gAactWlfdOo3CyXUOgBEcc7VL8b1dbXmycBssliC84SODqoR2NSk90GHxkNgMfi0Kj
 kqM2YOMzVrJSR2dgRkZQ9gdHTiQMFkrIC87pIdZAGZFulI4GmkYUXLrlBXjok4XiMMh9
 MHAz11+m0RvVWfvkmzt60nMs2ODvziA8VmICc4eK5GA8gm1gdlESX5OWrdvZBPaeLChO
 G6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785490581; x=1786095381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QTQkt42F2hscRyHtvxvg8wwiTcMOrENCPf1iXntbkuA=;
 b=eZmfPnU2Hs7fmh09UMbfEjum44rY8h/5urbA5ioW3yWMosNKL2KZtUz37VgTg0GChR
 QLvzUJSkZ8zsux0b+lkizPty7dC5lex1E9P6IsWR8vKo3HsdKUOmWgrGbqdlnRRy3MMU
 FFNF/WidxRv4K2WXc4EvrtrVImotfQw1Rh7XIlUu8dfR1WIYuFM+89t8oPADljzsNDKt
 YaJ8anmnRz0R9dYr+I6tGoZdwrnuqzpaFCihL/ipW3zE6PUOfmbOnsrUmsvk97RWIGnJ
 1sh821X5na3vdVjtfh6xB1mVYIS9mVXvzpKSVCnZOEjeariNL09A9xwdAAUEiNQudDsW
 gFeA==
X-Gm-Message-State: AOJu0Yx3dQU0trKf8/0gpylt1ZSAkNNqPLlOWU8CMjwQnbdXWz6W0Sue
 q5UMsgYyV8OU8y3UtyythEgI+q0T3iSzUQP/RXswiQ88ZKbCg77T7UU1auae6UKd4nMitvWn3JZ
 9V2pl
X-Gm-Gg: AR+sD13pRCvf/ER9GH0bM5dLdPig/77yajNF2xmUQm49InP0xDFmmsEzD0MPB3RT5C2
 jens5Z7CFtvoIRJaPSzFJ+jgNmKYyJfCN3IwRmgW3Ba6yiAYE3gfIxC9c17ZKqW2Fbag2QP4n5U
 k2Jf0dQbCr3Vu90n9DtUafc4zfJt1IlJRbyKflQMtDHV4phk7SSf/bppqFBHa3x60FimQyHUOT1
 x+BywnAzesnOB4ZRobxzHz3HXVY54ASYZrWfQKPEKgieoaIVFdQt9jXCRoisZG0VNW+b0eLie94
 JV4TjziNHW6i3pN17buZPUvA/eIuJapNtBBykUJWDekqNsTacDQviw40pd/sk6ADdlgaceb6HGy
 BUiZzAMmXo7FfGFIJ9UQ4+J+wX/yRWbv4E1gZqtsZt+mHHQFUTOzRVfMfjMl/7PBg/DL6C4hNmD
 vJa50wS1yxrf2/PBGOJ/rrXiQX6BEx77mg02f+jyo4s28qjyM/w41NGKNhmI++3I9zdApoOe//B
 Q4b/gHhB97c7C1N5eBxvo8K0OD1QhU9YBoOcvpxC+1xJIfWhBYxLFUDOxeKEB/8h8HFPOKmTOLJ
 zPctvw==
X-Received: by 2002:a05:6000:3113:b0:47f:91f0:9a8 with SMTP id
 ffacd0b85a97d-47fd2ae2504mr3079139f8f.23.1785490580693; 
 Fri, 31 Jul 2026 02:36:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e296csm2861208f8f.12.2026.07.31.02.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 02:36:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 0/2] hw/net/rtl8139: fix vlan tag related bugs
Date: Fri, 31 Jul 2026 10:36:16 +0100
Message-ID: <20260731093618.2961031-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This patchset fixes a couple of bugs in the rtl8139 device related
to its handling of vlan tags.

The first is one that showed up as
https://gitlab.com/qemu-project/qemu/-/work_items/3518 -- a guest
can send a carefully constructed packet to itself over loopback
(or receive on over the network) that makes the vlan tag extraction
code overread the packet buffer by 4 bytes, leaking that data into
the guest. This is a regression that we introduced when we moved
"pad short packets" from individual network devices into the core
net code. Bin and I had a discussion about this:
https://lore.kernel.org/qemu-devel/CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com/
where we started off thinking that we should fix this in the core
net code, but after looking at the 802.1Q spec I think that it is
a bug in the rtl8139 code, and it shouldn't be trying to pad the
packet as much as it is. So patch 1 fixes this by dropping that
attempt at padding entirely, so we always write exactly what we
get from the net backend into the receive buffer.

Patch 2 fixes a bug that Bin pointed out during that conversation:
when we insert a vlan tag while sending a packet over loopback we
don't adjust the size that we pass to qemu_receive_packet(), so we
truncate the last 4 bytes of data.

Big disclaimer here: I have tested these with "make check" and
with the buffer-overrun repro case from the bug report, and with
a simple guest VM. But we don't seem to document how to set up
a guest which receives and handles vlan-tagged packets, so I have
no idea how to actually test that part.

I don't think we need to be in a tearing hurry to get these fixes
into git, so although I've tagged them for stable I'm expecting
to get them in after we re-open for 11.2 rather than trying to
squeeze them into 11.1 at this point.

thanks
-- PMM

Peter Maydell (2):
  hw/net/rtl8139: Fix handling of VLAN tags on incoming short packets
  hw/net/rtl8139: Send whole of vlan-tagged packet when doing loopback

 hw/net/rtl8139.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.43.0


