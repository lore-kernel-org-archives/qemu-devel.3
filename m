Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B17F33824
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 09:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2R25-0001nv-Fp; Tue, 17 Mar 2026 05:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2R22-0001nD-Q9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 05:48:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2R21-00043b-7t
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 05:48:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so63085455e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773740887; x=1774345687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ph1pNO84S1EpHEhKclsWE7wWKRIyWhcQ/3QlynRy1nU=;
 b=rOkHv3PuXR0zxh4nx9JcMxYn1XIDJyuoFPFvJdRVkeWlUuzHTt/etmajaLO4POS/Pk
 8PMsPWsvD7rFLiKjyahN0KLOUUTXXJP0g9naz8SSbKzL9H5P5Izrbt1dX7AMmFIRtGjq
 IuAgetRyTIs7Cyn0Hgt93euQo8DkRABANWE1lRuH9Q9OvKfquwnONWvD4iOclE4bJGp1
 hzL9J1yjuguJRaBJINJIpR4PiusfFCI1w3nOMdb+KOkUyNjuMMBl28UTxzDUsL2nICg3
 0n9RFH+tMpToLm9Tm6rnkDDFONm8lwPp5ZPXh+XhT49kVNX8v+JaVbMskLpBi0ugQqfy
 XYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773740887; x=1774345687;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ph1pNO84S1EpHEhKclsWE7wWKRIyWhcQ/3QlynRy1nU=;
 b=nZl8kgrsfWJb+raO7h4NRyLk3CQHrXCJXZHxwFFEtGKq0sV5lhWDdi19XvK1V0SRPw
 qjwkEkr5k3ZqrQ5IUv9VKXUkTP3gx7W2tc6pBF49sQFnIdv1iBLScZY3MrJvPrtOQy4I
 eTR5D5q+9UiIDuiyb9o8LAPsL8vybtRqgHFO55EEwEtGqiBz8g+hhkfP59bf+b4lvfCA
 dAFyzndV+c0wB12srtWLGYCpUL3CJWyFbrmIisZ9KTuno2CG4E21byQG9EnTq6A7MIiS
 pcnclKqzmL6O6jQmOYK2xe1FUXp5RAc/fEkfKGkkGS++UH2WUGuYxS228g3Ppbh/T5cs
 qdKA==
X-Gm-Message-State: AOJu0YxTdLG+3rJJpURU1ZGKhPi2M5ObLoC19JuAXmSjWBV5nSeulH1t
 8a4i4uVLjyXRuqwxl0mkjBGEIhF0hTpMeUBdVF4zVCdCawhbweZ6gzyLcY2255/R0bvyi67g+Gb
 qoeUu
X-Gm-Gg: ATEYQzwJXurjg6ZZxOb+9ZG5is2/wOFJHgwgd9Lqh7RDWnP/oZqTRSruA6SP9hp4JBP
 BEmH27gftZqxlLZgmMnryWtTya4cy7C2Yx24COPlzqna5Tly2OwYUGaNaMNq3bTHtQk2bCjjuNW
 WsKG6NjiyuCLug5wpfKyNvJfeAr6zX/dmXnz6nGVeYfPbrg3CAR0HWnM3V2avXx0hD6PWRJTYga
 9rbb6+SIEIwrS7S1D6bFO8wyFfrpU1RG/Si8c+zT3zue7QDSbqk61Qi7P9k3ylrn2XrF9rNIpIp
 W+l0NQxd512wqDB2iMi3N3UFKfCZgLidhAOrNVa0d0SPu8bcUckdwnn1gQ4rv0zWMtL2OAuUCmR
 bhpEK3e+Ev0whksgZPTLx8yukpcAQPs5SVs7bJtpLLeLqHBzVWv4FN7iuhjmi8c5eBU9jP/Ubtx
 3Jyb67iJQ0rFbRoyhqmQhcK5KAllZtpJIKWz3KGk0aWAkknCQ8/XZ8M3P1rHYtgQWxKOrHUWP2V
 QcbXWs2lK9f//0T9NBu+h68eK9ZkrA=
X-Received: by 2002:a05:600c:8208:b0:485:34b3:8589 with SMTP id
 5b1f17b1804b1-4855a8d7004mr247072475e9.31.1773740887508; 
 Tue, 17 Mar 2026 02:48:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea98070sm54329075e9.6.2026.03.17.02.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 02:48:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH 0/3] fsfreeze-hook: fix bashisms, syslog fallback logic
Date: Tue, 17 Mar 2026 09:48:03 +0000
Message-ID: <20260317094806.1944053-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

This patchset fixes some issues with the fsfreeze-hook guest-agent
script reported in https://gitlab.com/qemu-project/qemu/-/work_items/3339

 * the script is a #!/bin/sh one, but it uses various bash-isms.
   Most are easy fixes, but getting rid of the PIPESTATUS usage
   is a little less obvious, so that gets its own patch
 * a bug in the logic determining whether to log to file or syslog
   means that if the logfile doesn't exist on first run, the script
   will create the logfile but log to syslog (and then log to file
   on second and subsequent runs)

NB: I have tested this by setting up the script and running it
manually in a temp directory, but not as a "real world" fsfreeze.

thanks
-- PMM

Peter Maydell (3):
  scripts/qemu-guest-agent/fsfreeze-hook: Avoid bash-isms
  scripts/qemu-guest-agent/fsfreeze-hook: Avoid use of PIPESTATUS
  scripts/qemu-guest-agent/fsfreeze-hook: Fix syslog-fallback logic

 scripts/qemu-guest-agent/fsfreeze-hook | 34 ++++++++++++++++++--------
 1 file changed, 24 insertions(+), 10 deletions(-)

-- 
2.43.0


