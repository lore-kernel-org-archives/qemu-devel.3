Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB4ACC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHO3M-0003et-Pn; Thu, 15 Oct 2026 12:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHO3G-0003dk-EE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 12:11:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHO3B-0007eJ-5X
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 12:11:28 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFuvU02416991
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 16:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GXFviBakwSjqh+WyR9UwbzE2EKT7jADc5Jt/e022h0E=; b=jkrUkRqmvp9XVIXe
 PsSBUepuzu0KXF2LM1x4xUeIungmMpWTxwte3ER4NfieHZoj6WPc/Zmb/btQ0BuZ
 81C6uqThVFDJtRDv33LAAJzhXDAwK4R/kY+ePGAxhO9nfUrPSj0PhbeJBDLLxT/g
 bdJP0BOyFaLtVHlw0cmZEpPYJzy6UY6GgEG82Wt3i/i+mwEOGbuRqlU8VhiZFAKl
 nvPMDgqTzD1BRK05aKB+JjwqZHAbcOEihkwaXHoBxYMuOrmL+3sUzCpGhL1ghMYh
 Qu59s0jM16fxN6VFf5vDVWYcSYqfMVR9m9OhL8Up2ObSwzXRf/5xaEVPnmSTE0pI
 34skiA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhk0vm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 16:11:21 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9179a556c43so112431296d6.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792080681; x=1792685481; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GXFviBakwSjqh+WyR9UwbzE2EKT7jADc5Jt/e022h0E=;
 b=AUcEREy6Poh+QSEh+nWKI6Qlyp3xWeNPjOAlviTKr5H746/ntIls49SqSnJX/cfUz0
 LJiKdvtktE2q245iRTFKAymNlyrjR4B3vm+4g68EVN4kvfEuHZRkC5APv7p5wWH0bR+B
 7hlU19ucnoFl6zRV3vh+Ot4vZ37EBl6CwfTUhG8MALt3Z1Mcdz5W8E0fbvfyOKDDZH3L
 zlF9PakuKEWs/5J4cOpimU4wU28IvZcBUma6XbchPEIu6c8zw6WoJhFbBqEjUJ7XnhnC
 3JR26jU/8me/OSuVZTxfqmGWrOwOkGsDhuGSz/u3pKJiDg1416tuAnTsB54egMIaYo61
 XrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792080681; x=1792685481;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GXFviBakwSjqh+WyR9UwbzE2EKT7jADc5Jt/e022h0E=;
 b=zgSsIKbLqToImAfr7pvWfeekFjiPF+BjAx4he3J/HJs9/ibZB7440pl9r+dsRqEUSU
 BPV9HQ8UMHa4HHaZP3Gfui/zrj/WfWnIKlsHXBx3FwhcAVWCdJH1aFy9/x1X+kttrliu
 W5uVTBshkzp3FSfr7bLX8NFMTC2YH0U16cROZfIQIsbSedWkkJjRT7aZiTTcclzypwM+
 lbJOHJnHFWID7JvotclBJhpyv2C5Se/SXnhFqBEiMrIisD93vhg9lgls6scHTt80ZTQ6
 QNPxXdQ7rkiCObxdgJF94s/TDU9cJS7JmiDFU2qe0V5iLY+vqgsYuIY9WlRrcgK5d1TX
 yKBA==
X-Forwarded-Encrypted: i=1;
 AKwUvByyU2qVZVRiYHTa42FkCT9Eao3jNDjKpQHccPNZRzwHiUfiSiWNXl3ZEqA8S/NMBHUX1/eWP1XHOmb0@nongnu.org
X-Gm-Message-State: AFq9FYIPMWDB5ulItJ3C3ptdS5M2R2ianxogsvf/vQmRrInQ7csQ+/Z4
 xgM/MndzR+zluPkDDpyT9F7JGwE9tajMNFJ52x5GH0dnnjxM7mi6LEOhexNvuN+fK+a1l0wwmD9
 yXpjQzB9AujlSu3VpCAtax3gI3hVvhxY2ATDipI1rqy0j1dSQKy9mPw0YcA==
