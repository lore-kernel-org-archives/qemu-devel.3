Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC48FEFB53
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvyLw-0006FB-12; Fri, 27 Feb 2026 08:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvyLj-0006AB-K5
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:57:47 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvyLi-0007VN-3R
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:57:47 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4399851b14bso1428265f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 05:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772200662; x=1772805462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ioBLQgdNgP+ui5ljs2ltf2mT4vFgrZDYJbhZDRSubRI=;
 b=lCZ3jd2hOxYCWanR1OCElmDE9MCa5jPOPaeFKwsnOU+u6dLtA+iIgXs0ricJ5CesVN
 XzC8KVXx508vZLtoBrpRjCEwMTDmVGxXpmrzshIFx6C99SRMpoQo+wWPfWq0blEBqWuB
 9mstBWjm3cd+NCc39ibVVDUFjpUrwOJNBBoyXTu/LKjWzeu/+DMSLk0+crm41pjPeVSJ
 L/w3MArteP1jQ2anQQLMASqT+fI91cjKklEqkkuOhEKwXQ7L1b+6ILL6jWFrbMpna2wQ
 au717DbyihKD/d5Rj2B5rYoduZw0qHbHZAAUGgmZqx+0cJ2U6R4+nKMjqFtqPT2JNRZq
 ifww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772200662; x=1772805462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ioBLQgdNgP+ui5ljs2ltf2mT4vFgrZDYJbhZDRSubRI=;
 b=nZsNFRKU/o0ikN19/4gGJyerXSyw7/tSFcspeGZsLn8br7G7LcazcZdZmOmitmnv+T
 L3n1jEv+5SMAgiRmLuQ0Zjv0JHQUYNitT7aJ070TNuUvDqUUgtzqfko/ShgPywPwunAn
 eST7I0jFCzYOpqIIvwokt3q2hhMCLLaBAms1oDeFHyHV1XAGJQxJgJc7DcFgNQ9hnJ4z
 +iwYvbE64a+PsXlWKzkhkNzoahdkPVx6/mtAyGynmRpVICKueB002m9BdwkEERXR+gs1
 ZQPGOKpN1HJswABAeSVL/k+8q3W2stbfh2CYkqehcxQdkSdQdwNnSRzED4lGov1laCXe
 b+DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBfQNhNdjJ/Ks7iSb8mG21VTiihMcqNS3TXF4n57owQbhes4RWwGL0HcSM8SMXcbUmeiFJ5WLIbqi5@nongnu.org
X-Gm-Message-State: AOJu0Yy8knG+GzPsNkE3ZJvcY1J4ok9RDTDkPnMca8TTKbcH3gTeAuvU
 yGUJDGpMRVYIZXnlUhSF08RLtDv3RR6gFqfZqgWL0wbtk1Pra1UyZQfWoQufBUI7m8o1NYU3wGs
 IISOp
X-Gm-Gg: ATEYQzyuYiTQkl67pUuVeAbpMkUmeuYSe18hs4hrketu7N+/ZyMAvmrtfHUSvwD90Nr
 CHe5a1WA6FD/iRdxqIA9AP45ktPA9r5rQozhHy0/YtThQ+AxDE9BvLjp7Kc4k4SFm13dr/zOZLS
 5s2YRg2J1w4wRJVOtmoxSWMGaLejCADhMtP2pNEmySlEJASiGrhQCpVQa4E2oSuORdUVDpi/gsr
 KCVP6OuD04yUQ8uaTgGI9yg+pp3Q+I9RYuJ9n+n/OF2B277HSPHPodnuQSMOYfyPpVChiUvhXrt
 gjRCmhiGzGgYyjSgn92pAeVsoOWg46h3JYRaL/f2/ah62DXU1nX3NwjRb9P6qAhvlu1wnGh7T1D
 912AOwUTPqeQmE5En8CMOYER6gjDQ224Fguo9bkdBr5sAgezrHmC3EPAwyILaBucKvQep2v14V5
 bGXAWS/3hqy5y+p4/W+nYiN5KYBaFnfYdtiqmw/xOr78hXkgZ/eB2iQOUB0fcUvS7CBMNQPRhiA
 eK1I3hAAcm/dAErtAirtAvkfaJ8Dm8YmqCM/hO2EA==
X-Received: by 2002:a5d:5f52:0:b0:439:8f2b:7697 with SMTP id
 ffacd0b85a97d-4399ddf1324mr4712039f8f.16.1772200662552; 
 Fri, 27 Feb 2026 05:57:42 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b327sm7655163f8f.20.2026.02.27.05.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 05:57:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 4/4] tests/qtest/iommu-smmuv3-test: Free QPCIDevice
Date: Fri, 27 Feb 2026 13:57:36 +0000
Message-ID: <20260227135736.2280161-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227135736.2280161-1-peter.maydell@linaro.org>
References: <20260227135736.2280161-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


