Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA57C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhEEP-0005SK-V0; Mon, 04 Mar 2024 14:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEL-0005RU-25
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:10 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhEEJ-0006uq-Ku
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:44:08 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dcc71031680so4588939276.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 11:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709581446; x=1710186246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkPmI8FuszQzNKc/W7C7bH++18bz1caF1vBxyxTADMI=;
 b=RNYJQ5UMOFZyfMnu8Y1OyEACreeKPx9gFgDM7sTnHi1yL1/AR32Zbex0yppTGCRtab
 YpPqO2vhZMPQ4ePDWhvPtNfC1eLemJG498LD034lhyj1OFNOjOeFMDIvM8CjhOVASQU6
 vKTJm2WiGGA4IEGbwjLUsYL5vYBpLLcrvR2UJkp+O6+MfBIosOLFxrmFRutGBdaaiCMr
 l6VQzDSYaJ/znip+VdXTiIq+LmbYO56XC9Y74xjyxzL+cfcgkhFLVkj2MveazkGZIvJo
 uthfCdaND1FP/Hn5AwlDQF5je9EYvJxcDtAscZmZz8R3NEd2iZntRmo0QJ3bJA1mj3Aq
 pKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709581446; x=1710186246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AkPmI8FuszQzNKc/W7C7bH++18bz1caF1vBxyxTADMI=;
 b=tR/FuR2ATupImy0vrF1gmwWtl5lreM81iMABE7pE0djUydrm7sG9bNAq9p89QAu5T9
 rZLhKiEvnONp1gBvysu0MmVmJa1cT6uIY0Yd2BPzwrelAYC3amYHPqE1X09HpJxuGiD0
 Fmjd6adORLniPgGg82AxjQi04rkNiILCh9t+ZYQ7g9SFOsCgchzPPybyEFAQlFphbRVj
 dcUQpA4VFavDT8hsP+i3P0v0N+xk7j+d8xJSc658vArEIZh2cJV3oJBl1RlBFsXZCp9x
 TPoC66PEtSBrZzdhdIFhkIt2xue7VsezVN48ldROAOAqmjrMItodHBrxf79K0EDvcmxR
 oKlA==
X-Gm-Message-State: AOJu0YwHcgFyBsP23/EFdWlY9zcRlxjS7U6V4FPxIWydJktBoE+ktYGV
 Zzc8gsT+iyNp0arPKIge7ZvVLb3WTnrxo3jeFznOA69j4e4HMmOHQs+2gPm/
X-Google-Smtp-Source: AGHT+IF8Ycb0Ig4cvVD+KZC7NiE7FpVTQX5T1d6xPH2bLLUEk6Pr5KEZbkD4FKZ2xmlpNCQuOqLiug==
X-Received: by 2002:a25:b109:0:b0:dcc:6112:f90d with SMTP id
 g9-20020a25b109000000b00dcc6112f90dmr7174783ybj.62.1709581446482; 
 Mon, 04 Mar 2024 11:44:06 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 11:44:06 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 01/13] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size
 field to output payload of identify memory device command
Date: Mon,  4 Mar 2024 11:33:56 -0800
Message-ID: <20240304194331.1586191-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304194331.1586191-1-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb2e.google.com
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

From: Fan Ni <fan.ni@samsung.com>

Based on CXL spec r3.1 Table 8-127 (Identify Memory Device Output
Payload), dynamic capacity event log size should be part of
output of the Identify command.
Add dc_event_log_size to the output payload for the host to get the info.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4bcd727f4c..ba1d9901df 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -21,6 +21,7 @@
 #include "sysemu/hostmem.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
+#define CXL_DC_EVENT_LOG_SIZE 8
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -780,8 +781,9 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
         uint16_t inject_poison_limit;
         uint8_t poison_caps;
         uint8_t qos_telemetry_caps;
+        uint16_t dc_event_log_size;
     } QEMU_PACKED *id;
-    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x43);
+    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x45);
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
@@ -807,6 +809,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     st24_le_p(id->poison_list_max_mer, 256);
     /* No limit - so limited by main poison record limit */
     stw_le_p(&id->inject_poison_limit, 0);
+    stw_le_p(&id->dc_event_log_size, CXL_DC_EVENT_LOG_SIZE);
 
     *len_out = sizeof(*id);
     return CXL_MBOX_SUCCESS;
-- 
2.43.0


