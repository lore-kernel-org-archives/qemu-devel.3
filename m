Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472ECC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPww-0002UY-Vc; Wed, 27 Mar 2024 05:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPwu-0002S1-Vx
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:52:01 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPws-0006k9-UF
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:52:00 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a466e53f8c0so855144966b.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533117; x=1712137917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9jqAsBPS2eVGtQ2Oyj66VMF1DnqaRA4xDyhtZgk1fo=;
 b=zI2UhLxgzCJ9YeSnbr9CixSjGwTOp2i29IiExWxgvEY2uGvHA2RW2JRXeksgHB47F8
 71EL8CA1evLbSktSoMf/K2jTViGVdbbymjgVoyHMAus/G/hT0TYhu3KSrKTmWJ8XoWk4
 2sO9tuzIs1bvMgCr/ntHBzt/AUGWJ8AMoj0thnMexQw/GcrFdazHOy/YTBqz4B0EdoiR
 QI7n7Fi2FwNzRmZsysiPZ8bdX4uos+SmCr9+JAvJBUYwVbWxJ4AT4KLC7Cm2W72OOZjd
 qhjCnR0kilzq9BIc03MoI1eioyYFFXe8wf6k6Isye4nzmlKLbxFc7jMMR8iN5rxef+GW
 gLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533117; x=1712137917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9jqAsBPS2eVGtQ2Oyj66VMF1DnqaRA4xDyhtZgk1fo=;
 b=JpkjrFkVjzZohRkGNMFBgdddkN1vvDdar+mDVSNqHUUMh+dE8Z4DNYsJ0tMvQILlTX
 zcDswXFFMhhtOl0IERmYS1dGglbEnv2VUuup3cBzVuSWpMLvZp1zpisyBsut+a8BcGlu
 VxBq94tkXvv0sw4aF4/wp82YyMJIQEU9DmU3Jn60/c9RZ6gfzae+pLwbMUpx+qDXbIqG
 LQxLDyFGwA/EeHUgvK9Ogvgg+4HbHmETNmVCOFK9RtWh1Pa/IJ+9M+Y5m7EC8NVCWU60
 WnocxCJ4e4lU7CTZSbL71KnRRmTUhIdcXENxLsM8VsnD0MQ02aBVnMwUG0jfdui7jcMd
 12pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIPN8VIcvOUvOZvB2lyXWB3U1ldiI3ELdQqkXNT5FY6EC0OqwEAgC1eQxyJXqQVKL3ry+895Orz4Vte9yg0o/DdMZkOrI=
X-Gm-Message-State: AOJu0YzdHkz/GGK8q8/MTQ9DEW4wc/YFaRruWdZ90npgeOPyrb5sOMF2
 SbohED466VsUMbUVxPvSNzQKmbzNOF0Nkz2lSNIjDLfB3OCOLedlJgtcrHEZA5k=
X-Google-Smtp-Source: AGHT+IF8zpfC/haXwmyH4jwHIuokYW+no7M7X2nYUpnPSg3hI59l1b7QNpSddC7ZUtIUIgE4Kf3jgQ==
X-Received: by 2002:a17:906:2a16:b0:a46:5f04:134 with SMTP id
 j22-20020a1709062a1600b00a465f040134mr571425eje.70.1711533117342; 
 Wed, 27 Mar 2024 02:51:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a1709060f8700b00a46faaf7427sm5204278ejj.121.2024.03.27.02.51.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:51:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-9.1 v2 05/21] hw/acpi/ich9: Remove
 'memory-hotplug-support' property
Date: Wed, 27 Mar 2024 10:51:07 +0100
Message-ID: <20240327095124.73639-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327095124.73639-1-philmd@linaro.org>
References: <20240327095124.73639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

No external code sets the 'memory-hotplug-support'
property, remove it.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/acpi/ich9.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 573d032e8e..9b605af21a 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -351,21 +351,6 @@ static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
-static bool ich9_pm_get_memory_hotplug_support(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    return s->pm.acpi_memory_hotplug.is_enabled;
-}
-
-static void ich9_pm_set_memory_hotplug_support(Object *obj, bool value,
-                                               Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    s->pm.acpi_memory_hotplug.is_enabled = value;
-}
-
 static bool ich9_pm_get_cpu_hotplug_legacy(Object *obj, Error **errp)
 {
     ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
@@ -445,9 +430,6 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                         NULL, NULL, pm);
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
                                    &gpe0_len, OBJ_PROP_FLAG_READ);
-    object_property_add_bool(obj, "memory-hotplug-support",
-                             ich9_pm_get_memory_hotplug_support,
-                             ich9_pm_set_memory_hotplug_support);
     object_property_add_bool(obj, "cpu-hotplug-legacy",
                              ich9_pm_get_cpu_hotplug_legacy,
                              ich9_pm_set_cpu_hotplug_legacy);
-- 
2.41.0


