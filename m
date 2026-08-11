Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CF7C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtiBk-0005Jm-8m; Tue, 11 Aug 2026 04:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtiBe-0005J4-9a
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:50:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtiBa-0001rR-TB
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:50:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67B7DOUr4156741
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eVyr1pEzlrBGMxTuELPwalOB9ZaqN51oADKYB3j+pd8=; b=CvXDETpFNISciUmc
 O6MogZ2yD+Ydodp3b66AYPhPD1Qtx/By7TzUQ5pjAM8SjP7hLcsPlZcjOjY13xwd
 cyHbxKIEmeROwsM9O0ZXyOH9ylUDJ20XPujL9oCt3QtOStg25EVH33c2ycpPg03r
 v0pJ8YyhE4wys4QvylabzYFXjOp4yY3TAZkhUm/1cFZ9CWhayWw8L/K6PLClFiBm
 GoSQZZJuvwitdAAbimF+l3SXbPFtFWnWmSOWUNZed6z4kY2pjvH0MnA6sKJcq6wQ
 jaGEv9hx2eVTmPzKFlCmRq2OkTQAHr7Ruv0AUyvwqVp7ODkaUSC+WVJAmlrieZmT
 uGf9YQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyhp8km7n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:50:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso48264031cf.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786438209; x=1787043009; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eVyr1pEzlrBGMxTuELPwalOB9ZaqN51oADKYB3j+pd8=;
 b=HrfB4MEoecouJS7jHIL3EZd9XqhQ8waKCJBMRGH+DQ5KciMAoOjo+P9jDZx+nTBfqr
 SSduP4bmAORBL1sJcjGJgIOJraqCG/dllnTAOlwmej/lYIneoPukoZtC8148aZkbBXYG
 ek1Etevy7oN0m4hKaHd9nGR9kMwUN/q36/UWQvB0eAuXBILB0YXp9BTUI8cw+NCawruz
 UDk8h5ZvmTvLBLqzAvAakQqLWTHGJjNtt+lfC46LYkkmBQDDiL8xrhKPsI2A6GZJOUSy
 b5S/WO6hfz9A6pvAveC7LDIxMnUp1Oy7oknklbgBNiDSfvG0ELJQP83uICJOSsl2ZNAG
 KL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786438209; x=1787043009;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eVyr1pEzlrBGMxTuELPwalOB9ZaqN51oADKYB3j+pd8=;
 b=o3SqCXujC+p8wY8sqlu7cMeCFqLjUNOq/fooxWdoKNG1Hk8M5TO/R/bdWkrWlukyOs
 5AOh/yZ29iz+NzYa32KE2xUa1joY4M3ssdV7seBhLkPWWs2nT/dkITLBDy8j1n6PKJcj
 tWChCKV45blzPuuL27G20hchmtzbB0VpIT/W1y9u/MjlJmzVtN5kH6R6msaO2X+JtQYv
 CIpb4iIMSYLyw3JfCg9/bRTZ2im9LRrgWIojEGX5F5Plrm/r6n0ORq/cwK54myrdO6iY
 0wWCTkHA1wPLh/Y/OkK9/fJgwJ7BTMt1S0wim80iveOnqDEtpieg/LU1Lxy6Ebv5mTr0
 5Y3Q==
X-Gm-Message-State: AOJu0Yw+NYSYIUabtaxOru7rLd1ijMy+d19vGEpqXkDyjBbfBJ2lrSOP
 heFOFC4+vO+U9E5cXaksYD10zVnVIMKk4ayfK1G8ChgGJGYajIy4s0IBz2ExSTDvreaXSnXNchO
 RekZS8+zNtLL7NgK+NWUKiGo9cCvOIOO1LywVOV3/ovpO0dH9bcah0PkRwdqw0yotRA==
X-Gm-Gg: AR+sD12I0ezqTJTBQ909KtkSgdp+Th4zfaV/oGeG916xvXcKGc8p7rM39wqYGq1epHH
 oxHATBn4HBSBSNWXWv1BiDdeWR4YJoVOnTxY2FIUMIoHHhz0KFgKuujbKG1gGjHsJe5sg0wg9IZ
 TDftoA50ytJFcGzyY9EOAYkeKGgBfRh6QUKw202a9s0tv+IF1/ydhsJI3IeTSnhJBf54sme/399
 BuPd6mUOL7Ob57p8NWwyMpmNiXUn4mS8cc4jIiHcyPjF7f3PD/B7NxuxlLTr4PjUkNcs9P/vwx6
 q5Ojwd9QNwsWgcEtDnn4aUvD4Tl1IyxMHEhA8dg0LICr4lsYtO03N1vgxdRB6U+4W/A34XwFBrH
 Z+nud6brTHRzuh4sjHKuQ7HF2LjimF+slqs8=
