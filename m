Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EF6F4613F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4heH-0005FR-9C; Mon, 23 Mar 2026 11:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he2-0005EV-2e
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:46 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he0-0007tN-7x
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:45 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b97a9f4b4dcso55075766b.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 08:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774281403; x=1774886203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1owwL+w+vru+csJAdWQEKd51KLa9JtH8Ji/d8a5Sfc=;
 b=Z/8m8wNdd1k8SwowSXTptQr7tUDGdeChzZZawKP1kQgeDGipR+uyHS6TKGBuHECk3O
 FOwfe5dM+7/vo1BqnY22HemmFUH4TU9/rTgOMAQODYl+Tj2AW75vXZPxj/PHTC8ZGMLa
 Bt0ZilFqAJwIrW5Gqo9hkPsKAOkT4KNBLXGjFOp2e8eJdPrtBmCTbHLtE1JzcItQ8ens
 yEDSN2U5vFxb6vJAc1ueTcb9VafeIzPAHuL2/7cUC5gVaQVmn7qqi8O1dXGiQOZi/kXd
 /+PPAB96re45Lj6txyyewfD8CwgO2vZ3NJzrsY+7ppE0497Dz/2FCxAegw3UKpFnazCj
 jrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774281403; x=1774886203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P1owwL+w+vru+csJAdWQEKd51KLa9JtH8Ji/d8a5Sfc=;
 b=jYFkE+AB9ujwuA73UeiKCc+qYxuHNA7LvGTXoP1z+roaG9H/zah/PQKYvsUq8/yPjE
 SvRVKnYbbg3SeG0E20GSr1gBgkdikQ9NePsSlbPLCJVd5ve+NKS4Ha0rLqF+EMpKK/tn
 urrqK4KJrpOSGV/0Yzf4aa656awRTgZ/z7zrPkU7yH4Kq+p0Ut2UQwsK/HDx/OLkWLer
 uiCpDwQNX0zXZkUniPstz2XQnVPQpcySs5VcXLz+nRcZMlhhCGRMDTJLIPnSyIBO73Xu
 6nk6eBvQdFW8xhkYscYD+EEwo8yeY4v5nWZeLOTAWO6+xSA1ZHd7j6U4jyK3xxbuC40e
 Ah5g==
X-Gm-Message-State: AOJu0YxSue8hUT3uq31SwyIVa/DtCE9CIYNzQZms9DIXNTzFTNfKx1Gb
 0MmoHHt9Htx81FrgeCAkjSshSnBBYGktIB/vzL5RtE31Skzqvg5H0ovSHT7SbKkJ3jM=
X-Gm-Gg: ATEYQzyvUgdw43yUujQOSS5PaKpe81iuq/awQHj4pWjTLEbIcmi1aIfhCvUso57607K
 gf/DLsW9aDA3fh2O2IhCLmdS6JpTkrdIhmJFLbdtv9vZeFOxSHxBAyFYzGM/lWSsF6+VKbovb5t
 2vKVd3XOzzrcKlQxhiZN3m52Hy5mSBFQ887fsu6jS46W2VcMBYUjINBqrrH/MI5szAdvMWDEfLc
 0sDskOpmvSZGMbZpW0wTg232RFtZTOpLMlPkBkFzGPvLkICswcG0noWgxcLD01PbsfRGvhozCj/
 IaTpHzx8hLmDlaQSXhcV5WernY1J1APkcp2TB22/0xtsU3fAPvWp/HWg+n0q06lX/+qbQ7z0mXo
 bNkBGnsvnIe+fzGA4tMyU5mONkyK7PUvha8xxo5EZEaMcP8h7DJ1KrU740p81IPUo0mKITf5Ad2
 kdcym78Kty4zJQ59zCoWXkAew=
X-Received: by 2002:a17:907:3f98:b0:b98:4b5e:da5e with SMTP id
 a640c23a62f3a-b984b5efa8bmr660242966b.43.1774281402533; 
 Mon, 23 Mar 2026 08:56:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b98335de177sm510337766b.29.2026.03.23.08.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 08:56:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4D64C5F888;
 Mon, 23 Mar 2026 15:56:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/8] tests/lcitool: Remove python3-sqlite3 from the list of
 needed packages
Date: Mon, 23 Mar 2026 15:56:34 +0000
Message-ID: <20260323155637.145015-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323155637.145015-1-alex.bennee@linaro.org>
References: <20260323155637.145015-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

From: Thomas Huth <thuth@redhat.com>

According to commit 7485508341f4 ("tests/docker: Add sqlite3 module to
openSUSE Leap container") that introduced this line, the sqlite3 package
was only required for Avocado. We don't use Avocado in QEMU anymore since
a while, so we can drop this package now from our list again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260316135407.209072-2-thuth@redhat.com>
Message-ID: <20260320155107.2143191-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 5e34e953514..b78a1d7f2e0 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -101,7 +101,6 @@ packages:
  - python3-setuptools
  - python3-sphinx
  - python3-sphinx-rtd-theme
- - python3-sqlite3
  - python3-tomli
  - python3-venv
  - python3-wheel
-- 
2.47.3


