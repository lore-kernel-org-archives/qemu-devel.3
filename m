Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8984AC30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 10:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOEbP-0007W5-PD; Mon, 01 Jul 2024 06:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOEax-0007Qi-Pj
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 06:49:41 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOEau-0005bZ-Dj
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 06:49:15 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e0365588ab8so2070210276.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 03:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719830951; x=1720435751; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pbHQcOPSpcTxyMQTh+kxRiEyINvmZ82NL9bMELm5q9M=;
 b=Oqmcjj5W3L+2OegLzvkYGpuCbLwcMmJZAti2GmP+burIrGgeu9ZTam4mO1cyIkNplN
 4Q3lfRKsILKxfoEwUGjj2/K5LWH/sVgECciTK8/ivo9BGxCTxzUmfQJzAn0PimdaOnr8
 fI7OwAWio94wUIc+AWIQLwM/nkHptXFznj8WdwCLnbEXklTz+o5HGuaxiT8DD5Tpi2Za
 HB+IiToOL0OI3McpxYfmrEG02GHx7V7CLH/BFz3gioAohU5ZJR+z9HKQ5yTX+wCiAJZv
 3axYcokdnBoI3RVLHgzSC7O80CtAJrSj2gx+Vzt8bg3rcRi4oZ/0KKmK0L/1D2CYgPL0
 2u/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719830951; x=1720435751;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pbHQcOPSpcTxyMQTh+kxRiEyINvmZ82NL9bMELm5q9M=;
 b=aEr7nmTiCT1k9fSq2A1az707LXSpfWkhNOv6jL9mDaYnxx+U7RmAJKjD7c95eVQxmk
 HCVEMFZorv/H42s8uY37msbsWCFgSQAQOvaS7x9QfUS+3fYkWbBsR69M+pACvUqYej8o
 P8MJ+unOj52idD65nWYD1ofgA+psYPjRqzcfVcHgoWs6ftjtoa2TjBQHoNE5QnghO1So
 YneTq9umPNkj7PhlvO/BjGXoi8A0f+/4IJ6aNy7EbZRrJBTMqkOuVQTimE3PNBm0JVmz
 T21VHuOEcZd9mYGcWCdsVDawZ3Pmq6BMTysK2Xuq+gUUi8rptnq+Huag7zqD9oyL4wWk
 K/QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpBeyVw40Eu0W70ClmsrLCJLxNIWBUHNGfmTBKX+71AQVAujI7b9d82BxsKjD7XMKzEK3BI063nUUO8hiQrAFO0ASQon8=
X-Gm-Message-State: AOJu0YzGMdNgKsoIpLIWRRP8jhVKdxbl3nHLG2SWqFFe0SU/ILy4P8WU
 ZOJWR3fUuRNvmg0hPf8eGvMB2UFqbSyrPdtUBjA5kbIcQMAlVEkrG7zE/ssWuZDdr4G8VUw7oVU
 0HzcwFlYBvoBbP/f/nuk2PTu1wG0=
X-Google-Smtp-Source: AGHT+IFcpnHMMIG257HhYxounm+YXRhnBdSSgOySWee9MKBqaqxQ/8ReQRN+WCRsGkYW2HFlcuwDJ+HPYB3VKEs7y7U=
X-Received: by 2002:a5b:484:0:b0:e03:63c7:7b46 with SMTP id
 3f1490d57ef6-e036eb3dc4cmr3817394276.20.1719830951026; Mon, 01 Jul 2024
 03:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 1 Jul 2024 14:48:58 +0400
Message-ID: <CAJ+F1CL84ZYtHq+6rVrFYerEhuRvczi1pb5Nui8BeyRqMygaVQ@mail.gmail.com>
Subject: Re: [PATCH v16 00/13] Support blob memory and venus on qemu
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Yiwei Zhang <zzyiwei@chromium.org>
Content-Type: multipart/alternative; boundary="000000000000e8e945061c2d58cb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yb1-xb32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000e8e945061c2d58cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

All R-b now, it looks good to merge. Thanks for all the effort!

Michael, are you taking it through your tree?

On Sun, Jun 23, 2024 at 7:23=E2=80=AFPM Dmitry Osipenko <
dmitry.osipenko@collabora.com> wrote:

