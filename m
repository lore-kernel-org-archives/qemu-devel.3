Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA804C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqTd-0002Ku-Im; Thu, 22 Jan 2026 03:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTb-0002BP-Cg
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:39 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTZ-0006HZ-RV
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:39 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so6046125e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072136; x=1769676936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R2jf6FTIV/QMjTTmk4SYEqdSgUBZTyWvH55UhLBazUM=;
 b=z8fJkqWLj1S7zDLmvtN0ZTs/dx1CZR7nLFNGj65TOwkXNR3TVtTQ2d1TJ3MNRwBSDT
 BOzaz1FTm6ltSO9R/egjuZIN32vKtWXilufhxHw2Hvw8kO88j2CdL9U+OvdkFxOReN6c
 rLcGlPGy1YUkuE45CGp3aMmyAClSwLDXeHcYWih7+r3ULqcC5GPTzvBINzUdPCYjBmEu
 93VGlOegIwnR5bTJRnanmpwBzOU8F2fxOXuVI1oSTvhzYW7Hij5WPUS7OgvfrocyoHRx
 7KMha4bqPgTOZlCSIfKqNoo4fXeWR7l60laMadCyYzkXJXHett/2vUrsVxk3bA4MeSqh
 /KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072136; x=1769676936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R2jf6FTIV/QMjTTmk4SYEqdSgUBZTyWvH55UhLBazUM=;
 b=MT9Tc5zwJGLw914mNfb3kPo92Iw4c9/FXN0AOi4E3b7lMzgKJWKHDFmBDPQ+4mQNOM
 PIkWCTGMabiHVLa5c+7CDtE0hxhbq3rOPVc8yFRiGiKQr3mIspeTFYTQokl3bb0aP26y
 DZLJIW4DsfP1l3Ruf2tfMoC9GyY7/Sn4KdK9gltftZs+anaf3GJk19K6i7OGCCIjRTGv
 mo+1GwGTjHMQ9x5S2RLPzCourzyDKc/cGJQ7kfdxBMQBDjD4K76YWIG1pfdnPGjjS7xv
 Ah/g3bj3S6GQC2jkSr86Yhv2ahE6pf9NeIt4rF+ssQTa/rcM2X7Iak/LE5Ah7iXWyvHc
 aY9w==
X-Gm-Message-State: AOJu0YzPmZN3PctSUdmgcnQZ/WqPuQAgr4iP7eEctZrx53wZZL7Y0L3C
 bK8MrK7BHrDt1Mxg9fKvSRjEwdu74s+G/FUNCeG3wqIv0vxfK/50kBH83ZHBDsO/VD7He0uHOXs
 NJRyoz8U=
X-Gm-Gg: AZuq6aI2+RG+98BsjS3UA+DRW0i7/H+Fu/A9Y8IS6yaAGxskTa5vpjly67BmfDE2UeX
 J5Ac0jqRet6jYxOc0Wuxy7K7t3x63BGSQ+gYygx+zGUwamO3RBVQEMPl4uCCQjm9lhQJZ73y539
 w4M6zz9mFRp0/sc3iRlVrhD3IdCm3npOGOXbHgdaI0BDn48kjYh+ngW6I6nRpIzxska1a0JZWVO
 2FZUXDKWkN5xCto2n06AKRqVESg3aOjsLbLDT0aknvT1RBoedlqWIgtfJ38T3Xp9bch3Pcks5h9
 gRBm/VyFhIi5Oh/fU/hLvBr1IS2iFBUmP7nbLCtv1LO35QACnHTlMq3JBvfZ8WWvSjK988zDGXj
 Vq7Rs+b4PiexObhLqOvCPcIE26UDEM0ubHcTZGOoFJ2bHwEzYkqQZe1wEEiOrfdTs/lNWggfpnf
 SxLH7xzmi6H5qcFosnEUpEygSztuNxXrcAv4wYaoEx3O92xYz48TsXi8Kd66rC
X-Received: by 2002:a05:600c:4e92:b0:47e:e970:b4e4 with SMTP id
 5b1f17b1804b1-4803e7f18dfmr128717825e9.29.1769072135592; 
 Thu, 22 Jan 2026 00:55:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470c1dc6sm49152685e9.10.2026.01.22.00.55.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:55:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/31] configs/targets: Forbid Renesas RX to use legacy native
 endianness API
Date: Thu, 22 Jan 2026 09:52:47 +0100
Message-ID: <20260122085255.95035-25-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The qemu-system-rx binary is buildable without a single
use of the legacy "native endian" API. Set the transitional
TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Preliminary commits allowing this final change:

 . b0afb81271a target/rx: Inline translator_lduw() and translator_ldl()
 . 41a1b46c3b2 target/rx: Use explicit little-endian LD/ST API
 . de1f3d628e6 target/rx: Use little-endian variant of cpu_ld/st_data*()
 . 0f4af4e2672 target/rx: Use MemOp type in gen_ld[u]() and gen_st()
 . 2062fa663c0 target/rx: Propagate DisasContext to generated helpers
 . 8b71fd6ffec target/rx: Propagate DisasContext to push() / pop()
 . 363fff6d1b1 target/rx: Propagate DisasContext to gen_ld[u]() and gen_st()
 . cb8e4556d58 target/rx: Factor mo_endian() helper out
 . f9903a8a23e target/rx: Replace MO_TE -> MO_LE

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224163304.91384-5-philmd@linaro.org>
---
 configs/targets/rx-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/rx-softmmu.mak b/configs/targets/rx-softmmu.mak
index 3a90f1b9977..281a165873a 100644
--- a/configs/targets/rx-softmmu.mak
+++ b/configs/targets/rx-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_XML_FILES= gdb-xml/rx-core.xml
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


