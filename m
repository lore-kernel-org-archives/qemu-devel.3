Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16179C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 18:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzKCG-0002Nw-LT; Mon, 31 Mar 2025 14:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tzKCB-0002NA-DU
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:49:18 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tzKC9-0001nC-3e
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:49:14 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3012a0c8496so6243984a91.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743446951; x=1744051751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c34zp6QHzUyuitt4Vixfy5pfieckp6MjfH8iM6VqqHQ=;
 b=ZrCs9NsGL5JOV3201yKNXve9PWp5FdoBbRsPz7GuL+S6yIcvLqN/ql6xV2W2+5dP17
 dXmamtjgB1cDMcW66VrxoRZ5BpqXTnYr0NSaPPX//OCoxl+M1UC1CDA201jgBAVVtIew
 PqwLPXHnBvaz0N4HtTEozut9gFUs1ONarPV1AUTqUCvaoHQZBOhnSXsL9tAB+bAzYsA2
 7qG6K7m/JZ5NP37o6b7nKlarxHaz6k1HZiWLpsTBqbuhfZ4b32sHbgrAgXSojyQjN7qn
 UTVLbQnaQaAUln7UOv8cWafuonZECBKDkOFiQEb04EyHSfgQR654GuOXJBgn201L6y6G
 KlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743446951; x=1744051751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c34zp6QHzUyuitt4Vixfy5pfieckp6MjfH8iM6VqqHQ=;
 b=QKh2Itj1HvHaC52lKjZVhfAXXFuBbmwPsp+2JmHLOsUDr+R7uzveg4R/uc2pgc5Xpm
 XQiYOBpf1BWS2GaZY5Ua90jK/h/RRQm8Q+hqNldmhqlpDTBtEcOA+stgERYcGemjO2sM
 H8sAKAqEMk5YiW9g0o7idPuhBldCqJ+V6AagoKi77UpV1a+HNXljzrUuo6nQH8D9YaQw
 E+9EMh9BlJrP0xM7QeJHn1ZSLvk+Zmi7IRTsKM2bSllkoqfU9gT7ZdBhkbnHV8G1CNrm
 pg4+2yvM5G+ZZ6cIF+hafu0zwaehBEloe5s3Pk2jhGaa3Z6IqH46OLcLAkw4ZUplL6AM
 iihA==
X-Gm-Message-State: AOJu0Ywh36j0q3gqa2NuBU02hypdEMmtqD/kYEzqC51HnqZBhJqkYdlz
 QRRRyqMRPeffnFZEkHhEug1UXm8CN9GjvS04Zi3QsZr915/X0guSLqtdgH4t
X-Gm-Gg: ASbGncuSvcnJUlHUr4pD4VnGKKFreqATWdh/iu+Whrb1M8k5/Y+zQdl5MIR8fb3dsMv
 LaCZhp0l28TCQpz0ZjVNe8BhUozTvdapZ8786BONjDeATXMC1o8ksN1aRmK60P99K3G3IyEaojC
 t7lhSKiT1hCrb+CDckDcRXhPDUy4UpIKJnTii1u7qEr5eyObpQNMHccV8osSTZZi+KpVJphfk1o
 abu4lZ2vBWOoSFuMDzG03xtH4nKdPFqTvWD6moC5vmZi3hKaaFDja+68tCTAbEgcTOXmgmEbv7L
 S7aPdawTsSA0VeIm1VdJ8ZAtGmdvIbRzCwvGJgmFqpDMcy4e2CI/
X-Google-Smtp-Source: AGHT+IH09QtKdtPBXNgrQlmAh7i9VHT8EfN/XAnHSHHoAZ93tsi681tEdoUf541XKijeVZlg4L0dSA==
X-Received: by 2002:a17:90b:5483:b0:2ff:64c3:3bd9 with SMTP id
 98e67ed59e1d1-3053214bcc3mr13048092a91.23.1743446950867; 
 Mon, 31 Mar 2025 11:49:10 -0700 (PDT)
Received: from blackjackal.. ([2409:40f4:2018:65c1:99be:24ba:7ca2:678f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f1d4f4bsm9928476a91.33.2025.03.31.11.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 11:49:10 -0700 (PDT)
From: Rakesh Jeyasingh <rakeshjb010@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, philmd@linaro.org,
 thuth@redhat.com, rakeshjb010@gmail.com, balaton@eik.bme.hu
Subject: [PATCH v4 2/2] hw/pci-host: Remove unused pci_host_data_be_ops
Date: Tue,  1 Apr 2025 00:18:20 +0530
Message-ID: <20250331184820.34673-3-rakeshjb010@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331184820.34673-1-rakeshjb010@gmail.com>
References: <20250331184820.34673-1-rakeshjb010@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=rakeshjb010@gmail.com; helo=mail-pj1-x102f.google.com
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

pci_host_data_be_ops became unused after endianness fixes

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci/pci_host.c          | 6 ------
 include/hw/pci-host/dino.h | 4 ----
 include/hw/pci/pci_host.h  | 1 -
 3 files changed, 11 deletions(-)

diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 80f91f409f..56f7f28a1a 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -217,12 +217,6 @@ const MemoryRegionOps pci_host_data_le_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-const MemoryRegionOps pci_host_data_be_ops = {
-    .read = pci_host_data_read,
-    .write = pci_host_data_write,
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
 static bool pci_host_needed(void *opaque)
 {
     PCIHostState *s = opaque;
diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h
index fd7975c798..5dc8cdf610 100644
--- a/include/hw/pci-host/dino.h
+++ b/include/hw/pci-host/dino.h
@@ -109,10 +109,6 @@ static const uint32_t reg800_keep_bits[DINO800_REGS] = {
 struct DinoState {
     PCIHostState parent_obj;
 
-    /*
-     * PCI_CONFIG_ADDR is parent_obj.config_reg, via pci_host_conf_be_ops,
-     * so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.
-     */
     uint32_t config_reg_dino; /* keep original copy, including 2 lowest bits */
 
     uint32_t iar0;
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index e52d8ec2cd..954dd446fa 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -68,6 +68,5 @@ uint32_t pci_data_read(PCIBus *s, uint32_t addr, unsigned len);
 extern const MemoryRegionOps pci_host_conf_le_ops;
 extern const MemoryRegionOps pci_host_conf_be_ops;
 extern const MemoryRegionOps pci_host_data_le_ops;
-extern const MemoryRegionOps pci_host_data_be_ops;
 
 #endif /* PCI_HOST_H */
-- 
2.43.0


