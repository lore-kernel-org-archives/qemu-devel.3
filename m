Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB6DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFfZ-0000kP-EB; Mon, 18 Mar 2024 12:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfS-0000Ba-Qz
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfQ-0004n7-Mt
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6/92uxUK8rityKiz36sQzzfXKAYAnQ5fkEB0NWVuirw=;
 b=XoYbyUIxSDs88hU5sGv8fPOWaR4GFhvs/yWTqr1k0z+El67F8biefD5O6vyQNliHxl4M2f
 n4WLKVKi/wG0CHBlWOzbBMhTebXIzqeuvlLXQ9IomTp6IF7/Cn8QQ3COXtg8M+I/RT2qPn
 vBAJEeiCQncm3PA6+JjIvTn8qE3052g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-c0vqcgjHMSC-VdmxF_hbbg-1; Mon, 18 Mar 2024 12:16:48 -0400
X-MC-Unique: c0vqcgjHMSC-VdmxF_hbbg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3418412a734so76634f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778607; x=1711383407;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/92uxUK8rityKiz36sQzzfXKAYAnQ5fkEB0NWVuirw=;
 b=ZkLo6HIhXiDTamD9uTaXXfokAcy07WdkKrjN92ato1vROsd/Nhjmg8q5j4CDWWxdOv
 K89UafC5Fy+uiwtvfxHJ7c1dVZGF4FopBvLJ3YQGfNNit/X2kZIeCaPsCHAU0RlsigS0
 7Ku3uKfaUK23Y/x/GEVk1zT6dxkSZmU854IrguUcuYPpUaafxqBiskpmx5n8JQ7+qSa0
 FrQibGUmkoLByBVlps3mXeIPtrYoNqEjHxtHH6bMR/Pqog6ou+x6J6w8GPpIRhl7pAxq
 zT8VYEOAXnf4bj31sX2hy5j4iKbaWKMCCZj8bBnwbqYHONu4/YU0xGvPJ0QFIDZGaS+b
 ugtg==
X-Gm-Message-State: AOJu0Yxtvlsm2+Z4v3ZByQP8S9OvmSHiEHKBXF9c/dth6fHt/pFJNx+b
 bsMdqXDbOBu6y46Hr5Yx0CAxyGbEAVkcqTVvcbrOpF2sTnip/o758rBbA/qE5QZLT+ioPw1FSWI
 Zvd1fN/wiMBLp2uoZI8Ogml0FjYd3olyaAy1sQhEsdRGoAlwVSMf9eHa+bcPBIdJF/nMBQ2/S4S
 QALp1oGB30xt357giD9jrc1xvawvVvhg==
X-Received: by 2002:adf:eed2:0:b0:33e:7f51:c2f7 with SMTP id
 a18-20020adfeed2000000b0033e7f51c2f7mr7866619wrp.52.1710778606835; 
 Mon, 18 Mar 2024 09:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6QpQAIjuYOnlYNrQIC08dF1KZwnCS0o21u8gcqH627NL54m1Bj78w5u2D9tV+oXzJTq44yQ==
X-Received: by 2002:adf:eed2:0:b0:33e:7f51:c2f7 with SMTP id
 a18-20020adfeed2000000b0033e7f51c2f7mr7866595wrp.52.1710778606365; 
 Mon, 18 Mar 2024 09:16:46 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 t14-20020a05600001ce00b0033d6c928a95sm10153073wrx.63.2024.03.18.09.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:16:45 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:16:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL 20/24] smbios: error out when building type 4 table is not
 possible
Message-ID: <5ed7948213af8cba0c6153611aa0aea55069bac2.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

If SMBIOS v2 version is requested but number of cores/threads
are more than it's possible to describe with v2, error out
instead of silently ignoring the fact and filling core/thread
count with bogus values.

This will help caller to decide if it should fallback to
SMBIOSv3 when smbios-entry-point-type='auto'

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240314152302.2324164-18-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index b0467347c5..eed5787b15 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -669,7 +669,8 @@ static void smbios_build_type_3_table(void)
 }
 
 static void smbios_build_type_4_table(MachineState *ms, unsigned instance,
-                                      SmbiosEntryPointType ep_type)
+                                      SmbiosEntryPointType ep_type,
+                                      Error **errp)
 {
     char sock_str[128];
     size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
@@ -723,6 +724,12 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance,
     if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
         t->core_count2 = t->core_enabled2 = cpu_to_le16(cores_per_socket);
         t->thread_count2 = cpu_to_le16(threads_per_socket);
+    } else if (t->core_count == 0xFF || t->thread_count == 0xFF) {
+        error_setg(errp, "SMBIOS 2.0 doesn't support number of processor "
+                         "cores/threads more than 255, use "
+                         "-machine smbios-entry-point-type=64 option to enable "
+                         "SMBIOS 3.0 support");
+        return;
     }
 
     SMBIOS_BUILD_TABLE_POST;
@@ -1111,7 +1118,10 @@ static bool smbios_get_tables_ep(MachineState *ms,
     assert(ms->smp.sockets >= 1);
 
     for (i = 0; i < ms->smp.sockets; i++) {
-        smbios_build_type_4_table(ms, i, ep_type);
+        smbios_build_type_4_table(ms, i, ep_type, errp);
+        if (*errp) {
+            goto err_exit;
+        }
     }
 
     smbios_build_type_8_table();
-- 
MST


