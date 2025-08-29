Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456FFCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNGs-0007hn-7m; Sat, 30 Aug 2025 11:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryil-0001Hm-54
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryig-0008ST-TI
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UKNKSXD6eeCer6bTk1W9ODjios6XZIduD9lyZO55AV0=;
 b=DowZK/dWpH7iaFxXash/rbkJJwAVOp0S+bOxYJcBN/TJxFHsdmKqieDDlknmuX4Hk331s5
 jvInRSGhX/la1WeU9QxgxqyFtENSjtkXRJv/AKCEq4Y9rLlX2QHptbzL5GAN8yZY8fFJ3c
 XRdAnDgz2E4HatPow0PMx1nO4dSUA/8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-h75r5sPvMYGw_R1pzWgsJg-1; Fri, 29 Aug 2025 09:00:38 -0400
X-MC-Unique: h75r5sPvMYGw_R1pzWgsJg-1
X-Mimecast-MFC-AGG-ID: h75r5sPvMYGw_R1pzWgsJg_1756472437
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a1b0cc989so16480455e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472437; x=1757077237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UKNKSXD6eeCer6bTk1W9ODjios6XZIduD9lyZO55AV0=;
 b=jfGAg6a2hVHbvrxHbdJ6tXgAPXbSlJr8hkp+EbQsAzSnEmb1dXG0NzXUsEdy4KBoDu
 Di4X4C7vKQmX+aui/uPwtMVVppMlF/iFQ40RU5lC9HxhSMNvMbwEdeKwUIbyZUWCc+aN
 hnXsqVdj66Zmr+bk3k38lSAvG2iTWzJA/UZK6dtrM7HgSTNlKRjwVZQ1f/tKIq2L4l42
 a5hz2qXGin6L9RcbgeB7XFOOrQR3c/rWaDon6IBuuQ+gZbI0ZtuqFxZExUV0T0L7exEq
 Kbg2/KG6LuRJd+EA3VGYX7r00YbY2Sju+UAUgxecRnbo/QVhOTUkuj93wMbhFOkMlu3+
 +sGw==
X-Gm-Message-State: AOJu0YxvROtm555Bop8KiVGsSpvRoi/Tr3BKRWxxKcJtM5ygcEwIGxZy
 Jb85tC/ZmQ/ah7Q/j4d2uPrFXvIPRSMCxDhKjREeHlVY1xdYb4g26oKTN4pAXf197Wl0GRR9qMf
 8zQ3pnKiyrHtN5xDw4otQQfU3CeeDPccH2kXBzBy0v3Sgwprnma5/mImmYTQ5MxkUJT5vUiVFIv
 YMWipcSvluKwhjYA4LoObQxb7tk7zDBmigKvG+gFQ7
X-Gm-Gg: ASbGncvsuZZmrP+U5G66qWI2GmSWabSaHC7NWTO7wjhL37XUxKkW8id1PykkhTPqr8e
 fCE3q0BZ81kkvBiGEZF1LDxTA1DFuTSiKi2PnuOTFq5J8lfToB2iGZI6un5AeHwh+UVPFNFtgaw
 UCTXw1K92ggi+M21YUm5VeFsx1dDLSLd9Oe6BBxeLRy37MqKlDgzlr4aydCnfmMyxF1PkNmcPqZ
 sU6G1AusSO1MnrmvmnBhuOZF61YfZ+Ij2t7n+IuE+XIqZUkdHO/AJd1GDqbyBD9VrltpurWnxoA
 Lm5OD+eLjP36aDf3mlzbe+qdk9A3m1TmAMcyLGsJYWhgjjE4RDlswK7Ux4cqu1G/SGLFtHVlvHn
 o5DfU3ztmqQTpvKtkwauJ4W/hynHCc+2t5WsRIuW1Bo8=
X-Received: by 2002:a05:600c:1c07:b0:45b:7ffa:1bf8 with SMTP id
 5b1f17b1804b1-45b7ffa1d60mr19703635e9.23.1756472436596; 
 Fri, 29 Aug 2025 06:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa8DZQ/d/Q29qaaQkZ/GREddHZy0PukUvlnzP0jmxuASNIK06ki3FUASLANKYhQDdSg79ttg==
X-Received: by 2002:a05:600c:1c07:b0:45b:7ffa:1bf8 with SMTP id
 5b1f17b1804b1-45b7ffa1d60mr19703255e9.23.1756472436042; 
 Fri, 29 Aug 2025 06:00:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b736bba5bsm47164955e9.6.2025.08.29.06.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 19/28] hw/i386/isapc.c: replace rom_memory with system_memory
Date: Fri, 29 Aug 2025 14:59:26 +0200
Message-ID: <20250829125935.1526984-20-pbonzini@redhat.com>
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

Now that we can guarantee the isapc machine will never have a PCI bus, any
instances of rom_memory can be replaced by system_memory and rom_memory
removed completely.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250828111057.468712-20-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/isapc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 300d64b7ad2..44f4a446724 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -38,7 +38,6 @@ static void pc_init_isa(MachineState *machine)
     uint32_t irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
-    MemoryRegion *rom_memory = system_memory;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     int i;
 
@@ -94,7 +93,7 @@ static void pc_init_isa(MachineState *machine)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, 0);
+        pc_memory_init(pcms, system_memory, system_memory, 0);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.51.0


