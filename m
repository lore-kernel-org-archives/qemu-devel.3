Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD1EC5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpihy-0005lN-UP; Fri, 31 Jul 2026 04:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpihx-0005kw-9f
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 04:35:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpihv-0001JD-Ha
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 04:35:09 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V8XZJ63382652
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 08:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cp/RqiEqjShtXcIzeV2FMEUgaoztlVGs1VzLDa+6+yo=; b=ZXpdI4KqlqFBJT/4
 SbMrBoKqMPSZzKqKsdSUWkiDrdAEyuMeFKljm7FU5610qWl3PaJECw2Nvcz0Sgom
 DBp9XEhxdvd0NwiNFRoeWZrParuyp1fMxFW0RydGgQV+gUDtocdTggVcS+I601wr
 EzRILB1y/BE18y/8DNdYmC6ySPZw7eTwhGC8H5EY9Qe31wWcBOH/byxeVh52SkxH
 liP5xREdBzlng/7xSwszB39NgJxgziWddhLLVIcamm3/g35RFSTiuORC/LIKVRHY
 rPLxPsg8iJ8mk1nSmm8ASyIn2WtyE6DG+QhMMCY9nbxtW6F6CHo34WfPh9ictfMJ
 yXSVkA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frra70063-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 08:35:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso6646331cf.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785486904; x=1786091704; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cp/RqiEqjShtXcIzeV2FMEUgaoztlVGs1VzLDa+6+yo=;
 b=VSqHW2HXw9nwPRmNjsMF+cx4/JUARvxe4DNj0uU+1HoYVe0rPV6nKS1E4w7p4zoUl+
 /V9UewUsoQvTk1FBXAaIZmgKw1M2+GjYAiGzxvoNJdg9ajt9BUTVRy+G71z0D9RIr5it
 n5IYBwYtGyeiiDTHbbJJOInrNWT3L7CGWQUg5rmBYKD4YjB7xJL0Tz259KcxmFKDr+dE
 p/7oO3Jkx5STBhGd+8FpmBhvWB4cS6dXwoh1wjeekRPYA/xWce4R1xydIdKMZu4cxyE/
 uxrRSL5E/kKyKIgEGd+71xCuS7p02KdYmuOWJW/fxnj7+Sfrk8NMC8/0wC9uzX3bLnnl
 lhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785486904; x=1786091704;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cp/RqiEqjShtXcIzeV2FMEUgaoztlVGs1VzLDa+6+yo=;
 b=PQmCcIOxcMiCQgDz+ic7l126CP+/vFXLgoHSP7aH2QK3YfNE3AyF37No9tRP/Ve8wz
 OBb9A/Aj7WF91qw9s8AB5c7L4YKK41DR9bEX9fs5dzIbuGk+df6I0GA3O0hJbNJE08rF
 9hH7Qt/9kkc0V4DywfKsW+ygfI1WRcUHccQSNNjMORD2SJtQCal9BYCZ6UPn83/ZQuvn
 tMrZCaT/22wWF0CRTlCMW3IKkGFLNz3Ii/WPSwajI8dZ3FCeP5O3YL6TEvcyYLYyQCoU
 ZW5RDQ6IuEP2omJeRVLozzfcBm+H0D8Ef6BULP0cLQ5zaKBH5kkHyBY6InfElDO0M9cs
 5MsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqw1428qxU61vIO8D2Uw98oofnZtWi+F9qnI1A8revJpqDOe71rnD3GXG9YGV61sPYBQVabRI/JpAGs@nongnu.org
X-Gm-Message-State: AOJu0YwKRrlbxpr7EJtT30PYu80fNa/Dplwkaua1nFvkWyrI8F350/It
 CdzDAplH2ri82gFktJiKmX4CRA7Al3TG/llij1snZ5y/9nB5vI6q+WLqxH4Fh/kwcbcows4fj9J
 B8ziudBRM9YeP+6AxDY5vYaXSaAT+0TnLmDJm1QG2Ob2vy7MQBcXCOULY0w==
X-Gm-Gg: AR+sD113m2oUeuMID3YiU6YhwFtkdrjl2HzI01a5j7YZoG9rhxzrqJBGP6swrV+oGYm
 ncEySGTH83FlnQT1qnhlBkiYNnyHSsk2Xlai1Paas14gSyqaaX+1kKsh+/9P8axg4xrK/llW+Ia
 p8KFkLloKR1h9u/APex3vCVCxCj19ZHUN1RRuJNow90jITFHEGm+vyoebzM2FPouYYhq5cmX0U0
 FT4orAYDZxlB0OG5aDI6Ky6weN/K30X//uDtO6yXf5lJHDjp6c9jr9wDJzk7WbxD7qK63lncs74
 SwdDCWsh0dR2CNU0KnQwDsj8KRIzj7EUqK9flzzXu0go6iHjicjuJKojRIAKOpGdXx7LMN4XJ2T
 dRnqamMphhCT684nEfRV/ucHqNV3dNPaSn4oRPkQuqOnNH6iE+IU=
