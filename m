Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C5FC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJvp-0003mq-0L; Tue, 18 Aug 2026 09:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wwJvm-0003le-Ob
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:32:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wwJvk-00008H-IM
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:32:42 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso32900105e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787059957; x=1787664757; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ct6g+Jg3FI+pu5C4RgA2VJIlWHc62WS2z/12FLNbEnc=;
 b=X+L0qwPK+vV77BLwk3egRA68eaGSTTZz4DtU4z2Ntgxd+Pe1wTZX2jQMiOhBuA5VD1
 Fk5+yNLSQZHzja+c0PEl7DN1IDZncIfJ43dN3SN8DqdRunozVxJUTT3ZPBrTudqMfKD2
 41TD6RNZy4lY9T06aovG1VRy1FGio31tKU2VbbWWE2asJRBOJYwZ9+tCFFG/vOf78juz
 xdIhfxBBPfrsGd11MkgMUbmDuv6m0hoDqQmx0DKSgq6ySolQcVPtCW4HhAMVPhu/fiZ9
 F6stqXusEDwKtOb4+CsU23I98dh7fluooSNSTjP0VAHc8UefOU6En2yplW5nGB4cGcSX
 om1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787059957; x=1787664757;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ct6g+Jg3FI+pu5C4RgA2VJIlWHc62WS2z/12FLNbEnc=;
 b=JyRuqbJTibD2d3dWPl3eRcoy3xGieoq/A1Y/6snhu0A84V3I8NpUDeBNJCma+yD1Wo
 dyKGfm7GaLkye3wDvv3syYhh4lWw6wLN/ZyPczQ55ElLcytrvGS78Mc67Y3M/tOCRd7w
 Yo4y1pNBr2ahlM/WKDaXi8hjqU7H89oF2E8Q5K1kPgKxOdRyr2R/wxuK/dFf1INt5jKl
 SknluleX3zqxSFacwlZCmSGs0J/DOLqvJtCT9WCheuHOzRmZ317zzSK1gD3vULpzlBuW
 zhJdqdNGKtLIfM8yeo5DgfGcDJVY6wzUEwUazJiAKPXxtaMfrvTMuYsGyF3JZ0SPw27z
 7yWA==
X-Gm-Message-State: AOJu0YzWc8MDkABwN0aZIoLh4+uU0Kv70Ter4OS0H93pxQmNsZaNGzMi
 bXgXyUvM3tjEMIKl7a0dfDBBwqj68Ci3DM9UGf61MK237k23eYuuBcvzVPYYaHFWiS+aYmKCdhP
 SDSxI2v4=
X-Gm-Gg: AR+sD11f1hm7LN6Wrst5Nmb9lgre2P9oKuok9zHCk+QxqBdPTFNGPRxEmO6ySMhVuEm
 1d5pqrWOA9FcIUAPI/BtSbKWpvJjDjrKO4/0XoFM+qM+NEqDhqQw2ySYWgnSOUo6CXQNaZrHGSt
 nfhkuNctxOMxTqTLtgBfFO8Y6E3PYX3xZIeX3WkP9YNZlHn0Yfa/LF19WejlD8hqpNYk/NrX/Bv
 MNGEUh5bLbRkX17U2QHyXJ7YA6RqQGgzBo815ocQxKMCcMCetx6JVwKgx+pdkmvSAAyP7loHWfj
 +O0mZL6RT6h7r6pg/hrfMkduK+RcVHYBZR8MKQpEUusCAI2Hoyq6ev0leCZM4FH+ucOrYigqIc+
 cp3FsD1Z8OGtakhff1Zxc6QbNcCyRNvYMzX9u18icXRGpQuSSAYYiGkpwhR13SsIJbLNX0qEZYS
 JMldbzHGtD4hkup2EVVjKV5NPJbnf80XbNP75Zn1EM11nPC0mQDX/Pj+VKYWzQ8KzM
X-Received: by 2002:a05:600c:3f10:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-4999fb3c2d6mr160706905e9.12.1787059956731; 
 Tue, 18 Aug 2026 06:32:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:c289:2687:e46c:f7e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b203cfsm298360625e9.3.2026.08.18.06.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:32:36 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH RFC 0/4] RME-DA preparatory work
Date: Tue, 18 Aug 2026 14:31:58 +0100
Message-Id: <20260818-jmac-rme-da-prep-v1-0-30fab951bc75@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM5ehGoC/x2MQQqAIBQFryJ/3QdtIdZVooXYs35QiUIE4d2Tl
 jMw81JBFhQa1UsZtxS5zgamUxQ2f65gWRpTr3urnXG8Hz5wPsCL55SR2OnBxuCMBUAtazLK8y+
 nudYPa97CeWIAAAA=
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x336.google.com
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

This is a subset of patches from Gustavo Romero's SMMU DA branch work,
featuring patches from Pierrick Bouvier and Viresh Kumar. These add
capabilities to the PCIe root port and ICH9 SATA driver, and also refactor
some code in hw/pci/msi.c for future use.

The goal here is to upstream work which is independent of Tao Tang's SMMU-V3
patches, while those are being reviewed. If/when Tao Tang's patches are
accepted, we can proceed with the remainder of the SMMU DA work.

I have spent some time understanding these patches and believe them to be
sensible, but some parts of them may be outside my understanding, hence the
RFC tag. In particular, we may be incorrectly advertising features here which
are not actually implemented; although this doesn't cause any problems I can
see with Linux or our test suites, I can quite easily set the feature flags to
zero and keep the code structure if that's a problem.

Jim

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Pierrick Bouvier (4):
      hw/pci: add IDE + TEE capability to PCIe root port
      sata: add SPDM + IDE + TEE pci support
      hw/pci: add DVSEC RMEDA capability to PCIe root port
      hw/pci/msi: extract msi_message_address_register

 hw/ide/ich.c                       | 72 +++++++++++++++++++++++++++++++++++++-
 hw/pci-bridge/gen_pcie_root_port.c | 38 ++++++++++++++++++++
 hw/pci/msi.c                       | 19 ++++++----
 hw/pci/pcie.c                      | 15 ++++++++
 include/hw/pci/msi.h               |  1 +
 include/hw/pci/pcie.h              |  3 ++
 include/hw/pci/pcie_regs.h         |  8 +++++
 7 files changed, 149 insertions(+), 7 deletions(-)
---
base-commit: fa19879df1658f96ac07365fca8835b7decd6995
change-id: 20260818-jmac-rme-da-prep-8096fc816eee

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


