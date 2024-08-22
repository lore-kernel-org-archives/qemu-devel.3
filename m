Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF32C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 09:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh4Ta-0007ea-QB; Thu, 22 Aug 2024 05:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh4TQ-0007ZU-1K
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 05:51:23 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh4TM-00023f-Ul
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 05:51:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42819654737so3935745e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 02:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724320273; x=1724925073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEt78BY1+b0Q2uRxu35ufp1qJ07/oJ8ixAjUQfbY+Bw=;
 b=Hyy9QXi0iVU86XpcnrEe+BPaTcMTodHfHG83N5djaETRPOFkTJ52neE27+f8gf6zJi
 jOr1SHt20IQM0i1ey3dqvbqE862AF2d6RZrJxEmoEYXWv1iaj+VFQkZ1Bbta+sgBRMPQ
 YcDrsDAUJvvGZxXwl9Xm1QLlPjs4OdbnT3q24QtEVIRWUoq0Lc7Ag+JOWxeaIJdVNGD+
 BDml5ryiMd2EUor9irQa3wX1A2M7qXBCsf5NeHtMhBZFw4XmLubhHtPllaYo1YMJPmNi
 QJLuGXIP4tOITYTdlbPfzUqygECs8qgFmwGyNvGak+agQf+lYOlFsP4YIV4xOLSENQMO
 XUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724320273; x=1724925073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEt78BY1+b0Q2uRxu35ufp1qJ07/oJ8ixAjUQfbY+Bw=;
 b=VIMNf0GGD4bcO2LFiEwOynBBPwg9JhUsHJ/UYqm/DJq0L/Hc4uSUXnQ9mzwuoajsGB
 3QaS4mX1EmyNhGDZ/qRIySLnhmvgAbOv3PhqX62epfQyin3A7unVQjqBeH3oBAWkF4SC
 NnlKDsU03ZFP6aIbU81Jh07Hxhc1HK7IiCbycO8S0TNvxbOiHzZ2uTchzr6G9ZWdNHdj
 55wbc9LWRkxOIFJNY6EYhe1Kb1fR60s1aHAtFysfbfZPZ4DbW8AbTpTf1/yeqivlJ0M3
 IIGWrJ21O+qp6kLCvHE0tr0DkgkNnPjmbkLxG3iw5a2DNI1Ukyis1CYGosuFkN+0lsE0
 LmzQ==
X-Gm-Message-State: AOJu0Yx4PYEehCfLC8VZXKSS6Tz/or6LeyeAer4Xr0F3AJiiZN3t4gWk
 InUly1CR0muL1z7KXqmSSIXsNJx2QTIqXerZwwI8LapgaA+5P91mk22qnbom39mSK7dVSZw7rbE
 c
X-Google-Smtp-Source: AGHT+IFxK8AYj+Zk4/YUdnzh2zR3OLsV+j2TX+Bndt7NHEOVwGLvECZth9RmePCmgxDcK2OY3YAutw==
X-Received: by 2002:a05:600c:5114:b0:426:5269:9827 with SMTP id
 5b1f17b1804b1-42ac5529b3dmr9941935e9.0.1724320272818; 
 Thu, 22 Aug 2024 02:51:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac5180339sm18190535e9.43.2024.08.22.02.51.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Aug 2024 02:51:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 4/4] tests/avocado: Run STM32 bFLT busybox binary in
 current directory
Date: Thu, 22 Aug 2024 11:50:45 +0200
Message-ID: <20240822095045.72643-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822095045.72643-1-philmd@linaro.org>
References: <20240822095045.72643-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When this test was added in commit 8011837a01, self.workdir was
set to the test directory. As of this commit, it is not set
anymore. Rather than using a full path to the busybox binary,
we can run it in the current directory, effectively kludging
the fact that self.workdir is not set. Good enough to run the
test:

  Fetching asset from tests/avocado/load_bflt.py:LoadBFLT.test_stm32
  JOB ID     : 020d317281b042f46ad99013530d29df0f1d7eb7
  JOB LOG    : tests/results/job-2024-08-22T10.17-020d317/job.log
   (1/1) tests/avocado/load_bflt.py:LoadBFLT.test_stm32: PASS (0.09 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 0.62 s

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/load_bflt.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/avocado/load_bflt.py b/tests/avocado/load_bflt.py
index bb50cec1ee..264489ee25 100644
--- a/tests/avocado/load_bflt.py
+++ b/tests/avocado/load_bflt.py
@@ -41,7 +41,7 @@ def test_stm32(self):
                       'Stm32_mini_rootfs.cpio.bz2')
         rootfs_hash = '9f065e6ba40cce7411ba757f924f30fcc57951e6'
         rootfs_path_bz2 = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
-        busybox_path = os.path.join(self.workdir, "/bin/busybox")
+        busybox_path = os.path.join(self.workdir, "bin/busybox")
 
         self.extract_cpio(rootfs_path_bz2)
 
-- 
2.45.2


