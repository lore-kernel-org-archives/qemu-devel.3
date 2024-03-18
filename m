Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8C0C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFfS-00008o-3b; Mon, 18 Mar 2024 12:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfM-0008Ib-ED
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfK-0004mI-RL
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v7D6ze7bzSDpMd9lkDC7i4XBFfIEIjDkSkct4Vx/D5I=;
 b=ZMC98pu5uGHq3JGMm/HvBdFov6FXMVkUT0A0dSfrX+x9TGsYoRr7XEKRM7DF3d4W7b8B0V
 UPd2LWYV2si8cCJSkyP6NKoDRm8vx81ad/XxpTPFz1gBJv7lwPvVbf2QGF5XQyG/OIPFNB
 U0spB/HTKub9kLNXoppoM6oCWQIUmC8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-GULcyox2MbGPl_nVZt_HhQ-1; Mon, 18 Mar 2024 12:16:43 -0400
X-MC-Unique: GULcyox2MbGPl_nVZt_HhQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ec604d3b3so3044477f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778602; x=1711383402;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7D6ze7bzSDpMd9lkDC7i4XBFfIEIjDkSkct4Vx/D5I=;
 b=pLl0gamj9DQcawQtO3UG7ZE4N5/QxR+PBBSH8ixSnro4RxzydB5jGH9cW0K6B0BOFd
 uHhkNA7fkl84KuaHWvWuiC6RsBBlxAbvRtAT6Bz3aC3c1tkRH/s43hQv1+yyYMm3yEyG
 u7WtE/WqHV9vT5tiL/0qlykbBF/FftodviChJRzvBTG19YXVDSOLyDCcFS4WcrLH5qR2
 iggnWIWyy5tHSC9k3qnfML/nc8ZgsirBRvhswJK0fAMHW7FOY3zCqnH+86hYFb8/PQRl
 +xM/aVNowFEAviaKkbSegwIgZEkHbmXYItwSzeoEUNh3ZG3rGQzSPju+F19nmqbMB6oo
 pImA==
X-Gm-Message-State: AOJu0YyEcO4KmFjAJYogessgxGXJNXd0ej58u2BG4q1qOh38Qo8PYGdq
 LyyS7s0JYp+hCxxYC9EdAeJKfaU52LDlNBIBiZzpXa9pSX0Yee3RuYxW7kFXWsebx3jkNqAx8yH
 cZ3duJusKhf+OB/0tk89XDGsh1OS7ehYC6Fxfg5WwNrFm/KDzK6BjCLX726ZOS4w/DGR3Q07dLu
 BJcOsmc0vHBlWkupxOHb9agA4qH/66AQ==
X-Received: by 2002:adf:f20f:0:b0:33e:c0db:441 with SMTP id
 p15-20020adff20f000000b0033ec0db0441mr9641748wro.7.1710778602131; 
 Mon, 18 Mar 2024 09:16:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVK8ajBREh60Dig4xkRE8jRcSGY9kgqxC5PB8myzqUthBgMW0gE+p9nBw6hpXPGpiPurXNXA==
X-Received: by 2002:adf:f20f:0:b0:33e:c0db:441 with SMTP id
 p15-20020adff20f000000b0033ec0db0441mr9641714wro.7.1710778601554; 
 Mon, 18 Mar 2024 09:16:41 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 n2-20020a5d4002000000b0033e93e00f68sm10122463wrp.61.2024.03.18.09.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:16:41 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:16:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL 19/24] smbios: in case of entry point is 'auto' try to build
 v2 tables 1st
Message-ID: <4840c8a2b4666cf1b320a387c3f8b609258e7654.1710778506.git.mst@redhat.com>
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

QEMU for some time now uses SMBIOS 3.0 for PC/Q35 machines by
default, however Windows has a bug in locating SMBIOS 3.0
entrypoint and fails to find tables when booted on SeaBIOS
(on UEFI SMBIOS 3.0 tables work fine since firmware hands
over tables in another way)

Missing SMBIOS tables may lead to some issues for guest
though (worst are: possible reactiveation, inability to
get virtio drivers from 'Windows Update')

It's unclear  at this point if MS will fix the issue on their
side. So instead of it (or rather in addition) this patch
will try to workaround the issue.

aka, use smbios-entry-point-type=auto to make QEMU try
generating conservative SMBIOS 2.0 tables and if that
fails (due to limits/requested configuration) fallback
to SMBIOS 3.0 tables.

With this in place majority of users will use SMBIOS 2.0
tables which work fine with (Windows + legacy BIOS).
The configurations that is not to possible to describe
with SMBIOS 2.0 will switch automatically to SMBIOS 3.0
(which will trigger Windows bug but there is nothing
QEMU can do here, so go and aks Microsoft to real fix).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240314152302.2324164-17-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 52 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 48713aa505..b0467347c5 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1082,7 +1082,7 @@ static void smbios_entry_point_setup(SmbiosEntryPointType ep_type)
     }
 }
 
-void smbios_get_tables(MachineState *ms,
+static bool smbios_get_tables_ep(MachineState *ms,
                        SmbiosEntryPointType ep_type,
                        const struct smbios_phys_mem_area *mem_array,
                        const unsigned int mem_array_size,
@@ -1091,6 +1091,7 @@ void smbios_get_tables(MachineState *ms,
                        Error **errp)
 {
     unsigned i, dimm_cnt, offset;
+    ERRP_GUARD();
 
     assert(ep_type == SMBIOS_ENTRY_POINT_TYPE_32 ||
            ep_type == SMBIOS_ENTRY_POINT_TYPE_64);
@@ -1177,11 +1178,56 @@ void smbios_get_tables(MachineState *ms,
         abort();
     }
 
-    return;
+    return true;
 err_exit:
     g_free(smbios_tables);
     smbios_tables = NULL;
-    return;
+    return false;
+}
+
+void smbios_get_tables(MachineState *ms,
+                       SmbiosEntryPointType ep_type,
+                       const struct smbios_phys_mem_area *mem_array,
+                       const unsigned int mem_array_size,
+                       uint8_t **tables, size_t *tables_len,
+                       uint8_t **anchor, size_t *anchor_len,
+                       Error **errp)
+{
+    Error *local_err = NULL;
+    bool is_valid;
+    ERRP_GUARD();
+
+    switch (ep_type) {
+    case SMBIOS_ENTRY_POINT_TYPE_AUTO:
+    case SMBIOS_ENTRY_POINT_TYPE_32:
+        is_valid = smbios_get_tables_ep(ms, SMBIOS_ENTRY_POINT_TYPE_32,
+                                        mem_array, mem_array_size,
+                                        tables, tables_len,
+                                        anchor, anchor_len,
+                                        &local_err);
+        if (is_valid || ep_type != SMBIOS_ENTRY_POINT_TYPE_AUTO) {
+            break;
+        }
+        /*
+         * fall through in case AUTO endpoint is selected and
+         * SMBIOS 2.x tables can't be generated, to try if SMBIOS 3.x
+         * tables would work
+         */
+    case SMBIOS_ENTRY_POINT_TYPE_64:
+        error_free(local_err);
+        local_err = NULL;
+        is_valid = smbios_get_tables_ep(ms, SMBIOS_ENTRY_POINT_TYPE_64,
+                                        mem_array, mem_array_size,
+                                        tables, tables_len,
+                                        anchor, anchor_len,
+                                        &local_err);
+        break;
+    default:
+        abort();
+    }
+    if (!is_valid) {
+        error_propagate(errp, local_err);
+    }
 }
 
 static void save_opt(const char **dest, QemuOpts *opts, const char *name)
-- 
MST


