Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48C6C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wti6D-0004DD-Q8; Tue, 11 Aug 2026 04:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wti67-0004Cm-OX
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:44:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wti66-000193-8B
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:44:35 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67B6ulqY2813303
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CWiqnl15AGuLmAULW3gHT+Dhud7LvRv9mR3RGSOS0k0=; b=oVVDVD58jUdEjBNp
 nUue/l6k0Dh1YPN05BI6Y0TUjYEgz3fzrie/z+53nzP0J/FzlOxCNGAQaPkl2mQj
 hDMqHdS+gGv810HPBxq6cFfjvKmSi4Bd9rqT0MK04TCY5UaFV8HLJg3oQ5FiPdG1
 PhD+tTlsXvFBqR6j+4vrfwcWMAr4Lu2Qa5qzD+odQRy11X2DOpzrB5HuIa6jyIl2
 UGJ2ZmsK4bNb32IixVXEbN6f7bFG7WHzHO2vSVAwf8SUeSAGtt94L0lbb0CDHqpu
 8SiY/hxi7/hVCuXWn7IYO4HWtetkaMcJnIh1vuOLMz6xhk+m/AeD/WE4vm0Y43Jj
 SCciUQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyxwerdgs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:44:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c20762d21so36667411cf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786437870; x=1787042670; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CWiqnl15AGuLmAULW3gHT+Dhud7LvRv9mR3RGSOS0k0=;
 b=Yjl15sVLiGM/P3eop96QpcOzP2d5ahfyCkQVc/1ISDuGtbfbwN6lxPnjai4Jh6Gvaf
 ReiIl4ZBQG7xFl/y9/shiI3dJr2BCjF3h/9gcEkOotTe5TzItZ/TwZRpyc/TdcE07q9P
 NheLw1aN1O/LQKzrnjvSWePdUMNtX/1krlM6LDCY7EyVTDgoHuBf/a4fz/xtec6kEc7g
 jDIAwWPz+zZsC5RkMO2Nfjq6JGvlZPSARsJziF+iSACTFA1p8wOByLWvDRLGMrK+F2Rc
 pKiqVsoNnc7+lqNehJrlHiKguD7xr1TQdt7vQPMCgJe8GvmXe0Eu6Nw80XxlturYHj5A
 ep9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786437870; x=1787042670;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CWiqnl15AGuLmAULW3gHT+Dhud7LvRv9mR3RGSOS0k0=;
 b=lyu1n0mhoqes0sigG3A9xyW0Om6T43Ck73npTAfu50vZ+mAQn6CCu0AD3x4x8odSm1
 h26dJUt0i7ka6HTv0iESq9k7NZroc4x64o4+aWdsu1HB2XgDwaE4UJd6o7M6y4gMuooi
 NtD5dFVB28+ZZLcVhyMMUpqrx7+/PBuGuXqeALOjERuY5JOR0Cva7axI8pMJecrQebjB
 G3J+OGgZI1hSJeZuHBBcgFT1stpPmpZ0//yjMXiIpoKplQfccyinKFVxcj6alsnWX3ny
 W7JwD9NrORGC8BbiCofC7DpEi8fWw754mqL9tWOoncuD2XINjPxN28MoU1y2cN0WFx5w
 reEg==
X-Gm-Message-State: AOJu0YwCI4QZe3Ev6ndt9wH4IzBDEmX5en6g88uNrUWCQn+w1TKh4yda
 rdYWpIClqJFa4IyQOH2w/W3o3n6eruYfahxxsXyJPKepdeOJAm0DH7gvCKLV7l/jCxd+RjzXfVB
 F5rLVkLk7vWmIQHqxqpFZzmOynzillzuieqmOaq5kRqP8iIkBLtF8s0HThJwwLDWvyQ==
X-Gm-Gg: AR+sD11g28I/hOc0KitX1+Zec1L0fpdMNjWjw4YOGeJgCGkoNZyt1Y5Pydz8ADXtlSn
 tDM9cv1A2Mvd1n2q4b2R2p3Hk+GeVBJ7KdtmoJDQKDOyl1AM354Ph5Vrmw6A8cpOjTnbVb0YEUF
 JRaGgnxvYxsRoER/7WZXYaQDAzvYI14FYBDmw4BxIuaNsYLCblSOJ3M27ZzY/aqsIRqwd8WC//u
 ZRp/RtuV3P2Fp5X2WotCvO0WkJNdCa6gbAUlwygh79lPkFctgQghRfDE47CJ/k2riwPJ33vZXg9
 6Kz0u/nTY8C5vbQs0VwnVstuNPwvpjMZK5EOwL/cD+kQUrLFsFEKV8CFTAlhmMcpW4aZVi+s1lm
 7JYgKpqUnVw7fskxtBybNdQmnreDkWgZQRVo=
