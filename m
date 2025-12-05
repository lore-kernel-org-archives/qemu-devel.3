Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A35D33992
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYsC-0005VR-7d; Fri, 05 Dec 2025 11:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYs9-0005Ta-FQ
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:33 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYs7-0005jX-BF
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:33 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477b91680f8so23840035e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952889; x=1765557689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qsvjLCe/g9Yo2D35pZGCx/V3Z+8Rixor5u6C+WagsU=;
 b=SySn5IPC+W0qB1SYf+ZzvUoGjKHSsnt550Ug+Uj2AYFgOUIHt2e1gWzlyaQs0qWlLO
 hqZFGwpVuh7fcY+05XdlcgfmuHs7AVP5DNxrPq1Fn66dAgs3C4tsS0bn8b6sOydMejbs
 41VocN+FUqyvjYff/5S8396i069IGq7AaOLnnkkGDlpPxImbn8gh3Trvy14K2NvCaAex
 YFCYqJjlPRPH4pm2jZEvtK5BqoLLsSyRFxARcLSEkOCneeczMofTsSIhTBegHMcU71cU
 naGgwCSdhwVhfeRdb8ke8udC3F63GI+KNvk08BstC2RpUbZq3ItcJgAH+7R5OFvejKl/
 A6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952889; x=1765557689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2qsvjLCe/g9Yo2D35pZGCx/V3Z+8Rixor5u6C+WagsU=;
 b=dBTHui2spYKOu2CmTxyx0NMtaipY0LxJfgcL9bDccC1ZFGrB3ojycdv2T/D9liGEIL
 LnRzkniZuC1ughSjtjalrtplmu2h1uL1a6u53Q3TyhPMtI7+xw+eU3bV/izg08Zq5Sle
 LRMPlQUVqPyqap0akbYjIOB4ZE50dJkrRhg69iOSJCtMwsVcbPoU2iucu07Y0arLi4xr
 3R+i7IYJqi2MCeJKN+TkYGb5NffMBE7DDyAaZE4p5cGD9YgGo4Ye2/VOR78fh5l6cTf/
 kqwYoJ7HDI8CV7frH6as3f/pl3AYwqNnoaGdcU+tPHmrt9W6eZTBatlDGGWI+RCNKso4
 qBwg==
X-Gm-Message-State: AOJu0YyumndwLFwmOjp7i7Nh4x7v6UfOKxBdyLBPZecG7L2abFEa6al6
 6DAoSZaPCaXxcLk6UHBKeo5X7MW5/9FG6FWlJ0b9jQCaifN9aYi1et/sn6y1RbOuFaM=
X-Gm-Gg: ASbGnctz/mS0uRAdb6P7rkw7nk+iIb5izEq+YSmubxG7vZ6IAFcagDEGSWfW3KuFEUB
 N/XxwmfB89Z28EP9LNISyfBD0ldind4Ii4ytj22nGU8nlm9YvGzftqCVPg8T+bntahGXE4V7NCs
 kN2PkWOOjewyePbvT+4tZA6o/F3b0us0CJ/c1cXtMdA37fbpD2TAjU6VTB6SX/Z6yN/+rtWc8UA
 Tyt2Dsr9Nbbdb27i0984NqOkFEc6Ox9Yi7iMn6rfKthP1bn0scAC2eVBnkShPwESZ6ZNM8KIYnY
 6xpHs+9RsrulX0ygp743EU+uO3GZ1CZZXAk6okzQoQgR6rTdrU2OC0AMn9mtc9WHSr4DJDF+J4h
 mcVCubDccxXy+rPA3HQZMwiW3R/j5dY60y4PR4qIuGx3sYw6HS7ei4fuuVu3S7967Kfd+6kpgVp
 dDq3MxtGbkeOg=
X-Google-Smtp-Source: AGHT+IEdik9OGtDNcigr7ForZHzry/XnI+wj/yNeJ426Qof87JnzY3vZULwjyJ6EIPFlJgSoMYCy9w==
X-Received: by 2002:a05:600c:1384:b0:479:2a3c:f31a with SMTP id
 5b1f17b1804b1-4792aedfba4mr99339845e9.1.1764952889180; 
 Fri, 05 Dec 2025 08:41:29 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47933aef61fsm56161715e9.7.2025.12.05.08.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:41:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 40DA35F861;
 Fri, 05 Dec 2025 16:41:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/14] gitlab-ci.d/cirrus: Update the FreeBSD job to v14.3
Date: Fri,  5 Dec 2025 16:41:14 +0000
Message-ID: <20251205164125.2122504-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205164125.2122504-1-alex.bennee@linaro.org>
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

From: Michael Tokarev <mjt@tls.msk.ru>

The FreeBSD 14.2 job fails since the image disappeared
from the cloud.  We already bumped FreeBSD image to 14.3
in tests/vm in c8958b7eb4 (part of v10.1.0).

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251204205025.2423326-1-mjt@tls.msk.ru>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 13a0bf5bb9f..0d66a14186a 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -37,7 +37,7 @@ x64-freebsd-14-build:
     NAME: freebsd-14
     CIRRUS_VM_INSTANCE_TYPE: freebsd_instance
     CIRRUS_VM_IMAGE_SELECTOR: image_family
-    CIRRUS_VM_IMAGE_NAME: freebsd-14-2
+    CIRRUS_VM_IMAGE_NAME: freebsd-14-3
     CIRRUS_VM_CPUS: 8
     CIRRUS_VM_RAM: 8G
     UPDATE_COMMAND: pkg update; pkg upgrade -y
-- 
2.47.3


