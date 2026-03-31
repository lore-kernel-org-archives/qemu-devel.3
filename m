Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20176FF60D5
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7T92-0005gP-QC; Tue, 31 Mar 2026 03:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w7T90-0005g0-HS
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:04:10 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w7T8y-0001vf-SI
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:04:10 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso988128366b.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 00:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774940646; x=1775545446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=swZ9kvTOQS5+lqtfG4wKPcOV4ahQS21L1+AOD+wWETI=;
 b=mMYjw1ejwfTuqdzCnU/SZb3jx5KApWHjm30h7MFzOrEOMflGIYuk6QW9+Hwf6MzL2C
 z+O95ADSqgwnvShDDdLCFedqXxzgzHBk2IkyxkUjQ2FTrQuSgjspwAAlZJOzbz8b5dju
 zkPQ0vJxmkuSverPDW7ARw9iI3gcMw95BqGMVcXukiQPjIac5eVaG71tH0/tHezd3v2T
 NEXHaQBEh7GJOMxVVDefuWgnWVD432NthHf6/91I1+k/Gvg5XhoN/Lho/jq3YP4MSGWF
 vZNfYyvoSNESzkw2T9kIZmk0+MddjeE/9cbO01NCtwXO+k9khD7mJ/H7WYU9Jc18t+7U
 DwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774940646; x=1775545446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=swZ9kvTOQS5+lqtfG4wKPcOV4ahQS21L1+AOD+wWETI=;
 b=rXOHsOe2KSjbTdYuESY16BKatbLXErqvqEjFtp1Uv5LPFJBpNo8FXTYyM118Hik48t
 2TT+uOR2sXgdfVqq6o9Qh5m0UVkOzlwv90aW1nD7b8QwnjjOjqlr2d9hPVkxuFEIp9sJ
 PL/QtYRGUwWH+KNFFSzqHWAvO6xMsKQd3zQpGCOiW+qPTsKb7Dlxjvv6aGCMaNiw6IB7
 qSaflWfQKcPVK8lpOkkRLQKA4TEn5RXhoYowQL/wdsLe4bJ0pL6ETcPgvIY+xcFCrYVL
 baKwLigAqzeJq6WUBDeW2lCVARjAR9Lk8RGsNxOU9mjlPqsUqMYJzv8oqX8E7G5SjsHw
 lNtw==
X-Gm-Message-State: AOJu0Yw4xVyHe3Pv5gnFk+oYoB+GGpW9ziOKBLofngRgtjHx2R7JLkvy
 1TCpOSgCXGITslH3DcbnkzCwt/2w/Ss0lllqC1cj7UnztFNPIIPyc6I6Hp0cyPKg9MNEtzUzWyU
 NnhAguDw=
X-Gm-Gg: ATEYQzxS+YgNnDhR4+Zie0488mmUKpUMSHQdQHaDsblmAZL9w53kC25jPj4kdvS04rQ
 XBoP30txm3FzyDBGvqrJvM2aDrBrIWPWv50OvbxA1jhzpEOqB28Rb5nXl0G0v6Ih9RBJTLDiHeK
 F5v2siFvR1WHqp+Jj1HlOAuI8l2hM8ojPdMue+6aEA5Y4X2uNrDIBdd7ebNOuCjUkrZ7G+5CI5B
 XEv/W/Cf72ynFeHqRneeMtmzOacqwzN0cQctzHO+motyEgLPCsymGXHwpbkw1CYjdlk5NXL2mNG
 RtwybSb2t7tqvImroy/w5+dZV09Lf8sp/RlLP8m4SyOOnbHJd27ZoLTJcsJVTjQuFkGU2p74M8w
 oFuEB6p+g0Rrk/D12HZYz968YgTMa89bf5vFMenLFjHb0+5fB/gYXY/k6t+TQKI4/TINDYq5hSw
 onFKhy38eC1CSiqyqE89sF/9G6vLIlBmlBfA==
X-Received: by 2002:a17:907:ca85:b0:b88:58e5:86ff with SMTP id
 a640c23a62f3a-b9be7e7bf36mr148679666b.0.1774940646141; 
 Tue, 31 Mar 2026 00:04:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b1e472dsm374539666b.50.2026.03.31.00.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 00:04:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C36815F803;
 Tue, 31 Mar 2026 08:04:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] MAINTAINERS: fix OSUOSL typo
Date: Tue, 31 Mar 2026 08:04:01 +0100
Message-ID: <20260331070401.1125840-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

It stands for Oregon State University Open Source Lab.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd8ba144506..84ea3f2469f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4526,7 +4526,7 @@ R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: tests/tcg/Makefile.target
 
-GitLab custom runners (HW sponsored by Linaro, OSOUL and IBM)
+GitLab custom runners (HW sponsored by Linaro, OSUOSL and IBM)
 M: Alex Bennée <alex.bennee@linaro.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
-- 
2.47.3


