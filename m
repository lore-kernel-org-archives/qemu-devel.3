Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E91B606A858
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jgaG6Is4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNpV1-0008Jd-Px; Mon, 02 Nov 2026 05:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lorandmarton.dev@gmail.com>)
 id 1xNpUv-0008Iu-Bl
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:42:41 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lorandmarton.dev@gmail.com>)
 id 1xNpUt-00082P-JR
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:42:41 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so24503705e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 02:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793616157; x=1794220957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rpqGaBE1hPPTNKsqwFrLZc6umcuff4TfF9FfMyquneo=;
 b=jgaG6Is4yQKLqRpdX6kojmhjrpQqDK31J3Ii9wZc9KoaKOVdC8SwbIQrEAr6+/Brln
 q43toVuyQtRwNaH10WvBnBnZPPS0CiMaGwRWejoiv0PLWjDyNeZF+8I+lkcF6D/gk5dN
 fw5MNdLa+obFKSz0akC5mf70/xkHXb0zmJxYA9BevorcR24a40EV/8w4aWe58UUYavFq
 oSNeR4mO0G+Hw5+9ce5QPizopMKedi+tefeX5bH1G9eiFrOZF+d+sNjrteZuCx/AvglQ
 BAC3k+/9hY3fv3NYxzVammqhIuDyq2k3wjuBQ+gNsftpH81MjlcR5HlQaPjOW+9HX7mk
 3YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793616157; x=1794220957;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rpqGaBE1hPPTNKsqwFrLZc6umcuff4TfF9FfMyquneo=;
 b=u5ve+ywMM4N/SQvy46CCMtuSpOA1SKk0kcQ1stNCSc9+C/VATSvT6hbgm86MSmWpkb
 j0QNVj91mJuwg8Xa80ev8KWOkUv3crnalVxympChVZx1uUvwUSyw4TE6OcUvuf76L7pV
 IJNX2csE4nMFawD+c3vrfcfL4pKRtqCrEpBEw4znvR2VgBDK+JWeIqWIpqPvYYD27a/c
 eneb9Se4yTNcA9avcom2ZNnUbh127S1e/znHMoWKKNvVBTkBvv8HzXPBWotVcK4qdIqM
 fjvdaNzbMChCMhkVtYpxLqVX8DaZJ36qtu/ds3AXZ/ef8slghvGba0w6R8DWeEboCL2z
 RsqQ==
X-Gm-Message-State: AFq9FYITQQiJ6VtSthhoFBcwbsOwC5T1BghCpbc8ge/GmnYfINGsMfgX
 vlRBULBSmcaSif2XxBeksCRPbFbL/Q+7DZgFcw1obOv4wVQJkX3cWDr7CG1yZl4TWbQ=
X-Gm-Gg: AYBFou2j8vGIzEePpQnfE0fovjrZJ73y2kCNtlwyya3oufLHnFggiKotj1x1EGQUabp
 +BG4Ila5A4lFrDniGlo18wbqBu6dFOFxq64vKVpcNIWGpMog8gFJrwEM1zULX2oEYJlmH9dTgyY
 cn7eqQpawN02SSMPw2nrlMHNmp5WFDZ4S3X4EpOVgKQ34DjOJtd+cUhW//rLjkIpZdZ8T/HVVz/
 yuweDJ6FCiDMVzn+B805vBcQt8M09GGij5QXXapDHY6fMDvwZ4nnOqZpsavjF6zoGgu7mg3nUAU
 3GbCnVA5C3FlyTdxZiaGOLuMa7I89bhODXJHsqXjxlqpIoYFkgfWnFGX3dn+XhBS7/9z5fqCNam
 ljHKaXcM4Lg83ZxgiXjhxlYyMkcXuTtvC5j1V+SbeUCCXPsH/OKtAMgY7FXmZvXAz11NIvkzgGd
 cWeWCNhISHGUhLLasMRtmxpCd7UE5H/DGWOHM/D3DJm/AlllFpBpDqQ0pl59qwN6Ts4InwC45Wx
 fPHIS4QByXU83OxpMH7eSae6vQ57gK6J6b+ZATU9iNOj2mi5wl4AJeA5bGh5xudrWjcY3tMNZUe
 sWzvRJ6d9HmOVy6m8X6Vm0VZ7ZG+IH24zhpDiVZgKwuaApCUKRrU82Tld94QCQ33wPyW0OiRE4x
 7yFKDCPsi3LCI5T3mfus46DA=
X-Received: by 2002:a05:600c:83c3:b0:4a9:18f4:925e with SMTP id
 5b1f17b1804b1-4ac174711afmr213347655e9.18.1793616157439; 
 Mon, 02 Nov 2026 02:42:37 -0800 (PST)
Received: from localhost.localdomain (email.telematik-zentrum.de.
 [87.138.218.176]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf67aab10sm257253035e9.9.2026.11.02.02.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:42:36 -0800 (PST)
From: Lorand Marton <lorandmarton.dev@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jasowangio@gmail.com, marcelomanzo@gmail.com, serg.oker@gmail.com
Subject: [PATCH 0/2] hw/net/bcm2838_genet: TX index wrap and full RX ring
Date: Mon,  2 Nov 2026 11:42:36 +0100
Message-ID: <cover.1793613972.genet-ring-fixes-v1.git.lorandmarton.dev@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=lorandmarton.dev@gmail.com; helo=mail-wm1-x335.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Based-on: <20261027143036.44973-1-marcelomanzo@gmail.com>

Two fixes for the BCM2838 GENET model of "[PATCH v6 00/17]
hw/arm/raspi4b: working PCIe and GENET (real networking)", which is in
target-arm.next. They apply to target-arm.next; if that is simpler,
they can also be folded into patch 12/17 (implement GENET TX path) and
patch 13/17 (implement GENET RX path) of that series.

- The TX consumer index counted past 16 bits, so the first transmit
  across the wrap never ended: the device sent the ring's descriptors
  forever with the BQL held, and the guest and the monitor hung. A
  guest sending a sustained stream hung after about 65k descriptors.
- The RX path wrote frames past the consumer index of a full ring and
  overwrote frames the guest had not read. The fix keeps them queued
  in the net layer until the guest frees descriptors, as e1000 does;
  real GENET drops them and counts them in DISCARD_CNT.

Patch 1 adds tests/qtest/bcm2838-genet-test.c. Each test fails with
only its fix reverted (the TX test hangs).

I found these bugs while running Raspberry Pi OS images on a model of
the Compute Module 4: https://github.com/LorandMarton/boardtwin. Its
QEMU changes are on the boardtwin-develop branch of
https://github.com/LorandMarton/qemu. I intend to send the board model
(raspicm4) after the 11.2 release.

Checked: each patch builds and passes the test; the aarch64 qtests
pass (33, 3 skipped: the slow cdrom test and the two swtpm tests).

Lorand Marton (2):
  hw/net/bcm2838_genet: wrap the TX consumer index at 16 bits
  hw/net/bcm2838_genet: hold RX frames while the ring is full

 hw/net/bcm2838_genet.c           |  42 ++++++-
 tests/qtest/bcm2838-genet-test.c | 204 +++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |   2 +
 3 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/bcm2838-genet-test.c


base-commit: eb5ac4b5bb4e221771cef0c53004f99499133f3e
-- 
2.56.0


