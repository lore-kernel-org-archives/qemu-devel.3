Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE5AC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvi5-0007RP-O4; Fri, 28 Aug 2026 08:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wzvi4-0007RC-8Z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:29:28 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wzvi1-0002B4-Jl
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:29:28 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67SCTAQg054723
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 28 Aug 2026 21:29:10 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=NwlAphhmNSBsraWuVrjSUHBYPh92g/vnkH5ocF4uonE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787920150; v=1;
 b=S/zfwbjGxLtqo7LwWM+1BxJoW6Nu3ieaTL7qaJlsjpd/0Rw9mdw3fKEi9DgFN42x
 iFNJhK0j5rrKF0Eif5AaCUXmjxlhzSYBShThz/NKu2BQKJjwJXn3+ydX2FFbnfTq
 w/Y/A1HTGP37gkK3akt9McDbv3tkekoVulDwGJYF2cnW51joMU6f7z8NkSWko9BG
 n+kaG0Uolc42Sz34Un9j3Aj4QbYVa6UrtsZ0r02Hy6ktTd+78AVGO1e+AeCcx/me
 d/1WEqNpxcyFtd/yr6bwLqRCgR4JJphB6vIJGsGH671SU6bxzRSqCR6Jzw/Lo+VY
 mcQv8xSgNLXtZEedRwN1PQ==
Message-ID: <d71116d3-2108-4f14-baa0-d2f1f878b5f4@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 28 Aug 2026 21:29:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] RFC: various virtio-gpu/dmabuf related fixes
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 swing <swing@mail.exp.sh>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
 <a0bd3ef2-91df-4a6d-a04f-67a568188b24@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
In-Reply-To: <a0bd3ef2-91df-4a6d-a04f-67a568188b24@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/08/28 21:26, Akihiko Odaki wrote:
> On 2026/08/25 19:20, Marc-André Lureau wrote:
>> Hi,
>>
>> While working on CVE-2026-66020 (which had a few revision on list), I
>> kept finding several places where virtio-gpu scanout and dmabuf
>> ownership was unclear.
>>
>> The CVE comes from using a blob after RESOURCE_DETACH_BACKING has
>> unmapped its memory. Following that path also found stale dmabuf
>> references, duplicated scanout bookkeeping, and inconsistent cleanup
>> between display backends.
>>
>> This series makes each virtio_gpu_scanout own its current dmabuf and
>> uses resource_id to track which resource it displays. It also makes
>> QemuDmaBuf own its file descriptors and moves GTK fence state out of the
>> dmabuf.
>>
>> Those changes touch a lot of area and I have done basic testing with the
>> various backends. I would not recommend backporting them to stable:
>> there is a high risk of introducing regressions. Yet, I don't know how
>> to address all the problems uncovered by CVE-2026-66020 in a simple
>> patch series. Help welcome!
> 
> If you mean "all the problems", my coding agent tells there are some 
> problems remaining:

I forgot to note that I manually reviewed the claims.

I also think you can drop RFC. Though the series is large, each patch is 
small and I think reasonable.

