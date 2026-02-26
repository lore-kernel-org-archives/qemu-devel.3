Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31013FD8FF5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 18:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvgUk-00006f-0Y; Thu, 26 Feb 2026 13:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvgU5-0008Cx-Fc
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:53:14 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvgU1-0003Wr-7s
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 13:53:11 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-65f980cea07so1849816a12.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 10:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772131988; x=1772736788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVtMJo46t96oZ1ya/vn5y1AlDQXHYekuQeJieX1c/BY=;
 b=UJLmzAui3/3zs+2OVP94JVaSfdHa0xvcRhbmDg+NgDd13SCAV84Oxb9Uym1FpPXK2p
 ILstSwjCD9DwxPfVu1ptpMa0euFgeJyX8GoxIdRH+aG7RnDxNZ7OyAf/v8SylVZyQNmG
 omvt4mTvE/NeQpb9DmWNImQNOYhkseGrFR8lAC7JW7hGb2Z3aFG/4pPVjb//EhDY9i3H
 BpxeEOKEdO6FMPkYMABOGvkaU/o/OfeaucTOhbtZSsxdqwZddO22cY5jcyyiJcObwgrz
 nM2hz+K//9DF+bptiSyyBbkgvHhK6nw3y0leri22YEAKkWTTaoL7iuf30f1qPSgPWC+r
 2cYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772131988; x=1772736788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gVtMJo46t96oZ1ya/vn5y1AlDQXHYekuQeJieX1c/BY=;
 b=mDK4BssVAcUKRLwyrpBGbh4XzZwJ7oYnt2bT88GvjDKx5yT89Lwgy7sDrBYRbFCisd
 UXANmMx9350dx4zy0VvVZY3atG1DrpfFawGKN472p0tbfq1A71od6a5nv9Bsi1M1Sa3U
 758MhvsviJ9JXFGz4nZz3Vuu0b0fhwfq6lX3hwxSWpIlB3F9NUWHPPyilRM1IsFtygTr
 XP0b5ofjvGK6SIKOb6rSLxqOVw6qVRtsN3gWdmtp3kXjRftpxVbpj/CEEqABIFLOKiFT
 qP+nmNpo6Dh8RCzMOiX/FdAMUFYWm/sshfrNxiigxdPhkMmfRbCL0B/EUCIQwiEhh9Ha
 TRDg==
X-Gm-Message-State: AOJu0YzSaSCXDdYVCMJTbuaKA7zBLUOgYZ/zwnA0CSBHsUZRMRWM98V7
 dCZ4JlUlbiEMeEt6dV4C3qbMYr3UU4XVeaFMreZR0TjYx1/dqW+fVwNFqHKMMSt3zlw=
X-Gm-Gg: ATEYQzytepFOGbp+zvTgi/jf27dOgL70rfDqTFktcgyTcOewmfqTiuyvoE6EyPLfYlT
 s1qZm366hZR/2w1Pxq8sOlHGsPJGJBfBPulNdPyYJJ20J/rpOiW6w2VS3qOD9kIiKbXakQn4NNc
 w4Ps/HuLp42vRuXrwVpQEZhwWo2hUVqsaZVMG8zNt8E1oOIao1yY3yP9C+7cjV9XW+5vp9KIQ+h
 oeLpOMNvY1ZEcdI8hqwGBv2o5EF/2B9hMAockDDks0GOitN6PL1di+LwzNGXVANc5ss30xJCZPG
 Oh7ebw+JyYB1yn6TqA38iuOP7gWY9T6pd0dELQF06IuqkIduldAzmxQs3U+mzc+VfcJFLR/Is/F
 Sk8lg2HVvd3c1o/mKUSEWS2FtCfbVeon79kQ76L5o/eI/HMeJbc3KWVAGdh5kZtusBCM9IlgZbW
 4SGQ+vxH79GAxR9w16qARS/As=
X-Received: by 2002:a17:907:86ab:b0:b88:5e4c:f842 with SMTP id
 a640c23a62f3a-b935b931214mr231810566b.47.1772131987515; 
 Thu, 26 Feb 2026 10:53:07 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935a597d02sm82378566b.0.2026.02.26.10.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 10:53:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CAA8C5F8D0;
 Thu, 26 Feb 2026 18:53:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 4/7] tests/vm: remove unused import
Date: Thu, 26 Feb 2026 18:52:59 +0000
Message-ID: <20260226185303.1920021-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226185303.1920021-1-alex.bennee@linaro.org>
References: <20260226185303.1920021-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260213154859.1551283-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/openbsd | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index d1289d78d24..9aabfeec963 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -14,7 +14,6 @@
 
 import os
 import sys
-import socket
 import subprocess
 import basevm
 
-- 
2.47.3


