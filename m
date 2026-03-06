Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F6DFCB613
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWex-0004GX-16; Fri, 06 Mar 2026 10:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeu-0004D8-QM
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:08 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWet-0002hl-5A
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:08 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so80012425e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809206; x=1773414006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bNW9OAAW7CqT3slS6bSdmD6LPZ5FjcK1/I23zVmHBdI=;
 b=Kdl90/4XEyuaRK87++hv/3JWa7GqfZANKTWPqLDILqayi81uSKhFT+0xKm7XLXplun
 yrDY98+WGLhCOpCEqu/fQwk1jatM2y27vrwnq9AX5V2iRYXNb5ILh4kJNarHc/Zr9iwI
 y1t2Ml595cyQMyTbOdJYL57d222XeAojwlBjb64Fr41FhbkVm25s/6wbgzpYvC/p8RMa
 wkp51ipj6Luma5h232EPMglqgzuH0b/S7HA2xHeFbLBAgLhz/N4uGZVLnNhQigbQ1OvD
 JOB+lpD8YaWwAczI1EvtV5WA3hyU/mEq+xzwR2Zwyj9iHiBc8ocnWgW2t1c8FmdtviBK
 Gbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809206; x=1773414006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bNW9OAAW7CqT3slS6bSdmD6LPZ5FjcK1/I23zVmHBdI=;
 b=gC0Iu4VuZ44rppHRWHZznFWJ3QWDKIkwoJf3ydRJYp833p7BlgJPXTe5k7ZyjTANEd
 JiF2CKsKkI3NWWp2XzJ7gJ17OfykDlFL6Wkbd3cj+SJMRBiQgHD8oe8YhZ8gQ5AlUep5
 JA45oPPzJ1RWsku4ipf7Tw06LgEvHfB2QLKvcOwmOUxjK+oJb7B5NjKElm1Yuli4c2lO
 8p3rAthnsLKwY2yVDM8uPDUOaiQjJ7P/Mj8tL+hZSvIlxjInhlYPi/ndy/b2UvYbr9MA
 eddQ0CuOkbioGteJoK3WbPQ49v4AA5ajC4nscnXisoD+AeEmJeuzOGHQypLscjRUpRIB
 DIVw==
X-Gm-Message-State: AOJu0YyOE7R/YeVDIzevqL4nWPA1psIqqeFMBU8LH9L9xRROmq1QVTjb
 /ztX2JkaBBt/LChKRnjxYIboe2hWkwGk0yrenao3I34ZKpKe4x6g1WwojyozXJLekKOTsWvaD48
 Fjyz4
X-Gm-Gg: ATEYQzzaNhrUwHoHovWsnHoceGyMLe8vmcn4JrmdkjR4F2ufOI1R1gjGpJDJEVjvUUZ
 9nbUilqvZb2aGPyknBklE3nhitUnBG7vG987Z5jIj/v4QZLkOWL8BPMdC8r3I4FG0CSe658c6ZB
 kEGOWO5GfvTQd2vxrW724qimTc38rUfOOo9zoBJJrNsz+87ONJNHKdHBw+sJmelOUyfUjzxc2sU
 ij3yCPqlXwr3l6++P0ybS7kBk8bER5BTd21TNJYmxOYPLi1X+Y+VO97ol9OgbpcOzq8qDQHg/7W
 KOS/VeCgc5VfzR2bnCNxM1lmKU/k/icDmFUujWdPhtjxion51MmAzlZNh+Jy+fElw+xwRnLbl4F
 Tltsqm3k0lGqA83/CMlfAh4b6maCBgOnhj6f9+1x6q/C5UUvXN0/2Vsd6NxaKDifSe/8OjTNe8e
 jHgfiyxFV8ZQlCmiXtGqiDJzYRckNqiSS0Tbarm5VxZoY2va7BuudYiptBh+GQii4MXNkoCsgy+
 HBHhovnSzKo/IVDYtwsAfc0i1+8cc8=
X-Received: by 2002:a05:600c:1e2a:b0:483:c771:10e with SMTP id
 5b1f17b1804b1-48526957d6cmr36362415e9.20.1772809204010; 
 Fri, 06 Mar 2026 07:00:04 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/49] tests/qtest/iommu-smmuv3-test: Free QPCIDevice
Date: Fri,  6 Mar 2026 14:59:14 +0000
Message-ID: <20260306145939.2162189-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The QPCIDevice we get via qpci_device_foreach() is allocated
memory, and we need to g_free() it after use.

This fixes asan leaks like this:

Direct leak of 64 byte(s) in 1 object(s) allocated from:
    #0 0x622a5f16913d in calloc (/home/pm215/qemu/build/arm-clang/tests/qtest/iommu-smmuv3-test+0x1d413d) (BuildId: bc598be1f4ad6d1a9a600c55aeef36108bdb6a04)
    #1 0x73ee41c0f771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x622a5f1d4cec in qpci_device_find /home/pm215/qemu/build/arm-clang/../../tests/qtest/libqos/pci.c:82:11
    #3 0x622a5f1d4cec in qpci_device_foreach /home/pm215/qemu/build/arm-clang/../../tests/qtest/libqos/pci.c:34:19
    #4 0x622a5f23cc73 in setup_qtest_pci_device /home/pm215/qemu/build/arm-clang/../../tests/qtest/iommu-smmuv3-test.c:45:5
    #5 0x622a5f23cc73 in run_smmuv3_translation /home/pm215/qemu/build/arm-clang/../../tests/qtest/iommu-smmuv3-test.c:74:11

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260302092225.4088227-5-peter.maydell@linaro.org
---
 tests/qtest/iommu-smmuv3-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
index cced49a9b6..dae9821b92 100644
--- a/tests/qtest/iommu-smmuv3-test.c
+++ b/tests/qtest/iommu-smmuv3-test.c
@@ -77,6 +77,7 @@ static void run_smmuv3_translation(const QSMMUTestConfig *cfg)
     g_test_message("### SMMUv3 translation mode=%d sec_sid=%d ###",
                    cfg->trans_mode, cfg->sec_sid);
     qsmmu_run_translation_case(qts, dev, bar, VIRT_SMMU_BASE, cfg);
+    g_free(dev);
     qtest_quit(qts);
 }
 
-- 
2.43.0


