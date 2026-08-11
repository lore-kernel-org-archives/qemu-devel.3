Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03811C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 09:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtiux-0005s4-Kg; Tue, 11 Aug 2026 05:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtiuv-0005rL-Ck
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 05:37:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtiut-0006jj-Iu
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 05:37:04 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67B6W7Gf3307910
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 09:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xfCGWZXT3oxw/tjJcMGtiuXpqcDRd17qp77SjVBtg08=; b=FwboiTsc0ZI22djo
 qt7HR2Lz4NB5gFpSEJEe/3ZXs4xyNfe+tS64MFGZ0xz3ctKzVUrExPhIECxVVlER
 0e9exyd1UjshVT1r1j6jhBbVtWHvVDOm5shlSTJBaBFpgnWAkW6LolrV3KsllaMM
 HGum6KkxfRMZgt7vzvvGifZQd9zFF0KsHCftcko4jIROS2WqjB212lGEF15IMUUQ
 cHU1P2GYYKIVI2Cf0CVN8Otg3ijsMTsSlKbE5AssLaIG2LTl14SwdEwMTzt1rFYr
 J/BtBsJ2nF9UTusTuSD5cxqVE8w6HKqCAYWTKL+reH0uBVN5J3475g3XeKUVkmnq
 IwZeCw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyfud17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 09:37:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d33c89a29so28313061cf.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 02:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786441021; x=1787045821; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xfCGWZXT3oxw/tjJcMGtiuXpqcDRd17qp77SjVBtg08=;
 b=i7n4fi9KeFKZ+4EIepvmyG6+rnSJ8/AB3T1tlLJRuEdwIyhQ6eudjDgvN5AsQEvCn0
 AtKM8QZbvr8gr3SVisEM0Ai/BEenba2CXSEcKVkxLtP4ES5FDxFLxv9B6KP9n8VQKcH+
 mMqmuEvCAWQmHLpydOUmLV6ku5dd1is3gSZAlnHIe3zqi685wX3MFPbIPV4QJippFd9d
 hQMxBwyl0PzNoEP2qrqR9O+v9jjt7WjUa19Wr8CRuByhyTQYAnI+D6iE0zS11iloTOit
 N+QORqw0xQk1ZhMpQrWDpMHDDC3TqWXhLQ0b3+IaIK2ni1syg84ThEPvhVZ/78tNLKIt
 pT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786441021; x=1787045821;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xfCGWZXT3oxw/tjJcMGtiuXpqcDRd17qp77SjVBtg08=;
 b=lmke01q7KrNE1d+QCMI4XhXnqvAkGcNDwkrtI0wArHX3Mlfcld3BWp/ybnMqNJ5Kvc
 emY+ctMC79zXcj3eh+SPKkXLR6guXiL9J+e1EXRKnQYWklUe4pOYzgrSNwAKQNg5mhPM
 D7uyT1K8hPcnG2zqAr+sJlIoClxEOCcoJQB/GkWEesve4BDSjnRlelj1RRJJ677RMeS0
 c4RKxh+PcAUevScwGS8tcikWWH76yYtSPF4y2BF2pThJceUTTil3F/4PeXavm4fbfrfl
 BoNt1Z/HC88sdM+Z9DCALieKny2vNLF2+w01YFqLcBRTNwCRT5HvMxrmw4keQqSMvK/4
 JGDw==
X-Gm-Message-State: AOJu0Yxwt9RESKJguTiqqv2nu4LaMJYxxxCNC/ujCLB3uAR9xTcmP4Sm
 DfBj6HDZgTM/KEDtDk2qSiyPmE/TOzFRVRYxmZ1yVVoGWF1MjAEu5p2FbLP/5sBHVhwD4HFvuaU
 NtgnAQMegA381HPlBKYnqZ84H9PHbnW5W0qOwaLs53Lr8WYuN7/xz/r1dB9xZ5j5b4w==
X-Gm-Gg: AR+sD13NNVxHKuKMtg+lIkkj7Y/aQZ7Vd+jSt/qfKevnTy+KiyWtaVYR3h8nhSxQYJB
 ImLJaIFla8fiv3Br08BkxNxmqbvY0XWDoDexSX10usv9rzz099hFDjWuNbCCk/dBGqkkYZdcbpV
 xvs1W8wUoQcPjXA5nlhHqY7LePpYbOXzN77zHJ05umtDX9lx7r0lmwcBwn0fet44oy1dY7sw/lt
 cbPMtKnS3Sdn8XqsWW8+gTqVYooB2rxh4KvGFbGbE4FllIfAr3hDe+XKNbT98V7qLdPTd3rP76N
 +ejDX2HBo1mDmJIvIam12yJNDoFM8Gk+egN9c5v6rdN4dD8SgkuzojTmqqKE2oNoLIjbR8GOz4H
 ehA2w3SV8+D85MzA0RYcYLlNPldmYXAm0t5c=
X-Received: by 2002:ac8:5a50:0:b0:51c:257c:8164 with SMTP id
 d75a77b69052e-52d585e207emr12492151cf.25.1786441021135; 
 Tue, 11 Aug 2026 02:37:01 -0700 (PDT)
