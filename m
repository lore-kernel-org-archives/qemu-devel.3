Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC36C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnAR-0004Il-Lo; Tue, 11 Aug 2026 10:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtnAQ-0004IK-KL
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:09:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtnAP-0006Lm-1S
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:09:22 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDWjLB3718161
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 14:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 loFLSosiBV+eF5PC2iaEWFill6fpkAYwL4Gym0cCmzc=; b=N1QqEyAjViFzbpf1
 FdQ5xxcf1uRiNOAgemDgH/ozcJDGWuIPX98lvaSzaTewJwt6dA9/yWjpsBhHGWYT
 R+LX6H3HGaihk3DXhOLFlMaEkUFseXU/w43Bzyo+jX9rb49hzmK35UN0g3H8yoh5
 AnlDwv2sSf36/08tJD+oyYIGoAvJhSV38WEk98+vekXy/ecXdsUE3lM1cSRxm8wr
 HvikHVcsuzdf7Pn5KHxFVlkCb2zhR3DD6bbWiA0tkvGhx2vdq32dIq/og9gk0PAw
 0v8UO4LzFPG9NG+DwrxKVNcFRRtxjCEuDM8jXA6upCm6IahaAhHqTHgT5A2m26FE
 7BqMkQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyxwesm66-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 14:09:19 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-96910ded42cso106556241.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786457359; x=1787062159; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=loFLSosiBV+eF5PC2iaEWFill6fpkAYwL4Gym0cCmzc=;
 b=Pvs/bB/KSbbCGfdROavBpT+uH5nWyuvTzLhoUZivWZgwkSeTeWJA2oiL+dbBSpe02h
 TC8JWcGA9VsLK/l1N78aGUCmnPkSQVo4lxsP1Jcr/+TTDrizdHz+BkQCplbHa7loisWd
 PM4rJ/VX9kLV0AJT0eCrNp0Fuxnifv387B2EKk8MUjs8cLuSFBazflIsDXfHRkQP1g0M
 pFY2CvodavBM56RixkVt4UYMx4PsgU/eHDXpDLLZJYWa/nuwqiq4Mn8pO7ct1V9dIS64
 LG/O6QhCSYXHgrjlrmedDk2aiO3xeOhUINyNbNaSD/LJRPDdhAiaGvOigZRPdpWDy0Be
 lSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786457359; x=1787062159;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=loFLSosiBV+eF5PC2iaEWFill6fpkAYwL4Gym0cCmzc=;
 b=a5aMInBj2vQ7msxy4wrw+ERrXLOAMa4kJgU7xcpCanbMMZCECS807ekrhMgy5Z/lTv
 AsJfLGxBXoSvQHGjv1KkMZLjc1csutZN0KjibdG4XDRLjYFwg0LLSqjwcLK3/+8gI2Ym
 3znYQW8cilASe/vNNpBP/+W2fb3YArhpGI0y6Jc+fkbVrnTgPCmBhaJie/aPnf3o5VM8
 Oo2bd78ocY1LUNfJRJWgbUrz1DRRkPQvFPaOkf6QxP3hZeTubCWCQPUWhgz0wWLVpkVR
 KD+828S+bCVSfoEzDYNmO7aYGqObOxUQmkIYb2o0q6XWalKK76WeZSB6ZiTOYeuw0JVZ
 c8ng==
X-Gm-Message-State: AOJu0YwFx8EFdJ0snLkmMfssiOZ+plb+hBGhlZvxg07PcZP2k+B2Muy4
 3xf3XCeieA9XJcQHmq2yeoLdypE9e6/605t2E5arahdfLL4u8P9IjPTdH2mhcUaD7OBKFgrYk14
 RuBgG/oXYK4yE6gmu8rMZeKMKYuPPyAQP5WuSa9UAGDCgtl1UXHtpeHydXg==
X-Gm-Gg: AR+sD10PpFEftKUIf8GBbEA92vr35v6Qai8KbW3SRmOQ/emoPnIkEZD/K4XcWuZjudu
 tJ/NIO9pR0/nTF7hYyYw092ARQbQDIdYQvv1+duepQnJDJOKsNp+vpTE6IXd/ehqo1Xs7n4JgPl
 xE0WLiMRXPQEfn71BQ7Esq3t2ZidHxMPEStKb+c+iF5gP/sVgGoGj0bOpv13B33xOunCUY6IoeN
 yjqu17/ThDkzjnimrgV8LMDOzDPWUX2x6MeOawxvyE8Q2JEHFYmbT/kFHLhExDV5SbxdJ3oJ2kY
 H/SAgsNo/96eYAYCQjTwzawoIKsTwYgruo5IPG6uRS5mzxX1Qs+25P+ZvgklMQw8Qp/izrlM+yX
 Iu5GvD3XlaAuAZoJkkmDLBS/VWHMVNJZmQn/h2Ex/
