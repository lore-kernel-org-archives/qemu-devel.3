Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A80AC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxd-000356-4e; Tue, 04 Mar 2025 20:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxb-0002wN-By
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:11 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxZ-0008Sc-Ki
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:11 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22349bb8605so121876465ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139648; x=1741744448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zW6PXe4XFNdvMN5XPwVPjnp1zyVCPW0vMTE7zxiqwxQ=;
 b=gJjgzJ/I5XRIFUBrmhhg92JBEmgFcGGam1e43vjrhVoRfoe92Xak+21SA1ZVwNY5Dj
 gOw8vZDEx7dtsdxz0Gqu1EJEfH2J6CZ8kHC+Xa4n2wA+uYeM57eSmgSvLaZ9uwHtI747
 Z59pWcal7m3xx1FhCxL+x9GoLTprgGWIU9QKHVybc1jxvlzhGO2yUgbtTbBYkzdKt5lU
 +jVU59JC4LMrZzlma8/o9qP1wAyA7pacSBqcdWUyxBHiZWX/jftLDnZ3gXEnrmnOjBcW
 gwTLWBC5n7B3T19KURnedytAUlAoMG4OgzO3wfbkNgIBO2XW6iAB5YOT68mRIZXgv0VU
 5EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139648; x=1741744448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zW6PXe4XFNdvMN5XPwVPjnp1zyVCPW0vMTE7zxiqwxQ=;
 b=Z8MyhrmNnCnAWUEcjc4f2Jd14X3geNscw8QkP15dlEnm2m3UqXQB9Baekle6O/FttW
 ip4Z6Zgz+MstWfeusLMlZluGIhrxTlUUX+Xv7CXggYl6g/xtQJYCylokbPHpFFBsYCIK
 TFEThq4gufO+fCHfEdOFWvjXsJaOaeW91LVXVUVnYi3MzpwQxqvPlpMpt4yrepcmFdql
 0zmARdwX3l/xP1Yk00anqqcnUj3btBBYjA4h07hMN9fMgbqL1mT0h0qNe5J4Pbno7l+b
 piG9owtetOp4hrQS1afM2jbmZEEvDNfC6sm62gMhFUShgoEZMvEnBttat5HfArpZh64e
 hhWw==
X-Gm-Message-State: AOJu0Yzhpzx5JbFSWwblUnqYSIOACCWnO5zkA0/+Q1Q2k/yLHcA4zaaY
 Fnhl9qx6wmE5kscITxuAEKzm+iCZN+j4W6NMkJmogZfSCXflPPjex3LKNJO072s=
X-Gm-Gg: ASbGnct1AXklamBK0F/bmr038jXJXRfQoWU37ma7alr83ONw95sdRF+w3GgSzBiqdsU
 +VJCvALySIm68UgIjr1ofpeobQo2Gy407MnkPBSDvf2ejp2Gkyq9xO5B3qsXCAmoqBaQucZ2bmi
 28ptlK4gTmam2J57YOyAmm3HbJ4JmId8/rZv4eb7SfL34HpGUoCI7YnY+jRIqRcGzO7/nDT8OdN
 V7ZBa7qRk9uKTxJYrNRuG7eyJK55Ze8TgIr92y8yta+vtxLMShyFDimcuvK1TThyu2HabQNRpmK
 u3sqjsl5LMfR/gGCDGo7G7CXZE+r/Hx4Hg0UoQnGArXD85eqVXJJNwB2VHgLxsTKNMhTuSs9rh3
 f8pc46lQnzu9cXgyagYr6HGpCKeyaIP6UkM48e/ZYXaAkVeKznMQ=
X-Google-Smtp-Source: AGHT+IFSJnakTu+Dbxp1KLlz7EBQqJL8B3cpFPPiSFtcUXZyd5DuLSxYJYZp3aT+Q0nEUlot1Q9xPw==
X-Received: by 2002:a17:903:8c8:b0:223:28a8:6118 with SMTP id
 d9443c01a7336-223f1c9bb60mr23806895ad.31.1741139647800; 
 Tue, 04 Mar 2025 17:54:07 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:07 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/59] hw/riscv/riscv-iommu-bits: Remove duplicate definitions
Date: Wed,  5 Mar 2025 11:52:26 +1000
Message-ID: <20250305015307.1463560-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jason Chien <jason.chien@sifive.com>

The header contains duplicate macro definitions.
This commit eliminates the duplicate part.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250115141730.30858-2-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-bits.h | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 485f36b9c9..de599b80d6 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -50,8 +50,14 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
 #define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
 #define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
+
 /* Payload fields */
+#define RISCV_IOMMU_PREQ_PAYLOAD_R      BIT_ULL(0)
+#define RISCV_IOMMU_PREQ_PAYLOAD_W      BIT_ULL(1)
+#define RISCV_IOMMU_PREQ_PAYLOAD_L      BIT_ULL(2)
 #define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
+#define RISCV_IOMMU_PREQ_PRG_INDEX      GENMASK_ULL(11, 3)
+#define RISCV_IOMMU_PREQ_UADDR          GENMASK_ULL(63, 12)
 
 /* Common field positions */
 #define RISCV_IOMMU_PPN_FIELD           GENMASK_ULL(53, 10)
@@ -382,22 +388,6 @@ enum riscv_iommu_fq_ttypes {
     RISCV_IOMMU_FW_TTYPE_PCIE_MSG_REQ = 9,
 };
 
-/* Header fields */
-#define RISCV_IOMMU_PREQ_HDR_PID        GENMASK_ULL(31, 12)
-#define RISCV_IOMMU_PREQ_HDR_PV         BIT_ULL(32)
-#define RISCV_IOMMU_PREQ_HDR_PRIV       BIT_ULL(33)
-#define RISCV_IOMMU_PREQ_HDR_EXEC       BIT_ULL(34)
-#define RISCV_IOMMU_PREQ_HDR_DID        GENMASK_ULL(63, 40)
-
-/* Payload fields */
-#define RISCV_IOMMU_PREQ_PAYLOAD_R      BIT_ULL(0)
-#define RISCV_IOMMU_PREQ_PAYLOAD_W      BIT_ULL(1)
-#define RISCV_IOMMU_PREQ_PAYLOAD_L      BIT_ULL(2)
-#define RISCV_IOMMU_PREQ_PAYLOAD_M      GENMASK_ULL(2, 0)
-#define RISCV_IOMMU_PREQ_PRG_INDEX      GENMASK_ULL(11, 3)
-#define RISCV_IOMMU_PREQ_UADDR          GENMASK_ULL(63, 12)
-
-
 /*
  * struct riscv_iommu_msi_pte - MSI Page Table Entry
  */
-- 
2.48.1


