Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73B7C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB78Q-0007kH-Kj; Mon, 28 Sep 2026 04:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoxiaoqiang007@gmail.com>)
 id 1xB78P-0007gK-4Y
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:54:53 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhaoxiaoqiang007@gmail.com>)
 id 1xB78N-0002aA-N8
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:54:52 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 d2e1a72fcca58-87fd84c0bfeso984429b3a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 01:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790585689; x=1791190489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y+uAfa+jzC1Q2rWRjpzOqPq0n+yBQdFZVlFpDBX3WIo=;
 b=opM/q5esy7CCYM56SUNDV4N8N+TJZ09CnAdOisTPNupNl79rzgSyhCvhtGAptTZ2dz
 V8p7s8pl5EXqyipg4FIykP8EPCCfVHAq+gSLrFrkJWuJTFqwMierZT6ziCe172XT3sJI
 g299uZndCyZ4XdyYHAbR1iXvkCRVICWGUvuJyUm2iKxL/dLBAC3cqbHA1YbIQQ9cG9Wa
 jUztCcpbLI0eGyIPFiO1DyjYmLyv38JRh0sgXojyQ1A5+xcaot4aASkFZQRAPnUfwHjT
 uKn21GpH+i67mrknNqj7tXBY0RSeqpcxZXANceHsDImMQEqzNAI7fPwcJb7NFRQjqv72
 thvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790585689; x=1791190489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y+uAfa+jzC1Q2rWRjpzOqPq0n+yBQdFZVlFpDBX3WIo=;
 b=T0vdGYQFBxWEGEmcnqbVu0uhHsdtcSZ8h5oX/SZ6w+rTjXkq3i7QbADacruor39jAe
 ZkG/E7zHXOnN7ywXRpzx+oig7lkopc/6pAP7LhD0RIlLYrUvd8cMH1W1qUexc138oYf6
 9sP20dWhdvNQZjBBGnzQERoNB0Gh5for1+Q5kL8FbLl9fxGEFhIJzjwNTl0s9/zCUosc
 YKV97om2JWvzw3NWTLkH0GmwuVyB0eh88qnKpNcSDgSZtWjTAHn+Ba0jrSCoE0xoMWRN
 VKOC+pr824rv5th0QE11hhnwV9u7Ig4Gs3zFsHoI+NcrIaui3iw1WOBE8cbPa5JbReRA
 LGVA==
X-Gm-Message-State: AFuF++mUbwOFsb4IXYOzjZGzr3foF+2eV+rMG0X8IB3hAA+WNBwM11JV
 42vqAImL5/JYdTY1MEaLPdX5PeLMjyCwzW9Qs9Dc2vj8l+vuglUI9M1CHca4dng5
X-Gm-Gg: AYBFou0rldbcPdOYFVGi+QfPsWCYL65upx2CtNLkisFZlQfp/IBG4ztXH8BhTkPIokF
 cH8ufNuNWgWCAe6LING3EKxXbV1HMMWNzH54XAF3D1654O5O4eIgY/n6pLVhqzIkQBRS4VP0tpJ
 RFFFxOHaXaQ+MpOR5lQTjDPiV/7WWoB/pSGtSRg6bKVk/5zLe8BJmDlRJ3kvveqViOi49s8/lqr
 1lGTJdR4l0vyXQ6xNuk/xLZV3LOs10WJN+V0+FstyI/+ElaFl3vYXhlh++fx93OpV7mVQu2Y10t
 nDFBOHmlV+UhbIFqnF2PzXyBab64plARRfYYhhV4i02pNnCqiUmfg9UxfU1qGevSHmnKhU6q78i
 u7FjbzY360kJRnonlnUch3GlSkyItGioBUzN+aM1/7ZQJU9dTuHuSGxeIBN2b4xv6mRi6jsc/qS
 nCRyHCUBOlOfO3DG3kz8yylkV6b5q6uM+9GZA6mfnXmLTaxPrK93Ghdp1LM/hT
X-Received: by 2002:a05:6a00:408d:b0:882:2195:5a74 with SMTP id
 d2e1a72fcca58-88221955f35mr3374007b3a.59.1790585689331; 
 Mon, 28 Sep 2026 01:54:49 -0700 (PDT)
Received: from debian ([1.203.174.67]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea18ff77sm3849500b3a.14.2026.09.28.01.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 01:54:48 -0700 (PDT)
From: xiaoqiang zhao <zhaoxiaoqiang007@gmail.com>
X-Google-Original-From: xiaoqiang zhao <zxq_yx_007@163.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, jiaxun.yang@flygoat.com,
 xiaoqiang zhao <zxq_yx_007@163.com>
Subject: [PATCH 0/3] hw/loongarch/virt: fix SPCR bitwidth
Date: Mon, 28 Sep 2026 16:54:16 +0800
Message-ID: <20260928085419.188886-1-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=zhaoxiaoqiang007@gmail.com; helo=mail-pz2-x0c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

Change SPCR base_addr.width from 32 to 8 to avoid UART probe ADE

Xiaoqiang Zhao (3):
  bios-tables-test-allowed-diff.h: allow loongarch SPCR
  hw/loongarch/virt: fix SPCR bitwidth value
  tests/data/acpi/loongarch64: update expected SPCR blob

 hw/loongarch/virt-acpi-build.c        |   2 +-
 tests/data/acpi/loongarch64/virt/SPCR | Bin 80 -> 80 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.55.0


