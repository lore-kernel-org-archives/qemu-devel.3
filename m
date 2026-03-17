Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C254F33824
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 09:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2R2A-0001op-G5; Tue, 17 Mar 2026 05:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2R25-0001nw-Ft
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 05:48:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2R23-00043w-QR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 05:48:13 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso48480025e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773740890; x=1774345690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/iFyReZLv6A8DCGV09DfF1JGeNsnz7YwppXHJdu2GgE=;
 b=U+jOo+zmw3MDymddRlApTSXaMmBK/Ee2sg75YDwUyPJRskuDHzh9qUOb4knJUY8aBM
 7sA8uyFOhbfX/WgyLQlhUeTcmGzwJui4NtvbaEGYPz6gnxjuneSWH16LLFE/WkfdwZ1/
 chxh0wFG9l6UN+WAVPpdhQ8pxBpo2w5XmWxuxeylbhkK5K8IPkJsTdnsl5XSs31OSuuY
 5l2ji/MGq8ttayuAkYtH5lkxtmDIMgHvvnZTIvMGjqoODKPO2ZN/zgW4Nwoxx955KtEh
 10Z0asASWR/9Y0CrwnY9LYH+xr/C+Va7E1davuciALVhQ9KpCMeaFXpj5jU5iWyh5Z4I
 eKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773740890; x=1774345690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/iFyReZLv6A8DCGV09DfF1JGeNsnz7YwppXHJdu2GgE=;
 b=XZ1YL3OR9UMIkJbxSPaFBeyunpAo69Vo8EeSC97yvpE1JUp+Hr6t3WF2KeKudBGebv
 s7Afic7kHxHk11+UDRum/dMWRit+P19KqJNorEGzfYrNkbiHOyNeDU+smsr1A44k2D2q
 Ynz+RTwjVVNk9gq9cwsXMPufenBb1K8l/6LhLBX8uiP72zmN45OgESay6ddb4oOUMir7
 DAdJqkOW69e1YpO1Afk+GsbKlpDXoCCGxPEaJvhx92dVhFet3Zr0TTNF8leVEwHaeWX6
 I6Vn2hjHgiBWmflgpIfnt5EAJZ1K51F822LrSXB8v4EVeaZg/rMq7D03flv3bYAX8Jx4
 WrHw==
X-Gm-Message-State: AOJu0YxHPg+thi90YKvMce70i6IoEiMQMqiOelbo0x9sAcXPH1zIjvcl
 EMSJWDsHVKLOXJ8w5VWEJk26+5mxvh86SQ4cxYZYbMs+jl6Av2sTgAsP8BqsNUKt8o61E4OiBX1
 E2LSW
X-Gm-Gg: ATEYQzzODG1ClNnJuiCr3Mv7A92vm2feRcUnn+HYPEvteeBys8V3/t2HeaS8dzVvBA/
 hGC+hrxoBySZaeGEyIUEcuv5WVm/LfnGwJ1XLjzmXUf77eRVTu0hQ6Gc7lJBnDviCemViZ4orXO
 /rUUafaeyzhuKC3ZWO3pDlD9UUElTwjBnppTlXCBjfeFioKLsC8VeMsKNj9XCqfHxuEHAYfQQFR
 dhstDgJ7Wd6LQ5V7e+dg/OA6PZiJQYR73uDYnWWCAXMLUyQb6AEGRKrdrtxiDn6CJZc0jTa506f
 ZmbqMpxGI2XV/GROkeChmMmq5hIrwWfsbBcoFJ5ZUqX9xqbhhp47TFUzdr1uno2TQ8cY/CoVpu4
 jjxtiaCg1RiYq2mdPwZLK+2AwM68MT71KMniYnegAAqaVQ8QIQnZ/brgjF4+eF/oOw1rN1iOPAg
 2pxpxly+jhTcRB3a8qm9Nb9+v9onyHUCZoqhhJ8U/aSXlg32oTHrf0obuqfHOU4je+762/YYzn1
 C9/x0LNMSJT6IxrUx56yFaiGTsmTlg=
X-Received: by 2002:a05:600c:8011:b0:485:3b00:f939 with SMTP id
 5b1f17b1804b1-485570ce1acmr252779375e9.8.1773740890115; 
 Tue, 17 Mar 2026 02:48:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea98070sm54329075e9.6.2026.03.17.02.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 02:48:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH 3/3] scripts/qemu-guest-agent/fsfreeze-hook: Fix
 syslog-fallback logic
Date: Tue, 17 Mar 2026 09:48:06 +0000
Message-ID: <20260317094806.1944053-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317094806.1944053-1-peter.maydell@linaro.org>
References: <20260317094806.1944053-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

In the fsfreeze script we attempt to implement "log to a file if we
can, and fall back to syslog if we cannot".  We do this with:

  [ ! -w "$LOGFILE" ] && USE_SYSLOG=1
  touch "$LOGFILE" >/dev/null 2>&1 || USE_SYSLOG=1

This has a weird behaviour if it is run in a setup where we have
permissions that would allow us to write to $LOGFILE but it does not
currently exist.  On the first execution, the '-w' fails and so we
set USE_SYSLOG=1.  But since we also do the "touch $LOGFILE" step we
create an empty logfile.  Then on the second time the script is
executed, we see a writeable logfile and will use it.  The effect is
"log to syslog once, then to the logfile thereafter", which is not
likely to be what anybody wants.

Update the condition of the first check to only pick syslog if
the logfile exists but is not writable. This means that:
 * if the logfile doesn't exist but we are able to create it,
   we will create it and use it
 * if the logfile already exists and we can write to it,
   we will use it
 * if the logfile already exists but we can't write to it,
   we will fall back to syslog
 * if the logfile doesn't exist and we can't create it,
   we will fall back to syslog

Cc: qemu-stable@nongnu.org
Fixes: 85978dfb6b1c133 ("qemu-ga: Optimize freeze-hook script logic of logging error")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/qemu-guest-agent/fsfreeze-hook | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-agent/fsfreeze-hook
index 21eb5c5145..76669f5caf 100755
--- a/scripts/qemu-guest-agent/fsfreeze-hook
+++ b/scripts/qemu-guest-agent/fsfreeze-hook
@@ -21,8 +21,8 @@ is_ignored_file() {
 }
 
 USE_SYSLOG=0
-# if log file is not writable, fallback to syslog
-[ ! -w "$LOGFILE" ] && USE_SYSLOG=1
+# if log file exists but is not writable, fallback to syslog
+[ -e "$LOGFILE" ] && [ ! -w "$LOGFILE" ] && USE_SYSLOG=1
 # try to update log file and fallback to syslog if it fails
 touch "$LOGFILE" >/dev/null 2>&1 || USE_SYSLOG=1
 
-- 
2.43.0


