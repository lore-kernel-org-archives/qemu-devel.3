Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F65DCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1V9-0003uU-6g; Mon, 17 Nov 2025 10:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UO-0003cx-HG
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:07 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UK-0007xl-9j
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:49:58 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42b31507ed8so3581747f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394595; x=1763999395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dd12xLv4jOlBj+DmEwVJ8XfqG9QkXEwDac20LPq+L2I=;
 b=n3rpmYNymI0QK/mIEojYB9RE0gK9Boa9Q+rx5Pe3mAWVrZnf8Lh9uz0Sxajcd4t0sA
 n1xchvT9J6DzkGh6MIv358OMA8CmU7R5mqvCqCtExBM+eTNDMswfK3WV+0ZM+AHU472i
 MH2pRPyOkPOQ1e03ydmvnnBanlBFCUZN91CUwSjkT+hz9pfc2SE7rlADah8p2wyc9zFV
 nC1bmrI3HshVi3ppQfVF1SHG3okFSa1As/77pV1kJV4MSFycrinriNkYzahkngDtVCOM
 L6XfS9dYOFGrJ8HbocwANpW9jBOpbcVTAOL2PmY7/uWIYU9nEGoViYZSSO+Q0eT8jVmv
 BQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394595; x=1763999395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dd12xLv4jOlBj+DmEwVJ8XfqG9QkXEwDac20LPq+L2I=;
 b=lUYtJzFw+/w6lpifdbeGDUms0IoeC+A2Kh6lL2ar64DWpxNl+68ZhKRMz6DFO5Qsdo
 jlRjcHmByEnNmW+iei+Nu7BVykQZiYz2Z+5Y1S8beRFgFBjSfJ3nzQ8WXf29e1nsP/ye
 qDBd6UrBRYTUA0IHrbKSCNfN/OKmt1aLBACMGKEZc3PWsWLu3rAux7HquPucCojpv5b5
 ubGASEFq8+oXeRHQ5O5Hi//3PJMUA1tQ9PA7Ixa5x9Z6WrAoq9+LR7ojp5GScQ9VbQJi
 7Cm5T5PRTwJk/kN/jQnmdJSHx9GIL8qh2/ewYpCv1P53+LJMIEwWPkc8WvYd9E4JX6PI
 Sacw==
X-Gm-Message-State: AOJu0YykOIhYXnczgql2DiW8Vc2Sq9OMnT8YC8l0bYFNCyu3DL6Tb2qx
 owjzcNd1QKt19krwnklCxhrfZAPgP5rILR9JgB+Frz40oJc4zQv9yjrT9kr5/Qd0lcE=
X-Gm-Gg: ASbGncsalV8R9QOGJkp8dscMnEUMyRq6t3aLedUV29vNctn385ANKR5oacPp06Zkmq/
 j/HVq55Zu21SsQSxQKYAA4TxKHIs6Ioa722+a2hbeWgCSYr1xf3s/YIAlykO4KYAiXf2EjYkMe9
 rUUcPHuT8MTQdMFk/u5MMdFgjTNGWFaujWfwTRC2szybf73ObbZtGufT0y7MSTSNL+jBFghom4D
 3DJlvQInghx1Vgh5KzYU6nnsbcHFAfh2PLwpXqKZuZbGKQOWv3urWtIuq86mEpy1qtLyubgIWV6
 7p9Mw8gWu3wcmTKMn6jPqjqmWBFIr/4F9OOH9ST8m58oaCItGzGDx69AS/BPZDYHSChQgxa6DWT
 cIJTWnvAyI7a3K2Gpd0Zceit+lTm3cc6DtxYG48BlEAbzJcqEXlZp5bGzXRNKj7aj8XX6K3XloE
 kJ0/kClqCenK81RC3zh4RfIg==
X-Google-Smtp-Source: AGHT+IFtDCBlglcCaSQ6fI6J+l+kGXMduL/iew1ebSh/ucpdshzWSP4P3zOuXSfgrhzlU0FMbC4BOw==
X-Received: by 2002:a05:6000:26c2:b0:429:c711:229a with SMTP id
 ffacd0b85a97d-42b59589fb5mr11542316f8f.56.1763394594733; 
 Mon, 17 Nov 2025 07:49:54 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f19664sm27500806f8f.36.2025.11.17.07.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:49:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2EB6F5F93E;
 Mon, 17 Nov 2025 15:49:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/18] tests: move test_netdev_ethtool to share.linaro.org
Date: Mon, 17 Nov 2025 15:49:37 +0000
Message-ID: <20251117154948.4122164-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org>
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org
Message-ID: <20251117115523.3993105-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/x86_64/test_netdev_ethtool.py b/tests/functional/x86_64/test_netdev_ethtool.py
index ee1a397bd24..ac8a92512cf 100755
--- a/tests/functional/x86_64/test_netdev_ethtool.py
+++ b/tests/functional/x86_64/test_netdev_ethtool.py
@@ -16,16 +16,10 @@ class NetDevEthtool(QemuSystemTest):
     # Runs in about 17s under KVM, 19s under TCG, 25s under GCOV
     timeout = 45
 
-    # Fetch assets from the netdev-ethtool subdir of my shared test
-    # images directory on fileserver.linaro.org.
-    ASSET_BASEURL = ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/'
-                     'download?path=%2Fnetdev-ethtool&files=')
-    ASSET_BZIMAGE = Asset(
-        ASSET_BASEURL + "bzImage",
-        "ed62ee06ea620b1035747f3f66a5e9fc5d3096b29f75562ada888b04cd1c4baf")
-    ASSET_ROOTFS = Asset(
-        ASSET_BASEURL + "rootfs.squashfs",
-        "8f0207e3c4d40832ae73c1a927e42ca30ccb1e71f047acb6ddb161ba422934e6")
+    ASSET_BZIMAGE = Asset("https://share.linaro.org/downloadFile?id=QD37GYYAJhGOgVe",
+                          "ed62ee06ea620b1035747f3f66a5e9fc5d3096b29f75562ada888b04cd1c4baf")
+    ASSET_ROOTFS = Asset("https://share.linaro.org/downloadFile?id=YAqnr0W8fruDh3f",
+                         "8f0207e3c4d40832ae73c1a927e42ca30ccb1e71f047acb6ddb161ba422934e6")
 
     def common_test_code(self, netdev, extra_args=None):
         self.set_machine('q35')
-- 
2.47.3


