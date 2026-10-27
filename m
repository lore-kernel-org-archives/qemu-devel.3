Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44521606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lw3TbhXx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnDj-0002mf-I3; Tue, 27 Oct 2026 15:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLnDh-0002lo-GJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:52:29 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLnDf-0004pW-HI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:52:29 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e47347279so186262f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793130746; x=1793735546; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=luRnNUW7uwy2MemYFX2qJnRCuTbEd1eVHKo0CdM5Jko=;
 b=Lw3TbhXxZJnB/3nLizMEe743e3Jl70NGVWn7exAIuCJz/5+sFLOgxDpvEoBvloBcK1
 OrmfUSjV6e4spa5xW0js3v6aFX8ZivepdQ9xNCt9vKUpW9x0djeVgiz23+1EKbw1FV1O
 iaeyhA148QNgqM0SSJ8nryInp4zLadRHwcIgu0FCIF6Lsk8EtCmtFiHgbzzk/5tPJO1z
 LHx2eBmMn5kaFzPRNa4XpJUec520E1wYsr39453ENzDXHnm9QnsaDE2g2eQVSJjHzNQB
 QNz69kH4PI0teQ6ygKe9o0QfxqVPvV7P787nj5N7jy3ZLSpKei1onjiQkGB4BIbBV2CR
 e0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793130746; x=1793735546;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=luRnNUW7uwy2MemYFX2qJnRCuTbEd1eVHKo0CdM5Jko=;
 b=swKJG71MY85I4ckR9KHKxMO4IRkoCmWwnQc62QHYySIKxEAic2Ooq3rqA8UYPm7mi2
 Pc8BGHRNN7R9vBL1zizYBNxTJyZo+WwyWdC4UzXktS7eDaS0O5fyyRXobMAy+kSGKF1u
 wXyy+REQ7aO7Y04nZ0P13D2fXKO2kY3Af6u3kH5OQEBXn83RFCXORQcO/Bw1WjYnMIqf
 WxoC4StxlRdxTwzRLGZ73xx4WvwhpiGv5nnj5uXQ202WaxlTKwDN3sshCpCLGS+LBInF
 GuRs1FgbdDyhwYRvutdEk30OY0A9pLA3rUuKY7LlXdMuAaxPo8lMF4GOzHvBrEYTL47c
 /kDQ==
X-Gm-Message-State: AFq9FYIP1x8O2CoeNUu+cKHvHwD6UcX1kO5TKSDJx9tmPowrDzl/1/vO
 hVzzrOQv891y1kfswcSOn6efoYH2vpjFYcbpdBTGzYbxYMBK6JSUve9v
X-Gm-Gg: AYBFou0TB8uNWMg/vCo7GJyXdHLbWSdKdFpfgQA5/iW/4h+/4eua9SrQOLFYk5zKMMM
 91qk4cG5+XaDi+wmKg6ylkX6N0LjatJfKSvAkR7HG2oidrPMhAbFIf4pAsGeXIPoiaD5Bn86LLn
 4vcYg1ILmf9HeZ8DZncdcHdZjIg1bQL7sqN8A2gZVkdKzMXxGI83jc5be8prTz6siA1NMS1YVI4
 RP/y9Cw6dqfRXdZLBSzVIwLGvaHfkQBUElqKTXmLeUDrUyXbnH5z9ZpykfNy6uQKSMuj1zvG/6g
 js2+Ppp5emPcX0dXsT2s7F7Sec+6HK1BJOrAjN5/UzDAdin7DV/D09k4kxhOIjAgrGHYUcgsujN
 o0vwQ1Ui6DhRd85xeMdhP27JfTFI5qDqW8c1+JbSGcr2sQCYZSHHyapIAS1PQZQs9sbEef+Wpk0
 PCTtPecAhfMBz5uK/FVLTTqbuLpGV9DyhEErmZPDdMSej5KBLlvAVCZJSiRECyhcVJqDKqnGXEO
 Ho1CRIt97zWYD9jzqTc5qWx0xQ/zc9W0RDbfqDm0HM79M60mHGBl98EAhXMWxj+snd2Y0FP5DKe
 8PV5+g/3Kwye1os=