X-Gm-Gg: AYBFou0n4trU28LO0SzIdHnjgZjmTyx81Vl3K3glNXhm3MxEhGZpHYg+1ily/BiCpTf
 dKOJfteEnPd4R5XpD5Gq8OwG/cgWxzaEOPQNChNZU121eb7wX3RBmpDx5eFFlYfe+D4tBraWZwB
 OgSRBs9Q+Z/2uaD9spgebVNodGJ4sJgLuvsnRL7NSaE2DUrsDS8rVhhqhYLSO2TnWXzm8AKUXUC
 9Oy6Jxuw8wLcaI7rQfXk5hFewLf9C4APQ3LWfavJoaqg+MWPkqpzluSsAPahvPozuOdk/VNlRnh
 EyUqu7k505YMRBoh0OqsQ1k4N/sJ+bI5mTJQ3EYscz6bFF4SMW4iAYTIY/iwMlt+L5fNLZW/nBd
 vPRISU09ZcjU/neNViQ/CJ2IUxe1g5e1FWj8=
X-Received: by 2002:a05:620a:17ac:b0:93e:5cf8:e5a4 with SMTP id
 af79cd13be357-93ebd27554amr3038415785a.58.1792080680712; 
 Thu, 15 Oct 2026 09:11:20 -0700 (PDT)
X-Received: by 2002:a05:620a:17ac:b0:93e:5cf8:e5a4 with SMTP id
 af79cd13be357-93ebd27554amr3038406685a.58.1792080679978; 
 Thu, 15 Oct 2026 09:11:19 -0700 (PDT)
Received: from [192.168.68.103] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef4f4986dsm810118285a.2.2026.10.15.09.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 09:11:19 -0700 (PDT)
Message-ID: <fbb0ffc9-d03a-4e10-b532-1d977711d496@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:11:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: reclaim invalidated IOATC entries
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
References: <20261007112330.298720-1-tanchi25@mails.ucas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007112330.298720-1-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2NCBTYWx0ZWRfXwrASpITUYU7Q
 ti9zPV4G3gcsT+3C4XXshp2ZnY0wMpVtHmfLSZoeyQT8tsKHqVHK/jz53VzAwxI/w+kandi7XZv
 OBWmhK4/SmSuJ+GAz9cv9eXFdxpBTN7Cy2zZB5lFrDkEpXZulJ/aIho5Ym4qhT6gs1PnKUVDD4F
 zdLk6bDsOrQa0yHP2fV/UKo1uRBSav7jEf394hjzKzPg/kX3nkseNKkVm5j3uPd2btiWb/AFJUA
 01Ud1qvQxKgxqD0Xr5RcCEPeI24lcqUKVFr26HntJ0b91zzBQb970+bE4CBsXgVaPFiSnkbIuL0
 kMIIKFPSVHo1hGJ6FWrCrkupplaKrAYvAg/CuzSKewxGxbAy7JEBznUh67MfYbctv2Y8jWICO5l
 q83xpDtw4TWTh+iVT5ltXSx8KxnKTLC92/VbiTdDdBY57226WW7JtziLRNLliok0QuwTTyLNomq
 WnZknKjMk6Iw0SydIgg==
X-Proofpoint-GUID: 5Y4sxeP2Apz-bKDA6RxmeWXevhgGdlkg
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad0fb2a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=5D9HXbLtB660VeQasMoA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2NCBTYWx0ZWRfX68Wo2e0d4zAT
 vLVKijyW0Q/6B8iGpVFYrx5lq2rEyQP/Z4xUmCpYniT1J51/qcKuOOW2VPiHsv5c6Ysf79pniHO
 vmAMjDWvnlO98fcWtJPimLIGp1NdkPo=
X-Proofpoint-ORIG-GUID: 5Y4sxeP2Apz-bKDA6RxmeWXevhgGdlkg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150064
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi,

On 10/7/2026 8:23 AM, Tan Chi wrote:
> IOTINVAL currently walks the IOATC hash table and invalidates matching
> entries by setting iot->perm to IOMMU_NONE. The invalidated entries remain
> in the hash table afterwards.
> 
> Under workloads with frequent DMA map/unmap activity, invalid entries can
> accumulate while only a smaller number of entries remain valid. Subsequent
> IOTINVAL operations continue to scan these entries. They are also included
> in g_hash_table_size(), causing the IOATC to reach iot_limit earlier and
> the entire cache to be flushed more frequently.
> 
> Remove matching entries during invalidation instead of leaving them in the
> hash table with IOMMU_NONE.
> 
> Removing an entry also frees it, so a concurrent lookup must not retain a
> pointer to an entry being removed. Accesses that modify the IOATC hash table
> must also be serialized. Add iot_lock to protect IOATC lookup, update,
> invalidation, and reset operations, keeping both the hash table state and
> cached entry lifetime valid while they are accessed.

