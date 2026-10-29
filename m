Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20830606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yTqORjXH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRhA-0000fJ-Ur; Thu, 29 Oct 2026 11:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xMRgt-0000UK-3O
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:05:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xMRgr-0001wn-6F
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:05:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so21291625e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793286314; x=1793891114; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aWU+KmuTxw6Q1UdOOx6481SDPwTPcHwSSHFfUNV6Q8c=;
 b=yTqORjXHm/MgbvMcUJ8lIdHVW3uA7jai4OrPStORhktYT/GE6nW7w9W1vLnGtilw/8
 Zqa67RiO3dtjDkCFK3n7O8vU9+3bEGsDWCrkPCk2T13j6RcvrObfEgTlj9+KTscpTHit
 vmkPKchSDScoinzXtOBJkf3P3g7Wj/6l9wTGcrHU6soSYXs3W6mNkzEvyJoPlH3TUu7H
 AM/BaKc8D1dkXBzck5/RXrNGKiWKcZXOCZXVWxW+o8q8C51yzBhjlllvHn2sjDigYR8W
 rmVNxaD12f2gCf4NCEgGA4DLqyT7Nt3WhzJZt+ZBYIC6La6yXlB8UXwu473Pi7XUlzFu
 E7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286314; x=1793891114;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aWU+KmuTxw6Q1UdOOx6481SDPwTPcHwSSHFfUNV6Q8c=;
 b=ZHZrvt0SxfJsKg4Xbpl89xAmFvEWh1Tzlpty9a8QMIVImT+JSbHXjVpX9yppRETg4c
 FIDexWRsUoiWb4Kv1o0Y5Rbzd1Myu/MnjVVeGsKXM0VFt6FqPtKEdKVILkqQCVOAxO51
 FNY9r4P/wac1Pyel/uhMJufOGjQ7tsWBGR20KmYAUeb2EJJ1si/ClBpk+DjZq1KxKQKr
 7PlFOODfdjdl0sS0JN6pwHjpRpZs9l18DLu+52Cqvv1zlcdyF1TBdxV13yboJeBwDM+Y
 TUeKAtP1btwexmEF1aP2Npisr87PSFC7y97l1ApazaRMQ7NNA/ZKuu5Eh8RDXr1mNbq/
 Wl6w==
X-Gm-Message-State: AFq9FYL3Dzj9LlJqRHK7FC7LQ/ADHrOb4pC2e4ZZBzzlAgWIxRqHctU7
 KndwASqsHgfpEPrauGpl2PDa+NV7Ecgps4k0SzCbMU+4JL0TDQBHUQrDCiBgQjDNzzY=
X-Gm-Gg: AYBFou1FbdLXhiS3aYCvBC/rw5wPdruMZ3PQ9bOSLl1LLF4QlKNuB6Fc05voNHZbVGO
 TtbZ2h9nUHSZOI/7J9B6ueBthKM7F3NLN4jrlcNu7OBumynDqFZOYUdzuzXe5s59raJjmeGwNyR
 WJEvNdJhcDg1AvrvC7Np2AFjVhOtZyp3vnsxqdDQQ1lRFCokNI+QKuXwiN8B8ag7/39oWd80UKI
 vRu3/t3WmBvf+/dKuFXYEh2Q9EFcKyVP0LkkL8b0Mek2esUXCF9FgJ5rg4W3S++ojn1poAqQ/rw
 W8h0pFydEqfnKIU7c7UlLU3ZrR2AFnT12KG91H3f0EC+rlBgu656WDbTMIQHRyJHOQzWixGJz/L
 f4yeSjZXGUgAR9iI5Ors5Z6uLXbGlF19wkmQmBBL/SoABgXJb3SAUX9Duk12iWieJ3gzJAZtzMo
 /6qBQbudKLxlhTqvS9PtxLFl06MIxK02KAwe9/O1QC5bXQWyjbVvm4KojiP4N0T/EsZmbIhCDB3
 q/AVbYZaMLHP/G1sNSpOhxoY8pJiZVVLDxdNxv4B1peZTNYgAzueJb0Jafx2UGCbZ1kq4KBBUIj
 +zVyc/rAEftBimNXfVyBPKDlV3IoSuBZgkPCIvuU9cHlaEDZtJ7W9g==
X-Received: by 2002:a05:600d:12:b0:4a1:d97e:cd60 with SMTP id
 5b1f17b1804b1-4a9672f8166mr100861435e9.16.1793286314180; 
 Thu, 29 Oct 2026 08:05:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:6ea5:6074:196c:9c53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee57589sm80999075e9.2.2026.10.29.08.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:05:13 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 0/4] RME-DA capabilities for PCIe Root Port
Date: Thu, 29 Oct 2026 15:05:09 +0000
Message-Id: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKVg42oC/yXMQQqDMBBG4avIrDuQhLaCVyld6OS3jmCUjC2Ce
 PfGdvkt3tvJkBVGTbVTxkdN51TgLxXJ0KYXWGMxBRfu3oXA49QKL6LgPIGxrUhnYwzp5OZ8vMa
 6p5IvGb1uv/Xj+be9uxGynj86ji8pIMgefAAAAA==
X-Change-ID: 20261022-jmac-pcie-rme-extensions-ecbc501d4d7f
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Jim MacArthur <"Jim MacArthur"@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.17-dev-6be7c
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x333.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This adds optional capabilities for the PCIe Root Port device: the TEE
flag in legacy config space and two extended capabilties:
- IDE (Integrity & Data Encryption)
- The RME-DA DVSEC capability.

All changes are enabled by the rme-cap=on flag for the pcie-root-port
device.

This is a rearrangement of original work done by Pierrick Bouvier
<pierrick.bouvier@linaro.org>.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Jim MacArthur (2):
      hw/pci-bridge: Add pcie_add_dvsec_capability helper
      hw/pci: More comments in pcie.c

Pierrick Bouvier (2):
      hw/pci: add IDE + TEE capability to PCIe root port
      hw/pci: add DVSEC RMEDA capability to PCIe root port

 hw/pci-bridge/gen_pcie_root_port.c | 54 ++++++++++++++++++++++++++++++++++++++
 hw/pci/pcie.c                      | 49 ++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie.h              |  7 +++++
 include/hw/pci/pcie_regs.h         |  8 ++++++
 4 files changed, 118 insertions(+)
---
base-commit: 5624b266cdd513506fb333e9041778407b6d1ac4
change-id: 20261022-jmac-pcie-rme-extensions-ecbc501d4d7f

Best regards,
--  
Jim MacArthur <jim.macarthur@linaro.org>


