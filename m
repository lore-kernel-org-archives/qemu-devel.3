Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06304606A333
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NmwgllAt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUzU-0008Of-VH; Fri, 20 Nov 2026 15:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUzH-0008Nl-3a
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:13:36 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUzF-0003rU-Ia
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:13:34 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4bb64c99d2fso13874685e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205612; x=1795810412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6B6MosqdBYMqMo0NdkfmSRTBc2dK32MFhV5BDQjJhfE=;
 b=NmwgllAtYkvZQtI3Yu5DTKCpXctPI2cmGUOrCx2Be8gZ+Pmi516E/gjLUsL18mVWym
 MVZST26htz5cGMiDarzI9KmNL/67hHmBE5dBikHj3l34cDxOdT2p5T+POsYje7PN6hKV
 TPjrnR9zvQ/1Hsvi6LMMIkbcYTvzsBtPsMh5ldR32qOr+xBKSJf0LxjLl9+Ljukwf8dw
 5UqnWopbbwSgr38iVQ1Z4BZMkW0UaNaYy2iNTJ6GQ4KdMJ6Cc7vmIUI6v6LB7f4mq/fz
 CZGwNR2RANJiWLMeq4/7b+4UdlrssS38Kf/QDTlaU2BRGP9tVOIzVvSPurqwRyL6rf+P
 bBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205612; x=1795810412;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6B6MosqdBYMqMo0NdkfmSRTBc2dK32MFhV5BDQjJhfE=;
 b=09lyruCk/ZUaXiR0DW0UX9S+hkEf6+sUNvCOGM/p3AZW9IneM7+8wTgRtyueU2n8X3
 OOuWaQ8Oz6hFk4c5uRb+9it4tMPcWjdbsZYSiCPH6UQRVybJxOvsHA+U7T8R6c6ia3SH
 1RH3sMfoYs+XY7rlnFR1awNH7IKr6Yz7Y2L4Nje1jojBnj9WV981UvDQo+zEgxwtygnE
 7IIkF1DFSJ6ML2DIK62s+zuMQO7yHWQpAmZn0ixjkYlkSiv7j+oGD53GaidaMRHyJ6CO
 LQdVZNFsiMxC/L0PgOtXb8R8Cee96v+uTk4j0dUQwsaBFnSHS2YT9Qv717pumsiH6cTS
 We6A==
X-Gm-Message-State: APuU4Z//MKMirInigvwJWfgeRBfOR7KsHZzu0XWE+U7UCYG98JzZeeSp
 MPszUVJFdq1VyXOe97ira/OxSvSgjxWKJhPpUC2hz78PLucgHPAkDoZX44AJcXqcuHQ=
X-Gm-Gg: AYBFou3dD5J1cqkZE3SZvLkDpOnfkA+FhQ+NVAW3BBPUmIV/chv1ipQCpe/Hwzu010+
 QByumRZYw37EdFU79mHND7894iuEAh/4Ikp/Pkdputiu9lLevnfwieg6KgPro//3Sb3vQEUzU/Y
 JsazOWebiha4Fu06SmqLZLqMvnPHkVVmdW67W1H0gKjMYOFhncQtgZJloMtp9O8XiTwkOxtVPP/
 qpHFDni7QH6Vrgkt9H73jzBsf1xqz2mrH5yLQMJEO7KTRC80VMbISma8WO3ehBtYN8SyPi9cATb
 MXceBS+Kgdyid9y9qZfTeWndzCXcorTHCQjXvIb/ZAOsmfHFKsYU0Nxt1LAMK6qkB9nS/THwHOc
 jjXq0lEMlDlhFdVFl6CyWnFU5V5utbyLKv2nt1zt/gWvnuWYg7h+qauj61GCiG+V89EJ/2H7mjM
 WZMj+BRr7PoXgw44n7h2GLqirsnNkSA0r1Yg+PTLW2to36A6G/yZTVzpLJnDY7fIkdX0Ww5Haid
 lVhXGZo1ai0oQqWnizhGZmDMWJYuzkVqyOnaG/2A796xMB13GorPLPyQg3SoS2evw1EfU5BYOMn
 uLeSn2DBU/nX9PJJzNF/djHPiB0J
X-Received: by 2002:a05:600c:1c21:b0:4bb:52bd:a3c7 with SMTP id
 5b1f17b1804b1-4bb88804d41mr114084625e9.6.1795205611951; 
 Fri, 20 Nov 2026 12:13:31 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm155703035e9.13.2026.11.20.12.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:13:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 967E55FCC6;
 Fri, 20 Nov 2026 20:05:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 22/22] MAINTAINERS: update security reporting links
Date: Fri, 20 Nov 2026 20:05:10 +0000
Message-ID: <20261120200511.822573-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

We've updated the online pages but we should make sure MAINTAINERS
doesn't point people to the wrong place.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 456d835ce70..c10cb0f2a0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -82,9 +82,7 @@ F: docs/glossary.rst
 
 Responsible Disclosure, Reporting Security Issues
 -------------------------------------------------
-W: https://wiki.qemu.org/SecurityProcess
-M: Michael S. Tsirkin <mst@redhat.com>
-L: qemu-security@nongnu.org
+W: https://www.qemu.org/contribute/security-process/
 
 Trivial patches
 ---------------
-- 
2.47.3


