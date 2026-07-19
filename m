Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66936C4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 16:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlUB9-0007iE-Nk; Sun, 19 Jul 2026 12:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUB8-0007hp-9f
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:46 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUB6-0002Ox-4L
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:46 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 1B12A1D00064;
 Sun, 19 Jul 2026 12:15:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sun, 19 Jul 2026 12:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1784477740; x=1784564140; bh=zsUyDu7DbN
 Ume01aD9op4gMX/XVIYwfAxiKaO+JABzg=; b=DIYr5UkEuPmVptQ60NUrBB1nNh
 L+C14XEWglcK65oALc58GZKVeRRaKg9WAlA4pgNUDqwzf34FnhA4n3Z4YUXV8E44
 sZD+xFZEA2k2gAOO8jAADpdOW5LlFODxpoIEkxxhf6lxuNhlGIVcTAc7N7fn5/q8
 f1Kh3Cfhd4PPBMs7gIZYASEc+4JRfy85s6USo7PfJgyYRtMmRM1nA/GhWq+CjhMx
 weVN/KKH4XBlZzfbPelwjzz0UB22DeXKAfBVhsBzqR2PR6tXNZLx83Z2yDtQpEWx
 wFhgmsL3VXYkPAKkdWcrSs1/H17nuijgLfizJ4sgJBxRYjM8Hnq1kkS6MWOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1784477740; x=1784564140; bh=zsUyDu7DbNUme01aD9op4gMX/XVIYwfAxiK
 aO+JABzg=; b=X80aX68CybRpO4vW1Bf2wEbtgW64MzO0mML682yhy8D9bBQNGUc
 3FbvXgkJN4Lqkrq6h7IftMeGyIyvtjmz7JrJxsJmlv6iH7v4l2ycO6h7CfHBK1g3
 Zk40/Li+UgDjthForKnshkrM0t0tiy+5O9tGfTOHTxeSQq9kFVj9rsPgtfZ4NwUU
 m99vxeyGYWOU3vXIb0ebtDSC93fTMjdGDJKsbcfdjGaRif33742eWpCSzStwoMKT
 5cTw4Vd04gpdNOcCO4vjDmJUveckgBukHjj10CCc6xmP2XzPD6wCkwMzmvpGMt5t
 P5y8y9YTnzrtyaHcvpyPaI/oG+YkPgyp4fA==
X-ME-Sender: <xms:LPhcauSWwFBwhoNIztlsabW5KV-YG-cAFIDI8aCDJMRnKcR103w1LA>
 <xme:LPhcarMOk-1mDBvTc7qKgblhML8UbRHMH8FO0OPHMpUeI18UUldA0SExlQfpFbuR0
 YClpBRSV-9inXWGKTkR7fdvwPEqCjosFIYPv68TuLeDSGbhqshrCnxo>
X-ME-Received: <xmr:LPhcapMcVEL3qHAk42QSRmc-lmVXl2BzFZWed0ZGiGjNMVP_XEIZDzWIK4I>
X-ME-Proxy-Cause: dmFkZTFhLrl/k4otgNiBxdSPYdp/Q7eFimbMN36j35gmN4yrN9X5MRviytLnGSjlCxfmYd
 8c/HwBDGHv5TlMFHiwPLazIGoF8LAtT7U/vJXYu+YxH6hLBKH31PvPARLzHsvaDqIUHl0h
 adjSHLe8ixc79s3t+FdL5UTjZciEllKTzCuHATdJrabhmuF2aG3/8HrENOLYtQfgJ8MkOP
 C2TzYLD3j0RYgh2ZzNG2jpzhLNZ2n9lJU+LsBXN8++sT44X8xD/3wUteL61xONQZ3MOavI
 8s5v5vH6agUyz9rMbfHOqbDJnkrP6LjCYrCvyBZaBl9ZKGu3+9lJJ9nwXwvIiuX+2HGdjY
 p4PGtK9uhHSouxPUm2PWiQDOzvBKmPUKSYG+8Jq8hqvE9UpfB3AnkSNU5EnzzvTWi9EY11
 w9HxMN813f8l/2uu8g4hkhDVvOjtKHZuht42DHW9PyroUV86prLTRdCP63NuYWn1G5OqcE
 lg6nTIBZy4C8bwro0JA0zCM2MPRHYSzzROeGwV3DyfUm3v8h/vQyWuR1qVvTAZwVCG/i7r
 +v3OmwlrX0yfo0h7ERIGD/lAYLYveqfmdyfWir9TAZeZVAntAhDtWmKph3yjg3+ke3Xivh
 jNKbfVyOqBqaskHnxRtsF7n/gVAQDCRcnWyOlwj1SLlsqsZIvWd14w3Z6xYQ
