Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79BEC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzsMA-0002U0-TF; Fri, 28 Aug 2026 04:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzsM5-0002TS-RL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:54:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzsM3-0001kJ-Ii
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:54:33 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S66coo2762015
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 08:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ffIaMdrfmc4B1cgkDM38qrl0HtGRsUEcSfu/QN17YLA=; b=krwAtGqyGsif5imJ
 B+cM6oXoPRG5R0V2EDIZcr/EvzsmhcRGcO2aVGl3/r0rsH7aRQYJXvXGBISCvPiD
 bfnKMyxVi1M31hTF1mwm0e1paQoKv8FcZw8yLlwaLetiunRC07XOc+XEE5lvZ2Gi
 nH/EXUWSNHHBn8g5Ltd96vU6u8ASzt1MV3EMGg09tU/PeUGi5xH0OzUqRK0qBId0
 6L5pblcBqruheZMcSkksXCUpKPeuhKEDx5z+Xxjy1nKlzLkfM4U+rEl4x8j3NdQe
 0EGwOfUNMEtXPb5zyCErd5ccUwNbtEnaPrxjwYlH3atmVAarrtmap2niY7f+6D9O
 UwDC3Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42p8t32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 08:54:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90cddf4f59eso8670586d6.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787907267; x=1788512067; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ffIaMdrfmc4B1cgkDM38qrl0HtGRsUEcSfu/QN17YLA=;
 b=Kwqa/JJXbiEtS3SGs6UcU0S04gRrHsIDhuFxUv3m9tVA8JuI0Onwf3/sIp6cnA34S5
 scM6ea9ux/SFLZbUuY7M1J3etMS5STGExy/tuzEKz6QGkef8uWsHKFZQWcdIcIHKTJy/
 wtz72OEhgFPetXH2C0w3TvceipG8ZmZG3uNYjeW5slVjGqfSfHcKIRUyBIuEw5+SPRAJ
 6i8FCznJVC99p+yxImRyAbaSUgRWbxEW3U6vQk7fH6pkOLstFtFeCXdyOTMMpYlivYw6
 dqdfkUGaP4wpDuf8j2hiVY4uuxYlbxVyXn9axj2UOdyH41GEWpTkgD8YA420tGqKZ4p3
 kF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787907267; x=1788512067;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ffIaMdrfmc4B1cgkDM38qrl0HtGRsUEcSfu/QN17YLA=;
 b=k5Sq6q/Q1YFYEAg7aY6k3KHcIM4HOUni1eoouYeifRBfrRfdTS9tT4d8RRLkMzRq95
 tW9aaxGm1hfvsmZrU0g9b499nDFJg/8kFOJ1/lhMhDc4L0/YNGVM2ayfPzu0CodfXIr5
 y3k3van6xfiodm0aFW0SiGET1UQZOmrSkNZao26fBnjeBsgsd5fFyFoIQof3CObKO7eW
 DAwaW5E0In9reE/qSMAZNcuxmwuPko1KjjjLu2AdhnHgK4QR/d6a58x8i/SFcEif+OP9
 1wRDmDGMLDngC0eTDKqaZ6dP+w6BZWshU1+EHvipBXFzvffzLHTZG16gJwwn1wwQlJeb
 OnqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpwbct6frhR/Gbyc1omALfj+z0Khlp0FWx5xgwqQcWVCR2wIWaTlhQn3Rq1BwHUs9GqlB+mjAxgHkcQ@nongnu.org
X-Gm-Message-State: AFuF++lsbdGb89438zLMdx33XpE4mmQOZy2fel94BtDLqtp4YVBSdsKh
 /jjrXpzzv2Nym3NdTWR/lKiVUpbZzS52FdwSY1Hy2ZomrTDmOzyi3cpj/6eQWiLIVAQs6yzmu3o
 PXgFz0gUE2samqPBrvQUs9juevwODBUP+u8TyRnem4vhRxrlH89Sj/ytuyA==
X-Gm-Gg: AR+sD12dkt9MsUoCrY6ROH278i5ukqB+TnvStvPP80VMMdnRKsK3BbcGcJ6P12y62i2
 oJAgw2zPS8VcrqVrf27m4TxqSG2EffOWHk9E3n3RrgpNmlxtZScjhaFtSj/+UzRdy+oYOzA02Ff
 GhLog5lLOkOIrSuR+sRKrWgFmFYBmQh+AlJdj6Xdkgthkxa9W45uRvf4jxNKqhH7vrH+ihLLMO0
 vZm6eb/XMDZMZFGIDmLImULgKyS+K5WHelHRZTTLv2GlZtvNYUg3qaV46kgNk4MvrhCoBXdl8Qt
 91M4222bHwsg+16RGCAf1bkfX2IjVnYAWukx0D2kHnqPnNitxl9mfW12+r++jTc4ysEvKQ4hoTL
 TOGJgsCWw66aVz92NOP0qrac0mV5eHl3eGg==
