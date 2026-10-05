Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457D1CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 04:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDaJm-0002D2-Dy; Mon, 05 Oct 2026 00:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xDaJd-0002CJ-Rk
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 00:28:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xDaJb-0005g6-SM
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 00:28:41 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695105oN1410910
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 04:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zSMX2wvf4RQtg960YPrfeShaaNNNLiY9P8LqaACWJT8=; b=KM9W7JErf2EUhQvt
 bmrlQqZbh7CgR5rMluVU5oPB8pma4MLPXu4cuKcKJt/eksgXzQil7/H8zExKqfpK
 AlA5D+4L4VF15nC85xk6Aj6NV6f/qrQfSg4Ja9urgCh4AkqlEg6YWK/aj+i1AS5Y
 arsNSEFdBcqqu/2IkW+MmQFxiAwLESEUFZ7E9wyNBSwGbgFRLddSN9p32/Dh9lib
 hgQvNolRLkEBsskaKe1cIFZKqvTmTkiksf+RUdpblXq37eYvRbq8Iz7Co8/0jICS
 gksG3W3BHnWuAz3xHK+uL8nd1d7qNw3xe8JITfktBeZhaBZlbGlTv2Gt7JeFFwDm
 r89FKQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sr6cepe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 04:28:35 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-917a7fffbe0so35619806d6.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 21:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791174511; x=1791779311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zSMX2wvf4RQtg960YPrfeShaaNNNLiY9P8LqaACWJT8=;
 b=W/x7tBNAiYUxAUuGYbKFtFIiji0SSoPjtj9folZx1KcwFkH5WrOnTMk7ZC6eEBGWGr
 nf6f4kqcdh6PBX0bTG1L6lAH1YPhsoYFi4ZOQYxm0PyEucVWeqIjqwiIllBZ/8kXRSAo
 fhOxsU8PY/csPiWHPcNy6uVDfCY+eQnTJuDSotLkuw7epzdstne1oLrc4voeMOnstQPk
 Vg8whDEhKPQASL4N8yYAmT+bBKSqsbx4m2GYoj+uRhD8mjDBRE0GGrMXPmB1+mAoSEWg
 /X5aItog98CPmUn1hJo/Fv+uyW6L7FjZzXHtqCxr88pPxbneM7vtDVn7CMFG6o8u/ygB
 35MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791174511; x=1791779311;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zSMX2wvf4RQtg960YPrfeShaaNNNLiY9P8LqaACWJT8=;
 b=ljLQnViUDxxmUpW8R22v8+emLLeV8TAXRBRb8bUY/Iedidykusni/W4oSX8vUd27i5
 7Jny6no4vA6Df9JAPzSivZNyTY5fvYdFUsYkRYfUsG+kiqCRiISDEk3LYi13bwgae8ka
 0xy3UZq7cWDIamUpZxg8vELzClwiXnzPeneZOyzsMuAQpZp1gnICtCNuKxNjP3EakeJA
 DSi+HK0mdf83iL591nJFt1+kY6isXeul7qJe3jQzFk43eg4ukIngU9pAkJbb+mofTiZo
 TyCTvoYHDhwxvOH2yO6dDwpeizcdOEv0xKb/cf3tclfDhQ3oNsoQwZDLyU3En0IX52+y
 cjWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWt+Bhs+3vv2XXFf9UXt0S6dvYAkn+4YrgLjtAVcFpg4/uKutqNtCk6j092YQnnSUrmNu5DurE0tIz@nongnu.org
X-Gm-Message-State: AFuF++ndvYVkyGEFeejtm4A5iCanVe0cLIF3LwahIu5fksGeoMydHro+
 oXm4rPlBrbRey+XG9y4fJj/T6RQfCLNbq/YZ/bTg7HLUorrafSdrI/EQeKk8b0ms8q4Av9CSn38
 mmOFfqmtYvy5bSSsBEuk5q9Y4M+Go+Uuy9DoWU0J/SVNq1u8xkUhOWfB0xw==
X-Gm-Gg: AYBFou2/qtG1X7tvKPJlRcQ6g7ixgFq5J14xga+wrXENsJUz5OM66wcdV7MFhMvUBrs
 kGl41kltO3pb6rVq8wVZdNQWHzU1UsYZ/eC4WZO5t+xsCCfst3dmwzscNDm79qp6GEUqWf3fXYR
 eHR+/eN5jd3skTsAJKPUw6kD5XpWNdFA+x3QtdnR+thpPy4JE3cuEGoH68aYvMJMfUleJC+gQJu
 WtVOzPg0AOrRyzLW2lLXtjmSzS+5GjyWCRbeY88hzm5ld8wPbDULfvpy56HbDlyENf4mGj+nUK+
 qauipHNqym3ux7vz2ybs3aSgyT6IB6+0dePvVMtX9pzbIC3lIpsw5V5tP8jmlYiDohlVIR3jTSS
 kmyiH4UAZYHcRI/BFWzQfBRhhR1IVXtteA5mP
X-Received: by 2002:a05:6214:250b:b0:914:563a:b3eb with SMTP id
 6a1803df08f44-917c0166b16mr193004676d6.40.1791174511021; 
 Sun, 04 Oct 2026 21:28:31 -0700 (PDT)
