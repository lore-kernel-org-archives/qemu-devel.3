Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DA5CD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 13:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNsVw-0005xS-Vr; Fri, 15 May 2026 09:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNsVs-0005wo-NI
 for qemu-devel@nongnu.org; Fri, 15 May 2026 09:23:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNsVp-0003xf-5t
 for qemu-devel@nongnu.org; Fri, 15 May 2026 09:23:36 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488ad135063so76364505e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 06:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778851398; x=1779456198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p/E0o7c6e/euQe6VIMHaQfoiLePgrVxaBMxM6GNeMJc=;
 b=dX5mC6iQkN9miOw6ZxS7KHcZCnpKERCk5VqWTKMrE5UkYvLfCsCk1Mgjpa3vKdybqV
 KNeytCz+/aCfqhLRot43XgBTxETsZFsFIDkRNg69dTMOw9Xy6z22q7kXJ4e4TceaxrkJ
 DFprjhEiesXEtzH/Lr4iO4eXgl1CNhUcqHKAf6P2d++VMKimktSmll9HplAFTjd4Tqlu
 76neDPGlKmIfR1kWSZ2gCrXwK9z+FfkWO16CZQgdzM7qA/4M60avHiKmzBCbVU+wcE2k
 HmNMY6akPbKPiicckmocQVs07RjDtaWoH5zVCWpISaP6yJ7KlzO6pVOitsjKkr3o4Nnq
 UuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778851398; x=1779456198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/E0o7c6e/euQe6VIMHaQfoiLePgrVxaBMxM6GNeMJc=;
 b=b3Y3YCh7ArXxlBUUVHLI/6Kjm2hFuifT75+YGTfDKLZHRbRQdAAzkEZQNcIB/65hie
 8G/GYzgpMqlNmjrl6plh10oNzhqft+rY4DnnO/4UD913duVyIafP0xaET/lO/EeOCEMd
 0Bh9mR9CSZm0fmFtZFjvWTRcq4ULT6PIywHR0vSGluaKMvKfHmqdTcOxhBVOHg5/39gP
 zdc+kkhDt6or4R7tnE2qnedcEkuYU5DectjkLWtRI0XranBQ3W9EriO3VmMoNLHJoy6c
 XTm5Ef9lUfung94UIZtJ5TGnV33djT/cz2LeU46NNRlMYR+IDas7Sus2XOLgKMhaZHRA
 MgDQ==
X-Gm-Message-State: AOJu0YxnNxvIHu3dpYMBsHl1nTffCoChE5wEoV7X/6KrK/VHVyWgvJFs
 T5FZ1xnRXtVWSVXZkpnUznogRYGRKJGX5aMzzhn7MYD4hsZrMIUrJC2j1G2An35oqVzmY3s5LcT
 k9C0VkV4=
X-Gm-Gg: Acq92OFGsdlHJzW0St9HHHiQrO9p94k4KT5JE37qZgG8ymMC8p2h2rocP3ot0NpI2iE
 SIgLpryiFW1xhaTyrh2HfSDh8QXr1frKjD/GZQDIjETnKEHDoCsGh4Mh1vT/XEvoDlVd9l9MWp5
 WdTrv5y9iO8eR0MirA9jzWB0v9oaIaoYslWLZUjNzw6zgo9FHudfGHTUOcTFEEt01lRQKLChfgk
 6cJYq+f3V2QljT6Om8z0xNS1BDXNWtCT4EUHVa+NNIgLgeECtQcy0/CgTa6TGomkmWhD4sTAU0k
 zkw00WUz+KOka1YUkz5f0mZICqJ6L292+SCpV3B0FLUo9NRRNrjkdZ1Y01i1pSfhs7pIvBVWAyV
 FCxZ524FCeEAqgTN7dJU6e0V0ymj6xPlOI2a+zpwjmcg9iCyuCoX/yIzPJzQRq7XYXE8xqcOAwz
 nxOhfoc4MfP2LpZwx3qs2p6OdhwqUpEmAm03+7/xbhdmch0rVHsgutqsXniVrrXpfsp+xO0S7RN
 W45ocANaRZClPUIhUkcyHDgMPn+QzvpmQteMgw7jf84cgMEJOX4
X-Received: by 2002:a05:600c:4fc9:b0:48a:5821:5ffc with SMTP id
 5b1f17b1804b1-48fe60e473bmr51955145e9.2.1778851397961; 
 Fri, 15 May 2026 06:23:17 -0700 (PDT)
Received: from localhost.localdomain (ppp-2-86-144-251.home.otenet.gr.
 [2.86.144.251]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe585absm13971705e9.19.2026.05.15.06.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:23:17 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, stefanha@redhat.com
Subject: [PULL 0/1] virtio: Add vhost-user-rtc and vhost-user-rtc-pci
Date: Fri, 15 May 2026 16:23:13 +0300
Message-ID: <20260515132315.520678-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

The following changes since commit edcc429e9e41a8e0e415dcdab6aa52ad17ef8889:

  Merge tag 'pbouvier/pr/docs-20260513' of https://gitlab.com/p-b-o/qemu into staging (2026-05-14 10:18:06 -0400)

are available in the Git repository at:

  https://gitlab.com/epilys/qemu.git tags/vhost-user-rtc-pr-1

for you to fetch changes up to e331d3089ee64411013eea74fdf71ccf30bcb626:

  virtio: Add vhost-user-rtc and vhost-user-rtc-pci (2026-05-15 16:13:07 +0300)

----------------------------------------------------------------
vhost-user-rtc-pr-1

----------------------------------------------------------------
Manos Pitsidianakis (1):
      virtio: Add vhost-user-rtc and vhost-user-rtc-pci

 include/hw/virtio/vhost-user-rtc.h        | 22 ++++++++++++++++++++++
 MAINTAINERS                               |  6 ++++++
 docs/system/devices/virtio/vhost-user.rst |  3 +++
 hw/virtio/Kconfig                         |  5 +++++
 hw/virtio/meson.build                     |  3 +++
 hw/virtio/vhost-user-rtc-pci.c            | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/virtio/vhost-user-rtc.c                | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 173 insertions(+)
 create mode 100644 include/hw/virtio/vhost-user-rtc.h
 create mode 100644 hw/virtio/vhost-user-rtc-pci.c
 create mode 100644 hw/virtio/vhost-user-rtc.c

-- 
γαῖα πυρί μιχθήτω


