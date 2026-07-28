Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94DAC54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokMc-0003pF-9i; Tue, 28 Jul 2026 12:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wokMU-0003n8-EM
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:09:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wokMR-0000DK-Iv
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:08:58 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SEcoeP3245095
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 16:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fiHlCjiRzEuJc6dDe4rlXDESMOocWFDjYp64zkJyJsU=; b=eRlc4P9EEpkfXxxF
 6Wtf8tQsZfC3nxUNj4EMkuCi+ssK+CwzMzNSyqP5xHTlPKgL7H+3dkyQcOCIBlp/
 kRWjqIelksuDG+6KWDEjl6mGkkjETuZKjgq5XPoE+ym8xmNzGcxP2pP29AGxvjgY
 wFZoIJlvzX6YHGft3v/lmlHavSFaOve9pcCmMxaOTQcyFqnPT+9IqI01xRw2L4zm
 EZO3qaGou/yj7BLkRnaWWbvi863Iq1ZPFMbij9Ss7/wOs7AKy/iHbYc4gvFH+Dpv
 pA4Fd0P7CrWROtyY2n0fq6fTXobn1k6acQXax732oJrAy/rKmLabo8RxFhdcHVha
 OlwbIA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fptathusn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 16:08:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bf321d786so44730751cf.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785254932; x=1785859732; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fiHlCjiRzEuJc6dDe4rlXDESMOocWFDjYp64zkJyJsU=;
 b=LuPVT59S2gNGwD13Gdt130kT5eFpIDaGXXt112rLCaEK5ieXV0yM7aVC/yR2ci51Ky
 99Ob29pX/CpVLd98JRaNzQ0GE+8ZwT4cHDXLFv2LM471dwRaDxZv5dCklV7aUPFJXXP+
 Jtyj2TVxIGgRylfd06+VuxPszAi2QubTIZ8sYcMi57WfOEeSDAwuApmRENXc4qoOc4y2
 CHEcz/8e436cfGUKx/LmXm+hRIfgq+tNJQl6B+AyWy7o88m4ZoGKuKdeu2spfMhlr543
 1r85igZW7mYi0e2zXo64LgSevqVruAVp5fJ7855rTx8vjB1BqXqnREpxPqkrt2M1eLfa
 PyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785254932; x=1785859732;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fiHlCjiRzEuJc6dDe4rlXDESMOocWFDjYp64zkJyJsU=;
 b=iKQlM1cNwlWvwJKcdnp/DEn6FrQp1AnHYPQTwz8GrViYJGNTCVlaYvNgZJmPPaf0OW
 wBZALGXMe2rJxUmg3H0hsa10Gc+/Jv4EwrlU8I0a6qcx4m/K/2k0ftWsf/wnqjuCQimP
 z85xWnS75QM2f9+7nEHwHy7cZe19mqQbYGXYSV3yUapa5ExioOnd9zUAzHzL7u+HFGGo
 RnEdzdeajr4z+Eer4vz7U+rilLOA1AP/lvkFG18lACZXKQaX8UgQR+23k7s1StjuJ0nk
 z8P9rIgthrYq5alkvV6yPpGNwsyksWRFXTiLjL8T09KFESTfCi/pbbAfMVLLIoTuGrgx
 dNYA==
X-Gm-Message-State: AOJu0YyaAB46+0Ud2xY4llU3+xJ0xzX4dUqQN1Al0Ee/rxoV5spJ3GSm
 IvHQKncNQzou9ci1ssv6xpJiNfqvGgV7QpS3y5XhaTlKOplAvUGnZZ+UnI8ioliUylxr8s9ht77
 ziyOeHMll52tq/Qk/j7TKlQwZbAImffCVQ8vg5UTi/BIXVraPphf7wwh4Iw==
X-Gm-Gg: AR+sD12Las/fE1YHgVhEO4qwPkaE65FVhHxwcoSdTYNvk7QD51OE0SlTLRrIE0T3tr3
 uw4Nfo4B/hoyzk1a3xDOLIHF/I6B3Y1+JhZXe4chRAySJxyq3Om+SAowteaECjFpu+J79xkwYBA
 6+8QOIBId54d5h/Tv29E7RMdic1IexAj0zoo44x8ZVOYOa6Yc+ioCUh1fUOMsugTXLiRgX/lOss
 NoPqr33UokORqFVHdEA02s12/WNCLZX02lF0sC8j0jkZsJB/Y2EwJ3mQ+q9uhshWyvfRwtzeiv+
 WhACLn7fIeHHkpKS8c8IVKmnDNtNBuVItLt4OLnNDLEjJY7d7kdHZZUg4upljUrthdoahH6PQjM
 iu5IIWLagtoOFi1HK2/hpT8yBnIU5k3qa0LFvm5OPD4RxsLNadAI=
