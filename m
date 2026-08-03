Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8F9C55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqr7e-0006v8-LA; Mon, 03 Aug 2026 07:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqr7c-0006nE-M2
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 07:46:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqr7a-0003ee-IV
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 07:46:20 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673ArIcP005487
 for <qemu-devel@nongnu.org>; Mon, 3 Aug 2026 11:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 97YBUTkzaCGGhd46/AGc2JpLrXpIsukTRNZG/Jth9C0=; b=X6H2zBJajhOdEWGV
 O4zrO7RDJXtbzkN5Qq6+NSFu24jIq4HJiSI7PhQVQxvZKaemyK/0y1waqlOPq7x9
 13+nI/Ev1xRNt7rzi+PsfDNB9oNj48qgxNoaBwClOMaIAWrDOpDRUzS/GOsebXVU
 414v9nS2cdn/l4sd9uQm//gjZ7ZNy15nycSnh2L4WlqVrvs9DRFknUUeCFlsifp1
 saFsL9kG+FM7encgLr9YgF0WtPHBRNy3ESzCRWfAehasQGD2HWN/kxavWEJNkGP7
 Lqs5HuS0R5snb1nphwrtjlrjwFjI7j7WUIt6/9TfDrx1/pA0S7BMXlK7U86+iyJQ
 mmQEqQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnj79bb9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 11:46:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52827090cc5so34118811cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 04:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785757576; x=1786362376; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=97YBUTkzaCGGhd46/AGc2JpLrXpIsukTRNZG/Jth9C0=;
 b=NJEACxg4ueeni3Jj+kvu84qYkno4jz0njECg61KLFs4+AEop5H0UUUMOrrXk2vgXx/
 MRKx4H1zjaH08TWkZo3XjKibaDoL5uvsfg1H0vMHPz8zMeY/DjC2lz4mbpBbB+NM35P+
 fYbIxbRaF+rpdaFWc1F9dT2DyJvY1sBeQq2McqXVyZ6UTi9TtKuGchLBQ46DAZalKiG2
 m2QX2nbI+SYibYYj5f1w27MUvYk4HcwU0qdEg40jx+hlakPtbDJTrpbQRCBMzPX3AWGa
 /DGjlHrO1m7bX9hPm1BzkXxYebOfwUxFUIlD9raHXAZyfAK6mhtEPAaN9iivLJ5sJ1za
 wCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785757576; x=1786362376;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=97YBUTkzaCGGhd46/AGc2JpLrXpIsukTRNZG/Jth9C0=;
 b=RZyL/nRGG2L+AUL6UgYKDCpvyGMbyED+IKS4dSNjG2TofwZAw1KOKcwvl9iqHkP9ky
 UMDWJI3FQA41DdUmsXBNjIeaK7br3jqFclzuyfHwWNQKtGVGoEcFvUmgOgMBz9U+sNsh
 A+iIzOBbWoeUQDTvQYz3MoL4SbrriDDFyBBRAsqomxcC5Ae557u8DIvh/NSj5v6GQeE1
 MijgCRZVxEb2CAa0+fpSt/PxdgFB1IKnflbmsO5LSlF3HIv90iAXFHdD6qOKwCx5D7vN
 7lPLZgxOx9LpMqJq4+Namv7+0WTSyPtuEjJhp28LKIcJE/Qe013aHI4+HLLKhmjsQj6Q
 7X5g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rri9PcW4B/iDpF1FoU3g/GFl94Jektbc2R39gHOa8Ig1ddm8Hbn3Xuk4mVYDPAPUxD2GVYq2z0DVgAl@nongnu.org
X-Gm-Message-State: AOJu0YyjIVCYgppgumKM+7E0l+2Q3e2sILYFN48QBdSR69T9BCGxXYgm
 SiB67e2Oou43lXBBd2kW61x18Ro5o1+A5Fvc9c3e2baWH4BFPguBv6qqYMkaOwqwqyrh2qw/JeK
 9mT6wrrzKXNqsEaXcsjiRNmTHOU4jzihfZ46WI6rsxgGXWzyMt4v85H/++w==
