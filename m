Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5E606A332
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OrDVLv9x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSuev-0003yd-CX; Mon, 16 Nov 2026 06:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSuef-0003wI-SG
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:45 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSuec-0002Dq-Uk
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:45 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so18071755e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827620; x=1795432420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZeIoUKJuIFtwvLGxQyj4VF/I9F4rg7HdJbidZ6Y8hPM=;
 b=OrDVLv9x0J3PUSJZV1cqjGr1TmGtOtYAVBqcuf02VnKf9tgWiSt7TPjRvsvLQUQXC0
 pDjTSZ4HOWsOrtMJJ/ZJoDkx/UcBUUmw06ILtkTZw/ePELc8NZOljxYi5n/j/O3aaV/2
 8Z8Ja5KPqjIUZNH9jgkZ2EO7T7Mi2L4bJ644xY+I7gqpWCRVIavVbslUG6Wi6V6iVQAg
 sBFIUGPeJOlDHf9ABIe661THhM5h8Qz1V3amj63T/UEoA2E+EmUFJEsb95LD9dPrqXnD
 +tEyoSuNWH1jzpP/rjsnoTkPhy6sp4BCjlfY73vFXp/q1Cj39/4p0KUFd/9isn6vJuMO
 fqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827620; x=1795432420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZeIoUKJuIFtwvLGxQyj4VF/I9F4rg7HdJbidZ6Y8hPM=;
 b=dh+HjS8VACDJTkkQdMIl78oBPp7KRO369ZiOLZDaxHHlt8ZJGnCqC/pK10T/6BzIEV
 koKpfQgMZysjDRsrAYXwkhPOhtWZhIYvtbgKQUoKa2wlIGo+dzmVK/8etVxnYq+TBD3A
 LxIWg46pZZqMwiDUDd091gEAnna+jh/d7qJev+GIJkKlE95hXQOpwy5FCM/Wnwj36skx
 S4Q3mnuImvB/2kVFlkD+jSCEvpwgYn+0eWKrgD8xZDLy1GNCaDP+6Q63avc7TuBduGqZ
 FkN6rz2TqV0adZkULUFrtklRyzZi2hVF63izblJSc9VaJnM3l1MuoXxI4MbyyPsKfaIY
 Yl6Q==
X-Gm-Message-State: APuU4Z9Tb6BtVpbBQ+/a4MEhUl4Uj1hz9g48ILiHlC/NglMDAjC5KsoU
 izyRIphZzDjGz8ri3zFFjlElNsgqa4JfrkXuZm0JsIM9nHAc8aqcPr478if7aVuDVkMx7FmY+OZ
 +hVH9vrs=
X-Gm-Gg: AYBFou3AtoqNOUTgmlLNd4Xrja3WgY+eJw1oYQeE13f6u8oPd2gZMSKAgHS/42WuucY
 rncU/ss29SqdzZX44flXgSkTEp7ADsxKZDylA7ogTTkR4OYotw9GgDT4J9aRoysNd7UX1zjINPS
 27rQgn2/LXcsepx/4QYT6GVVV0BkK3Pd5X2GD98C6q3wtNeyqLb03hrLBrPgZiv8+cfP8po4Uku
 9/85jWGTVIbVMrpR42un/uuBpoyfL0TQ/zKRm3mceAJWVn2jExs0dKVoqztkNec5fE1H47Hx7CZ
 YhUGx1AlByfSBGc8FfoPNnwPnXl+gFJCOpE4SOexr+GqvWnJ0bUHRK/Xgzgy7/n8aKNhGQwRwP5
 bNq2UVr68Loye9J2zk/SThkDAhnGl/X9RifZT4gr40NmgRPBn5y0dNvbZ0HN+M4ePT7BKLgpkhG
 51XRYluQRYKYOxfDlJ7XsWNhi/Q9uEAN3z5frN30rLNVnJQJ+Uo7nH5Lt7ZHEVuU06ivzoRmn5x
 DOOc3+D+O9ORobHTGW+CM2y79jaxgXnC6ViWPsXSuc7co+pIv8JMQdbrVJXxt7xbEGMx7X6JCe4
 57xBuhQoPexYb0BVByZofmPht9a4Jc6NQNvKRqLOb2wnfToA4mPI69dnYfwcwLbtah/jqrXs0Kk
 3vrNKVqrS1BZdu6/9dAXNHkzgKf99UUuKRw==
X-Received: by 2002:a05:600c:4e12:b0:4bb:69b2:d3b3 with SMTP id
 5b1f17b1804b1-4bb69b2da58mr99771245e9.27.1794827619754; 
 Mon, 16 Nov 2026 03:13:39 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/33] docs/about/deprecated: Fix heading level for AF_ALG
 heading
Date: Mon, 16 Nov 2026 11:13:01 +0000
Message-ID: <20261116111303.1692832-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-id: 20261112093824.2281467-3-peter.maydell@linaro.org
---
 docs/about/deprecated.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4188445ed45..3362dbf0acd 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -476,7 +476,7 @@ Build features
 --------------
 
 Crypto AF_ALG backend (since 11.2)
-----------------------------------
+''''''''''''''''''''''''''''''''''
 
 The use of the AF_ALG backend for cryptography has been deprecated
 with no replacement.
-- 
2.43.0