X-Received: by 2002:ac8:5890:0:b0:528:22:8c68 with SMTP id
 d75a77b69052e-529d710f776mr27970051cf.25.1785254931722; 
 Tue, 28 Jul 2026 09:08:51 -0700 (PDT)
X-Received: by 2002:ac8:5890:0:b0:528:22:8c68 with SMTP id
 d75a77b69052e-529d710f776mr27969331cf.25.1785254931036; 
 Tue, 28 Jul 2026 09:08:51 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b191a0sm178014f8f.28.2026.07.28.09.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 09:08:50 -0700 (PDT)
Message-ID: <e14891ed-faa6-4778-a652-ef0a6925e1d5@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:08:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/nvme: fix unintentional integer overflow in shift
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260728-fix-shift-v1-1-bdb98c205233@samsung.com>
 <7428df68-ffb9-429b-b0ab-8c009c0c42ad@oss.qualcomm.com>
 <amh5lvDUQ-cOOgNb@AALNPWKJENSEN.aal.scsc.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <amh5lvDUQ-cOOgNb@AALNPWKJENSEN.aal.scsc.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0MyBTYWx0ZWRfXyFE/DwXO3VbC
 +i5OaxEe6KoQYQVR9xHWPw12AkhTcbglSBw/Lr4FXrMq4feA6Kn6iUKxUsOntGCg9jbUGLzaLR1
 EQlJUJfg4NNpuj1GCEVA+/ArVJ2g470=
X-Proofpoint-ORIG-GUID: sw2LL65dO1QV9FtARTwZLr3ah1Qes01G
X-Authority-Analysis: v=2.4 cv=KtJ9H2WN c=1 sm=1 tr=0 ts=6a68d414 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=hD80L64hAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=7lQ7JEI3HuBqGH3S-pAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: sw2LL65dO1QV9FtARTwZLr3ah1Qes01G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0MyBTYWx0ZWRfX7JBKhdsDk84q
 1sEobQeU+S+Xn+FZYU1ABQY3VrqnNzAh4PNZ2b6FMrg6lCRd7JqVpno/TF0ynzJAaXBitN+RH9i
 RhjZhFA4FQDuX/gaGAjnnDYmT5uTrEiagKyZ3xmuGv3Tz4660KkChv0Qwy6+yz7Wpx7urv2Ft3t
 7nwXAKZmtGSJPZi4Gfhn7fW7SkrbgmigEp2AQQMmAGwlMRCGGrfIDZvnsd/HV63LUQTk1Ex5CLz
 PVGjFN412nn9qwQ8hAri0ggFdEZAJIAdjNLlOeQfSa/oBhiuVnOw9kTavmI5V9YO3eLSdF0J/7a
 IHjtXyf1RhV8NEVDaDY/otVweqagcvVff4VW+12VIqtQ/HgwxOT9E4w/eP/LsxtU7DrLaeI1yBv
 iZuzifX4/ypCK/loNVmHcLsRVvxi4TiLSjVe68PpNVDWRnsHSyD6ct6XEuJ28HRbZhoLbLQJp7q
 K2B+o3nddSuV4nB2vkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280143
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 28/7/26 11:42, Klaus Jensen wrote:
> On Jul 28 11:34, Philippe Mathieu-Daudé wrote:
>> On 28/7/26 11:26, Klaus Jensen wrote:
>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>
>>> Fix potentially overflowing shift operation.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>> Resolves: Coverity CID 1663674
>>> Fixes: ec917cd49918 ("hw/nvme: fix FDP set FDP events")
>>> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>>> ---
>>>    hw/nvme/ctrl.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
>>> index a67e1598891c..40f22fdc40bd 100644
>>> --- a/hw/nvme/ctrl.c
>>> +++ b/hw/nvme/ctrl.c
>>> @@ -6622,7 +6622,7 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
>>>            if (!shift && event_type) {
>>>                continue;
>>>            }
>>> -        event_mask |= (1 << nvme_fdp_evf_shifts[events[i]]);
>>> +        event_mask |= (1ULL << nvme_fdp_evf_shifts[events[i]]);
>>
>> Alternatively:
>>
>>    event_mask = deposit64(event_mask, nvme_fdp_evf_shifts[events[i]], 1);
>>
> 
> Better! Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> 
>>>        }
>>>        if (enable) {
>>>
>>> ---
>>> base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
>>> change-id: 20260728-fix-shift-525e53c1df6f
>>>
>>> Best regards,
>>
>>


