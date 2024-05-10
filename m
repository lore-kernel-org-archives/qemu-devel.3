Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F5AC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 17:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5U8B-0006GS-TR; Fri, 10 May 2024 13:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s5U88-0006GD-Ew
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s5U7w-0005Or-Fe
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715362427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oClqf0IBPfeyE52Yw+hVaOzTGdtEAD+IWsLO57huaic=;
 b=g6xMGJboFdU5asEAHVdL0IBl+l8B40TyqMyThdcsgdvyz2qFE5nAyis52WAY6gaUyTVZBv
 Uw1fYa/ELj5PeYDgEdAPvnAVj3MuDIBittDUvdSoznRLKH+C9usYFMaL6LwNkRFAUaEMBl
 CTuurDd8VQLw49/v9s6CekUyhVa/gfE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-w2zW0s3_OA67FXsd_0VXbA-1; Fri, 10 May 2024 13:33:45 -0400
X-MC-Unique: w2zW0s3_OA67FXsd_0VXbA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6a0f16e37b3so8512576d6.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 10:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715362425; x=1715967225;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oClqf0IBPfeyE52Yw+hVaOzTGdtEAD+IWsLO57huaic=;
 b=eDWRQIbuOfU2rvgSZmqWxg2qulJ6iGaiI+/VsbNkDV8jMt4y3//kStI4iAuzPqkQgN
 EVO8IN8LYNHRteILY3nV2kSGTUTrv703hvd0P73QLDO8r66SZ1c21y4H1vSBh11/HMmd
 MaY4NUzRiUZX8qXDkOlNr2iMLSPx19SlA38lbT9DXfIdMAjez02DHu+24YLsRTf675Gb
 XGEdPDnFebgRfUJYRUO7hppHDFQ9uolxHS/cJFoCKp/Tfk45DQHKoQVjASp18AnEAwFZ
 lbPCH/Upm1Fsf+FXbEwjNiBXpK8xKTu2U4rnOUfud7d5F2tFI/DJKeBBNmIaTLtsnGjy
 DAWQ==
X-Gm-Message-State: AOJu0YyxL4rk451a44glwYOip/7MTPjRojVcrtnYs/vLrQZcRluy1sq+
 2iAmz88eP+gpwG02nmTwRT9csaaCptKkCrGjY9bV/cwaK9UO9ZMml3J7J7GFBL0l7TNlrWpdeHh
 ZCbXph/3QCR8ot2fc+rhoBS7cyKSZ2DM9xeg3SbYH7hHfyTw2raJG
X-Received: by 2002:ac8:7f8e:0:b0:43a:b82a:5571 with SMTP id
 d75a77b69052e-43dfde9b0c4mr35749951cf.6.1715362424897; 
 Fri, 10 May 2024 10:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb6L5gw9SHNkx63VyasGaNGeKObSQJtY8C5bLaxXzSsQKYxzLu+TRZQme7MLZ0OAUxP1wsXA==
X-Received: by 2002:ac8:7f8e:0:b0:43a:b82a:5571 with SMTP id
 d75a77b69052e-43dfde9b0c4mr35749471cf.6.1715362424156; 
 Fri, 10 May 2024 10:33:44 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e046467a4sm6454641cf.83.2024.05.10.10.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 10:33:43 -0700 (PDT)
Date: Fri, 10 May 2024 13:33:41 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Sebastian Ott <sebott@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eduardo Habkost <eduardo@habkost.net>, Fiona Ebner <f.ebner@proxmox.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 3/4] virtio-gpu: use a VMState variant for the scanout
 field
Message-ID: <Zj5adUCIINuv42ua@x1n>
References: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
 <20240507111920.1594897-4-marcandre.lureau@redhat.com>
 <ZjqILU7qxlTGN4OD@x1n>
 <CAJ+F1CJjNnHoX=LvSsh5M_fiZg-n5K=KEgPRh+2gAjRij4Oq-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJjNnHoX=LvSsh5M_fiZg-n5K=KEgPRh+2gAjRij4Oq-w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.586,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Marc-André,

On Fri, May 10, 2024 at 12:39:34PM +0400, Marc-André Lureau wrote:
> Since we don't have per VMSD version information on the wire, nested
> struct versioning is quite limited and cumbersome. I am not sure it
> can be changed without breaking the stream format, and whether it's
> worthwhile.

Right that's a major pain, and actually I just notice it..

I think it'll be much, much simpler if we keep vmsd version on the wire for
each VMSD (including struct fields), then it makes more sense to me.

Then when I went back and see again the VSTRUCT thing...  I can hardly
understand what it is doing, and also how it works at all.

Look at the current only IPMI user, who has:

        VMSTATE_VSTRUCT_V(kcs, ISAIPMIKCSDevice, 2, vmstate_IPMIKCS,
                          IPMIKCS, 2),

It is setting both vmsd version and struct_version to 2.  I can't tell why
it matters then if anyway both of the fields are the same..

