Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CE2C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woEsM-0006JG-OF; Mon, 27 Jul 2026 02:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woEsD-0006I6-GI
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:31:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woEsB-0000Yf-Ni
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:31:37 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R1foi32571946
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NNxCys7olVHmFlkfyqkUO+AzLbSDBBizDcxv3gNYSzM=; b=TO6lkAJza+hvmzia
 s5SR/TVakP0wvvAnjpdFSI49LaZfzKZ4emW2JS5pTshgnTvhY8SWJNnjXDZZ9MOr
 BrHBqK/KIq01TsSoj8YVMYG1P5rkuIoA1tKO6J79aLKd1ahK9oUXfLwhqymF6LRe
 m/ZW/CA+nY90IcXNTaOgG5f0gTUqbh7Hv7y/tANEx/syJtmc2yDoCw2HA5COnqLn
 rHe3QMw6F6NYG2G9hIfDezRDeLdaEiRGG/+bHMWEOa4y9fk5nwuVk4HBuvfrlq/j
 Tkjn242JIy5lYvM8oTxF4qtAtDaCnHLwfp3INzNHxzPDVQTNzuR5Atholl/VAlou
 5nW0Qw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm3scw4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:31:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c20762d21so25824251cf.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 23:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785133892; x=1785738692; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NNxCys7olVHmFlkfyqkUO+AzLbSDBBizDcxv3gNYSzM=;
 b=P1LtqwOnlo+QluR5Bnog5cWEVsw0s9Rq4suukH7Zd3r0LuerLWWnrN/JTGRXV/LHMY
 M4I3G6r8tbTPZbTVV/nIXoqiHIYrYPCcQL68Ic0192J+oV2yDrimOH0w2AhkEaIXqhg/
 jT50UGwkb1LusQQZROOeeGVicEcBEX9rrVcs8X1R06bjhc+HMEjBTscYb5afTJ8JV2LK
 6ne6sj45RAB1gqOLwUabVay66GbgnnbYB1RTNs7UqqlcLF62BA7Zv+MnKYEkvXwgjyxs
 22Szkw7FW0nUj+hhIeuLkjRdmy0CkbLQANr5qZ9TILlOmj5IPyJ/Idfc9GBs+kJnUzT7
 aGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785133892; x=1785738692;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NNxCys7olVHmFlkfyqkUO+AzLbSDBBizDcxv3gNYSzM=;
 b=hwoYRO8sckeLk5ytZdAyCtmyDCnwxg1gC4GMwDC1k7j/14IEE+dW8RclQQ+72TjOsm
 tpKsSfPgQOrAlLQyr96D8HNkNguGC1/Ik59iKshZYLzLF1T558D3dCB1l+PlHEw41NX2
 sWzMGK8Z8Z3YRDQqTW0B1zmOtSXI7Dd2yeG86FNI4N3bsp/8qcGE65JL/dpNVYCs0dsE
 DFWrCS5qdg3snr/N09RyD+qct9lUpN4BtuUH77U8f3UXujkq4PBmagfsPJKUDKn7cjCR
 GnzOaC0J8iRhjTh3025HpQEfi9N7OwDmBJfXw7t42j7kpEusdJIorcqUyXaJd3P/Kg5/
 8Bfg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUgWPCK7UvNOvYxi+/J2yBR8M50aTB27DT0PYeC6CTe48/8puKANxg7Qt4F7Xm7v37Z4phdi1Oz4wW@nongnu.org
X-Gm-Message-State: AOJu0YyyKQ/wDBxcqMA6BNUoEZ/hX2mt/mjuLsszO8SfSpEi6S3svMb3
 Mk+igwz/DRspr0CWadvYKo3clSQbVXnGu1FreAzt0LKeJChfpNMGO4paQDD7IDEALOTOE+41qzY
 I/4NoECXeF5QUuPBcjG/Kqcc4uZSuc15Tz8xZyes0TtOnOS+/J86VJXo7VA==