X-Received: by 2002:ac8:7dd0:0:b0:527:69dd:5413 with SMTP id
 d75a77b69052e-52b4aeb6ee6mr13425911cf.5.1785486903804; 
 Fri, 31 Jul 2026 01:35:03 -0700 (PDT)
X-Received: by 2002:ac8:7dd0:0:b0:527:69dd:5413 with SMTP id
 d75a77b69052e-52b4aeb6ee6mr13425341cf.5.1785486903379; 
 Fri, 31 Jul 2026 01:35:03 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd450d71bsm66135766b.46.2026.07.31.01.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 01:35:02 -0700 (PDT)
Message-ID: <eef9784f-5e68-4f1a-ba12-85ad4128116d@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 10:35:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] virtio: make virtio_add_queue() queue_size an
 unsigned int
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 virtio-fs@lists.linux.dev, Hanna Reitz <hreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Alexander Graf
 <graf@amazon.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-block@nongnu.org,
 Greg Kurz <groug@kaod.org>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Amit Shah <amit@kernel.org>
References: <20260730205846.19479-1-stefanha@redhat.com>
 <20260730205846.19479-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260730205846.19479-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2MSBTYWx0ZWRfX8Lh74guY0AqS
 iFoaK9wSSjPD5i+090+gXo3G5Zq2fWg5ZN6odbigcH+DuulSxWRK+7IyDKSnBihQ1955MMceuo6
 5t3XulBDRklDNSWlLUmpGKhH2UO7/XeOzNhmDD1IcMR6XabKy4tkHF0GxnbydMS3eyiwhRX2npl
 GZHj7TP90D5HiDbw2OI8N3k2dNK2G8O0ySa+LqahJmHW305tRy5uO9ZqnNz+N5Cd7unZuZm5zFF
 +FVJjqN4DLFGAL4feYGgZBGjlrAd38VFCbLvSI9x5fuEbqXralGi7mUsUJbX98RLT+5jw5I4A+d
 VCl634q1e2pL4GgdHLJ9noncwjwRBCPXYUhZYJtKXc4vW8SMWavTZHfI6RQWv4ogx2zxIvx8OTI
 wdKVcKyTJVc6a6EqMRXjjzyRwbuolFhwKt+4LP8P4AnVE7YClw+Z2J+4dW72MLnZVXZs5whu3cf
 iJ1LvvgkoALco7LBStw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2MSBTYWx0ZWRfX/fzhHASkLRfs
 2rpzc3VNvIj961sBKu4XtrghQPmkeewEPC92Dx83t7OP7+eYpGhfJNcbEJwMYbv6/B5G1JkL5WO
 ns0pp0W7gUk7/EEfH+CEhez7A6H8nuo=
X-Proofpoint-ORIG-GUID: uKNAOxzT0tACh1QoN6MePB3SMgcyGUpY
X-Authority-Analysis: v=2.4 cv=dsfrzVg4 c=1 sm=1 tr=0 ts=6a6c5e38 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=0-W2_F3agLd6ZuelXpwA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: uKNAOxzT0tACh1QoN6MePB3SMgcyGUpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310061
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

Hi Stefan,

On 30/7/26 22:58, Stefan Hajnoczi wrote:
> virtio_add_queue()'s queue_size argument is a signed int. The
> vdev->vq[i].vring.num and num_default fields are already declared as
> unsigned int, so change the virtio_add_queue() argument's type for
> consistency.
> 
> A note on consistency: the VIRTIO specification defines queue size as an
> unsigned 16-bit value.

Why not use uint16_t then?

> QEMU's device models variously use uint16_t,
> uint32_t, and other unsigned types for queue size qdev properties.
> virtio_add_queue() limits queue size to the much smaller
> VIRTQUEUE_MAX_SIZE (1024) constant, so the different widths don't really
> matter.
> 
> I have checked that all callers of virtio_add_queue() pass an unsigned
> queue size.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/hw/virtio/virtio.h | 2 +-
>   hw/virtio/virtio.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c99cb19d886..ff7f837fb92 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -302,7 +302,7 @@ void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name);
>   
>   typedef void (*VirtIOHandleOutput)(VirtIODevice *, VirtQueue *);
>   
> -VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
> +VirtQueue *virtio_add_queue(VirtIODevice *vdev, unsigned int queue_size,
>                               VirtIOHandleOutput handle_output);
>   
>   void virtio_del_queue(VirtIODevice *vdev, int n);
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index daa5607338c..e1210f024c6 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2564,7 +2564,7 @@ void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector)
>       }
>   }
>   
> -VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
> +VirtQueue *virtio_add_queue(VirtIODevice *vdev, unsigned int queue_size,
>                               VirtIOHandleOutput handle_output)
>   {
>       int i;