X-Received: by 2002:a05:622a:c06:b0:528:3d62:16c8 with SMTP id
 d75a77b69052e-52d586748b5mr12876691cf.31.1786437870535; 
 Tue, 11 Aug 2026 01:44:30 -0700 (PDT)
X-Received: by 2002:a05:622a:c06:b0:528:3d62:16c8 with SMTP id
 d75a77b69052e-52d586748b5mr12876421cf.31.1786437870064; 
 Tue, 11 Aug 2026 01:44:30 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a5be1b7sm2607532f8f.14.2026.08.11.01.44.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 01:44:29 -0700 (PDT)
Message-ID: <ac8e5e46-eb2f-4e7d-aad8-390a940829e9@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 10:44:28 +0200
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
In-Reply-To: <20260810213723.58467-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zC0XaH55TNFrOIxbnU_dJdsSdtkgoQDG
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=6a7ae0ef cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=fgVizY3q1H_Q9AlP4zMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: zC0XaH55TNFrOIxbnU_dJdsSdtkgoQDG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MSBTYWx0ZWRfXz3wkPM2k2sjb
 yLlASALDvebgXMrURxET3xQsB4tpcI5IEMAYcv/1B1uha/X0RMQ+CDkvCHMgHNBasCNVEjHuGbR
 CpM7ucN5x49nMJaFNBuDX7BEBSS4LbE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MSBTYWx0ZWRfXxHfuvqyd9twq
 /GxvrVa2rJZsdti3UtOw1fq/6pqseMnvCjkz/tXzM5zTLpGKkhAgkDfICJ6ZJVGWRVi8m/f2B+P
 Yv+ybHtbcQZ/VwmOsavgUVSd3RMAfEo/bce7YU0GGwTIocWtFkZ3k5qCYx9wlSqynIyim7PzdN0
 03CMLdZWgKmWqonrqc+r+UdEsHba0jXiMIprvJM7De+C8aG53WOzrI6f3/xgK9fr3k0xmkLytJ/
 eB9UoH/0VGxwizjF3eHyvAInVu8RVE/vjN+1h1II2G+Xs0jBzbhvcye6L3MB5MArOtZj0cHzfWB
 +PYAGlzq9uDGVPGW5u0jNzVxblyBM8Ll0X6QyYkaOpB4FpUmvkS4nd0F2IZqQFzke1DigU2iPoR
 4KlXkVSm3LHiGMY/wtDbFD5FsKZP4Zyn+Ge9XIJ9k1czYbsmJvhgyMD9wOE3Ug2oYJAfpzWvWgm
 aJNd+3gaj/HJ24ed5AA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110071
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

On 10/8/26 23:37, Philippe Mathieu-DaudÃ© wrote:
> Hi Marc-André,
> 
> I don't remember what I suggested particularly for
> 20260626-qemu-no-hmp-v2-7-8af31bc54c61@redhat.com,
> but this series is what I had in mind back then.
> 
> If you find it worthy, please consider including it
> in your "Make HMP optional" work.

Not well explained, this series disentangle HMP from
the generic NMI class.

> 
> Regard,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (4):
>    hw/nmi: Allow delivering to first available vCPU (not by index)
>    hw/nmi: Introduce nmi_cpu_handler() for vcpu-specific delivery
>    hw/s390x: Deliver per-vcpu NMI using nmi_cpu_handler
>    hw/nmi: Remove unused @cpu_index and @errp arguments
> 
>   include/hw/core/nmi.h      | 10 +++++++++-
>   hw/core/nmi.c              | 25 ++++++++++++++++++++++---
>   hw/hppa/machine.c          |  4 ++--
>   hw/i386/x86.c              |  5 ++---
>   hw/intc/m68k_irqc.c        |  4 ++--
>   hw/ipmi/ipmi.c             |  2 +-
>   hw/m68k/q800-glue.c        |  4 ++--
>   hw/misc/macio/gpio.c       |  4 ++--
>   hw/ppc/pnv.c               |  7 +++----
>   hw/ppc/spapr.c             |  4 ++--
>   hw/s390x/s390-virtio-ccw.c |  6 ++----
>   hw/watchdog/watchdog.c     |  2 +-
>   12 files changed, 50 insertions(+), 27 deletions(-)
> 


