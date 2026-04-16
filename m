Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A56F8A14C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrj-0005vM-DP; Thu, 16 Apr 2026 05:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqU-0005BP-D6
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqR-0007kf-2v
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:10 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so102365495e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331024; x=1776935824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qUsQecM9puT7jlNbunEhZ2EsfmI74E6/VrO9ge7/g5o=;
 b=aSmOKo1QZmHdRStRYnDakvoDG/EfJPxH6RH8egf6rsfcIhgD8jj/FDKh5LiN3FndJx
 9eFbw8UTebq/XJgxht7ZAxh4mU8VojjaQYJO8unlZo5tS8F/dH/LHg8rTHmd0+mIhFgY
 rqMRhLmBU58cCq/nXATu9FpMmuPHcD2i9slVNUsd0ViEepZQUh5S5A33TU3He/uKp+bg
 TGs5vKMlJI2k/r2Klf0NmRvlyjQ4IidyNs9PXp1PZ9dyX9xxjjjmh2rHnYV70Q7KHAXq
 9RLDLrjbRgQR16X8XDXRNHUoMTcXCbHc+cD23QLzkODUFOkkHuOPX4l7XqrGWOKnSb96
 fokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331024; x=1776935824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qUsQecM9puT7jlNbunEhZ2EsfmI74E6/VrO9ge7/g5o=;
 b=XAmnIn+RVPTLr6wusxqfkb6Uh7N/CDc20xOCYx7+7A+OosRyRaTlaw+/G88DKqlMDx
 LnmMLPUXgGuGdpAU4iE318aIvEO1zk6ryCNWcP04muhiVhZP+pJdQVXHryYwckpT03OZ
 IY5xtX8sggjCpf9EjlljSXKjwk/YoslA61wqypSm1Oy8u0qGxVe/AbbU/SbYvWWih4Ok
 xdEwMr77tRZ3RGvegVMyYVN37sdnrMZwaN5a2T5zqo8j7FirTldTygsELd0dMICen4tC
 d2uSjiQJZGo1IMIzXb7FPMwjD3xGGGj8EEkGP74xDX1SpbZuTvQXdZI8/RdkwRSQoF4v
 8nLA==
X-Gm-Message-State: AOJu0YxIlwSq77Z+cuos5GvSHMjM3oUx5slOsEw615yxDBMexBrV/Mqr
 /SboTwwhChwnepufxd72CTRYhiZ8usg6kUUT7/5r2n58eVpyTNg/7n0zi6aeSFx8ZKb7DSuWXe1
 WakwXejY=
X-Gm-Gg: AeBDietxhwj3PqEchgz/sRwWxnS83whasuOX2Hsyeg+HajL7z84lIxemq2kTGqb9Mes
 /4EZomZmupOJDkZCh7MTISiqtNxVAk/pPXMg3JOVN8eZKaAnDaCcz8lsz4FirprJvoGTKUtA+3L
 ia5dOAHJOeZL/h2I7jlDzJgK9+o3GgmY65PvMDbSosRFIVx7fmVcUL+x95TZ5qaRfs50qHKlakh
 97iW0yacBOlBEBufahLCatqaSvmzHn8pVD1iKeCksxBL4M5tnAKhfC/N976eCIAt9X9EeRNmZSf
 AM+YfMQ6Erg/p3GAXicgofbVWTXAM3nSUhLVYeB2TGEehRduFx4wuWxG4Tly3NFcMfl5yCeN/L4
 fMm4rTzgIMJprA8+NSHYRc0BXdAz49uka7ckZ/wLlIYOmH2pH4gOYjawD5ysVp14uE2j5bThEcv
 DJO6rHpbaMk0o67tCtWG66tAaW9yRmzCKQheBdpUMEnUVHJlqRlI0sGIZPenJFBdrIxZrAaTILk
 0gOWJ0uGkzONsQa6qBfsSoQ+xd6+w53uVQhP6BngQ==
X-Received: by 2002:a05:600c:64cd:b0:487:21c7:2885 with SMTP id
 5b1f17b1804b1-488d67df57dmr350640215e9.5.1776331024225; 
 Thu, 16 Apr 2026 02:17:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/28] MAINTAINERS: Remove Dongjiu Geng
Date: Thu, 16 Apr 2026 10:16:34 +0100
Message-ID: <20260416091654.316158-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Dongjiu Geng has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the "ACPI/HEST/GHES" section orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90837d0316..a7fb4e4770 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2219,9 +2219,8 @@ F: tests/functional/x86_64/test_acpi_bits.py
 F: docs/devel/testing/acpi-bits.rst
 
 ACPI/HEST/GHES
-R: Dongjiu Geng <gengdongjiu1@gmail.com>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Orphan
 F: hw/acpi/ghes.c
 F: include/hw/acpi/ghes.h
 F: docs/specs/acpi_hest_ghes.rst
-- 
2.43.0


