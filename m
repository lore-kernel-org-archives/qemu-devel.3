Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D8606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G2UasF9N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOdx3-00026I-Bd; Wed, 04 Nov 2026 11:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xOdwl-000239-AO
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 11:34:48 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xOdwh-0007vG-Ef
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 11:34:46 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso634441f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 08:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793810080; x=1794414880; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GFumMiBTyQzNR93yXmICK0ObtGYb2ReUiRHIoSCND2E=;
 b=G2UasF9Nl2O/VuhT/qGzMUWC4Yzu4ZnL5Y2cnixHxOVHklUjF0bDf1ACQ2XLkI5ZDp
 vcsym92MTN1xfLAVmG7g7sCu/B2K8SyPZa99+RPd6/TJ7HLbuTJBj0/MUOsz0uJQ74vz
 CFhE8iQldj8BuMcftOVsakrtKMbJ69MaWgXsBBj+7weOZWAKb/LWFk/uRd8DseN2YKO5
 sar0mg4sD8WKSQHxdd5AE2Ouix2QGC6wVWDmmq4rJnfa6eXiJ3PVKie+Ltm2dqAiRlMI
 g43u5re19zcmu7CTrsgJ23DOTV83sJ2XsPnoi3pdno4957bK6y1apLdKz0uH9Yyu1scI
 WCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810080; x=1794414880;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GFumMiBTyQzNR93yXmICK0ObtGYb2ReUiRHIoSCND2E=;
 b=bac4ww7uKlGE2bkDmwkxpyxkh7ZkrfDcHptnrgr1vSB8gkmv3Dy1SxaFNEwvHe7g/m
 +j9X95OYmIEsqGr9c1L+9IiVozYKqk68os9lYe3CtKVU08M47mfuUTbtFCVpG5+tGEhQ
 wUuDQYkrn2SzEE8NtxdmjGSGFgkUdQaF4g6KYjQ4LQlqFyIafg8cZWZgdDgE41gjcEh7
 Y9XhwxwUGaQWbC9IwEVBQcU88nMhS7UXH+2V32poS+CGmZtDlRyIBm40PmeNni1tB5M8
 RYTok7mrpwL4PX9do6oU4Be1e49/u+D/sC68kjyGExH9wpqKkxzNPv8G3X9JFUX8kePG
 x/BQ==
X-Gm-Message-State: APuU4Z/zoniGt4cYtfdcPDOiS8kFRa86SC/6IdxORE1HXSbghOc9B2ej
 QGcfDWdqReTwF/4Uj3+BNei8zaoaDWGapDfP7yOWwgp9DViBxI6nmbw8MjN8NzVUOrJplVpsHMX
 2LnnPGyo=
X-Gm-Gg: AYBFou2sI19HaZeLzSvKhgq/NrIwNfjyYOsVpjasSLy4orGkLo9fS9Y2R3h6ApNHltm
 2jjjaxMp797HR+vdjW8iIUIi5F27tGPJmxGgRRhc1XraIB8YTdhJ7fNOw9KNALzl7jSG3lSnEO0
 RgACBU9QooRTkBSywAnGWeryFwo9PPnKZw336jJNmKWF8+fxksP4GQAQAGrnZEZAmOZF2RyKG+M
 TbsBdCagMstn2HyEI02SkQv4jpPAhauWhZ2qofkkEdV5T2kP8XAkWEhrF29I4qmHykY1f8ckwVk
 lOlkuT/CDSBkhMqOuhk3fBlkskMs1vt22Gb8uejWj7f49TPYcLGDU2svXTxIeIrq03tMpak2l9l
 lXddhnZWBMPu0B+n/ayc5czlewCGhHvSKaRNpfTcqzOX4RFnllxphVKcW/wZkBnmfYswsNZvZ7I
 Zw3KNSRMHJGsttlw171zQFTShJacIZbmq3bZ3SC6N4TE2Q/xrWHIm54W1KBVfRz6YaBvC07DNxp
 dLcxybYQdX4NaVye9ZPVudVkQhynYwXSbGNiw9HFDxdhPu9yQmKolbn0htAXTaHnCYTGJwQVbY8
 8oIFG+Nsx3Brt9fDzaM/cUC3d7T9M3sfYA==
X-Received: by 2002:a05:6000:260d:b0:490:9fe2:6a3d with SMTP id
 ffacd0b85a97d-4909fe26b6cmr2607805f8f.32.1793810080111; 
 Wed, 04 Nov 2026 08:34:40 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:ace5:d1f9:7e3c:8531])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda203b6sm4658544f8f.48.2026.11.04.08.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:34:39 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 0/2] hw/ide: IDE & TEE support for ICH9 SATA Driver
Date: Wed, 04 Nov 2026 16:34:34 +0000
Message-Id: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJpe62oC/yXMQQrCQAxG4auUrA3MTMuAXkVc6OSvjWAtiS1C6
 d076vJbvLeSwxROp2Ylw6Kur7EiHhoqw3W8g1WqKYWUY0hH1jKwmC4w9kmeLLnPoUMniC3VajL
 0+vkdz5e/fb49UN7fDW3bDrt8VRxzAAAA
X-Change-ID: 20261029-ich-driver-spdm-d6f604e4de13
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.17-dev-6be7c
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42e.google.com
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

We intend to use the ICH9 SATA driver as an example for RME device assignment,
hence adding the capabilities for TEE (Trusted Execution Environment) and
IDE (Integrity & Data Encryption, not Integrated Drive Electronics). These
will be used by later patches which use them for TEE-TDISP support.

The first patch duplicates work from the earlier PCIe root registers:
20261029-jmac-pcie-rme-extensions-v1-2-212d2409563e@linaro.org
I can respin this series if/when that patch series is accepted, or we can
merge these into one patch series; getting some feedback on the second patch
is my main reason for sending these.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Jim MacArthur (1):
      hw/pci: IDE, TEE support functions

Pierrick Bouvier (1):
      hw/ide: add SPDM + IDE + TEE pci support to ICH9 SATA driver

 hw/ide/ich.c               | 82 ++++++++++++++++++++++++++++++++++++++++++++--
 hw/pci/pcie.c              | 15 +++++++++
 include/hw/pci/pcie.h      |  2 ++
 include/hw/pci/pcie_regs.h |  4 +++
 4 files changed, 101 insertions(+), 2 deletions(-)
---
base-commit: 74f7bf4c59e6b6d50dbc6e124d93440be8be4386
change-id: 20261029-ich-driver-spdm-d6f604e4de13

Best regards,
--  
Jim MacArthur <jim.macarthur@linaro.org>