When we do save(), there is:

                } else if (field->flags & VMS_STRUCT) {
                    ret = vmstate_save_state(f, field->vmsd, curr_elem,
                                             vmdesc_loop);
                } else if (field->flags & VMS_VSTRUCT) {
                    ret = vmstate_save_state_v(f, field->vmsd, curr_elem,
                                               vmdesc_loop,
                                               field->struct_version_id, errp);

When we load():

                } else if (field->flags & VMS_STRUCT) {
                    ret = vmstate_load_state(f, field->vmsd, curr_elem,
                                             field->vmsd->version_id);
                } else if (field->flags & VMS_VSTRUCT) {
                    ret = vmstate_load_state(f, field->vmsd, curr_elem,
                                             field->struct_version_id);
                } else {

In this case, passing in struct_version==version should have zero effect
afaict, because the default behavior is passing in vmsd->version_id anyway.

Moreover, now I highly doubt whether the VMS_STRUCT whole thing makes sense
at all as you mentioned.  Especially on the load side, here we should rely
on vmstate_load_state() taking the last parameter as version_id on the
wire.  Here we're passing in the struct's version_id or struct_version_id,
and neither of them makes sense to me... if we miss that version_id
information, afaiu we should simply fix it and put it on the wire..  It'll
break migration, we may need to work that out, but I don't see a better
way.  Keeping it like this like a nightmare to me.. :-(

Irrelevant of all these mess.. For this specific problem, what I meant is
exactly what Michael was requesting too (hopefully), I'd want to avoid
further extending the complexity in this area.  I have a patch attached at
last which I also tested 8.2<->9.0 bi-directional migrations and it worked
for me when I smoked it.  Please have a look to see whether that makes
sense and at the meantime avoid most of the tricks.

I'd also like to mention one more thing just in case this can cause some
more attention to virtio guys..

Normally I ran vmstate-static-checker.py before softfreeze, and I did it
for 9.0 too without seeing this problem.  It isn't raised because all
virtio devices are using the "self managed" VMSTATE_VIRTIO_DEVICE to
migrate.  In that case I am out of luck.  We can further extend what
Fabiano mentioned in the other thread to cover migration stream validations
in the future, but just to mention IMHO that needs extra work, and may work
most likely the same as vmstate static checker but just waste many more cpu
resources.  It'll be good if someone could still help move virtio towards
like most of the rest devices, or at least get covered by the static
checker, too.  But that definitely is a separate topic too.. so we can
address the immediate breakage first.

Thanks,

==8<==
From a24ef99670fa7102da461d795aed4a957bad86b1 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 10 May 2024 12:33:34 -0400
Subject: [PATCH] fix gpu

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  2 +-
 hw/core/machine.c              |  1 +
 hw/display/virtio-gpu.c        | 21 +++++++++++++++------
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index ed44cdad6b..e128501bdc 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -176,7 +176,7 @@ typedef struct VGPUDMABuf {
 
 struct VirtIOGPU {
     VirtIOGPUBase parent_obj;
-
+    uint8_t vmstate_version;
     uint64_t conf_max_hostmem;
 
     VirtQueue *ctrl_vq;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4ff60911e7..8f6f0dda7c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -42,6 +42,7 @@ GlobalProperty hw_compat_8_2[] = {
     { "migration", "zero-page-detection", "legacy"},
     { TYPE_VIRTIO_IOMMU_PCI, "granule", "4k" },
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
+    { "virtio-gpu-device", "x-vmstate-version", "1" },
 };
 const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ae831b6b3e..c53f55404c 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1166,6 +1166,14 @@ static void virtio_gpu_cursor_bh(void *opaque)
     virtio_gpu_handle_cursor(&g->parent_obj.parent_obj, g->cursor_vq);
 }
 
+static bool vmstate_after_v2(void *opaque, int version)
+{
+    struct VirtIOGPUBase *base = container_of(opaque, VirtIOGPUBase, scanout);
+    struct VirtIOGPU *gpu = container_of(base, VirtIOGPU, parent_obj);
+
+    return gpu->vmstate_version >= 2;
+}
+
 static const VMStateDescription vmstate_virtio_gpu_scanout = {
     .name = "virtio-gpu-one-scanout",
     .version_id = 2,
@@ -1181,12 +1189,12 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
         VMSTATE_UINT32(cursor.hot_y, struct virtio_gpu_scanout),
         VMSTATE_UINT32(cursor.pos.x, struct virtio_gpu_scanout),
         VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
-        VMSTATE_UINT32_V(fb.format, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.bytes_pp, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.width, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.height, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.stride, struct virtio_gpu_scanout, 2),
-        VMSTATE_UINT32_V(fb.offset, struct virtio_gpu_scanout, 2),
+        VMSTATE_UINT32_TEST(fb.format, struct virtio_gpu_scanout,vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.bytes_pp, struct virtio_gpu_scanout,vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.width, struct virtio_gpu_scanout,vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.height, struct virtio_gpu_scanout,vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.stride, struct virtio_gpu_scanout,vmstate_after_v2),
+        VMSTATE_UINT32_TEST(fb.offset, struct virtio_gpu_scanout,vmstate_after_v2),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -1659,6 +1667,7 @@ static Property virtio_gpu_properties[] = {
     DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
     DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
+    DEFINE_PROP_UINT8("x-vmstate-version", VirtIOGPU, vmstate_version, 2),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.44.0


-- 
Peter Xu


