Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF618FCA16D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfSD-000786-3N; Mon, 09 Mar 2026 14:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzfSB-00077x-PI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:35:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzfS9-0003Qk-5q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:35:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-485410a0a8aso4452675e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773081338; x=1773686138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n+n1XzLbQai9WbGm/ckfBsm2uzsateK7yt/Qy3zcLsM=;
 b=hI34yzxzT3rfndXtG616qoQdC1Oio8RCpMkBtyMEQah32xNkcGNR9LM380ujZYLLep
 Nthcbb15O9BdDeiDhe7y74RvwAIfuWI/6JhWZ2VP/inREUJdTadBoaOpGiihWb6cqtnH
 ykA/v219plzeEEiMSybhowKSDXk0JjmVE8zxKGGWkgng1OVJqEeHqQqSpcYOWrlFvt1b
 SyOv9Xy+/Qe4nOoq8NSG2PBXcnz09nco/S9B7HCIYA6HlOcstL8fubR6HO3gSsZbhN7c
 XLXqZhv4bQMewaAczSOoqPLPUc4H33WRCw6B02FDcMUhwIf5IxUfZT9G43LJnQmSzb1i
 hRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773081338; x=1773686138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+n1XzLbQai9WbGm/ckfBsm2uzsateK7yt/Qy3zcLsM=;
 b=moM7dV08CXuoJ+O84iitCJz914O96CUgxGebEJodRrURoQuThBFFIdgOxMLA5Ufibz
 9bOVlov0U0/T64ROG7XkZgz7pJdZqnnhrzD9fetiCzQCf4ZZE5eiSP7qszgVWEJVV+1R
 b0WlbR87PJNXB3cX9rK5Q7wbXs1QhgGl+hnxAI86QajT/5ddkEj+XAuddV7a7w/PTPES
 nbHGqU6D5vNQ8Bc2vceF3gN1pRR0N6unM7r7Xh0s5MSZEcjiUrN7Gq2fIVS1HRRONyhQ
 Wbl6QGU/jOo2TBNFF14jk8rXXAPwubL+dU0QpxbWfYbkQysBvVipCDFJXrlVUKlqBfhN
 JsJw==
X-Gm-Message-State: AOJu0YwouXe57RSL9qXqYEnAhcKEmXssle+VlVTHPMZAQnKxS4IRJQtK
 JyOb69BcNSQzPLixuXM/zmg6hNEqWOtYBMsuWR6I2pe8+Fni7keZ4FpnO4CDe5Q3yjhJhB+5f31
 7OD5BB+c=
X-Gm-Gg: ATEYQzz1OeyC9e8SMAJZwI0mqPDGKhBNrqOSGHoBLkyMArtyhP9UabcDrJopOyF/QT3
 qezOqFCf0WYn45v6/Gbh2j8q5MWD/Hd45ipKXsPWPT/RuKk1xBNsUEngrsTdRJsyctggJM76y5r
 a0y59H/JJ4AR6X0FI9+5SFXrhkxBGlv/4u+EbBD5R9atbN932oJo/fRLHMQYb74pjpXsm+RKv45
 AerfTmOWiOFMt36DpdT9l4twjoaNI2Pebtxcy0paqupF+aVLipkUomLa06cStxOlfBkEdv1A/Ro
 dZwBHYlAY5IVqXriulbyDomWWzK3trvSlfP7e0ms+Osz8Q7YkcVvEJsBFFgSfzpPrCKV05A+KRC
 HrZ1EifpkC47Hm3DzjzFPRHJ7eA6gQMLsdweYdIycwyVJrqeL5uQyv//GkAnAH52Vw9x9AhgYYJ
 K2OCncYQKCO/SmG4NsLdtk9dfMADUJx7TtNaq/MqfwP35daXrCrV8HFhyE7Pq+++SE/KHgglZ1
X-Received: by 2002:a05:600c:a115:b0:485:3b5b:eb8 with SMTP id
 5b1f17b1804b1-4853b5b108emr60211815e9.26.1773081338186; 
 Mon, 09 Mar 2026 11:35:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a8f610sm17524365e9.7.2026.03.09.11.35.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 11:35:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 0/4] system/memory: Constify various RAMBlock/MemoryRegion
 arguments
Date: Mon,  9 Mar 2026 19:35:31 +0100
Message-ID: <20260309183536.88976-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

v2:
- Dropped "stubs: Merge physmem.c within ram-block.c" (Zoltan)
- Dropped "info mtree" patches (no time to update doc for freeze)
- New Xen patch

Philippe Mathieu-Daudé (4):
  system/ramblock: Constify various RAMBlock arguments
  system/memory: Constify various MemoryRegion arguments
  system/xen: Constify various MemoryRegion arguments
  system/memory: Have memory_region_type() correctly describe containers

 include/system/memory.h       | 38 ++++++++++++++++-----------------
 include/system/ramblock.h     | 28 ++++++++++++------------
 include/system/xen-mapcache.h |  2 +-
 include/system/xen.h          |  6 +++---
 hw/xen/xen-hvm-common.c       |  8 +++----
 hw/xen/xen-mapcache.c         |  2 +-
 hw/xen/xen_stubs.c            |  6 +++---
 stubs/physmem.c               |  2 +-
 stubs/ram-block.c             |  6 +++---
 system/memory.c               | 40 +++++++++++++++++++----------------
 system/physmem.c              | 30 +++++++++++++-------------
 11 files changed, 86 insertions(+), 82 deletions(-)

-- 
2.53.0


