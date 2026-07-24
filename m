Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7111C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 05:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn8Pl-0008Mb-LU; Fri, 24 Jul 2026 01:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wn8Pj-0008MF-6R
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 01:25:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wn8Pf-0001Mw-N2
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 01:25:38 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66O5PPYW053096
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Jul 2026 14:25:25 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=dkjhLPwJiBVIgLYWat4RUH+y85/fQfYFQrV/Ghph1oo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784870725; v=1;
 b=rN+I4V6JZIhs8LYAu3ixYzKvLE1BczS9CJ4Qknb4hs5Np4/kQo3prO4WNkAWbsC6
 0jEvrzmMlzdKRyNxWLTYGbZJG6PXWkz0k+Fyp/iU1cQPY+3ZfdoSaNpyLkBiq8D/
 e9wd3D6ozK3AlEND66iIPAV3B9Jh4eRoHKfgY2gxblrEqjC9dGgOgItEB1BNXcEc
 IB4SsKGDwIvjWJ4iRRMCPwyKLwRz47/Qt0CL0d4DH/L6vZ+wLuGCFM3yqmn5b7tG
 zfZk9MIauLsB/zV7Rg9S44wfQEKPlbFdyJ9LfyeGBzjqM84M+LO9W3KQyuQeC+H2
 Y/7DmrFDgC6tMKh2ywmuVw==
Message-ID: <55a8dba5-a0f5-4a8d-8d3f-e9433a963960@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 24 Jul 2026 14:25:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/display/qxl: validate primary surface stride
 against width
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260723135909.429714-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260723135909.429714-1-marcandre.lureau@redhat.com>
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

On 2026/07/23 22:59, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The existing validation in qxl_create_guest_primary() checks that
> abs(stride) * height fits in vgamem_size and that stride is 4-byte
> aligned, but never checks that abs(stride) is large enough to hold one
> row of pixels for the declared width and format.
> 
> A malicious guest can create a primary surface with a stride much
> smaller than width * bytes_per_pixel (e.g. stride=4 for a 64-wide 32bpp
> surface). The spice server rejects this via red_validate_surface(), but
> the return is void and QEMU unconditionally proceeds to set up the local
> rendering state. On the next display refresh, VNC or SDL reads width *
> bytes_pp per scanline from a region backed by only stride bytes per
> row, causing a host-side out-of-bounds read.
> 
> Add three checks in qxl_create_guest_primary() before creating the
> surface:
>   - reject unknown surface formats
>   - reject zero width or height
>   - reject surfaces where abs(stride) < width * bytes_per_pixel
> 
> Also fix two related issues in qxl-render.c:
>   - qxl_blit() used abs_stride to advance the dst pointer into the
>     DisplaySurface, but when stride is negative the DisplaySurface is a
>     packed buffer whose stride may be smaller. Use surface_stride()
>     instead.
>   - qxl_render_update_area_unlocked() uses guest_head0_width (set via
>     QXL_IO_MONITORS_CONFIG_ASYNC) without validating it against
>     abs_stride, bypassing the new validation. Clamp the effective width
>     to abs_stride / bytes_pp to prevent out-of-bounds access while
>     tolerating the normal transient where the monitor config arrives
>     before the primary surface is resized to match.

The height is also problematic. For the same reason, guest_head0_height 
can bypass the check in qxl_create_guest_primary(), overrunning vgamem_size.

qxl_phys2virt(), called in qxl_render_update_area_unlocked(), is meant 
to prevent overrunning the containing MemoryRegion, but it is also 
ineffective because the size parameter passed to the function may have 
overflowed; the value is calculated as abs_stride * height, so it will 
overflow when abs_stride == 16 MiB and height == 256.

Regards,
Akihiko Odaki

> 
> Fixes: CVE-2026-16271
> Fixes: 3761abb16784 ("hw/display/qxl: fix signed to unsigned comparison")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3637
> Reported-by: huntr bubble
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/qxl-render.c | 11 +++++++++--
>   hw/display/qxl.c        | 29 +++++++++++++++++++++++++++++
>   2 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
> index 4799c9e8befd..231cad17ee3e 100644
> --- a/hw/display/qxl-render.c
> +++ b/hw/display/qxl-render.c
> @@ -27,6 +27,7 @@
>   static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
>   {
>       DisplaySurface *surface = qemu_console_surface(qxl->vga.con);
> +    int dst_stride = surface_stride(surface);
>       uint8_t *dst = surface_data(surface);
>       uint8_t *src;
>       int len, i;
> @@ -45,14 +46,14 @@ static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
>       } else {
>           src += rect->top * qxl->guest_primary.abs_stride;
>       }
> -    dst += rect->top  * qxl->guest_primary.abs_stride;
> +    dst += rect->top  * dst_stride;
>       src += rect->left * qxl->guest_primary.bytes_pp;
>       dst += rect->left * qxl->guest_primary.bytes_pp;
>       len  = (rect->right - rect->left) * qxl->guest_primary.bytes_pp;
>   
>       for (i = rect->top; i < rect->bottom; i++) {
>           memcpy(dst, src, len);
> -        dst += qxl->guest_primary.abs_stride;
> +        dst += dst_stride;
>           src += qxl->guest_primary.qxl_stride;
>       }
>   }
> @@ -103,6 +104,12 @@ static void qxl_render_update_area_unlocked(PCIQXLDevice *qxl)
>       int height = qxl->guest_head0_height ?: qxl->guest_primary.surface.height;
>       int i;
>   
> +    if (qxl->guest_primary.bytes_pp > 0) {
> +        int max_width = qxl->guest_primary.abs_stride
> +                        / qxl->guest_primary.bytes_pp;
> +        width = MIN(width, max_width);
> +    }
> +
>       if (qxl->guest_primary.resized) {
>           qxl->guest_primary.resized = 0;
>           qxl->guest_primary.data = qxl_phys2virt(qxl,
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index b7d871b9ee33..41673c369bca 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -1496,6 +1496,7 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
>       QXLSurfaceCreate *sc = &qxl->guest_primary.surface;
>       uint32_t requested_height = le32_to_cpu(sc->height);
>       int requested_stride = le32_to_cpu(sc->stride);
> +    uint32_t bytes_pp;
>   
>       if (requested_stride == INT32_MIN ||
>           abs(requested_stride) * (uint64_t)requested_height
> @@ -1532,6 +1533,34 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
>           return;
>       }
>   
> +    switch (surface.format) {
> +    case SPICE_SURFACE_FMT_16_555:
> +    case SPICE_SURFACE_FMT_16_565:
> +        bytes_pp = 2;
> +        break;
> +    case SPICE_SURFACE_FMT_32_xRGB:
> +    case SPICE_SURFACE_FMT_32_ARGB:
> +        bytes_pp = 4;
> +        break;
> +    default:
> +        qxl_set_guest_bug(qxl, "%s: unhandled format %d",
> +                          __func__, surface.format);
> +        return;
> +    }
> +
> +    if (surface.width == 0 || surface.height == 0) {
> +        qxl_set_guest_bug(qxl, "%s: zero dimension %ux%u",
> +                          __func__, surface.width, surface.height);
> +        return;
> +    }
> +
> +    if ((uint64_t)surface.width * bytes_pp > abs(surface.stride)) {
> +        qxl_set_guest_bug(qxl, "%s: stride too small for width:"
> +                          " stride %d width %u bpp %u",
> +                          __func__, surface.stride, surface.width, bytes_pp);
> +        return;
> +    }
> +
>       surface.mouse_mode = true;
>       surface.group_id   = MEMSLOT_GROUP_GUEST;
>       if (loadvm) {