> 
> 1. Vhost-user still has duplicate, incomplete DMA-BUF ownership.
> 
> VhostUserGPU retains its separate g->dmabuf[]. The contrib backend 
> disables a scanout using ordinary VHOST_USER_GPU_SCANOUT with zero 
> dimensions, but the QEMU frontend handles that by only calling 
> qemu_console_set_surface().
> 
> Although that changes con->scanout.kind, it neither releases g- 
>  >dmabuf[id] nor invokes the frontend GL-disable callback. GTK/SDL can 
> therefore retain their private scanout mode and redraw the old buffer; 
> the wrapper and owned fd remain until another DMA-BUF message. Reset and 
> finalize also never free this array.
> 
> Separately, contrib’s virgl RESOURCE_UNREF destroys the renderer 
> resource without disabling scanouts using it. The in-process virgl 
> backend fixes precisely this case, but contrib does not.
> 
> 2. GTK DMA-BUF texture release lacks the required GL context.
> 
> GTK’s release callback directly calls egl_dmabuf_release_texture(), 
> which calls glDeleteTextures() and then unconditionally forgets the 
> texture ID. Neither it nor the core release dispatcher establishes the 
> owning context.
> 
> This is reachable after another GTK console’s surface update leaves
> EGL_NO_CONTEXT current. Deletion is then not guaranteed, yet the ID is 
> lost, leaking the GL import and backing. With another unshared context 
> current, a coincident texture name could be deleted from the wrong 
> context. SDL has the same missing-context pattern.
> 
> 3. Rutabaga resource destruction remains incomplete.
> 
> virtio_gpu_rutabaga_resource_unref() calls Rutabaga unref and frees the 
> QEMU resource, but does not clean res->iov/res->addrs or remove a mapped 
> blob’s host-visible MemoryRegion. Only explicit RESOURCE_UNMAP_BLOB 
> removes that region.
> 
> Consequently, MAP_BLOB → RESOURCE_UNREF or reset can leave a
> MemoryRegion pointing at storage destroyed by Rutabaga, as well as 
> pinned DMA mappings. This is adjacent to, rather than the original 
> scanout-detach CVE, but it is another unresolved blob-ownership problem.
> 
> ...so there is still some work to be done.
> 
> But when it comes to backporting, I think we can instead do focused 
> backporting to avoid extra trouble. Concretely, the patches you tagged 
> with "Fixes: CVE-2026-66020" can be backported, namely:
> 
> - "[PATCH 10/18] virtio-gpu: disable blob scanouts on mapping cleanup" and
> - "[PATCH 18/18] virtio-gpu: fix use-after-free on blob cursor after 
> detach"
> 
> The latter is interchangeable with "[PATCH v2 4/5] hw/display/virtio- 
> gpu: Check cursor data presence", which I posted (sorry but I forgot the 
> presence of your cursor fix.)
> 
> These patches fix use-after-free that can have unpredictable 
> consequences and is potentially vulnerable.
> 
> Other patches fix stale DMA-BUF references and potential resource leaks. 
> While they are real bugs and can lead to problems like display glitches 
> and high memory usage, these risks are minor and their security 
> implication is probably negligible.
> 
> Regards,
> Akihiko Odaki
>>
>> thanks
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>> Marc-André Lureau (18):
>>        ui/gtk: move GL fence tracking from QemuDmaBuf to 
>> VirtualGfxConsole
>>        ui/dbus: disable scanout iff dmabuf is current
>>        virtio-gpu: store the scanout DMABUF in virtio_gpu_scanout
>>        ui/console: disable GL scanout when dmabuf is the active one
>>        ui/sdl2: clear guest_fb.dmabuf on release
>>        ui/dmabuf: own and close fds on free
>>        virtio-gpu: release the dmabuf when a scanout is disabled
>>        contrib/vhost-user-gpu: drop scanout_bitmask bookkeeping
>>        virtio-gpu-rutabaga: fix scanout handling
>>        virtio-gpu: disable blob scanouts on mapping cleanup
>>        virtio-gpu: drop scanout_bitmask bookkeeping
>>        virtio-gpu: release dmabuf when switching to a surface
>>        virtio-gpu/virgl: release dmabuf when a texture replaces a scanout
>>        virtio-gpu: consolidate disabling scanout
>>        virtio-gpu: minor refactoring
>>        virtio-gpu/virgl: disable scanouts on resource unref
>>        virtio-gpu: initialize dmabuf_fd to -1
>>        virtio-gpu: fix use-after-free on blob cursor after detach
>>
>>   contrib/vhost-user-gpu/vhost-user-gpu.c | 28 +++-------
>>   hw/display/vhost-user-gpu.c             |  1 -
>>   hw/display/virtio-gpu-rutabaga.c        | 26 +++++++---
>>   hw/display/virtio-gpu-udmabuf-stubs.c   |  2 +-
>>   hw/display/virtio-gpu-udmabuf.c         | 90 ++++++++++ 
>> +----------------------
>>   hw/display/virtio-gpu-virgl.c           | 75 ++++++++++++++ 
>> +------------
>>   hw/display/virtio-gpu.c                 | 82 ++++++++++++++++++ 
>> +-----------
>>   hw/vfio/display.c                       |  1 -
>>   include/hw/virtio/virtio-gpu.h          | 18 ++-----
>>   include/ui/dmabuf.h                     |  5 --
>>   include/ui/egl-helpers.h                |  4 +-
>>   include/ui/gtk.h                        |  8 +--
>>   ui/console.c                            |  3 ++
>>   ui/dbus-listener.c                      | 69 +++++++++++++++++--------
>>   ui/dmabuf.c                             | 51 +++----------------
>>   ui/egl-helpers.c                        | 15 +++---
>>   ui/gtk-egl.c                            | 30 ++++++-----
>>   ui/gtk-gl-area.c                        | 12 ++---
>>   ui/gtk.c                                | 31 +++++++++---
>>   ui/sdl2-gl.c                            |  5 ++
>>   20 files changed, 277 insertions(+), 279 deletions(-)
>> ---
>> base-commit: 82706188517bd102ed25f1931c4cb041ecf3ef50
>> change-id: 20260825-virtio-gpu-cleanup-dfb2ba185936
>>
>> Best regards,
>> -- 
>> Marc-André Lureau <marcandre.lureau@redhat.com>
>>
> 