X-Received: by 2002:a05:622a:598d:b0:51c:1bcd:5cc3 with SMTP id
 d75a77b69052e-52fb96887a9mr59315771cf.25.1787907266669; 
 Fri, 28 Aug 2026 01:54:26 -0700 (PDT)
X-Received: by 2002:a05:622a:598d:b0:51c:1bcd:5cc3 with SMTP id
 d75a77b69052e-52fb96887a9mr59315471cf.25.1787907266202; 
 Fri, 28 Aug 2026 01:54:26 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2072csm2171408f8f.23.2026.08.28.01.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 01:54:25 -0700 (PDT)
Message-ID: <f4cde0b6-ddd8-48b8-a63e-c32dc1bf384c@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 10:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/display/virtio-gpu: introduce virtio_gpu_{simple,
 virgl}_resource_new()
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com, berrange@redhat.com
References: <20260828075308.3882813-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828075308.3882813-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jKiFVj2b_dEQ_lngj_v1kY94_96FG3Ij
X-Authority-Analysis: v=2.4 cv=ToDWQjXh c=1 sm=1 tr=0 ts=6a914cc3 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=YxxACPZ4BP4DdAB5bJsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: jKiFVj2b_dEQ_lngj_v1kY94_96FG3Ij
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA3NSBTYWx0ZWRfX5px1kpXplgTp
 we718pYw2q7xGFTkZJDilkYzLj6jQYPjcnlQr8noF/tt2JS0Ev7fm90l3zmnF3xW7lEilDfA0Y4
 EA0fACyatyVM1TggH82Ky1yiR0Yly+M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA3NSBTYWx0ZWRfX3HCThvZs6TfZ
 LIVaj9kZZTLDmzHDIIlgTpGeiGvYzGGRe6UmsZMBMtWsUGXV2R6lCfcyNIWbw/J2KYwsUUWMrxY
 E1BaWCfOccc5zja8z7CynX4y2z+wbSi4ttEBhH09zPjrlNxWN1TdW4m7UAMP7UsRTMBaJrO3DIO
 UNc+zS830IgXiydwlKV15Hz4gf8o18lCKctIYNUiHJFqTbIhVw3Nycd4bZXVdOrnNF7dX1peoXz
 0K1ttLnsI++nm+I4LHfGukEZd5EubURpDbgsJv2ZoWHsjT6LdHGmbn/9cZhSojg8yGVe+tGF5Oz
 0OsIo7vjoQXg0lC75N+eaYzES+NumntP4oEcQ//2rYtfOLkeezZ0PiY953TcjajpwbH6CxfqDs5
 d+RKF+IBDeMeXIcxOqiTCVMPEBgjLa5L+DwxIvEgXyiaM2tj69oW0WEpfabEiqSqgGc0icKfMKq
 2uvCH1OU+HVE92RlPzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280075
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

On 28/8/26 09:53, marcandre.lureau--- via qemu development wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> All allocation sites used g_new0() which zero-initializes fields.
> However share_handle must be SHAREABLE_NONE (-1 on Unix, NULL on
> Windows) and dmabuf_fd must be -1, not 0. Centralize allocation and
> field initialization in new constructors fix this and reduce code
> duplication.
> 
> This fixes -display dbus with virtio-gpu blob resources. The other
> end is currently receiving qemu fd 0.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   v2: add virgl_gpu_virgl_resource_new()
> ---
>   hw/display/virtio-gpu-rutabaga.c | 20 +++++-------------
>   hw/display/virtio-gpu-virgl.c    | 34 ++++++++++++++++++-------------
>   hw/display/virtio-gpu.c          | 35 +++++++++++++++++++++-----------
>   include/hw/virtio/virtio-gpu.h   |  4 ++++
>   4 files changed, 52 insertions(+), 41 deletions(-)


> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 9bda572426b2..d32801c3893a 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -309,6 +309,23 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>   }
>   #endif
>   
> +static struct virtio_gpu_virgl_resource *
> +virtio_gpu_virgl_resource_new(uint32_t resource_id, uint32_t width,
> +                              uint32_t height, uint32_t format)
> +{
> +    struct virtio_gpu_virgl_resource *res = g_new0(struct virtio_gpu_virgl_resource, 1);
> +
> +    res->base.share_handle = SHAREABLE_NONE;
> +    res->base.dmabuf_fd = -1;
> +
> +    res->base.resource_id = resource_id;
> +    res->base.width = width;
> +    res->base.height = height;
> +    res->base.format = format;

Seeing v2 maybe we should only add a virtio_gpu_virgl_resource_init().

> +
> +    return res;
> +}


