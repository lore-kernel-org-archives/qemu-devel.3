Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165FAC531FC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBJf-00088t-Gb; Fri, 24 Jul 2026 04:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wnBJZ-00088Q-RC
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:31:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wnBJY-0002aX-1W
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:31:29 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4lbkT2125326
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 08:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9Ot0MV2DOB3SDCktdaHIXtOFbygRud+AUo2veWfWkOc=; b=gK8ak+qCZQRadFqP
 ooLPqrCnqhfzFP0O0NWbbiL30y6QSkhOF9PwIOuu4iVo/+e9sfnesXaKQ3dA7DkE
 9seqXhcjBQBs3/2Lfe9CMOwgcCQ7C3/yHPRr6RPCU3BVxGNi872yTjgor/G94aA0
 Koc6o8rasD9h19jd9Hpucrm43blh+IynQJNeNLzE27bSQNVssxGs/u7FUo57b9wm
 mLmBdn5o3XplQqeqv1sqPrtBdVf/+PCoXqftwvHhl4fGCIXWb0GMKqna0BuKGjoy
 Kw3Yiq/BEg2Ta9uBRPRgLfDRQfnrbQ5QaL/nbrsjXPyq21ydV4B+vOBfxbKLqGMw
 O2FwYg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqamttkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 08:31:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c26012cd0so2307601cf.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784881885; x=1785486685; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Ot0MV2DOB3SDCktdaHIXtOFbygRud+AUo2veWfWkOc=;
 b=UmZ2i+jAR8az9dDveMeAjIOsLuwA8noN7vIa83RWV6j5DwHV18gXmYkOvSVJwKuSXM
 YF2f5BmJl/Z3gVCqOhRiSNGKyxwJlyETEJKEUwYsoDRyhCK3vdax1OEBSWPW9116WQe5
 43qW3h6U4OIVZrqqPo7U/eAnqF8fTpZvMZS20FqO2PsTNgET7h2Jgs6ltMA71emwO4Ug
 dpdTT2QUJYaD7Gmy6cebWlegx9JmgqMrCB+xCR/7/pMOnsDOy8LM2Pi461rvcbzLADOs
 uoDgVh/rhjTBStHh6i+ntEoXlIkQuTwAKjqXrM57anWDPf5yifcZKPKT08U7OEF30+LW
 btSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784881885; x=1785486685;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Ot0MV2DOB3SDCktdaHIXtOFbygRud+AUo2veWfWkOc=;
 b=ggXwdjS29L/35QLitFzmM/0VSTP8qFsEDtcJ03Qoz6XvH8VzbhEZTMDZf7UddVuE3X
 VyU83Y2iEI5NA8vYNt5V6/qay1Syex07rDroTQweEd4J1thcYriZAxgfPPh4HILZbp6s
 uP08erJa5U3isJ6nddtnLt5odeQP4/i20j5mJsKCcXy5/Dk2fkc6jDHFWppi9EFRs2eh
 Y1DZ087wrCyzboZ4uuqw6MNXU39+d0yNmk8duxfqntmeFiuSTDSaDnP/V4x8Mok41wFH
 bCHo9sEgcqSSPaYVmPhcB595s4VknA5QSQ3Y60I0dcfk5WVZ4nO3sbWuRTcKFOzOtvbf
 lAcg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCWrMYymKYXS1FC93BK7bi7P+Tb5cWZQLPLESLr5WAf2iGH+Wet+JDBnvz1k9Z6lGBE9+Ixv0tcfmz@nongnu.org
X-Gm-Message-State: AOJu0YwoD5MlaaQZYmxGZfBWHIsE+01WRh05FFPZQu2hkALqtpcPIFhV
 ZYCWHhDR9sIid9gQAxKKjCFl+m5lUXg+4hfGfImE6wuPZ1Cb4lecn7O3EI75WfDVc0KhDYoase0
 LZ8TKKCbnB7a6d5x8zCkclmBRKaerM8ZZPlObGauR9qzrk9/33IcPbsMCqw==