X-Gm-Gg: AR+sD13hBiToCZV+0kLHXitY7SV+YAR4gWsc87R9sW6bTErVd2Jcej18ZoYtgohH/gi
 t/UcARLq2lp4VceEwN7vfWgiaZaMbKklTM270BCKyBlgduGenv8yjf3OI6bRhbMUpx4jmCcwo+q
 RfInxrkLNdZSul1D5dpwQPw1sRM0K85pzwBbUUyinZVOr6nUDA4Pm00HjLXWv+/nTSP7wXm4dyz
 qHFVgB1fCkFm/8JASnQp8cgL8l0HOtggwiJSFKfW0fs9txO/4hS8xWOk3jOHJMjJ/0LJozArlEW
 TMHCAu+OmwJGUaMFRSOzO/FMnuAgjNTrX71qwGxGGf81CYuTTuTjYT9K1SwIo3F6eKRiBJKUGgy
 J/kT2D6LrAz/Z396IvCG0daMV2mmQSwG7StZUv+iCuwz5b1ja9B4=
X-Received: by 2002:ac8:5850:0:b0:516:d83d:b28 with SMTP id
 d75a77b69052e-52b4c5ac831mr170095561cf.17.1785757575595; 
 Mon, 03 Aug 2026 04:46:15 -0700 (PDT)
X-Received: by 2002:ac8:5850:0:b0:516:d83d:b28 with SMTP id
 d75a77b69052e-52b4c5ac831mr170095061cf.17.1785757575099; 
 Mon, 03 Aug 2026 04:46:15 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807bb45ebsm161415435e9.4.2026.08.03.04.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 04:46:14 -0700 (PDT)
Message-ID: <faa6229a-b944-4a66-8f2e-fd06b3044588@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 13:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: Always reject invalid scanout
 bounds
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260803-scanout-v1-1-c9831dafdab2@rsg.ci.i.u-tokyo.ac.jp>
 <f18b62fc-9efe-4741-af01-5190f902165f@oss.qualcomm.com>
 <2579e4f0-d557-4061-bc0d-7c1592705a82@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2579e4f0-d557-4061-bc0d-7c1592705a82@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ow1Lq0AvTTkdjjGRW-OdAA4FvYqH5obA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwNSBTYWx0ZWRfX8b2eihz+r3Fj
 mA1L4NdFEEyKk+O9zC2JcpHRGzxX65p3rzQYZ/79O9hIHNw5pVviHLkd7VjwlRL7Bq63jlw980Z
 iMxR4BYMB7gla/IozPZNwYUXO3LXRjlLguYBWDQLcIjxDd0S4QcVQJjJr6193GP6EukTcuZ9Pk1
 cFoE63p8bKlDMVkXHz0ktKDTn1q9DTR9sVPwp3x8G5ekzIQli6Bedjm46CG/70fh7fFEqO1TAUS
 we7dytXuGsQPl64DgR7n5s7gpgN7X9d9p0jftC5UnSic638liJVcXvJ63ZVAzQE0io+vkp2JPMq
 Bx0+kbpkQMCmjrYzpEySbktHa4Ast0JW3TU2okN5+WmOg/zhPMENsjSif8uvjg+2fR2tWBOAlBh
 MNXD/NL6RF2mQ21GNtlhqfKlg0EP01WzdjBCogNxSrd8QN04bP8iDXPrs2rjmwIrTPWYATnrBFp
 LzQ1/JFLZvC5m/rLRow==
