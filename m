Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E357C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 09:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueVzc-0004JA-SX; Wed, 23 Jul 2025 05:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ueVzb-0004I0-D7
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 05:42:31 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ueVzZ-0005m3-DG
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 05:42:31 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-237311f5a54so51856175ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 02:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1753263747; x=1753868547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxJ9997vLSNcd0hQskYWllp+aKzQqhaB9PVyEgB28CE=;
 b=ew1cPO/oTobcay5oxduj2HkqotyEWqWsVfBqTOx39EQJC+cEVf/eaTg0Rl302BkFmg
 JMVTuX71cOpT3m++ajNxnjJHxyOZk9UrVQB6U0Sx0Cm6hWQR4uIXbSLvttFUB9XJCtSs
 eoaisqQQzNE+FrF6XS/twaLtoApqZumLzKv5pf5tjcWWxFaqZLcP4tK50A5Ys5i2Abfe
 KuNWp0oQsOVTJ1sG7tfbsbhnOCt/+H9rUNZNLvq8P9r8QCwKIIIF4r1QOpIDtGS4Pp/w
 qoI86QEzZd3/8v8VnkryDpPfxT+KZEGBBmOd5XO4iHvcd3AhHRpVelf8HBnlR+Alr0Sb
 VZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753263747; x=1753868547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxJ9997vLSNcd0hQskYWllp+aKzQqhaB9PVyEgB28CE=;
 b=lSJf1KE5wwghzax5mfEeAujD7/4MxIOTvJy4LxcJUGNz8Qtj3u/RMYOgcCwRVGrnm3
 gNH+XfZ/l8GOC546SQ+oQ+sSXfRbqAKHYBgomb85fFEXT6F1fpIJ6/5BYN8k7aWJkW9E
 R7oim9fkUxSJ7CBnINLbzSHtjQ1Wl4ExF7leX733pS60fT1TcxeauMtNYoLNyLTEicPe
 uxuEO4a4cGC6+JtVrJmmTfmISflulQWQtGvTHHSG5U9AIwJOGFG7eddDFLCMTXm3OFAq
 cS+vshVkbhhxbaSztqMNxYh5vfKLmald1NvC1ojGggAcqgzo1BW9Qlq1jR4k+aR5dvoa
 hSZA==
X-Gm-Message-State: AOJu0YwOkzCqU/FpWqrDpRr8Q6NoL2wnWs4aPBpA1GPpp3MaPeunIyuL
 1MnoQ19r3HRf2xcu5otN1kU3QvDj5TbA2CZCTUnfzxNO71dVVQzwfAaNM1B5j8n9po/9otU2rjq
 okMug
X-Gm-Gg: ASbGncvqfrMwpfJTjUrdhdo8N5PkW3lHAHZH/kcn68h+1AzH10eJlPxxB7d4RzOoip5
 NBgow3HRMxP8xI0MFprDgxvmVF/vuKSX4L34MkyHbShNN7ySD8AW1eUBOZWY8DJwHsjP2Vyp0UV
 19Un5VI1RQuJ9nDWNYUpNkX46fTHqaQ9fBX53Z5MJC+DRTzwWK2f4KjLR4L1bx30DAtGedoRPil
 xt0RLUQbd6Z/3tLbVGx3/o3OaWJXCt4mDA+C+Hbm4CJvHef9MtsecQzoQG7hX8wCWLNofDFtgD7
 IWxbKZJjZY1EOppb7KKp6DTVbAGg3N6vkB+h4hjvehktI1h3hZB10Mgi9LunK+kDfuHdpDPYZOP
 lU7bUFnmK7vmPsplzko7plCkYdCJmAV+7Mg==
X-Google-Smtp-Source: AGHT+IFd/nmgiDQ99wsIkjYLR3F3gniHKyps0Q79iQmZKI+OFypcdQWKSeKnSAClo5b5NbqvAkMulA==
X-Received: by 2002:a17:903:28c:b0:234:f182:a735 with SMTP id
 d9443c01a7336-23f981b42a6mr34786885ad.34.1753263747616; 
 Wed, 23 Jul 2025 02:42:27 -0700 (PDT)
Received: from grind ([177.170.118.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6b4a88sm92732205ad.131.2025.07.23.02.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 02:42:27 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.1 1/1] roms/opensbi: Update to v1.7
Date: Wed, 23 Jul 2025 06:42:13 -0300
Message-ID: <20250723094213.2975268-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723094213.2975268-1-dbarboza@ventanamicro.com>
References: <20250723094213.2975268-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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

Update OpenSBI and the pre-built opensbi32 and opensbi64 images to
version 1.7.

It has been almost an year since we last updated OpenSBI (at the time,
up to v1.5.1) and we're missing a lot of good stuff from both v1.6 and
v1.7, including SBI 3.0 and RPMI 1.0.

The changelog is too large and tedious to post in the commit msg so I
encourage referring to [1] and [2] to see the new features we're adding
into the QEMU roms.

[1] https://github.com/riscv-software-src/opensbi/releases/tag/v1.6
[2] https://github.com/riscv-software-src/opensbi/releases/tag/v1.7

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268312 -> 268752 bytes
 .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 272504 -> 273048 bytes
 roms/opensbi                                  |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
index b2e740010b..02be3a72a8 100644
Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
index 018b4731a7..cce35c65c2 100644
Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
diff --git a/roms/opensbi b/roms/opensbi
index 43cace6c36..a32a910691 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20
+Subproject commit a32a91069119e7a5aa31e6bc51d5e00860be3d80
-- 
2.50.1


