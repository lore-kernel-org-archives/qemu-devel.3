Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA06CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPOGy-0007vh-P3; Tue, 19 May 2026 13:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPOGx-0007vS-5u
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:30:27 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPOGv-0003e6-EN
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:30:26 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48e82c23840so31674505e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779211824; x=1779816624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxRYnsIA10GXvb5Tkj1WKvjbYAGzHQ2fK6fA9ThVOHY=;
 b=wMhVxAsXs8r9Ykin3bkujexbtJXhJEruQ75F6wQiyYm2g2eR83ymA3y4Ax4HHSjeP9
 nE+CFtHvpalxRXMJoySzW0qWoubVTuSrOaE0A7+6SWXNotrsOBxvXzlUC4tz7NVjiMHo
 EzTX7pYxkL7nLH4tEKqTxXHI33iv69D7fjHckPASVqT7Jtor9LJk03N3juUsnPliXtrC
 qjmCMzbeDyud0EwOAgQEy5Ux9tqSX/pxMWvtuvjysvbhQ3eXoW35GtMMsuh87YX5hc6w
 IFcIDKvFJvshn6qEbV75S45VR+oB0cGzjf8BrY0JPsdxOYaql9NcG/TDH3r2qO4knslM
 z2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779211824; x=1779816624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zxRYnsIA10GXvb5Tkj1WKvjbYAGzHQ2fK6fA9ThVOHY=;
 b=TCS9yB6+bnBsydZHKH3jR7nVSTLKqifwM87m+ZLx7nME5Td8vzOig66TKG3+Vditej
 nb51SwoLXZOcfoTtJ7DC8mvo4RRvEhQTW+C0f+G9ikgEWCt7x0dVVOn6b3S9PdBMcCFE
 L/fF9c3EmWLJd7AYid8zK6+5Hyk+XV8SdghA+/uA/yB+xwTkpfBFPfYR76kBQUtmG44n
 YJGMKAlTC+zmv7MKMIjHEKB5kXc/txzsH6hmKh9GZ+AkXr/lhY7k24eAZRtDh1/MNA2d
 uRQX2J9QHMnOljCWxHAxkaM7CYD/0+alTB46iaw8fgXt8FGkc5No/hR2DEDavFJvfH8g
 wuOA==
X-Gm-Message-State: AOJu0YwXX5VxGinGpwU9adZoh4zM66Nyhajjnru3QK4D0vWZ6Rrk8Nwl
 ZN2/lmtoDdJN/4NasQOvKDApHUHjD0LqWJXAyAv5tQRe5gShLaGlK1FjacJvcbr34gPfAqB3yoo
 JwQD+kD4=
X-Gm-Gg: Acq92OFsaEizGvsdY6kMTYTvACNILHQ7y/vfWJdP0JFRvKcOXEszFWbTWm0SdNa60e9
 YltX3LbzjrpG+G70vmTybrOrT7nipWAP+dOxDjwoRAqst7QsHWEvA4Mj9HL0nNa5cv1p9ro3dIR
 NNPrcxyw54TPzFbRHej9j0wpebu0TWZQNbqsy+UUwUdBUe1lLtNYWYqPkb0Hxljx7AXVl92t1sp
 /L3HD4nJNWxcJeFv8gB6fj/O/Jo+XDjqQwmEdrdwzGcMt1WKLP6lNstsvkILIanTlSc1Sd3Pttt
 YTCfn5C6FHHG+VeIsSsIlfdIhk+othV/UqSKrCO18WLvtRGPB6loMiofHAHsikzxsafLjAXfOY/
 lkXYzo3b+sqesqD6ZVA2Eu3JX7am15MDMkC7/+giPIlFy4rFGDb16LTldG+uewF3V91Q/fzH2tf
 NQM6ST6nItvPzCs+jZeLDDwShLLn1zUyZ7n0gE/OPnWkVaAjQQjUkEHmbEjW8a+wQ6Uy+vy/N0
X-Received: by 2002:a05:600c:1384:b0:490:2238:4021 with SMTP id
 5b1f17b1804b1-4902238403fmr38396765e9.8.1779211823611; 
 Tue, 19 May 2026 10:30:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fffb9aac4sm417549755e9.9.2026.05.19.10.30.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 10:30:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 1/2] MAINTAINERS: Transfer FW schema specs section to Daniel
Date: Tue, 19 May 2026 19:30:13 +0200
Message-ID: <20260519173014.98967-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519173014.98967-1-philmd@linaro.org>
References: <20260519173014.98967-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Pass the torch to Daniel, but demote the 'Firmware schema
specifications' section from 'Maintained' to 'Odd fixes'.

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 85651cf2a18..0ba6391dea6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4004,10 +4004,9 @@ F: docs/specs/fsi.rst
 F: tests/qtest/aspeed_fsi-test.c
 
 Firmware schema specifications
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
-R: Daniel P. Berrange <berrange@redhat.com>
+M: Daniel P. Berrange <berrange@redhat.com>
 R: Kashyap Chamarthy <kchamart@redhat.com>
-S: Maintained
+S: Odd fixes
 F: docs/interop/firmware.json
 
 EDK2 Firmware
-- 
2.53.0


