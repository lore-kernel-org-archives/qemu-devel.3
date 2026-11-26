Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AEE606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=c5x8zdFR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWW26-00081s-Kf; Thu, 26 Nov 2026 04:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xWW1m-0007yG-7T
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 04:44:33 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xWW1h-0001zC-Cc
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 04:44:26 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso5149053f8f.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 01:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795686263; x=1796291063; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9FvP1aug5dRMbLJQX4+0+Ho8Ov5gqB8lA8R3WQgoUgs=;
 b=c5x8zdFRccX9nyC44HEj4e2eIv317ZfWEZB4lpKnwG1WISujC966FqqV0Jzwmfk61U
 ZboL8zBhabpnvy2RIcASu+wToemwprUYa3ux48VRpNu6h4Wa50C/+dSZD7XUYqeBBrCY
 dphRLyINy0YQ4cgMRO+BBXfLCF3m5OWI5Go1PI71H3hpAxpwVIEsqEvmZHYk4xfAlNK5
 8nBFjNQowrbGGU8BBRdHctZZMGnJkYknOwt4bq2Txw16S0ESMa8T4Sc7ZG7TBVkWRn5D
 HT424tS7GjAo5jG+aH1EI5PqkfF6cqT7VC5DY6ix8iFusbXxt7PYCDHeD93gvKoA2DEX
 ZNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795686263; x=1796291063;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9FvP1aug5dRMbLJQX4+0+Ho8Ov5gqB8lA8R3WQgoUgs=;
 b=QmQYHAlJ5sLh+3z4wGxzJ/ULXsvu3dq29wJQKQUDFuaBPK7fYI88CUew14d3cApFkf
 emUsjKWdgSMsyJiIr/5A5wdtSboAwrq6gDl1hrMp8+28GQS1vz8bWV7IqCT5kgkddQAV
 vGJjP50BOBbpTuX3GZC6Duy15fp3I8rtQZzQwQ5VqSv/L3G27eCwazyWFXdgiQa9Cglg
 Jdb8M0NxRCKKhPsh/lFS/wG9fqiHsTeFFK5y8B+ad59pQIYIwdCz32AS2z8++Nvpwpqb
 vCkWcolSbdFpzcsfoDkqpU+VUck+2SAeJ4M/mgfX6vGtrK/BWn4U8WbEzN3crUKwby9S
 rEgQ==
X-Gm-Message-State: APuU4Z9c+QCnSHDJarOttuqOPUqA49hFsVcIch6RD7497z3hfiT1LzPE
 TVQqQl0A2mB1Wrl5UqC6XZo1V1S4SycyDrzl8Ra0qysLqBgP8WNMzKlkiWHpTdnpDRc=
X-Gm-Gg: AZFdTZdi8lPUPCKzGvz/DV2t27z2vUUavuiWy47vCgy4q5KqaOV/eC140sLuCXE4CM0
 lev1vyvvsAF01laeKw3UbnYC+5faNLFWZ6+y5drjx9FRnCt/hUYiFv7sFgFJ3QvKzo122bGS5Qa
 JV5o70QSVPvq6Bl11jasnxupkDh2QF7LKvrQr7YiTVBhCk8pHtFf2GjM/nSl0MmIhYRsSL1t48H
 tOs5RhjCr5V+8HhvRoUz4uXzPSUobKNvmN0TBBd+8n7qvq5dwYNEhvzdF5Qs9taFIRjcmv60hdn
 5rvShxVTfq3pBrUtulgLP9pFipSQnXTscArmV8nZ0Xo935tFcOleby1Bi9rbAFMoZ8e08VMr1Pv
 XFFbeS/XimnHoHDKri7BiLrXgdnxR/QAvneBX1GPFwA5wr4FArnWKYWa4HHSKbercKrQxQT6Cym
 /hctr+XItrE3uloXoGJol2dhZKJ3bsnXiLLzEpTd4abi12iorvyTW4lwGPDtRngPnbwNa9VfYgx
 +4VezyPhkQDpujeA/QBHFVD7KEkNc1V4rp+MbQ71M4QiOQpyHx934t9IZZ0J/CXsjhrFSk+5bFD
 I9R+2bfCxGKFEosdP98QsyzXtuPRr4nuqw==
X-Received: by 2002:a05:6000:2c13:b0:4a6:dfe3:fd93 with SMTP id
 ffacd0b85a97d-4abb41f4dc6mr37782261f8f.40.1795686263492; 
 Thu, 26 Nov 2026 01:44:23 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:496e:5802:6210:8370])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2050f1sm39023989f8f.38.2026.11.26.01.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 01:44:23 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v3 0/2] Add SMMUv3 Root registers
Date: Thu, 26 Nov 2026 09:44:18 +0000
Message-Id: <20261126-jmac-smmu-root-registers-v3-0-b46a8ac59b6d@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHL/B2sC/32OQQ6CMBREr2K6tqYtUMCV9zAuSvlAiVDzC42Gc
 HdbjDEudDnJzHuzEAdowJHjbiEI3jhjxxCS/Y7oTo0tUFOHTAQTkjOe0X5QmrphmClaO1GE1rg
 J0NFapw0HoWRSZSTMbwiNuW/o8+WV3Vz1oKfIi40uLC0+NrfnsffWyN8azymjkBdQFHlZJ2l+u
 ppRoT1YbEn0ePEhcfHnsBeBVGpgjVQqY+U3aV3XJzXFy44dAQAA
X-Change-ID: 20261015-jmac-smmu-root-registers-dc4f1e2a63b5
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Gustavo Romero <gromero@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.17-dev-6be7c
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is preparatory work for further SMMUv3.3 features including RME-DA.
We are adding in patches originally authored by Pierrick Bouvier 
<pierrick.bouvier@linaro.org> and Gustavo Romero <gustavo.romero@linaro.org>
in a way that will avoid conflicts with Tao Tang's current SMMUv3 Secure
state patches. Since Root registers do not use the banking system, this
should only conflict around the offset check near smmu_write_mmio and
smmu_read_mmio.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Changes in v3:
- Added missing header to sbsa-ref.c.
- Link to v2: https://lore.kernel.org/qemu-devel/20261125-jmac-smmu-root-registers-v2-0-9ce0f6aa5097@linaro.org

Changes in v2:
- More named constants for SMMUv3 register layout.
- x-root flag for Root registers; off by default, forced on for sbsa-ref
  machine.
  This controls the allocation of the extra 64KB page for Root registers.
  (Thanks to gromero@redhat.com for the example code)
- Root registers are cleared on SMMU reset.
- smmu_read_mmio_root renamed to smmu_read_root, similar for write.
- A couple of other typos raised by the review of V1.
- Link to v1: https://lore.kernel.org/qemu-devel/20261016-jmac-smmu-root-registers-v1-0-e78e8879d347@linaro.org

---
Jim MacArthur (1):
      hw/arm/sbsa-ref.c: Increase SMMU space for Root registers

Pierrick Bouvier (1):
      hw/arm/smmuv3: define Root registers and x-root flag

 hw/arm/sbsa-ref.c              |   4 +-
 hw/arm/smmuv3.c                | 241 ++++++++++++++++++++++++++++++++++++++++-
 include/hw/arm/smmuv3-common.h |  30 +++++
 include/hw/arm/smmuv3.h        |  14 +++
 4 files changed, 287 insertions(+), 2 deletions(-)
---
base-commit: 9751c62358073580cbf330a4df22077a7c6a407c
change-id: 20261015-jmac-smmu-root-registers-dc4f1e2a63b5

Best regards,
--  
Jim MacArthur <jim.macarthur@linaro.org>


