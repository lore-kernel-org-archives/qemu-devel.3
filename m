Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E75109191D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3KTG-0006iQ-SJ; Thu, 19 Mar 2026 16:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3KTD-0006gv-6i
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:59:55 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3KTB-0005s1-1v
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 16:59:54 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35bb7afdc38so919079a91.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 13:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953991; x=1774558791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pkmd32xFo5bwhSQnQC9HJzlY+NYxJbF4ADfY4Le2asI=;
 b=XvcXD7XaNxmJUCEk5foXQtRoqjGTvGvMaAERa3c914Y6Od3v0OkXuBLYggMgGU1fyh
 rkUoJC32vEN470sAdVq1SCLKsqleo44RGMH5NWF4X4ODzCVM++QI8Kk/eBqlWSZdTLm6
 fDVamAD99oHV5wvEixdLjlEcoXdycbV8rarCi6HJSiiJF/1VBcRwhdDx5CKRgf7GvvzA
 JH6um9Kfav0oihXso3kb4SwNfdxkXdVX3Tf5UmBcQf9Vu3jMccARUj86IAJQCJJp8pQW
 KKc9fcSfVHCVz8a/LHit+HWCR/mIoOsRolycNDWE8BPFl9qlCEQFpzHa/a390UdhxbMV
 x62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953991; x=1774558791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkmd32xFo5bwhSQnQC9HJzlY+NYxJbF4ADfY4Le2asI=;
 b=jVg2kA6dDVnee2oZcz3NOlsEYLpiMMNdMo99U0wB+TDVkcUPXmUOeoafOIAU7pfWkZ
 ezEmQZl6vXDcXCpRgvlni0yUM1LNBRkZmnVDwDZ+gIjCz9IowBqxB5M6r34y/hpVQ+EV
 KFkfm4+Fjl95eFkSCSaeu0mgpy3nqmd6dxxch2yWOFzpsRIf+zXupKw4nQFPiJWDeJoM
 fEolV/F6BCEJ0OpM+njI8I81YZmCLKL3i8uh4A0ZkrquNKuJZe1TVModcXLdtPPwmyoR
 HaIwMe4KTfaE0jFm4rkx3NxIEo9lMvgO1EEXhc1n1YxeNkQsZ5WFyIAJdNSp6jugysXs
 kU2A==
X-Gm-Message-State: AOJu0YwXXnP51y5aSVsz4wocnoaoluCUUQ16WDme5ZVq3r33tMedRTfm
 UWeQryd7M3pe9jmp3IbAExdbio3XR/Ra35/DMHxMmK8XFtxfZ4+NYTC+SmsZbjJHn2WhZYAKf/c
 UAFjg7Ac=
X-Gm-Gg: ATEYQzyPEphBcp08EQERNPKyFXGjMr2cka+VpSnIdZuYw5ogMc1TMGU8fWje5JiY2fk
 LbSnX67WEVJTe3yvq0MgeeN89oPMSAU3Cigru5LMi2fgWcJ7uF50I3q75HIquhKFcjfLHSOYmmS
 Bjea2jMwxpE5LP33q15+hTDwqdlFaPf2PuRI4wQA7rX2cYWSuzgcFM5mJbZWCSdSaPC3FNISQRh
 pkh3dtAHnHEPDYpp7IUR+X5TE+B1kyaevN7bmVSBceo5zonWrOZcfglUAWBdPC6/WMJdJqKs3AX
 TJ+hJzglqGUoPDVNprdjEz1V96WJ43l/KXwx3HJUDOlUQAIz/azRMSs/ESA3Bu/VJhGllkAQCav
 xA1qprBdU1hl8qtk0wt/yyszBNIJtUAZd5CQAy6Sf83YiEX4PhD8fFEEkUz83lbMNXiO7ddpuat
 YTx/hYeV3/pBKMg95Tr3ROlchIY6vUWfYWMhZ+tLdN2V01gC1i6DXMqoeITxJrZj2F7/AUiRno2
 ZxJ
X-Received: by 2002:a17:90a:e7d1:b0:35b:90e7:c458 with SMTP id
 98e67ed59e1d1-35bd2bba0admr441241a91.3.1773953990939; 
 Thu, 19 Mar 2026 13:59:50 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bd40e4bfdsm31273a91.9.2026.03.19.13.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:59:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 0/2] iommufd: give hints to user about kernel support
Date: Thu, 19 Mar 2026 13:59:40 -0700
Message-ID: <20260319205942.367705-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

Using iommufd requires two different kernel config:
CONFIG_IOMMUFD and CONFIG_VFIO_DEVICE_CDEV
https://docs.kernel.org/driver-api/vfio.html#vfio-device-cdev

It can be complex to identify what is missing when trying to use it. This series
gives hints to user about it.

Suggested on:
https://lore.kernel.org/qemu-devel/0cc139d6-9289-44a0-9122-d701426dae0c@linaro.org/

Tested using a cross compiled QEMU and a custom kernel + debian rootfs [1].

[1] https://github.com/p-b-o/qemu-linux-stack/tree/device_passthrough

v3
--

- more accurate check for /dev/iommu presence in iommufd_backend_complete

v2
--

- Move /dev/iommu to iommufd_backend_complete, so we can report the error
  instead of aborting.

Pierrick Bouvier (2):
  backends/iommufd.c: report error when /dev/iommu is not available
  hw/vfio/iommufd.c: report hint to user when vfio-dev/vfio*/dev is
    missing

 backends/iommufd.c | 3 +++
 hw/vfio/iommufd.c  | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.47.3


