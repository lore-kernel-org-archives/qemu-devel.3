Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A561C44512
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 07:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlMIE-0001OO-Kk; Sun, 19 Jul 2026 03:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wlMI5-0001JS-FQ; Sun, 19 Jul 2026 03:50:26 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wlMI2-0005MT-JB; Sun, 19 Jul 2026 03:50:25 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66J7oGFX010002
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 19 Jul 2026 16:50:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=P73/KLzmqeIGXZolmImzw1JzOt1XRCX+0gINv+dLIqo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784447416; v=1;
 b=t7ysgbZqZYhS0TgYAiMeRaU58dECOCTr/d1KUcNn6Yc+0GvQ83IKErEFA8ULeUNj
 o6AwOzcwKFX7D3Y0PE0qQgNSVWDUEVppOUv7etOzMxXc8N3Vpv4GtHXFdphgJKy9
 /0WsMep/hknUF4jr6ApbZ5wRDdDmQScivttndfHlKmp+CRsc9sWqIeLfgHBhcFiq
 Axlh+D1WMpyI3kj6k1A48E3W4YSsGJ3psEPwWX6JBTUPt4uqZ017Yyv0twGAxj0Y
 VKPNxlQUg+WBdDktsGbva7a13JgtR1qHeJKyR1vXQ2/0AieV1IVVqa78sLhu2640
 5/m22ZnWtJC/2r6A0ehaEA==
Message-ID: <a12f0dfc-2487-4ff9-be0b-149451e80032@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 19 Jul 2026 16:50:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 00/15] Various UI/security-related fixes for 11.1
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
 <a6f014be-7f31-4f53-a3f4-9b1ea437d7e7@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <a6f014be-7f31-4f53-a3f4-9b1ea437d7e7@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/07/19 16:33, Michael Tokarev wrote:
> [Resending with the correct email of Akihiko Odaki, please excuse the 
> duplicate]
> 
> On 7/17/26 14:52, Marc-André Lureau wrote:
> 
>> Various UI/security-related fixes for 11.1
>>
>> ----------------------------------------------------------------
>> Akihiko Odaki (3):
>>        ui/gtk: Narrow DMA-BUF critical section
>>        hw/display/virtio-gpu: reject strides exceeding INT_MAX
>>        hw/display/virtio-gpu: Check pixman_image_create_bits() results
>>
>> Marc-André Lureau (12):
>>        i386/tdx: fix uninitialized variable warning in tdx_check_features
>>        ui/vnc: fix OOB write in vnc_refresh_lossy_rect
>>        ui/vnc: validate color shifts in SetPixelFormat
>>        ui/vnc: use RFB wire types for client message handlers
>>        ui/input-barrier: fix off-by-one in keycode bounds check
>>        ui/vnc: fix out-of-bounds write in lossy refresh dirty marking
>>        ui/vnc: validate SetPixelFormat field ranges
>>        hw/display/virtio-gpu: fix dmabuf_fd leak on remap failure
>>        hw/display/qxl: fix TOCTOU in cursor chunk data_size handling
>>        hw/display/virtio-gpu: validate stride against width on scanout
>>        hw/display/virtio-gpu: cap submit_3d command buffer allocation
>>        hw/display/virtio-gpu: handle migration iov allocation failure
> 
> Hi!

Hi Michael, Marc-André,

> 
> Is there anything in there which should *not* go
> to the stable qemu series?
> (besides fixes for code which is not in releases, if any)
> 
> It feels like everything in this pullreq should be picked up
> for qemu-stable.

The hw/display/virtio-gpu patches are generally good for stable, with 
one exception:

"hw/display/virtio-gpu: validate stride against width on scanout"

This patch doesn't account for the late feedback I sent here:
https://lore.kernel.org/qemu-devel/ec997fca-6dc4-4268-9269-0e4be676b0fb@rsg.ci.i.u-tokyo.ac.jp/

Marc-André: My apologies for the timing, but please check the linked 
thread.

Michael: You may holding off on that specific patch for qemu-stable 
until we clear up that edge case, but at least it's not harmful. I think 
my patches and the other virtio-gpu patches are ready.

Regards,
Akihiko Odaki

