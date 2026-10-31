Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4D4606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aldaomoy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNC8i-0002SY-6X; Sat, 31 Oct 2026 12:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC8h-0002S0-BO
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:41:07 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC8e-0007kS-4t
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:41:07 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-1438d9363fbso1304674c88.0
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793464863; x=1794069663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=13JWMDuL1/kg2WARtJ9HlJ9hNXkjKRwhhY6NmWBu4Ck=;
 b=AldaomoyfocljUdKLWGXlzPV1dy/1kyaw48gpFagT1K/VuXB5bS8o0Q2Iwy7joyr8/
 85Pv7zKNw+YuRMYnfrV5HPPsVqzoLXxqQuxZnDhEVfiHZ/eUneACHe9KW6DinCIy4c3q
 Pj0e4jMEwymlAJ2p5LFsBxgbMYBp5flPqPBvbLXFfGQU3o2VQUQS4ZhIRbnaGeb0rMbV
 5f0S08sk9lsbzYquRcuNhKKRPV0G3o3ynQlPLVnGC0c5VKTMPGuKsmR4SuDCfKAwJkcL
 /8t58c2qwzspyLLdyAQmM+Orx18/CHiamvvfDAPWXqgOPtWqQAifeNrO8xIWIdZhB80G
 X9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793464863; x=1794069663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=13JWMDuL1/kg2WARtJ9HlJ9hNXkjKRwhhY6NmWBu4Ck=;
 b=ykbxapN3xZelETZUtl2wIl9J3Uh4luCc50lvDCiXnzir9TDOX+gRWqhJo2tjLyNk93
 FAlVfhFhVLhreKkZb9HeQ5UZ8LyZ5AcvQcFz+LQZMHrZScfbnY7svBUnrpdfZQCEhn0+
 i8zwsgto0VSMiaFSOlEmctdCIU1eCPHEQa1ZaXBX4/OJXHTOu5h1QEhCaGw0cuJ1BXPI
 V7xxNrBudeS2wZLwBA9lMVsFNtCN2Y3DW9RZS1Kv87G21f36nXkTv6T1pqkJE152X4la
 wrK2DtX4CgrTf/GrvXjplDsgzaILn/A2IP+95DW4svgu7RfkM3Gyg0zcdZBQT0C1hkGU
 GQFg==
X-Gm-Message-State: AFq9FYIRLegMc3/BpFznWI21dgdVCUwnHC2MBdgQs49Yr2iXFyFi8s1D
 oChBRrbfe/gxFVPwQQLEt3rDt9Trus/4al5l+4m66jwWER7xVpAu5AOrN+cBES7Z
X-Gm-Gg: AYBFou3IWNeudTlUQuN2+pKU1yDdcthY/95iR/Ss5hoJk9kTpnR1oPjrqPf02mRcDgp
 +oM79LoBCwjP91zrD+6GL3ZvNCt/fMH1QKlyz+NOLMru/k67lurVOz1Sxid+BZ1uERLdFs27phT
 zOsZooJZMoP9EIrqOkt7IzHrj+vu513bLxlfKJ80jJI1OgP7jd7Xbwr1IjfaU0F8paasFx122bA
 EkvKrLWiQ4juwxsYMLjjAPlGMK5lw4KEtr2A4ZuVPoN8Y1ZrMyEqHsohLrv4BzRqFxZxPh8S9KJ
 /Ll8E2NY2rRl6ah7VtIUJTolhXvcwkf44uKpojBrx2VgZzZkaP5fVrJssuwda4JApvGOArOJa3F
 eYJmEGyMgCaFrJiech1zk68JBBZLRzM11KsqztqKqy66VHIyofUOmRSpFuMnCoLd0isenEuOHRK
 luaqvUPjON2v7JAi/f+YcnTQdSiypV5GsS/impQVBiN8MoqzryQ3rEv8Utzme5un1Jq+YX3mj22
 Nac8r46Jaef2wCIsH8jxUuMhnU2gpWmgeeW+LLJRK9sbTu7H5oalrGwhWqfNoN5KeWIU8MxooCw
 v+Q22FboTZES76enh5/kLngM/zXdC6kPGxWY9TdQJMX0BNLm
X-Received: by 2002:a05:701a:ca8a:b0:1af:194e:8264 with SMTP id
 a92af1059eb24-1af194e82e0mr2685741c88.22.1793464862627; 
 Sat, 31 Oct 2026 09:41:02 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm19574572c88.11.2026.10.31.09.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:41:01 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 07/12] hw/scsi/scsi-disk: register s390x scsi-hd and
 scsi-cd variants