X-ME-Proxy: <xmx:LPhcajvAyonluxNMUf_kmvhoXYOc4bpqoqSKGDzhuSj2xP7vmW5o_w>
 <xmx:LPhcarVWzp52L1tGyzLW-LgBOU2EyOzRKSp17Mt4FIhtkwFvErd56A>
 <xmx:LPhcajsKL-9pgtglZAJb5jjvyUioTIBcRfPupuWgsARe9L7mQvwKzA>
 <xmx:LPhcavVmbyDpSNut6ZRrn9qR5NYLtRSev08bcnRYwUUM0_MVogWjqQ>
 <xmx:LPhcalYKPf8Szsax4ER_byowNbUFRcjCXg9e-uJT37mOnB7g0a-BGeG->
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 12:15:39 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 875759a8;
 Sun, 19 Jul 2026 16:15:39 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 0/9] ati-vga: Implement r100 CP engine
Date: Sun, 19 Jul 2026 12:15:27 -0400
Message-ID: <20260719161536.774061-1-chad@jablonski.xyz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.146; envelope-from=chad@jablonski.xyz;
 helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 FROM_SUSPICIOUS_NTLD_FP=1.999, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

This series implements the CP engine for the r100. This includes the ring
buffer, indirect buffer, and packet processing for Type-0/1/2 packets. Type-3
packet processing is left for a future series.

* Patches 1-3: 2D engine differences discovered for the r100
* Patches 4-5: Implement and use the GPU memory controller
* Patch     6: Type-0/1/2 packet processing
* Patches 7-8: Ring and indirect buffer implementation
* Patch     9: Scratch registers used for fencing

Tested with Debian Squeeze (kernel 2.6.32) booting with the radeon.modeset=0
kernel arg. Xorg initializes and basic fills work. An xterm window is displayed
but unfortunately, the driver uses a Type-3 packet for host data blits. So glyphs
will not yet render.

Tested on Radeon QY (RV100) (PCI 1002:5159).

Hardware tests available at:
https://codeberg.org/cjab/ati-tests/src/commit/5c3efeb0bcebdc7e6f780bb6c5d3a8dfd7a65e35/tests/r100/cce.c
https://codeberg.org/cjab/ati-tests/src/commit/5c3efeb0bcebdc7e6f780bb6c5d3a8dfd7a65e35/tests/r100/pitch_offset_cntl.c

Chad Jablonski (9):
  ati-vga: r100 scissor dimensions are exclusive
  ati-vga: r100 does not latch defaults on DP_GUI_MASTER_CNTL
  ati-vga: r100 pitch registers differ from r128
  ati-vga: Route GPU addresses with memory controller
  ati-vga: Route r100 src and dst offsets through memory controller
  ati-vga: Process Type-0/1/2 CP packets
  ati-vga: CP engine ring buffer
  ati-vga: CP engine indirect buffer
  ati-vga: Scratch registers

 hw/display/ati.c        | 221 ++++++++++++++++++++++++++++++++++++----
 hw/display/ati_2d.c     |  52 ++++++++--
 hw/display/ati_int.h    |  74 ++++++++++++++
 hw/display/ati_pkt.c    | 151 +++++++++++++++++++++++++++
 hw/display/ati_regs.h   |  20 ++++
 hw/display/meson.build  |   3 +-
 hw/display/trace-events |   9 ++
 7 files changed, 498 insertions(+), 32 deletions(-)
 create mode 100644 hw/display/ati_pkt.c

-- 
2.54.0


