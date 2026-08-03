Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DDBC55196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 10:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqpkG-0004md-L6; Mon, 03 Aug 2026 06:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqpkE-0004mN-B0
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 06:18:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqpkB-00083T-EK
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 06:18:05 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6736ksDx4123780
 for <qemu-devel@nongnu.org>; Mon, 3 Aug 2026 10:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hx7ntfITOMH2ESpugt11z3S9ls72VsAZl+dLy4Xn4Lo=; b=GSxgMdUxPwmJvlEm
 qHBXQQ1INq9qr7+YezOp79mK7xsMaZFXV9IbDejPs+PDyOBp7+Yy/ncYoTbPL/ah
 zs/af5RmA/WmnF+NlKr03JgPTlA/ptChrbCqGoVgjCsBUjdu194XlDAN1LEneTp5
 AjlOytByNAjoeJIiHwT4F6K0Uwnb3eUNXP3krc74qLnkYgTrgsujKxQI8jmV/6r+
 058ZcD/D6ZmB3QTArUZHobNIDsRbQOvvtnx9A9QVFu37Gkj2+z3C+ZMaLe+XA6H9
 xW1hUxx1FgciHLKomgGFqyQJIKFUVKi2enC5lIhKzuaESjxBr+JmSU2/vADSCFrW
 3ZKdqw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftp168wrn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 10:18:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c20762d21so36674401cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 03:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785752280; x=1786357080; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hx7ntfITOMH2ESpugt11z3S9ls72VsAZl+dLy4Xn4Lo=;
 b=fgKyG6DsDYjsDkVzuyYnM/czYJhvBhMcsDwRLSjUnd8swj/rTYbz+ldh0044yBKrXz
 G71BMdGpQPzoZfMGDsrAvnJ3u8vWEqDZcUEFmWA/2PKdO560+miXTzovaXqk2+0QrJaa
 vky3izaBP7L/WIqm2kGDSoJiLXAWsSmV7AZFspZEaOTbJI6G6oKjH/2oQ/D9xPN/W59M
 krjlzlZ7z2UjeDqBtNyfv0oixnhmYIGbDPF/5lrmeHscedlLh+nPuFLRYsVmHzCuqOIk
 nzXzZSST50hBvJsnKzizFWi9zUMaTBhwK00wU38xUsbv+pOwecXzWX8CJb/Lw3StXhzz
 VXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785752280; x=1786357080;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hx7ntfITOMH2ESpugt11z3S9ls72VsAZl+dLy4Xn4Lo=;
 b=IbYakFJSgt9N7B0aSB1undJdTOIoqDHBFI1DXFzBuhjiurfWHffiPg2ZZNhJ6PvTeS
 oZCfEIbtTX5K1mT4pgSKuYPdL6H5f37Kwaw/GpDIlOqGJ3Z3rtkOTqTtUWGuBfc3sjTZ
 /U4lU4ZpRykO5uQ6z0olx6r603h0+Ny/dYVNDqQZlC4CYbx1tCcqjZTQjeEf5ke64h+v
 Pw54+7A2KzE4iICa/cGl/YB2s+WKRXxFoyEtA3/p/rCyIEd9vZRtHKsH131bmb0LEm5G
 suKbzA0WvrO3Yok/9FOFAmQknD+kVdO+oIiCTIupCz3BnQPSzdJEgt2T3EK0FLVl5nMi
 VmaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RohEWAzo/TkR/NepVziG0gfgrsvrOX1NbcWNfPwF6ykKuQFEYlIylKEpXfMBXY5gVAxmPA/0LJng1k9@nongnu.org
X-Gm-Message-State: AOJu0YySJplJJRrCZ2YuwvSBzz+QypGTSF8OKT8WpuIN81S8TsVGjUek
 DuBIdYbVD9zmKG/oHN+tKFSyC0SQkWr1S/z1mdSxw0QnMUDffmBuNe2YQ+J13ISbSlLnSXnwVZG
 1rajEJwiPqaGjKEqrJ3eqmTulU/TllVa/c6KocEwKbCa1QA25x1zfcwOk/A==
X-Gm-Gg: AR+sD13ywZAuyNwyZZNjb3pab2yl1FQrvWtmBFcKs2OeNjMJL02zoSBKS3n6oumABBS
 up5rq01ZrShY2PP8kmVbRWQ0MqwhUbDyrNt9EGjWthAPSbF7vqYUNFD1ckfMMQ2TI+uYmInsPOu
 TUFApUSQmM9y3zFKgbMSaFrlsOmAWjqxohsXxXuXjVvZvfrxFx/l77wMUJgTcIkgV+ERRGmwLUG
 AuhqkOtPL4ApxSdC4Ztc78coaux6nHqp7qmM2/cWN+0Z0p6ddLU4p6nnBzBi8xV5GZN9C115GNI
 1jVJZ4e646e/SpjWYq3TxvkVfoi1VYizpIsNYIp30JdzdIGC+lkuyj/TiqAfZWpimqD1KADpSb5
 1EHp9x77MPWz6T1nupF3rfTJqPoa55lwVVCcp6bIpidmvH4F8r/g=
X-Received: by 2002:a05:622a:a08:b0:51c:2340:bbdb with SMTP id
 d75a77b69052e-52b5674fabfmr187814531cf.26.1785752279990; 
 Mon, 03 Aug 2026 03:17:59 -0700 (PDT)
X-Received: by 2002:a05:622a:a08:b0:51c:2340:bbdb with SMTP id
 d75a77b69052e-52b5674fabfmr187814281cf.26.1785752279514; 
 Mon, 03 Aug 2026 03:17:59 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2484sm32780935f8f.11.2026.08.03.03.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 03:17:58 -0700 (PDT)
