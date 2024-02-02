Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3814BC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 20:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW0T0-0000vJ-PG; Fri, 02 Feb 2024 15:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3MVW9ZQcKCgYqusrujomuumrk.iuswks0-jk1krtutmt0.uxm@flex--komlodi.bounces.google.com>)
 id 1rW0Sz-0000v7-CX
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 15:48:53 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3MVW9ZQcKCgYqusrujomuumrk.iuswks0-jk1krtutmt0.uxm@flex--komlodi.bounces.google.com>)
 id 1rW0Sx-00007u-Je
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 15:48:53 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2964520a438so602482a91.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 12:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706906929; x=1707511729; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ErERYQ0sEpDcgbGqoWZPsVfPCOLStoMFvPtCKiYyRlU=;
 b=gttMJcSLUBLWyAzw6O0RENLNr9v7bs84On/XFZ9kkfRdDhZYlbIe5iVdoX3oiD0cOd
 CSo8d2HVNa7J1g0GCt1F7x0PfmHkQG44RQmdKdHoCFwrKN70XJsowSnqfUZJBEKTlvg1
 awGs64HgeLO1AXwAa/X4aT53eRJ/D73PfMjJPv6jAXOFuSkxKCQLhE3y8VLFiKc0x48o
 IrjY1Tt95+FWA+ljr7vLwGLZyptZsFNAk3klCK577GOVFjSmdeTuRWb/t7Bifcp7kcFZ
 RfOVC8OM/CQoBrTboUUUQWgdOzAfOwKH5SX4koilNHJv/wf3z/bFkA5zbxTKeOPDYF/h
 +3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706906929; x=1707511729;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ErERYQ0sEpDcgbGqoWZPsVfPCOLStoMFvPtCKiYyRlU=;
 b=vwY8NJINSODUPpRSFxWQHsd45oAYTJ6ZLuY+Poea9y5S2Hn2sNwp07e3pB48O2leUU
 aEBdFGd3VWhMHxg6z9ZbbWkYWbLpjpJuacdQyCj+lKx0Nx1UOSGxS+qdf0BWGV4E83PD
 oPFOTYAAHLsZhOgu262Mb0CJTLtoljWfYcYT5MJdC9Gsx08vlesnoJdS/tkMsHQyK+Dn
 W8MashaftWC8k9cnfL9B0wbyUQnj22xmrvguPsUmZ21EuXfKbtt8Z1+rFdTrFsBbMS8U
 HddFgdJpxMcM+COmf/WxZVQZhgmzqtIdAR2PGsvmup3rIv1W+J16e0PKkXX8lVvUsaeT
 /Uig==
X-Gm-Message-State: AOJu0YweuvLleziPsFRp4yAvdyD6BNuWoLEYi18p9Pt1uW7RIn+u9P16
 VhFLMoA3GmfkJYk/qp4jf8QSz4ONojWK7JYn600XxFZ/IunpFmVqS6Udc+gq42o8TL38ARHhOAu
 pykHWbRL47UDYyyUpxiBBmYQrKJ4P+HyntVDe/VQE4VGiaXOmlvD3bcFmPnJ7fzDnsMhmHA+gIW
 1cXjXb8HHdnVLz+KC1AjwJ+wgHyoOR8gXV65Gs
X-Google-Smtp-Source: AGHT+IFpxN8MQ0oiGFCNKJx5H9GuxG+unSPRRzAer3h+IVO377fiXHgbC6NiJf0Ofmt9iAFf3arqMq1Fvz/g
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a17:90a:840e:b0:295:c117:d9e9 with SMTP id
 j14-20020a17090a840e00b00295c117d9e9mr41769pjn.4.1706906929159; Fri, 02 Feb
 2024 12:48:49 -0800 (PST)
Date: Fri,  2 Feb 2024 20:48:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202204847.2062798-1-komlodi@google.com>
Subject: [PATCH v3 0/3] hw/i2c: smbus: Reset fixes
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, minyard@acm.org, 
 peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3MVW9ZQcKCgYqusrujomuumrk.iuswks0-jk1krtutmt0.uxm@flex--komlodi.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Changelog:

v2 -> v3
Patch 1
- Removed I3CBus class definition, since it was unneeded.
- whitespace fixes
- Changed enter_reset to hold_reset

Patch 2
- Moved pointer returned by object_get_canonical_path outside of printf
  so it can be freed

Patch 3
- Changed enter_reset to hold_reset

v1 -> v2
- Dropped 4th patch "hw/i2c: smbus: mux: Reset SMBusDevice state
on reset". After more testing and Corey's comment, I realized it
wasn't needed.

Original message:

Hi all,

This series adds some resets for SMBus and for the I2C core. Along with
it, we make SMBus slave error printing a little more helpful.

These reset issues were very infrequent, they would maybe occur in 1 out
of hundreds of resets in our testing, but the way they happen is pretty
straightforward.

Basically as long as a reset happens in the middle of a transaction, the
state of the old transaction would still partially be there after the
reset. Once a new transaction comes in, the partial stale state can
cause the new transaction to incorrectly fail.

Thanks,
Joe

Joe Komlodi (3):
  hw/i2c: core: Add reset
  hw/i2c/smbus_slave: Add object path on error prints
  hw/i2c: smbus_slave: Reset state on reset

 hw/i2c/core.c        | 19 +++++++++++++++++++
 hw/i2c/smbus_slave.c | 17 +++++++++++++++--
 include/hw/i2c/i2c.h |  2 +-
 3 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


