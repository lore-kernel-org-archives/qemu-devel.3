Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BD6C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54PP-0003Bq-Hk; Fri, 11 Sep 2026 12:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x54PI-0003BE-3K
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:47:21 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x54PF-0001Zx-1Z
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:47:19 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68BGkx99054110
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 12 Sep 2026 01:46:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=uuLAHT0ruRJEw+g+GpghjYQunN1PVXDmRiXZEPfy7nQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1789145220; v=1;
 b=mAyyj9gBPSVCQqhaFje2/KB37oBDNVQZrH+tIxK1ZqAnzhYPtWeNMnYTp/HV0XHA
 L4OailHRQFZhr4W+lgbz9dH9akmiXmD9kD2plIOO605gPfWnrkpi2b8PWZ0XScBh
 L1TkiuuXfrmMOWqtXLQNuLky/IcFHIzVYxD6nTEToMISqyT9KfCtCs62mhkdtCog
 XIrI1D8tAwKXYRCxbqVCEF+pWTNBUPF8QiG/+zP1aZu1ICJPbSGTFERn517BztUY
 So7KGpyz464CiFwO7dRGgNkGvOYFH4KVPPrKr1CYxCmrSCSAt8EW79QVay7hCEAl
 580XuKcMd7HhpluDyigFsA==
Message-ID: <48eacf0c-503e-497c-b54e-686607f9cbf7@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 12 Sep 2026 01:46:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display: Guard new_blob to fix Wunused-function
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 marcandre.lureau@redhat.com
References: <20260911141906.736052-1-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260911141906.736052-1-brian.cain@oss.qualcomm.com>
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

On 2026/09/11 23:19, Brian Cain wrote:
> The call to virtio_gpu_virgl_resource_new_blob() should be guarded like

s/call to/definition of/

> the (sole) caller is, to avoid -Wunused-function.
> 
>          ../hw/display/virtio-gpu-virgl.c:328:1: error: ‘virtio_gpu_virgl_resource_new_blob’ defined but not used [-Werror=unused-function]
>        328 | virtio_gpu_virgl_resource_new_blob(uint32_t resource_id, uint64_t blob_size)
>            | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

May also have:

Fixes: d814b44636d0 ("hw/display/virtio-gpu: introduce 
virtio_gpu_{simple,virgl}_resource_new()")

Nevertheless, everything other than these nits looks good, so:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

> ---
>   hw/display/virtio-gpu-virgl.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 1c9380e2a6d..f45571060fe 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -324,6 +324,7 @@ virtio_gpu_virgl_resource_new(uint32_t resource_id, uint32_t width,
>       return res;
>   }
>   
> +#if VIRGL_VERSION_MAJOR >= 1
>   static struct virtio_gpu_virgl_resource *
>   virtio_gpu_virgl_resource_new_blob(uint32_t resource_id, uint64_t blob_size)
>   {
> @@ -335,6 +336,7 @@ virtio_gpu_virgl_resource_new_blob(uint32_t resource_id, uint64_t blob_size)
>   
>       return res;
>   }
> +#endif
>   
>   static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>                                            struct virtio_gpu_ctrl_command *cmd)


