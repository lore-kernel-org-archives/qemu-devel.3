Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE828C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0AZ-00035w-04; Wed, 05 Jun 2024 19:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0AW-00034k-Uq
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0AV-0005W0-90
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2dkENUzfzIIIcUTPF2EEwEXmUV3lpfWAm7D6XMdf5LE=;
 b=eeEhhpKbBrVGq/tlFQDQ/bk9Nl+aHdV8MlNnPeovP3ZKVUcSQV/QwfsbtjctetjVdVEGmy
 oA+8+1m2fiEEI5O0rbFveE3PkY2c42fQ88w33d0CqTpTB7aYWpt6u+mMHDrLkaR81CH4yW
 nFcKMk98axwpq+uw5BhwOh71RZQlCJA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-gmBMSoZtMca_9BS6ySEtiw-1; Wed, 05 Jun 2024 19:35:45 -0400
X-MC-Unique: gmBMSoZtMca_9BS6ySEtiw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57a306c4b1eso128972a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630543; x=1718235343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dkENUzfzIIIcUTPF2EEwEXmUV3lpfWAm7D6XMdf5LE=;
 b=fi7htBuNbNYOxw5CxjIWC4vswbGVQHdsQGb+VHfhDtc4kdxRzbkRzVKDxFW130kJVY
 1sZg/ui1gqPPhire70M/DTmaL7xEPuyLqD9Fs4smjPZm0VZebiVaG9PtaAxrMQgbuMDq
 2kP+PX1cTHoMEMl+7d3faso01YgvLPNoz885hYwZ549bicrQFWiGKHoc/yF+YUqozI77
 q4D0VqrLKEM7MSAkb0jexfyQZb6zunQy+ddYr8e0EdDx6a7U2KRw8ZifsOMHh2gq3MpN
 2JIJh8pkjtmBeHFa8GrXGxsj4Yb6Fsl0rcY5v3rHXxyBW8c7hr6p/3rdbDEY4JK5W9SR
 gKlg==
X-Gm-Message-State: AOJu0YzcvhR84Jgz4wOF1LYp1hgL+Dflpq6tehNlXys2LrbMYSCfNqia
 DkxzmOBrLqb+0gO3qYm8tQHPiOH+ePT9LwlpI3g6m7db6m1+OLYxsTO3YzhO58CvrdHv5w95Owc
 /TmcxglsqJlJELG4SoYLzYwI6b3aUc04nt6b4eTP83VBhflMYCm9aKBpnvirPdFrvngh5RXYELL
 YsHS5GJ+jAqTZJlTcPHHM2L+4GvCrMgQ==
X-Received: by 2002:a17:906:410e:b0:a66:76f2:71bc with SMTP id
 a640c23a62f3a-a699fa9e0f4mr264693866b.24.1717630543380; 
 Wed, 05 Jun 2024 16:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5MLggCZSot0KijJNh4rtbG9R8nxOFWS5h+P0EhcfEwp47I5KEmIMd1qQv9yRgBKUJq1kq8g==
X-Received: by 2002:a17:906:410e:b0:a66:76f2:71bc with SMTP id
 a640c23a62f3a-a699fa9e0f4mr264692566b.24.1717630542788; 
 Wed, 05 Jun 2024 16:35:42 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8058272bsm7196166b.18.2024.06.05.16.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:35:42 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:35:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gourry.memverge@gmail.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v3 16/41] hw/cxl/mailbox: change CCI cmd set structure to be a
 member, not a reference
Message-ID: <e3f84457c051ce7c4e03135d21ae8162c98470ef.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Gregory Price <gourry.memverge@gmail.com>

This allows devices to have fully customized CCIs, along with complex
devices where wrapper devices can override or add additional CCI
commands without having to replicate full command structures or
pollute a base device with every command that might ever be used.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-2-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  2 +-
 hw/cxl/cxl-mailbox-utils.c  | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 279b276bda..ccc4611875 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -164,7 +164,7 @@ typedef struct CXLEventLog {
 } CXLEventLog;
 
 typedef struct CXLCCI {
-    const struct cxl_cmd (*cxl_cmd_set)[256];
+    struct cxl_cmd cxl_cmd_set[256][256];
     struct cel_log {
         uint16_t opcode;
         uint16_t effect;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e5eb97cb91..2c9f50f0f9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1447,10 +1447,21 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
                                  bg_timercb, cci);
 }
 
+static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256])
+{
+    for (int set = 0; set < 256; set++) {
+        for (int cmd = 0; cmd < 256; cmd++) {
+            if (cxl_cmds[set][cmd].handler) {
+                cci->cxl_cmd_set[set][cmd] = cxl_cmds[set][cmd];
+            }
+        }
+    }
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_sw;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
@@ -1458,7 +1469,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set;
+    cxl_copy_cci_commands(cci, cxl_cmd_set);
     cci->d = d;
 
     /* No separation for PCI MB as protocol handled in PCI device */
@@ -1476,7 +1487,7 @@ static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
 void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
                                size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_t3_ld;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_t3_ld);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
@@ -1496,7 +1507,7 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
                                            DeviceState *intf,
                                            size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_t3_fm_owned_ld_mctp;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
-- 
MST


