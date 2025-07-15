Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA6EC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 21:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubn8s-0002Kp-5J; Tue, 15 Jul 2025 17:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubn7s-000250-00
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 17:23:49 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubn7p-0001oU-K2
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 17:23:47 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so6212422b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752614623; x=1753219423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uJuDKaPyuOQ11qMEvzCeZiq7F9iOl5xDj1QLIO3/YMo=;
 b=W9tPWiR027wIphs/I9l1hbyHwtEBrwOCGkZ/+xtUmzrFURUmqxvN3U+DfUl0DuN3Pt
 6YBiDkBaJXUZrsJZMSOsXpFCXRaYL3c0DUS6Qnlcl0OeaSQn+2l/R2y2bwPh8xfzccHI
 HfJ5fOerKoB4aJqTgWDq9cAgcc09wBCNyT8bwyzPJO4gPIXB1lOeP6UzZpPnJRUcPsxC
 sYIy/BE45puVE2bbJ+pgd6Kl/5Dg9i8VKaYTZdmZEdbh4D1TksskRcqUFkFfWr3NbHXW
 FZ7e7pqY8FthocIQetQAdhx4j8T0xomKrRCF0eIsPggLY7L3APcmYNcxQ0L6dKP1s9/C
 unzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752614623; x=1753219423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uJuDKaPyuOQ11qMEvzCeZiq7F9iOl5xDj1QLIO3/YMo=;
 b=sr/uydDi9Pw7eE55uVHXeBZsOXuHub5N233L/uKR5aYF1UfEEu0LZvOqWimWaYN2Mt
 CFCXfu0Fn/bn3sRh4SJ14VpuE7n1tqrMHC5Gy0/7Jwj6/JcpWAoxi70G5o8LSrESGkfz
 5iHkD7uyX6PNz8NM8fIFoPpqZijc6YX/aV9CUXxN2OZ5Yr0/wIbt1KWSN2YF/hyJvAXI
 N/DWsWJRXm6w0s1UyjxR/qIYywKzXMRP/PV07KPWC+vrS8Qifrc0hqRu+AAIKzB4FbV4
 h7hgVFrgnZxdid7dZM9w/F9ajzm69TOX5Ca/RmsPNii6VJDdMJEQQncG9xBlVtwQAsB8
 2AxQ==
X-Gm-Message-State: AOJu0YxiiTtqplmT+aZEf/ToQ7VmspVrpU41qpYLYLQFKJIWFSywKUSv
 qdGq9rk/lHwYv4j+drRUubpz6CC4EyHmHRNgs7lowcX0uZ0W89qwM/QGwLA34EzL+GmC7a3pXPU
 Rt27d
X-Gm-Gg: ASbGncuf956g0W3L+ftTXjLv1+wC7ZgNgpfqXUJJQUsyYFJPwnzG9dm0/Jrp4+HeEWF
 +zy3/9WEXLAKXIi4prjxGaeSX6AqZZ8XHOkAv0jaebeJ76WfHlpwXPxr4nXs/bFQDyiQY7GNy6I
 cqYSwE6jrEf78dGVzsUjvGtCk8uwHFG779jZLzxw+IXtoJyGjPhqWRK0bSl1HQoSPjEcC9w51xZ
 Q4NZ3NbFsyt9W3MKApwuaYwNyifNi8V72Cwp02X8olMgotCo+VasmA9ApvDM1JrtjdEiEtn++Do
 G1TAhRXc85aDuKlGRU22+xEGqBOxAWx7MYsRuFV5ugtAyYovhbSm2I7xHPANW63QEgUzy7ag8e6
 zhae5ExXJ2KOTWwELuMpJBA==
X-Google-Smtp-Source: AGHT+IGoF9ww+51xV8mMCpAaeU1d1gluPlrjn0GCgvTKObpoku2zj2OKShR2kfoC2mirp2Cf9sg/eQ==
X-Received: by 2002:a05:6a00:cd5:b0:748:f365:bedd with SMTP id
 d2e1a72fcca58-7572568099fmr104059b3a.17.1752614622982; 
 Tue, 15 Jul 2025 14:23:42 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f4b16fsm12281708b3a.120.2025.07.15.14.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 14:23:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, jean-philippe@linaro.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, gustavo.romero@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/2] aarch64: update test images with new trusted firmware
Date: Tue, 15 Jul 2025 14:23:33 -0700
Message-ID: <20250715212335.2215509-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

The FEAT_MEC series [1] introduces FEAT_TCR2 and FEAT_SCTLR2.
TF-A needs to be aware of that change to allow accesses to those registers, and
thus must be patched [2] to enable this for QEMU platforms.

Concerned test images need to be updated to allow them to boot.

[1] https://lore.kernel.org/qemu-devel/20250714155836.1514748-1-richard.henderson@linaro.org/
[2] https://git.codelinaro.org/linaro/dcap/tf-a/trusted-firmware-a/-/commit/c8836cec14213bf92dae79d353bc345254a0a31e

Note: [2] will be upstreamed in TF-A once associated series on QEMU side is
merged.

Pierrick Bouvier (2):
  tests/functional/test_aarch64_device_passthrough: update image
  tests/functional/test_aarch64_rme: update image

 tests/functional/test_aarch64_device_passthrough.py | 9 +++++----
 tests/functional/test_aarch64_rme_sbsaref.py        | 9 +++++----
 tests/functional/test_aarch64_rme_virt.py           | 9 +++++----
 3 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.47.2


