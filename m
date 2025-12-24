Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056F1E776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRJ6-0006kD-IB; Wed, 24 Dec 2025 11:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRIq-0006bo-CN
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:01:42 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRIm-0006PJ-54
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:01:31 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64baaa754c6so6032683a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592085; x=1767196885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxI8NcLb0sSwsafe727o0TmJhll8M8GoPEr1FiUnEX8=;
 b=LTS9QXKbrzGD/vrtQ9fSYr1vWvKck4NWjft9u/W4mRWaqH1DWAx5qMgTRHYaH0z5DT
 QUfQbMWVDeC27/TsSoFg8c+Q0Azi1yGOT3bwC3x/zBYreAlcrZlHOjmH8DZA9h/SLY2/
 IpzMjLCujFYj9flG5bopsgZJTdspiDT9dHU29oZC5gTCNfvDGsJ7He4OrQNPjEFS7pgN
 SikaxPSLmzSam/SOOTOOy45QRZ9edLjQUDCkJGQIuf0bcmlL+m8EiIA7p+oXtIMRyLDS
 ImRmYQ/gsjdAzssoHUKZoKdC1kS3xXtY09moNgKPtB1Z9FPnntBgU3oFLdVsGTlb9GGE
 pY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592085; x=1767196885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TxI8NcLb0sSwsafe727o0TmJhll8M8GoPEr1FiUnEX8=;
 b=hcj4Yi1cOU9MJaQCjz/UEJ7atg06WTakKZgVFy9rsWKDYlDoWu8is1jbJeWclqzspm
 Mz2qNPJmnhLI8WAC3UoL3nhNR8+hl8ItmAhbyIl6AcgPd/0dbB1bL566/6oSbVT2hGoo
 LQNx+Q8BwRg0uH/uxFoYrcWkghNTpFGqUHyVjSasz+kl7kC8dttmD+1keKmqmwt07CIQ
 cU3cgSXrhACC4GLZbCNGZGpmAsc0XemU63HWzl4ZbQ8vINRRh0JFYED9cgeMVr0CgrcY
 r4NybBuMTXno09o39vpD3ZC4PJqSH7NKnqS9kPTPVDImEzDQGsW/Knuw8THzI9Nx4YBq
 UqaA==
X-Gm-Message-State: AOJu0YzcSCN4EBIrEUKEzOUJsHXQ0oSdHoQo5mnHSZ40O/dIyOeevSKJ
 5U1H/OkBdEfbIFO6rpvoguyKv21apC4hrrkSo7GE9CHODqJJVxFoIWPaItVHp8FDi4daCkWUmcl
 RHE1t7XM=
X-Gm-Gg: AY/fxX5inPLcarMkbZ7ToxuqonGGGCk+btQEPV2cBRaTXPiaYDlzUZJWqwFcc9rG+80
 ZaN1J1ef4rvxxSvaKVHL+3yPvGC6TuNKzwub64Vk2gneVggR1wulhalrc6p9Z2GVwRcwEoyiK56
 HJA41ndFzeESz92gyQeGDDme5+NBIh415pjCzdVIWSgK6mVSgsZxKU2ppz48ECqDuifOLouGjQ1
 XT5DMePDs1W928+ag231/0hNec8jBD0AZNs4ElvkwF7T9tQIJyNT5Gv7nebW4B5xwrfLD6du2eZ
 25lJ8wYoAMVylVhh62JP3eb0Hbq1n635B8tvUjKp9tt3BkTLH6WbyJwkUOPoOyiEVNddN2LlNq1
 OePSTufEKqQMYxbPgqjBNsAU0Qz6EeASXJw7jvTDxUqrxy0ARQ/3F86MIG0XIMx7DbXidhV7p1H
 8jbm1YiCQwRReMV3ARb/UtRQPBGME2jdLJQJGsHe6OARItCs9AkUVfrjY=
X-Google-Smtp-Source: AGHT+IFDUL+mV85KvrDCMgc+KDm5xr1c3eDL2UvFVYkaapVLk1TTszgNj9lEoLkv/juu2Co4FpQg9Q==
X-Received: by 2002:a17:907:970a:b0:b79:e887:e1b3 with SMTP id
 a640c23a62f3a-b803727bec3mr2082044066b.57.1766592085463; 
 Wed, 24 Dec 2025 08:01:25 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b80426fc164sm1657353466b.30.2025.12.24.08.01.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:01:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] configs/targets: Forbid Alpha to use legacy native
 endianness APIs
Date: Wed, 24 Dec 2025 17:00:38 +0100
Message-ID: <20251224160040.88612-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160040.88612-1-philmd@linaro.org>
References: <20251224160040.88612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

All Alpha-related binaries are buildable without a single use
of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/alpha-linux-user.mak | 1 +
 configs/targets/alpha-softmmu.mak    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/alpha-linux-user.mak b/configs/targets/alpha-linux-user.mak
index aa25766236e..ee505e16ef4 100644
--- a/configs/targets/alpha-linux-user.mak
+++ b/configs/targets/alpha-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=64
 TARGET_XML_FILES= gdb-xml/alpha-core.xml
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/alpha-softmmu.mak b/configs/targets/alpha-softmmu.mak
index e31f059a52d..22fbbf0cb08 100644
--- a/configs/targets/alpha-softmmu.mak
+++ b/configs/targets/alpha-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=alpha
 TARGET_LONG_BITS=64
 TARGET_XML_FILES= gdb-xml/alpha-core.xml
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


