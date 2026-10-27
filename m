Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4210606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qaKmi1Hv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLZvQ-0002VH-1R; Tue, 27 Oct 2026 01:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLZvM-0002Uj-RT
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 01:40:41 -0400
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLZvK-0004Pj-UZ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 01:40:40 -0400
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-369f3e9e431so459825eec.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 22:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793079637; x=1793684437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b8yIEW3WuAmlQJ0bWC2xlltYR67kLiU9V6AGMzwpN14=;
 b=qaKmi1HvV15VKzSqvW5/Z80+bvjAy0S/bCZ2+oQyC19Exn0ns0muZTMpXla3EFyDgG
 P0U32EYUMKfGASdnS6Hpm9PEeKxSWKlbG/rXtGW/1OjJ6bhI2l8gkRkiKX99YqL5ojNW
 0AqVFLNYTJGZ4YVrxrBETs3uVFD1n7grRhuNK/Um44W9phbWJfr6q3udS+m+4pkQ7apO
 tmfqIqcIFVRRCrjh3IUwBwHwv3zU5v3qNbzALkBicg4pUyh6aI5t8HfMlVzKr9OHoy8z
 T5cQogcCYMzskzhxPCGll/zEeeHiXE4BpxOXD+YJ+VAUEFPMNfmpDYp6tWtkpPNGjUIL
 LUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793079637; x=1793684437;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b8yIEW3WuAmlQJ0bWC2xlltYR67kLiU9V6AGMzwpN14=;
 b=JZoXb8X5b+2ph2WofppVVH5oASlH6YGv1BpHJhZasDyc9etlvTsMQPi6yTcx/LnmWw
 vLilQg2fVTwQbZasR+taj51VlZqP8Re2mN1I5zlpUxUzs5xIkdd3W5h/yNuDIRioHNdL
 C4cMxwoKC+H4ZIV0p8QY3qTwO45/ojw8a0A2MNNOy8Y+3ZaOCv4y9ZHgUrgGmA+I6uM4
 AEjrRFWotkvvnLKD4mYzI6BM9NDa2iAMzVaUSSV+NPrhq1La9PCdcHaj/xki97OWDP9P
 cIFk+4XXi5uVH11R61PIFyG0IEjtIdr1L0Vcb8cNneilwacppzICmpFsxTaLSxs5R8xW
 /7Aw==
X-Gm-Message-State: AFq9FYKGCKwwy7ueey6gnz96RJX3qFhaDH609+vzX+kP3nLaGRFk3HY6
 RlcChOu2vvOq/R9NCQzuD4lTi8fVMfzeurG+MTzChRy1/PUxO3yboKa3MdiWP1RB
X-Gm-Gg: AYBFou3eSe6DzHeqZQXq85FtJtC/8aQRsxolIqWfFUd3y1cdJBaVnnfbOQFQVLJGcHM
 zwrFkU3ne4V4rnlyeUTRN8aEN/eZoiJRasxWYyjUN23zWhRDLkg72pM4a/V2y8LoawZ8dkTzvIc
 ujR4rf9tazvWgp5+eyNgWcJw0+oTLiKtITeORKJgK2ZBOxyqcWNwNOiUwheKvilL3+1jbhzTXCr
 6neLzBKLe2RfYxW0lVJoraFWr8sFMWU4pbGEzNpO7cwRQt++w396qXee/WDFXneAwH0+xGsot33
 U+wsK/6gIjtl8N4SugYOWvyZTzjrz/wP0992958Z+3/iO8DDk8m4bpZ6KSs1uIf8+9cy67N9Vhc
 4wEQ0mm2tlqDLtl0PXxfUQ9N9XAo7AmOBuGRaGNHMjkawWQ2X1cAkT5R10L0Ldbvql5y+kAZapU
 Pyyk4csU+XAFS2sWsczUABGVUTDQUUk4PWqH+yFEL1ML5xA/1QXQi/tB/SzErMUDJdXpi5KSfrn
 CFObd4lEEEbFvJ9VmOn/47MTfmM4p7xcKA0OD4/Bs8SDJ18Vd9Ron5ZKviE/PC8RA+FoVbzEdU=
X-Received: by 2002:a05:693c:65dc:b0:353:5d7a:cabe with SMTP id
 5a478bee46e88-36a0f81ac0cmr1985391eec.13.1793079636625; 
 Mon, 26 Oct 2026 22:40:36 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-369e8ec9276sm51416372eec.25.2026.10.26.22.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 22:40:35 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 0/2] Register accel-$cpu_type for all targets
Date: Tue, 27 Oct 2026 13:40:24 +0800
Message-ID: <20261027054026.2184-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In multi-target binary, the target list is more than one, so
we need register them all by iterating target list for system-emu.
The user-emu still register the accel-$cpu_Type in the old way as
it's stil contains only a single target, and it do not have the
target list in QOM way.

This is an alternative way to

Link: https://lore.kernel.org/qemu-devel/20261024173649.7405-19-pierrick.bouvier@oss.qualcomm.com/
Link: https://lore.kernel.org/qemu-devel/20261024173649.7405-18-pierrick.bouvier@oss.qualcomm.com/
Link: https://lore.kernel.org/qemu-devel/20261024201136.27090-1-pierrick.bouvier@oss.qualcomm.com/

doesn't means this is a blocker of them, they can co-exist.

Yonggang Luo (2):
  target-info: cache the QOM target list before MODULE_INIT_QOM
  accel: register CPU parent for each target

 accel/accel-common.c           |  6 ++----
 accel/accel-internal.h         |  1 +
 accel/accel-system.c           | 24 +++++++++++++++++++++++
 accel/accel-user.c             |  7 +++++++
 include/qemu/target-info-qom.h |  4 ++++
 system/vl.c                    |  2 +-
 target-info-qom.c              | 26 ++++++++++++++++++++++++-
 tests/qtest/fuzz/fuzz.c        |  2 +-
 tests/unit/test-multi-target.c | 35 +++++++++++++++++++++++++++-------
 9 files changed, 93 insertions(+), 14 deletions(-)

-- 
2.55.0.windows.3


