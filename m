Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFF0CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPO05-0000Vz-HU; Tue, 19 May 2026 13:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPNzw-0000TV-Nd
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:12:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPNzv-0007Km-91
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:12:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso26805775e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779210770; x=1779815570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5aM9LUMM6/oOZYHLSdxAIyM2Jbu5rO9yNDEVgQNtoM=;
 b=kMFa3GnvNqRZRKsE8mBhMvAwD7IdTo8LirNXNriSnj6LBdZDsWR5+Q/e5BD4KMEv2L
 tJscCV/qBJGbYj1ozzTwqzsq66nLpdj4LdYjQEt757iLZ9fYsmY/6BKWcm3L13xto4nt
 iJQrpDyPpmPy1XQ+cy2HKf4WNrT9dQiBOu+Y/K4ZXEuuocxBlitbFzSpfhZ7xlQwzBkU
 9WWI3oJpBHCdWvqSbGGfnercwuYISKlFKNvM7PBG9Hd5m5HSluj15X3nmYNmSboUlMdx
 aMszpWwqPTnsGXd7/GceIh662/z6lD7o0YxNMJvSQUsCuEWOyV6ORKeHM4+HGMU+6g6j
 SV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779210770; x=1779815570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W5aM9LUMM6/oOZYHLSdxAIyM2Jbu5rO9yNDEVgQNtoM=;
 b=WE7Tv0DibMKKCiAdwdDalepWovoJkO4pAoB+EVrf2Ty0GwgJtnPfH2VdIJ/bu43aTR
 WSUtWeZbdlW/m7nvxECQUf+8VzrMw0bP1+OP4qLRxjlXBMuZ/d+OeVsp+HbPIQ8QRw+L
 WJXg4aiWHIzSwytiOXlCEekPqqAX20K+Gl/U+w6uM5TbACMvVNZW1QvPzK6BM+/tBz01
 cB77F/UUsTMkFy5GtKBErWFxFz5akYZpwgvGxfO7UlrHAgyRF4oyd/fyJTHs6SQQzEkv
 TNqE/IPNP4+x8udZluWS3wSZT7GpZpQ/h5DAziq8avtuG1Q41SWtzfOdgFMi5agTFpJt
 P3Hw==
X-Gm-Message-State: AOJu0Yx9a9+EmtI07QZSi3Rkd+iLIZ9jDYydUPMtgUWG9Qv2kBVwLy4c
 gXWpLhq2ozU5wG12Ik9JURgew022hfaFfQPJkXST4y6edoUgBR3lzcVGAxAgbKGFbaPSEgPxubj
 L1qhhi2A=
X-Gm-Gg: Acq92OFiFO9GWqAH+yl50mI9dz8lZNcxBCHOJHUARxFL4zO/ePqPFqfbCbAjDDR4SXB
 trrlHyUAwRp5CVAmx2aufWI5wuWezzXNOV38y3dqZOcKQqW0qu36cmh+gQIGdPWDxWpdthS/J6Y
 +eel0Qtebiu7f0+6JHhMTHBp3CNlkwz698NqKzMXsjCybbmoQV/RP5Ml0eno3t1OpcN8NrlrnNv
 yHzgdMwslxclAD55AbqOtiKWR3Bodm4FkCtokvPvuFuovkLD5gWSma87Xpb0aCuTNWxhe3cT2j4
 TpzatalCNEv+oryeGwFI9dJ0ifk8BHkvidOwTv5iG4xR5q7jjLf+RkvoO9v5LwobqoF8/zflV0x
 BV48KUlW/4jYLZFgZD4ciTVzIrNs30j4jWv3mc0Ymp72thURNmh2Z86oW66IyOCLdFfM1Hgf5JT
 ydMU0JVNlFgyXjmK6qJOH9Rix1PygKNCKN3VrewAZ5rEHpZCtLoSAUqdih3yfNz4FbUHRVouE9h
 ZC/WGTXYNE=
X-Received: by 2002:a05:600c:34d3:b0:48e:6db3:ff3a with SMTP id
 5b1f17b1804b1-48fe63270fdmr296649545e9.16.1779210769585; 
 Tue, 19 May 2026 10:12:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe1a41sm51055455f8f.31.2026.05.19.10.12.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 10:12:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
Subject: [PATCH v2 1/4] MAINTAINERS: Fix s390x storage key/attribute device
 paths
Date: Tue, 19 May 2026 19:12:37 +0200
Message-ID: <20260519171240.97420-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519171240.97420-1-philmd@linaro.org>
References: <20260519171240.97420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Fixes: 56e34834029 ("MAINTAINERS: split out s390x sections")
Reported-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eda1e84268a..7749fe7f9bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2975,7 +2975,7 @@ M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
-F: hw/s390x/storage-keys.h
+F: include/hw/s390x/storage-keys.h
 F: hw/s390x/s390-skeys*.c
 L: qemu-s390x@nongnu.org
 
@@ -2984,7 +2984,7 @@ M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
-F: hw/s390x/storage-attributes.h
+F: include/hw/s390x/storage-attributes.h
 F: hw/s390x/s390-stattrib*.c
 L: qemu-s390x@nongnu.org
 
-- 
2.53.0


