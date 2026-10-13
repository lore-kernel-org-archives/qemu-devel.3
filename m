Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDF7CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGZUp-0003Mc-2P; Tue, 13 Oct 2026 06:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGZUn-0003M7-Oc
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:12:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGZUl-0000zu-RD
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:12:33 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8RIKx923086
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 10:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lXplvBc2e7L9iSAnMsXcuVcd5AsadwKMAwd5W0Jdcpk=; b=VKGBqD+Hmxxta0Lq
 /ZuaiM/PWbNjpmsw8MNMgzJpWa6gJwHqSG0bYPTCDq5SoJ7L+x0SLWO+zl4FlpKI
 5BEBaWx73fOjOMDySO6VawqlJDlsEkaJYeQMXHn3/S0OMhy/JwtnDTMcKxEMDf19
 dYwZ8twWLiXqOFGhnWEEo85DbJF44kL8N+GITYgzIj/L0vrApEQnLRpPNMD3RtbU
 wspuUSnk65+IffibjIgo9oExVQ7Fww2TsX6RrPjlWnV9qhXjGF8/kT9TH0x493PZ
 lU0X4vJZTc2wfO9xHZDrWR5lT4Sy2hr+cmqzbpyMopfgIkTm9TxfYhUJZDlDhgWc
 LNwQIA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1tcnx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 10:12:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a3f673221so845308885a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791886349; x=1792491149; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lXplvBc2e7L9iSAnMsXcuVcd5AsadwKMAwd5W0Jdcpk=;
 b=C1+lkw+gB3JA9QqcOyBHJXcyleJozkkN7ujnVEVpKLhv5sMb6H97++0ko1kO5bExK7
 KYalJpyViPco8n8dCw0tETk+V6YILCBQrwNZ0APr1Dk6eckw872KIPW4kEG/OFh1uG+v
 KAo4xLoEdw02kyM4wpZIHomd22hTL8I+XOaZQu+O2Eme496vevh4MIt2U81aEBjYwWxe
 oXdnthDZuZF58Y6Vmt2SThdCEX+DX6VQt4ev0H8NPTwWaf7k55G0i4W8QwfDRT4VbXZS
 tr+tCGnPBYqte1ltd/A7ojFkXQ7vzoslQw7bMg1uelwFt7ns+CIRLWQVSAZYm+BUXgRs
 roRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791886349; x=1792491149;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lXplvBc2e7L9iSAnMsXcuVcd5AsadwKMAwd5W0Jdcpk=;
 b=XDfcmIgcSav29gCczqGkrm29dW5wknNq7yRDe3gjfSQvFbaUUH4ybwQkX1B5nP7T2m
 ZnAIZKHaBGK71RmCp+Fja20cz9+YPteo/qaM69pEJZ2fRNaMJJ2oDFzZGUN2UAUrlnz6
 7YMJEG2v8Ug8nFvcB/MlZmbKVvhRWtYx5piDgF+ui9+FnQOC7K1qPN15gNgNzdiXn2H3
 jz0tOHwBR2YvRWDxBpmTJAELq95UhIYge1AXg1HKLz0ErBeRVehhGMWk4NOaCuO9gI3p
 VMljziQ0yZpKcLYx/f8/1ilhyZt6Z9TGNSAwfS6kT2gqD/M0ZOgSwK8MCsOMIZPIcNNW
 SNQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvcY59NkDntbbvr8OiNfRXzVY8k58AgX8Of8jAWcmRvy7aj+fwTQuApOmYjM2cu+wocS3f517Znf3B@nongnu.org
X-Gm-Message-State: AFq9FYLO74adXtv5WBbynJFio7DaKRhh0ElaGkUjgeE9qf+Vf49q4egf
 J9Ps/B2/EIkkOUJRswfIEEoBoMaRKo+tIoqHKx64ryh1F61MdnRCcBwoccL/3LkDICMMJt/OcSq
 bYmEQ8xzI/qcJ5Z7aTuLbIaLIb8lYKfGfxBeQgDds8gzgkp+zir1Spu3TWtDzswHGoTpe
