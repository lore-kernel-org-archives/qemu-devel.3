Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281F4C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 22:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raNfT-0002yt-Iv; Wed, 14 Feb 2024 17:23:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1raNfP-0002yC-DP; Wed, 14 Feb 2024 17:23:47 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1raNfN-0004LC-Sl; Wed, 14 Feb 2024 17:23:47 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e104a8e3f7so284070b3a.1; 
 Wed, 14 Feb 2024 14:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707949424; x=1708554224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=js9MPuxE6HDFGb/bm1Qi8CQe6wvYU0HraTNqQ6YK0o4=;
 b=Ay9qMNrYgER2xOMZL+vJZOksnwalFAA73ji2cdpZxtz3CZ6RtJTUJT+PtaysKdWct5
 qYpe4gwK22ceeV8LygmGRMQNmZnW/vP2xgnp8vWkiDGEXhYVSQJsUqD9EsMke/OM8/eP
 4amCbDb2PSevNR75kMgUz4W1gsdLU3VFYgoxYF0VrRxktTR0TBK8on3AkiIKC4LLy4UD
 bNN3Xy83zAL/NtA2HDgS2OzoPRaPDIba9J6E9QbuY7KZ8qNCuQLFFwttiYraxkgpkPU3
 AhjeH5cW7/znayBMhu5QuoFQiXbx8r4P4yQnNbmjLzC/o1tcOcji11PArpLatMbIujWr
 3G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707949424; x=1708554224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=js9MPuxE6HDFGb/bm1Qi8CQe6wvYU0HraTNqQ6YK0o4=;
 b=UtpqusBnWVV8zFbNKCwLixLwU2uObMb+5hBbR1m2TTC2ufgzNKzWHiDbKYdge3tmdx
 DBeuClTrFZ/UQH4D3xYD3Ij6c1N+kQEyD59CJ4dIQiv/dgqZQwiqgoaQsqCkrOKHzM6Y
 YEGyQR4zhas+gEGK1ZsQr6KgQfUNPFIP2l4F3I6h5tx33OAu9Zz33xQKRvrYceb6ePe4
 yIBwF8FcQhf/YMqPN4HNIpAMuSNuqMUez/Tvhyt5qx5KT8bDEy1jHTrM+lcf9tmlmfgk
 EQk5SmlyX4Tn4q8hCYWH1hzyRT+0s2wClUgeehQNNqqO3pV+Edj0ysV0CsR9Nqu4sECM
 r/Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbajInvIaiOT7FD5/B7axHErBEbFK+R25OZ4EoAi4XI/h0dt6eQHQ1MPxXXGuoIZpKKxGjaKnwKWoS3r9A16dLQVfudmQ=
X-Gm-Message-State: AOJu0YwcDFfMRYkiFZK3j3/yTYRXXngWqvaEfE2i1dKMDxaxfwVhIWuX
 2mkwNnBgawb0FkgG1XcyDc5UmgbnsKAa5uVd3zP1rK0gEryngJXOiF8lRFHYGM8=
X-Google-Smtp-Source: AGHT+IGjqh0+2tP17eVBq7c1nX/+GlZ5zdJ4IsNWQw8zJ16xuLByBCHpRakHmYfe5OdE8oaCDFVYEw==
X-Received: by 2002:a05:6a00:1995:b0:6e0:e618:7eb0 with SMTP id
 d21-20020a056a00199500b006e0e6187eb0mr216238pfl.8.1707949424231; 
 Wed, 14 Feb 2024 14:23:44 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWuNLFg88Ex74oHJDi16aHb3teNa0ZVrj9kTmQXtICY886iND3h/U0xWUcMqM9HfV1wvLtnXEwT04jMa9/tEd61efPHSwHKfIQ3v12Yrn3QFNVAD5wEnw+uJylTvhW+SW5TQZ/8rMJjXZJi3i6/L7GfTPgldZ+r84thnqHrJka1F9YdLbJS
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 t27-20020a62d15b000000b006e03a640007sm10215269pfl.71.2024.02.14.14.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 14:23:43 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 1/3] hw/nvme: add Identify Endurance Group List
Date: Thu, 15 Feb 2024 07:23:35 +0900
Message-Id: <20240214222337.5699-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214222337.5699-1-minwoo.im.dev@gmail.com>
References: <20240214222337.5699-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


