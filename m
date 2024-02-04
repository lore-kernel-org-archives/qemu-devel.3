Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E7CC4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 11:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWabH-0003MX-2V; Sun, 04 Feb 2024 06:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rWabG-0003MP-4W
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 06:23:50 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rWabD-0001ay-VD
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 06:23:49 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a29c4bbb2f4so419399666b.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 03:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707045824; x=1707650624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XAzhxia15MyifFcUesFnIF2tMUrPWbbXk2pNUaEBE6A=;
 b=uoC9KDVVlL47B7bkHqhGTUYTo7aOXXQVOvPEii2IZD9v0dUc5okf4OTgr2++1zd5rG
 cWJN9urT1hO6xm7fNmD8X/JPjwFJdFsY9cmUFQAoKSVnDJh81zj44Ny/k9uEcNamoNKD
 TscLdDilRxkCJMPguY6JzTkv4R8e1YMgf7czY8re9Q+TQ/M4qAg3pKHuFLECrSxt/Sbs
 RIhx/J3U1SMR0kljmkcVyKeOLHdS5dBJhRhGsXrlpkIDLtgM19PIy5ZAnk1Ofgk1ww/1
 krw9sBfSClNprfLtpfJEoxpBKzyBrTf+xGZ/yb+D/netsr8cW/OdxCnVMxO7LzCn81pV
 JqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707045824; x=1707650624;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XAzhxia15MyifFcUesFnIF2tMUrPWbbXk2pNUaEBE6A=;
 b=jw3bPI/KJa8XQCGpMHpUnKgnsBVgCV1NGbnfYOfjoeBuox6PEhivRI0LKFQSjZBDxs
 Xo8ox6fvCqOxStEohDDt7CbZUh4MErzdUVgDab+vEVN+QoZjNxJS1U6AlBIS99lasWnu
 TcxxQj2DFlDhZnmbptDpJTFHA1gY/kT6eRx8SN41tJB0dwrtE7qkiUxyHs9xfXBPEwgh
 bzheXKSbTY2x+0siDDo4zg4HWOg1WwyA/yDdH8ymUayxD/mYmhfHur3146DawiEnyk/B
 wYh6RB7qdzT22CVZZM64L+F6b8MftnbhN8Mtyio96hxshiJzbP3SW7poI8cTu2KEnSUF
 kehg==
X-Gm-Message-State: AOJu0Yz2inwNjkWbeLH4mOif7SHexm37eB8LQxB4CJK0QWppXeg+icYr
 ckK5qnpWWAMb0gzbaodYNjpSiRLjo2ZTVnYtGHhxtDJsXVt2vsgRqIGFGHkpUfk=
X-Google-Smtp-Source: AGHT+IExkfe4knfhoX2f1YyYfljPhvhxCihuCVWmyveVBxLIQLbWrs7up4j3kH613M7IuKz1yAyZVw==
X-Received: by 2002:a17:907:7751:b0:a36:f811:424 with SMTP id
 kx17-20020a170907775100b00a36f8110424mr4852896ejc.3.1707045824580; 
 Sun, 04 Feb 2024 03:23:44 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXM77zbbh8zAf8XY6YRFGYlE49VnWTb/UQ2Q+QkNIYlYauJ/3XzcFdIhIP9JYx8VDniYdZRfuH1e6l78ygnURFOXFb1BMobw7RDjrAeJG69uE7WlAa3SSFZ9zUqniXljDPUR5TYWT9Kok4//N/ocTxCEbgF570WBiDEPKR8EutVyZzVaavRWRu0xPgKyXNnx0mypewafLC1gY6/IheEUuKN7Lq9Zk1BKV6WRKMNxIZrRDnA66TOb7zuwA8SN3EpiPE+dpWQ70pGsk7AMUazgrNHaqD6nTuP4rJM/7ubVcbLLsZ+fQ3luBNbYdw=
Received: from meli.delivery (adsl-245.37.6.163.tellas.gr. [37.6.163.245])
 by smtp.gmail.com with ESMTPSA id
 ti8-20020a170907c20800b00a3617097f49sm3034004ejc.101.2024.02.04.03.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 03:23:44 -0800 (PST)
Date: Sun, 04 Feb 2024 13:18:45 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 virglrenderer-devel-request@lists.freedesktop.org,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Huang Rui <ray.huang@amd.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: Help understanding allocation and mapping flow of virtio-gpu 3D
 resource blobs
