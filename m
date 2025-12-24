Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEFCE7491C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 07:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYIrN-00046x-GP; Wed, 24 Dec 2025 02:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vYIqo-00040g-7D
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 02:00:04 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vYIqk-0003op-Vl
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 02:00:01 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BO6wTl2001939
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Dec 2025 15:59:46 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=V5oYldSZoKx17wkwRIj7SmOYSSUafWHRrP99NlcOYa0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1766559586; v=1;
 b=a1rVPASUGwqe/B5gdHshf+yPeYfQ4LLVVQ3nxCQAbbwkI9z8NAQEaKRutd4mzkd1
 zK5DGklX5JJdVXAtOrWOTzgsyJam2XTKCIgReaViQpml3XQBwXtziycBpu7EeE6K
 tFSIm98P3Az2hWF7p0rKlbmMRuvnMuNzcN1HSbKVFZu2KbMrMrXbCjIgFrjvJfx/
 UhUdUenw2sR+YTgFYZcIaUoUl1h+JQcsZdnTOV70cyf6MEKzD921HbLU8qq+wemp
 PXWqHIV/bC3QkAhidZeI5c1u26D68vv/cyteddM1WiwmE/At9+/8SMcD8/T3eUQT
 3VnrmC8E9mAWhuCV5Iguog==
Message-ID: <8c4f9e95-8dfd-4673-bf5f-dff9fc6c7f65@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 24 Dec 2025 15:58:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/7] virtio-gpu-virgl: update virglrenderer defines
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-5-j@getutm.app>
 <32a0ad66-5c42-4d98-8c5d-0a601e31b76a@rsg.ci.i.u-tokyo.ac.jp>
 <CA+E+eSDgi-5sJmMk8=PWYOXdoJSAXURUD35y+2sHxJWWH0GtWA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CA+E+eSDgi-5sJmMk8=PWYOXdoJSAXURUD35y+2sHxJWWH0GtWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2025/12/20 1:26, Joelle van Dyne wrote:
> On Wed, Dec 3, 2025 at 11:13 PM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2025/12/03 13:07, Joelle van Dyne wrote:
>>> In order to support additional native texture types, we need to update the
>>> defines in virglrenderer. The changes are backwards compatible and so
>>> builds should work with either the new version or the old version.
>>>
>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>>> ---
>>>    hw/display/virtio-gpu-virgl.c | 28 +++++++++++++++++++++++++---
>>>    1 file changed, 25 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>> index d0e6ad4b17..36c670f988 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -24,6 +24,8 @@
>>>
>>>    #include <virglrenderer.h>
>>>
>>> +#define SUPPORTED_VIRGL_INFO_EXT_VERSION (1)
>>
>> This naming is a bit confusing because version 0 is also supported.
>>
>>> +
>>>    struct virtio_gpu_virgl_resource {
>>>        struct virtio_gpu_simple_resource base;
>>>        MemoryRegion *mr;
>>> @@ -441,12 +443,30 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>>>            memset(&ext, 0, sizeof(ext));
>>>            ret = virgl_renderer_resource_get_info_ext(ss.resource_id, &ext);
>>>            info = ext.base;
>>> +        /* fallback to older version */
>>>            native = (ScanoutTextureNative){
>>>                .type = ext.d3d_tex2d ? SCANOUT_TEXTURE_NATIVE_TYPE_D3D :
>>>                                        SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
>>>                .u.d3d_tex2d = ext.d3d_tex2d,
>>>            };
>>> -#else
>>> +#if VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION >= SUPPORTED_VIRGL_INFO_EXT_VERSION
>>> +        if (ext.version >= VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION) {
>>> +            switch (ext.native_type) {
>>> +            case VIRGL_NATIVE_HANDLE_NONE:
>>> +            case VIRGL_NATIVE_HANDLE_D3D_TEX2D: {
>>> +                /* already handled above */
>>> +                break;
>>> +            }
>>> +            default: {
>>> +                qemu_log_mask(LOG_GUEST_ERROR,
>>> +                            "%s: unsupported native texture type %d\n",
>>> +                            __func__, ext.native_type);
>>
>> It is not an error condition; the d3d_tex2d field is an optional hint
>> that allows zero-copy inter-process sharing and the tex_id field is used
>> if it is missing or inter-process sharing is unnecessary. It should be
>> fine to dismiss the native handle unless the semantic changes.
> When VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION >= 1, the semantic
> changed to always have a ext.native_type. In case of missing
> d3d_tex2d, ext.native_type will be VIRGL_NATIVE_HANDLE_NONE. The
> default case is if virglrenderer introduces a new native type that is
> unknown at the time QEMU is built. This is why the struct version is
> bumped.

What I am saying is that having a new native type that is unknown is 
fine and hence no need to log an error. QEMU will simply use the OpenGL 
texture in such a case.

Regards,
Akihiko Odaki

