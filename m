Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C47C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfgM-0004y7-69; Fri, 07 Mar 2025 16:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgK-0004xh-Qs
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:36 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgJ-0001jI-7y
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:36 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2235189adaeso40782595ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384594; x=1741989394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vmW8mpO+51LbriEKWobYb1vkwz08PyFagyva1YCnsvQ=;
 b=WqCclSze4Vm5pJ9B9fFH0O+WEMAagATv1UeIKdE40vwmwFGcOyPs0ggR0XxGG1Uryu
 se24i11UP8ifUCy9zYN5AnpIf1RRGvCWKtYIP8eqNnmoziMnhvS20BwdKpECzbDb+hNo
 8OLGjvbXhz3nURxWA7fwTk5gFHq9Cg/SOKqA26h0cZRbkxjr8LJVjmeZcSZfvyg/wVdg
 1Z+syHWa4gjFtjVrt+kbRYA/+w3d8sGbanP9k64A9F2FQ+UqRGYPqy76yHOhyA2wz7Ii
 Q8HMiZQy9oF8sLGTbeeSmv4Jpzl68qFICVy+16lT2N+of9wLXjqn1uQvJnbxDfeUMPSi
 eOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384594; x=1741989394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vmW8mpO+51LbriEKWobYb1vkwz08PyFagyva1YCnsvQ=;
 b=jh9qio3xX8badGspczFBuuy5AS150k/vZnSb8pbiftPgcNBJ7gqOhP7nLUMq67EzW/
 guoO6cu5lgxpSp3oHkt9C7Z5uP5HMfFuBrvyFnGkEKtMMqLBl3Pdfvxw60BvhSXcGYu/
 wdMwhFmeY7REgX7K7l/Phwo3XEkMr8rnXJdBuyZPxYKtkIHW+mlJDl/sCkmtOdN7/WA7
 E2C/HtJDVuWxCnYx+/9puwkqhH8xc+Ap2qWNIiPKT5kTxiaLagSu8SC+COV/49fJNIvC
 4/PAteREHxZs5iO3FNX/PhBkRQC1XZVIRVyw3Fl6oGw+XRH4MC+G7hojrLcqk1ltVoCq
 60zg==
X-Gm-Message-State: AOJu0YypAp00aQZ+VqDfKfG0tul2GiYW38FLcNLBjg0MCBKz5MInYaXJ
 MRZ1dloI7rS/9cMxaRgQxlfjpzcE04O7jFUS+7JKXk10vEhB7xzc0CbUp/aYiFOURQ4eLhkwhR5
 e
X-Gm-Gg: ASbGncv9VedSGENjsHP5XHxwbKnk1sSAEO7uUcnJq03F0UwTzTgWCgPlGesNg4bTvMJ
 JHEOUmqg04H4YxvCabjwGP0QAW38je19IxVPq4c3r2roOkYHQjo5IcLsccn2xf1sY8+0TeFc64S
 d/ZOzYN35FjfjAjksSWHNWP/1W3Uvhs31bmVlXreyn1kWLbD/NrMJSaNa9NcyU+tLpbnW9MeN18
 tAzzXc70QFny3Uvr0VxKZXC/VSvfWw6ne4ispHM9urJLBvoRbbfyYRD7RrVwgJjvPNTNhztubXo
 wnfkXDyAYhDcu/WENBMnLbscSENUJAooIA1BAkcdS+Sn
X-Google-Smtp-Source: AGHT+IGZj5v3f7xS8vJEb0p8ApYtBb9xYLDO7DIkJnv8r93Ui68HFQrEuHLB+G46dT5oBoz88XrvPg==
X-Received: by 2002:a17:903:2f82:b0:223:fbbe:599c with SMTP id
 d9443c01a7336-2246452f784mr19947915ad.19.1741384593835; 
 Fri, 07 Mar 2025 13:56:33 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ac9247dcsm2000927b3a.125.2025.03.07.13.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 13:56:33 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 pierrick.bouvier@linaro.org, kvm@vger.kernel.org, alex.bennee@linaro.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v4 0/7] hw/hyperv: remove duplication compilation units
Date: Fri,  7 Mar 2025 13:56:16 -0800
Message-Id: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Work towards having a single binary, by removing duplicated object files.

hw/hyperv/hyperv.c was excluded at this time, because it depends on target
dependent symbols:
- from system/kvm.h
    - kvm_check_extension
    - kvm_vm_ioctl
- from exec/cpu-all.h | memory_ldst_phys.h.inc
    - ldq_phys

v2
- remove osdep from header
- use hardcoded buffer size for syndbg, assuming page size is always 4Kb.

v3
- fix assert for page size.

v4
- use KiB unit

Pierrick Bouvier (7):
  hw/hyperv/hv-balloon-stub: common compilation unit
  hw/hyperv/hyperv.h: header cleanup
  hw/hyperv/vmbus: common compilation unit
  hw/hyperv/hyperv-proto: move SYNDBG definition from target/i386
  hw/hyperv/syndbg: common compilation unit
  hw/hyperv/balloon: common balloon compilation units
  hw/hyperv/hyperv_testdev: common compilation unit

 include/hw/hyperv/hyperv-proto.h | 12 ++++++++
 include/hw/hyperv/hyperv.h       |  3 +-
 target/i386/kvm/hyperv-proto.h   | 12 --------
 hw/hyperv/syndbg.c               | 11 +++++--
 hw/hyperv/vmbus.c                | 50 ++++++++++++++++----------------
 hw/hyperv/meson.build            |  9 +++---
 6 files changed, 52 insertions(+), 45 deletions(-)

-- 
2.39.5


