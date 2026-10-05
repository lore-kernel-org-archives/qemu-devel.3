Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DEDCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 22:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDr3K-0003i6-FZ; Mon, 05 Oct 2026 18:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xDr2l-0003YB-1h; Mon, 05 Oct 2026 18:20:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xDr2e-00076G-DX; Mon, 05 Oct 2026 18:20:22 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695Ha0r01277040; Mon, 5 Oct 2026 22:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qwiYlN
 QLt7JE60tkzrUEfarkZPeZ6z12dMAuyegtJII=; b=DIwmQ8+Tr80rMy/M1G6QpW
 xJiYvd88GbZSkg8Viofq6GOCwwK47znXKkFoRzYHT+i5QtSM2HumVSFN678MFuhg
 deQ3kVyJtOvtBYFcVejcAhROhDvN9cxt8s2vUPBDdVyrS9vWo6AJ8q4Q3Oilqvt9
 ASe0JzGYbyFDyrvDIIAR12ArAeJy3JCocw2QKDTlPFsJZjB+H+ZS4G230GWDl8tN
 bHS48uGea9+7ETQQzT7t2cajhE/YsI+t2GyXbzlkRGlHWPgTjQZu8gyCbwLwZ9OE
 p7dP56+PdtsoK/oqtaPdcbRHK8QYuJm2/Hlo2+fi1xBr5zO1D2jgt2eAtRSFI3MA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv3wxk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 22:20:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695LnjMp3214601; Mon, 5 Oct 2026 22:20:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jqd2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 22:20:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695MK5MP18088468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 22:20:05 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DAA75804E;
 Mon,  5 Oct 2026 22:20:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 465705803F;
 Mon,  5 Oct 2026 22:20:04 +0000 (GMT)
Received: from [9.61.255.78] (unknown [9.61.255.78])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 22:20:04 +0000 (GMT)
Message-ID: <16c455c2-6f42-4041-9580-eb7292647759@linux.ibm.com>
Date: Mon, 5 Oct 2026 15:20:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 15/16] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260930145255.140164-1-kshk@linux.ibm.com>
 <20260930145255.140164-16-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260930145255.140164-16-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YFnkc2XZIv2Nlhk5IVnfKuawddIBpmjd
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac42297 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=yMMIk1pPZdNznOaS9MQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YFnkc2XZIv2Nlhk5IVnfKuawddIBpmjd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NyBTYWx0ZWRfXwKQM68bctYiO
 w07qWzcUy3nI/4NvgU4N5K+ix6WAA3HC5zdbpTQb0ajdOOdkH5Niz7Bt8a2RVh5mVZm2Ue9qXhY
 P6HbRUx8Qo6JOsH3u0pSFW3lqVEfcCJmVQS5WwFb23QjfFu9IEif0StqfMmrYSo4XLRgAumsesG
 xt1GaniLvN0HS/L1Qb3p86thjLZwpAEH1+XxMTgt+gpo8F0Kv3VfE2Jlrqd0E6Pq815O5YhynTo
 GPLEn3z2caG8h00kJGUQY+BTC5bsIrQNE/svLPiSkK99DruyIZSDCwakRz0ICmLgGHP4z0QUS9e
 qPsHKMzzQOIYCbENIoLcgNbwqaoOBFAsrYXjUn8/PBn1dZSjgSO5wf5gJyc4fpykoSeaFbhj1h7
 ffW0029PQVHzIbnln9+2Viy7r62HfYQD1ZEwzisscZ8nhfFCFcgkqHMlblDdXAI7UYvQQRk3yM2
 yHOW4x1/yiyP2d7MfXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NyBTYWx0ZWRfX5SH33TAseF/H
 WOvLVefsKWPtq2EXl7FiPAGARM71I9/jCSw84Pm5vNe0DEmhrX+NAHcWmVFQq32R/ZUKuthF5PX
 Gn19MOU1Ev/Bx1IwDS2R7FGgKBVA3H0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050087
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

<..snip..>

On 9/30/2026 7:52 AM, Konstantin Shkolnyy wrote:
> +/*
> + * When pending_sei load is executed, pending_sei can already contain SEIs
> + * generated here in the target QEMU, for example, by state loads of zpci
> + * devices. A dumb load here would place the older SEIs from the source QEMU
> + * after the new SEIs. To fix this, we have pre_load() stash the new SEIs from
> + * pending_sei and post_load() unstash them after the old ones.
> + */
> +static void s390_pci_move_sei_list(SeiContainerList *dst, SeiContainerList *src)
> +{
> +    SeiContainer *sei_cont;
> +
> +    while ((sei_cont = QTAILQ_FIRST(src))) {
> +        QTAILQ_REMOVE(src, sei_cont, link);
> +        QTAILQ_INSERT_TAIL(dst, sei_cont, link);
> +    }
> +}
> +
> +static int s390_pcihost_pending_sei_vmstate_pre_load(void *opaque)
> +{
> +    S390pciState *s = S390_PCI_HOST_BRIDGE(opaque);
> +
> +    QTAILQ_INIT(&s->pending_sei_stash);
> +    s390_pci_move_sei_list(&s->pending_sei_stash, &s->pending_sei);
> +    return 0;
> +}

Does this mean we can append SEIs to the list while we are still 
migrating? In that case do we need any form of synchronization here when 
accessing the pending_sei list?

Thanks

Farhan

> +
> +static int s390_pcihost_pending_sei_vmstate_post_load(void *opaque,
> +                                                      int version_id)
> +{
> +    S390pciState *s = S390_PCI_HOST_BRIDGE(opaque);
> +
> +    s390_pci_move_sei_list(&s->pending_sei, &s->pending_sei_stash);
> +    return 0;
> +}
> +
> +static const VMStateDescription s390_pcihost_pending_sei_vmstate = {
> +    .name = TYPE_S390_PCI_HOST_BRIDGE "/pending-sei",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = s390_pcihost_pending_sei_vmstate_needed,
> +    .pre_load = s390_pcihost_pending_sei_vmstate_pre_load,
> +    .post_load = s390_pcihost_pending_sei_vmstate_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_QTAILQ_V(pending_sei, S390pciState, 1,
> +                         vmstate_sei_container, SeiContainer, link),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +

