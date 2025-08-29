Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E152CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNH1-00088y-B5; Sat, 30 Aug 2025 11:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiE-000182-0S
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiC-0008Bv-2L
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNgBnsocI3GR7Pw0K8L2VSK+KTUjcI66uLxSDZZqK5U=;
 b=cNtDXdxz2rTPm6NVYZvq2e1XDpFCBDy3mqJOSlUDWlQLQ/NiKkYDfurQ/LAE6cTQjt5pj5
 7O0YRixoDZi5GSH4BAqx0cD7mL1f5PHyCaYpnDStAx/LTbEjdAjKBifFZiNO7w04bIKuyu
 MPq2HKWHxA62jrj4KloGHMCJcIgzAeo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-ApmVIgcfOqCvjfr_9g990w-1; Fri, 29 Aug 2025 09:00:09 -0400
X-MC-Unique: ApmVIgcfOqCvjfr_9g990w-1
X-Mimecast-MFC-AGG-ID: ApmVIgcfOqCvjfr_9g990w_1756472408
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3cbe70a7861so1524579f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472407; x=1757077207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNgBnsocI3GR7Pw0K8L2VSK+KTUjcI66uLxSDZZqK5U=;
 b=RBWnLaSHvdnQ4JjmDDr33+NJszz/6fYLOKZTjduOa1jnV9SWQuDAiKvEOV5ld/4lPu
 jWeO1ZWB0Ztu3ZGhT9QYL6tycg2d97pa3aeCs5ZUMx5PLOX1FCUYpEUm22rg2jj7QAza
 pFwnMcHcd4H9OiIuuYjnO9Bp3lZYhJzgVw5DySxQeaNUFkj/7DtQgPgwO0HWHOIRZPXC
 4KjLWFsC+0GXb587zXHmONHoSc7RErbtr7pPTmBS14cc2bKNwmqTCv/Jp16zvvycSuxW
 S9xICrvvl5AMNGMcNTlV4Mei/maol5ef5IQLq60Ae9rxpTvYBiJnH+8VN5WXzxpkFe2l
 KspA==
X-Gm-Message-State: AOJu0Yzo8DSQDi1ayzE+JJzyzY+CnJC0BjxLEmQGumk/oNMVriV5VfWG
 Zp+3suh5kTfhR35OnEHscS75psWmIMCHWqmNArSxBBP3VHJz8iKrkRakH9wJ+Z8TCE4nWGENq4/
 ay4PCx2ZnYztnOu5f12Qd6dMEA0GNmlshS6i/ycEt3BPUUV60Gla6+I5w7lLtLdY9yjD8C2gESD
 IZLxnqY/2QsqedibhlEieBWiKYuanwvWOwoZYooCia
X-Gm-Gg: ASbGncv65rLvt5DzstxIUFtL9R9a4MKO1Mi5Rpsaea+jvr7d7EfpG+z0z/4L42bqL5A
 eo8Uf2neQmpj8wR22aOoDE5pheW+Q0NntzO2AVHhy+fXYcimpy+11coVBIZo+vxdOA30M+YAmGr
 HL2oB+A+u/iJS/loTcv4fB+dlFW36ye6zedsgTyh5/UdqWWwWnnQFkX/xAGQIgn5TeXvQqM8/3M
 5mSTQG8HacKLcYB4bGqaLASVElgpjS9rPpiw58bBHy+5fFxHrP6YaUuZ6TD8RN6hWX9G91C5j/1
 Gbl6vL6rOHTe6OWZtaSxhtYZAKzFep9KVxEjOJGA+u2Rq5+VwBuQ7V3jLz5Z2nvrzsONF/wt5U1
 Gm5jtjEASrHeNL6FZddvbQKHa8x2gZacgkCr78Kn13E4=
X-Received: by 2002:a05:6000:178b:b0:3c9:a722:e189 with SMTP id
 ffacd0b85a97d-3c9a722e3e6mr13429075f8f.62.1756472406536; 
 Fri, 29 Aug 2025 06:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeRExpKznG0FMDzIDcV7empYGImPiru2lwiaqSFyXZr9Lf9EUeIxynWnRcR61ivvoyNeEtMw==
X-Received: by 2002:a05:6000:178b:b0:3c9:a722:e189 with SMTP id
 ffacd0b85a97d-3c9a722e3e6mr13429039f8f.62.1756472405790; 
 Fri, 29 Aug 2025 06:00:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d12c90a01bsm876081f8f.31.2025.08.29.06.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/28] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
Date: Fri, 29 Aug 2025 14:59:18 +0200
Message-ID: <20250829125935.1526984-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

All isapc machines must have 32-bit CPUs and so the RAM split logic can be hardcoded
accordingly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250828111057.468712-12-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 58 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index daf63a326b6..0bc033943ca 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -445,7 +445,6 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    ram_addr_t lowmem;
     uint64_t hole64_size = 0;
 
     /*
@@ -480,65 +479,16 @@ static void pc_init_isa(MachineState *machine)
     }
 
     /*
-     * Calculate ram split, for memory below and above 4G.  It's a bit
-     * complicated for backward compatibility reasons ...
-     *
-     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
-     *    default value for max_ram_below_4g now.
-     *
-     *  - Then, to gigabyte align the memory, we move the split to 3G
-     *    (lowmem = 0xc0000000).  But only in case we have to split in
-     *    the first place, i.e. ram_size is larger than (traditional)
-     *    lowmem.  And for new machine types (gigabyte_align = true)
-     *    only, for live migration compatibility reasons.
-     *
-     *  - Next the max-ram-below-4g option was added, which allowed to
-     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
-     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
-     *    but prints a warning.
-     *
-     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
-     *    so legacy non-PAE guests can get as much memory as possible in
-     *    the 32bit address space below 4G.
-     *
-     *  - Note that Xen has its own ram setup code in xen_ram_init(),
-     *    called via xen_hvm_init_pc().
-     *
-     * Examples:
-     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
-     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
-     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
-     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
+     * There is no RAM split for the isapc machine
      */
     if (xen_enabled()) {
         xen_hvm_init_pc(pcms, &ram_memory);
     } else {
         ram_memory = machine->ram;
-        if (!pcms->max_ram_below_4g) {
-            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
-        }
-        lowmem = pcms->max_ram_below_4g;
-        if (machine->ram_size >= pcms->max_ram_below_4g) {
-            if (pcmc->gigabyte_align) {
-                if (lowmem > 0xc0000000) {
-                    lowmem = 0xc0000000;
-                }
-                if (lowmem & (1 * GiB - 1)) {
-                    warn_report("Large machine and max_ram_below_4g "
-                                "(%" PRIu64 ") not a multiple of 1G; "
-                                "possible bad performance.",
-                                pcms->max_ram_below_4g);
-                }
-            }
-        }
 
-        if (machine->ram_size >= lowmem) {
-            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
-            x86ms->below_4g_mem_size = lowmem;
-        } else {
-            x86ms->above_4g_mem_size = 0;
-            x86ms->below_4g_mem_size = machine->ram_size;
-        }
+        pcms->max_ram_below_4g = 3.5 * GiB;
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
     }
 
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
-- 
2.51.0