I'll ask you to please split this patch in two: one to add the iot_lock code,
another one for the IOATC inval changes.

One small comment below:

> 
> The measurements use a Linux 7.3-rc5 guest based on linux-iommu/next
> commit cec2dc7663e7 with v6 of the "iommu/riscv: Enable MSI remapping,
> IOMMU_DMA and VFIO" series applied. The QEMU behavior is not specific to
> this guest kernel; this configuration makes it easier to exercise through
> normal DMA map/unmap activity.
> 
> In a high-churn NVMe workload with frequent DMA map/unmap activity, runtime
> drops from 168 seconds to 35 seconds, a 4.8x speedup.
> 
> A short fio workload with a small working set remains within measurement
> noise, showing no measurable regression from the added locking. Across
> three runs for each version of a 300-second fio workload with a 4 GiB
> working set, median throughput improves from 68.6 MiB/s to 75.0 MiB/s, an
> increase of 9.3%.
> 
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---
>   hw/riscv/riscv-iommu.c | 160 ++++++++++++++++++++---------------------
>   hw/riscv/riscv-iommu.h |   1 +
>   2 files changed, 79 insertions(+), 82 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 323a041b4a..85121f6468 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1582,107 +1582,96 @@ static guint riscv_iommu_iot_hash(gconstpointer v)
>   /* GV: 0 AV: 0 PSCV: 0 GVMA: 0 */
>   /* GV: 0 AV: 0 GVMA: 1 */
>   static
> -void riscv_iommu_iot_inval_all(gpointer key, gpointer value, gpointer data)
> +gboolean riscv_iommu_iot_inval_all(gpointer key, gpointer value, gpointer data)
>   {
>       RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>       RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> -    if (iot->tag == arg->tag) {
> -        iot->perm = IOMMU_NONE;
> -    }
> +    return iot->tag == arg->tag;
>   }
>   
>   /* GV: 0 AV: 0 PSCV: 1 GVMA: 0 */
>   static
> -void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value, gpointer data)
> +gboolean riscv_iommu_iot_inval_pscid(gpointer key, gpointer value,
> +                                     gpointer data)
>   {
>       RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>       RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> -    if (iot->tag == arg->tag &&
> -        iot->pscid == arg->pscid) {
> -        iot->perm = IOMMU_NONE;
> -    }
> +    return iot->tag == arg->tag &&
> +           iot->pscid == arg->pscid;
>   }
>   
>   /* GV: 0 AV: 1 PSCV: 0 GVMA: 0 */
>   static
> -void riscv_iommu_iot_inval_iova(gpointer key, gpointer value, gpointer data)
> +gboolean riscv_iommu_iot_inval_iova(gpointer key, gpointer value, gpointer data)
>   {
>       RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>       RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> -    if (iot->tag == arg->tag &&
> -        iot->iova == arg->iova) {
> -        iot->perm = IOMMU_NONE;
> -    }
> +    return iot->tag == arg->tag &&
> +           iot->iova == arg->iova;
>   }
>   
>   /* GV: 0 AV: 1 PSCV: 1 GVMA: 0 */
> -static void riscv_iommu_iot_inval_pscid_iova(gpointer key, gpointer value,
> -                                             gpointer data)
> +static gboolean riscv_iommu_iot_inval_pscid_iova(gpointer key,
> +                                                 gpointer value,
> +                                                 gpointer data)
>   {
>       RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>       RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> -    if (iot->tag == arg->tag &&
> -        iot->pscid == arg->pscid &&
> -        iot->iova == arg->iova) {
> -        iot->perm = IOMMU_NONE;
> -    }
> +    return iot->tag == arg->tag &&
> +           iot->pscid == arg->pscid &&
> +           iot->iova == arg->iova;
>   }
>   
>   /* GV: 1 AV: 0 PSCV: 0 GVMA: 0 */
>   /* GV: 1 AV: 0 GVMA: 1 */
> -static
> -void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value, gpointer data)
> +static gboolean riscv_iommu_iot_inval_gscid(gpointer key, gpointer value,
> +                                            gpointer data)
>   {
>       RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>       RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> -    if (iot->tag == arg->tag &&
> -        iot->gscid == arg->gscid) {
> -        iot->perm = IOMMU_NONE;
> -    }
> +    return iot->tag == arg->tag &&
> +           iot->gscid == arg->gscid;
>   }
>   
>   /* GV: 1 AV: 0 PSCV: 1 GVMA: 0 */
> -static void riscv_iommu_iot_inval_gscid_pscid(gpointer key, gpointer value,
> -                                              gpointer data)
> +static gboolean riscv_iommu_iot_inval_gscid_pscid(gpointer key,
> +                                                  gpointer value,
> +                                                  gpointer data)
>   {
>       RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>       RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> -    if (iot->tag == arg->tag &&
> -        iot->gscid == arg->gscid &&
> -        iot->pscid == arg->pscid) {
> -        iot->perm = IOMMU_NONE;
> -    }
> +    return iot->tag == arg->tag &&
> +           iot->gscid == arg->gscid &&
> +           iot->pscid == arg->pscid;
>   }
>   
>   /* GV: 1 AV: 1 PSCV: 0 GVMA: 0 */
>   /* GV: 1 AV: 1 GVMA: 1 */
> -static void riscv_iommu_iot_inval_gscid_iova(gpointer key, gpointer value,
> -                                             gpointer data)
> +static gboolean riscv_iommu_iot_inval_gscid_iova(gpointer key,
> +                                                 gpointer value,
> +                                                 gpointer data)
>   {
>       RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>       RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> -    if (iot->tag == arg->tag &&
> -        iot->gscid == arg->gscid &&
> -        iot->iova == arg->iova) {
> -        iot->perm = IOMMU_NONE;
> -    }
> +    return iot->tag == arg->tag &&
> +           iot->gscid == arg->gscid &&
> +           iot->iova == arg->iova;
>   }
>   
>   /* GV: 1 AV: 1 PSCV: 1 GVMA: 0 */
> -static void riscv_iommu_iot_inval_gscid_pscid_iova(gpointer key, gpointer value,
> -                                                   gpointer data)
> +static gboolean riscv_iommu_iot_inval_gscid_pscid_iova(gpointer key,
> +                                                       gpointer value,
> +                                                       gpointer data)
>   {
>       RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
>       RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
> -    if (iot->tag == arg->tag &&
> -        iot->gscid == arg->gscid &&
> -        iot->pscid == arg->pscid &&
> -        iot->iova == arg->iova) {
> -        iot->perm = IOMMU_NONE;
> -    }
> +    return iot->tag == arg->tag &&
> +           iot->gscid == arg->gscid &&
> +           iot->pscid == arg->pscid &&
> +           iot->iova == arg->iova;
>   }
>   
> -/* caller should keep ref-count for iot_cache object */
> +/* caller must hold s->iot_lock */
>   static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
>       GHashTable *iot_cache, hwaddr iova, RISCVIOMMUTransTag transtag)
>   {
> @@ -1695,27 +1684,26 @@ static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
>       return g_hash_table_lookup(iot_cache, &key);
>   }
>   
> -/* caller should keep ref-count for iot_cache object */
> -static void riscv_iommu_iot_update(RISCVIOMMUState *s,
> -    GHashTable *iot_cache, RISCVIOMMUEntry *iot)
> +/* caller must hold s->iot_lock */
> +static void riscv_iommu_iot_update(RISCVIOMMUState *s, RISCVIOMMUEntry *iot)
>   {
>       if (!s->iot_limit) {
>           return;
>       }
>   
>       if (g_hash_table_size(s->iot_cache) >= s->iot_limit) {
> -        iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
> +        GHashTable *old_cache = s->iot_cache;
> +        s->iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
>                                             riscv_iommu_iot_equal,
>                                             g_free, NULL);
> -        g_hash_table_unref(qatomic_xchg(&s->iot_cache, iot_cache));
> +        g_hash_table_unref(old_cache);
>       }
> -    g_hash_table_add(iot_cache, iot);
> +    g_hash_table_add(s->iot_cache, iot);
>   }
>   
> -static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
> +static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHRFunc func,
>       uint32_t gscid, uint32_t pscid, hwaddr iova, RISCVIOMMUTransTag transtag)
>   {
> -    GHashTable *iot_cache;
>       RISCVIOMMUEntry key = {
>           .tag = transtag,
>           .gscid = gscid,
> @@ -1723,9 +1711,9 @@ static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
>           .iova  = PPN_DOWN(iova),
>       };
>   
> -    iot_cache = g_hash_table_ref(s->iot_cache);
> -    g_hash_table_foreach(iot_cache, func, &key);
> -    g_hash_table_unref(iot_cache);
> +    qemu_mutex_lock(&s->iot_lock);
> +    g_hash_table_foreach_remove(s->iot_cache, func, &key);
> +    qemu_mutex_unlock(&s->iot_lock);
>   }
>   
>   static RISCVIOMMUTransTag riscv_iommu_get_transtag(RISCVIOMMUContext *ctx)
> @@ -1750,12 +1738,10 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       IOMMUAccessFlags perm;
>       bool enable_pid;
>       bool enable_pri;
> -    GHashTable *iot_cache;
>       int fault;
>   
>       riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
>   
> -    iot_cache = g_hash_table_ref(s->iot_cache);
>       enable_pri = (iotlb->perm == IOMMU_NONE) &&
>                    (ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI);
>       enable_pid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
> @@ -1771,15 +1757,18 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           }
>       }
>   
> -    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova, transtag);
> +    qemu_mutex_lock(&s->iot_lock);
> +    iot = riscv_iommu_iot_lookup(ctx, s->iot_cache, iotlb->iova, transtag);
>       perm = iot ? iot->perm : IOMMU_NONE;
>       if (perm != IOMMU_NONE) {
>           iotlb->translated_addr = PPN_PHYS(iot->phys);
>           iotlb->addr_mask = ~TARGET_PAGE_MASK;
>           iotlb->perm = perm;
>           fault = 0;
> +        qemu_mutex_unlock(&s->iot_lock);
>           goto done;
>       }
> +    qemu_mutex_unlock(&s->iot_lock);