> Hello,
>
> This series enables Vulkan Venus context support on virtio-gpu.
>
> All virglrender and almost all Linux kernel prerequisite changes
> needed by Venus are already in upstream. For kernel there is a pending
> KVM patchset that fixes mapping of compound pages needed for DRM drivers
> using TTM [1], othewrwise hostmem blob mapping will fail with a KVM error
> from Qemu.
>
> [1]
> https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@google.com/
>
> You'll need to use recent Mesa version containing patch that removes
> dependency on cross-device feature from Venus that isn't supported by
> Qemu [2].
>
> [2]
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/087e9a96d13155e26987bef=
ae78b6ccbb7ae242b
>
> Example Qemu cmdline that enables Venus:
>
>   qemu-system-x86_64 -device virtio-vga-gl,hostmem=3D4G,blob=3Dtrue,venus=
=3Dtrue
> \
>       -machine q35,accel=3Dkvm,memory-backend=3Dmem1 \
>       -object memory-backend-memfd,id=3Dmem1,size=3D8G -m 8G
>
>
> Changes from V15 to V16
>
> - Fixed resource_get_info() change made in v15 that was squshed into a
>   wrong patch. Squashed set_scanout_blob patch into the blob-commands
> patch,
>   otherwise we'll need to revert back ordering of blob patches to older v=
7
>   variant.
>
> - Changed hostmem mapping state to boolean, suggested by Akihiko Odaki.
>
> - Documented Venus in virtio-gpu doc. Amended "Support Venus context" pat=
ch
>   with the doc addition. Suggested by Akihiko Odaki.
>
> Changes from V14 to V15
>
> - Dropped hostmem mapping state that got unused in v14, suggested by
>   Akihiko Odaki.
>
> - Moved resource_get_info() from set_scanout_blob() to create_blob(),
>   suggested by Akihiko Odaki.
>
> - Fixed unitilized variable in create_blob(), spotted by Alex Benn=C3=A9e=
.
>
> Changes from V13 to V14
>
> - Fixed erronous fall-through in renderer_state's switch-case that was
>   spotted by Marc-Andr=C3=A9 Lureau.
>
> - Reworked HOSTMEM_MR_FINISH_UNMAPPING handling as was suggested by
>   Akihiko Odaki. Now it shares the same code path with HOSTMEM_MR_MAPPED.
>
> - Made use of g_autofree in virgl_cmd_resource_create_blob() as was
>   suggested by Akihiko Odaki.
>
> - Removed virtio_gpu_virgl_deinit() and moved all deinit code to
>   virtio_gpu_gl_device_unrealize() as was suggested by Marc-Andr=C3=A9 Lu=
reau.
>
> - Replaced HAVE_FEATURE in mseon.build with virglrenderer's VERSION_MAJOR
>   check as was suggested by Marc-Andr=C3=A9 Lureau.
>
> - Added trace event for cmd-suspension as was suggested by Marc-Andr=C3=
=A9
> Lureau.
>
> - Added patch to replace in-flight printf's with trace events as was
>   suggested by Marc-Andr=C3=A9 Lureau
>
> Changes from V12 to V13
>
> - Replaced `res->async_unmap_in_progress` flag with a mapping state,
>   moved it to the virtio_gpu_virgl_hostmem_region like was suggested
>   by Akihiko Odaki.
>
> - Renamed blob_unmap function and added back cmd_suspended argument
>   to it. Suggested by Akihiko Odaki.
>
> - Reordered VirtIOGPUGL refactoring patches to minimize code changes
>   like was suggested by Akihiko Odaki.
>
> - Replaced gl->renderer_inited with gl->renderer_state, like was suggeste=
d
>   by Alex Benn=C3=A9e.
>
> - Added gl->renderer state resetting to gl_device_unrealize(), for
>   consistency. Suggested by Alex Benn=C3=A9e.
>
> - Added rb's from Alex and Manos.
>
> - Fixed compiling with !HAVE_VIRGL_RESOURCE_BLOB.
>
> Changes from V11 to V12
>
> - Fixed virgl_cmd_resource_create_blob() error handling. Now it doesn't
>   corrupt resource list and releases resource properly on error. Thanks
>   to Akihiko Odaki for spotting the bug.
>
> - Added new patch that handles virtio_gpu_virgl_init() failure gracefully=
,
>   fixing Qemu crash. Besides fixing the crash, it allows to implement
>   a cleaner virtio_gpu_virgl_deinit().
>
> - virtio_gpu_virgl_deinit() now assumes that previously virgl was
>   initialized successfully when it was inited at all. Suggested by
>   Akihiko Odaki.
>
> - Fixed missed freeing of print_stats timer in virtio_gpu_virgl_deinit()
>
> - Added back blob unmapping or RESOURCE_UNREF that was requested
>   by Akihiko Odaki. Added comment to the code explaining how
>   async unmapping works. Added back `res->async_unmap_in_progress`
>   flag and added comment telling why it's needed.
>
> - Moved cmdq_resume_bh to VirtIOGPUGL and made coding style changes
>   suggested by Akihiko Odaki.
>
> - Added patches that move fence_poll and print_stats timers to VirtIOGPUG=
L
>   for consistency with cmdq_resume_bh.
>
> Changes from V10 to V11
>
> - Replaced cmd_resume bool in struct ctrl_command with
>   "cmd->finished + !VIRTIO_GPU_FLAG_FENCE" checking as was requested
>   by Akihiko Odaki.
>
> - Reworked virgl_cmd_resource_unmap/unref_blob() to avoid re-adding
>   the 'async_unmap_in_progress' flag that was dropped in v9:
>
>     1. virgl_cmd_resource_[un]map_blob() now doesn't check itself whether
>        resource was previously mapped and lets virglrenderer to do the
>        checking.
>
>     2. error returned by virgl_renderer_resource_unmap() is now handled
>        and reported properly, previously the error wasn't checked. The
>        virgl_renderer_resource_unmap() fails if resource wasn't mapped.
>
>     3. virgl_cmd_resource_unref_blob() now doesn't allow to unref resourc=
e
>        that is mapped, it's a error condition if guest didn't unmap
> resource
>        before doing the unref. Previously unref was implicitly unmapping
>        resource.
>
> Changes from V9 to V10
>
> - Dropped 'async_unmap_in_progress' variable and switched to use
>   aio_bh_new() isntead of oneshot variant in the "blob commands" patch.
>
> - Further improved error messages by printing error code when actual erro=
r
>   occurrs and using ERR_UNSPEC instead of ERR_ENOMEM when we don't really
>   know if it was ENOMEM for sure.
>
> - Added vdc->unrealize for the virtio GL device and freed virgl data.
>
> - Dropped UUID and doc/migration patches. UUID feature isn't needed
>   anymore, instead we changed Mesa Venus driver to not require UUID.
>
> - Renamed virtio-gpu-gl "vulkan" property name back to "venus".
>
> Changes from V8 to V9
>
> - Added resuming of cmdq processing when hostmem MR is freed,
>   as was suggested by Akihiko Odaki.
>
> - Added more error messages, suggested by Akihiko Odaki
>
> - Dropped superfluous 'res->async_unmap_completed', suggested
>   by Akihiko Odaki.
>
> - Kept using cmd->suspended flag. Akihiko Odaki suggested to make
>   virtio_gpu_virgl_process_cmd() return false if cmd processing is
>   suspended, but it's not easy to implement due to ubiquitous
>   VIRTIO_GPU_FILL_CMD() macros that returns void, requiring to change
>   all the virtio-gpu processing code.
>
> - Added back virtio_gpu_virgl_resource as was requested by Akihiko Odaki,
>   though I'm not convinced it's really needed.
>
> - Switched to use GArray, renamed capset2_max_ver/size vars and moved
>   "vulkan" property definition to the virtio-gpu-gl device in the Venus
>   patch, like was suggested by Akihiko Odaki.
>
> - Moved UUID to virtio_gpu_virgl_resource and dropped UUID save/restore
>   since it will require bumping VM version and virgl device isn't miratab=
le
>   anyways.
>
> - Fixed exposing UUID feature with Rutabaga
>
> - Dropped linux-headers update patch because headers were already updated
>   in Qemu/staging.
>
> - Added patch that updates virtio migration doc with a note about
> virtio-gpu
>   migration specifics, suggested by Akihiko Odaki.
>
> - Addressed coding style issue noticed by Akihiko Odaki
>
> Changes from V7 to V8
>
> - Supported suspension of virtio-gpu commands processing and made
>   unmapping of hostmem region asynchronous by blocking/suspending
>   cmd processing until region is unmapped. Suggested by Akihiko Odaki.
>
> - Fixed arm64 building of x86 targets using updated linux-headers.
>   Corrected the update script. Thanks to Rob Clark for reporting
>   the issue.
>
> - Added new patch that makes registration of virgl capsets dynamic.
>   Requested by Antonio Caggiano and Pierre-Eric Pelloux-Prayer.
>
> - Venus capset now isn't advertised if Vulkan is disabled with vulkan=3Df=
alse
>
> Changes from V6 to V7
>
> - Used scripts/update-linux-headers.sh to update Qemu headers based
>   on Linux v6.8-rc3 that adds Venus capset definition to virtio-gpu
>   protocol, was requested by Peter Maydel
>
> - Added r-bs that were given to v6 patches. Corrected missing s-o-bs
>
> - Dropped context_init Qemu's virtio-gpu device configuration flag,
>   was suggested by Marc-Andr=C3=A9 Lureau
>
> - Added missing error condition checks spotted by Marc-Andr=C3=A9 Lureau
>   and Akihiko Odaki, and few more
>
> - Returned back res->mr referencing to memory_region_init_ram_ptr() like
>   was suggested by Akihiko Odaki. Incorporated fix suggested by Pierre-Er=
ic
>   to specify the MR name
>
> - Dropped the virgl_gpu_resource wrapper, cleaned up and simplified
>   patch that adds blob-cmd support
>
> - Fixed improper blob resource removal from resource list on resource_unr=
ef
>   that was spotted by Akihiko Odaki
>
> - Change order of the blob patches, was suggested by Akihiko Odaki.
>   The cmd_set_scanout_blob support is enabled first
>
> - Factored out patch that adds resource management support to
> virtio-gpu-gl,
>   was requested by Marc-Andr=C3=A9 Lureau
>
> - Simplified and improved the UUID support patch, dropped the hash table
>   as we don't need it for now. Moved QemuUUID to
> virtio_gpu_simple_resource.
>   This all was suggested by Akihiko Odaki and Marc-Andr=C3=A9 Lureau
>
> - Dropped console_has_gl() check, suggested by Akihiko Odaki
>
> - Reworked Meson cheking of libvirglrender features, made new features
>   available based on virglrender pkgconfig version instead of checking
>   symbols in header. This should fix build error using older virglrender
>   version, reported by Alex Benn=C3=A9e
>
> - Made enabling of Venus context configrable via new virtio-gpu device
>   "vulkan=3Dtrue" flag, suggested by Marc-Andr=C3=A9 Lureau. The flag is =
disabled
>   by default because it requires blob and hostmem options to be enabled
>   and configured
>
> Changes from V5 to V6
>
> - Move macros configurations under virgl.found() and rename
>   HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS.
>
> - Handle the case while context_init is disabled.
>
> - Enable context_init by default.
>
> - Move virtio_gpu_virgl_resource_unmap() into
>   virgl_cmd_resource_unmap_blob().
>
> - Introduce new struct virgl_gpu_resource to store virgl specific members=
.
>
> - Remove erro handling of g_new0, because glib will abort() on OOM.
>
> - Set resource uuid as option.
>
> - Implement optional subsection of vmstate_virtio_gpu_resource_uuid_state
>   for virtio live migration.
>
> - Use g_int_hash/g_int_equal instead of the default
>
> - Add scanout_blob function for virtio-gpu-virgl
>
> - Resolve the memory leak on virtio-gpu-virgl
>
> - Remove the unstable API flags check because virglrenderer is already 1.=
0
>
> - Squash the render server flag support into "Initialize Venus"
>
> Changes from V4 (virtio gpu V4) to V5
>
> - Inverted patch 5 and 6 because we should configure
>   HAVE_VIRGL_CONTEXT_INIT firstly.
>
> - Validate owner of memory region to avoid slowing down DMA.
>
> - Use memory_region_init_ram_ptr() instead of
>   memory_region_init_ram_device_ptr().
>
> - Adjust sequence to allocate gpu resource before virglrender resource
>   creation
>
> - Add virtio migration handling for uuid.
>
> - Send kernel patch to define VIRTIO_GPU_CAPSET_VENUS.
>   https://lore.kernel.org/lkml/20230915105918.3763061-1-ray.huang@amd.com=
/
>
> - Add meson check to make sure unstable APIs defined from 0.9.0.
>
> Changes from V1 to V2 (virtio gpu V4)
>
> - Remove unused #include "hw/virtio/virtio-iommu.h"
>
> - Add a local function, called virgl_resource_destroy(), that is used
>   to release a vgpu resource on error paths and in resource_unref.
>
> - Remove virtio_gpu_virgl_resource_unmap from
>   virtio_gpu_cleanup_mapping(),
>   since this function won't be called on blob resources and also because
>   blob resources are unmapped via virgl_cmd_resource_unmap_blob().
>
> - In virgl_cmd_resource_create_blob(), do proper cleanup in error paths
>   and move QTAILQ_INSERT_HEAD(&g->reslist, res, next) after the resource
>   has been fully initialized.
>
> - Memory region has a different life-cycle from virtio gpu resources
>   i.e. cannot be released synchronously along with the vgpu resource.
>   So, here the field "region" was changed to a pointer and is allocated
>   dynamically when the blob is mapped.
>   Also, since the pointer can be used to indicate whether the blob
>   is mapped, the explicite field "mapped" was removed.
>
> - In virgl_cmd_resource_map_blob(), add check on the value of
>   res->region, to prevent beeing called twice on the same resource.
>
> - Add a patch to enable automatic deallocation of memory regions to resol=
ve
>   use-after-free memory corruption with a reference.
>
>
> Antonio Caggiano (1):
>   virtio-gpu: Support Venus context
>
> Dmitry Osipenko (8):
>   virtio-gpu: Use trace events for tracking number of in-flight fences
>   virtio-gpu: Move fence_poll timer to VirtIOGPUGL
>   virtio-gpu: Move print_stats timer to VirtIOGPUGL
>   virtio-gpu: Handle virtio_gpu_virgl_init() failure
>   virtio-gpu: Unrealize GL device
>   virtio-gpu: Use pkgconfig version to decide which virgl features are
>     available
>   virtio-gpu: Don't require udmabuf when blobs and virgl are enabled
>   virtio-gpu: Support suspension of commands processing
>
> Huang Rui (2):
>   virtio-gpu: Support context-init feature with virglrenderer
>   virtio-gpu: Add virgl resource management
>
> Pierre-Eric Pelloux-Prayer (1):
>   virtio-gpu: Register capsets dynamically
>
> Robert Beckett (1):
>   virtio-gpu: Handle resource blob commands
>
>  docs/system/devices/virtio-gpu.rst |  11 +
>  hw/display/trace-events            |   3 +
>  hw/display/virtio-gpu-gl.c         |  62 ++-
>  hw/display/virtio-gpu-virgl.c      | 585 +++++++++++++++++++++++++++--
>  hw/display/virtio-gpu.c            |  44 ++-
>  include/hw/virtio/virtio-gpu.h     |  32 +-
>  meson.build                        |   5 +-
>  7 files changed, 685 insertions(+), 57 deletions(-)
>
> --
> 2.45.2
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000e8e945061c2d58cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>All R-b now, it looks go=
od to merge. Thanks for all the effort!=C2=A0</div><div><br></div><div>Mich=
ael, are you taking it through your tree?<br></div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jun 23, 2024 at =
7:23=E2=80=AFPM Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@colla=
bora.com">dmitry.osipenko@collabora.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
This series enables Vulkan Venus context support on virtio-gpu.<br>
<br>
All virglrender and almost all Linux kernel prerequisite changes<br>
needed by Venus are already in upstream. For kernel there is a pending<br>
KVM patchset that fixes mapping of compound pages needed for DRM drivers<br=
>
using TTM [1], othewrwise hostmem blob mapping will fail with a KVM error<b=
r>
from Qemu.<br>
<br>
[1] <a href=3D"https://lore.kernel.org/kvm/20240229025759.1187910-1-stevens=
d@google.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org=
/kvm/20240229025759.1187910-1-stevensd@google.com/</a><br>
<br>
You&#39;ll need to use recent Mesa version containing patch that removes<br=
>
dependency on cross-device feature from Venus that isn&#39;t supported by<b=
r>
Qemu [2].<br>
<br>
[2] <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/commit/087e9a96d1=
3155e26987befae78b6ccbb7ae242b" rel=3D"noreferrer" target=3D"_blank">https:=
//gitlab.freedesktop.org/mesa/mesa/-/commit/087e9a96d13155e26987befae78b6cc=
bb7ae242b</a><br>
<br>
Example Qemu cmdline that enables Venus:<br>
<br>
=C2=A0 qemu-system-x86_64 -device virtio-vga-gl,hostmem=3D4G,blob=3Dtrue,ve=
nus=3Dtrue \<br>
=C2=A0 =C2=A0 =C2=A0 -machine q35,accel=3Dkvm,memory-backend=3Dmem1 \<br>
=C2=A0 =C2=A0 =C2=A0 -object memory-backend-memfd,id=3Dmem1,size=3D8G -m 8G=
<br>
<br>
<br>
Changes from V15 to V16<br>
<br>
- Fixed resource_get_info() change made in v15 that was squshed into a<br>
=C2=A0 wrong patch. Squashed set_scanout_blob patch into the blob-commands =
patch,<br>
=C2=A0 otherwise we&#39;ll need to revert back ordering of blob patches to =
older v7<br>
=C2=A0 variant.<br>
<br>
- Changed hostmem mapping state to boolean, suggested by Akihiko Odaki.<br>
<br>
- Documented Venus in virtio-gpu doc. Amended &quot;Support Venus context&q=
uot; patch<br>
=C2=A0 with the doc addition. Suggested by Akihiko Odaki.<br>
<br>
Changes from V14 to V15<br>
<br>
- Dropped hostmem mapping state that got unused in v14, suggested by<br>
=C2=A0 Akihiko Odaki.<br>
<br>
- Moved resource_get_info() from set_scanout_blob() to create_blob(),<br>
=C2=A0 suggested by Akihiko Odaki.<br>
<br>
- Fixed unitilized variable in create_blob(), spotted by Alex Benn=C3=A9e.<=
br>
<br>
Changes from V13 to V14<br>
<br>
- Fixed erronous fall-through in renderer_state&#39;s switch-case that was<=
br>
=C2=A0 spotted by Marc-Andr=C3=A9 Lureau.<br>
<br>
- Reworked HOSTMEM_MR_FINISH_UNMAPPING handling as was suggested by<br>
=C2=A0 Akihiko Odaki. Now it shares the same code path with HOSTMEM_MR_MAPP=
ED.<br>
<br>
- Made use of g_autofree in virgl_cmd_resource_create_blob() as was<br>
=C2=A0 suggested by Akihiko Odaki.<br>
<br>
- Removed virtio_gpu_virgl_deinit() and moved all deinit code to<br>
=C2=A0 virtio_gpu_gl_device_unrealize() as was suggested by Marc-Andr=C3=A9=
 Lureau.<br>