X-Gm-Gg: AYBFou2Wmc5cDKXvnlqIrJ62E2z8LpHBd+gLjKTgRuEyKFuol8fKwrsUMxJXkcu5Yqe
 Izn92HYUFcJZsEty44KRzzep9c1QgmrxzPXLqFDv7mlY2sYvGbDXtCMFM7gfCT692vG/4CXDGOm
 g68L13HHC1YhbnqIQRH3s1uMp9YKhM+h9s5/6lCn/+FuGmEdY8YNp9KJyLTTITeirTqOb5T1Ghe
 RRlv2PS4l/S2JRjwhm8aIUQ5wV3A0SZx9xrm7zhLMXf+Xierbq68av03wnI1THtk5jX4uYONqa2
 Fca/pKPRKTUqgDoqgokHldvHu04U4ZwUla1XFL+SVIA/T7qCyOkqCS+sehq6xtzgbfgkzLKmp+V
 7G92Jk3tNRcKpQmcrKS+TkqACrd9tfE7EuQ==
X-Received: by 2002:a05:620a:890c:b0:93e:c12c:fbbf with SMTP id
 af79cd13be357-93ec12d0fcemr1771701585a.76.1791886348813; 
 Tue, 13 Oct 2026 03:12:28 -0700 (PDT)
X-Received: by 2002:a05:620a:890c:b0:93e:c12c:fbbf with SMTP id
 af79cd13be357-93ec12d0fcemr1771698885a.76.1791886348167; 
 Tue, 13 Oct 2026 03:12:28 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c198134sm356381175e9.15.2026.10.13.03.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 03:12:27 -0700 (PDT)
Message-ID: <8a030bca-4697-405a-aaa8-017baed8ab55@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:12:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 56/86] hw/intc/arm_gicv5: Implement IRS_VMAP_VMR
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-57-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261013083933.1024405-57-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6ace040d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=iiB_1M5JUh-BO4UfUGIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6aig3ZVkicr4doqWk-fb3DMSkPRYKSOl
X-Proofpoint-ORIG-GUID: 6aig3ZVkicr4doqWk-fb3DMSkPRYKSOl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfXxY+v+o2xRgWn
 HvHbxYaKU2AvCGFM3TpPdQypG67fUNwM5k58mvCkmibf55YPHHhNeWu0/5wjyNZ0v1VHCYazfAS
 /mxWt5Y0hLXcJOAB63GQLautF1us6kQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfX4egM6sO7rQ9R
 RBfJAfyoDphoCi++Py5/XqkwbjLbGm5km/faobkjxwmkkIzWzD6tyqwsU2NTFgH0Kpda5JsbYmo
 SEnbwUfxe+AXyGZc8FL1/kVk3aFFEfYrs304xCreI5aWwngBjf9ogP3JcCpRqKZCNo8iFw42hse
 T6CabOU+3dYBfk7BnM0Ay2JML6flwhozpcRolP2BscXYVo1VxjXjrdUzdUCiDZZFl1i7Xw7Vxjr
 WF+PtH0q/gCVPX58M+6SNDnFJ4GmEsAC7nQ1QdARXrGKE6+virdIECII1fzH5tLdDo8Hb2zAzLv
 8MtoJ3jq3iV1a9Sg5P5vMYi1wwYKVmNK1w2rTXyVhvhBYxNsOOcuYuoM/lWx9pRBUy1Vv0L/9D7
 FEzyQ4b1XxwwuAwFcGHpQkFNhWzQZ1TInGea06GFBDoPGHrI0t6dMscj9kSnIerLOc38t9mTLOD
 1mRGhzUgF76xUyYUSOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130040
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

