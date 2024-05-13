Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4584FC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 03:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Mkn-0001Oe-ET; Sun, 12 May 2024 23:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6MkX-0001Jj-0x
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:53:17 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6MkT-0008Lk-Sm
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:53:15 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f472d550cbso3144910b3a.1
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 20:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715572391; x=1716177191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+J5rbIfUpvehIGmWcPG1zjcR1aPta5xb+LZyWF/KhY=;
 b=U/AFihFqjz0mxS2uWdaoQYnur6EU6ikH/W2qV39ZiQgsYS3bzEyydcVw+A2B2AfWMB
 xmUWaMQamEV+79Bqnt+gAnZn/LmhGoW4vLO+c61r6RSryUEWKAD4mVtRP1llmp2XJpwI
 1RpV4UkFDj+y1F1G8ZC59bUgwLwlUNvb4LEDyju9R9Ogw9ODJJqcP+mrciBJFpeyMMap
 V1YwYUkGMIoku5YTzePV3uS14Q7pOPxlRd8dGFNz+DFPgOU1Jg84y3mxlLLwPTibAOKg
 IQOqzvrUrx6ejMkvTBWHRYLRugHynllMTOiffdzgVEpZpXYcn/dMRjgwXLZov5qNUujZ
 cc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715572391; x=1716177191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+J5rbIfUpvehIGmWcPG1zjcR1aPta5xb+LZyWF/KhY=;
 b=GSMMeZfFL1VmOj0vQNgpmFRtTvrIIzyV7dLhcHnLwYfYJhohoepyaRV5U3tlDuuHGH
 bMP8p5LMnBnabittzYsgXtrg/yKpwdBjQ2Ypu9bkq6VgmzOn4XUF13dynZLdPCS1/Fh1
 /D/zU08104tNcgO6Frj7TGAyIp+TriYIMcniyG+r9SbTMG47zE2XnUgd5RhYl5zzuUQB
 I42p1RUYsAK3ZvYPm4fv2LjfdYuqfu//2rPdxub20LHdnpIygZvHY4tmb3VRyLJ2XnKy
 FDUPvqWzxpJeJKecxj9aiA5VNqS+BQ9sXOaVVJEEzQQ89EHubp/ebjuNxCvXMFWRAH6R
 gmyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKpGD1k0r0m1cWjJVX5OZ69/OgpzcjmQr9KzGQOrC5z5sEZllCAxmeqs0GNdbgz5/beHczDkl9qcZvuWPdQe2HXpd8aWM=
X-Gm-Message-State: AOJu0YxVXyXQboxauXSqPgYLRVBLl7ocHCqgfjzQBPtpFsNUdwxGL8p/
 tXLXIeeOE02d7zb49RvZVTkTB+WvZkmz9p9lwLy6M/4ARaZ3S4cpGihKSwJi0So=
X-Google-Smtp-Source: AGHT+IEb7YcESQVycOnJJGFN5KAkU52Zg4YkDArryJlm1dUVePR5yJf0hOPDtfrIZHqX9wXiWCTFqg==
X-Received: by 2002:a05:6a20:7faa:b0:1ad:1168:a417 with SMTP id
 adf61e73a8af0-1afde0e6b67mr13703910637.28.1715572391490; 
 Sun, 12 May 2024 20:53:11 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.40])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a8137asm6407947b3a.45.2024.05.12.20.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 20:53:11 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v2 08/11] hw/nvme: enable ONCS reservations
Date: Mon, 13 May 2024 11:52:27 +0800
Message-Id: <20240513035230.60162-9-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240513035230.60162-1-luchangqi.123@bytedance.com>
References: <20240513035230.60162-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x42b.google.com
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