<br>
- Replaced HAVE_FEATURE in mseon.build with virglrenderer&#39;s VERSION_MAJ=
OR<br>
=C2=A0 check as was suggested by Marc-Andr=C3=A9 Lureau.<br>
<br>
- Added trace event for cmd-suspension as was suggested by Marc-Andr=C3=A9 =
Lureau.<br>
<br>
- Added patch to replace in-flight printf&#39;s with trace events as was<br=
>
=C2=A0 suggested by Marc-Andr=C3=A9 Lureau<br>
<br>
Changes from V12 to V13<br>
<br>
- Replaced `res-&gt;async_unmap_in_progress` flag with a mapping state,<br>
=C2=A0 moved it to the virtio_gpu_virgl_hostmem_region like was suggested<b=
r>
=C2=A0 by Akihiko Odaki.<br>
<br>
- Renamed blob_unmap function and added back cmd_suspended argument<br>
=C2=A0 to it. Suggested by Akihiko Odaki.<br>
<br>
- Reordered VirtIOGPUGL refactoring patches to minimize code changes<br>
=C2=A0 like was suggested by Akihiko Odaki.<br>
<br>
- Replaced gl-&gt;renderer_inited with gl-&gt;renderer_state, like was sugg=
ested<br>
=C2=A0 by Alex Benn=C3=A9e.<br>
<br>
- Added gl-&gt;renderer state resetting to gl_device_unrealize(), for<br>
=C2=A0 consistency. Suggested by Alex Benn=C3=A9e.<br>
<br>
- Added rb&#39;s from Alex and Manos.<br>
<br>
- Fixed compiling with !HAVE_VIRGL_RESOURCE_BLOB.<br>
<br>
Changes from V11 to V12<br>
<br>
- Fixed virgl_cmd_resource_create_blob() error handling. Now it doesn&#39;t=
<br>
=C2=A0 corrupt resource list and releases resource properly on error. Thank=
s<br>
=C2=A0 to Akihiko Odaki for spotting the bug.<br>
<br>
- Added new patch that handles virtio_gpu_virgl_init() failure gracefully,<=
br>
=C2=A0 fixing Qemu crash. Besides fixing the crash, it allows to implement<=
br>
=C2=A0 a cleaner virtio_gpu_virgl_deinit().<br>
<br>
- virtio_gpu_virgl_deinit() now assumes that previously virgl was<br>
=C2=A0 initialized successfully when it was inited at all. Suggested by<br>
=C2=A0 Akihiko Odaki.<br>
<br>
- Fixed missed freeing of print_stats timer in virtio_gpu_virgl_deinit()<br=
>
<br>
- Added back blob unmapping or RESOURCE_UNREF that was requested<br>
=C2=A0 by Akihiko Odaki. Added comment to the code explaining how<br>
=C2=A0 async unmapping works. Added back `res-&gt;async_unmap_in_progress`<=
br>
=C2=A0 flag and added comment telling why it&#39;s needed.<br>
<br>
- Moved cmdq_resume_bh to VirtIOGPUGL and made coding style changes<br>
=C2=A0 suggested by Akihiko Odaki.<br>
<br>
- Added patches that move fence_poll and print_stats timers to VirtIOGPUGL<=
br>
=C2=A0 for consistency with cmdq_resume_bh.<br>
<br>
Changes from V10 to V11<br>
<br>
- Replaced cmd_resume bool in struct ctrl_command with<br>
=C2=A0 &quot;cmd-&gt;finished + !VIRTIO_GPU_FLAG_FENCE&quot; checking as wa=
s requested<br>
=C2=A0 by Akihiko Odaki.<br>
<br>
- Reworked virgl_cmd_resource_unmap/unref_blob() to avoid re-adding<br>
=C2=A0 the &#39;async_unmap_in_progress&#39; flag that was dropped in v9:<b=
r>
<br>
=C2=A0 =C2=A0 1. virgl_cmd_resource_[un]map_blob() now doesn&#39;t check it=
self whether<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0resource was previously mapped and lets virglren=
derer to do the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0checking.<br>
<br>
=C2=A0 =C2=A0 2. error returned by virgl_renderer_resource_unmap() is now h=
andled<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0and reported properly, previously the error wasn=
&#39;t checked. The<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0virgl_renderer_resource_unmap() fails if resourc=
e wasn&#39;t mapped.<br>
<br>
=C2=A0 =C2=A0 3. virgl_cmd_resource_unref_blob() now doesn&#39;t allow to u=
nref resource<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0that is mapped, it&#39;s a error condition if gu=
est didn&#39;t unmap resource<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0before doing the unref. Previously unref was imp=
licitly unmapping<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0resource.<br>
<br>
Changes from V9 to V10<br>
<br>
- Dropped &#39;async_unmap_in_progress&#39; variable and switched to use<br=
>
=C2=A0 aio_bh_new() isntead of oneshot variant in the &quot;blob commands&q=
uot; patch.<br>
<br>
- Further improved error messages by printing error code when actual error<=
br>
=C2=A0 occurrs and using ERR_UNSPEC instead of ERR_ENOMEM when we don&#39;t=
 really<br>
