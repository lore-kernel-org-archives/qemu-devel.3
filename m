Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE744C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZNF-0000Ga-BW; Tue, 14 Jul 2026 05:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZND-0000Ff-8j
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:24:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZNB-0007gT-Hw
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:24:19 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SZ8L4005264
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kwZLbG00s3qK2E9+IT/+QkPe1+PdqMPbGrfVl40b+xc=; b=QyL/do7+0j4VgGPO
 BaxmAgrnwz1q/89+81CH6fQi16aScSLg3AlY3MuUe8C5/OLUO1JVGP+lReF9yMdZ
 m7ihB/mB6cNd6gMtmGUdtG0FATHR9ShRC2IaqI99aNFUt9RAGWsvzG+HS1TrzygC
 /qHqx/rKxxgA8cM27aEEQNP26Umszhcvr7jV0iDXmZYOJFRukyVHnaPDuFoYKBY6
 YPr6DKh/GX4gnTotFROS/C290jxubk1cl8t09EjyhPkYUN0QkBTtC1muOcmXe6Qp
 d3Kk8lq9uBCj2rmelYX0htl+MqPzeCzTWkjBzpKhIUD4TJuFE5lccBrH3jDG0Cv9
 XQGYyQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44cu1tc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:24:15 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso75537801cf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784021054; x=1784625854; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kwZLbG00s3qK2E9+IT/+QkPe1+PdqMPbGrfVl40b+xc=;
 b=ZfL6DqM2d7YB6Wd6MJfjqQ8I7ztUm5DY+1IjyZGDp+xactvS0n2zLtLS0C/IsnW9/d
 M9afmEzx//bb3sErfdWnDEapP0+6/MZwy6d5GsnRM9WetgvMVA7OVrCVjqKv9WnI7LeW
 DUmonLiydT+hlO4TEiTK3v2Do1mMrDwTs3cF7++qKtnc5qnD24RdNHu0/lk5/DCLZITu
 avjrvopnWIGCZzUuVsEZSvevXDFPOsN/pci/YqRV4RKWQl+CVlAmQUPg62TKQqMmsJ+i
 W7ope44DJmV3bPdfP69NOXuSpRtBF674BPJregm++dfMa3hbBP925jT9pOTeX6+PA9oe
 gDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784021054; x=1784625854;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kwZLbG00s3qK2E9+IT/+QkPe1+PdqMPbGrfVl40b+xc=;
 b=QJk+6GLWa2d+Z0T1vttnGrlcdFLQ7jTQ+q5E232Jt1BC2o65I+wUmwazMjNHEtPSjJ
 z0/aPXKsD5+5uBZn/PeJgxGkkyQ0Wy3QeMrHUoDtIP01FuRl45UVDpqkOC6upEzXwp3e
 Z6QNcmXsSME5J7qkzq4k6UE93Hc4XzHnkyO8YctRTsB6HVGdqWFKQXBr5qd1YTNTJTPA
 osaC17/BHrTNGrFXEQjXmUjdTuyLZ5VpSLBXmwVY0Ysc7zaZY9GAdwkbllNFeE5f/PYp
 47XsnFVYr4+9GI3sbojriWgCHoIFPyt+lrce3g3fQKWslFWQVM48afvh2RPTflcuw4U6
 UjEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RomQjr+UxVY7owTmYgJ7sxq6BaM91tFTZLSs1zxyecBYfkMqKLq7UR9ea3/XRcmRsjrmBwSRTsxImuP@nongnu.org
X-Gm-Message-State: AOJu0Yz3NiLXwXskcdXejfcXUU/715iwUMtLHzxIY5zfWdOVlfRhp4lg
 Vq+fJ3N7WX0tmat5qCaaV/7j1z+dTtD5nX6WYsUua20jo0sgPUlF+4qZFKiJ7ldvTChjnk+6Nwe
 F5OEr6MhIYPCs07Ajw4zZA7fwZ8geBK1KqGRAhqACCWwzYmLIDAUqNaBqdw==
X-Gm-Gg: AfdE7cnfc82M4o9fOhLwDJRVRXXmB+V8dWOumTG2zaL695bPh0iJG5tf0r2bzuXdfRY
 54iWPEB2zRVeIAJK1Dwcfjo9ULrm51MaXE+LbgPimHKB9ajrCTA/i1UYVb8IWVDZD4JpNbxILJ8
 hjEork/nrjQqmCEMKAIhV2UQF1CjMGmNRpLx6kJzLCjCOryvoi7ENmhiBTgFl5UxKAA7LG6lm6D
 KexJwX0TPtpgxl3ErC+HMMk4qT44rU9VlimC//oeBU5XvksTKQR/DizMvmlfHF/5CkGwktkLCfc
 rO7N7Wm2XQDV08YLWwp9udNF/tGEZuOYfBptFNT0OjyLuafwa1CddTRaRc4BosEMvhkW9GspqSe
 zMSQmwiioz65byV33gwKJtkY7uDceRWD3hx/tL7ou0KPeT1ZCNCb16KUncpu3qQ==