X-Proofpoint-GUID: Ow1Lq0AvTTkdjjGRW-OdAA4FvYqH5obA
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a707f88 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=EZRpUE22QLhfCPDqwUMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwNSBTYWx0ZWRfX0ZLmYzYDLO78
 KjzDukEzRwHxdK+pU4qEjYjcjciv+wVaItSVwOUs+Z4f06ucsLrW29vyEPJMZSYKMN+sU6QsnFp
 aXNXQlCDI3hGZS8Dyr4Ck4rpIexcUUE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030105
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 3/8/26 12:32, Akihiko Odaki wrote:
> On 2026/08/03 19:17, Philippe Mathieu-Daudé wrote:
>> Hi Akihiko,
>>
>> On 3/8/26 10:45, Akihiko Odaki wrote:
>>> virtio-gpu does not consistently check scanout bounds with wraparound
>>> handling. In the unchecked virgl SET_SCANOUT path, guest dimensions
>>> reach qemu_console_resize(), qemu_create_displaysurface(), and
>>> ultimately qemu_pixman_image_new_shareable(..., &error_abort), so an
>>> invalid rectangle can terminate QEMU. Implement a check with proper
>>> wraparound handling and apply it consistently.
>>>
>>> Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering 
>>> support.")
>>> Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
>>> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
>>> Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for 
>>> gfxstream")
>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> ---
>>>   include/hw/virtio/virtio-gpu.h   |  5 +++++
>>>   hw/display/virtio-gpu-rutabaga.c |  6 ++++++
>>>   hw/display/virtio-gpu-virgl.c    | 20 +++++++++-----------
>>>   hw/display/virtio-gpu.c          | 36 +++++++++++++++++++++ 
>>> +--------------
>>>   4 files changed, 42 insertions(+), 25 deletions(-)
>>
>>
>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>>> index 4d46a4eb10fa..3c0e38c1def0 100644
>>> --- a/hw/display/virtio-gpu.c
>>> +++ b/hw/display/virtio-gpu.c
>>> @@ -622,6 +622,26 @@ static uint32_t 
>>> virtio_gpu_format_bytes_pp(pixman_format_code_t format)
>>>       return DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
>>>   }
>>> +bool virtio_gpu_check_scanout_bounds(uint32_t scanout_id, uint32_t 
>>> resource_id,
>>> +                                     uint32_t width, uint32_t height,
>>> +                                     const struct virtio_gpu_rect *r,
>>> +                                     uint32_t *error)
>>> +{
>>> +    if (r->width < 16 ||
>>> +        r->height < 16 ||
>>> +        (uint64_t)r->x + r->width > width ||
>>> +        (uint64_t)r->y + r->height > height) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d 
>>> bounds for"
>>> +                      " resource %d, fb %d %d, rect (%d,%d)+%d,%d\n",
>>> +                      __func__, scanout_id, resource_id, width, height,
>>
>> __func__ will always be "virtio_gpu_check_scanout_bounds", maybe we
>> want the caller instead? Otherwise simply drop?
>>
>> Since we rework this code, in case we are debugging broken guest driver,
>> it could be more helpful to log one LOG_GUEST_ERROR per error type:
>>
>>      if (r->width < 16) { ... }
>>      if (r->height < 16) { ... }
>>      ...
> 
> I don't have a strong opinion here, but if I'm debugging a broken guest, 
> probably I would use the printed function name to look up this code and 
> then figure out what's wrong by comparing with the actual condition.
> 
> This applies to other instances of LOG_GUEST_ERROR; ideally it would be 
> nice if there is some sort of guideline, though I think people have 
> different opinions what such a guideline should say.

Fine.

> 
> Regards,
> Akihiko Odaki
> 
>>
>>> +                      r->x, r->y, r->width, r->height);
>>> +        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>>> +        return false;
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>>   static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>>>                                         uint32_t scanout_id,
>>>                                         struct virtio_gpu_framebuffer 
>>> *fb,
>>> @@ -635,20 +655,8 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>>>       scanout = &g->parent_obj.scanout[scanout_id];
>>> -    if (r->x > fb->width ||
>>> -        r->y > fb->height ||
>>
>>  > -        r->width > fb->width ||
>>  > -        r->height > fb->height ||
>>
>> Do we want to remove these checks?

I'm interested by your view on this, I might have misunderstood
part of the change.

Otherwise removing __func__:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>>
>>> -        r->width < 16 ||
>>> -        r->height < 16 ||
>>
>>> -        r->x + r->width > fb->width ||
>>> -        r->y + r->height > fb->height) {
>>> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d 
>>> bounds for"
>>> -                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
>>> -                      __func__, scanout_id, res->resource_id,
>>> -                      r->x, r->y, r->width, r->height,
>>> -                      fb->width, fb->height);
>>> -        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>>> +    if (!virtio_gpu_check_scanout_bounds(scanout_id, res->resource_id,
>>> +                                         fb->width, fb->height, r, 
>>> error)) {
>>>           return false;
>>>       }
>>>
>>> ---
>>> base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
>>> change-id: 20260803-scanout-c7cf28c1890e
>>>
>>> Best regards,
>>> -- 
>>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>
>>>
>>
> 
> 


