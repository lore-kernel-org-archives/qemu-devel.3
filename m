Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5CAD17157
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34Q9-0005xU-2g; Mon, 21 Oct 2024 22:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t34Q6-0005x5-UI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:14:50 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t34Q5-0001Xu-DQ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:14:50 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20c767a9c50so47375565ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 19:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729563287; x=1730168087;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zo+RtlxJE/Vyu5z39LEZBU3bTp7nPUEFJlDoFBaiCLQ=;
 b=Ajhe2szO4SGNPdQTdTlOi6bBCcHByl30e+k3qmerRurfksGtIA7IO6NDRM8gOqAfqx
 OiwaZt0nJpl1GPhLh9P6gXRujx8yxBgadNONDoAOSk6EMQ+QchfG6vNIPiyAmCrs76sj
 x5VtkansJEM/DQudV4X4eQaKu5cI4PKpQOeX8nI5M4iU0PeAtlsafKtXLx0+SR+27s+M
 oPhsKM80+wv21qkghihV2A3K0O+R85kAYfn5EpNcSJblJGX6Ypzk/rFT3Eoe0PJqPb5m
 2L2bzPJMgDa7DqFUN9nIR4DdA2/TW2STfJdMVKzEnVw9QqxAMCM2WFcOyjArwJ2jyaWO
 PwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729563287; x=1730168087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zo+RtlxJE/Vyu5z39LEZBU3bTp7nPUEFJlDoFBaiCLQ=;
 b=XrGF3uir59Q5yiLNJiw9fmJjbXzqm3Q9JxFHec+yWXClYAjKxCTAu0BiVfVYhQMGER
 uYqaDBqMkCssjJaRiYDY++viXTcG8zKJRiMc/9qBaP97Z23+pW7OFN7SuGQZfr3nwBbR
 gScvYGuor9bDCaW6d2DOFHN5BamQtpI5NT7F81At8WSVTXeKyRpfA5dj//YHIGcsqFWZ
 /kL+E1Rj8dpZ49ZgP0e/S9JqJCi0L7vD5Hx+dKAxV2chSduZnligLm7tLHt/W/e5EVJO
 2xmHvzbnWOjJ1BJp8OIApxWxYiufSwqc3P5LGXbX8UcVoJq2lOIpHHDLqIvWMEcLI/bs
 qqbQ==
X-Gm-Message-State: AOJu0Yy1hfoJ0klHy6EUMymha1karmJ+fU0zNxh6qFY/Zc3FvAZHfFRi
 NxOX2JVgWmMwGUgoQBZopxWUx4s0ZE52wjU+s62DV7UX0Szww4wxw16LR86xdpLHAeODfZFRWnA
 Jv5Ck2Q==
X-Google-Smtp-Source: AGHT+IFkmHnl0YIw8XivFFVe6tv2y88tYsfLMqv2zd/Cffit5vAjqxkkuQRwJvyN6jkxPiYcEYXuRQ==
X-Received: by 2002:a17:902:da8f:b0:20c:6392:1a7b with SMTP id
 d9443c01a7336-20e5a736ff0mr194222415ad.2.1729563286811; 
 Mon, 21 Oct 2024 19:14:46 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([103.172.41.198])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd63fsm32726545ad.173.2024.10.21.19.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 19:14:46 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v3 4/5] guestperf: Nitpick the inconsistent parameters
Date: Tue, 22 Oct 2024 10:14:25 +0800
Message-Id: <4a243c2b8a5dc8baa689dc94e96a6ab3372f1644.1729562974.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729562974.git.yong.huang@smartx.com>
References: <cover.1729562974.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/migration/guestperf/comparison.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/migration/guestperf/comparison.py b/scripts/migration/guestperf/comparison.py
index 42cc0372d1..40e9d2eb1d 100644
--- a/scripts/migration/guestperf/comparison.py
+++ b/scripts/migration/guestperf/comparison.py
@@ -127,7 +127,7 @@ def __init__(self, name, scenarios):
     # varying numbers of channels
     Comparison("compr-multifd", scenarios = [
         Scenario("compr-multifd-channels-4",
-                 multifd=True, multifd_channels=2),
+                 multifd=True, multifd_channels=4),
         Scenario("compr-multifd-channels-8",
                  multifd=True, multifd_channels=8),
         Scenario("compr-multifd-channels-32",
-- 
2.27.0


