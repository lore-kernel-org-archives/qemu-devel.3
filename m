Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFDCCD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 10:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYhmF-0002X7-CJ; Sun, 14 Jun 2026 06:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wYhm9-0002VI-Pk
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 06:09:11 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wYhm7-0005cG-7s
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 06:09:09 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45eeea039ebso1256510f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 03:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781431746; x=1782036546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sERDsKFrSOMR+YY8GENahrksk2j3CicdmJMSq7fCAVw=;
 b=ZnVe3iFZ7aiYL5GYAqXvS+3/EkMLtEXfPZhVX96vfGifyVI6sBEudkQIVc4awt7oaP
 ixeIT8cSMRT51/G5bsxoSvQtmuYRPNILRwJxnyr9BHXVLGx8Df2MGr8EPHWX7nL/EW8w
 FMz9rBe+LO9fgcZG6M1tWjuwFiwQNe5GyZEZysHE7EU+xqzT4yMclOIeq4idfJ12+Qry
 r17tW4QEM/VGxiGc4m/PGuc5Dv0X6WQksuNZJz4RnaCqyoRbifVzkhVG0whXHLDemjWV
 kILXN6f9v83bWuIgeWR3rsxdJb7zg+MJFWuRBfoBaPgi4IrpulksiEuN3neRo7Fk7Pw4
 Y0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781431746; x=1782036546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sERDsKFrSOMR+YY8GENahrksk2j3CicdmJMSq7fCAVw=;
 b=qaLT3hVQjTHZmEiCxCdxIDCkRBuNYaVIipYz6cvMQ/96r9LxP35h3A7bZS5LWiCFAw
 RIdQYH5zv6m0sEf1JGcXkGAgzRVFV4foHpjfPHHrXN8ob0ROIdiq20zczJJpcxXKSdNI
 MZZRZW0S9gNsGhvmZkPKdKrhlEeGDMGJjzYqobf17ue0REjOGpYxdmNY3z58a+8VgONf
 WwyZVGI/GRE762S3ZfwGQBpO2erWBnvg0VdCXG/IAufxMxbQUATBPHXlD0C9+zMg0ElF
 aonfgSZfCru4uqwCqO9s0owYmaNfhJtCermnmMED8KpYjCu8oandE5mvK1Evspv8cOHj
 T+pQ==
X-Gm-Message-State: AOJu0YyU7CMMbRzjQSlNZ6Or+bEQVyIrSI23EUo237ypG21AWEM5nvEr
 kMSpdZxtNipihqbM60hjKVJvUtJ0W3Mmhb4WNHUDyNvmT4pXRJqTbtH3VGz0YNXxZmM=
X-Gm-Gg: Acq92OG0z0+iGKrofLNmshNkh4jfsVohmFUBye1vxS60V/W1I0qQLbyV1OSZMBg3V06
 0OiFdVkSrks6gAB1nTPcjjY1jASG6gt4BhsDfW2w6oRShhAFTZ7v7IjbVX0Mn0uZMBl3w4kIDGE
 xUpkv1nGE6jGTRPR5Dbvh1nCsE4RgTWFjUNfbGNB5rQnXIBXZkW45jtCLhqT/iVsFS+gM8NIrqL
 k4AuSUEDx4sv38Zx6BAixkciRzRCdCq8Xk7l4a7T/5dzvcbJTATvf+iQknK+WJ4okfuWW71xeAn
 fMSCo+VCfD2pz/p/NOg8+iNzhyIOtxRHLdf6pX57+P+TrOXo3MNxlb0frtKrPcu7kp0t6KbcnUC
 18+tb0xYGSGDHY57hDUFmgQC/5+20aX6bZq9nr4F9mT4ZHrr077u7aYz92UC21nji5Z7pv5GCVm
 iWNIfGLulRKGRoOixPDAWER00=
X-Received: by 2002:a05:6000:2584:b0:460:1967:abed with SMTP id
 ffacd0b85a97d-4607eaf7cfemr6589812f8f.39.1781431745210; 
 Sun, 14 Jun 2026 03:09:05 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d933esm22055593f8f.33.2026.06.14.03.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 03:09:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 06DC95FA2F;
 Sun, 14 Jun 2026 11:09:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/4] python/qemu: split console from harness args
Date: Sun, 14 Jun 2026 11:09:00 +0100
Message-ID: <20260614100902.885698-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260614100902.885698-1-alex.bennee@linaro.org>
References: <20260614100902.885698-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Before we mess with the console output lets create a new helper just
for that.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 python/qemu/machine/machine.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index e8973a87394..18ee5ec0147 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -306,7 +306,11 @@ def _harness_args(self) -> List[str]:
                 moncdev = f"socket,id=mon,path={self._monitor_address}"
             args.extend(['-chardev', moncdev, '-mon',
                          'chardev=mon,mode=control'])
+        return args
 
+    @property
+    def _console_args(self) -> List[str]:
+        args: List[str] = []
         for _ in range(self._console_index):
             args.extend(['-serial', 'null'])
         if self._console_set:
@@ -372,6 +376,7 @@ def _pre_launch(self) -> None:
             self._wrapper,
             [self._binary],
             self._harness_args,
+            self._console_args,
             self._base_args,
             self._args
         ))
-- 
2.47.3