Date: Sun,  1 Nov 2026 00:40:02 +0800
Message-ID: <20261031164009.2048-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261031164009.2048-1-luoyonggang@gmail.com>
References: <20261031164009.2048-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

scsi-hd and scsi-cd added the s390x loadparm property from class_init
when target_s390x() was true. Register a second type for each name
that always adds loadparm, and select the two with target_s390x() and
target_not_s390x().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/scsi/scsi-disk.c | 48 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 6341089ddf2..bb5377fb7fa 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3221,14 +3221,11 @@ static void scsi_property_add_specifics(DeviceClass *dc)
 {
     ObjectClass *oc = OBJECT_CLASS(dc);
 
-    /* The loadparm property is only supported on s390x */
-    if (target_s390x()) {
-        object_class_property_add_str(oc, "loadparm",
-                                      scsi_property_get_loadparm,
-                                      scsi_property_set_loadparm);
-        object_class_property_set_description(oc, "loadparm",
-                                              "load parameter (s390x only)");
-    }
+    object_class_property_add_str(oc, "loadparm",
+                                  scsi_property_get_loadparm,
+                                  scsi_property_set_loadparm);
+    object_class_property_set_description(oc, "loadparm",
+                                          "load parameter (s390x only)");
 }
 
 static void scsi_disk_base_class_initfn(ObjectClass *klass, const void *data)
@@ -3362,14 +3359,31 @@ static void scsi_hd_class_initfn(ObjectClass *klass, const void *data)
     dc->desc = "virtual SCSI disk";
     device_class_set_props(dc, scsi_hd_properties);
     dc->vmsd  = &vmstate_scsi_disk_state;
+}
+
+static void scsi_hd_s390x_class_initfn(ObjectClass *klass, const void *data)
+{
+    scsi_hd_class_initfn(klass, data);
+    scsi_property_add_specifics(DEVICE_CLASS(klass));
+}
 
-    scsi_property_add_specifics(dc);
+static bool target_not_s390x(void)
+{
+    return !target_s390x();
 }
 
 static const TypeInfo scsi_hd_info = {
     .name          = "scsi-hd",
     .parent        = TYPE_SCSI_DISK_BASE,
     .class_init    = scsi_hd_class_initfn,
+    .is_available  = target_not_s390x,
+};
+
+static const TypeInfo scsi_hd_s390x_info = {
+    .name          = "scsi-hd",
+    .parent        = TYPE_SCSI_DISK_BASE,
+    .class_init    = scsi_hd_s390x_class_initfn,
+    .is_available  = target_s390x,
 };
 
 static const Property scsi_cd_properties[] = {
@@ -3405,14 +3419,26 @@ static void scsi_cd_class_initfn(ObjectClass *klass, const void *data)
     dc->desc = "virtual SCSI CD-ROM";
     device_class_set_props(dc, scsi_cd_properties);
     dc->vmsd  = &vmstate_scsi_disk_state;
+}
 
-    scsi_property_add_specifics(dc);
+static void scsi_cd_s390x_class_initfn(ObjectClass *klass, const void *data)
+{
+    scsi_cd_class_initfn(klass, data);
+    scsi_property_add_specifics(DEVICE_CLASS(klass));
 }
 
 static const TypeInfo scsi_cd_info = {
     .name          = "scsi-cd",
     .parent        = TYPE_SCSI_DISK_BASE,
     .class_init    = scsi_cd_class_initfn,
+    .is_available  = target_not_s390x,
+};
+
+static const TypeInfo scsi_cd_s390x_info = {
+    .name          = "scsi-cd",
+    .parent        = TYPE_SCSI_DISK_BASE,
+    .class_init    = scsi_cd_s390x_class_initfn,
+    .is_available  = target_s390x,
 };
 
 #ifdef __linux__
@@ -3462,7 +3488,9 @@ static void scsi_disk_register_types(void)
 {
     type_register_static(&scsi_disk_base_info);
     type_register_static(&scsi_hd_info);
+    type_register_static(&scsi_hd_s390x_info);
     type_register_static(&scsi_cd_info);
+    type_register_static(&scsi_cd_s390x_info);
 #ifdef __linux__
     type_register_static(&scsi_block_info);
 #endif
-- 
2.55.0.windows.3