X-Received: by 2002:ac8:5a50:0:b0:51c:257c:8164 with SMTP id
 d75a77b69052e-52d585e207emr12491901cf.25.1786441020649; 
 Tue, 11 Aug 2026 02:37:00 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977baac4csm34960395e9.0.2026.08.11.02.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 02:36:59 -0700 (PDT)
Message-ID: <eff6e1f7-e477-42ea-a80a-14349bacb97b@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 11:36:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/nmi: Safer vCPU delivery
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <minyard@acm.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20260810213723.58467-1-philmd@oss.qualcomm.com>
 <ac8e5e46-eb2f-4e7d-aad8-390a940829e9@oss.qualcomm.com>
 <81799d60-4409-4286-8795-192e1b8ea4fa@oss.qualcomm.com>
In-Reply-To: <81799d60-4409-4286-8795-192e1b8ea4fa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: S42U1mWeY6hd-vp4LzkJdcaH4NfFwaNO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3OSBTYWx0ZWRfX04nfqACIN2SM
 WEnADBcjT9Rm/RQC2Ak9qvI9xtA6jGrY148rxnk1KC6WNX3Vk8wEjblWvPGcwTVhG14nrHalHJv
 woew8yzXU42EJapqdtZm13MtAzivpUg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3OSBTYWx0ZWRfX8kikvvvjbYUS
 a+PYjHnL8PcKoT5nhlHBX7t8Bf+46lLy3cnyPTE8jUsnDCYkSQnMbO0DQH3qEcxr9CF7Sq5g62H
 HKWJ1OSy662uhRh95fITQBtiuBDtKGNTE51pF4tM0LH+XhC8a2XPUqEPOT0Kev5PMYfzw7/A29E
 UenEI0cBjdN4em5fgTBCSjxAapSeYr2SwvkS7ffIHVkC383K1Isi81hjEj/3ojlC+xke+dL4Tsd
 82/9BTZ84XFFa/6FtXQ8T37d5e/z0oS4KVVMJdFb+biCQ57v2mtYfV9AOkgWb74N7oML4tqgeNb
 NE4vTb5s9JdxnL7w4LUbwKageHJcBzvQibdJmrSOUxBd2x5/PXtAT5PbsDdqbK91N6NjsMGHrni
 TRY81+CIqfHjyjBjx+zCEOCwOc9PQdicpxI0X6McXZYOk15tbCx7YDR8W4xRYDWsaud1O+Ynm5M
 JyGW0JUz/Vu+xS5FORA==
X-Proofpoint-GUID: S42U1mWeY6hd-vp4LzkJdcaH4NfFwaNO
X-Authority-Analysis: v=2.4 cv=Zd4t8MVA c=1 sm=1 tr=0 ts=6a7aed3d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=1QnTeQ4-yZ6FDZtMlo0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110079
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

On 11/8/26 10:50, Philippe Mathieu-DaudÃ© wrote:
> On 11/8/26 10:44, Philippe Mathieu-DaudÃ© wrote:
>> On 10/8/26 23:37, Philippe Mathieu-DaudÃ© wrote:
>>> Hi Marc-André,
>>>
>>> I don't remember what I suggested particularly for
>>> 20260626-qemu-no-hmp-v2-7-8af31bc54c61@redhat.com,
>>> but this series is what I had in mind back then.
>>>
>>> If you find it worthy, please consider including it
>>> in your "Make HMP optional" work.
>>
>> Not well explained, this series disentangle HMP from
>> the generic NMI class.

Actually previous version is better:
https://lore.kernel.org/qemu-devel/20240220150833.13674-1-philmd@linaro.org/

> 
> Oh no, one patch is missing!
> 
>>
>>>
>>> Regard,
>>>
>>> Phil.
>>>
>>> Philippe Mathieu-Daudé (4):
>>>    hw/nmi: Allow delivering to first available vCPU (not by index)
>>>    hw/nmi: Introduce nmi_cpu_handler() for vcpu-specific delivery
>>>    hw/s390x: Deliver per-vcpu NMI using nmi_cpu_handler
>>>    hw/nmi: Remove unused @cpu_index and @errp arguments
>>>
>>>   include/hw/core/nmi.h      | 10 +++++++++-
>>>   hw/core/nmi.c              | 25 ++++++++++++++++++++++---
>>>   hw/hppa/machine.c          |  4 ++--
>>>   hw/i386/x86.c              |  5 ++---
>>>   hw/intc/m68k_irqc.c        |  4 ++--
>>>   hw/ipmi/ipmi.c             |  2 +-
>>>   hw/m68k/q800-glue.c        |  4 ++--
>>>   hw/misc/macio/gpio.c       |  4 ++--
>>>   hw/ppc/pnv.c               |  7 +++----
>>>   hw/ppc/spapr.c             |  4 ++--
>>>   hw/s390x/s390-virtio-ccw.c |  6 ++----
>>>   hw/watchdog/watchdog.c     |  2 +-
>>>   12 files changed, 50 insertions(+), 27 deletions(-)
>>>
>>
>>
> 
> 


