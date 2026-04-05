Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901E0E64016
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 07:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9HvI-0003uP-Ot; Sun, 05 Apr 2026 03:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvH-0003tu-DD
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:31 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvF-0007Eo-Tl
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:31 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2c54c68db4dso6147470eec.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 00:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775374168; x=1775978968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5URZfSAg9FIccdRM6Usf30iSs9MBUi6bDCXKqbZ7TQ=;
 b=ng7a5H+2Cmrfc/S1PAJei6UV03yf5u7x/k7KDzrLQMtpVJQL2pebzgW81yT2bnqpbe
 eIMUrWHlgWgXk6+sK3VMu2Ts+vaC1ZNuU6tznst2S7TczQm6ajbVeAE0vvSVzNpVVQl8
 eFKGs+JT8Llo/uvKW5VGor9eQD8olOPP40yhiOmSHAmvwSvJGiOdh7/qjdVnDj34pOmb
 6Yx5jSFAbGDipQiHksu+mIGcbaZcM027mSot7A68nry8kjil/tMUg0tI5TVhYJvcvmTW
 +fJr5ET0Ncb+PlUls3FddMyLZZx0NS17nS6X73y4NrN4zvHAoEaAq4nKO5gaSaADyOD9
 LcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775374168; x=1775978968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U5URZfSAg9FIccdRM6Usf30iSs9MBUi6bDCXKqbZ7TQ=;
 b=haeZho7RHoK3tXFbwc15gbkG+CJVm6HZ50A0Q2h8lRBl5fudUeMUJooFvGtENy6tJ4
 FsXgAmHsqxWuMGS4mx6k8Op56FTaMORRkOBcEpgCPffbEpcuJKVueBmSRW7nG/my8120
 AeOnAeQNvC+YDyA9a/eQYlPn2JYGPJR5Ktniwei9uzCdVos9RNH9fmdafeiWGLPcfDll
 2XM1G+/9+dRfAU/V5qbkz3q/Z9ALeoDkwYgV6kkbcCJsW9mjYlHsDol8e0yHg2fwZfcz
 fSZnEKAsALLCx8Tepzf78aq65+D6UE4c/yMXkNd68r8U7lsPgD3f6X7/KYC5jBkmk1kl
 x+Cw==
X-Gm-Message-State: AOJu0YwwiSDBiFBmHvUODpWM3KlGvWbqITmm3Lo6Z5fTWNBPpMGBi4p7
 SUx5HWLDtaYEby8aMUl5DQCAJ+0Bmz7TqoG3QYJWUTcmiF4qIsqbmPkMFv9D4wvwEI0=
X-Gm-Gg: AeBDiev4iG1HXPZSN0wWDx+TRoCYhYwtoBTcNMUKd4fxJLg+1pZzhkvGu6U/FEhNzkB
 ZbzhPLaQt1GR8V1Hlpa4/yaOwXOokpD6YX0eAPCV/M5xAWsG4H6WdxiTu7/KkSCo9kiG2LURM9I
 Ak2w1I1KR91nhnFNz3GrErf3T8UwZgQSopAhw8/MpKIs0cVwQEapVjg6oUtLYQDYE4NY1aaN4Ke
 SbXAaGSZ7SmUvf7uy7VdoOAmNYVDaOR2WcV7IBZGYayrIaLV87t14soVQ3q7eNPSx32zlF1h7rr
 WHJ0szH5kHOxaLO9H9ZxgUECWL1+HLWPtxPmaQZKSMJLeZBNS3K4i3zo/fJVdxPWEyDgf0Aij/X
 f1EOUhrz03FI93djv1hSETYLriQZdTLAJKdd7H+SnjwjX3wweUYFuiIOxycYd64/ojV8aUvUB9/
 2Mj405/mbzkXHsmh+Be7BasY0X/6hdTEmWKN6jui8L9iP/3O8yMqVIE2nM3G3tGKFKed4IZjTvm
 80zh7SnuzawXG76t73nbfwLM74=
X-Received: by 2002:a05:693c:3009:b0:2c1:5b23:1752 with SMTP id
 5a478bee46e88-2cbfc463645mr4676211eec.23.1775374168034; 
 Sun, 05 Apr 2026 00:29:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:41e4:ff2b:ff70:4d75])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cb92ea0ef1sm7636502eec.21.2026.04.05.00.29.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Apr 2026 00:29:27 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, rbolshakov@ddn.com,
 phil@philjordan.eu, mst@redhat.com, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, qemu-s390x@nongnu.org,
 "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [RFC PATCH 02/10] accel/hvf: avoid executable mappings for RAM-device
 memory
Date: Sun,  5 Apr 2026 00:28:46 -0700
Message-ID: <20260405072857.66484-3-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405072857.66484-1-scottjgo@gmail.com>
References: <20260405072857.66484-1-scottjgo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x1333.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On macOS, HVF can panic the host kernel if a guest accesses device-backed
memory through an executable mapping. Leave RAM-device/MMIO regions
mapped read/write only and keep EXEC for ordinary guest RAM.

This works around the immediate crash seen with passthrough BAR
mappings. There are still platform-specific performance issues with
guest write-combining mappings, but uncached mappings behave much more
like the host-side mapping and this at least avoids the panic.

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
---
 accel/hvf/hvf-all.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 5f357c6d19..76cec4655b 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -114,7 +114,15 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
         return;
     }
 
-    flags = HV_MEMORY_READ | HV_MEMORY_EXEC | (writable ? HV_MEMORY_WRITE : 0);
+    flags = HV_MEMORY_READ | (writable ? HV_MEMORY_WRITE : 0);
+    /*
+     * Leave RAM-device/MMIO mappings RW-only: on macOS, accessing them through
+     * executable HVF mappings can panic the host kernel. Ordinary guest RAM
+     * still needs EXEC.
+     */
+    if (!memory_region_is_ram_device(area)) {
+        flags |= HV_MEMORY_EXEC;
+    }
     mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
 
     trace_hvf_vm_map(gpa, size, mem, flags,
-- 
2.50.1 (Apple Git-155)


