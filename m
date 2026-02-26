Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71FAFD9E1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjSz-0003hU-JB; Thu, 26 Feb 2026 17:04:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjSF-0002gO-Bm
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:03:32 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjS9-0001vJ-Ka
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:03:28 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-437711e9195so991447f8f.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772143399; x=1772748199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hbzn5vHgMdXp7p0dhzileZ9MCb8UEIgfWGmULUXbwAo=;
 b=OlM4xEeNzJsLYitiemx8oGObTEMPV5FERDflDi74fHJON+QxZ5Z2pPjZZnygaGd1t/
 5BJGpaP+p5+2ho6Jr9lnFMHXYWYqGscuBDyFXJGhZAT8Z44GeXAeY8KYRUbExL3C7Vda
 5BYVKQO1k4z/Xzyx5fjPn7A+yluIMtUu/0niTT3xP9NsIWX9sukfljVSg3z6fv/mRog7
 L0rDIRnxBRnDFV6CuGellV7G6Fsdp//h6e5WfIsIk0K9/xlEnVx5lI6yFkahzu3OB08u
 MwgXcsPgpONlHI/KR5p9B72tP5g9qVZp41m59C5XFxONl+V3Huq+H+SBuWghjbf2utmz
 esLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772143399; x=1772748199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hbzn5vHgMdXp7p0dhzileZ9MCb8UEIgfWGmULUXbwAo=;
 b=qp14njOeqWm4zQ8TqWirxFx/zYXWtNsTgPQF1DVr5r0+OB4kFKfWFlXpWwKtQtr/2A
 4TnIU4iGYCbO1jwuwd7XMGoG8GSKbL6FiislJzlwrrv7BQ5gll3S6byUj22iNmSQqxHE
 WvfyiLOxYThWOHBQfM2spZpFlpPIK/K1NVdT3bxzHSlpYu4IRGaAwwBBPeb9zcpbN/4f
 6RSZDFj8quV6wkFQdSxIO+tfozKnKsJyzv1S65ENSbXT9/rMOV8x4G3MxRXw/4hLsrHZ
 F63kYHKb7MvA3fsjOXzZhIvyOTiBy3x50zN2X1fChET0TsCUvVCflMsbLMpWSIY7M8N8
 675w==
X-Gm-Message-State: AOJu0Yy9Ah/dIyZ3CSAcKiI0VlaxWDB8s8iaKpeEdC3l4ejhT17L7i6x
 8hRJtZtN2P/mFON+X/5/vy9etC+EQTfrjsdwSD+wr9PBK7H8a5k1d9eRAukW1Ayh+RSMrgOzLP9
 AeJN0Vp0=
X-Gm-Gg: ATEYQzy9HohlkKfsNsNsaEGhcbTrJvIZ/KqzdW0RY1balaWhYpUXlpYN4odQKiAjCbM
 0BtfG/e4kjOz+GuF6XAhMl8WmQnThLyeBG0Ke05ne/00SR9EMjdZsFXSRCqjoBSfh6a9+R6qh/X
 n79MCBab1DDDbi7sRRgFH5nYkswtqXUAWS7P3OOAXLW2aYXXz9xzEPS8PVAijK1kMDNJ1ESTX5t
 qC1elMI/+Y4aehj1EkCOcHmkQR+wIvv3XYkkkFYgYUnfJJxjv7fGZH9jvZoekpyegtdP0nxR0pw
 eCuEEjQcvdSBIc0WseNP8/ehxeCWYxtR5akNXDNzC2tBz3wGDCez8Eh+UfStTVP5QoBFDVBK3pZ
 a2E95SSBxir+aPc43uGKv4AXu6Q0IQy7YGdwy7zbZ5cvJfoss6GvAnA9YmcgWDLEbtWo2YnexZP
 l0Xpota/WrIDa/Ofxacs9RCEFtC7WTLUA1V9mQk6B9LPZ6cR1lM00rpYpCZ9IjdqR51uNHcBTBR
 hzSJ0PChkY=
X-Received: by 2002:a05:6000:2901:b0:439:5c09:4854 with SMTP id
 ffacd0b85a97d-4399de2fcd2mr690489f8f.41.1772143398974; 
 Thu, 26 Feb 2026 14:03:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c76b40esm1838119f8f.36.2026.02.26.14.03.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Feb 2026 14:03:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 7/7] system/memory: Have 'info mtree' display addresses nicely
