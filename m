Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7A9C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJvpS-0005Sz-NR; Tue, 27 May 2025 11:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJvpQ-0005RI-AM
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:02:56 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJvpN-0006E1-5e
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:02:55 -0400
Received: by mail-vs1-xe41.google.com with SMTP id
 ada2fe7eead31-4dfa2aeec86so1251686137.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748358170; x=1748962970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agFWYYCKCVq6mVFbehNZ8ax/fZ1A0ibvbnP/23upHzI=;
 b=BAYeOfEGgjcNJXZq59AfBetmjGF5pmV7TEwOXXtMk194ISMz8htOnu3cbea7FAnbp8
 TpRP8hm/ZywfBM9eBoCxiVbVA/ZoIr2Il1gLepj2E9qlNqsiUY5Mlw/Zz3BOdfxo/+FL
 yO2jzNZC/DgRs1d9q+kl++HDj/FrqDRugzToH6fE/AfWUR1wzoHvNQ07U0UaSHwalYVV
 404gvr2XhSM09IUO4Q48AEJfYCXa3qxsuvHYs62BHPFWZ5cEPIRG69AiwB8is+FoXrvo
 D/4QVV903G75hyAwxMSmO4LKkvjINYX+WGC/oOKXf1MWcNOgGHWjBpVmnN0gdQgeM4ru
 Z8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748358170; x=1748962970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agFWYYCKCVq6mVFbehNZ8ax/fZ1A0ibvbnP/23upHzI=;
 b=je5+5mZbrhiIDWOX6ZdZylO6Somzl7zpMqMa1wPU8sspSRqr3pd7qfMhsVF4a42ct+
 gO1eSelIhb/Hmp4Bu6pBKEZ8soNeVm7nB4YxFSPt6pN6n9uuGEOPAPe2Qv5MyX5KYN2J
 pj0pwH6aZSF0qoJmMB72aiWu7/lcLP3AsZm3B5T5mB+igalr2uK+E2tR5k/AXir5nEhn
 Ylfs/aHnTbCvlc1RIqVWvxUZb7oLq2IE7/naje0PVCjm3LFzgMGV+ylFD9mHTOlLss0D
 Dd1Tmtnp5nQafGoMOVJDSgqZ0oi4jCoYg17F9xaV9FDt9UAWQi8nwMZRlQxmSkHilCQB
 f+pg==
X-Gm-Message-State: AOJu0Yy2u53H20OnjVYxfKVck8G1aTjbGe3xH2NUnUV6OeJi0RlWM3Na
 6vR5p03VdZmtr5r8mL4AjIJ74jNjTb9gHNkKa07rVY9bWYuKVNL6OsF0UNyT1eBW9IsnWvuJqrI
 aVzTa1zXtSA==
X-Gm-Gg: ASbGncsm1ReKJG7LJ6EWx00K2yXql2TnlTvM81ScT1kvNeohiua4PajcqX2uXko6hAH
 s8RBH4o6aAPRVBRHeL4G5T8Z9jnEGrgEMOSoFcOlwzJhOHwr+kl/Znny5IF6bbzHV6L5sanLnId
 AAA736+awRvSf8kfnMzBKiFIIUpMig/qZdw1+fQEviSEJW+uAo2WX70v9KTb/DPgFkqm1MfO1lO
 a4/h+PNMjdLAIS+8InsPsfhrKwmJjdaSMotnDuiJh9BdNwWzhWohnL78q2wjI3ryOMBANyfJoLJ
 d7/okztDpQB2DfnXSuhgwrGsIs8ZnTLqUb0VLMmx/MmqUCX9b/s3JO3whhwAtgz7zauluA4zmNy
 nfgBvy0KpBPZjvqFe7DBZrg==
X-Google-Smtp-Source: AGHT+IFZ72oGyj6zqgb1m6S3CDOn0dykaUi1s3nbhFSi839o4SCP7fdLWsZJM+ZNdDJjfzgl9obcHg==
X-Received: by 2002:a05:6102:370b:b0:4af:c519:4e7f with SMTP id
 ada2fe7eead31-4e4241af472mr9779721137.18.1748358169635; 
 Tue, 27 May 2025 08:02:49 -0700 (PDT)
Received: from gromero0.. (200-100-75-183.dial-up.telesp.net.br.
 [200.100.75.183]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e51e94c9c2sm2189649137.23.2025.05.27.08.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 08:02:48 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	eric.auger@redhat.com
Cc: qemu-arm@nongnu.org, thuth@redhat.com, gustavo.romero@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH 1/2] tests/functional/test_aarch64_hotplug_pci: Update SHA
Date: Tue, 27 May 2025 15:02:28 +0000
Message-Id: <20250527150229.1617074-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250527150229.1617074-1-gustavo.romero@linaro.org>
References: <20250527150229.1617074-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e41;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe41.google.com
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

Update SHA for 'linux' and 'initrd.gz' images.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/test_aarch64_hotplug_pci.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
index fa1bb62c8f..bb2c121503 100755
--- a/tests/functional/test_aarch64_hotplug_pci.py
+++ b/tests/functional/test_aarch64_hotplug_pci.py
@@ -20,12 +20,12 @@ class HotplugPCI(LinuxKernelTest):
     ASSET_KERNEL = Asset(
         ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
          'current/images/netboot/debian-installer/arm64/linux'),
-        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
+         'd92a60392ce1e379ca198a1a820899f8f0d39a62d047c41ab79492f81541a9d9')
 
     ASSET_INITRD = Asset(
         ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
          'current/images/netboot/debian-installer/arm64/initrd.gz'),
-        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
+        '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a917790c')
 
     def test_hotplug_pci(self):
 
-- 
2.34.1