X-Received: by 2002:a05:622a:1aa4:b0:51c:2685:2964 with SMTP id
 d75a77b69052e-52d5866c112mr11427011cf.43.1786438209619; 
 Tue, 11 Aug 2026 01:50:09 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa4:b0:51c:2685:2964 with SMTP id
 d75a77b69052e-52d5866c112mr11426861cf.43.1786438209203; 
 Tue, 11 Aug 2026 01:50:09 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499788f17ccsm24291955e9.11.2026.08.11.01.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 01:50:08 -0700 (PDT)
Message-ID: <81799d60-4409-4286-8795-192e1b8ea4fa@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 10:50:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/nmi: Safer vCPU delivery
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <minyard@acm.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20260810213723.58467-1-philmd@oss.qualcomm.com>
 <ac8e5e46-eb2f-4e7d-aad8-390a940829e9@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ac8e5e46-eb2f-4e7d-aad8-390a940829e9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MiBTYWx0ZWRfXxNoRO6WKRoL7
 WmNLqOr2mfgda2DgIDWST0EUCT+3aH0R2mNkuJ5kPytR+3c+2wjIKGe+W6NoRBW1fWvPLVl4xCm
 1wmK9FxMyMGBzZY/gn4neGA5qyZWv20=
X-Proofpoint-GUID: u2yRVWfKT-JtETYO88JbNBHe3ACsuGCf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MiBTYWx0ZWRfX+EvFsPsHjF/f
 o9lWjGWWVUL9WFQk1JRn1Gr/hQg9SnJEovpjZ3KIx/yYNyaG6/YmxA58ekN17HfhNecOruZKsR3
 Tt0MZ7fE0VX8r4OKGWKS9kso4vBbXQRkp79i4tuARI5G5ahmv5mGeaBvwgT4vG6cL1SmymIzaHi
 iCw7NMtwXpLp319QubuxKcYUzH5qMYS1m7mIiKLpsIQCvkuW0vcxfEmh++S1dYyK7XFGcP0m8ID
 BGk1/Oxn2zBduCGuNWENPx4zTBvSmgI16cAv/pS0fS3WHnU0GLcXC6485W1LVrGasys8JPHfFKQ
 CNsMgPaE2VYpu2dQo2FJfwDxVIQxeQD14vzE06MB+XIwCfswfY8Q/uNsk3+0fqmggnAoke9cEYf
 RlBT793tHOprAnjwLy+4MznwFZMRpBqcm9KhVAibdOpOU8NCCkRSqdL1LBlQCWnKf9kmXsXoeRq
 aCW9ab0Nqi8hiAgWqtA==
X-Authority-Analysis: v=2.4 cv=RM+D2Yi+ c=1 sm=1 tr=0 ts=6a7ae242 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=gFk9ZIMQH04VPGbQW5UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: u2yRVWfKT-JtETYO88JbNBHe3ACsuGCf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110072
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

On 11/8/26 10:44, Philippe Mathieu-DaudÃ© wrote:
> On 10/8/26 23:37, Philippe Mathieu-DaudÃ© wrote:
>> Hi Marc-André,
>>
>> I don't remember what I suggested particularly for
>> 20260626-qemu-no-hmp-v2-7-8af31bc54c61@redhat.com,
>> but this series is what I had in mind back then.
>>
>> If you find it worthy, please consider including it
>> in your "Make HMP optional" work.
> 
> Not well explained, this series disentangle HMP from
> the generic NMI class.

Oh no, one patch is missing!

> 
>>
>> Regard,
>>
>> Phil.
>>
>> Philippe Mathieu-Daudé (4):
>>    hw/nmi: Allow delivering to first available vCPU (not by index)
>>    hw/nmi: Introduce nmi_cpu_handler() for vcpu-specific delivery
>>    hw/s390x: Deliver per-vcpu NMI using nmi_cpu_handler
>>    hw/nmi: Remove unused @cpu_index and @errp arguments
>>
>>   include/hw/core/nmi.h      | 10 +++++++++-
>>   hw/core/nmi.c              | 25 ++++++++++++++++++++++---
>>   hw/hppa/machine.c          |  4 ++--
>>   hw/i386/x86.c              |  5 ++---
>>   hw/intc/m68k_irqc.c        |  4 ++--
>>   hw/ipmi/ipmi.c             |  2 +-
>>   hw/m68k/q800-glue.c        |  4 ++--
>>   hw/misc/macio/gpio.c       |  4 ++--
>>   hw/ppc/pnv.c               |  7 +++----
>>   hw/ppc/spapr.c             |  4 ++--
>>   hw/s390x/s390-virtio-ccw.c |  6 ++----
>>   hw/watchdog/watchdog.c     |  2 +-
>>   12 files changed, 50 insertions(+), 27 deletions(-)
>>
> 
> 


