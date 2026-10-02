Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486F0CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 07:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCXK2-0004RD-3R; Fri, 02 Oct 2026 03:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xCXK0-0004Qr-B5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 03:04:44 -0400
Received: from mail-wr2-x11.google.com ([2a00:1450:4864:30::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xCXJy-0007on-Gn
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 03:04:44 -0400
Received: by mail-wr2-x11.google.com with SMTP id
 ffacd0b85a97d-48b0fc598f8so770447f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790924681; x=1791529481; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H0y4uisHLcRf9/+4sj1Z7KQ6XlfM+YHm2Mt2yVvDRqM=;
 b=oGGwKEf8M4r3alVY0CxPZLlQEqhtbg3GcLdXX4DQqf2QLUdH05yZUbazPu+LE7QDXf
 5+8k5OpQ4ogPzbphZ1qjSnDsp7nkSiCRGut3vhB2m3c6AeAmlgcpCbLHtop3g50/XVSC
 a80nIUKPrx8lNw3P1+p3A5gqjRvBYLrmw6lolsZpNSXhD7YNbhXHpgO6kiQDFZ8wovHF
 2sIet6qNgJ8BWC02yEAF+u/lbAl3xlxS5JxO1ZVa0Z2dLxpUOiglEqGlaztDo4GaPfQ0
 eZpl6JUwg5gQ0pgYUcShd9oaKuXjZQKRgdIpDdz2A0Ty+AOiuSWZwi0/1UB+IVqCz0yd
 kFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790924681; x=1791529481;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=H0y4uisHLcRf9/+4sj1Z7KQ6XlfM+YHm2Mt2yVvDRqM=;
 b=aKhxrKRoSBiD6STK9Q/pK0SA7W5RHyrnWuEWXixklbCUqfNxvssOLovuVUOJP9Q14J
 9174MmZ6AVglKk/F8PU4gysYTm5GkYKRI13nPizxDMq+AvjcvCadLN0SJcn84riktM+W
 kRtz3yfGFSJji/tewpaDGTyym3lf8jGlH8MfG/ZTeCCa5HkF+6Vc11dUHP4X7GntdlcP
 hZvr7vGl92MF9Uem80b1cyoIbTl4FOM95NpT1Ta0uyHFI2rMbPEBkTWW2vBOZyPWk+hi
 cQmfEeUO2hyYDcyfauC1nn5Bl68Z8P6t+OfelMAv057RfMMBN2xaPM+13Tr9NphTCO8W
 bMlg==
X-Gm-Message-State: AFq9FYL2l6LPahX7d8iaZANpbqj2e0qzb00a6mwHtuQX2s/XMiICTGpR
 wyT0sPosVZ9XmehYKa/F0+l397PdK7Y8VdlKnmsXUJD24Aef/FiPd4D8
X-Gm-Gg: AYBFou0/RggXPldlBqUayHMKVulb3lvO+UATSw5qLLx/+To6kb3bx4vc58HPG8aVJIr
 +F6esv2sCFLdA30S+N/+reoRVwq/HUYv0ysBgoZ+/cq3ZMTtGyDfEEodz1ASB+dkuLxYSrmM3WR
 mfR5HfqqEU27cWJicxxysWgfv5wjWZoRi0z9r92J9VIi0lj5SKLcdwS176HImTsSvx+Fq22FCqw
 6BFO5TPTpoLNzhJAmsUf3eRGQyAzoFKzUXA3VklNKsFBWXq1jZdnQQwzOyBwxzUAraByWGxii7e
 +VY5KBI/B24kNfMnEGhhhDRV+joLRwDu8wCae8NdiCDJI4cP8xh6CFJmbx5l2BFbvo8koPToi96
 VD81XSBjz5levdF1TGaHOzcmUf5ac/L3cc3dFihGKm6MAyU0ZySJXBcc4rz4No8TJ0XkE8Ks5xD
 9mv8oBhnv7E3Dd+8fNEboIiAS7Xdp81LkF2obPL5ZBI52Ef13tyyxNpUidhRfLe7WKShfb1SZKu
 A2nkB0mlCEhx9kKKY4yY8WlQjxW+fvYdxXDW7dM8lxKgZXWjogtLbP9j2M6FCZzlUr+657EkHf+
 FjB8ttXZW7FH3EDdpg9Gg8y3GOEe9iI=
X-Received: by 2002:a05:6000:4304:b0:48a:fba3:d5b1 with SMTP id
 ffacd0b85a97d-48b127762c2mr3172293f8f.55.1790924680713; 
 Fri, 02 Oct 2026 00:04:40 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-59ed-f900-fcb6-f178-37d4-c8fa.310.pool.telefonica.de.
 [2a02:3100:59ed:f900:fcb6:f178:37d4:c8fa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ae1sm3723407f8f.39.2026.10.02.00.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 00:04:40 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Fri, 02 Oct 2026 09:04:01 +0200
Subject: [PATCH] iotests: annotate TestRunner.shared_self for mypy 2.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-mypy-2-4-v1-1-185c406d1cbd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM3QpAQBCG4VvRHJvaHYtyK3LgZzDKT7uI5N4tD
 p96v+8Cx1bYQRZcYHkXJ/PkocMA6r6cOkZpvIEUJVopwvFcTiQ0SLExTRm1hnUKPl8st3J8V3n
 x223VwPX67uG+H6gp97psAAAA
X-Change-ID: 20261002-mypy-2-4-2544da3f4e17
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, 
 Tim Pambor <timpambor@gmail.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:30::11;
 envelope-from=timpambor@gmail.com; helo=mail-wr2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

mypy 2.4.0 infers the unannotated class attribute "shared_self = None"
as having type "None" and rejects the later assignment of a TestRunner
instance in run_tests_pool():

  testrunner.py:126: error: Incompatible types in assignment
  (expression has type "TestRunner", variable has type "None")

Earlier mypy versions treated the attribute as a partial type and
accepted the assignment. Give the attribute an explicit
Optional['TestRunner'] annotation so both old and new mypy agree.

Fixes tests/linters.py::TestLinters::test_mypy_iotests with mypy >= 2.4.

Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
CI run with mypy 2.4: https://gitlab.com/tpambor/qemu/-/pipelines/2905639361
---
 tests/qemu-iotests/testrunner.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index cc36867719..729680da4a 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -108,7 +108,7 @@ def __init__(self, status: str, description: str = '',
 
 
 class TestRunner(contextlib.AbstractContextManager['TestRunner']):
-    shared_self = None
+    shared_self: Optional['TestRunner'] = None
 
     @staticmethod
     def proc_run_test(test: str, test_field_width: int) -> TestResult:

---
base-commit: f7ada39edacaa5c26b30e98b94017b0b2ccbcf94
change-id: 20261002-mypy-2-4-2544da3f4e17

Best regards,
--  
Tim Pambor <timpambor@gmail.com>


