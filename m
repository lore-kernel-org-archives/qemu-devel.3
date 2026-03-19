Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06021091904
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3IlJ-0008WH-DF; Thu, 19 Mar 2026 15:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3IlF-0008W4-RR
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:10:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3IlC-0008EG-AF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:10:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so14064105e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773947420; x=1774552220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vU8ZyooruV3h3bAlmHkr5VcsSDa9nsQZcNL7OQ+2qtU=;
 b=QsEJtpSCHg6JtAfvpZajtWoval0b0BVngeMF8uaKGy9ET7VFvlqyvQu3/nHPpmbo8W
 nNLHwO5mz86qu9WYH77O9HNaO9dRqYkfWN7lg3VgwBDPAtOGu3Q0mC7vxRQUUdV/G67L
 GAjMZ7mBJPtApIFRNI7BXBWsCBjwRZptf6sRVMs6oZ20ux8KvElS1d8mPvnFOsY5QJrE
 Lr9CpQCuO29KC0w+0mHzfT+WTaz93bfQElFR29RyG0wbAsmm2Fr4Io0ErysCXxFOq6Uw
 mzdAfoFANF5jVgbG6MeBWMmTp9c+UTnybNwtR3oD6o7c7W0uhCr3hrBV3Ep0ueLfrXnQ
 AUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773947420; x=1774552220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vU8ZyooruV3h3bAlmHkr5VcsSDa9nsQZcNL7OQ+2qtU=;
 b=ebocgB63buBtJjsRQpmELxS+Lc36eVTVGi9HQ/PpQPJsgFLrRH5onsDRljrHxqZOX+
 EJqPdytKQLp/Zpi8hv+llETZ0HYT/9aFf6kHcv+wbJ5i3K8NnlUPIKHiPb1UpVHeYDqy
 3ctrUT5BNIY4ViTHPeR2IpJmb4o+5XcMVhy5kyGYOXxPTKS2YO+kIEYELVgoLjcY90/h
 3vW5htDgYmdbGdzMn3QiVmCLx7ryEJERBOdQ6JMBMMvHfzBlUKnhnuEKPTs+6aD61vAj
 2qTtinb9cRYrb1gSy0fnPt5ZGZ1M0GUbfwTlOA7GVI7/W42ePYcRqFmi6UYYNGx9b1Po
 LktA==
X-Gm-Message-State: AOJu0YyUWDSTSJbgQX7FcPMZklUzG1Bx81Df6kvYcsfBw5VaDoOcSLBo
 faMIb8w6PQBjY9H2J91Jt3UEl5EXzXwuN8x2tfbnqFHq5jAZrOlQ5g/qIJraSj6flKe+fJTCv/b
 d83GG8So=
X-Gm-Gg: ATEYQzy/7OfmncoR5RCjuKBuH5BHkCGeW0IGzJrZZ6PV9gYSiPJDpPulctLCD4iMSCf
 4Qh9v5IU4YUkTdx+TlBpVYblz5u7fAYJa3dm5QdFwA2l3HLUOfaT6oEaDbZzwX5QYeB46Cexgjq
 9d/S5icNAMvmrfwPbxo4QwYl6kt073sWvvLRHzaUf0XjL0ckQTNY01iuXVvpqBAeFN/E8MW+Km2
 uJmifXaqrmQ+mG+NWoINKHNg5F3NLChGzPQ4vJvaB8bwTc0V+Yaxw1cY6UCvdtH0ZLZGsf/xlmL
 PjSKd6VXn6ca6bzIQfEx+QScZd2LSO1JzSFzXZhbjAnU/nD/3Mf8Ldn8nWvSAE75u9Y+/xG33Qy
 qaqdrlO/y0YyvniQGD/lLWfzaGwSjxMnyIWespw68IWiH8jeiiCU7VOTgC8NZxzdP5AoSQ9OFQP
 19qn26nX5shBdulc5Z7s4O8/MG/lgyJ7ybUIyI3bOzmwrcJfHEQWHfxEVxN5QMyIhJ8blO7NhC
X-Received: by 2002:a05:600c:8b61:b0:485:4328:407a with SMTP id
 5b1f17b1804b1-486fee1485dmr3407105e9.19.1773947420061; 
 Thu, 19 Mar 2026 12:10:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe68ec05sm18762585e9.0.2026.03.19.12.10.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 12:10:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 0/8] system/memory: Constify various
 AddressSpace/MemoryRegionCache arguments
Date: Thu, 19 Mar 2026 20:10:09 +0100
Message-ID: <20260319191017.12636-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

When structures are only accessed read-only, it is safer to mark
them const to protect against invalid API (ab)uses. This is also
an useful hint to compilers.

Philippe Mathieu-Daudé (8):
  system/memory: Constify various AddressSpace arguments (flatview)
  system/memory: Constify various AddressSpace arguments (checks)
  system/memory: Constify various AddressSpace arguments (xlat)
  system/memory: Constify various AddressSpace arguments (flat-range)
  system/memory: Constify various AddressSpace arguments (notify)
  system/memory: Constify various AddressSpace arguments (cache)
  system/memory: Constify various AddressSpace arguments (access)
  system/memory: Constify various MemoryRegionCache arguments

 include/system/memory.h                 | 32 +++++++++---------
 include/system/memory_cached.h          | 20 +++++------
 system/memory-internal.h                |  5 +--
 include/system/memory_ldst_cached.h.inc | 15 +++++----
 system/memory.c                         | 18 +++++-----
 system/physmem.c                        | 44 ++++++++++++++-----------
 6 files changed, 73 insertions(+), 61 deletions(-)

-- 
2.53.0


