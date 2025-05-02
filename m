Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C91C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 19:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvZz-0005Sp-3u; Fri, 02 May 2025 14:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZx-0005PZ-JQ
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:45 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvZv-0005UW-Um
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:45 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f624291db6so3623086a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212262; x=1746817062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJup76xViPoYlcZ6DgY2Il03anUYcrocSLmxC3mshks=;
 b=hnakHWOLYk2WSEY+1dgT1PIWStT/daysp4VTectjn05QDT0j3ShXb0gkt2TBvyQ9Q1
 ZFDfEtua/d+iOKC67pIXfJK5buU93OtqbV86fMkEC9V6bFaH/VgK8hYk+S3Tpc/U3Q2/
 kagaVo12QVyofsYrKyxoOVnDv7DPvKY4vVBx+zLRVppKTrIRpf6YaoR5FhU8iQXBx+sa
 zN98NcFqhOmW+b6nuX1S4OB1cP0KXbcSsdjOFjgccMBdPwSJKcHg9rTDvKYzsHKdgrht
 BOff37dGrhXGuom4f/ygevuKXqZrq0RqA25QJTglHdOuGDmLA7GEtKE2XQ476ocPzv6o
 Dfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212262; x=1746817062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJup76xViPoYlcZ6DgY2Il03anUYcrocSLmxC3mshks=;
 b=IIb5/97HgqSC6j9N16NYYPYbNXoYw0QXGrjbZ+INs9edfaItoN5s6HVyooAGVtVpg3
 qNT6lKLZHVxuzLWL/ZPgx6/hjC8GlXWT5hqRRAPcRucXrwmDdeuYblUPFP0qDpzYsGK2
 wqQu2gTzsLLt3jTf4+N872+C1/yWshbrMfqcb3GjJKnOqv45Qs/uZOfKJgofrXhPVoXA
 tEl5HncSz4bDGdyzrPj7YwuQDDcA8ihPIQM6pABfm0HUdg3F8FAiNe0CChVu6YBXLpNA
 6pPSJUpgFR5dRmuHOfRi/EEMx2UmmKxEF66R9PeYPHOGsIOFLTfKT7amDT+kDWF5730Q
 94mw==
X-Gm-Message-State: AOJu0YzPA5tIW3zV4rnCu75+fC24eOHdKt91YC0pujhfSNAJG+HITRdy
 x1pZ/SWET0LYCBOxkCjYMi75EwTgKtJeM7zMSIdec3IGOZxSF3Nl26xjw2KXpKtSDyNAEopRByq
 9
X-Gm-Gg: ASbGnctdreAbYKNE+SxEa9KUQm6JtSSGakTq16HWHliv2ZZOlrFne4M/cFh9Aj4kaxS
 10pmnW9U8x7xQP+Lneu0TpU6iNEJMXVPVBYgo7A+5OD1yl1rOPFQW88B1s3dgJ3ia9xbblB1+p6
 VvM2+ynDfLegvzc5ILSbQX0tsg4j0AuW2al7Qa2opTYAbMrX0QC5nW1BghnMp633sveZMWT2BbC
 7lSo+aD0agTB/orwAyTCXE7xQefGpc+1tC0HUtmU6nO1I5m2xKVeZHxD8dc9T3zs4oD8t/70t4v
 Z/PCRzp1rUx7cnpqLA05jeQzFNIZNoQeXnsONaM9eksmvZhqVsVSaKQDZd7vjcLdBzjYUrf0zep
 uMQjYVqGB1V2uJoOqKULMGn5MSLUb4Sg=
X-Google-Smtp-Source: AGHT+IH5/igCkChzWlVlBAT9HAF6ftX+1s8qZ3Pw5rfboLb09huidH1GiTzWBVXUg8A114AluNMqoA==
X-Received: by 2002:a05:6402:270b:b0:5f6:ace4:9fa6 with SMTP id
 4fb4d7f45d1cf-5fa7804467bmr3246373a12.16.1746212261963; 
 Fri, 02 May 2025 11:57:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa777561basm1617455a12.9.2025.05.02.11.57.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:57:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 08/19] hw/intc/apic: Remove
 APICCommonState::legacy_instance_id field
Date: Fri,  2 May 2025 20:56:40 +0200
Message-ID: <20250502185652.67370-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

The APICCommonState::legacy_instance_id boolean was only set
in the pc_compat_2_6[] array, via the 'legacy-instance-id=on'
property. We removed all machines using that array, lets remove
that property, simplifying apic_common_realize().

Because instance_id is initialized as initial_apic_id, we can
not register vmstate_apic_common directly via dc->vmsd.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/i386/apic_internal.h | 1 -
 hw/intc/apic_common.c           | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 429278da618..db6a9101530 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -188,7 +188,6 @@ struct APICCommonState {
     uint32_t vapic_control;
     DeviceState *vapic;
     hwaddr vapic_paddr; /* note: persistence via kvmvapic */
-    bool legacy_instance_id;
     uint32_t extended_log_dest;
 };
 
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 37a7a7019d3..1d259b97e63 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -294,9 +294,6 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
         info->enable_tpr_reporting(s, true);
     }
 
-    if (s->legacy_instance_id) {
-        instance_id = VMSTATE_INSTANCE_ID_ANY;
-    }
     vmstate_register_with_alias_id(NULL, instance_id, &vmstate_apic_common,
                                    s, -1, 0, NULL);
 
@@ -412,8 +409,6 @@ static const Property apic_properties_common[] = {
     DEFINE_PROP_UINT8("version", APICCommonState, version, 0x14),
     DEFINE_PROP_BIT("vapic", APICCommonState, vapic_control, VAPIC_ENABLE_BIT,
                     true),
-    DEFINE_PROP_BOOL("legacy-instance-id", APICCommonState, legacy_instance_id,
-                     false),
 };
 
 static void apic_common_get_id(Object *obj, Visitor *v, const char *name,
-- 
2.47.1