User-Agent: meli 0.8.5-rc.3
References: <87r0hso5ds.fsf@draig.linaro.org>
In-Reply-To: <87r0hso5ds.fsf@draig.linaro.org>
Message-ID: <8bwzh.953cen69a73r@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Good morning Alex,

Just one observation,

On Sun, 04 Feb 2024 13:06, Alex Bennée <alex.bennee@linaro.org> wrote:
>Hi,
>
>I'm trying to get an understanding of the blob allocation and mapping
>flow for virtio-gpu for Vulkan and Rutabaga. Having gotten all the
>various libraries setup I'm still seeing failures when running a TCG
>guest (buildroot + latest glm, mesa, vkmark) with:
>
>  ./qemu-system-aarch64 \
>             -M virt -cpu cortex-a76 \
>             -m 8192 \
>             -object memory-backend-memfd,id=mem,size=8G,share=on \
>             -serial mon:stdio \
>             -kernel ~/lsrc/linux.git/builds/arm64.initramfs/arch/arm64/boot/Image \
>             -append "console=ttyAMA0" \
>             -device virtio-gpu-gl,context_init=true,blob=true,hostmem=4G \
>             -display sdl,gl=on -d guest_errors,trace:virtio_gpu_cmd_res\*,trace:virtio_gpu_virgl_process_command -D debug.log
>
>which shows up as detected in dmesg but not to vulkaninfo:
>
>  [    0.644879] virtio-pci 0000:00:01.0: enabling device (0000 -> 0003)
>  [    0.648643] virtio-pci 0000:00:02.0: enabling device (0000 -> 0002)
>  [    0.672391] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>  [    0.678071] Serial: AMBA driver
>  [    0.682122] [drm] pci: virtio-gpu-pci detected at 0000:00:02.0
>  [    0.683249] [drm] Host memory window: 0x8000000000 +0x100000000
>  [    0.683420] [drm] features: +virgl +edid +resource_blob +host_visible
>  [    0.683470] [drm] features: +context_init
>  [    0.695695] [drm] number of scanouts: 1
>  [    0.695837] [drm] number of cap sets: 3
>  [    0.716173] [drm] cap set 0: id 1, max-version 1, max-size 308
>  [    0.716499] [drm] cap set 1: id 2, max-version 2, max-size 1384
>  [    0.716686] [drm] cap set 2: id 4, max-version 0, max-size 160
>  [    0.726001] [drm] Initialized virtio_gpu 0.1.0 0 for 0000:00:02.0 on minor 0
>  virgl_resource_create: err=0, res=2
>  virgl_renderer_resource_attach_iov: 0x55b843c17a80/2
>  virgl_resource_attach_iov: pipe_resource: 0x55b8434da8f0
>  vrend_pipe_resource_attach_iov: 0x43
>
>  ...
>
>  # vulkaninfo --summary
>  WARNING: [Loader Message] Code 0 : terminator_CreateInstance: Failed to CreateInstance in ICD 1.  Skipping ICD.

a common problem I have when testing different mesa builds is not 
declaring the intended driver each time. I could be getting errors like 
yours but if I set the VK_ICD_FILENAMES env var to the correct driver 
manifest (the installed icd.d/virtio-*.json file from my mesa build) the 
device is properly recognized. Might be unrelated to this error, but 
still it helps to define it explicitly each time.