X-Received: by 2002:ac8:5fd0:0:b0:51c:7b13:62fd with SMTP id
 d75a77b69052e-51e3c39cf0dmr26799051cf.83.1784021054228; 
 Tue, 14 Jul 2026 02:24:14 -0700 (PDT)
X-Received: by 2002:ac8:5fd0:0:b0:51c:7b13:62fd with SMTP id
 d75a77b69052e-51e3c39cf0dmr26798921cf.83.1784021053787; 
 Tue, 14 Jul 2026 02:24:13 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15dfda815dsm793849366b.36.2026.07.14.02.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:24:13 -0700 (PDT)
Message-ID: <c49d8ebe-d85d-4f43-a8ca-e006d4a411bf@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:24:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv/virt: Add optional UART1
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Yanfeng Liu <yfliu2008@qq.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <tencent_06551FAEA44CD75E915AE611FCA0C99CDD09@qq.com>
 <24329582-f5cf-41de-aabe-c2c3d54f03ea@oss.qualcomm.com>
 <tencent_3045B23CF7A9872F29FC351E24D8F9373F07@qq.com>
 <6c0ff642-8125-4c35-8ed0-8f89da555ee9@oss.qualcomm.com>
 <CAFEAcA-AqgGDgRkkc4MzCcE1zeMT-aWbYoyPYsUJsYShy0-0dA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA-AqgGDgRkkc4MzCcE1zeMT-aWbYoyPYsUJsYShy0-0dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HrraLNna-_VwqRA7TLnEOdk0AnsoxQ5H
X-Proofpoint-ORIG-GUID: HrraLNna-_VwqRA7TLnEOdk0AnsoxQ5H
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5NyBTYWx0ZWRfX5g3Egpprj9ub
 OjmSVUPfo43zOgY7btZlRGD0kdC2PtAKFb8gF2ZjAim3I18hS9legBRy5OMHPKpKLdI2h6KFGXJ
 En8QdzssewIDd16BAELNpXgwhXy0g4A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5NyBTYWx0ZWRfXwo6q5lMQxCdf
 OCdLo3HGrRaX4USivXNv3i8OusW0qydnMLujKM3L3ohbBZS553q2mdLQ/jgfPnJHaVv1DrYaEe5
 bOhekXYQ4jNJT6cKSjPoFn29EyM/mkQdXwzdt3UqBqdOIGrtrq9GI+Ypw0+v2mJAyt3UF3vWIbE
 njAC/BOuR6ZK0vrbLIIMVIERKkNBHkRffalkITMgwZepzew4x1AkKThSIubLYtKOHihDtfCWTrg
 jELnda053nKiLW19+Tl43Amh14t0JJR+yOHu6gIO6PbEgBwEsVLrgPjLXD0lC5u1jc2T/97dW0O
 y3xQqdy5MndDGNI1VRqL3AD9wmirNVM3ptV+NHtNYGUcE2GsrCn8gHlya58pE9QAQvIYWJXerer
 9ClcgHEkw5w3CqIL2XC074Fk+M2qJ0R1+BWX1WFheqdtBrVr65jmy4UrhL60VFAJhZwyLboclgi
 OTADHejBB4VrqZEz9YA==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a56003f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Ce5UDDiJR_swwK8C2rEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140097
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

On 14/7/26 10:52, Peter Maydell wrote:
> On Sun, 5 Jul 2026 at 23:05, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 4/7/26 03:41, Yanfeng Liu wrote:
>>>
>>> Philippe,
>>>
>>> The v1 always creates UART1 carelessly, then Peter suggested following
>>> 5d8a250f9068 (openrisc) and e7100972f2 (arm) to reduce guest breakage.
>>
>> Oh I missed that. I'm confused because I thought not checking for
>> backend use of a chardev (in particular calling serial_hd) was part
>> of Peter's recommendations, since he did that cleanup years ago.
> 
> Where we're modelling a real piece of hardware that always has,
> say, two UARTs, we want to always create both UARTs (because they're
> always there in the real hardware, whether there's a serial cable
> plugged into them or not). Having the chardev code handle "backend
> is NULL" as equivalent to "this is the do-nothing backend" lets us
> avoid unnecessary conditionals in the board code.
> 
> For "virtual" board types where it's QEMU defining what they are,
> the situation is a little different. Ideally we'd do the simple
> thing, i.e. "just create all the devices", but where there's
> existing guest software that makes assumptions about how older
> versions of QEMU used to behave and the number of users of the
> board type is big enough that we care about not breaking that,
> we sometimes need to do something else. The "only create the
> second UART if the user puts another -serial option on the
> command line" was the best idea I could come up with for letting
> the user opt into the extra functionality if they needed it.
> 
> (If we have another future architecture that creates a "virt"
> board type we should make sure we have it create at least two
> UARTs right from the beginning, because we've now made this
> mistake twice :-))

Thanks for the clarification, I missed this is a built up
virt board where QEMU itself announces the hw available,
not some real world model.

Regards,

Phil.

