Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ED5C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH2g4-0007sl-IH; Wed, 14 Oct 2026 13:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH2g2-0007rd-IK
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:22:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH2fz-0004Y7-ET
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 13:22:05 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EGZjkv3468940
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bem+LxRUYmIOQNTbX/QX3Xrf/i/l0R0YUbLzjY/AllM=; b=MkukNoWhBc+e5htx
 QYJxnT7F/ltcmii89zQt9whktK+2oREyn7VWLk4mSx39EWVjUxAiJehfYDwfS3II
 dJQvtuB8+X8/T1OzJUDMtsJpbe1+rnsw4jXRfuP7CFIWKOB97Sijv3mlCamHSdfS
 Xwh8ktkwCmQoFKpAJ6pruWPW8vAEBTkl+UjqzDIiBVMKA08yiaX/g9MQwo8EUOUn
 Tr1ehIlZ5Dxge2jmSrxqUuWrVP/nb6LPWbXF44nehntztHkKQxwLopxTocr5N3/X
 m8McaZfJcg+O5cEUjqvvfGqH5ZKNDRRFjZzfoGNY4V1lnDw99vCCr4Ac7LkGyc3F
 LziXQQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd785uv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:22:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33713e5e6daso6453499eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791998521; x=1792603321; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bem+LxRUYmIOQNTbX/QX3Xrf/i/l0R0YUbLzjY/AllM=;
 b=CiNGJQTTPKLsirt1TDolQf97iitKr55fNYkynu+BZ3UgUoI/dY5gyHT3jAKaDZMJyk
 iXtVaBELWhdhxmmUaBIJ7QIrLc4gS6jOXTwQTdjpEMLE1sMyhHn+Z8EKc3EI390pPrRS
 CTr/+EU03WioOvqFB1BuqVJ3hfs+M5ue4ANdHJxc9f3KSieY0SV/lkcPuQcKurQ20r4R
 ajaQcmG3sUsHYPE3dgaXzNdn66iFGOmFwfZnP9z/qj7Az5GoswSNTfBMpYrCY/q32h92
 XzE36+4wPlchqxl8UgnyI2Va3XNYj5WlytWHtDXstofSgfY+zZ8jD+NrwDfEWkeoQDXX
 29Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791998521; x=1792603321;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bem+LxRUYmIOQNTbX/QX3Xrf/i/l0R0YUbLzjY/AllM=;
 b=fSgs659Xl0boQhVCINtSThZ6HTW4zdSmtBSdcufYcSXbA/VFG4SyScjYeOKTTwxEAb
 URF4eaeufs0JfatqqR+nTViWnGO/qnf5YdhsJJY0IKTY60dAZ42rYE3WjNKYWOXc/G4N
 6lp3lfqPtbgdC1YOo6f/qKUcBzNpdDT0XoHneTHf8LY0aGGf1BaTv9hin4yaeK2FBtzq
 y2aEQ4yJL130ckfMrhXOxn4a4n0iFrUp2zp8HTsfxgfgWYDdPSU1Eafo5I+bmNMIwZrz
 x5iTXaaTixwlBeCripvfqfJE1v4m5dknBK5Urplinh4Om5V+Kkj3P6KAf5Wtb6TeF3Cd
 FB+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEQ1W0xWHPHB+3rsVdMc0YkV+YLcjvo5Wn/LMPjDY/gkxqEJCzOhSvelqK2y9DptceujiwAiHGvrZu@nongnu.org
X-Gm-Message-State: AFq9FYJYiK0WXEBowbqqE9V4vuBOJoaAlnTg8EuX+vlcvhyXnv476Q/+
 hYBR380GMF5UhaezvEf27s0BOVZg/Ix2YfnKACzebQahhkcWCoUEyewpuJmzVw6ohoVcZvybJk4
 0TEWDjs3f1bYCNX/rCRFzCIPN7wJ2mfZIuv/u83gSLfO0OFWdhfFy2tsIFQ==
X-Gm-Gg: AYBFou0JQEV0kg+mX2PqvhdlbMF3Z2oWBFxpkDy3lvaJNkJQ7brW/rsV5tEgzIJyf7c
 6+0x6J1plfqmCgC9IvfrA44z3Ooqxmfg319xMm6fDq9RvfdEUgdEsJfZrswehSpbRSDETo961tq
 rfWuhgFRtV9/bNt9Y6hA2TOlTxoaM4qUH5QZ5j1iVyc0U8RQ8m+uNJZBEiD3HtqdszuPXmQsfz0
 KEBUzF/cy1t8UR/oLDdk8Y6cvjxabggWvcSQKQIJczQauIZOP3yxfn6f8gXWspd1AOrL5nBI/Ib
 qcj9mmauK/vJYr4mRBgfzfc/PUpyyXv9FSrSCnLZY/7sN3uLwPD2Ba8EoaqUyuhj6cJcq2BoMuf
 2kM11IgrqH41pJ10Bhfbs675k31acTKbQM9r7ydDusvQHtTrD0slg8kpZ/ATaNq8Z1fcyyw==
