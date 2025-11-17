Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CA8CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1V7-0003tT-TM; Mon, 17 Nov 2025 10:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UO-0003d0-Gm
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:07 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UL-0007y7-8A
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:49:59 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b32a3e78bso3638572f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394595; x=1763999395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZRYAZdzLgyEzHOt2DfzPrkE819VJ/pVp5yoaxoHfw4=;
 b=A5vkMRohWI/C06lgF+qwO5Jes6bhX1NMG7az7HZ2O11uHWXDtKYfN0WcGp53FzLxAy
 stSfZu8CscjzonIufR8STJMmIdj+TNDZw6atqaLhymGWfDXNIR12L8lUs6/LqNhg8ZdQ
 EzduNEI3sTPDgmwD8qCTFAFn/gNodPFM/pJ9C4SiH37G5TMtgNQ8qS9hTlxeKXGmO5zT
 Hxy4AJHOCzssSAGGS8F9DjfxgMATOLQDY0A/ES4IJWULDTZwXJ1WfYIi8AQrOL8Og8Xw
 MGVmHcICmKYdNxcxO5dwtWUBfjE6LVw+EXNpIBWJW6KzS3SnsxGN+Wr5CEm7ZNUGSw2Q
 YzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394595; x=1763999395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oZRYAZdzLgyEzHOt2DfzPrkE819VJ/pVp5yoaxoHfw4=;
 b=RtK8MV5lhka1WcrOCIkCP+0IQKjpQkvULDeNi88lyU6QbXDhPYR6UrOzVqMJakzuUm
 OV7q2/ptek/9MgPzs9O89NlUDxwsyV6DmuDhlZ1FL/MEHbXRqdkjJ2o29kb/Y8fydsaG
 1wBP/aT8JKr40Jia2YIViu1eqfi/4ySl039IxH8PUtn9/kcS1cRK6GZkrG2ilDFNONZT
 IgZnTNWlHHURv5sG50B/yH38n2To0QXskAYCXcXib8xwaVPOPWGxvseYyWdHM6TFMGFY
 JXjiy0DkxKQ/idZpRi44gpSezZN+nB8ti7TnuCmvh5gMPXRMxWPKJiohlZ3BuWua2NCc
 CCjg==
X-Gm-Message-State: AOJu0Yw7blyT+pmF+RO5WNAqMZmzuDmThWaIkQtlKLwV+WRKt6J46N4M
 2NK1mu1ftdwefvaDtZ9Vzlsn+A4vmbNKJ0PtHG/1bC2RAc7qyfPRZnJ6tlJG+mKa2LQ=
X-Gm-Gg: ASbGncunc+L030hpT1j5d9ALMlyJJ8MPZcYIjpvU+uOb8Ynr+vxTf8QvHs6eBk+Q3Sy
 LfGh/clBNmeGAp3x4ICXj962afEy3M5kV+JHnbjD7SLIZm7jMxYnCPoldHqSslyFdJZ/L9a4YFw
 qzx+4tVmRsuWhBU/S+Wj+z0hzyPLnRAtJmMipgTuS7W6SVTI6TXjr2QDdteUy1JdSDjWeOA8iJ9
 GsE4eeROCV2D1339KPrBCGyQi2JYFl4aEt4xA4nnsnhSHSH4FEC0BfsbHXyPtNj3hWnATce1zpF
 lhWH8ztPqrB5EJ8j4x8AMaA9VMPzmIa/c8Iu9S6otJwlBnwUqLNyqqlvsUiFxcgnymWSVImEgmf
 aozSZ2eSiItUCSxxFrjDkHN2tU7/0dYKZSXnRCNiPI7/S4QKqgh2ksEidEJpq5ElnEO4KWLMfbJ
 kKgqKG0FNtYHQ=
X-Google-Smtp-Source: AGHT+IEc8jEEVXXrv8qeE8/V3Q2lcaCxaYmnm6aToTAPc5Dps/raXtBpg904AugJIh+PuuCdRLBUSA==
X-Received: by 2002:a05:6000:22c1:b0:42b:4139:579e with SMTP id
 ffacd0b85a97d-42b5938eee5mr12763429f8f.43.1763394595486; 
 Mon, 17 Nov 2025 07:49:55 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53dea1c9sm27103070f8f.0.2025.11.17.07.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:49:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5C8EE5FA14;
 Mon, 17 Nov 2025 15:49:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM KVM CPUs)
Subject: [PULL 10/18] tests: move test_kvm to share.linaro.org
Date: Mon, 17 Nov 2025 15:49:39 +0000
Message-ID: <20251117154948.4122164-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org>
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Cc: qemu-stable@nongnu.org
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251117115523.3993105-11-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
index 9fb9286139f..7545f5ed554 100755
--- a/tests/functional/aarch64/test_kvm.py
+++ b/tests/functional/aarch64/test_kvm.py
@@ -19,9 +19,7 @@
 class Aarch64VirtKVMTests(LinuxKernelTest):
 
     ASSET_KVM_TEST_KERNEL = Asset(
-        'https://fileserver.linaro.org/s/HmjaxXXYHYSqbes/'
-        'download?path=%2F&files='
-        'image-with-kvm-tool-and-unit-tests.gz',
+        'https://share.linaro.org/downloadFile?id=Bs8Eb2Wb7yWtkTA',
         '34de4aaea90db5da42729e7d28b77f392c37a2f4da859f889a5234aaf0970696')
 
     # make it easier to detect successful return to shell
-- 
2.47.3


