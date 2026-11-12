Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D2B606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XVLOXuft
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRX51-0007KA-Ej; Thu, 12 Nov 2026 10:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xRWot-0007Rr-Lj
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 10:34:44 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xRWor-0004Yh-5b
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 10:34:35 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-67be9601f48so378669d50.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 07:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794497671; x=1795102471; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h9UddGE2ZQqj6f8ug4uHdt0gJkr3Nog0HYIcg4xSqYo=;
 b=XVLOXuftEIVMm6yUZepFtF4DtHMxA8Z3f4YJHZqhjoG8Xp+B7z63YcRcCJkea5wY20
 m69U9bpNY0vnZZ53Jwkc1cy2YgG5XTvmEDA5sONVaDgoKGBubPp6ltPcb7WL++Jgnpqu
 hfX+JbjJy/DdeNn3RgsLZ9Mwt0n0vnukAULABW5jXt15RmUQGG3CSR9QiklYivVCNbho
 XbgdSYezXzVGrauzGCQwnHAn08yHpGvtVemZfgwxVJrZEEauZManYZdlgwHmA3gkXOgA
 /ZML8g17ajpAm/FmZpCh0t0KJ/vvcJG1+IY/vKyOnjY1982I/p8WDAkjldGNt2PCf/FJ
 KGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794497671; x=1795102471;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h9UddGE2ZQqj6f8ug4uHdt0gJkr3Nog0HYIcg4xSqYo=;
 b=ZF9kSA8TsGMhnmQW7u/QEf3YOYjmcxrPm8aV7HNdoGDOLt0HQTawFE8vYIHl9rTjYA
 8rFOVsg546LL4rhqhXdwgQvWp47bBgT1woOcQfEUpffz9Cw2PZUkYPQQh4u8Bo8Hgrcl
 pfvcBwP/VOwXZIxsh2C5o8JaAreOPj9xGZ4LwenyRyzBkOuhKFrYLmyOxh5F+2rfZgzx
 9QZdf22ZcVENmo1prob3Xe8srQBEUzaoWuzqHQV22Dkrh+VBerNOPcXApMHJYxfg8FWP
 rLs8zOigLaSmmGV4pIZtomc+GbkgYswIjLNIqV1eLnGjHkfy0bu6ZVCYvqg4n3ZLc3yP
 j11g==
X-Gm-Message-State: APuU4Z+OOEpu2gGlBI9D7/XxUumMeU1SUoilihRCNPpH/7ishFaAk+jY
 gnpJa7o+C38j2YTZwHkvnWh8QFOoGFQMs9Fh66/TLPCkSdSYw3/sY4DV
X-Gm-Gg: AYBFou2LomFvyEPWjBLsxyOWf83pIHBs8MEpJ9ggTixGZNmPk0E62Qq4I7R7eQ39e4q
 v+2T8HQU5h/xM362CcgUxcw2smpuQABGEjcKc+YKQdP9ZOW8MBgqsliCDlXffuhKBZpLWqHmik7
 kSPtBoJHjK8j8STAFHVLDddhedtnOJn9bXBPk1Dh99v0+3rR57zcQGpiyKUSv1mX3kiS9i7k4pI
 TsyqR358mAsuigN3YVeYtk15+OuOUAk4r5NEYhHj28pChL1ozpa5KXES2629lXDjAMPuUxxb1Is
 6gqEc7XWW9ojd90+hqrx0P7F5D1uN7SoR59q++BqBOV0QLhBlCyM+MZzqj7MuspN/pzwhbtQtxh
 jrsmriaZDp8n2Lws3JRwLQJY9Mjla1ZgVIQUTRS2YmtRYyhpCSh+MBvsEHHLnv/AbPWuz3x4i25
 BnnC2KBTw5F5QcrSW+FlAeIXKeIDNTRC+uvffDbI2Qgy+Zp/JuRTb0yQ4/Vh2/RBPy2WhEU3hmT
 fux/3n3yaOoiSMEcOXE4/cAsxqAAcOrZ4Una1ltACwDI2dhc0CBrXctriIyoDYC8EoW1nvdSKKG
 bfbHUmJdzJOvLX3iq+Io6ug/zcgKZtQbo/E+Pt4=
X-Received: by 2002:a05:690e:4883:20b0:679:887f:a2ba with SMTP id
 956f58d0204a3-67c67f1cfdcmr3007834d50.24.1794497671384; 
 Thu, 12 Nov 2026 07:34:31 -0800 (PST)
Received: from [192.168.0.195] ([2804:14c:3b83:954b::221c])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c58a09074sm7656618d50.18.2026.11.12.07.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:34:30 -0800 (PST)
From: Julio Faracco <jcfaracco@gmail.com>
Subject: [PATCH 0/2] block/dmg-lzfse: fix short-decode heap disclosure and
 add regression test
Date: Thu, 12 Nov 2026 12:33:55 -0300
Message-Id: <20261112-dmg-short-decode-v1-0-f7f342097b60@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtQCcOuEi1EJ51FGhoRSHdPW
 r7F/w0qFaYKy9Cg0M2Vc+qQ4wAu2hQI2XeDEkpLKRX6I2CNuVzoyWVPqI0wxrppmoWAnp2Fdn7
 +5bq97wcN8vnqYgAAAA==
X-Change-ID: 20261112-dmg-short-decode-69099ac44700
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, 
 Julio Faracco <jcfaracco@gmail.com>, oxsignal <awo@kakao.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794497667; l=1289;
 i=jcfaracco@gmail.com; s=20261112; h=from:subject:message-id;
 bh=BE+YkjW5JluSlwaxMrfT3wqfDPOF0c3c1svb2Kl1Y58=;
 b=2VeovcHng/HAxfbe9Gx266K79Ag7vNzXuK2KEMUdHZp6l8CTKjSn6Yc+20PcgfCTY2DutDqdg
 ZmbrhTENvDzDf4efFlkncbmJcRME/ccoJ2aCMMBfv/NOtb8mNgD1tfM
X-Developer-Key: i=jcfaracco@gmail.com; a=ed25519;
 pk=hAqVCeSg6RtgTRedcz7HIqiICyRcEDanumwIF9bNBHg=
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=jcfaracco@gmail.com; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Nov 2026 10:51:10 -0500
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes a heap disclosure vulnerability in the DMG block driver's
LZFSE decompression path (CVE-2026-116483) and adds a regression test.

Specifically, this series (1) updates `dmg_uncompress_lzfse_do()` to decode
with one extra byte of capacity (pre-allocated in `dmg_open()`) so that
exact decodes can be reliably distinguished from short or oversized LZFSE
streams, preventing unzeroed chunk tail leakage.

It also (2) introduces a new qemu-iotest (`dmg-lzfse-short`) that
constructs a crafted DMG with a short LZFSE stream and verifies that
reading the chunk correctly fails with an I/O error.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
Julio Faracco (2):
      block/dmg-lzfse: reject short LZFSE decodes
      tests/qemu-iotests: cover the dmg LZFSE short-decode fix

 block/dmg-lzfse.c                            |  27 +++--
 block/dmg.c                                  |   8 +-
 tests/qemu-iotests/tests/dmg-lzfse-short     | 142 +++++++++++++++++++++++++++
 tests/qemu-iotests/tests/dmg-lzfse-short.out |   2 +
 4 files changed, 170 insertions(+), 9 deletions(-)
---
base-commit: 29760efaf96bbe5928f8111881eddbf5ac06439e
change-id: 20261112-dmg-short-decode-69099ac44700

Best regards,
-- 
Julio Faracco <jcfaracco@gmail.com>


