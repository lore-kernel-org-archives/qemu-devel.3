Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2C9F4180D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcx8-0000UP-SZ; Mon, 09 Mar 2026 11:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwq-0008W1-PW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:18 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwp-0000e8-A8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:12 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so1793656f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071709; x=1773676509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NCORoNPQHDOcsEAMIb/xmUVZv8e+uBI25ItL/f7mOyY=;
 b=MG2UuKGiBV+XkBOXqUzjbT7qWYSGRLJCfihtVabTAhgfQ/BDrQKH1ylQK2c4oo3haZ
 UOKZCTeyHQ7L6KKLmk2te+Qw3yI0kB50s6a2a6HluIX8+b10/fFHPilHYTd0MuRZndNH
 TooEUv0m+bISn7EJvr2JrzVRLvA++XMBqNSkC1/3d/0nAKR0tQ2K8tAxJQQd3UnCfSTV
 vLM4B0s/BZFo56S1epgEjzWhB6MOU3lVTGk0M6ti+1STbAlO4v3s2bVoKLZgmUNkB5TA
 dcJPQRyAYLdJMfkBHGy4DYouQ9PVZi9wc7hI9osqMW11RH2BlPWk+0B1/8UK8gumYvHv
 wZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071709; x=1773676509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NCORoNPQHDOcsEAMIb/xmUVZv8e+uBI25ItL/f7mOyY=;
 b=Ax/uZd7n7EzbnP/BAtywwDvWRPFxz0rEGx558JXE6epIdYHPJOn07Kwz3Bo4SXA1P9
 bS6FvI7vW3msw7mfEtTpOm8BA/ceX/tvpyVPgU00KBoLY3keWYeMckL0AAVkCCrw59Hu
 CgCTT7v33vTDocIJ/w6UlVv79lsZN2/blI83wSKhiAmPOh41db+2xvrHz+LwAKSGmcua
 hiI4/gDD7VrhN8E5pBHE1JeeMb8BIe201KZiyi9qaJ0MOMXNUXgjL+g7ptRwasdE+f75
 FpnOt9Dw8xnxjenMt3fiLhLQOcgEDHv9+fW9CusGyFXyEu+VTFH/wzZHxoR+92oknPC7
 uNwg==
X-Gm-Message-State: AOJu0YzayKCwIkxVtKLIsO9bSXjkoaclSO9XY6k9G80OVrGzA1u6N2an
 tQZZSzv3xpLeDi0tYReDNMWiUfdxF1VaFhTeLYVW88XlwfCuAC+Eb8Mtb+k1JaeAnCfweuLwvf8
 k/aA083Y=
X-Gm-Gg: ATEYQzxLY0zMta8x6MHs2qaneGSIaLcdV44IibQ0NO3tOfCMiZj+XMR9jAg2BJfFgy4
 JKKsfk9Hy3bfT0oZ6NVv9JNlwUrImrnw0bueg/RDN3dzyU5+0+aJA7w5JbEfwM1p9woW9aQyOFV
 nqv0kAd0+zKdRYttbNSwkLNJxVbiyWL5LFKtbydkw3dTAq5MBAZp0I3UcPRK4npTKFj7j0Kl9QN
 CvxUr5nW5QFakaY5fklk8jx5btKu8qRwNIBYvd1BfqvqbsoJbaGMSNm5S4YBaUuekVN9kIh5Z4v
 lXrTHRNYaoGWogD9etjV88SkAqyKPovk6OZPq2CZ7DuAggVpCUUqTfXyhHLXjd31fD+VW+U8qJZ
 N1snRSma65GWPozoVI8ZQM9qhY21iOoWrMLBqZtTJXXi6kunvzXHhHxJ6rQ99Okww+NZPvc7tpW
 +Mii5FOXXRswhvdvMOafxi5cuFmsnRS284Qmdq+/BY+MpSpIp6E13OzE0COTuEUH575DzueS7Cw
 TvxScnvXbQ=
X-Received: by 2002:a05:6000:49:b0:439:be67:a02d with SMTP id
 ffacd0b85a97d-439da67c0c9mr16614261f8f.31.1773071709488; 
 Mon, 09 Mar 2026 08:55:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae57401sm22872051f8f.38.2026.03.09.08.55.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:55:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/49] vfio/pci: Grow buffer in vfio_pci_host_match()
Date: Mon,  9 Mar 2026 16:51:55 +0100
Message-ID: <20260309155219.62400-26-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Each field of PCIHostDeviceAddress is an unsigned int, therefore
while a valid address is limited to 13 characters, an invalid
address could exceed the specified format, up to:

        ffffffff:ffffffff:ffffffff.ffffffff<NUL>

This requires 36 characters with the terminator.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>
Message-ID: <20260305-nvme-v4-2-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c89f3fbea34..94c174a773f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2739,7 +2739,7 @@ void vfio_pci_post_reset(VFIOPCIDevice *vdev)
 
 bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
 {
-    char tmp[13];
+    char tmp[36];
 
     sprintf(tmp, "%04x:%02x:%02x.%1x", addr->domain,
             addr->bus, addr->slot, addr->function);
-- 
2.53.0