X-Gm-Gg: AR+sD13Twr5DyFMc4NnACRExmrqR4jhzS/dJ6hxeku68erjvcppNjXN8z+55FBkBKmE
 3X9Er6uLlmieL1WFczgDL6LZKoCIVf98GYaeNIMFKMIHahssA0CInlS3JAdqz3c8PfzfLoDXuDP
 sVSJsKX3L6V2GEpKZmEnzdSXZYH9X7oPinrsEuasOLcKWhr++/tI0AzAt3C4UoA9sdAiln/ZAw8
 hZZJQEd8DS8BEPRyJg+vbR2585EJPKHnmO2tcxACKY4B0DvRpq6jlK5gH5WXuGdKHeTqcnftR4Y
 hyyt8xaYTXAqVrvZ4n1x9+ZKxOQ2G36y4FRCJQexq4/CWPTByTAdrvy53KlBH49AW8qejgD6lDH
 k2hniyPFrldGwHyFlQbm3CvFs4t2OsGHIMWg4lhP1pHfRVOkO7vQ=
X-Received: by 2002:ac8:5954:0:b0:527:61:b4e8 with SMTP id
 d75a77b69052e-529a8732cdbmr70149221cf.66.1785133892527; 
 Sun, 26 Jul 2026 23:31:32 -0700 (PDT)
X-Received: by 2002:ac8:5954:0:b0:527:61:b4e8 with SMTP id
 d75a77b69052e-529a8732cdbmr70149041cf.66.1785133892022; 
 Sun, 26 Jul 2026 23:31:32 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4f24a93sm223884725e9.11.2026.07.26.23.31.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 23:31:31 -0700 (PDT)
Message-ID: <980f519a-cc73-42a7-9938-7f07c45ffdb1@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 08:31:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/nvme: cancel inflight requests on controller reset
Content-Language: en-US
To: Minwoo Im <minwoo.im.dev@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Minwoo Im <minwoo.im@samsung.com>
References: <20260725170203.100051-1-minwoo.im@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260725170203.100051-1-minwoo.im@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA2MiBTYWx0ZWRfX6AG/EwwCEUwx
 lWPZ/SjHc9UY0B4qErLTxgWHpz7yzRoseB/ZTdQwaEJV/HM3e99HRNlNkaekrQUPZltPiNPb4VD
 xKcmFMnfCQrpyCIxP7fGPHX6AY6Os+iffuISMJRXQi8KLnTV2eUtn6D8zjULwRVOtX+S17I9CqQ
 USlW5rFfYllVW53Td1MiJeStLgEcWP1pVM2aFdY88sDqLqQB1LYP0L0BcOKq0f8F0oulES0djjY
 /C0CisH1Se1zAyepb5bg8ySSQk5y4z0LRg4lszbC7dJGYmp8cJ8j2U+ftO3w7nVQj/ZbWta7JgM
 1DwNojO2+JlMcsvBI7E+V7NXkr5igb32Rf1Ytsaz6PNf9CSGrxPRLrfmuqYE1PEcIiC0VvPT5JW
 jyOaIzFVJbHJMoE2ASo3P3nEQVUecM1s5W1IQ3Vv9JJUQEJKZkKNTk+BVp6+jxvcbPBjzZ61mT5
 MJxYrNN0vbafpScxOtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA2MiBTYWx0ZWRfX3cKQ+SIB6VH7
 peBkq7o5P2spxqIEfWBawepEBP6VihHOZo5huwo1bS3aXpRDiZMlTEj2OgPKN3IBoUq7NltFpMk
 SMKrCU7Sttp8EzgiHSUkip45awC6SO4=
X-Proofpoint-ORIG-GUID: gCHkJGtHUfXsjNyjoJLh3Mz3dTwOJ2gN
X-Proofpoint-GUID: gCHkJGtHUfXsjNyjoJLh3Mz3dTwOJ2gN
X-Authority-Analysis: v=2.4 cv=KanidwYD c=1 sm=1 tr=0 ts=6a66fb45 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=hD80L64hAAAA:8 a=3XX8HzIzDEKdemMDA2cA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270062
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

Hi,

