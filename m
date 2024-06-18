Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D1CC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbq4-0005KF-1b; Tue, 18 Jun 2024 12:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJbq1-0005JC-VC; Tue, 18 Jun 2024 12:37:41 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJbq0-00050L-C9; Tue, 18 Jun 2024 12:37:41 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57cc7e85b4bso2932a12.0; 
 Tue, 18 Jun 2024 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718728658; x=1719333458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vcmJDQiSruIcaEPOxulSjKxCIvJVJZPab1Btx+x8YHM=;
 b=Z8bWq8cw0+Zr1zBilJJWPpyJMWGNY7y0s/gDS+IOyrp9FZaVNoYPPx6/FvBsDZ7wbJ
 Y00bmRmaFDhN+QFYy05TC0MZxx18rEyRSlMkUoX9UzHzuYecylFtluykvaBNgcogvL3X
 hDc3AcWLykAJWFWzVNMg8F+MBHirULqTngzVzw85u1RkauB0BHmDlxzDqKX/44A5PY5W
 izqPHSwtaoTvX123v/hsvdGQ/pIONVsFzyB1ccFRoC5PodbvmQbHnXOZYDY1z8bvGVYh
 VmfA+Pfs8YGxHDcnd0oa46KYBWFt+Cgh7rgWUyT91Ply2Q2GzMSbN9wXetPKPh1HdbFz
 GWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718728658; x=1719333458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vcmJDQiSruIcaEPOxulSjKxCIvJVJZPab1Btx+x8YHM=;
 b=evDAtr+ocSOwCfoH0KB6vwaAzPZ61FBLcVd3g4ArXiboxMC7MDEoKUS9jaGvUDPLHV
 lrgAdipYIWHA2qTg6YRb53gUD+C+VEoKl78hPKVimEG2u4pXTfKQw73zj/pZUe0+DqBT
 RKzk7/W8kZrP0yLsB+tJkG0WzFjfGNJdwAmfNw0cL8tHRRGfrHIzwo44gpkiOBAPzxlB
 p2NFvF7tI3qgrtDUW+9LJHnGsygF36hsMEOWGwqqrbtDSNWigex/jftfeBZ0w4FmQOeT
 PBZoT6wOEhHGzmwZT4FirRf9wrgnEhs7Q2haJHPuWvTMzJjka0SdC08Wyhel1zAAFd/6
 xIug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUeyML/26qxn34sfcakDldSFmSGxZVrRD9p6lMb5C75V86iY6ziLx91d6n7QKYJghQwG6sHWL7nwE/ntQNxY+mPM5YMML2EvsDQSgCoSkTGiitqT3LyOgK7j8=
X-Gm-Message-State: AOJu0YzcUNC33kF9MCcCXEBVfrL3C4z1Hl/tvTuyASpHcLCsX/bsJ4t2
 d1gwOihmDlK1hHhcXXv8nEWUQ8ZVIPJ7MJgE5SBYp8k/K0ekmIA=
X-Google-Smtp-Source: AGHT+IE+nnjMZH6jeZjLgGXAPMxiQ++t5FmuE/3pvw8f79DbnfxJqi/xTYUj4LzhKKr42C2dZFvN8g==
X-Received: by 2002:a50:c04b:0:b0:57c:614c:56e7 with SMTP id
 4fb4d7f45d1cf-57d06ad8d11mr181876a12.18.1718728657162; 
 Tue, 18 Jun 2024 09:37:37 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72cdffcsm7949309a12.6.2024.06.18.09.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 09:37:36 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Zheyu Ma <zheyuma97@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3] hw/misc: Set valid access size for Exynos4210 RNG
Date: Tue, 18 Jun 2024 18:37:01 +0200
Message-Id: <20240618163701.3204975-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=zheyuma97@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The Exynos4210 RNG module requires 32-bit (4-byte) accesses to its registers.
According to the User Manual Section 25.3[1], the registers for RNG operations
are 32-bit. This change ensures that the memory region operations for the
RNG module enforce the correct access sizes, preventing invalid memory accesses.

[1] http://www.mediafire.com/view/8ly2fqls3c9c31c/Exynos_4412_SCP_Users_Manual_Ver.0.10.00_Preliminary0.pdf

Reproducer:
cat << EOF | qemu-system-aarch64 -display none \
-machine accel=qtest, -m 512M -machine smdkc210 -qtest stdio
readb 0x10830454
EOF

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v3:
- point to the device specification
---
 hw/misc/exynos4210_rng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 0756bd3205..674d8eece5 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -217,6 +217,8 @@ static const MemoryRegionOps exynos4210_rng_ops = {
     .read = exynos4210_rng_read,
     .write = exynos4210_rng_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
 };
 
 static void exynos4210_rng_reset(DeviceState *dev)
-- 
2.34.1


