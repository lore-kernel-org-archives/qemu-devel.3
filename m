Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8387F5545A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 05:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv7DI-000708-LF; Wed, 25 Feb 2026 00:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7DG-0006zg-TX
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:13:30 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7DF-000472-Dr
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:13:30 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-483bd7354efso8443785e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 21:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771996407; x=1772601207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9StylsjjkPu8pnZ8zwuRErmCy8w6JuJLaaJ30WKTm3g=;
 b=BRb67G1KjNn9h4x46Mc8kPVs5Ti5m08vwEKw22C2n9qpXtBwKKdaqIap9aPEdBZldZ
 9FgJwCmVinemSEm3iWIs3osdk1Ir0U+bCDIii6vPXYbVIVtPJQGaBYBVjTtpHwOiUWHz
 eqRipoKvdMW9D0jMNOsy3xieWMqSm5r6VaGWFhyNrvVvX8H3yggKpnMKaPGp6RHdfuqQ
 7PvVUXoizlCuq8FbY2sLcjXdTky+atX2b5r0nziSPYrpiELBl7sfI1JW3qPSsWajGmpA
 LSZC4UZFfk0yDzjq4U5B3H00/vBoHJUxiBZSOyYiEeOkbY7eTq3KsVvB5NRR2NtZIpYi
 R+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771996407; x=1772601207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9StylsjjkPu8pnZ8zwuRErmCy8w6JuJLaaJ30WKTm3g=;
 b=UKRxvIa52cdl9/6yvUWaqjviNyhYMWXpPbVBSahfZsZFRAq3LOZyZWrrMFAjpzmxUV
 YqQbjGMmzBCJDJfF9z1lVps38LhKrAI7f4K+f08bGeG/rYnBwLe8YB/WE/A94Y2QYOBT
 LkVTZd5Hdbkppf12FE34CRGtvUYKC0OM/7ysDh/IbdfHbVWjp8Fv7K1H8YajSea9farf
 xj1/WYyB5r2POyBwmcFKwPQv3q+FGtM/eMWLQ4cNimfr/yvXt0D4xGYF0dxippJ5hHvD
 yzAIGF67QMkR3kEtXsq7e+YelHOznsq0AijqEnSJa/yO0vdTJkUWg8wb+ILgg1/AO8xe
 FuEg==
X-Gm-Message-State: AOJu0Yzi505RXZ9OEGXqcnjrsnWxpIx2pZADA2dPFNEpvaayxmUxagje
 Rlb/AIcFSbciCGZ3aqC9CGX1fZ5pQ3XaufbOAAtndDpoiQoxCTm+AUDYI9iczYocmTYo/Svd56y
 tMb3xP9k=
X-Gm-Gg: ATEYQzwgfVJd4iekPJgxEgwNgNW0IT1B9NTiEuTxNbFFLXcB/KK3cctn/mPKInScAKf
 gYKT3DC2EyjlNjdBLvvLauNjUPK8qN3v8qlXdbOgRMww8JCHuVl9R/BqCq6LdAAY2hjOZ5AyQqF
 sMURP3ELvXYrPpN4E7AOtyWeyDHfxFQ4bKVR7oGZE5bByhqqcaT07tQvGdUHkG4qlCf4fOcp+Ep
 7wJj6uccX3+RtYaV1ol0MzKQuG+laPdUhlWfwZj0AgG2uhmOmDrWDR1P78aViM/RJQiS4aTlbs/
 tfbN+JwK6LzdCCmIfbi4UhgUoOOm2+XR6+hFjQbE35WvKnqCoevYGWH2kdpXUZYUmf6Ux8gm9cI
 IYN6eMEDQEL+oq/DpZ6q8tRgJKTfUoqJvx+S0d9XM6u9Io3OEP+eUtBJWnEo/ItlaxAs0e04gcI
 9QbmLfHmZW1DCIj/m7qns9N9Rki31YsHtexIOMANW6OzKRI0tIGWuThUV1aN/BHFmVwuBFPLDS
X-Received: by 2002:a05:600c:3e8e:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-483bef5aac0mr18344565e9.27.1771996407557; 
 Tue, 24 Feb 2026 21:13:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd702e7bsm48222585e9.5.2026.02.24.21.13.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 21:13:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 3/5] accel/mshv: Build without target-specific knowledge
Date: Wed, 25 Feb 2026 06:13:01 +0100
Message-ID: <20260225051303.91614-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225051303.91614-1-philmd@linaro.org>
References: <20260225051303.91614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Code in accel/ aims to be target-agnostic. Enforce that
by moving the MSHV file units to system_ss[], which is
target-agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/mshv/meson.build | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
index d3a2b325811..c1b1787c5e6 100644
--- a/accel/mshv/meson.build
+++ b/accel/mshv/meson.build
@@ -1,9 +1,6 @@
-mshv_ss = ss.source_set()
-mshv_ss.add(if_true: files(
+system_ss.add(when: 'CONFIG_MSHV', if_true: files(
   'irq.c',
   'mem.c',
   'msr.c',
   'mshv-all.c'
 ))
-
-specific_ss.add_all(when: 'CONFIG_MSHV', if_true: mshv_ss)
-- 
2.52.0