Can't we do:

 > +    qemu_mutex_lock(&s->iot_lock);
 > +    iot = riscv_iommu_iot_lookup(ctx, s->iot_cache, iotlb->iova, transtag);
 > +    qemu_mutex_unlock(&s->iot_lock);
        (...)


Instead of adding two unlocks?  It doesn't seem to me that the lock is needed
to set iotlb->... before jumping to 'done'.


Thanks,
Daniel

>   
>       riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_TLB_MISS);
>   
> @@ -1805,12 +1794,12 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           iot->pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
>           iot->perm = iotlb->perm;
>           iot->tag = transtag;
> -        riscv_iommu_iot_update(s, iot_cache, iot);
> +        qemu_mutex_lock(&s->iot_lock);
> +        riscv_iommu_iot_update(s, iot);
> +        qemu_mutex_unlock(&s->iot_lock);
>       }
>   
>   done:
> -    g_hash_table_unref(iot_cache);
> -
>       if (enable_pri && fault) {
>           struct riscv_iommu_pq_record pr = {0};
>           if (enable_pid) {
> @@ -1969,7 +1958,8 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
>       dma_addr_t addr;
>       uint32_t tail, head, ctrl;
>       uint64_t cmd_opcode;
> -    GHFunc func;
> +    GHRFunc iot_func;
> +    GHFunc ctx_func;
>   
>       ctrl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
>       tail = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQT) & s->cq_mask;
> @@ -2032,18 +2022,18 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
>                   goto cmd_ill;
>               }
>   
> -            func = riscv_iommu_iot_inval_all;
> +            iot_func = riscv_iommu_iot_inval_all;
>   
>               if (gv) {
> -                func = (av) ? riscv_iommu_iot_inval_gscid_iova :
> +                iot_func = (av) ? riscv_iommu_iot_inval_gscid_iova :
>                                 riscv_iommu_iot_inval_gscid;
>               }
>   
>               riscv_iommu_iot_inval(
> -                s, func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VG);
> +                s, iot_func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VG);
>   
>               riscv_iommu_iot_inval(
> -                s, func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VN);
> +                s, iot_func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VN);
>               break;
>           }
>   
> @@ -2063,24 +2053,24 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
>               if (gv) {
>                   transtag = RISCV_IOMMU_TRANS_TAG_VN;
>                   if (pscv) {
> -                    func = (av) ? riscv_iommu_iot_inval_gscid_pscid_iova :
> +                    iot_func = (av) ? riscv_iommu_iot_inval_gscid_pscid_iova :
>                                     riscv_iommu_iot_inval_gscid_pscid;
>                   } else {
> -                    func = (av) ? riscv_iommu_iot_inval_gscid_iova :
> +                    iot_func = (av) ? riscv_iommu_iot_inval_gscid_iova :
>                                     riscv_iommu_iot_inval_gscid;
>                   }
>               } else {
>                   transtag = RISCV_IOMMU_TRANS_TAG_SS;
>                   if (pscv) {
> -                    func = (av) ? riscv_iommu_iot_inval_pscid_iova :
> +                    iot_func = (av) ? riscv_iommu_iot_inval_pscid_iova :
>                                     riscv_iommu_iot_inval_pscid;
>                   } else {
> -                    func = (av) ? riscv_iommu_iot_inval_iova :
> +                    iot_func = (av) ? riscv_iommu_iot_inval_iova :
>                                     riscv_iommu_iot_inval_all;
>                   }
>               }
>   
> -            riscv_iommu_iot_inval(s, func, gscid, pscid, iova, transtag);
> +            riscv_iommu_iot_inval(s, iot_func, gscid, pscid, iova, transtag);
>               break;
>           }
>   
> @@ -2088,12 +2078,12 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
>                                RISCV_IOMMU_CMD_IODIR_OPCODE):
>               if (!(cmd.dword0 & RISCV_IOMMU_CMD_IODIR_DV)) {
>                   /* invalidate all device context cache mappings */
> -                func = riscv_iommu_ctx_inval_all;
> +                ctx_func = riscv_iommu_ctx_inval_all;
>               } else {
>                   /* invalidate all device context matching DID */
> -                func = riscv_iommu_ctx_inval_devid;
> +                ctx_func = riscv_iommu_ctx_inval_devid;
>               }
> -            riscv_iommu_ctx_inval(s, func,
> +            riscv_iommu_ctx_inval(s, ctx_func,
>                   get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID), 0);
>               break;
>   
> @@ -2103,9 +2093,9 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
>                   /* illegal command arguments IODIR_PDT & DV == 0 */
>                   goto cmd_ill;
>               } else {
> -                func = riscv_iommu_ctx_inval_devid_procid;
> +                ctx_func = riscv_iommu_ctx_inval_devid_procid;
>               }
> -            riscv_iommu_ctx_inval(s, func,
> +            riscv_iommu_ctx_inval(s, ctx_func,
>                   get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID),
>                   get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_PID));
>               break;
> @@ -2671,6 +2661,7 @@ static void riscv_iommu_instance_init(Object *obj)
>                                            riscv_iommu_ctx_equal,
>                                            g_free, NULL);
>   
> +    qemu_mutex_init(&s->iot_lock);
>       s->iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
>                                            riscv_iommu_iot_equal,
>                                            g_free, NULL);
> @@ -2690,6 +2681,8 @@ static void riscv_iommu_instance_finalize(Object *obj)
>   
>       g_hash_table_unref(s->ctx_cache);
>       g_hash_table_unref(s->iot_cache);
> +
> +    qemu_mutex_destroy(&s->iot_lock);
>   }
>   
>   static void riscv_iommu_realize(DeviceState *dev, Error **errp)
> @@ -2850,7 +2843,10 @@ void riscv_iommu_reset(RISCVIOMMUState *s)
>       riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_IPSR, 0);
>   
>       g_hash_table_remove_all(s->ctx_cache);
> +
> +    qemu_mutex_lock(&s->iot_lock);
>       g_hash_table_remove_all(s->iot_cache);
> +    qemu_mutex_unlock(&s->iot_lock);
>   }
>   
>   static const Property riscv_iommu_properties[] = {
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index da70e8bfa8..16d257a106 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -73,6 +73,7 @@ struct RISCVIOMMUState {
>   
>       GHashTable *iot_cache;          /* IO Translated Address Cache */
>       unsigned iot_limit;             /* IO Translation Cache size limit */
> +    QemuMutex iot_lock;
>   
>       /* MMIO Hardware Interface */
>       MemoryRegion regs_mr;


