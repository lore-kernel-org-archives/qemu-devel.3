Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B6DC636C5
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIXI-0001i2-Vy; Sun, 22 Feb 2026 18:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIXH-0001hP-S2
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:47 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIXG-0005wM-BP
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:47 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43945763558so2196557f8f.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801604; x=1772406404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/lJp/K/sDtW2YKLoXEP9LMb0n0a2kdE5iy2Xn+rwkwk=;
 b=oZ303TDXCf6eihoVhxrpy+Ctcln73JxNQ5PxktYsXuPIl3jkLMAslIvufKDmTBWskA
 7c1w6CCjN/wVgRjpy9fjw0kkAYP2hwxMHu64+1fA899QPYAZjvCliWzF4CXaDJqMRNdc
 nnkrRMGxLHgcO6ApTfdmFk4LfUzolgFyjN6lnym7c7F54TfdrbfGUMOsVH9sD0PxFlgg
 VjAXco5mjkkClw3CnxzzuRApj5sOA+kh+yA+LWWgMcaNFMYA2zrww7AAFO+3snT8yoUR
 AiVHDIgi2bLKZ2DhC4VoBZCP7nnRuEzlHuxmuMFSdCWdyHd7i7Qd+LPmZ1jfTYB4IwgG
 bmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801604; x=1772406404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/lJp/K/sDtW2YKLoXEP9LMb0n0a2kdE5iy2Xn+rwkwk=;
 b=UbmubHRwrDvSu2HYKThxzE/8dKoFpXobFXqv8Kb+oXYbrqMkjQ9R+m0Fjz+0wQ1DO3
 Yka6ltEirvHYYpA/ydEeqpPtl5SjgYsUqEmyYXWshjf5nigYYcEMp9X/b/X17vW/sD1k
 qs+NX91UNFAKnTannA9ZMByO84xdOjE/GVqb/BVXROfb6CTV2MPAPEeylkCyjmFoQUdy
 QGBQjU3pqWlQj9qodilOZ7kinlKRyKpPK/gpH8MGp3e1L90VFjMJlH3Q75aPl8CO+VeY
 EFmGKXXTWW19e40+A68oVgeaYO6XG1A3uBkyE6BWID9omeZPrLDDlQFq2Dz3xufGgajH
 P+yQ==
X-Gm-Message-State: AOJu0Yz+vER2BE39eC7BJIdoXtHytY/Dy7DyBPRT26ojcHQcn9W3pYeJ
 6MCDF5+OTGqihAk2tOVA77/SoAPq2GnJJKSkI2pViX0Hh4c7ZMGCZqVjDH2Q/xwPV5oTigHmke8
 uwn+HvVc=
X-Gm-Gg: AZuq6aIceFfa2hkB1rBUEwEzbFgiBpH3KqP4CJpoq8VTB1MFqj+TolZHF9BtNtnyYBw
 16ueM6uddtcKr5QzK+16es7FWpe5jhly18wc+F8GPGWkJOf84/yMxsBBDNAK0v1AFqUYq848X6L
 Q1eQGD5QHPq5XvLOU9Agwr5l/2wg8W3q9yMx8SGhgTKZYczLKoKgYC4RLs6B4gCRMOl0N+ZRDtN
 PhC2bIt9Vkgtl6ATdhmbO7GggnveCq7kFX5hJUAC/Pte5lJ5ccHkwIzMZjVIjdbME1bki6esa98
 qXnzJS0fqrn/FtdN5P1GGzLTPTbgj7JX/+GjeaKlgXX8dGXO9zPL53PBOk3r1/hxRgX5MqC9dNh
 3J/VbGe4p5K5shB3XHSdSwAOAeywGClJC88msv+kEKqNDmKF/uh5mNA0R+6LQgXrlu2c/t2x70t
 nM01g98uixOHjApa2oMmXJyqGl7KfKA+K+er3DXlQQx6D/Cg11RWchfvCf5zR6TAMEiVI0+N+C
X-Received: by 2002:a05:600c:154b:b0:477:afc5:fb02 with SMTP id
 5b1f17b1804b1-483a962e38bmr101858805e9.21.1771801604196; 
 Sun, 22 Feb 2026 15:06:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b3dd7sm234640785e9.2.2026.02.22.15.06.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:06:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/20] hw/m68k/q800: Use MacFbMode fields in q800_machine_init()
Date: Mon, 23 Feb 2026 00:05:47 +0100
Message-ID: <20260222230602.5756-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Once the Mac Frame Buffer device is realized on the NuBus,
its MacFbMode might be different of the global graphic_depth
and graphic_width globals. Prefer the device MacFbMode fields
to initialize the BootInfo structure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20260216213121.47122-4-philmd@linaro.org>
---
 hw/m68k/q800.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 4767eb4298f..b55c03a90bf 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -605,9 +605,9 @@ static void q800_machine_init(MachineState *machine)
         BOOTINFO2(param_ptr, BI_MEMCHUNK, 0, ram_size);
         BOOTINFO1(param_ptr, BI_MAC_VADDR,
                   VIDEO_BASE + macfb_mode->offset);
-        BOOTINFO1(param_ptr, BI_MAC_VDEPTH, graphic_depth);
+        BOOTINFO1(param_ptr, BI_MAC_VDEPTH, macfb_mode->depth);
         BOOTINFO1(param_ptr, BI_MAC_VDIM,
-                  (graphic_height << 16) | graphic_width);
+                  (graphic_height << 16) | macfb_mode->width);
         BOOTINFO1(param_ptr, BI_MAC_VROW, macfb_mode->stride);
         BOOTINFO1(param_ptr, BI_MAC_SCCBASE, SCC_BASE);
 
-- 
2.52.0