X-Received: by 2002:a05:6214:250b:b0:914:563a:b3eb with SMTP id
 6a1803df08f44-917c0166b16mr193004336d6.40.1791174510479; 
 Sun, 04 Oct 2026 21:28:30 -0700 (PDT)
Received: from [192.168.10.208] ([185.243.168.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-919442ce1c4sm70842716d6.3.2026.10.04.21.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Oct 2026 21:28:29 -0700 (PDT)
Message-ID: <eeb97c7e-e4a1-4b8c-acba-74025b22f1c2@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 01:28:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: fix entry leak with ioatc-limit=0
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-stable@nongnu.org
References: <20261004151855.201300-1-tanchi25@mails.ucas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261004151855.201300-1-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxNyBTYWx0ZWRfXwv2/jYj/ZcH5
 BE/PoTewciElruqQEzWLz9NJW5FNmzRNj+nxM56PBqFpPMcDtw7XV7Ur2dQ1E4OnXh4e1WDLMUf
 p4oTVU0HA/2KCykBj0POuPsn1OY2/W4=
X-Authority-Analysis: v=2.4 cv=NaBzRGD4 c=1 sm=1 tr=0 ts=6ac32773 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=Adc43iEMMYzOb2FTIT2GVQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=69wJf7TsAAAA:8 a=O8oy15Apc-w8djsST1MA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: IGAO7rHz4YqmdvMFm9KWATa8hv6a_2GC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxNyBTYWx0ZWRfX/bWkjJy3tl2H
 5jXVT7nYaLG2ZtvLjY0JyjHpjccOseBIIlaKHCzGeC6I/Sv4SCYeVQP3NAf6xvUcSpx7PSN5opA
 8PdN/S0WTshvq4EkvFVvD5whuoBOwU8Bb6Qod03nCMtfmYcC+6Lm4fU1M7MQPmItDntkjgLcyXR
 N3cZfr0Dhzml/y27zEp4SKyryrRqvjNlDrjE7bghPqdgWPTNceup8DM/w5hU2+BoVj297HRkzmf
 RD9nGBmHU8pCuWWS6I5z6hhI1lkMAJbB/aHmsmfOnl7quYOudGoC9uIE/Ep4+kkdEs6NwEe/WnX
 /xKaOJangQUYoyzDBZTj+/z+g2oMEE/RA33IN/kYQDLgtb+4sACvTLu6GGpje9SyP0BLoz7jDWi
 14ou1W1Itq/rICrHX+RxjaHBSDnzt391Vt9u+p/3diVBl3vm2H80YRJyR4T9u4xu2P3qaE10ShQ
 bMK/ez+/EBLGxOcVRzg==
X-Proofpoint-ORIG-GUID: IGAO7rHz4YqmdvMFm9KWATa8hv6a_2GC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050017
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



On 10/4/2026 12:18 PM, Tan Chi wrote:
> riscv_iommu_translate() allocates an IOATC entry before passing it to
> riscv_iommu_iot_update(). The update helper normally transfers ownership
> to the hash table.
> 
> When ioatc-limit is zero, however, the helper returns without inserting or
> freeing the entry. Every cacheable non-identity translation therefore leaks
> one RISCVIOMMUEntry.
> 
> Free the entry on the disabled-cache path so that
> riscv_iommu_iot_update() consistently consumes the entry passed to it.
> 
> Fixes: 9d085a1c3cb2 ("hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---
>   hw/riscv/riscv-iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 323a041b4a..ebf8d7006c 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1700,6 +1700,7 @@ static void riscv_iommu_iot_update(RISCVIOMMUState *s,
>       GHashTable *iot_cache, RISCVIOMMUEntry *iot)
>   {
>       if (!s->iot_limit) {
> +        g_free(iot);
>           return;
>       }

It is better if we could avoid g_freeing() stuff from other functions to avoid
cases where we need to fix freeing logic for a certain pointer all over the code.


I see that riscv_iommu_iot_update() is being gated by these checks in riscv_iommu_translate():

     if (!fault && iotlb->translated_addr != iotlb->iova && enable_cache) {


The 'enable_cache' flag is a flag set by callers of riscv_iommu_translate() in two
instances:

- in riscv_iommu_process_dbg(), always set to 'false':

    int fault = riscv_iommu_translate(s, ctx, &iotlb, false);

- in riscv_iommu_memory_region_translate(), always set to 'true':

    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb, true)) {

The use in riscv_iommu_process_dbg() is correct because we don't cache
debug messages.  But the other one isn't - s->iot_limit is a property set
during init(), i.e. it won't change during the iommu lifecycle, and we
can't have cache if s->iot_limit is 0.

So I think we can do this instead:

-    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb, true)) {
+    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb,
+                                     s->iot_limit > 0 ? true : false)) {

And we're fixing the leak you're detected while also making the logic more sound,
if ever so slightly.



In fact I think there's more improvements to be made w.r.t s->iot_limit, i.e.
if it's a known zero why bother allocating s->iot_cache in the first place,
but that's something out of the scope for this patch.


Thanks,
Daniel




>   