On 25/7/26 19:02, Minwoo Im wrote:
> nvme_ctrl_reset() freed every SQ/CQ right after nvme_ns_drain(), which
> only waits out requests on a per-namespace BlockBackend. That is safe
> as long as the guest first tore down I/O queues gracefully (Delete
> I/O SQ/CQ), since nvme_del_sq() already cancels and waits for
> anything left on a queue before freeing it.
> 
> A reset that happens without that graceful sequence first (e.g. an
> abrupt/asynchronous controller reset) can still have commands
> inflight on blk_aio_*. Freeing sq/cq before those complete leaves
> their completion callbacks (nvme_rw_cb() and friends) to run against
> already-freed NvmeRequest/NvmeSQueue/NvmeCQueue memory via
> nvme_enqueue_req_completion(), causing a use-after-free/segfault.

I'm seeing multiple logical changes here. Do you mind splitting the
patch? Generally that helps git bisections and reverts. LGTM otherwise.

> Factor the cancel-and-wait loop already used by nvme_del_sq() into
> nvme_sq_cancel_inflight(),

(2)

> and run it over every queue in
> nvme_ctrl_reset() before the free loops.

(3)

> A pending Async Event
> Request has no aiocb (nvme_aer() parks it without issuing any block
> I/O), so drop it directly instead of asserting.

(1)

> 
> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
> ---
>   hw/nvme/ctrl.c | 47 +++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index a67e1598891c..1482da57e4d9 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -4822,6 +4822,32 @@ static int nvme_init_sq_ioeventfd(NvmeSQueue *sq)
>       return 0;
>   }
>   
> +/*
> + * Cancel every command still inflight on sq and block until each one's
> + * completion callback has run. Safe to call regardless of how the queue is
> + * going away (explicit Delete SQ, or a controller reset that never went
> + * through the guest's graceful queue teardown) since it guarantees no
> + * in-flight blk_aio_* callback can fire after sq/req memory is freed.
> + *
> + * A pending Async Event Request has no aiocb (nvme_aer() parks it without
> + * issuing any block I/O), so there is nothing to cancel; just drop it.
> + */
> +static void nvme_sq_cancel_inflight(NvmeSQueue *sq, uint16_t status)
> +{
> +    NvmeRequest *r;
> +
> +    while (!QTAILQ_EMPTY(&sq->out_req_list)) {
> +        r = QTAILQ_FIRST(&sq->out_req_list);
> +        r->status = status;
> +
> +        if (r->aiocb) {
> +            blk_aio_cancel(r->aiocb);
> +        } else {
> +            QTAILQ_REMOVE(&sq->out_req_list, r, entry);
> +        }
> +    }
> +}
> +
>   static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl *n)
>   {
>       uint16_t offset = sq->sqid << 3;
> @@ -4856,14 +4882,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
>       trace_pci_nvme_del_sq(qid);
>   
>       sq = n->sq[qid];
> -    while (!QTAILQ_EMPTY(&sq->out_req_list)) {
> -        r = QTAILQ_FIRST(&sq->out_req_list);
> -        assert(r->aiocb);
> -        r->status = NVME_CMD_ABORT_SQ_DEL;
> -        blk_aio_cancel(r->aiocb);
> -    }
> -
> -    assert(QTAILQ_EMPTY(&sq->out_req_list));
> +    nvme_sq_cancel_inflight(sq, NVME_CMD_ABORT_SQ_DEL);
>   
>       if (!nvme_check_cqid(n, sq->cqid)) {
>           cq = n->cq[sq->cqid];
> @@ -8022,6 +8041,18 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
>           nvme_ns_drain(ns);
>       }
>   
> +    /*
> +     * Cancel and wait out every inflight command on every queue first. A
> +     * reset is not required to be preceded by the guest's graceful
> +     * Delete I/O SQ/CQ sequence, so sq/cq must not be freed below while a
> +     * blk_aio_* completion for them could still be in flight.
> +     */
> +    for (i = 0; i < n->num_queues; i++) {
> +        if (n->sq[i] != NULL) {
> +            nvme_sq_cancel_inflight(n->sq[i], NVME_CMD_ABORT_SQ_DEL);
> +        }
> +    }
> +
>       for (i = 0; i < n->num_queues; i++) {
>           if (n->sq[i] != NULL) {
>               nvme_free_sq(n->sq[i], n);


