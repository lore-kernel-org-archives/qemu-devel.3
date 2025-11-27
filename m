Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7077FD116E0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 00:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOPd4-0002jw-3l; Wed, 26 Nov 2025 19:12:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3gpcnaQcKCp8M9UHCDLFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--navidem.bounces.google.com>)
 id 1vOPd1-0002gy-Sp
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:12:55 -0500
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3gpcnaQcKCp8M9UHCDLFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--navidem.bounces.google.com>)
 id 1vOPd0-0005yY-7D
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:12:55 -0500
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-7b8a12f0cb4so213889b3a.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 16:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1764202371; x=1764807171; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=uSoBoVL9DjBHsGRfYe8XYLj51gZGrhVymhTsNNjP0Es=;
 b=UGAP/f5hKXHhGmQRvJFovwh1ZdOKhVCt2MUhDq8GqyJLqvYJ20vk0Y8Y2Bzgw4EKYJ
 Y0osPKsygHXZ9blXHM8usA7hrzaq3GzI9yMAWEAmhd2g18D/+y+N2GiChqflsy2dN/u9
 kHb3FSxh/n/6+6DETiCpgekQorxYZVqU2T9l7tdqdjmEfifY6E9kvigjmnPuxwzp+hE4
 NjQEWtFIaaJQUMEnicJ4CBh4Tu6zOv5bk6wgDz3WREpHOlMRCOx7EsOtDfnNHgTHXh30
 6Tg+uNL5YCUCExhaey6pi4i9Tl+emVbLWIxNotwrVeguRUOKOp4lHVXgjb24e9RCDVp4
 t0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764202371; x=1764807171;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uSoBoVL9DjBHsGRfYe8XYLj51gZGrhVymhTsNNjP0Es=;
 b=bEzG2wq0XnehFXH0MIbZmtNacFWRiklIiMPb0Pur1Js/UdNiiaoluQIcmP+0UFWKmt
 biYnMxdGwKHlgL/LVJGHmdx5+gSSJCtMzg8keW2WGKsNnJbjJJdejUaXvJ5jJbLY9ZS0
 cXKYOTOcpSmKCKLv36ztz42h+0nWISqByz8qaW3wBF8En9fBVkXQ9G5DJv9nU4GgOFqZ
 faePaHnEcogDaxSLI5qFr7rOZ2QxSk03RPcXiW9/VfQKE7OoBMqHfp3bhjOElYv65vlH
 UaFTaro5q2Jew96KHorRDbxelbrNhOjDZXZpkSrFrCekXwOUavFMgVkJUHYyQ1DRXvpR
 /tDg==
X-Gm-Message-State: AOJu0YwtMo5ePgIlsU7GjSyiFYVrTeWLhymxLn6sovRgZ4JRT9oIWEL/
 RtkXqpfNpO8rzc7rNlfDLC9449NgPT4d+6bIcXG5wxwn0srcAotyTtyIbLwoGcF6h19LUypyHlP
 GFkhWe/1uAM3fM9dlMn+15cB3Rg+zleIp2J/rtGbXlMRW0gi3h3k7mySrJHIGuMKTn9HNItehBl
 0fWgsSNcfdVLpsdAuAfcgCcUaoazcP7tV9vL4kXni1
X-Google-Smtp-Source: AGHT+IEC4YBp8uF6bdbTNFhbtdJ2yCP/6X8FcBczQ40MwhRjxugIjCGomGqGPPltM2dZRabS6DH5mc5sAiTm
X-Received: from pfmu8.prod.google.com ([2002:aa7:8388:0:b0:799:398b:a4a])
 (user=navidem job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2191:b0:7a3:455e:3fa5
 with SMTP id d2e1a72fcca58-7ca8627223fmr8934127b3a.0.1764202370871; Wed, 26
 Nov 2025 16:12:50 -0800 (PST)
Date: Thu, 27 Nov 2025 00:12:42 +0000
In-Reply-To: <CAFEAcA-hyn0B-yWE1=g4+NN9=NBjWvk-P8qrAk9L4vpAZpUYvQ@mail.gmail.com>
Mime-Version: 1.0
References: <CAFEAcA-hyn0B-yWE1=g4+NN9=NBjWvk-P8qrAk9L4vpAZpUYvQ@mail.gmail.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251127001247.1672873-1-navidem@google.com>
Subject: [PATCH v2 0/5] tests/qtest: Rework libqos PCI BAR handling to support
 fuzzing
From: Navid Emamdoost <navidem@google.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, zsm@google.com, 
 alxndr@bu.edu, Navid Emamdoost <navidem@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3gpcnaQcKCp8M9UHCDLFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--navidem.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Peter,

Thank you for the excellent feedback on the first version of this series.
I have implemented your suggestions in this new version of the patch series.

The original prerequisite patch (which used #ifdef CONFIG_FUZZ) has been
expanded into a 4-patch series that makes the libqos PCI API safer and more
robust for all use cases. This involved fixing several tests in the suite
that were performing invalid memory accesses, which the new API now
correctly catches.

The final patch in the series, which adds the pcie-pci-bridge fuzzer,
remains unchanged.

---

Changes in v2:

- Reworked the prerequisite from a single #ifdef-based patch into a
4-patch series that improves the core libqos API.
- (1/5) The core change now adds a size field to QPCIBar and moves
bounds checking into the accessor functions.
- (2/5) The qpci_legacy_iomap function is updated to require a size,
and its callers (ide-test, tco-test) are fixed.
- (3/5) ahci-test is fixed to check only implemented ports.
- (4/5) nvme-test is reworked to be compatible with the new strict
BAR checks.
- (5/5) The fuzzer patch is unchanged.


Navid Emamdoost (5):
  libqos: pci: Handle zero-sized BARs gracefully
  libqos: pci: Require size for legacy I/O port mapping
  tests/qtest: ahci-test: Check only implemented ports in verify_state
  tests/qtest: Rework nvmetest_oob_cmb_test for BAR check
  tests/qtest/fuzz: Add generic fuzzer for pcie-pci-bridge

 tests/qtest/ahci-test.c                 |  8 +++++++
 tests/qtest/fuzz/generic_fuzz_configs.h |  8 +++++++
 tests/qtest/ide-test.c                  |  2 +-
 tests/qtest/libqos/pci.c                | 29 +++++++++++++++++++---
 tests/qtest/libqos/pci.h                |  3 ++-
 tests/qtest/nvme-test.c                 | 32 ++++++++++++++++++-------
 tests/qtest/tco-test.c                  |  2 +-
 7 files changed, 69 insertions(+), 15 deletions(-)

-- 
2.52.0.158.g65b55ccf14-goog