Message-ID: <f18b62fc-9efe-4741-af01-5190f902165f@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 12:17:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: Always reject invalid scanout
 bounds
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260803-scanout-v1-1-c9831dafdab2@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260803-scanout-v1-1-c9831dafdab2@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5MiBTYWx0ZWRfXxm8pqwd1hbx9
 qy8WnGcobjS5d9K3eGXKsgqkbbmDimfNVki/D1Z060uUrwcrBvfkq1s9ApciqdL9zcHUN46b6/m
 uJjBn1sITqyUy6OJ+gMA3pAw6G5S4xruXxSGjk9h79QrtSRVXcVVhpqvrMFFKi54lJr0A5NNKrJ
 1A6zatP10ddJh66E0PtrpoFIy8FZztkL77dASJ3bTT4wHi8P0l+dZCTyJ2iEsJ3OQxGnMwLGMd9
 YdQdBXvkJL0NxLTIdB1obQM6dPb/OX8jYGIAps7cywmCNKiSbI1ZJIfWWjp12aN3MXVL33rLFUm
 YUa58v5tmzxZsR+BBzu41wCMdq8TpE/O+61L5nKReyCOADVfHyjrz5BbjPut/CPKlY0qjSfSpz/
 w9XreZjrzFjyU5xXsQ8TBnhBqlwuUPsBgg7oJ/eCLlwVY8xytpMVQhIRgDNLi/njtdOu8CMExMA
 lrMUGljBWGIARP4clHg==
X-Authority-Analysis: v=2.4 cv=Wpob99fv c=1 sm=1 tr=0 ts=6a706ad8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=du91pqLo5wgDQs5x_4EA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5MiBTYWx0ZWRfX8YgGwS1iBOCJ
 FQ7/b62TfJ3zzBW1Gafef+4wWvpmaBnUQYXg1X0K/nOjMQIa3eZWO7WtwUPin3OtgDb4GrskRpK
 MlEkwKcGGUFEDild6yO7Cz2DuVS3UHo=
X-Proofpoint-ORIG-GUID: q9sjfEPjur3ZY7XrxiCqSyG8bnjr5k4B
X-Proofpoint-GUID: q9sjfEPjur3ZY7XrxiCqSyG8bnjr5k4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi Akihiko,

On 3/8/26 10:45, Akihiko Odaki wrote:
> virtio-gpu does not consistently check scanout bounds with wraparound
> handling. In the unchecked virgl SET_SCANOUT path, guest dimensions
> reach qemu_console_resize(), qemu_create_displaysurface(), and
> ultimately qemu_pixman_image_new_shareable(..., &error_abort), so an
> invalid rectangle can terminate QEMU. Implement a check with proper
> wraparound handling and apply it consistently.
> 
> Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering support.")
> Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
> Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   include/hw/virtio/virtio-gpu.h   |  5 +++++
>   hw/display/virtio-gpu-rutabaga.c |  6 ++++++
>   hw/display/virtio-gpu-virgl.c    | 20 +++++++++-----------
>   hw/display/virtio-gpu.c          | 36 ++++++++++++++++++++++--------------
>   4 files changed, 42 insertions(+), 25 deletions(-)


> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 4d46a4eb10fa..3c0e38c1def0 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -622,6 +622,26 @@ static uint32_t virtio_gpu_format_bytes_pp(pixman_format_code_t format)
>       return DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
>   }
>   
> +bool virtio_gpu_check_scanout_bounds(uint32_t scanout_id, uint32_t resource_id,
> +                                     uint32_t width, uint32_t height,
> +                                     const struct virtio_gpu_rect *r,
> +                                     uint32_t *error)
> +{
> +    if (r->width < 16 ||
> +        r->height < 16 ||
> +        (uint64_t)r->x + r->width > width ||
> +        (uint64_t)r->y + r->height > height) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds for"
> +                      " resource %d, fb %d %d, rect (%d,%d)+%d,%d\n",
> +                      __func__, scanout_id, resource_id, width, height,

__func__ will always be "virtio_gpu_check_scanout_bounds", maybe we
want the caller instead? Otherwise simply drop?

Since we rework this code, in case we are debugging broken guest driver,
it could be more helpful to log one LOG_GUEST_ERROR per error type:

     if (r->width < 16) { ... }
     if (r->height < 16) { ... }
     ...

> +                      r->x, r->y, r->width, r->height);
> +        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>   static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>                                         uint32_t scanout_id,
>                                         struct virtio_gpu_framebuffer *fb,
> @@ -635,20 +655,8 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>   
>       scanout = &g->parent_obj.scanout[scanout_id];
>   
> -    if (r->x > fb->width ||
> -        r->y > fb->height ||

 > -        r->width > fb->width ||
 > -        r->height > fb->height ||

Do we want to remove these checks?

> -        r->width < 16 ||
> -        r->height < 16 ||

> -        r->x + r->width > fb->width ||
> -        r->y + r->height > fb->height) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds for"
> -                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
> -                      __func__, scanout_id, res->resource_id,
> -                      r->x, r->y, r->width, r->height,
> -                      fb->width, fb->height);
> -        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +    if (!virtio_gpu_check_scanout_bounds(scanout_id, res->resource_id,
> +                                         fb->width, fb->height, r, error)) {
>           return false;
>       }
>   
> 
> ---
> base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
> change-id: 20260803-scanout-c7cf28c1890e
> 
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> 


