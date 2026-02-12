Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D41EEA86E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 23:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqgNx-0004g3-Os; Thu, 12 Feb 2026 18:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqgNw-0004dm-7U
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:46:12 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqgNu-0008Az-4B
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 18:46:11 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-823075fed75so195444b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 15:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770939968; x=1771544768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=luaT4ogN3kuDQSmznOCyfhY3qOLWnWLi3BZPktB1v6U=;
 b=KjgNFSkoL7TsyJDOOG0AZPHppBXYB/6kNmk4erx18AgWVrKGVk+7VgyNB1WPV7Hvqv
 2pSeAr/Z/83vm8T350KHsOgZqNW5sgSeWj1sWDQmQKZ8md862Gr4lgIsnhal5FuEO7Ig
 thRJ5IMEKIAnTNo0DfafINPAppwf2CZyY6zSmZ9GEHdFqI74l4y7xgtw8wwYFwLSA6kg
 D+E5VpCG8FkmVbsJCmZ0tysrhGXotB9ydCPJmuUbTXBbMz6tv90BIWGkrb/cGSa8TBiW
 W6L5oj2MHw6ybPQQyWhZYvSre11Gzlq+WjK9XhIRAeEZvc+kBTwDfDtbnhcRS0N/4KAg
 cizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770939968; x=1771544768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=luaT4ogN3kuDQSmznOCyfhY3qOLWnWLi3BZPktB1v6U=;
 b=WclczCwkZcGoY4j9hV2rIa2Lc02jBK7EXTSWWceBULGo5cxjOxYVmKEFvabd73Z9iV
 MAp7F+7VXmYFPuNzoo8nTdrKqigRoCByXDq7segDcCD+8Y6NGgGLKKcmmYj+2yGCciGt
 KoW6UpORrhbaMM9XtRRPy5XP0pvgQbq2lJth4K0rm70B0UFKodLByoM6Bshlb1KPQzU/
 /kIWr5BtdVolI+AJiIrWTLWCExRudoBeqQ1hrEDtrpyGjK/AimQBHD3v9mAl5tMg8DSi
 dNtBfcQt3S6hEQWbpgismOs36JlCh7DU0EFa5tWSinoipdjKpdhrbZtp3kg7/yUD0zay
 cyZQ==
X-Gm-Message-State: AOJu0Yzs87UX+DOg5/xvH9cAIMa2ltYTdh9Yyn7Wax78ctqs5Wrxgoin
 y5rFzlGj7yV8h2IaX4o+0WbNEohjWUkgBjVuFAn1xIt1Fqk27IonVPV1B2DcxCRcbaCyaXleONq
 ctxVA
X-Gm-Gg: AZuq6aI3PsNwVEm21prVoHH1yTyCg0JXbh/aOEFoyjGSeWN3fxQvFgWra/sP/weLFXq
 mK1/uIvZ3JcfT2XRRZabgfxqgTk8B/ItIEzjJJ9rUD5Cq4abU4U7d4X9d3WCLVbaIap9TJHTbDm
 iS0bwI/+qRu4/BXv26CNz6cuO4Czjv+fdfKAkStNYSik/kBzseLLa/3WAcM6oZ3vRsB8t6a/LUf
 q9bLCfoULJSdzou3HHq3Dk54INBwK5UcSyDZ85KBz5P/XD7B/YTjBW3njUD7tr6nWN2TkYh9ehD
 ItSqUJw0ZeKueLEeU/MAQ8n0jexz+L/vo/ftqfKKWwVKNqwDxFselG9p54k0VpNWo4mq67Mv9ay
 MJznRYej4wo8wrqoKLplqlDpr4ByMp+9U2uHOqlycCTFAqEzoLBS+NujC98mp5oQfAcVhOr4YU4
 RqF6ugk/wJ3SuvIBLvtASNUms2KWnULN2O1G4RaDOEH+etqn9XAryFDHzCaET2jvRxYq3LBxehS
 cBx
X-Received: by 2002:a05:6a21:6f0d:b0:38b:dd94:936a with SMTP id
 adf61e73a8af0-3946a886795mr28051637.24.1770939968019; 
 Thu, 12 Feb 2026 15:46:08 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e1ac0e004sm5609936a12.6.2026.02.12.15.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 15:46:07 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com,
 richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] hw/virtio/virtio-access.h: remove target specific code
Date: Thu, 12 Feb 2026 15:45:59 -0800
Message-ID: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

This series eliminates some target specifics in hw/virtio and replace them with
runtime functions where needed, to be able to link virtio code in single-binary.
After a first try on a series [0] doing this change and making all virtio files
common, Richard asked to refactor this part, thus this independent series.

By diving into virtio initialization, I noticed that device_endian is always
storing endianness of cpu associated on device reset. The root issue, is when
dealing with target who dynamically change their endianness during execution.
ppc64 is the main use case, as cpu always boot in BE and most of OS use LE. arm
use case is more limited, as big endian systems are mostly dead nowadays.

Because of this, initialization is tricky, and goes through different hoops to
have the expected value. My first approach has been to try to change this, by
simply setting endianness on the first access. However, it fell flat, because
current_cpu is not always available at this time.
A second approach was to set endianness to LE by default, and change it only
when setting device features, and potentially discovering it's a legacy virtio
device. It brought other issues, that showed that current initialization code,
even though it's complex, does the right thing.
Thus, I focused on refactoring virtio_access_is_big_endian, and noticed that it
was not even needed at this point.

Patches 1 and 2 are refactoring names to clear some confusion.
Patch 3 eliminates virtio_access_is_big_endian, with a lenghty commit message
explaining the change. By doing this, we remove target specifics from
hw/virtio/virtio-access.h.

Of course, performance has been tested, and it is on par with upstream/master.

Results are on 20 runs and expressed in kIOPS:
reference: mean=239.2 std_dev=3.48
with_series: mean=238.1 std_dev=3.56

---

Performance has been measured with this automated fio benchmark [1], with
original instructions from Stefan [2].

Download artifacts and run benchmark with:
$ wget https://github.com/pbo-linaro/qemu-linux-stack/releases/download/build/x86_64_io_benchmark-a55f2d6.tar.xz
$ tar xvf x86_64_io_benchmark-a55f2d6.tar.xz
$ ./run.sh /path/to/qemu-system-x86_64

[0] https://lore.kernel.org/qemu-devel/20260206221908.1451528-1-pierrick.bouvier@linaro.org/
[1] https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64_io_benchmark
[2] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedora/

Pierrick Bouvier (3):
  hw/virtio: add virtio_vdev_is_{modern, legacy}
  hw/virtio: rename virtio_is_big_endian to virtio_vdev_is_big_endian
  hw/virtio: remove virtio_access_is_big_endian

 include/hw/virtio/virtio-access.h | 43 +++++++++----------------------
 include/hw/virtio/virtio.h        | 14 ++++++++--
 hw/net/virtio-net.c               |  6 ++---
 hw/virtio/vhost.c                 |  6 ++---
 hw/virtio/virtio-pci.c            | 10 +++----
 hw/virtio/virtio.c                | 20 +++++++-------
 6 files changed, 45 insertions(+), 54 deletions(-)

-- 
2.47.3