=C2=A0 know if it was ENOMEM for sure.<br>
<br>
- Added vdc-&gt;unrealize for the virtio GL device and freed virgl data.<br=
>
<br>
- Dropped UUID and doc/migration patches. UUID feature isn&#39;t needed<br>
=C2=A0 anymore, instead we changed Mesa Venus driver to not require UUID.<b=
r>
<br>
- Renamed virtio-gpu-gl &quot;vulkan&quot; property name back to &quot;venu=
s&quot;.<br>
<br>
Changes from V8 to V9<br>
<br>
- Added resuming of cmdq processing when hostmem MR is freed,<br>
=C2=A0 as was suggested by Akihiko Odaki.<br>
<br>
- Added more error messages, suggested by Akihiko Odaki<br>
<br>
- Dropped superfluous &#39;res-&gt;async_unmap_completed&#39;, suggested<br=
>
=C2=A0 by Akihiko Odaki.<br>
<br>
- Kept using cmd-&gt;suspended flag. Akihiko Odaki suggested to make<br>
=C2=A0 virtio_gpu_virgl_process_cmd() return false if cmd processing is<br>
=C2=A0 suspended, but it&#39;s not easy to implement due to ubiquitous<br>
=C2=A0 VIRTIO_GPU_FILL_CMD() macros that returns void, requiring to change<=
br>
=C2=A0 all the virtio-gpu processing code.<br>
<br>
- Added back virtio_gpu_virgl_resource as was requested by Akihiko Odaki,<b=
r>
=C2=A0 though I&#39;m not convinced it&#39;s really needed.<br>
<br>
- Switched to use GArray, renamed capset2_max_ver/size vars and moved<br>
=C2=A0 &quot;vulkan&quot; property definition to the virtio-gpu-gl device i=
n the Venus<br>
=C2=A0 patch, like was suggested by Akihiko Odaki.<br>
<br>
- Moved UUID to virtio_gpu_virgl_resource and dropped UUID save/restore<br>
=C2=A0 since it will require bumping VM version and virgl device isn&#39;t =
miratable<br>
=C2=A0 anyways.<br>
<br>
- Fixed exposing UUID feature with Rutabaga<br>
<br>
- Dropped linux-headers update patch because headers were already updated<b=
r>
=C2=A0 in Qemu/staging.<br>
<br>
- Added patch that updates virtio migration doc with a note about virtio-gp=
u<br>
=C2=A0 migration specifics, suggested by Akihiko Odaki.<br>
<br>
- Addressed coding style issue noticed by Akihiko Odaki<br>
<br>
Changes from V7 to V8<br>
<br>
- Supported suspension of virtio-gpu commands processing and made<br>
=C2=A0 unmapping of hostmem region asynchronous by blocking/suspending<br>
=C2=A0 cmd processing until region is unmapped. Suggested by Akihiko Odaki.=
<br>
<br>
- Fixed arm64 building of x86 targets using updated linux-headers.<br>
=C2=A0 Corrected the update script. Thanks to Rob Clark for reporting<br>
=C2=A0 the issue.<br>
<br>
- Added new patch that makes registration of virgl capsets dynamic.<br>
=C2=A0 Requested by Antonio Caggiano and Pierre-Eric Pelloux-Prayer.<br>
<br>
- Venus capset now isn&#39;t advertised if Vulkan is disabled with vulkan=
=3Dfalse<br>
<br>
Changes from V6 to V7<br>
<br>
- Used scripts/update-linux-headers.sh to update Qemu headers based<br>
=C2=A0 on Linux v6.8-rc3 that adds Venus capset definition to virtio-gpu<br=
>
=C2=A0 protocol, was requested by Peter Maydel<br>
<br>
- Added r-bs that were given to v6 patches. Corrected missing s-o-bs<br>
<br>
- Dropped context_init Qemu&#39;s virtio-gpu device configuration flag,<br>
=C2=A0 was suggested by Marc-Andr=C3=A9 Lureau<br>
<br>
- Added missing error condition checks spotted by Marc-Andr=C3=A9 Lureau<br=
>
=C2=A0 and Akihiko Odaki, and few more<br>
<br>
- Returned back res-&gt;mr referencing to memory_region_init_ram_ptr() like=
<br>
=C2=A0 was suggested by Akihiko Odaki. Incorporated fix suggested by Pierre=
-Eric<br>
=C2=A0 to specify the MR name<br>
<br>
- Dropped the virgl_gpu_resource wrapper, cleaned up and simplified<br>
=C2=A0 patch that adds blob-cmd support<br>
<br>
- Fixed improper blob resource removal from resource list on resource_unref=
<br>
=C2=A0 that was spotted by Akihiko Odaki<br>
<br>
- Change order of the blob patches, was suggested by Akihiko Odaki.<br>
=C2=A0 The cmd_set_scanout_blob support is enabled first<br>
<br>
- Factored out patch that adds resource management support to virtio-gpu-gl=
,<br>
=C2=A0 was requested by Marc-Andr=C3=A9 Lureau<br>
<br>
- Simplified and improved the UUID support patch, dropped the hash table<br=
>
=C2=A0 as we don&#39;t need it for now. Moved QemuUUID to virtio_gpu_simple=
_resource.<br>
=C2=A0 This all was suggested by Akihiko Odaki and Marc-Andr=C3=A9 Lureau<b=
r>
<br>
- Dropped console_has_gl() check, suggested by Akihiko Odaki<br>
<br>
- Reworked Meson cheking of libvirglrender features, made new features<br>
=C2=A0 available based on virglrender pkgconfig version instead of checking=
<br>
=C2=A0 symbols in header. This should fix build error using older virglrend=
er<br>
=C2=A0 version, reported by Alex Benn=C3=A9e<br>
<br>
- Made enabling of Venus context configrable via new virtio-gpu device<br>
=C2=A0 &quot;vulkan=3Dtrue&quot; flag, suggested by Marc-Andr=C3=A9 Lureau.=
 The flag is disabled<br>
