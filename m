Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA17F4368F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDh1h-00009o-Nv; Fri, 17 Apr 2026 07:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh1X-0008PE-Ee
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:06:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDh1V-0003j5-JK
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:06:10 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so354327f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 04:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776423968; x=1777028768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eeNtk+biZKcoxZRr7VwHdoOP/dSEF6ejSZGgF6c0V9Q=;
 b=kSfvc9ERted1Iad9q4ZdqoLnDBc/DJZvlE+js62bYkQ107RlF6mHgFFZkyAEX3Yxin
 XcZKju9pWOna4ZoAdCLy/yVKB0EVAtWDRxUCAOHEht2RxNHIWSdiI0MM9wGPQ2jpuX7u
 xnIVqvwKIHMnDsZ2bBt4D8WFrWGRpASi5eoqJOQ+wg6UIXOSr9w/uSj0UxcmL0ossMg/
 t9t3jFZUag+6s+UZrB44PSsv8xHob6s6nXemMY6FE22csFQYmoewiPNHVSIKTFkNTYXu
 1bamrqoGLXY4oRXwUDcKcWEL2xaJFycdguU/Ct9/jfJ8pIpoHqKo/m1rosNw9RJNB4Jo
 0B4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776423968; x=1777028768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eeNtk+biZKcoxZRr7VwHdoOP/dSEF6ejSZGgF6c0V9Q=;
 b=e6IzuI+3j1AD7Do5IfvcCrWfYF2ZgxwfFRSKgRrc4imrnbbo5wEtktwWQ0ZUIoH5N8
 QUYEvfPOJ65/lZ046JN2uz4sTo8TMOuKEUgvH5KD6uerA6UQPuunXfGFpwV8gYjXFcB7
 +t1JId67Sssn+Acy2YLnRKfJyenj5iocxVkh1KzZ/098iy1UaNcZpjdOoYSmKiUVmhBi
 xwzqmtScc9FZd5ut+fO3c7gYe248sWT/ZWV+6wHtO/uzuLlly7GaiXGSW7GOn337fHxv
 HaTZbe5miQL8z00Vao3HlLBcWKzVTMkxttMZWSdsCDD0eoLQAxiMXWX0qVH847KJ1RHU
 fqdw==
X-Gm-Message-State: AOJu0Yxmc3GCd1SiHomIr9GPv7j1wjJe2zy8NZII3DaznA4qn+eKvIQh
 jQycQMOEC2QXzrfWkaxYGlRFKyxUYvp+Vfkpd5wIIxpovngVWSWzh+w1kKyIZqxKY1eei7RKDcC
 20zzHtIU=
X-Gm-Gg: AeBDieuYro0DdjJZQfNfXYPqDoyCx74Nud6c8ScqyKvqWcneNfG869U4RsmLXToJHf6
 OKHilv487GddTihvRAOemog6x/0KzZyyC5qPnTGTaRJ3CD6kXva4F7fZhihcQ4HWwAkPbe4/Kkb
 O/RejB9cyxxl9iCVX0uhIt3JHW4mHnsl9J0buklVMzUD7tHJEVSh6kUTz1HBxWoiSPMoboyBtNe
 rukkLJQjq7oVakD0qSscJVNIk2EFKJWpUOcmLuORMagyJETsDy1k6M0dQFT1lYxLN2U7ZKO3Aim
 CsSZEHj6GqxRnSMo9hqzj/uzBQxwq7y0vuSxCC9aPVe2StLXCTqN3JjBMVnUq6hkTRCkbce+Q1n
 Ok7JqK1vURd2uV5jwZf/eIWEoAJ5vX6+hQaMGgROqs0WL3MKpb4NR9lR7I7PmAk0LXKIb6hNsPi
 BmYBOsn8cbyX5RX6+Wo/B4/bvV51IBR3Sfj9jzLaofPUtVZPqhQmqUGDA+rVz0F2+PtmANesMSe
 YGfSGJ+er0=
X-Received: by 2002:a5d:5f46:0:b0:43d:761d:5423 with SMTP id
 ffacd0b85a97d-43fe3dcc03bmr3503456f8f.16.1776423967586; 
 Fri, 17 Apr 2026 04:06:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d5b1sm3859352f8f.30.2026.04.17.04.06.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Apr 2026 04:06:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 2/7] MAINTAINERS: Step up to maintain core machine code
Date: Fri, 17 Apr 2026 13:05:44 +0200
Message-ID: <20260417110550.70068-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417110550.70068-1-philmd@linaro.org>
References: <20260417110550.70068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

The 'Machine core' section is orphan. Being acquainted
with the code, step up to maintain it.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Yanan Wang <wangyanan55@huawei.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0950479ab2..11bf50a9ecf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2006,9 +2006,9 @@ F: include/hw/i386/nitro_enclave.h
 F: docs/system/i386/nitro-enclave.rst
 
 Machine core
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Zhao Liu <zhao1.liu@intel.com>
-S: Supported
+S: Maintained
 F: hw/core/cpu-common.c
 F: hw/core/cpu-system.c
 F: hw/core/machine-qmp-cmds.c
-- 
2.53.0