On 13/10/26 10:39, Peter Maydell wrote:
> The IRS_VMAP_VMR register lets the guest mark a VM as valid.  This is
> a 64-bit register similar in operation to IRS_VMAP_L2_VMTR.
> 
> We are eventually going to want to cache the information in a VM
> table entry, but for the moment implement the "make valid" operation
> as simply writing 1 to the VALID bit in the L2 VMTE.
> 
> Note that unlike many of the other address fields in GICv5 data
> structures, we don't need to clear any of the low bits in
> L1_VMTE.L2_ADDR beyond masking with R_L1_VMTE_L2_ADDR_MASK.  This is
> because a level 2 VMT is always 4KB and so the alignment is fixed;
> the mask clears the low 12 bits, enforcing 4KB alignment.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c                | 94 ++++++++++++++++++++++++++++++
>   hw/intc/arm_gicv5_common.c         |  1 +
>   hw/intc/trace-events               |  1 +
>   include/hw/intc/arm_gicv5_common.h |  1 +
>   include/hw/intc/arm_gicv5_regs.h   | 21 +++++++
>   5 files changed, 118 insertions(+)


> @@ -1472,6 +1531,22 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
>               *data = 0;
>           }
>           return true;
> +    case A_IRS_VMAP_VMR:
> +        if (gicv5_domain_has_virt(cs, domain) && s->vmt_config[domain].valid) {
> +            *data = extract64(cs->irs_vmap_vmr[domain], 0, 32);
> +        } else {
> +            /* RAZ/WI if no virt or no VM table */
> +            *data = 0;
> +        }
> +        return true;
> +    case A_IRS_VMAP_VMR + 4:
> +        if (gicv5_domain_has_virt(cs, domain) && s->vmt_config[domain].valid) {
> +            *data = extract64(cs->irs_vmap_vmr[domain], 32, 32);
> +        } else {
> +            /* RAZ/WI if no virt or no VM table */
> +            *data = 0;
> +        }
> +        return true;
>       case A_IRS_SPI_STATUSR:
>           /*
>            * QEMU writes to IRS_SPI_{CFGR,DOMAINR,SELR,VMR} take effect
> @@ -1604,6 +1679,14 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
>                                  deposit64(cs->irs_vmap_l2_vmtr[domain],
>                                            32, 32, data));
>           return true;
> +    case A_IRS_VMAP_VMR:
> +        irs_vmap_vmr_write(s, domain,
> +                           deposit64(cs->irs_vmap_vmr[domain], 0, 32, data));
> +        return true;
> +    case A_IRS_VMAP_VMR + 4:
> +        irs_vmap_vmr_write(s, domain,
> +                           deposit64(cs->irs_vmap_vmr[domain], 32, 32, data));
> +        return true;
>       case A_IRS_SPI_SELR:
>           cs->irs_spi_selr[domain] = data;
>           return true;
> @@ -1704,6 +1787,14 @@ static bool config_readll(GICv5 *s, GICv5Domain domain, hwaddr offset,
>               *data = 0;
>           }
>           return true;
> +    case A_IRS_VMAP_VMR:
> +        if (gicv5_domain_has_virt(cs, domain) && s->vmt_config[domain].valid) {
> +            *data = cs->irs_vmap_l2_vmtr[domain];

irs_vmap_l2_vmtr[] or irs_vmap_vmr[]?

> +        } else {
> +            /* RAZ/WI if no virt or no VM table */
> +            *data = 0;
> +        }
> +        return true;
>       }
>   
>       return false;
> @@ -1722,6 +1813,9 @@ static bool config_writell(GICv5 *s, GICv5Domain domain, hwaddr offset,
>       case A_IRS_VMAP_L2_VMTR:
>           irs_vmap_l2_vmtr_write(s, domain, data);
>           return true;
> +    case A_IRS_VMAP_VMR:
> +        irs_vmap_vmr_write(s, domain, data);
> +        return true;
>       }