=C2=A0 by default because it requires blob and hostmem options to be enable=
d<br>
=C2=A0 and configured<br>
<br>
Changes from V5 to V6<br>
<br>
- Move macros configurations under virgl.found() and rename<br>
=C2=A0 HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS.<br>
<br>
- Handle the case while context_init is disabled.<br>
<br>
- Enable context_init by default.<br>
<br>
- Move virtio_gpu_virgl_resource_unmap() into<br>
=C2=A0 virgl_cmd_resource_unmap_blob().<br>
<br>
- Introduce new struct virgl_gpu_resource to store virgl specific members.<=
br>
<br>
- Remove erro handling of g_new0, because glib will abort() on OOM.<br>
<br>
- Set resource uuid as option.<br>
<br>
- Implement optional subsection of vmstate_virtio_gpu_resource_uuid_state<b=
r>
=C2=A0 for virtio live migration.<br>
<br>
- Use g_int_hash/g_int_equal instead of the default<br>
<br>
- Add scanout_blob function for virtio-gpu-virgl<br>
<br>
- Resolve the memory leak on virtio-gpu-virgl<br>
<br>
- Remove the unstable API flags check because virglrenderer is already 1.0<=
br>
<br>
- Squash the render server flag support into &quot;Initialize Venus&quot;<b=
r>
<br>
Changes from V4 (virtio gpu V4) to V5<br>
<br>
- Inverted patch 5 and 6 because we should configure<br>
=C2=A0 HAVE_VIRGL_CONTEXT_INIT firstly.<br>
<br>
- Validate owner of memory region to avoid slowing down DMA.<br>
<br>
- Use memory_region_init_ram_ptr() instead of<br>
=C2=A0 memory_region_init_ram_device_ptr().<br>
<br>
- Adjust sequence to allocate gpu resource before virglrender resource<br>
=C2=A0 creation<br>
<br>
- Add virtio migration handling for uuid.<br>
<br>
- Send kernel patch to define VIRTIO_GPU_CAPSET_VENUS.<br>
=C2=A0 <a href=3D"https://lore.kernel.org/lkml/20230915105918.3763061-1-ray=
.huang@amd.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.o=
rg/lkml/20230915105918.3763061-1-ray.huang@amd.com/</a><br>
<br>
- Add meson check to make sure unstable APIs defined from 0.9.0.<br>
<br>
Changes from V1 to V2 (virtio gpu V4)<br>
<br>
- Remove unused #include &quot;hw/virtio/virtio-iommu.h&quot;<br>
<br>
- Add a local function, called virgl_resource_destroy(), that is used<br>
=C2=A0 to release a vgpu resource on error paths and in resource_unref.<br>
<br>
- Remove virtio_gpu_virgl_resource_unmap from<br>
=C2=A0 virtio_gpu_cleanup_mapping(),<br>
=C2=A0 since this function won&#39;t be called on blob resources and also b=
ecause<br>
=C2=A0 blob resources are unmapped via virgl_cmd_resource_unmap_blob().<br>
<br>
- In virgl_cmd_resource_create_blob(), do proper cleanup in error paths<br>
=C2=A0 and move QTAILQ_INSERT_HEAD(&amp;g-&gt;reslist, res, next) after the=
 resource<br>