>  error: XDG_RUNTIME_DIR is invalid or not set in the environment.
>  ==========
>  VULKANINFO
>  ==========
>
>  Vulkan Instance Version: 1.3.262
>
>
>  Instance Extensions: count = 12
>  -------------------------------
>  VK_EXT_debug_report                    : extension revision 10
>  VK_EXT_debug_utils                     : extension revision 2
>  VK_KHR_device_group_creation           : extension revision 1
>  VK_KHR_external_fence_capabilities     : extension revision 1
>  VK_KHR_external_memory_capabilities    : extension revision 1
>  VK_KHR_external_semaphore_capabilities : extension revision 1
>  VK_KHR_get_physical_device_properties2 : extension revision 2
>  VK_KHR_get_surface_capabilities2       : extension revision 1
>  VK_KHR_portability_enumeration         : extension revision 1
>  VK_KHR_surface                         : extension revision 25
>  VK_KHR_surface_protected_capabilities  : extension revision 1
>  VK_LUNARG_direct_driver_loading        : extension revision 1
>
>  Instance Layers:
>  ----------------
>
>  Devices:
>  ========
>  GPU0:
>          apiVersion         = 1.3.267
>          driverVersion      = 0.0.1
>          vendorID           = 0x10005
>          deviceID           = 0x0000
>          deviceType         = PHYSICAL_DEVICE_TYPE_CPU
>          deviceName         = llvmpipe (LLVM 15.0.3, 128 bits)
>          driverID           = DRIVER_ID_MESA_LLVMPIPE
>          driverName         = llvmpipe
>          driverInfo         = Mesa 23.3.2 (LLVM 15.0.3)
>          conformanceVersion = 1.3.1.1
>          deviceUUID         = 6d657361-3233-2e33-2e32-000000000000
>          driverUUID         = 6c6c766d-7069-7065-5555-494400000000
>
>With an older and more hacked up set of the blob patches I can get
>vulkaninfo to work but I see multiple GPUs and vkmark falls over when
>mapping stuff:
>
>  # vulkaninfo --summary
>  render_state_create_resource: res_id = 5
>  vkr_context_add_resource: res_id = 5
>  vkr_context_import_resource_internal: res_id = 5
>  virgl_resource_create: err=0, res=5
>  render_state_create_resource: res_id = 6
>  vkr_context_add_resource: res_id = 6
>  vkr_context_import_resource_internal: res_id = 6
>  virgl_resource_create: err=0, res=6
>  error: XDG_RUNTIME_DIR is invalid or not set in the environment.
>  ==========
>  VULKANINFO
>  ==========
>
>  Vulkan Instance Version: 1.3.262
>
>
>  Instance Extensions: count = 12
>  -------------------------------
>  VK_EXT_debug_report                    : extension revision 10
>  VK_EXT_debug_utils                     : extension revision 2
>  VK_KHR_device_group_creation           : extension revision 1
>  VK_KHR_external_fence_capabilities     : extension revision 1
>  VK_KHR_external_memory_capabilities    : extension revision 1
>  VK_KHR_external_semaphore_capabilities : extension revision 1
>  VK_KHR_get_physical_device_properties2 : extension revision 2
>  VK_KHR_get_surface_capabilities2       : extension revision 1
>  VK_KHR_portability_enumeration         : extension revision 1
>  VK_KHR_surface                         : extension revision 25
>  VK_KHR_surface_protected_capabilities  : extension revision 1
>  VK_LUNARG_direct_driver_loading        : extension revision 1
>  VK_LUNARG_direct_driver_loading        : extension revision 1                                                                                                        [0/7869]
>
>  Instance Layers:
>  ----------------
>
>  Devices:
>  ========
>  GPU0:
>          apiVersion         = 1.3.230
>          driverVersion      = 23.3.4
>          vendorID           = 0x8086
>          deviceID           = 0xa780
>          deviceType         = PHYSICAL_DEVICE_TYPE_INTEGRATED_GPU
>          deviceName         = Virtio-GPU Venus (Intel(R) Graphics (RPL-S))
>          driverID           = DRIVER_ID_MESA_VENUS
>          driverName         = venus
>          driverInfo         = Mesa 23.3.4
>          conformanceVersion = 1.3.0.0
>          deviceUUID         = 29d2e940-a1a0-3054-0f9a-9f7dec52a084
>          driverUUID         = b11fafe9-8706-9ab8-0f16-8b272cf893ca
>  GPU1:
>          apiVersion         = 1.2.0
>          driverVersion      = 23.3.4
>          vendorID           = 0x10005
>          deviceID           = 0x0000
>          deviceType         = PHYSICAL_DEVICE_TYPE_CPU
>          deviceName         = Virtio-GPU Venus (llvmpipe (LLVM 15.0.6, 256 bits))
>          driverID           = DRIVER_ID_MESA_VENUS
>          driverName         = venus
>          driverInfo         = Mesa 23.3.4
>          conformanceVersion = 1.3.0.0
>          deviceUUID         = 5fb5c03f-c537-f0fe-a7e6-9cd5866acb8d
>          driverUUID         = b11fafe9-8706-9ab8-0f16-8b272cf893ca
>  GPU2:
>          apiVersion         = 1.3.267
>          driverVersion      = 0.0.1
>          vendorID           = 0x10005
>          deviceID           = 0x0000
>          deviceType         = PHYSICAL_DEVICE_TYPE_CPU
>          deviceName         = llvmpipe (LLVM 15.0.3, 128 bits)
>          driverID           = DRIVER_ID_MESA_LLVMPIPE
>          driverName         = llvmpipe
>          driverInfo         = Mesa 23.3.2 (LLVM 15.0.3)
>          conformanceVersion = 1.3.1.1
>          deviceUUID         = 6d657361-3233-2e33-2e32-000000000000
>          driverUUID         = 6c6c766d-7069-7065-5555-494400000000
>  render_state_destroy_resource: res_id = 5
>  vkr_context_remove_resource: res_id = 5
>  virgl_resource_destroy_func: res=5
>  render_state_destroy_resource: res_id = 6
>  vkr_context_remove_resource: res_id = 6
>  virgl_resource_destroy_func: res=6
>
>running vkmark gives:
>
>  # vkmark --winsys kms
>  render_state_create_resource: res_id = 7
>  vkr_context_add_resource: res_id = 7
>  vkr_context_import_resource_internal: res_id = 7
>  virgl_resource_create: err=0, res=7
>  render_state_create_resource: res_id = 8
>  vkr_context_add_resource: res_id = 8
>  vkr_context_import_resource_internal: res_id = 8
>  virgl_resource_create: err=0, res=8
>  virgl_resource_create: err=0, res=9
>  virgl_renderer_resource_attach_iov: 0x55615acf7f40/9
>  virgl_resource_attach_iov: pipe_resource: 0x55615acf7db0
>  vrend_pipe_resource_attach_iov: 0x43
>
>this bit does nothing as VREND_STORAGE_HOST_SYSTEM_MEMORY isn't set.
>
>  virgl_resource_create: err=0, res=10
>  virgl_renderer_resource_attach_iov: 0x55615ae569a0/10
>  virgl_resource_attach_iov: pipe_resource: 0x55615a99ce20
>  vrend_pipe_resource_attach_iov: 0x43
>  Warning: KMSWindowSystem: Using VK_IMAGE_TILING_OPTIMAL for dmabuf with invalid modifier, but this is not guaranteed to work.
>  vkr_dispatch_vkAllocateMemory: mem_index_type:0
>  virgl_render_server[2889817]: vkr: failed to import resource: invalid res_id 9
>  virgl_render_server[2889817]: vkr: vkAllocateMemory resulted in CS error
>  virgl_render_server[2889817]: vkr: ring_submit_cmd: vn_dispatch_command failed
>  MESA-VIRTIO: debug: vn_ring_submit abort on fatal
>  render_state_destroy_resource: res_id = 7
>  vkr_context_remove_resource: res_id = 7
>  render_state_destroy_resource: res_id = 8
>  vkr_context_remove_resource: res_id = 8
>  virgl_resource_destroy_func: res=7
>  virgl_resource_destroy_func: res=8
>  virgl_resource_destroy_func: res=10
>  virgl_resource_destroy_func: res=9
>  Aborted
>
>The debug printfs are throughout QEMU and virlgrenderer while trying to
>work out what was going on. While the eventual aim is to enable this
>stack on a ARM64 platform with Xen I wanted to make sure I understand
>the blob resource flow first.
>
>As I understand it we need resource blobs to hold 3D data for rendering
>that is visible to the underlying GPU that will be doing the work. While
>these blobs can be copied back and forth the most efficient way to do
>this is to allocate HOST VISIBLE blobs that are appropriately placed
>and aligned for the host GPU. For Vulkan there will also be the command
>stream which will need to be translated from the Vulkan's portable
>shader IR (as emitted by mesa on the guest) to the underlying shader
>commands on the host system (via mesa on the host).
>
>I can see the host visible region is created as a large chunk of the PCI
>BAR space and is outside of the guests system RAM.
>
>The guest creates a unique resource ID by submitting a
>VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB command.
>
>Q1: is the actual allocation done here? I assume this happens somewhere
>in the depths of virglrenderer or is it the kernel DRM subsystem?
>
>Q2: should the memory for this resource be visible to the host
>userspace at this point? Where is the mapping into userspace done?
>
>The guest submits a VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB command with a
>unique resource ID and requests it is mapped at an offset into the host
>visible memory region.
>
>Q3: Is all the mapping for host and guest handled by QEMU's memory_region
>code?
>
>Q4: Are there any differences between cards with VRAM and those with a
>unified memory architecture (e.g. using system RAM)?
>
>Finally should we expect to see any other resources
>(RESOURCE_CREATE_2D/3D, TRANSFER_TO_HOST, ATTACH_BACKING) if we have
>host visible blobs properly allocated and working?
>
>--
>Alex Bennée
>Virtualisation Tech Lead @ Linaro

