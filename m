Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C6EC531CC
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 08:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnuJ0-0003Tr-K5; Sun, 26 Jul 2026 04:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnuIu-0003T6-Uk; Sun, 26 Jul 2026 04:33:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnuIt-00017g-1y; Sun, 26 Jul 2026 04:33:48 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66Q8XF4R034902
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 26 Jul 2026 17:33:15 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=QswiQ/L8FXd+V4Ti1ALLVF/K+0AewuQNXXBx9a9d7BI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785054795; v=1;
 b=AdJzZ7o9rJUuo/1AtWXo8kIXJwsajUsD17j9Lw6FK3XcUk/rK2HacQ7TAgVfHZNJ
 NgZvrSnEdBOflt8wEO5WDcQJbJWackyYLHS0bxwXr7w2JkQDiUvW9hQ1doOl03eI
 kdzRMOMeprGsoFL2/ZPrFWZKmeYUS5vLjSyXlI7Mvr+ewxDdXXAotFcKrsBNAARi
 i2znZzTaWffwr+flCmth72YCbym21kgtEv/y4yzTkzYB7xspqNDC7SLBiH4T5bBw
 IQDozdAGfBWvJ8xWpub2+qA3YbXZJXJ1bsXhUZE+vCwAv9bK+xmW+y5GBOuoya31
 QrLRPsrHRKIxCydMpZ5kjA==
Message-ID: <6ea16c39-3bae-4ea7-8e91-afb58f775ca2@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 26 Jul 2026 17:33:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] hw/display/virtio-gpu-rutabaga: zero-init capset info
 response
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "P. Berrange, Daniel" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Haotian Jiang <jianghaotian.sunday@gmail.com>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-1-5c9a6ce7b96a@redhat.com>
 <d6876e8f-1414-4e7d-b6e2-1b59a18e8288@rsg.ci.i.u-tokyo.ac.jp>
 <CAMxuvawR=TiF4r+wdVCDF3Hyu-ND9neFHjUEZn5_YnSbxweXhg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAMxuvawR=TiF4r+wdVCDF3Hyu-ND9neFHjUEZn5_YnSbxweXhg@mail.gmail.com>
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

On 2026/07/26 17:24, Marc-André Lureau wrote:
> Hi
> 
> On Sun, Jul 26, 2026 at 11:33 AM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/07/25 23:00, Marc-André Lureau wrote:
>>> rutabaga_cmd_get_capset_info() only fills in capset_id,
>>> capset_max_version and capset_max_size before sending the response to
>>> the guest. The remaining fields of struct virtio_gpu_resp_capset_info,
>>> including hdr.fence_id, hdr.ctx_id and hdr.ring_idx, are left with
>>> stack garbage and leaked to the guest, including host pointers useful
>>> for an ASLR bypass.
>>>
>>> Zero the response first, matching virgl_cmd_get_capset_info().
>>>
>>> Not a real risk thanks to -ftrivial-auto-var-init=zero.
>>
>> GCC only added -ftrivial-auto-var-init=zero in GCC 12, while QEMU still
>> supports GCC 10.4/11.
>>
> 
> Good point, may be we should update:
> https://patchew.org/QEMU/20260723094622.1515831-1-berrange@redhat.com/
> 
> ack otherwise?

Yes:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards.
Akihiko Odaki

> 
>> Regards,
>> Akihiko Odaki
>>
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3609
>>> Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
>>> Reported-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    hw/display/virtio-gpu-rutabaga.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
>>> index 4d7d7b245929..95a19eed7eda 100644
>>> --- a/hw/display/virtio-gpu-rutabaga.c
>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>> @@ -555,6 +555,8 @@ rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>>>
>>>        VIRTIO_GPU_FILL_CMD(info);
>>>
>>> +    memset(&resp, 0, sizeof(resp));
>>> +
>>>        result = rutabaga_get_capset_info(vr->rutabaga, info.capset_index,
>>>                                          &resp.capset_id, &resp.capset_max_version,
>>>                                          &resp.capset_max_size);
>>>
>>
> 


