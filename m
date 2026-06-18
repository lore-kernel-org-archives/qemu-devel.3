Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDCDCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9zd-00036I-2X; Thu, 18 Jun 2026 06:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wa9zX-00035Y-P8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:28:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wa9zW-0004i0-5X
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:28:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I8FauV1011270
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xFnw4aXbceA0vXrk9kfab7WvtQ3zLrHzHzzkGOm0o2o=; b=nRi6P/GHaepAhiSV
 FEv80YG9G1sLmqW3fQWrCTImKVtIgkE9425baig1Q/JMr+iHC0FLF4JTlquxU4DZ
 sWrgdyD4LPBDnDseKV350qSWtDOHqwNBpjuygTa+teOlQ+rmvLSJzJBhDGhfAyh2
 kL21+HTsEMUpM4QRbIqTn8Bw08CdaKz2VJl+0Te2YsI9AP08pBoVf6+fQGBRjZJ7
 pn6i29P+ksR7AQ/UPGdrAx8fqIm+T1EXETz+xU1ruRIQ49I1xZ91KZm/tl9uRXhU
 S21w+80dEqlzDXP9CigY3INlavkNz5s2Yv/3uwSu9uSmv1xNySW2PFvcwPgOfLfv
 lDrOLQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1rttume-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:28:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9158f2c4b55so156243185a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781778535; x=1782383335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xFnw4aXbceA0vXrk9kfab7WvtQ3zLrHzHzzkGOm0o2o=;
 b=blFZtQ+zRE31+ttTf7e/0ayas4jy2WqqkCa7cDlbJQpoAlMe4ftyXjHzmZsbufG/jE
 8gZK8Vwf5lS423qnSU08Uyes2KSxmUDFaHyEMbB/eFArT/nWio1H9rkIx+cS+WLUmUWQ
 6h3sokV+RpKPLCf4UQ5jqNCn3PauDKPOfn+mIY6OZoSZSSWeKVYsckw4vI6eauLpVHZp
 /ekoa8U2Lt8ZDuwOtuX/MSbAcpJrJwoVnkpLDCYsa4PK8PrTmyyDvwm+nKo2qyuaKp6f
 eMmKTD7c6+Ond8hXk7ikDXZRh0NjboQGUp4hwjukHAGvAddlhtGotIjhH6+y0SBy+XQz
 ieCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781778535; x=1782383335;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xFnw4aXbceA0vXrk9kfab7WvtQ3zLrHzHzzkGOm0o2o=;
 b=EgW+fQjYqBZfOaLbI7KtYxw0D0Fc+M5PaCzYIstmhf03l1NsFZhn2yJ7pcM4h4Oj9E
 2Es4o7YzO3bO8DhXVn8lQRDEicWglKAVupq46n4Se8JzpL0F4qXhBdmoJM9SkoYYHAS6
 bLc1FInnf6gzywtOCvT1mU4M7+tvSJYLrcyUn1n52lygJ8t0eINq9PwDZofGRdixBqce
 vLpGo5sNgT3lVTwU/s7ali7aR8Fc/2366UFcgDNz0Kn1rey+FhMGmWgnEQoJW7RSdXOa
 ha0/6zP8m2LBaaPCie6cdCtMBcvAhV7HQCr06DFw43NVf34SkeF2jzaohkwToHVqEe8b
 jtlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hx6mrYenJ7kdsq/Il37PX74UuW70xLcVLPNrQPdvD5uJdf+B8p1V1ySotJYelR5YNGklJY369pkEm@nongnu.org
X-Gm-Message-State: AOJu0YyjutW6X0Xwzy9Orvd41HphMSG5ttutCydKygszVBkkcvG7KCpq
 45nv8oYE9qVbSiFZWO+KOVrjLV4MTqCKIVZXflMI/6HkSX2+g5VYUiqKx/fnd9Q33enaMgIgSsY
 nHHGMG+JblvVy8WgZTAOq94lUEZA1CREIoXhor0FQEGm58mJkbBZlAXz2Dg==
X-Gm-Gg: Acq92OEiBmHad5Nf/awr2wgFG9BNDxXT0USDeYrGbLorUK06OCwJ8VM0bxN4Roc15CA
 uBuQ/0IqPMumjlrFZDWI8YmM5v9vXGcuT/0bmM3eaSLKFcD9562wAqWNkdOSgekOXxAVMYbYc/Z
 JA2/hGzTqXTYTYDfrAba44ZEP/TeQFo9JIA5IwjleR9KSdL9yGsDsAghnj3iCe0rLcuVJn5hn/M
 ZsYYBZT01JVBeMQ0xsNJ7ULAdEbTenp0VJ66eFAPH3SHHZ4Zp2xI9uh1zxmcZtJOGeSCCIPdCqM
 nuGqbuci11/bLsua43st/t4SgbpEkOq0EGnQllc2AYuRvITBvOZhaQ3Z08aw3nmyc8qHHRChrIe
 EDfxWYQEC17C0Somn22uwjAxpkTBVNlN6Y8g5e22ZYXkEJpy9IxeRFljQPG4+Mg==
