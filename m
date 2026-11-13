Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1868606A891
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=N65GytGd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xS16b-0000w6-MB; Fri, 13 Nov 2026 18:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xS16Z-0000uE-2Z
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 18:54:51 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xS16W-0007B5-Fx
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 18:54:50 -0500
Received: from [172.31.11.120] (m85.aaa.bbb.ccc.bctel.net [209.52.143.85] (may
 be forged)) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6ADNsa2H040351
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 14 Nov 2026 08:54:43 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=T/ilPTanM9C6/yUsTKJL3Momz829jAukqludUUT1Mvg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1794614084; v=1;
 b=N65GytGdvzDgm55mqmJ9CVhKbHWdXIFsSs6E9r9/vt3dlC1tboeaaS3t2yFjDP70
 U1Rew30h++zGxqz2x3z5cDEDhK3nw8F+SnWyM3+2SV4WLW8lCB8pdxtIW8C0fZ39
 2UCqFKmoYJJVVACS4JpmRJCW3GxMwgszlp/SLEXwVWo6xAUNcuMQDG8z2QQTn37i
 oGw0m8wNJLk660ajbHBX8Itm0L2hBehXQdcnpM0JXmfmhAeLqUw7dkXeaEVW9zA/
 MgEntHxzrwdZZK55svov2+Rke3aHSgM4lZ1zYCr5QuGB/WiYtZELYPlxYtkZvEXY
 TsgpuWvQq+DXSFprf+XTag==
Message-ID: <c9f24eda-0360-4c5d-81e4-30f36b550821@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 13 Nov 2026 16:54:43 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] hw/display/vhost-user-gpu: reset the console
 scanout on device reset
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Dmitry R <rdmitry@taktcycles.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
References: <20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com>
 <20261113-issue-4848-v3-3-98e4fa3e77eb@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261113-issue-4848-v3-3-98e4fa3e77eb@redhat.com>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/13 9:29, Marc-André Lureau wrote:
> vhost_user_gpu_reset() clears VirtIOGPUBase::enable, which makes the
> virtio-vga wrapper fall back to the legacy VGA display. The console is
> left in a GL scanout though, so qemu_console_surface() returns NULL and
> vga_update_display() dereferences it when the display refreshes: the
> host crashes on guest reboot or driver reload with a GL display.
> 
> Release the frontend dmabufs, disable the GL scanout and install a
> placeholder surface for each output, as virtio_gpu_reset() does for the
> non vhost-user device.

This is unsafe independently: GL teardown runs on the vCPU thread. Patch 
4 fixes this; please fold them together to preserve bisectability.

Regards,
Akihiko Odaki

> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4846
> Reported-by: Dmitry R <rdmitry@taktcycles.com>
> Tested-by: Dmitry R <rdmitry@taktcycles.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/vhost-user-gpu.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index c09aca041135..d3b720d08a73 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -638,6 +638,20 @@ static void
>   vhost_user_gpu_reset(VirtIODevice *vdev)
>   {
>       VhostUserGPU *g = VHOST_USER_GPU(vdev);
> +    int i;
> +
> +    /* release the scanouts before virtio_gpu_base_reset() drops ds */
> +    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
> +        struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[i];
> +
> +        /* the guest may have left a GL scanout behind */
> +        if (g->dmabuf[i]) {
> +            qemu_console_gl_release_dmabuf(scanout->con, g->dmabuf[i]);
> +            g_clear_pointer(&g->dmabuf[i], qemu_dmabuf_free);
> +        }
> +        qemu_console_gl_scanout_disable(scanout->con);
> +        qemu_console_set_surface(scanout->con, NULL);
> +    }
>   
>       virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
>   
> 


