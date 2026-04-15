Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE92FF43824
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 14:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0xc-00041n-PL; Wed, 15 Apr 2026 10:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wD0xZ-00041b-Ox
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 10:11:17 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wD0xV-0000nJ-Hp
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 10:11:17 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63FEAwHq000661
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 15 Apr 2026 23:10:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=S8zoX3YPrEwfUCcBnsY5VlHO/OP2atpnzwwkBjzuEMM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1776262259; v=1;
 b=kwgSV8erYaHLE3gjov3YTfMnsV56ypHYcSsXXJPjO5LCaA9TWlSWKdI2xJpu9sKC
 V/O2ACa5eKG9qawyc+QqKpE9FRCiwSVkK2BrLt3Visq2VxGY+zOgl09pKvAwfqV3
 QhA9D9qcbRC+LcARe7D6qTDTZ30oh9VQhG3nTYCr0l4/3spJ2AlRc2RSyHtl0O7u
 z3H2SMCPW0KgDjZX46rPG9y8k/FXvEWHn2SrbcJSEBGRyXe7YPw3SdLUVZ5Eh9Jk
 196hlMZ49V8Ra7IP2PlSF/COpmYIrwJqVjRBLbV0fwmVE2jr80cv3ZKahFuDy1sy
 08G7c9GGJcDFpMuubcrCDw==
Message-ID: <1f4d02d6-b314-4bc6-bafe-a95b03502821@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 15 Apr 2026 23:10:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] add a refresh_rate option to virtio-gpu
To: slonkazoid <slonkazoid@slonk.ing>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260415-virtio-gpu-refresh-rate-v2-1-b71599d84755@slonk.ing>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260415-virtio-gpu-refresh-rate-v2-1-b71599d84755@slonk.ing>
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

On 2026/04/15 18:19, slonkazoid wrote:
> Signed-off-by: slonkazoid <slonkazoid@slonk.ing>
> ---
> currently, the virtio-gpu module does not set a refresh rate, making it
> default to 75Hz in the qemu edid generation logic. i wrote a sloppy patch
> that adds a `refresh_rate` option to virtio-gpu, which propagates to all
> the devices based on it (i was interested in virtio-vga-gl). it's not of
> much use by itself but when combined with something like Sunshine or
> looking-glass, it can provide *far* smoother guest graphics than the
> inbuilt display devices. i have done a bare minimum amount of manual
> testing (virtio-vga-gl with venus XOR amdgpu drm native context streaming
> video games) and it functions as intended, and should not break the code
> path to fetch the refresh rate from the active display device (?), however,
> i have never contributed to QEMU before and i don't know the customs
> concerning testing, documentation, etc. if there's more i should do, please
> tell me! if this is something that would benefit QEMU, feel free to merge it.
> it's probably not a copyrightable change anyways.
> ---
> Changes in v2:
> - Update default value of refresh_rate to the old implied default of 75000

It looks good to me now.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

> - Link to v1: https://lore.kernel.org/qemu-devel/20260414-virtio-gpu-refresh-rate-v1-1-59e6320eb24e@slonk.ing
> ---
>   hw/display/virtio-gpu-base.c   | 1 +
>   include/hw/virtio/virtio-gpu.h | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index cb76302e2d..d87f6604d0 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -232,6 +232,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>   
>       g->req_state[0].width = g->conf.xres;
>       g->req_state[0].height = g->conf.yres;
> +    g->req_state[0].refresh_rate = g->conf.refresh_rate;
>   
>       for (output_idx = 0, node = g->conf.outputs;
>            node && output_idx < g->conf.max_outputs;
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index f69fc19462..e440535fa0 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -131,6 +131,7 @@ struct virtio_gpu_base_conf {
>       uint32_t flags;
>       uint32_t xres;
>       uint32_t yres;
> +    uint32_t refresh_rate;
>       uint64_t hostmem;
>       VirtIOGPUOutputList *outputs;
>   };
> @@ -176,7 +177,8 @@ struct VirtIOGPUBaseClass {
>       DEFINE_PROP_BIT("edid", _state, _conf.flags, \
>                       VIRTIO_GPU_FLAG_EDID_ENABLED, true), \
>       DEFINE_PROP_UINT32("xres", _state, _conf.xres, 1280), \
> -    DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800)
> +    DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800), \
> +    DEFINE_PROP_UINT32("refresh_rate", _state, _conf.refresh_rate, 75000)
>   
>   typedef struct VGPUDMABuf {
>       QemuDmaBuf *buf;
> 
> ---
> base-commit: 985062e2319e6bf4a4be9c216ede6d34379e5777
> change-id: 20260414-virtio-gpu-refresh-rate-37b388e7dd72
> 
> Best regards,


