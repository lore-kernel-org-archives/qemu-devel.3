Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF488C25B78
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 09:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7uH2-0002MG-RA; Fri, 17 May 2024 05:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s7uH0-0002LT-EX
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:53:10 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s7uGq-0006QL-50
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:53:09 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2b5388087f9so898114a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715939579; x=1716544379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+J5rbIfUpvehIGmWcPG1zjcR1aPta5xb+LZyWF/KhY=;
 b=Q6nUk6VPe0/wyaU4If4mS3CBhkCpYb1UrXVNJ1hJnyrIxkndqzLFpFQbOQGc01yAQ+
 2iQcVPzXNt3byBa2b4mrZ8PbSQ510//+W2pMauAFZuQdTu2nvvHCRHOOLTz+ta9T+I6G
 nO4iOr3PbfFXqXbaSYz++Ze9weSKwnFdRZ7otMc3GYTy7D7vGmLtVUTfjXZr5NcJjNoc
 o7qvmBvGZG3AS78rd2B/httTScaGWG3+6K+vEChrKDIt4I+0iBbNIRwL2TP8W9hxgfbr
 RXcF04heSQNrze/8lgO1Zpt4bwFp8PEz5uT6KP2IAzOSYOg7cMviWbgwPO+cWqancYqC
 r6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715939579; x=1716544379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+J5rbIfUpvehIGmWcPG1zjcR1aPta5xb+LZyWF/KhY=;
 b=ZyG3iNWDRaAB6CC2R0aempDqcL8ZAlF8frThEhumMZ033f5Ekkt0igVluPHw2G8Ho5
 oMrhck01l0Zd5iZf/Bi2FzIY0GUqYvmP/YmC1aFp6oZeULDCx1QrrDNLZpdjULJC91GZ
 KVXupVarZJ3J91qJv5Zb5Q2lwbf7LJ6lDa/6zyh2L0oo0hkxxUAMEigiVYfGbPNTND9j
 duqlY+nB2UkDE6nFgm921kQZrlm/VEtHMoQU3xq1NwAlp2IxrEN9ysXt7WXEU4DnBSTg
 U9ns4lxYZeF6OfSr3Nke2Mcmn64YJPSg3uZcCCJlYG/CBuL9MuObz6WWjJ43JM7faXFF
 Q9Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjzcUEW0abbC8gx2xQxLgrB0HBcf3inJiNvQSfZ9nol2KgE4TOz2kvOtb4Pl3W81hJUCy8KcIFykFgNOLd7kndjNpt1m8=
X-Gm-Message-State: AOJu0YzUF124UMDDRooPPNLPFsX63hCPlI2G8JI/SLFfiyOKisudVZ5b
 YDyZdm33zm4HLOZdahPh8LXKeHnJSlCdcdBAcvOYqXmFZDIlklSwTh6aDJFhgaI=
X-Google-Smtp-Source: AGHT+IEsNTB7b2SgKIMyR54BI6pekcFfxKddYkXYktbhD+hctte6J7xdVkUDa/6iOXagDeY2YrWudw==
X-Received: by 2002:a17:90a:c506:b0:2b6:c650:fb54 with SMTP id
 98e67ed59e1d1-2b6ccd86144mr17928087a91.49.1715939578767; 
 Fri, 17 May 2024 02:52:58 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ca53cesm16975992a91.44.2024.05.17.02.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 02:52:58 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v3 08/11] hw/nvme: enable ONCS reservations
Date: Fri, 17 May 2024 17:52:15 +0800
Message-Id: <20240517095218.3107672-9-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
References: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This commit enables ONCS to support the reservation
function at the controller level. It also lays the
groundwork for detecting and enabling the reservation
function on a per-namespace basis in RESCAP.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/nvme/ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..182307a48b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8248,7 +8248,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(NVME_MAX_NAMESPACES);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES | NVME_ONCS_DSM |
-                           NVME_ONCS_COMPARE | NVME_ONCS_COPY);
+                           NVME_ONCS_COMPARE | NVME_ONCS_COPY |
+                           NVME_ONCS_RESRVATIONS);
 
     /*
      * NOTE: If this device ever supports a command set that does NOT use 0x0
-- 
2.20.1


