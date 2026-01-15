Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04035D4114C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 09:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgJlX-0001wz-9M; Thu, 15 Jan 2026 04:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgJlR-0001w5-JO
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 04:35:38 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgJlL-0001kP-Qy
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 04:35:36 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60F9YBr7013094
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 15 Jan 2026 18:35:10 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=EGBoJmCFq8ZUlxpc4vEa+w/XvMghTLmbO+B0Ln4E/0E=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1768469711; v=1;
 b=nUEkg7fmjXWYEoUzdic6IdPq/FvonTIHBXumlGItCxKjcY5BsSQAPP6fl+YLpcIm
 HujshcXdm3gwY9pmeIZ0CbHirf3RbsXOSDatfo/fA6jtVuoVisgZ+vLNp6LM2YLE
 MMrq7qxYbBkNO2GzN+kZsNybkvvaJ94JCUK+yxW5Yjs+2YLS2D79z8UqvoZ8IWg+
 v5QhlMmYme45W/iNL7FkZgpyhBWESODMulnkbAo2GoT2EXePWllDtt948pjOd/ks
 LcJS0iliCxSZCu0eW7Htv/RS0zJXRCDJhxWB6NEVCapicjhBl1Ov8dsXKvYKMUqO
 Uv9HCqAaonl9cv49nQmA/Q==
Message-ID: <71358c60-7048-4bf1-8b4d-81c1a958780a@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 15 Jan 2026 18:34:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] virtio-gpu: Add userptr support and ROCm
 capability enhancements
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 dmitry.osipenko@collabora.com, Ray.Huang@amd.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20260115082739.174224-1-honghuan@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260115082739.174224-1-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/01/15 17:27, Honglei Huang wrote:
> This patch series introduces enhancements to virtio-gpu to improve
> memory management and GPU virtualization capabilities for ROCm (Radeon Open Compute)
> workloads.
> 
> Usage example:
>    -device virtio-gpu-gl,rocm=on
> 
> The series includes:
> 
> 1. Linux header updates for userptr support: Synchronizes virtio-gpu headers
>     with upstream kernel changes, adding VIRTIO_GPU_F_RESOURCE_USERPTR feature
>     flag and VIRTIO_GPU_BLOB_FLAG_USE_USERPTR blob flag support. This enables
>     user pointer mapping for blob resources, allowing guest applications to use
>     user-allocated memory for GPU resources more efficiently.
> 
> 2. Removal of nr_entries limit: Removes the artificial 16384 entry limit in
>     virtio_gpu_create_mapping_iov() to align with kernel driver behavior and
>     support legitimate large scatter-gather operations.
> 
> 3. Linux header updates for ROCm capability: Synchronizes headers to add
>     VIRTIO_GPU_CAPSET_ROCM capability set definition.
> 
> 4. ROCm capability support: Adds native support for AMD's ROCm (Radeon Open
>     Compute) platform through a new "rocm=on" device property and capability.
>     This enables GPU compute workloads using the ROCm stack through virtio-gpu.
> 
> Changes in v5:
> - Split userptr header updates into dedicated patch (patch 1/4)
> - Extracted nr_entries limit removal into standalone commit (patch 2/4)
> - Split ROCm header updates into dedicated patch (patch 3/4)
> - Removed VIRTIO_GPU_F_RESOURCE_USERPTR feature decectiontion
> - Keep ROCm capability support with "rocm=on" device property (patch 4/4)
> - Change corresponding commit messages, change corresponding cover letter content
> - Remove RFC label

It is too early to drop the RFC labell. The following should happen 
before dropping the RFC label:
- The Linux header change land in some maintainer's tree.
- The Linux headers with scripts/update-linux-headers.sh is updated
   using the tree.
- The virglrenderer change lands the upstream.
- A proper virglrenderer feature detection with a version number that is
   expected to have the change.

So the QEMU change will land the last. The patches can still be reviewed 
in the RFC state to ensure that the series will be quickly pulled when 
ready.

Regards,
Akihiko Odaki

> 
> Changes in v4:
> - Change this series to RFC
> - Renamed HSAKMT-related functionality to ROCm for better clarity and
>    alignment with the ROCm ecosystem terminology
> - Changed device property from "hsakmt=on" to "rocm=on"
> - Changed flag from VIRTIO_GPU_FLAG_HSAKMT_ENABLED to
>    VIRTIO_GPU_FLAG_ROCM_ENABLED
> - Changed renderer flag from VIRGL_RENDER_USE_HSAKMT to
>    VIRGL_RENDERER_USE_ROCM
> - Updated capset handling to use VIRTIO_GPU_CAPSET_ROCM (8) instead of
>    VIRTIO_GPU_CAPSET_HSAKMT (8)
> - Removed the error handling fix from patch 1 (virtio-gpu-virgl.c) into
>    another thread
> 
> Changes in v3:
> - Renamed HSAKMT-related functionality to ROCm for better clarity and
>    alignment with the ROCm ecosystem terminology
> - Changed device property from "hsakmt=on" to "rocm=on"
> - Changed flag from VIRTIO_GPU_FLAG_HSAKMT_ENABLED to
>    VIRTIO_GPU_FLAG_ROCM_ENABLED
> - Changed renderer flag from VIRGL_RENDER_USE_HSAKMT to
>    VIRGL_RENDERER_USE_ROCM
> - Updated capset handling to use VIRTIO_GPU_CAPSET_ROCM (8) instead of
>    VIRTIO_GPU_CAPSET_HSAKMT (8)
> - Removed the error handling fix from patch 1 (virtio-gpu-virgl.c) into
>    another thread
> 
> Changes in v2:
> - Fixed error handling bug in virtio-gpu-virgl.c where the return
>    value check was inverted (changed from "if (!ret)" to "if (ret != 0)")
> - Added VIRGL_RENDER_USE_HSAKMT flag initialization in virtio_gpu_virgl_init()
>    when HSAKMT support is enabled
> - Simplified blob resource creation logic by removing complex conditional
>    branching for userptr vs regular blob handling
> - Updated commit messages to reflect bug fixes and improvements
> - Added references to related patches in Linux kernel, virglrenderer, and
>    ROCm Runtime components for complete feature implementation tracking
> 
> Related patches in other components:
> - Linux kernel virtio-gpu support:
>    https://lore.kernel.org/lkml/20251112072910.3716944-1-honglei1.huang@amd.com/
> - Virglrenderer support:
>    https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1568
> - ROCm Runtime support (merged):
>    https://github.com/ROCm/ROCR-Runtime/commit/48d3719dba6ca91f597a8179d8b341387ce155e8
> 
> Honglei Huang (4):
>    virtio-gpu: Update Linux headers to add virtio-gpu userptr support
>    virtio-gpu: Remove nr_entries limit check in create_mapping_iov
>    virtio-gpu: Update Linux headers to add ROCM capability set
>    virtio-gpu: Add ROCm capability support
> 
>   hw/display/virtio-gpu-gl.c                  |  2 ++
>   hw/display/virtio-gpu-virgl.c               | 12 ++++++++++++
>   hw/display/virtio-gpu.c                     |  7 -------
>   include/hw/virtio/virtio-gpu.h              |  3 +++
>   include/standard-headers/linux/virtio_gpu.h |  6 ++++++
>   5 files changed, 23 insertions(+), 7 deletions(-)
> 


