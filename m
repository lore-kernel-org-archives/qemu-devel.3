Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC86C369A0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 13:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0KkT-0001az-CC; Thu, 03 Apr 2025 09:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1u0JVP-0000Kj-VG
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 08:17:11 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1u0JVO-0002vn-3Y
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 08:17:11 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5edc07c777eso1118571a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 05:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743682628; x=1744287428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=soJfbtivJR94+FbU86ULGjFMRetjrqluFsbTH7g6BBE=;
 b=jjgUcCI2annAjefl/5OxGgVBAKKc4zTwHEn/j0V32470TQAjKDTAKTEyqfE0F26v8Z
 c8qY3eURlAfTeGC4HJa5htZDOClWTIjOvRuqJNco4A3a7LsI2rYr1m5/5szTX4/dsDPm
 FL/NYI8jWnrbIHQJ9Pu69Cva7CDlS3b9KBmPdxKC2YxsM7krmAzhQNEj4HvHhlz9AH/t
 frRVsyugWRJICRNBi42fF64Fqw987Oe+3g1/1ATLfZioOLZtcGHzuhu8immARxAsHWv7
 27LMfL+8TTQRt8lzDN/CchHtkyRlgt+M/Ri73QEfQgR03u7CVCwBuGYDWzRtb+/P5K1X
 vgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743682628; x=1744287428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=soJfbtivJR94+FbU86ULGjFMRetjrqluFsbTH7g6BBE=;
 b=pueSqVZqwFdcrecFBRwG9E60FgQ0YKuIkn8FM/U6FN9sX712EVp0c5tQ5teR9m1Z3h
 p9dQRbs6UpKNBTh04XI4lnfMPOo+ucdDy6OYB/BLLFnGpjc5WSxFILOKVQIRRd2jJfa0
 hE/uN8wXyV+fNLTbHECc+57xqW6Ljnxpc0rFEwKE7sT+bhTo/wlzxOujE1wJklIGaelz
 tszyBCm97UmtDyFqVeP0OsNhndu/W9OkimAN7IJUzkllEdO98LNFr0xfEsKLfIdXQjrZ
 ijH/T2yNsM+uDdDBOPebWSOGpufQf/I+adOpci9MYHVh56k9cRBGek9xu0sYKl2NGt+o
 YpkA==
X-Gm-Message-State: AOJu0YwkXWyqaeOil1o8PTWOat3X5gGe9zOKgwjQweEOdxQNisn3uVfD
 D341ats6vjfjtLoXTHwsI8MCtblr2QVb2+oSdC+wndZ1IOpE/NQB0E/MjwaPvPmB8ksKadvWpxS
 vKPs=
X-Gm-Gg: ASbGncvpqsxl2tiVeH7KUDhWTY2JBgCJ8V+x/rKWQst08UL927F0PjISUgwOLyoeC25
 CDDczD5VAUVH4jE2FvD6qm362W5DVB0Y1selFI3F+E0rPj3ue/OrqpwYpwIuye7HmCy7a/7TNww
 UfD26BaDdI0xeSnrPj006rf4B48KYWEexKBOpqqceqysU/29Lhn6bGPa2gz/DlyItfJRs+7V5n8
 lQ31ee726v/a53H8io3jHFq491ncfscff7i9ePOeeWsxWs5zSSi8/sBkCr5gcXorEVH04VfhaRl
 DryIQiYKyO4ot/HRlvexeF+9wGBxre++tnyHMDjcGApwsbOpyjUnzowC8ztXCVSilJCDVyEL+3i
 R/CP/CpBF50Pe0SVAEKU=
X-Google-Smtp-Source: AGHT+IHK+AjpcagVc0IuOK85YMhhZHFkpWuB8lnGz8V6Cmrp+iexAWaWJCKULON8CDxPxepEevTEjg==
X-Received: by 2002:a17:907:6e88:b0:ac4:5f1:a129 with SMTP id
 a640c23a62f3a-ac7a16c1307mr545411066b.15.1743682627822; 
 Thu, 03 Apr 2025 05:17:07 -0700 (PDT)
Received: from localhost.localdomain (adsl-37.37.6.161.tellas.gr.
 [37.6.161.37]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe61c15sm85641666b.12.2025.04.03.05.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 05:17:07 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v1 1/2] virtio-gpu: fix hang under TCG when unmapping blob
Date: Thu,  3 Apr 2025 15:17:01 +0300
Message-ID: <20250403121704.2754589-2-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250403121704.2754589-1-manos.pitsidianakis@linaro.org>
References: <20250403121704.2754589-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 03 Apr 2025 09:36:46 -0400
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

This commit fixes an indefinite hang when using VIRTIO GPU blob objects
under TCG in certain conditions.

The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB VIRTIO command creates a
MemoryRegion and attaches it to an offset on a PCI BAR of the
VirtIOGPUdevice. The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB command unmaps
it.

Because virglrenderer commands are not thread-safe they are only
called on the main context and QEMU performs the cleanup in three steps
to prevent a use-after-free scenario where the guest can access the
region after it’s unmapped:

1. From the main context, the region’s field finish_unmapping is false
   by default, so it sets a variable cmd_suspended, increases the
   renderer_blocked variable, deletes the blob subregion, and unparents
   the blob subregion causing its reference count to decrement.

2. From an RCU context, the MemoryView gets freed, the FlatView gets
   recalculated, the free callback of the blob region
   virtio_gpu_virgl_hostmem_region_free is called which sets the
   region’s field finish_unmapping to true, allowing the main thread
   context to finish replying to the command

3. From the main context, the command is processed again, but this time
   finish_unmapping is true, so virgl_renderer_resource_unmap can be
   called and a response is sent to the guest.

It happens so that under TCG, if the guest has no timers configured (and
has no other interrupts that will cause the CPU to exit), the RCU thread
does not have enough time to grab the locks and recalculate the
FlatView.

That’s not a big problem in practice since most guests will assume a
response will happen later in time and go on to do different things,
potentially triggering interrupts and allowing the RCU context to run.
If the guest waits for the unmap command to complete though, it blocks
indefinitely. Attaching to the QEMU monitor and force quitting the guest
allows the cleanup to continue.

There's no reason why the FlatView recalculation can't occur right away
when we delete the blob subregion, however. It does not, because when we
create the subregion we set the object as its own parent:

    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);

The extra self-reference is what prevents freeing the memory region
object in the memory transaction of deleting the subregion.

This commit changes the owner object to the device, which removes the
extra owner reference in the memory region and causes the MR to be
freed right away in the main context.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/display/virtio-gpu-virgl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 145a0b3879..ad600ccc9c 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -120,7 +120,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     vmr->g = g;
 
     mr = &vmr->mr;
-    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
+    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
     memory_region_add_subregion(&b->hostmem, offset, mr);
     memory_region_set_enabled(mr, true);
 
-- 
γαῖα πυρί μιχθήτω