=C2=A0 has been fully initialized.<br>
<br>
- Memory region has a different life-cycle from virtio gpu resources<br>
=C2=A0 i.e. cannot be released synchronously along with the vgpu resource.<=
br>
=C2=A0 So, here the field &quot;region&quot; was changed to a pointer and i=
s allocated<br>
=C2=A0 dynamically when the blob is mapped.<br>
=C2=A0 Also, since the pointer can be used to indicate whether the blob<br>
=C2=A0 is mapped, the explicite field &quot;mapped&quot; was removed.<br>
<br>
- In virgl_cmd_resource_map_blob(), add check on the value of<br>
=C2=A0 res-&gt;region, to prevent beeing called twice on the same resource.=
<br>
<br>
- Add a patch to enable automatic deallocation of memory regions to resolve=
<br>
=C2=A0 use-after-free memory corruption with a reference.<br>
<br>
<br>
Antonio Caggiano (1):<br>
=C2=A0 virtio-gpu: Support Venus context<br>
<br>
Dmitry Osipenko (8):<br>
=C2=A0 virtio-gpu: Use trace events for tracking number of in-flight fences=
<br>
=C2=A0 virtio-gpu: Move fence_poll timer to VirtIOGPUGL<br>
=C2=A0 virtio-gpu: Move print_stats timer to VirtIOGPUGL<br>
=C2=A0 virtio-gpu: Handle virtio_gpu_virgl_init() failure<br>
=C2=A0 virtio-gpu: Unrealize GL device<br>
=C2=A0 virtio-gpu: Use pkgconfig version to decide which virgl features are=
<br>
=C2=A0 =C2=A0 available<br>
=C2=A0 virtio-gpu: Don&#39;t require udmabuf when blobs and virgl are enabl=
ed<br>
=C2=A0 virtio-gpu: Support suspension of commands processing<br>
<br>
Huang Rui (2):<br>
=C2=A0 virtio-gpu: Support context-init feature with virglrenderer<br>
=C2=A0 virtio-gpu: Add virgl resource management<br>
<br>
Pierre-Eric Pelloux-Prayer (1):<br>
=C2=A0 virtio-gpu: Register capsets dynamically<br>
<br>
Robert Beckett (1):<br>
=C2=A0 virtio-gpu: Handle resource blob commands<br>
<br>
=C2=A0docs/system/devices/virtio-gpu.rst |=C2=A0 11 +<br>
=C2=A0hw/display/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A03 +<br>
=C2=A0hw/display/virtio-gpu-gl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6=
2 ++-<br>
=C2=A0hw/display/virtio-gpu-virgl.c=C2=A0 =C2=A0 =C2=A0 | 585 +++++++++++++=
++++++++++++++--<br>
=C2=A0hw/display/virtio-gpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 44 ++-<br>
=C2=A0include/hw/virtio/virtio-gpu.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 32 +-<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +-<br>
=C2=A07 files changed, 685 insertions(+), 57 deletions(-)<br>
<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div>

--000000000000e8e945061c2d58cb--

