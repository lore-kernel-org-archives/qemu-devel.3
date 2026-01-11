Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82079D2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 20:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf25E-0005tb-S1; Sun, 11 Jan 2026 15:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1vf0VI-0005Rz-0J
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 13:49:34 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1vf0VG-0007Yp-Es
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 13:49:31 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-29f102b013fso55406005ad.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 10:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768157369; x=1768762169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ar1B/LWH2fiMHmQ1MbphdWYmxoynyqyilffTedByHN4=;
 b=b2iBbOByH80wnBunTkXpfoR6EcDYazJ8YOg6Jn/7yxkawLQKCYl4/6AJPurGE9Ie40
 ZK/EUVJIx3q3D9RJYVnt0ui0vNRdmcusYUZTnDWZMnj/TCL2VF7LLruGeKjLyDIAScXp
 wznRANxu7fXw0ipdntcexxcvB8EbQEad7pGUVWufEZxb+BEcyRsbN3x41MQph8yYEaV/
 1GNBRwJzL2C04sWj2JMiKAhbXp6Pka0XYD9BiekMG+PX6XjkUdebDuJSLeiCOMA35yXK
 ocoZxnNUfZHVrzp3sLdl7lisPNLFhW3Vu3dLteJud6hw7Rdk1ze7Nc8GQSVS3SyNi4Ku
 Q0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768157369; x=1768762169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ar1B/LWH2fiMHmQ1MbphdWYmxoynyqyilffTedByHN4=;
 b=GftgzQa1U+hdtxQnQMgSNxYcGU/waLNCX+AXpMoDIeeG55Z2qG5gBm88rV/x83UL3d
 0o6bB4WT+4LEq4m+o7im4pYjMcxYajRz1b/VdWnqV2+FddJcwvNQniHpcU0/qrHSA67I
 wAEveAwFRIwt3FpDN1/PfT5ddZawl8ZhjobypdMnqO/pYz72MjlgJE9nIqsWMdPgQSeW
 C3w1nYJTGNNMTJx+75h6jEmDuywgD85n9S6KYsr9Ae0HA60BtK44Vy2BjaWgZ9N8zuw9
 7/Tm85t/1WBbvzABJh3B5CAE1MFH7uV62qSgj3rjcIQJv8vsGcXFpgeKiQZOB4DSah/9
 nuFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpIwbaei9xo+TVt1UP3OTOTogWvad8ROBBMkQ+kge8wjRiO7vA7rve1fW0Heg9VHpwo3FmxGGTSghP@nongnu.org
X-Gm-Message-State: AOJu0YyRbmWO3KSEnKTpbY8BmR3a7ZpD/5kix+oL7jNN3zUJzB4mwsDH
 amSVKUR0U0sT33nhbPKCvYR3tCyjSuiw+4krIAfJL3fFFayXSS51grfefy16Zw==
X-Gm-Gg: AY/fxX7qyHZHnSgMAE3NRfjIJt1hozikar599Ajqp09wF9VloSE07eIdG+ohl8/wlpk
 Q9Rz5bHGg+w0e7XeQcDpWjkRu/t2oL9wt4rqR4VvyDHwGuRB2Fx/Sb0XBvyXmOj/L62g1G8Yh9G
 BTpUh8CKEkOVkRxKD4q9dcrF3yhUb9fthLcNX/+RXIB86+1PqhJnRvJeFjmUaxGg4OcniWxkr/I
 zHFl2S66PkVKMqVfOJxc3YHyDRDBzlRXT4HBKAsnbfNIO+pKV30l4kSE4JksCnopQn7b9P91zZz
 raaVa2U9R4/WZf2qp+lpPPQ9ziF7W0Je+18JhPn7JP/ZoKBlo8Tz5IQSxKC3q50HMqeg7aIfc5y
 KU5e0NRDMyXxEXeD4/AzOtMh5NvDmJt4pgR9VpgRVZ7XMYyv9W/2qqX8bqRRQg/Bi0ggu9W/G2f
 V+slL0hmVYOZ+cYAvuUpkPgBIWgj311fIu17oCoA9cYotQk3l3FsxP8K0iHR8oIBXl6VUgw3b7+
 oNT7xpvs6oKYAe6QqMlFA==
X-Google-Smtp-Source: AGHT+IGuvFEMTAi9wRimF2In2xo0dyfGJ/cVPvbzg1VJwnpc6DLg/SdnyTTf7YQqktVETWmh7J7LpQ==
X-Received: by 2002:a17:903:244e:b0:2a2:d2e8:9f1f with SMTP id
 d9443c01a7336-2a3ee491c2bmr155099835ad.31.1768157368607; 
 Sun, 11 Jan 2026 10:49:28 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c4893dsm152753005ad.28.2026.01.11.10.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 10:49:28 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: laurent@vivier.eu
Cc: jserv@ccns.ncku.edu.tw, qemu-devel@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] hw/misc/virt_ctrl: Fix incorrect trace event in read operation
Date: Sun, 11 Jan 2026 18:49:15 +0000
Message-ID: <20260111184915.1363318-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=visitorckw@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 11 Jan 2026 15:30:43 -0500
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

The virt_ctrl_read() function currently invokes trace_virt_ctrl_write()
instead of trace_virt_ctrl_read(). This results in read operations
appearing as write operations in the trace output, which is misleading
during debugging and analysis.

Replace the incorrect trace call with the proper read-specific trace
event to accurately reflect the hardware behavior.

Fixes: 0791bc02b8fb ("m68k: add a system controller")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 hw/misc/virt_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/virt_ctrl.c b/hw/misc/virt_ctrl.c
index 40747925a2..9b82e97ffd 100644
--- a/hw/misc/virt_ctrl.c
+++ b/hw/misc/virt_ctrl.c
@@ -43,7 +43,7 @@ static uint64_t virt_ctrl_read(void *opaque, hwaddr addr, unsigned size)
         break;
     }
 
-    trace_virt_ctrl_write(s, addr, size, value);
+    trace_virt_ctrl_read(s, addr, size, value);
 
     return value;
 }
-- 
2.52.0.457.g6b5491de43-goog


