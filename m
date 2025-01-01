Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D25E7718B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2025 08:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSttv-0003hS-QY; Wed, 01 Jan 2025 03:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tSttu-0003ge-3u
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 03:16:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tStts-0004Lm-Ki
 for qemu-devel@nongnu.org; Wed, 01 Jan 2025 03:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735719379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=M/DGQVvJ6pD8EPF6A3oGVPxri4BF+dfcHR3gxhYHa20=;
 b=VxhDvBrn2hRnioXHIgwTJ2IFXMJefbMxFhuuacg0sTMOtCTS+o8v4DK+TQYG6UhKc4KTw+
 mMTwoldJv+TQ3qRwNKiWQG3IVowYu9REiHYpXROGO2sZr76PwdaK0uYzYMDCKo9b+5xOAj
 ad40xD++SRkeJTmJZnE2+wK7GJ8gxkA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-d9SfKgULOmK1LzxcrWz8pg-1; Wed, 01 Jan 2025 03:16:16 -0500
X-MC-Unique: d9SfKgULOmK1LzxcrWz8pg-1
X-Mimecast-MFC-AGG-ID: d9SfKgULOmK1LzxcrWz8pg
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2f2a9743093so14665015a91.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2025 00:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735719375; x=1736324175;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M/DGQVvJ6pD8EPF6A3oGVPxri4BF+dfcHR3gxhYHa20=;
 b=dI7ziLbTDp+BtTt7EG7pxrNfWaK+TjFNecrC1sK2sDnK5S285kLXT7uWDlCpDYSI2s
 l5Erw/5v9CVuilMYXA8kfYk5FFnMmKutcCWST4wyE2owK20NTKpmcQgKuvZ7SEgPI4hJ
 5XRYwhAjmfKnH6qi+A5hE9880mSYTVihHE6XeoGSLqwVvtJqoxpj3QF47VuMDiv7XhTp
 FvipN/QdUTEbq1CZBvmdvYrFwoAVzZ9GhPnH4eKojtNBlKPYpyQMO9qqBJsqZl0/ewhB
 zoRhOUuaV3dikNPxUWbpSuKhIg+UPO2HYqKrd7bF20bNDVW/DXFYg7v1HJhAvBwjSOxh
 0PiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgB+3Z1UXBSUdIow88d/zCtA2it3AoEbiWzudZj88KDalNPe1cwPe/iaknTcrSCWBl+OA20CIxSnSB@nongnu.org
X-Gm-Message-State: AOJu0Yyd3qlyUTlvaP5Lq3bdxo8/FrsS+HIAOM3ynUcBL3qy+Ue4iUuv
 kXCD5uawRJzgV2U/oql1rEjNLfasB1GVI0CcnunqHvMVa5LSpnOy2lylSnqN/uSFI4FnTN4HMC+
 Cxj0rAGSecrjBCqYOT5qKLmE1EN4nVK0mjoqdiSN/hWxd2Xw2luB0
X-Gm-Gg: ASbGncsFiy2HdHbsngozSiIYJI8KhPXiIxn9zKsOexf24mrkS1uOSkgjIMSjr3zrYPJ
 kcECHejPx95AWK3QoV6RDYKqDWMqhndZQ0kst58llD0VeQ0qP7N6hTFuYjqPGtpJFFV7xvk3D2P
 yI1TrQXbhXge9sv5wVG+iErCH+c11CNEZkPEcMlZGxVKjmkxbj1ATPmT0lOyGEXk/dSkgeoAdpn
 R4oLvYOFsQ/LhDXyvUjOyPXnBuyIrv5PbHoNVo6gTw5azVfWlxa1BQW3xedkuOUXvmUc53q5sUO
 AA==
X-Received: by 2002:a17:90b:2802:b0:2ee:8358:385 with SMTP id
 98e67ed59e1d1-2f452def795mr62334102a91.4.1735719375216; 
 Wed, 01 Jan 2025 00:16:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGF2/sz5tqb9cQQb4onPZRZfjAFk6O5RDLNTSf95ce/gijJmPoZyVDAON/A9UCan1Oflh4aSQ==
X-Received: by 2002:a17:90b:2802:b0:2ee:8358:385 with SMTP id
 98e67ed59e1d1-2f452def795mr62334084a91.4.1735719374961; 
 Wed, 01 Jan 2025 00:16:14 -0800 (PST)
Received: from localhost.localdomain ([115.96.136.4])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-219dc96313esm205447335ad.20.2025.01.01.00.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 00:16:14 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] qtest/fw-cfg: remove compiled out code
Date: Wed,  1 Jan 2025 13:45:55 +0530
Message-ID: <20250101081555.1050736-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.188,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove code that is already compiled out. This prevents confusion.

CC: qemu-trivial@nongnu.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/fw_cfg-test.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/qtest/fw_cfg-test.c b/tests/qtest/fw_cfg-test.c
index 5dc807ba23..e48b34afa5 100644
--- a/tests/qtest/fw_cfg-test.c
+++ b/tests/qtest/fw_cfg-test.c
@@ -243,12 +243,6 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/ram_size", test_fw_cfg_ram_size);
     qtest_add_func("fw_cfg/nographic", test_fw_cfg_nographic);
     qtest_add_func("fw_cfg/nb_cpus", test_fw_cfg_nb_cpus);
-#if 0
-    qtest_add_func("fw_cfg/machine_id", test_fw_cfg_machine_id);
-    qtest_add_func("fw_cfg/kernel", test_fw_cfg_kernel);
-    qtest_add_func("fw_cfg/initrd", test_fw_cfg_initrd);
-    qtest_add_func("fw_cfg/boot_device", test_fw_cfg_boot_device);
-#endif
     qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
-- 
2.45.2