X-Received: by 2002:a05:6102:915:b0:76b:12e9:a442 with SMTP id
 ada2fe7eead31-76b54f7ac18mr845926137.1.1786457358694; 
 Tue, 11 Aug 2026 07:09:18 -0700 (PDT)
X-Received: by 2002:a05:6102:915:b0:76b:12e9:a442 with SMTP id
 ada2fe7eead31-76b54f7ac18mr845914137.1.1786457358233; 
 Tue, 11 Aug 2026 07:09:18 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997415daa7sm62280715e9.12.2026.08.11.07.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 07:09:17 -0700 (PDT)
Message-ID: <a63982d6-cd6f-4945-9541-fb65b105e3ba@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 16:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] hw/nmi: Deliver NMI only once
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <minyard@acm.org>, Markus Armbruster <armbru@redhat.com>
References: <20260811105425.7429-1-philmd@oss.qualcomm.com>
 <20260811105425.7429-8-philmd@oss.qualcomm.com>
 <CAFEAcA-kPGVfJ5KfKYLVJaEtxCZd_Qhs44j9HB4XxWQ7GZ5t_Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA-kPGVfJ5KfKYLVJaEtxCZd_Qhs44j9HB4XxWQ7GZ5t_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wsOUAsSdv7wBs_cPr9hTefExVPHtxhrS
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=6a7b2d0f cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=QwkVr2a9dXBqvz9nFN0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: wsOUAsSdv7wBs_cPr9hTefExVPHtxhrS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExOCBTYWx0ZWRfXyZf/NabOfHBj
 YbqOeX63nukbo44Cvb12gvVt4oDG2FBcgbJjuJFPjzzbIjaFYZQj0sjzs9KgFvtLzrDLFotUE83
 ItSqjzr0thJicxxhDAueJ7LTqoG1pEI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExOCBTYWx0ZWRfX21jeRrHtQ67X
 22W3jbny81oTqBjbbribnRnh/8xeIBSlWZ/WGP4DJW+H1/xRcmloFjCdooTbfsU8qWYhhUujgK9
 n3zIUUVTBsdaGrtY/lvpyNlEEJ8UqdiPsfRljkAxkYZgdWe0wFbRKtUINEXsdm4vMhyUV+1QWcM
 CvrJnZ+zZucABgU1af+qViA5iF/U6v3J1R0IZ1NhqP4Ub36GIGMocIfTyLbYPhFCktMFnNzLW1n
 uVetOAMMRzFI/IU9+GRKpIF7v94G1j9ohijBKV/Js6CWsvGtiJkKY+BhzD+YVxxODL4BT9FrG9d
 qXApopNvmS2x+3UZCNhqcgMY0zHF75IRJyPZpilgge3b+3Wb0CALJ1P/PL3zg/N6mTsXlnVe6xL
 GlBD0kjGGl/2XMYzLjWD0U8GtXo8ZLpSv6Y1RorJpYEJhG9d81oTaw9+FVuN5VTkFRuWxaDaG68
 ImrUkwKcuXHAZUFgOtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110118
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

On 11/8/26 15:34, Peter Maydell wrote:
> On Tue, 11 Aug 2026 at 11:55, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> Use the first handler available to deliver NMI only once.
>> If anothers handlers are available, no need to keep delivering.
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   hw/core/nmi.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/core/nmi.c b/hw/core/nmi.c
>> index 8eea75ad530..4fe5ee75bfc 100644
>> --- a/hw/core/nmi.c
>> +++ b/hw/core/nmi.c
>> @@ -31,6 +31,8 @@ static int do_nmi(Object *o, void *opaque)
>>       if (n) {
>>           *handled = true;
>>           NMI_GET_CLASS(n)->deliver_nmi(n);
>> +        /* We only need to deliver NMI once */
>> +        return 1;
>>       }
>>
>>       return 0;
> 
> Looking back at my review comments on v1 of this series,
> I think we could clarify the comment / commit message a bit.
> Commit message:
> 
> We only expect one device in the system to implement the
> TYPE_NMI interface (typically the machine, but in a few cases
> for e.g. m68k and ppc this is an interrupt controller or
> similar device); so we don't need to keep walking the whole
> QOM tree once we've found it. As no machine type creates more
> than one object implementing TYPE_NMI, this is not a behaviour
> change.
> 
> and comment:
> 
>   /*
>    * We expect only one object to implement TYPE_NMI, so once
>    * we've asked it to deliver the NMI we can stop looking.
>    */
> 
> With that
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks for the wording help!


