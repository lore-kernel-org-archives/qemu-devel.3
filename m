Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAB0C88E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 19:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5qH3-0007bZ-At; Sun, 13 Sep 2026 15:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x5qGG-0007Oc-8a
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 15:53:17 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x5qGC-0006CZ-1i
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 15:53:11 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633cd78so547797f8f.1
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 12:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789329185; x=1789933985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6SS5MwxEwlCAoKS4/FhjnSRX16Od8hAKhlzTyGhVfh4=;
 b=fqxSX6bzukhriU9S6j8roxxkxkp/OsRTKkowi2PRLexjjij3IIlo7/cdO7w9m6f8RV
 FtaSyRPy/gzH8xRBRF2Z9uYCEf/T1iTgI3/vc/BdU1NmjGMJpWD2b8eOKVgBRJmQ5xBK
 MmdQLy62zj8/wajFG54cGACrFtlanqQ0obddCwZcXawzDdJX/7EfwwIzGG1wFrwVu6gJ
 PwxWbyOmCKTgu9Gl3pLmjedBGNf4djcGLDKe05dDDCSf1If264OxGVbFmP7bzxSfIZRu
 XvW3DgptGcp8SAbgNPVntmuhaygQL53VhOLDUdCJ9ALaRAZWL0QooSGv/tIVGP5uPARs
 3c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789329185; x=1789933985;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6SS5MwxEwlCAoKS4/FhjnSRX16Od8hAKhlzTyGhVfh4=;
 b=fDLDuHSMrBnRtKOFyAPhPRVImDxFAfDrpYbGNq+EQ1N+A91JURJWYqy6Z7MxMrMwCy
 eKjPZBVtAnQ9nMWckP+Z1gtd76Bl/Qhad/oESlRA8ABzj5GdIy0+Hnjos0PcUwqioi1G
 BSMGCwYQwbZLDzyg3Xwa/7MF0X/2NTyLpGUtHov9fZ5lM753BCKbACASZK1FNKcoCon2
 whhqgRIc1BCcMsbY5KBL/vZStBvGIzOhMEhutKiIEQjen1bmo3eO38iKyBZ1/cY1qAEI
 EBwe2VdSP9XoauvYQQAMYgHyUAQQejSFuToYxAZ4D2sKCmFDoOjJ9GUw322d+smpcV/y
 EvpA==
X-Gm-Message-State: AFuF++mXSQ/1Y4zeLPRa7XPCMNpt5xz++mAWV1sSzjYvBFRQbr+0mOh4
 94eg7Wou+x6k38Fj5vuRtZooeI536Psg0WBN+1GbuvZIec/eYoSRVtrwRUIDPlGBPO3EFYVpXB9
 pHEFj
X-Gm-Gg: AYBFou3P/3O/Eni8pypGjSNQhv+uG6I7bP5LX54PyE+H4IidC6c9bo6j7Rw9UFpI7Ug
 0SLzDpIu7smvwwYeswkfbF8s8hGXtLo9u96ntX/v3mkRCG7HTd6NzdB6GuOz91KtdEgcsLtw6GU
 9Nq8LceHqbkM3wVYpe/unvwKQHHwtIavXDncAeN8xFDMGH0OR/6ED1ojO57vJyrC5lYeR51nvMU
 m3L5Rj76UwshHFJ1RB5VwUfRfglGznFOiMAU+24iMOY9eoGbqNyrklcF/PIBbJqh4TCVKlRoB3K
 OkA/Dd0T3TjH9hFLjA4WNB6iX/7kD6GoOzzYrmnYF0ta0r3ouYfDF74Bsi2vh+el1e6ES+9v6BF
 ZHDqJOw8jjrxix3vKL2B4LHzwCy9A4rdcTXPHFLDe2AUZDPLDER+S3ojr/Q0k6p3yT0xj+KDJD+
 j3jSEq042cZUtH9V0NtBbqZF+KHmxbCpZWtedXv3hDGeJmqBb0ke4JuSC6rPqG
X-Received: by 2002:a5d:5d86:0:b0:487:1f7:f506 with SMTP id
 ffacd0b85a97d-48701f7f532mr60490f8f.11.1789329185077; 
 Sun, 13 Sep 2026 12:53:05 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:ef7b:3cbd:e3a9:adbf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fc02sm20374678f8f.16.2026.09.13.12.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 12:53:04 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v8 0/3] parallels: report the stored dirty bitmaps in qemu-img
 info
Date: Sun, 13 Sep 2026 21:52:58 +0200
Message-ID: <20260913195301.1514888-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

What is left of "[PATCH v7 00/25] parallels: Add full dirty bitmap
support" after the rest of it went upstream. The other 22 patches are
merged as 209b2afafa ("Merge tag 'pull-parallels-2026-09-11' of
https://gitlab.com/dlunev/qemu into staging"), so only the qemu-img
info reporting patch and the two iotests which consume it are here.

The numbers have shifted: 19, 21 and 22 of v7 are 1, 2 and 3 here.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>

v7 was:

https://lore.kernel.org/qemu-devel/20260903144143.2328870-1-den@openvz.org/

v8:
1: On Markus' review. @inconsistent reads "is in an inconsistent
   state and cannot be used". @bitmaps drops the clause about bitmaps
   which are not written out yet and becomes "A list of parallels
   bitmap details", matching ImageInfoSpecificQCow2, and the struct
   description loses its stray "dirty". ParallelsBitmapInfo moved
   next to Qcow2BitmapInfo, out of the ImageInfoSpecificFOO run.
2, 3: Unchanged.

Denis V. Lunev (3):
  parallels: report the stored dirty bitmaps in qemu-img info
  iotests: cover storing a parallels dirty bitmap
  iotests: cover the qemu-img bitmap operations on parallels

 block/parallels-ext.c                         |  26 +++
 block/parallels.c                             |  20 ++
 block/parallels.h                             |   3 +
 qapi/block-core.json                          |  45 +++-
 tests/qemu-iotests/tests/parallels-bitmap     | 217 +++++++++++++++++-
 tests/qemu-iotests/tests/parallels-bitmap.out |  57 +++++
 tests/qemu-iotests/tests/parallels-checks     |   6 +
 tests/qemu-iotests/tests/parallels-checks.out |  19 ++
 8 files changed, 390 insertions(+), 3 deletions(-)

-- 
2.53.0