X-Received: by 2002:a05:7301:9a93:b0:35b:2d66:942b with SMTP id
 5a478bee46e88-35b2d6697d3mr11847162eec.13.1791998521092; 
 Wed, 14 Oct 2026 10:22:01 -0700 (PDT)
X-Received: by 2002:a05:7301:9a93:b0:35b:2d66:942b with SMTP id
 5a478bee46e88-35b2d6697d3mr11847064eec.13.1791998519998; 
 Wed, 14 Oct 2026 10:21:59 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm60664206eec.17.2026.10.14.10.21.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 10:21:59 -0700 (PDT)
Message-ID: <8f2da1a8-25fa-4773-a9f0-1da56c0d29d4@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 10:21:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/34] hw/virtio/virtio-mem: Avoid call to target_info()
 in class_init
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Eric Blake <eblake@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-s390x@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, Fabiano Rosas <farosas@suse.de>,
 Song Gao <17746591750@163.com>, Fam Zheng <fam@euphon.net>,
 Markus Armbruster <armbru@redhat.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>
References: <20261014094224.1976-1-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014094224.1976-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6acfba39 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=OEecPaBRvUleK0BGN0QA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: lmy-qLYdXt2kBWbO85Q-qhokzzMhwH2e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2OSBTYWx0ZWRfXyDdzZX+ouiu6
 8HskaqDZ/F3bSQ/bhXEr/bfotsbuQuABu4Y2oadoek/AknEapP4LEZl7YHl17hCCujti/R2+E13
 cQeeOHrH+PTfjqNXQjaEY8l9KacHpZzvZCg4RvnHjRFwHCcHVXOzr+4mvPNg2Sk6MOyq/OeXYTE
 AldtNz5+N2R4dedMWs8ggp8pAAz597pm4KdvrIOi2XeHeVjGSGUHOKkG3XxEjBTJhIA9lRDdszm
 0i3YHm/YmPnlZogjQW4ED6gdCqfjfUVL9ZkbhgiP9Di9YXGeJHu0k6e0umO3kjz55fgOJaCH/G8
 N+NNb0KNWB2rxIvFoMNlO5I9zwkcha7hXkq4wToYfuUm8xkv7AXz8VS+uldep1LyHgd2GsnB4ub
 Pr4ago74sgt/PhtRmD4u3p77RsbxLS9jQm4KXxIUEvdkhxd4cJYQxAdHYlo/4FxcVpTRLJPHxVq
 yUYocnY+Uy3pxbkEvNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2OSBTYWx0ZWRfX7yH5EnsthsBV
 smOIj3kIoUPxk5Jnoag/qVTB1go0ai2MrvCdvzw2yDExelGhYElR2/zi3rHJqHJMoyXvqpKBmWh
 tZO3QGg6Yf7EiFGFYkAIIPWrAkgGnBM=
X-Proofpoint-ORIG-GUID: lmy-qLYdXt2kBWbO85Q-qhokzzMhwH2e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/14/2026 2:41 AM, Yonggang Luo wrote:
> Done by merge virtio_mem_legacy_guests_properties into virtio_mem_properties.
> As we already have vmem->unplugged_inaccessible handle in virtio_mem_device_realize
> So we can reject the wrong option in virtio_mem_device_realize, then the call
> target_info() in class_init no need anymore.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  hw/virtio/virtio-mem.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index a4110d61312..81e2192c2fb 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -879,7 +879,11 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>              break;
>          }
>      } else {
> -        vmem->unplugged_inaccessible = ON_OFF_AUTO_ON;
> +        if (vmem->unplugged_inaccessible != ON_OFF_AUTO_ON) {
> +            error_setg(errp, "'%s' must be 'on' on non-x86 targets",
> +                       VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP);
> +            return;
> +        }
>      }
>  
>      if (vmem->dynamic_memslots &&
> @@ -1568,9 +1572,6 @@ static const Property virtio_mem_properties[] = {
>                       early_migration, true),
>      DEFINE_PROP_BOOL(VIRTIO_MEM_DYNAMIC_MEMSLOTS_PROP, VirtIOMEM,
>                       dynamic_memslots, false),
> -};
> -
> -static const Property virtio_mem_legacy_guests_properties[] = {
>      DEFINE_PROP_ON_OFF_AUTO(VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP, VirtIOMEM,
>                              unplugged_inaccessible, ON_OFF_AUTO_ON),
>  };
> @@ -1635,9 +1636,6 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
>      RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_CLASS(klass);
>  
>      device_class_set_props(dc, virtio_mem_properties);
> -    if (virtio_mem_has_legacy_guests()) {
> -        device_class_set_props(dc, virtio_mem_legacy_guests_properties);
> -    }
>      dc->vmsd = &vmstate_virtio_mem;
>  
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);

Not sure what happened with the sending, but it seems like this series
has been split in two threads.

