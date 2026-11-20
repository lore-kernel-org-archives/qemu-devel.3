Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F408606A699
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jWU0Ttb/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUXSK-0000Wo-8D; Fri, 20 Nov 2026 17:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUXSI-0000Vx-Eq
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:51:42 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUXSG-00051n-Of
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:51:42 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2f04244c3d0so11631645ad.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 14:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795215099; x=1795819899; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6nXkv/2Fugvc5SpQYCH1lmgKJdDzhcmT+YAghdfPQK4=;
 b=jWU0Ttb/TZ+ZSFEZrfqS+8YW7DiWkT10DjYzZo2Ai5iihUEqMch/bUZ2OmMBLTJXZL
 /MfmKwiRUCKD/GkCcbup85jOpUYGRKlh67wJdk85VbF1LEMcadgr7PbomEQW7PHBNrKQ
 43nCur52OpuUFVMqR5NOwPXyE2ZeWOUDJkx/A0wkXKJVUp4B4JCTjV4OOVdoEapBhzgQ
 tLIZigH1ZIqBgod8X9E4R6D4Uw4ENac6UUpEAJlQbLPODXJkMBVA9jjqUTL/QXfIXG3c
 5escyokYVwCyhgye6/LVg3uISfuXQuxt7SFELeYr/aH5iGBl16jB4oLQ9Y2+LCusKcEo
 gxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795215099; x=1795819899;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6nXkv/2Fugvc5SpQYCH1lmgKJdDzhcmT+YAghdfPQK4=;
 b=W9Yx2U0uXNAEyp0iD6UfQIRFwEeIHBnAWKAbw2NmZ0LhLm2vz3V6V5BTUcm92USbDv
 0yGINVhYp/YWEIEEJBQOrDUWL73JQkiYqIntxGU0UQjwDOcpEVfdSev8RKswV5CPMhu3
 XSCMAqzuOpaw4gxg5w7bU/QeTk+Zv6Eh84hbnCWLwYA54xKJxFk+MWNYRJn9bcENSWr+
 kGZGxL4ctttZh29OCIXgGNnKUwJCfeGdU+t5UkAvHC3oO1kI+zws7wC97n5NG/WfVWft
 lsRzQJveTHiPxT5X+PumdhRGX6YBt8dv84zZMu8hPaD8hJldzuUNPbRNSqUgCvCnSdt8
 1gFg==
X-Gm-Message-State: APuU4Z/wizhCFth+TlNLUxZDK4WUizEF9PaXDDMZ/zs4UPv+DbukftWv
 A3JEimJal1rbiSmFC6cSJDcgJ0m2gPf7xFWxC2TiuArfg7h22BYN6Ic93czowX1JELQt/IHBpC3
 LTGfK
X-Gm-Gg: AZFdTZdYIG2F3KV8+xjothSUBZBYM8tnmN0K61c2fZJ8YmGWwNO9SW4ZYmgNoYoDE4k
 NJj2I7H2DlYCmHt/0yD4TYbFY9CkZElAuvgSH5MKDpUuSlhQK6Y7g62OKcH77ivDUb9xhRQgf+U
 t9oN2W5JH+Ayt58m1/OrWliVIjlLlBbVZCPTQQfGxQQ7o8dEZbBJrSJaY3vEj/6I/d62JLIP94A
 5GLPWQ+/KmXRUH37GWJmWSyXLvGvp5BDmin6kBxAQmBLBmVetFsiQm5eNN7yhcz8y8erhv5xdWi
 CNC+5MlbJdwx+hoA9WhS9ms2Bc1PS9+JfbflFHE7cAHRJ76i3W3E8rWwV9Wu8/rSzA08C3lpMCF
 yvZt207YvnVdy/kZHEbZLyDNd09Cxt3eQI8xCVWqrFo1U+nN0WSTL/HVNVHyRN+yx4hZ6y6LALG
 5/fsiONm7XBUDbHHHfB1VxIdP6PkcbCDR/dWR/HGy6DYE7B3QmUv6Wo29I/D8vfr1g2wOx2tsKe
 AqOV/HJcO5dvC30xiQicJ5bojMo8KCrSgV4aQvfh50OKC4QVPUQCWfwauUGDOxrCCsFWM9Y/zlw
 /kjZIkDHaJ2c7kF9sAyagyZ0dMCXiAL8DCTpIaBflxlpOacwRjC4o1d6CUzB
X-Received: by 2002:a17:903:41cc:b0:2e9:60fb:5e2b with SMTP id
 d9443c01a7336-2f03f16bd1bmr41713385ad.44.1795215098978; 
 Fri, 20 Nov 2026 14:51:38 -0800 (PST)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f0433a3a43sm15669055ad.62.2026.11.20.14.51.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:51:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] tcg patch queue 20261120
Date: Fri, 20 Nov 2026 14:51:33 -0800
Message-ID: <20261120225138.7198-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 08c9bbb825148dec9669f5184ecf18823bb6d631:

  Update version for v11.2.0-rc1 release (2026-11-18 12:57:24 -0800)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20261120

for you to fetch changes up to 3b89d474910fe8a8e70d83639f5bd26de37ccb77:

  docs/tcg-ops: Rename cpu_env to tcg_env (2026-11-19 11:56:49 -0800)

----------------------------------------------------------------
docs/tcg-ops: Rename cpu_env to tcg_env
accel/tcg: Fix jump cache flush after large page flush
host/include/loongarch64: Fix build with 128-bit LL/SC enabled

----------------------------------------------------------------
Chinmay Rath (1):
      docs/tcg-ops: Rename cpu_env to tcg_env

Richard Henderson (3):
      accel/tcg: Drop DEBUG_TLB_LOG_GATE
      accel/tcg: Adjust tlb assertions to allow stopped cpus
      accel/tcg: Fix jump cache flush after large page flush

WANG Xuerui (1):
      host/include/loongarch64: Fix build with 128-bit LL/SC enabled

 accel/tcg/cputlb.c                                 | 119 +++++++--------------
 docs/devel/tcg-ops.rst                             |   4 +-
 .../loongarch64/host/store-insert-al16.h.inc       |  12 ---
 3 files changed, 42 insertions(+), 93 deletions(-)
 delete mode 100644 host/include/loongarch64/host/store-insert-al16.h.inc

