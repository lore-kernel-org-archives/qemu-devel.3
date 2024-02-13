Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7BEC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 08:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZnuM-0000gO-AW; Tue, 13 Feb 2024 03:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnuK-0000eD-MS
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:12:48 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnuI-0000tg-Nz
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:12:48 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33cd57b86bfso269414f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 00:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707811963; x=1708416763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDigo3VaEMu1N9qxZDm571UBwWnNIeVpjt1aUzhYjcA=;
 b=r0FN62pCs1kidnhu/2RxxfY2K2doocDlkAMfqzL8V9JEeT6/fdGgiSu2En2lzxoL5/
 vxyimfZr3v0obT9cguTdr8YXNRyu+ElbQ86Hjy36gnHJiVN1w3mwdlSQ/479D5nbyKlD
 Wa3zOTeLaN8V/0pE7NnUYWSvcKkPydIjYK3cgX0R+w4mGnpb409jqdKP+EtmZutntKCo
 iaZKHuUNE5/M8CWKX185oSBrPq9cLVPB48NFtcMX/LZf+BZC+T97BEPlWp4l9JBhMvr1
 6XNKiC+Z+VEk9VnJ4SQ/ATZVOeM+2aHxvnx+7M7TTqlndUDHJ9oNvL7UTA7pDask+jhJ
 /Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707811963; x=1708416763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QDigo3VaEMu1N9qxZDm571UBwWnNIeVpjt1aUzhYjcA=;
 b=NLaypr1M4/ak8oVC6hS+2BAioC+tuMLQNfwjyb8PXuOjkSyQcLIetHdUP7BKigItui
 Id1IslwN7TVH8645RbkdeRVHkmjWrYH8wAnRF14RmU6yfYB6zDftgCN1RGKzM8SnxXUE
 97zLvJ9abA4FKgpesMNHC5vxlTIrd48Hd6689Fzh3zo79O38NOXZYtiLN4qz2wP3al/v
 A+EroFAa2h1EcL06SYH6qXNQq9Fsu3SkKmp4f3Z9zELCvWdrUcSUrPXOvqAkztEnSRhP
 AAq31Xd7IpWy4JvGQ2VqxrBFBQQ0EoRH4530WANz+1KS2UavhUTk3wnczXfCKoUG1apL
 k5Vw==
X-Gm-Message-State: AOJu0YwqMksjAVvD68oKo8rheY5JSi7zZb1gcN8ia70OgzB8W32bkI4O
 Qsf7r4zlaXYZZXfQgqxkmA8R87Uz+BrGUocjv+izzdfwY3hgDVSeNHEVmLVp2MkEsKPm/Fkwoo7
 L
X-Google-Smtp-Source: AGHT+IEf0sAKjH806V1tAGv1IXhVy/FsJOQAWk4T95MDi2Q0YCVei/0+Fk8Rp55UjppPlI5sqU+Vlg==
X-Received: by 2002:a5d:6c6d:0:b0:33c:d88b:bc5a with SMTP id
 r13-20020a5d6c6d000000b0033cd88bbc5amr799050wrz.34.1707811963439; 
 Tue, 13 Feb 2024 00:12:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXSXrtsPG9g3efdKsqit9qYtcUzRvSrnd+k0Pl5vgN0tuKFia2vMbuvE+J4LMwegiPd0NdW0OPllB4VVSIjuV0AO44GPgDHEsh5FyV914eSHTb6E/sVEKPoxnfg3mXRj+7O2IHheBhHqlWNRW+kogul0gT2lbiXd526KuZP6NG9dD/ZL6ClHZvwAhBFr+3G7BqE7vsOQCYp1gYBmM9gnIyB7Ee8HM+lRcL4tY+8wlySq1fvyNHikhlbFMxn31ACmWSK6zJiz/u0uJoPLuc4xsyb0QmCfvc=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d4b09000000b0033b843786e1sm4085476wrq.51.2024.02.13.00.12.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 00:12:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/9] hw/ide/ahci: Convert AHCIState::ports to unsigned
Date: Tue, 13 Feb 2024 09:11:57 +0100
Message-ID: <20240213081201.78951-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213081201.78951-1-philmd@linaro.org>
References: <20240213081201.78951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

AHCIState::ports should be unsigned. Besides, we never
check it for negative value. It is unlikely it was ever
used with more than INT32_MAX ports, so it is safe to
convert it to unsigned.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ide/ahci.h | 2 +-
 hw/ide/ahci.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index 8cd55b1333..604d3a0994 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -46,7 +46,7 @@ typedef struct AHCIState {
     MemoryRegion idp;       /* Index-Data Pair I/O port space */
     unsigned idp_offset;    /* Offset of index in I/O port space */
     uint32_t idp_index;     /* Current IDP index */
-    int32_t ports;
+    uint32_t ports;
     qemu_irq irq;
     AddressSpace *as;
 } AHCIState;
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index bac1871a31..2c3306dae4 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1819,7 +1819,7 @@ const VMStateDescription vmstate_ahci = {
     .version_id = 1,
     .post_load = ahci_state_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT_VARRAY_POINTER_INT32(dev, AHCIState, ports,
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(dev, AHCIState, ports,
                                      vmstate_ahci_device, AHCIDevice),
         VMSTATE_UINT32(control_regs.cap, AHCIState),
         VMSTATE_UINT32(control_regs.ghc, AHCIState),
@@ -1827,7 +1827,7 @@ const VMStateDescription vmstate_ahci = {
         VMSTATE_UINT32(control_regs.impl, AHCIState),
         VMSTATE_UINT32(control_regs.version, AHCIState),
         VMSTATE_UINT32(idp_index, AHCIState),
-        VMSTATE_INT32_EQUAL(ports, AHCIState, NULL),
+        VMSTATE_UINT32_EQUAL(ports, AHCIState, NULL),
         VMSTATE_END_OF_LIST()
     },
 };
-- 
2.41.0


