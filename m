Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFC2D58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwunT-00019n-QU; Sun, 01 Mar 2026 23:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunS-00019Z-3r
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:18 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunQ-0006uX-H3
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:17 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d4c307db9aso2503465a34.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425335; x=1773030135;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoOIE+vCtRwq0nZC6F99uM+Dxp6vXSThV662VgTHnGM=;
 b=2WmJnAhrwWjhVgZJ+zYD8X5+P0Sq+uMb0hz+/SVhWHmaCHZn3JM+anoliqf+pZPwh0
 /A2SbE2JHLk4OcnSQwp5EFoBem398NTGBRF/tluRYz8YOtb+rkZPhx7kFCyk/wvH33rc
 hh50dluEHOH6IA4TRDx0rGeWhciLwdUWgoqM7d4li1bcD/OI8nW6PzKE4aTNyKY28z9z
 um1u6IY1Bum0OzFOGQHjJJZOmhKrq8vjxcgPxxSrB3XRHyO0opr2jHo8a7SdBpuAi1jG
 ThrfHkSQucWQFhLkXkCf5fCDxpZm7yr0hjOI66OdsE+xvLSFq+fLb51KehQwO21/TfNJ
 dTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425335; x=1773030135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eoOIE+vCtRwq0nZC6F99uM+Dxp6vXSThV662VgTHnGM=;
 b=CvAPr7mZ94gr9YHAg6BJ2/jHy6Lj47bzQbuWz10mAV93PH5ML1WrQkvEYYNp9rVIxk
 X8t6mONjAbBuxRXw6kyBDJffKg88njxFhyoAmkeNO0keON6cf7mMEqx8B53hb3FJSUty
 kH3yTk0IR/qUpc5ClhZlEupz4wbwXgO+gnKY4kCfSokl/gIxgPfv1e1M7qqMsrf4jEfj
 8tUEK0AY2tcfZjTJ509nnWrbX9HqK9OMZ69kq004cqdxRwvKksSKeYy8M1xUd1dQdHIW
 wQdX5OGId9XNBaus6T1oCadEA8Bg2+QdYFWrOndgYuGC+0+UzZFXt3Cd6pFLTSfHdfsd
 a2ig==
X-Gm-Message-State: AOJu0YxQv162tlztmX8b0w/COTdB8Mis/7rGxJ4n/KWHcEYV/dCDU76c
 2H5erQPnw0+81oVz7vEDw7YriTMv57427KkyXU2rd3bmcJVB1OQfcSMAekXm/p+jWr/ZgbC2xjF
 w+vyCxcM=
X-Gm-Gg: ATEYQzxZXiZNv/89jgAGBdgifIutNq/FBREH7rcpEGlKEcK/kG6mn7zJlZ4gqT1Av2g
 GUGjdfElJeToVNMFqFXV7j3ZsbgDTTj7G35dUyoqT8eTNgHbfiENtGLJbBs+Qr7kSnKCm9kRjrM
 ALsutKlpTKV6O1ziYMcoMJ7XDidWaIez0eVqNNIPYZmkS/sL+zBAn7k9GOOioqRjhq5qI89OSxo
 KdoQfDMY40apF4zbd69CbK2kFcYoLaur/So6wuCz2dPwCxhUdF8iai59pawgAJzGGjR9l1Lfqqx
 xlJy+PgdtXmB0Yg0p/tYSmdUkz9GZstftAeMPAH3A+BAFoVPJ9nGEqpSPYQNmQbpXlh2Q5L5xnp
 UdZe5FoXjY6VOtctcG8uMi5PKdQqw6c0xL1z/TOTFhYtIAEca4P49uJu7gfoipVpEmiXLEowUWt
 F7UM1TficNbA==
X-Received: by 2002:a05:6870:1cf:b0:409:40bb:6b5d with SMTP id
 586e51a60fabf-41627037555mr6632207fac.32.1772425335173; 
 Sun, 01 Mar 2026 20:22:15 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:22:14 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Siva Mahadevan <me@svmhdvn.name>
Subject: [PULL 27/27] bsd-user: update aarch64-bsd-user.mak gdb XML list
Date: Sun,  1 Mar 2026 21:21:15 -0700
Message-ID: <20260302042115.83410-28-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Siva Mahadevan <me@svmhdvn.name>

Fixes unreachable code assert in qemu:smoke / bsd-user-smoke test.

Upstream commit: https://gitlab.com/qemu-project/qemu/-/commit/591e848aca7af3b4d25af03ed5bd266c479054bf

Pull-Request: https://github.com/qemu-bsd-user/qemu-bsd-user/pull/61
Signed-off-by: Siva Mahadevan <me@svmhdvn.name>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 configs/targets/aarch64-bsd-user.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/targets/aarch64-bsd-user.mak b/configs/targets/aarch64-bsd-user.mak
index 7f42e06047..03979d8240 100644
--- a/configs/targets/aarch64-bsd-user.mak
+++ b/configs/targets/aarch64-bsd-user.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-sme2.xml
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml gdb-xml/aarch64-sme2.xml
 TARGET_LONG_BITS=64
-- 
2.52.0


