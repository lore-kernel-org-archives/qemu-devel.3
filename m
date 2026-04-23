Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7044FF9936B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquX-0007Em-0S; Thu, 23 Apr 2026 06:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtw-0006V6-A8
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtu-0002HR-Bp
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:15 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so5143819f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938593; x=1777543393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SDREAVhQVCftlsNVYh/k/u+8eiUT7Fox+ascvSNpxfI=;
 b=mGdKkHKfAZmPms+BWVQSG1mF/TAmg0ailBf+FGdPxD7liynnTGfZYJcKnm8xrdyEoL
 aoekpTahIzFeghoHAPs56Jg5/Tv+Dw43o8g3y3+rBJEu37U/aVgKu9ha191vOaSjD7CA
 lLO/Gi6jl36WWQycpj3sLe8fKpAiGUQQ8Iw7+hGrRdL3cZXlzQgVukDWVSCzPGZ63Qas
 8mb54937R8f9v0JpWFqVoi2UGlbL9vzPShnobM0gb6AzX5yz+5AmycTIm09xc+5G2Aqy
 lb4NsoUi9V2I+m4Ha4DhKrpLOUty1MgkR3An1dabnNHdnT/JegtrHpUNJ7FVZxI/S5rM
 u/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938593; x=1777543393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SDREAVhQVCftlsNVYh/k/u+8eiUT7Fox+ascvSNpxfI=;
 b=WIkXXMrY6gCt8uFHcYy8iz3D+LfZ45f2hM0E6khh3qMsj1f+Z9sQ9K/cl+HutkUYLk
 UF92ky5VOUYsTdp2UNxpVpLMh/2up4VyCiP25gFIC+QhO5UN2TUqvM7nv9PWvDpHiNhE
 o+LtSrgaVO/5Y3tjMo+YBfQbyawhHrL122OIGk0y2aBf2ojgekuX1SsqzJgI1KDaG4y2
 5qNfw425+HMEjEkVB+0KPXaKYgH07WqecGyKCnxa2rh9nF7THJzL2H3qZLYdvOm7WCL1
 gidNfpB4uLli9Nunj8ZDFPuYRer+w3zV1PJMOirfMv6RTydw5h6KPtrGy+/SMlpT1HOu
 kGiA==
X-Gm-Message-State: AOJu0Yy8HSZP77Q4AUnr+LI6H8acovYFrlP3KzAmtXSK1AC76qzOQHoz
 LEZ2MwJiJ4kaxfr/a4daWTWJyhapJ4tNlHbGn9UzSXrpszeZXt2wH/qqFM3FF37OGt0/1RSg12Y
 Rnu/g
X-Gm-Gg: AeBDiev+3yqdEembggT0oqH9/4tac8ZoG8cpsIkPwLyGebCbfcQboeFkZUaH87v+mCd
 caso9aPkfFWHZalK3k4Tlj9D9bLAkLjza2T4CWgbt0OlnOks83aHHrDxNrTVBQda5kjbRd92TZH
 iO0CQOVexWq4gd0C9ACm7ttIC80GvTQHz1yRGg0RFFg8doLLimZfw7VA3EJYJxOTzKWigIAzqHu
 Z9mQbjnVgB4iIZwlR7NCs2b9Mw8QHXL/hKSqvncn92/y6pxLE5TIG/6BFYZsrC+IKEgkAMzoEU7
 WIBDZ7WPcqN+UqI6rdn1v5g/7dHDJr4DuqwhL8zHRs9y5hmH07nx6h4B/XvtZ5t8lmD7/nmkITi
 IZ+fUUE2ys/TUTRQIvDjPWvY3d9YfCZZFp59oqXUJG/47qrtxnkuCfw5KXXzovkVAWWvvMNXQU+
 zo6xeIxu5iN7xdbZbFkWUrEoFd76UeR1fihpJ3TwH9zrEjEj72gStOVuVJI/ePnS5k75BVTMImo
 7GVOItyf4tChKfSniRO3wa+F/stAqIycRJ5IKT1IInTdtWR55UH
X-Received: by 2002:a05:6000:1785:b0:43c:fc5c:a9fe with SMTP id
 ffacd0b85a97d-43fe3dbf4e7mr40458377f8f.20.1776938592958; 
 Thu, 23 Apr 2026 03:03:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/59] MAINTAINERS: Remove Damien Hedde
Date: Thu, 23 Apr 2026 11:02:08 +0100
Message-ID: <20260423100229.2941820-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Damien Hedde has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-7-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index db894223ca..855b6dee70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4035,7 +4035,6 @@ F: .gitlab-ci.d/opensbi/
 
 Clock framework
 M: Luc Michel <luc@lmichel.fr>
-R: Damien Hedde <damien.hedde@dahe.fr>
 S: Maintained
 F: include/hw/core/clock.h
 F: include/hw/core/qdev-clock.h
-- 
2.43.0


