Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810DDC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 13:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seaGz-0002ae-4j; Thu, 15 Aug 2024 09:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seaGx-0002Vd-Bs
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:12:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seaGv-0001Iy-LG
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:12:11 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42816ca782dso6004095e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723727527; x=1724332327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fQeJTGYV8gJkGc7HH3WsnrWzsRykqMMD3HBZvBu6UDs=;
 b=Grxdt8IxCsdkj7RPeI5rZW+Y2p0u5fVFjWLO4zRDYkOW/x6Fb/ZkMgA22jTaGZXaIY
 TKJu394L6jKRiKzxCxPtMo9e/P9TQ+4tkcqAxUMUxNrynCcCsuHuK1jOcQqAGizkfidB
 B3y9oYSK5V522db9QkxvPIPmWjJIi0H9J66VgHVmd7pzKZWH/kwmvbtWzCYgnHrqtty5
 +OX4k2RhyyzeLwgSfWiWQlrj+JjADE0TQERH3FuFAXWSJZUTrCuFNV+CBU6AqV1aEeeD
 0bQpNiV5bdBxv/TDZ4Kfe/RsM6a2u/9/dBMVOVrXVXlVvy1xCENYkHljWgXtP9tSIehL
 DFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723727527; x=1724332327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fQeJTGYV8gJkGc7HH3WsnrWzsRykqMMD3HBZvBu6UDs=;
 b=o1hcpa+tJklHNFMd7AnJKUwaIPPdRqRKs4nf3PKCaDs4pA7VPa7Nr6F2jrBbaCx3dl
 4yrT/4rgmdqa9BNNlfXy0FxFHN9G7onJvQzbAIPKKUH9CkaS0l2IYyi5XRHgi0o83TbX
 yCVW9Z5SuEY5tWCAxVnG314BxJa2fwTrHjN3NxjZOqayNy9vUC8zWRXr7Wtny44SDV6l
 qnRTeqTCtKXPefWSj+iMMorLmidaqqUH14okbjtBuLxZfNDCMGyWzJoYPwyj6VRFYYUA
 CwuzRDUfsOA6AqT5BkpexiJuRcD/LymwKDd9HG1XZQGu1gfp4dovoQB+oqaym1wllOXv
 xRDw==
X-Gm-Message-State: AOJu0YzYEUJb+v05ItIhW2D+wcUDkMvJeN4BS4U2ucn9AQMpwEYyQr2b
 USaDA7b1dUmI303VmGiGdewKS6qkWDftSKggEpTtmdVIly0ORBR8eFEivyKSqBmF7p82AyHR2Jc
 V
X-Google-Smtp-Source: AGHT+IFS+sLyRC/qR7BJrQtnBrVlosZEqjPFG21pr9c33m+Exu7zne8FxjHk/NGcCPg485Gsx7J76Q==
X-Received: by 2002:a05:600c:3155:b0:426:647b:1bfa with SMTP id
 5b1f17b1804b1-429dd22ee1emr38363455e9.8.1723727527369; 
 Thu, 15 Aug 2024 06:12:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded19627sm48269935e9.5.2024.08.15.06.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 06:12:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH for-9.2 0/2] accel/kvm: Fix two minor Coverity nits
Date: Thu, 15 Aug 2024 14:12:04 +0100
Message-Id: <20240815131206.3231819-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

This patchset fixes a couple of minor Coverity nits:
 * a can't-happen integer overflow when assigning from a long to
   an int in kvm_init_vcpu()
 * some unreachable code in kvm_dirty_ring_reaper_thread()

Since there's no actual incorrect behaviour, these are 9.2
material.

thanks
-- PMM

Peter Maydell (2):
  kvm: Make 'mmap_size' be 'int' in kvm_init_vcpu(),
    do_kvm_destroy_vcpu()
  kvm: Remove unreachable code in kvm_dirty_ring_reaper_thread()

 accel/kvm/kvm-all.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.34.1


