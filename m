Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547F8CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMrw-0006Ma-SD; Wed, 07 Oct 2026 04:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEH5n-0001SP-PR
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:09:33 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEH5X-0005F2-73
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:09:06 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 696AoHGI046138
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 6 Oct 2026 19:50:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=XrIGxFT/heej1FjwUGNC/kAhMqVX74K/F21ptWq9elk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791283817; v=1;
 b=R2madkSqagvNk/KIt7/tEqkfFh6bRez+640gIaaSYrHyAkugH9o1KQbbkIHBcF57
 RL6Sn7NlsNGJL9pSR+mM505DtIdwZ430xsy+gFIIgoFU/oOHBGYTk/g2+XhrLaXp
 IbtDLA/zDr0B+amV/50vht3G81z+fmYCuiu3cATx4NtLyr/BMAz6+XJbgG+5yvv4
 qFq/npJFdSwOKnYOVARz4q1X2Uq1vmyc3rKB9kjqnje+Zyl37Z+G/kdA4WqnNa18
 XKKUDuPCohVOaBtRMPaZm7ZBgwjKfdc2KjNv6vVqp3xEccZcaWAs/bOA+71j3fvG
 llKadxD22d3CshYP1x7vIw==
Message-ID: <5f7a466d-3815-427e-98f7-94f48d8e9777@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 6 Oct 2026 19:50:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu-rutabaga: make sure ctx_ids match
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gurchetan Singh <gurchetan.singh.foss@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20261005174522.8663-1-gurchetan.singh.foss@gmail.com>
 <CAJ+F1C+zTWt878LjRHn7wXQWn3aW8UvWD=E15yBwc1DiGWSmUg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+F1C+zTWt878LjRHn7wXQWn3aW8UvWD=E15yBwc1DiGWSmUg@mail.gmail.com>
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

On 2026/10/06 4:22, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Oct 5, 2026 at 11:00 PM Gurchetan Singh
> <gurchetan.singh.foss@gmail.com> wrote:
>>
>> The ctx_ids need to match as well as the ring ids for
>> proper signaling.
>>
>> Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
>> Signed-off-by: Gurchetan Singh <gurchetan.singh.foss@gmail.com>
>> ---
>>   hw/display/virtio-gpu-rutabaga.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
>> index 3aafa4dc66..edf7b62703 100644
>> --- a/hw/display/virtio-gpu-rutabaga.c
>> +++ b/hw/display/virtio-gpu-rutabaga.c
>> @@ -902,7 +902,8 @@ virtio_gpu_rutabaga_aio_cb(void *opaque)
>>           }
>>
>>           if (signaled_ctx_specific &&
>> -           (cmd->cmd_hdr.ring_idx != fence_data.ring_idx)) {
>> +           ((cmd->cmd_hdr.ctx_id != fence_data.ctx_id) ||
>> +           (cmd->cmd_hdr.ring_idx != fence_data.ring_idx))) {
>>               continue;
>>           }
> 
> lgtm
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> 
> btw Gurchetan, do you remember why virtio-gpu-pci-rutabaga.c is using
> raw TypeInfo, and not VirtioPCIDeviceTypeInfo? Is it just an
> oversight? I can send a patch if it's the case

It looks like an oversight to me as well.

Earlier revisions of the patch used VirtioPCIDeviceTypeInfo [1]. In v12, 
the code was converted to use DEFINE_TYPES() [2], and 
VirtioPCIDeviceTypeInfo was replaced with TypeInfo at the same time.

[1] 
https://lore.kernel.org/qemu-devel/20230823012541.485-7-gurchetansingh@chromium.org/
[2] 
https://lore.kernel.org/qemu-devel/20230824234046.499-7-gurchetansingh@chromium.org/

Regards,
Akihiko Odaki

