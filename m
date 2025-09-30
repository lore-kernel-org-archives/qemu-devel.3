Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A42CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3WSJ-0004vI-Th; Tue, 30 Sep 2025 05:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3WSA-0004rB-1T
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:15:23 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3WRr-00011v-VD
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:15:17 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso4433113f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 02:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759223698; x=1759828498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LOadWaIV+z8ZytM/LHRkBdJ4uNgNIismo0RU95dZe4o=;
 b=sPCA2nue7uwL6Mk74ID7m68gRT3OEsIvzD6wOds8XZ55mv5bVohE7I9EFXOhKaYNkS
 Tzn9Upw5BawyryPJBk7u2cIEvQcL6+ZLQZHz8WOvzyD4rja8U8Abi+Fm/w213ggnZuVj
 ouvXoYz2ABZm7yEskLQSE8GHGTds70Ys7/aKp/+RIr2xISPxc7vC94gg9ulW/FsY53l2
 Zm5SaWTLcxqIGd7Fmbu1ptIgIVTsP+1XMdgPQP8559rwC3vxS1FPtg7Cp4/HafxDAPB4
 QOglO+255scuaGgWjloibhVvQFzN0iTMfPx2rcwsqUlrsSRDL7IpJwRTGWQ2G6mJJpTt
 idOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759223698; x=1759828498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LOadWaIV+z8ZytM/LHRkBdJ4uNgNIismo0RU95dZe4o=;
 b=c5j2VXIg01Q0UDUn+ZAB2hruU51j3S/aEVnx+E0D1eHsyVu60d9nAf45O6dTgE4y90
 wuv1ieQT1WMB+fjlF8yPhIL4jeyCzGPM4F3XUvVctOJjjm/HYCJEd/ACWWMy2WvXVAK5
 En0Z3IfEWZgPVpEaFnG97yOBRft9H0n6f+LMGYYl4bNmMBgcQQefBW8vR/fOLnmw5zL1
 VfO2WKu17RwRH6jO+Fd9Q/et1PXG0XoZR0bgTwEfALWl4seaMiXWzp/7Ou4rK4LKeDPo
 gdLVf9R5oJ/L0OD7+a6OM6Dbwll2R6oQiGgQzFQC+EkawArf4eK/pnimlqqWhFDIK6oa
 eRzg==
X-Gm-Message-State: AOJu0Yzkb/jIV8ZAQFfJ/5Y7Uv2b9L4YZQpU9WnqSKTd5EXU8025HZKc
 v+hg0+hWRaPG28q6VAkpjeXBWU3lgmYmG8KvNi0CG+usW2bxMTQdSZmACx0by//Wpdx6zsF369N
 hDQpyj4t7yA==
X-Gm-Gg: ASbGncujtM3acaobPfXsDdR5Tus0JMrGGD5ly9ipDsqP5R4aKmhFdSKh5LPm6Yp5s2E
 oqyNFrfU5Nj4nM/rk9uuhkl8aIueh5vgXazOQI0My26qfeYEdl0avKXO6rA9uggeV/7rj+/Fj77
 0aJBgK476npUT9/07anoYpsTRFT9cRBsSikoOoEfK2Vtu4SDWmklHxA3Vz+4k2ElP64CyfgKwa0
 ZFH85FWLaC6Ta83VguID3j/Pw3zc3kyvejylZ3cP/aJeZrh0iFG+tRPP+rfhlQsQrItmhgVMq3g
 xqVFFDoIHDxENO5kw0ItKfIJ5CIfmEaoasOXQ+t5F+RD3sUdy1uUNV102oBFxxienXgUrxCVsgK
 tia4pDaeNBtFeW0vwWv0pg44cL6FbDJbARMtiXlZmP4oZqDaFd6mSEKtOWIKsHEhk8StXmFAhOu
 r/mqfcyNT6HfAr0EAtFg7kh2hAU+5yFtPDP9X0T3Lb+g==
X-Google-Smtp-Source: AGHT+IHeRdGEEz0PnNdqAi/SsdZ+SHSTE+Z2PqgPuH5/chRHRD1VO7i53Sq7sWKh5T+av6YjIxn/CQ==
X-Received: by 2002:a5d:5d87:0:b0:410:f600:c35e with SMTP id
 ffacd0b85a97d-4240f823631mr3026681f8f.8.1759223698201; 
 Tue, 30 Sep 2025 02:14:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f3dbcfsm48381905e9.3.2025.09.30.02.14.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 02:14:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] hw/vfio: Remove invalid uses of ram_addr_t type
Date: Tue, 30 Sep 2025 11:14:53 +0200
Message-ID: <20250930091456.34524-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Replace ram_addr_t by either hwaddr or uint64_t types.

Philippe Mathieu-Daudé (3):
  system/iommufd: Use uint64_t type for IOVA mapping size
  hw/vfio: Avoid ram_addr_t in vfio_container_query_dirty_bitmap()
  hw/vfio: Use uint64_t for IOVA mapping size in vfio_container_dma_*map

 include/hw/vfio/vfio-container.h | 13 +++++++------
 include/hw/vfio/vfio-cpr.h       |  2 +-
 include/system/iommufd.h         |  6 +++---
 backends/iommufd.c               |  6 +++---
 hw/vfio-user/container.c         |  4 ++--
 hw/vfio/container-legacy.c       |  8 ++++----
 hw/vfio/container.c              | 15 ++++++++-------
 hw/vfio/cpr-legacy.c             |  2 +-
 hw/vfio/iommufd.c                |  6 +++---
 hw/vfio/listener.c               | 12 ++++++------
 10 files changed, 38 insertions(+), 36 deletions(-)

-- 
2.51.0


