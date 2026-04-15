Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB12F43821
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 14:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD1GY-0000lh-OT; Wed, 15 Apr 2026 10:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wD1GW-0000lW-O3
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 10:30:52 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wD1GS-0006ba-6s
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 10:30:52 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63FEUXl6006163
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 15 Apr 2026 23:30:34 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=eNOKKw0SnlBp1MELFohMtMB456mn5aK9rF1MLaI5VJY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1776263434; v=1;
 b=LnQL3HXdqfk6meO7dlAzcsq2RaHSReT64/57AGLteQ7QAuHDy01KdEQNmrIARS9t
 KiWyCuLalSVk7DNqkln84JX2Hlk/R5IqlNtG0lr7bcGLXEFfV9IKOxFTESMgbuxf
 hHmMp5h2AganK6Xdhl7MeNTJZCGRTG5f/WPLBb12JwYF3feyQUYr39NzsgfI9ejs
 1feToqKxvjZFV0KHVHb2hlYNd67tbdGKBNGjBjpX+DlfbC/7T/XzLg1K4lBxZtmw
 9p+RuinTmxbiiZEStYJlHI1UzbY33fgrUdqnaD9gDG5AhejZOQdJhCyFyMmBhO9k
 KwmXNqKmyZlpGkSeTd6M0g==
Message-ID: <40fb4df5-20a7-49ce-a087-d9c048255d05@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 15 Apr 2026 23:30:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu: fix inverted mouse cursor
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?B?QmVubm8gRsO8bmZzdMO8Y2s=?= <benno.fuenfstueck@neodyme.io>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260409144639.3610-1-benno.fuenfstueck@neodyme.io>
 <CAJ+F1CKYu4UfJyFJxPYLe9gjQhOD9QA7BrTmBXSCPuCDFgPf1A@mail.gmail.com>
 <CAP-XHHCuVyP=21LyME1KmNB0heRDXAdq7QdCsoVomAK38ZRi7A@mail.gmail.com>
 <CAJ+F1CJPiXH2Sf2Tqz4QoHeP23bUpMdfi=cPsYYnGoGwWeKJ8w@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+F1CJPiXH2Sf2Tqz4QoHeP23bUpMdfi=cPsYYnGoGwWeKJ8w@mail.gmail.com>
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

On 2026/04/15 22:10, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Apr 15, 2026 at 5:01 PM Benno Fünfstück
> <benno.fuenfstueck@neodyme.io> wrote:
>>
>> Hi Marc-André,
>>
>> On Mon, 13 Apr 2026 at 15:23, Marc-André Lureau <marcandre.lureau@gmail.com> wrote:
>>>
>>> Arguably, this is a bug in virgl vrend_renderer_get_cursor_content(),
>>> since the function doesn't return y0_top it should always return the
>>> data in the correct orientation.
>>>
>>> We may have a temporary workaround in qemu though for older virgl, but
>>> I think it should be solved there too.
>>
>>
>> Thanks, I didn't know about this. I submitted a MR to virglrenderer now as well to fix it there: https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1611
>>
> 
> great
> 
>> How should I change the patch to make it a temporary fix? Some kind of version gate (but not sure yet in which version of virglrenderer the fix will end up being release)?
> 
> Since it is not released yet, it's acceptable to not have a
> VIRGL_CHECK_VERSION yet. Just leave TODO comment so we can later add
> it when virgl has the fix.
> 
> thanks

I'm worried that updating virgl silently breaks the fix. I don't think 
there is an easy way to prevent that.

Perhaps a temporary fix may not be necessary. I don't have a reason to 
believe that deploying the virglrenderer-side fix takes longer than 
deploying the QEMU-side fix.

Regards,
Akihiko Odaki

> 
>>
>>>
>>>
>>>> ---
>>>>   hw/display/virtio-gpu-gl.c | 20 +++++++++++++++++++-
>>>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>>>> index 2b7a41c466..4562d3405e 100644
>>>> --- a/hw/display/virtio-gpu-gl.c
>>>> +++ b/hw/display/virtio-gpu-gl.c
>>>> @@ -33,6 +33,9 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
>>>>       VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>>>>       uint32_t width, height;
>>>>       uint32_t pixels, *data;
>>>> +    bool y_0_top = true;
>>>> +    int ret;
>>>> +    struct virgl_renderer_resource_info info;
>>>>
>>>>       if (gl->renderer_state != RS_INITED) {
>>>>           return;
>>>> @@ -49,8 +52,23 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
>>>>           return;
>>>>       }
>>>>
>>>> +    memset(&info, 0, sizeof(info));
>>>> +    ret = virgl_renderer_resource_get_info(resource_id, &info);
>>>> +    if (ret == 0) {
>>>> +        y_0_top = info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
>>>> +    }
>>>> +
>>>>       pixels = s->current_cursor->width * s->current_cursor->height;
>>>> -    memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_t));
>>>> +    if (y_0_top) {
>>>> +        memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_t));
>>>> +    } else {
>>>> +        uint32_t *dst = s->current_cursor->data;
>>>> +        for (uint32_t y = 0; y < height; y++) {
>>>> +            memcpy(dst + y * width,
>>>> +                   data + (height - 1 - y) * width,
>>>> +                   width * sizeof(uint32_t));
>>>> +        }
>>>> +    }
>>>>       free(data);
>>>>   }
>>>>
>>>> --
>>>> 2.50.1 (Apple Git-155)
>>>>
>>>>
>>>> --
>>>> Neodyme AG
>>>> Sitz der Gesellschaft / Address: Dirnismaning 55 | Halle 13 |
>>>> 85748 Garching b.München
>>>> Postanschrift: Rosenthaler Straße 72a | 10119
>>>> Berlin
>>>>
>>>> Registergericht / Registry court: München, HRB 269168
>>>> Vorstand /
>>>> Management Board: Thomas Lambertz | Tobias Madl
>>>> Aufsichtsratsvorsitzender /
>>>> Chairman of the Supervisory Board: Hendrik Hofstadt
>>>>
>>>>
>>>>
>>>>
>>>>
>>>
>>>
>>> --
>>> Marc-André Lureau
>>
>>
>> Neodyme AG
>>
>> Sitz der Gesellschaft / Address: Dirnismaning 55 | Halle 13 | 85748 Garching b.München
>> Postanschrift: Rosenthaler Straße 72a | 10119 Berlin
>> Registergericht / Registry court: München, HRB 269168
>> Vorstand / Management Board: Thomas Lambertz | Tobias Madl
>> Aufsichtsratsvorsitzender / Chairman of the Supervisory Board: Hendrik Hofstadt
> 
> 
> 


