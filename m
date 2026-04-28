Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BA0FF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHljo-0007MA-I4; Tue, 28 Apr 2026 12:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ReTwaQQKCigVOMVKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--rkir.bounces.google.com>)
 id 1wHljm-0007Lq-P3
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:56:42 -0400
Received: from mail-qt1-x849.google.com ([2607:f8b0:4864:20::849])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ReTwaQQKCigVOMVKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--rkir.bounces.google.com>)
 id 1wHljl-0005ZO-Bb
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:56:42 -0400
Received: by mail-qt1-x849.google.com with SMTP id
 d75a77b69052e-50d890580e1so164819801cf.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777395400; x=1778000200; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hqt0Ox6fqkRNuBsRY+/ccPu3FJOmcv/lsoKtLnDVcfs=;
 b=D02qVOQHqqxhpj6MWRULJuf6qylzuWCQxkKiI/q3Bkx4RK1Sd3AJc+bdnrftWDh5af
 xTu8xkmnUcdpHMHiV4cBViNYZq7VsmG53IdpaFcUz/Vw3gfF9z1JclXUT2e9cr5aMur5
 dPS2FNdL5Uc0x7MLjhv1p+enm6Pp9tk5u6oOhj8DRFfSgeU7811zEywm9nCyyvK+2FWU
 6Dyk/LigtNZ3BWCoH1/nM5tF2h82mzEVxGlOVkSs/x1GzkSQdPgQDPajZxWv9EG38oEd
 UalWF4eowBhbYUgp5dMCZlKj4wd8bBt8mjFltNnbxZ8jl44cWMoXVlz7WCEcxBhm3RRl
 uBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777395400; x=1778000200;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hqt0Ox6fqkRNuBsRY+/ccPu3FJOmcv/lsoKtLnDVcfs=;
 b=BLgJiNxb/i51oUENy9Ann+r0PJuqh7INlIO+qXD2uNs0ek4qMD+9bde0kLoYwg5py7
 yc2FH2kt4voVM8Lzza2rU/ltZiBr9ki2N9pqvkYACqjhaEVAaAbYGcxlBkiUsJDs+p8C
 JG2ed61Wfc0vHDErrTqR/rvXPDp0Q5TzRQJu7BoKxmkr7OijYLFUGPRmKXoNsoDX4Q9T
 /rV+cnFeuNPz4YO+WWwTzJDuoL7ecHwmZOkVYEPpfVdrasIwnA0aku3d3TELwUf5dh3h
 B/b+6Xl6xxGT7/M2SExp914xqWdKcMDJKQ9my8sdRgH1hUTAbhvllkjwEyxdjeukJlQp
 pFzQ==
X-Gm-Message-State: AOJu0YzsYhXJKLwKHqDG1U2eiB4o15g+i+AQDHGhREmzNW4V0AsPaNd2
 SEN3WYW4x+OPMGi1ZJGoeKEeKvocCSsm2cVXOeNSQynSVi3Jx/B+TzKWKU6Ij73cGjWrv88K3Q=
 =
X-Received: from pfnz21.prod.google.com ([2002:aa7:85d5:0:b0:82f:aed1:37c5])
 (user=rkir job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:aa09:b0:829:7e6d:cf22
 with SMTP id d2e1a72fcca58-834ddc8800cmr3569793b3a.43.1777394757155; Tue, 28
 Apr 2026 09:45:57 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:45:45 +0000
In-Reply-To: <20260428164545.2782523-1-rkir@google.com>
Mime-Version: 1.0
References: <20260427154441.1918536-1-rkir@google.com>
 <20260428164545.2782523-1-rkir@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428164545.2782523-3-rkir@google.com>
Subject: [PATCH v2 2/2] display: rutabaga: unparent MemoryRegions in unmap
From: Roman Kiryanov <rkir@google.com>
To: pbonzini@redhat.com, alex.bennee@linaro.org, marcandre.lureau@gmail.com
Cc: qemu-devel@nongnu.org, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::849;
 envelope-from=3ReTwaQQKCigVOMVKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--rkir.bounces.google.com;
 helo=mail-qt1-x849.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The virtio-gpu-rutabaga-device instance holds a
hash table of child objects (`Object::properties`)
and a memory region is added there every time
`memory_region_init_ram_ptr` is called.

The `unmap_blob` call invalidates a `MemoryRegion`
but does not remove it from the device, which makes
pointers to the region dangling and eventually causes
a crash when those pointers are dereferenced.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 hw/display/virtio-gpu-rutabaga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index ebb6c783fb..5cd9b19336 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -737,6 +737,7 @@ rutabaga_cmd_resource_unmap_blob(VirtIOGPU *g,
 
         MemoryRegion *mr = &(vr->memory_regions[slot].mr);
         memory_region_del_subregion(&vb->hostmem, mr);
+        object_unparent(OBJECT(mr));
 
         vr->memory_regions[slot].resource_id = 0;
         vr->memory_regions[slot].used = 0;
-- 
2.54.0.545.g6539524ca2-goog


