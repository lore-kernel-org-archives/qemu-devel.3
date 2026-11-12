Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87015606A32D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ndDMsU4T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRGN-0007o9-Ic; Thu, 12 Nov 2026 04:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRRGK-0007kZ-Ac
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:38:32 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRRGI-0003Vx-9w
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 04:38:32 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so2393193f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 01:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794476309; x=1795081109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dLndRGayGSp8KcIetuylw+yYhrnMD9MulBH+rS6Uu3Y=;
 b=ndDMsU4TsV+Q+PE7VsKeo5pjrw64kn0QTdfw5yHNIZXCJn2pENkU9xYvUedGRpmwjg
 xEqzuiaTRAg/UF2NNpGhlZztKm86yqRk65in/0ig0ZvSUS5FvgPY3HEubHf4olC8TGSS
 ZMnOrOifExwHAYyxuiL79pbCYaWzc+DTZ5FQ7PMTnMXz0j+5n3/TBDeGud8wD9qq347Z
 yNs8DRxP3J8vxVw+R3QvQjM6S9MBa94p9pys/pNeFe/W5z9GJPhrZWDAJ1BbbcR4TC4+
 VGARBpnN1GfE2XzbpguXKABJTPrEzdqHyySPRjRt80OeKVJ3M7ZV6sMIlDIkkapyjrie
 bVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794476309; x=1795081109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dLndRGayGSp8KcIetuylw+yYhrnMD9MulBH+rS6Uu3Y=;
 b=HfOxi6oTGrB34nQGKJMnTfJLbD7dIiB7rojpgkXu8lZcCydQNHza/w+4z8pcfLziY2
 GYg6QIEkfiikDy9GXPepHNhJTN/Hw6taF6rVKT7rzKCDRvwfsPNDKKr/MfDe6wUzFB/V
 c73dGINLtg3jxXRg7KnZK7K/35sJsPFlDyo7jOFejeirDDRqMoiGJCznBgYQiNaoHCaN
 IDvDpwiJbsJ6lqQgA3YCdwmzuUd7+gb1qapxGB9Ud6mOnUQUd7ODMdabYLi1WIwIYAlr
 P4Cswkb4++F8Rq4rHK1hZhyZumisOlc2CUJN2PBZSlGT6+9f5cULCF7NDm4r7eP+Z0B3
 yvXA==
X-Gm-Message-State: APuU4Z+PNs5TImqHki3zlGi0+ywQwEprdi1D6ZnVFJhj1jY/kyFKMFFZ
 /W4dNDHV0mVSIrUgOMjdqUQzYI1w0BmuSg4e8xmnIB/z5IzFRsmNfUiTpBwJCG2LrDlZJFgyBTm
 056BhsJ4=
X-Gm-Gg: AYBFou19Eon1CztYHg5BvU/5phv+sVqyQ6ZdAHg5ffavuqLVeZyNtnYZz2XZIjBpDwq
 d7pa/MYJ6RTwjzSv+NbdgahH/LbLTsV7ywxHW9YTwJGvDvf0cB6o5yup9EY2+YWhiejO5OawWsm
 ghqxlNxpYQ0ykeaaeOeowLDUXKTkisj92carArpGEvjHdlHhAcOaRO7TwGKjoelickoLMUHvLjZ
 nphKTD++dinw6IUs0V3fRiKCV4HZhEV0DCMXLzUW4BNpKXhAeK0ELYke8HiDesOgzDHNGsptczD
 C4dfFUWpRyQRgRt83HEaVz7IsWpiXY73IFAHmPo99W8xMy0xbt59YbYP+Uu4i0ELewJyQr6SO3a
 bJm7jwI3j5OsQUtYapdY8+cemOROT5VmxkyjLkm7KJcA/ZgucAvQZIReB0y7UdepiNNuAsy+iHT
 fPpI21tmJAZZq0UCUSaf+RtRrmnScsagEaFToiX5f9n2SupT5cqVHKvnW9VvG0ZiILaIOLXw0o9
 8cBhbY0o5h2/fd7WsGwgWwREUVMXPID4d9IofDs2x+l2QzrTD3qBJhgnI/njnEHe6Ym1KaqVMnG
 eT1YT3SFdCmyITErrjXKV2Kn5+opVucAs0kQPWucbuY1fr2r5lZB+zny7RJe5BnfZeUTfTX1T/j
 U/dqvj2IiiQQtS3bLVjoMJi1fxi5e0/EbHA==
X-Received: by 2002:a05:6000:4809:b0:492:8dd4:baf8 with SMTP id
 ffacd0b85a97d-499c38baf7cmr8415611f8f.6.1794476308813; 
 Thu, 12 Nov 2026 01:38:28 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983585923bsm16189279f8f.11.2026.11.12.01.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 01:38:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH for-11.2 2/2] docs/about/deprecated: Fix heading level for
 AF_ALG heading
Date: Thu, 12 Nov 2026 09:38:24 +0000
Message-ID: <20261112093824.2281467-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112093824.2281467-1-peter.maydell@linaro.org>
References: <20261112093824.2281467-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rST heading levels are marked by using different underline levels.
In commit 00e70abb8500a979 we added what was intended to be a new
section "Build features" with one sub-section "Crypto AF_ALG
backend", but because the same underline character is used in
both cases they ended up both as sections at the same level.
Fix the underline for the AF_ALG heading.

Fixes: 00e70abb8500a9 ("crypto: deprecate the AF_ALG crypto backend")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/about/deprecated.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 85491991383..22088e1023d 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -466,7 +466,7 @@ Build features
 --------------
 
 Crypto AF_ALG backend (since 11.2)
-----------------------------------
+''''''''''''''''''''''''''''''''''
 
 The use of the AF_ALG backend for cryptography has been deprecated
 with no replacement.
-- 
2.43.0


