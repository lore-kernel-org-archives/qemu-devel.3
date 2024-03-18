Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCBAC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFff-0001eA-KB; Mon, 18 Mar 2024 12:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfe-0001T6-55
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFfc-0004pJ-Fi
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aVNpxLYgQa8mn+iVqcjp/uygNfGlH8NPfTbHmWsTQGc=;
 b=gPYeagXK8jLrAbckTWTc0jC8OevYnHkMEk+R5EEJ7odKCQUFDcxibhq0zkWIGbtRqGMPbl
 aAA3XuiTl2mH9MH9rEeT+wNa3hOpabls96kKHgq590iDuG0tD6x++NvaiLFsq+BPyXqlf0
 gQy7h7DXuPCrB+s9YlSzf7H4+Qo10u0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-ILjAHalFPSaYfavCG4-EXA-1; Mon, 18 Mar 2024 12:17:02 -0400
X-MC-Unique: ILjAHalFPSaYfavCG4-EXA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6e729f8e8c1so867972b3a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778621; x=1711383421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVNpxLYgQa8mn+iVqcjp/uygNfGlH8NPfTbHmWsTQGc=;
 b=OPx6VoCpLIQDS176Bf7cAk+oBJrk2sktXKILp8mo/r8vrVcV34cpJIoF0N3ybhETIE
 4hcuTwYRkWVk+vQcm5tG9VwLdk8e1cZEklGGfdAsMBw84dAX9XSpHO3wj+f1Ah2rC1Ec
 62azjMrzoXkUnm3yAVsQ6GaJaqClKEphVCDYrZaLUZvR07H/cuF78SGSLgVHdkpFbwNb
 nQqS8vhZ4qV1157A7Yw7mAhs9Fp4YN9L2/TAZTFLgrZgXwuA0C5kfoSmSGN+mZgP4XEp
 XOYARADHJYQ+8T5NPdc7BmfgHFN9hx5seHqrU0jXQR4w087NW45ci+oXj4LmgYqUGVxa
 42Tw==
X-Gm-Message-State: AOJu0YxTjh6ABYKBReiMpXXH0CNPJbKg/+H2s1b9QqtnwBm/0ChZeMtS
 JCFRSBwL2geG9wvDgVFZ8GAT21Xg5Tvim9Fr7BK6VyZJVpzt9ePjWCchGdq28/IXtpW0OPmXv/+
 5vTYQSVzATsQZ0Y7vWjiSxkBTANXxRF1FryVLrJ8lrjf8KL4hEVenODTqXo8XlU0peB32irZxpa
 3ikt6LcliwQd+CGZfCyIcTgJ5Hk4wZsQ==
X-Received: by 2002:a05:6a00:14c4:b0:6e7:8dd:ed8f with SMTP id
 w4-20020a056a0014c400b006e708dded8fmr189378pfu.21.1710778621019; 
 Mon, 18 Mar 2024 09:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHbRntzI+EnTG3Khg6393kA9M+61FgoRh4cM3R4DIz2NF67hTmoK46HS/4VkmRSzpVa/IAEQ==
X-Received: by 2002:a05:6a00:14c4:b0:6e7:8dd:ed8f with SMTP id
 w4-20020a056a0014c400b006e708dded8fmr189249pfu.21.1710778619093; 
 Mon, 18 Mar 2024 09:16:59 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 a5-20020aa78e85000000b006e6857da474sm8268979pfr.178.2024.03.18.09.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:16:58 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:16:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 22/24] pc/q35: set SMBIOS entry point type to 'auto' by default
Message-ID: <2c7c45b3d0ba097ac99bf4b9a13c6de1d7724032.1710778506.git.mst@redhat.com>
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

Use smbios-entry-point-type='auto' for newer machine types as a workaround
for Windows not detecting SMBIOS tables. Which makes QEMU pick SMBIOS tables
based on configuration (with 2.x preferred and fallback to 3.x if the former
isn't compatible with configuration)

Default compat setting of smbios-entry-point-type after series
for pc/q35 machines:
  * 9.0-newer: 'auto'
  * 8.1-8.2: '64'
  * 8.0-older: '32'

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2008
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240314152302.2324164-20-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c      | 2 +-
 hw/i386/pc_piix.c | 4 ++++
 hw/i386/pc_q35.c  | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 44eb073abd..e80f02bef4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1832,7 +1832,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
     mc->default_ram_id = "pc.ram";
-    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
         pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c9a6c0aa68..18ba076609 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -525,12 +525,16 @@ DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
 
 static void pc_i440fx_8_2_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_9_0_machine_options(m);
     m->alias = NULL;
     m->is_default = false;
 
     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
+    /* For pc-i44fx-8.2 and 8.1, use SMBIOS 3.X by default */
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 }
 
 DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8a427c4647..b5922b44af 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -376,11 +376,14 @@ DEFINE_Q35_MACHINE(v9_0, "pc-q35-9.0", NULL,
 
 static void pc_q35_8_2_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_9_0_machine_options(m);
     m->alias = NULL;
     m->max_cpus = 1024;
     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
+    /* For pc-q35-8.2 and 8.1, use SMBIOS 3.X by default */
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 }
 
 DEFINE_Q35_MACHINE(v8_2, "pc-q35-8.2", NULL,
-- 
MST