Date: Thu, 26 Feb 2026 23:02:25 +0100
Message-ID: <20260226220226.20164-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226220226.20164-1-philmd@linaro.org>
References: <20260226220226.20164-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use the size of a MR / AS to decide how many address chars
need to be used.

For example, using 'qemu-system-x86_64 -M q35 -S -monitor stdio'
to run 'info mtree' displays before:

  address-space: I/O
    0000000000000000-000000000000ffff (prio 0, i/o): io
        0000000000000000-0000000000000003 (prio 0, i/o): acpi-evt
        0000000000000004-0000000000000005 (prio 0, i/o): acpi-cnt
        0000000000000008-000000000000000b (prio 0, i/o): acpi-tmr
        0000000000000020-000000000000002f (prio 0, i/o): acpi-gpe0
        0000000000000030-0000000000000037 (prio 0, i/o): acpi-smi
        0000000000000060-000000000000007f (prio 0, i/o): sm-tco
      0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
      0000000000000008-000000000000000f (prio 0, i/o): dma-cont
      0000000000000020-0000000000000021 (prio 0, i/o): pic
      0000000000000040-0000000000000043 (prio 0, i/o): pit
      ...
  memory-region: pc.ram
    0000000000000000-0000000007ffffff (prio 0, ram): pc.ram
  memory-region: pc.bios
    00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
  memory-region: pci
    0000000000000000-ffffffffffffffff (prio -1, i/o): pci
      00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
      00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
      00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
      00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
  ...

and after:

  address-space: I/O
    0000-ffff (prio 0, container): io
        0000-0003 (prio 0, i/o): acpi-evt
        0004-0005 (prio 0, i/o): acpi-cnt
        0008-000b (prio 0, i/o): acpi-tmr
        0020-002f (prio 0, i/o): acpi-gpe0
        0030-0037 (prio 0, i/o): acpi-smi
        0060-007f (prio 0, i/o): sm-tco
      0000-0007 (prio 0, i/o): dma-chan
      0008-000f (prio 0, i/o): dma-cont
      0020-0021 (prio 0, i/o): pic
      0040-0043 (prio 0, i/o): pit
      ...
  memory-region: pc.ram
    00000000-07ffffff (prio 0, ram): pc.ram
  memory-region: pc.bios
    fffc0000-ffffffff (prio 0, rom): pc.bios
  memory-region: pci
    0000000000000000-ffffffffffffffff (prio -1, i/o): pci
      00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
      00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
      00000000000e0000-00000000000fffff (prio 1, rom): alias isa-bios @pc.bios 0000000000020000-000000000003ffff
      00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
  ...

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 4d276307da5..abcbdaadcd7 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3321,7 +3321,26 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
 
 #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
                            int128_sub((size), int128_one())) : 0)
-#define MR_ADDR_WIDTH   16
+
+static unsigned mr_addr_fmt_width(const MemoryRegion *mr)
+{
+    const unsigned int bits = 127 - clz128(mr->size);
+    unsigned int width;
+
+    if (bits <= 8) {
+        width = 2;
+    } else if (bits <= 16) {
+        width = 4;
+    } else if (bits <= 32) {
+        width = 8;
+    } else if (bits <= 64) {
+        width = 16;
+    } else {
+        width = 20;
+    }
+    return width;
+}
+
 #define MTREE_INDENT "  "
 
 static void mtree_expand_owner(const char *label, Object *obj)
@@ -3513,7 +3532,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
         return;
     }
 
-    width = MR_ADDR_WIDTH;
+    width = mr_addr_fmt_width(view->root);
     while (n--) {
         const MemoryRegion *mr = range->mr;
 
@@ -3643,7 +3662,7 @@ static void mtree_print_as(gpointer key, gpointer value, gpointer user_data)
     MemoryRegion *mr = key;
     GSList *as_same_root_mr_list = value;
     struct AddressSpaceInfo *asi = user_data;
-    const unsigned int width = MR_ADDR_WIDTH;
+    const unsigned int width = mr_addr_fmt_width(mr);
 
     g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
     mtree_print_mr(mr, 1, width, -mr->addr, false,
@@ -3692,7 +3711,7 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
     /* print aliased regions */
     QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
         const MemoryRegion *mr = ml->mr;
-        const unsigned int width = MR_ADDR_WIDTH;
+        const unsigned int width = mr_addr_fmt_width(mr);
 
         qemu_printf("memory-region: %s\n", memory_region_name(mr));
         mtree_print_mr(mr, 1, width, 0, false, &ml_head, owner, disabled);
-- 
2.52.0


