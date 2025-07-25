Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C1FC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufOwB-0000eO-4G; Fri, 25 Jul 2025 16:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOrN-0005rn-3n
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:17:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOrL-0000pJ-Hh
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:17:40 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-748e378ba4fso3305270b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753474657; x=1754079457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lRb8YP8Kyc3LwuOEoyb3AQPqAoLQh72yk5nriW4mRt0=;
 b=YDfXRUnDFEPQidD2MZpEUKjimewnQS5fzHexrOTNxBjYS7z5YtCYFFhioKPhMfFs1c
 s6883In3IlFe9DSbsugqn/c/ndTgYhCjoplcyvWR9Ksd+U9rrYk8TKKfXspcZqsr2vyu
 6OFEyltb6qu/XiidI33MBlt30F2G5T97s0Erc6u+qhG6uRHzoHlF4QX4x05liXM9OK08
 snty7DQNDERhhrHydd2EQvbgB9XzdYQZXES3xn2I9qxijJRM49lerO1YekvZrd5dcqZL
 JpqNm7HNSRPiUVRFQmWb3shI6uv1RQSd/tqf4wcruEQmaQU9uxquc7jC4h9Cs+PAQgDx
 1TvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753474657; x=1754079457;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lRb8YP8Kyc3LwuOEoyb3AQPqAoLQh72yk5nriW4mRt0=;
 b=fnJNZU1ALeLiIQSbKZ6NjwPYarLMWi/LesI9mAN/s3VY/tohf9AMqwhnaulwWwX6qW
 PTx+ROeen7QJVmHDEso5kkqhfYfZSHriff+/0lsIg4K1cr2JIZjI4yG9dTlLseFL5KZd
 6MLwINHEUH5BS4K/DW4nPtWFjTLEvvcp6Peq2Pg6IhoHp3E6W8z9knooWtSPjQeqiDHt
 X80B0lhyhjv8JPadQQxQpu8rNd9mJr4bZNgXeoMEr6sEa42AoALH+HaDqO/79w34zBkK
 itbbyb0EIGpmcF8dQINY3RhzoYLLCysu9MoJnSPYhUFOTR61w24e0Tdc1K2JFnXxNT4Q
 YGbw==
X-Gm-Message-State: AOJu0YyPlN2puvSy0jIOh93WnnJAD0mblkjQt1CJ8fDGg34GRlUoG3xK
 lOxJyfHFI84rjJbD1SCv/SmZwOTJ7ZqT9EYNq3iLM61EtEx81y4+9RCMxQHYswobSFYd/CKLTmJ
 XfvsW
X-Gm-Gg: ASbGncvBMJOTLdd5SjN8kbgk2lYnSePZv1hURwLvyqBlSQvAEX5J6su/zyiURWZOWZM
 v/4IvtX5sDHgjMUqen5Xwlh3tycIKwhcalYBYAk4/mJYgNiNA2BqFb4XORoCQ1gxe+6urSONjDY
 n1olZvHWh4tvkaJYc8FU9KACOfc+ijmKcjdDKk/hjN+bDSt3NTMOHkMoHZtZJPo4ojiOjiJsUQN
 EnLzbQVWSy27kQDdkuoO5aoZXNpJulGCNJbsnX5ijU9s5WMNMDjKmbzuUSrxkvj1yl3E9+90utP
 WQQ8ig/g6z13RQH0cnCwaogdhtIiP9KQEIcHcWMarEAJc3XJQYh4ct9uBDffiWdtuqDC7GWOWkl
 AFiiMFKBkJVZuDjNDqK9sQI1OxAMH0vyq
X-Google-Smtp-Source: AGHT+IFpOZQtTc0wk89YRbg3gM4O2oxbvtfWK0/l0Izg7s3vZ3Na/IH/r6WKPP4lCRYxP8ae0LxCJg==
X-Received: by 2002:a05:6a00:4611:b0:736:5822:74b4 with SMTP id
 d2e1a72fcca58-763351b9fc7mr5274149b3a.21.1753474657523; 
 Fri, 25 Jul 2025 13:17:37 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76408c023absm383611b3a.38.2025.07.25.13.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 13:17:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/3] single-binary: compile once migration files
Date: Fri, 25 Jul 2025 13:17:26 -0700
Message-ID: <20250725201729.17100-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

This series removes target dependencies in migration code.

Pierrick Bouvier (3):
  migration: compile migration/ram.c once
  migration: rename target.c to vfio.c
  migration/vfio: compile only once

 migration/vfio-stub.c          | 16 ++++++++++++++++
 migration/{target.c => vfio.c} | 16 +---------------
 migration/meson.build          |  8 ++++----
 3 files changed, 21 insertions(+), 19 deletions(-)
 create mode 100644 migration/vfio-stub.c
 rename migration/{target.c => vfio.c} (67%)

-- 
2.47.2


