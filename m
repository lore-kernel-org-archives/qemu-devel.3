Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB60CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps7a-00051j-MG; Thu, 28 Mar 2024 11:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7R-0004f8-Fd
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:46 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7P-0002XK-UH
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:45 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a46ea03c2a5so216843966b.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641402; x=1712246202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muQ9YYs1garpvhloVWRUiLPzA6iwq65Rr1SdS4smlFw=;
 b=xIviQFS5WkfB3SmaSqmdUiAYqROgybIZKD58pgI+nEQ6LVuoxICa+gUvJ/0tTQwbzF
 o+uLtFAavL7ut4sMimpHF6nxEOCUOeRg6tCtKL3dQnxXVrFop37PE66b9GSDjArbGVpx
 wuwy6fTwtFcrIWsjIHtCew9cfKdqHUayeiBMlVjFq9nClJpotpgJN133Yet1y+CX7S4V
 Fe18wz1fhSljbdc1b0Pae2YXWJ1/xZBXZAmBqZHAPr/hgrw0YyYr/qDdL2dka3PjVB19
 ueZqFa/A4vS4rpcyqBVsrt0ftb9YlaMc3Bpy9/G51V3NPxYAU/6vOFqKjm5/31/hdo75
 Cf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641402; x=1712246202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=muQ9YYs1garpvhloVWRUiLPzA6iwq65Rr1SdS4smlFw=;
 b=H1wHNYV0VeiOjpMCZUH19sS5E7C5op114D2gNMaL9XBCDneh2zGNS+gLEu9Q8GjAYh
 wFDCb0wa8UHUFm6IW4VYtO5bPeLDgMax9neYLUmHbftsCjMOpJwSSJ2pY+x3OBBFIcrY
 N/PvQJtNO34Ll8gfdJ39F3BU8DFCclXuPJWGiseHVgC2VALTB6+v124bOTvFTrCDIJDc
 d3k59A0RoRgXB4ZnZuVujNOP2R4aNyGFr7Zn6+nD3e87mmR9sUYEQ0PAwpxI0aHojtQo
 sAfpOtrRyHo2trdLFpdhQS005Ejr2QMw0L16SmkzmTxdj+2AP3GUq5W7yfNKDcD2uiJh
 bABA==
X-Gm-Message-State: AOJu0Yw92N27Qljkj0evo+0qYu+sh/liQkX3exoA9UlnfXOxKC3SRvO4
 lpiT5QGG8n8XBguTv4Ia3HkJbC5YHZIwfb/YG+ZJ2q35VLigykaEQBjdAUlzenJQbH2OFHzD3iY
 7
X-Google-Smtp-Source: AGHT+IFXbYhPHZn5NXBz7Ikr8yC8QHRf+1TONIhT4Hw3waF5CP4z/i4EhLM/5gQv8lw+8vgiP63smA==
X-Received: by 2002:a17:906:714a:b0:a4e:f91:4694 with SMTP id
 z10-20020a170906714a00b00a4e0f914694mr2568225ejj.27.1711641401851; 
 Thu, 28 Mar 2024 08:56:41 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 dr3-20020a170907720300b00a4a38d10801sm896023ejc.35.2024.03.28.08.56.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:56:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 19/29] hw/i386/pc: Pass PcPciMachineState argument
 to CXL helpers
Date: Thu, 28 Mar 2024 16:54:27 +0100
Message-ID: <20240328155439.58719-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

Since CXL helpers expect a PCI-based machine, we
can directly pass them a PcPciMachineState argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e36d76656b..d8e91d18b8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -705,14 +705,14 @@ static void pc_get_device_memory_range(PCMachineState *pcms,
     *device_mem_size = size;
 }
 
-static uint64_t pc_get_cxl_range_start(PCMachineState *pcms)
+static uint64_t pc_get_cxl_range_start(PcPciMachineState *ppms)
 {
+    PCMachineState *pcms = PC_MACHINE(ppms);
     MachineState *ms = MACHINE(pcms);
     hwaddr cxl_base;
     ram_addr_t size;
 
-    if (has_reserved_memory(pcms) &&
-        (ms->ram_size < ms->maxram_size)) {
+    if ((ms->ram_size < ms->maxram_size)) {
         pc_get_device_memory_range(pcms, &cxl_base, &size);
         cxl_base += size;
     } else {
@@ -722,10 +722,9 @@ static uint64_t pc_get_cxl_range_start(PCMachineState *pcms)
     return cxl_base;
 }
 
-static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
+static uint64_t pc_get_cxl_range_end(PcPciMachineState *ppms)
 {
-    PcPciMachineState *ppms = PC_PCI_MACHINE(pcms);
-    uint64_t start = pc_get_cxl_range_start(pcms) + MiB;
+    uint64_t start = pc_get_cxl_range_start(ppms) + MiB;
 
     if (ppms->cxl_devices_state.fixed_windows) {
         GList *it;
@@ -937,7 +936,7 @@ void pc_memory_init(PCMachineState *pcms,
         MemoryRegion *mr = &ppms->cxl_devices_state.host_mr;
         hwaddr cxl_size = MiB;
 
-        cxl_base = pc_get_cxl_range_start(pcms);
+        cxl_base = pc_get_cxl_range_start(ppms);
         memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
         memory_region_add_subregion(system_memory, cxl_base, mr);
         cxl_resv_end = cxl_base + cxl_size;
@@ -1027,7 +1026,7 @@ uint64_t pc_pci_hole64_start(void)
     ram_addr_t size = 0;
 
     if (ppms->cxl_devices_state.is_enabled) {
-        hole64_start = pc_get_cxl_range_end(pcms);
+        hole64_start = pc_get_cxl_range_end(ppms);
     } else if (has_reserved_memory(pcms) && (ms->ram_size < ms->maxram_size)) {
         pc_get_device_memory_range(pcms, &hole64_start, &size);
         if (!pcmc->broken_reserved_end) {
-- 
2.41.0