X-Received: by 2002:a05:6000:4a19:b0:487:40d:af33 with SMTP id
 ffacd0b85a97d-48e5d5c27admr803704f8f.13.1793130745532; 
 Tue, 27 Oct 2026 12:52:25 -0700 (PDT)
Received: from [127.0.1.1] (95-24-99-141.broadband.corbina.ru. [95.24.99.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm24746368f8f.25.2026.10.27.12.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:52:25 -0700 (PDT)
From: Timur Maksimov <gessingate@gmail.com>
Subject: [PATCH v2 0/6] hw/i2c/aspeed: fix non-packet buffer and DMA
 transfer modes
Date: Tue, 27 Oct 2026 22:50:41 +0300
Message-Id: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6DIBAFf8Vw7jZARGlP/Y/GA8Kqm1YgYEwb4
 7+XmvTY40zy5m0sYyLM7FptLOFKmYIvIE8Vs5PxIwK5wkxy2QguFZgcER2QtOCDj48FBnqBvvR
 ayV5ZXRtWtjFh0Uf33hWeKC8hvY+bVXztr9j+Ka4COPC2sc6hEvWgb+Ns6Hm2YWbdvu8fFLffp
 roAAAA=
X-Change-ID: 20261025-aspeed-i2c-nonpkt-fix-89b852b5c84a
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Timur Maksimov <gessingate@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793130744; l=1458;
 i=gessingate@gmail.com; s=20261022; h=from:subject:message-id;
 bh=SMyJH0N9KYFgSRT/4ZYFWoRqEtu1Al23PZB9s538W4M=;
 b=P2vbQHToaTgEQYGF5v7/ACZMwIzx9FTnIg4xHtZuxoSaAgy303BLIhCQy7jdU/uu4MgeKsJ4t
 hZb7xOSHf1JCFtwbP51hyYmD87J9fP3Pvq7CB3iQiguM06mCXIG2Kfy
X-Developer-Key: i=gessingate@gmail.com; a=ed25519;
 pk=xF4NKIzSbKMdte17nQ66S/q9m/A2gu6GiEWc8ZnyJmo=
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=gessingate@gmail.com; helo=mail-wr1-x433.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In non-packet mode, buffer and DMA modes are broken
in the Aspeed I2C controller,
probably because no available driver currently uses them.
This patch fixes them, so byte, buffer, and DMA transfer modes
now work correctly for both register modes, old and new ones.
Tests are provided to prevent possible regressions.

Signed-off-by: Timur Maksimov <gessingate@gmail.com>
---
Changes in v2:
- Fix commits description format. Some of them are reordered and clarified. 
- Link to v1: https://lore.kernel.org/qemu-devel/20261027-aspeed-i2c-nonpkt-fix-v1-0-076cdde514f8@gmail.com

---
Timur Maksimov (6):
      hw/i2c: add dummy device
      hw/i2c/aspeed: fix BUSY status reading in new register mode
      hw/i2c/aspeed: fix I2CD_CMD register reading
      hw/i2c/aspeed: fix buffer transfer in non-packet mode
      hw/i2c/aspeed: fix DMA transfer in non-packet mode
      tests/qtest: Add cases for 32-bit Aspeed I2C controllers

 hw/i2c/Kconfig                |   5 +
 hw/i2c/aspeed_i2c.c           |  23 +-
 hw/i2c/i2c-dummy-device.c     | 168 +++++++++
 hw/i2c/meson.build            |   3 +-
 tests/qtest/aspeed_i2c-test.c | 836 ++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   2 +
 6 files changed, 1029 insertions(+), 8 deletions(-)
---
base-commit: 9b77fa7a4fe86c80d1ff526769c61ada7d28666a
change-id: 20261025-aspeed-i2c-nonpkt-fix-89b852b5c84a

-- 
Timur Maksimov <gessingate@gmail.com>


