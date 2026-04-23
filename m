Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CA8F99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqua-0007XO-Rz; Thu, 23 Apr 2026 06:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu8-0006ZQ-Ac
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:34 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu6-0002O6-Ad
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:27 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso3901626f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938605; x=1777543405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GCkO0pein/QuTqyD8EbkjZLuu3mM6IzpBO9la+bzpC0=;
 b=swCJFx/j/nzcmzlhdAJ9C8n8LIm41tQb5awp8bwhzBaFPg2qJcgzGUWAZTxGXScUY3
 eOdDe/pqTqp3Me1nswXmdoj3uxxm5T4rUR8EZjGF94LOuQLJ92QgoOEx+efwq/tWs4+J
 pJ5HhJpCcVFK9D0noEN8epyYJq2bIyx5A/M4RUQN124jx97ZhHKuZCMoZRDZ06tY/rWv
 fhI81FEvCBQE8f3a0JmKzRHv1NmnuCbHRSn76HpTC794/H0kKVU7zzf+UuP1+nfrXPAJ
 8rkFOTGcNf7hNC3eQWcpnrlEVUpwDCGIvJz5NcHshobZu9kIuXi7/IYJSWPDYQX3EfgB
 9J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938605; x=1777543405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GCkO0pein/QuTqyD8EbkjZLuu3mM6IzpBO9la+bzpC0=;
 b=W4xJ8rafZGf1J/vcbO2+Bzv4BsoaFqyKi6FFwJ4OU+PWBRk+8bGR6wEjpxvUN/IHU2
 2PHFjfzT65u6o0t3KSRPS43FWKubNekaBGoVgXeDIQ9B0dN1eG+W0b3fvRo6pCBvdCL/
 sPtCSHSnufq6rfqQSvQoExBFVPgxE/wiTkUXcM+SgZzBGy43nbsJ7vXuMBKmqZ7iVeRF
 F5NdaLi607uxQvXxpP1GWmdAgefRnAaVeZu0UtePpsVzUwYpbASi/pLDuIkgXGi6RtTn
 UO9+PBUrO5kbQqJCYX0K+59FiBblEnxP3v+2OYTUQ1Ro5NSOaT9dZo7/+UGZAFl+sE6r
 XGUQ==
X-Gm-Message-State: AOJu0YzY6Kug0oabahuFyscOB+nRE15yPfIZ2ZBYfk92v0GLamSdv6bB
 o4fEID4LYHWkWZTqkFm6G3AxaTKGiHALogmGHtZA1Rf8HXAQCIhPDRRMSeWEeKRlvP05y7Xh9Eb
 RgDR5
X-Gm-Gg: AeBDievIYyCa9y1g1kt+pQde4xYpX3tTMJfWmpEf1IZCFUQC47AhY9iyhlY8Eh+u3QG
 R50qZF4KqglxkIlhS346xMhzE9rc4/w30g7DhfMwnCBpK0HHR/KX2BngAWoeoPvJyjNM425iXSl
 c/PEbX5hS7uO8wWMWSRem6Lr2DZU2C9YIo5CWYeqM2Tswb+pswVzJztcZPam3yINxqgBnD031uL
 ZzJAcmvTQcVRCHqYmLNoDI/hLBAxJjoIPXsoDtAqr9qjOqeDYlVei/45n89Ye3QDnAtKGwZBZLD
 hoeSQJozbRrbA/now+cH5VHmzWkgI3131GIbkC2bo4AAT2W0lxkv7lBSWKUe37xVrBRTNB1xCCj
 teTbXw4Y5K9aXHM7dTm0yZJtVDWPl7LszNpwonMcp258QzPNXsxbetErQO0wbFnJqd7Yjjuep8Q
 WHFHGJOTGdRNc4z3F1J1cL2TXcpQiNTfiUzki1u7Xo8ryG69Dq6qm3A81lRKNoFE3gzGeEYTOY5
 2W8RwwlRZpWX9ya4+Dkutbv5eG8CirgNypWWkiGjA==
X-Received: by 2002:a5d:64e7:0:b0:43d:77e1:6a67 with SMTP id
 ffacd0b85a97d-43fe3da648dmr40618744f8f.5.1776938604688; 
 Thu, 23 Apr 2026 03:03:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/59] MAINTAINERS: Remove Qiuhao Li
Date: Thu, 23 Apr 2026 11:02:19 +0100
Message-ID: <20260423100229.2941820-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Qiuhao Li has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-19-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c58200cf37..abe7b5f920 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3607,7 +3607,6 @@ R: Paolo Bonzini <pbonzini@redhat.com>
 R: Stefan Hajnoczi <stefanha@redhat.com>
 R: Fabiano Rosas <farosas@suse.de>
 R: Darren Kenny <darren.kenny@oracle.com> 
-R: Qiuhao Li <Qiuhao.Li@outlook.com>
 S: Maintained
 F: tests/qtest/fuzz/
 F: tests/qtest/fuzz-*test.c
-- 
2.43.0