X-Gm-Gg: AR+sD10Aoe0QdF/uB661NXu2o4RHDY6ki2za2/RI6L3lnhM8K3AlaLXFGFUhttAXvr/
 q+WGVLk79Pkb/u5HCAzSsh/cN5cn6m3CylH+cjWRdl+fB+TzlwHmVrDZMHIRZw91aOYclVaFEvH
 sTf6KbGL4A18qQ7GK51CkAWMpMIPdxCZLBIcaQiLrYtIo4J44xY5YhrOAeLHwGGtSOz1NascAkF
 TabeeXhL7I1qgZq0xjgYWnbKOiqkUV58paR5I1ZJ8t7O3aq3KgN1teQWHxtL8MWdBg0NvcXnWKq
 Yk3tKeq5GRA4xlT4mKFqN2IJh4NXBf//6/M61YBKkcZLOeFhmHwyDeXHNAgxEZ+4chH9iHAprS0
 yNJvxskVyX38Wc2NXwl51VA==
X-Received: by 2002:ac8:5a41:0:b0:528:22:8c61 with SMTP id
 d75a77b69052e-5283de53bbbmr60592331cf.38.1784881885267; 
 Fri, 24 Jul 2026 01:31:25 -0700 (PDT)
X-Received: by 2002:ac8:5a41:0:b0:528:22:8c61 with SMTP id
 d75a77b69052e-5283de53bbbmr60592101cf.38.1784881884773; 
 Fri, 24 Jul 2026 01:31:24 -0700 (PDT)
Received: from [192.168.1.138] ([176.176.154.185])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af9128fsm49599305e9.13.2026.07.24.01.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 01:31:24 -0700 (PDT)
Message-ID: <9ce8bdaa-70a3-4b8b-bb26-8cb84c5da857@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 10:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio-rng: Fix host use-after-free (CVE-2026-50624)
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
 Jia Jia <physicalmtea@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>
References: <20260708063944.1788243-1-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260708063944.1788243-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3NyBTYWx0ZWRfX4LAUg7kfZ+YV
 zMJb+e/PGuFFyM4KTL5XUqlHhgCxObLCG8D+H50F7ws8ydjywG5P0UqypVoDv1KoW9CDI8hHoJ+
 vJD8ophiocv4WAW0KVFc2eKWT+VOci6Z14+u8HEO2hEFKIPISZz1ULTeEcj6sjdfmmFr5GORvzQ
 swUjMftFo3UTe+DqP7bCJkO1bpNj0EzzjzarYAEb6qotluwLSO2ffy7Cf+vEEUVyM0uwchWqddn
 jbn7AXPjz3VTFrolWbwgktqa+DKQWJGsrTAqs6FEaLTKyoX5pwhDzalqbyFBd04ghPksM2Gte5B
 MwZ0xUyC8yDrY7K31oYe0TXheJgiu9kAlG040i69yu1ArQJRj9+tKsq9xzklq/poc+arElpLc/H
 Cy/Sro9HEKqfAUKaWs1+e7Z8NtL0eJFD0R6UAlKRC0Bl/iUyrAf2I4WM87IkdQukyS1Hvu35Dsp
 0odxTIfeHTRiQnp8V/Q==
X-Proofpoint-GUID: y5AhbzaGa3rJ9OfjgBD5X9WxwDfycI0j
X-Authority-Analysis: v=2.4 cv=DfAnbPtW c=1 sm=1 tr=0 ts=6a6322dd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=uVRRv9AK2fddTnT+2a2/4A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=ehhAyVRAbGlrGaafr0sA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3NyBTYWx0ZWRfX6Kp+nkh6PIlF
 t8/FE1VOQfQprNL9Pi6rFtPAKZOHl77SiUh1dfM+VuqR1D0bIXvGGrfYeqGrSlmxrXPy6F4q5+w
 95EHfpPMfIkxyFth81rjOJTeqgQ0ml0=
