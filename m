Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8B1C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 18:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgqyG-0002ye-48; Sun, 03 Mar 2024 13:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgqy7-0002xr-G2
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 13:53:55 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgqy5-0003y8-RE
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 13:53:51 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-412e14dac68so2667785e9.3
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 10:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709492026; x=1710096826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UyJ9mxtdoxL+DYRUJvwUw3QhltHpzKE9QiB4/SHTQxQ=;
 b=eECQsyGFzyd8rdCTMZcQIKkJYe6cLuyPZ1xvqFITBBDS5WDsu3Fsdzeu3EhQO6/wt3
 LtQmT5SQpUsIyVv/p+7Ecp2wjSIOrI1S12sRUCmy5C3JssY6Dnq6/XmxsgjEu8Ie4E98
 y7JjdLuGdKJILpmHep1Fwqgh/042Wom02ITI0qp1oPwq0E3/VdOSaBJMqHigE5/yU/aT
 bz2UIo6dMTudc4q2Ob6h4I1HDZ6oLLr0gVHzxUPolbBRLSLoDTUvpJAZwyzG3Y9djf+d
 BUyrtPZeQxGglRk03emcfRJA+bjqVDzoWgf5fQz8CcmIc2H5+5oyD4j13SSk5PECzDgY
 nn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709492026; x=1710096826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UyJ9mxtdoxL+DYRUJvwUw3QhltHpzKE9QiB4/SHTQxQ=;
 b=rCwhOZPSkNAWm+uExs4TGNtGyN9+pmNO39qRFV1qv8nuOte3lUAG7JgQ5YB/e0xc1F
 oNlwKTbo94YIVPQYIUWdpmjls7ZwlF98GFEx6NyUGYE+b6j20GF+kswj+Gr/b63VObLi
 3yxSfYEwRQfLfTttPf/BNC5ANk2L6zhj+DbiEGN1r1I7JjPLeYjmW0qxHVVE/rz6eh0O
 eRfGpWL/dU15Y+5VSh2l2/8a3fPTsun5W5earNc2Jojcfi3l2hV+fzCBLx2BUFdK7Vgz
 MjubGIZM0slvVZly4W+uR6jaKNgMidpYKg/f73yXMcqdvIGJsJzq33s+1ukpgOZk4Cke
 Ks+Q==
X-Gm-Message-State: AOJu0YzzBsuuQLcahcYCz8NT4JzIR2EKsv1M3rB3kFXWPFhOT03uimMZ
 sXj7k85GZbmPsPv8Q+8y/vdAuzvedJWT5G5nUupwU9pkFjn8TZefqvs62O63
X-Google-Smtp-Source: AGHT+IH1S0OrL4jn7OQ4PakVvGTdXR6ROwHso0L8pFKW80UHTlRmgbI/AcEsg0eGOC8Ib2mm+rmu9w==
X-Received: by 2002:a05:600c:4f0e:b0:412:77a4:d7c with SMTP id
 l14-20020a05600c4f0e00b0041277a40d7cmr6003705wmq.9.1709492026504; 
 Sun, 03 Mar 2024 10:53:46 -0800 (PST)
Received: from archlinux.. (dynamic-092-224-118-014.92.224.pool.telefonica.de.
 [92.224.118.14]) by smtp.gmail.com with ESMTPSA id
 o17-20020a05600c4fd100b00412d68dbf75sm5259460wmq.35.2024.03.03.10.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 10:53:45 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 2/4] hw/i386/pc: Avoid one use of the current_machine global
Date: Sun,  3 Mar 2024 19:53:30 +0100
Message-ID: <20240303185332.1408-3-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303185332.1408-1-shentey@gmail.com>
References: <20240303185332.1408-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x329.google.com
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

The RTC can be accessed through the X86 machine instance, so rather than passing
the RTC it's possible to pass the machine state instead. This avoids
pc_boot_set() from having to access the current_machine global.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 63b7583af0..06ef278b34 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -425,9 +425,10 @@ static void set_boot_dev(PCMachineState *pcms, MC146818RtcState *s,
 
 static void pc_boot_set(void *opaque, const char *boot_device, Error **errp)
 {
-    PCMachineState *pcms = PC_MACHINE(current_machine);
+    PCMachineState *pcms = opaque;
+    X86MachineState *x86ms = X86_MACHINE(pcms);
 
-    set_boot_dev(pcms, opaque, boot_device, errp);
+    set_boot_dev(pcms, MC146818_RTC(x86ms->rtc), boot_device, errp);
 }
 
 static void pc_cmos_init_floppy(MC146818RtcState *rtc_state, ISADevice *floppy)
@@ -1252,7 +1253,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     }
 #endif
 
-    qemu_register_boot_set(pc_boot_set, rtc_state);
+    qemu_register_boot_set(pc_boot_set, pcms);
 
     if (!xen_enabled() &&
         (x86ms->pit == ON_OFF_AUTO_AUTO || x86ms->pit == ON_OFF_AUTO_ON)) {
-- 
2.44.0