X-Received: by 2002:a05:620a:45a2:b0:915:cda5:2804 with SMTP id
 af79cd13be357-91f8f9032f9mr201150285a.58.1781778535348; 
 Thu, 18 Jun 2026 03:28:55 -0700 (PDT)
X-Received: by 2002:a05:620a:45a2:b0:915:cda5:2804 with SMTP id
 af79cd13be357-91f8f9032f9mr201146885a.58.1781778534831; 
 Thu, 18 Jun 2026 03:28:54 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1ce102sm41777505e9.1.2026.06.18.03.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:28:53 -0700 (PDT)
Message-ID: <4c8c283a-d471-47fe-a70d-4b3d4cc4a40a@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 12:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/nvme: fix potential use-after-free doing controller
 reset
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jia Jia <physicalmtea@gmail.com>
References: <20260618-fix-heap-uaf-ctrl-reset-v1-1-806ec08dd951@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260618-fix-heap-uaf-ctrl-reset-v1-1-806ec08dd951@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MNpQXsZl c=1 sm=1 tr=0 ts=6a33c867 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=hD80L64hAAAA:8 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8 a=ey5ZRIe-wupFFPNIJwAA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5NyBTYWx0ZWRfX65X65kNQGjaD
 +MMN6ejTY/Pq+GuxinTC55r7cCtmxm0bKAirPb0M/lPFFBOnKzAq4JCyWSKHMzZb/GY2olrHOa8
 7ohqwUZ2mNjlEiU4pUWWrmW6wg4hgUwONPVYljKWPVfJDE4mv8QdSpGAw9YnndpHDr+963uYl2Y
 aZ4rbxelvPKgNO6W6A4SJmeuE1uPdxEe3BBNqdFgs7at7ohpzFO0QWwgSHhEWelT++5RzlIsTji
 e4B/P4A4z34k4/9ideHGjMrEzUgI/V+fS8vQ2VjRxDaAlNJo4YatT1LANEn+iTq6i3IxXxgdPUS
 AM+J+7LG9O8OfHSQ5rBhBMCdfWqpYr6Uxu2bt2IuIeGKW83s7aJDU5O81dXyGnujq3/4E+30BwA
 a4QpOLCS5+8Hf894zBwhALtkb+pF8GgQ0ZfOFdwpiiAPvydKlzWUz6Aj+tS35snEGU8Piv+rLga
 vUc58Dr4uGnFPD7zdCA==
X-Proofpoint-ORIG-GUID: 2F-5JeJZ21D08XuFL4IgUgqCTSDAEmkQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5NyBTYWx0ZWRfX/nCS+LKRmjAa
 mxgS1uS5v9Yw0pVHb7EHkNwRZ7UMSFtUTwW3Ci/Fc8wCnYru6jammBlfaPDlhpquRdqijh4hTEC
 xCPCIJFDZ+1YiJ2qz61txSehIhPiP44=
X-Proofpoint-GUID: 2F-5JeJZ21D08XuFL4IgUgqCTSDAEmkQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180097
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

Hi Klaus,

On 18/6/26 09:56, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> A controller reset may race with inflight DMA I/O. SQ deletion (when
> done by the host through the Delete I/O Submission Queue command)
> handles this, but the controller reset path does not, which may lead to
> the freeing request resources prior to the DMA completing in certain
> conditions under large and heavy I/O pressure.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Jia Jia <physicalmtea@gmail.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/nvme/ctrl.c | 34 ++++++++++++++++++++++++++++++++--
>   1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 815f39173c8a..75768272f241 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -7906,10 +7906,40 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
>       }
>   
>       for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
> -        if (n->sq[i] != NULL) {
> -            nvme_free_sq(n->sq[i], n);
> +        NvmeRequest *req, *next;
> +
> +        NvmeSQueue *sq = n->sq[i];
> +        NvmeCQueue *cq;
> +
> +        if (!sq) {
> +            continue;
>           }
> +
> +        /* cancel any outstanding requests */
> +        while (!QTAILQ_EMPTY(&sq->out_req_list)) {
> +            req = QTAILQ_FIRST(&sq->out_req_list);
> +            assert(req->aiocb);
> +            req->status = NVME_NO_COMPLETE;
> +            blk_aio_cancel(req->aiocb);
> +        }
> +
> +        assert(QTAILQ_EMPTY(&sq->out_req_list));
> +
> +        cq = n->cq[sq->cqid];
> +
> +        /* blk_aio_cancel may enqueue completions on the cq; drop them */
> +        QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
> +            if (req->sq != sq) {
> +                continue;
> +            }
> +
> +            QTAILQ_REMOVE(&cq->req_list, req, entry);
> +            QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
> +        }
> +
> +        nvme_free_sq(n->sq[i], n);
>       }

Could we factor common code with nvme_del_sq() and call it instead?

> +
>       for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
>           if (n->cq[i] != NULL) {
>               nvme_free_cq(n->cq[i], n);
> 
> ---
> base-commit: c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff
> change-id: 20260618-fix-heap-uaf-ctrl-reset-cf05cbc0e729
> 
> Best regards,


