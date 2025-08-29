Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E5BCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNHw-0001Kc-Ax; Sat, 30 Aug 2025 11:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiA-00014A-Bp
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryi8-0008B2-Lv
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8z64wgKIX5iIIJhY5HOTWJ5MxfKprYoGM2UJJP1XlE=;
 b=hlm3nnTgyPYuWbyx7eGnkqM7zWCYT4T2LgbLJqp9XKyLg7tQ3B5DpoZ+VpSp5k+fJYSLbk
 pSF4cybnHGidf0VvGdlV3XslmQbINHT8YCGY8dIC9x+N5+keXwhYzNJMl+98BQZjEX8whT
 mRQAHMbmRgAP8Jc+4S0sbfZIP6W+luw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-UQqAP4n_Op62LT8h81YH5g-1; Fri, 29 Aug 2025 09:00:05 -0400
X-MC-Unique: UQqAP4n_Op62LT8h81YH5g-1
X-Mimecast-MFC-AGG-ID: UQqAP4n_Op62LT8h81YH5g_1756472405
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3d1114879a4so233212f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472404; x=1757077204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u8z64wgKIX5iIIJhY5HOTWJ5MxfKprYoGM2UJJP1XlE=;
 b=RzZRklVflv3GZV+R6M6RRA52ANn4+wJTCtTtOXO3dYlafloWFa8WCR3dOGl/plUk4D
 K1yzZKIRO010FINFUAm46cR5+/WjFQOOoe2v6tD1GrNv1AO8qCGwK8iSFsIhLZVyJOFa
 7ueVvCoR/XaxVOyVb7OHcIXwuWHqSiltTlwRbytS0HqSxD2l9TYpDbaPUA22Hkba0ZaO
 L3tlutKVofiGq/fqqJ3fF140onFELskGJeXIuRR1G8S/Io3cUTIQ4o092D780F4Z63z6
 O/i2KFY0pUoxxsE5qm2ZTVo7Ev7KMeD008I/X80QYtR+OZnwY2glHuq+vBjWMt3xGB3M
 iviQ==
X-Gm-Message-State: AOJu0YzVJ8bAoTW4My5b/s5ioP3uqbRVkiPnLMzdckFuFWxJzYDIJkhy
 vgq4/r9LHin8V8PEuzbwlVODjFnX1kilpxB60tEQVDdPF/lB36xwM5qzPUGhU5JIWvKzLsUFlxh
 dAGPkzFlpDrkDn5hcUnyl9l9H2mWYjiYG9fYHkbxVitv3xcxB7rXL28mWNDIgzqxdc64zbHXR+A
 zQ1D5Egkbqsl4FdYYvD2ZEnN/W35SRPgADNupVbeik
X-Gm-Gg: ASbGncs9zaky3Tsf6pkSgvWfzVEtKf1aiuCTbWX04NysxScnK+ejImZYgeKHU4FtjhO
 acGnTQInYuvxHWIapRinyZVoP2Ye4KBOLz78CnCaA6KctxW9cFWV0cJHW8aaqkRaw2QcXPyA1QZ
 6rb5KRKfxMZA8PH894RY990r04rf3CE/FXbGDhA3w8Dez7SGgAPy3b7IcrLLiz88L4Mbe2anEsB
 FszGzKcJkEwY+x0C9P2zsQM/zanxshFm8lU4W+cGLBlz9kwOIOxS28utbC94F+ey4MkTv1BHZ/Z
 yrhJO3ugQ8b5TiLoZeohfUqlS0KfTFrGcu8cQg1SOoktGAariNhHNJOPFLU5xDIcyh/WrmnvkEr
 9Sbz0ql+k0HfaKpS0WdgTzJCvHRXOy0rCrPexPZ7m3bU=
X-Received: by 2002:a05:6000:40dc:b0:3c9:469d:c087 with SMTP id
 ffacd0b85a97d-3c9469dc445mr15812271f8f.25.1756472403781; 
 Fri, 29 Aug 2025 06:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcBF57RSIt+clYMAReNX5cm1VeM86TgVVqqJXUuHT1aHDuaqYYqixAjMmUEzghRvC0Dx9pXA==
X-Received: by 2002:a05:6000:40dc:b0:3c9:469d:c087 with SMTP id
 ffacd0b85a97d-3c9469dc445mr15812243f8f.25.1756472403287; 
 Fri, 29 Aug 2025 06:00:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fc11dsm3261490f8f.4.2025.08.29.06.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 10/28] hw/i386/pc_piix.c: remove nvdimm initialisation from
 pc_init_isa()
Date: Fri, 29 Aug 2025 14:59:17 +0200
Message-ID: <20250829125935.1526984-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

NVDIMMs cannot be used by PCs from a pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250828111057.468712-11-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9a2eee8ab0a..daf63a326b6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -614,12 +614,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 #endif
-
-    if (machine->nvdimms_state->is_enabled) {
-        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-                               x86_nvdimm_acpi_dsmio,
-                               x86ms->fw_cfg, OBJECT(pcms));
-    }
 }
 #endif
 
-- 
2.51.0


