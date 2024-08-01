Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0A8C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWRi-00063L-KX; Thu, 01 Aug 2024 10:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sZWRe-0005s1-TW
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:06:19 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sZWRd-0006qg-9U
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:06:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fc56fd4de1so16237805ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1722521175; x=1723125975; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxeg5KXRrlKgteP3D/ZipXV3kyjL5x4E+NzJSexClU8=;
 b=KnWKNITAelWktRSBR0BVM82HKesRzvEI3F1fq0hAXaxaSB+NImsMBMiMAfIbFviyiM
 NiFh73ACdoTL3xzjlOTqfO7apLtc7qDJ0/l3pPpXKsXAcTv4nKM1czwHm6O8dZgMiEf4
 kjDD6gnCGboFxewgQPNGOwhY1LijGbaVK/CahQ2LM2Pm5S3YU5/RBMYSOD+aymsdVuvH
 3/Cce19CumUzzjqmLsmB8e8CM3gD9FLMBt2Qc1qfegu8nYT3OiVdEaJpYIAwYKRJSUeG
 R9N5Jr6KFpmelRlD8zfmSOSaVGJ6r3q1sxUei7D2jUrq3zpCySyADotLUkk+wJiX3VFh
 4Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722521175; x=1723125975;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxeg5KXRrlKgteP3D/ZipXV3kyjL5x4E+NzJSexClU8=;
 b=QJTxbr2WtkhWfk0d9U153EUNITc0ulsFN8DkKv7B5wcugHCySzO23D2OE0B2w7k9cb
 38IggM9wHmMEvo3+Bq7kdM4BchDKqbc5BcKPZhfndjVYSUiPFsXefpanHk4StvqqAIq+
 Vw+HXmQR3z5XRKiZ9aN1VIsVN1y2MGstl0LxaE9FAGtBaWgjz/o88KpGZndMcFsBYcrm
 voaGbDphNFoCGioHT/EoeJ2OcKGlcJawyb7Mxv7AhE78Hj50VtGpDN8baI5aQ28n7rDW
 t5nduVVECVTOGkX1h04TcR3exAqBvLkqwEbD1rk87iAaeTuZft1gXqX2CuV79uNXBlKl
 iLnA==
X-Gm-Message-State: AOJu0YyCS4cwaTgXIN0Q4b1IxBsCte9/hiJ6xSVCZKI0Mtk603M/QERI
 cfGCfjvP6BCr9qmqHaAC5bGDxZwbxCDAq4FpcR6WObSWkxvkezLIMFbzdOz5CPPgzBZLDckRDq7
 443dWlJwGOQPwBTllG7PHw+6JmqMibHp/q/lnY1YoARXES+FU692C+cCWd3kX8bs0w8jml/DYfS
 FFcFKE64h+JMYHmTIPJQ+s+gRzS/C1vVNfNMpW
X-Google-Smtp-Source: AGHT+IHRtWnk/YcpfiQatbyDq1rrOeIgO96EcGOIEfQRcDQtX/Sbzp8J/7XUU/nHS+4f9h66pqmRMg==
X-Received: by 2002:a17:902:dac3:b0:1fa:2b11:657d with SMTP id
 d9443c01a7336-1ff57b827c9mr1048365ad.10.1722521174975; 
 Thu, 01 Aug 2024 07:06:14 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7cc0213sm142631275ad.72.2024.08.01.07.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:06:14 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 0/3] Several fixes of AXI-ethernet/DMA
Date: Thu,  1 Aug 2024 22:06:06 +0800
Message-Id: <20240801140609.26922-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x633.google.com
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

v2:
- Remove redundant RCW1_RX checking in enet_write()
- Remove qemu_set_irq() in DeviceState::reset()

Fix txlen value in the descriptor status field, DMA error handling,
and ethernet/DMA reset flow.

Jim Shu (3):
  hw/dma: xilinx_axidma: Correct the txlen value in the descriptor
  hw/dma: xilinx_axidma: Send DMA error IRQ if any memory access is
    failed
  hw/net: xilinx_axienet: Fix DMA RX IRQ if ethernet disable RX

 hw/dma/trace-events     |  1 +
 hw/dma/xilinx_axidma.c  | 74 +++++++++++++++++++++++++++++------------
 hw/net/xilinx_axienet.c | 71 +++++++++++++++++++++++----------------
 3 files changed, 95 insertions(+), 51 deletions(-)

-- 
2.17.1