X-Proofpoint-ORIG-GUID: y5AhbzaGa3rJ9OfjgBD5X9WxwDfycI0j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240077
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

On 8/7/26 08:39, Laurent Vivier wrote:
> Fix a heap-use-after-free in the virtio-rng frontend when a delayed
> rng-random backend completion arrives after the virtio-rng device has been
> hot-unplugged.
> 
> Fixes: CVE-2026-50624
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3917
> Reported-by: Jia Jia <physicalmtea@gmail.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   backends/rng.c         | 16 ++++++++++++++++
>   hw/virtio/virtio-rng.c |  2 ++
>   include/system/rng.h   | 14 ++++++++++++++
>   3 files changed, 32 insertions(+)
> 
> diff --git a/backends/rng.c b/backends/rng.c
> index ab94dfea850a..182269be4a83 100644
> --- a/backends/rng.c
> +++ b/backends/rng.c
> @@ -68,6 +68,22 @@ static void rng_backend_free_request(RngRequest *req)
>       g_free(req);
>   }
>   
> +void rng_backend_cancel_request_entropy(RngBackend *s,
> +                                        EntropyReceiveFunc *receive_entropy,
> +                                        void *opaque)
> +{
> +    RngRequest *req, *next;
> +
> +    QSIMPLEQ_FOREACH_SAFE(req, &s->requests, next, next) {
> +        if (req->receive_entropy != receive_entropy ||
> +            req->opaque != opaque) {
> +            continue;
> +        }
> +        QSIMPLEQ_REMOVE(&s->requests, req, RngRequest, next);
> +        rng_backend_free_request(req);
> +    }
> +}
> +
>   static void rng_backend_free_requests(RngBackend *s)
>   {
>       RngRequest *req, *next;
> diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
> index 66690a34dc97..a77ea5ab1385 100644
> --- a/hw/virtio/virtio-rng.c
> +++ b/hw/virtio/virtio-rng.c
> @@ -234,6 +234,8 @@ static void virtio_rng_device_unrealize(DeviceState *dev)
>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>       VirtIORNG *vrng = VIRTIO_RNG(dev);
>   
> +    rng_backend_cancel_request_entropy(vrng->rng, chr_read, vrng);
> +
>       qemu_del_vm_change_state_handler(vrng->vmstate);
>       timer_free(vrng->rate_limit_timer);
>       virtio_del_queue(vdev, 0);
> diff --git a/include/system/rng.h b/include/system/rng.h
> index e383f87d20b2..5b0893eb2bd5 100644
> --- a/include/system/rng.h
> +++ b/include/system/rng.h
> @@ -86,4 +86,18 @@ void rng_backend_request_entropy(RngBackend *s, size_t size,
>    * deleted.
>    */
>   void rng_backend_finalize_request(RngBackend *s, RngRequest *req);
> +
> +/**
> + * rng_backend_cancel_request_entropy:
> + * @s: the backend that created the request
> + * @receive_entropy: the function invoked when entropy is available
> + * @opaque: data passed to @receive_entropy
> + *
> + * This function is used by the front-end to cancel all requests to a
> + * given backend. Requests to cancel are identified by the receive_entropy
> + * function and the data passed to the function.
> + */
> +void rng_backend_cancel_request_entropy(RngBackend *s,
> +                                        EntropyReceiveFunc *receive_entropy,
> +                                        void *opaque);

I'd simply name it rng_backend_cancel_requests(), and make the argument 
const:

   void rng_backend_cancel_requests(RngBackend *s,
                                    const EntropyReceiveFunc 
*receive_entropy,
                                    const void *opaque);

I suppose we should implement spapr_rng_unrealize() calling this helper.

For this patch (preferably renamed):
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


