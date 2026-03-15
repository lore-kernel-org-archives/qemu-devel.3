Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AB0D58B08
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 07:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1fao-0001ko-3N; Sun, 15 Mar 2026 03:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1fam-0001k4-Gc
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:08:52 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1fal-0000dW-4p
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:08:52 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35a211df8e3so1579562a91.2
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 00:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773558530; x=1774163330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7SBLNkZfE70Q4c4n8fHx6puQVux00Zu8cChd4QK9u4=;
 b=JBDy7fylnU/Jm31EUVo+h0R9wvOWKV6a4Rd4juGoVZhQO2tOrlGkPgI+Sms85ADw83
 mQhnu0l9I5lR/5rlinuGYfKu6ltdpz0eVkEVTJTRhWAb0iZ1xaXWnd7ZIAqZceHhARN9
 YtdGWpe6wYtPl+UvwEqEDALp1pdj3eVka/CJM3v9HQnVRyyi/3QogJzAEH1CZbUkrTKq
 y3gPIaFKSH5RIKFKAgK0neff+tVslTyHmxUPv23/LoL6UNyhRUwg7eMNsb4RRCMmR986
 qWwthQpo5S+BbVFQDUEUrnT7PCVy2nkDemK/EIM33drWgbx4+oWEJxGZMWsJJleaHNDP
 QjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773558530; x=1774163330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D7SBLNkZfE70Q4c4n8fHx6puQVux00Zu8cChd4QK9u4=;
 b=sRhoqyWaEwvBDnu53s7g8PWfz2kBS9ojHTJlhoTQsSIm/RZXZcb3rKy+o6zA2G1jlu
 6eqrRfAqmpQKVyVQzEvnsO3nGWWDPfTqoKpf63WK00PiaHp8d062IKDPWY90Jg77Sn3G
 203nJ5vM01KQdtqD/PNcREI3ACzdmIurvNNW8rEy9lZzRCLHweKWRXd+64wqCLmWQvwJ
 7RvIiyKxzb59Jv0XCm9zsoGCcly5qCwcSVAR7xzDrCGyIewNXq7SsggkZ0eAJAqwKEyr
 9uY8L5a5GNHbVv6Af+2nS40q+D0HGTZJ05prUblLhkkkEwZigSux+1y9eCWwhIvcfvEc
 VapA==
X-Gm-Message-State: AOJu0Yxb2L2sa728OUqNp5NTfQvBrAwwhwyqKB8/gYeL+z8QAJfjLgm7
 fSE1z2aUK52UqmWV2/6EtZpa6qyOmGzLzybfMpMhBgzNh1WyYNtu55+AZMDzQ6OVPDxPEWenctF
 HNe0lXW8=
X-Gm-Gg: ATEYQzyandPnZaPuxrAFeer7zWZqSkDW7Ah48Idi8VMn1+R16uMmfh5K749IYWgUZLn
 4TMkVh+ghC1sMVNbKvsMT13G/VtIk+f/7nGes4MzhFcwUn5BEImh0AIci8E2mv+2gS/JP96BFHr
 1cD998HcbqoG23Wtc9nSnD4yP9aCer5WFHvHRghdNDxJEEKj0Za5LqhszTKxkOtfL8jal5Ri1T0
 L3Jaw/7BmqPUdenIpgYht7GYwX11boIuvNDHlm/R7JtvOwtZH9XMWhhccS3bvcUW43Gj8TaBm1x
 vZ9yb/bYirBIO22bJgrtmknaLLdXqlEGgW+4DDhYruadvCEimZ7tySbyDUUXlmZLJdUhIFQBGET
 DaBjt7SPJeE2JTw5SEP/rb7bsx2oKE9MAYfUEMaoBQqQkKGr5D7Aqak1YvK/aNREG5N1KujeLtK
 oNwshtLUu4Xi+VtrTfobCyUBkFLfxWF2IkhRuARgycBHeQt61TbyVM21SPtibDHAIQcfaLaJevX
 Nc=
X-Received: by 2002:a17:90b:574f:b0:359:fe72:3559 with SMTP id
 98e67ed59e1d1-35a21fdd3b7mr8189306a91.21.1773558529698; 
 Sun, 15 Mar 2026 00:08:49 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a24acecadsm3468233a91.2.2026.03.15.00.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 00:08:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-ppc@nongnu.org, eric.auger@redhat.com
Subject: [PATCH v3 6/8] hw/vfio/ap.c: use full path for target specific header
Date: Sun, 15 Mar 2026 00:08:32 -0700
Message-ID: <20260315070834.198331-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
References: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

In addition, we fix target/s390x/kvm/kvm_s390x.h cpu-qom include also.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/s390x/kvm/kvm_s390x.h | 2 +-
 hw/vfio/ap.c                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
index 649dae5948a..7b1cce3e60d 100644
--- a/target/s390x/kvm/kvm_s390x.h
+++ b/target/s390x/kvm/kvm_s390x.h
@@ -10,7 +10,7 @@
 #ifndef KVM_S390X_H
 #define KVM_S390X_H
 
-#include "cpu-qom.h"
+#include "target/s390x/cpu-qom.h"
 
 struct kvm_s390_irq;
 
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 856fa2678cd..3fae9ae9814 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "kvm/kvm_s390x.h"
+#include "target/s390x/kvm/kvm_s390x.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/s390x/ap-bridge.h"
-- 
2.47.3


