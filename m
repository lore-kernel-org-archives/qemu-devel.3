Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F2606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=QkrOjwcJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpMS-0007n2-4U; Fri, 27 Nov 2026 01:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xWpMG-0007IF-Mj
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 01:22:57 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xWpMD-00034V-Hg
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 01:22:56 -0500
Received: from [157.82.201.75] ([157.82.201.75]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6AR6MomF002790
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 27 Nov 2026 15:22:50 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=rHAwE4ADfCjApA8fZJkQLukDToXTf4Gw+z1fsudftpQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1795760570; v=1;
 b=QkrOjwcJxgC1sm2r7PPyA2kW//SdMlkVq082tfPUb7n90l2O6h3pM3BBjyZWAMoc
 wYAHD7X412dhm9vxkK1e8fg7Tw4bNXNpOzTC3JQueChbhf1MSMdhwvR45fEeBJAR
 et3DHnu1K+Xh/YIreZlnwI+TvRJ8r+Uu5vucdcavcvqF+JoGTBCuLvwVJse7bXrn
 dBlPxK3EHtn/2iJy29rwfqXgbleN9wRyycYyMMFFaStj47RQZ+th3ggGY19FkPOV
 68Dqx2gH3ax7GzRKxhJHYZ+wv0TOmvNxdQKOCtkiyKgxEGFDKFQv2wygb+lsOmsU
 7QY/KTpFYaWY4kX9kUVW7w==
Message-ID: <b6d7c99c-eb8b-480d-806d-e8051b3e44c1@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 27 Nov 2026 15:22:50 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] hw/display/vhost-user-gpu: don't set an fd handler
 without a socket
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Dmitry R <rdmitry@taktcycles.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
References: <20261124-issue-4848-v4-0-24993c4766fc@redhat.com>
 <20261124-issue-4848-v4-3-24993c4766fc@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261124-issue-4848-v4-3-24993c4766fc@redhat.com>
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

On 2026/11/24 21:47, Marc-André Lureau wrote:
> A GL display client that stays attached across a device stop can unblock
> the console after vhost_gpu_fd has been reset to -1: the UpdateDMABUF
> reply or the one-second gl unblock timer reach
> vhost_user_gpu_gl_flushed(), which installs the display socket handler
> on fd -1. With the io_uring fd monitor, the failed poll of fd -1 is
> reported as readiness, so the handler runs and is re-armed forever.

console_hw_gl_unblock_timer() only logs a warning. I guess you meant the 
timeout specific to D-Bus instead of the timer in the common code, since 
the timeout actually leads to qemu_console_hw_gl_block(..., false).

The fix itself looks good to me.

Regards,
Akihiko Odaki

> 
> Only set the handler when the device has a display socket.
> 
> Fixes: 3cddb8b9e0b5 ("display/ui: add a callback to indicate GL state is flushed")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4847
> Reported-by: Dmitry R <rdmitry@taktcycles.com>
> Tested-by: Dmitry R <rdmitry@taktcycles.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/vhost-user-gpu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 32e7d9638f68..61a15dd916f8 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -448,6 +448,11 @@ end:
>   static void
>   vhost_user_gpu_update_blocked(VhostUserGPU *g, bool blocked)
>   {
> +    /* the display socket doesn't exist before DRIVER_OK */
> +    if (g->vhost_gpu_fd == -1) {
> +        return;
> +    }
> +
>       qemu_set_fd_handler(g->vhost_gpu_fd,
>                           blocked ? NULL : vhost_user_gpu_chr_read, NULL, g);
>   }
> 


