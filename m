Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F00C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZII-0000vq-NM; Fri, 07 Mar 2025 10:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZID-0000uh-Oc
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:18 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIB-00088N-8r
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:17 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390ec449556so2383743f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360032; x=1741964832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+QkSXpcJmb4SjhyzEiZSJ5JG+w4vRWp9nEHIGthYBHI=;
 b=thqRFN7zE2ku6n9akLdRiBFPzENE5uCDlJgsUdrscgNznRrR2WBJG78H1tOekZDBQE
 OPFmxXvH8Xb8h4Huge6keL4PAePUx2pp1YAF1a2FWkCmDJAXt1M+K2lj/2Sby3pg0l/o
 +NOFExdOFx4kwghtUI+O5llA75ExJ3Xt9lumN4o1GN2Hj5ZvAqxt0vHSyFZYFbBmGiIe
 PvAel6r80J6uVhH3l6p1/dvi2aex2Jy5ZK1aG//GCszIBd2RKkQcV62Ba1SttnqABO6O
 i8w3oQ1XFUu9vpa9lkzIezrZYRMg8JYK8DVIYeaqy9guZiaYdxI4gVkR/tfuWPccx3fo
 nDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360032; x=1741964832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+QkSXpcJmb4SjhyzEiZSJ5JG+w4vRWp9nEHIGthYBHI=;
 b=i/DK7xKDwvcdJqadr65nVHNRbNAdS9KupECfPns6AYrBjlrkduHAmhYi6v2/yFtBCR
 N3Q45YcdpG7REFvATwdpssQOho3iEqHd9HAhCFVY3pqEqg3eDJQ+dlI1tcz3oRiepL/E
 Sj35ZbhZfLsmU2BBrqoFZ0DKktLgJwK84AOY3x1pFRcZnpSPf+lBqXeDy9rNzcRm5Tvo
 YSG6cjByLkco5cwYlC1X3NxoQL4cmv9bKOwlMxqj3K9slYq+Snabts8o+nRXGBEXGwSa
 DMpTdQY9e35FxQHFTToZzqDjFISO03lt4uJ61ejtE+zriY1QwAHrvzGkl3D0eeJcBqIh
 NRFw==
X-Gm-Message-State: AOJu0YxxjhsBZrgwOabBX1UwX5JlTVlLf390eGG0U4MlzA+xnK6bj0ud
 wsRz+VT4g5eOKmeoJQZ5wZCsjnI6SLNxVH+bHbDfqvElsY6uPsXDFvtgo80sFOTkwwGF0HASztg
 L
X-Gm-Gg: ASbGncvRUg27ZZI8T50qkiWVnXJKESXr59RglFpR9fqfhRz/o/LQFjYRMAgjWYdnpge
 xWlvim1Gc66l4FBe2uhN07GRiz0WrFS4Lhhoqrm4HHV3PK/Y4FJcRPWDt2DghPDn74p6SRXOP34
 Lk3NgRMT6Qpdd8m+PuKWawdIaplUpjrStb62tDdL6/JdGy+Pss8Eg1aPdB/By19bbWKAfRfWGcc
 N3xOcRVD1mV8NdPg5mtRyscM0RWfrHAEkNlzqjAYemRazVsRMd3MdQte47J1HFxlKJTO/aaiZEK
 FvuxeAqJm9hcvlx57a4hlxYFNxLfHtK6174QQAAhyqGonmQsQN4=
X-Google-Smtp-Source: AGHT+IEipGZ5hY4utgxesPXs60KaW82O9P+tVN0ixOB4fdu5HmxoZ0XJJu+edFgwgmsVj3GMfuVdMQ==
X-Received: by 2002:a05:6000:1a86:b0:391:4f9:a048 with SMTP id
 ffacd0b85a97d-39132d095e2mr3263933f8f.4.1741360032400; 
 Fri, 07 Mar 2025 07:07:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/21] hw/arm/smmu-common: Remove the repeated ttb field
Date: Fri,  7 Mar 2025 15:06:48 +0000
Message-ID: <20250307150708.3222813-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: JianChunfu <jansef.jian@hj-micro.com>

SMMUTransCfg->ttb is never used in QEMU, TT base address
can be accessed by SMMUTransCfg->tt[i]->ttb.

Signed-off-by: JianChunfu <jansef.jian@hj-micro.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20250221031034.69822-1-jansef.jian@hj-micro.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index d1a4a64551d..e5ad55bbae7 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -110,7 +110,6 @@ typedef struct SMMUTransCfg {
     /* Used by stage-1 only. */
     bool aa64;                 /* arch64 or aarch32 translation table */
     bool record_faults;        /* record fault events */
-    uint64_t ttb;              /* TT base address */
     uint8_t oas;               /* output address width */
     uint8_t tbi;               /* Top Byte Ignore */
     int asid;
-- 
2.43.0


