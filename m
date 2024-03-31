Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC14CD1284
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 19:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rr0tH-0000IX-RE; Sun, 31 Mar 2024 15:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1rr0tG-0000IG-AZ; Sun, 31 Mar 2024 15:30:50 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1rr0tE-0001Pv-OP; Sun, 31 Mar 2024 15:30:50 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5d42e7ab8a9so1813959a12.3; 
 Sun, 31 Mar 2024 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711913446; x=1712518246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=js9MPuxE6HDFGb/bm1Qi8CQe6wvYU0HraTNqQ6YK0o4=;
 b=akEv1Ton/31SWx/CfmZwlLOCVrUGPWvM9I0/EGbR5N9gItN5XwLLSacCg3lqNVGpuK
 4j/MTpX4D05EwrnSBzQb+ZfPDn17C5fOADE0JoTJIEVO4H8+05YKpKNJ3wFpMuU/M/+G
 FNNXm2aPQTav24E2QGytH87QgJgd7pTKUIs1Qpq4vX6a48QFEkQhEm5z19oPcAU1B8eq
 hH2+PT3YVFpjC78Rd0AtLhUaGry2nTMb8SiY8D6wY5/xWtzd4dvdDTQgqLlyLT/olK0Z
 F8xnRxegrQ/rPPUJSZHRmIniDCDW0TSjtl57wlZ3V8BzJYM/3b2LIcnLfw8RrvX8QLfr
 nXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711913446; x=1712518246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=js9MPuxE6HDFGb/bm1Qi8CQe6wvYU0HraTNqQ6YK0o4=;
 b=ouLSxUM86S5lt3UwqKyNGZKlO5b+vbHEnuIy20CjMzPSujiFbly6B86z/8tQdLrioo
 FmviPjEVT5ewTduSUn0SoCuvod+w/eeOIZGnltTCNlxb3m60FEAkqJZVW5yfT/ps74hO
 w0juXFgjfNkg6IMbJHq/0qDl/k4xanOUtRQL5BB6aFsDad/AzK5flakLZ3xUauhEsNJZ
 aJFNhBKZY+AXFQLuxy9fVKMr2O0+gDof3DqTILuDurFvgRdDAT1E0qecIq820LcCVuhR
 4g/lBKoI+6hhFjS//EhLKqhS6D6cMwGK53jTDkxSP1AnNAt9mKd43cT+yjesp6ZFi6Ya
 lsrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9+Hmwqx6FknrMeew7z2IdFrYf8O35sBfFWaHmDqyjF4B/2D0OxPCIc5eo6VAa0hE6HFRg7MvUuDl8q47pmEQItDWZ9GU=
X-Gm-Message-State: AOJu0YwPRQwPsOz4m2/1lZ0sbbw8RFp920LV1yhTHaCYB9tshJvxuecO
 e2nu+El4Ifvm+GqNiy2OqEKFjz2CybUcwWZ6oTHXRcabxuObE9Hu
X-Google-Smtp-Source: AGHT+IFhf0fx9aXtbewMkV+ijIhcG6WT5qJeTWTELqHJyNpgSsNuDN1yJYSdtKa8UdQqlZ/bANbIqA==
X-Received: by 2002:a05:6a20:6a1b:b0:1a5:6f67:3f63 with SMTP id
 p27-20020a056a206a1b00b001a56f673f63mr7724117pzk.0.1711913446195; 
 Sun, 31 Mar 2024 12:30:46 -0700 (PDT)
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 s16-20020a170902ea1000b001e0afbb6d99sm7232394plg.47.2024.03.31.12.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 12:30:45 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v2 1/4] hw/nvme: add Identify Endurance Group List
Date: Mon,  1 Apr 2024 04:30:29 +0900
Message-Id: <20240331193032.5186-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240331193032.5186-1-minwoo.im.dev@gmail.com>
References: <20240331193032.5186-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Minwoo Im <minwoo.im@samsung.com>

Commit 73064edfb864 ("hw/nvme: flexible data placement emulation")
intorudced NVMe FDP feature to nvme-subsys and nvme-ctrl with a
single endurance group #1 supported.  This means that controller should
return proper identify data to host with Identify Endurance Group List
(CNS 19h).  But, yes, only just for the endurance group #1.  This patch
allows host applications to ask for which endurance group is available
and utilize FDP through that endurance group.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 22 ++++++++++++++++++++++
 include/block/nvme.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f026245d1e9e..cfe53a358871 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5629,6 +5629,26 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
     return nvme_c2h(n, list, data_len, req);
 }
 
+static uint16_t nvme_endurance_group_list(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint16_t list[NVME_CONTROLLER_LIST_SIZE] = {};
+    uint16_t *nr_ids = &list[0];
+    uint16_t *ids = &list[1];
+    uint16_t endgid = le32_to_cpu(req->cmd.cdw11) & 0xffff;
+
+    /*
+     * The current nvme-subsys only supports Endurance Group #1.
+     */
+    if (!endgid) {
+        *nr_ids = 1;
+        ids[0] = 1;
+    } else {
+        *nr_ids = 0;
+    }
+
+    return nvme_c2h(n, list, sizeof(list), req);
+}
+
 static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
@@ -5732,6 +5752,8 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
         return nvme_identify_nslist(n, req, false);
     case NVME_ID_CNS_CS_NS_ACTIVE_LIST:
         return nvme_identify_nslist_csi(n, req, true);
+    case NVME_ID_CNS_ENDURANCE_GROUP_LIST:
+        return nvme_endurance_group_list(n, req);
     case NVME_ID_CNS_CS_NS_PRESENT_LIST:
         return nvme_identify_nslist_csi(n, req, false);
     case NVME_ID_CNS_NS_DESCR_LIST:
diff --git a/include/block/nvme.h b/include/block/nvme.h
index bb231d0b9ad0..7c77d38174a7 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1074,6 +1074,7 @@ enum NvmeIdCns {
     NVME_ID_CNS_CTRL_LIST             = 0x13,
     NVME_ID_CNS_PRIMARY_CTRL_CAP      = 0x14,
     NVME_ID_CNS_SECONDARY_CTRL_LIST   = 0x15,
+    NVME_ID_CNS_ENDURANCE_GROUP_LIST  = 0x19,
     NVME_ID_CNS_CS_NS_PRESENT_LIST    = 0x1a,
     NVME_ID_CNS_CS_NS_PRESENT         = 0x1b,
     NVME_ID_CNS_IO_COMMAND_SET        = 0x1c,
-- 
2.34.1


