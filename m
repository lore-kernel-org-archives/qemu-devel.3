Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF904EE6B69
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 22:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUAb-000628-CG; Fri, 06 Feb 2026 17:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAZ-00061K-Q4
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:19 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAX-00078t-R2
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:19 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a0c20ee83dso21990125ad.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770416356; x=1771021156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nFU+mS2PD7BuE9hvnELs4siMLgxFPzdVyOSiHvJ+WW4=;
 b=WEYG4Fqjb3qT88a3Et9kVLfoA6P6dKLT1jbG6yjBATzWNJ/j03BTklCG3LG9jlVBC9
 JlnIlJBlrnSHlL7WqbIe21YLlUPds84/gMXyV/419GLxNwv6a8sOReA/DDlPbjdn44Gh
 BFcOp5Gboco/OgXmsgAiK3vMCl5X6H/CmurqL8t2YkFLRT7gMYAC3SU//fxTS/TIk+Ph
 1gGRxSmFPZ9TWTGMbopqs5XxKpIYGufUzKM8lNr7EaNFXSYo4F6lEU1Z7NC50SMQoVUT
 L9OLv4HvZctQJy31Pd/TS0LVrkcd2DwXJa+VviAVX6RP4a1EUlU2FaejQ/W7vbdS6Vyj
 a1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770416356; x=1771021156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFU+mS2PD7BuE9hvnELs4siMLgxFPzdVyOSiHvJ+WW4=;
 b=DJ/zZ6cgqf5IdlosP+dVqo0ec9UGThsdm4wSjleoeoPRX58VCgWBmcBRBTFNVQMNVx
 OIKPy7Hb9rPwQOHbB90Yqv6kmSYkBOSKXCNL3j2+oLSiKrqCzilfHPjEQL0QXXUa6LYM
 v7nK9F4Rf9S75/07BCGdz7VQKoS9l9sQHMGC6TuAZeEwZqn1vvb0oJOYo+b08Vsh7jKy
 cSLnd78JXunsfAJR2JlMTuzBTlEsX4EE0HArHKLw1Kc7yHB88c/NmyvcBBnR3CSsk1O+
 9jX02yLxDK/27PJ7H8ERT3s982kFQZ5H69ZQlLqGfesFUNfYpqMugEjqWyncgCy6aoE/
 hgrQ==
X-Gm-Message-State: AOJu0YyY9JSEDxvD1VITLEPApli8KG8WcV0gOek1FtEob3B7yx6yzWuS
 B8GQ5kBEqSrMDdmsnUyeaaMoM+zBy7Vc26aF9ThubiE0zeQNZxxURdxsnbGrtAtiv0VSKj4gnWx
 skCKo
X-Gm-Gg: AZuq6aIwJYKYH03/ITCMxUiKzEbFvonkEfMlKsd6SE+EUVeFEh1lk6h0LNPJjlb6HCh
 evUIxCvO72lOLEbytyq5G7sYJWPIjLX03PXwKMIulCkJMxhNdu1oqPWQPNoF25ytP1DKf2KwiWZ
 57yjamYQkao2CcATAHxuIdl2So4DwCv1r0OxVL+4DDQ0JOB+XIPbIeqHnTDgyZ0Kka74Xq9pILl
 WqMIY5FwHrprKEIaiAeU6pBBT1RicwZt7g7qHS3enPaLJqFjBzDe2Qb3e6/V+hL725sDtFB9Gyp
 zFHk1SYpufT57+mO2406rtaPnZiM2x5d5/rzV7rxtWtY/+dYcT1vIQOD1DcHQ6z+Z5WJ0wmDruC
 gD6lXWebRsVFGn3bK7Gh5ItBjrufqLqNTVA0R3l3h0aO4wbbxla9rQT3SVK2aZP1kkSPvqc4vLe
 qfG9nnIXlbgzzHL30u9MtTWHO2ho8qJriBZ3flTBDTkZXdRqvnn8rSO8iFCN52Kodf
X-Received: by 2002:a17:902:ef02:b0:2a7:d93a:a3b8 with SMTP id
 d9443c01a7336-2a9516d4f7emr39397305ad.32.1770416355877; 
 Fri, 06 Feb 2026 14:19:15 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a95bff42f7sm13316575ad.68.2026.02.06.14.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 14:19:15 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, stefanha@redhat.com,
 richard.henderson@linaro.org, qemu-ppc@nongnu.org
Subject: [PATCH v5 0/9] single-binary: hw/virtio
Date: Fri,  6 Feb 2026 14:18:59 -0800
Message-ID: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

This series eliminates target specifics in hw/virtio and replace them with
runtime functions where needed.

Performance has been measured with this automated fio benchmark [1], with
original instructions from Stefan [2].

Download artifacts and run benchmark with:
$ wget https://github.com/pbo-linaro/qemu-linux-stack/releases/download/build/x86_64_io_benchmark-a55f2d6.tar.xz
$ tar xvf x86_64_io_benchmark-a55f2d6.tar.xz
$ ./run.sh /path/to/qemu-system-x86_64

[1] https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64_io_benchmark
[2] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedora/

Results are on 20 runs and expressed in kIOPS:
reference: mean=239.2 std_dev=3.48
with_series: mean=238.5 std_dev=3.46

Performance is on par, and within standard deviation.

v5
--

- Fix missing vdev->access_is_big_endian when features are set
- No difference in performance since hot path is not modified
- Simplified virtio_access_is_big_endian

v4
--

- Include Philippe patches computing once device endianness to skip runtime
  checks on every access.

Philippe Mathieu-Daudé (3):
  hw/virtio: Constify virtio_is_big_endian() argument
  hw/virtio: Introduce VirtIODevice::access_is_big_endian boolean field
  hw/virtio: Use VirtIODevice::access_is_big_endian field

Pierrick Bouvier (6):
  include/hw/virtio/virtio-access.h: remove target specifics define
  include/hw/virtio/virtio-access.h: simplify
    virtio_access_is_big_endian
  include/hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a new header
  hw/virtio/vhost-user: make compilation unit common
  hw/virtio/virtio-qmp: make compilation unit common
  hw/virtio/: make all compilation units common

 include/hw/ppc/spapr.h            |  8 +---
 include/hw/ppc/spapr_common.h     | 16 +++++++
 include/hw/virtio/virtio-access.h | 43 +++++++++----------
 include/hw/virtio/virtio.h        |  7 +++-
 hw/virtio/vhost-user.c            | 11 ++---
 hw/virtio/virtio-qmp.c            | 70 -------------------------------
 hw/virtio/virtio.c                |  9 +++-
 hw/virtio/meson.build             | 17 ++++----
 8 files changed, 60 insertions(+), 121 deletions(-)
 create mode 100644 include/hw/ppc/spapr_common.h

-- 
2.47.3


