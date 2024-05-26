Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199C0C25B7C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJfx-00082X-3o; Sun, 26 May 2024 15:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfr-00080K-Vm
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:55 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfn-0006V3-Vj
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:55 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2bf62b121ccso1451603a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752209; x=1717357009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/u6sVUfyOTZY6L4bCBYpJrwQfNL8kIsz360ipvIMKM=;
 b=zZjFCWuB71t9jbhZISRVDI/kdqCKocNovf5H87uuftsoz+hWAZOKJg8bKqDtvgCsPk
 /4o+tVP6Bt3y99oely+TNOn7gblkY4DS2QLgjJ0SOlDBAbCCpLuXUk15C+Z30OtFhOkX
 xBU9eHS6RcGKXGm9EaG1w/0OPV9aRlI6UPF5eu6UAJZCryh4wE2Ge0MRGRuhR1ucB5km
 OkVASB1Ajd6GMcC22ImG+HUmDcO+MJX/JOwAMSc3HaADu7Xxkd4yHKZvappUhFc92OBQ
 BzCmpqUauVRQN3bBKeIi6kR7IpgbObMP06F7IT/T78oj++K0UwoCMZpJ7hU6nh8F17um
 7dXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752209; x=1717357009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/u6sVUfyOTZY6L4bCBYpJrwQfNL8kIsz360ipvIMKM=;
 b=s0iVWrlBYFNgR6zxZr5Uh+GEUqQaCTdX4NBJ6bQKTA0Ibdpszd2SRoclJOlRT9cY3n
 R/jWz5eNg1f5Lwy1THzSIBgh6yh99jC3/hWUbm6wjbzPap1iF8ATmwR5esux+1khR5UY
 Y70fINgfGtyhYB83y5dBNgc+5ad5MgWSxd3xqStfGYWW6b1JEZx7JhdGcDG4RcE3q8pC
 QK2hqVpy+29XmhkHfl7n0TsmdBXzJQlr3BtsQLl76B4FvgBWLYTPYuDxc3xHS4x4QL6Q
 CMiZ2kj05Vfo3X/5MfktssFKB3v51B2eXTS1w6v4e6LPDbwUwWl8gU4dHfIu90IxYK5E
 n5fw==
X-Gm-Message-State: AOJu0Yz2dExUQpELIBrwV2pSZHjZ5Y6BcnwWJ2fx9HpSS2cqaAi1Hco5
 URIL2Tg3MVFs8+AtJQfD8pepEbdx6aA0/sJndpE5QknR/F76m6uocYKIa445Y9Hc01R9a3fVXQO
 X
X-Google-Smtp-Source: AGHT+IE+KtahcloVwVrSVlNACHbBxOVtzqRoaBJ3jphGi86Yk3Wf7m4keUB7u19Tdx8iRhXCTPaRPw==
X-Received: by 2002:a17:90a:b117:b0:2bf:7cf1:f55f with SMTP id
 98e67ed59e1d1-2bf7cf1f613mr7949863a91.15.1716752208545; 
 Sun, 26 May 2024 12:36:48 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f6155b6sm4943761a91.29.2024.05.26.12.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:36:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 12/13] sparc64: Add IMA instructions
Date: Sun, 26 May 2024 12:36:36 -0700
Message-Id: <20240526193637.459064-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526193637.459064-1-richard.henderson@linaro.org>
References: <20240526193637.459064-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 sparc64.risu | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sparc64.risu b/sparc64.risu
index ca7ed35..271fee0 100644
--- a/sparc64.risu
+++ b/sparc64.risu
@@ -243,3 +243,10 @@ MOVxTOd         VIS3 10 rd:5 110110 00000 1 0001 1000 rs2:5 \
 #     !constraints { reg_ok($rs2); }
 # CMASK32         VIS3 10 00000 110110 00000 0 0001 1111 rs2:5 \
 #     !constraints { reg_ok($rs2); }
+
+#
+# IMA
+#
+
+FPMADDX         IMA 10 rd:5 110111 rs1:5 rs3:5 0000 rs2:5
+FPMADDXHI       IMA 10 rd:5 110111 rs1:5 rs3:5 0100 rs2:5
-- 
2.34.1


